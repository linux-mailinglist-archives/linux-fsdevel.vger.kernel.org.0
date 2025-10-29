Return-Path: <linux-fsdevel+bounces-66146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6085AC17E01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A9DA426E9F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8A92D9EEA;
	Wed, 29 Oct 2025 01:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gydd/QP8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49F72D4807;
	Wed, 29 Oct 2025 01:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700951; cv=none; b=N0PUlyuIzCG+qOtbFV1AoOA6u7LOdC0TotfXrbQKDnPEL1H44dGqdfPeC2R+2hxqBBsjb2zoaeB1kQccwig+SNNPYRGZv6xLEA3bh3jpMdpVpP2DE+n6x8sG0g+rNNX2C85r7SiLd9tWcq4IQWq8NkfXtvM6NOZiBXyxMD3L4II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700951; c=relaxed/simple;
	bh=PnR7wXcUUubxQ/wRxHO6s+8N5fXWmRF3JxNQbra0+DQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LJH9BpkNWPo1M+VKjGK4R44lTJIWPrG3VXc50LUhn9xzD2uHGzRg7uwHa2iOBgBdmJiKJ7QdKYm3qvr/4YEUANSM4P0XxI7WJvOsmdzQIwfytgi5gsAevRJq7doKXnP/fjWGKwyBbYXLl/7t4McjWZ9cVQdNlLrJGLs9UuRu86c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gydd/QP8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA10C4CEFD;
	Wed, 29 Oct 2025 01:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700951;
	bh=PnR7wXcUUubxQ/wRxHO6s+8N5fXWmRF3JxNQbra0+DQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=gydd/QP8S9a9gn1PEkepJ9KPRe4vg77TTimFQ14EUqeW3XAbLb9Hjd/30nhKGq92s
	 4q1DByyF4fuRSRikkjoxBiaOd3Bh5L+/m6YxuJ1fvNPfQf0b6mM+sd+b1oqnT5rDjb
	 vN7Lz14T0xevhVEypI0hTotugF4pvY7yDeditg+Pzt8tFPTxkzkJ8G+ZHr7Thi2Nw2
	 oezthJutDXfGlAQ8pp8S9EXbcxz3EykANPzMFPjvY5LtdaIkgmbt42KycW7koMEzC/
	 LTD5qs39dFu8o2IiCD5L46g/KVKqR1wrn5jAZHA7ysKcCOoFZpKVDiaK+55eSz6uUg
	 eDov8HL0pzM8A==
Date: Tue, 28 Oct 2025 18:22:31 -0700
Subject: [PATCH 08/33] misc: convert _scratch_mount -o remount to
 _scratch_remount
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: neal@gompa.dev, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169820126.1433624.6296363063091653426.stgit@frogsfrogsfrogs>
In-Reply-To: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Use the purpose-built scratch filesystem remount helper so that we don't
waste time recomputing mount options.  This is needed for any filesystem
with a mount helper (i.e. /sbin/fs/mount.$FSTYP) because mount(8)
assumes that every helper is smart enough to find an existing mount and
remount it... and some of them like fuse2fs are not that smart.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/btrfs/015   |    2 +-
 tests/btrfs/032   |    2 +-
 tests/btrfs/082   |    2 +-
 tests/f2fs/005    |    2 +-
 tests/generic/082 |    4 ++--
 tests/generic/235 |    4 ++--
 tests/generic/294 |    2 +-
 tests/xfs/017     |    4 ++--
 tests/xfs/075     |    2 +-
 tests/xfs/189     |    4 ++--
 tests/xfs/199     |    2 +-
 11 files changed, 15 insertions(+), 15 deletions(-)


diff --git a/tests/btrfs/015 b/tests/btrfs/015
index fc4277ff357424..adcf9941ac1ce7 100755
--- a/tests/btrfs/015
+++ b/tests/btrfs/015
@@ -16,7 +16,7 @@ _require_scratch
 
 _scratch_mkfs > /dev/null 2>&1
 _scratch_mount -o ro
-_scratch_mount -o rw,remount
+_scratch_remount remount
 
 $BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap >> $seqres.full 2>&1 \
 	|| _fail "couldn't create snapshot"
diff --git a/tests/btrfs/032 b/tests/btrfs/032
index 5a963145b5bf6e..9653ddd28aaa1f 100755
--- a/tests/btrfs/032
+++ b/tests/btrfs/032
@@ -19,6 +19,6 @@ _scratch_mount "-o flushoncommit"
 
 $XFS_IO_PROG -f -c "pwrite 0 10M" "$SCRATCH_MNT/tmpfile" | _filter_xfs_io
 
-_scratch_mount "-o remount,ro"
+_scratch_remount "ro"
 
 status=0 ; exit
diff --git a/tests/btrfs/082 b/tests/btrfs/082
index 13cd1a2874e4f6..db55d688af5fb1 100755
--- a/tests/btrfs/082
+++ b/tests/btrfs/082
@@ -25,7 +25,7 @@ _require_scratch
 _scratch_mkfs >$seqres.full 2>&1
 
 _scratch_mount "-o thread_pool=6"
-_scratch_mount "-o remount,thread_pool=10"
+_scratch_remount "thread_pool=10"
 
 echo "Silence is golden"
 status=0
diff --git a/tests/f2fs/005 b/tests/f2fs/005
index 33d4fdb9bc97ee..56969968d0e907 100755
--- a/tests/f2fs/005
+++ b/tests/f2fs/005
@@ -36,7 +36,7 @@ mv $tmpfile $tmpdir
 # it runs out of free segment
 dd if=/dev/zero of=$testfile bs=1M count=5 conv=notrunc conv=fsync 2>/dev/null
 
-_scratch_mount -o remount,checkpoint=enable
+_scratch_remount checkpoint=enable
 
 # it may hang umount if tmpdir is still dirty during evict()
 _scratch_unmount
diff --git a/tests/generic/082 b/tests/generic/082
index f078ef2ffff944..0b2fabd4c0923f 100755
--- a/tests/generic/082
+++ b/tests/generic/082
@@ -35,10 +35,10 @@ quotaon $SCRATCH_MNT >>$seqres.full 2>&1
 # quota, but currently xfs doesn't fail in this case, the unknown option is
 # just ignored, but quota is still on. This may change in future, let's
 # re-consider the case then.
-_try_scratch_mount "-o remount,ro,nosuchopt" >>$seqres.full 2>&1
+_scratch_remount "ro,nosuchopt" >>$seqres.full 2>&1
 quotaon -p $SCRATCH_MNT | _filter_scratch | filter_project_quota_line
 # second remount should succeed, no oops or hang expected
-_try_scratch_mount "-o remount,ro" || _fail "second remount,ro failed"
+_scratch_remount "ro" || _fail "second remount,ro failed"
 
 # success, all done
 status=0
diff --git a/tests/generic/235 b/tests/generic/235
index 037c29e806dbc4..1f97d5686d5a58 100755
--- a/tests/generic/235
+++ b/tests/generic/235
@@ -39,9 +39,9 @@ do_repquota
 # https://bugzilla.redhat.com/show_bug.cgi?id=563267
 #
 # then you need a more recent mount binary.
-_try_scratch_mount "-o remount,ro" 2>&1 | tee -a $seqres.full | _filter_scratch
+_scratch_remount "ro" 2>&1 | tee -a $seqres.full | _filter_scratch
 touch $SCRATCH_MNT/failed 2>&1 | tee -a $seqres.full | _filter_scratch
-_try_scratch_mount "-o remount,rw" 2>&1 | tee -a $seqres.full | _filter_scratch
+_scratch_remount "rw" 2>&1 | tee -a $seqres.full | _filter_scratch
 
 touch $SCRATCH_MNT/testfile2
 chown $qa_user:$qa_user $SCRATCH_MNT/testfile2
diff --git a/tests/generic/294 b/tests/generic/294
index b074591163714d..1381492879a9b7 100755
--- a/tests/generic/294
+++ b/tests/generic/294
@@ -40,7 +40,7 @@ rm -rf $THIS_TEST_DIR
 mkdir $THIS_TEST_DIR || _fail "Could not create dir for test"
 
 _create_files 2>&1 | _filter_scratch
-_try_scratch_mount -o remount,ro || _fail "Could not remount scratch readonly"
+_scratch_remount ro || _fail "Could not remount scratch readonly"
 _create_files 2>&1 | _filter_scratch
 
 # success, all done
diff --git a/tests/xfs/017 b/tests/xfs/017
index 263ecc7530ef7c..22ea0d78ed2ef8 100755
--- a/tests/xfs/017
+++ b/tests/xfs/017
@@ -35,7 +35,7 @@ do
 	FSSTRESS_ARGS=`_scale_fsstress_args -d $SCRATCH_MNT -n 1000`
         _run_fsstress $FSSTRESS_ARGS
 
-        _try_scratch_mount -o remount,ro \
+        _scratch_remount ro \
             || _fail "remount ro failed"
 
         echo ""                                 >>$seqres.full
@@ -49,7 +49,7 @@ do
         echo ""                             >>$seqres.full
         _scratch_xfs_repair -n              >>$seqres.full 2>&1 \
             || _fail "xfs_repair -n failed"
-        _try_scratch_mount -o remount,rw \
+        _scratch_remount rw \
             || _fail "remount rw failed"
 done
 
diff --git a/tests/xfs/075 b/tests/xfs/075
index ab1d6cae85efac..3ac1bfc3a96cec 100755
--- a/tests/xfs/075
+++ b/tests/xfs/075
@@ -26,7 +26,7 @@ _scratch_mkfs_sized $((512 * 1024 * 1024)) >$seqres.full
 _try_scratch_mount "-o ro,norecovery" >>$seqres.full 2>&1 \
 	|| _fail "First ro mount failed"
 # make sure a following remount,rw fails
-_try_scratch_mount "-o remount,rw" >>$seqres.full 2>&1 \
+_scratch_remount "rw" >>$seqres.full 2>&1 \
 	&& _fail "Second rw remount succeeded"
 
 # success, all done
diff --git a/tests/xfs/189 b/tests/xfs/189
index 1770023760fd88..bd2051b2e4a5cb 100755
--- a/tests/xfs/189
+++ b/tests/xfs/189
@@ -192,11 +192,11 @@ ENDL
 	[ $? -eq 0 ] || echo "mount failed unexpectedly!"
 	_check_mount rw
 
-	_try_scratch_mount -o remount,nobarrier
+	_scratch_remount nobarrier
 	[ $? -eq 0 ] || _fail "remount nobarrier failed"
 	_check_mount rw nobarrier
 
-	_try_scratch_mount -o remount,barrier
+	_scratch_remount barrier
 	[ $? -eq 0 ] || _fail "remount barrier failed"
 	_check_mount rw
 
diff --git a/tests/xfs/199 b/tests/xfs/199
index 7b9c8eeae1f9a3..fe41b372fd5f07 100755
--- a/tests/xfs/199
+++ b/tests/xfs/199
@@ -58,7 +58,7 @@ _scratch_xfs_db -x  -c 'sb' -c 'write features2 0'
 # And print the flags after a mount ro and remount rw
 #
 _scratch_mount -o ro
-_scratch_mount -o remount,rw
+_scratch_remount rw
 _scratch_unmount
 rof2=`_scratch_xfs_get_sb_field features2`
 


