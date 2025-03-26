Return-Path: <linux-fsdevel+bounces-45102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8033AA71EA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 19:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407FE3BBF1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 18:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898A7253331;
	Wed, 26 Mar 2025 18:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TOBgnsZW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCC317F7;
	Wed, 26 Mar 2025 18:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743015068; cv=none; b=JovLa1rsAV8I1u6l/chOg/taMdqgz0TBtzdQ6b/t7s/rXCqbCIsxMwe598sV9Am4XDmbHYQKHJS1c+I+QJ5stnzs7J4jkZTXdwBy5FS9/r+W1+p2+ZlvrGz0QZixdJLTOrC3fU8yDrW3LyYXgmGfeGYVK2T04e1Qd242uGNtmR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743015068; c=relaxed/simple;
	bh=DWgEXr9fuwdtMXS+nOYIHZ1UHKVv3edPUTElOoJ/aZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EfLYf8gdyZ40utLgfwZzv/resEjcZV07LvcDDn6+X88fqanzC/zLNjtrN8MMcNbzm+Lwb8F3OmCowr5jRdhczhnaPG5M0po/UF3xaKV2y6XVNJK2A55YqkjqW3UHdts9fgKWGANaNsHy7F2ZOoMnUI679egKzXmpDus/GVmeMwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TOBgnsZW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=EswWmpH0jdfJkjx/smz0IWtj6k3xpAbWXDFWCIq3/Gg=; b=TOBgnsZWngiPWkGP2A/P6PFSAV
	+3FwAaUROryqiOu0PfRDntjMVa6xc4IrMYNiHVnUrsPG0hLVfTD7nKG8TMpCfn28VblSkvYIT4XJI
	6EnZDerlzJs7NBPzqnFpuKDLiiRXEjlesv0gx48NJlzzfLQguRByX+Q6Gt1Jg1nRf6q5uona+f31M
	5+HFbZKkjrUAthOJHQ0S91cQY1jwLxJAujFB69R+ptvPAvN46B3kClH2RVOzosnl0hqx6YJV+nQGX
	ZAOZt9zT8dXd32D1q6iBSHjMimi3Wj/Mmb+tgVkC2Y1QwlXBk2eHdQYkeenD3qtThfu0fgP1CXvk7
	aEO/DiEA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txVqB-00000009O28-1Nuk;
	Wed, 26 Mar 2025 18:51:03 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: patches@lists.linux.dev,
	fstests@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	oliver.sang@intel.com,
	hannes@cmpxchg.org,
	willy@infradead.org,
	jack@suse.cz,
	apopple@nvidia.com,
	brauner@kernel.org,
	hare@suse.de,
	oe-lkp@lists.linux.dev,
	lkp@intel.com,
	john.g.garry@oracle.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	dave@stgolabs.net,
	riel@surriel.com,
	krisman@suse.de,
	boris@bur.io,
	jackmanb@google.com,
	gost.dev@samsung.com,
	mcgrof@kernel.org
Subject: [PATCH] generic/764: fsstress + migrate_pages() test
Date: Wed, 26 Mar 2025 11:50:55 -0700
Message-ID: <20250326185101.2237319-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

0-day reported a page migration kernel warning with folios which happen
to be buffer-heads [0]. I'm having a terribly hard time reproducing the bug
and so I wrote this test to force page migration filesystems.

It turns out we have have no tests for page migration on fstests or ltp,
and its no surprise, other than compaction covered by generic/750 there
is no easy way to trigger page migration right now unless you have a
numa system.

We should evaluate if we want to help stress test page migration
artificially by later implementing a way to do page migration on simple
systems to an artificial target.

So far, this doesn't trigger any kernel splats, not even warnings for me.

Reported-by: kernel test robot <oliver.sang@intel.com>
Link: https://lore.kernel.org/r/202503101536.27099c77-lkp@intel.com # [0]
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 common/config         |  2 +
 common/rc             |  8 ++++
 tests/generic/764     | 94 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/764.out |  2 +
 4 files changed, 106 insertions(+)
 create mode 100755 tests/generic/764
 create mode 100644 tests/generic/764.out

diff --git a/common/config b/common/config
index 2afbda141746..93b50f113b44 100644
--- a/common/config
+++ b/common/config
@@ -239,6 +239,8 @@ export BTRFS_MAP_LOGICAL_PROG=$(type -P btrfs-map-logical)
 export PARTED_PROG="$(type -P parted)"
 export XFS_PROPERTY_PROG="$(type -P xfs_property)"
 export FSCRYPTCTL_PROG="$(type -P fscryptctl)"
+export NUMACTL_PROG="$(type -P numactl)"
+export MIGRATEPAGES_PROG="$(type -P migratepages)"
 
 # udev wait functions.
 #
diff --git a/common/rc b/common/rc
index e51686389a78..ed9613a9bf28 100644
--- a/common/rc
+++ b/common/rc
@@ -281,6 +281,14 @@ _require_vm_compaction()
 	fi
 }
 
+_require_numa_nodes()
+{
+	readarray -t QUEUE < <($NUMACTL_PROG --show | awk '/^membind:/ {for (i=2; i<=NF; i++) print $i}')
+	if (( ${#QUEUE[@]} < 2 )); then
+		_notrun "You need a system with at least two numa nodes to run this test"
+	fi
+}
+
 # Requires CONFIG_DEBUGFS and truncation knobs
 _require_split_huge_pages_knob()
 {
diff --git a/tests/generic/764 b/tests/generic/764
new file mode 100755
index 000000000000..91d9fb7e08da
--- /dev/null
+++ b/tests/generic/764
@@ -0,0 +1,94 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Luis Chamberlain.  All Rights Reserved.
+#
+# FS QA Test 764
+#
+# fsstress + migrate_pages() test
+#
+. ./common/preamble
+_begin_fstest auto rw long_rw stress soak smoketest
+
+_cleanup()
+{
+	cd /
+	rm -f $runfile
+	rm -f $tmp.*
+	kill -9 $run_migration_pid > /dev/null 2>&1
+	kill -9 $stress_pid > /dev/null 2>&1
+
+	wait > /dev/null 2>&1
+}
+
+_require_scratch
+_require_command "$NUMACTL_PROG" "numactl"
+_require_command "$MIGRATEPAGES_PROG" "migratepages"
+_require_numa_nodes
+
+readarray -t QUEUE < <($NUMACTL_PROG --show | awk '/^membind:/ {for (i=2; i<=NF; i++) print $i}')
+if (( ${#QUEUE[@]} < 2 )); then
+	echo "Not enough NUMA nodes to pick two different ones."
+	exit 1
+fi
+
+echo "Silence is golden"
+
+_scratch_mkfs > $seqres.full 2>&1
+_scratch_mount >> $seqres.full 2>&1
+
+nr_cpus=$((LOAD_FACTOR * 4))
+nr_ops=$((25000 * nr_cpus * TIME_FACTOR))
+fsstress_args=(-w -d $SCRATCH_MNT -n $nr_ops -p $nr_cpus)
+test -n "$SOAK_DURATION" && fsstress_args+=(--duration="$SOAK_DURATION")
+
+runfile="$tmp.migratepages"
+pidfile="$tmp.stress.pid"
+
+run_stress_fs()
+{
+	$FSSTRESS_PROG $FSSTRESS_AVOID "${fsstress_args[@]}" &
+	stress_pid=$!
+	echo $stress_pid > $pidfile
+	wait $stress_pid
+	rm -f $runfile
+	rm -f $pidfile
+}
+
+run_stress_fs &
+touch $runfile
+
+stress_pid=$(cat $pidfile)
+
+while [ -e $runfile ]; do
+	readarray -t QUEUE < <(numactl --show | awk '/^membind:/ {for (i=2; i<=NF; i++) print $i}')
+	# Proper Fisher–Yates shuffle
+	for ((i=${#QUEUE[@]} - 1; i > 0; i--)); do
+		j=$((RANDOM % (i + 1)))
+		var=${QUEUE[i]}
+		QUEUE[i]=${QUEUE[j]}
+		QUEUE[j]=$var
+	done
+
+	RANDOM_NODE_1=${QUEUE[0]}
+	RANDOM_NODE_2=${QUEUE[1]}
+
+	if [[ -f $pidfile ]]; then
+		echo "migrating parent fsstress process:" >> $seqres.full
+		echo -en "\t$MIGRATEPAGES_PROG $pid $RANDOM_NODE_1 $RANDOM_NODE_2 ..." >> $seqres.full
+		$MIGRATEPAGES_PROG $stress_pid $RANDOM_NODE_1 $RANDOM_NODE_2
+		echo " $?" >> $seqres.full
+		echo "migrating child fsstress processes ..." >> $seqres.full
+		for pid in $(ps --ppid "$stress_pid" -o pid=); do
+			echo -en "\tmigratepages $pid $RANDOM_NODE_1 $RANDOM_NODE_2 ..." >> $seqres.full
+			$MIGRATEPAGES_PROG $pid $RANDOM_NODE_1 $RANDOM_NODE_2
+			echo " $?" >> $seqres.full
+		done
+	fi
+	sleep 2
+done &
+run_migration_pid=$!
+
+wait > /dev/null 2>&1
+
+status=0
+exit
diff --git a/tests/generic/764.out b/tests/generic/764.out
new file mode 100644
index 000000000000..bb58e5b8957f
--- /dev/null
+++ b/tests/generic/764.out
@@ -0,0 +1,2 @@
+QA output created by 764
+Silence is golden
-- 
2.47.2


