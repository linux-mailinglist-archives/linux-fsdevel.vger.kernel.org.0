Return-Path: <linux-fsdevel+bounces-21005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE03B8FC0BB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 02:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937942820F5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 00:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5291144D02;
	Wed,  5 Jun 2024 00:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opmt81wZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCD613D291;
	Wed,  5 Jun 2024 00:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547145; cv=none; b=W7O43i766cD7hoUecK2PYrbGFwvQa3W6HX++Dh/PGQhALErp4m2Ft5hHjg7pSs6t+btJUU6vCuAbe7mmNX7ojYnXXC3Hu1bwl5dNGUUwfc+jAQ7C3LN3Qlj6l4MIjC+hUkvSowZZEiEUA0xf66RKY6Buqj6BdKhNtQY/tQ8WXRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547145; c=relaxed/simple;
	bh=6bfQltsebIDFmP7fT8/qzCkTKSF6gxCrj2vhm2ulkGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S7PhYT2qPQvo3cC/E3itLqB7LwuvOfKTcDcQtchXo5yMcghqeQkXNIx86Us5bDm48HtneVd+tjDLxy8ePGNDz7pKE8xMOVNZIe3Grh4jPtYX6BtNIgWWDCsMhzGvUS7mCYnRueEVyuyEwNVOeAC7j322qp3e0e2O7ua1K3b8OHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opmt81wZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DDFC2BBFC;
	Wed,  5 Jun 2024 00:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717547145;
	bh=6bfQltsebIDFmP7fT8/qzCkTKSF6gxCrj2vhm2ulkGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=opmt81wZngUknnQTTOcKDFZcCS76fVo2OK9CC+rIqkSO7slsl+ZrmNXcyw8lAJFfQ
	 lltNT7n3/XTJsliYev/jBmNdHj3L+IkgDxtAWwarYwErSobyTQvv8nwWqq8uHmrfkk
	 f3ZhmU657tfWxPI/MftfyHufeH6/TUFttPah7xKDgJSe2uC7kh9wLK3VkDGDqUDnCO
	 GbJL+gBvZ/vCZ+ll4umgv+XdMnqqrNR15Fa2AvUO1vnvgpCsxepqvyB/de8UzDN0w9
	 XBpibd02VOFN/+spe2BmXEN6mjX+D6u48sKiTm2+Z0iLyN3esXsMgoViYV5mk2ijk5
	 RdEjiN6v+knVg==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	gregkh@linuxfoundation.org,
	linux-mm@kvack.org,
	liam.howlett@oracle.com,
	surenb@google.com,
	rppt@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v3 8/9] selftests/bpf: make use of PROCMAP_QUERY ioctl if available
Date: Tue,  4 Jun 2024 17:24:53 -0700
Message-ID: <20240605002459.4091285-9-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605002459.4091285-1-andrii@kernel.org>
References: <20240605002459.4091285-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of parsing text-based /proc/<pid>/maps file, try to use
PROCMAP_QUERY ioctl() to simplify and speed up data fetching.
This logic is used to do uprobe file offset calculation, so any bugs in
this logic would manifest as failing uprobe BPF selftests.

This also serves as a simple demonstration of one of the intended uses.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/test_progs.c    |   3 +
 tools/testing/selftests/bpf/test_progs.h    |   2 +
 tools/testing/selftests/bpf/trace_helpers.c | 104 +++++++++++++++++---
 3 files changed, 94 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 89ff704e9dad..6a19970f2531 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -19,6 +19,8 @@
 #include <bpf/btf.h>
 #include "json_writer.h"
 
+int env_verbosity = 0;
+
 static bool verbose(void)
 {
 	return env.verbosity > VERBOSE_NONE;
@@ -848,6 +850,7 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 				return -EINVAL;
 			}
 		}
+		env_verbosity = env->verbosity;
 
 		if (verbose()) {
 			if (setenv("SELFTESTS_VERBOSE", "1", 1) == -1) {
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 0ba5a20b19ba..6eae7fdab0d7 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -95,6 +95,8 @@ struct test_state {
 	FILE *stdout;
 };
 
+extern int env_verbosity;
+
 struct test_env {
 	struct test_selector test_selector;
 	struct test_selector subtest_selector;
diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 70e29f316fe7..6723186c46bb 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -10,6 +10,8 @@
 #include <pthread.h>
 #include <unistd.h>
 #include <linux/perf_event.h>
+#include <linux/fs.h>
+#include <sys/ioctl.h>
 #include <sys/mman.h>
 #include "trace_helpers.h"
 #include <linux/limits.h>
@@ -233,29 +235,91 @@ int kallsyms_find(const char *sym, unsigned long long *addr)
 	return err;
 }
 
+#ifdef PROCMAP_QUERY
+int env_verbosity __weak = 0;
+
+int procmap_query(int fd, const void *addr, __u32 query_flags, size_t *start, size_t *offset, int *flags)
+{
+	char path_buf[PATH_MAX], build_id_buf[20];
+	struct procmap_query q;
+	int err;
+
+	memset(&q, 0, sizeof(q));
+	q.size = sizeof(q);
+	q.query_flags = query_flags;
+	q.query_addr = (__u64)addr;
+	q.vma_name_addr = (__u64)path_buf;
+	q.vma_name_size = sizeof(path_buf);
+	q.build_id_addr = (__u64)build_id_buf;
+	q.build_id_size = sizeof(build_id_buf);
+
+	err = ioctl(fd, PROCMAP_QUERY, &q);
+	if (err < 0) {
+		err = -errno;
+		if (err == -ENOTTY)
+			return -EOPNOTSUPP; /* ioctl() not implemented yet */
+		if (err == -ENOENT)
+			return -ESRCH; /* vma not found */
+		return err;
+	}
+
+	if (env_verbosity >= 1) {
+		printf("VMA FOUND (addr %08lx): %08lx-%08lx %c%c%c%c %08lx %02x:%02x %ld %s (build ID: %s, %d bytes)\n",
+		       (long)addr, (long)q.vma_start, (long)q.vma_end,
+		       (q.vma_flags & PROCMAP_QUERY_VMA_READABLE) ? 'r' : '-',
+		       (q.vma_flags & PROCMAP_QUERY_VMA_WRITABLE) ? 'w' : '-',
+		       (q.vma_flags & PROCMAP_QUERY_VMA_EXECUTABLE) ? 'x' : '-',
+		       (q.vma_flags & PROCMAP_QUERY_VMA_SHARED) ? 's' : 'p',
+		       (long)q.vma_offset, q.dev_major, q.dev_minor, (long)q.inode,
+		       q.vma_name_size ? path_buf : "",
+		       q.build_id_size ? "YES" : "NO",
+		       q.build_id_size);
+	}
+
+	*start = q.vma_start;
+	*offset = q.vma_offset;
+	*flags = q.vma_flags;
+	return 0;
+}
+#else
+int procmap_query(int fd, const void *addr, size_t *start, size_t *offset, int *flags)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 ssize_t get_uprobe_offset(const void *addr)
 {
-	size_t start, end, base;
-	char buf[256];
-	bool found = false;
+	size_t start, base, end;
 	FILE *f;
+	char buf[256];
+	int err, flags;
 
 	f = fopen("/proc/self/maps", "r");
 	if (!f)
 		return -errno;
 
-	while (fscanf(f, "%zx-%zx %s %zx %*[^\n]\n", &start, &end, buf, &base) == 4) {
-		if (buf[2] == 'x' && (uintptr_t)addr >= start && (uintptr_t)addr < end) {
-			found = true;
-			break;
+	/* requested executable VMA only */
+	err = procmap_query(fileno(f), addr, PROCMAP_QUERY_VMA_EXECUTABLE, &start, &base, &flags);
+	if (err == -EOPNOTSUPP) {
+		bool found = false;
+
+		while (fscanf(f, "%zx-%zx %s %zx %*[^\n]\n", &start, &end, buf, &base) == 4) {
+			if (buf[2] == 'x' && (uintptr_t)addr >= start && (uintptr_t)addr < end) {
+				found = true;
+				break;
+			}
+		}
+		if (!found) {
+			fclose(f);
+			return -ESRCH;
 		}
+	} else if (err) {
+		fclose(f);
+		return err;
 	}
-
 	fclose(f);
 
-	if (!found)
-		return -ESRCH;
-
 #if defined(__powerpc64__) && defined(_CALL_ELF) && _CALL_ELF == 2
 
 #define OP_RT_RA_MASK   0xffff0000UL
@@ -296,15 +360,25 @@ ssize_t get_rel_offset(uintptr_t addr)
 	size_t start, end, offset;
 	char buf[256];
 	FILE *f;
+	int err, flags;
 
 	f = fopen("/proc/self/maps", "r");
 	if (!f)
 		return -errno;
 
-	while (fscanf(f, "%zx-%zx %s %zx %*[^\n]\n", &start, &end, buf, &offset) == 4) {
-		if (addr >= start && addr < end) {
-			fclose(f);
-			return (size_t)addr - start + offset;
+	err = procmap_query(fileno(f), (const void *)addr, 0, &start, &offset, &flags);
+	if (err == 0) {
+		fclose(f);
+		return (size_t)addr - start + offset;
+	} else if (err != -EOPNOTSUPP) {
+		fclose(f);
+		return err;
+	} else if (err) {
+		while (fscanf(f, "%zx-%zx %s %zx %*[^\n]\n", &start, &end, buf, &offset) == 4) {
+			if (addr >= start && addr < end) {
+				fclose(f);
+				return (size_t)addr - start + offset;
+			}
 		}
 	}
 
-- 
2.43.0


