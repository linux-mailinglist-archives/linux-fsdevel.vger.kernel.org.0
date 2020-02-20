Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E44221667F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 21:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgBTUGl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 15:06:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57258 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728929AbgBTUGl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 15:06:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582229200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U/oLbx5cHHC38z0dd70vpQOtX19OGfnYLbW8tHaodgw=;
        b=PbuTM2oRvvi415M15gUwSAZRnE8KNDC6wVxR2R1QElHNOdgvSEcIusLunBreZB6s9Q+9hh
        tw3NyNBU6vMq6wvrDSellREE7qcMqseTAOqCGgyIftgioFvOthEup/AcGrjuDBvbPUOigl
        46QEKsedkgOPa6GKuCGGDw2QH+ydKsw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-oTXoGsccMzS-R5h8VXKLkw-1; Thu, 20 Feb 2020 15:06:36 -0500
X-MC-Unique: oTXoGsccMzS-R5h8VXKLkw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7AC68017CC;
        Thu, 20 Feb 2020 20:06:35 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 99CF387B0A;
        Thu, 20 Feb 2020 20:06:35 +0000 (UTC)
Received: by segfault.boston.devel.redhat.com (Postfix, from userid 3734)
        id 9602B2015B1C; Thu, 20 Feb 2020 15:06:34 -0500 (EST)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     fstests@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>
Subject: [PATCH V2 1/3] dax/dm: disable testing on devices that don't support dax
Date:   Thu, 20 Feb 2020 15:06:30 -0500
Message-Id: <20200220200632.14075-2-jmoyer@redhat.com>
In-Reply-To: <20200220200632.14075-1-jmoyer@redhat.com>
References: <20200220200632.14075-1-jmoyer@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the check for dax from the individual target scripts into
_require_dm_target.  This fixes up a couple of missed tests that are
failing due to the lack of dax support (such as tests requiring
dm-snapshot).

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
---
 common/dmdelay  |  5 -----
 common/dmerror  |  5 -----
 common/dmflakey |  5 -----
 common/dmthin   |  5 -----
 common/rc       | 11 +++++++++++
 5 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/common/dmdelay b/common/dmdelay
index f1e725b9..66cac1a7 100644
--- a/common/dmdelay
+++ b/common/dmdelay
@@ -7,11 +7,6 @@
 DELAY_NONE=3D0
 DELAY_READ=3D1
=20
-echo $MOUNT_OPTIONS | grep -q dax
-if [ $? -eq 0 ]; then
-	_notrun "Cannot run tests with DAX on dmdelay devices"
-fi
-
 _init_delay()
 {
 	local BLK_DEV_SIZE=3D`blockdev --getsz $SCRATCH_DEV`
diff --git a/common/dmerror b/common/dmerror
index 426f1e96..7d12e0a1 100644
--- a/common/dmerror
+++ b/common/dmerror
@@ -4,11 +4,6 @@
 #
 # common functions for setting up and tearing down a dmerror device
=20
-echo $MOUNT_OPTIONS | grep -q dax
-if [ $? -eq 0 ]; then
-	_notrun "Cannot run tests with DAX on dmerror devices"
-fi
-
 _dmerror_setup()
 {
 	local dm_backing_dev=3D$SCRATCH_DEV
diff --git a/common/dmflakey b/common/dmflakey
index 2af3924d..b4e11ae9 100644
--- a/common/dmflakey
+++ b/common/dmflakey
@@ -8,11 +8,6 @@ FLAKEY_ALLOW_WRITES=3D0
 FLAKEY_DROP_WRITES=3D1
 FLAKEY_ERROR_WRITES=3D2
=20
-echo $MOUNT_OPTIONS | grep -q dax
-if [ $? -eq 0 ]; then
-	_notrun "Cannot run tests with DAX on dmflakey devices"
-fi
-
 _init_flakey()
 {
 	local BLK_DEV_SIZE=3D`blockdev --getsz $SCRATCH_DEV`
diff --git a/common/dmthin b/common/dmthin
index 7946e9a7..61dd6f89 100644
--- a/common/dmthin
+++ b/common/dmthin
@@ -21,11 +21,6 @@ DMTHIN_POOL_DEV=3D"/dev/mapper/$DMTHIN_POOL_NAME"
 DMTHIN_VOL_NAME=3D"thin-vol"
 DMTHIN_VOL_DEV=3D"/dev/mapper/$DMTHIN_VOL_NAME"
=20
-echo $MOUNT_OPTIONS | grep -q dax
-if [ $? -eq 0 ]; then
-	_notrun "Cannot run tests with DAX on dmthin devices"
-fi
-
 _dmthin_cleanup()
 {
 	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
diff --git a/common/rc b/common/rc
index eeac1355..65cde32b 100644
--- a/common/rc
+++ b/common/rc
@@ -1874,6 +1874,17 @@ _require_dm_target()
 	_require_sane_bdev_flush $SCRATCH_DEV
 	_require_command "$DMSETUP_PROG" dmsetup
=20
+	echo $MOUNT_OPTIONS | grep -q dax
+	if [ $? -eq 0 ]; then
+		case $target in
+		stripe|linear|log-writes)
+			;;
+		*)
+			_notrun "Cannot run tests with DAX on $target devices."
+			;;
+		esac
+	fi
+
 	modprobe dm-$target >/dev/null 2>&1
=20
 	$DMSETUP_PROG targets 2>&1 | grep -q ^$target
--=20
2.19.1

