Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CF76A4AD3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 20:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjB0T0V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 14:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjB0T0U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:26:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F46522A04
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 11:26:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D787460F19
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 19:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39081C433D2;
        Mon, 27 Feb 2023 19:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677525978;
        bh=eJ7PiisXyw0dEFk0gkdzzz5mFVLQhgd//Z//TmUr9hc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lw1bLTo9SL7ABi1tmwbmhJ61+t6ZvUIh9fKbYL05fuX8pG/WYiKz10RvbNI1KxBKj
         GIqa0BeJiH0Rvg3FF5E1g8ZWjnHRVALoXKkv4oC9OcXnWZZ5rkyS/kVQULWnAXXEpN
         DI5aYjZcvRawcnM3t6E8srVQNbVPJF7eMGmi814Du1tyGB0oqNzm4a8EXAkt//KCXI
         BAnuR5dVLRd4U4ukpdgJvMFUl6790XoLSzsMu4tJ/3LRt3rrq7mef+A7uBP60loyY2
         dbVUTrOl3NFftwL/2RJpLYddOAnJdX8TwOfd2wDPn/PPxjKEglHzF2ZyWyZr7sS4e9
         geX0rPGLVFffQ==
Date:   Mon, 27 Feb 2023 11:26:17 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        lsf-pc@lists.linux-foundation.org,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        "kbus @imap.suse.de>> Keith Busch" <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: LSF/MM/BPF 2023 IOMAP conversion status update
Message-ID: <Y/0D2UYzmhuCigg4@magnolia>
References: <20230129044645.3cb2ayyxwxvxzhah@garbanzo>
 <Y9X+5wu8AjjPYxTC@casper.infradead.org>
 <20230208160422.m4d4rx6kg57xm5xk@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208160422.m4d4rx6kg57xm5xk@quack3>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 08, 2023 at 05:04:22PM +0100, Jan Kara wrote:
> On Sun 29-01-23 05:06:47, Matthew Wilcox wrote:
> > On Sat, Jan 28, 2023 at 08:46:45PM -0800, Luis Chamberlain wrote:
> > > I'm hoping this *might* be useful to some, but I fear it may leave quite
> > > a bit of folks with more questions than answers as it did for me. And
> > > hence I figured that *this aspect of this topic* perhaps might be a good
> > > topic for LSF.  The end goal would hopefully then be finally enabling us
> > > to document IOMAP API properly and helping with the whole conversion
> > > effort.
> > 
> > +1 from me.
> > 
> > I've made a couple of abortive efforts to try and convert a "trivial"
> > filesystem like ext2/ufs/sysv/jfs to iomap, and I always get hung up on
> > what the semantics are for get_block_t and iomap_begin().
> 
> Yeah, I'd be also interested in this discussion. In particular as a
> maintainer of part of these legacy filesystems (ext2, udf, isofs).
> 
> > > Perhaps fs/buffers.c could be converted to folios only, and be done
> > > with it. But would we be loosing out on something? What would that be?
> > 
> > buffer_heads are inefficient for multi-page folios because some of the
> > algorthims are O(n^2) for n being the number of buffers in a folio.
> > It's fine for 8x 512b buffers in a 4k page, but for 512x 4kb buffers in
> > a 2MB folio, it's pretty sticky.  Things like "Read I/O has completed on
> > this buffer, can I mark the folio as Uptodate now?"  For iomap, that's a
> > scan of a 64 byte bitmap up to 512 times; for BHs, it's a loop over 512
> > allocations, looking at one bit in each BH before moving on to the next.
> > Similarly for writeback, iirc.
> > 
> > So +1 from me for a "How do we convert 35-ish block based filesystems
> > from BHs to iomap for their buffered & direct IO paths".  There's maybe a
> > separate discussion to be had for "What should the API be for filesystems
> > to access metadata on the block device" because I don't believe the
> > page-cache based APIs are easy for fs authors to use.
> 
> Yeah, so the actual data paths should be relatively easy for these old
> filesystems as they usually don't do anything special (those that do - like
> reiserfs - are deprecated and to be removed). But for metadata we do need
> some convenience functions like - give me block of metadata at this block
> number, make it dirty / clean / uptodate (block granularity dirtying &
> uptodate state is absolute must for metadata, otherwise we'll have data
> corruption issues). From the more complex functionality we need stuff like:
> lock particular block of metadata (equivalent of buffer lock), track that
> this block is metadata for given inode so that it can be written on
> fsync(2). Then more fancy filesystems like ext4 also need to attach more
> private state to each metadata block but that needs to be dealt with on
> case-by-case basis anyway.

I reiterate a years-ago suggestion from Dave Chinner to reintroduce a
(metadata-only) buffer cache for filesystems.

xfs_buf already does everything you want -- read a buffer, mark it
dirty, bwrite it to storage, lock it, unlock it, mark it stale, etc.
Memory pages are tracked (and reclaimed) separately from the bdev page
cache, which means filesystem authors don't need to figure out the
pagecache APIs.

Upside/downside: Userspace programs scribbling on a mounted block device
lose some ability to screw over that mounted filesystem.  tune2fs loses
the ability to change ext4 labels.

Things get harder when you want to feed buffers to jbd2, since IIRC jbd2
tracks its own state in the journal head.  Some the pieces are similar
to the xfs_buf_log_item (shadow buffers, list of items in transaction),
but others (triggers) aren't.  Given that jbd2 and ext4 both want to
attach other bits of information, I suspect you'd have to let the
filesystem allocate the struct fsbuf objects.

OTOH, once you do this, I think it's shouldn't be hard to remove buffer
heads from ext* except the crypt/verity files.

> > Maybe some related topics are
> > "What testing should we require for some of these ancient filesystems?"
> > "Whose job is it to convert these 35 filesystems anyway, can we just
> > delete some of them?"
> 
> I would not certainly miss some more filesystems - like minix, sysv, ...
> But before really treatening to remove some of these ancient and long
> untouched filesystems, we should convert at least those we do care about.
> When there's precedent how simple filesystem conversion looks like, it is
> easier to argue about what to do with the ones we don't care about so much.

AFAICT, most of those old filesystems are pretty simple -- they don't do
the fancy cow and transformation things that modern filesystems do.  My
guess is that rewiring the buffered IO path wouldn't be that hard.
Dealing with all the other bitrot (metadata buffer heads, lack of
testing) is what's going to kill them or force them into becoming fuse
servers that we can isolate to userspace.

Maybe that isn't such a bad thing.

> > "Is there a lower-performance but easier-to-implement API than iomap
> > for old filesystems that only exist for compatibiity reasons?"
> 
> As I wrote above, for metadata there ought to be something as otherwise it
> will be real pain (and no gain really). But I guess the concrete API only
> matterializes once we attempt a conversion of some filesystem like ext2.
> I'll try to have a look into that, at least the obvious preparatory steps
> like converting the data paths to iomap.

willy's tried this.

--D

> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
