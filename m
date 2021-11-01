Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA72441384
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 07:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbhKAGIH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 02:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbhKAGHj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 02:07:39 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004BBC061210;
        Sun, 31 Oct 2021 23:04:50 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y4so1005212pfa.5;
        Sun, 31 Oct 2021 23:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d7LTw3kPVa/zFmJb8s8WHpppDtuC/dCZbGEz654o0Z0=;
        b=H/Nt6ip1DACtHq57o9Mdyh3bCgZ2fAcALeHvM0Gv+XQbwcYyRHXWzojtO6xw8zIvFg
         of7ARcpuxOICZBLLWsgHgEjiLZ0NGPmGsuSOqYNFLvMqSv4w8r/p8nLl5pblmv9MgEXK
         21ou7ksmzx/LPZaw79nrvSnwPYYF223o7/HBbYq0pHxF7nGPcAxZCCl6cOjOw/p4oGNc
         VxIcq8UNpcJv+RFjFLhBnY8fbD5NrNaZXXYN5J97DSOc3G3PRDERiKp/Ha/Guhftz0eU
         E9yXRyZQp5jPEOXF7gKMmJZHCv2oeodhDAX0AAFrN+gmh4zIDj2PfHr03avz0ORhIkM/
         aw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d7LTw3kPVa/zFmJb8s8WHpppDtuC/dCZbGEz654o0Z0=;
        b=bssYcQhuHz2agv7qxG/Q1CWChUxVZ4uOAvVo5e0rYO8mMcfHQ7lZphu6jqJFip7o8y
         3MJ0ckdAAJpz4UqyY5B1yd7heJ8E9tflktCWPApGPmH8893WCFeGEN4lMQgtXe/m4jSO
         4tarRIwNfB5+tcr3az3AHgCylm0quUiBee74uRj9r3zauqDpoRwcSIebf18aB5KU0263
         aApFEQAwfo8i+6wbSgyulrlM8dbFu1PtPYgmRwsZgJZ0qG/cspA7brQoY1Du6qawtSpM
         OmNgY0mm0TiUSCKjWepuszxLfDje5kL3rLxhCov14ZkHPKy3XPiJPnYMiB02WJVYjspP
         YUKA==
X-Gm-Message-State: AOAM533LaemEc4aqaTd6HJlE31rubWkyIAEmG0VxeazcGO2JlbG40RHF
        3659EmGUBf6TcGHmSo5tKpU=
X-Google-Smtp-Source: ABdhPJxHtNbH9HB5n5DPJRDQzLHf3MgJ9R6ynW9CWqOunCISp1/PBfsWZl/KKejsKvsqjLu1N78mrQ==
X-Received: by 2002:a63:7e05:: with SMTP id z5mr20295506pgc.354.1635746690496;
        Sun, 31 Oct 2021 23:04:50 -0700 (PDT)
Received: from localhost.localdomain ([144.202.123.152])
        by smtp.gmail.com with ESMTPSA id g8sm3277586pfc.65.2021.10.31.23.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 23:04:49 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     akpm@linux-foundation.org, keescook@chromium.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        arnaldo.melo@gmail.com, pmladek@suse.com, peterz@infradead.org,
        viro@zeniv.linux.org.uk, valentin.schneider@arm.com,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        christian@brauner.io, dietmar.eggemann@arm.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, dennis.dalessandro@cornelisnetworks.com,
        mike.marciniszyn@cornelisnetworks.com, dledford@redhat.com,
        jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, oliver.sang@intel.com, lkp@intel.com,
        Yafang Shao <laoar.shao@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH v7 09/11] tools/testing/selftests/bpf: make it adopt to task comm size change
Date:   Mon,  1 Nov 2021 06:04:17 +0000
Message-Id: <20211101060419.4682-10-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211101060419.4682-1-laoar.shao@gmail.com>
References: <20211101060419.4682-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The hard-coded 16 is used in various bpf progs. These progs get task
comm either via bpf_get_current_comm() or prctl() or
bpf_core_read_str(), all of which can work well even if the task comm size
is changed.

In these BPF programs, one thing to be improved is the
sched:sched_switch tracepoint args. As the tracepoint args are derived
from the kernel, we'd better make it same with the kernel. So the macro
TASK_COMM_LEN is converted to type enum, then all the BPF programs can
get it through BTF.

The BPF program which wants to use TASK_COMM_LEN should include the header
vmlinux.h. Regarding the test_stacktrace_map and test_tracepoint, as the
type defined in linux/bpf.h are also defined in vmlinux.h, so we don't
need to include linux/bpf.h again.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Kees Cook <keescook@chromium.org>
Cc: Petr Mladek <pmladek@suse.com>
---
 include/linux/sched.h                                   | 9 +++++++--
 tools/testing/selftests/bpf/progs/test_stacktrace_map.c | 6 +++---
 tools/testing/selftests/bpf/progs/test_tracepoint.c     | 6 +++---
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b9c85c52fed0..09ac13e54549 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -274,8 +274,13 @@ struct task_group;
 
 #define get_current_state()	READ_ONCE(current->__state)
 
-/* Task command name length: */
-#define TASK_COMM_LEN			16
+/*
+ * Define the task command name length as enum, then it can be visible to
+ * BPF programs.
+ */
+enum {
+	TASK_COMM_LEN = 16,
+};
 
 extern void scheduler_tick(void);
 
diff --git a/tools/testing/selftests/bpf/progs/test_stacktrace_map.c b/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
index 00ed48672620..e9b602a6dc1b 100644
--- a/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
+++ b/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2018 Facebook
 
-#include <linux/bpf.h>
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 
 #ifndef PERF_MAX_STACK_DEPTH
@@ -41,11 +41,11 @@ struct {
 /* taken from /sys/kernel/debug/tracing/events/sched/sched_switch/format */
 struct sched_switch_args {
 	unsigned long long pad;
-	char prev_comm[16];
+	char prev_comm[TASK_COMM_LEN];
 	int prev_pid;
 	int prev_prio;
 	long long prev_state;
-	char next_comm[16];
+	char next_comm[TASK_COMM_LEN];
 	int next_pid;
 	int next_prio;
 };
diff --git a/tools/testing/selftests/bpf/progs/test_tracepoint.c b/tools/testing/selftests/bpf/progs/test_tracepoint.c
index 4b825ee122cf..f21982681e28 100644
--- a/tools/testing/selftests/bpf/progs/test_tracepoint.c
+++ b/tools/testing/selftests/bpf/progs/test_tracepoint.c
@@ -1,17 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2017 Facebook
 
-#include <linux/bpf.h>
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 
 /* taken from /sys/kernel/debug/tracing/events/sched/sched_switch/format */
 struct sched_switch_args {
 	unsigned long long pad;
-	char prev_comm[16];
+	char prev_comm[TASK_COMM_LEN];
 	int prev_pid;
 	int prev_prio;
 	long long prev_state;
-	char next_comm[16];
+	char next_comm[TASK_COMM_LEN];
 	int next_pid;
 	int next_prio;
 };
-- 
2.17.1

