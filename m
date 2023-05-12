Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E1E700EED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 May 2023 20:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238456AbjELSga (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 May 2023 14:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238600AbjELSg0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 May 2023 14:36:26 -0400
Received: from out-17.mta0.migadu.com (out-17.mta0.migadu.com [IPv6:2001:41d0:1004:224b::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8734C35A6
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 May 2023 11:36:20 -0700 (PDT)
Date:   Fri, 12 May 2023 14:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683916578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T7EDRGNNQxDhy7JG1X1Rb19Q2/wH1f0oPatD+5ixTQ0=;
        b=xCCG65Bw0cexF9Nd3/QXcOc4QPm5PIm/tJf9tNZJ/su0MlbxUQbD+p6omf5kA3Co7G8nL/
        iKkpCUP16KIF+s/7KGW5iG29X/AMwQXWGMz1fiwMlg/iC9CpcDYGMn9MxqtwgqNuGFB1Fk
        YJyZ5UQbufDhClfNgTlxNnft73FPFzM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <ZF6HHRDeUWLNtuL7@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <ZFqxEWqD19eHe353@infradead.org>
 <ZFq3SdSBJ_LWsOgd@murray>
 <ZFq7JhrhyrMTNfd/@moria.home.lan>
 <20230510064849.GC1851@quark.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510064849.GC1851@quark.localdomain>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 09, 2023 at 11:48:49PM -0700, Eric Biggers wrote:
> What seems to be missing is any explanation for what we're actually getting from
> this extremely unusual solution that cannot be gained any other way.  What is
> unique about bcachefs that it really needs something like this?

Ok, as promised:

Background: all metadata in bcachefs is a structured as key/value pairs,
and there's a common key format for all keys.

struct bkey {
	/* 3 byte header */
	u8		u64s;		/* size of k/v in u64s */
	u8		format;		/* packed/unpacked, needs_whiteout */
	u8		type;		/* value type */
	u8		pad;

	/*
	 * Order of fields below is for little endian, they're in
	 * reverse order on big endian (and byte swabbed as necessary
	 * when reading foreign endian metadata)
	 * 
	 * Since field order matches byte order, the key can be treated
	 * as one large multi word integer for doing comparisons:
	 */
	u96		version;	/* nonces, send/recv support */
	u32		size;		/* size of extent keys */

	/* Below are the field used for ordering/comparison: */
	u32		snapshot;	
	u64		offset;
	u64		inode;

	/* Value is stored inline with key */
	struct bch_val	v;
};

sizeof(struct bkey) == 40.

An extent value that has one pointer and no checksum is 8 bytes, with
one pointer and one 32 bit checksum 16 bytes, for 56 bytes total (key
included).

But for a given btree node, most of the key fields will typically be
redundandant. An extents leaf node might have extents for all one inode
number or a small range of inode numbers, snapshots may or may not be in
use, etc. - clearly some compression is desirable here.

The key observation is that key compression is possible if we have a
compression function that preserves order, and an order-preserving
compression function is possible if it's allowed to fail. That means we
do comparisons on packed keys, which lets us skip _most_ unpack
operations, for btree node resorts and for lookups within a node.

Packing works by defining a format with an offset and a bit width for
each field, so e.g. if all keys in a btree node have the same inode
number the packed format can specify that inode number and then a field
width of 0 bits for the inode field.

Continuing the arithmetic from before, a packed extent key will
typically be only 8 or 16 bytes, or 24-32 including the val, which means
bkey packing cuts our metadata size roughly in half.

(It also makes our key format somewhat self describing and gives us a
mechanism by which we could add or extend fields in the future).

-----------------------------------------------------

As mentioned before, since packed bkeys are still multi-word integers we
can do some important operations without unpacking, but to iterate over
keys, compare packed & unpacked keys in resort, etc. - we'll still need
to unpack, so we need this operation to be as fast as possible.

bkey.c __bch2_bkey_unpack_key() is the unspecialized version written in
C, that works on any archictecture. It loops over the fields in a
bkey_format, pulling them out of the input words and adding back the
field offsets. It's got the absolute minimum number of branches - one
per field, when deciding to advance to the next input word - but it
can't be branchless and it's a whole ton of shifts and bitops.

dynamic codegen lets us produce unpack functions that are fully
branchless and _much_ smaller. For any given btree node we'll have a
format where multiple fields have 0 field with - i.e. those fields are
always constants. That code goes away, and also if the format can be
byte aligned we can eliminate shifts and bitopts. Code size for the
dynamically compiled unpack functions is roughly 10% that of the
unspecialized C version.

I hope that addresses some of the "what is this even for" questions :)

Cheers,
Kent
