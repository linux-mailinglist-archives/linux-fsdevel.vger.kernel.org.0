Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1674427B36
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Oct 2021 17:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbhJIPPb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Oct 2021 11:15:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38030 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234652AbhJIPPZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Oct 2021 11:15:25 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 199BuD1B000392;
        Sat, 9 Oct 2021 11:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=OsjRPBuVAZJUiH/1Tx72owDpcys2APioOZ0ZDm+Jjuw=;
 b=I83NbEN3nMcRnBJCS8ba6wlY7yuDfgQBwW4Al5U8+uXQXosXBSh7xS0LpD3EQU4NKvTm
 7ybvsGnlKwUmntopz6lmhCEebpA7Xija9E3eUCf87fBHRNIpGdLzW46eOULCHQLlXfnq
 UB2fr/SP5vvD0aK/LtWUkolnK+SBxm6Qrg+HRqrWmKQaEMOQlURH+yLYsu3b9l6qMEMi
 KFASBCXwuJ59QlEePc6OQkQXxWe7kVYrbA+aEm2G/EeQfc9qOtBmOTXHoI0X4LUmcQk1
 sJcDApLmnBfrfkYsPttMr3tmzxd5Wlaj3Nru+2CFxpQMVonRQKhGelz3lO4vNeb7wGp9 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bk8p23njq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Oct 2021 11:13:22 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 199FCf9L021297;
        Sat, 9 Oct 2021 11:13:22 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bk8p23njc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Oct 2021 11:13:21 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 199FCtOS011912;
        Sat, 9 Oct 2021 15:13:20 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3bk2q91y7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Oct 2021 15:13:19 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 199F7oZg45875672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 9 Oct 2021 15:07:51 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 108B442041;
        Sat,  9 Oct 2021 15:13:17 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3309A4203F;
        Sat,  9 Oct 2021 15:13:12 +0000 (GMT)
Received: from pratiks-thinkpad.ibm.com (unknown [9.43.17.147])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  9 Oct 2021 15:13:11 +0000 (GMT)
From:   "Pratik R. Sampat" <psampat@linux.ibm.com>
To:     bristot@redhat.com, christian@brauner.io, ebiederm@xmission.com,
        lizefan.x@bytedance.com, tj@kernel.org, hannes@cmpxchg.org,
        mingo@kernel.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, containers@lists.linux.dev,
        containers@lists.linux-foundation.org, psampat@linux.ibm.com,
        pratik.r.sampat@gmail.com
Subject: [RFC 5/5] proc/cpuns: Make procfs load stats CPU namespace aware
Date:   Sat,  9 Oct 2021 20:42:43 +0530
Message-Id: <20211009151243.8825-6-psampat@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211009151243.8825-1-psampat@linux.ibm.com>
References: <20211009151243.8825-1-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: X_x5yr7sENtw0e_STqG8RDaFy-Rk1EG-
X-Proofpoint-GUID: HSvmPRK-eWOmoMD9w29veN912rT3gHlL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-09_04,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110090109
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit adds support provide a virtualized view to the /proc/stat
load statistics. The load, idle, irq and the rest of the information of
a physical CPU is now displayed for its corresponding virtual CPU
counterpart.
The procfs file only populates the virtualized view for the CPUs based
on the restrictions from cgroupfs set upon it.

Signed-off-by: Pratik R. Sampat <psampat@linux.ibm.com>
---
 fs/proc/stat.c | 50 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 6561a06ef905..3ff39e7362bb 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -14,6 +14,7 @@
 #include <linux/irqnr.h>
 #include <linux/sched/cputime.h>
 #include <linux/tick.h>
+#include <linux/cpu_namespace.h>
 
 #ifndef arch_irq_stat_cpu
 #define arch_irq_stat_cpu(cpu) 0
@@ -107,13 +108,14 @@ static void show_all_irqs(struct seq_file *p)
 
 static int show_stat(struct seq_file *p, void *v)
 {
-	int i, j;
+	int i, j, pcpu;
 	u64 user, nice, system, idle, iowait, irq, softirq, steal;
 	u64 guest, guest_nice;
 	u64 sum = 0;
 	u64 sum_softirq = 0;
 	unsigned int per_softirq_sums[NR_SOFTIRQS] = {0};
 	struct timespec64 boottime;
+	cpumask_var_t cpu_mask;
 
 	user = nice = system = idle = iowait =
 		irq = softirq = steal = 0;
@@ -122,27 +124,39 @@ static int show_stat(struct seq_file *p, void *v)
 	/* shift boot timestamp according to the timens offset */
 	timens_sub_boottime(&boottime);
 
-	for_each_possible_cpu(i) {
+#ifdef CONFIG_CPU_NS
+	if (current->nsproxy->cpu_ns == &init_cpu_ns) {
+		cpumask_copy(cpu_mask, cpu_possible_mask);
+	} else {
+		cpumask_copy(cpu_mask,
+			     &current->nsproxy->cpu_ns->v_cpuset_cpus);
+	}
+#else
+	cpumask_copy(cpu_mask, cpu_possible_mask);
+#endif
+
+	for_each_cpu(i, cpu_mask) {
 		struct kernel_cpustat kcpustat;
 		u64 *cpustat = kcpustat.cpustat;
 
-		kcpustat_cpu_fetch(&kcpustat, i);
+		pcpu = get_pcpu_cpuns(current->nsproxy->cpu_ns, i);
+		kcpustat_cpu_fetch(&kcpustat, pcpu);
 
 		user		+= cpustat[CPUTIME_USER];
 		nice		+= cpustat[CPUTIME_NICE];
 		system		+= cpustat[CPUTIME_SYSTEM];
-		idle		+= get_idle_time(&kcpustat, i);
-		iowait		+= get_iowait_time(&kcpustat, i);
+		idle		+= get_idle_time(&kcpustat, pcpu);
+		iowait		+= get_iowait_time(&kcpustat, pcpu);
 		irq		+= cpustat[CPUTIME_IRQ];
 		softirq		+= cpustat[CPUTIME_SOFTIRQ];
 		steal		+= cpustat[CPUTIME_STEAL];
 		guest		+= cpustat[CPUTIME_GUEST];
 		guest_nice	+= cpustat[CPUTIME_GUEST_NICE];
-		sum		+= kstat_cpu_irqs_sum(i);
-		sum		+= arch_irq_stat_cpu(i);
+		sum		+= kstat_cpu_irqs_sum(pcpu);
+		sum		+= arch_irq_stat_cpu(pcpu);
 
 		for (j = 0; j < NR_SOFTIRQS; j++) {
-			unsigned int softirq_stat = kstat_softirqs_cpu(j, i);
+			unsigned int softirq_stat = kstat_softirqs_cpu(j, pcpu);
 
 			per_softirq_sums[j] += softirq_stat;
 			sum_softirq += softirq_stat;
@@ -162,18 +176,30 @@ static int show_stat(struct seq_file *p, void *v)
 	seq_put_decimal_ull(p, " ", nsec_to_clock_t(guest_nice));
 	seq_putc(p, '\n');
 
-	for_each_online_cpu(i) {
+#ifdef CONFIG_CPU_NS
+	if (current->nsproxy->cpu_ns == &init_cpu_ns) {
+		cpumask_copy(cpu_mask, cpu_online_mask);
+	} else {
+		cpumask_copy(cpu_mask,
+			     &current->nsproxy->cpu_ns->v_cpuset_cpus);
+	}
+#else
+	cpumask_copy(cpu_mask, cpu_online_mask);
+#endif
+	for_each_cpu(i, cpu_mask) {
 		struct kernel_cpustat kcpustat;
 		u64 *cpustat = kcpustat.cpustat;
 
-		kcpustat_cpu_fetch(&kcpustat, i);
+		pcpu = get_pcpu_cpuns(current->nsproxy->cpu_ns, i);
+
+		kcpustat_cpu_fetch(&kcpustat, pcpu);
 
 		/* Copy values here to work around gcc-2.95.3, gcc-2.96 */
 		user		= cpustat[CPUTIME_USER];
 		nice		= cpustat[CPUTIME_NICE];
 		system		= cpustat[CPUTIME_SYSTEM];
-		idle		= get_idle_time(&kcpustat, i);
-		iowait		= get_iowait_time(&kcpustat, i);
+		idle		= get_idle_time(&kcpustat, pcpu);
+		iowait		= get_iowait_time(&kcpustat, pcpu);
 		irq		= cpustat[CPUTIME_IRQ];
 		softirq		= cpustat[CPUTIME_SOFTIRQ];
 		steal		= cpustat[CPUTIME_STEAL];
-- 
2.31.1

