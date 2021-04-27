Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA5B36C9AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 18:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237497AbhD0QpN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 12:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236169AbhD0QpL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:45:11 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE97BC061756;
        Tue, 27 Apr 2021 09:44:27 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id l1so4799495qtr.12;
        Tue, 27 Apr 2021 09:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F11ppnBlARrz8dbdJc+VC9LpbnbDA0nA8a+ccqrdZiM=;
        b=oWPMBrdgTVflxAqsoQSjG9VjnRgXyIP41p2b514xpzFPtuALvePk8VmgKgDtAMDlYC
         8plAQPAicCu7qld+IguQQ/Pfs/naXUfwBYgapT3dVd5FYwTAFBJZdVckzu0Tc6Dit8mM
         3iBfQZxagHA8Tn/1P3ExQX7CoaOwqX4p1miNuz5e3AqTPZ4SrpBBnAH5oIjTPJ7eH6Qo
         2kmdtbr33kN2n9IdCOmZ1iBhUwhGPLZHNto6iol3YveZVMuJNFDbNcPbImXITV9fpX6V
         veofBWxvjttOjsq5R/IbouojOxnAlKuYVViLBwEFAhFEN2tBFeVkTnfB99RlwfNKWofp
         oPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F11ppnBlARrz8dbdJc+VC9LpbnbDA0nA8a+ccqrdZiM=;
        b=K9+kBSI38mDnJKkN0isW7wMK9dZes0blc9jTqgpr0rR8AeBBuN6/YfsciHEwGFJXAj
         eepM7rj6S62+kfFRG8JZCOGU2WSrRXE7ELyfHFivsLGxAsZBo8tyTO82f/AqpZnH0TUx
         t1bV0UvOb9MCHRmRIMYhCYwS3VWc/TCVFDPDETcafLA9KdmE+dzLklCFpXWLmg5jEyXR
         E2UpEuXWbsn8HGxVmhckuquQr9KkLvttUq4UK18QiEwQ7XOtlaLWcsZIZNkLogSHze9J
         vrGiNtnVF4+QfTCJ8qfLXDaeG/o/S8qoHM9j5LTp39DeFTB4B6H8j8T9O1WX8BVaKsAf
         cXmg==
X-Gm-Message-State: AOAM532WuJW6E6SkgzYoTh5IzMocK6oQkCb0auOs4LTGVwCUAmPUgw+Z
        2WhcYSn5qdIS8uVMzxQaaykXM7Uxhk/9
X-Google-Smtp-Source: ABdhPJwnplI7PMb+d1FSxiCkqPzOf133ywBHbkt7krRHrYn9eJ4FBDPqZMa5qbELhGCeVNuR1izNQQ==
X-Received: by 2002:ac8:41ce:: with SMTP id o14mr22518620qtm.96.1619541866718;
        Tue, 27 Apr 2021 09:44:26 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id l71sm3149163qke.27.2021.04.27.09.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 09:44:26 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Cc:     Kent Overstreet <kmo@daterainc.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 1/3] Initial bcachefs support
Date:   Tue, 27 Apr 2021 12:44:17 -0400
Message-Id: <20210427164419.3729180-2-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427164419.3729180-1-kent.overstreet@gmail.com>
References: <20210427164419.3729180-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kent Overstreet <kmo@daterainc.com>

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 common/attr        |  6 ++++++
 common/config      |  3 +++
 common/dmlogwrites |  7 +++++++
 common/quota       |  4 ++--
 common/rc          | 31 +++++++++++++++++++++++++++++++
 tests/generic/042  |  3 ++-
 tests/generic/425  |  3 +++
 tests/generic/441  |  2 +-
 tests/generic/482  | 27 ++++++++++++++++++++-------
 tests/generic/558  |  2 ++
 10 files changed, 77 insertions(+), 11 deletions(-)

diff --git a/common/attr b/common/attr
index 669909d600..42ceab9233 100644
--- a/common/attr
+++ b/common/attr
@@ -33,6 +33,9 @@ _acl_get_max()
 			echo 506
 		fi
 		;;
+	bcachefs)
+		echo 251
+		;;
 	*)
 		echo 0
 		;;
@@ -273,6 +276,9 @@ pvfs2)
 9p|ceph|nfs)
 	MAX_ATTRVAL_SIZE=65536
 	;;
+bcachefs)
+	MAX_ATTRVAL_SIZE=1024
+	;;
 *)
 	# Assume max ~1 block of attrs
 	BLOCK_SIZE=`_get_block_size $TEST_DIR`
diff --git a/common/config b/common/config
index a47e462c77..8153301483 100644
--- a/common/config
+++ b/common/config
@@ -415,6 +415,9 @@ _mkfs_opts()
 	btrfs)
 		export MKFS_OPTIONS="$BTRFS_MKFS_OPTIONS"
 		;;
+	bcachefs)
+		export MKFS_OPTIONS="--errors=panic"
+		;;
 	*)
 		;;
 	esac
diff --git a/common/dmlogwrites b/common/dmlogwrites
index 573f4b8a56..668d49e995 100644
--- a/common/dmlogwrites
+++ b/common/dmlogwrites
@@ -111,6 +111,13 @@ _log_writes_replay_log()
 	[ -z "$_blkdev" ] && _fail \
 	"block dev must be specified for _log_writes_replay_log"
 
+	if [ "$FSTYP" = "bcachefs" ]; then
+		# bcachefs gets confused if we're replaying the history out of
+		# order, and we see writes on the device from a newer point in
+		# time than what the superblock points to:
+		dd if=/dev/zero of=$SCRATCH_DEV bs=1M oflag=direct >& /dev/null
+	fi
+
 	$here/src/log-writes/replay-log --log $LOGWRITES_DEV --find \
 		--end-mark $_mark >> $seqres.full 2>&1
 	[ $? -ne 0 ] && _fail "mark '$_mark' does not exist"
diff --git a/common/quota b/common/quota
index 32a9a55593..883a28a20d 100644
--- a/common/quota
+++ b/common/quota
@@ -17,7 +17,7 @@ _require_quota()
 	    _notrun "Installed kernel does not support quotas"
 	fi
 	;;
-    gfs2|ocfs2)
+    gfs2|ocfs2|bcachefs)
 	;;
     xfs)
 	if [ ! -f /proc/fs/xfs/xqmstat ]; then
@@ -278,7 +278,7 @@ _check_quota_usage()
 
 	VFS_QUOTA=0
 	case $FSTYP in
-	ext2|ext3|ext4|ext4dev|f2fs|reiserfs|gfs2)
+	ext2|ext3|ext4|ext4dev|f2fs|reiserfs|gfs2|bcachefs)
 		VFS_QUOTA=1
 		quotaon -f -u -g $SCRATCH_MNT 2>/dev/null
 		;;
diff --git a/common/rc b/common/rc
index 2cf550ec68..0e03846aeb 100644
--- a/common/rc
+++ b/common/rc
@@ -334,6 +334,7 @@ _try_scratch_mount()
 		return $?
 	fi
 	_mount -t $FSTYP `_scratch_mount_options $*`
+	return
 }
 
 # mount scratch device with given options and _fail if mount fails
@@ -667,6 +668,9 @@ _test_mkfs()
     ext2|ext3|ext4)
 	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* $TEST_DEV
 	;;
+    bcachefs)
+	$MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* $TEST_DEV
+	;;
     *)
 	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* $TEST_DEV
 	;;
@@ -706,6 +710,10 @@ _mkfs_dev()
 	$MKFS_PROG -t $FSTYP -- -f $MKFS_OPTIONS $* \
 		2>$tmp.mkfserr 1>$tmp.mkfsstd
 	;;
+    bcachefs)
+	$MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* \
+		2>$tmp_dir.mkfserr 1>$tmp_dir.mkfsstd
+	;;
     *)
 	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* \
 		2>$tmp.mkfserr 1>$tmp.mkfsstd
@@ -803,6 +811,10 @@ _scratch_mkfs()
 		mkfs_cmd="yes | $MKFS_PROG -t $FSTYP --"
 		mkfs_filter="grep -v -e ^mkfs\.ocfs2"
 		;;
+	bcachefs)
+		mkfs_cmd="$MKFS_PROG -t $FSTYP --"
+		mkfs_filter="cat"
+		;;
 	*)
 		mkfs_cmd="yes | $MKFS_PROG -t $FSTYP --"
 		mkfs_filter="cat"
@@ -1065,6 +1077,9 @@ _scratch_mkfs_sized()
 		fi
 		export MOUNT_OPTIONS="-o size=$fssize $TMPFS_MOUNT_OPTIONS"
 		;;
+	bcachefs)
+		$MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS --fs_size=$fssize --block_size=$blocksize $SCRATCH_DEV
+		;;
 	*)
 		_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_sized"
 		;;
@@ -1133,6 +1148,9 @@ _scratch_mkfs_blocksized()
     ocfs2)
 	yes | ${MKFS_PROG} -t $FSTYP -F $MKFS_OPTIONS -b $blocksize -C $blocksize $SCRATCH_DEV
 	;;
+    bcachefs)
+	${MKFS_PROG}.$FSTYP $MKFS_OPTIONS --block_size=$blocksize $SCRATCH_DEV
+	;;
     *)
 	_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_blocksized"
 	;;
@@ -1179,6 +1197,19 @@ _repair_scratch_fs()
 	fi
 	return $res
         ;;
+    bcachefs)
+	fsck -t $FSTYP -n $SCRATCH_DEV 2>&1
+	res=$?
+	case $res in
+	0)
+		res=0
+		;;
+	*)
+		_dump_err2 "fsck.$FSTYP failed, err=$res"
+		;;
+	esac
+	return $res
+	;;
     *)
 	local dev=$SCRATCH_DEV
 	local fstyp=$FSTYP
diff --git a/tests/generic/042 b/tests/generic/042
index 35727bcbc6..42919e2313 100755
--- a/tests/generic/042
+++ b/tests/generic/042
@@ -63,7 +63,8 @@ _crashtest()
 
 	# We should /never/ see 0xCD in the file, because we wrote that pattern
 	# to the filesystem image to expose stale data.
-	if hexdump -v -e '/1 "%02X "' $file | grep -q "CD"; then
+	# The file is not required to exist since we didn't sync before going down:
+	if [[ -f $file ]] && hexdump -v -e '/1 "%02X "' $file | grep -q "CD"; then
 		echo "Saw stale data!!!"
 		hexdump $file
 	fi
diff --git a/tests/generic/425 b/tests/generic/425
index 51cbe1c67d..be2bc1b02e 100755
--- a/tests/generic/425
+++ b/tests/generic/425
@@ -30,6 +30,9 @@ _cleanup()
 
 # real QA test starts here
 _supported_fs generic
+
+[ $FSTYP = bcachefs ] && _notrun "bcachefs does not store xattrs in blocks"
+
 _require_scratch
 _require_attrs
 _require_xfs_io_command "fiemap" "-a"
diff --git a/tests/generic/441 b/tests/generic/441
index bedbcb0817..814387b2a9 100755
--- a/tests/generic/441
+++ b/tests/generic/441
@@ -40,7 +40,7 @@ case $FSTYP in
 	btrfs)
 		_notrun "btrfs has a specialized test for this"
 		;;
-	ext3|ext4|xfs)
+	ext3|ext4|xfs|bcachefs)
 		# Do the more thorough test if we have a logdev
 		_has_logdev && sflag=''
 		;;
diff --git a/tests/generic/482 b/tests/generic/482
index 86941e8468..3cbe187f2e 100755
--- a/tests/generic/482
+++ b/tests/generic/482
@@ -77,16 +77,29 @@ prev=$(_log_writes_mark_to_entry_number mkfs)
 cur=$(_log_writes_find_next_fua $prev)
 [ -z "$cur" ] && _fail "failed to locate next FUA write"
 
+if [ "$FSTYP" = "bcachefs" ]; then
+    _dmthin_cleanup
+    _dmthin_init $devsize $devsize $csize $lowspace
+fi
+
 while [ ! -z "$cur" ]; do
 	_log_writes_replay_log_range $cur $DMTHIN_VOL_DEV >> $seqres.full
 
-	# Here we need extra mount to replay the log, mainly for journal based
-	# fs, as their fsck will report dirty log as error.
-	# We don't care to preserve any data on the replay dev, as we can replay
-	# back to the point we need, and in fact sometimes creating/deleting
-	# snapshots repeatedly can be slower than replaying the log.
-	_dmthin_mount
-	_dmthin_check_fs
+	if [ "$FSTYP" = "bcachefs" ]; then
+	    # bcachefs will get confused if fsck does writes to replay the log,
+	    # but then we replay writes from an earlier point in time on the
+	    # same fs - but  fsck in -n mode won't do any writes:
+	    _check_scratch_fs -n $DMTHIN_VOL_DEV
+	else
+	    # Here we need extra mount to replay the log, mainly for journal based
+	    # fs, as their fsck will report dirty log as error.
+	    # We don't care to preserve any data on the replay dev, as we can replay
+	    # back to the point we need, and in fact sometimes creating/deleting
+	    # snapshots repeatedly can be slower than replaying the log.
+
+	    _dmthin_mount
+	    _dmthin_check_fs
+	fi
 
 	prev=$cur
 	cur=$(_log_writes_find_next_fua $(($cur + 1)))
diff --git a/tests/generic/558 b/tests/generic/558
index 4bed90e2a7..2eaa8f7686 100755
--- a/tests/generic/558
+++ b/tests/generic/558
@@ -55,6 +55,8 @@ _scratch_mount
 i=0
 free_inode=`_get_free_inode $SCRATCH_MNT`
 file_per_dir=1000
+[ $FSTYP = bcachefs ] && file_per_dir=10000
+
 loop=$((free_inode / file_per_dir + 1))
 mkdir -p $SCRATCH_MNT/testdir
 
-- 
2.31.1

