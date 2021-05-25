Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1823390C12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 00:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhEYWVh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 18:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhEYWVg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 18:21:36 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF60C061756;
        Tue, 25 May 2021 15:20:05 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id h20so16606535qko.11;
        Tue, 25 May 2021 15:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u2BiTeXky6V2PqfyD5Afd5g5sd0MTSBoPrFa0V/c9TY=;
        b=sHYg/jsb6l6q8Jiz76XqCKtj80Tm20E9SJ0FhXFLPLmLUxYtFo85QFh4hLxxS8OVal
         FvIdR8OZsG2s++EVBSO+DYb3sVbKP/KK9NXUb/fyQ09RTUlIe6sadJsv4kvxFKCAWYFD
         4xGCXJpKjJQVoY7jIMzAZl0fuG6JWwfHwQLSt628d1TooxW8eDzLzys4S3r3i+lAP1L0
         Q43tZ0y2sbJqrY6xJMgoOnaSko/QWotoCs8Q9ykpcMhq3V7zjEAhe9/kz0hJvEvYVrNM
         h6KQ8btNFJLp2FA96IUmm2mg+Gp6YPOFvfzRm4eIV64BsI7OFWY1xmW6trBk479yCNmT
         DAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u2BiTeXky6V2PqfyD5Afd5g5sd0MTSBoPrFa0V/c9TY=;
        b=hZuHBUKWGeIsUWfdg05kaOa5FeFAr29LoQu9Dcu/cIuuTy+Rauzh0wyh5IUYJGsdoL
         RIpKx5GYlYEveumalG9+vZfHYrHWe0XK8gp9ZQLcCp/gO5AMsUaeWnQY5LCqfzYsKzqh
         NMkeysIqcGt3VRKO29XkaNROU28cPshR7w+5YSEK+mTNmqYNDtNgKhSyvrbrKqS7D2ht
         ICDYS/TxeaAmX/j7dqi4HvOwQBNRK62AfMcHqwvcwxpxdRh7K6kkskFsL//jsTAClVOd
         OO8BTOkS4nFAxwCwVpE+7PCyobsLYku4Ky8rW7V1HUnNnTs0KoHSQV6QCFyJym3zUxc0
         Ne/g==
X-Gm-Message-State: AOAM531WAqdVws0YzhmpJADFDVB2HA63dSSbuom1PELh/Du8fhfm0TNz
        SyDAa4vjI+p13fcuSg/m0jkcTgnwLAjb
X-Google-Smtp-Source: ABdhPJwjKXHfGUMTJOYusoujfxokOXhqK4vqSqdCUogHhldq3GgoejPOlvliVVWo59d9NgLY+pPz/w==
X-Received: by 2002:a37:7fc5:: with SMTP id a188mr36404178qkd.279.1621981204208;
        Tue, 25 May 2021 15:20:04 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id m10sm333445qkk.113.2021.05.25.15.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 15:20:03 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 2/4] Initial bcachefs support
Date:   Tue, 25 May 2021 18:19:49 -0400
Message-Id: <20210525221955.265524-2-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210525221955.265524-1-kent.overstreet@gmail.com>
References: <20210525221955.265524-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To get started, you'll need to get bcachefs from the kernel repository
  https://evilpiepirate.org/git/bcachefs.git/

and tools from
  https://evilpiepirate.org/git/bcache-tools.git/

Build kernel as normal, enabling CONFIG_BCACHEFS_FS (and probably
CONFIG_BCACHEFS_DEBUG), and build and install tools. Then running
fstests is exactly the same as other local filesystems - just set
FSTYP=bcachefs

Also see https://evilpiepirate.org/git/ktest.git/ for a tool for
conveniently building kernel and running fstests inside a qemu VM.

This patch also updates generic/441 to run the more thorough test on
bcachefs, and generic/425 to not run on bcachefs (since bcachefs does
not store xattrs in blocks)

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 common/attr       |  6 ++++++
 common/config     |  3 +++
 common/quota      |  4 ++--
 common/rc         | 11 +++++++++++
 tests/generic/425 |  3 +++
 tests/generic/441 |  2 +-
 6 files changed, 26 insertions(+), 3 deletions(-)

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
index 1a26934985..ad1c9eb092 100644
--- a/common/config
+++ b/common/config
@@ -416,6 +416,9 @@ _mkfs_opts()
 	btrfs)
 		export MKFS_OPTIONS="$BTRFS_MKFS_OPTIONS"
 		;;
+	bcachefs)
+		export MKFS_OPTIONS=$BCACHEFS_MKFS_OPTIONS
+		;;
 	*)
 		;;
 	esac
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
index b18cf61e8a..a0aa7300dc 100644
--- a/common/rc
+++ b/common/rc
@@ -1065,6 +1065,9 @@ _scratch_mkfs_sized()
 		fi
 		export MOUNT_OPTIONS="-o size=$fssize $TMPFS_MOUNT_OPTIONS"
 		;;
+	bcachefs)
+		$MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS --fs_size=$fssize --block_size=$blocksize $SCRATCH_DEV
+		;;
 	*)
 		_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_sized"
 		;;
@@ -1133,6 +1136,9 @@ _scratch_mkfs_blocksized()
     ocfs2)
 	yes | ${MKFS_PROG} -t $FSTYP -F $MKFS_OPTIONS -b $blocksize -C $blocksize $SCRATCH_DEV
 	;;
+    bcachefs)
+	${MKFS_PROG} -t $FSTYP $MKFS_OPTIONS --block_size=$blocksize $SCRATCH_DEV
+	;;
     *)
 	_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_blocksized"
 	;;
@@ -1179,6 +1185,11 @@ _repair_scratch_fs()
 	fi
 	return $res
         ;;
+    bcachefs)
+	# With bcachefs, if fsck detects any errors we consider it a bug and we
+	# want the test to fail:
+	_check_scratch_fs
+	;;
     *)
 	local dev=$SCRATCH_DEV
 	local fstyp=$FSTYP
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
-- 
2.32.0.rc0

