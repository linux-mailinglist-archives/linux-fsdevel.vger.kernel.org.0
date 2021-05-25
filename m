Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDBDF390C1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 00:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhEYWVn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 18:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhEYWVj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 18:21:39 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CF0C061574;
        Tue, 25 May 2021 15:20:09 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id v8so32153537qkv.1;
        Tue, 25 May 2021 15:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u2BiTeXky6V2PqfyD5Afd5g5sd0MTSBoPrFa0V/c9TY=;
        b=XDDdI/tmmPiBe1s6BJdU8WoP6nL5yBfxckIVeKsKNADHrLC/GW6KoGe28IJMeRi6Ks
         kORYkFrQRQNxT1sBYgs46FVNl/UPuOhJ8tblbI0PYwS9OkAsKF0Ek0h04M2ukAe9lp75
         1uLez5xRyzW7AYH3l6/7HJRhwj2s8BMV5Q69dnNTIAxQa+rUQNmraAsH5mPL/0TIXgE5
         6KFfSvrnzrc1VhkiNoNdynK8nUJ8qG4gxBcTCdF7J7apHxxHGL4bPMxv/hVJGBN/lkJy
         C1F+++6NQW0dXyn4nOBFQM7WB3PgH4izuJ333pMh+l7opz9hXu6TDClirH5iyuqqFyTH
         XlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u2BiTeXky6V2PqfyD5Afd5g5sd0MTSBoPrFa0V/c9TY=;
        b=q/kLOyjdc+/whjSdPYibFl3aJGfZTo1XJLo6oLNjWmTF3otmbcMjAhBmSpzGVssj2T
         ysGqBOpbUkHD1Lid0SuEuBCAsH2HUV8c0YEDTWY/3rkkYPW8SxPSLxPyJ9XgmEqBSBu3
         ZDqDw0H63ofxGzH8mAsQMlyO0JaWRX3HCrxkfw+Rs+FX5/mG1kweqMfDaF24i+1gk81x
         HLbyJaxDFwkaVoIN7f69ouxZArSBKtRimysQqGVV/jvCsz4kCV0sPRpV1GbRReXuBF2e
         rWRxWgXPGv6PuDCGt46CVrskKjkCGITp+mNef35AyaNx19vTZ6YdnwvOkfB3k1sbfOTj
         i6kw==
X-Gm-Message-State: AOAM530OJ661ciN/mmEsJNjP9hP+Vmj+gynVlaEEr2/CU86RLuRJCiRH
        3m/bzhRk+UHjAkocnRe95zqZQL4NI5Tr
X-Google-Smtp-Source: ABdhPJxkYFRTbpaOuGCEgVMbR4OCvU0K+1Sz+BtAyltugFbI0lAL+aKLx0kfxJKoWNqjsCtVHk/gow==
X-Received: by 2002:a37:9d12:: with SMTP id g18mr36405846qke.199.1621981207721;
        Tue, 25 May 2021 15:20:07 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id m10sm333445qkk.113.2021.05.25.15.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 15:20:07 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH v2 2/4] Initial bcachefs support
Date:   Tue, 25 May 2021 18:19:53 -0400
Message-Id: <20210525221955.265524-6-kent.overstreet@gmail.com>
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

