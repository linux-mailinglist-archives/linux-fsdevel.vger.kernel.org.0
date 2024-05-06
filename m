Return-Path: <linux-fsdevel+bounces-18863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0DB8BD581
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 21:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4E9AB22DCF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 19:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B081115ADA3;
	Mon,  6 May 2024 19:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SN9A9aSZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBDD5FDA5;
	Mon,  6 May 2024 19:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715024228; cv=none; b=Oz/uuj0xjBmJGEW5DGSv2vCp6xasllK07nm+VRy3BDdI25mBhoSqfiuk5b99QoR1dbibi4ULqnvNFqwP+eum+VRL+3Fejn0nzAdKObZrO+KRUOU5wdrzkdtdIDwKHSCu8cjRfJpgPgaui1L6BWPsrycoarBQdaL1RxS25lgSxNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715024228; c=relaxed/simple;
	bh=nuf1f/LIwto4hj0YbCTdRsSN0gd75WgtZzepSxjtU6o=;
	h=From:To:Cc:Subject:Date:Message-Id; b=CSinMlm0dedhI9/kZxjac8ydLmVVIrWzuYY+l7sVYSk+B8XBRyuwBLP3Dh6BGPMiuAQOxBM4vjBNAuHBkX+TDmw6uoG8mTt0d3EKzogzWQLcFd0w/+hkgb57b9tSVuWKEG4BQJ7XET/9oIXwbco5ZzEWF0eLjOSMgW4ZTb9BKog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SN9A9aSZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from apais-vm1.0synte4vioeebbvidf5q0vz2ua.xx.internal.cloudapp.net (unknown [52.183.86.224])
	by linux.microsoft.com (Postfix) with ESMTPSA id 22F92207E7E3;
	Mon,  6 May 2024 12:37:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 22F92207E7E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715024226;
	bh=NSsFZUKvbcPALUhxizKrUYUWMdVfFHil/vZ8XEa5VXM=;
	h=From:To:Cc:Subject:Date:From;
	b=SN9A9aSZBeugCNzM9TEJsrc6Ukg/iTdKsFylD+xiyzzUHKf4jlR7P4D/lFIGY1+Lp
	 X33vtsOoNaANjT8rBDmFtRgVyEDDXxRlrFjH/tEJJhIm6v5An+27L8knjVYLWHIu1A
	 Tc65J0H6kl5b2rOLlO9UbI6PCa5HAqwvUUhp2I1Q=
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
Subject: [PATCH v4] fs/coredump: Enable dynamic configuration of max file note size
Date: Mon,  6 May 2024 19:37:00 +0000
Message-Id: <20240506193700.7884-1-apais@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Introduce the capability to dynamically configure the maximum file
note size for ELF core dumps via sysctl.

Why is this being done?
We have observed that during a crash when there are more than 65k mmaps
in memory, the existing fixed limit on the size of the ELF notes section
becomes a bottleneck. The notes section quickly reaches its capacity,
leading to incomplete memory segment information in the resulting coredump.
This truncation compromises the utility of the coredumps, as crucial
information about the memory state at the time of the crash might be
omitted.

This enhancement removes the previous static limit of 4MB, allowing
system administrators to adjust the size based on system-specific
requirements or constraints.

Eg:
$ sysctl -a | grep core_file_note_size_min
kernel.core_file_note_size_max = 4194304

$ sysctl -n kernel.core_file_note_size_min
4194304

$echo 519304 > /proc/sys/kernel/core_file_note_size_min

$sysctl -n kernel.core_file_note_size_min
519304

Attempting to write beyond the ceiling value of 16MB
$echo 17194304 > /proc/sys/kernel/core_file_note_size_min
bash: echo: write error: Invalid argument

Signed-off-by: Vijay Nag <nagvijay@microsoft.com>
Signed-off-by: Allen Pais <apais@linux.microsoft.com>

---
Changes in v4:
   - Rename core_file_note_size_max to core_file_note_size_min [kees]
   - Rename core_file_note_size_max to MAX_FILE_NOTE_SIZE to
     CORE_FILE_NOTE_SIZE_DEFAULT and MAX_ALLOWED_NOTE_SIZE to
     CORE_FILE_NOTE_SIZE_MAX [Kees]
   - change core_file_note_size_allowed to static and const [Kees]
Changes in v3:
   - Fix commit message to reflect the correct sysctl knob [Kees]
   - Add a ceiling for maximum pssible note size(16M) [Allen]
   - Add a pr_warn_once() [Kees]
Changes in v2:
   - Move new sysctl to fs/coredump.c [Luis & Kees]
   - rename max_file_note_size to core_file_note_size_max [kees]
   - Capture "why this is being done?" int he commit message [Luis & Kees]
---
 fs/binfmt_elf.c          |  7 +++++--
 fs/coredump.c            | 15 +++++++++++++++
 include/linux/coredump.h |  1 +
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 5397b552fbeb..4dc7eb265a97 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1564,7 +1564,6 @@ static void fill_siginfo_note(struct memelfnote *note, user_siginfo_t *csigdata,
 	fill_note(note, "CORE", NT_SIGINFO, sizeof(*csigdata), csigdata);
 }
 
-#define MAX_FILE_NOTE_SIZE (4*1024*1024)
 /*
  * Format of NT_FILE note:
  *
@@ -1592,8 +1591,12 @@ static int fill_files_note(struct memelfnote *note, struct coredump_params *cprm
 
 	names_ofs = (2 + 3 * count) * sizeof(data[0]);
  alloc:
-	if (size >= MAX_FILE_NOTE_SIZE) /* paranoia check */
+	/* paranoia check */
+	if (size >= core_file_note_size_min) {
+		pr_warn_once("coredump Note size too large: %u (does kernel.core_file_note_size_min sysctl need adjustment?\n",
+			      size);
 		return -EINVAL;
+	}
 	size = round_up(size, PAGE_SIZE);
 	/*
 	 * "size" can be 0 here legitimately.
diff --git a/fs/coredump.c b/fs/coredump.c
index be6403b4b14b..20807c3c5477 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -56,10 +56,16 @@
 static bool dump_vma_snapshot(struct coredump_params *cprm);
 static void free_vma_snapshot(struct coredump_params *cprm);
 
+#define CORE_FILE_NOTE_SIZE_DEFAULT (4*1024*1024)
+/* Define a reasonable max cap */
+#define CORE_FILE_NOTE_SIZE_MAX (16*1024*1024)
+
 static int core_uses_pid;
 static unsigned int core_pipe_limit;
 static char core_pattern[CORENAME_MAX_SIZE] = "core";
 static int core_name_size = CORENAME_MAX_SIZE;
+static const unsigned int core_file_note_size_max = CORE_FILE_NOTE_SIZE_MAX;
+unsigned int core_file_note_size_min = CORE_FILE_NOTE_SIZE_DEFAULT;
 
 struct core_name {
 	char *corename;
@@ -1020,6 +1026,15 @@ static struct ctl_table coredump_sysctls[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
+	{
+		.procname       = "core_file_note_size_min",
+		.data           = &core_file_note_size_min,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler	= proc_douintvec_minmax,
+		.extra1		= &core_file_note_size_min,
+		.extra2		= (unsigned int *) &core_file_note_size_max,
+	},
 };
 
 static int __init init_fs_coredump_sysctls(void)
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index d3eba4360150..f6be9fd2aea7 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -46,6 +46,7 @@ static inline void do_coredump(const kernel_siginfo_t *siginfo) {}
 #endif
 
 #if defined(CONFIG_COREDUMP) && defined(CONFIG_SYSCTL)
+extern unsigned int core_file_note_size_min;
 extern void validate_coredump_safety(void);
 #else
 static inline void validate_coredump_safety(void) {}
-- 
2.17.1


