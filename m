Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 944BB296C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2019 13:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391017AbfEXLLd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 May 2019 07:11:33 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:38673 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391007AbfEXLLZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 May 2019 07:11:25 -0400
Received: by mail-it1-f193.google.com with SMTP id i63so13211905ita.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 May 2019 04:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nuilRgGUYviZJo16cdF7vgoam1Y3XVG2+yfRV0kCp44=;
        b=R+t/15ExfNAlDmS3T8/nYVgxjZsPbXAkCbY/B3M2JMRsaFaURV0Zvwo0dvOoA8j1Hm
         pYCK1zBbhCgnKR+XhqVnk7+ApqJfnA2u7suNZ83jbrV4R6vPW6qeJf7gbtLWsp8NPh5C
         7QGuX9muWb4qK2c7arcSFCR/ETv8/zM12NWPgcweja2NzxE0Nb6gWV3ACS2uOuwyElHV
         mivWTrs4gdGOskQm1ccR4N4oruKpjx/ClJz9t2u6Li4RA51pbfSX1I+7TFfDNr/PD8QU
         BbPiZbClYmIgJVXnBXzJUBI/f+bo1JTfUguXL47Z1WJ3MaS6fvhxARml1t5MsSBiA5gB
         mG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nuilRgGUYviZJo16cdF7vgoam1Y3XVG2+yfRV0kCp44=;
        b=YmnV2kvW4L+/t6sz3TLfvplwUkxpuDlPkxf8CFVMeY1L/GqYAORNP+SCye+wN35FZo
         siTGLa6HbHSh64Xvlu0vGC6OtjgK0gr5zTJjG8iaX2Y8rTNPG0LOR15HbFI1pXs1zcCV
         kAC3A77Mw2TWwhnCP2mfVFenpGov1QE0LqmlDD4x6GTm7r09+O0BTEr1mc0gt0dkL4vK
         nuLT4VvRrTXt3UYe7FZ+vu9AcSZY7PLmZFOshe93yIfnsaLbAbvo7LOmnNKlcY8UGysJ
         D6SisKleRKPWtlCDkkiFDqfXEhR03snBnw3pbdN4sALKxX0ZKRjTHWZj9eJ1qNQGB6Yd
         Tudg==
X-Gm-Message-State: APjAAAWLKLwigMDPwdbDv4Trzefw+Jp6w9z7y2mvGQ2w79P93gMqpIeh
        y/g4/VyaXF6RFLp3zrcqvWuVYQ==
X-Google-Smtp-Source: APXvYqxBWUfU8Pv7v2XH7gr4LqA1seYEni45lAXHr6lzqG9t83zM0qgC2zZvMzAwxI3Sa3ujZjPIVg==
X-Received: by 2002:a24:7c97:: with SMTP id a145mr12709178itd.117.1558696284466;
        Fri, 24 May 2019 04:11:24 -0700 (PDT)
Received: from localhost.localdomain ([172.56.12.37])
        by smtp.gmail.com with ESMTPSA id y194sm1024771itb.34.2019.05.24.04.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 04:11:23 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        fweimer@redhat.com
Cc:     jannh@google.com, oleg@redhat.com, tglx@linutronix.de,
        arnd@arndb.de, shuah@kernel.org, dhowells@redhat.com,
        tkjos@android.com, ldv@altlinux.org, miklos@szeredi.hu,
        Christian Brauner <christian@brauner.io>,
        linux-api@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 3/3] tests: add close_range() tests
Date:   Fri, 24 May 2019 13:10:47 +0200
Message-Id: <20190524111047.6892-4-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524111047.6892-1-christian@brauner.io>
References: <20190524111047.6892-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds basic tests for the new close_range() syscall.
- test that no invalid flags can be passed
- test that a range of file descriptors is correctly closed
- test that a range of file descriptors is correctly closed if there there
  are already closed file descriptors in the range
- test that max_fd is correctly capped to the current fdtable maximum

Signed-off-by: Christian Brauner <christian@brauner.io>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jann Horn <jannh@google.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Dmitry V. Levin <ldv@altlinux.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-api@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
---
v1: unchanged
v2:
- Christian Brauner <christian@brauner.io>:
  - verify that close_range() correctly closes a single file descriptor
v3:
- Christian Brauner <christian@brauner.io>:
  - add missing Cc for Shuah
  - add missing Cc for linux-kselftest
---
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/core/.gitignore       |   1 +
 tools/testing/selftests/core/Makefile         |   6 +
 .../testing/selftests/core/close_range_test.c | 142 ++++++++++++++++++
 4 files changed, 150 insertions(+)
 create mode 100644 tools/testing/selftests/core/.gitignore
 create mode 100644 tools/testing/selftests/core/Makefile
 create mode 100644 tools/testing/selftests/core/close_range_test.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 9781ca79794a..06e57fabbff9 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -4,6 +4,7 @@ TARGETS += bpf
 TARGETS += breakpoints
 TARGETS += capabilities
 TARGETS += cgroup
+TARGETS += core
 TARGETS += cpufreq
 TARGETS += cpu-hotplug
 TARGETS += drivers/dma-buf
diff --git a/tools/testing/selftests/core/.gitignore b/tools/testing/selftests/core/.gitignore
new file mode 100644
index 000000000000..6e6712ce5817
--- /dev/null
+++ b/tools/testing/selftests/core/.gitignore
@@ -0,0 +1 @@
+close_range_test
diff --git a/tools/testing/selftests/core/Makefile b/tools/testing/selftests/core/Makefile
new file mode 100644
index 000000000000..de3ae68aa345
--- /dev/null
+++ b/tools/testing/selftests/core/Makefile
@@ -0,0 +1,6 @@
+CFLAGS += -g -I../../../../usr/include/ -I../../../../include
+
+TEST_GEN_PROGS := close_range_test
+
+include ../lib.mk
+
diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
new file mode 100644
index 000000000000..d6e6079d3d53
--- /dev/null
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/kernel.h>
+#include <limits.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syscall.h>
+#include <unistd.h>
+
+#include "../kselftest.h"
+
+static inline int sys_close_range(unsigned int fd, unsigned int max_fd,
+				  unsigned int flags)
+{
+	return syscall(__NR_close_range, fd, max_fd, flags);
+}
+
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+#endif
+
+int main(int argc, char **argv)
+{
+	const char *test_name = "close_range";
+	int i, ret;
+	int open_fds[101];
+	int fd_max, fd_mid, fd_min;
+
+	ksft_set_plan(9);
+
+	for (i = 0; i < ARRAY_SIZE(open_fds); i++) {
+		int fd;
+
+		fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
+		if (fd < 0) {
+			if (errno == ENOENT)
+				ksft_exit_skip(
+					"%s test: skipping test since /dev/null does not exist\n",
+					test_name);
+
+			ksft_exit_fail_msg(
+				"%s test: %s - failed to open /dev/null\n",
+				strerror(errno), test_name);
+		}
+
+		open_fds[i] = fd;
+	}
+
+	fd_min = open_fds[0];
+	fd_max = open_fds[99];
+
+	ret = sys_close_range(fd_min, fd_max, 1);
+	if (!ret)
+		ksft_exit_fail_msg(
+			"%s test: managed to pass invalid flag value\n",
+			test_name);
+	ksft_test_result_pass("do not allow invalid flag values for close_range()\n");
+
+	fd_mid = open_fds[50];
+	ret = sys_close_range(fd_min, fd_mid, 0);
+	if (ret < 0)
+		ksft_exit_fail_msg(
+			"%s test: Failed to close range of file descriptors from %d to %d\n",
+			test_name, fd_min, fd_mid);
+	ksft_test_result_pass("close_range() from %d to %d\n", fd_min, fd_mid);
+
+	for (i = 0; i <= 50; i++) {
+		ret = fcntl(open_fds[i], F_GETFL);
+		if (ret >= 0)
+			ksft_exit_fail_msg(
+				"%s test: Failed to close range of file descriptors from %d to %d\n",
+				test_name, fd_min, fd_mid);
+	}
+	ksft_test_result_pass("fcntl() verify closed range from %d to %d\n", fd_min, fd_mid);
+
+	/* create a couple of gaps */
+	close(57);
+	close(78);
+	close(81);
+	close(82);
+	close(84);
+	close(90);
+
+	fd_mid = open_fds[51];
+	/* Choose slightly lower limit and leave some fds for a later test */
+	fd_max = open_fds[92];
+	ret = sys_close_range(fd_mid, fd_max, 0);
+	if (ret < 0)
+		ksft_exit_fail_msg(
+			"%s test: Failed to close range of file descriptors from 51 to 100\n",
+			test_name);
+	ksft_test_result_pass("close_range() from %d to %d\n", fd_mid, fd_max);
+
+	for (i = 51; i <= 92; i++) {
+		ret = fcntl(open_fds[i], F_GETFL);
+		if (ret >= 0)
+			ksft_exit_fail_msg(
+				"%s test: Failed to close range of file descriptors from 51 to 100\n",
+				test_name);
+	}
+	ksft_test_result_pass("fcntl() verify closed range from %d to %d\n", fd_mid, fd_max);
+
+	fd_mid = open_fds[93];
+	fd_max = open_fds[99];
+	/* test that the kernel caps and still closes all fds */
+	ret = sys_close_range(fd_mid, UINT_MAX, 0);
+	if (ret < 0)
+		ksft_exit_fail_msg(
+			"%s test: Failed to close range of file descriptors from 51 to 100\n",
+			test_name);
+	ksft_test_result_pass("close_range() from %d to %d\n", fd_mid, fd_max);
+
+	for (i = 93; i < 100; i++) {
+		ret = fcntl(open_fds[i], F_GETFL);
+		if (ret >= 0)
+			ksft_exit_fail_msg(
+				"%s test: Failed to close range of file descriptors from 51 to 100\n",
+				test_name);
+	}
+	ksft_test_result_pass("fcntl() verify closed range from %d to %d\n", fd_mid, fd_max);
+
+	ret = sys_close_range(open_fds[100], open_fds[100], 0);
+	if (ret < 0)
+		ksft_exit_fail_msg(
+			"%s test: Failed to close single file descriptor\n",
+			test_name);
+	ksft_test_result_pass("close_range() closed single file descriptor\n");
+
+	ret = fcntl(open_fds[100], F_GETFL);
+	if (ret >= 0)
+		ksft_exit_fail_msg(
+			"%s test: Failed to close single file descriptor\n",
+			test_name);
+	ksft_test_result_pass("fcntl() verify closed single file descriptor\n");
+
+	return ksft_exit_pass();
+}
-- 
2.21.0

