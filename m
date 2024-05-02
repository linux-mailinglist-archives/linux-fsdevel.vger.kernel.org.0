Return-Path: <linux-fsdevel+bounces-18545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A845F8BA441
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 01:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4883C1F21672
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 23:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77752158A19;
	Thu,  2 May 2024 23:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KEz01Qxj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D95158860;
	Thu,  2 May 2024 23:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714694169; cv=none; b=bXbtruAZM0L5csmXYO8GUDo0kaarG3z6FzHfeqokjWyJ1VjSVmZ6M+O0N2lKI5wM4i/Rp0LKsLQBcwNep0lgwnr2Qa1nnuSE5DN7p3DExHMuASFMjqD5OgWds+YJjhP+LMIEI6l7bvWvi8MplydVfbwAl1jv638G6cKi2Jphqmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714694169; c=relaxed/simple;
	bh=KDTPeN05M57xS2MXKydvC49uBoYhEKguBW3iE8aLQTo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=eu4wx3LJ2s99jOSGhnBqFus2YJiddQU0chIJ2VC1tSZ2nb9wKvh0gf1sU/7ob7Y3ayNxPsize1yFPEJNGcdrd3RB4/Ej4kd3IAutYWu6aCpxAoa8ARQAJ8xfKs33R3huDAvgp9kxmvTwMx3Epmvk++Pbt0XJd4nvOAAuR4pl5OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KEz01Qxj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from apais-vm1.0synte4vioeebbvidf5q0vz2ua.xx.internal.cloudapp.net (unknown [52.183.86.224])
	by linux.microsoft.com (Postfix) with ESMTPSA id 516C2206B4FD;
	Thu,  2 May 2024 16:56:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 516C2206B4FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1714694167;
	bh=0ApDPPUAUdsRc/Ls5y+zI70kXBtCixjZ+x/qjau8Og4=;
	h=From:To:Cc:Subject:Date:From;
	b=KEz01Qxj2Gpz2MBLoacRPZ8SwgTCX//O2/jmyVG8S+s22YPkRX+F8OF4H1wJ1VFjt
	 uGI+B7bpOFmIJKh6Oj7CclSJRYzfEMhybumBWn1uXhDVUKOmEqRNm4fQi9MZa6pHLB
	 UMq+yPmihLGsnHw0X6ivB5+3nABH2jmfwTMroBYI=
From: Allen Pais <apais@linux.microsoft.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	ebiederm@xmission.com,
	keescook@chromium.org,
	mcgrof@kernel.org,
	j.granados@samsung.com,
	allen.lkml@gmail.com
Subject: [PATCH v3] fs/coredump: Enable dynamic configuration of max file note size
Date: Thu,  2 May 2024 23:56:03 +0000
Message-Id: <20240502235603.19290-1-apais@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Introduce the capability to dynamically configure the maximum file
note size for ELF core dumps via sysctl. This enhancement removes
the previous static limit of 4MB, allowing system administrators to
adjust the size based on system-specific requirements or constraints.

- Remove hardcoded `MAX_FILE_NOTE_SIZE` from `fs/binfmt_elf.c`.
- Define `max_file_note_size` in `fs/coredump.c` with an initial value
  set to 4MB.
- Declare `max_file_note_size` as an external variable in
  `include/linux/coredump.h`.
- Add a new sysctl entry in `kernel/sysctl.c` to manage this setting
  at runtime.

$ sysctl -a | grep core_file_note_size_max
kernel.core_file_note_size_max = 4194304

$ sysctl -n kernel.core_file_note_size_max
4194304

$echo 519304 > /proc/sys/kernel/core_file_note_size_max

$sysctl -n kernel.core_file_note_size_max
519304

Attempting to write beyond the ceiling value of 16MB
$echo 17194304 > /proc/sys/kernel/core_file_note_size_max
bash: echo: write error: Invalid argument

Why is this being done?
We have observed that during a crash when there are more than 65k mmaps
in memory, the existing fixed limit on the size of the ELF notes section
becomes a bottleneck. The notes section quickly reaches its capacity,
leading to incomplete memory segment information in the resulting coredump.
This truncation compromises the utility of the coredumps, as crucial
information about the memory state at the time of the crash might be
omitted.

Signed-off-by: Vijay Nag <nagvijay@microsoft.com>
Signed-off-by: Allen Pais <apais@linux.microsoft.com>

---
Chagnes in v3:
   - Fix commit message to reflect the correct sysctl knob [Kees]
   - Add a ceiling for maximum pssible note size(16M) [Allen]
   - Add a pr_warn_once() [Kees]
Changes in v2:
   - Move new sysctl to fs/coredump.c [Luis & Kees]
   - rename max_file_note_size to core_file_note_size_max [kees]
   - Capture "why this is being done?" int he commit message [Luis & Kees]
---
 fs/binfmt_elf.c          |  8 ++++++--
 fs/coredump.c            | 15 +++++++++++++++
 include/linux/coredump.h |  1 +
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 5397b552fbeb..5294f8f3a9a8 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1564,7 +1564,6 @@ static void fill_siginfo_note(struct memelfnote *note, user_siginfo_t *csigdata,
 	fill_note(note, "CORE", NT_SIGINFO, sizeof(*csigdata), csigdata);
 }
 
-#define MAX_FILE_NOTE_SIZE (4*1024*1024)
 /*
  * Format of NT_FILE note:
  *
@@ -1592,8 +1591,13 @@ static int fill_files_note(struct memelfnote *note, struct coredump_params *cprm
 
 	names_ofs = (2 + 3 * count) * sizeof(data[0]);
  alloc:
-	if (size >= MAX_FILE_NOTE_SIZE) /* paranoia check */
+	/* paranoia check */
+	if (size >= core_file_note_size_max) {
+		pr_warn_once("coredump Note size too large: %u "
+		"(does kernel.core_file_note_size_max sysctl need adjustment?)\n",
+		size);
 		return -EINVAL;
+	}
 	size = round_up(size, PAGE_SIZE);
 	/*
 	 * "size" can be 0 here legitimately.
diff --git a/fs/coredump.c b/fs/coredump.c
index be6403b4b14b..ffaed8c1b3b0 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -56,10 +56,16 @@
 static bool dump_vma_snapshot(struct coredump_params *cprm);
 static void free_vma_snapshot(struct coredump_params *cprm);
 
+#define MAX_FILE_NOTE_SIZE (4*1024*1024)
+/* Define a reasonable max cap */
+#define MAX_ALLOWED_NOTE_SIZE (16*1024*1024)
+
 static int core_uses_pid;
 static unsigned int core_pipe_limit;
 static char core_pattern[CORENAME_MAX_SIZE] = "core";
 static int core_name_size = CORENAME_MAX_SIZE;
+unsigned int core_file_note_size_max = MAX_FILE_NOTE_SIZE;
+unsigned int core_file_note_size_allowed = MAX_ALLOWED_NOTE_SIZE;
 
 struct core_name {
 	char *corename;
@@ -1020,6 +1026,15 @@ static struct ctl_table coredump_sysctls[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
+	{
+		.procname       = "core_file_note_size_max",
+		.data           = &core_file_note_size_max,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler	= proc_douintvec_minmax,
+		.extra1		= &core_file_note_size_max,
+		.extra2		= &core_file_note_size_allowed,
+	},
 };
 
 static int __init init_fs_coredump_sysctls(void)
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index d3eba4360150..14c057643e7f 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -46,6 +46,7 @@ static inline void do_coredump(const kernel_siginfo_t *siginfo) {}
 #endif
 
 #if defined(CONFIG_COREDUMP) && defined(CONFIG_SYSCTL)
+extern unsigned int core_file_note_size_max;
 extern void validate_coredump_safety(void);
 #else
 static inline void validate_coredump_safety(void) {}
-- 
2.17.1


