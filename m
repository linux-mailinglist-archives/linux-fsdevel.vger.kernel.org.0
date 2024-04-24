Return-Path: <linux-fsdevel+bounces-17678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B04B8B166C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 00:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E7A71C23AC5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 22:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D102B16E888;
	Wed, 24 Apr 2024 22:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AfsSgbqP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A795C16C856;
	Wed, 24 Apr 2024 22:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713998814; cv=none; b=FFSX5k/oGsGOsRd6378DanpaW6iaAa5hPpT9yDazV9OIG/FNPlk41o6kwBu6/ZqPVxcFChMl6/eWmn39Ga5zHaOA2wHvk/s3MB3116ScQNE+bG83SJNIEfi04KoEeU/SDcr9WXiIO+oEoR8QV+FJZQgdHrhsk7m+8JE54mtTTAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713998814; c=relaxed/simple;
	bh=Pzly7aLzb0VvZCh/3FgpujjjD/iX/9vyr6mKhufDIK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pn4QZWx8znS0t867FdiA5CK1zBujVC5tWtnR6PoQR2m3pmAUA4VwDhrAp7CIsG1Bw2yGvZkCk2mp/1Un7bQdZGSS0DP3EdwaomxY9WROCIRLO1n2ImdxzOc82oFSXZWS9/G/HCDB38DG4gZIBFByDciOUoLHIR3TxR2AgRhBfP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AfsSgbqP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Hw0HmQ2VEKVgbWiNSP0dEFNkBKekQpwn0LXOF19HUZ0=; b=AfsSgbqPr+n7jTybbzd1M0TyvG
	BBhEO1mkSDpfZqZMdokLbmyzCxQQDKFWDp8hEQ+ya00glLCUlpjpvCsQ80LKupeQs8uf589jw+3gT
	nsoWeyw5LFhF6I3yjKkk2e/T2Pam5TGzSlPSdsn9hHYqZDoUkg+nZLFguqD/JGiUro+DGWME4bNTo
	YlwDW5s1kAjPhSp3e33E5scxlbhlen8f50kRupmfx150AiganALAjrexnuUVv+umhhRGxGwefHdRx
	mjU+0yHQ0Faa7YQDStrplqKEdbvYn1aOiaWPG142aOVEDK9Htwgghi1WdklSP03lED9P2Zp2ACZWV
	4gZxZ+vA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzlO5-00000006GgV-35I8;
	Wed, 24 Apr 2024 22:46:49 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	willy@infradead.org,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	hare@suse.de,
	john.g.garry@oracle.com,
	ziy@nvidia.com,
	linux-xfs@vger.kernel.org,
	patches@lists.linux.dev,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC] fstests: add fsstress + writeback + debugfs folio split test
Date: Wed, 24 Apr 2024 15:46:48 -0700
Message-ID: <20240424224649.1494092-1-mcgrof@kernel.org>
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
a new smaller folio order. This is dangerous at the moment as its using
a debugfs API which requires two out of tree fixes [0] [1] which will
be posted shortly. With these patches applied no crash is possible yet.
However, this test was designed to try to exacerbate races with folio
splits and writeback, at least running generic/447 twice ends up
producing a crash only if large folio splits with minimum folio order
is enabled.

With the known fixes for the debugfs interface, this test produces no
crashes even after 3 hour soaking for 4k and LBS. We should enhance
this test a bit more so to reproduce the issues observed by running
generic/447 twice.

This also begs the question if something like MADV_NOHUGEPAGE might be
desirable from userspace, so to enable userspace to request splits when
possible.

If inspecting more closely, you'll want to enable on your kernel boot:

	dyndbg='file mm/huge_memory.c +p'

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?h=20240424-lbs&id=80f6df5037fd0ad560526af45bd7f4d779fe03f6
[1] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?h=20240424-lbs&id=38f6fac5b4283ea48b1876fc56728f062168f8c3
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

For those that want to help stress test folio splits to an order, hopefully
this will help start to enable this. Perhaps there are better ways to create
more easy targets to stress test folio splits, and in particular try to
reproduce the issue which so far is only possible by running generic/447 twice
on LBS. The issue with generic/447 on LBS is not observed on 4k, and this test
produces no crashes on LBS...

 common/rc             | 20 +++++++++
 tests/generic/745     | 97 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/745.out |  2 +
 3 files changed, 119 insertions(+)
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
index 000000000000..0a30dbee35bd
--- /dev/null
+++ b/tests/generic/745
@@ -0,0 +1,97 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 Luis Chamberlain. All Rights Reserved.
+#
+# FS QA Test No. 734
+#
+# Run fsstress in a loop, and in the background force some writeback and
+# folio splits for every file. If you're enabling this and want to check
+# underneath the hood you may want to enable:
+#
+# dyndbg='file mm/huge_memory.c +p'
+. ./common/preamble
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
+blocksize=$(_get_file_block_size $SCRATCH_MNT)
+export XFS_DIO_MIN=$((blocksize * 2))
+
+test -n "$SOAK_DURATION" && fsstress_args+=(--duration="$SOAK_DURATION")
+
+# Our general goal here is to race with ops which can stress folio addition,
+# removal, edits, and writeback.
+
+# zero frequencies for write ops to minimize writeback
+fsstress_args+=(-R)
+
+# XXX: we can improve this, so to increase the chances to allow more
+# folio splits. Also running generic/447 twice triggers a corner case we can't
+# capture here on folio splits and write_cache_pages, increasing the chances of
+# this test to cover that same corner case would be ideal.
+#
+# https://gist.github.com/mcgrof/d12f586ec6ebe32b2472b5d634c397df
+fsstress_args+=(-f creat=1)
+fsstress_args+=(-f write=1)
+fsstress_args+=(-f dwrite=1)
+fsstress_args+=(-f truncate=1)
+fsstress_args+=(-f zero=1)
+fsstress_args+=(-f unlink=1)
+fsstress_args+=(-f fsync=1)
+fsstress_args+=(-f punch=2)
+fsstress_args+=(-f copyrange=4)
+fsstress_args+=(-f clonerange=4)
+
+if [[ "$FSTYP" != "xfs" || "$FSTYP" == "ext4" ]]; then
+	fsstress_args+=(-f collapse=1)
+fi
+
+$FSSTRESS_PROG $FSSTRESS_AVOID "${fsstress_args[@]}" >> $seqres.full
+
+rm -f $runfile
+wait > /dev/null 2>&1
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


