Return-Path: <linux-fsdevel+bounces-18508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2538B9D0D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 17:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29DFA1C22CAD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 15:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A2A15AAD5;
	Thu,  2 May 2024 15:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kLpxbUQM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC21A1552EE;
	Thu,  2 May 2024 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714662498; cv=none; b=c0lwOCXvpnwfxMsdXg3V/G7lkUq3A1NHvBh1TgPrS5SZ8YM3vGrF3CD2KgD3yFfi/HDzfAGcKfZpNx3fpcrL1hwlDmo83E8VYDeCmBf4AtJyyJcFBxHZvWFASRok5uruolq7EtHPWO2G67LuX8mTluxFSWRsxmca/RKwemr1Ro0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714662498; c=relaxed/simple;
	bh=vqe6bqVfksmhA3Dv0sGQ+VBpqTfUtbHpQ4u1lvvVW/k=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Ch13iceUqkf78i/rzxfNYBXd3JoF+yo4kSMYGHCeWO3Bxs1RWbmqH6CRSZjdhkRIsoZmzj7OF8jptECzuy/Gjqbhn4p0EZXcbiiC8sR+AqvCGanKoUtOoxYTRGD15p2cjaDbESkxp/O0df9tsM5EkUvlkuyAt8nlDLcTmzAOhM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kLpxbUQM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from apais-vm1.0synte4vioeebbvidf5q0vz2ua.xx.internal.cloudapp.net (unknown [52.183.86.224])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4E46E20B2C80;
	Thu,  2 May 2024 07:59:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4E46E20B2C80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1714661965;
	bh=emptab7+3YFMG1SQMC0wFEdq7q5l4lpPKpITnuC0zJg=;
	h=From:To:Cc:Subject:Date:From;
	b=kLpxbUQM6vgG2iRx6mGF27Bwzlq2ikZH0BIuBoKzsQ0i7ds67Lu5X4A7WWApGpM7I
	 uXdh2D8hr8mXwvd2AM9XSyAxcCX3NtWB6bQiN+RFltl5adKQ5Ht6BPHpEgj0du8fAX
	 JEZ8PEm5s2jkhU5eJFIac47yXgch+NYOIJIcwj1E=
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
	j.granados@samsung.com
Subject: [PATCH v2] fs/coredump: Enable dynamic configuration of max file note size
Date: Thu,  2 May 2024 14:59:20 +0000
Message-Id: <20240502145920.5011-1-apais@linux.microsoft.com>
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

$ sysctl -a | grep max_file_note_size
kernel.max_file_note_size = 4194304

$ sysctl -n kernel.max_file_note_size
4194304

$echo 519304 > /proc/sys/kernel/max_file_note_size

$sysctl -n kernel.max_file_note_size
519304

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
Changes in v2:
   - Move new sysctl to fs/coredump.c [Luis & Kees]
   - rename max_file_note_size to core_file_note_size_max [kees]
   - Capture "why this is being done?" int he commit message [Luis & Kees]
---
 fs/binfmt_elf.c          |  3 +--
 fs/coredump.c            | 10 ++++++++++
 include/linux/coredump.h |  1 +
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 5397b552fbeb..6aebd062b92b 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1564,7 +1564,6 @@ static void fill_siginfo_note(struct memelfnote *note, user_siginfo_t *csigdata,
 	fill_note(note, "CORE", NT_SIGINFO, sizeof(*csigdata), csigdata);
 }
 
-#define MAX_FILE_NOTE_SIZE (4*1024*1024)
 /*
  * Format of NT_FILE note:
  *
@@ -1592,7 +1591,7 @@ static int fill_files_note(struct memelfnote *note, struct coredump_params *cprm
 
 	names_ofs = (2 + 3 * count) * sizeof(data[0]);
  alloc:
-	if (size >= MAX_FILE_NOTE_SIZE) /* paranoia check */
+	if (size >= core_file_note_size_max) /* paranoia check */
 		return -EINVAL;
 	size = round_up(size, PAGE_SIZE);
 	/*
diff --git a/fs/coredump.c b/fs/coredump.c
index be6403b4b14b..a312be48030f 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -56,10 +56,13 @@
 static bool dump_vma_snapshot(struct coredump_params *cprm);
 static void free_vma_snapshot(struct coredump_params *cprm);
 
+#define MAX_FILE_NOTE_SIZE (4*1024*1024)
+
 static int core_uses_pid;
 static unsigned int core_pipe_limit;
 static char core_pattern[CORENAME_MAX_SIZE] = "core";
 static int core_name_size = CORENAME_MAX_SIZE;
+unsigned int core_file_note_size_max = MAX_FILE_NOTE_SIZE;
 
 struct core_name {
 	char *corename;
@@ -1020,6 +1023,13 @@ static struct ctl_table coredump_sysctls[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
+	{
+		.procname       = "core_file_note_size_max",
+		.data           = &core_file_note_size_max,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = proc_douintvec,
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


