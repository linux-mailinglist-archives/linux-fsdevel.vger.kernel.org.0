Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37D347122E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Dec 2021 07:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhLKGkJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Dec 2021 01:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhLKGkG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Dec 2021 01:40:06 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CF7C061714;
        Fri, 10 Dec 2021 22:40:05 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so9287726pjb.1;
        Fri, 10 Dec 2021 22:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YOmWgj2DxdohruN6t1jhLzVebqIDyQ6/9OEYQxNzBg0=;
        b=avF8g6XTx8SXtkscJO5GafrYodx7aduWYE3dYkSVMyLazEekKe1vVFk1AcFgyRBi6D
         KLtMP+qE/Amw1XwaQT/yoZ7FOpLwpBIsjgKmZHipCkgkLFNTE6AqlpV1aH5qy7E7MmSl
         Qm6JgY75X1B3qkf/H2k7QvWLl8G9yHb61vg4+ii+LxdBRZLuOVbmTGjafvriHmt9NNf2
         C2Gdtyfny7jByIehwd+AyV30ha9OKEIw3yPh05v5AvFtaFqno5FojQ8vmgGFIAbxiGEE
         h9szKpnk6ljwBnYCjFwml3+o+AVuPYrMIgmExUuBfP4zdOzo4zP83bUHVEc1hawnKN1j
         56yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YOmWgj2DxdohruN6t1jhLzVebqIDyQ6/9OEYQxNzBg0=;
        b=TMVBGicERsFuIKKy+F9Yu02a1zdhH5P1TCU8I0jOAhavTMQpYxO/EDws4oM+iv+Hwk
         AJaLAsBmWYOkhR8jIxAWffEXa7UkDb+paYGSrLck2KHwC3Rykn2r8zOJODe6IvW/WK84
         d9QE5Di+e4J/XsUnDKch9ZGiG6CRCerfFe/OPmXYuEWTRTMoiZ8PUh0zKn8Nq785AtjF
         XsMwzG6NR1yC236ab1znuusAA5T6GG4H+nWYE9abRtuiqfZmZz599+HIRk+OcBXglhbC
         yzTTldzORhwZsBviYDWOEVpOU/8jhlLFnv60AmHsrgasDxFyk+9C/ioKTSIr+Reh7AMs
         Ov7Q==
X-Gm-Message-State: AOAM533LrE/gW5/FbmOOKEAvn9Um+xwfN1ZuZebJ6tKN+dw99tkqcoM8
        caw9zWviJuO74igYWgeKSSI=
X-Google-Smtp-Source: ABdhPJyBEqkEghuO8KOI7906KYxsqu3siKTh85eWa5YxoDkG4ZEkClWkFiRCnC3BaaN4x8agFkpY0w==
X-Received: by 2002:a17:90b:1b45:: with SMTP id nv5mr29250796pjb.120.1639204805586;
        Fri, 10 Dec 2021 22:40:05 -0800 (PST)
Received: from vultr.guest ([45.76.74.237])
        by smtp.gmail.com with ESMTPSA id mr2sm869638pjb.25.2021.12.10.22.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 22:40:05 -0800 (PST)
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
Subject: [PATCH -mm v2 3/3] tools/perf: replace old hard-coded 16 with TASK_COMM_LEN_16
Date:   Sat, 11 Dec 2021 06:39:49 +0000
Message-Id: <20211211063949.49533-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211211063949.49533-1-laoar.shao@gmail.com>
References: <20211211063949.49533-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

evsel-tp-sched will verify the task comm len in sched:sched_switch
and sched:sched_wakeup tracepoints. In order to make it grepable, we'd
better replace the hard-coded 16 with TASK_COMM_LEN_16.

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
 tools/perf/tests/evsel-tp-sched.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/evsel-tp-sched.c b/tools/perf/tests/evsel-tp-sched.c
index cf4da3d748c2..8be44b8e2b9c 100644
--- a/tools/perf/tests/evsel-tp-sched.c
+++ b/tools/perf/tests/evsel-tp-sched.c
@@ -5,6 +5,8 @@
 #include "tests.h"
 #include "debug.h"
 
+#define TASK_COMM_LEN_16 16
+
 static int evsel__test_field(struct evsel *evsel, const char *name, int size, bool should_be_signed)
 {
 	struct tep_format_field *field = evsel__field(evsel, name);
@@ -43,7 +45,7 @@ static int test__perf_evsel__tp_sched_test(struct test_suite *test __maybe_unuse
 		return -1;
 	}
 
-	if (evsel__test_field(evsel, "prev_comm", 16, false))
+	if (evsel__test_field(evsel, "prev_comm", TASK_COMM_LEN_16, false))
 		ret = -1;
 
 	if (evsel__test_field(evsel, "prev_pid", 4, true))
@@ -55,7 +57,7 @@ static int test__perf_evsel__tp_sched_test(struct test_suite *test __maybe_unuse
 	if (evsel__test_field(evsel, "prev_state", sizeof(long), true))
 		ret = -1;
 
-	if (evsel__test_field(evsel, "next_comm", 16, false))
+	if (evsel__test_field(evsel, "next_comm", TASK_COMM_LEN_16, false))
 		ret = -1;
 
 	if (evsel__test_field(evsel, "next_pid", 4, true))
@@ -73,7 +75,7 @@ static int test__perf_evsel__tp_sched_test(struct test_suite *test __maybe_unuse
 		return -1;
 	}
 
-	if (evsel__test_field(evsel, "comm", 16, false))
+	if (evsel__test_field(evsel, "comm", TASK_COMM_LEN_16, false))
 		ret = -1;
 
 	if (evsel__test_field(evsel, "pid", 4, true))
-- 
2.17.1

