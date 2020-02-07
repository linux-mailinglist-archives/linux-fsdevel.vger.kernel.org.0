Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC9E155156
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 04:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgBGDtm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 22:49:42 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:51088 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727195AbgBGDtm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 22:49:42 -0500
Received: from dread.disaster.area (pa49-181-161-120.pa.nsw.optusnet.com.au [49.181.161.120])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 84EAE82126E;
        Fri,  7 Feb 2020 14:49:37 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1izue7-00083P-Pl; Fri, 07 Feb 2020 14:49:35 +1100
Date:   Fri, 7 Feb 2020 14:49:35 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v12 1/2] fs: New zonefs file system
Message-ID: <20200207034935.GD21953@dread.disaster.area>
References: <20200206052631.111586-1-damien.lemoal@wdc.com>
 <20200206052631.111586-2-damien.lemoal@wdc.com>
 <20200207002948.GC21953@dread.disaster.area>
 <BYAPR04MB58165F4D55724B03EDED8E0DE71C0@BYAPR04MB5816.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB58165F4D55724B03EDED8E0DE71C0@BYAPR04MB5816.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=SkgQWeG3jiSQFIjTo4+liA==:117 a=SkgQWeG3jiSQFIjTo4+liA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=7-415B0cAAAA:8 a=V9UHJ5PAOhlcPSilHCoA:9 a=sOQjfYZ0gjBQq63s:21
        a=aK1aEbmzGdfnh8zD:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 07, 2020 at 02:29:37AM +0000, Damien Le Moal wrote:
> On 2020/02/07 9:29, Dave Chinner wrote:
> > On Thu, Feb 06, 2020 at 02:26:30PM +0900, Damien Le Moal wrote:
> >> zonefs is a very simple file system exposing each zone of a zoned block
> >> device as a file. Unlike a regular file system with zoned block device
> >> support (e.g. f2fs), zonefs does not hide the sequential write
> >> constraint of zoned block devices to the user. Files representing
> >> sequential write zones of the device must be written sequentially
> >> starting from the end of the file (append only writes).
> > 
> > ....
> >> +	if (flags & IOMAP_WRITE)
> >> +		length = zi->i_max_size - offset;
> >> +	else
> >> +		length = min(length, isize - offset);
> >> +	mutex_unlock(&zi->i_truncate_mutex);
> >> +
> >> +	iomap->offset = offset & (~sbi->s_blocksize_mask);
> >> +	iomap->length = ((offset + length + sbi->s_blocksize_mask) &
> >> +			 (~sbi->s_blocksize_mask)) - iomap->offset;
> > 
> > 	iomap->length = __ALIGN_MASK(offset + length, sbi->s_blocksize_mask) -
> > 			iomap->offset;
> > 
> > or it could just use ALIGN(..., sb->s_blocksize) and not need
> > pre-calculation of the mask value...
> 
> Yes, that is cleaner. Fixed.
> 
> >> +static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
> >> +{
> >> +	struct inode *inode = file_inode(iocb->ki_filp);
> >> +	struct zonefs_sb_info *sbi = ZONEFS_SB(inode->i_sb);
> >> +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
> >> +	size_t count;
> >> +	ssize_t ret;
> >> +
> >> +	/*
> >> +	 * For async direct IOs to sequential zone files, ignore IOCB_NOWAIT
> >> +	 * as this can cause write reordering (e.g. the first aio gets EAGAIN
> >> +	 * on the inode lock but the second goes through but is now unaligned).
> >> +	 */
> >> +	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ && !is_sync_kiocb(iocb)
> >> +	    && (iocb->ki_flags & IOCB_NOWAIT))
> >> +		iocb->ki_flags &= ~IOCB_NOWAIT;
> > 
> > Hmmm. I'm wondering if it would be better to return -EOPNOTSUPP here
> > so that the application knows it can't do non-blocking write AIO to
> > this file.
> 
> I wondered the same too. In the end, I decided to go with silently ignoring
> the flag (for now) since raw block device accesses do the same (the NOWAIT
> support is not complete and IOs may wait on free tags). I have an idea for
> fixing simply the out-of-order issuing that may result from using nowait. I
> will send a patch for that later and can then remove this.
> But if zonefs does not make it to 5.6 (looking really tight), I will send
> add that patch to a new zonefs series rebased for 5.7.

THat seems reasonable to me.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
