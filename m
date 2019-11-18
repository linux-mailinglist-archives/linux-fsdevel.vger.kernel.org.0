Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A277100932
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2019 17:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfKRQ0v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Nov 2019 11:26:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13336 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726216AbfKRQ0v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Nov 2019 11:26:51 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAIGCJ5p021821
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2019 11:26:50 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wact5tjx8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2019 11:26:49 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Mon, 18 Nov 2019 16:26:42 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Nov 2019 16:26:37 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAIGQaH854001892
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 16:26:36 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55DFD4203F;
        Mon, 18 Nov 2019 16:26:36 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5A2442049;
        Mon, 18 Nov 2019 16:26:33 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 18 Nov 2019 16:26:33 +0000 (GMT)
Date:   Mon, 18 Nov 2019 21:56:33 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Dave Chinner <david@fromorbit.com>
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
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20191114113153.GB4213@ming.t460p>
 <20191114235415.GL4614@dread.disaster.area>
 <20191115010824.GC4847@ming.t460p>
 <20191115045634.GN4614@dread.disaster.area>
 <20191115070843.GA24246@ming.t460p>
 <20191115234005.GO4614@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20191115234005.GO4614@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19111816-0020-0000-0000-0000038982B7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111816-0021-0000-0000-000021DFAA93
Message-Id: <20191118162633.GC32306@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_04:2019-11-15,2019-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 mlxscore=0 bulkscore=0 clxscore=1011 spamscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911180147
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Dave Chinner <david@fromorbit.com> [2019-11-16 10:40:05]:

> On Fri, Nov 15, 2019 at 03:08:43PM +0800, Ming Lei wrote:
> > On Fri, Nov 15, 2019 at 03:56:34PM +1100, Dave Chinner wrote:
> > > On Fri, Nov 15, 2019 at 09:08:24AM +0800, Ming Lei wrote:
> > I can reproduce the issue with 4k block size on another RH system, and
> > the login info of that system has been shared to you in RH BZ.
> > 
> > 1)
> 
> Almost all the fio task migrations are coming from migration/X
> kernel threads. i.e it's the scheduler active balancing that is
> causing the fio thread to bounce around.
> 

Can we try with the below patch.

-- 
Thanks and Regards
Srikar Dronamraju

--->8-----------------------------8<----------------------------------
From 9687c1447532558aa564bd2e471b7987d6bda70f Mon Sep 17 00:00:00 2001
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Date: Tue, 2 Jul 2019 16:38:29 -0500
Subject: [PATCH] sched/fair: Avoid active balance on small load imbalance

Skip active load balance when destination CPU is busy and the imbalance
is small and fix_small_imabalance is unable to calculate minor
imbalance. Its observed that active load balances can lead to ping-pong
of tasks between two CPUs.

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/fair.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3599bdcab395..0db380c8eb6c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7094,6 +7094,7 @@ enum group_type {
 #define LBF_SOME_PINNED	0x08
 #define LBF_NOHZ_STATS	0x10
 #define LBF_NOHZ_AGAIN	0x20
+#define LBF_SMALL_IMBL	0x40
 
 struct lb_env {
 	struct sched_domain	*sd;
@@ -8386,6 +8387,8 @@ void fix_small_imbalance(struct lb_env *env, struct sd_lb_stats *sds)
 	/* Move if we gain throughput */
 	if (capa_move > capa_now)
 		env->imbalance = busiest->load_per_task;
+	else if (env->idle == CPU_NOT_IDLE)
+		env->flags |= LBF_SMALL_IMBL;
 }
 
 /**
@@ -8466,7 +8469,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 	 * moved
 	 */
 	if (env->imbalance < busiest->load_per_task)
-		return fix_small_imbalance(env, sds);
+		fix_small_imbalance(env, sds);
 }
 
 /******* find_busiest_group() helpers end here *********************/
@@ -8732,6 +8735,13 @@ static int need_active_balance(struct lb_env *env)
 	if (voluntary_active_balance(env))
 		return 1;
 
+	/*
+	 * Destination CPU is not idle and fix_small_imbalance is unable
+	 * to calculate even minor imbalances, skip active balance.
+	 */
+	if (env->flags & LBF_SMALL_IMBL)
+		return 0;
+
 	return unlikely(sd->nr_balance_failed > sd->cache_nice_tries+2);
 }
 
-- 
2.18.1


