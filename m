Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282162B77A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 09:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgKRHzz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 02:55:55 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:41547 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725772AbgKRHzz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 02:55:55 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id E7C9058C30B;
        Wed, 18 Nov 2020 18:55:51 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kfIJi-00CNZl-Vm; Wed, 18 Nov 2020 18:55:51 +1100
Date:   Wed, 18 Nov 2020 18:55:50 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC] iomap: only return IO error if no data has been
 transferred
Message-ID: <20201118075550.GO7391@dread.disaster.area>
References: <2a56ae95-b64e-f20f-8875-62a2f2e8e00f@kernel.dk>
 <20201118071941.GN7391@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118071941.GN7391@dread.disaster.area>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=nNwsprhYR40A:10 a=7-415B0cAAAA:8
        a=AWkF9NgL3smnyXJhxhoA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 18, 2020 at 06:19:41PM +1100, Dave Chinner wrote:
> On Tue, Nov 17, 2020 at 03:17:18PM -0700, Jens Axboe wrote:
> > If we've successfully transferred some data in __iomap_dio_rw(),
> > don't mark an error for a latter segment in the dio.
> > 
> > Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > 
> > ---
> > 
> > Debugging an issue with io_uring, which uses IOCB_NOWAIT for the
> > IO. If we do parts of an IO, then once that completes, we still
> > return -EAGAIN if we ran into a problem later on. That seems wrong,
> > normal convention would be to return the short IO instead. For the
> > -EAGAIN case, io_uring will retry later parts without IOCB_NOWAIT
> > and complete it successfully.
> 
> So you are getting a write IO that is split across an allocated
> extent and a hole, and the second mapping is returning EAGAIN
> because allocation would be required? This sort of split extent IO
> is fairly common, so I'm not sure that splitting them into two
> separate IOs may not be the best approach.

The trivial reproducer:

$ sudo xfs_io -fdt -c "pwrite 0 4k" -c "pwrite -V 1 -b 8k -N 0 8k" /mnt/scr/foo
wrote 4096/4096 bytes at offset 0
4 KiB, 1 ops; 0.0001 sec (27.509 MiB/sec and 7042.2535 ops/sec)
pwrite: Resource temporarily unavailable
$

The pwritev2(0, 8kB, RWF_NOWAIT) call returns EAGAIN having done
the first 4kB write:

 xfs_file_direct_write: dev 259:1 ino 0x83 size 0x1000 offset 0x0 count 0x2000
 iomap_apply:          dev 259:1 ino 0x83 pos 0 length 8192 flags WRITE|DIRECT|NOWAIT (0x31) ops xfs_direct_write_iomap_ops caller iomap_dio_rw actor iomap_dio_actor
 xfs_ilock_nowait:     dev 259:1 ino 0x83 flags ILOCK_SHARED caller xfs_ilock_for_iomap
 xfs_iunlock:          dev 259:1 ino 0x83 flags ILOCK_SHARED caller xfs_direct_write_iomap_begin
 xfs_iomap_found:      dev 259:1 ino 0x83 size 0x1000 offset 0x0 count 8192 fork data startoff 0x0 startblock 24 blockcount 0x1
 iomap_apply_dstmap:   dev 259:1 ino 0x83 bdev 259:1 addr 102400 offset 0 length 4096 type MAPPED flags DIRTY

Here the first iomap loop has mapped the first 4kB of the file and
issued the IO, and we enter the second iomap_apply loop:

 iomap_apply: dev 259:1 ino 0x83 pos 4096 length 4096 flags WRITE|DIRECT|NOWAIT (0x31) ops xfs_direct_write_iomap_ops caller iomap_dio_rw actor iomap_dio_actor
 xfs_ilock_nowait:     dev 259:1 ino 0x83 flags ILOCK_SHARED caller xfs_ilock_for_iomap
 xfs_iunlock:          dev 259:1 ino 0x83 flags ILOCK_SHARED caller xfs_direct_write_iomap_begin

And we exit with -EAGAIN out because we hit the allocate case trying
to make the second 4kB block.

Then IO completes on the first 4kB and the original IO context
completes and unlocks the inode, returning -EAGAIN to userspace:

 xfs_end_io_direct_write: dev 259:1 ino 0x83 isize 0x1000 disize 0x1000 offset 0x0 count 4096
 xfs_iunlock:          dev 259:1 ino 0x83 flags IOLOCK_SHARED caller xfs_file_dio_aio_write

> I'd kinda like to avoid have NOWAIT IO return different results to a
> non-NOWAIT IO with exactly the same setup contexts i.e. either we
> get -EAGAIN or the IO completes as a whole just like a non-NOWAIT IO
> would.
> 
> So perhaps it would be better to fix the IOMAP_NOWAIT handling in XFS
> to return EAGAIN if the mapping found doesn't span the entire range
> of the IO. That way we avoid the potential "partial NOWAIT"
> behaviour for IOs that span extent boundaries....
> 
> Thoughts?

I think the above shows split extent mappings with IOMAP_NOWAIT
should be handled better in XFS and the iomap code should remain the
way it is...

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
