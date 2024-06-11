Return-Path: <linux-fsdevel+bounces-21369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AEE902EDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 05:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A01D11C22CFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 03:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6EC16F918;
	Tue, 11 Jun 2024 03:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tyK80xDR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5584F7E782;
	Tue, 11 Jun 2024 03:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718074928; cv=none; b=ROs3dgX+BQ9Iydqlr3WEgOn7LED6Rs8HxbWWevRaorLLjmOvAA+FdDzwCQkU3hz+1zehcue/xXBzm3O/N8TOnDSxa4oUjLIUM6NL0Jlh29+Xe51L4AJe4iqLKh3ALyeu73OxIGadAMZBhMlxk0ss09NgfukR6OGTljv2Nn3Gk4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718074928; c=relaxed/simple;
	bh=0UFPifbtnr1gSnowkmHbNZZMQdlAKHV/k6/w1U/2hfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mdB1BgPf2GYi9RPnFLlKxQODCVBTqOK10AhuAbGYiHkqb/h8YjcBc50fTjdhXVhw0m6RXxwIFE8/cqDRvUqapemsl531ugKe+M2dKMOmhqZ0LJPCMbJ4aQ5Y4SDCpFzF7Isvmm7RFFfLETUZ+2uzneH2IUng7qNT6bL8WLUi3LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tyK80xDR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=w5upqqK3le9bkA35Adh9sB0Tb3TWHmZ5mS+iqjEKnts=; b=tyK80xDR4FjkmXamvnGufFwee/
	osrHpUf1HtQ7JnZlKRPjDbwP6VxoRLDshUf1idmTDgzPQ+o+IBHMJw4lIaXvBME2ey/SQOv4qJHE0
	VoOAOYx1Dw7Xetp3OUDD8IhANx6OsQV38M5S+ialE3F3kBNW+2cWU/ynh9I7FtSqdx20fyr9ly/b/
	JdZmLCHGKzswNupQYtEkfjAcNXED2JcUObhdgPkEmjgLTSmJm+An6HmkF8VY9B/DICy229Ek8ILcP
	/j/RAriVVoSgBiq96+VcYOrrOuvfIOEv2Q5UTveYEUa60fNtFjy28iq9i34Wl6bN+8AWd/CaiRwqx
	BaXeOayw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGrls-00000007DDO-2Yy9;
	Tue, 11 Jun 2024 03:02:04 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: patches@lists.linux.dev,
	fstests@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org,
	ziy@nvidia.com,
	vbabka@suse.cz,
	seanjc@google.com,
	willy@infradead.org,
	david@redhat.com,
	hughd@google.com,
	linmiaohe@huawei.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	hare@suse.de,
	john.g.garry@oracle.com,
	mcgrof@kernel.org
Subject: [PATCH 5/5] fstests: add stress truncation + writeback test
Date: Mon, 10 Jun 2024 20:02:02 -0700
Message-ID: <20240611030203.1719072-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240611030203.1719072-1-mcgrof@kernel.org>
References: <20240611030203.1719072-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Stress test folio splits by using the new debugfs interface to a target
a new smaller folio order while triggering writeback at the same time.

This is known to only creates a crash with min order enabled, so for example
with a 16k block sized XFS test profile, an xarray fix for that is merged
already. This issue is fixed by kernel commit 2a0774c2886d ("XArray: set the
marks correctly when splitting an entry").

If inspecting more closely, you'll want to enable on your kernel boot:

	dyndbg='file mm/huge_memory.c +p'

Since we want to race large folio splits we also augment the full test
output log $seqres.full with the test specific number of successful
splits from vmstat thp_split_page and thp_split_page_failed. The larger
the vmstat thp_split_page the more we stress test this path.

This test reproduces a really hard to reproduce crash immediately.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 common/rc             |  14 +++++
 tests/generic/751     | 127 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/751.out |   2 +
 3 files changed, 143 insertions(+)
 create mode 100755 tests/generic/751
 create mode 100644 tests/generic/751.out

diff --git a/common/rc b/common/rc
index 30beef4e5c02..60f572108818 100644
--- a/common/rc
+++ b/common/rc
@@ -158,6 +158,20 @@ _require_vm_compaction()
 	    _notrun "Need compaction enabled CONFIG_COMPACTION=y"
 	fi
 }
+
+# Requires CONFIG_DEBUGFS and truncation knobs
+_require_split_debugfs()
+{
+       if [ ! -f $DEBUGFS_MNT/split_huge_pages ]; then
+           _notrun "Needs CONFIG_DEBUGFS and split_huge_pages"
+       fi
+}
+
+_split_huge_pages_all()
+{
+	echo 1 > $DEBUGFS_MNT/split_huge_pages
+}
+
 # Get hugepagesize in bytes
 _get_hugepagesize()
 {
diff --git a/tests/generic/751 b/tests/generic/751
new file mode 100755
index 000000000000..7cc96054a5a9
--- /dev/null
+++ b/tests/generic/751
@@ -0,0 +1,127 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 Luis Chamberlain. All Rights Reserved.
+#
+# FS QA Test No. 751
+#
+# stress page cache truncation + writeback
+#
+# This aims at trying to reproduce a difficult to reproduce bug found with
+# min order. The issue was root caused to an xarray bug when we split folios
+# to another order other than 0. This functionality is used to support min
+# order. The crash:
+#
+# https://gist.github.com/mcgrof/d12f586ec6ebe32b2472b5d634c397df
+#
+# This may also find future truncation bugs in the future, as truncating any
+# mapped file through the collateral of using echo 1 > split_huge_pages will
+# always respect the min order. Truncating to a larger order then is excercised
+# when this test is run against any filesystem LBS profile or an LBS device.
+#
+# If you're enabling this and want to check underneath the hood you may want to
+# enable:
+#
+# dyndbg='file mm/huge_memory.c +p'
+#
+# This tests aims at increasing the rate of successful truncations so we want
+# to increase the value of thp_split_page in $seqres.full. Using echo 1 >
+# split_huge_pages is extremely aggressive, and even accounts for anonymous
+# memory on a system, however we accept that tradeoff for the efficiency of
+# doing the work in-kernel for any mapped file too. Our general goal here is to
+# race with folio truncation + writeback.
+
+. ./common/preamble
+
+_begin_fstest auto long_rw stress soak smoketest
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+	rm -f $runfile
+	kill -9 $split_huge_pages_files_pid > /dev/null 2>&1
+}
+
+fio_config=$tmp.fio
+fio_out=$tmp.fio.out
+
+# real QA test starts here
+_supported_fs generic
+_require_test
+_require_scratch
+_require_debugfs
+_require_split_debugfs
+_require_command "$KILLALL_PROG" "killall"
+_fixed_by_git_commit kernel 2a0774c2886d \
+	"XArray: set the marks correctly when splitting an entry"
+
+# we need buffered IO to force truncation races with writeback in the
+# page cache
+cat >$fio_config <<EOF
+[force_large_large_folio_parallel_writes]
+nrfiles=10
+direct=0
+bs=4M
+group_reporting=1
+filesize=1GiB
+readwrite=write
+fallocate=none
+numjobs=$(nproc)
+directory=$SCRATCH_MNT
+runtime=100*${TIME_FACTOR}
+time_based
+EOF
+
+_require_fio $fio_config
+
+echo "Silence is golden"
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount >> $seqres.full 2>&1
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
+	_split_huge_pages_all >/dev/null 2>&1
+done &
+split_huge_pages_files_pid=$!
+
+split_count_before=0
+split_count_failed_before=0
+
+if grep -q thp_split_page /proc/vmstat; then
+	split_count_before=$(grep ^thp_split_page /proc/vmstat | head -1 | awk '{print $2}')
+	split_count_failed_before=$(grep ^thp_split_page_failed /proc/vmstat | head -1 | awk '{print $2}')
+else
+	echo "no thp_split_page in /proc/vmstat" >> $seqres.full
+fi
+
+# we blast away with large writes to force large folio writes when
+# possible.
+echo -e "Running fio with config:\n" >> $seqres.full
+cat $fio_config >> $seqres.full
+$FIO_PROG $fio_config --alloc-size=$(( $(nproc) * 8192 )) --output=$fio_out
+
+rm -f $runfile
+
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
diff --git a/tests/generic/751.out b/tests/generic/751.out
new file mode 100644
index 000000000000..6479fa6f1404
--- /dev/null
+++ b/tests/generic/751.out
@@ -0,0 +1,2 @@
+QA output created by 751
+Silence is golden
-- 
2.43.0


