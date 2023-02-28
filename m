Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3CB6A55E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 10:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjB1Jdu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 04:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjB1Jdq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:33:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2B2199B;
        Tue, 28 Feb 2023 01:33:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07BC7B80DFF;
        Tue, 28 Feb 2023 09:33:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C855C433EF;
        Tue, 28 Feb 2023 09:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677576810;
        bh=ySf52tgWqEzdgE2vONbMq7274Pu4w3NaXS6sukUJ/0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zgd0zI0qCybzWRqKGIKUz+Rm49XKg3Uy7NFHPGFw2GDLDuL1jlUXC13xDSN/8EHMo
         4V5P+uyoEs9Zuhajj71FPcUKW6bLUmymtvxLe8/74wwj3vDCvwM2OpXY2WSbg7krW7
         2I/yp6iqFJIU2rCfEXQFcDyUYmLHATae/AXLtZhw8EJbUqjr0bA/xp1NLTEdgQZeYy
         Tz8wUH1wHeEnIXtrUxY9RqgPgS4rx8fn7haijA02hKW2iguF7lEl2VJbKx2E5JQ9dk
         PrUMUo0oURbDLheqXXfeyY6pA0ObUo3g3d3ZahQGyGxY32/DsyKSs5nof1ZWrI130V
         S84l0gHSDnRnw==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH RFC v2 bpf-next 6/9] selftests/bpf: Add err.h header
Date:   Tue, 28 Feb 2023 10:32:03 +0100
Message-Id: <20230228093206.821563-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230228093206.821563-1-jolsa@kernel.org>
References: <20230228093206.821563-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Moving error macros from profiler.inc.h to new err.h header.
It will be used in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/progs/err.h          | 13 +++++++++++++
 tools/testing/selftests/bpf/progs/profiler.inc.h |  3 +--
 2 files changed, 14 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/err.h

diff --git a/tools/testing/selftests/bpf/progs/err.h b/tools/testing/selftests/bpf/progs/err.h
new file mode 100644
index 000000000000..3ac6324da6fd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/err.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ERR_H__
+#define __ERR_H__
+
+#define MAX_ERRNO 4095
+#define IS_ERR_VALUE(x) (unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO
+
+static inline int IS_ERR_OR_NULL(const void *ptr)
+{
+	return !ptr || IS_ERR_VALUE((unsigned long)ptr);
+}
+
+#endif /* __ERR_H__ */
diff --git a/tools/testing/selftests/bpf/progs/profiler.inc.h b/tools/testing/selftests/bpf/progs/profiler.inc.h
index 875513866032..f799d87e8700 100644
--- a/tools/testing/selftests/bpf/progs/profiler.inc.h
+++ b/tools/testing/selftests/bpf/progs/profiler.inc.h
@@ -6,6 +6,7 @@
 #include <bpf/bpf_tracing.h>
 
 #include "profiler.h"
+#include "err.h"
 
 #ifndef NULL
 #define NULL 0
@@ -16,7 +17,6 @@
 #define O_DIRECTORY 00200000
 #define __O_TMPFILE 020000000
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
-#define MAX_ERRNO 4095
 #define S_IFMT 00170000
 #define S_IFSOCK 0140000
 #define S_IFLNK 0120000
@@ -34,7 +34,6 @@
 #define S_ISBLK(m) (((m)&S_IFMT) == S_IFBLK)
 #define S_ISFIFO(m) (((m)&S_IFMT) == S_IFIFO)
 #define S_ISSOCK(m) (((m)&S_IFMT) == S_IFSOCK)
-#define IS_ERR_VALUE(x) (unsigned long)(void*)(x) >= (unsigned long)-MAX_ERRNO
 
 #define KILL_DATA_ARRAY_SIZE 8
 
-- 
2.39.2

