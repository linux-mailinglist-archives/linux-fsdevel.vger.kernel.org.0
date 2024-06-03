Return-Path: <linux-fsdevel+bounces-20767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F2D8D7960
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 02:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED45D1C20CDA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 00:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E9711CA0;
	Mon,  3 Jun 2024 00:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vMHc0xIm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1810AAD5F
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 00:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717374806; cv=none; b=XzDX9pjIA3LpZG/ALRSWTrfRNyK8m6QKhZamDHGkdHDq/1hOTOlcnz0SyTZS/EnAarwJKfVdnvKlqrHPVzzKuQiiX6Jmg2nI71V+y1sc/EwShI7vfGCcimhZ7SKhmk197pdKOuCauIvT1ntA9zUg/+eLMjJq/uCBEFZfsn1v2U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717374806; c=relaxed/simple;
	bh=kEKiOFdh5hpyo/igNooYbtGOy+7574G9SztbHRdwO4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IviYWpDJiSRzmizcUIrx2I7KkKGr3fXFuoQQR27XKly/cnFT7E1z4C5Aag7NLQfK3ufKSnOQr9Cj7+yzOK9N+r/VZpluhtqbG+JAhtbXe4FsW35P2SypSeHk0Uk023jVU27bfgi+eDejmWrWnmDpCGIgRHBfWHmAdK24OqvpI1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vMHc0xIm; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717374802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lid2ntMsw00JkkyCn7zuRGFLtASs70M1/6euqfBnjHA=;
	b=vMHc0xImlmkfSN8LhsrQzghIWopuZAElfRf+f441af22PU9ZUB9dOBzOPR/W52K54OE5lJ
	ulGnaHSIEheKlAZ35eLPPSJucr1Gk1tN0GHJw1pOIN7gpiBlfWtWSF1YYoyX4vIn5gBLDX
	VhFiQT9b5tZ2sh/SwGXNGNM3J6EAkR4=
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: axboe@kernel.dk
X-Envelope-To: kent.overstreet@linux.dev
X-Envelope-To: brauner@kernel.org
X-Envelope-To: viro@zeniv.linux.org.uk
X-Envelope-To: bernd.schubert@fastmail.fm
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: josef@toxicpanda.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	linux-mm@kvack.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 5/5] ringbuffer: Userspace test helper
Date: Sun,  2 Jun 2024 20:33:02 -0400
Message-ID: <20240603003306.2030491-6-kent.overstreet@linux.dev>
In-Reply-To: <20240603003306.2030491-1-kent.overstreet@linux.dev>
References: <20240603003306.2030491-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This adds a helper for testing the new ringbuffer syscall using
/dev/ringbuffer-test; it can do performance testing of both normal reads
and writes, and reads and writes via the ringbuffer interface.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 tools/ringbuffer/Makefile          |   3 +
 tools/ringbuffer/ringbuffer-test.c | 254 +++++++++++++++++++++++++++++
 2 files changed, 257 insertions(+)
 create mode 100644 tools/ringbuffer/Makefile
 create mode 100644 tools/ringbuffer/ringbuffer-test.c

diff --git a/tools/ringbuffer/Makefile b/tools/ringbuffer/Makefile
new file mode 100644
index 000000000000..2fb27a19b43e
--- /dev/null
+++ b/tools/ringbuffer/Makefile
@@ -0,0 +1,3 @@
+CFLAGS=-g -O2 -Wall -Werror -I../../include
+
+all: ringbuffer-test
diff --git a/tools/ringbuffer/ringbuffer-test.c b/tools/ringbuffer/ringbuffer-test.c
new file mode 100644
index 000000000000..0fba99e40858
--- /dev/null
+++ b/tools/ringbuffer/ringbuffer-test.c
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/time.h>
+#include <unistd.h>
+
+#define READ	0
+#define WRITE	1
+
+#define min(a, b) (a < b ? a : b)
+
+#define __EXPORTED_HEADERS__
+#include <uapi/linux/ringbuffer_sys.h>
+
+#define BUF_NR		4
+
+typedef uint32_t u32;
+typedef unsigned long ulong;
+
+static inline struct ringbuffer_ptrs *ringbuffer(int fd, int rw, u32 size)
+{
+	ulong addr = 0;
+	int ret = syscall(463, fd, rw, size, &addr);
+	if (ret < 0)
+		errno = -ret;
+	return (void *) addr;
+}
+
+static inline int ringbuffer_wait(int fd, int rw)
+{
+	return syscall(464, fd, rw);
+}
+
+static inline int ringbuffer_wakeup(int fd, int rw)
+{
+	return syscall(465, fd, rw);
+}
+
+static ssize_t ringbuffer_read(int fd, struct ringbuffer_ptrs *rb,
+			       void *buf, size_t len)
+{
+	void *rb_data = (void *) rb + rb->data_offset;
+
+	u32 head, orig_tail = rb->tail, tail = orig_tail;
+
+	while ((head = __atomic_load_n(&rb->head, __ATOMIC_ACQUIRE)) == tail)
+		ringbuffer_wait(fd, READ);
+
+	while (len && head != tail) {
+		u32 tail_masked = tail & rb->mask;
+		unsigned b = min(len,
+			     min(head - tail,
+				 rb->size - tail_masked));
+
+		memcpy(buf, rb_data + tail_masked, b);
+		buf += b;
+		len -= b;
+		tail += b;
+	}
+
+	__atomic_store_n(&rb->tail, tail, __ATOMIC_RELEASE);
+
+	__atomic_thread_fence(__ATOMIC_SEQ_CST);
+
+	if (rb->head - orig_tail >= rb->size)
+		ringbuffer_wakeup(fd, READ);
+
+	return tail - orig_tail;
+}
+
+static ssize_t ringbuffer_write(int fd, struct ringbuffer_ptrs *rb,
+				void *buf, size_t len)
+{
+	void *rb_data = (void *) rb + rb->data_offset;
+
+	u32 orig_head = rb->head, head = orig_head, tail;
+
+	while (head - (tail = __atomic_load_n(&rb->tail, __ATOMIC_ACQUIRE)) >= rb->size)
+		ringbuffer_wait(fd, WRITE);
+
+	while (len && head - tail < rb->size) {
+		u32 head_masked = head & rb->mask;
+		unsigned b = min(len,
+			     min(tail - head + rb->size,
+				 rb->size - head_masked));
+
+		memcpy(rb_data + head_masked, buf, b);
+		buf += b;
+		len -= b;
+		head += b;
+	}
+
+	__atomic_store_n(&rb->head, head, __ATOMIC_RELEASE);
+
+	__atomic_thread_fence(__ATOMIC_SEQ_CST);
+
+	if ((s32) (rb->tail - orig_head) >= 0)
+		ringbuffer_wakeup(fd, WRITE);
+
+	return head - orig_head;
+}
+
+static void usage(void)
+{
+	puts("ringbuffer-test - test ringbuffer syscall\n"
+	     "Usage: ringbuffer-test [OPTION]...\n"
+	     "\n"
+	     "Options:\n"
+	     "      --type=(io|ringbuffer)\n"
+	     "      --rw=(read|write)\n"
+	     "  -h, --help                Display this help and exit\n");
+}
+
+static inline ssize_t rb_test_read(int fd, struct ringbuffer_ptrs *rb,
+				   void *buf, size_t len)
+{
+	return rb
+		? ringbuffer_read(fd, rb, buf, len)
+		: read(fd, buf, len);
+}
+
+static inline ssize_t rb_test_write(int fd, struct ringbuffer_ptrs *rb,
+				    void *buf, size_t len)
+{
+	return rb
+		? ringbuffer_write(fd, rb, buf, len)
+		: write(fd, buf, len);
+}
+
+int main(int argc, char *argv[])
+{
+	const struct option longopts[] = {
+		{ "type",		required_argument,	NULL, 't' },
+		{ "rw",			required_argument,	NULL, 'r' },
+		{ "help",		no_argument,		NULL, 'h' },
+		{ NULL }
+	};
+	int use_ringbuffer = false, rw = false;
+	int opt;
+
+	while ((opt = getopt_long(argc, argv, "h", longopts, NULL)) != -1) {
+		switch (opt) {
+		case 't':
+			if (!strcmp(optarg, "io"))
+				use_ringbuffer = false;
+			else if (!strcmp(optarg, "ringbuffer") ||
+				 !strcmp(optarg, "rb"))
+				use_ringbuffer = true;
+			else {
+				fprintf(stderr, "Invalid type %s\n", optarg);
+				exit(EXIT_FAILURE);
+			}
+			break;
+		case 'r':
+			if (!strcmp(optarg, "read"))
+				rw = false;
+			else if (!strcmp(optarg, "write"))
+				rw = true;
+			else {
+				fprintf(stderr, "Invalid rw %s\n", optarg);
+				exit(EXIT_FAILURE);
+			}
+			break;
+		case '?':
+			fprintf(stderr, "Invalid option %c\n", opt);
+			usage();
+			exit(EXIT_FAILURE);
+		case 'h':
+			usage();
+			exit(EXIT_SUCCESS);
+		}
+	}
+
+	int fd = open("/dev/ringbuffer-test", O_RDWR);
+	if (fd < 0) {
+		fprintf(stderr, "Error opening /dev/ringbuffer-test: %m\n");
+		exit(EXIT_FAILURE);
+	}
+
+	struct ringbuffer_ptrs *rb = NULL;
+	if (use_ringbuffer) {
+		rb = ringbuffer(fd, rw, 4096);
+		if (!rb) {
+			fprintf(stderr, "Error from sys_ringbuffer: %m\n");
+			exit(EXIT_FAILURE);
+		}
+
+		fprintf(stderr, "got ringbuffer %p\n", rb);
+	}
+
+	printf("Starting test with ringbuffer=%u, rw=%u\n", use_ringbuffer, rw);
+	static const char * const rw_str[] = { "read", "wrote" };
+
+	struct timeval start;
+	gettimeofday(&start, NULL);
+	size_t nr_prints = 1;
+
+	u32 buf[BUF_NR];
+	u32 idx = 0;
+
+	while (true) {
+		struct timeval now;
+		gettimeofday(&now, NULL);
+
+		struct timeval next_print = start;
+		next_print.tv_sec += nr_prints;
+
+		if (timercmp(&now, &next_print, >)) {
+			printf("%s %u u32s, %lu mb/sec\n", rw_str[rw], idx,
+			       (idx * sizeof(u32) / (now.tv_sec - start.tv_sec)) / (1UL << 20));
+			nr_prints++;
+			if (nr_prints > 20)
+				break;
+		}
+
+		if (rw == READ) {
+			int r = rb_test_read(fd, rb, buf, sizeof(buf));
+			if (r <= 0) {
+				fprintf(stderr, "Read returned %i (%m)\n", r);
+				exit(EXIT_FAILURE);
+			}
+
+			unsigned nr = r / sizeof(u32);
+			for (unsigned i = 0; i < nr; i++) {
+				if (buf[i] != idx + i) {
+					fprintf(stderr, "Read returned wrong data at idx %u: got %u instead\n",
+						idx + i, buf[i]);
+					exit(EXIT_FAILURE);
+				}
+			}
+
+			idx += nr;
+		} else {
+			for (unsigned i = 0; i < BUF_NR; i++)
+				buf[i] = idx + i;
+
+			int r = rb_test_write(fd, rb, buf, sizeof(buf));
+			if (r <= 0) {
+				fprintf(stderr, "Write returned %i (%m)\n", r);
+				exit(EXIT_FAILURE);
+			}
+
+			unsigned nr = r / sizeof(u32);
+			idx += nr;
+		}
+	}
+
+	exit(EXIT_SUCCESS);
+}
-- 
2.45.1


