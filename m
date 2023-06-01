Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4422A71974C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 11:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbjFAJmt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 05:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjFAJmr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:42:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A269D1A1;
        Thu,  1 Jun 2023 02:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=sIveeC0ThkkyVdSiByd2bf1uVMnSayc9SF2mm08yF90=; b=ZTSd2hK4rZ/iNCZu8fPU1tOqBg
        0X6fqdRcYHqRtpdl4epZsrjCUvLXpnzc2+7ySL7JxWxxKXw5s41Q3hlcY9Je9EXNsiNQySA45cAyY
        5RICQh1aMqtVpnICepIAK+W4PmhSrXAI8i3XCDgsYDLvqHvGesbSSoqNO4odE4v2Fs2qe0kgKlJwR
        waInhKoR8OuSsH1KmRyA33p+pnCLaHgbygkCM9mgOJto2GLcrYLV8MtDfs1anVGa3E6vby84B+sGS
        uSfhegFWBccEeRA61goQmYLWTwqezyJ1zJmwQyy68w4LO7vgYv6sY4c53iL8alQIbvENQn68Y2SCH
        jsSKKLQQ==;
Received: from [2001:4bb8:182:6d06:35f3:1da0:1cc3:d86d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4epI-002lZG-0j;
        Thu, 01 Jun 2023 09:42:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] generic: add a test for device removal without dirty data
Date:   Thu,  1 Jun 2023 11:42:24 +0200
Message-Id: <20230601094224.1350253-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601094224.1350253-1-hch@lst.de>
References: <20230601094224.1350253-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Test the removal of the underlying device when the file system still
does not have dirty data.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/730     | 55 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/730.out |  2 ++
 2 files changed, 57 insertions(+)
 create mode 100755 tests/generic/730
 create mode 100644 tests/generic/730.out

diff --git a/tests/generic/730 b/tests/generic/730
new file mode 100755
index 00000000..7f795da3
--- /dev/null
+++ b/tests/generic/730
@@ -0,0 +1,55 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2015 Red Hat Inc. All Rights Reserved.
+# Copyright (c) 2023 Christoph Hellwig
+#
+# Test proper file system shut down when the block device is removed underneath
+# and it has no dirty data.
+#
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+_cleanup()
+{
+	cd /
+	$UMOUNT_PROG $SCRATCH_MNT >>$seqres.full 2>&1
+	_put_scsi_debug_dev
+	rm -f $tmp.*
+}
+
+. ./common/filter
+. ./common/scsi_debug
+
+_supported_fs generic
+_require_scsi_debug
+
+physical=`blockdev --getpbsz $SCRATCH_DEV`
+logical=`blockdev --getss $SCRATCH_DEV`
+
+SCSI_DEBUG_DEV=`_get_scsi_debug_dev ${physical:-512} ${logical:-512} 0 300`
+test -b "$SCSI_DEBUG_DEV" || _notrun "Failed to initialize scsi debug device"
+echo "SCSI debug device $SCSI_DEBUG_DEV" >>$seqres.full
+
+_mkfs_dev $SCSI_DEBUG_DEV
+
+_mount $SCSI_DEBUG_DEV $SCRATCH_MNT
+
+# create a test file
+$XFS_IO_PROG -f -c "pwrite 0 1M" -c "fsync" $SCRATCH_MNT/testfile >>$seqres.full
+
+# open a file descriptor for reading the file
+exec 3< $SCRATCH_MNT/testfile
+
+# drop all caches and delete the scsi debug device
+echo 3 > /proc/sys/vm/drop_caches
+echo 1 > /sys/block/`_short_dev $SCSI_DEBUG_DEV`/device/delete
+
+# try to read from the file, which should give us -EIO
+cat <&3 > /dev/null
+
+# close the file descriptor to not block unmount
+exec 3<&-
+
+status=0
+exit
diff --git a/tests/generic/730.out b/tests/generic/730.out
new file mode 100644
index 00000000..79e96db8
--- /dev/null
+++ b/tests/generic/730.out
@@ -0,0 +1,2 @@
+QA output created by 730
+cat: -: Input/output error
-- 
2.39.2

