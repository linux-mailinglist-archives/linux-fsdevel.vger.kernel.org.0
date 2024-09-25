Return-Path: <linux-fsdevel+bounces-30069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336BF985A84
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 14:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55AFF1C23846
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 12:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56DE1B6529;
	Wed, 25 Sep 2024 11:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VV6tAi9M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDF31B6520;
	Wed, 25 Sep 2024 11:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264544; cv=none; b=hNXh6/lWNpibwZMik9WjOlAyd27UdJERlctUM0Cxs+AY5Sq5TEsm5uQRs/mRPRoKLrASLImDjS3OKIvm4PD8l9zO+lI4q/3uQqJPqj4bPnurIAV1660G0lZfP3sIq4uRCwszDTVbcZed2zCGBlMUEzg5ks59aV158/kdHu/jalE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264544; c=relaxed/simple;
	bh=fS3Q/48pPvCa6bLqolJB6//mXjLbouiRJW9n8sT+kmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOex4+XkU4qgFomjjkBiB/XL1lR2jXx1uzM3aT10/h2yaL4YGObse3zCOYMHcMguj0coCxiyYe8ATkBPuij26rvUa8/KL3bNhR2ZJi5d9wgmWiGYne9KVxxeCYgcfgjUSZ/GqUbqqs5ZP/WfaJ7TGHV+c1+AcrPVsidkzs2+iFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VV6tAi9M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61CA3C4CEC3;
	Wed, 25 Sep 2024 11:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264543;
	bh=fS3Q/48pPvCa6bLqolJB6//mXjLbouiRJW9n8sT+kmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VV6tAi9MAWVQZBHcjBHWmjoZL6RhN8C41TLE1b3nPS8+TG9GbzFbDQMYpF2IFA4Sl
	 6+2rfUwoJMeAvaOY5Fv+RerFY+c+BVzah4M4o0WVK72rdHLj3h4aL8COUuEbTzV8GN
	 NpkZMAlF85v8ELwJNoh2qAF+3map16rq4ww7TOVGT32VgbpeviCtD4SeP4haYChj6+
	 eGSZ4mYK0BeC3WMVINeosOgMKZ8XlXZ7Pe/d/88c7vcOv/heSDPLk6hZt7/zMT2iRP
	 C2VQ6lneZiDx0DYtOVY602zF2w3+Zotqa/fM3PY61MOW+E1UK/DORKRv3ycynB3TCK
	 fK2gR8qQSFiQQ==
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
Subject: [PATCH AUTOSEL 6.11 118/244] coredump: Standartize and fix logging
Date: Wed, 25 Sep 2024 07:25:39 -0400
Message-ID: <20240925113641.1297102-118-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
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
index 7f12ff6ad1d3e..87ff71a59fbe7 100644
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


