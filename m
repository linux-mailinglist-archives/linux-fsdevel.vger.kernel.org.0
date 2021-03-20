Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEAF342DF5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 16:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCTPtQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 11:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhCTPs7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 11:48:59 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F45C061574;
        Sat, 20 Mar 2021 08:48:58 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a7so14392355ejs.3;
        Sat, 20 Mar 2021 08:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=dTfLHDds3QROg079FJDOkQVVptErbIgmQiK60+WqgI8=;
        b=ShGzQSRVbYjYJovXE73WrVwYorSw9ZGjEzQJ04rpab0ZRtec2dJxYVnNkMyLbN6I6u
         39Eg/J5LywScJ+jqOHpYgp90Tnnlj/RJwALMO+T1isqz4N9FJk//qsbvg+xvHlOyzfWR
         gf5xy/DvHLK903cJLry/AD/HtTgzFFx/tMRfILu/aeu+hSvp4HCTHqG47VJw5PSsMhAd
         X1k0STq9pHje4wL5bdg8Ws1HdSwb9b98Bxv/0eOG/YRR50HwELI4oGdmASHVKIEPow3m
         6p/vSAdWMtNAeSzBpE/wRygzJQfyzGYXk5UH150Cxv9wV63aHsMogibJ8QKKjQVmhDGk
         bUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=dTfLHDds3QROg079FJDOkQVVptErbIgmQiK60+WqgI8=;
        b=kGz/XMOIoGUyQpFldVgB3SLXbGQQImwF6hvIfpOPLGZdI26lfw/+jou0h+oU1+g1KJ
         ZSNGw3av8g7iafLrsBA7k0bTMNvLsEds5taz40Iw1VzzpxOHgH7Ni+stXM1XXmcxOIM4
         DKrr2iUPlvpC1amYOR6B4PWd9RCip/xSvZB6/x1APQi2+CXzOFF0XYcqTlR76Vqowo61
         5ExeAoGJ7kBmN3z4EOGz8rv5uRBSx0WyWhJ1df/DU8/o32rL2QFTERMkBvdL4SPNfLM4
         Y6fj5uJFZPxYmwvFHfrbLZ437k8bw6FMlEI+PjBWSgmlbOcvKRrXtUT8aaTVHDjX2/Jd
         Cycw==
X-Gm-Message-State: AOAM533/y4YD1NlXz5p3w37EvA0IrFP2+u9bl2wToLL3q+heqHiJmJKs
        x5oV7nMq8ODn9hhnwo+0pQ==
X-Google-Smtp-Source: ABdhPJzm2a+FwiwoIS8i2cl03jNYAej/AocRQXJthGp6sQxA1jgfOu7W1bfgANH8/Ez/j0W4g6c1iA==
X-Received: by 2002:a17:906:f283:: with SMTP id gu3mr10177338ejb.91.1616255337187;
        Sat, 20 Mar 2021 08:48:57 -0700 (PDT)
Received: from localhost.localdomain ([46.53.248.213])
        by smtp.gmail.com with ESMTPSA id k12sm6471815edr.60.2021.03.20.08.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 08:48:56 -0700 (PDT)
Date:   Sat, 20 Mar 2021 18:48:55 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gladkov.alexey@gmail.com
Subject: [PATCH] proc: test subset=pid
Message-ID: <YFYZZ7WGaZlsnChS@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Test that /proc instance mounted with

	mount -t proc -o subset=pid

contains only ".", "..", "self", "thread-self" and pid directories.

Note:
Currently "subset=pid" doesn't return "." and ".." via readdir.
This must be a bug.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/proc/Makefile          |    1 
 tools/testing/selftests/proc/proc-subset-pid.c |  121 +++++++++++++++++++++++++
 2 files changed, 122 insertions(+)

--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -12,6 +12,7 @@ TEST_GEN_PROGS += proc-self-map-files-001
 TEST_GEN_PROGS += proc-self-map-files-002
 TEST_GEN_PROGS += proc-self-syscall
 TEST_GEN_PROGS += proc-self-wchan
+TEST_GEN_PROGS += proc-subset-pid
 TEST_GEN_PROGS += proc-uptime-001
 TEST_GEN_PROGS += proc-uptime-002
 TEST_GEN_PROGS += read
new file mode 100644
--- /dev/null
+++ b/tools/testing/selftests/proc/proc-subset-pid.c
@@ -0,0 +1,121 @@
+/*
+ * Copyright (c) 2021 Alexey Dobriyan <adobriyan@gmail.com>
+ *
+ * Permission to use, copy, modify, and distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ */
+/*
+ * Test that "mount -t proc -o subset=pid" hides everything but pids,
+ * /proc/self and /proc/thread-self.
+ */
+#undef NDEBUG
+#include <assert.h>
+#include <errno.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mount.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <dirent.h>
+#include <unistd.h>
+#include <stdio.h>
+
+static inline bool streq(const char *a, const char *b)
+{
+	return strcmp(a, b) == 0;
+}
+
+static void make_private_proc(void)
+{
+	if (unshare(CLONE_NEWNS) == -1) {
+		if (errno == ENOSYS || errno == EPERM) {
+			exit(4);
+		}
+		exit(1);
+	}
+	if (mount(NULL, "/", NULL, MS_PRIVATE|MS_REC, NULL) == -1) {
+		exit(1);
+	}
+	if (mount(NULL, "/proc", "proc", 0, "subset=pid") == -1) {
+		exit(1);
+	}
+}
+
+static bool string_is_pid(const char *s)
+{
+	while (1) {
+		switch (*s++) {
+		case '0':case '1':case '2':case '3':case '4':
+		case '5':case '6':case '7':case '8':case '9':
+			continue;
+
+		case '\0':
+			return true;
+
+		default:
+			return false;
+		}
+	}
+}
+
+int main(void)
+{
+	make_private_proc();
+
+	DIR *d = opendir("/proc");
+	assert(d);
+
+	struct dirent *de;
+
+	bool dot = false;
+	bool dot_dot = false;
+	bool self = false;
+	bool thread_self = false;
+
+	while ((de = readdir(d))) {
+		if (streq(de->d_name, ".")) {
+			assert(!dot);
+			dot = true;
+			assert(de->d_type == DT_DIR);
+		} else if (streq(de->d_name, "..")) {
+			assert(!dot_dot);
+			dot_dot = true;
+			assert(de->d_type == DT_DIR);
+		} else if (streq(de->d_name, "self")) {
+			assert(!self);
+			self = true;
+			assert(de->d_type == DT_LNK);
+		} else if (streq(de->d_name, "thread-self")) {
+			assert(!thread_self);
+			thread_self = true;
+			assert(de->d_type == DT_LNK);
+		} else {
+			if (!string_is_pid(de->d_name)) {
+				fprintf(stderr, "d_name '%s'\n", de->d_name);
+				assert(0);
+			}
+			assert(de->d_type == DT_DIR);
+		}
+	}
+
+	char c;
+	int rv = readlink("/proc/cpuinfo", &c, 1);
+	assert(rv == -1 && errno == ENOENT);
+
+	int fd = open("/proc/cpuinfo", O_RDONLY);
+	assert(fd == -1 && errno == ENOENT);
+
+	return 0;
+}
