Return-Path: <linux-fsdevel+bounces-18299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2072C8B692B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9A71F21F01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F4A11185;
	Tue, 30 Apr 2024 03:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNbnE6Sj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B76FC02;
	Tue, 30 Apr 2024 03:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448526; cv=none; b=TwgwZHVDd1xYL/OQjsS1VDQ2luQSy387w2dLsx/UXh7EMsBFtYQ7P2uvlqzyeqOzYFjasPuKUq7uL0cnaqpc04FRwVMB923ZkTW7df+tl4ZVvX4hQVyg+ZyYpH19hE/8M7YSMTcouqgccFHtzTCJc9GBU9lwjn7Zoi6NBIYz36w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448526; c=relaxed/simple;
	bh=t6F6gZTIpN6m1eTxRsMo75eCx/x0KWlooz1X8l0W2as=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fRNwohNLnqp5KHcEhavQELTCY9KMR3w39Z6Gi9GsqTsCgqC3/kIZzw7Ns6bBuRISkyKUBxW5e8g5Zxu+j25FziqJfTBqUQ3DTa2I3eqQZkqopg2A/4o/5Bse2LPZK/FqQwTTl3MXnAuXoI2peyGqaPKRUk0CxpjwwNh4rLenUMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNbnE6Sj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4B3C116B1;
	Tue, 30 Apr 2024 03:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714448526;
	bh=t6F6gZTIpN6m1eTxRsMo75eCx/x0KWlooz1X8l0W2as=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=eNbnE6SjQhmRzNbf9K/6gokOBTyljpMd1KpBLUid84o58S6G+QkCY0QtcXZmHWq5H
	 7LQ1seLM5V8Gs5ymFOLZYtOybJRE2fyiu/CZ+sGMQw8gXyXpGB59zs2HMRQOefHNZw
	 mSX1RopQBxmFqnQsrKIb4l9CNkZDpjSHCOrCzPf5mvrgwtzL4iI5FE0Of5ZaNGW4lv
	 1RxVLFzaJBDmSHJqXtHBCv5dcDJFURwdxtSoTIvIc6Wngd4CKrp+oO2f6ZOcRZnf5q
	 wvK1v3G9b/hTK97zu+sp/I4BBhSe4BsjLYGXnxl7jkySYEHHkOnB9YL0cnhWhJ0UdA
	 MPMU3W071AuFg==
Date: Mon, 29 Apr 2024 20:42:05 -0700
Subject: [PATCH 5/6] xfs: test disabling fsverity
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, zlang@redhat.com, ebiggers@kernel.org,
 djwong@kernel.org
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, guan@eryu.me,
 linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Message-ID: <171444688055.962488.12884471948592949028.stgit@frogsfrogsfrogs>
In-Reply-To: <171444687971.962488.18035230926224414854.stgit@frogsfrogsfrogs>
References: <171444687971.962488.18035230926224414854.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add a test to make sure that we can disable fsverity on a file that
doesn't pass fsverity validation on its contents anymore.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 tests/xfs/1881     |  111 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/1881.out |   28 +++++++++++++
 2 files changed, 139 insertions(+)
 create mode 100755 tests/xfs/1881
 create mode 100644 tests/xfs/1881.out


diff --git a/tests/xfs/1881 b/tests/xfs/1881
new file mode 100755
index 0000000000..411802d7c7
--- /dev/null
+++ b/tests/xfs/1881
@@ -0,0 +1,111 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oracle.  All Rights Reserved.
+#
+# FS QA Test 1881
+#
+# Corrupt fsverity descriptor, merkle tree blocks, and file contents.  Ensure
+# that we can still disable fsverity, at least for the latter cases.
+#
+. ./common/preamble
+_begin_fstest auto quick verity
+
+_cleanup()
+{
+	cd /
+	_restore_fsverity_signatures
+	rm -f $tmp.*
+}
+
+. ./common/verity
+. ./common/filter
+. ./common/fuzzy
+
+_supported_fs xfs
+_require_scratch_verity
+_disable_fsverity_signatures
+_require_fsverity_corruption
+_require_xfs_io_command noverity
+_require_scratch_nocheck	# corruption test
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount
+
+_require_xfs_has_feature "$SCRATCH_MNT" verity
+VICTIM_FILE="$SCRATCH_MNT/a"
+_fsv_can_enable "$VICTIM_FILE" || _notrun "cannot enable fsverity"
+
+create_victim()
+{
+	local filesize="${1:-3}"
+
+	rm -f "$VICTIM_FILE"
+	perl -e "print 'moo' x $((filesize / 3))" > "$VICTIM_FILE"
+	fsverity enable --hash-alg=sha256 --block-size=1024 "$VICTIM_FILE"
+	fsverity measure "$VICTIM_FILE" | _filter_scratch
+}
+
+disable_verity() {
+	$XFS_IO_PROG -r -c 'noverity' "$VICTIM_FILE" 2>&1 | _filter_scratch
+}
+
+cat_victim() {
+	$XFS_IO_PROG -r -c 'pread -q 0 4096' "$VICTIM_FILE" 2>&1 | _filter_scratch
+}
+
+echo "Part 1: Delete the fsverity descriptor" | tee -a $seqres.full
+create_victim
+_scratch_unmount
+_scratch_xfs_db -x -c "path /a" -c "attr_remove -f vdesc" -c 'ablock 0' -c print >> $seqres.full
+_scratch_mount
+cat_victim
+
+echo "Part 2: Disable fsverity, which won't work" | tee -a $seqres.full
+disable_verity
+cat_victim
+
+echo "Part 3: Corrupt the fsverity descriptor" | tee -a $seqres.full
+create_victim
+_scratch_unmount
+_scratch_xfs_db -x -c "path /a" -c 'attr_modify -f "vdesc" -o 0 "BUGSAHOY"' -c 'ablock 0' -c print >> $seqres.full
+_scratch_mount
+cat_victim
+
+echo "Part 4: Disable fsverity, which won't work" | tee -a $seqres.full
+disable_verity
+cat_victim
+
+echo "Part 5: Corrupt the fsverity file data" | tee -a $seqres.full
+create_victim
+_scratch_unmount
+_scratch_xfs_db -x -c "path /a" -c 'dblock 0' -c 'blocktrash -3 -o 0 -x 24 -y 24 -z' -c print >> $seqres.full
+_scratch_mount
+cat_victim
+
+echo "Part 6: Disable fsverity, which should work" | tee -a $seqres.full
+disable_verity
+cat_victim
+
+echo "Part 7: Corrupt a merkle tree block" | tee -a $seqres.full
+create_victim 1234 # two merkle tree blocks
+_fsv_scratch_corrupt_merkle_tree "$VICTIM_FILE" 0
+cat_victim
+
+echo "Part 8: Disable fsverity, which should work" | tee -a $seqres.full
+disable_verity
+cat_victim
+
+echo "Part 9: Corrupt the fsverity salt" | tee -a $seqres.full
+create_victim
+_scratch_unmount
+_scratch_xfs_db -x -c "path /a" -c 'attr_modify -f "vdesc" -o 3 #08' -c 'attr_modify -f "vdesc" -o 80 "BUGSAHOY"' -c 'ablock 0' -c print >> $seqres.full
+_scratch_mount
+cat_victim
+
+echo "Part 10: Disable fsverity, which should work" | tee -a $seqres.full
+disable_verity
+cat_victim
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/1881.out b/tests/xfs/1881.out
new file mode 100644
index 0000000000..3e94b8001e
--- /dev/null
+++ b/tests/xfs/1881.out
@@ -0,0 +1,28 @@
+QA output created by 1881
+Part 1: Delete the fsverity descriptor
+sha256:bab5cfebae30d53e4318629d4ba0b4760d6aae38e03ae235741ed69a31873f1f SCRATCH_MNT/a
+SCRATCH_MNT/a: Invalid argument
+Part 2: Disable fsverity, which won't work
+SCRATCH_MNT/a: Invalid argument
+SCRATCH_MNT/a: Invalid argument
+Part 3: Corrupt the fsverity descriptor
+sha256:bab5cfebae30d53e4318629d4ba0b4760d6aae38e03ae235741ed69a31873f1f SCRATCH_MNT/a
+SCRATCH_MNT/a: Invalid argument
+Part 4: Disable fsverity, which won't work
+SCRATCH_MNT/a: Invalid argument
+SCRATCH_MNT/a: Invalid argument
+Part 5: Corrupt the fsverity file data
+sha256:bab5cfebae30d53e4318629d4ba0b4760d6aae38e03ae235741ed69a31873f1f SCRATCH_MNT/a
+pread: Input/output error
+Part 6: Disable fsverity, which should work
+pread: Input/output error
+Part 7: Corrupt a merkle tree block
+sha256:c56f1115966bafa6c9d32b4717f554b304161f33923c9292c7a92a27866a853c SCRATCH_MNT/a
+pread: Input/output error
+Part 8: Disable fsverity, which should work
+pread: Input/output error
+Part 9: Corrupt the fsverity salt
+sha256:bab5cfebae30d53e4318629d4ba0b4760d6aae38e03ae235741ed69a31873f1f SCRATCH_MNT/a
+pread: Input/output error
+Part 10: Disable fsverity, which should work
+pread: Input/output error


