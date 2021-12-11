Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098F047122C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Dec 2021 07:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhLKGkF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Dec 2021 01:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhLKGkD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Dec 2021 01:40:03 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38450C061714;
        Fri, 10 Dec 2021 22:40:03 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id gt5so8332677pjb.1;
        Fri, 10 Dec 2021 22:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TZV2akOfGkMYXOBRArbqbu6dxDYcT5+TVmROYOG16l0=;
        b=TkcDmDViXI57Xnv7ZLFQNtjrEPmhhun71oUPc9lDSvrkVqzpeqhOZtev3RPN6jjz0u
         N9zpX8zdcx/Osl7dswhaP8mJz7jndE8heKd0yCnPJVUgnVPlDnBsRgF3DfOYfEGQGWjK
         j7OjirVMTUYvgtv6+63tAOqtccuw+NpRilI57jL8hh/Fi+96GlSD5yBOG/Lehh1WCyOh
         ATmUaNxeO3jK62SlOJGR2sSGglUKQbrlJIXwJtlJGCMa9fTL9D/2Pcwsih+nP3ygM6QS
         CuSo4GuUIfvp4nYHT4rx6FW5qhvP+2jqZl1Dr45tHbNSRQlu4obh0xSpGacDXuQRQ2Lj
         NrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TZV2akOfGkMYXOBRArbqbu6dxDYcT5+TVmROYOG16l0=;
        b=YQ7Oxs1BjIaXYa1ECTHR8NF+u+Egnb7vbFp36mzacPUA323wxaX5qMEtDNHjgJbM0f
         +UBFLiXZg5oGbSAavzX99tE0wC51oWbBHOzObDEGmkqxLArMQ7qI76Ode4b5eJrDynON
         JBKpD+t+aXi2e59XGbY6xP5mtmR02DDCDlC5eHfKRyQDSqKK6//iR/FWZG+0rkAsHGMa
         8O5NUOOIkVJg/vupNjCI5fs8WODtMvxkgE5mSUW88kZmbj4yETXaCx9URcFZpZNgI0s8
         MLCh1HlNCnXGeLvda8j7/1pFhLOWD1VMl0shuJVLI72hmO2RVdazZ0OnZfdhUjyzZdJH
         NFlg==
X-Gm-Message-State: AOAM532AILrYRdM3jpKSFZVDAoRpWjya/aU6+ll/hGtWylnWSQ5BlBnn
        oW41qEyd+bbKwyEFy7k6Qlw=
X-Google-Smtp-Source: ABdhPJxLChN+ADVPJ6LFYKtwALt6CHN+EQPy/Y/OCNbJZ9hpnCuwbpT+ooSoB6bQWw3XkomJn6HDOQ==
X-Received: by 2002:a17:902:e88a:b0:141:dfde:eed7 with SMTP id w10-20020a170902e88a00b00141dfdeeed7mr81576375plg.17.1639204802767;
        Fri, 10 Dec 2021 22:40:02 -0800 (PST)
Received: from vultr.guest ([45.76.74.237])
        by smtp.gmail.com with ESMTPSA id mr2sm869638pjb.25.2021.12.10.22.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 22:40:02 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     akpm@linux-foundation.org, rostedt@goodmis.org,
        keescook@chromium.org, pmladek@suse.com, david@redhat.com,
        arnaldo.melo@gmail.com, andrii.nakryiko@gmail.com,
        alexei.starovoitov@gmail.com
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH -mm v2 1/3] elfcore: replace old hard-code 16 with TASK_COMM_LEN_16
Date:   Sat, 11 Dec 2021 06:39:47 +0000
Message-Id: <20211211063949.49533-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211211063949.49533-1-laoar.shao@gmail.com>
References: <20211211063949.49533-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A new macro TASK_COMM_LEN_16 is introduced for the old hard-coded 16 to
make it more grepable. As explained above this marco, the difference
between TASK_COMM_LEN and TASK_COMM_LEN_16 is that TASK_COMM_LEN_16 must
be a fixed size 16 and can't be changed.

Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
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

