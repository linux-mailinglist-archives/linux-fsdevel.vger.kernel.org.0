Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02A4F118486
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 11:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfLJKLn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 05:11:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51958 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727093AbfLJKLn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:11:43 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBAA7crg150933
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2019 05:11:41 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wsmfu1sjw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2019 05:11:38 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Tue, 10 Dec 2019 10:11:26 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 10 Dec 2019 10:11:21 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBAABKum50004096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Dec 2019 10:11:20 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2951C42042;
        Tue, 10 Dec 2019 10:11:20 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 670BC42052;
        Tue, 10 Dec 2019 10:11:17 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 10 Dec 2019 10:11:17 +0000 (GMT)
Date:   Tue, 10 Dec 2019 15:41:16 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>, Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fs <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jeff Moyer <jmoyer@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>
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
 <CAKfTPtCBxV+az30n8E9fRv_HweN_QPJn_ni961OsKp5xUWUD2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAKfTPtCBxV+az30n8E9fRv_HweN_QPJn_ni961OsKp5xUWUD2A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19121010-0012-0000-0000-000003736E80
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121010-0013-0000-0000-000021AF4031
Message-Id: <20191210101116.GA9139@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-10_01:2019-12-10,2019-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 adultscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912100090
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Vincent Guittot <vincent.guittot@linaro.org> [2019-12-10 10:43:46]:

> On Tue, 10 Dec 2019 at 06:43, Srikar Dronamraju
> <srikar@linux.vnet.ibm.com> wrote:
> >
> > This is more prone to happen if the current running task is CPU
> > intensive and the sched_wake_up_granularity is set to larger value.
> > When the sched_wake_up_granularity was relatively small, it was observed
> > that the bound thread would complete before the load balancer would have
> > chosen to move the cache hot task to a different CPU.
> >
> > To deal with this situation, the current running task would yield to a
> > per CPU bound kthread, provided kthread is not CPU intensive.
> >
> > /pboffline/hwcct_prg_old/lib/fsperf -t overwrite --noclean -f 5g -b 4k /pboffline
> >
> > (With sched_wake_up_granularity set to 15ms)
> 
> So you increase sched_wake_up_granularity to a high level to ensure
> that current is no preempted by waking thread but then you add a way
> to finally preempt it which is somewhat weird IMO
> 

Yes, setting to a smaller value will help mitigate/solve the problem.
There may be folks out who have traditionally set a high wake_up_granularity
(and have seen better performance with it), who may miss out that when using
blk-mq, such settings will cause more harm. And they may continue to see
some performance regressions when they move to a lower wake_up_granularity.

> Have you tried to increase the priority of workqueue thread  (decrease
> nice priority) ? This is the right way to reduce the impact of the
> sched_wake_up_granularity on the wakeup of your specific kthread.
> Because what you want at the end is keeping a low wakeup granularity
> for these io workqueues
> 

Yes, people can tune the priority of workqueue threads and infact it may be
easier to set wake_up_granularity to a lower value. However the point is how
do we make everyone aware that they are running into a performance issue
with a higher wakeup_granularity?

-- 
Thanks and Regards
Srikar Dronamraju

