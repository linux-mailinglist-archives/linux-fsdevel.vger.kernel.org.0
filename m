Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63E23DB95D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 23:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503641AbfJQV4S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 17:56:18 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:46033 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391375AbfJQV4S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 17:56:18 -0400
Received: from dread.disaster.area (pa49-181-198-88.pa.nsw.optusnet.com.au [49.181.198.88])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id A572843F0F3;
        Fri, 18 Oct 2019 08:56:14 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iLDkj-0002Ck-BA; Fri, 18 Oct 2019 08:56:13 +1100
Date:   Fri, 18 Oct 2019 08:56:13 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 01/14] iomap: iomap that extends beyond EOF should be
 marked dirty
Message-ID: <20191017215613.GN16973@dread.disaster.area>
References: <20191017175624.30305-1-hch@lst.de>
 <20191017175624.30305-2-hch@lst.de>
 <20191017183917.GL13108@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017183917.GL13108@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=ocld+OpnWJCUTqzFQA3oTA==:117 a=ocld+OpnWJCUTqzFQA3oTA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=ckDNvsoUsni0MSp1FtYA:9
        a=CjuIK1q_8ugA:10 a=igBNqPyMv6gA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 17, 2019 at 11:39:17AM -0700, Darrick J. Wong wrote:
> On Thu, Oct 17, 2019 at 07:56:11PM +0200, Christoph Hellwig wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > When doing a direct IO that spans the current EOF, and there are
> > written blocks beyond EOF that extend beyond the current write, the
> > only metadata update that needs to be done is a file size extension.
> > 
> > However, we don't mark such iomaps as IOMAP_F_DIRTY to indicate that
> > there is IO completion metadata updates required, and hence we may
> > fail to correctly sync file size extensions made in IO completion
> > when O_DSYNC writes are being used and the hardware supports FUA.
> > 
> > Hence when setting IOMAP_F_DIRTY, we need to also take into account
> > whether the iomap spans the current EOF. If it does, then we need to
> > mark it dirty so that IO completion will call generic_write_sync()
> > to flush the inode size update to stable storage correctly.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Looks ok, but need fixes tag.  Also, might it be wise to split off the
> ext4 section into a separate patch so that it can be backported
> separately?

I 've done a bit more digging on this, and the ext4 part is not
needed for DAX as IOMAP_F_DIRTY is only used in the page fault path
and hence can't change the file size. As such, this only affects
direct IO. Hence the ext4 hunk can be added to the ext4 iomap-dio
patchset that is being developed rather than being in this patch.

Fixes: 3460cac1ca76 ("iomap: Use FUA for pure data O_DSYNC DIO writes")

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
