Return-Path: <linux-fsdevel+bounces-18298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 333258B6928
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B53D11F21E53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9425C10A3F;
	Tue, 30 Apr 2024 03:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhFB6ms5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE41A1118C;
	Tue, 30 Apr 2024 03:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448511; cv=none; b=r5i1JrU0T/QfLrZcudXMv9qTRznepnbPzvM4VtFO9He2nDd1rqMyHTQgq+7U/trnL9tPfoi5Kuu8KrJG0vbcZajWeuvUdUnSaaJHenSYEWHVtbiQozc6kTtxIPvDKrZYgGeBKy2m1bDGg9SOcsltTjlhfdxv0L8A5i6mCTvGzxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448511; c=relaxed/simple;
	bh=bQVYXStPWSHGBiJ6GLlj4Vn5t5hQyIXFN9y1dk7wLS4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzQGAAr2876hqeG271I5NMJmLFj/I4R3vrERb8xeNL8678cUTV8kKMGfaNj9cnhIVFBH2GqAyaGDbrfvzIOJ7gKG4iI3PyNH19tw9vcP/Vcl4pBOaQL8TZUEd5HJqc4NlnWA5L5hzQtfySWR8iO1svAOe2Cl1c+yzgSD0GEU/Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhFB6ms5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB208C116B1;
	Tue, 30 Apr 2024 03:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714448510;
	bh=bQVYXStPWSHGBiJ6GLlj4Vn5t5hQyIXFN9y1dk7wLS4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=FhFB6ms5zPGV6cd/YhXXHIdnYcyqBJUakX+csiwyls57JOMePlNCsCuKYUK+xt3Vm
	 8cwpB1uuNgLUCkw4JKJWg1ei8vZbflOOVkcEnJA3wGDWG4K68HbO5Ay5DaGpnjXYQb
	 81an9VK0CwhT3fwbViQYNodbRYbyoz53sWWraEqAEyd+4xMTcxjS5CPXZipzZoB6cw
	 L0H08GSth8sfMAOlAIMjhznlZ6K9Ahee6ss5GdhykT8VzldPXNkkhQxn8h0Gzeum75
	 LxazmVvnUhmC8FPgcrMoDkTgN7GzHjWZnbzeXacdOTE1Qy6ib4gJRNHJeSzn+7OA8x
	 DA1jKkg5YO8/w==
Date: Mon, 29 Apr 2024 20:41:50 -0700
Subject: [PATCH 4/6] xfs: test xfs_scrub detection and correction of corrupt
 fsverity metadata
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, zlang@redhat.com, ebiggers@kernel.org,
 djwong@kernel.org
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, guan@eryu.me,
 linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Message-ID: <171444688039.962488.5264219734710985894.stgit@frogsfrogsfrogs>
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

Create a basic test to ensure that xfs_scrub media scans complain about
files that don't pass fsverity validation.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 tests/xfs/1880     |  135 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/1880.out |   37 ++++++++++++++
 2 files changed, 172 insertions(+)
 create mode 100755 tests/xfs/1880
 create mode 100644 tests/xfs/1880.out


diff --git a/tests/xfs/1880 b/tests/xfs/1880
new file mode 100755
index 0000000000..a2119f04c2
--- /dev/null
+++ b/tests/xfs/1880
@@ -0,0 +1,135 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oracle.  All Rights Reserved.
+#
+# FS QA Test 1880
+#
+# Corrupt fsverity descriptor, merkle tree blocks, and file contents.  Ensure
+# that xfs_scrub detects this and repairs whatever it can.
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
+_require_scratch_nocheck	# fsck test
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount
+
+_require_scratch_xfs_scrub
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
+filter_scrub() {
+	awk '{
+		if ($0 ~ /fsverity metadata missing/) {
+			print("fsverity metadata missing");
+		} else if ($0 ~ /Corruption.*inode record/) {
+			print("xfs_ino corruption");
+		} else if ($0 ~ /verity error at offset/) {
+			print("fsverity read error");
+		}
+	}'
+}
+
+run_scrub() {
+	$XFS_SCRUB_PROG -b -x $* $SCRATCH_MNT &> $tmp.moo
+	filter_scrub < $tmp.moo
+	cat $tmp.moo >> $seqres.full
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
+run_scrub -n
+
+echo "Part 2: Run repair to clear XFS_DIFLAG2_VERITY" | tee -a $seqres.full
+run_scrub
+cat_victim
+run_scrub -n
+
+echo "Part 3: Corrupt the fsverity descriptor" | tee -a $seqres.full
+create_victim
+_scratch_unmount
+_scratch_xfs_db -x -c "path /a" -c 'attr_modify -f "vdesc" -o 0 "BUGSAHOY"' -c 'ablock 0' -c print >> $seqres.full
+_scratch_mount
+cat_victim
+run_scrub -n
+
+echo "Part 4: Run repair to clear XFS_DIFLAG2_VERITY" | tee -a $seqres.full
+run_scrub
+cat_victim
+run_scrub -n
+
+echo "Part 5: Corrupt the fsverity file data" | tee -a $seqres.full
+create_victim
+_scratch_unmount
+_scratch_xfs_db -x -c "path /a" -c 'dblock 0' -c 'blocktrash -3 -o 0 -x 24 -y 24 -z' -c print >> $seqres.full
+_scratch_mount
+cat_victim
+run_scrub -n
+
+echo "Part 6: Run repair which will not help" | tee -a $seqres.full
+run_scrub
+cat_victim
+run_scrub -n
+
+echo "Part 7: Corrupt a merkle tree block" | tee -a $seqres.full
+create_victim 1234 # two merkle tree blocks
+_fsv_scratch_corrupt_merkle_tree "$VICTIM_FILE" 0
+cat_victim
+run_scrub -n
+
+echo "Part 8: Run repair which will not help" | tee -a $seqres.full
+run_scrub
+cat_victim
+run_scrub -n
+
+echo "Part 9: Corrupt the fsverity salt" | tee -a $seqres.full
+create_victim
+_scratch_unmount
+_scratch_xfs_db -x -c "path /a" -c 'attr_modify -f "vdesc" -o 3 #08' -c 'attr_modify -f "vdesc" -o 80 "BUGSAHOY"' -c 'ablock 0' -c print >> $seqres.full
+_scratch_mount
+cat_victim
+run_scrub -n
+
+echo "Part 10: Run repair which will not help" | tee -a $seqres.full
+run_scrub
+cat_victim
+run_scrub -n
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/1880.out b/tests/xfs/1880.out
new file mode 100644
index 0000000000..17961ec70b
--- /dev/null
+++ b/tests/xfs/1880.out
@@ -0,0 +1,37 @@
+QA output created by 1880
+Part 1: Delete the fsverity descriptor
+sha256:bab5cfebae30d53e4318629d4ba0b4760d6aae38e03ae235741ed69a31873f1f SCRATCH_MNT/a
+SCRATCH_MNT/a: Invalid argument
+xfs_ino corruption
+fsverity metadata missing
+Part 2: Run repair to clear XFS_DIFLAG2_VERITY
+Part 3: Corrupt the fsverity descriptor
+sha256:bab5cfebae30d53e4318629d4ba0b4760d6aae38e03ae235741ed69a31873f1f SCRATCH_MNT/a
+SCRATCH_MNT/a: Invalid argument
+xfs_ino corruption
+fsverity metadata missing
+Part 4: Run repair to clear XFS_DIFLAG2_VERITY
+Part 5: Corrupt the fsverity file data
+sha256:bab5cfebae30d53e4318629d4ba0b4760d6aae38e03ae235741ed69a31873f1f SCRATCH_MNT/a
+pread: Input/output error
+fsverity read error
+Part 6: Run repair which will not help
+fsverity read error
+pread: Input/output error
+fsverity read error
+Part 7: Corrupt a merkle tree block
+sha256:c56f1115966bafa6c9d32b4717f554b304161f33923c9292c7a92a27866a853c SCRATCH_MNT/a
+pread: Input/output error
+fsverity read error
+Part 8: Run repair which will not help
+fsverity read error
+pread: Input/output error
+fsverity read error
+Part 9: Corrupt the fsverity salt
+sha256:bab5cfebae30d53e4318629d4ba0b4760d6aae38e03ae235741ed69a31873f1f SCRATCH_MNT/a
+pread: Input/output error
+fsverity read error
+Part 10: Run repair which will not help
+fsverity read error
+pread: Input/output error
+fsverity read error


