Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4889B2806DD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 20:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732998AbgJASii (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 14:38:38 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24728 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732931AbgJASiR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601577497; x=1633113497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pTkyVP7Td2jDa9Gu75FvxlDevtrMsYCgV6qHyrQB9qk=;
  b=OZuMxQCaj1H4l87cibGCUj32GCkZgsXlshT43c0Qb/FRrU6xB8NYIP38
   ptl/qH6mCWsgOIjUTAP3THyT9sZkzYAivgoXmkhQ6eIk8Z4dXU8HCwtin
   Pac7W7zUk5M/4JuqYP1eD75Alamn8Zj/uF7D2TP/siFy3zsLFs+hiq33E
   CVh6PkQFKQHzfPHcuix/3g5bN0t9YdWGbv5WRe+beqDNiETTb37wGhRws
   J9gIvFJm3nZe0WSizNwgcZC1vf3bG2oXFhmlsaY1d+Y4LNI46RmXgZszj
   u3vnNhYdnK8A5047OEmPIwwF64/V/EaWUCIBsyZnRL1iCp9JLZJej13tw
   A==;
IronPort-SDR: omaPjMOYPJeOUz1oKOTIh1I6fiOMRWulGXmbO4pjs/JnoPZWpcsXAgwA4ojaaFoiV6U27xa+1A
 pbbqQFcn98T0w3ApBMtTIOD+h4GXVp+hbECsQspmn0cCRyY85sa95aCVi8qO2h+6K6ffmu3IeA
 0OlmpTnsmf8xO4UQucrUS5On2bMwgCMlfvaPFYdGDIBAyy0Phn5muvkDxZXnuzaR36Sx3Sd3wW
 PluNQBXP6KGpB3a7RBqCepXJ3LJCZvWld/fjIoGL1rWSiosNmPwJlz9F1JZ0S0rgWTF/bpFud3
 By8=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; 
   d="scan'208";a="150036798"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 02:38:17 +0800
IronPort-SDR: 5SwzOdgMmjguY66vk5NW5cj+eRqSh0Kc+tIfFabJSNEu32AK1lmRDncoHo50aY2L6qX+syzFoU
 GIuCBF6/9xRA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:24:13 -0700
IronPort-SDR: O7kSsBPHNqhzF7Iy9fhEfJWxQWu3OMLqL1Mnt+j+vG/nF5lNx832fhZEOIeD3pvGqd7bqHRBvF
 xGn7iEv8MkFQ==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 11:38:16 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v8 13/41] btrfs: verify device extent is aligned to zone
Date:   Fri,  2 Oct 2020 03:36:20 +0900
Message-Id: <7dd11a4a91107e78eab80932ff5ac3c89288a44e.1601574234.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
References: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch add a verification in verify_one_dev_extent() to check if the
device extent is aligned to zone boundary.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/volumes.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3b6f07330553..c22ea7f0551f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7779,6 +7779,20 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 		ret = -EUCLEAN;
 		goto out;
 	}
+
+	if (dev->zone_info) {
+		u64 zone_size = dev->zone_info->zone_size;
+
+		if (!IS_ALIGNED(physical_offset, zone_size) ||
+		    !IS_ALIGNED(physical_len, zone_size)) {
+			btrfs_err(fs_info,
+"dev extent devid %llu physical offset %llu len %llu is not aligned to device zone",
+				  devid, physical_offset, physical_len);
+			ret = -EUCLEAN;
+			goto out;
+		}
+	}
+
 out:
 	free_extent_map(em);
 	return ret;
-- 
2.27.0

