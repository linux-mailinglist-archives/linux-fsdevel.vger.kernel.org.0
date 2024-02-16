Return-Path: <linux-fsdevel+bounces-11879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 055458584FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 19:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29CF01C20D4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 18:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3701350E3;
	Fri, 16 Feb 2024 18:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eCegxYGH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B0D130E5E;
	Fri, 16 Feb 2024 18:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708107543; cv=none; b=XJDSsvE+Kcp15rJQBdhwvog0Xkoo7udRWQ4fgFEeQSNQu5H50L5p/iDqDtQk53h/JMOtL79vhiP1v0zSU9SU5pA0NHtB38+a/HhhV4jzOWSk7VBvTY8qANeiAK/xZnVRqAQn45SCJoxll8E1BJkGol8aYEZ871zia1iVTHWd5L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708107543; c=relaxed/simple;
	bh=07Cou0HQ+uzdH5wK3SWkr7pZOrRTZFZ6exDqkR4+pUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/f48p1AzC7Whqovo/HSEgYmNwl9El/9KUEVvXpfJXIbQn+ni/Tva/E1zjOV5R7PI8aR2VloQk8oQJGrIfj6hS36P6sWgUJiF0MBz9B6FgCE1puNXaLKi0STMCHXYcOHp3jPTsB1AUev+TCYQCGtGygz8CKg9vOudzlwy3VA14U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eCegxYGH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=BugVdAZLl6iZBDLAjqc/S6sSdpLf33R97Aew9wjkZwQ=; b=eCegxYGHOyH+NkLuvC4IiZfLCK
	+KJDr8H4vXubIAle4eYm+mbeh+XwZpCXhqUxR+7c8n3TqV6OO8rzoD5A03VdRtAajwqTFtBbSeLfc
	KotlgPCsafLq80VC/3fu1EhbzGZlp93cwAIf02WDVp6qaK6/nbdG3+tCknOx1+b6FRmgtMp6uBXrK
	QlYBthTM4E/Z9GPL7Qy09ze1rZ9xNWCN6mZU06u786c17QHNuulaLaK45/yUFJY0D5/pmJ1T+v7uw
	expVkhYjLpm/o9xcVlpIDLuPQaKt44mBzNzgtcgRYI+ZLRofc1imTrFQEb4fe2e6nX5GSNWNhR2oF
	IqtdZSIA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb2nd-00000003J8K-3i1r;
	Fri, 16 Feb 2024 18:19:01 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: fstests@vger.kernel.org,
	anand.jain@oracle.com,
	aalbersh@redhat.com,
	djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	kdevops@lists.linux.dev,
	patches@lists.linux.dev,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 3/3] check: add --print-start-done to enhance watchdogs
Date: Fri, 16 Feb 2024 10:18:59 -0800
Message-ID: <20240216181859.788521-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216181859.788521-1-mcgrof@kernel.org>
References: <20240216181859.788521-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

fstests specific watchdogs want to know when the full test suite will
start and end. Right now the kernel ring buffer can get augmented but we
can't know for sure if it was due to a test or some odd hardware issue
after fstests ran. This is specially true for systems left running tests in
loops in automation where we are not running things ourselves but rather just
get access to kernel logs, or for filesystem runner watdogs such as the one
in kdevops [0]. It is also often not easy to determine for sure based on
just logs when fstests check really has completed unless we have a
matching log of who spawned that test runner. Although we could keep track of
this ourselves by an annotation locally on the test runner, it is useful to
have independent tools which are not attached to the process which spawned
check to just peak into a system and verify the system's progress with
fstests by just using the kernel log. Keeping this in the test target kernel
ring buffer enables these use cases.

This is useful for example for filesyste checker specific watchdogs like the
one in kdevops so that the watchdog knows when to start hunting for crashes
based just on the kernel ring buffer, and so it also knows when the show is
over.

[0] https://github.com/linux-kdevops/kdevops/blob/master/scripts/workflows/fstests/fstests_watchdog.py

Demo:

root@demo-xfs-reflink /var/lib/xfstests # dmesg -c > /dev/null
root@demo-xfs-reflink /var/lib/xfstests # ./check -s xfs_reflink --print-start-done generic/002
SECTION       -- xfs_reflink
RECREATING    -- xfs on /dev/loop16
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 demo-xfs-reflink 6.5.0-5-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.5.13-1 (2023-11-29)
MKFS_OPTIONS  -- -f -f -m reflink=1,rmapbt=1, -i sparse=1, /dev/loop5
MOUNT_OPTIONS -- /dev/loop5 /media/scratch

generic/002        1s
Ran: generic/002
Passed all 1 tests

SECTION       -- xfs_reflink
=========================
Ran: generic/002
Passed all 1 tests

root@demo-xfs-reflink /var/lib/xfstests # dmesg -c
[61392.525562] XFS (loop16): Mounting V5 Filesystem 20c3bdf7-69d8-42b2-8a7c-fccff0949dcc
[61392.536059] XFS (loop16): Ending clean mount
[61392.684417] run fstests fstestsstart/000 at 2024-02-16 17:51:28
[61392.726709] XFS (loop16): Unmounting Filesystem 20c3bdf7-69d8-42b2-8a7c-fccff0949dcc
[61392.779791] XFS (loop16): Mounting V5 Filesystem ce4188e8-8da8-474a-acb4-b1d8c3e7edb7
[61392.791217] XFS (loop16): Ending clean mount
[61393.328386] XFS (loop5): Mounting V5 Filesystem 6e3f6c64-5b48-41b6-8810-d2a41fbcd125
[61393.340019] XFS (loop5): Ending clean mount
[61393.347636] XFS (loop5): Unmounting Filesystem 6e3f6c64-5b48-41b6-8810-d2a41fbcd125
[61393.403519] XFS (loop16): Unmounting Filesystem ce4188e8-8da8-474a-acb4-b1d8c3e7edb7
[61393.456945] XFS (loop16): Mounting V5 Filesystem ce4188e8-8da8-474a-acb4-b1d8c3e7edb7
[61393.466506] XFS (loop16): Ending clean mount
[61393.504926] run fstests generic/002 at 2024-02-16 17:51:29
[61394.579638] XFS (loop16): Unmounting Filesystem ce4188e8-8da8-474a-acb4-b1d8c3e7edb7
[61394.637296] XFS (loop16): Mounting V5 Filesystem ce4188e8-8da8-474a-acb4-b1d8c3e7edb7
[61394.646365] XFS (loop16): Ending clean mount
[61394.762667] XFS (loop16): Unmounting Filesystem ce4188e8-8da8-474a-acb4-b1d8c3e7edb7
[61394.790581] run fstests fstestsdone/000 at 2024-02-16 17:51:30

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 check | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/check b/check
index 523cf024c139..b3fdda57f665 100755
--- a/check
+++ b/check
@@ -19,6 +19,7 @@ have_test_arg=false
 randomize=false
 exact_order=false
 start_after_test=""
+print_start_done=false
 list_group_tests=false
 export here=`pwd`
 xfile=""
@@ -84,6 +85,7 @@ check options
     --large-fs		optimise scratch device for large filesystems
     --list-group-tests	only list tests part of the groups you specified, do not run the tests
     --start-after	only start testing after the test specified
+    --print-start-done  append to /dev/kmsg when available test start and end time
     -s section		run only specified section from config file
     -S section		exclude the specified section from the config file
     -L <n>		loop tests <n> times following a failure, measuring aggregate pass/fail metrics
@@ -379,6 +381,11 @@ while [ $# -gt 0 ]; do
 	--list-group-tests)
 		list_group_tests=true
 		;;
+	--print-start-done)
+		if [ -w /dev/kmsg ]; then
+			print_start_done=true
+		fi
+		;;
 	-s)	RUN_SECTION="$RUN_SECTION $2"; shift ;;
 	-S)	EXCLUDE_SECTION="$EXCLUDE_SECTION $2"; shift ;;
 	-l)	diff="diff" ;;
@@ -1161,6 +1168,11 @@ function run_section()
 	_scratch_unmount 2> /dev/null
 }
 
+if $print_start_done; then
+	start_time=`date +"%F %T"`
+	echo "run fstests fstestsstart/000 at $start_time" > /dev/kmsg
+fi
+
 for ((iters = 0; iters < $iterations; iters++)) do
 	for section in $HOST_OPTIONS_SECTIONS; do
 		run_section $section
@@ -1172,6 +1184,11 @@ for ((iters = 0; iters < $iterations; iters++)) do
 	done
 done
 
+if $print_start_done; then
+	end_time=`date +"%F %T"`
+	echo "run fstests fstestsdone/000 at $end_time" > /dev/kmsg
+fi
+
 interrupt=false
 status=`expr $sum_bad != 0`
 exit
-- 
2.42.0


