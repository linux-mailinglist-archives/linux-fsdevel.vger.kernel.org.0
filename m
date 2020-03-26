Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBDDD1944E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 18:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgCZRBt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 13:01:49 -0400
Received: from verein.lst.de ([213.95.11.211]:46717 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726971AbgCZRBt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:01:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 45C90227A81; Thu, 26 Mar 2020 18:01:45 +0100 (CET)
Date:   Thu, 26 Mar 2020 18:01:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>, linux-xfs@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] fs: avoid double-writing the inode on a lazytime
 expiration
Message-ID: <20200326170145.GA6387@lst.de>
References: <20200325122825.1086872-1-hch@lst.de> <20200325122825.1086872-3-hch@lst.de> <20200326032212.GN10776@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326032212.GN10776@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 26, 2020 at 02:22:12PM +1100, Dave Chinner wrote:
> On Wed, Mar 25, 2020 at 01:28:23PM +0100, Christoph Hellwig wrote:
> > In the case that an inode has dirty timestamp for longer than the
> > lazytime expiration timeout (or if all such inodes are being flushed
> > out due to a sync or syncfs system call), we need to inform the file
> > system that the inode is dirty so that the inode's timestamps can be
> > copied out to the on-disk data structures.  That's because if the file
> > system supports lazytime, it will have ignored the dirty_inode(inode,
> > I_DIRTY_TIME) notification when the timestamp was modified in memory.q
> > Previously, this was accomplished by calling mark_inode_dirty_sync(),
> > but that has the unfortunate side effect of also putting the inode the
> > writeback list, and that's not necessary in this case, since we will
> > immediately call write_inode() afterwards.  Replace the call to
> > mark_inode_dirty_sync() with a new lazytime_expired method to clearly
> > separate out this case.
> 
> 
> hmmm. Doesn't this cause issues with both iput() and
> vfs_fsync_range() because they call mark_inode_dirty_sync() on
> I_DIRTY_TIME inodes to move them onto the writeback list so they are
> appropriately expired when the inode is written back.

True, we'd need to call ->lazytime_expired in the fsync path as well.
While looking into this I've also noticed that lazytime is "enabled"
unconditionally without a file system opt-in.  That means for file systems
that don't rely on ->dirty_inode it kinda "just works" except that both
Teds original fix and this one break that in one way or another.  This
series just cleanly disables it, but Ted's two patches would fail to
pass I_DIRTY_SYNC to ->write_inode.

This whole area is such a mess..
