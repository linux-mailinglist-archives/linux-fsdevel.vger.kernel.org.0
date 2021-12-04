Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256084683CA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Dec 2021 10:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384554AbhLDJ4g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Dec 2021 04:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244915AbhLDJ4e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Dec 2021 04:56:34 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A49AC061751;
        Sat,  4 Dec 2021 01:53:08 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so6617200pjb.1;
        Sat, 04 Dec 2021 01:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GW6b3sF6GwXHhqR55kptdOe2KtH0uXmQ535WwxRDhsU=;
        b=eX8Wa48ra4eTAbUzCOJnNU1tZ8LQ+5YwkjMF4cC9JNp6JnMctLCfNTRZ7InZ0I+Qgw
         FVfECKW4F52lrzjt3vh137DZkIUoY7hB47gSfr/K9H2QoqO7465U7lEdZiIizj/JYnFk
         bRoRZO41cYRH7VnyoUgkvvtsKAQWU5ZI23WV9EZiRrldtZERlW98OTwXF+tHGZgWjmMX
         VZ8ZbEgTX590IeapTCgsueZoPBhgDl+0oMTt7QfPhE5JvJ06Zi4kfRFyaSkQQ/Ajklu3
         uz1hArULEkefVEcgnMPS3o8gHsHiWGlBc4of8r6zd0yOpf6s9sWt4D2fMJk6/PdQTdMu
         e0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GW6b3sF6GwXHhqR55kptdOe2KtH0uXmQ535WwxRDhsU=;
        b=IHSusJ8GRLwrwVxCP2Xd+eBdkshxcH5YbO12hNGUURRhiMOwocHRsDjebRmfBSCLHW
         dRsTSQGZ/BE/l7PSWQJcZ0M4ge60ijyLnTL/HVy/SAS/2Xq0BSBNzd5Q1q0E4ii+Yijv
         +lTSQ8wX9BAcYsyLBIIMAMzB+ZVBcPk4+dOUXyrYkEwTETbfeGkppHVtyCAG+uAMl5dF
         zuf+1eR+M2+RtK8jdFgoz55IG14S6NvqIq6XMiAPI/S7UH517qilQJ60MVAMRraLcP4p
         x6oMv+oRFoCtmAKoGzG51/OKlUxE8GLPSMBJd6hQiI47aFxSgtpCzLgRlfeyHoPNhyOX
         f8kA==
X-Gm-Message-State: AOAM532+pYFK6n+NCJ+qxDRi/Aq+zHqDGUu6wL3ttu/ze3WjqipIoKv1
        rTsK0j7YcH+hRjj9mErWz0I=
X-Google-Smtp-Source: ABdhPJw12fabYSRxUnXmqlFx9H8BClcqkjFEXyD2Xgc+LCeTuaPuNjEU+nngQzdL92YKIn8kJzo0XA==
X-Received: by 2002:a17:903:18d:b0:142:8ab:d11f with SMTP id z13-20020a170903018d00b0014208abd11fmr29233302plg.47.1638611588164;
        Sat, 04 Dec 2021 01:53:08 -0800 (PST)
Received: from vultr.guest ([45.76.74.237])
        by smtp.gmail.com with ESMTPSA id ms15sm4343198pjb.26.2021.12.04.01.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 01:53:07 -0800 (PST)
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
Subject: [PATCH -mm 1/5] elfcore: replace old hard-code 16 with TASK_COMM_LEN_16
Date:   Sat,  4 Dec 2021 09:52:52 +0000
Message-Id: <20211204095256.78042-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211204095256.78042-1-laoar.shao@gmail.com>
References: <20211204095256.78042-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A new macro TASK_COMM_LEN_16 is introduced for the old hard-coded 16 to
make it more grepable. As explained above this marco, the difference
between TASK_COMM_LEN and TASK_COMM_LEN_16 is that TASK_COMM_LEN_16 must
be a fixed size 16 and can't be changed.

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
 include/linux/elfcore-compat.h | 8 ++------
 include/linux/elfcore.h        | 9 ++-------
 include/linux/sched.h          | 5 +++++
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/include/linux/elfcore-compat.h b/include/linux/elfcore-compat.h
index 54feb64e9b5d..69fa1a728964 100644
--- a/include/linux/elfcore-compat.h
+++ b/include/linux/elfcore-compat.h
@@ -5,6 +5,7 @@
 #include <linux/elf.h>
 #include <linux/elfcore.h>
 #include <linux/compat.h>
+#include <linux/sched.h>
 
 /*
  * Make sure these layouts match the linux/elfcore.h native definitions.
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
diff --git a/include/linux/sched.h b/include/linux/sched.h
index c79bd7ee6029..8d963a50a2a8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -279,6 +279,11 @@ struct task_group;
  * BPF programs.
  */
 enum {
+	/*
+	 * For the old hard-coded 16, which is exposed to userspace and can't
+	 * be changed.
+	 */
+	TASK_COMM_LEN_16 = 16,
 	TASK_COMM_LEN = 16,
 };
 
-- 
2.17.1

