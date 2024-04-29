Return-Path: <linux-fsdevel+bounces-18134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC88D8B5FF8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7491C20912
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACFA86658;
	Mon, 29 Apr 2024 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IxToBezp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D2A85C62;
	Mon, 29 Apr 2024 17:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714411302; cv=none; b=s1Z0BHDYB3yWshcmOz9hqAvojNFew6kSuTrBN2mKhcU8XGK0nqCiB+HSvh3L53+alIScNDciNwmyVvCcN0eoR1u85aAw3ybzU1Nt+YUGs3RbbECOrsLChnZqe0UqshO5NtqvaHY0s97qGjuDllA7wR+cFLLOyn71yvkSgUiWMk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714411302; c=relaxed/simple;
	bh=JFGjpoqRM4aJhNpya/IJJg82GCFmJlYc/LsE0Egd+NM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=aLCTtjWAmZHD7dOgH3HDTO12ywWf4ZoJEiFeA87jOUsW6yf73WaHcqbZeWHLPGJsqZYf3ZnmE8LbHM4s9ZHq1djESkuYDm6Z6St+qZLEKd6HZYbGABwhKA3Zmo7FAMePtvrEddi1FGBFvPahDTQZ+cl+PUoJvPlfP/o0KnN64Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IxToBezp; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from apais-vm1.0synte4vioeebbvidf5q0vz2ua.xx.internal.cloudapp.net (unknown [52.183.86.224])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7E699210EF5F;
	Mon, 29 Apr 2024 10:21:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7E699210EF5F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1714411295;
	bh=jBH8AhHdJPWgCtslcMAO+aZioWiiZfizHaoFD7DZLNQ=;
	h=From:To:Cc:Subject:Date:From;
	b=IxToBezpHlKHGPPV9I2Ofu9C2YHjwlY1hCUnsXFGvNS4nhnIyo1ZBKuBdWdbOj8oc
	 bTXBhIw2mwe7cig+Mj1Mwa6Fh9e8zKjYsQkIIGu4p8bv2oeHVoRcLDXqzMz6QPVlc7
	 +/6Xoo1kzEfGp3Vsf4QZ3NBhPWU2mch/uMc3hbJ4=
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
Subject: [RFC PATCH] fs/coredump: Enable dynamic configuration of max file note size
Date: Mon, 29 Apr 2024 17:21:28 +0000
Message-Id: <20240429172128.4246-1-apais@linux.microsoft.com>
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
- Define `max_file_note_size` in `fs/coredump.c` with an initial value set to 4MB.
- Declare `max_file_note_size` as an external variable in `include/linux/coredump.h`.
- Add a new sysctl entry in `kernel/sysctl.c` to manage this setting at runtime.

$ sysctl -a | grep max_file_note_size
kernel.max_file_note_size = 4194304

$ sysctl -n kernel.max_file_note_size
4194304

$echo 519304 > /proc/sys/kernel/max_file_note_size

$sysctl -n kernel.max_file_note_size
519304

Signed-off-by: Vijay Nag <nagvijay@microsoft.com>
Signed-off-by: Allen Pais <apais@linux.microsoft.com>
---
 fs/binfmt_elf.c          | 3 +--
 fs/coredump.c            | 3 +++
 include/linux/coredump.h | 1 +
 kernel/sysctl.c          | 8 ++++++++
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 5397b552fbeb..5fc7baa9ebf2 100644
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
+	if (size >= max_file_note_size) /* paranoia check */
 		return -EINVAL;
 	size = round_up(size, PAGE_SIZE);
 	/*
diff --git a/fs/coredump.c b/fs/coredump.c
index be6403b4b14b..a83c6cc893fc 100644
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
+unsigned int max_file_note_size = MAX_FILE_NOTE_SIZE;
 
 struct core_name {
 	char *corename;
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index d3eba4360150..e1ae7ab33d76 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -46,6 +46,7 @@ static inline void do_coredump(const kernel_siginfo_t *siginfo) {}
 #endif
 
 #if defined(CONFIG_COREDUMP) && defined(CONFIG_SYSCTL)
+extern unsigned int max_file_note_size;
 extern void validate_coredump_safety(void);
 #else
 static inline void validate_coredump_safety(void) {}
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 81cc974913bb..80cdc37f2fa2 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -63,6 +63,7 @@
 #include <linux/mount.h>
 #include <linux/userfaultfd_k.h>
 #include <linux/pid.h>
+#include <linux/coredump.h>
 
 #include "../lib/kstrtox.h"
 
@@ -1623,6 +1624,13 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
+	{
+		.procname       = "max_file_note_size",
+		.data           = &max_file_note_size,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec,
+	},
 #ifdef CONFIG_PROC_SYSCTL
 	{
 		.procname	= "tainted",
-- 
2.17.1


