Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9564254BA9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 19:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgH0RKJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 13:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgH0RKB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 13:10:01 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5184FC061235
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 10:10:00 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id j2so4335650ioj.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 10:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JueOAVgNYgqbWYVYqLooj1vIHH/WeKWbvTedzr6nkHI=;
        b=YKb3uzdI72no6P2AMeLmB/dQ7L5o4c89fhaInwgUEQzNIl3gqfWzfygxqN9yuB7NnO
         1La7m8T0c4shQtFDVoltp4emyuNj4ozrOcdlPivRM6j9BEx3d172BPAHSzCd0xYfM7Fg
         fXn/li9z6G+ll/lP1jZPEcJS01PYlySWTPpkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JueOAVgNYgqbWYVYqLooj1vIHH/WeKWbvTedzr6nkHI=;
        b=nqmolhK6uKVy4y51meiPLvmNTXH8KeiXRu+GmlkAy0FFfP5jdnS4CZ+2cYkOwkb0L7
         LNKsguP7LgizYh18JdqrFJ0GBy5buLRca5BDZroHkbJBIIfk6LfPITVOSxdtymodLqA1
         XqcnHqAdtDw3YvdM+6O/iwWguByxUEwbL3s0KUdfuG2C7KYsB7Fqav8tNtXGJvMCHQwn
         Ac8YFzBjyOGR5gl1j6zyXqdQhM1o+9m6B+pwHKHK55rIIn4RQfcW+XDd9JiI78kKcSMU
         SVBRJDXEtQ30wh25hVJdizIven9lyaNTumUhXXzHkJTzfyIepUa1YswueEKNfmmTvm7v
         ziUA==
X-Gm-Message-State: AOAM5334eiszC4m8FAgQUI4zkGoSmXBwvOAyIbaEJE13itrJmPSjPi5V
        kpPTXiImqavwAp35vW8YFzS8oA==
X-Google-Smtp-Source: ABdhPJwgdpRQdR/omvo7NV4K3vZad1KgZMYV8A3SZEKwH4TFMRbIRvi58Y6c3e2vKc0zdS3D1L7yBg==
X-Received: by 2002:a6b:681a:: with SMTP id d26mr17763852ioc.70.1598548199537;
        Thu, 27 Aug 2020 10:09:59 -0700 (PDT)
Received: from ravnica.hsd1.co.comcast.net ([2601:285:8380:9270::f2a2])
        by smtp.gmail.com with ESMTPSA id 137sm1501157ioc.20.2020.08.27.10.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 10:09:58 -0700 (PDT)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>,
        Mattias Nissler <mnissler@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Gordon <bmgordon@google.com>,
        David Howells <dhowells@redhat.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Micah Morton <mortonm@google.com>,
        Raul Rangel <rrangel@google.com>, Shuah Khan <shuah@kernel.org>
Subject: [PATCH v9 2/2] selftests: mount: add nosymfollow tests
Date:   Thu, 27 Aug 2020 11:09:47 -0600
Message-Id: <20200827170947.429611-2-zwisler@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200827170947.429611-1-zwisler@google.com>
References: <20200827170947.429611-1-zwisler@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add tests for the new 'nosymfollow' mount option.  We test to make sure
that symlink traversal fails with ELOOP when 'nosymfollow' is set, but
that readlink(2) and realpath(3) still work as expected.  We also verify
that statfs(2) correctly returns ST_NOSYMFOLLOW when we are mounted with
the 'nosymfollow' option.

Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 tools/testing/selftests/mount/.gitignore      |   1 +
 tools/testing/selftests/mount/Makefile        |   4 +-
 .../selftests/mount/nosymfollow-test.c        | 218 ++++++++++++++++++
 .../selftests/mount/run_nosymfollow.sh        |   4 +
 ...n_tests.sh => run_unprivileged_remount.sh} |   0
 5 files changed, 225 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/mount/nosymfollow-test.c
 create mode 100755 tools/testing/selftests/mount/run_nosymfollow.sh
 rename tools/testing/selftests/mount/{run_tests.sh => run_unprivileged_remount.sh} (100%)

diff --git a/tools/testing/selftests/mount/.gitignore b/tools/testing/selftests/mount/.gitignore
index 0bc64a6d4c181..17f2d84151622 100644
--- a/tools/testing/selftests/mount/.gitignore
+++ b/tools/testing/selftests/mount/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 unprivileged-remount-test
+nosymfollow-test
diff --git a/tools/testing/selftests/mount/Makefile b/tools/testing/selftests/mount/Makefile
index 026890744215b..2d9454841644a 100644
--- a/tools/testing/selftests/mount/Makefile
+++ b/tools/testing/selftests/mount/Makefile
@@ -3,7 +3,7 @@
 CFLAGS = -Wall \
          -O2
 
-TEST_PROGS := run_tests.sh
-TEST_GEN_FILES := unprivileged-remount-test
+TEST_PROGS := run_unprivileged_remount.sh run_nosymfollow.sh
+TEST_GEN_FILES := unprivileged-remount-test nosymfollow-test
 
 include ../lib.mk
diff --git a/tools/testing/selftests/mount/nosymfollow-test.c b/tools/testing/selftests/mount/nosymfollow-test.c
new file mode 100644
index 0000000000000..650d6d80a1d27
--- /dev/null
+++ b/tools/testing/selftests/mount/nosymfollow-test.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <sched.h>
+#include <stdarg.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/vfs.h>
+#include <unistd.h>
+
+#ifndef MS_NOSYMFOLLOW
+# define MS_NOSYMFOLLOW 256     /* Do not follow symlinks */
+#endif
+
+#ifndef ST_NOSYMFOLLOW
+# define ST_NOSYMFOLLOW 0x2000  /* Do not follow symlinks */
+#endif
+
+#define DATA "/tmp/data"
+#define LINK "/tmp/symlink"
+#define TMP  "/tmp"
+
+static void die(char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+	va_end(ap);
+	exit(EXIT_FAILURE);
+}
+
+static void vmaybe_write_file(bool enoent_ok, char *filename, char *fmt,
+		va_list ap)
+{
+	ssize_t written;
+	char buf[4096];
+	int buf_len;
+	int fd;
+
+	buf_len = vsnprintf(buf, sizeof(buf), fmt, ap);
+	if (buf_len < 0)
+		die("vsnprintf failed: %s\n", strerror(errno));
+
+	if (buf_len >= sizeof(buf))
+		die("vsnprintf output truncated\n");
+
+	fd = open(filename, O_WRONLY);
+	if (fd < 0) {
+		if ((errno == ENOENT) && enoent_ok)
+			return;
+		die("open of %s failed: %s\n", filename, strerror(errno));
+	}
+
+	written = write(fd, buf, buf_len);
+	if (written != buf_len) {
+		if (written >= 0) {
+			die("short write to %s\n", filename);
+		} else {
+			die("write to %s failed: %s\n",
+				filename, strerror(errno));
+		}
+	}
+
+	if (close(fd) != 0)
+		die("close of %s failed: %s\n", filename, strerror(errno));
+}
+
+static void maybe_write_file(char *filename, char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	vmaybe_write_file(true, filename, fmt, ap);
+	va_end(ap);
+}
+
+static void write_file(char *filename, char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	vmaybe_write_file(false, filename, fmt, ap);
+	va_end(ap);
+}
+
+static void create_and_enter_ns(void)
+{
+	uid_t uid = getuid();
+	gid_t gid = getgid();
+
+	if (unshare(CLONE_NEWUSER) != 0)
+		die("unshare(CLONE_NEWUSER) failed: %s\n", strerror(errno));
+
+	maybe_write_file("/proc/self/setgroups", "deny");
+	write_file("/proc/self/uid_map", "0 %d 1", uid);
+	write_file("/proc/self/gid_map", "0 %d 1", gid);
+
+	if (setgid(0) != 0)
+		die("setgid(0) failed %s\n", strerror(errno));
+	if (setuid(0) != 0)
+		die("setuid(0) failed %s\n", strerror(errno));
+
+	if (unshare(CLONE_NEWNS) != 0)
+		die("unshare(CLONE_NEWNS) failed: %s\n", strerror(errno));
+}
+
+static void setup_symlink(void)
+{
+	int data, err;
+
+	data = creat(DATA, O_RDWR);
+	if (data < 0)
+		die("creat failed: %s\n", strerror(errno));
+
+	err = symlink(DATA, LINK);
+	if (err < 0)
+		die("symlink failed: %s\n", strerror(errno));
+
+	if (close(data) != 0)
+		die("close of %s failed: %s\n", DATA, strerror(errno));
+}
+
+static void test_link_traversal(bool nosymfollow)
+{
+	int link;
+
+	link = open(LINK, 0, O_RDWR);
+	if (nosymfollow) {
+		if ((link != -1 || errno != ELOOP)) {
+			die("link traversal unexpected result: %d, %s\n",
+					link, strerror(errno));
+		}
+	} else {
+		if (link < 0)
+			die("link traversal failed: %s\n", strerror(errno));
+
+		if (close(link) != 0)
+			die("close of link failed: %s\n", strerror(errno));
+	}
+}
+
+static void test_readlink(void)
+{
+	char buf[4096];
+	ssize_t ret;
+
+	bzero(buf, sizeof(buf));
+
+	ret = readlink(LINK, buf, sizeof(buf));
+	if (ret < 0)
+		die("readlink failed: %s\n", strerror(errno));
+	if (strcmp(buf, DATA) != 0)
+		die("readlink strcmp failed: '%s' '%s'\n", buf, DATA);
+}
+
+static void test_realpath(void)
+{
+	char *path = realpath(LINK, NULL);
+
+	if (!path)
+		die("realpath failed: %s\n", strerror(errno));
+	if (strcmp(path, DATA) != 0)
+		die("realpath strcmp failed\n");
+
+	free(path);
+}
+
+static void test_statfs(bool nosymfollow)
+{
+	struct statfs buf;
+	int ret;
+
+	ret = statfs(TMP, &buf);
+	if (ret)
+		die("statfs failed: %s\n", strerror(errno));
+
+	if (nosymfollow) {
+		if ((buf.f_flags & ST_NOSYMFOLLOW) == 0)
+			die("ST_NOSYMFOLLOW not set on %s\n", TMP);
+	} else {
+		if ((buf.f_flags & ST_NOSYMFOLLOW) != 0)
+			die("ST_NOSYMFOLLOW set on %s\n", TMP);
+	}
+}
+
+static void run_tests(bool nosymfollow)
+{
+	test_link_traversal(nosymfollow);
+	test_readlink();
+	test_realpath();
+	test_statfs(nosymfollow);
+}
+
+int main(int argc, char **argv)
+{
+	create_and_enter_ns();
+
+	if (mount("testing", TMP, "ramfs", 0, NULL) != 0)
+		die("mount failed: %s\n", strerror(errno));
+
+	setup_symlink();
+	run_tests(false);
+
+	if (mount("testing", TMP, "ramfs", MS_REMOUNT|MS_NOSYMFOLLOW, NULL) != 0)
+		die("remount failed: %s\n", strerror(errno));
+
+	run_tests(true);
+
+	return EXIT_SUCCESS;
+}
diff --git a/tools/testing/selftests/mount/run_nosymfollow.sh b/tools/testing/selftests/mount/run_nosymfollow.sh
new file mode 100755
index 0000000000000..5fbbf03043a2e
--- /dev/null
+++ b/tools/testing/selftests/mount/run_nosymfollow.sh
@@ -0,0 +1,4 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+./nosymfollow-test
diff --git a/tools/testing/selftests/mount/run_tests.sh b/tools/testing/selftests/mount/run_unprivileged_remount.sh
similarity index 100%
rename from tools/testing/selftests/mount/run_tests.sh
rename to tools/testing/selftests/mount/run_unprivileged_remount.sh
-- 
2.28.0.297.g1956fa8f8d-goog

