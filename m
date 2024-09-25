Return-Path: <linux-fsdevel+bounces-30080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADC6985F50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 15:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31192B2DACE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 13:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9E315884D;
	Wed, 25 Sep 2024 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nx6WfQKi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29C3220FC5;
	Wed, 25 Sep 2024 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266505; cv=none; b=d+B/TSJgnqkeLIV1v3KfQmSEVG4sHTDd29SIm2bvA6i+g7mJqilYG6C6sYlp3HQkZJW/2FoK6LHjny6zH0dWPP2Cap/I7G8MregOHzMNDcUnkoGymrikT5D5yPeidjjGPx1vmgPdppG/WqYEurntzI4Gio20iBe2gVVyGqu9Sy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266505; c=relaxed/simple;
	bh=RLnAnqgkxxWhHBmmluAbdBNsGy1I8W8V56sX8SNEnHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WX+GF/EzJNNzWfhbyqqH79Tel3KhRT8RgJYtk+L2SfeDh9I/diXBK7oAF4X7CpK27qY+2mRJpI2U4CnEk8ZxzV+GAqVE9MsnkY0BNn/UiE31ki1/n584VnzHNdhLtf/Hh0alI4cdg+chusroFkZQGvbyXakrlDvs6m/nQNDvTXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nx6WfQKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2018BC4CEC3;
	Wed, 25 Sep 2024 12:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266505;
	bh=RLnAnqgkxxWhHBmmluAbdBNsGy1I8W8V56sX8SNEnHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nx6WfQKiWs1TM6FmUQ9UQxfi9xpPb0ACLFuhKt9FcaXuLMTnb2srVHzulOU72jVv2
	 P67ECEVWxGv4PL8vqwUlZG+GaMqWFaiPVJYbBmX09CnkwkIi/RayDxOqyYwZztNiuC
	 UiUKXtKkkWSPm7OGuSISzG0/BNPFp4WcF360tIjUm7eiojnOp7fmyYx128bujutQ+U
	 l/AgNQRxvrwLu2MFrDken0H2zAScBvZLV8vss67NDEEg2NhYLeQbrykeB41/lmPqDK
	 7FjpG2IEyxlQjZ2Sid+D7EdXhbS3uNE9G1zDOZmOXWlIa0Gn96S0evMNMeqqf92Do6
	 LZUoQHWkmlENA==
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
Subject: [PATCH AUTOSEL 6.6 076/139] coredump: Standartize and fix logging
Date: Wed, 25 Sep 2024 08:08:16 -0400
Message-ID: <20240925121137.1307574-76-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
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
index 9d235fa14ab98..9846b4d06c3dd 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -583,8 +583,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		struct subprocess_info *sub_info;
 
 		if (ispipe < 0) {
-			printk(KERN_WARNING "format_corename failed\n");
-			printk(KERN_WARNING "Aborting core\n");
+			coredump_report_failure("format_corename failed, aborting core");
 			goto fail_unlock;
 		}
 
@@ -604,27 +603,21 @@ void do_coredump(const kernel_siginfo_t *siginfo)
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
@@ -641,8 +634,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 
 		kfree(helper_argv);
 		if (retval) {
-			printk(KERN_INFO "Core dump to |%s pipe failed\n",
-			       cn.corename);
+			coredump_report_failure("|%s pipe failed", cn.corename);
 			goto close_fail;
 		}
 	} else {
@@ -655,10 +647,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
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
 
@@ -727,13 +717,13 @@ void do_coredump(const kernel_siginfo_t *siginfo)
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
@@ -754,7 +744,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		 * have this set to NULL.
 		 */
 		if (!cprm.file) {
-			pr_info("Core dump to |%s disabled\n", cn.corename);
+			coredump_report_failure("Core dump to |%s disabled", cn.corename);
 			goto close_fail;
 		}
 		if (!dump_vma_snapshot(&cprm))
@@ -941,11 +931,10 @@ void validate_coredump_safety(void)
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
index d3eba43601508..f897de8ccea8c 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -41,8 +41,30 @@ extern int dump_align(struct coredump_params *cprm, int align);
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


