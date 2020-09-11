Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F85E266787
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 19:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgIKRo3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 13:44:29 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38451 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgIKMeD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599827644; x=1631363644;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VtUI/UUEY5r9r9zyt3U+9zudIoc620wwP7oYcJO7XcI=;
  b=m8l/rSS3feNftDH1YLSBObyYpVzQVNhzNZmvJHQglCKAcyhGxEsiHy+m
   AYTa2PQ35e6vGQUzE9TfnT0XVur0NALFUCpK3rwZM4RB/adGEnKy6JghW
   eaOmV+Q8neIRDm3oEPZFcsCBDGQSzfFmsAobAjJrGa8YoqNPHd1uF0WAx
   ctVAqX0sNqTTbzMtUJ3nDe4EcmoypA+3F/sP5AMH7IooLx5ikNlnSJdga
   Wy4x9fKPc2z8xYrlPJoh3jpavZqh7/pA2O2maMCWMwRgeYRM2GkgQous/
   i4XsDURjnYlTJZ8bNcW/639NiZ/r/oQUVzQ66oRNhBkzjanys8UjPJbGo
   w==;
IronPort-SDR: 17BzVFbg2H54vRdCSNefBCOc1JxQOOYvJXNjGzhBgncS2MD+uciM71r+M7wnYMZNXxIcnYhpPh
 c2OPutsrSqx6R1XVI2tVlRLhov2CKG8oJmknVvVLz4S/zHK1H7zlib2sMkQ+VXAzPJ9xtSAXp/
 jEbHY1IlYw32R+00ruRRrxJ5aAP9Bj/tJiwbxsOIXWoKk1X58s9KdaxqQpfina4Sw82S0HFt1p
 KNG0VFqIAwL7U+gbiwzvo6BJ/zBKysB8mywWayulainKqriOLOXmCPdiuBc7K2XDMNjKG7IG4p
 xY8=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147125963"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:33:17 +0800
IronPort-SDR: 2tRazSOvHIMVMyy66ue0N88Oonp6HzEaaH1aH3Ccq/TBGf8Wq1hijZ6pbs8FpZF6km4YTUCl5I
 HYOu6xJqzWSQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:19:37 -0700
IronPort-SDR: 8CWfhvT5sZU0hE1c7f/XQF9xSa5tuj4FZjP5fBZ7HUAsBCuscTIeiFKpyIskDIlNYDZqaNYn0H
 vnd6mNYOd8DQ==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:33:14 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v7 06/39] btrfs: disallow NODATACOW in ZONED mode
Date:   Fri, 11 Sep 2020 21:32:26 +0900
Message-Id: <20200911123259.3782926-7-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
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
index ac45f022b495..548692cdc5df 100644
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

