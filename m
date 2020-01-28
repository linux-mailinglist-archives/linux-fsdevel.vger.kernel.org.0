Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B91014C378
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 00:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgA1XTN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 18:19:13 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45701 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgA1XTM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 18:19:12 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so7427435pfg.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2020 15:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JoR7QxwxRHZHPSnoQTrpX3BN6exCUE2jZrUJfUjj8zo=;
        b=clFtvDi4F/Hsl+L3ueDeA6Q0eVuG7kD6+FTup+rDzqDpJLeFilNw0shUtnIKYOXd6a
         lGMU5NFP9G5ck64L/AFILBvDT/KZ4zjGVZNTJUwHRy369hVWXT+HMr74cg64jSLrsY9O
         4JpuF9DK11Z5SL16VNjyT8tcfUylGky5oCY4D7BLq8MgYhtNH634THfaBVIOE1U79bPI
         lsIKH9WOhUYiie0NtvnU5ByDCu/YG18nZ0TJX4ZVGFVhDnmyV1Yo5XTdqsIgokeljpkS
         HzWyst0+pcwolYONAdTOzKDQGyaFj00KYQvO3N+Ntgtw33cVWrBfp00YGGt4GeTnuhpw
         nwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JoR7QxwxRHZHPSnoQTrpX3BN6exCUE2jZrUJfUjj8zo=;
        b=YLCO2r9NlfjQjZR5oQtdA8l6s+9qjmwtkXF5lh4v1ZrBv9xp3fFW8KNgLs/I82l7z9
         AVo5+FHr8qTuHnKOtbtwzRjfyRafeB3Mi4BvuJ9Ao0NzKj1vmLk2QJyV/eT9a9NPAUc+
         MWCj6lkIg8iTdjdbYlN5n+EUlOaTyBJ9EowAVo049SdhWXFTpwpLLEYEdROeBhLBC3yg
         gj3N4rxc9zUuC3LwuDMIovWHd4sSE57vEdxmMjFtgSN2n45rKIO6ZegZHubuhCUDhN6y
         TcZt4SYsGHwoCZgx9SzciaWH30fgFJtaUmsx+G2aNMmBMHlPmZaP5lIwXhmN28t68Hn0
         P3Hw==
X-Gm-Message-State: APjAAAWEDyX9utMtJP09OlrbYbHIpEkAAsNF81Ek5sOyVST4k1c+h6Ad
        u1yxDMLrCNjMFqD5RVpQFOgjSkMrw/8=
X-Google-Smtp-Source: APXvYqwrAtGtTj3JRBlsP9kZ0uHgkwmDu7YgNeeeiHLv/E3UGEuIO2UJ08Fy5pLaOWfJqODaDMZP7w==
X-Received: by 2002:aa7:8191:: with SMTP id g17mr6471829pfi.25.1580253550227;
        Tue, 28 Jan 2020 15:19:10 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:200::43a7])
        by smtp.gmail.com with ESMTPSA id p24sm156353pgk.19.2020.01.28.15.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 15:19:09 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Cc:     kernel-team@fb.com
Subject: [RFC PATCH xfstests] generic: add smoke test for AT_LINK_REPLACE
Date:   Tue, 28 Jan 2020 15:18:56 -0800
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

