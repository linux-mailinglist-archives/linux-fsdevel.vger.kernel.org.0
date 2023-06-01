Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EA5719748
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 11:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjFAJmq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 05:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjFAJml (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:42:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AE8E42;
        Thu,  1 Jun 2023 02:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=bSiYRErgId/94mjsvRxC22Zew9GpS4fzwrEPteKYtcY=; b=Gh1DZGgBfBfavJONJTdumqEFMm
        2CXAdykGs6iVlm8IcCdrIPgT/YJg8eOzGwi0cmLyO1SfnAGzwj5/4lD39K7lJTWa33maSdoYsDnfk
        eMW8CHJnQVPqknsX/WA0fZV4Zvwfg+LuSgJK5WiTOTom0iMkBL1MHi2nhYrshwK5DjQ/GL0BBXZRM
        70e4viiNa7DpMGGEMzqP1ioXMZTrU5C4zGWF54NCpXvkaCbW5lMZjujwY1yMq12ESP/GSz7TfEIS5
        yWprsjMTVzN1E0O/QPd74pwDpccgB+CH378von7A3F7VUWwaQ126Ci+rLHcL+b5W/pCuvNaxvQrfY
        UIb3WAvA==;
Received: from [2001:4bb8:182:6d06:35f3:1da0:1cc3:d86d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4epD-002lYs-2S;
        Thu, 01 Jun 2023 09:42:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] generic: add a test for device removal with dirty data
Date:   Thu,  1 Jun 2023 11:42:23 +0200
Message-Id: <20230601094224.1350253-2-hch@lst.de>
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
has dirty data.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/729     | 53 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/729.out |  2 ++
 2 files changed, 55 insertions(+)
 create mode 100755 tests/generic/729
 create mode 100644 tests/generic/729.out

diff --git a/tests/generic/729 b/tests/generic/729
new file mode 100755
index 00000000..e3b52a51
--- /dev/null
+++ b/tests/generic/729
@@ -0,0 +1,53 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2015 Red Hat Inc. All Rights Reserved.
+# Copyright (c) 2023 Christoph Hellwig
+#
+# Test proper file system shut down when the block device is removed underneath
+# and there is dirty data.
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
+$XFS_IO_PROG -f -c "pwrite 0 1M" $SCRATCH_MNT/testfile >>$seqres.full
+
+# open a file descriptor for reading the file
+exec 3< $SCRATCH_MNT/testfile
+
+# delete the scsi debug device while it still has dirty data
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
diff --git a/tests/generic/729.out b/tests/generic/729.out
new file mode 100644
index 00000000..8abf2b3c
--- /dev/null
+++ b/tests/generic/729.out
@@ -0,0 +1,2 @@
+QA output created by 729
+cat: -: Input/output error
-- 
2.39.2

