Return-Path: <linux-fsdevel+bounces-17210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4378A8FE6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 02:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD8F1C214C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 00:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E737010FA;
	Thu, 18 Apr 2024 00:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ecONMVNC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0C6181;
	Thu, 18 Apr 2024 00:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713399241; cv=none; b=icX+z0PuZjV4dL/KtwIkHhBhR4B5i9nMzMFHgjrpLES7h+DBgRRt9zZS17Bq4h6A9+ZR1HoEXfwgihSlYAD38Vx5t0LMDU1U9Qpc+b0QasZf4fakHckISQ4zwM1SenmL1DWbE026P5NycVKImcR2Puxe4Bsae/KViYt7Sh8ExTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713399241; c=relaxed/simple;
	bh=2mR9+iBLxKQaQvSC1xlCx/tRVkq11IAb/GVR9khq/Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oz+VGiTMIwFOWx3nzYKAYFROlksAB4WfSxiwFsZdE9a/9mrdpUm0+Xi++Q1TMK1HdkiwSLgoOdbHLqMWqNW5vsumrWKXipVOaEyNUzF3JZfmUeb286f3s93j1qZrRomxP9TbmiVovW61NOPuUYntYuBT+d36AR9qP6X7ErwOXNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ecONMVNC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Fc9W3NDlawC6i8CUcs20Bxa//1KfA2ETQ6jFvKSlCKk=; b=ecONMVNC6Mu9hrfLzfZ1uco50U
	N/UcJ7LR6OTvkC1P4rsF/uYOt1uKo9EIR89BANXn2fZpy3Q1FpB/qC8dXzHCb4MSRDv0io9cKgC4t
	uScHC6O6mXYXiF7OXUbeaI7YYeqclAwB5JbcA4FHUJ0ziWm6h5azTAiAvLkvx68RZMDCkVdkQBXVn
	FF1Nicxfk3c37vJTQIw0ftzmHP301rNhMysOhNeaP4xczcDA75CX0J5beFvgnzbfLuy3hmWxO5ssz
	XJWPKqqMLSjCFj10TybpdjLhnA7povBP64w680mUKnlFH0Blkom4sfPQPMueqUz+/73DPQxKJz7km
	fbbbgKeg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxFPZ-00000000OwW-3Abv;
	Thu, 18 Apr 2024 00:13:57 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: fstests@vger.kernel.org
Cc: kdevops@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	willy@infradead.org,
	david@redhat.com,
	linmiaohe@huawei.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] fstests: add fsstress + compaction test
Date: Wed, 17 Apr 2024 17:13:56 -0700
Message-ID: <20240418001356.95857-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Running compaction while we run fsstress can crash older kernels as per
korg#218227 [0], the fix for that [0] has been posted [1] but that patch
is not yet on v6.9-rc4 and the patch requires changes for v6.9.

Today I find that v6.9-rc4 is also hitting an unrecoverable hung task
between compaction and fsstress while running generic/476 on the
following kdevops test sections [2]:

  * xfs_nocrc
  * xfs_nocrc_2k
  * xfs_nocrc_4k

Analyzing the trace I see the guest uses loopback block devices for the
fstests TEST_DEV, the loopback file uses sparsefiles on a btrfs
partition. The contention based on traces [3] [4] seems to be that we
have somehow have fsstress + compaction race on folio_wait_bit_common().

We have this happening:

  a) kthread compaction --> migrate_pages_batch()
                --> folio_wait_bit_common()
  b) workqueue on btrfs writeback wb_workfn  --> extent_write_cache_pages()
                --> folio_wait_bit_common()
  c) workqueue on loopback loop_rootcg_workfn() --> filemap_fdatawrite_wbc()
                --> folio_wait_bit_common()
  d) kthread xfsaild --> blk_mq_submit_bio() --> wbt_wait()

I tried to reproduce but couldn't easily do so, so I wrote this test
to help, and with this I have 100% failure rate so far out of 2 runs.

Given we also have korg#218227 and that patch likely needing
backporting, folks will want a reproducer for this issue. This should
hopefully help with that case and this new separate issue.

To reproduce with kdevops just:

make defconfig-xfs_nocrc_2k  -j $(nproc)
make -j $(nproc)
make fstests
make linux
make fstests-baseline TESTS=generic/733
tail -f guestfs/*-xfs-nocrc-2k/console.log

[0] https://bugzilla.kernel.org/show_bug.cgi?id=218227
[1] https://lore.kernel.org/all/7ee2bb8c-441a-418b-ba3a-d305f69d31c8@suse.cz/T/#u
[2] https://github.com/linux-kdevops/kdevops/blob/main/playbooks/roles/fstests/templates/xfs/xfs.config
[3] https://gist.github.com/mcgrof/4dfa3264f513ce6ca398414326cfab84
[4] https://gist.github.com/mcgrof/f40a9f31a43793dac928ce287cfacfeb

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

Note: kdevops uses its own fork of fstests which has this merged
already, so the above should just work. If it's your first time using
kdevops be sure to just read the README for the first time users:

https://github.com/linux-kdevops/kdevops/blob/main/docs/kdevops-first-run.md

 common/rc             |  7 ++++++
 tests/generic/744     | 56 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/744.out |  2 ++
 3 files changed, 65 insertions(+)
 create mode 100755 tests/generic/744
 create mode 100644 tests/generic/744.out

diff --git a/common/rc b/common/rc
index b7b77ac1b46d..d4432f5ce259 100644
--- a/common/rc
+++ b/common/rc
@@ -120,6 +120,13 @@ _require_hugepages()
 		_notrun "Kernel does not report huge page size"
 }
 
+# Requires CONFIG_COMPACTION
+_require_compaction()
+{
+	if [ ! -f /proc/sys/vm/compact_memory ]; then
+	    _notrun "Need compaction enabled CONFIG_COMPACTION=y"
+	fi
+}
 # Get hugepagesize in bytes
 _get_hugepagesize()
 {
diff --git a/tests/generic/744 b/tests/generic/744
new file mode 100755
index 000000000000..2b3c0c7e92fb
--- /dev/null
+++ b/tests/generic/744
@@ -0,0 +1,56 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Luis Chamberlain.  All Rights Reserved.
+#
+# FS QA Test 744
+#
+# fsstress + compaction test
+#
+. ./common/preamble
+_begin_fstest auto rw long_rw stress soak smoketest
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+	$KILLALL_PROG -9 fsstress > /dev/null 2>&1
+}
+
+# Import common functions.
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+
+_require_scratch
+_require_compaction
+_require_command "$KILLALL_PROG" "killall"
+
+echo "Silence is golden."
+
+_scratch_mkfs > $seqres.full 2>&1
+_scratch_mount >> $seqres.full 2>&1
+
+nr_cpus=$((LOAD_FACTOR * 4))
+nr_ops=$((25000 * nr_cpus * TIME_FACTOR))
+fsstress_args=(-w -d $SCRATCH_MNT -n $nr_ops -p $nr_cpus)
+
+# start a background getxattr loop for the existing xattr
+runfile="$tmp.getfattr"
+touch $runfile
+while [ -e $runfile ]; do
+	echo 1 > /proc/sys/vm/compact_memory
+	sleep 15
+done &
+getfattr_pid=$!
+
+test -n "$SOAK_DURATION" && fsstress_args+=(--duration="$SOAK_DURATION")
+
+$FSSTRESS_PROG $FSSTRESS_AVOID "${fsstress_args[@]}" >> $seqres.full
+
+rm -f $runfile
+wait > /dev/null 2>&1
+
+status=0
+exit
diff --git a/tests/generic/744.out b/tests/generic/744.out
new file mode 100644
index 000000000000..205c684fa995
--- /dev/null
+++ b/tests/generic/744.out
@@ -0,0 +1,2 @@
+QA output created by 744
+Silence is golden
-- 
2.43.0


