Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80C4479EF2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Dec 2021 04:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhLSDDV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Dec 2021 22:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhLSDDU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Dec 2021 22:03:20 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CDAC061574;
        Sat, 18 Dec 2021 19:03:20 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gj24so5954727pjb.0;
        Sat, 18 Dec 2021 19:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DoHxgraNwchjmQ3Foa7UMkDxGQIGhMw2Lx+0ONxhfqY=;
        b=RzVzt73CTOKi1KaKzpHYyei5faX2GrgI9r7ZQnCHcKxxYvmsX27CcPBvTR0wWVK1k7
         lIdb6lFSTCGgaSZrA5VyxysI01Slj5F4nBgUoJwwj4KQfsfn8VFwFTSwGP+7ijRhlTwZ
         Wu9ZuxobL124j77yBXQlj4C5fXiacnEgcehqNUvyksjMzdBXOfzST5NJ8S2U71DbOOMC
         f7b4yiV0w0NX3SRLX9d2N0F9lCrs+KDKUbqRDkwmsHMICSMRdYR5rJ229cYdoT6fOcvv
         u02bDusRk1m7A2IUxmSrOpxxWTAt9QcmP5VB8KY10P/yrIicvh3RzRDkZ+s1Zpps/qrC
         NVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DoHxgraNwchjmQ3Foa7UMkDxGQIGhMw2Lx+0ONxhfqY=;
        b=NSS5UmnQorWOvjXBUi8TL9DfTOcECnRHcyN0Lqg4WpZ94TKRPrJV4x8WVf9St5B6ur
         IRMPe9dNCPIgJGZCrsYX3rvmpjZSDjILMe7LXlT+F5oB1PQeZ0Ap1hFHJuc5qCZrz3im
         FjKV/+Z/4P618ZvvkvAEW/nSBRhWPYs6bxJHwA15BuGr508+GwpgpCCDx6oZihPkUqca
         bw9uszwwnvYH/cHyeObi1Ces/LdtK5euYJUm2nelok5XkU2teWvl/87c9GvPSEnJxVgM
         imxSAfbkoK0TQuUkmivtSNbV+yZL/pUyuDdaeTcveDJa7x9+o/W7RQ5zMCUyzdiCeeqN
         P78g==
X-Gm-Message-State: AOAM530TIdHSx+ywl5A9Je0xCqQfz5pvykGMFzuu9Zfn2QXzsmR5Jxs2
        anbc89+N8CkbECPhbL1tIqBiXO/Xxvg=
X-Google-Smtp-Source: ABdhPJyQIYSOuo+Acd4lT12T3KQV/ROU3csTNxsNAD5bRAOL+B30pzE963VFDwrlScOfxQ9dOyPkhA==
X-Received: by 2002:a17:902:da8d:b0:142:4fa:9147 with SMTP id j13-20020a170902da8d00b0014204fa9147mr10477947plx.72.1639883000135;
        Sat, 18 Dec 2021 19:03:20 -0800 (PST)
Received: from vultr.guest ([45.76.74.237])
        by smtp.gmail.com with ESMTPSA id h191sm12604333pge.55.2021.12.18.19.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 19:03:19 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     akpm@linux-foundation.org, rostedt@goodmis.org,
        keescook@chromium.org, pmladek@suse.com, david@redhat.com,
        arnaldo.melo@gmail.com, andrii.nakryiko@gmail.com
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH -mm v3] replace old hard-coded 16 with TASK_COMM_LEN_16
Date:   Sun, 19 Dec 2021 03:02:58 +0000
Message-Id: <20211219030258.14738-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the followup work of task comm cleanups[1].

A new macro TASK_COMM_LEN_16 is introduced to replace old hard-coded 16
in various files, in order to make them grepable. The difference between
TASK_COMM_LEN and TASK_COMM_LEN_16 is:
- TASK_COMM_LEN
  The size should be same with the TASK_COMM_LEN defined in linux/sched.h.
- TASK_COMM_LEN_16
  The size must be a fixed-size 16 no matter what TASK_COMM_LEN is. The
  usage around it is exposed to userspace, so this macro is defined in
  the UAPI header.

[1]. https://lore.kernel.org/lkml/20211120112738.45980-1-laoar.shao@gmail.com/

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Michal Miroslaw <mirq-linux@rere.qmqm.pl>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Kees Cook <keescook@chromium.org>
Cc: Petr Mladek <pmladek@suse.com>

---
Changes since v2:
- make TASK_COMM_LEN_16 a single instance (Michal)
- merge all the patches into a single patch

Changes since v1:
- use TASK_COMM_LEN_16 instead of TASK_COMM_LEN in patch #3 (Steven)
- avoid changing samples/bpf and bpf/progs (Alexei)
---
 include/linux/elfcore-compat.h    | 8 ++------
 include/linux/elfcore.h           | 9 ++-------
 include/uapi/linux/cn_proc.h      | 3 ++-
 include/uapi/linux/sched.h        | 7 +++++++
 tools/include/uapi/linux/sched.h  | 7 +++++++
 tools/perf/tests/evsel-tp-sched.c | 7 ++++---
 6 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/include/linux/elfcore-compat.h b/include/linux/elfcore-compat.h
index 54feb64e9b5d..319daa69bb23 100644
--- a/include/linux/elfcore-compat.h
+++ b/include/linux/elfcore-compat.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_ELFCORE_COMPAT_H
 #define _LINUX_ELFCORE_COMPAT_H
 
+#include <uapi/linux/sched.h>
 #include <linux/elf.h>
 #include <linux/elfcore.h>
 #include <linux/compat.h>
@@ -43,12 +44,7 @@ struct compat_elf_prpsinfo
 	__compat_uid_t			pr_uid;
 	__compat_gid_t			pr_gid;
 	compat_pid_t			pr_pid, pr_ppid, pr_pgrp, pr_sid;
-	/*
-	 * The hard-coded 16 is derived from TASK_COMM_LEN, but it can't be
-	 * changed as it is exposed to userspace. We'd better make it hard-coded
-	 * here.
-	 */
-	char				pr_fname[16];
+	char				pr_fname[TASK_COMM_LEN_16];
 	char				pr_psargs[ELF_PRARGSZ];
 };
 
diff --git a/include/linux/elfcore.h b/include/linux/elfcore.h
index 746e081879a5..d3bb4bd3c985 100644
--- a/include/linux/elfcore.h
+++ b/include/linux/elfcore.h
@@ -65,13 +65,8 @@ struct elf_prpsinfo
 	__kernel_gid_t	pr_gid;
 	pid_t	pr_pid, pr_ppid, pr_pgrp, pr_sid;
 	/* Lots missing */
-	/*
-	 * The hard-coded 16 is derived from TASK_COMM_LEN, but it can't be
-	 * changed as it is exposed to userspace. We'd better make it hard-coded
-	 * here.
-	 */
-	char	pr_fname[16];	/* filename of executable */
-	char	pr_psargs[ELF_PRARGSZ];	/* initial part of arg list */
+	char	pr_fname[TASK_COMM_LEN_16];	/* filename of executable */
+	char	pr_psargs[ELF_PRARGSZ];		/* initial part of arg list */
 };
 
 static inline void elf_core_copy_regs(elf_gregset_t *elfregs, struct pt_regs *regs)
diff --git a/include/uapi/linux/cn_proc.h b/include/uapi/linux/cn_proc.h
index db210625cee8..88e645230ea5 100644
--- a/include/uapi/linux/cn_proc.h
+++ b/include/uapi/linux/cn_proc.h
@@ -20,6 +20,7 @@
 #define _UAPICN_PROC_H
 
 #include <linux/types.h>
+#include "sched.h"
 
 /*
  * Userspace sends this enum to register with the kernel that it is listening
@@ -110,7 +111,7 @@ struct proc_event {
 		struct comm_proc_event {
 			__kernel_pid_t process_pid;
 			__kernel_pid_t process_tgid;
-			char           comm[16];
+			char           comm[TASK_COMM_LEN_16];
 		} comm;
 
 		struct coredump_proc_event {
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 3bac0a8ceab2..490fd5d48378 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -145,4 +145,11 @@ struct clone_args {
 			 SCHED_FLAG_KEEP_ALL		| \
 			 SCHED_FLAG_UTIL_CLAMP)
 
+/*
+ * For the one which is exposed to userspace and thus can't be changed.
+ */
+enum {
+	TASK_COMM_LEN_16 = 16,
+};
+
 #endif /* _UAPI_LINUX_SCHED_H */
diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linux/sched.h
index 3bac0a8ceab2..490fd5d48378 100644
--- a/tools/include/uapi/linux/sched.h
+++ b/tools/include/uapi/linux/sched.h
@@ -145,4 +145,11 @@ struct clone_args {
 			 SCHED_FLAG_KEEP_ALL		| \
 			 SCHED_FLAG_UTIL_CLAMP)
 
+/*
+ * For the one which is exposed to userspace and thus can't be changed.
+ */
+enum {
+	TASK_COMM_LEN_16 = 16,
+};
+
 #endif /* _UAPI_LINUX_SCHED_H */
diff --git a/tools/perf/tests/evsel-tp-sched.c b/tools/perf/tests/evsel-tp-sched.c
index cf4da3d748c2..0b74bf2ca1ce 100644
--- a/tools/perf/tests/evsel-tp-sched.c
+++ b/tools/perf/tests/evsel-tp-sched.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/err.h>
+#include <linux/sched.h>
 #include <traceevent/event-parse.h>
 #include "evsel.h"
 #include "tests.h"
@@ -43,7 +44,7 @@ static int test__perf_evsel__tp_sched_test(struct test_suite *test __maybe_unuse
 		return -1;
 	}
 
-	if (evsel__test_field(evsel, "prev_comm", 16, false))
+	if (evsel__test_field(evsel, "prev_comm", TASK_COMM_LEN_16, false))
 		ret = -1;
 
 	if (evsel__test_field(evsel, "prev_pid", 4, true))
@@ -55,7 +56,7 @@ static int test__perf_evsel__tp_sched_test(struct test_suite *test __maybe_unuse
 	if (evsel__test_field(evsel, "prev_state", sizeof(long), true))
 		ret = -1;
 
-	if (evsel__test_field(evsel, "next_comm", 16, false))
+	if (evsel__test_field(evsel, "next_comm", TASK_COMM_LEN_16, false))
 		ret = -1;
 
 	if (evsel__test_field(evsel, "next_pid", 4, true))
@@ -73,7 +74,7 @@ static int test__perf_evsel__tp_sched_test(struct test_suite *test __maybe_unuse
 		return -1;
 	}
 
-	if (evsel__test_field(evsel, "comm", 16, false))
+	if (evsel__test_field(evsel, "comm", TASK_COMM_LEN_16, false))
 		ret = -1;
 
 	if (evsel__test_field(evsel, "pid", 4, true))
-- 
2.17.1

