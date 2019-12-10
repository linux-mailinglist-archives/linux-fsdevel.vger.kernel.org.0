Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 625981184B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 11:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfLJKQe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 05:16:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727110AbfLJKQd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:16:33 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBAA7AVn087213
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2019 05:16:32 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wrtkt9uk8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2019 05:16:32 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Tue, 10 Dec 2019 10:16:30 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 10 Dec 2019 10:16:26 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBAAGPxc36045042
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Dec 2019 10:16:25 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C52DA4051;
        Tue, 10 Dec 2019 10:16:25 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7307BA404D;
        Tue, 10 Dec 2019 10:16:22 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 10 Dec 2019 10:16:22 +0000 (GMT)
Date:   Tue, 10 Dec 2019 15:46:21 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Phil Auld <pauld@redhat.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2] sched/core: Preempt current task in favour of bound
 kthread
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20191115234005.GO4614@dread.disaster.area>
 <20191118092121.GV4131@hirez.programming.kicks-ass.net>
 <20191118204054.GV4614@dread.disaster.area>
 <20191120191636.GI4097@hirez.programming.kicks-ass.net>
 <20191120220313.GC18056@pauld.bos.csb>
 <20191121132937.GW4114@hirez.programming.kicks-ass.net>
 <20191209165122.GA27229@linux.vnet.ibm.com>
 <20191209231743.GA19256@dread.disaster.area>
 <20191210054330.GF27253@linux.vnet.ibm.com>
 <20191210092601.GK2844@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20191210092601.GK2844@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19121010-0016-0000-0000-000002D36ED9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121010-0017-0000-0000-000033358525
Message-Id: <20191210101621.GB9139@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-10_01:2019-12-10,2019-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912100090
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> [2019-12-10 10:26:01]:

> On Tue, Dec 10, 2019 at 11:13:30AM +0530, Srikar Dronamraju wrote:
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 44123b4d14e8..82126cbf62cd 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -2664,7 +2664,12 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
> >   */
> >  int wake_up_process(struct task_struct *p)
> >  {
> > -	return try_to_wake_up(p, TASK_NORMAL, 0);
> > +	int wake_flags = 0;
> > +
> > +	if (is_per_cpu_kthread(p))
> > +		wake_flags = WF_KTHREAD;
> > +
> > +	return try_to_wake_up(p, TASK_NORMAL, wake_flags);
> >  }
> >  EXPORT_SYMBOL(wake_up_process);
> 
> Why wake_up_process() and not try_to_wake_up() ? This way
> wake_up_state(.state = TASK_NORMAL() is no longer the same as
> wake_up_process(), and that's weird!
> 

Thanks Vincent and Peter for your review comments.

I was trying to be more conservative. But I don't see any reason why we
can't do the same at try_to_wake_up. And I mostly thought the kthreads were
using wake_up_process.

So I shall move the check to try_to_wake_up then.

> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 69a81a5709ff..36486f71e59f 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6660,6 +6660,27 @@ static void set_skip_buddy(struct sched_entity *se)
> >  		cfs_rq_of(se)->skip = se;
> >  }
> >  
> > +static int kthread_wakeup_preempt(struct rq *rq, struct task_struct *p, int wake_flags)
> > +{
> > +	struct task_struct *curr = rq->curr;
> > +	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
> > +
> > +	if (!(wake_flags & WF_KTHREAD))
> > +		return 0;
> > +
> > +	if (p->nr_cpus_allowed != 1 || curr->nr_cpus_allowed == 1)
> > +		return 0;
> 
> Per the above, WF_KTHREAD already implies p->nr_cpus_allowed == 1.

Yes, this is redundant.

> 
> > +	if (cfs_rq->nr_running > 2)
> > +		return 0;
> > +
> > +	/*
> > +	 * Don't preempt, if the waking kthread is more CPU intensive than
> > +	 * the current thread.
> > +	 */
> > +	return p->nvcsw * curr->nivcsw >= p->nivcsw * curr->nvcsw;
> 
> Both these conditions seem somewhat arbitrary. The number of context
> switch does not correspond to CPU usage _at_all_.
> 
> vtime OTOH does reflect exactly that, if it runs a lot, it will be ahead
> in the tree.
> 

Right, my rational was to not allow a runaway kthread to preempt and take
control.


-- 
Thanks and Regards
Srikar Dronamraju

