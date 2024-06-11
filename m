Return-Path: <linux-fsdevel+bounces-21372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD049902EE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 05:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7971F23186
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 03:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B17B16FF47;
	Tue, 11 Jun 2024 03:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tUD/4hEu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5589716F8E0;
	Tue, 11 Jun 2024 03:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718074929; cv=none; b=G+crjlTzdKUPsy7mcpCqwTOhfVYNSnQWP+oM+MMx5YvIrcWnVA2NGDc/g+mSC1lZi7Kn1RG2TnbuNUkUozA//JUbKL0A9E8e6nzB/3Xl5MC46Z0GpIki5Y/r2f3C//zpwDBBGfHRRkgNDCVGZYbK+etwpFqxCaYJSECiUFCx8Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718074929; c=relaxed/simple;
	bh=uN2PiGu6IvSFFUOXZL8XHjpkCxUo4UX94FylCZpICvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udo/R6bXaO1NQTnIWAwaTjUPPXsiohLOXalheeY+Pv6sGTdilvFp6gtFLRsJm7XasSaVx2G3G3yKiWzwjhbJrz4iyoM+xaSVjNHpzpZnTLAilDGTQRw9PZXwj3xxj08KSsw28GjjypGtK9VmfrgubxooITegfXLsieRqxmq0hPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tUD/4hEu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Hv/cXQiOxKNgXmCwyVTUDGGov4wBn8i/fmF48xSrHJk=; b=tUD/4hEuSCcxRCkWHCYdICg4V1
	aQVNu8MES9D2iMfkf0d6CXzkD+DIkcvF8xvtjLGMOZtsBapUP1fOpVyDi55ef/m6fYV9kO3JIGPdO
	9Ob4C5GzLJfP0PbEi1m+Gu/HRRRL4+gP3QUFPEw495CaEPQFPLcrZUBdQ5lb76JIJpS5UKI0onozu
	5d8/Vzt0VycLoHwFyKUXdqkiPUHM3htT+hGKeaTqq7eo60KpsXwEgCuz1cQPvJJpUYGgPdWPCvmSx
	wH1HMpvahXkxWBV0csveIVGfqMQ0V27EOOhyLTB8MFKaTBd9P7N18XQ2befZxRfYy8q1PuEBc+Z3z
	/nVhMneQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGrls-00000007DDK-294X;
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
Subject: [PATCH 3/5] fstests: add fsstress + compaction test
Date: Mon, 10 Jun 2024 20:02:00 -0700
Message-ID: <20240611030203.1719072-4-mcgrof@kernel.org>
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

Running compaction while we run fsstress can crash older kernels as per
korg#218227 [0], the fix for that [0] has been posted [1] that patch
was merged on v6.9-rc6 fixed by commit d99e3140a4d3 ("mm: turn
folio_test_hugetlb into a PageType"). However even on v6.10-rc2 where
this kernel commit is already merged we can still deadlock when running
fsstress and at the same time triggering compaction, this is a new
issue being reported now this through patch, but this patch also
serves as a reproducer with a high confidence. It always deadlocks.
If you enable CONFIG_PROVE_LOCKING with the defaults you will end up
with a complaint about increasing MAX_LOCKDEP_CHAIN_HLOCKS [1], if
you adjust that you then end up with a few soft lockup complaints and
some possible deadlock candidates to evaluate [2].

Provide a simple reproducer and pave the way so we keep on testing this.

Without lockdep enabled we silently deadlock on the first run of the
test without the fix applied. With lockdep enabled you get a splat about
the possible deadlock on the first run of the test.

[0] https://bugzilla.kernel.org/show_bug.cgi?id=218227
[1] https://gist.github.com/mcgrof/824913b645892214effeb1631df75072
[2] https://gist.github.com/mcgrof/926e183d21c5c4c55d74ec90197bd77a

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 common/rc             |  7 +++++
 tests/generic/750     | 62 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/750.out |  2 ++
 3 files changed, 71 insertions(+)
 create mode 100755 tests/generic/750
 create mode 100644 tests/generic/750.out

diff --git a/common/rc b/common/rc
index e812a2f7cc67..18ad25662d5c 100644
--- a/common/rc
+++ b/common/rc
@@ -151,6 +151,13 @@ _require_hugepages()
 		_notrun "Kernel does not report huge page size"
 }
 
+# Requires CONFIG_COMPACTION
+_require_vm_compaction()
+{
+	if [ ! -f /proc/sys/vm/compact_memory ]; then
+	    _notrun "Need compaction enabled CONFIG_COMPACTION=y"
+	fi
+}
 # Get hugepagesize in bytes
 _get_hugepagesize()
 {
diff --git a/tests/generic/750 b/tests/generic/750
new file mode 100755
index 000000000000..334ab011dfa0
--- /dev/null
+++ b/tests/generic/750
@@ -0,0 +1,62 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Luis Chamberlain.  All Rights Reserved.
+#
+# FS QA Test 750
+#
+# fsstress + memory compaction test
+#
+. ./common/preamble
+_begin_fstest auto rw long_rw stress soak smoketest
+
+_cleanup()
+{
+	cd /
+	rm -f $runfile
+	rm -f $tmp.*
+	kill -9 $trigger_compaction_pid > /dev/null 2>&1
+	$KILLALL_PROG -9 fsstress > /dev/null 2>&1
+
+	wait > /dev/null 2>&1
+}
+
+# Import common functions.
+
+# real QA test starts here
+
+_supported_fs generic
+
+_require_scratch
+_require_vm_compaction
+_require_command "$KILLALL_PROG" "killall"
+
+# We still deadlock with this test on v6.10-rc2, we need more work.
+# but the below makes things better.
+_fixed_by_git_commit kernel d99e3140a4d3 \
+	"mm: turn folio_test_hugetlb into a PageType"
+
+echo "Silence is golden"
+
+_scratch_mkfs > $seqres.full 2>&1
+_scratch_mount >> $seqres.full 2>&1
+
+nr_cpus=$((LOAD_FACTOR * 4))
+nr_ops=$((25000 * nr_cpus * TIME_FACTOR))
+fsstress_args=(-w -d $SCRATCH_MNT -n $nr_ops -p $nr_cpus)
+
+# start a background trigger for memory compaction
+runfile="$tmp.compaction"
+touch $runfile
+while [ -e $runfile ]; do
+	echo 1 > /proc/sys/vm/compact_memory
+	sleep 5
+done &
+trigger_compaction_pid=$!
+
+test -n "$SOAK_DURATION" && fsstress_args+=(--duration="$SOAK_DURATION")
+
+$FSSTRESS_PROG $FSSTRESS_AVOID "${fsstress_args[@]}" >> $seqres.full
+wait > /dev/null 2>&1
+
+status=0
+exit
diff --git a/tests/generic/750.out b/tests/generic/750.out
new file mode 100644
index 000000000000..bd79507b632e
--- /dev/null
+++ b/tests/generic/750.out
@@ -0,0 +1,2 @@
+QA output created by 750
+Silence is golden
-- 
2.43.0


