Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8AF326317A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 18:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730964AbgIIQP3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 12:15:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46348 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730950AbgIIQPT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:15:19 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 089EcaZO039982;
        Wed, 9 Sep 2020 14:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=6ULPP3Gb9cEI6JekEdlEIOYKhWs71LEp2bfdfN7zhRs=;
 b=yTOeDS0wHSkYYU8WFkoIh5Ce9ZZOxElSYphhkwTfRfseKTRFiGQy0361GiDxIjsNLECN
 NB2W+blqs9WmJI80WNRon39lhU7mS+KCMm6Owh48l2DXLYAtJqLSj5+1FeBS/LBGwWhi
 /AgtY8a5hK3ebeqeTIvrJhQrcVWKV2m1VZHB5PZUxaJJtGMaa703FemfNLRIYrY9sZg7
 HVls44NA6J8YeIvurcGQrIWlU7FIacnPJOYMsKVv097yhRQzWvYrh14R/DmKZh3gGD58
 VpzDfGNJRENM+JkFXVCN8JlABBsrlglZG8i5fA0t+kcGcdiBDWwHabzjkTDAhUqVyes/ Pw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33c2mm27me-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Sep 2020 14:43:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 089Ef5Tp033108;
        Wed, 9 Sep 2020 14:41:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 33cmk6prwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Sep 2020 14:41:32 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 089EfUC8034192;
        Wed, 9 Sep 2020 14:41:32 GMT
Received: from localhost.localdomain (dhcp-10-65-175-55.vpn.oracle.com [10.65.175.55])
        by aserp3020.oracle.com with ESMTP id 33cmk6pru6-3;
        Wed, 09 Sep 2020 14:41:31 +0000
From:   Tom Hromatka <tom.hromatka@oracle.com>
To:     tom.hromatka@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, fweisbec@gmail.com,
        tglx@linutronix.de, mingo@kernel.org, adobriyan@gmail.com
Subject: [RESEND PATCH 2/2] /proc/stat: Simplify iowait and idle calculations when cpu is offline
Date:   Wed,  9 Sep 2020 08:41:22 -0600
Message-Id: <20200909144122.77210-3-tom.hromatka@oracle.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200909144122.77210-1-tom.hromatka@oracle.com>
References: <20200909144122.77210-1-tom.hromatka@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9738 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090132
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
2.25.4

