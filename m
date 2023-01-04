Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F21E65DCFB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 20:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239891AbjADTkn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 14:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240070AbjADTkh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:40:37 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5D1F6;
        Wed,  4 Jan 2023 11:40:35 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ud5so85239171ejc.4;
        Wed, 04 Jan 2023 11:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwDrttgdZi4gGSC0PiL7aNGYNpXMXsVaezlgiRprS6s=;
        b=jPBPPvHMESFBkzq+TpQ4oN0FMFuDmwx8O3AQr3DakNWAAQgkHqjThQ/dnCniciHSTN
         zxZc7Pu8+VyG2sasiR8h33E5G6HIkP01dpwK6Fq8Pbx6XdAmLqs//Ty0EdkctTIQXC4/
         jvID3JpDmcSHLclQ8+VtDcX69/1xFgnhcbjzzi8UAH/EUx8s/MyRWNBa10PT9U1kadSe
         6HU5WeueGNT702ykYdRAkPSXBq0edy6Je4Dib/ZDQTHUiabKPCYZc/jRtT6RDmYzztrn
         KUhfO0+yDcP8HNhkwcstoL18cntvKUatBU+AQLlvEUfaEfA7P+S8aJWKguGbonl0CUJQ
         V0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bwDrttgdZi4gGSC0PiL7aNGYNpXMXsVaezlgiRprS6s=;
        b=B4BJC5BSm7XEPvvfKveSNPrmQhmvQg4WMtnBtJw7vgPkbfXG8Gd7aKz2SYG1G6/spI
         gsm3zpyG1nVG/YtraODNw5WbfIM/zNcQw1JaAGKhzALWxsCyC4t/k3vF4i1Ypr7yHxtx
         0io1rJDf3QtXB5N+AN1b2Z0cRiwx9kqSfm0HG0E9LB6paPuY5fk2WzDNFs8+8/7jNump
         GzG38M8A/Hgam5i8sspx6n2Wk2bu3yA+U9qda1l18cphJCRM1t9wu/CY8/xrn30mknk1
         7idKANBFVQi6lcl9C6wbjJnKQnltfvbV9VS5enJ92UamEz63EoH4oEhsfwtQ1lefhzSR
         TfPw==
X-Gm-Message-State: AFqh2kp4wxiBQURJ/3s+97ojIjOVDla+G/I9mgkbWSLzsfm88Q8waBaY
        6oghE2SjdyAbGx+XKkMO6kU=
X-Google-Smtp-Source: AMrXdXvNO7D2NJIDtDE+CLiMdCyZ9Wli6LrHkODfy95ddmC1T7lezmLA3M+YQppPJGg6aeaZNHvlbg==
X-Received: by 2002:a17:906:ca10:b0:7c0:a4ae:c542 with SMTP id jt16-20020a170906ca1000b007c0a4aec542mr40877463ejb.39.1672861233857;
        Wed, 04 Jan 2023 11:40:33 -0800 (PST)
Received: from localhost.localdomain (2a02-8388-16c0-7e80-f739-05d5-c6d9-3234.cable.dynamic.v6.surfer.at. [2a02:8388:16c0:7e80:f739:5d5:c6d9:3234])
        by smtp.gmail.com with ESMTPSA id cz8-20020a0564021ca800b0048f032371bcsm1142857edb.88.2023.01.04.11.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 11:40:33 -0800 (PST)
From:   Jakob Unterwurzacher <jakobunt@gmail.com>
To:     guaneryu@gmail.com
Cc:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        miklos@szeredi.hu, Miklos Szeredi <mszeredi@redhat.com>,
        Jakob Unterwurzacher <jakobunt@gmail.com>
Subject: [PATCH] xfstests: add fuse support
Date:   Wed,  4 Jan 2023 20:39:33 +0100
Message-Id: <20230104193932.984531-1-jakobunt@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20200217100800.GH2697@desktop>
References: <20200217100800.GH2697@desktop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Miklos Szeredi <miklos@szeredi.hu>

This allows using any fuse filesystem that can be mounted with

  mount -t fuse.$FUSE_SUBTYP ...

Changelog:

v2: Jan 3, 2022, Jakob Unterwurzacher
* Rebased to master
* Instructions updated
** To not fail with libfuse version mismatch on passthrough_ll exe
   on Fedora
** To use sudo
* Review comments from Eryu Guan addressed:
** Comment updated to mention fuse
** Renamed SUBTYP to FUSE_SUBTYP
** Removed $SCRATCH_MNT/bin/sh check before "rm -rf"
** _require_scratch_nocheck for fuse also checks for $SCRATCH_MNT
** _require_test for fuse also checks for $TEST_DIR

v1: Jan 8, 2020, Miklos Szeredi
* Initial submission
* https://patchwork.kernel.org/project/linux-fsdevel/patch/20200108192504.GA893@miu.piliscsaba.redhat.com/

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Jakob Unterwurzacher <jakobunt@gmail.com>
---
 README.fuse       | 26 ++++++++++++++++++++++++++
 check             |  3 ++-
 common/config     |  9 +++++++--
 common/rc         | 24 ++++++++++++++++++------
 tests/generic/020 |  4 ++--
 5 files changed, 55 insertions(+), 11 deletions(-)
 create mode 100644 README.fuse

diff --git a/README.fuse b/README.fuse
new file mode 100644
index 00000000..35ad9c46
--- /dev/null
+++ b/README.fuse
@@ -0,0 +1,26 @@
+Here are instructions for testing fuse using the passthrough_ll example
+filesystem provided in the libfuse source tree:
+
+git clone git://github.com/libfuse/libfuse.git
+cd libfuse
+meson build
+cd build
+ninja
+cat << EOF | sudo tee /sbin/mount.fuse.passthrough_ll
+#!/bin/bash
+ulimit -n 1048576
+exec $(pwd)/example/passthrough_ll -ofsname="\$@"
+EOF
+sudo chmod +x /sbin/mount.fuse.passthrough_ll
+mkdir -p /mnt/test /mnt/scratch /home/test/test /home/test/scratch
+
+Use the following local.config file:
+
+export TEST_DEV=non1
+export TEST_DIR=/mnt/test
+export SCRATCH_DEV=non2
+export SCRATCH_MNT=/mnt/scratch
+export FSTYP=fuse
+export FUSE_SUBTYP=.passthrough_ll
+export FUSE_MOUNT_OPTIONS="-osource=/home/test/scratch,allow_other,default_permissions"
+export TEST_FS_MOUNT_OPTS="-osource=/home/test/test,allow_other,default_permissions"
diff --git a/check b/check
index 1ff0f44a..e25037f1 100755
--- a/check
+++ b/check
@@ -60,6 +60,7 @@ check options
     -glusterfs		test GlusterFS
     -cifs		test CIFS
     -9p			test 9p
+    -fuse		test fuse
     -virtiofs		test virtiofs
     -overlay		test overlay
     -pvfs2		test PVFS2
@@ -279,7 +280,7 @@ while [ $# -gt 0 ]; do
 	case "$1" in
 	-\? | -h | --help) usage ;;
 
-	-nfs|-glusterfs|-cifs|-9p|-virtiofs|-pvfs2|-tmpfs|-ubifs)
+	-nfs|-glusterfs|-cifs|-9p|-fuse|-virtiofs|-pvfs2|-tmpfs|-ubifs)
 		FSTYP="${1:1}"
 		;;
 	-overlay)
diff --git a/common/config b/common/config
index e2aba5a9..6c8cb3a5 100644
--- a/common/config
+++ b/common/config
@@ -341,6 +341,9 @@ _common_mount_opts()
 	9p)
 		echo $PLAN9_MOUNT_OPTIONS
 		;;
+	fuse)
+		echo $FUSE_MOUNT_OPTIONS
+		;;
 	xfs)
 		echo $XFS_MOUNT_OPTIONS
 		;;
@@ -511,6 +514,8 @@ _source_specific_fs()
 		;;
 	9p)
 		;;
+	fuse)
+		;;
 	ceph)
 		. ./common/ceph
 		;;
@@ -583,8 +588,8 @@ _check_device()
 	fi
 
 	case "$FSTYP" in
-	9p|tmpfs|virtiofs)
-		# 9p and virtiofs mount tags are just plain strings, so anything is allowed
+	9p|fuse|tmpfs|virtiofs)
+		# 9p, fuse and virtiofs mount tags are just plain strings, so anything is allowed
 		# tmpfs doesn't use mount source, ignore
 		;;
 	ceph)
diff --git a/common/rc b/common/rc
index 23530413..c17e3f6e 100644
--- a/common/rc
+++ b/common/rc
@@ -274,7 +274,7 @@ _try_scratch_mount()
 		_overlay_scratch_mount $*
 		return $?
 	fi
-	_mount -t $FSTYP `_scratch_mount_options $*`
+	_mount -t $FSTYP$FUSE_SUBTYP `_scratch_mount_options $*`
 	mount_ret=$?
 	[ $mount_ret -ne 0 ] && return $mount_ret
 	_idmapped_mount $SCRATCH_DEV $SCRATCH_MNT
@@ -458,7 +458,7 @@ _test_mount()
     fi
 
     _test_options mount
-    _mount -t $FSTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
+    _mount -t $FSTYP$FUSE_SUBTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
     mount_ret=$?
     [ $mount_ret -ne 0 ] && return $mount_ret
     _idmapped_mount $TEST_DEV $TEST_DIR
@@ -584,6 +584,9 @@ _test_mkfs()
     9p)
 	# do nothing for 9p
 	;;
+    fuse)
+	# do nothing for fuse
+	;;
     virtiofs)
 	# do nothing for virtiofs
 	;;
@@ -624,6 +627,9 @@ _mkfs_dev()
     9p)
 	# do nothing for 9p
 	;;
+    fuse)
+	# do nothing for fuse
+	;;
     virtiofs)
 	# do nothing for virtiofs
 	;;
@@ -691,7 +697,7 @@ _scratch_mkfs()
 	local mkfs_status
 
 	case $FSTYP in
-	nfs*|cifs|ceph|overlay|glusterfs|pvfs2|9p|virtiofs)
+	nfs*|cifs|ceph|overlay|glusterfs|pvfs2|9p|fuse|virtiofs)
 		# unable to re-create this fstyp, just remove all files in
 		# $SCRATCH_MNT to avoid EEXIST caused by the leftover files
 		# created in previous runs
@@ -1587,7 +1593,7 @@ _require_scratch_nocheck()
 			_notrun "this test requires a valid \$SCRATCH_MNT"
 		fi
 		;;
-	9p|virtiofs)
+	9p|fuse|virtiofs)
 		if [ -z "$SCRATCH_DEV" ]; then
 			_notrun "this test requires a valid \$SCRATCH_DEV"
 		fi
@@ -1787,7 +1793,7 @@ _require_test()
 			_notrun "this test requires a valid \$TEST_DIR"
 		fi
 		;;
-	9p|virtiofs)
+	9p|fuse|virtiofs)
 		if [ -z "$TEST_DEV" ]; then
 			_notrun "this test requires a valid \$TEST_DEV"
 		fi
@@ -2986,7 +2992,7 @@ _mount_or_remount_rw()
 
 	if [ $USE_REMOUNT -eq 0 ]; then
 		if [ "$FSTYP" != "overlay" ]; then
-			_mount -t $FSTYP $mount_opts $device $mountpoint
+			_mount -t $FSTYP$FUSE_SUBTYP $mount_opts $device $mountpoint
 			_idmapped_mount $device $mountpoint
 		else
 			_overlay_mount $device $mountpoint
@@ -3124,6 +3130,9 @@ _check_test_fs()
     9p)
 	# no way to check consistency for 9p
 	;;
+    fuse)
+	# no way to check consistency for fuse
+	;;
     virtiofs)
 	# no way to check consistency for virtiofs
 	;;
@@ -3185,6 +3194,9 @@ _check_scratch_fs()
     9p)
 	# no way to check consistency for 9p
 	;;
+    fuse)
+	# no way to check consistency for fuse
+	;;
     virtiofs)
 	# no way to check consistency for virtiofs
 	;;
diff --git a/tests/generic/020 b/tests/generic/020
index b91bca34..be5cecad 100755
--- a/tests/generic/020
+++ b/tests/generic/020
@@ -56,7 +56,7 @@ _attr_get_max()
 {
 	# set maximum total attr space based on fs type
 	case "$FSTYP" in
-	xfs|udf|pvfs2|9p|ceph|nfs)
+	xfs|udf|pvfs2|9p|ceph|fuse|nfs)
 		max_attrs=1000
 		;;
 	ext2|ext3|ext4)
@@ -134,7 +134,7 @@ _attr_get_maxval_size()
 	pvfs2)
 		max_attrval_size=8192
 		;;
-	xfs|udf|9p)
+	xfs|udf|9p|fuse)
 		max_attrval_size=65536
 		;;
 	bcachefs)
-- 
2.38.1

