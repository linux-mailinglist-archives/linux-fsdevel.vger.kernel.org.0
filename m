Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B299037139C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 12:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbhECK2P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 06:28:15 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48330 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbhECK2N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 06:28:13 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id 723E51F42180
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     fstests@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, krisman@collabora.com,
        preichl@redhat.com, kernel@collabora.com, willy@infradead.org,
        djwong@kernel.org
Subject: [PATCH v2] generic/631: Add a check for extended attributes
Date:   Mon,  3 May 2021 15:56:54 +0530
Message-Id: <20210503102654.196661-1-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Test case 631 fails for filesystems like exfat or vfat or any other
which does not support extended attributes.

The main reason for failure is not being able to mount overlayfs
with filesystems that do not support extended attributes.
mount -t overlay overlay -o "$l,$u,$w,$i" $mergedir

Above command would return an error as -
/var/mnt/scratch/merged0: wrong fs type, bad option, bad superblock
on overlay, missing codepage or helper program, or other error.

dmesg log reports the following -
overlayfs: filesystem on '/var/mnt/scratch/upperdir1' not supported

As per the overlayfs documentation -
"A wide range of filesystems supported by Linux can be the lower
filesystem, but not all filesystems that are mountable by Linux
have the features needed for OverlayFS to work. The lower filesystem
does not need to be writable. The lower filesystem can even be another
overlayfs. The upper filesystem will normally be writable and if it
is it must support the creation of trusted.* and/or user.* extended
attributes, and must provide valid d_type in readdir responses,
so NFS is not suitable. A read-only overlay of two read-only
filesystems may use any filesystem type."

As per the above statements from the overlayfs documentation,
it is clear that filesystems that do not support extended
attributes or d_type would not work with overlayfs.
This is why we see the error in dmesg log for upperdir1
which had an exfat filesystem.

This test case already checks for d_type but does not check for
extended attributes, hence add a check for it which would avoid
running this tests for filesystems that are not supported.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---

Changes in v2
  - Wrap the commit messages at 75 columns.
  - Improve the commit message to mention about d_type check.


 tests/generic/631 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/generic/631 b/tests/generic/631
index c43f3de3..c7f0190e 100755
--- a/tests/generic/631
+++ b/tests/generic/631
@@ -39,10 +39,12 @@ _cleanup()
 
 # get standard environment, filters and checks
 . ./common/rc
+. ./common/attr
 
 # real QA test starts here
 _supported_fs generic
 _require_scratch
+_require_attrs
 test "$FSTYP" = "overlay" && _notrun "Test does not apply to overlayfs."
 _require_extra_fs overlay
 
-- 
2.30.2

