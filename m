Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35102718AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 01:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgITXuA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Sep 2020 19:50:00 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:47977 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726156AbgITXt7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Sep 2020 19:49:59 -0400
Received: from dread.disaster.area (pa49-195-191-192.pa.nsw.optusnet.com.au [49.195.191.192])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 393C13A9E86;
        Mon, 21 Sep 2020 09:49:56 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kK95e-0005lx-FN; Mon, 21 Sep 2020 09:49:54 +1000
Date:   Mon, 21 Sep 2020 09:49:54 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Oleg Nesterov <oleg@redhat.com>, peterz@infradead.org,
        Boaz Harrosh <boaz@plexistor.com>,
        Hou Tao <houtao1@huawei.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] locking/percpu-rwsem: use this_cpu_{inc|dec}() for
 read_count
Message-ID: <20200920234954.GY12096@dread.disaster.area>
References: <b885ce8e-4b0b-8321-c2cc-ee8f42de52d4@huawei.com>
 <ddd5d732-06da-f8f2-ba4a-686c58297e47@plexistor.com>
 <20200917120132.GA5602@redhat.com>
 <20200918090702.GB18920@quack2.suse.cz>
 <20200918100112.GN1362448@hirez.programming.kicks-ass.net>
 <20200918101216.GL35926@hirez.programming.kicks-ass.net>
 <20200918104824.GA23469@redhat.com>
 <20200918110310.GO1362448@hirez.programming.kicks-ass.net>
 <20200918130914.GA26777@redhat.com>
 <20200918132635.GI18920@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918132635.GI18920@quack2.suse.cz>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=IuRgj43g c=1 sm=1 tr=0 cx=a_idp_d
        a=vvDRHhr1aDYKXl+H6jx2TA==:117 a=vvDRHhr1aDYKXl+H6jx2TA==:17
        a=kj9zAlcOel0A:10 a=reM5J-MqmosA:10 a=7-415B0cAAAA:8
        a=QF-8DhSd7u3_DeGXtgMA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 18, 2020 at 03:26:35PM +0200, Jan Kara wrote:
> On Fri 18-09-20 15:09:14, Oleg Nesterov wrote:
> > On 09/18, Peter Zijlstra wrote:
> > > > But again, do we really want this?
> > >
> > > I like the two counters better, avoids atomics entirely, some archs
> > > hare horridly expensive atomics (*cough* power *cough*).
> > 
> > I meant... do we really want to introduce percpu_up_read_irqsafe() ?
> > 
> > Perhaps we can live with the fix from Hou? At least until we find a
> > "real" performance regression.
> 
> I can say that for users of percpu rwsem in filesystems the cost of atomic
> inc/dec is unlikely to matter. The lock hold times there are long enough
> that it would be just lost in the noise.

I'm not sure that is correct. We do an inc/dec pair per AIO, so if
we are running millions of IOPS through the AIO subsystem, then the
cost of doing millions of extra atomic ops every second is going to
be noticable...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
