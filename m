Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9493C6BD6A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 18:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjCPRD6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 13:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjCPRDr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:03:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B682E6FFE;
        Thu, 16 Mar 2023 10:03:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 934CA62057;
        Thu, 16 Mar 2023 17:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8B1C433EF;
        Thu, 16 Mar 2023 17:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678986194;
        bh=XHhvrIWZe8yN3WAyFVo4Xi7J+OqocuCK7k5vskhhChE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u/EISLQO2803reejxf8JO9MgqJ4NQbmCh7G+bn4fdRV+pQjJWe7KhKZRVVRMnw/ro
         ky1GblNRwpv7o43sqGdjR+vtMiXrfHmEkRy8GDHTp5zyIIcdCaW4MxkTblBR6l0SbR
         TAOctZXlkrbvfAr32VS7QCdN1vTKcd2FZpyaKwV6Mip5pPdN0fuTmWVv1nPd5jY5FD
         bZBxvJTG9trTD+BxrlJdfuicdsC4pgcFCE22xVsACPERaSCMmO+3odXdTcRCiUZbhM
         JiYpsGUKNn82I0dJFtheJV6qlT2BNNhuk7D4WYnHHcRnSXICVtX3RbdWfjsCO+7e5l
         iBrppzqNKKC5Q==
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
        Namhyung Kim <namhyung@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Subject: [PATCHv3 bpf-next 6/9] selftests/bpf: Add err.h header
Date:   Thu, 16 Mar 2023 18:01:46 +0100
Message-Id: <20230316170149.4106586-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230316170149.4106586-1-jolsa@kernel.org>
References: <20230316170149.4106586-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Moving error macros from profiler.inc.h to new err.h header.
It will be used in following changes.

Also adding PTR_ERR macro that will be used in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/progs/err.h        | 18 ++++++++++++++++++
 .../testing/selftests/bpf/progs/profiler.inc.h |  3 +--
 2 files changed, 19 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/err.h

diff --git a/tools/testing/selftests/bpf/progs/err.h b/tools/testing/selftests/bpf/progs/err.h
new file mode 100644
index 000000000000..d66d283d9e59
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/err.h
@@ -0,0 +1,18 @@
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
+static inline long PTR_ERR(const void *ptr)
+{
+	return (long) ptr;
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

