Return-Path: <linux-fsdevel+bounces-53029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AABE2AE92A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 01:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 208FA1885219
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 23:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466353093BC;
	Wed, 25 Jun 2025 23:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="t1U6E5zd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A8930B984
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 23:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893584; cv=none; b=SJzKrx1mo3oi8TjcdrgQJMvqHdhSXsG0Z70HwRLkqZ3PaGRRhSiW4BF4Le/BY9I/pgubAjeZz7+PrqKSjU7eBY7nCZU9sNMTVVnvRFmaL3dNeT4cH6rJhu0zVNgLbuppevdNxcJokWFORny0mQeV1fcNz9pydSEmDdokiyGK1H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893584; c=relaxed/simple;
	bh=8l0K6QJ4RkWllZcpyZGwgZlU9m1P2gnk5TToNIUeT/Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmMxGNiQZhLASCVxczhL8FzcNciEdMXirF6ehe/T+5UM5VIe/APuwhoVwaX57NwktGvsFA64Whz4TJd+ftDZW+t5Jzn4jxI8+EbYX3Jn68AN0SCTv+N4j/ZJZ8DDyGWBdGMqixx77ejWVT4kuk9eD90hBIcdZEdi/46E88u3ijk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=t1U6E5zd; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e81a7d90835so317567276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 16:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1750893580; x=1751498380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=60o0+pILn7oYpaQU4GzfpCaIJI/wVLOztDCQbTE/8Fw=;
        b=t1U6E5zd7n4RDB1Q3z5zU4DqXcrvp+PPKVVlu77s/frc2wqrUNSkkAI218tRB30EFE
         qJ/Vd4zkTz96nagnCxTk/alKLL976lwsBCwuDmJ8cKbPYyFtaxWBYrFaoSBO1tWeMvzv
         59UjCELAnCENBcgTNf9XWZzjJ3/mUfmZIG+Ee4tvndYbVfq/mzow05R5uImnKnmTyvcr
         IVgQGSsXAA+30VKFN6VSxaSuen26ZM0A5R50j/us+Fy8t+qg5t2SWr69AeZx7Vr1vvlx
         F6UnKDAV7gI63Td5TCm/oeU858iThERqz6TXiauhP2NJTxaOFb02QAtZCSoeMVwvDel4
         Ac4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750893580; x=1751498380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60o0+pILn7oYpaQU4GzfpCaIJI/wVLOztDCQbTE/8Fw=;
        b=bI/5e78rqjx9Szkb+Dm4dJbf7VCZRMhjOYW6+tdmBO+9MS52eymFqWnFn6bgpMq/46
         Rbp4iuIqprQ9IZr34h9O1JSgiyG31gVzGN3f/cELAd56iykkfeKjFuuFTfSg/5uslYgR
         28REo9sYSdaI6rTuDdtCRRCF3SkovlSHCgPgTmsU/Ji8RnAVlYT1FFVG6BzvoHqMpuxZ
         kSYcIgKHeoO3nwXgEZNY1ZjXlDyhWc9HO6Kpauu4THYf/VPBoANlaeMUaVI3zPiRBbpc
         dKNCEQYRK4hn8tHx5rNsCd9jVyuXZQfoW0QkUDO4vGH8MPwI31i+QYynkRsCzpuB7hrY
         FVeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf4MEdrqeBEQtiaSIRCM3ab2yiHrySULDvJGVL5Xa0q8q7JjnPeQiojmqN2buQz5d2Ex32R4p0VT7e7emh@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0CfBVGbaoOOV18GmZLeycGYrYlg0iALiWP1Sl6Ocgm2Nor0+E
	JUB5ZbYjhnQ+SChMsqpyDUHy+t31qPMpmvUYgGj6uP6CGWQbgKKEmXw+rQMOKeqjxqs=
X-Gm-Gg: ASbGncvzjnw5xyXlCBmKRjC78z9sMNblmf1KxzSY69SMNmqtR5pLM37z9w5htQvjdkp
	+TkBzZMXgqSIMvBYi2giSLS2iNZvpEywSfok0B+NCvi3/Cdd4dVxV6KUyl1+J5vdd9C/48lW5B/
	j98wbBUN0jQpkJOvgf8Tn3wyLKi9Ql0kk4tsCcsmo5UDeO780q9AJ7Qi6th+Gz9dt+O2yPQpufS
	OjfNhJE2330WM36kX3IErfPDYG9ce0lphiQopSzFdyPjZ1F/FtD6smsenPh73Eb5VwKC3X5ziNo
	T7nelVVDwiTUP6PHv4lzIKgFloivEVqBQWSBM9OZ1uN2mKUPVBN6wmVcBu13BPUtvnlA0iUznB2
	00Xfv4v/dWQAxNGtXJsAGIOKRdccmpiEtOLSYPSNfQVM3I4losPLH
X-Google-Smtp-Source: AGHT+IGMtC4mqGRTCqwsD7zQuJKELdqefWUDOU17sadjrHFNIDwPtfJBpjKQ/cUFNH+/Umt7SFD3zg==
X-Received: by 2002:a05:6902:90d:b0:e84:43bd:e9b6 with SMTP id 3f1490d57ef6-e86016f89damr6516568276.13.1750893580131;
        Wed, 25 Jun 2025 16:19:40 -0700 (PDT)
Received: from soleen.c.googlers.com.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842ac5c538sm3942684276.33.2025.06.25.16.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 16:19:39 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC v1 32/32] libluo: add tests
Date: Wed, 25 Jun 2025 23:18:19 +0000
Message-ID: <20250625231838.1897085-33-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pratyush Yadav <ptyadav@amazon.de>

Add a test suite for libluo itself, and for the kernel LUO interface.
The below tests are added:

1. init - Tests the initialization and cleanup functions of libluo.

2. state - Tests the luo_get_state() API, which in turn tests the
LIVEUPDATE_IOCTL_GET_STATE ioctl

3. preserve - Creates a memfd, preserves it, puts LUO in prepared state,
   cancels liveupdate, and makes sure memfd is functional.

4. prepared - Puts a memfd in LUO enters prepared state. Then it
   makes sure the memfd stays functional but remains in restricted mode. It
   makes sure the memfd can't grow or shrink, but can be read from or
   written to.

5. transitions - Tests transitions from normal to prepared to cancel
   state work.

6. error - Tests error handling of the library on invalid inputs.

7. kexec - Tests the main functionality of LUO -- preserving a FD over
   kexec. It creates a memfd with random data, saves the data to a file on
   disk, and then preserves the FD and goes into prepared state. Now the
   test runner must perform a kexec. Once rebooted, running the test again
   resumes the test. It fetches the memfd back, nd compares its content
   with the saved data on disk.

A specific test can be selected or excluded uring the -t or -e arguments.

Sample run:

    $ ./test
    LibLUO Test Suite
    =================

    Testing initialization and cleanup... PASSED
    Testing get_state... PASSED (current state: normal)
    Testing state transitions... PASSED
    Testing fd_preserve with freeze and cancel... PASSED
    Testing operations on prepared memfd... PASSED
    Testing error handling... PASSED
    Testing fd preserve for kexec... READY FOR KEXEC (token: 3)
    Run kexec now and then run this test again to complete.

    All requested tests completed.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 tools/lib/luo/Makefile         |   4 +
 tools/lib/luo/tests/.gitignore |   1 +
 tools/lib/luo/tests/Makefile   |  18 +
 tools/lib/luo/tests/test.c     | 848 +++++++++++++++++++++++++++++++++
 4 files changed, 871 insertions(+)
 create mode 100644 tools/lib/luo/tests/.gitignore
 create mode 100644 tools/lib/luo/tests/Makefile
 create mode 100644 tools/lib/luo/tests/test.c

diff --git a/tools/lib/luo/Makefile b/tools/lib/luo/Makefile
index e8f6bd3b9e85..ef4c489efcc5 100644
--- a/tools/lib/luo/Makefile
+++ b/tools/lib/luo/Makefile
@@ -29,9 +29,13 @@ $(SHARED_LIB): $(OBJS)
 cli: $(STATIC_LIB)
 	$(MAKE) -C cli
 
+tests: $(STATIC_LIB)
+	$(MAKE) -C tests
+
 clean:
 	rm -f $(OBJS) $(STATIC_LIB) $(SHARED_LIB)
 	$(MAKE) -C cli clean
+	$(MAKE) -C tests clean
 
 install: all
 	install -d $(DESTDIR)/usr/local/lib
diff --git a/tools/lib/luo/tests/.gitignore b/tools/lib/luo/tests/.gitignore
new file mode 100644
index 000000000000..ee4c92682341
--- /dev/null
+++ b/tools/lib/luo/tests/.gitignore
@@ -0,0 +1 @@
+/test
diff --git a/tools/lib/luo/tests/Makefile b/tools/lib/luo/tests/Makefile
new file mode 100644
index 000000000000..7f4689722ff6
--- /dev/null
+++ b/tools/lib/luo/tests/Makefile
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: LGPL-3.0-or-later
+TESTS = test
+INCLUDE_DIR = ../include
+HEADERS = $(wildcard $(INCLUDE_DIR)/*.h)
+
+CC = gcc
+CFLAGS = -Wall -Wextra -O2 -g -I$(INCLUDE_DIR)
+LDFLAGS = -L.. -l:libluo.a
+
+.PHONY: all clean
+
+all: $(TESTS)
+
+test: test.c ../libluo.a $(HEADERS)
+	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS)
+
+clean:
+	rm -f $(TESTS)
diff --git a/tools/lib/luo/tests/test.c b/tools/lib/luo/tests/test.c
new file mode 100644
index 000000000000..7963ae8ebadf
--- /dev/null
+++ b/tools/lib/luo/tests/test.c
@@ -0,0 +1,848 @@
+// SPDX-License-Identifier: LGPL-3.0-or-later
+#define _GNU_SOURCE
+/**
+ * @file test.c
+ * @brief Test program for the LibLUO library
+ *
+ * This program tests the basic functionality of the LibLUO library.
+ *
+ * Copyright (C) 2025 Amazon.com Inc. or its affiliates.
+ * Author: Pratyush Yadav <ptyadav@amazon.de>
+ */
+
+#include <libluo.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <errno.h>
+#include <sys/mman.h>
+#include <getopt.h>
+
+/* Path to store token for kexec test */
+#define TOKEN_FILE		"libluo_test_token"
+#define TEST_DATA_FILE		"libluo_test_data"
+#define MEMFD_NAME		"libluo_test_memfd"
+
+/* Size of the random data buffer (1 MiB) */
+#define RANDOM_BUFFER_SIZE	(1 << 20)
+static char random_buffer[RANDOM_BUFFER_SIZE];
+
+/* Test IDs */
+#define TEST_INIT_CLEANUP	(1 << 0)
+#define TEST_GET_STATE		(1 << 1)
+#define TEST_FD_PRESERVE	(1 << 2)
+#define TEST_ERROR_HANDLING	(1 << 3)
+#define TEST_FD_KEXEC		(1 << 4)
+#define TEST_FD_PREPARED	(1 << 5)
+#define TEST_STATE_TRANSITIONS	(1 << 6)
+#define TEST_ALL		(TEST_INIT_CLEANUP | TEST_GET_STATE | \
+				 TEST_FD_PRESERVE | TEST_ERROR_HANDLING | \
+				 TEST_FD_KEXEC | TEST_FD_PREPARED | \
+				 TEST_STATE_TRANSITIONS)
+
+/*
+ * luo_fd_preserve() needs a unique token. Generate a monotonically increasing
+ * token.
+ */
+static uint64_t next_token()
+{
+	static uint64_t token = 0;
+
+	return token++;
+}
+
+/* Read exactly specified size from fd. Any less results in error. */
+static int read_size(int fd, char *buffer, size_t size)
+{
+	size_t remain = size;
+	ssize_t bytes_read;
+
+	while (remain) {
+		bytes_read = read(fd, buffer, remain);
+		if (bytes_read == 0)
+			return -ENODATA;
+		if (bytes_read < 0)
+			return -errno;
+
+		remain -= bytes_read;
+	}
+
+	return 0;
+}
+
+/* Write exactly specified size from fd. Any less results in error. */
+static int write_size(int fd, const char *buffer, size_t size)
+{
+	size_t remain = size;
+	ssize_t written;
+
+	while (remain) {
+		written = write(fd, buffer, remain);
+		if (written == 0)
+			return -EIO;
+		if (written < 0)
+			return -errno;
+
+		remain -= written;
+	}
+
+	return 0;
+}
+
+static int generate_random_data(char *buffer, size_t size)
+{
+	int fd, ret;
+
+	fd = open("/dev/urandom", O_RDONLY);
+	if (fd < 0)
+		return -errno;
+
+	ret = read_size(fd, buffer, size);
+	close(fd);
+	return ret;
+}
+
+static int save_test_data(const char *buffer, size_t size)
+{
+	int fd, ret;
+
+	fd = open(TEST_DATA_FILE, O_RDWR);
+	if (fd < 0)
+		return -errno;
+
+	ret = write_size(fd, buffer, size);
+	close(fd);
+	return ret;
+}
+
+static int load_test_data(char *buffer, size_t size)
+{
+	int fd, ret;
+
+	fd = open(TEST_DATA_FILE, O_RDONLY);
+	if (fd < 0)
+		return -errno;
+
+	ret = read_size(fd, buffer, size);
+	close(fd);
+	return ret;
+}
+
+/* Create and initialize a memfd with random data. */
+static int create_test_fd(const char *memfd_name, char *buffer, size_t size)
+{
+	int fd;
+	int ret;
+
+	fd = memfd_create(memfd_name, 0);
+	if (fd < 0)
+		return -errno;
+
+	ret = generate_random_data(buffer, size);
+	if (ret < 0) {
+		close(fd);
+		return ret;
+	}
+
+	if (write_size(fd, buffer, size) < 0) {
+		close(fd);
+		return -errno;
+	}
+
+	/* Reset file position to beginning */
+	if (lseek(fd, 0, SEEK_SET) < 0) {
+		close(fd);
+		return -errno;
+	}
+
+	return fd;
+}
+
+/*
+ * Make sure fd contains expected data up to size. Returns 0 on success, 1 on
+ * data mismatch, -errno on error.
+ */
+static int verify_fd_content(int fd, const char *expected_data, size_t size)
+{
+	char buffer[size];
+	int ret;
+
+	/* Reset file position to beginning */
+	if (lseek(fd, 0, SEEK_SET) < 0)
+		return -errno;
+
+	ret = read_size(fd, buffer, size);
+	if (ret < 0)
+		return ret;
+
+	if (memcmp(buffer, expected_data, size) != 0)
+		return 1;
+
+	return 0;
+}
+
+/* Save token to file for kexec test. */
+static int save_token(uint64_t token)
+{
+	FILE *file = fopen(TOKEN_FILE, "w");
+
+	if (!file)
+		return -errno;
+
+	if (fprintf(file, "%lu", token) < 0) {
+		fclose(file);
+		return -errno;
+	}
+
+	fclose(file);
+	return 0;
+}
+
+/* Load token from file for kexec test. */
+static int load_token(uint64_t *token)
+{
+	FILE *file = fopen(TOKEN_FILE, "r");
+
+	if (!file)
+		return -errno;
+
+	if (fscanf(file, "%lu", token) != 1) {
+		fclose(file);
+		return -EINVAL;
+	}
+
+	fclose(file);
+	return 0;
+}
+
+/* Test initialization and cleanup */
+static void test_init_cleanup(void)
+{
+	int ret;
+
+	printf("Testing initialization and cleanup... ");
+
+	ret = luo_init();
+	if (ret < 0) {
+		printf("FAILED (init: %s)\n", strerror(-ret));
+		return;
+	}
+
+	luo_cleanup();
+	printf("PASSED\n");
+}
+
+/* Test getting LUO state */
+static void test_get_state(void)
+{
+	int ret;
+	enum liveupdate_state state;
+
+	printf("Testing get_state... ");
+
+	ret = luo_init();
+	if (ret < 0) {
+		printf("FAILED (init: %s)\n", strerror(-ret));
+		return;
+	}
+
+	ret = luo_get_state(&state);
+	if (ret < 0) {
+		printf("FAILED (get_state: %s)\n", strerror(-ret));
+		luo_cleanup();
+		return;
+	}
+
+	printf("PASSED (current state: %s)\n", luo_state_to_string(state));
+	luo_cleanup();
+}
+
+/* Test preserving and unpreserving a file descriptor with prepare and cancel */
+static void test_fd_preserve_unpreserve(void)
+{
+	uint64_t token = next_token();
+	int ret, fd = -1;
+
+	printf("Testing fd_preserve with freeze and cancel... ");
+
+	ret = luo_init();
+	if (ret < 0) {
+		printf("FAILED (init: %s)\n", strerror(-ret));
+		return;
+	}
+
+	fd = create_test_fd(MEMFD_NAME, random_buffer, sizeof(random_buffer));
+	if (fd < 0) {
+		ret = fd;
+		printf("FAILED (create_test_fd: %s)\n", strerror(-ret));
+		goto out_cleanup;
+	}
+
+	ret = luo_fd_preserve(fd, token);
+	if (ret < 0) {
+		printf("FAILED (preserve: %s)\n", strerror(-ret));
+		goto out_close_fd;
+	}
+
+	ret = luo_prepare();
+	if (ret < 0) {
+		printf("FAILED (prepare: %s)\n", strerror(-ret));
+		goto out_unpreserve;
+	}
+
+	ret = luo_cancel();
+	if (ret < 0) {
+		printf("FAILED (cancel: %s)\n", strerror(-ret));
+		goto out_unpreserve;
+	}
+
+	ret = luo_fd_unpreserve(token);
+	if (ret < 0) {
+		printf("FAILED (unpreserve: %s)\n", strerror(-ret));
+		goto out_close_fd;
+	}
+
+	ret = verify_fd_content(fd, random_buffer, sizeof(random_buffer));
+	if (ret < 0) {
+		printf("FAILED (verify_fd_content: %s)\n",
+		       ret == 1 ? "data mismatch" : strerror(-ret));
+		goto out_close_fd;
+	}
+
+	printf("PASSED\n");
+	goto out_close_fd;
+
+out_unpreserve:
+	luo_fd_unpreserve(token);
+out_close_fd:
+	close(fd);
+out_cleanup:
+	luo_cleanup();
+}
+
+/* Test error handling with invalid inputs. */
+static void test_error_handling(void)
+{
+	int ret;
+
+	printf("Testing error handling... ");
+
+	ret = luo_init();
+	if (ret < 0) {
+		printf("FAILED (init: %s)\n", strerror(-ret));
+		return;
+	}
+
+	/* Test with invalid file descriptor */
+	ret = luo_fd_preserve(-1, next_token());
+	if (ret != -EINVAL) {
+		printf("FAILED (expected EINVAL for invalid fd, got %d)\n", ret);
+		luo_cleanup();
+		return;
+	}
+
+	/* Test with NULL state pointer */
+	ret = luo_get_state(NULL);
+	if (ret != -EINVAL) {
+		printf("FAILED (expected EINVAL for NULL state, got %d)\n", ret);
+		luo_cleanup();
+		return;
+	}
+
+	luo_cleanup();
+	printf("PASSED\n");
+}
+
+/* Test preserving a file descriptor for kexec reboot */
+static void test_fd_preserve_for_kexec(void)
+{
+	enum liveupdate_state state;
+	int fd = -1, ret;
+	uint64_t token;
+
+	ret = luo_init();
+	if (ret < 0) {
+		printf("FAILED (init: %s)\n", strerror(-ret));
+		return;
+	}
+
+	/* Check if we're in post-kexec state */
+	ret = luo_get_state(&state);
+	if (ret < 0) {
+		printf("FAILED (get_state: %s)\n", strerror(-ret));
+		goto out_cleanup;
+	}
+
+	if (state == LIVEUPDATE_STATE_UPDATED) {
+		/* Post-kexec: restore the file descriptor */
+		printf("Testing memfd restore after kexec... ");
+
+		ret = load_token(&token);
+		if (ret < 0) {
+			printf("FAILED (load_token: %s)\n", strerror(-ret));
+			goto out_cleanup;
+		}
+
+		ret = load_test_data(random_buffer, RANDOM_BUFFER_SIZE);
+		if (ret < 0) {
+			printf("FAILED (load_test_data: %s)\n", strerror(-ret));
+			goto out_cleanup;
+		}
+
+		ret = luo_fd_restore(token, &fd);
+		if (ret < 0) {
+			printf("FAILED (restore: %s)\n", strerror(-ret));
+			goto out_cleanup;
+		}
+
+		/* Verify the file descriptor content with stored data. */
+		ret = verify_fd_content(fd, random_buffer, RANDOM_BUFFER_SIZE);
+		if (ret) {
+			printf("FAILED (verify_fd_content: %s)\n",
+			       ret == 1 ? "data mismatch" : strerror(-ret));
+			goto out_close_fd;
+		}
+
+		ret = luo_finish();
+		if (ret < 0) {
+			printf("FAILED (finish: %s)\n", strerror(-ret));
+			goto out_close_fd;
+		}
+
+		printf("PASSED\n");
+		goto out_close_fd;
+	} else {
+		/* Pre-kexec: preserve the file descriptor */
+		printf("Testing fd preserve for kexec... ");
+
+		fd = create_test_fd(MEMFD_NAME, random_buffer, RANDOM_BUFFER_SIZE);
+		if (fd < 0) {
+			ret = fd;
+			printf("FAILED (create_test_fd: %s)\n", strerror(-ret));
+			goto out_cleanup;
+		}
+
+		/* Save random data to file for post-kexec verification */
+		ret = save_test_data(random_buffer, RANDOM_BUFFER_SIZE);
+		if (ret < 0) {
+			printf("FAILED (save_test_data: %s)\n", strerror(-ret));
+			goto out_close_fd;
+		}
+
+		token = next_token();
+		ret = luo_fd_preserve(fd, token);
+		if (ret < 0) {
+			printf("FAILED (preserve: %s)\n", strerror(-ret));
+			goto out_close_fd;
+		}
+
+		/* Save token to file for post-kexec restoration */
+		ret = save_token(token);
+		if (ret < 0) {
+			printf("FAILED (save_token: %s)\n", strerror(-ret));
+			goto out_unpreserve;
+		}
+
+		ret = luo_prepare();
+		if (ret < 0) {
+			printf("FAILED (prepare: %s)\n", strerror(-ret));
+			goto out_unpreserve;
+		}
+
+		printf("READY FOR KEXEC (token: %lu)\n", token);
+		printf("Run kexec now and then run this test again to complete.\n");
+
+		/* Note: At this point, the system should perform kexec reboot.
+		 * The test will continue in the new kernel with the
+		 * LIVEUPDATE_STATE_UPDATED state.
+		 *
+		 * Since the FD is now preserved, we can close it.
+		 */
+		goto out_close_fd;
+	}
+
+out_unpreserve:
+	luo_fd_unpreserve(token);
+out_close_fd:
+	close(fd);
+out_cleanup:
+	luo_cleanup();
+}
+
+/*
+ * Test that prepared memfd can't grow or shrink, but reads and writes still
+ * work.
+ */
+static void test_fd_prepared_operations(void)
+{
+	char write_buffer[128] = {'A'};
+	size_t initial_size, file_size;
+	int ret, fd = -1;
+	uint64_t token;
+
+	printf("Testing operations on prepared memfd... ");
+
+	ret = luo_init();
+	if (ret < 0) {
+		printf("FAILED (init: %s)\n", strerror(-ret));
+		return;
+	}
+
+	/* Create and initialize test file descriptor */
+	fd = create_test_fd(MEMFD_NAME, random_buffer, sizeof(random_buffer));
+	if (fd < 0) {
+		ret = fd;
+		printf("FAILED (create_test_fd: %s)\n", strerror(-ret));
+		goto out_cleanup;
+	}
+
+	/* Get initial file size */
+	ret = lseek(fd, 0, SEEK_END);
+	if (ret < 0) {
+		printf("FAILED (lseek to end: %s)\n", strerror(errno));
+		goto out_close_fd;
+	}
+	initial_size = (size_t)ret;
+
+	token = next_token();
+	ret = luo_fd_preserve(fd, token);
+	if (ret < 0) {
+		printf("FAILED (preserve: %s)\n", strerror(-ret));
+		goto out_close_fd;
+	}
+
+	ret = luo_prepare();
+	if (ret < 0) {
+		printf("FAILED (prepare: %s)\n", strerror(-ret));
+		goto out_unpreserve;
+	}
+
+	/* Test 1: Write to the prepared file descriptor (within existing size) */
+	if (lseek(fd, 0, SEEK_SET) < 0) {
+		printf("FAILED (lseek before write: %s)\n", strerror(errno));
+		goto out_cancel;
+	}
+
+	/* Write buffer is smaller than total file size. */
+	ret = write_size(fd, write_buffer, sizeof(write_buffer));
+	if (ret < 0) {
+		printf("FAILED (write to prepared fd: %s)\n", strerror(errno));
+		goto out_cancel;
+	}
+
+	ret = verify_fd_content(fd, write_buffer, sizeof(write_buffer));
+	if (ret) {
+		printf("FAILED (verify_fd_content after write: %s)\n",
+		       ret == 1 ? "data mismatch" : strerror(-ret));
+		goto out_cancel;
+	}
+
+	/* Test 2: Try to grow the file using write(). */
+
+	/* First, seek to one byte behind initial size. */
+	ret = lseek(fd, initial_size - 1, SEEK_SET);
+	if (ret < 0) {
+		printf("FAILED: (lseek after write verification: %s)\n",
+		       strerror(errno));
+	}
+
+	/*
+	 * Then, write some data that should increase the file size. This should
+	 * fail.
+	 */
+	ret = write_size(fd, write_buffer, sizeof(write_buffer));
+	if (ret == 0) {
+		printf("FAILED: (write beyond initial size succeeded)\n");
+		goto out_cancel;
+	}
+
+	ret = lseek(fd, 0, SEEK_END);
+	if (ret < 0) {
+		printf("FAILED (lseek after larger write: %s)\n", strerror(errno));
+		goto out_cancel;
+	}
+	file_size = (size_t)ret;
+
+	if (file_size != initial_size) {
+		printf("FAILED (file grew beyond initial size: %zu != %zu)\n",
+		       (size_t)file_size, initial_size);
+		goto out_cancel;
+	}
+
+	/* Test 3: Try to shrink the file using truncate */
+	ret = ftruncate(fd, initial_size / 2);
+	if (ret == 0) {
+		printf("FAILED (file was truncated)\n");
+		goto out_cancel;
+	}
+
+	ret = lseek(fd, 0, SEEK_END);
+	if (ret < 0) {
+		printf("FAILED (lseek after shrink attempt: %s)\n", strerror(errno));
+		goto out_cancel;
+	}
+	file_size = (size_t)ret;
+
+	if (file_size != initial_size) {
+		printf("FAILED (file shrunk from initial size: %zu != %zu)\n",
+		       (size_t)file_size, initial_size);
+		goto out_cancel;
+	}
+
+	ret = luo_cancel();
+	if (ret < 0) {
+		printf("FAILED (cancel: %s)\n", strerror(-ret));
+		goto out_unpreserve;
+	}
+
+	ret = luo_fd_unpreserve(token);
+	if (ret < 0) {
+		printf("FAILED (unpreserve: %s)\n", strerror(-ret));
+		goto out_close_fd;
+	}
+
+	printf("PASSED\n");
+	goto out_close_fd;
+
+out_cancel:
+	luo_cancel();
+out_unpreserve:
+	luo_fd_unpreserve(token);
+out_close_fd:
+	close(fd);
+out_cleanup:
+	luo_cleanup();
+}
+
+static int test_prepare_cancel_sequence(const char *sequence_name)
+{
+	int ret;
+	enum liveupdate_state state;
+
+	/* Initial state should be NORMAL */
+	ret = luo_get_state(&state);
+	if (ret < 0) {
+		printf("FAILED (%s get initial state failed: %s)\n",
+		       sequence_name, strerror(-ret));
+		return ret;
+	}
+
+	if (state != LIVEUPDATE_STATE_NORMAL) {
+		printf("FAILED (%s unexpected initial state: %s)\n",
+		       sequence_name, luo_state_to_string(state));
+		return -EINVAL;
+	}
+
+	/* Test NORMAL -> PREPARED transition */
+	ret = luo_prepare();
+	if (ret < 0) {
+		printf("FAILED (%s prepare failed: %s)\n",
+		       sequence_name, strerror(-ret));
+		return ret;
+	}
+
+	ret = luo_get_state(&state);
+	if (ret < 0) {
+		printf("FAILED (%s get state after prepare failed: %s)\n",
+		       sequence_name, strerror(-ret));
+		goto out_cancel;
+	}
+
+	if (state != LIVEUPDATE_STATE_PREPARED) {
+		printf("FAILED (%s expected PREPARED state, got %s)\n",
+		       sequence_name, luo_state_to_string(state));
+		ret = -EINVAL;
+		goto out_cancel;
+	}
+
+	/* Test PREPARED -> NORMAL transition via cancel */
+	ret = luo_cancel();
+	if (ret < 0) {
+		printf("FAILED (%s cancel failed: %s)\n",
+		       sequence_name, strerror(-ret));
+		return ret;
+	}
+
+	ret = luo_get_state(&state);
+	if (ret < 0) {
+		printf("FAILED (%s get state after cancel failed: %s)\n",
+		       sequence_name, strerror(-ret));
+		return ret;
+	}
+
+	if (state != LIVEUPDATE_STATE_NORMAL) {
+		printf("FAILED (%s expected NORMAL state after cancel, got %s)\n",
+		       sequence_name, luo_state_to_string(state));
+		return -EINVAL;
+	}
+
+	return 0;
+
+out_cancel:
+	luo_cancel();
+	return ret;
+}
+
+/* Test all state transitions */
+static void test_state_transitions(void)
+{
+	int ret;
+
+	printf("Testing state transitions... ");
+
+	ret = luo_init();
+	if (ret < 0) {
+		printf("FAILED (init failed: %s)\n", strerror(-ret));
+		return;
+	}
+
+	/* Test first prepare -> cancel sequence */
+	ret = test_prepare_cancel_sequence("first");
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * Test second prepare -> freeze -> cancel sequence in case the
+	 * previous cancellation left some side effects.
+	 */
+	ret = test_prepare_cancel_sequence("second");
+	if (ret < 0)
+		goto out;
+
+	printf("PASSED\n");
+
+out:
+	luo_cleanup();
+}
+
+/* Test name to flag mapping */
+struct test {
+	const char *name;
+	void (*fn)(void);
+	unsigned int flag;
+};
+
+/* Array of test names and their corresponding flags */
+static struct test tests[] = {
+	{"init", test_init_cleanup, TEST_INIT_CLEANUP},
+	{"state", test_get_state, TEST_GET_STATE},
+	{"transitions", test_state_transitions, TEST_STATE_TRANSITIONS},
+	{"preserve", test_fd_preserve_unpreserve, TEST_FD_PRESERVE},
+	{"prepared", test_fd_prepared_operations, TEST_FD_PREPARED},
+	{"error", test_error_handling, TEST_ERROR_HANDLING},
+	{"kexec", test_fd_preserve_for_kexec, TEST_FD_KEXEC},
+	{NULL, NULL, 0}
+};
+
+static int parse_test_names(char *arg, unsigned int *flags)
+{
+	char *name;
+	struct test *test;
+
+	*flags = 0;
+	name = strtok(arg, ",");
+
+	while (name != NULL) {
+		test = tests;
+		while (test->name) {
+			if (strcmp(name, test->name) == 0) {
+				*flags |= test->flag;
+				break;
+			}
+			test++;
+		}
+
+		/* Check if we found a match */
+		if (!test->name) {
+			printf("Unknown test: %s\n", name);
+			return 1;
+		}
+
+		name = strtok(NULL, ",");
+	}
+
+	return 0;
+}
+
+static void usage(const char *program_name)
+{
+	printf("Usage: %s [options]\n", program_name);
+	printf("Options:\n");
+	printf("  -h, --help                 Show this help message\n");
+	printf("  -t, --test=TEST_ID         Run specific test(s)\n");
+	printf("  -e, --exclude=TEST_ID      Exclude specific test(s)\n");
+	printf("\n");
+	printf("Test IDs:\n");
+	printf("  init        - Test initialization and cleanup\n");
+	printf("  state       - Test getting LUO state\n");
+	printf("  preserve    - Test memfd preserve/unpreserve with freeze/cancel\n");
+	printf("  prepared    - Test memfd functions can read/write but not grow after prepare\n");
+	printf("  transitions - Test all state transitions (NORMAL->PREPARED->FROZEN->NORMAL)\n");
+	printf("  error       - Test error handling\n");
+	printf("  kexec       - Test memfd preserve for kexec\n");
+	printf("\n");
+	printf("Multiple tests can be specified with comma separation.\n");
+	printf("Example: %s --test=init,state --exclude=kexec\n", program_name);
+	printf("By default, all tests are run.\n");
+}
+
+int main(int argc, char *argv[])
+{
+	unsigned int tests_to_run = TEST_ALL;
+	unsigned int tests_to_exclude = 0;
+	struct option long_options[] = {
+		{"help", no_argument, 0, 'h'},
+		{"test", required_argument, 0, 't'},
+		{"exclude", required_argument, 0, 'e'},
+		{0, 0, 0, 0}
+	};
+	struct test *test;
+	int opt;
+
+	printf("LibLUO Test Suite\n");
+	printf("=================\n\n");
+
+	if (!luo_is_available()) {
+		printf("LUO is not available on this system. Skipping tests.\n");
+		return 0;
+	}
+
+	while ((opt = getopt_long(argc, argv, "ht:e:", long_options, NULL)) != -1) {
+		switch (opt) {
+		case 'h':
+			usage(argv[0]);
+			return 0;
+		case 't':
+			if (parse_test_names(optarg, &tests_to_run))
+				return 1;
+			break;
+		case 'e':
+			if (parse_test_names(optarg, &tests_to_exclude))
+				return 1;
+			break;
+		default:
+			printf("Try '%s --help' for more information.\n", argv[0]);
+			return 1;
+		}
+	}
+
+	/* Apply exclusions to the tests to run */
+	tests_to_run &= ~tests_to_exclude;
+	if (!tests_to_run) {
+		printf("ERROR: all tests excluded\n");
+		return 1;
+	}
+
+	/* Run selected tests */
+	test = tests;
+	while (test->name) {
+		if (tests_to_run & test->flag)
+			test->fn();
+		test++;
+	}
+
+	printf("\nAll requested tests completed.\n");
+	return 0;
+}
-- 
2.50.0.727.gbf7dc18ff4-goog


