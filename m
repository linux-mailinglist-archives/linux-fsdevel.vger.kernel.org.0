Return-Path: <linux-fsdevel+bounces-8289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DED83256F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 09:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E921281C49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 08:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3BBDDD5;
	Fri, 19 Jan 2024 08:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dMES4aKi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A2ED53E;
	Fri, 19 Jan 2024 08:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705651749; cv=none; b=npC9QR4i6plQqsbpAz85B0Ul5G6f7SNVisUJW7oQFeYVwiwq1xqtQPM18urwyUvqd0LdKLAPrgtCFUqfnQ63uw4IGSS9y61cywjM+FCyg7w447nhHtKBm+n7/eEOk+iBAJ+9a9CN++AwSV1IxUooHDI2LQqgkgw2YxvBSVbB8/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705651749; c=relaxed/simple;
	bh=qd+BTb6rH9NIO5HR/wKbO4iEQrU+TISoT2pw6lZuSJI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PVujti2lE+ybYCIB7XRmRruYRW6Cn8aRNHANx3rwd1juF0dMD+TmiyZu9BNLlMx66+2vEil1NjeqTWrqIgNleeHlIGTwpqpgIae/FKs/95r7mNTfCzFMGmlKj6yxrKJ4CrAyT33TM5yi4mapU5eqjgLes7fFFPePQ7kQ4YT6abE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dMES4aKi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40J7DNDm011457;
	Fri, 19 Jan 2024 08:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=kvg0ufm
	g1LH0ci+iHAQyCkwG18EJIWxbtdxWL6idM00=; b=dMES4aKiTDFrd+kU2LVdhxQ
	vrA93N0i3WIX8PChK2HejR+1YwCrdo87e44nm85ocE5w5By6iNR4eST3sSaBfWXJ
	qI/16cZ5v2rF56B/btMJpR3OS6c/vC3Wug4y0EcHWF17j7E2f22YxS9uHrswQ9lm
	KyvQm4p554HyeueiQPqAXMT6Ed1CGUIQGE/bdxQNW/0aC+iOeJ7ADoIGDBm4qL0B
	KUbcIaww/DeRhNK8B3WPG16Htwwf0erWC+9QDaLO6Df7PJaak4/m4msSLiBMpIi3
	XkpMabeoXmKWJcu5rYUJVwv5vRkv3tS0JZm6SryEhLbqUjp4LPG1tdhT42d4cZQ=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vqmgd8345-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 08:08:47 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40J88lX9019216
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 08:08:47 GMT
Received: from hyiwei-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 19 Jan 2024 00:08:38 -0800
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
Subject: [PATCH v3] tracing: Support to dump instance traces by ftrace_dump_on_oops
Date: Fri, 19 Jan 2024 16:08:24 +0800
Message-ID: <20240119080824.907101-1-quic_hyiwei@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: d1sf6dGn5_q50si8XE02nqKgfoVetdDB
X-Proofpoint-GUID: d1sf6dGn5_q50si8XE02nqKgfoVetdDB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_04,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 phishscore=0 clxscore=1011 priorityscore=1501 mlxscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401190029

Currently ftrace only dumps the global trace buffer on an OOPs. For
debugging a production usecase, instance trace will be helpful to
check specific problems since global trace buffer may be used for
other purposes.

This patch extend the ftrace_dump_on_oops parameter to dump a specific
trace instance:

  - ftrace_dump_on_oops=0: as before -- don't dump
  - ftrace_dump_on_oops[=1]: as before -- dump the global trace buffer
  on all CPUs
  - ftrace_dump_on_oops=2 or =orig_cpu: as before -- dump the global
  trace buffer on CPU that triggered the oops
  - ftrace_dump_on_oops=<instance_name>: new behavior -- dump the
  tracing instance matching <instance_name>

Also, the sysctl node can handle the input accordingly.

Cc: Ross Zwisler <zwisler@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Huang Yiwei <quic_hyiwei@quicinc.com>
---
Link: https://lore.kernel.org/linux-trace-kernel/20221209125310.450aee97@gandalf.local.home/

 .../admin-guide/kernel-parameters.txt         |  9 +--
 Documentation/admin-guide/sysctl/kernel.rst   | 11 ++--
 include/linux/ftrace.h                        |  4 +-
 include/linux/kernel.h                        |  1 +
 kernel/sysctl.c                               |  4 +-
 kernel/trace/trace.c                          | 64 ++++++++++++++-----
 kernel/trace/trace_selftest.c                 |  2 +-
 7 files changed, 65 insertions(+), 30 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a36cf8cc582c..b3aa533253f1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1559,12 +1559,13 @@
 			The above will cause the "foo" tracing instance to trigger
 			a snapshot at the end of boot up.
 
-	ftrace_dump_on_oops[=orig_cpu]
+	ftrace_dump_on_oops[=orig_cpu | =<instance>]
 			[FTRACE] will dump the trace buffers on oops.
-			If no parameter is passed, ftrace will dump
-			buffers of all CPUs, but if you pass orig_cpu, it will
+			If no parameter is passed, ftrace will dump global
+			buffers of all CPUs, if you pass orig_cpu, it will
 			dump only the buffer of the CPU that triggered the
-			oops.
+			oops, or specific instance will be dumped if instance
+			name is passed.
 
 	ftrace_filter=[function-list]
 			[FTRACE] Limit the functions traced by the function
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 6584a1f9bfe3..ecf036b63c48 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -296,11 +296,12 @@ kernel panic). This will output the contents of the ftrace buffers to
 the console.  This is very useful for capturing traces that lead to
 crashes and outputting them to a serial console.
 
-= ===================================================
-0 Disabled (default).
-1 Dump buffers of all CPUs.
-2 Dump the buffer of the CPU that triggered the oops.
-= ===================================================
+=========== ===================================================
+0           Disabled (default).
+1           Dump buffers of all CPUs.
+2(orig_cpu) Dump the buffer of the CPU that triggered the oops.
+<instance>  Dump the specific instance buffer.
+=========== ===================================================
 
 
 ftrace_enabled, stack_tracer_enabled
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index e8921871ef9a..f20de4621ec1 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1151,7 +1151,9 @@ static inline void unpause_graph_tracing(void) { }
 #ifdef CONFIG_TRACING
 enum ftrace_dump_mode;
 
-extern enum ftrace_dump_mode ftrace_dump_on_oops;
+#define MAX_TRACER_SIZE		100
+extern char ftrace_dump_on_oops[];
+extern enum ftrace_dump_mode get_ftrace_dump_mode(void);
 extern int tracepoint_printk;
 
 extern void disable_trace_on_warning(void);
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d9ad21058eed..de4a76036372 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -255,6 +255,7 @@ enum ftrace_dump_mode {
 	DUMP_NONE,
 	DUMP_ALL,
 	DUMP_ORIG,
+	DUMP_INSTANCE,
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
index a0defe156b57..9a76a278e5c3 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -130,9 +130,10 @@ cpumask_var_t __read_mostly	tracing_buffer_mask;
  * /proc/sys/kernel/ftrace_dump_on_oops
  * Set 1 if you want to dump buffers of all CPUs
  * Set 2 if you want to dump the buffer of the CPU that triggered oops
+ * Set instance name if you want to dump the specific trace instance
  */
-
-enum ftrace_dump_mode ftrace_dump_on_oops;
+/* Set to string format zero to disable by default */
+char ftrace_dump_on_oops[MAX_TRACER_SIZE] = "0";
 
 /* When set, tracing will stop when a WARN*() is hit */
 int __disable_trace_on_warning;
@@ -178,7 +179,6 @@ static void ftrace_trace_userstack(struct trace_array *tr,
 				   struct trace_buffer *buffer,
 				   unsigned int trace_ctx);
 
-#define MAX_TRACER_SIZE		100
 static char bootup_tracer_buf[MAX_TRACER_SIZE] __initdata;
 static char *default_bootup_tracer;
 
@@ -201,19 +201,32 @@ static int __init set_cmdline_ftrace(char *str)
 }
 __setup("ftrace=", set_cmdline_ftrace);
 
+enum ftrace_dump_mode get_ftrace_dump_mode(void)
+{
+	if (!strcmp("0", ftrace_dump_on_oops))
+		return DUMP_NONE;
+	else if (!strcmp("1", ftrace_dump_on_oops))
+		return DUMP_ALL;
+	else if (!strcmp("orig_cpu", ftrace_dump_on_oops) ||
+			!strcmp("2", ftrace_dump_on_oops))
+		return DUMP_ORIG;
+	else
+		return DUMP_INSTANCE;
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
+	if (*str++ == '=') {
+		strscpy(ftrace_dump_on_oops, str, MAX_TRACER_SIZE);
+		return 1;
+	}
 
-        return 0;
+	return 0;
 }
 __setup("ftrace_dump_on_oops", set_ftrace_dump_on_oops);
 
@@ -10085,14 +10098,16 @@ static struct notifier_block trace_die_notifier = {
 static int trace_die_panic_handler(struct notifier_block *self,
 				unsigned long ev, void *unused)
 {
-	if (!ftrace_dump_on_oops)
+	enum ftrace_dump_mode dump_mode = get_ftrace_dump_mode();
+
+	if (!dump_mode)
 		return NOTIFY_DONE;
 
 	/* The die notifier requires DIE_OOPS to trigger */
 	if (self == &trace_die_notifier && ev != DIE_OOPS)
 		return NOTIFY_DONE;
 
-	ftrace_dump(ftrace_dump_on_oops);
+	ftrace_dump(dump_mode);
 
 	return NOTIFY_DONE;
 }
@@ -10133,12 +10148,12 @@ trace_printk_seq(struct trace_seq *s)
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
@@ -10158,6 +10173,11 @@ void trace_init_global_iter(struct trace_iterator *iter)
 	iter->fmt_size = STATIC_FMT_BUF_SIZE;
 }
 
+void trace_init_global_iter(struct trace_iterator *iter)
+{
+	trace_init_iter(iter, &global_trace);
+}
+
 void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
 {
 	/* use static because iter can be a bit big for the stack */
@@ -10168,6 +10188,15 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
 	unsigned long flags;
 	int cnt = 0, cpu;
 
+	if (oops_dump_mode == DUMP_INSTANCE) {
+		tr = trace_array_find(ftrace_dump_on_oops);
+		if (!tr) {
+			printk(KERN_TRACE "Instance %s not found\n",
+				ftrace_dump_on_oops);
+			return;
+		}
+	}
+
 	/* Only allow one dump user at a time. */
 	if (atomic_inc_return(&dump_running) != 1) {
 		atomic_dec(&dump_running);
@@ -10182,12 +10211,12 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
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
@@ -10200,6 +10229,7 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
 
 	switch (oops_dump_mode) {
 	case DUMP_ALL:
+	case DUMP_INSTANCE:
 		iter.cpu_file = RING_BUFFER_ALL_CPUS;
 		break;
 	case DUMP_ORIG:
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index 529590499b1f..a9750a680324 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -768,7 +768,7 @@ static int trace_graph_entry_watchdog(struct ftrace_graph_ent *trace)
 	if (unlikely(++graph_hang_thresh > GRAPH_MAX_FUNC_TEST)) {
 		ftrace_graph_stop();
 		printk(KERN_WARNING "BUG: Function graph tracer hang!\n");
-		if (ftrace_dump_on_oops) {
+		if (get_ftrace_dump_mode()) {
 			ftrace_dump(DUMP_ALL);
 			/* ftrace_dump() disables tracing */
 			tracing_on();
-- 
2.25.1


