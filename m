Return-Path: <linux-fsdevel+bounces-30076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4CE985D5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 15:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AE3B1F27C0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 13:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14481E0B7F;
	Wed, 25 Sep 2024 12:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n20ruq78"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EE01E0B6F;
	Wed, 25 Sep 2024 12:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265801; cv=none; b=izHQx0wpYlOLlONmY05837ScQUGBxqobI7d4jLNqLc9foroaPgMoSgTcTjjiDQe2I/xSk/GQr5sN0k1MASmXMuM5Hr1b6qepQToBuqriJnJw15iYptWD03JK75KUi+zRjpMuhNmd3fg14brd4O7oT+OcrHQQ/eTOTo6+R0QOpkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265801; c=relaxed/simple;
	bh=00T0XKO50BgBtINzLUeeDRmPfFmeXkj7Q+63BH4yxLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tt41U9JDDiwUZ4o+ZCWLT0phsFDGk+y3O0THPY4Ztx51HKvxJcast2X/1s37pRuN+ivZ5EcbFA3xXe2rMEbIlQUKOkMpFyFJ4FcY6/tl59TP7HA9E1aFvT9skDQKGMQCdX7/0KgEQIZiuNowazYa/qRpZIoyv6KMco4dOBWFIFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n20ruq78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB48C4CEC7;
	Wed, 25 Sep 2024 12:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265800;
	bh=00T0XKO50BgBtINzLUeeDRmPfFmeXkj7Q+63BH4yxLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n20ruq78QO9rhc4gAkC5/kUw8rk4XOAFoGD81ueWOGot8ZXlR2HKQ8jkKnVLjcK1J
	 mUtP0siIfiAR38CRJyKsyLX4lm4j7Tf8xAZ4vvNo48q3toXnHj9zCejIOWHDwLc1++
	 6/N6/K2spkrUquMfVDyYULXJm9eFGXhbXdRkRLn8+xbiZOLDHH51sZAZZjyMBlajDk
	 9sQYL8PSnnV6L/rVDZcJfHSAVnk7MUlFwEae3/aD1gRZnxINx40316k38bVgVMtENV
	 o5WTV1TyG9lF1D6u9PdhB6AxsMZdV44kIXzJgZrzw1Y0z8dpEBP+Ygs0zElMBcY0hc
	 UUSYJ9X9zHQnw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roman Kisel <romank@linux.microsoft.com>,
	Allen Pais <apais@linux.microsoft.com>,
	Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	nagvijay@microsoft.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 101/197] coredump: Standartize and fix logging
Date: Wed, 25 Sep 2024 07:52:00 -0400
Message-ID: <20240925115823.1303019-101-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Roman Kisel <romank@linux.microsoft.com>

[ Upstream commit c114e9948c2b6a0b400266e59cc656b59e795bca ]

The coredump code does not log the process ID and the comm
consistently, logs unescaped comm when it does log it, and
does not always use the ratelimited logging. That makes it
harder to analyze logs and puts the system at the risk of
spamming the system log incase something crashes many times
over and over again.

Fix that by logging TGID and comm (escaped) consistently and
using the ratelimited logging always.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Tested-by: Allen Pais <apais@linux.microsoft.com>
Link: https://lore.kernel.org/r/20240718182743.1959160-2-romank@linux.microsoft.com
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/coredump.c            | 43 +++++++++++++++-------------------------
 include/linux/coredump.h | 22 ++++++++++++++++++++
 2 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index a57a06b80f571..19d3343b93c6b 100644
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
index 0904ba010341a..45e598fe34766 100644
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
2.43.0


