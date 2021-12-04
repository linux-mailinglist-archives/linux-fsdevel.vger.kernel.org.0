Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823DE4683D1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Dec 2021 10:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384601AbhLDJ4p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Dec 2021 04:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384558AbhLDJ4h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Dec 2021 04:56:37 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1BDC061751;
        Sat,  4 Dec 2021 01:53:12 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id g19so5295915pfb.8;
        Sat, 04 Dec 2021 01:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jc/1UqX6dBziNJTgW2IO/F7rtsTi2nR5UyyzWa0yaTY=;
        b=OPS6Tq0grzniAtkhVxBUnYGlNHe2LHenEl9GBTJUtoQpFmZ4NpGLdXZjKUgC7IZqdL
         ZKWU9aSUkUqHoSXlb9199RCCbprlEwAz/eREA8MLQnnkIgsEEY3qPvF/NMesCapvpCTL
         CDJI0dUFjTdXdtPWz0FFQdAtRz26RuQoiQvkBRzKFySMAH48+WOoxFj1q+RcM1mq8PJA
         4HpF89d8G613VAWp+7lBQWZzOShQCn6ZJ9mRR7ESbX0eCDt7rNkgILW7w1PQEFJhi3gT
         yF3ugmTHCdttEto30CCqoAPVMIpMK7h+XNAJYJWgzLuqIe2i7V6I3L23Amzdh+sY9Pc8
         tOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jc/1UqX6dBziNJTgW2IO/F7rtsTi2nR5UyyzWa0yaTY=;
        b=3hUN/Fb0jkawNHT+khD9Rs1Fef00KawgSg9os2tNzpqWK+LqKdmHgljzBAl1vD2+AM
         XOpcdmhiy3nl336PnDoNJP7D5xffW2aDYc/q3ab05gKNfeQ1JEHe4/huTsbq7Ot5JoVV
         NWHNwLvmdhbmok4O0CWIH1ly9/mMRwgfABC5XUTSViuLipLZM/HLd4qiwcQqQw09bPt2
         nARBLI/Moz7y5JP3JnTy2QM28yHjzhKFu5AakTBDIMHdKaact3uy+PYlgbtdPkDuljw/
         Bwl8BIPr251cUgOJ3qSAJyVO3By3+wACjDh5wmTJ2pxWb2CnCDF4RXJMG+iwe28mUt3w
         Pniw==
X-Gm-Message-State: AOAM532sUXFWgSVuuxHP5iWoyEDf7WBaQaFpdFFXyr5aacfWMTs9dJII
        COJr/TyUNdInrxtlq4U2nRk=
X-Google-Smtp-Source: ABdhPJxOtpMKrYAZBUYRY5WFF9PUZ3+zcvLt12isc0/o9+IZvyummoBi6CX2Z881q/Ptmt968HlHTw==
X-Received: by 2002:a63:1107:: with SMTP id g7mr8918770pgl.108.1638611592149;
        Sat, 04 Dec 2021 01:53:12 -0800 (PST)
Received: from vultr.guest ([45.76.74.237])
        by smtp.gmail.com with ESMTPSA id ms15sm4343198pjb.26.2021.12.04.01.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 01:53:11 -0800 (PST)
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
Subject: [PATCH -mm 4/5] tools/perf: replace hard-coded 16 with TASK_COMM_LEN
Date:   Sat,  4 Dec 2021 09:52:55 +0000
Message-Id: <20211204095256.78042-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211204095256.78042-1-laoar.shao@gmail.com>
References: <20211204095256.78042-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

evsel-tp-sched will verify the task comm len in sched:sched_switch
and sched:sched_wakeup tracepoints. The len must be same with TASK_COMM_LEN
defined in linux/sched.h. In order to make it grepable, we'd better replace
the hard-coded 16 with TASK_COMM_LEN.

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
index cf4da3d748c2..83e0ce2e676f 100644
--- a/tools/perf/tests/evsel-tp-sched.c
+++ b/tools/perf/tests/evsel-tp-sched.c
@@ -5,6 +5,8 @@
 #include "tests.h"
 #include "debug.h"
 
+#define TASK_COMM_LEN 16
+
 static int evsel__test_field(struct evsel *evsel, const char *name, int size, bool should_be_signed)
 {
 	struct tep_format_field *field = evsel__field(evsel, name);
@@ -43,7 +45,7 @@ static int test__perf_evsel__tp_sched_test(struct test_suite *test __maybe_unuse
 		return -1;
 	}
 
-	if (evsel__test_field(evsel, "prev_comm", 16, false))
+	if (evsel__test_field(evsel, "prev_comm", TASK_COMM_LEN, false))
 		ret = -1;
 
 	if (evsel__test_field(evsel, "prev_pid", 4, true))
@@ -55,7 +57,7 @@ static int test__perf_evsel__tp_sched_test(struct test_suite *test __maybe_unuse
 	if (evsel__test_field(evsel, "prev_state", sizeof(long), true))
 		ret = -1;
 
-	if (evsel__test_field(evsel, "next_comm", 16, false))
+	if (evsel__test_field(evsel, "next_comm", TASK_COMM_LEN, false))
 		ret = -1;
 
 	if (evsel__test_field(evsel, "next_pid", 4, true))
@@ -73,7 +75,7 @@ static int test__perf_evsel__tp_sched_test(struct test_suite *test __maybe_unuse
 		return -1;
 	}
 
-	if (evsel__test_field(evsel, "comm", 16, false))
+	if (evsel__test_field(evsel, "comm", TASK_COMM_LEN, false))
 		ret = -1;
 
 	if (evsel__test_field(evsel, "pid", 4, true))
-- 
2.17.1

