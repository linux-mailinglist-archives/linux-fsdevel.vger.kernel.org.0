Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2DBDF816
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 00:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbfJUWi1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 18:38:27 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:59088 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729620AbfJUWi1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 18:38:27 -0400
Received: from dread.disaster.area (pa49-180-40-48.pa.nsw.optusnet.com.au [49.180.40.48])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id EF732362540;
        Tue, 22 Oct 2019 09:38:20 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iMgJf-00073z-CX; Tue, 22 Oct 2019 09:38:19 +1100
Date:   Tue, 22 Oct 2019 09:38:19 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        darrick.wong@oracle.com
Subject: Re: [PATCH v5 00/12] ext4: port direct I/O to iomap infrastructure
Message-ID: <20191021223819.GB2642@dread.disaster.area>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <20191021133111.GA4675@mit.edu>
 <20191021194330.GJ25184@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021194330.GJ25184@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=G6BsK5s5 c=1 sm=1 tr=0
        a=y881pOMu+B+mZdf5UrsJdA==:117 a=y881pOMu+B+mZdf5UrsJdA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=7-415B0cAAAA:8 a=yd6ouk31S0WiYp9GCygA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 21, 2019 at 09:43:30PM +0200, Jan Kara wrote:
> On Mon 21-10-19 09:31:12, Theodore Y. Ts'o wrote:
> > Hi Matthew, thanks for your work on this patch series!
> > 
> > I applied it against 4c3, and ran a quick test run on it, and found
> > the following locking problem.  To reproduce:
> > 
> > kvm-xfstests -c nojournal generic/113
> > 
> > generic/113		[09:27:19][    5.841937] run fstests generic/113 at 2019-10-21 09:27:19
> > [    7.959477] 
> > [    7.959798] ============================================
> > [    7.960518] WARNING: possible recursive locking detected
> > [    7.961225] 5.4.0-rc3-xfstests-00012-g7fe6ea084e48 #1238 Not tainted
> > [    7.961991] --------------------------------------------
> > [    7.962569] aio-stress/1516 is trying to acquire lock:
> > [    7.963129] ffff9fd4791148c8 (&sb->s_type->i_mutex_key#12){++++}, at: __generic_file_fsync+0x3e/0xb0
> > [    7.964109] 
> > [    7.964109] but task is already holding lock:
> > [    7.964740] ffff9fd4791148c8 (&sb->s_type->i_mutex_key#12){++++}, at: ext4_dio_write_iter+0x15b/0x430
> 
> This is going to be a tricky one. With iomap, the inode locking is handled
> by the filesystem while calling generic_write_sync() is done by
> iomap_dio_rw(). I would really prefer to avoid tweaking iomap_dio_rw() not
> to call generic_write_sync().

You can't remove it from there, because that will break O_DSYNC
AIO+DIO. i.e. generic_write_sync() needs to be called before
iocb->ki_complete() is called in the AIO completion path, and that
means filesystems using iomap_dio_rw need to be be able to run
generic_write_sync() without taking the inode_lock().

> So we need to remove inode_lock from
> __generic_file_fsync() (used from ext4_sync_file()). This locking is mostly
> for legacy purposes and we don't need this in ext4 AFAICT - but removing
> the lock from __generic_file_fsync() would mean auditing all legacy
> filesystems that use this to make sure flushing inode & its metadata buffer
> list while it is possibly changing cannot result in something unexpected. I
> don't want to clutter this series with it so we are left with
> reimplementing __generic_file_fsync() inside ext4 without inode_lock. Not
> too bad but not great either. Thoughts?

XFS has implemented it's own ->fsync operation pretty much forever
without issues. It's basically:

	1. flush dirty cached data w/ WB_SYNC_ALL
	2. flush dirty cached metadata (i.e. journal force)
	3. flush device caches if journal force didn't, keeping in
	mind the requirements of data and journal being placed on
	different devices.

The ext4 variant shouldn't need to be any more complex than that...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
