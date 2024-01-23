Return-Path: <linux-fsdevel+bounces-8521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C0E838A8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 10:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F811F2466A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 09:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999835C8EC;
	Tue, 23 Jan 2024 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WzxfBXoS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3DA5BAFA;
	Tue, 23 Jan 2024 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003044; cv=none; b=c4tJ+CkKgENaodgtw09qYKWOnaSamcQVGmuZHZ4fu3w6E7nh5LmOibJNtSNCpbfjIxBTb1Wp+V0KqE35tlDjEpiMrynKPV4sc257PsyazSpQbplChykubdi7NBL5dCdAh8tBWgolQgsYchmVKKMTWmWf+DRuDrbfmfIn6BofHKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003044; c=relaxed/simple;
	bh=USx+V+gR/5Lk+0GJr2lbq1FeCI2pXKMzpek+ct39bMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y3d+ZSffVEdPq1YWX7Y7QJAVDZgL3GyLLSpq7kSefUuJIBfu3S/MVO/eY8TbukYSNbc1NOFfNbvMbVEYpmTM14Jf1qP10sye8YHbF35ZQ07NaGcMGC2uN8xM4rJPaVS+zQuFaPzwpR5rkFAGiuifODD2QhQdNEYBmaCWf/bIHQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WzxfBXoS; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706003042; x=1737539042;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=USx+V+gR/5Lk+0GJr2lbq1FeCI2pXKMzpek+ct39bMM=;
  b=WzxfBXoSysLCoYvWX9Wk00wDWTjKLQZ+eJlTxBnzw9bmmSvo2NNrikn9
   l6rqo5mnfZ8d6VnJ+xH4zdChm1qCSbxkQHhdc0EDyDjrffbsSB3hLSOuk
   lXwDrZXD5kPrUs6dOgN4I6KprRSvsvBxF4JIqUsUONmhfGEzUHUTNO1bJ
   k4amxZ1SqjOY309xDtlFQtpOY2SMjcYO2PCZ2P+iFmQ20o0OjDrt+nj6W
   JtGOFUbpKo7vHDnAo2TUQD3Z852jnBlsumKJxW24PLh1COvrEaNv7Yos4
   9R5qXx0CVTuo1qb/kuxQHUK+3++MaEOV5unPDjHvoR76yZ+cwJ5b7V+PL
   Q==;
X-CSE-ConnectionGUID: OLgmSsDqRTC4a2U/r99VOA==
X-CSE-MsgGUID: FvWCBe8QRtWec/o+td0l5A==
X-IronPort-AV: E=Sophos;i="6.05,214,1701100800"; 
   d="scan'208";a="7514650"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2024 17:43:54 +0800
IronPort-SDR: SYyrr2sfevEd2YeeThp4yjSt6XDT1YqATLjmPIuNAYwwoqCCmbs5PoYMlJFbPFp70n3YsNU0YA
 Llkgv1jyt/Ww==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2024 00:53:57 -0800
IronPort-SDR: P3OOCgnEiOoiT5kro0hhE2puMVinRxHrlbO9eu21ZDBzEa4K+SZFeEYuAtZNHIp7Zz4lNvn0Hv
 sg9b/x3sDNFA==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Jan 2024 01:43:50 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Tue, 23 Jan 2024 01:43:42 -0800
Subject: [PATCH 1/5] zonefs: pass GFP_KERNEL to blkdev_zone_mgmt() call
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-zonefs_nofs-v1-1-cc0b0308ef25@wdc.com>
References: <20240123-zonefs_nofs-v1-0-cc0b0308ef25@wdc.com>
In-Reply-To: <20240123-zonefs_nofs-v1-0-cc0b0308ef25@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Naohiro Aota <naohiro.aota@wdc.com>, Mike Snitzer <snitzer@kernel.org>, 
 dm-devel@lists.linux.dev, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706003027; l=967;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=USx+V+gR/5Lk+0GJr2lbq1FeCI2pXKMzpek+ct39bMM=;
 b=CqyzAxjrtVF3h1COiTD1vUp/FvMExp42Wy7b72mtI/+VK3Cc+nQQgb8KdYlLZ32Qn9DwLPhCQ
 2dpOdt+5tGWBTomHGv+qgGPRnYLx+GcwkDEU2N7SunPs8Zz3A98pXO5
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Pass GFP_KERNEL instead of GFP_NOFS to the blkdev_zone_mgmt() call in
zonefs_zone_mgmt().

As as zonefs_zone_mgmt() and zonefs_inode_zone_mgmt() are never called
from a place that can recurse back into the filesystem on memory reclaim,
it is save to call blkdev_zone_mgmt() with GFP_KERNEL.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/zonefs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 93971742613a..63fbac018c04 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -113,7 +113,7 @@ static int zonefs_zone_mgmt(struct super_block *sb,
 
 	trace_zonefs_zone_mgmt(sb, z, op);
 	ret = blkdev_zone_mgmt(sb->s_bdev, op, z->z_sector,
-			       z->z_size >> SECTOR_SHIFT, GFP_NOFS);
+			       z->z_size >> SECTOR_SHIFT, GFP_KERNEL);
 	if (ret) {
 		zonefs_err(sb,
 			   "Zone management operation %s at %llu failed %d\n",

-- 
2.43.0


