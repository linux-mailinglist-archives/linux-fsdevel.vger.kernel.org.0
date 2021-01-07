Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B757A2EE820
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 23:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbhAGWGl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 17:06:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:39036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726854AbhAGWGk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 17:06:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61A192343B;
        Thu,  7 Jan 2021 22:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610057159;
        bh=8/Njk5My/xo58SgY5AEYrWu0cHTtA/f6rh9KDGGIO84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YqvO6VLFRUXCMoC7PXsrFxiGKcSo5KFcmgW+yA1wydzR95Nm9jMb/qeuHCgJDgfgt
         q3nqfHHT5HSRkqUn4PlHxsRBI1KHccRyxUPjcI0LRC7kPMKYLaY3UebB/ga+Mh/YLE
         pM2QS0Ers4Kun38cgeylE0HUj5Q9XblXT6D6smj9++abKWGB1WYFj+Yssy/xlhR53O
         jMlwicEjdSSeDCtmHU+T8iqA31cq6bDE2u9ioKmR4bYPPNqj+IntLOTGjkS22CX47O
         WZonqErVNV+e4n3zroK91TJ0+s+PFGcQIW5j/TZRfEap218U9aediX2r+c63ocXeEF
         2oIGzJyMeAEiQ==
Date:   Thu, 7 Jan 2021 14:05:57 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 11/13] fs: add a lazytime_expired method
Message-ID: <X/eFxSh3ac6EGdYI@gmail.com>
References: <20210105005452.92521-1-ebiggers@kernel.org>
 <20210105005452.92521-12-ebiggers@kernel.org>
 <20210107140228.GF12990@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107140228.GF12990@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 07, 2021 at 03:02:28PM +0100, Jan Kara wrote:
> On Mon 04-01-21 16:54:50, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Add a lazytime_expired method to 'struct super_operations'.  Filesystems
> > can implement this to be notified when an inode's lazytime timestamps
> > have expired and need to be written to disk.
> > 
> > This avoids any potential ambiguity with
> > ->dirty_inode(inode, I_DIRTY_SYNC), which can also mean a generic
> > dirtying of the inode, not just a lazytime timestamp expiration.
> > In particular, this will be useful for XFS.
> > 
> > If not implemented, then ->dirty_inode(inode, I_DIRTY_SYNC) continues to
> > be called.
> > 
> > Note that there are three cases where we have to make sure to call
> > lazytime_expired():
> > 
> > - __writeback_single_inode(): inode is being written now
> > - vfs_fsync_range(): inode is going to be synced
> > - iput(): inode is going to be evicted
> > 
> > In the latter two cases, the inode still needs to be put on the
> > writeback list.  So, we can't just replace the calls to
> > mark_inode_dirty_sync() with lazytime_expired().  Instead, add a new
> > flag I_DIRTY_TIME_EXPIRED which can be passed to __mark_inode_dirty().
> > It's like I_DIRTY_SYNC, except it causes the filesystem to be notified
> > of a lazytime expiration rather than a generic I_DIRTY_SYNC.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Hum, seeing this patch I kind of wonder: Why don't we dirty the inode after
> expiring the lazytime timestamps with I_DIRTY_SYNC | I_DIRTY_TIME_EXPIRED
> and propagate I_DIRTY_TIME_EXPIRED even to ->dirty_inode() where XFS can
> catch it and act? Functionally it would be the same but we'd save a bunch
> of generic code and ->lazytime_expired helper used just by a single
> filesystem...
> 

Yes, that would be equivalent to what this patch does.

Either way, note that if we also use your suggestion for patch #1, then that
already fixes the XFS bug, since i_state will start containing I_DIRTY_TIME when
->dirty_inode(I_DIRTY_SYNC) is called.  So xfs_fs_dirty_inode() will start
working as intended.

That makes introducing ->lazytime_expired (or equivalently I_DIRTY_TIME_EXPIRED)
kind of useless since it wouldn't actually fix anything.

So I'm tempted to just drop it.

The XFS developers might have a different opinion though, as they were the ones
who requested it originally:

	https://lore.kernel.org/r/20200312143445.GA19160@infradead.org
	https://lore.kernel.org/r/20200325092057.GA25483@infradead.org
	https://lore.kernel.org/r/20200325154759.GY29339@magnolia
	https://lore.kernel.org/r/20200312223913.GL10776@dread.disaster.area

Any thoughts from anyone about whether we should still introduce a separate
notification for lazytime expiration, vs. just using ->dirty_inode(I_DIRTY_SYNC)
with I_DIRTY_TIME in i_state?

- Eric
