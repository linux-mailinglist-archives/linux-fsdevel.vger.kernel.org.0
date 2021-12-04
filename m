Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5734683D3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Dec 2021 10:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384571AbhLDJ4v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Dec 2021 04:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384552AbhLDJ4g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Dec 2021 04:56:36 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A2CC061354;
        Sat,  4 Dec 2021 01:53:11 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id q17so3760108plr.11;
        Sat, 04 Dec 2021 01:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7KNky9vHErqn9OL9wm+gliP7fCGte3KeREk90aKC+mg=;
        b=qsHK5Wp3DDnxrHGKr78oHp3IvG22FXMQ6WLWibND/E4BbWM4VRjvkAOOeDurq/WY2z
         fOAeQgN/6YWcrKHrMoT2GS3f/Mc7fS1YBcI7oD9q/GKw3m0e4Gr7c3s5n9lB2VkrNMed
         UtdMn06egm/MpTXviwqTxAIO6ehe3o5MT9YHEmmQK93GlVRGSN/qnBnuwpCcK3S2inJR
         sNVFHTPd4HdI4Szm8nxVoxpw6iVU0r3IcOYsT4R/5ZyjNtEvX64EtfZ9S8u1M/a9WdG0
         7yz9zKW0X0SDPHB1FlCbkCy7K4rbSCIL3m6c7UPYgDAJtWjwtq1TMgbS7AcjwwbYPHSl
         mbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7KNky9vHErqn9OL9wm+gliP7fCGte3KeREk90aKC+mg=;
        b=zSEZHAhQHQpZKUaHANXO/F9I8zQi+amMr6JWTrJIdO6XvpdUSYkosnXXmxYKCL3bLB
         Sruont0ReO2xUeXdTjFsReJ18D82xjh88kxxEs93hQbesTQJ6N4oJfFTLHnRjp5eFqyp
         4EyufUQjfytPKcHMmz0cAN54483gJgl45AyBe1adzzRcqY2r1kRnNOhubi5C4NNo8wfC
         9437Z/agu5q3ghymwruuX3ckumBzYzJ1Nd/U/SUtMk7HeeYbo50hfavFm5WfZZoD08tF
         paL+CMcFdUwSXpHUurYVOjUkAIFSvceMUeznOpguUKpJuW/v9Zgbl7BZDuAxCZAdxiLu
         9LSg==
X-Gm-Message-State: AOAM530Bh3+bKkpusFCGI0fMaabMRn5g3ikBdk0iC4sGOQIjrwiQz2Vi
        GK+GoqohntpqdY4vzotyOx0=
X-Google-Smtp-Source: ABdhPJwqg6pKyGYMoMdlo2j7xJDfBIjTYhK1gMRW2j6TUtLmctuFv3TisafzMoi0MWS2K97dkPcYqQ==
X-Received: by 2002:a17:902:bcc4:b0:141:bfc4:ada with SMTP id o4-20020a170902bcc400b00141bfc40adamr28918047pls.20.1638611590852;
        Sat, 04 Dec 2021 01:53:10 -0800 (PST)
Received: from vultr.guest ([45.76.74.237])
        by smtp.gmail.com with ESMTPSA id ms15sm4343198pjb.26.2021.12.04.01.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 01:53:10 -0800 (PST)
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
Subject: [PATCH -mm 3/5] samples/bpf/tracex2: replace hard-coded 16 with TASK_COMM_LEN
Date:   Sat,  4 Dec 2021 09:52:54 +0000
Message-Id: <20211204095256.78042-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211204095256.78042-1-laoar.shao@gmail.com>
References: <20211204095256.78042-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The comm used in tracex2 should have the same size with the comm in
task_struct, we'd better define the size of it as TASK_COMM_LEN to make it
more grepable.

linux/sched.h can be included in tracex2 kernel code, but it can't be
included in tracex2 userspace code. So a new marco TASK_COMM_LEN is
defined in tracex2 userspace code.

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
 samples/bpf/tracex2_kern.c | 3 ++-
 samples/bpf/tracex2_user.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/samples/bpf/tracex2_kern.c b/samples/bpf/tracex2_kern.c
index 5bc696bac27d..51dbaf765cd5 100644
--- a/samples/bpf/tracex2_kern.c
+++ b/samples/bpf/tracex2_kern.c
@@ -7,6 +7,7 @@
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
 #include <linux/version.h>
+#include <linux/sched.h>
 #include <uapi/linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
@@ -65,7 +66,7 @@ static unsigned int log2l(unsigned long v)
 }
 
 struct hist_key {
-	char comm[16];
+	char comm[TASK_COMM_LEN];
 	u64 pid_tgid;
 	u64 uid_gid;
 	u64 index;
diff --git a/samples/bpf/tracex2_user.c b/samples/bpf/tracex2_user.c
index 1626d51dfffd..b728a946d83d 100644
--- a/samples/bpf/tracex2_user.c
+++ b/samples/bpf/tracex2_user.c
@@ -12,6 +12,7 @@
 
 #define MAX_INDEX	64
 #define MAX_STARS	38
+#define TASK_COMM_LEN	16
 
 /* my_map, my_hist_map */
 static int map_fd[2];
@@ -28,7 +29,7 @@ static void stars(char *str, long val, long max, int width)
 }
 
 struct task {
-	char comm[16];
+	char comm[TASK_COMM_LEN];
 	__u64 pid_tgid;
 	__u64 uid_gid;
 };
-- 
2.17.1

