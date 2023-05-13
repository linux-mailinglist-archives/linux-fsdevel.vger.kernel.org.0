Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09CC7013D5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 May 2023 03:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240867AbjEMB55 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 May 2023 21:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjEMB54 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 May 2023 21:57:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2678D559F;
        Fri, 12 May 2023 18:57:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAF7660C80;
        Sat, 13 May 2023 01:57:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC24C433D2;
        Sat, 13 May 2023 01:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683943074;
        bh=eFikobi7MSbviz1Fp5uL4fBgaRdT+cxkeTjrebawFcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uUX2uRiISwv4wnF/caLxPD9c7EdINaQrl3AcnTofcVnLITWh141w9BVcbpbYm+ddn
         TpiEPmdc6m+PTGksGdUvlj5tPm8yreD+O3n2Km2sx/ja1S5FF3HMye2BbqKMPOicZV
         +adPoQDfAiQOlqTJbWXeRYVQ0K7MJtHlPLBCy6ro3S02hSTwZMBvXGRxc4wIch6ywf
         wXZGRhYTs61TI7ktCreUiCrLdONf30uLreYNXoZXiuqjyc5LQg7Ux2pTA//+FPrERY
         yVn+ZfteA4TqWB886MrUtR6RX0nKp9ioei0YyaXaDVRV0NWckZb86GyEyCzPhnWlbm
         9HuSxxWigYFjg==
Date:   Fri, 12 May 2023 18:57:52 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <20230513015752.GC3033@quark.localdomain>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <ZFqxEWqD19eHe353@infradead.org>
 <ZFq3SdSBJ_LWsOgd@murray>
 <ZFq7JhrhyrMTNfd/@moria.home.lan>
 <20230510064849.GC1851@quark.localdomain>
 <ZF6HHRDeUWLNtuL7@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZF6HHRDeUWLNtuL7@moria.home.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Kent,

On Fri, May 12, 2023 at 02:36:13PM -0400, Kent Overstreet wrote:
> On Tue, May 09, 2023 at 11:48:49PM -0700, Eric Biggers wrote:
> > What seems to be missing is any explanation for what we're actually getting from
> > this extremely unusual solution that cannot be gained any other way.  What is
> > unique about bcachefs that it really needs something like this?
> 
> Ok, as promised:
> 
> Background: all metadata in bcachefs is a structured as key/value pairs,
> and there's a common key format for all keys.
> 
> struct bkey {
> 	/* 3 byte header */
> 	u8		u64s;		/* size of k/v in u64s */
> 	u8		format;		/* packed/unpacked, needs_whiteout */
> 	u8		type;		/* value type */
> 	u8		pad;
> 
> 	/*
> 	 * Order of fields below is for little endian, they're in
> 	 * reverse order on big endian (and byte swabbed as necessary
> 	 * when reading foreign endian metadata)
> 	 * 
> 	 * Since field order matches byte order, the key can be treated
> 	 * as one large multi word integer for doing comparisons:
> 	 */
> 	u96		version;	/* nonces, send/recv support */
> 	u32		size;		/* size of extent keys */
> 
> 	/* Below are the field used for ordering/comparison: */
> 	u32		snapshot;	
> 	u64		offset;
> 	u64		inode;
> 
> 	/* Value is stored inline with key */
> 	struct bch_val	v;
> };
> 
> sizeof(struct bkey) == 40.
> 
> An extent value that has one pointer and no checksum is 8 bytes, with
> one pointer and one 32 bit checksum 16 bytes, for 56 bytes total (key
> included).
> 
> But for a given btree node, most of the key fields will typically be
> redundandant. An extents leaf node might have extents for all one inode
> number or a small range of inode numbers, snapshots may or may not be in
> use, etc. - clearly some compression is desirable here.
> 
> The key observation is that key compression is possible if we have a
> compression function that preserves order, and an order-preserving
> compression function is possible if it's allowed to fail. That means we
> do comparisons on packed keys, which lets us skip _most_ unpack
> operations, for btree node resorts and for lookups within a node.
> 
> Packing works by defining a format with an offset and a bit width for
> each field, so e.g. if all keys in a btree node have the same inode
> number the packed format can specify that inode number and then a field
> width of 0 bits for the inode field.
> 
> Continuing the arithmetic from before, a packed extent key will
> typically be only 8 or 16 bytes, or 24-32 including the val, which means
> bkey packing cuts our metadata size roughly in half.
> 
> (It also makes our key format somewhat self describing and gives us a
> mechanism by which we could add or extend fields in the future).
> 
> -----------------------------------------------------
> 
> As mentioned before, since packed bkeys are still multi-word integers we
> can do some important operations without unpacking, but to iterate over
> keys, compare packed & unpacked keys in resort, etc. - we'll still need
> to unpack, so we need this operation to be as fast as possible.
> 
> bkey.c __bch2_bkey_unpack_key() is the unspecialized version written in
> C, that works on any archictecture. It loops over the fields in a
> bkey_format, pulling them out of the input words and adding back the
> field offsets. It's got the absolute minimum number of branches - one
> per field, when deciding to advance to the next input word - but it
> can't be branchless and it's a whole ton of shifts and bitops.
> 
> dynamic codegen lets us produce unpack functions that are fully
> branchless and _much_ smaller. For any given btree node we'll have a
> format where multiple fields have 0 field with - i.e. those fields are
> always constants. That code goes away, and also if the format can be
> byte aligned we can eliminate shifts and bitopts. Code size for the
> dynamically compiled unpack functions is roughly 10% that of the
> unspecialized C version.
> 
> I hope that addresses some of the "what is this even for" questions :)
> 
> Cheers,
> Kent

I don't think this response addresses all the possibilities for optimizing the C
implementation, so I'd like to bring up a few and make sure that you've explored
them.

To summarize, you need to decode 6 fields that are each a variable number of
bits (not known at compile time), and add an offset (also not known at compile
time) to each field.

I don't think the offset is particularly interesting.  Adding an offset to each
field is very cheap and trivially parallelizable by the CPU.

It's really the bit width that's "interesting", as it must be the serialized
decoding of variable-length fields that slows things down a lot.

First, I wanted to mention that decoding of variable-length fields has been
extensively studied for decompression algorithms, e.g. for Huffman decoding.
And it turns out that it can be done branchlessly.  The basic idea is that you
have a branchless refill step that looks like the following:

#define REFILL_BITS_BRANCHLESS()                    \
        bitbuf |= get_unaligned_u64(p) << bitsleft; \
        p += 7 - ((bitsleft >> 3) & 0x7);           \
        bitsleft |= 56;

That branchlessly ensures that 'bitbuf' contains '56 <= bitsleft <= 63' bits.
Then, the needed number of bits can be removed and returned:

#define READ_BITS(n)                          \
        REFILL_BITS_BRANCHLESS();             \
        tmp = bitbuf & (((u64)1 << (n)) - 1); \
        bitbuf >>= (n);                       \
        bitsleft -= (n);                      \
        tmp

If you're interested, I can give you some references about the above method.
But, I really just wanted to mention it for completeness, since I think you'd
actually want to go in a slightly different direction, since (a) you have all
the field widths available from the beginning, as opposed to being interleaved
into the bitstream itself (as is the case in Huffman decoding for example), so
you're not limited to serialized decoding of each field, (b) your fields are up
to 96 bits, and (c) you've selected a bitstream convention that seems to make it
such that your stream *must* be read in aligned units of u64, so I don't think
something like REFILL_BITS_BRANCHLESS() could work for you anyway.

What I would suggest instead is preprocessing the list of 6 field lengths to
create some information that can be used to extract all 6 fields branchlessly
with no dependencies between different fields.  (And you clearly *can* add a
preprocessing step, as you already have one -- the dynamic code generator.)

So, something like the following:

    const struct field_info *info = &format->fields[0];

    field0 = (in->u64s[info->word_idx] >> info->shift1) & info->mask;
    field0 |= in->u64s[info->word_idx - 1] >> info->shift2;

... but with the code for all 6 fields interleaved.

On modern CPUs, I think that would be faster than your current C code.

You could do better by creating variants that are specialized for specific
common sets of parameters.  During "preprocessing", you would select a variant
and set an enum accordingly.  During decoding, you would switch on that enum and
call the appropriate variant.  (This could also be done with a function pointer,
of course, but indirect calls are slow these days...)

For example, you mentioned that 8-byte packed keys is a common case.  In that
case there is only a single u64 to decode from, so you could create a function
that just handles that case:

    field0 = (word >> info->shift) & info->mask;

You could also create other variants, e.g.:

- 16-byte packed keys (which you mentioned are common)
- Some specific set of fields have zero width so don't need to be extracted
  (which it sounds like is common, or is it different fields each time?)
- All fields having specific lengths (are there any particularly common cases?)

Have you considered any of these ideas?

- Eric
