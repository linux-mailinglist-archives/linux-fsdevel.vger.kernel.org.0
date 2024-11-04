Return-Path: <linux-fsdevel+bounces-33587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BB79BAA07
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 01:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A6BFB21330
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 00:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2F9A957;
	Mon,  4 Nov 2024 00:54:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD82833FE;
	Mon,  4 Nov 2024 00:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730681673; cv=none; b=uLzBC/B+tm7ZbqTapzefRJbjII8lUrVvFHqFed/KGFP1LZ8Lbo1uLNlw0y8pmcxaB5WfANAzF5KvimXt0+c2AasSf/l28fuibqqgqn+MJxhmdZDYy+thAUTSlPEbL0nLIR40yNTg5HxvtGwpBeTt2Wg/BymTtJwIANSE404iAi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730681673; c=relaxed/simple;
	bh=4P9Gt9Gti9J/0neH+YENuJ4M8tG8jPeCIcy94SL+xg0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RU9caDDuA0r4C4ohbYrYtGTAiGOEfP7cxQzqGndfssf57B4rAv7T224R43RRzTL0j82SRj17hOKqiuKCWeTh/8ktvdLqHUIejtEEOPM1FFHLSJOcmSPzr+F51RqDYeuhb5TElz/2J/ExdahGaC4EnNRIaTRHEiuPFtDGpIrrEx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A402Kor013211;
	Mon, 4 Nov 2024 00:54:13 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42nb2899m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 04 Nov 2024 00:54:12 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 3 Nov 2024 16:54:11 -0800
Received: from pek-lpd-ccm5.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Sun, 3 Nov 2024 16:54:09 -0800
From: Yun Zhou <yun.zhou@windriver.com>
To: <mcgrof@kernel.org>, <kees@kernel.org>, <joel.granados@kernel.org>,
        <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
        <yun.zhou@windriver.com>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH v2] kernel: add pid_max to pid_namespace
Date: Mon, 4 Nov 2024 08:54:08 +0800
Message-ID: <20241104005408.1926451-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=CfNa56rl c=1 sm=1 tr=0 ts=67281b34 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=VlfZXiiP6vEA:10 a=t7CeM3EgAAAA:8 a=Xi3v-mgWfji5ICalIy4A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: eUeEofWin1bCxwW--EOrFriLJxjE-yLP
X-Proofpoint-GUID: eUeEofWin1bCxwW--EOrFriLJxjE-yLP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-03_21,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411040005

It is necessary to have a different pid_max in different containers.
For example, multiple containers are running on a host, one of which
is Android, and its 32 bit bionic libc only accepts pid <= 65535. So
it requires the global pid_max <= 65535. This will cause configuration
conflicts with other containers and also limit the maximum number of
tasks for the entire system.

Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
 include/linux/pid_namespace.h     |  1 +
 kernel/pid.c                      | 12 +++++------
 kernel/pid_namespace.c            | 34 ++++++++++++++++++++++++++-----
 kernel/sysctl.c                   |  9 --------
 kernel/trace/pid_list.c           |  2 +-
 kernel/trace/trace.h              |  2 --
 kernel/trace/trace_sched_switch.c |  2 +-
 7 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index f9f9931e02d6a..064cfe2542fc5 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -38,6 +38,7 @@ struct pid_namespace {
 	struct ucounts *ucounts;
 	int reboot;	/* group exit code if this pidns was rebooted */
 	struct ns_common ns;
+	int pid_max;
 #if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
 	int memfd_noexec_scope;
 #endif
diff --git a/kernel/pid.c b/kernel/pid.c
index 2715afb77eab8..f8026a61436bd 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -60,8 +60,6 @@ struct pid init_struct_pid = {
 	}, }
 };
 
-int pid_max = PID_MAX_DEFAULT;
-
 int pid_max_min = RESERVED_PIDS + 1;
 int pid_max_max = PID_MAX_LIMIT;
 /*
@@ -78,6 +76,7 @@ static u64 pidfs_ino = RESERVED_PIDS;
  */
 struct pid_namespace init_pid_ns = {
 	.ns.count = REFCOUNT_INIT(2),
+	.pid_max = PID_MAX_DEFAULT,
 	.idr = IDR_INIT(init_pid_ns.idr),
 	.pid_allocated = PIDNS_ADDING,
 	.level = 0,
@@ -198,7 +197,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 			tid = set_tid[ns->level - i];
 
 			retval = -EINVAL;
-			if (tid < 1 || tid >= pid_max)
+			if (tid < 1 || tid >= tmp->pid_max)
 				goto out_free;
 			/*
 			 * Also fail if a PID != 1 is requested and
@@ -238,7 +237,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 			 * a partially initialized PID (see below).
 			 */
 			nr = idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
-					      pid_max, GFP_ATOMIC);
+					      tmp->pid_max, GFP_ATOMIC);
 		}
 		spin_unlock_irq(&pidmap_lock);
 		idr_preload_end();
@@ -653,11 +652,12 @@ void __init pid_idr_init(void)
 	BUILD_BUG_ON(PID_MAX_LIMIT >= PIDNS_ADDING);
 
 	/* bump default and minimum pid_max based on number of cpus */
-	pid_max = min(pid_max_max, max_t(int, pid_max,
+	init_pid_ns.pid_max = min(pid_max_max, max_t(int, init_pid_ns.pid_max,
 				PIDS_PER_CPU_DEFAULT * num_possible_cpus()));
 	pid_max_min = max_t(int, pid_max_min,
 				PIDS_PER_CPU_MIN * num_possible_cpus());
-	pr_info("pid_max: default: %u minimum: %u\n", pid_max, pid_max_min);
+	pr_info("pid_max: default: %u minimum: %u\n", init_pid_ns.pid_max,
+			pid_max_min);
 
 	idr_init(&init_pid_ns.idr);
 
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index d70ab49d5b4a6..a5a8254825d55 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -111,6 +111,7 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
 	ns->user_ns = get_user_ns(user_ns);
 	ns->ucounts = ucounts;
 	ns->pid_allocated = PIDNS_ADDING;
+	ns->pid_max = parent_pid_ns->pid_max;
 #if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
 	ns->memfd_noexec_scope = pidns_memfd_noexec_scope(parent_pid_ns);
 #endif
@@ -280,19 +281,44 @@ static int pid_ns_ctl_handler(const struct ctl_table *table, int write,
 
 	return ret;
 }
+#endif	/* CONFIG_CHECKPOINT_RESTORE */
+
+static int pid_max_ns_ctl_handler(const struct ctl_table *table, int write,
+		void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct pid_namespace *pid_ns = task_active_pid_ns(current);
+	struct ctl_table tmp = *table;
+
+	if (write && !checkpoint_restore_ns_capable(pid_ns->user_ns))
+		return -EPERM;
+
+	tmp.data = &pid_ns->pid_max;
+	if (pid_ns->parent)
+		tmp.extra2 = &pid_ns->parent->pid_max;
+
+	return proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
+}
 
-extern int pid_max;
 static struct ctl_table pid_ns_ctl_table[] = {
+#ifdef CONFIG_CHECKPOINT_RESTORE
 	{
 		.procname = "ns_last_pid",
 		.maxlen = sizeof(int),
 		.mode = 0666, /* permissions are checked in the handler */
 		.proc_handler = pid_ns_ctl_handler,
 		.extra1 = SYSCTL_ZERO,
-		.extra2 = &pid_max,
+		.extra2 = &init_pid_ns.pid_max,
 	},
-};
 #endif	/* CONFIG_CHECKPOINT_RESTORE */
+	{
+		.procname = "pid_max",
+		.maxlen = sizeof(int),
+		.mode = 0644,
+		.proc_handler = pid_max_ns_ctl_handler,
+		.extra1 = &pid_max_min,
+		.extra2 = &pid_max_max,
+	},
+};
 
 int reboot_pid_ns(struct pid_namespace *pid_ns, int cmd)
 {
@@ -449,9 +475,7 @@ static __init int pid_namespaces_init(void)
 {
 	pid_ns_cachep = KMEM_CACHE(pid_namespace, SLAB_PANIC | SLAB_ACCOUNT);
 
-#ifdef CONFIG_CHECKPOINT_RESTORE
 	register_sysctl_init("kernel", pid_ns_ctl_table);
-#endif
 
 	register_pid_ns_sysctl_table_vm();
 	return 0;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 79e6cb1d5c48f..676a0d675e7f8 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1804,15 +1804,6 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec,
 	},
 #endif
-	{
-		.procname	= "pid_max",
-		.data		= &pid_max,
-		.maxlen		= sizeof (int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &pid_max_min,
-		.extra2		= &pid_max_max,
-	},
 	{
 		.procname	= "panic_on_oops",
 		.data		= &panic_on_oops,
diff --git a/kernel/trace/pid_list.c b/kernel/trace/pid_list.c
index 4966e6bbdf6f3..c62b9b3cfb3d8 100644
--- a/kernel/trace/pid_list.c
+++ b/kernel/trace/pid_list.c
@@ -414,7 +414,7 @@ struct trace_pid_list *trace_pid_list_alloc(void)
 	int i;
 
 	/* According to linux/thread.h, pids can be no bigger that 30 bits */
-	WARN_ON_ONCE(pid_max > (1 << 30));
+	WARN_ON_ONCE(init_pid_ns.pid_max > (1 << 30));
 
 	pid_list = kzalloc(sizeof(*pid_list), GFP_KERNEL);
 	if (!pid_list)
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index c866991b9c78b..e51851d64e4d9 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -715,8 +715,6 @@ extern unsigned long tracing_thresh;
 
 /* PID filtering */
 
-extern int pid_max;
-
 bool trace_find_filtered_pid(struct trace_pid_list *filtered_pids,
 			     pid_t search_pid);
 bool trace_ignore_this_task(struct trace_pid_list *filtered_pids,
diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
index 8a407adb0e1c4..c20c80abe065b 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -442,7 +442,7 @@ int trace_alloc_tgid_map(void)
 	if (tgid_map)
 		return 0;
 
-	tgid_map_max = pid_max;
+	tgid_map_max = init_pid_ns.pid_max;
 	map = kvcalloc(tgid_map_max + 1, sizeof(*tgid_map),
 		       GFP_KERNEL);
 	if (!map)
-- 
2.27.0


