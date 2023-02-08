Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F2868F2C4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 17:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjBHQEv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 11:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjBHQEo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:04:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691C8457C2
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Feb 2023 08:04:24 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E8DB833787;
        Wed,  8 Feb 2023 16:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675872262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jztu6kPRArmYAWeaNd2ZPA7CnaNgV1G1FdAMKJLz+gk=;
        b=MtW1KWKFEsF/zioFfyXPEGAi526JjBrig8YDHpRbCCFm4LI0r6TfYHLl6+W2D4dDTj6wqo
        9Xh3CIRTowicVcK/DEcfFFUAYzH+gYIzoYYI5U/Bgb63Hsq3Lh775dCmHrF5dAWQcFsahY
        KFEIOd4/yMHFgKoiJYMGD6e5fhGdBXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675872262;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jztu6kPRArmYAWeaNd2ZPA7CnaNgV1G1FdAMKJLz+gk=;
        b=QC5v9xR02uAkH+FZA7JOjHmT9BpCPpYw2P1sZ2RxQJOSU6bCoahmj9oPWz3qNvv9Wknsoa
        owOTIMRwdIbDTPBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D21701358A;
        Wed,  8 Feb 2023 16:04:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pt9BMwbI42P6TwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 08 Feb 2023 16:04:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5D41BA06D5; Wed,  8 Feb 2023 17:04:22 +0100 (CET)
Date:   Wed, 8 Feb 2023 17:04:22 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        lsf-pc@lists.linux-foundation.org,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        "kbus @imap.suse.de>> Keith Busch" <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: LSF/MM/BPF 2023 IOMAP conversion status update
Message-ID: <20230208160422.m4d4rx6kg57xm5xk@quack3>
References: <20230129044645.3cb2ayyxwxvxzhah@garbanzo>
 <Y9X+5wu8AjjPYxTC@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9X+5wu8AjjPYxTC@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 29-01-23 05:06:47, Matthew Wilcox wrote:
> On Sat, Jan 28, 2023 at 08:46:45PM -0800, Luis Chamberlain wrote:
> > I'm hoping this *might* be useful to some, but I fear it may leave quite
> > a bit of folks with more questions than answers as it did for me. And
> > hence I figured that *this aspect of this topic* perhaps might be a good
> > topic for LSF.  The end goal would hopefully then be finally enabling us
> > to document IOMAP API properly and helping with the whole conversion
> > effort.
> 
> +1 from me.
> 
> I've made a couple of abortive efforts to try and convert a "trivial"
> filesystem like ext2/ufs/sysv/jfs to iomap, and I always get hung up on
> what the semantics are for get_block_t and iomap_begin().

Yeah, I'd be also interested in this discussion. In particular as a
maintainer of part of these legacy filesystems (ext2, udf, isofs).

> > Perhaps fs/buffers.c could be converted to folios only, and be done
> > with it. But would we be loosing out on something? What would that be?
> 
> buffer_heads are inefficient for multi-page folios because some of the
> algorthims are O(n^2) for n being the number of buffers in a folio.
> It's fine for 8x 512b buffers in a 4k page, but for 512x 4kb buffers in
> a 2MB folio, it's pretty sticky.  Things like "Read I/O has completed on
> this buffer, can I mark the folio as Uptodate now?"  For iomap, that's a
> scan of a 64 byte bitmap up to 512 times; for BHs, it's a loop over 512
> allocations, looking at one bit in each BH before moving on to the next.
> Similarly for writeback, iirc.
> 
> So +1 from me for a "How do we convert 35-ish block based filesystems
> from BHs to iomap for their buffered & direct IO paths".  There's maybe a
> separate discussion to be had for "What should the API be for filesystems
> to access metadata on the block device" because I don't believe the
> page-cache based APIs are easy for fs authors to use.

Yeah, so the actual data paths should be relatively easy for these old
filesystems as they usually don't do anything special (those that do - like
reiserfs - are deprecated and to be removed). But for metadata we do need
some convenience functions like - give me block of metadata at this block
number, make it dirty / clean / uptodate (block granularity dirtying &
uptodate state is absolute must for metadata, otherwise we'll have data
corruption issues). From the more complex functionality we need stuff like:
lock particular block of metadata (equivalent of buffer lock), track that
this block is metadata for given inode so that it can be written on
fsync(2). Then more fancy filesystems like ext4 also need to attach more
private state to each metadata block but that needs to be dealt with on
case-by-case basis anyway.

> Maybe some related topics are
> "What testing should we require for some of these ancient filesystems?"
> "Whose job is it to convert these 35 filesystems anyway, can we just
> delete some of them?"

I would not certainly miss some more filesystems - like minix, sysv, ...
But before really treatening to remove some of these ancient and long
untouched filesystems, we should convert at least those we do care about.
When there's precedent how simple filesystem conversion looks like, it is
easier to argue about what to do with the ones we don't care about so much.

> "Is there a lower-performance but easier-to-implement API than iomap
> for old filesystems that only exist for compatibiity reasons?"

As I wrote above, for metadata there ought to be something as otherwise it
will be real pain (and no gain really). But I guess the concrete API only
matterializes once we attempt a conversion of some filesystem like ext2.
I'll try to have a look into that, at least the obvious preparatory steps
like converting the data paths to iomap.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
