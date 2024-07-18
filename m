Return-Path: <linux-fsdevel+bounces-23952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFC793518C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 20:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88A16B22112
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 18:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1052C145A15;
	Thu, 18 Jul 2024 18:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SXd9PvAG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E65A14389A;
	Thu, 18 Jul 2024 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721327282; cv=none; b=VW/oqC9Md5jaoTDbs3lV1c3JVq/WWmLDK4OIvaTA1EMUurQzPQp9R/gJ/E2xAfZRZOfaZGqZkmzgMTWpN/EjTNP3hkQ/EWfMEP0/cvpP9U289Pzi5Gjr7Zi87XCt0WoQQZyBHV3T/sBSncrF017OjiP9I53dJQlcM2j7VNeevIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721327282; c=relaxed/simple;
	bh=h54FbOyDO7UJQQFmYoXBOP1p1g2OVFHBFrtdg//EIg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ItK8+poIqE79X08RS9rSjldcWQP5M5baKLSuLq5q+oshk4tg7zyVlljaRA7lG9J1bOJCcZI9ErG6COyyT282yBkRNz1lLyJ70uZaTbZyyF6LSzcUwRh1MmVywfIwcMv3FSUYw+CXzAcGNJu90hVtJjEJdkTAng6hXrNo69u7hrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SXd9PvAG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from xps-8930.corp.microsoft.com (unknown [131.107.160.48])
	by linux.microsoft.com (Postfix) with ESMTPSA id CA41520B7177;
	Thu, 18 Jul 2024 11:27:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CA41520B7177
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1721327273;
	bh=GnOQJH6coKfJJds1hTuGDPjeAO6p0g0oj+N+wSCFGtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SXd9PvAGvsqXeqsEtaFnGlNW3LLr2x2Avdeqb1hqf8LG+RUfsgWYbdhtQ/xUkEQ7W
	 VvKfpeAMZiTZ0PbjElW3ytMtBT6dyKkilUkNwJb8XgxAiSILm92KagJ2OayHQ7/WnH
	 +2pJtCwKuJ9IxBoo+MAivQN2RIDd5y4qrhNjtcDM=
From: Roman Kisel <romank@linux.microsoft.com>
To: akpm@linux-foundation.org,
	apais@linux.microsoft.com,
	ardb@kernel.org,
	bigeasy@linutronix.de,
	brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	keescook@chromium.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	nagvijay@microsoft.com,
	oleg@redhat.com,
	tandersen@netflix.com,
	vincent.whitchurch@axis.com,
	viro@zeniv.linux.org.uk
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	ssengar@microsoft.com,
	sunilmut@microsoft.com,
	vdso@hexbites.dev
Subject: [PATCH v3 1/2] coredump: Standartize and fix logging
Date: Thu, 18 Jul 2024 11:27:24 -0700
Message-ID: <20240718182743.1959160-2-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718182743.1959160-1-romank@linux.microsoft.com>
References: <20240718182743.1959160-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The coredump code does not log the process ID and the comm
consistently, logs unescaped comm when it does log it, and
does not always use the ratelimited logging. That makes it
harder to analyze logs and puts the system at the risk of
spamming the system log incase something crashes many times
over and over again.

Fix that by logging TGID and comm (escaped) consistently and
using the ratelimited logging always.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 fs/coredump.c            | 43 +++++++++++++++-------------------------
 include/linux/coredump.h | 22 ++++++++++++++++++++
 2 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index a57a06b80f57..19d3343b93c6 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -586,8 +586,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		struct subprocess_info *sub_info;
 
 		if (ispipe < 0) {
-			printk(KERN_WARNING "format_corename failed\n");
-			printk(KERN_WARNING "Aborting core\n");
+			coredump_report_failure("format_corename failed, aborting core");
 			goto fail_unlock;
 		}
 
@@ -607,27 +606,21 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 			 * right pid if a thread in a multi-threaded
 			 * core_pattern process dies.
 			 */
-			printk(KERN_WARNING
-				"Process %d(%s) has RLIMIT_CORE set to 1\n",
-				task_tgid_vnr(current), current->comm);
-			printk(KERN_WARNING "Aborting core\n");
+			coredump_report_failure("RLIMIT_CORE is set to 1, aborting core");
 			goto fail_unlock;
 		}
 		cprm.limit = RLIM_INFINITY;
 
 		dump_count = atomic_inc_return(&core_dump_count);
 		if (core_pipe_limit && (core_pipe_limit < dump_count)) {
-			printk(KERN_WARNING "Pid %d(%s) over core_pipe_limit\n",
-			       task_tgid_vnr(current), current->comm);
-			printk(KERN_WARNING "Skipping core dump\n");
+			coredump_report_failure("over core_pipe_limit, skipping core dump");
 			goto fail_dropcount;
 		}
 
 		helper_argv = kmalloc_array(argc + 1, sizeof(*helper_argv),
 					    GFP_KERNEL);
 		if (!helper_argv) {
-			printk(KERN_WARNING "%s failed to allocate memory\n",
-			       __func__);
+			coredump_report_failure("%s failed to allocate memory", __func__);
 			goto fail_dropcount;
 		}
 		for (argi = 0; argi < argc; argi++)
@@ -644,8 +637,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 
 		kfree(helper_argv);
 		if (retval) {
-			printk(KERN_INFO "Core dump to |%s pipe failed\n",
-			       cn.corename);
+			coredump_report_failure("|%s pipe failed", cn.corename);
 			goto close_fail;
 		}
 	} else {
@@ -658,10 +650,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 			goto fail_unlock;
 
 		if (need_suid_safe && cn.corename[0] != '/') {
-			printk(KERN_WARNING "Pid %d(%s) can only dump core "\
-				"to fully qualified path!\n",
-				task_tgid_vnr(current), current->comm);
-			printk(KERN_WARNING "Skipping core dump\n");
+			coredump_report_failure(
+				"this process can only dump core to a fully qualified path, skipping core dump");
 			goto fail_unlock;
 		}
 
@@ -730,13 +720,13 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		idmap = file_mnt_idmap(cprm.file);
 		if (!vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, inode),
 				    current_fsuid())) {
-			pr_info_ratelimited("Core dump to %s aborted: cannot preserve file owner\n",
-					    cn.corename);
+			coredump_report_failure("Core dump to %s aborted: "
+				"cannot preserve file owner", cn.corename);
 			goto close_fail;
 		}
 		if ((inode->i_mode & 0677) != 0600) {
-			pr_info_ratelimited("Core dump to %s aborted: cannot preserve file permissions\n",
-					    cn.corename);
+			coredump_report_failure("Core dump to %s aborted: "
+				"cannot preserve file permissions", cn.corename);
 			goto close_fail;
 		}
 		if (!(cprm.file->f_mode & FMODE_CAN_WRITE))
@@ -757,7 +747,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		 * have this set to NULL.
 		 */
 		if (!cprm.file) {
-			pr_info("Core dump to |%s disabled\n", cn.corename);
+			coredump_report_failure("Core dump to |%s disabled", cn.corename);
 			goto close_fail;
 		}
 		if (!dump_vma_snapshot(&cprm))
@@ -983,11 +973,10 @@ void validate_coredump_safety(void)
 {
 	if (suid_dumpable == SUID_DUMP_ROOT &&
 	    core_pattern[0] != '/' && core_pattern[0] != '|') {
-		pr_warn(
-"Unsafe core_pattern used with fs.suid_dumpable=2.\n"
-"Pipe handler or fully qualified core dump path required.\n"
-"Set kernel.core_pattern before fs.suid_dumpable.\n"
-		);
+
+		coredump_report_failure("Unsafe core_pattern used with fs.suid_dumpable=2: "
+			"pipe handler or fully qualified core dump path required. "
+			"Set kernel.core_pattern before fs.suid_dumpable.");
 	}
 }
 
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 0904ba010341..45e598fe3476 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -43,8 +43,30 @@ extern int dump_align(struct coredump_params *cprm, int align);
 int dump_user_range(struct coredump_params *cprm, unsigned long start,
 		    unsigned long len);
 extern void do_coredump(const kernel_siginfo_t *siginfo);
+
+/*
+ * Logging for the coredump code, ratelimited.
+ * The TGID and comm fields are added to the message.
+ */
+
+#define __COREDUMP_PRINTK(Level, Format, ...) \
+	do {	\
+		char comm[TASK_COMM_LEN];	\
+	\
+		get_task_comm(comm, current);	\
+		printk_ratelimited(Level "coredump: %d(%*pE): " Format "\n",	\
+			task_tgid_vnr(current), (int)strlen(comm), comm, ##__VA_ARGS__);	\
+	} while (0)	\
+
+#define coredump_report(fmt, ...) __COREDUMP_PRINTK(KERN_INFO, fmt, ##__VA_ARGS__)
+#define coredump_report_failure(fmt, ...) __COREDUMP_PRINTK(KERN_WARNING, fmt, ##__VA_ARGS__)
+
 #else
 static inline void do_coredump(const kernel_siginfo_t *siginfo) {}
+
+#define coredump_report(...)
+#define coredump_report_failure(...)
+
 #endif
 
 #if defined(CONFIG_COREDUMP) && defined(CONFIG_SYSCTL)
-- 
2.45.2


