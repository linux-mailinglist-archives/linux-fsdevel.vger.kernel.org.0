Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5A1EDFFB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 10:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388469AbfJVIk0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 04:40:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:52332 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388366AbfJVIk0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:40:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C3643AB92;
        Tue, 22 Oct 2019 08:40:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 277AC1E4AA7; Tue, 22 Oct 2019 10:01:42 +0200 (CEST)
Date:   Tue, 22 Oct 2019 10:01:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        darrick.wong@oracle.com
Subject: Re: [PATCH v5 00/12] ext4: port direct I/O to iomap infrastructure
Message-ID: <20191022080142.GC2436@quack2.suse.cz>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <20191021133111.GA4675@mit.edu>
 <20191021194330.GJ25184@quack2.suse.cz>
 <20191021223819.GB2642@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021223819.GB2642@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 22-10-19 09:38:19, Dave Chinner wrote:
> On Mon, Oct 21, 2019 at 09:43:30PM +0200, Jan Kara wrote:
> > On Mon 21-10-19 09:31:12, Theodore Y. Ts'o wrote:
> > > Hi Matthew, thanks for your work on this patch series!
> > > 
> > > I applied it against 4c3, and ran a quick test run on it, and found
> > > the following locking problem.  To reproduce:
> > > 
> > > kvm-xfstests -c nojournal generic/113
> > > 
> > > generic/113		[09:27:19][    5.841937] run fstests generic/113 at 2019-10-21 09:27:19
> > > [    7.959477] 
> > > [    7.959798] ============================================
> > > [    7.960518] WARNING: possible recursive locking detected
> > > [    7.961225] 5.4.0-rc3-xfstests-00012-g7fe6ea084e48 #1238 Not tainted
> > > [    7.961991] --------------------------------------------
> > > [    7.962569] aio-stress/1516 is trying to acquire lock:
> > > [    7.963129] ffff9fd4791148c8 (&sb->s_type->i_mutex_key#12){++++}, at: __generic_file_fsync+0x3e/0xb0
> > > [    7.964109] 
> > > [    7.964109] but task is already holding lock:
> > > [    7.964740] ffff9fd4791148c8 (&sb->s_type->i_mutex_key#12){++++}, at: ext4_dio_write_iter+0x15b/0x430
> > 
> > This is going to be a tricky one. With iomap, the inode locking is handled
> > by the filesystem while calling generic_write_sync() is done by
> > iomap_dio_rw(). I would really prefer to avoid tweaking iomap_dio_rw() not
> > to call generic_write_sync().
> 
> You can't remove it from there, because that will break O_DSYNC
> AIO+DIO. i.e. generic_write_sync() needs to be called before
> iocb->ki_complete() is called in the AIO completion path, and that
> means filesystems using iomap_dio_rw need to be be able to run
> generic_write_sync() without taking the inode_lock().
> 
> > So we need to remove inode_lock from
> > __generic_file_fsync() (used from ext4_sync_file()). This locking is mostly
> > for legacy purposes and we don't need this in ext4 AFAICT - but removing
> > the lock from __generic_file_fsync() would mean auditing all legacy
> > filesystems that use this to make sure flushing inode & its metadata buffer
> > list while it is possibly changing cannot result in something unexpected. I
> > don't want to clutter this series with it so we are left with
> > reimplementing __generic_file_fsync() inside ext4 without inode_lock. Not
> > too bad but not great either. Thoughts?
> 
> XFS has implemented it's own ->fsync operation pretty much forever
> without issues. It's basically:
> 
> 	1. flush dirty cached data w/ WB_SYNC_ALL
> 	2. flush dirty cached metadata (i.e. journal force)
> 	3. flush device caches if journal force didn't, keeping in
> 	mind the requirements of data and journal being placed on
> 	different devices.
> 
> The ext4 variant shouldn't need to be any more complex than that...

Yeah, that's what we do for the common case as well. But when the
filesystem is created without a journal (i.e., ext2 compatibility mode) we
currently use the old fsync implementation including
__generic_file_fsync(). But as I wrote above, duplicating those ~5 lines
out of __generic_file_fsync() we really care about is not a big deal.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
