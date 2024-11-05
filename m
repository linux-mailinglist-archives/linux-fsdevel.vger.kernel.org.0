Return-Path: <linux-fsdevel+bounces-33649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A449BC3AD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 04:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5004A1F22DC3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 03:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A2B1607A4;
	Tue,  5 Nov 2024 03:10:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBA76A33B;
	Tue,  5 Nov 2024 03:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730776236; cv=none; b=FTkHijGbVn2BZj3p8x6Kqxqt/cW0a8TAmu9/LxdwqpO/mMSoRCbMvQr/loJdHrP4qfu8DrZrK21tcJGWqCwlKyQpsGq9M0OccsZVv5odliiyhVE8L4na8oD2eaR4CJYwDKZE7spHkcCM19YEt2jILVqmF8xihc3pni7qtJW4g6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730776236; c=relaxed/simple;
	bh=25oeWFuoIWocaEkkD3V0Ha8+s29QJfJBFCSghi/3QTc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UlKVhYQpxG33cFix4sSH9oLDvRAWVylx/hXpuFwXWDwolbYebICrgYJstq9dzCBK2CBWOp+SH33mGWQPpqVkNLMDMCBwGi8SIE5qA61wlI3nJkMcifM70nn00nz4o32lS7hLuc+45v7qAKrBtQBVwIru3rI1LpWtV9clNOFix7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A52WpUm029056;
	Tue, 5 Nov 2024 03:10:29 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42nb28afnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 05 Nov 2024 03:10:28 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 19:10:27 -0800
Received: from pek-lpd-ccm5.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 19:10:25 -0800
From: Yun Zhou <yun.zhou@windriver.com>
To: <mcgrof@kernel.org>, <kees@kernel.org>, <joel.granados@kernel.org>,
        <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
        <yun.zhou@windriver.com>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH v2] kernel: add pid_max to pid_namespace
Date: Tue, 5 Nov 2024 11:10:24 +0800
Message-ID: <20241105031024.3866383-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=CfNa56rl c=1 sm=1 tr=0 ts=67298ca4 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=VlfZXiiP6vEA:10 a=t7CeM3EgAAAA:8 a=VwQbUJbxAAAA:8 a=Q_y-cLcJQs12tt3JvBMA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: uI7GLaIKgy391YtmvlckW-ZROhEnIAaK
X-Proofpoint-GUID: uI7GLaIKgy391YtmvlckW-ZROhEnIAaK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-04_22,2024-11-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411050023

It is necessary to have a different pid_max in different containers.
For example, multiple containers are running on a host, one of which
is Android, and its 32 bit bionic libc only accepts pid <= 65535. So
it requires the global pid_max <= 65535. This will cause configuration
conflicts with other containers and also limit the maximum number of
tasks for the entire system.

Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
 - Remove sentinels from ctl_table arrays.
v1 - https://lore.kernel.org/all/20241030052933.1041408-1-yun.zhou@windriver.com/
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
index f9f9931e02d6..064cfe2542fc 100644
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
index 2715afb77eab..f8026a61436b 100644
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
index d70ab49d5b4a..a5a8254825d5 100644
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
index 79e6cb1d5c48..676a0d675e7f 100644
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
index 4966e6bbdf6f..c62b9b3cfb3d 100644
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
index c866991b9c78..e51851d64e4d 100644
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
index 8a407adb0e1c..c20c80abe065 100644
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


