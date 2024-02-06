Return-Path: <linux-fsdevel+bounces-10433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78ACC84B18E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 10:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D0A285696
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 09:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B631012D74A;
	Tue,  6 Feb 2024 09:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l8OgYQtt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322E612D145;
	Tue,  6 Feb 2024 09:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707212870; cv=none; b=ZaTn3SF2bt+p2+0Zftk85bGZlleK2cz/BJ8eKXG+Nu553uQjBF+UVBGC9F4f1vWH9CXaeXIlDPK37NIw9rMktUAgSH6NdN4CbmgL8MJaKG8F7+ueK8kIss1YjRI5AHCwGi/bVaZDnBEXmrqPw7lFRi9dh3FRyBsOOVIODPKmwVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707212870; c=relaxed/simple;
	bh=VmWIeQEni7NFSfsMlhBXrt2Zjb52TqmWQ8g5BUg+fkE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZnRYpqcWoGS/2a2a5QoMCY2qR/nn5ON0hp9nbuohN90QVndUp5h35atWAsIc4BFwW1LM3ZyKuRimsfMCPGU4OSfv6GsDM+I1+4LOdXceWLFVaD2LK874NlnlPyIRGm8josMHcVwsbIl+SPYFiIZpXd8ayly1eBsgQjjIAHloFEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l8OgYQtt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4164iI6j011278;
	Tue, 6 Feb 2024 09:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=mZJ576n
	Tug8HxiwY6/Pd4AEQHQSm6XDEeD8g6N8hzew=; b=l8OgYQttJ4ceOxVEKKXEIv0
	ZDNHiNx4TFyF4k4WXYAsF7dOJBi3wD9XgQSdLkKOlqEWMtQABV6WtsljrYhV7rrc
	x9YdYhx8jWMybzvtkYZzkGhbZUS7Q17dOmsurwA2YB+64UkeTo2yOQ/BMeEyA0QN
	ul+1IbF7vGNkzOPEYPS4bVZ3/PNtQoJ1d6c0xmpat7bAY0BasDfMyMm2Jb1BGjwF
	Q515j5ek3df7MwHedcLJlnuTCgWys0vhd6Rc6DHrgJUU6tOEw1gpw3DMJaiMmiuO
	yjwxCzURnEvnsre7qcwmp4x24qSF3OqItLgmoFIoKW0mqf2CsMDLuzVcdph/yBw=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w399es3e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 09:47:23 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4169lLXQ016543
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 09:47:21 GMT
Received: from hyiwei-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 6 Feb 2024 01:47:13 -0800
From: Huang Yiwei <quic_hyiwei@quicinc.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <mark.rutland@arm.com>,
        <mcgrof@kernel.org>, <keescook@chromium.org>, <j.granados@samsung.com>,
        <mathieu.desnoyers@efficios.com>, <corbet@lwn.net>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <quic_bjorande@quicinc.com>, <quic_tsoni@quicinc.com>,
        <quic_satyap@quicinc.com>, <quic_aiquny@quicinc.com>,
        <kernel@quicinc.com>, Huang Yiwei <quic_hyiwei@quicinc.com>,
        Ross Zwisler <zwisler@google.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v4] tracing: Support to dump instance traces by ftrace_dump_on_oops
Date: Tue, 6 Feb 2024 17:46:50 +0800
Message-ID: <20240206094650.1696566-1-quic_hyiwei@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: w0P0RX9VzB73zH7ZO02hPfP5wMczb5ZZ
X-Proofpoint-ORIG-GUID: w0P0RX9VzB73zH7ZO02hPfP5wMczb5ZZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 clxscore=1011 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060068

Currently ftrace only dumps the global trace buffer on an OOPs. For
debugging a production usecase, instance trace will be helpful to
check specific problems since global trace buffer may be used for
other purposes.

This patch extend the ftrace_dump_on_oops parameter to dump a specific
or multiple trace instances:

  - ftrace_dump_on_oops=0: as before -- don't dump
  - ftrace_dump_on_oops[=1]: as before -- dump the global trace buffer
  on all CPUs
  - ftrace_dump_on_oops=2 or =orig_cpu: as before -- dump the global
  trace buffer on CPU that triggered the oops
  - ftrace_dump_on_oops=<instance_name>: new behavior -- dump the
  tracing instance matching <instance_name>
  - ftrace_dump_on_oops[=2/orig_cpu],<instance1_name>[=2/orig_cpu],
  <instrance2_name>[=2/orig_cpu]: new behavior -- dump the global trace
  buffer and multiple instance buffer on all CPUs, or only dump on CPU
  that triggered the oops if =2 or =orig_cpu is given

Also, the sysctl node can handle the input accordingly.

Cc: Ross Zwisler <zwisler@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Huang Yiwei <quic_hyiwei@quicinc.com>
---
Link: https://lore.kernel.org/linux-trace-kernel/20240119080824.907101-1-quic_hyiwei@quicinc.com/

 .../admin-guide/kernel-parameters.txt         |  26 ++-
 Documentation/admin-guide/sysctl/kernel.rst   |  30 +++-
 include/linux/ftrace.h                        |   4 +-
 include/linux/kernel.h                        |   1 +
 kernel/sysctl.c                               |   4 +-
 kernel/trace/trace.c                          | 156 +++++++++++++-----
 kernel/trace/trace_selftest.c                 |   2 +-
 7 files changed, 168 insertions(+), 55 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 31b3a25680d0..f4c05a43b561 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1561,12 +1561,28 @@
 			The above will cause the "foo" tracing instance to trigger
 			a snapshot at the end of boot up.
 
-	ftrace_dump_on_oops[=orig_cpu]
+	ftrace_dump_on_opps[=2(orig_cpu) | =<instance>][,<instance> |
+			  ,<instance>=2(orig_cpu)]
 			[FTRACE] will dump the trace buffers on oops.
-			If no parameter is passed, ftrace will dump
-			buffers of all CPUs, but if you pass orig_cpu, it will
-			dump only the buffer of the CPU that triggered the
-			oops.
+			If no parameter is passed, ftrace will dump global
+			buffers of all CPUs, if you pass 2 or orig_cpu, it
+			will dump only the buffer of the CPU that triggered
+			the oops, or the specific instance will be dumped if
+			its name is passed. Multiple instance dump is also
+			supported, and instances are separated by commas. Each
+			instance supports only dump on CPU that triggered the
+			oops by passing 2 or orig_cpu to it.
+
+			ftrace_dump_on_opps=foo=orig_cpu
+
+			The above will dump only the buffer of "foo" instance
+			on CPU that triggered the oops.
+
+			ftrace_dump_on_opps,foo,bar=orig_cpu
+
+			The above will dump global buffer on all CPUs, the
+			buffer of "foo" instance on all CPUs and the buffer
+			of "bar" instance on CPU that triggered the oops.
 
 	ftrace_filter=[function-list]
 			[FTRACE] Limit the functions traced by the function
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 6584a1f9bfe3..ea8e5f152edc 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -296,12 +296,30 @@ kernel panic). This will output the contents of the ftrace buffers to
 the console.  This is very useful for capturing traces that lead to
 crashes and outputting them to a serial console.
 
-= ===================================================
-0 Disabled (default).
-1 Dump buffers of all CPUs.
-2 Dump the buffer of the CPU that triggered the oops.
-= ===================================================
-
+======================= ===========================================
+0                       Disabled (default).
+1                       Dump buffers of all CPUs.
+2(orig_cpu)             Dump the buffer of the CPU that triggered the
+                        oops.
+<instance>              Dump the specific instance buffer on all CPUs.
+<instance>=2(orig_cpu)  Dump the specific instance buffer on the CPU
+                        that triggered the oops.
+======================= ===========================================
+
+Multiple instance dump is also supported, and instances are separated
+by commas. If global buffer also needs to be dumped, please specify
+the dump mode (1/2/orig_cpu) first for global buffer.
+
+So for example to dump "foo" and "bar" instance buffer on all CPUs,
+user can::
+
+  echo "foo,bar" > /proc/sys/kernel/ftrace_dump_on_oops
+
+To dump global buffer and "foo" instance buffer on all
+CPUs along with the "bar" instance buffer on CPU that triggered the
+oops, user can::
+
+  echo "1,foo,bar=2" > /proc/sys/kernel/ftrace_dump_on_oops
 
 ftrace_enabled, stack_tracer_enabled
 ====================================
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index e8921871ef9a..54d53f345d14 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1151,7 +1151,9 @@ static inline void unpause_graph_tracing(void) { }
 #ifdef CONFIG_TRACING
 enum ftrace_dump_mode;
 
-extern enum ftrace_dump_mode ftrace_dump_on_oops;
+#define MAX_TRACER_SIZE		100
+extern char ftrace_dump_on_oops[];
+extern int ftrace_dump_on_oops_enabled(void);
 extern int tracepoint_printk;
 
 extern void disable_trace_on_warning(void);
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d9ad21058eed..b142a4f41d34 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -255,6 +255,7 @@ enum ftrace_dump_mode {
 	DUMP_NONE,
 	DUMP_ALL,
 	DUMP_ORIG,
+	DUMP_PARAM,
 };
 
 #ifdef CONFIG_TRACING
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 157f7ce2942d..81cc974913bb 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1710,9 +1710,9 @@ static struct ctl_table kern_table[] = {
 	{
 		.procname	= "ftrace_dump_on_oops",
 		.data		= &ftrace_dump_on_oops,
-		.maxlen		= sizeof(int),
+		.maxlen		= MAX_TRACER_SIZE,
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dostring,
 	},
 	{
 		.procname	= "traceoff_on_warning",
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2a7c6fd934e9..5622614d3035 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -130,9 +130,12 @@ cpumask_var_t __read_mostly	tracing_buffer_mask;
  * /proc/sys/kernel/ftrace_dump_on_oops
  * Set 1 if you want to dump buffers of all CPUs
  * Set 2 if you want to dump the buffer of the CPU that triggered oops
+ * Set instance name if you want to dump the specific trace instance
+ * Multiple instance dump is also supported, and instances are seperated
+ * by commas.
  */
-
-enum ftrace_dump_mode ftrace_dump_on_oops;
+/* Set to string format zero to disable by default */
+char ftrace_dump_on_oops[MAX_TRACER_SIZE] = "0";
 
 /* When set, tracing will stop when a WARN*() is hit */
 int __disable_trace_on_warning;
@@ -178,7 +181,6 @@ static void ftrace_trace_userstack(struct trace_array *tr,
 				   struct trace_buffer *buffer,
 				   unsigned int trace_ctx);
 
-#define MAX_TRACER_SIZE		100
 static char bootup_tracer_buf[MAX_TRACER_SIZE] __initdata;
 static char *default_bootup_tracer;
 
@@ -201,19 +203,33 @@ static int __init set_cmdline_ftrace(char *str)
 }
 __setup("ftrace=", set_cmdline_ftrace);
 
+int ftrace_dump_on_oops_enabled(void)
+{
+	if (!strcmp("0", ftrace_dump_on_oops))
+		return 0;
+	else
+		return 1;
+}
+
 static int __init set_ftrace_dump_on_oops(char *str)
 {
-	if (*str++ != '=' || !*str || !strcmp("1", str)) {
-		ftrace_dump_on_oops = DUMP_ALL;
+	if (!*str) {
+		strscpy(ftrace_dump_on_oops, "1", MAX_TRACER_SIZE);
 		return 1;
 	}
 
-	if (!strcmp("orig_cpu", str) || !strcmp("2", str)) {
-		ftrace_dump_on_oops = DUMP_ORIG;
-                return 1;
-        }
+	if (*str == ',') {
+		strscpy(ftrace_dump_on_oops, "1", MAX_TRACER_SIZE);
+		strscpy(ftrace_dump_on_oops + 1, str, MAX_TRACER_SIZE - 1);
+		return 1;
+	}
+
+	if (*str++ == '=') {
+		strscpy(ftrace_dump_on_oops, str, MAX_TRACER_SIZE);
+		return 1;
+	}
 
-        return 0;
+	return 0;
 }
 __setup("ftrace_dump_on_oops", set_ftrace_dump_on_oops);
 
@@ -10243,14 +10259,14 @@ static struct notifier_block trace_die_notifier = {
 static int trace_die_panic_handler(struct notifier_block *self,
 				unsigned long ev, void *unused)
 {
-	if (!ftrace_dump_on_oops)
+	if (!ftrace_dump_on_oops_enabled())
 		return NOTIFY_DONE;
 
 	/* The die notifier requires DIE_OOPS to trigger */
 	if (self == &trace_die_notifier && ev != DIE_OOPS)
 		return NOTIFY_DONE;
 
-	ftrace_dump(ftrace_dump_on_oops);
+	ftrace_dump(DUMP_PARAM);
 
 	return NOTIFY_DONE;
 }
@@ -10291,12 +10307,12 @@ trace_printk_seq(struct trace_seq *s)
 	trace_seq_init(s);
 }
 
-void trace_init_global_iter(struct trace_iterator *iter)
+static void trace_init_iter(struct trace_iterator *iter, struct trace_array *tr)
 {
-	iter->tr = &global_trace;
+	iter->tr = tr;
 	iter->trace = iter->tr->current_trace;
 	iter->cpu_file = RING_BUFFER_ALL_CPUS;
-	iter->array_buffer = &global_trace.array_buffer;
+	iter->array_buffer = &tr->array_buffer;
 
 	if (iter->trace && iter->trace->open)
 		iter->trace->open(iter);
@@ -10316,22 +10332,19 @@ void trace_init_global_iter(struct trace_iterator *iter)
 	iter->fmt_size = STATIC_FMT_BUF_SIZE;
 }
 
-void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
+void trace_init_global_iter(struct trace_iterator *iter)
+{
+	trace_init_iter(iter, &global_trace);
+}
+
+void ftrace_dump_one(struct trace_array *tr, enum ftrace_dump_mode dump_mode)
 {
 	/* use static because iter can be a bit big for the stack */
 	static struct trace_iterator iter;
-	static atomic_t dump_running;
-	struct trace_array *tr = &global_trace;
 	unsigned int old_userobj;
 	unsigned long flags;
 	int cnt = 0, cpu;
 
-	/* Only allow one dump user at a time. */
-	if (atomic_inc_return(&dump_running) != 1) {
-		atomic_dec(&dump_running);
-		return;
-	}
-
 	/*
 	 * Always turn off tracing when we dump.
 	 * We don't need to show trace output of what happens
@@ -10340,12 +10353,12 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
 	 * If the user does a sysrq-z, then they can re-enable
 	 * tracing with echo 1 > tracing_on.
 	 */
-	tracing_off();
+	tracer_tracing_off(tr);
 
 	local_irq_save(flags);
 
 	/* Simulate the iterator */
-	trace_init_global_iter(&iter);
+	trace_init_iter(&iter, tr);
 
 	for_each_tracing_cpu(cpu) {
 		atomic_inc(&per_cpu_ptr(iter.array_buffer->data, cpu)->disabled);
@@ -10356,21 +10369,15 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
 	/* don't look at user memory in panic mode */
 	tr->trace_flags &= ~TRACE_ITER_SYM_USEROBJ;
 
-	switch (oops_dump_mode) {
-	case DUMP_ALL:
-		iter.cpu_file = RING_BUFFER_ALL_CPUS;
-		break;
-	case DUMP_ORIG:
+	if (dump_mode == DUMP_ORIG)
 		iter.cpu_file = raw_smp_processor_id();
-		break;
-	case DUMP_NONE:
-		goto out_enable;
-	default:
-		printk(KERN_TRACE "Bad dumping mode, switching to all CPUs dump\n");
+	else
 		iter.cpu_file = RING_BUFFER_ALL_CPUS;
-	}
 
-	printk(KERN_TRACE "Dumping ftrace buffer:\n");
+	if (tr == &global_trace)
+		printk(KERN_TRACE "Dumping ftrace buffer:\n");
+	else
+		printk(KERN_TRACE "Dumping ftrace instance %s buffer:\n", tr->name);
 
 	/* Did function tracer already get disabled? */
 	if (ftrace_is_dead()) {
@@ -10412,15 +10419,84 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
 	else
 		printk(KERN_TRACE "---------------------------------\n");
 
- out_enable:
 	tr->trace_flags |= old_userobj;
 
 	for_each_tracing_cpu(cpu) {
 		atomic_dec(&per_cpu_ptr(iter.array_buffer->data, cpu)->disabled);
 	}
-	atomic_dec(&dump_running);
 	local_irq_restore(flags);
 }
+
+static void ftrace_dump_by_param(void)
+{
+	bool first_param = true;
+	char dump_param[MAX_TRACER_SIZE];
+	char *buf, *token, *inst_name;
+	struct trace_array *tr;
+
+	strscpy(dump_param, ftrace_dump_on_oops, MAX_TRACER_SIZE);
+	buf = dump_param;
+
+	while ((token = strsep(&buf, ",")) != NULL) {
+		if (first_param) {
+			first_param = false;
+			if (!strcmp("0", token))
+				continue;
+			else if (!strcmp("1", token)) {
+				ftrace_dump_one(&global_trace, DUMP_ALL);
+				continue;
+			}
+			else if (!strcmp("2", token) ||
+			  !strcmp("orig_cpu", token)) {
+				ftrace_dump_one(&global_trace, DUMP_ORIG);
+				continue;
+			}
+		}
+
+		inst_name = strsep(&token, "=");
+		tr = trace_array_find(inst_name);
+		if (!tr) {
+			printk(KERN_TRACE "Instance %s not found\n", inst_name);
+			continue;
+		}
+
+		if (token && (!strcmp("2", token) ||
+			  !strcmp("orig_cpu", token)))
+			ftrace_dump_one(tr, DUMP_ORIG);
+		else
+			ftrace_dump_one(tr, DUMP_ALL);
+	}
+}
+
+void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
+{
+	static atomic_t dump_running;
+
+	/* Only allow one dump user at a time. */
+	if (atomic_inc_return(&dump_running) != 1) {
+		atomic_dec(&dump_running);
+		return;
+	}
+
+	switch (oops_dump_mode) {
+	case DUMP_ALL:
+		ftrace_dump_one(&global_trace, DUMP_ALL);
+		break;
+	case DUMP_ORIG:
+		ftrace_dump_one(&global_trace, DUMP_ORIG);
+		break;
+	case DUMP_PARAM:
+		ftrace_dump_by_param();
+		break;
+	case DUMP_NONE:
+		break;
+	default:
+		printk(KERN_TRACE "Bad dumping mode, switching to all CPUs dump\n");
+		ftrace_dump_one(&global_trace, DUMP_ALL);
+	}
+
+	atomic_dec(&dump_running);
+}
 EXPORT_SYMBOL_GPL(ftrace_dump);
 
 #define WRITE_BUFSIZE  4096
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index 529590499b1f..e9c5058a8efd 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -768,7 +768,7 @@ static int trace_graph_entry_watchdog(struct ftrace_graph_ent *trace)
 	if (unlikely(++graph_hang_thresh > GRAPH_MAX_FUNC_TEST)) {
 		ftrace_graph_stop();
 		printk(KERN_WARNING "BUG: Function graph tracer hang!\n");
-		if (ftrace_dump_on_oops) {
+		if (ftrace_dump_on_oops_enabled()) {
 			ftrace_dump(DUMP_ALL);
 			/* ftrace_dump() disables tracing */
 			tracing_on();
-- 
2.25.1


