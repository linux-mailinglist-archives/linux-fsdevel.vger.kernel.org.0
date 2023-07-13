Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CE9752DCB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 01:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjGMXJq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 19:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjGMXJq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 19:09:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E26B172C;
        Thu, 13 Jul 2023 16:09:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CA4B60A70;
        Thu, 13 Jul 2023 23:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992A5C433C8;
        Thu, 13 Jul 2023 23:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689289780;
        bh=BQUnTmDBddlxRHvOZ6/VzgVMFh5ycXpIlBQaFHVxBWY=;
        h=From:To:Cc:Subject:Date:From;
        b=KO1cxiOL4XiocgTiv66xqzumu2NxX1I7gYuPmaYFGtcI/OoyvzyRE9YhoZd2cTTZW
         vSY2O7BZlZgyHd3X9Koqjz4D8pIWoda3AQeVnjD7yk4bEQdMZTexHkAoqgBkUwwv/d
         FqwRmM/FIukX4H1OLAMEWAuxwR9UyFwLigwkWJ46A6357oPWZZztXcj4GSN0cLFtgE
         PQljHqIkqCobJyQpkXphEfJi2/k/N3Fx2nrAAhnzn0EFajPtXMqKyWo7TMIGMG4CU7
         AA0hxtStKSTfQ7MuLFOod9xc97dfFoT0fJdMfj+hi3RAUCvwN2MWnIsOPy8L+iEbDm
         546FMXW+pkf1Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     fstests@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [fstests PATCH] generic: add a test for multigrain timestamps
Date:   Thu, 13 Jul 2023 19:09:39 -0400
Message-ID: <20230713230939.367068-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ensure that the mtime and ctime apparently change, even when there are
multiple writes in quick succession. Older kernels didn't do this, but
there are patches in flight that should help ensure it in the future.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 src/Makefile          |   2 +-
 src/mgctime.c         | 107 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/730     |  25 ++++++++++
 tests/generic/730.out |   1 +
 4 files changed, 134 insertions(+), 1 deletion(-)
 create mode 100644 src/mgctime.c
 create mode 100755 tests/generic/730
 create mode 100644 tests/generic/730.out

This patchset is intended to test the new multigrain timestamp feature:

    https://lore.kernel.org/linux-fsdevel/20230713-mgctime-v5-0-9eb795d2ae37@kernel.org/T/#t

I had originally attempted to write this as a shell script, but it was
too slow, which made it falsely pass on unpatched kernels.

All current filesystems will fail this, so we may want to wait until
we are closer to merging the kernel series.

diff --git a/src/Makefile b/src/Makefile
index 24cd47479140..aff7d07466f0 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -33,7 +33,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
 	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
 	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
-	uuid_ioctl
+	uuid_ioctl mgctime
 
 EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
 	      btrfs_crc32c_forged_name.py popdir.pl popattr.py
diff --git a/src/mgctime.c b/src/mgctime.c
new file mode 100644
index 000000000000..38e22a8613ff
--- /dev/null
+++ b/src/mgctime.c
@@ -0,0 +1,107 @@
+/*
+ * Older Linux kernels always use coarse-grained timestamps, with a
+ * resolution of around 1 jiffy. Writes that are done in quick succession
+ * on those kernels apparent change to the ctime or mtime.
+ *
+ * Newer kernels attempt to ensure that fine-grained timestamps are used
+ * when the mtime or ctime are queried from userland.
+ *
+ * Open a file and do a 1 byte write to it and then statx the mtime and ctime.
+ * Do that in a loop 1000 times and ensure that the value is different from
+ * the last.
+ *
+ * Copyright (c) 2023: Jeff Layton <jlayton@kernel.org>
+ */
+#define _GNU_SOURCE 1
+#include <stdio.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <stdint.h>
+#include <getopt.h>
+#include <stdbool.h>
+
+#define NUM_WRITES 1000
+
+static int64_t statx_ts_cmp(struct statx_timestamp *ts1, struct statx_timestamp *ts2)
+{
+	int64_t ret = ts2->tv_sec - ts1->tv_sec;
+
+	if (ret)
+		return ret;
+
+	ret = ts2->tv_nsec;
+	ret -= ts1->tv_nsec;
+
+	return ret;
+}
+
+int main(int argc, char **argv)
+{
+	int ret, fd, i;
+	struct statx stx = { };
+	struct statx_timestamp ctime, mtime;
+	bool verbose = false;
+
+	while ((i = getopt(argc, argv, "v")) != -1) {
+		switch (i) {
+		case 'v':
+			verbose = true;
+			break;
+		}
+	}
+
+	if (argc < 2) {
+		errno = -EINVAL;
+		perror("usage");
+	}
+
+	fd = open(argv[1], O_WRONLY|O_CREAT|O_TRUNC, 0644);
+	if (fd < 0) {
+		perror("open");
+		return 1;
+	}
+
+	ret = statx(fd, "", AT_EMPTY_PATH, STATX_MTIME|STATX_CTIME, &stx);
+	if (ret < 0) {
+		perror("stat");
+		return 1;
+	}
+
+	ctime = stx.stx_ctime;
+	mtime = stx.stx_mtime;
+
+	for (i = 0; i < NUM_WRITES; ++i) {
+		ssize_t written;
+
+		written = write(fd, "a", 1);
+		if (written < 0) {
+			perror("write");
+			return 1;
+		}
+
+		ret = statx(fd, "", AT_EMPTY_PATH, STATX_MTIME|STATX_CTIME, &stx);
+		if (ret < 0) {
+			perror("stat");
+			return 1;
+		}
+
+		if (verbose)
+			printf("%d: %llu.%u\n", i, stx.stx_ctime.tv_sec, stx.stx_ctime.tv_nsec);
+
+		if (!statx_ts_cmp(&ctime, &stx.stx_ctime)) {
+			printf("Duplicate ctime after write!\n");
+			return 1;
+		}
+
+		if (!statx_ts_cmp(&mtime, &stx.stx_mtime)) {
+			printf("Duplicate mtime after write!\n");
+			return 1;
+		}
+
+		ctime = stx.stx_ctime;
+		mtime = stx.stx_mtime;
+	}
+	return 0;
+}
diff --git a/tests/generic/730 b/tests/generic/730
new file mode 100755
index 000000000000..c3f24aeb8534
--- /dev/null
+++ b/tests/generic/730
@@ -0,0 +1,25 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023, Jeff Layton <jlayton@redhat.com>
+#
+# FS QA Test No. 730
+#
+# Multigrain time test
+#
+# Open a file, and do 1 byte writes to it, and statx the file for
+# the ctime and mtime after each write. Ensure that they have changed
+# since the previous write.
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+# Override the default cleanup function.
+_require_test_program mgctime
+
+testfile="$TEST_DIR/test_mgtime_file.$$"
+
+$here/src/mgctime $testfile
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/730.out b/tests/generic/730.out
new file mode 100644
index 000000000000..5dbea532d60f
--- /dev/null
+++ b/tests/generic/730.out
@@ -0,0 +1 @@
+QA output created by 730
-- 
2.41.0

