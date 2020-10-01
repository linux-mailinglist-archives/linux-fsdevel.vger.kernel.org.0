Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D1C2806D1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 20:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732755AbgJASiJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 14:38:09 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24680 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729927AbgJASiD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601577483; x=1633113483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5ETJSKP96iJAWlgibSI+CXwv6npNrB2/5xTsR6UalTM=;
  b=gcD1I6Jq1lBr4NXqro6Qbc7RmE8Gr/W4SuCtSbo0hwoK8pyo9vh4ABqJ
   p7zXpSHhB8/WFQ827NMk2X8PByL5SYEfqbR7C2PK1gRmC03/RZtTezpjf
   y/iuc1yJ+RT9MHthjaB58QMHxf4CmQvYKY4lMAFFHyXT8Q9FewJ1vaLkA
   twVDo1Vb7wJ08wNywi6wz1ihHSAbgui9hfzYZr5BH8wMrHYcHxPfQ6SgN
   fOOa9Qfa+GOVGmJFXFoXu8gDFTvWA3FBXuL+rvF173VHdP8aDRx+j5Ex+
   /eWpoXkqNAzY895+bVYe7RslEiE7RKqAka3HMs3WkE+5uuoxWrctRNvmC
   w==;
IronPort-SDR: Ti7coKoozM74JVoq4/2+3dU7s9wzUJQ/9/T9tnFu2aJq+QxkJ0wt4wX5WyJBnePHs0A6hLjBV5
 Ylbl1RNN8XcEhJjelzkD3iCZTd/9ZFI83+JxMA76WHWrSG5wrjDv5j50OkIMeuuIxyxVKvwx3D
 ke5pizpWAShr2qcKrFtI97mGcOMPx/mhlgYLcCZo249enIiNImSSSH6rlJs4OGoJSx/SsraySH
 WcvPuQfaMhovkmJHRo9TI4GwhSFbtBjJgr6lG0VL7MJE+N5ZoHgx9pbhwY/r2+mnIHtyY8FfGw
 Nsw=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; 
   d="scan'208";a="150036762"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 02:38:02 +0800
IronPort-SDR: r8O3PXw9zc4GhH46WBRGcHA8vd3I6KrXERnmOScctQgKBQSB/Qz/sWV7XxTG13Oq/D+qCiMsS7
 BpwMjbP4atpQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:23:59 -0700
IronPort-SDR: zfnoi9Wi2Zuarstdwa+QDGGK6Z3dCgtYMAOtCtEQB8dMGBkSWfYKLZgZc6Pdu57aenIL4f4gek
 G59jHh21XYBA==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 11:38:01 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Anand Jain <anand.jain@oracle.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v8 02/41] btrfs: introduce ZONED feature flag
Date:   Fri,  2 Oct 2020 03:36:09 +0900
Message-Id: <778806c32892a82a27a9252f8d33003fa95a20ee.1601574234.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
References: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduces the ZONED incompat flag. The flag indicates that the
volume management will satisfy the constraints imposed by host-managed
zoned block devices.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/sysfs.c           | 2 ++
 include/uapi/linux/btrfs.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 279d9262b676..828006020bbd 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -263,6 +263,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);
 BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
 BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
 BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
+BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
 
 static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(mixed_backref),
@@ -278,6 +279,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(metadata_uuid),
 	BTRFS_FEAT_ATTR_PTR(free_space_tree),
 	BTRFS_FEAT_ATTR_PTR(raid1c34),
+	BTRFS_FEAT_ATTR_PTR(zoned),
 	NULL
 };
 
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 2c39d15a2beb..5df73001aad4 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -307,6 +307,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_NO_HOLES		(1ULL << 9)
 #define BTRFS_FEATURE_INCOMPAT_METADATA_UUID	(1ULL << 10)
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
+#define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
-- 
2.27.0

