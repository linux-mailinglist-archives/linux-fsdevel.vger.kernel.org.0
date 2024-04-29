Return-Path: <linux-fsdevel+bounces-18052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C65AB8B5072
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 07:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F62AB2288F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 05:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3383DD520;
	Mon, 29 Apr 2024 05:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2feX+zPn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C27C8C7;
	Mon, 29 Apr 2024 05:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714366829; cv=none; b=YsaAjTOxd2Whip+4kS1/34R4Oz7JCyoRaTjZ9W/66chqx9l4UQSqZ1DQsRWzN2/FX2Cz/U0KOJGsfcb48JZNSUGhSZTdssp/WXlO36R1uLltYu4WXkfHvwdL9BMyxG2TvcyPx5pVi/km+/7vqzAX8D5Btd80bP/7RuwQvE0otcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714366829; c=relaxed/simple;
	bh=8XvmCn7Pd1ktB7On/6rVc5Y8x7d9UEbl4Pd866pIWC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LibfOg7aPW+RNR7cyt/eJsCbqfdtM0ZIazAaioijF6U2ZNAAfBuiTxshtr2aFAYfQlfUdnluLb4j3mNlhKg71NZ+0YBZ33vSia0NG+OCmuLx1WsqX2qsBj/a7mNWWOLe0GlWF4iXjiy2POHuXzSyu47K83JpzRG0Cx+J33lFQoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2feX+zPn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=0up5w6U/SD43DrHq7xXf8Ll9aXDDKmogMJKfJTux2Uw=; b=2feX+zPnyDaIDIoXqrS5icBciX
	8dUhFHXFjBk8vww8VOa9IFnUM/TRQd6u9UuaEf2fVDuxXMlo3Dyt0VvEtmuOL9fBE7LrLxPKNHns/
	nlGdysdqRTBOAQ86LMKL2qGXpH7jv8lj/53KyHIb/egMByJETfFwyva6cBQ8BzTqahL1sA3/npSWl
	QDXb8A4NaKS2+eMYce0pnLuvRs/jZgbJnhBNTdzxceVHynaSJlfHl2S40/y8Ktg39OkYJ3UdQ1wEC
	xYL3zg8S27AYAB7RRL5ROLxzAyChs5ZtxvvH6pkpHZZqECV81YCfvbyMnHG3ux5A3X+LeADo8mnfs
	MHUxw7YQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1J7n-00000001TGv-1acJ;
	Mon, 29 Apr 2024 05:00:23 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: fstests@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org,
	ziy@nvidia.com,
	vbabka@suse.cz,
	seanjc@google.com,
	willy@infradead.org,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	hare@suse.de,
	john.g.garry@oracle.com,
	linux-xfs@vger.kernel.org,
	patches@lists.linux.dev,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC v2] fstests: add stress truncation + writeback + compaction split test
Date: Sun, 28 Apr 2024 22:00:22 -0700
Message-ID: <20240429050022.350818-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Stress test folio splits by using the debugfs interface to a target
a new smaller folio order while running compaction at the same time.
This is dangerous at the moment as its using a debugfs API which
requires two out of tree fixes [0] [1] which have already been
posted but not yet merged.

With these debugfs patches applied this test can now be used to
reproduce an issue which was only possible to reproduce by running
generic/447 twice with min order:

https://gist.github.com/mcgrof/d12f586ec6ebe32b2472b5d634c397df

This is designed to try to exacerbate races with folio splits incurred
by truncation and race that with compaction and writeback. This only
creates a crash with min order enabled, so for example with a 16k block
sized XFS test profile.

This also begs the question if something like MADV_NOHUGEPAGE might be
desirable from userspace, so to enable userspace to request splits when
possible.

If inspecting more closely, you'll want to enable on your kernel boot:

	dyndbg='file mm/huge_memory.c +p'

Since we want to race large folio splits we also augment the full test
output log $seqres.full with the test specific number of successful
splits from vmstat thp_split_page and thp_split_page_failed.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?h=20240424-lbs&id=80f6df5037fd0ad560526af45bd7f4d779fe03f6
[1] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?h=20240424-lbs&id=38f6fac5b4283ea48b1876fc56728f062168f8c3
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

For now at laest to allow people to more easily reproduce the crash we're
discussing here:

https://lkml.kernel.org/r/Zi8aYA92pvjDY7d5@bombadil.infradead.org

I can clean this up based on Zorro's feedback after this. Posting this RFCv2
so to enable folks to more easily reproduce the issue and also the debugfs
issue that this uses.

 common/rc             |  20 ++++++++
 tests/generic/745     | 115 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/745.out |   2 +
 3 files changed, 137 insertions(+)
 create mode 100755 tests/generic/745
 create mode 100644 tests/generic/745.out

diff --git a/common/rc b/common/rc
index d4432f5ce259..1eefb53aa84b 100644
--- a/common/rc
+++ b/common/rc
@@ -127,6 +127,26 @@ _require_compaction()
 	    _notrun "Need compaction enabled CONFIG_COMPACTION=y"
 	fi
 }
+
+# Requires CONFIG_DEBUGFS and truncation knobs
+SPLIT_DEBUGFS="/sys/kernel/debug/split_huge_pages"
+_require_split_debugfs()
+{
+       if [ ! -f $SPLIT_DEBUGFS ]; then
+           _notrun "Needs CONFIG_DEBUGFS and split_huge_pages"
+       fi
+}
+
+_split_huge_pages_file_full()
+{
+	local file=$1
+	local offset="0x0"
+	local len=$(printf "%x" $(stat --format='%s' $file))
+	local order="0"
+	local split_cmd="$file,$offset,0x${len},$order"
+	echo $split_cmd > $SPLIT_DEBUGFS
+}
+
 # Get hugepagesize in bytes
 _get_hugepagesize()
 {
diff --git a/tests/generic/745 b/tests/generic/745
new file mode 100755
index 000000000000..0c67bd990a2f
--- /dev/null
+++ b/tests/generic/745
@@ -0,0 +1,115 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 Luis Chamberlain. All Rights Reserved.
+#
+# FS QA Test No. 734
+#
+# stress truncation + writeback + compaction
+#
+# This aims at trying to reproduce a difficult to reproduce bug found with
+# min order. The root cause lies in compaction racing with truncation on
+# min order:
+#
+# https://gist.github.com/mcgrof/d12f586ec6ebe32b2472b5d634c397df
+#
+# If you're enabling this and want to check underneath the hood you may want to
+# enable:
+#
+# dyndbg='file mm/huge_memory.c +p'
+#
+# We want to increase the rate of successful truncations + compaction racing,
+# so we want to increase the value of thp_split_page in $seqres.full.
+#
+# Our general goal here is to race with folio truncation + writeback and
+# compaction.
+
+. ./common/preamble
+
+# This is dangerous_fuzzers fow now until we get the debugfs interface
+# this uses fixed. Patches for that have been posted but still under
+# review.
+_begin_fstest long_rw stress soak smoketest dangerous_fuzzers
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+	$KILLALL_PROG -9 fsstress > /dev/null 2>&1
+}
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_require_test
+_require_scratch
+_require_split_debugfs
+_require_compaction
+_require_command "$KILLALL_PROG" "killall"
+
+echo "Silence is golden"
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount >> $seqres.full 2>&1
+
+nr_cpus=$((LOAD_FACTOR * 4))
+nr_ops=$((25000 * nr_cpus * TIME_FACTOR))
+
+fsstress_args=(-w -d $SCRATCH_MNT/test -n $nr_ops -p $nr_cpus)
+
+# used to let our loops know when to stop
+runfile="$tmp.keep.running.loop"
+touch $runfile
+
+# The background ops are out of bounds, the goal is to race with fsstress.
+
+# Force folio split if possible, this seems to be screaming for MADV_NOHUGEPAGE
+# for large folios.
+while [ -e $runfile ]; do
+	for i in $(find $SCRATCH_MNT/test \( -type f \) 2>/dev/null); do
+		_split_huge_pages_file_full $i >/dev/null 2>&1
+	done
+	sleep 2
+done &
+split_huge_pages_files_pid=$!
+
+while [ -e $runfile ]; do
+	echo 1 > /proc/sys/vm/compact_memory
+	sleep 10
+done &
+compaction_pid=$!
+
+blocksize=$(_get_file_block_size $SCRATCH_MNT)
+export XFS_DIO_MIN=$((blocksize * 2))
+
+test -n "$SOAK_DURATION" && fsstress_args+=(--duration="$SOAK_DURATION")
+
+split_count_before=0
+split_count_failed_before=0
+
+if grep -q thp_split_page /proc/vmstat; then
+	split_count_before=$(grep ^thp_split_page /proc/vmstat | head -1 | awk '{print $2}')
+	split_count_failed_before=$(grep ^thp_split_page_failed /proc/vmstat | head -1 | awk '{print $2}')
+else
+	echo "no thp_split_page in /proc/vmstat" >> /proc/vmstat
+fi
+
+$FSSTRESS_PROG $FSSTRESS_AVOID "${fsstress_args[@]}" >> $seqres.full
+
+rm -f $runfile
+wait > /dev/null 2>&1
+
+if grep -q thp_split_page /proc/vmstat; then
+	split_count_after=$(grep ^thp_split_page /proc/vmstat | head -1 | awk '{print $2}')
+	split_count_failed_after=$(grep ^thp_split_page_failed /proc/vmstat | head -1 | awk '{print $2}')
+	thp_split_page=$((split_count_after - split_count_before))
+	thp_split_page_failed=$((split_count_failed_after - split_count_failed_before))
+
+	echo "vmstat thp_split_page: $thp_split_page" >> $seqres.full
+	echo "vmstat thp_split_page_failed: $thp_split_page_failed" >> $seqres.full
+fi
+
+status=0
+exit
diff --git a/tests/generic/745.out b/tests/generic/745.out
new file mode 100644
index 000000000000..fce6b7f5489d
--- /dev/null
+++ b/tests/generic/745.out
@@ -0,0 +1,2 @@
+QA output created by 745
+Silence is golden
-- 
2.43.0


