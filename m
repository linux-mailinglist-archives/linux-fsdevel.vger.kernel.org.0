Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3B9100D87
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2019 22:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfKRVSJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Nov 2019 16:18:09 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:41523 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726272AbfKRVSJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Nov 2019 16:18:09 -0500
Received: from dread.disaster.area (pa49-181-255-80.pa.nsw.optusnet.com.au [49.181.255.80])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 12C7A43F3EA;
        Tue, 19 Nov 2019 08:18:05 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iWoPM-0005FQ-KM; Tue, 19 Nov 2019 08:18:04 +1100
Date:   Tue, 19 Nov 2019 08:18:04 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: single aio thread is migrated crazily by scheduler
Message-ID: <20191118211804.GW4614@dread.disaster.area>
References: <20191114113153.GB4213@ming.t460p>
 <20191114235415.GL4614@dread.disaster.area>
 <20191115010824.GC4847@ming.t460p>
 <20191115045634.GN4614@dread.disaster.area>
 <20191115070843.GA24246@ming.t460p>
 <20191115234005.GO4614@dread.disaster.area>
 <20191118162633.GC32306@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118162633.GC32306@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=XqaD5fcB6dAc7xyKljs8OA==:117 a=XqaD5fcB6dAc7xyKljs8OA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=MeAgGD-zjQ4A:10
        a=7-415B0cAAAA:8 a=Zwmjrk_3-jsYGy5YB9sA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 18, 2019 at 09:56:33PM +0530, Srikar Dronamraju wrote:
> * Dave Chinner <david@fromorbit.com> [2019-11-16 10:40:05]:
> 
> > On Fri, Nov 15, 2019 at 03:08:43PM +0800, Ming Lei wrote:
> > > On Fri, Nov 15, 2019 at 03:56:34PM +1100, Dave Chinner wrote:
> > > > On Fri, Nov 15, 2019 at 09:08:24AM +0800, Ming Lei wrote:
> > > I can reproduce the issue with 4k block size on another RH system, and
> > > the login info of that system has been shared to you in RH BZ.
> > > 
> > > 1)
> > 
> > Almost all the fio task migrations are coming from migration/X
> > kernel threads. i.e it's the scheduler active balancing that is
> > causing the fio thread to bounce around.
> > 
> 
> Can we try with the below patch.

That makes things much, much worse.

$ sudo trace-cmd show |grep fio |wc -l
4701
$

Even when not running the fio workload (i.e. the system is largely
idle and I'm just doing admin tasks like setting up for test runs),
the number of task migrations that occur goes up significantly.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
