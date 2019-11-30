Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C60FD10DCD5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2019 07:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfK3Gxi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Nov 2019 01:53:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37889 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725783AbfK3Gxi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Nov 2019 01:53:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575096817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=abmEBm+MuAPMV/Lt2KXXX2QVNefdEbVkI4GqG5WtJkY=;
        b=dl0hHjNQj+UUuakybx/QoBlz0f/sUN+aS4S8530Ilfv29LXZfhNyKC1OY8e7Y+2X5WyvDI
        HPZxb7hzrrwJN68V6hYYJQwFglSLql2dDMrIGB+RUe+k+J4KwuAM9KES0k+sAXxhuXbO5p
        y/OnnmBVuAzEWunnok7OU0m4xni0zGI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-BjOq5tLrP2iEauWIDjsanA-1; Sat, 30 Nov 2019 01:53:35 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92F3BDB20;
        Sat, 30 Nov 2019 06:53:34 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-80.pek2.redhat.com [10.72.12.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F9FE60BF4;
        Sat, 30 Nov 2019 06:53:32 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] generic: test mount move semantics
Date:   Sat, 30 Nov 2019 14:53:24 +0800
Message-Id: <20191130065324.17608-1-zlang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: BjOq5tLrP2iEauWIDjsanA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This's a functional test case for mount --move operation, it verifies
below semantics:

  -------------------------------------------------------------------------=
--
  |         MOVE MOUNT OPERATION                                           =
 |
  |************************************************************************=
**
  |source(A)->| shared       |       private  |       slave    | unbindable=
 |
  | dest(B)  |               |                |                |           =
 |
  |   |      |               |                |                |           =
 |
  |   v      |               |                |                |           =
 |
  |************************************************************************=
**
  |  shared  | shared        |     shared     | shared & slave |  invalid  =
 |
  |          |               |                |                |           =
 |
  |non-shared| shared        |      private   |      slave     | unbindable=
 |
  *************************************************************************=
**
  NOTE: moving a mount residing under a shared mount is invalid.

This case uses fsstress to produce a little random load, to make
sure basic operations won't break the the moved mountpoints.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

It's been long time (maybe 2 years) since I finished this test case. Those
cases before this one have been merged:

  8a02ca3b generic: test two vfsmount no peers
  101cb277 generic: test mount shared subtrees state transition
  71691c26 generic: test bind mount operations
  74a84259 common/rc: new functions for multi-level mount/umount operations

I thought this 'mount --move' test wasn't so necessary, so I left it in my
local repo long time. But now upstream fsdevel is developing new mount API,
I think this case will be helpful for that (if mount util supports new moun=
t
API later). So I change it a little then send out again.

Thanks,
Zorro

 common/rc             |   6 +
 tests/generic/586     | 182 ++++++++++++++++++++
 tests/generic/586.out | 374 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/group   |   1 +
 4 files changed, 563 insertions(+)
 create mode 100755 tests/generic/586
 create mode 100644 tests/generic/586.out

diff --git a/common/rc b/common/rc
index b988e912..936cc5c5 100644
--- a/common/rc
+++ b/common/rc
@@ -189,6 +189,12 @@ _get_mount()
=20
 =09_mount $scratch_opts $*
 =09if [ $? -eq 0 ]; then
+=09=09# mount --move operation updates the mountpoint, so remove
+=09=09# the old one and insert the new one
+=09=09if [[ "$*" =3D~ --move|-M ]]; then
+=09=09=09MOUNTED_POINT_STACK=3D`echo $MOUNTED_POINT_STACK | \
+=09=09=09=09=09=09cut -d\  -f2-`
+=09=09fi
 =09=09MOUNTED_POINT_STACK=3D"$mnt_point $MOUNTED_POINT_STACK"
 =09else
 =09=09return 1
diff --git a/tests/generic/586 b/tests/generic/586
new file mode 100755
index 00000000..170e57bc
--- /dev/null
+++ b/tests/generic/586
@@ -0,0 +1,182 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Red Hat Inc.  All Rights Reserved.
+#
+# FS QA Test 586
+#
+# Test mount shared subtrees, verify the move semantics:
+#
+# ------------------------------------------------------------------------=
---
+# |         MOVE MOUNT OPERATION                                          =
  |
+# |***********************************************************************=
***
+# |source(A)->| shared       |       private  |       slave    | unbindabl=
e |
+# | dest(B)  |               |                |                |          =
  |
+# |   |      |               |                |                |          =
  |
+# |   v      |               |                |                |          =
  |
+# |***********************************************************************=
***
+# |  shared  | shared        |     shared     | shared & slave |  invalid =
  |
+# |          |               |                |                |          =
  |
+# |non-shared| shared        |      private   |      slave     | unbindabl=
e |
+# ************************************************************************=
***
+#   NOTE: moving a mount residing under a shared mount is invalid.
+#
+#-----------------------------------------------------------------------
+#
+seq=3D`basename $0`
+seqres=3D$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=3D`pwd`
+tmp=3D/tmp/$$
+status=3D1=09# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+=09cd /
+=09rm -f $tmp.*
+=09_clear_mount_stack
+=09# make sure there's no bug cause dentry isn't be freed
+=09rm -rf $MNTHEAD
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_test
+_require_scratch
+_require_local_device $SCRATCH_DEV
+
+fs_stress()
+{
+=09local target=3D$1
+
+=09$FSSTRESS_PROG -n 50 -p 3 -d $target >/dev/null
+=09sync
+}
+
+# prepare some mountpoint dir
+SRCHEAD=3D$TEST_DIR/$seq-src
+DSTHEAD=3D$TEST_DIR/$seq-dst
+rm -rf $SRCHEAD $DSTHEAD
+mkdir $SRCHEAD $DSTHEAD 2>>$seqres.full
+mpA=3D$SRCHEAD/"$$"_mpA
+mpB=3D$SRCHEAD/"$$"_mpB
+mpC=3D$DSTHEAD/"$$"_mpC
+mpD=3D$DSTHEAD/"$$"_mpD
+
+find_mnt()
+{
+=09echo "------"
+=09findmnt -n -o TARGET,SOURCE $SCRATCH_DEV | \
+=09=09sed -e "s;$mpA;mpA;g" \
+=09=09    -e "s;$mpB;mpB;g" \
+=09=09    -e "s;$mpC;mpC;g" \
+=09=09    -e "s;$mpD;mpD;g" | \
+=09=09_filter_spaces | _filter_testdir_and_scratch | sort
+=09echo "=3D=3D=3D=3D=3D=3D"
+}
+
+start_test()
+{
+=09local type=3D$1
+
+=09_scratch_mkfs >$seqres.full 2>&1
+
+=09_get_mount -t $FSTYP $SCRATCH_DEV $SRCHEAD
+=09# make sure $SRCHEAD is private
+=09$MOUNT_PROG --make-private $SRCHEAD
+
+=09_get_mount -t $FSTYP $SCRATCH_DEV $DSTHEAD
+=09# test start with a bind, then make-shared $DSTHEAD
+=09_get_mount --bind $DSTHEAD $DSTHEAD
+=09$MOUNT_PROG --make-"${type}" $DSTHEAD
+=09mkdir $mpA $mpB $mpC $mpD
+}
+
+end_test()
+{
+=09_clear_mount_stack
+=09rm -rf $mpA $mpB $mpC $mpD
+}
+
+move_run()
+{
+=09local source=3D$1
+=09local dest=3D$2
+
+=09start_test $dest
+
+=09echo "move $source to $dest"
+=09_get_mount -t $FSTYP $SCRATCH_DEV $mpA
+=09mkdir -p $mpA/dir 2>/dev/null
+=09$MOUNT_PROG --make-shared $mpA
+=09# need a peer for slave later
+=09_get_mount --bind $mpA $mpB
+=09$MOUNT_PROG --make-"$source" $mpB
+=09# maybe unbindable at here
+=09_get_mount --move $mpB $mpC 2>/dev/null
+=09if [ $? -ne 0 ]; then
+=09=09find_mnt
+=09=09end_test
+=09=09return 0
+=09fi
+
+=09# check mpC after move B to C
+=09for m in $mpA $mpC; do
+=09=09_get_mount -t $FSTYP $SCRATCH_DEV $m/dir
+=09=09fs_stress $m/dir
+=09=09find_mnt
+=09=09_put_mount
+=09done
+
+=09# mpC will be in different parent mount, test moving from different
+=09# parent mount, and moving a mount residing under a shared mount is
+=09# invalid
+=09_get_mount --move $mpC $mpD 2>/dev/null
+=09if [ $? -ne 0 ]; then
+=09=09find_mnt
+=09=09end_test
+=09=09return 0
+=09fi
+=09for m in $mpA $mpD; do
+=09=09_get_mount -t $FSTYP $SCRATCH_DEV $m/dir
+=09=09fs_stress $m/dir
+=09=09find_mnt
+=09=09_put_mount
+=09done
+
+=09end_test
+}
+
+move_test()
+{
+=09#        source     dest
+=09move_run shared     shared
+=09move_run slave      shared
+=09move_run private    shared
+=09move_run unbindable shared
+
+=09move_run shared     slave
+=09move_run slave      slave
+=09move_run private    slave
+=09move_run unbindable slave
+
+=09move_run shared     private
+=09move_run slave      private
+=09move_run private    private
+=09move_run unbindable private
+}
+
+move_test
+
+# success, all done
+status=3D0
+exit
diff --git a/tests/generic/586.out b/tests/generic/586.out
new file mode 100644
index 00000000..efa99942
--- /dev/null
+++ b/tests/generic/586.out
@@ -0,0 +1,374 @@
+QA output created by 586
+move shared to shared
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+move slave to shared
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+move private to shared
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+move unbindable to shared
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpB SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+move shared to slave
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+move slave to slave
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+move private to slave
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+move unbindable to slave
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+move shared to private
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+move slave to private
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+move private to private
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+move unbindable to private
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpC SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpC SCRATCH_DEV
+mpC/dir SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpA/dir SCRATCH_DEV
+mpD SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
+------
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-dst SCRATCH_DEV
+TEST_DIR/586-src SCRATCH_DEV
+mpA SCRATCH_DEV
+mpD SCRATCH_DEV
+mpD/dir SCRATCH_DEV
+=3D=3D=3D=3D=3D=3D
diff --git a/tests/generic/group b/tests/generic/group
index e5d0c1da..7ceddfcd 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -588,3 +588,4 @@
 583 auto quick encrypt
 584 auto quick encrypt
 585 auto rename
+586 auto quick mount
--=20
2.20.1

