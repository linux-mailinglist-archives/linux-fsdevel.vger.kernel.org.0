Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F059266782
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 19:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgIKRoM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 13:44:12 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38451 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgIKMfZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599827725; x=1631363725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yH1nPkHODBV09kOOFiPhVkyCkpApdtePV0TSia5UdZM=;
  b=bax7xpX+CPwLujyCVoLBSQUVsbXGTKCROhweLqSrKCN+e8/aMvgsgKhd
   B5Avq1u8rvoHJn3vUaxvj9yYCdYSaVIdM+/yz0lHFOx2Bi8Y4+s8FwqhB
   BsL08YjQVvoTrydJfQ+7eGuQWexd2Pl/z/KLSWTpMVLk1hbNsnew2ggfi
   BcwveP8Br7QzrTOchFbgGyOJtm4G3RidwRKo0WBSgjtWw3t7KDUUSQh8p
   LA/N4Frd2ZvpkVw+LRk/xTh1fXh4rEsyYNRoY36ujvD9VsJP97k3VVo7X
   3MraYotJg/KVytn1r9INOC9PTOGwnDMe+M+84PpWdhb7Qehoa9G7ZhNka
   w==;
IronPort-SDR: qlHqBj7B8XODFqkTsvT84Dq3ggcX4CLo/6vXZF7lgNmD2uavcgmojzn5ckQqniHoyd+TQ5LkJZ
 8uPURxQMc+Bm/vfk423FEEa9NZgwtJbalKPjjy44G4rhxSyGYzHiTXZeJSrvaa26l9c4u+kb+e
 28denc4aj63XJWC7T92NsIBB88hM/Pg6KCj1pRjqSD6g2XSitHBnqbkAPqawyNO3XX8JSpTPcx
 9Y9QaBhTwOWuThEpKNHqva5pyNBkv2vW9VNkr/L4r66YZBsD5Zn0MlspgbEZCbJx1tGe5CQikT
 IOA=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147125978"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:33:25 +0800
IronPort-SDR: RhBzNfws+h5iMTWzZ863TTbrL9jP86jXKoyWkGc0feJh6ZI6o32Nr0QpFPM1XmUvO+y+NTlHda
 Dn6CmQLR51ig==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:19:46 -0700
IronPort-SDR: ZkLh3ZvYdikujK0xzO9wN3MUnwFs5hSDAQFDer1MfztJfgIOYZQmiEd7ST71VdKvu3rjDB9Khp
 e8vybWwigQEQ==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:33:23 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v7 12/39] btrfs: verify device extent is aligned to zone
Date:   Fri, 11 Sep 2020 21:32:32 +0900
Message-Id: <20200911123259.3782926-13-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
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
index 8c439d1ae4c5..086cd308e5b6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7765,6 +7765,20 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
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

