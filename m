Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5CC68886C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Feb 2023 21:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjBBUoi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 15:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjBBUog (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 15:44:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68266598;
        Thu,  2 Feb 2023 12:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2Gu1J17vUOqah9snYcpOpRqgXozaOqIS6UOuMS3TPDU=; b=nBecBO+le/dfpA61aDSji/IT8c
        Jtpk5VIkJ0m1vBtuaxptXdJ/oIIbbAH0pqvZqcVxvttuZlRtLDKXIhaa23N1SjMEkbKDNYis6ShNF
        Rsig0553S1/uylbIfEMobwRyeLj+CgHeUmJPqVvGzNqX88Jd57qQtQegCyncP+63tRKILRWPihjb5
        yCGI0RNgt3IIXMzIMmRWkUrf5vPGvU8xF2ShjG7/W+zpd49ew3/BhME1TE88PpbjIZsdOKHx7QGXD
        WfS4Y1QKwclnEZiFBnuwCJT7n6IYUwe/ERhek6N/j+EKTi458KfQRGCiCnV353LqlnIg/JOWmJmF3
        QwgiXE+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNgRb-00Di7p-Pr; Thu, 02 Feb 2023 20:44:31 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        fstests@vger.kernel.org
Subject: [PATCH 6/5] generic: test ftruncate zeroes bytes after EOF
Date:   Thu,  2 Feb 2023 20:44:28 +0000
Message-Id: <20230202204428.3267832-7-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230202204428.3267832-1-willy@infradead.org>
References: <20230202204428.3267832-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

https://pubs.opengroup.org/onlinepubs/9699919799/functions/ftruncate.html
specifies that "If the file size is increased, the extended area shall
appear as if it were zero-filled."  Many filesystems do not currently
do this for the portion of the page after EOF.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 .gitignore            |  1 +
 src/Makefile          |  2 +-
 src/truncate-zero.c   | 50 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/707     | 31 +++++++++++++++++++++++++++
 tests/generic/707.out |  2 ++
 5 files changed, 85 insertions(+), 1 deletion(-)
 create mode 100644 src/truncate-zero.c
 create mode 100755 tests/generic/707
 create mode 100644 tests/generic/707.out

diff --git a/.gitignore b/.gitignore
index a6f433f1..6aa5bca9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -169,6 +169,7 @@ tags
 /src/test-nextquota
 /src/testx
 /src/trunc
+/src/truncate-zero
 /src/truncfile
 /src/unwritten_mmap
 /src/unwritten_sync
diff --git a/src/Makefile b/src/Makefile
index afdf6b30..83ca11ac 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -19,7 +19,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	t_ofd_locks t_mmap_collision mmap-write-concurrent \
 	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
 	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
-	t_mmap_cow_memory_failure fake-dump-rootino
+	t_mmap_cow_memory_failure fake-dump-rootino truncate-zero
 
 LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
diff --git a/src/truncate-zero.c b/src/truncate-zero.c
new file mode 100644
index 00000000..67f53912
--- /dev/null
+++ b/src/truncate-zero.c
@@ -0,0 +1,50 @@
+#include <fcntl.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+int main(int argc, char **argv)
+{
+	char *buf;
+	int i, fd;
+
+	if (argc != 2) {
+		fprintf(stderr, "Usage: %s <file>\n", argv[0]);
+		return 1;
+	}
+
+	fd = open(argv[1], O_RDWR | O_CREAT, 0644);
+	if (fd < 0) {
+		perror(argv[1]);
+		return 1;
+	}
+
+	if (ftruncate(fd, 1) < 0) {
+		perror("ftruncate");
+		return 1;
+	}
+
+	buf = mmap(NULL, 1024, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+	if (buf == MAP_FAILED) {
+		perror("mmap");
+		return 1;
+	}
+
+	memset(buf, 'a', 10);
+
+	if (ftruncate(fd, 5) < 0) {
+		perror("ftruncate");
+		return 1;
+	}
+
+	if (memcmp(buf, "a\0\0\0\0", 5) == 0)
+		return 0;
+
+	fprintf(stderr, "Truncation did not zero new bytes:\n");
+	for (i = 0; i < 5; i++)
+		fprintf(stderr, "%#x ", buf[i]);
+	fputc('\n', stderr);
+
+	return 2;
+}
diff --git a/tests/generic/707 b/tests/generic/707
new file mode 100755
index 00000000..ddc82a9a
--- /dev/null
+++ b/tests/generic/707
@@ -0,0 +1,31 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Matthew Wilcox for Oracle.  All Rights Reserved.
+#
+# FS QA Test 707
+#
+# Test whether we obey this part of POSIX-2017 ftruncate:
+# "If the file size is increased, the extended area shall appear as if
+# it were zero-filled"
+#
+. ./common/preamble
+_begin_fstest auto quick posix
+
+_supported_fs generic
+_require_test
+_require_test_program "truncate-zero"
+
+test_file=$TEST_DIR/test.$seq
+
+_cleanup()
+{
+	cd /
+	rm -f $test_file
+}
+
+$here/src/truncate-zero $test_file > $seqres.full 2>&1 ||
+	_fail "truncate zero failed!"
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/707.out b/tests/generic/707.out
new file mode 100644
index 00000000..8e57a1d8
--- /dev/null
+++ b/tests/generic/707.out
@@ -0,0 +1,2 @@
+QA output created by 707
+Silence is golden
-- 
2.35.1

