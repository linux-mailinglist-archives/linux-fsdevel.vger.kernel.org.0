Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5D64DB150
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 14:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348743AbiCPNYZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 09:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242794AbiCPNYW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:24:22 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63D213E98;
        Wed, 16 Mar 2022 06:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647436988; x=1678972988;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=alf05YzTWExykrDr4nOA1oxCnGH0bd9x1s4DBonX7yU=;
  b=Xit+ZN/FzCrV7/HYGmTAScYDXY6EJVI7bn3RXlPnYe3R0bDiRIjN2BbK
   8qlB+ZWIBZkAnJYJ7mzR4mgCGGXNuIprQ/iW4+xFTwWuPc6fHEuwrU4I0
   CRO5xrUEi802OnKQ8tZ+m5XGoVhdyBXd5vilgweOuCtFe+LIqzNT7h66w
   2cPV9Y931EZbVA8fIQnjRwqhjKqFq6IeO+aXkMpmGA7QiMHUrNgtlK3OP
   ppq5Gh8onOrgzVANvxXhh0Uf7bi5m6CZuxgidFKOSyJaLF7m95RCHEpyX
   kFW8U3TD9LHZRl0qg8xXzZ8EcGzweR1gS5YfCBBDfdKQp3hI4hdeBAFFd
   g==;
X-IronPort-AV: E=Sophos;i="5.90,186,1643644800"; 
   d="scan'208";a="299654883"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2022 21:23:08 +0800
IronPort-SDR: M4OS0KtaXBDoGms6J0RzXV2gLiDrqDQSmmgykCmmWsK6f8aizVB9dBBz1ejgj/RaA3KbJXe1Ol
 fvwIOG44aKpBnSC0e1cSYVy11KOlC77AKssQW1u9Tk6vvd09MDbi8WiODILYK17GGTpXyX5AlH
 LIvQbVYLiWwlLmLt8npDn4KJSkrA5w64c4smuL3AeaZpJuEg5E/kPq4MzxedpeHcC/lUCNG8Sd
 TSw56JPfQ68nzU/O8oUFgrXre2weSFbyiV0m6dLpDA02BQc0LjabUZFWjJAKDWMNAXxLf5pMdp
 vSUMOdyS8/0vUvIpsY89l4RZ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 05:54:14 -0700
IronPort-SDR: yGqvzEQDJlkkAM1Obt4VXtEv35c12+C1oO1SQ2rPKTlbv6pLZx01+kL7Y2Ykrmx7skmm7hBtJ5
 xEZcuF0ZndyiYBQnY91dZzKJ+lFfvl9WyFSk5oxW5iSFmuMrN/LYBjFJSFm3Hxrnr48A3Y1iyN
 +PcZMLNXaKnrXLJ0xtcn29FUgfS0nO8ZMGBA3V7s7ZoDDnJQ+76OmU0txALqVGPtSbSD7XLJMD
 eLLcZtPQyn2WZ70uiGjh/etrUbGhHZuc3iycaXx5q7SJjFq7BIVwu3j5kvKQCr7orYeavPNMiQ
 Y9E=
WDCIronportException: Internal
Received: from d2bbl13.ad.shared (HELO naota-xeon.wdc.com) ([10.225.55.209])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Mar 2022 06:23:07 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 2/4] btrfs: mark device addition as mnt_want_write_file
Date:   Wed, 16 Mar 2022 22:22:38 +0900
Message-Id: <4b8a439c276e774ab2402cbd5395061ea0bd3cde.1647436353.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647436353.git.naohiro.aota@wdc.com>
References: <cover.1647436353.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

btrfs_init_new_device() calls btrfs_relocate_sys_chunk() which incurs
file-system internal writing. That writing can cause a deadlock with
FS freezing like as described in like as described in commit
26559780b953 ("btrfs: zoned: mark relocation as writing").

Mark the device addition as mnt_want_write_file. This is also consistent
with the removing device ioctl counterpart.

Cc: stable@vger.kernel.org # 4.9+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ioctl.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 60c907b14547..a6982a1fde65 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3474,8 +3474,10 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 	return ret;
 }
 
-static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
+static long btrfs_ioctl_add_dev(struct file *file, void __user *arg)
 {
+	struct inode *inode = file_inode(file);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_ioctl_vol_args *vol_args;
 	bool restore_op = false;
 	int ret;
@@ -3488,6 +3490,10 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
 		return -EINVAL;
 	}
 
+	ret = mnt_want_write_file(file);
+	if (ret)
+		return ret;
+
 	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_DEV_ADD)) {
 		if (!btrfs_exclop_start_try_lock(fs_info, BTRFS_EXCLOP_DEV_ADD))
 			return BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
@@ -3520,6 +3526,7 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
 		btrfs_exclop_balance(fs_info, BTRFS_EXCLOP_BALANCE_PAUSED);
 	else
 		btrfs_exclop_finish(fs_info);
+	mnt_drop_write_file(file);
 	return ret;
 }
 
@@ -5443,7 +5450,7 @@ long btrfs_ioctl(struct file *file, unsigned int
 	case BTRFS_IOC_RESIZE:
 		return btrfs_ioctl_resize(file, argp);
 	case BTRFS_IOC_ADD_DEV:
-		return btrfs_ioctl_add_dev(fs_info, argp);
+		return btrfs_ioctl_add_dev(file, argp);
 	case BTRFS_IOC_RM_DEV:
 		return btrfs_ioctl_rm_dev(file, argp);
 	case BTRFS_IOC_RM_DEV_V2:
-- 
2.35.1

