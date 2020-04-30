Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72E51BF767
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 13:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgD3L7G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Apr 2020 07:59:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgD3L7G (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:59:06 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04C9F2078D;
        Thu, 30 Apr 2020 11:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588247945;
        bh=MTHhwdAQgoPQj+qDZufQqSCn//NQmghP9mu5ED4ji+k=;
        h=From:To:Cc:Subject:Date:From;
        b=WeTofuiXkzp2SmsiIg3utgCWWiJJRSxMoo/Q4jWDdkcIZ6CW5XMUz4U9wA5EiXBSB
         0TfIPLipbo9RNY2BfdjjmGni6M1WNC5UG8381IY0FkNBiPca3z0YUw+6zOslyvWqBc
         RTdWE6Zan1ZN/sKa+sXsDwXrxppCTbBfgqNdyIfo=
From:   Jeff Layton <jlayton@kernel.org>
To:     guaneryu@gmail.com, fstests@vger.kernel.org
Cc:     bfoster@redhat.com, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: [xfstests PATCH] generic: test reporting of wb errors via syncfs
Date:   Thu, 30 Apr 2020 07:59:02 -0400
Message-Id: <20200430115902.28613-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

Add a test for new syncfs error reporting behavior. When an inode fails
to be written back, ensure that a subsequent call to syncfs() will also
report an error.

Reviewed-by: Brian Foster <bfoster@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 tests/generic/999     | 79 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/999.out |  8 +++++
 tests/generic/group   |  1 +
 3 files changed, 88 insertions(+)
 create mode 100755 tests/generic/999
 create mode 100644 tests/generic/999.out

This patch is intended to test new behavior for syncfs that has recently
gone into linux-next and should make v5.8. See:

https://lore.kernel.org/linux-fsdevel/20200428135155.19223-1-jlayton@kernel.org/

diff --git a/tests/generic/999 b/tests/generic/999
new file mode 100755
index 000000000000..cdc0772d0774
--- /dev/null
+++ b/tests/generic/999
@@ -0,0 +1,79 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2020, Jeff Layton. All rights reserved.
+# FS QA Test No. 999
+#
+# Open a file and write to it and fsync. Then, flip the data device to throw
+# errors, write to it again and do an fdatasync. Then open an O_RDONLY fd on
+# the same file and call syncfs against it and ensure that an error is reported.
+# Then call syncfs again and ensure that no error is reported. Finally, repeat
+# the open and syncfs and ensure that there is no error reported.
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1    # failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+	_dmerror_cleanup
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/dmerror
+
+# real QA test starts here
+_supported_os Linux
+_require_scratch_nocheck
+# This test uses "dm" without taking into account the data could be on
+# realtime subvolume, thus the test will fail with rtinherit=1
+_require_no_rtinherit
+_require_dm_target error
+
+rm -f $seqres.full
+
+echo "Format and mount"
+_scratch_mkfs > $seqres.full 2>&1
+_dmerror_init
+_dmerror_mount
+
+
+# create file
+testfile=$SCRATCH_MNT/syncfs-reports-errors
+touch $testfile
+
+# write a page of data to file, and call fsync
+datalen=$(getconf PAGE_SIZE)
+$XFS_IO_PROG -c "pwrite -W -q 0 $datalen" $testfile
+
+# flip device to non-working mode
+_dmerror_load_error_table
+
+# rewrite the data and call fdatasync
+$XFS_IO_PROG -c "pwrite -w -q 0 $datalen" $testfile
+
+# heal the device error
+_dmerror_load_working_table
+
+# open again and call syncfs twice
+echo "One of the following syncfs calls should fail with EIO:"
+$XFS_IO_PROG -r -c syncfs -c syncfs $testfile
+echo "done"
+
+echo "This syncfs call should succeed:"
+$XFS_IO_PROG -r -c syncfs $testfile
+echo "done"
+
+# success, all done
+_dmerror_cleanup
+
+status=0
+exit
diff --git a/tests/generic/999.out b/tests/generic/999.out
new file mode 100644
index 000000000000..950a2ba42503
--- /dev/null
+++ b/tests/generic/999.out
@@ -0,0 +1,8 @@
+QA output created by 999
+Format and mount
+fdatasync: Input/output error
+One of the following syncfs calls should fail with EIO:
+syncfs: Input/output error
+done
+This syncfs call should succeed:
+done
diff --git a/tests/generic/group b/tests/generic/group
index 718575baeef9..9bcf296fc3dd 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -598,3 +598,4 @@
 594 auto quick quota
 595 auto quick encrypt
 596 auto quick
+999 auto quick
-- 
2.26.2

