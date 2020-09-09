Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00EA72635CF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 20:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbgIISUv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 14:20:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37134 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIISUp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 14:20:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 089EdGeS055361;
        Wed, 9 Sep 2020 14:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=h6y6WG3zhGQaU+uqolHKa4rZq0wEiHiUEuGCpqBnCxU=;
 b=qXgkdU5hP/usLZQAIcf8Iy8dOMot2CleWzLeMSLZsHLWujbogAtw8nQ+j711GUARiayq
 wm/NGaUciipGKRjuqZXyRQwTlWae9zJ25IhwKOS7y/yo3Ohceg2rFtJ04YHMoe/00KF+
 y2nKY7qwlYooHb7lLP4Y7Si0BkE7qq+Dverptuy7epWWCG36t19+l1v7I4tEJnoyXZ2Q
 MNz+fg/XXuhLZRYU2T/7ZjfESETnCm0pz4b+h9beXyduqBsyZ9aGS2hthV/SCsRO8ky3
 bd+AGP3xkR0045C00NmkSYf7EvM+opd0ZmoHNISsRbLs6Vujj+sLl69MkekGb/gt306a DA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 33c23r29ws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Sep 2020 14:41:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 089Ef4EG032991;
        Wed, 9 Sep 2020 14:41:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 33cmk6prw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Sep 2020 14:41:31 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 089EfUC6034192;
        Wed, 9 Sep 2020 14:41:31 GMT
Received: from localhost.localdomain (dhcp-10-65-175-55.vpn.oracle.com [10.65.175.55])
        by aserp3020.oracle.com with ESMTP id 33cmk6pru6-2;
        Wed, 09 Sep 2020 14:41:31 +0000
From:   Tom Hromatka <tom.hromatka@oracle.com>
To:     tom.hromatka@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, fweisbec@gmail.com,
        tglx@linutronix.de, mingo@kernel.org, adobriyan@gmail.com
Subject: [RESEND PATCH 1/2] tick-sched: Do not clear the iowait and idle times
Date:   Wed,  9 Sep 2020 08:41:21 -0600
Message-Id: <20200909144122.77210-2-tom.hromatka@oracle.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200909144122.77210-1-tom.hromatka@oracle.com>
References: <20200909144122.77210-1-tom.hromatka@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9738 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090132
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A customer reported that when a cpu goes offline and then comes back
online, the overall cpu idle and iowait data in /proc/stat decreases.
This is wreaking havoc with their cpu usage calculations.

Prior to this patch:

	        user nice system    idle iowait
	cpu  1390748  636 209444 9802206  19598
	cpu1  178384   75  24545 1392450   3025

take cpu1 offline and bring it back online

	        user nice system    idle iowait
	cpu  1391209  636 209682 8453440  16595
	cpu1  178440   75  24572     627      0

To prevent this, do not clear the idle and iowait times for the
cpu that has come back online.

With this patch:

	        user nice system    idle iowait
	cpu   129913   17  17590  166512    704
	cpu1   15916    3   2395   20989     47

take cpu1 offline and bring it back online

	        user nice system    idle iowait
	cpu   130089   17  17686  184625    711
        cpu1   15942    3   2401   23088     47

Signed-off-by: Tom Hromatka <tom.hromatka@oracle.com>
---
 kernel/time/tick-sched.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 3e2dc9b8858c..8103bad7bbd6 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1375,13 +1375,22 @@ void tick_setup_sched_timer(void)
 void tick_cancel_sched_timer(int cpu)
 {
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
+	ktime_t idle_sleeptime, iowait_sleeptime;
 
 # ifdef CONFIG_HIGH_RES_TIMERS
 	if (ts->sched_timer.base)
 		hrtimer_cancel(&ts->sched_timer);
 # endif
 
+	/* save off and restore the idle_sleeptime and the iowait_sleeptime
+	 * to avoid discontinuities and ensure that they are monotonically
+	 * increasing
+	 */
+	idle_sleeptime = ts->idle_sleeptime;
+	iowait_sleeptime = ts->iowait_sleeptime;
 	memset(ts, 0, sizeof(*ts));
+	ts->idle_sleeptime = idle_sleeptime;
+	ts->iowait_sleeptime = iowait_sleeptime;
 }
 #endif
 
-- 
2.25.4

