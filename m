Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED9A38FB7E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 09:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhEYHOs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 03:14:48 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:59741 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229503AbhEYHOs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 03:14:48 -0400
Received: from dread.disaster.area (pa49-180-230-185.pa.nsw.optusnet.com.au [49.180.230.185])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 181B780B616;
        Tue, 25 May 2021 17:13:15 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1llRFa-004y7E-TP; Tue, 25 May 2021 17:13:14 +1000
Date:   Tue, 25 May 2021 17:13:14 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Brian Foster <bfoster@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v3 3/3] iomap: bound ioend size to 4096 pages
Message-ID: <20210525071314.GH664593@dread.disaster.area>
References: <20210517171722.1266878-1-bfoster@redhat.com>
 <20210517171722.1266878-4-bfoster@redhat.com>
 <20210520232737.GA9675@magnolia>
 <YKuVymtSYhrDCytP@bfoster>
 <20210525042035.GE202121@locust>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525042035.GE202121@locust>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0
        a=dUIOjvib2kB+GiIc1vUx8g==:117 a=dUIOjvib2kB+GiIc1vUx8g==:17
        a=kj9zAlcOel0A:10 a=5FLXtPjwQuUA:10 a=7-415B0cAAAA:8
        a=5pqBUYiiS7DB0VkXb6wA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 24, 2021 at 09:20:35PM -0700, Darrick J. Wong wrote:
> <shrug> I think I'm comfortable starting with 256 for xfs to bump an
> ioend to a workqueue, and 4096 pages as the limit for an iomap ioend.
> If people demonstrate a need to smart-tune or manual-tune we can always
> add one later.
> 
> Though I guess I did kind of wonder if maybe a better limit for iomap
> would be max_hw_sectors?  Since that's the maximum size of an IO that
> the kernel will for that device?
>
> (Hm, maybe not; my computers all have it set to 1280k, which is a
> pathetic 20 pages on a 64k-page system.)

I've got samsung nvme devices here that set max_hw_sectors_kb to
128kB....

But device sizes ignore that RAID devices give an optimal IO size
for submissions:

$ cat /sys/block/dm-0/queue/optimal_io_size
1048576
$ cat /sys/block/dm-0/queue/max_sectors_kb
128

IOWs, we might be trying to feed lots of devices through the one
submission, so using a "device" limit isn't really something we
should be doing. Ideally I think we should be looking at some
multiple of the  maximum optimal IO size that the underlying device
requests if it is set, otherwise a byte limit of some kind....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
