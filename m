Return-Path: <linux-fsdevel+bounces-28237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8FB968699
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 13:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638321F21FF6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 11:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DFF1D6C6C;
	Mon,  2 Sep 2024 11:49:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F314A32;
	Mon,  2 Sep 2024 11:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725277788; cv=none; b=NWXMgDV/G8m15hmXBawQdhMp963zJfLoh5ncQfP3bbW1m5qnAt8aaFVcVcbK27FH2SUvN5MLUNKULqNoi9wbZPrzx6vejQO2quf72CLUJ85xL8ZB18J+LxiAEPpK4mMc0vB+JtNhVHk1xFnvHVRAsjSyGVCMw2Uw0od4s0bB6CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725277788; c=relaxed/simple;
	bh=FjuCWzUEIOKpjZU4R/83y9ZrM89QEkr/ocBjm542UWc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FOx5oSdr1Vg1GNMRAOtvKxn8hgZ131XtrD3kYs1bv1IEmRh8Y2Z87l+/6CBojz3AxuuN5mTJQQZBB/CJCOmEFejcCiy4iLys2ZrWY5klTl/yTF0krO3CSK7iA0vhqVPxWG00XXdiJfT2F/K9ggf79E9u5YVBI/Cb9Mo/pA6mgwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4825q1rT007958;
	Mon, 2 Sep 2024 11:49:25 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41bt599v6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 02 Sep 2024 11:49:25 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Sep 2024 04:49:23 -0700
Received: from pek-lpd-ccm5.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Mon, 2 Sep 2024 04:49:21 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <mcgrof@kernel.org>, <keescook@chromium.org>, <yzaikin@google.com>,
        <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <mathieu.desnoyers@efficios.com>, <yun.zhou@windriver.com>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH] kernel: add pid_max to pid_namespace
Date: Mon, 2 Sep 2024 19:49:20 +0800
Message-ID: <20240902114920.1534699-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: pBk3oJjMTpTfqvgKEfVvYDrt0PlWpOZ0
X-Authority-Analysis: v=2.4 cv=DN/d4DNb c=1 sm=1 tr=0 ts=66d5a645 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=EaEq8P2WXUwA:10 a=t7CeM3EgAAAA:8 a=Xi3v-mgWfji5ICalIy4A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: pBk3oJjMTpTfqvgKEfVvYDrt0PlWpOZ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-09-02_02,2024-09-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2409020095

Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
 include/linux/pid_namespace.h |  1 +
 kernel/pid.c                  | 12 ++++++------
 kernel/pid_namespace.c        | 33 ++++++++++++++++++++++++++++-----
 kernel/sysctl.c               |  9 ---------
 kernel/trace/pid_list.c       |  2 +-
 kernel/trace/trace.c          |  2 +-
 kernel/trace/trace.h          |  2 --
 7 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index f9f9931e02d6..0e3c18f3cac5 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -27,6 +27,7 @@ struct pid_namespace {
 	struct idr idr;
 	struct rcu_head rcu;
 	unsigned int pid_allocated;
+	int pid_max;
 	struct task_struct *child_reaper;
 	struct kmem_cache *pid_cachep;
 	unsigned int level;
diff --git a/kernel/pid.c b/kernel/pid.c
index 6500ef956f2f..14da3f68ceed 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -59,8 +59,6 @@ struct pid init_struct_pid = {
 	}, }
 };
 
-int pid_max = PID_MAX_DEFAULT;
-
 #define RESERVED_PIDS		300
 
 int pid_max_min = RESERVED_PIDS + 1;
@@ -74,6 +72,7 @@ int pid_max_max = PID_MAX_LIMIT;
  */
 struct pid_namespace init_pid_ns = {
 	.ns.count = REFCOUNT_INIT(2),
+	.pid_max = PID_MAX_DEFAULT,
 	.idr = IDR_INIT(init_pid_ns.idr),
 	.pid_allocated = PIDNS_ADDING,
 	.level = 0,
@@ -194,7 +193,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 			tid = set_tid[ns->level - i];
 
 			retval = -EINVAL;
-			if (tid < 1 || tid >= pid_max)
+			if (tid < 1 || tid >= tmp->pid_max)
 				goto out_free;
 			/*
 			 * Also fail if a PID != 1 is requested and
@@ -234,7 +233,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 			 * a partially initialized PID (see below).
 			 */
 			nr = idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
-					      pid_max, GFP_ATOMIC);
+					      tmp->pid_max, GFP_ATOMIC);
 		}
 		spin_unlock_irq(&pidmap_lock);
 		idr_preload_end();
@@ -651,11 +650,12 @@ void __init pid_idr_init(void)
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
index 3028b2218aa4..d6b3f34ecb25 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -110,6 +110,7 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
 	ns->user_ns = get_user_ns(user_ns);
 	ns->ucounts = ucounts;
 	ns->pid_allocated = PIDNS_ADDING;
+	ns->pid_max = parent_pid_ns->pid_max;
 #if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
 	ns->memfd_noexec_scope = pidns_memfd_noexec_scope(parent_pid_ns);
 #endif
@@ -295,20 +296,44 @@ static int pid_ns_ctl_handler(struct ctl_table *table, int write,
 
 	return ret;
 }
+#endif	/* CONFIG_CHECKPOINT_RESTORE */
+
+static int pid_max_ns_ctl_handler(struct ctl_table *table, int write,
+		void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct pid_namespace *pid_ns = task_active_pid_ns(current);
+
+	if (write && !checkpoint_restore_ns_capable(pid_ns->user_ns))
+		return -EPERM;
+
+	table->data = &pid_ns->pid_max;
+	if (pid_ns->parent)
+		table->extra2 = &pid_ns->parent->pid_max;
+
+	return proc_dointvec_minmax(table, write, buffer, lenp, ppos);
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
+	},
+#endif	/* CONFIG_CHECKPOINT_RESTORE */
+	{
+		.procname	= "pid_max",
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= pid_max_ns_ctl_handler,
+		.extra1		= &pid_max_min,
+		.extra2		= &pid_max_max,
 	},
 	{ }
 };
-#endif	/* CONFIG_CHECKPOINT_RESTORE */
 
 int reboot_pid_ns(struct pid_namespace *pid_ns, int cmd)
 {
@@ -465,9 +490,7 @@ static __init int pid_namespaces_init(void)
 {
 	pid_ns_cachep = KMEM_CACHE(pid_namespace, SLAB_PANIC | SLAB_ACCOUNT);
 
-#ifdef CONFIG_CHECKPOINT_RESTORE
 	register_sysctl_init("kernel", pid_ns_ctl_table);
-#endif
 
 	register_pid_ns_sysctl_table_vm();
 	return 0;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 157f7ce2942d..857bfdb39b15 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1809,15 +1809,6 @@ static struct ctl_table kern_table[] = {
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
index 95106d02b32d..ef52820e6719 100644
--- a/kernel/trace/pid_list.c
+++ b/kernel/trace/pid_list.c
@@ -414,7 +414,7 @@ struct trace_pid_list *trace_pid_list_alloc(void)
 	int i;
 
 	/* According to linux/thread.h, pids can be no bigger that 30 bits */
-	WARN_ON_ONCE(pid_max > (1 << 30));
+	WARN_ON_ONCE(init_pid_ns.pid_max > (1 << 30));
 
 	pid_list = kzalloc(sizeof(*pid_list), GFP_KERNEL);
 	if (!pid_list)
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index fbcd3bafb93e..6295679ce16c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5415,7 +5415,7 @@ int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
 
 	if (mask == TRACE_ITER_RECORD_TGID) {
 		if (!tgid_map) {
-			tgid_map_max = pid_max;
+			tgid_map_max = init_pid_ns.pid_max;
 			map = kvcalloc(tgid_map_max + 1, sizeof(*tgid_map),
 				       GFP_KERNEL);
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index b7f4ea25a194..df61b1db86a2 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -700,8 +700,6 @@ extern unsigned long tracing_thresh;
 
 /* PID filtering */
 
-extern int pid_max;
-
 bool trace_find_filtered_pid(struct trace_pid_list *filtered_pids,
 			     pid_t search_pid);
 bool trace_ignore_this_task(struct trace_pid_list *filtered_pids,
-- 
2.27.0


