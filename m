Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54B54134B76
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 20:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbgAHTZf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 14:25:35 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40354 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbgAHTZf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 14:25:35 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so4640094wrn.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jan 2020 11:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=0sNC8jmXp2Yi+T5aKk0mqVrDOvJHjARtc2RxQpOJLOU=;
        b=T9JxaQpo6wsWMd6+cS6hhpZO+/whCXJqrRwAHYbI3vdtzydpgHnKsgun0nJzlxr1H7
         2lyEzBvCCPjcPva7LSBhUxg6VwzenlUkqEJWPxtE6WGUscwI2ye6zG3L2rFfHyua/ROm
         y6TMF2U7WrF79z9xJJ5mWazLwCzhgVlb+rTns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=0sNC8jmXp2Yi+T5aKk0mqVrDOvJHjARtc2RxQpOJLOU=;
        b=uVjS+ANMP5xGsWA5jQSqEeFrcGnZodNX7uJlJlBb4VST02nm3bYXoMYpnAl0I84bvI
         Qc8Thy7X6MOBh3t7PbrSfFj/vXaH7+uvAVhjUqNc8C2I36Wmo7k8yGCiaCiFnqybzJzQ
         cVbAeRg4mKdj9MTb8GVvWizPOY2ZpPugMvW0D5yQUupug4iUbDf8PqDEo/P+wpJdvZT6
         vDDDng6Bn7gO6Q+tzP4wlkFlcSLXtqV0gx1WGuBUNbwVmezJhvv2jftLvNQjz/LbRR3a
         Wfh1cm6QtVz/DQsUSL+sscjgeJdEbx1B1j9WMQp2VlfA//+w6RHcYSMLme9fUoVE0RzQ
         XaEQ==
X-Gm-Message-State: APjAAAUraLOSgCR6Yi5We72K0KU1Lv7RAGeFtr7sMfM1MAWVBrrwpQFQ
        bb2eN1MWFHwVu8FuIdmvQQC0zw==
X-Google-Smtp-Source: APXvYqy0HQKXvGunDbArFkX9VaqJ014nHzIWKb6VNWwl1qML6LqiWZqhVQOCSiUbRB2cR4io/f0Wpg==
X-Received: by 2002:adf:e812:: with SMTP id o18mr6186746wrm.127.1578511533465;
        Wed, 08 Jan 2020 11:25:33 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id e18sm5363682wrr.95.2020.01.08.11.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 11:25:32 -0800 (PST)
Date:   Wed, 8 Jan 2020 20:25:25 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     fstests@vger.kernel.org
Cc:     Eryu Guan <guaneryu@gmail.com>, linux-fsdevel@vger.kernel.org
Subject: [PATCH] xfstests: add fuse support
Message-ID: <20200108192504.GA893@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This allows using any fuse filesystem that can be mounted with

  mount -t fuse.$SUBTYPE ...

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 README.fuse   |   28 ++++++++++++++++++++++++++++
 check         |    2 ++
 common/attr   |    4 ++--
 common/config |    8 +++++++-
 common/rc     |   34 ++++++++++++++++++++++++++++------
 5 files changed, 67 insertions(+), 9 deletions(-)

--- a/common/config
+++ b/common/config
@@ -295,6 +295,9 @@ _mount_opts()
 	9p)
 		export MOUNT_OPTIONS=$PLAN9_MOUNT_OPTIONS
 		;;
+	fuse)
+		export MOUNT_OPTIONS=$FUSE_MOUNT_OPTIONS
+		;;
 	xfs)
 		export MOUNT_OPTIONS=$XFS_MOUNT_OPTIONS
 		;;
@@ -353,6 +356,9 @@ _test_mount_opts()
 	9p)
 		export TEST_FS_MOUNT_OPTS=$PLAN9_MOUNT_OPTIONS
 		;;
+	fuse)
+		export TEST_FS_MOUNT_OPTS=$FUSE_MOUNT_OPTIONS
+		;;
 	cifs)
 		export TEST_FS_MOUNT_OPTS=$CIFS_MOUNT_OPTIONS
 		;;
@@ -485,7 +491,7 @@ _check_device()
 	fi
 
 	case "$FSTYP" in
-	9p|tmpfs|virtiofs)
+	9p|fuse|tmpfs|virtiofs)
 		# 9p and virtiofs mount tags are just plain strings, so anything is allowed
 		# tmpfs doesn't use mount source, ignore
 		;;
--- a/common/rc
+++ b/common/rc
@@ -143,6 +143,8 @@ case "$FSTYP" in
 	 ;;
     9p)
 	 ;;
+    fuse)
+	 ;;
     ceph)
 	 ;;
     glusterfs)
@@ -339,7 +341,7 @@ _try_scratch_mount()
 		_overlay_scratch_mount $*
 		return $?
 	fi
-	_mount -t $FSTYP `_scratch_mount_options $*`
+	_mount -t $FSTYP$SUBTYP `_scratch_mount_options $*`
 }
 
 # mount scratch device with given options and _fail if mount fails
@@ -422,7 +424,7 @@ _test_mount()
         return $?
     fi
     _test_options mount
-    _mount -t $FSTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
+    _mount -t $FSTYP$SUBTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
 }
 
 _test_unmount()
@@ -614,6 +616,9 @@ _test_mkfs()
     9p)
 	# do nothing for 9p
 	;;
+    fuse)
+	# do nothing for fuse
+	;;
     virtiofs)
 	# do nothing for virtiofs
 	;;
@@ -654,6 +659,9 @@ _mkfs_dev()
     9p)
 	# do nothing for 9p
 	;;
+    fuse)
+	# do nothing for fuse
+	;;
     virtiofs)
 	# do nothing for virtiofs
 	;;
@@ -705,6 +713,14 @@ _scratch_cleanup_files()
 		_overlay_mkdirs $OVL_BASE_SCRATCH_MNT
 		# leave base fs mouted so tests can setup lower/upper dir files
 		;;
+	fuse)
+		[ -n "$SCRATCH_MNT" ] || return 1
+		_scratch_mount
+		if [ ! -e $SCRATCH_MNT/bin/sh ]; then
+			rm -rf $SCRATCH_MNT/*
+		fi
+		_scratch_unmount
+		;;
 	*)
 		[ -n "$SCRATCH_MNT" ] || return 1
 		_scratch_mount
@@ -721,7 +737,7 @@ _scratch_mkfs()
 	local mkfs_status
 
 	case $FSTYP in
-	nfs*|cifs|ceph|overlay|glusterfs|pvfs2|9p|virtiofs)
+	nfs*|cifs|ceph|overlay|glusterfs|pvfs2|9p|fuse|virtiofs)
 		# unable to re-create this fstyp, just remove all files in
 		# $SCRATCH_MNT to avoid EEXIST caused by the leftover files
 		# created in previous runs
@@ -1495,7 +1511,7 @@ _require_scratch_nocheck()
 			_notrun "this test requires a valid \$SCRATCH_MNT"
 		fi
 		;;
-	9p|virtiofs)
+	9p|fuse|virtiofs)
 		if [ -z "$SCRATCH_DEV" ]; then
 			_notrun "this test requires a valid \$SCRATCH_DEV"
 		fi
@@ -1619,7 +1635,7 @@ _require_test()
 			_notrun "this test requires a valid \$TEST_DIR"
 		fi
 		;;
-	9p|virtiofs)
+	9p|fuse|virtiofs)
 		if [ -z "$TEST_DEV" ]; then
 			_notrun "this test requires a valid \$TEST_DEV"
 		fi
@@ -2599,7 +2615,7 @@ _mount_or_remount_rw()
 
 	if [ $USE_REMOUNT -eq 0 ]; then
 		if [ "$FSTYP" != "overlay" ]; then
-			_mount -t $FSTYP $mount_opts $device $mountpoint
+			_mount -t $FSTYP$SUBTYP $mount_opts $device $mountpoint
 		else
 			_overlay_mount $device $mountpoint
 		fi
@@ -2727,6 +2743,9 @@ _check_test_fs()
     9p)
 	# no way to check consistency for 9p
 	;;
+    fuse)
+	# no way to check consistency for fuse
+	;;
     virtiofs)
 	# no way to check consistency for virtiofs
 	;;
@@ -2788,6 +2807,9 @@ _check_scratch_fs()
     9p)
 	# no way to check consistency for 9p
 	;;
+    fuse)
+	# no way to check consistency for fuse
+	;;
     virtiofs)
 	# no way to check consistency for virtiofs
 	;;
--- a/check
+++ b/check
@@ -56,6 +56,7 @@ check options
     -glusterfs		test GlusterFS
     -cifs		test CIFS
     -9p			test 9p
+    -fuse		test fuse
     -virtiofs		test virtiofs
     -overlay		test overlay
     -pvfs2		test PVFS2
@@ -269,6 +270,7 @@ while [ $# -gt 0 ]; do
 	-glusterfs)	FSTYP=glusterfs ;;
 	-cifs)		FSTYP=cifs ;;
 	-9p)		FSTYP=9p ;;
+	-fuse)		FSTYP=fuse ;;
 	-virtiofs)	FSTYP=virtiofs ;;
 	-overlay)	FSTYP=overlay; export OVERLAY=true ;;
 	-pvfs2)		FSTYP=pvfs2 ;;
--- a/common/attr
+++ b/common/attr
@@ -238,7 +238,7 @@ _getfattr()
 
 # set maximum total attr space based on fs type
 case "$FSTYP" in
-xfs|udf|pvfs2|9p|ceph)
+xfs|udf|pvfs2|9p|ceph|fuse)
 	MAX_ATTRS=1000
 	;;
 *)
@@ -258,7 +258,7 @@ xfs|udf|btrfs)
 pvfs2)
 	MAX_ATTRVAL_SIZE=8192
 	;;
-9p|ceph)
+9p|ceph|fuse)
 	MAX_ATTRVAL_SIZE=65536
 	;;
 *)
--- /dev/null
+++ b/README.fuse
@@ -0,0 +1,28 @@
+Here are instructions for testing fuse using the passthrough_ll example
+filesystem provided in the libfuse source tree:
+
+git clone git://github.com/libfuse/libfuse.git
+cd libfuse
+meson build
+cd build
+ninja
+cp example/passthrough_ll /usr/bin
+cd
+cat << 'EOF' > /sbin/mount.fuse.passthrough_ll
+#!/bin/bash
+ulimit -n 1048576
+exec /usr/bin/passthrough_ll -ofsname="$@"
+EOF
+chmod +x /sbin/mount.fuse.passthrough_ll
+mkdir -p /mnt/test /mnt/scratch /home/test/test /home/test/scratch
+
+Use the following config file:
+
+export TEST_DEV=non1
+export TEST_DIR=/mnt/test
+export SCRATCH_DEV=non2
+export SCRATCH_MNT=/mnt/scratch
+export FSTYP=fuse
+export SUBTYP=.passthrough_ll
+export FUSE_MOUNT_OPTIONS="-osource=/home/test/scratch,allow_other,default_permissions"
+export TEST_FS_MOUNT_OPTS="-osource=/home/test/test,allow_other,default_permissions"



