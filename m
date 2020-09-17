Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7DF26D3DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 08:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgIQGmo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 02:42:44 -0400
Received: from verein.lst.de ([213.95.11.211]:54969 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgIQGmm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 02:42:42 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EBE4E68B05; Thu, 17 Sep 2020 08:42:38 +0200 (CEST)
Date:   Thu, 17 Sep 2020 08:42:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH] btrfs: don't call btrfs_sync_file from iomap
 context
Message-ID: <20200917064238.GA32441@lst.de>
References: <20200901130644.12655-1-johannes.thumshirn@wdc.com> <42efa646-73cd-d884-1c9c-dd889294bde2@toxicpanda.com> <20200903163236.GA26043@lst.de> <20200907000432.GM12096@dread.disaster.area> <20200915214853.iurg43dt52h5z2gp@fiona> <20200917030942.GU12096@dread.disaster.area> <20200917055232.GA31646@lst.de> <20200917062923.GV12096@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917062923.GV12096@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 04:29:23PM +1000, Dave Chinner wrote:
> > inode_dio_wait really just waits for active I/O that writes to or reads
> > from the file.  It does not imply that the I/O is stable, just like
> > i_rwsem itself doesn't.
> 
> No, but iomap_dio_rw() considers a O_DSYNC write to be incomplete
> until it is stable so that it presents consistent behaviour to
> anythign calling inode_dio_wait().

But that point is that inode_dio_wait does not care about that
"consistency".  It cares about when the I/O is done.  I know because I
wrote it (and I regret that as we should have stuck with the non-owner
release of the rwsem which makes a whole lot more sense).

> 
> > Various file systems have historically called
> > the syncing outside i_rwsem and inode_dio_wait (in fact that is what the
> > fs/direct-io.c code does, so XFS did as well until a few years ago), and
> > that isn't a problem at all - we just can't return to userspace (or call
> > ki_complete for in-kernel users) before the data is stable on disk.
> 
> I'm really not caring about userspace here - we use inode_dio_wait()
> as an IO completion notification for the purposes of synchronising
> internal filesystem state before modifying user data via direct
> metadata manipulation. Hence I want sane, consistent, predictable IO
> completion notification behaviour regardless of the implementation
> path it goes through.

And none of that consistency matters.  Think of it:

 - an O_(D)SYNC write is nothing but a write plus a ranged fsync,
   even if we do some optimizations to speed up the fsync by e.g.
   using the FUA flag
 - another fsync can come up at any time after we completed a write
   (with or without O_SYNC)
 - so any synchronization using inode_dio_wait (or i_rwsem for that
   matter) must not care if an fsync runs in parallel.
 - take a look at where we call inode_dio_wait to verify this - the
   prime original use case was truncate as we can't have I/O in
   progress while trunating.  We then later extended it to all the
   truncate-like more compliated operations like hole punches, extent
   insert an collapse, etc.  But in all that cases what matters is
   the actual I/O, not the sync.  By having done direct I/O the
   page cache side of the sync doesn't matter to start with (but
   the callers all invalidate it anyway), so what matter is the metadata
   flush, aka the log force in the XFS case.  And for that we absolutely
   do not need to be before inode_dio_wait returns.

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
---end quoted text---
