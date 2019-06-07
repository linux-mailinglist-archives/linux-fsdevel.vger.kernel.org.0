Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 349E138B41
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 15:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbfFGNLQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 09:11:16 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53156 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbfFGNLO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559913074; x=1591449074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DlQ4GLxGdZJmE7yvObMcvG5bi4ACFJsGLoXRshNTPh4=;
  b=YnnTsX7TgGm2qbncVUjZ6CfHIxdV8PjRqWEC4pV9fFdld8oGEgGQgXhc
   IxwfFnTVFm4HGnxxVF+E720prI8UP2A74RXgmjEuq0X61poSx2rW01IgA
   HGr219GR7U8/YzYNk+Cgu1yyRrgAbs1NhUq1d5MpvZZTxoZG9SRGC3WV+
   MgIJLemcIhUuIhQPy8iobqwIfMHosDTtHTuZo6wTtT6veM1IrGjKRb7K5
   1egTIC51ZVpUS+nm+kWKbQUKpyPGyOHIwRE5pTy7vmi5xs83dgLHKIf+l
   +deZVIQ4r4Me+GjIpKd/l2pxyDbRh7n3aE196oD9jnpX1GZwY9HGgFtjB
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="110027764"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 21:11:14 +0800
IronPort-SDR: cxtWHuDtXCXoPt8gegaPneVM5VhprwTNG0/zgciKLkD9vwhc2dQlngAAiAKmaWsG22rXqCf4xg
 apBqvpzxfbsKa8n1WxrR0ylFYmZdYfekgwTITkgJmW2Fp+HPyXIS5DEIPzvCUCWKDmVFN53NI0
 NjfDubZA/9tOc19KcpsVt+cm1eUmU4jhiIc+2iOK+OGuCU4jNbtz1c1C5zNo235/BhNKcaRC3P
 H2NoxTjY9XnvC5IssVyXciEYosY6NeD8sKQ6YjRrIr4R4iUVLY7mtHQFCJvhoa7jWPa85ETgj1
 rrGziCJ+NSXEoXAGRA4a1hUA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 05:48:31 -0700
IronPort-SDR: /mUewI0BvY0IcXPufJN85DXHDBm7kLJrWkNdFR/j9w3Yx8O7m1GDyEqDFzwYyRLNgv6HdBHBep
 jOnug/QD5AdqhMzOFqtkUGzi2Fa8gEDxo+0T4N/L0EIP/ybIA9p9kBVawt2DH3I/+kkhs4pMiF
 CTPZ/RViJFuQdKc/+v8m8ngMQ17xtRlRdzO7kwIe5JTQtSyOtPXfSQLaPXq9iAQyibVIMhQYkb
 uxEyI2JgTRIzkJSGVEjregeQS9v/uGlTH8NTsep6vmo+t8jHrsvVYZTFCwduBWzWRslsd13BC6
 Nvg=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 06:11:12 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 01/19] btrfs: introduce HMZONED feature flag
Date:   Fri,  7 Jun 2019 22:10:07 +0900
Message-Id: <20190607131025.31996-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607131025.31996-1-naohiro.aota@wdc.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduces the HMZONED incompat flag. The flag indicates that
the volume management will satisfy the constraints imposed by host-managed
zoned block devices.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/sysfs.c           | 2 ++
 include/uapi/linux/btrfs.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 2f078b77fe14..ccb3d732e7d2 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -192,6 +192,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(raid56, RAID56);
 BTRFS_FEAT_ATTR_INCOMPAT(skinny_metadata, SKINNY_METADATA);
 BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);
 BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
+BTRFS_FEAT_ATTR_INCOMPAT(hmzoned, HMZONED);
 BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
 
 static struct attribute *btrfs_supported_feature_attrs[] = {
@@ -206,6 +207,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(skinny_metadata),
 	BTRFS_FEAT_ATTR_PTR(no_holes),
 	BTRFS_FEAT_ATTR_PTR(metadata_uuid),
+	BTRFS_FEAT_ATTR_PTR(hmzoned),
 	BTRFS_FEAT_ATTR_PTR(free_space_tree),
 	NULL
 };
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index c195896d478f..2d5e8f801135 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -270,6 +270,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA	(1ULL << 8)
 #define BTRFS_FEATURE_INCOMPAT_NO_HOLES		(1ULL << 9)
 #define BTRFS_FEATURE_INCOMPAT_METADATA_UUID	(1ULL << 10)
+#define BTRFS_FEATURE_INCOMPAT_HMZONED		(1ULL << 11)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
-- 
2.21.0

