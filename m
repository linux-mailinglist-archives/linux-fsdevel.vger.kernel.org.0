Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377032DB74F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 01:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgLPAB2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 19:01:28 -0500
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:42299 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725769AbgLOX3W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 18:29:22 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id 2618411A239;
        Wed, 16 Dec 2020 10:28:37 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kpJk9-004NPu-GG; Wed, 16 Dec 2020 10:28:33 +1100
Date:   Wed, 16 Dec 2020 10:28:33 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
        dan.j.williams@intel.com, hch@lst.de, song@kernel.org,
        rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [RFC PATCH v3 8/9] md: Implement ->corrupted_range()
Message-ID: <20201215232833.GM632069@dread.disaster.area>
References: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
 <20201215121414.253660-9-ruansy.fnst@cn.fujitsu.com>
 <20201215205102.GB6918@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215205102.GB6918@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=zTNgK-yGK50A:10 a=7-415B0cAAAA:8
        a=c9VSvi9VynfUMAegli0A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 15, 2020 at 12:51:02PM -0800, Darrick J. Wong wrote:
> On Tue, Dec 15, 2020 at 08:14:13PM +0800, Shiyang Ruan wrote:
> > diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> > index 4688bff19c20..e8cfaf860149 100644
> > --- a/drivers/nvdimm/pmem.c
> > +++ b/drivers/nvdimm/pmem.c
> > @@ -267,11 +267,14 @@ static int pmem_corrupted_range(struct gendisk *disk, struct block_device *bdev,
> >  
> >  	bdev_offset = (disk_sector - get_start_sect(bdev)) << SECTOR_SHIFT;
> >  	sb = get_super(bdev);
> > -	if (sb && sb->s_op->corrupted_range) {
> > +	if (!sb) {
> > +		rc = bd_disk_holder_corrupted_range(bdev, bdev_offset, len, data);
> > +		goto out;
> > +	} else if (sb->s_op->corrupted_range)
> >  		rc = sb->s_op->corrupted_range(sb, bdev, bdev_offset, len, data);
> > -		drop_super(sb);
> 
> This is out of scope for this patch(set) but do you think that the scsi
> disk driver should intercept media errors from sense data and call
> ->corrupted_range too?  ISTR Ted muttering that one of his employers had
> a patchset to do more with sense data than the upstream kernel currently
> does...

Most definitely!

That's the whole point of layering corrupt range reporting through
the device layers like this - the corrupted range reporting is not
limited specifically to pmem devices and so generic storage failures
(e.g.  RAID failures, hardware media failures, etc) can be reported
back up to the filesystem and we can take immediate, appropriate
action, including reporting to userspace that they just lost data in
file X at offset Y...

Combine that with the proposed "watch_sb()" syscall for reporting
such errors in a generic manner to interested listeners, and we've
got a fairly solid generic path for reporting data loss events to
userspace for an appropriate user-defined action to be taken...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
