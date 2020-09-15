Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F6D26ADB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 21:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgIOTgs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 15:36:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49272 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgIOTgm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:36:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FJUJ4P110760;
        Tue, 15 Sep 2020 19:36:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=M+FvkCbclb/hSWMg93jzDNHQCnEcVHjxVzIK1ptGD3s=;
 b=Ci+wtht9MKp2e7z7QUggQ1E+x6Z0KpNFG14yE/9WnmAHNLufpIN09RorsgDZBfvMk+dW
 PKARrA79t0dKbaamhw9IstcSlm6I6AXG34S1oiMEHIMOtzAzseKIHvcAZwkmffZNQ4oD
 uZxnjrdUujtP/owBMZO2pKfTuE3j2wsGxj+qtXQfeqaBaGkLHx+Db0swM+VXZwpmS3Ct
 G5hgllPmOwxz6Rginavqcn9YQ7iKqSKLD9MycJ2E+mRYQbRLtX0t22UZR+SIUWltqcue
 /LXpNIOsOl+yFQMcRABRIS/lcLZni9j6YtfkcWV197m/wjchNLjOy3BvY6hKjwqcIOFa YQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 33j91dgu51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 19:36:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FJTvK5172786;
        Tue, 15 Sep 2020 19:36:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 33h7wpn3av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 19:36:31 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08FJZuSR187206;
        Tue, 15 Sep 2020 19:36:31 GMT
Received: from localhost.localdomain (dhcp-10-65-133-238.vpn.oracle.com [10.65.133.238])
        by aserp3030.oracle.com with ESMTP id 33h7wpn39m-3;
        Tue, 15 Sep 2020 19:36:30 +0000
From:   Tom Hromatka <tom.hromatka@oracle.com>
To:     tom.hromatka@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, fweisbec@gmail.com,
        tglx@linutronix.de, mingo@kernel.org, adobriyan@gmail.com
Subject: [PATCH v2 2/2] /proc/stat: Simplify iowait and idle calculations when cpu is offline
Date:   Tue, 15 Sep 2020 13:36:27 -0600
Message-Id: <20200915193627.85423-3-tom.hromatka@oracle.com>
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

Prior to this commit, the cpu idle and iowait data in /proc/stat used
different data sources based upon whether the CPU was online or not.
This would cause spikes in the cpu idle and iowait data.

This patch uses the same data source, get_cpu_{idle,iowait}_time_us(),
whether the CPU is online or not.

This patch and the preceding patch, "tick-sched: Do not clear the
iowait and idle times", ensure that the cpu idle and iowait data
are always increasing.

Signed-off-by: Tom Hromatka <tom.hromatka@oracle.com>
---
 fs/proc/stat.c | 26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 46b3293015fe..198f3c50cb91 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -47,34 +47,12 @@ static u64 get_iowait_time(struct kernel_cpustat *kcs, int cpu)
 
 static u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
 {
-	u64 idle, idle_usecs = -1ULL;
-
-	if (cpu_online(cpu))
-		idle_usecs = get_cpu_idle_time_us(cpu, NULL);
-
-	if (idle_usecs == -1ULL)
-		/* !NO_HZ or cpu offline so we can rely on cpustat.idle */
-		idle = kcs->cpustat[CPUTIME_IDLE];
-	else
-		idle = idle_usecs * NSEC_PER_USEC;
-
-	return idle;
+	return get_cpu_idle_time_us(cpu, NULL) * NSEC_PER_USEC;
 }
 
 static u64 get_iowait_time(struct kernel_cpustat *kcs, int cpu)
 {
-	u64 iowait, iowait_usecs = -1ULL;
-
-	if (cpu_online(cpu))
-		iowait_usecs = get_cpu_iowait_time_us(cpu, NULL);
-
-	if (iowait_usecs == -1ULL)
-		/* !NO_HZ or cpu offline so we can rely on cpustat.iowait */
-		iowait = kcs->cpustat[CPUTIME_IOWAIT];
-	else
-		iowait = iowait_usecs * NSEC_PER_USEC;
-
-	return iowait;
+	return get_cpu_iowait_time_us(cpu, NULL) * NSEC_PER_USEC;
 }
 
 #endif
-- 
2.25.4

