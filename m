Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D224C14C7B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 09:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgA2I6p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 03:58:45 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34303 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgA2I6p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 03:58:45 -0500
Received: by mail-pf1-f195.google.com with SMTP id i6so8110994pfc.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2020 00:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HZ1fUgHkKafGnPPxbaIK69OWQ8cHhuK6+MSpL+KfJsw=;
        b=J85FbUDc/TdNx7uRrkMJNtNzm2tqgFgyIb1YAEQNDhJhCaQW9aEQ0U13SPHkR3c7Xf
         ofZic2Y+3nWH/J7UGGzlO7mQZd86FiaQEi4OCgLA9bQTctvxgpLSsAe+11+uRNU1GyAV
         KZdm1wZ6X9EcS8cCwII1zgVTM131xJAvNr8SOANepdLfayhZ8nbn52mhdllFuvp7Vu6E
         7lfVHsWE3jIP/WPd0h6ByqtX1TmfUwK+cglVz+SfuLSevlBVPysT51ArHJwbzEizS1Pd
         C6SXxcBfG3hyJzp6w7CGrU3GaUwviIZ1c1Nm8OzcgzZNg805s5M0uAvuD4efBCm2qLFj
         SYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HZ1fUgHkKafGnPPxbaIK69OWQ8cHhuK6+MSpL+KfJsw=;
        b=roBB0yH86E2YgEi3wHCIwaxcvQgOTpawqCzFXB++3dD1wNPTUjpwNFd7QGvPZH02yY
         aK2d+HV6flu1Fhgw/ggGG+1wk3RNuVNdiELglU+Mr/CugXndyOcoRjn1L8E2jp3D4n4V
         8IS3JeTy0zj3yYmMbJ0Ol4WIbvmaUIITZH0IaSeg1PVlchhNcL62g50DBRjHw8x0XEZv
         Drv4djhOQ6yOLA66moUxCarmVkMsCNtdQhtsOQ2LF87/37D5U/9shcL5y5AFJV9rwvXz
         AWUc4ZTR9hl1iSThQiOgguGqTgNM4qX6nOMNgSNS/ajXoFaA+YBhy7uym/OfluBf+NsD
         fMYg==
X-Gm-Message-State: APjAAAV+v4sASrUf1zXPYk80XIqh50Dj7uWKL863walTFoI1wmeb6K4X
        wsiZQmHoqmYsFX3HfEFpybMVw/jWpgE=
X-Google-Smtp-Source: APXvYqzCaxjzL1BCmtE9Gr4XiyfN2SK3rP/+TSRXQgOwqWHDazZahMLQ22ojJ77gTeOc+H6hpGaz5A==
X-Received: by 2002:a62:1a16:: with SMTP id a22mr8261295pfa.34.1580288324210;
        Wed, 29 Jan 2020 00:58:44 -0800 (PST)
Received: from vader.hsd1.wa.comcast.net ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id s131sm1935932pfs.135.2020.01.29.00.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 00:58:43 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Cc:     kernel-team@fb.com, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Xi Wang <xi@cs.washington.edu>, fstests@vger.kernel.org
Subject: [RFC PATCH xfstests] generic: add smoke test for AT_LINK_REPLACE
Date:   Wed, 29 Jan 2020 00:58:27 -0800
Message-Id: <f23621bea2e8d5f919389131b84fa0226b90f502.1580253372.git.osandov@fb.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580251857.git.osandov@fb.com>
References: <cover.1580251857.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Cc: fstests@vger.kernel.org
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 common/rc             |  2 +-
 tests/generic/593     | 97 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/593.out |  6 +++
 tests/generic/group   |  1 +
 4 files changed, 105 insertions(+), 1 deletion(-)
 create mode 100755 tests/generic/593
 create mode 100644 tests/generic/593.out

diff --git a/common/rc b/common/rc
index eeac1355..257f65a1 100644
--- a/common/rc
+++ b/common/rc
@@ -2172,7 +2172,7 @@ _require_xfs_io_command()
 		;;
 	"flink")
 		local testlink=$TEST_DIR/$$.link.xfs_io
-		testio=`$XFS_IO_PROG -F -f -c "flink $testlink" $testfile 2>&1`
+		testio=`$XFS_IO_PROG -F -f -c "flink $param $testlink" $testfile 2>&1`
 		rm -f $testlink > /dev/null 2>&1
 		;;
 	"-T")
diff --git a/tests/generic/593 b/tests/generic/593
new file mode 100755
index 00000000..8a9fee02
--- /dev/null
+++ b/tests/generic/593
@@ -0,0 +1,97 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Facebook.  All Rights Reserved.
+#
+# FS QA Test 593
+#
+# Smoke test linkat() with AT_LINK_REPLACE.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+_supported_fs generic
+_supported_os Linux
+_require_test
+_require_xfs_io_command "-T"
+_require_xfs_io_command "flink" "-f"
+
+same_file() {
+	[[ "$(stat -c '%d %i' "$1")" = "$(stat -c '%d %i' "$2")" ]]
+}
+
+touch "$TEST_DIR/$seq.src"
+touch "$TEST_DIR/$seq.tgt"
+$XFS_IO_PROG -c "flink -f $TEST_DIR/$seq.tgt" "$TEST_DIR/$seq.src"
+same_file "$TEST_DIR/$seq.src" "$TEST_DIR/$seq.tgt" ||
+	echo "Target was not replaced"
+
+# Linking to the same file should be a noop.
+$XFS_IO_PROG -c "flink -f $TEST_DIR/$seq.src" "$TEST_DIR/$seq.src"
+$XFS_IO_PROG -c "flink -f $TEST_DIR/$seq.tgt" "$TEST_DIR/$seq.src"
+same_file "$TEST_DIR/$seq.src" "$TEST_DIR/$seq.tgt" || echo "Target changed?"
+
+# Should work with O_TMPFILE.
+$XFS_IO_PROG -c "flink -f $TEST_DIR/$seq.tgt" -T "$TEST_DIR"
+stat -c '%h' "$TEST_DIR/$seq.tgt"
+same_file "$TEST_DIR/$seq.src" "$TEST_DIR/$seq.tgt" &&
+	echo "Target was not replaced"
+
+# It's okay if the target doesn't exist.
+$XFS_IO_PROG -c "flink -f $TEST_DIR/$seq.tgt2" "$TEST_DIR/$seq.src"
+same_file "$TEST_DIR/$seq.src" "$TEST_DIR/$seq.tgt2" ||
+	echo "Target was not created"
+
+# Can't replace directories.
+mkdir "$TEST_DIR/$seq.dir"
+$XFS_IO_PROG -c "flink -f $TEST_DIR/$seq.dir" "$TEST_DIR/$seq.src"
+cd "$TEST_DIR/$seq.dir"
+$XFS_IO_PROG -c "flink -f ." "$TEST_DIR/$seq.src"
+$XFS_IO_PROG -c "flink -f .." "$TEST_DIR/$seq.src"
+cd - &> /dev/null
+
+# Can't replace local mount points.
+touch "$TEST_DIR/$seq.mnt"
+$MOUNT_PROG --bind "$TEST_DIR/$seq.mnt" "$TEST_DIR/$seq.mnt"
+$XFS_IO_PROG -c "flink -f $TEST_DIR/$seq.mnt" "$TEST_DIR/$seq.src"
+
+# Can replace mount points in other namespaces, though.
+unshare -m \
+	bash -c "$UMOUNT_PROG $TEST_DIR/$seq.mnt; $XFS_IO_PROG -c \"flink -f $TEST_DIR/$seq.mnt\" $TEST_DIR/$seq.src"
+if $UMOUNT_PROG "$TEST_DIR/$seq.mnt" &> /dev/null; then
+	echo "Mount point was not detached"
+fi
+same_file "$TEST_DIR/$seq.src" "$TEST_DIR/$seq.mnt" ||
+	echo "Mount point was not replaced"
+
+# Should replace symlinks, not follow them.
+touch "$TEST_DIR/$seq.symtgt"
+ln -s "$TEST_DIR/$seq.symtgt" "$TEST_DIR/$seq.sym"
+$XFS_IO_PROG -c "flink -f $TEST_DIR/$seq.sym" "$TEST_DIR/$seq.src"
+same_file "$TEST_DIR/$seq.src" "$TEST_DIR/$seq.sym" ||
+	echo "Symlink was not replaced"
+same_file "$TEST_DIR/$seq.src" "$TEST_DIR/$seq.symtgt" &&
+	echo "Symlink target was replaced"
+
+rm -rf "$TEST_DIR/$seq."*
+
+status=0
+exit
diff --git a/tests/generic/593.out b/tests/generic/593.out
new file mode 100644
index 00000000..834c34bf
--- /dev/null
+++ b/tests/generic/593.out
@@ -0,0 +1,6 @@
+QA output created by 593
+1
+flink: Is a directory
+flink: Is a directory
+flink: Is a directory
+flink: Device or resource busy
diff --git a/tests/generic/group b/tests/generic/group
index 6fe62505..0a87efca 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -595,3 +595,4 @@
 590 auto prealloc preallocrw
 591 auto quick rw pipe splice
 592 auto quick encrypt
+593 auto quick hardlink
-- 
2.25.0

