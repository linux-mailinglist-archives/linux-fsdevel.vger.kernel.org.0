Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9415D1F5D77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 23:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgFJVGH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 17:06:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54588 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgFJVGF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:06:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05AKqv25085289;
        Wed, 10 Jun 2020 21:05:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=ltkLJIPe4dHdcnuDRbQdb6ZEMq/7yblSuuxzoI9Jykk=;
 b=JCM8LL68Y+dpHTScVfDL+XoLxtpaOAlI5BCBEqArSKCfUEtHnKzGT6P4xcRrmuM5VVfU
 CHzv1yXtiogAKFEPrcT2pTD5qtSrfd9QWk02QWZg3KhNBb3vuvJq7Q2GEw7ZSqDufc4L
 q7psPI6OAyf2RZaNNJuRbr62P8PNekX2R1K7/hgvLFiiagHzrCNPVCF8tDR/BFLbN2Lj
 83/2NeOiSz5asZ9OHvaicKdeedBXclPatsFzZPiKlxK6LmSzcS+pjpxNXSBGxELb7Dwo
 i5mlWKciT/na1n6W7ENywb/K5UWJXEeuGOUScf8VgPEd4PqbMYHaiKY2ewYaucovn/ul uQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 31g3sn4ffm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Jun 2020 21:05:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05AKiSOn132390;
        Wed, 10 Jun 2020 21:05:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 31gmwtve42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Jun 2020 21:05:52 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05AL5o8e021995;
        Wed, 10 Jun 2020 21:05:52 GMT
Received: from localhost.localdomain (dhcp-10-65-148-96.vpn.oracle.com [10.65.148.96])
        by userp3020.oracle.com with ESMTP id 31gmwtve2s-3;
        Wed, 10 Jun 2020 21:05:51 +0000
From:   Tom Hromatka <tom.hromatka@oracle.com>
To:     tom.hromatka@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        adobriyan@gmail.com
Subject: [PATCH 2/2] /proc/stat: Simplify iowait and idle calculations when cpu is offline
Date:   Wed, 10 Jun 2020 15:05:49 -0600
Message-Id: <20200610210549.61193-3-tom.hromatka@oracle.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200610210549.61193-1-tom.hromatka@oracle.com>
References: <20200610210549.61193-1-tom.hromatka@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9648 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006100154
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A customer reported that when a cpu goes offline, the iowait and idle
times reported in /proc/stat will sometimes spike.  This is being
caused by a different data source being used for these values when a
cpu is offline.

Prior to this patch:

put the system under heavy load so that there is little idle time

	       user nice system    idle iowait
	cpu  109515   17  32111  220686    607

take cpu1 offline

	       user nice system    idle iowait
	cpu  113742   17  32721  220724    612

bring cpu1 back online

	       user nice system    idle iowait
	cpu  118332   17  33430  220687    607

To prevent this, let's use the same data source whether a cpu is
online or not.

With this patch:

put the system under heavy load so that there is little idle time

	       user nice system    idle iowait
	cpu   14096   16   4646  157687    426

take cpu1 offline

	       user nice system    idle iowait
	cpu   21614   16   7179  157687    426

bring cpu1 back online

	       user nice system    idle iowait
	cpu   27362   16   9555  157688    426

Signed-off-by: Tom Hromatka <tom.hromatka@oracle.com>
---
 fs/proc/stat.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 46b3293015fe..35b92539e711 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -47,32 +47,20 @@ static u64 get_iowait_time(struct kernel_cpustat *kcs, int cpu)
 
 static u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
 {
-	u64 idle, idle_usecs = -1ULL;
+	u64 idle, idle_usecs;
 
-	if (cpu_online(cpu))
-		idle_usecs = get_cpu_idle_time_us(cpu, NULL);
-
-	if (idle_usecs == -1ULL)
-		/* !NO_HZ or cpu offline so we can rely on cpustat.idle */
-		idle = kcs->cpustat[CPUTIME_IDLE];
-	else
-		idle = idle_usecs * NSEC_PER_USEC;
+	idle_usecs = get_cpu_idle_time_us(cpu, NULL);
+	idle = idle_usecs * NSEC_PER_USEC;
 
 	return idle;
 }
 
 static u64 get_iowait_time(struct kernel_cpustat *kcs, int cpu)
 {
-	u64 iowait, iowait_usecs = -1ULL;
-
-	if (cpu_online(cpu))
-		iowait_usecs = get_cpu_iowait_time_us(cpu, NULL);
+	u64 iowait, iowait_usecs;
 
-	if (iowait_usecs == -1ULL)
-		/* !NO_HZ or cpu offline so we can rely on cpustat.iowait */
-		iowait = kcs->cpustat[CPUTIME_IOWAIT];
-	else
-		iowait = iowait_usecs * NSEC_PER_USEC;
+	iowait_usecs = get_cpu_iowait_time_us(cpu, NULL);
+	iowait = iowait_usecs * NSEC_PER_USEC;
 
 	return iowait;
 }
-- 
2.25.3

