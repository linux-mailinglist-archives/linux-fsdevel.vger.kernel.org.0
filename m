Return-Path: <linux-fsdevel+bounces-22654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287D291AD8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 19:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 554C51C22048
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 17:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5C019E7CF;
	Thu, 27 Jun 2024 17:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UR7h+SFI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F7B19DF68;
	Thu, 27 Jun 2024 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508163; cv=none; b=jtqQWaFsIIIIm/RHIbKqRuOCWQE7Xwm8R6iGqwdbnLcP3dGmJeSgbF+3dnqayRus3AyfPTextzM3TwbRuNemZbMNh4QJGH+oj7Wnn9Kqjgzz/yktDtlLUDKRznxFdFvzilqsr/coQh8Q+cQlZ6EbFuukDqLvV7oGZ3R5j41Kuqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508163; c=relaxed/simple;
	bh=UCwCLJEQqsSSL94rfskjH98zL7sdkNEm83V+CMuhWVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4DpO6F+/Pw+q3jEkCGdtBtQVnqOJt1E2c+R+JEUXunRRgIgxb0U7lDVwBAAAZMeuLUxZ4wTZDjFI/Dcol+nglGvjz4zKjhSTAY2LVoOXF0u/zcNPb0V+DYg9rTl2BoD3zgsPM1UADjVqnUgbo0tu+PY7u9tyOiE+AtJGNdowZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UR7h+SFI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC84C2BBFC;
	Thu, 27 Jun 2024 17:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719508163;
	bh=UCwCLJEQqsSSL94rfskjH98zL7sdkNEm83V+CMuhWVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UR7h+SFIAeDssN9Yd1k3TBkGRgLtfj2sQPBGN2OlUxlh1q1ZxiDntpTkFtxOhtyZV
	 2qE5ePOJvfOKb6ER6fIAlKaVrHzMj81EfOw6Ciyox+OgZZV+F29CRbykU+ttAhN/1F
	 fwID8x9Mk1rlmwGxemy51dhDUSQhCk28NlJfqIWHQhAUN386ENUEO3PDWyhHvaSXJg
	 A2fbh3K86f5J1fBgTvckpafBZ9pC0Z5E9sykAFddIECSazhNuE/GP1S8yRw/c/Gktx
	 sQC5EdEQ7PzLd+4Sm53UHpyhO5DXZEfKHpqaMqJfjc5varHjIGprsSNMK/Pmb6wrt/
	 70GdVpHmM1jTw==
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
	adobriyan@gmail.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v6 6/6] selftests/proc: add PROCMAP_QUERY ioctl tests
Date: Thu, 27 Jun 2024 10:08:58 -0700
Message-ID: <20240627170900.1672542-7-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627170900.1672542-1-andrii@kernel.org>
References: <20240627170900.1672542-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend existing proc-pid-vm.c tests with PROCMAP_QUERY ioctl() API.
Test a few successful and negative cases, validating querying filtering
and exact vs next VMA logic works as expected.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/proc/Makefile      |  1 +
 tools/testing/selftests/proc/proc-pid-vm.c | 86 ++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
index cd95369254c0..291e7087f1b3 100644
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -Wall -O2 -Wno-unused-function
 CFLAGS += -D_GNU_SOURCE
+CFLAGS += $(TOOLS_INCLUDES)
 LDFLAGS += -pthread
 
 TEST_GEN_PROGS :=
diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
index cacbd2a4aec9..d04685771952 100644
--- a/tools/testing/selftests/proc/proc-pid-vm.c
+++ b/tools/testing/selftests/proc/proc-pid-vm.c
@@ -45,6 +45,7 @@
 #include <linux/kdev_t.h>
 #include <sys/time.h>
 #include <sys/resource.h>
+#include <linux/fs.h>
 
 #include "../kselftest.h"
 
@@ -492,6 +493,91 @@ int main(void)
 		assert(buf[13] == '\n');
 	}
 
+	/* Test PROCMAP_QUERY ioctl() for /proc/$PID/maps */
+	{
+		char path_buf[256], exp_path_buf[256];
+		struct procmap_query q;
+		int fd, err;
+
+		snprintf(path_buf, sizeof(path_buf), "/proc/%u/maps", pid);
+		fd = open(path_buf, O_RDONLY);
+		if (fd == -1)
+			return 1;
+
+		/* CASE 1: exact MATCH at VADDR */
+		memset(&q, 0, sizeof(q));
+		q.size = sizeof(q);
+		q.query_addr = VADDR;
+		q.query_flags = 0;
+		q.vma_name_addr = (__u64)(unsigned long)path_buf;
+		q.vma_name_size = sizeof(path_buf);
+
+		err = ioctl(fd, PROCMAP_QUERY, &q);
+		assert(err == 0);
+
+		assert(q.query_addr == VADDR);
+		assert(q.query_flags == 0);
+
+		assert(q.vma_flags == (PROCMAP_QUERY_VMA_READABLE | PROCMAP_QUERY_VMA_EXECUTABLE));
+		assert(q.vma_start == VADDR);
+		assert(q.vma_end == VADDR + PAGE_SIZE);
+		assert(q.vma_page_size == PAGE_SIZE);
+
+		assert(q.vma_offset == 0);
+		assert(q.inode == st.st_ino);
+		assert(q.dev_major == MAJOR(st.st_dev));
+		assert(q.dev_minor == MINOR(st.st_dev));
+
+		snprintf(exp_path_buf, sizeof(exp_path_buf),
+			"/tmp/#%llu (deleted)", (unsigned long long)st.st_ino);
+		assert(q.vma_name_size == strlen(exp_path_buf) + 1);
+		assert(strcmp(path_buf, exp_path_buf) == 0);
+
+		/* CASE 2: NO MATCH at VADDR-1 */
+		memset(&q, 0, sizeof(q));
+		q.size = sizeof(q);
+		q.query_addr = VADDR - 1;
+		q.query_flags = 0; /* exact match */
+
+		err = ioctl(fd, PROCMAP_QUERY, &q);
+		err = err < 0 ? -errno : 0;
+		assert(err == -ENOENT);
+
+		/* CASE 3: MATCH COVERING_OR_NEXT_VMA at VADDR - 1 */
+		memset(&q, 0, sizeof(q));
+		q.size = sizeof(q);
+		q.query_addr = VADDR - 1;
+		q.query_flags = PROCMAP_QUERY_COVERING_OR_NEXT_VMA;
+
+		err = ioctl(fd, PROCMAP_QUERY, &q);
+		assert(err == 0);
+
+		assert(q.query_addr == VADDR - 1);
+		assert(q.query_flags == PROCMAP_QUERY_COVERING_OR_NEXT_VMA);
+		assert(q.vma_start == VADDR);
+		assert(q.vma_end == VADDR + PAGE_SIZE);
+
+		/* CASE 4: NO MATCH at VADDR + PAGE_SIZE */
+		memset(&q, 0, sizeof(q));
+		q.size = sizeof(q);
+		q.query_addr = VADDR + PAGE_SIZE; /* point right after the VMA */
+		q.query_flags = PROCMAP_QUERY_COVERING_OR_NEXT_VMA;
+
+		err = ioctl(fd, PROCMAP_QUERY, &q);
+		err = err < 0 ? -errno : 0;
+		assert(err == -ENOENT);
+
+		/* CASE 5: NO MATCH WRITABLE at VADDR */
+		memset(&q, 0, sizeof(q));
+		q.size = sizeof(q);
+		q.query_addr = VADDR;
+		q.query_flags = PROCMAP_QUERY_VMA_WRITABLE;
+
+		err = ioctl(fd, PROCMAP_QUERY, &q);
+		err = err < 0 ? -errno : 0;
+		assert(err == -ENOENT);
+	}
+
 	return 0;
 }
 #else
-- 
2.43.0


