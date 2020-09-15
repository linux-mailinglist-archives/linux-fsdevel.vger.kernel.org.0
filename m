Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D7C26ADB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 21:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgIOTgr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 15:36:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49274 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727631AbgIOTgm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:36:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FJUlPx110921;
        Tue, 15 Sep 2020 19:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=eXkcvuozkDBMpAiD4/7I8c5AgA5RqF/C5+lcxERnyHY=;
 b=BXy8UiJ3ZrCKDL6IFUTrWq6RS3XDJC0UpsatIAl3eZk4rzRRUhLZ5YhSlq9s09BX8nRH
 Q3UPL2AG8VflmbBENDX/3am6VWvWhft74RnZeaKxxEQPlBomDzdcy2d22LnGxKilcv+q
 20ZxHPGDHwxDbFxUFC+B5JFqtn2k2mGsLMb2E24w86bpSvlZZUjYPsVgjDFjZH4y8w8H
 j2m+EEC6EAGcwVCyCrmMFpx5eZnCFcMqCuaCeckXsMDR02xu72hf7OczO9NkyS4HDiI/
 JTNa5+q1TCcJhUH1CHmdEc7lzA1mnBA07Egy90zqlVHRYRTWxF0BlEWu14zUptb8sllv VA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 33j91dgu4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 19:36:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FJTwj7172866;
        Tue, 15 Sep 2020 19:36:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 33h7wpn3a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 19:36:30 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08FJZuSP187206;
        Tue, 15 Sep 2020 19:36:29 GMT
Received: from localhost.localdomain (dhcp-10-65-133-238.vpn.oracle.com [10.65.133.238])
        by aserp3030.oracle.com with ESMTP id 33h7wpn39m-2;
        Tue, 15 Sep 2020 19:36:29 +0000
From:   Tom Hromatka <tom.hromatka@oracle.com>
To:     tom.hromatka@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, fweisbec@gmail.com,
        tglx@linutronix.de, mingo@kernel.org, adobriyan@gmail.com
Subject: [PATCH v2 1/2] tick-sched: Do not clear the iowait and idle times
Date:   Tue, 15 Sep 2020 13:36:26 -0600
Message-Id: <20200915193627.85423-2-tom.hromatka@oracle.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200915193627.85423-1-tom.hromatka@oracle.com>
References: <20200915193627.85423-1-tom.hromatka@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150152
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Prior to this commit, the cpu idle and iowait data in /proc/stat were
cleared when a CPU goes down.  When the CPU came back online, both idle
and iowait times were restarted from 0.

This commit preserves the CPU's idle and iowait values when a CPU goes
offline and comes back online.

Signed-off-by: Tom Hromatka <tom.hromatka@oracle.com>
---
 kernel/time/tick-sched.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index f0199a4ba1ad..4fbf67171dde 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1383,13 +1383,22 @@ void tick_setup_sched_timer(void)
 void tick_cancel_sched_timer(int cpu)
 {
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
+	ktime_t idle_sleeptime, iowait_sleeptime;
 
 # ifdef CONFIG_HIGH_RES_TIMERS
 	if (ts->sched_timer.base)
 		hrtimer_cancel(&ts->sched_timer);
 # endif
 
+	/*
+	 * Preserve idle and iowait sleep times accross a CPU offline/online
+	 * sequence as they are accumulative.
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

