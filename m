Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F652806CA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 20:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732936AbgJASiR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 14:38:17 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24694 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732672AbgJASiK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601577490; x=1633113490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7ukzEdMdawXTYzv0Ef7UrRfJK4C09v/gF5FDZbrkpSw=;
  b=lUge+ZReYcnF3oVFCXgT2U/9rCFLDVK6/hvl9XIpY2DO2xGjMPDm546+
   P/xUtOoqBBw8vwuBIBL0BNKa+4B30lZz9AyaufcRWWqsqdco4eV4pusLR
   o1lQa8RYRVs9HODqXsiODK0DnnxJSEa00Gja9dMwJFmnqK+B1vAgxbAih
   Dllg0eIsqkyg6R6snU1ClVczWBGUBeceMD8dP+FtgGaej5YFptpE1AWWo
   3tWESQ9Kgp+cWG1hSZC1TD24yJKzto56HxsY0MbXbB3aSHMK77v4yuyzz
   kut+7xGTrykUp1Vs/ZD/Q9+BNekR7KOm7qNK25hx2mHbiB8PHQj7hphxS
   g==;
IronPort-SDR: 3xHQHszBHuXdSm0exzpewBnBEcD4V0T+lIIkEjmRwQCPPIts2LXCgA7rcVo0zwmGDh6jIms/wO
 tL6h45jRmDLzmDaMXHFV1Gc4+e6rOTFtUkVhTB/Big/ARaZBb8VSPUyRhqrgQtl3Pm4PwOhGx5
 T1TvmCq0BBC6RSQDXUOvq8+f2WF65KO+ci+b0h2FSZS6GxkSZ4Oe1XRaqYczoGFL4Ep/LKnRBH
 XzfwA+W1xvKqS87GD4D0YSjG34tkpmoPe12i8cs0MSoAgooRbeCnC8nZclp1ElT6eqyHcglp0d
 NWE=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; 
   d="scan'208";a="150036780"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 02:38:09 +0800
IronPort-SDR: ovHq9ETv8+6Mkjcz//kuuJ52wefC40UngaY2RCOJIPsPmuDrBrqiWgHPr1Q0s/cVBypsCPlR+l
 VGE7dOMrXyNw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:24:06 -0700
IronPort-SDR: 0VVbbzqeEtjaQjOK6fkyuI01aw/m9gbfwizMk0AhzN4o7jAyDypomaNESn+Egnic14ZMfJ6ziq
 eoWce5LG1R2A==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 11:38:08 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v8 07/41] btrfs: disallow NODATACOW in ZONED mode
Date:   Fri,  2 Oct 2020 03:36:14 +0900
Message-Id: <c5f6be584aea6de94506d91093be11c6c22e6088.1601574234.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
References: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

NODATACOW implies overwriting the file data on a device, which is
impossible in sequential required zones. Disable NODATACOW globally with
mount option and per-file NODATACOW attribute by masking FS_NOCOW_FL.

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ioctl.c | 3 +++
 fs/btrfs/zoned.c | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index ab408a23ba32..5d592da4e2ff 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -91,6 +91,9 @@ struct btrfs_ioctl_send_args_32 {
 static unsigned int btrfs_mask_fsflags_for_type(struct inode *inode,
 		unsigned int flags)
 {
+	if (btrfs_fs_incompat(btrfs_sb(inode->i_sb), ZONED))
+		flags &= ~FS_NOCOW_FL;
+
 	if (S_ISDIR(inode->i_mode))
 		return flags;
 	else if (S_ISREG(inode->i_mode))
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 1629e585ba8c..6bce654bb0e8 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -284,5 +284,11 @@ int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
 		return -EOPNOTSUPP;
 	}
 
+	if (btrfs_test_opt(info, NODATACOW)) {
+		btrfs_err(info,
+		  "cannot enable nodatacow with ZONED mode");
+		return -EOPNOTSUPP;
+	}
+
 	return 0;
 }
-- 
2.27.0

