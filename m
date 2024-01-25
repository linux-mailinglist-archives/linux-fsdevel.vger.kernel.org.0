Return-Path: <linux-fsdevel+bounces-8985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B029283C927
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 18:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CDC31F2247C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A09713DBB9;
	Thu, 25 Jan 2024 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AbjrdRdY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F566130E31;
	Thu, 25 Jan 2024 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201631; cv=none; b=gSAzxyw5zRerHpsxc6EDauf4K8j2dBVzGqpHBclJfvhBXr83JJCBostcUbStKBTFphvssV4eGlO0EVADoHEa/C4/2hkzmQ/DI69RI6iyAKJrIIF5vXS427cwuY6IsYH1DPTyYQWwooiJIqL74kJmLsibt6ScPWCjd2WaGmDhz8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201631; c=relaxed/simple;
	bh=jxy1iW5YBQpx2L/2XzM+MqzG0Ug1dnhtomAoOd2ZnbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TtJNx8xJkOKH1jYE4w1/63hduJ/kY2BmZl5PccxnluxbnJ5K3u8sqgWs2gTBZrxvNpc7GqjN5zTqFzmwc9vIeVasAZDPPxjW0rsWU3cx1yse4TEy8b1rzCjhoxKk4EZg5bXB4DElhbBLZSqGGnR6DA8pl4gOuh/qWJq3NDuhb7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AbjrdRdY; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706201629; x=1737737629;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=jxy1iW5YBQpx2L/2XzM+MqzG0Ug1dnhtomAoOd2ZnbI=;
  b=AbjrdRdY1WGepAZHly8a8rkM3pOAqvKTJUcO3jk8I4ZbDqXCK68r8l3y
   mf93ET0it2DnXy19iJqHwT4jda8Vpz5VZIU6+58zQwvMd2GCRY50Dpye4
   DmYnIuX0nFX+ZC/k1mPgAg5YDDgdG9wWwwzt6Pagwo1n7WJ7aKYDl6+Yq
   mCFdPMDhDWor4yDkckuP6pBy+CiQq+ooLMRQM2PshnDeD8fSqUaSfv66c
   QzLnsqtJ74DhkJ74VGbaiVaqnSFcrS9fkwFUM+pbbWma3FfIDn/Gg3nff
   fCNaGo3JtIaEHFEj+hFK12QGbh0P3pKyxFIdH8bvwsj/jzw7Aa+vBSjd2
   g==;
X-CSE-ConnectionGUID: h/9/xjg4QHOslyrku6ABYQ==
X-CSE-MsgGUID: se0jx8kXSdaHVUyLDOJOgA==
X-IronPort-AV: E=Sophos;i="6.05,216,1701100800"; 
   d="scan'208";a="8248267"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2024 00:53:48 +0800
IronPort-SDR: 52mo72Y+rGnhGos/fvRZWn5vj5yGUvF6EXI4gvOkTGXuGJZjT3mEuW9akUkqPCx+jlF5dYxAIu
 4S1XdqHbEc+A==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jan 2024 08:03:48 -0800
IronPort-SDR: vvINqP4GdCHHBUjrb+eTmiCcQWnfbMc+2pMGcRzFL6dLXp7d61N849rxXvVPTSMHLUafyk3OEY
 WA9UeNNLFunA==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Jan 2024 08:53:45 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Thu, 25 Jan 2024 08:53:27 -0800
Subject: [PATCH v2 4/5] f2fs: guard blkdev_zone_mgmt with nofs scope
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-zonefs_nofs-v2-4-2d975c8c1690@wdc.com>
References: <20240125-zonefs_nofs-v2-0-2d975c8c1690@wdc.com>
In-Reply-To: <20240125-zonefs_nofs-v2-0-2d975c8c1690@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev, 
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, 
 Chao Yu <chao@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706201608; l=1916;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=jxy1iW5YBQpx2L/2XzM+MqzG0Ug1dnhtomAoOd2ZnbI=;
 b=6us0f0y8sZaGXrk0YEnbz9rCMC7kxZhDixZl391EGOrX5/lIDzriXPbrRnxwUUYl4Zr6sOeSq
 7toptEmDVs6Bj71yz4Kq8CNaR0lPsnmNTeTOXYxfHWc5XpmvrxgA/Op
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Guard the calls to blkdev_zone_mgmt() with a memalloc_nofs scope.
This helps us getting rid of the GFP_NOFS argument to blkdev_zone_mgmt();

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/f2fs/segment.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 4c8836ded90f..0094fe491364 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1971,9 +1971,15 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
 		}
 
 		if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING))) {
+			unsigned int nofs_flags;
+			int ret;
+
 			trace_f2fs_issue_reset_zone(bdev, blkstart);
-			return blkdev_zone_mgmt(bdev, REQ_OP_ZONE_RESET,
-						sector, nr_sects, GFP_NOFS);
+			nofs_flags = memalloc_nofs_save();
+			ret = blkdev_zone_mgmt(bdev, REQ_OP_ZONE_RESET,
+						sector, nr_sects, GFP_KERNEL);
+			memalloc_nofs_restore(nofs_flags);
+			return ret;
 		}
 
 		__queue_zone_reset_cmd(sbi, bdev, blkstart, lblkstart, blklen);
@@ -4865,6 +4871,7 @@ static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
 	block_t zone_block, valid_block_cnt;
 	unsigned int log_sectors_per_block = sbi->log_blocksize - SECTOR_SHIFT;
 	int ret;
+	unsigned int nofs_flags;
 
 	if (zone->type != BLK_ZONE_TYPE_SEQWRITE_REQ)
 		return 0;
@@ -4912,8 +4919,10 @@ static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
 		    "pointer: valid block[0x%x,0x%x] cond[0x%x]",
 		    zone_segno, valid_block_cnt, zone->cond);
 
+	nofs_flags = memalloc_nofs_save();
 	ret = blkdev_zone_mgmt(fdev->bdev, REQ_OP_ZONE_FINISH,
-				zone->start, zone->len, GFP_NOFS);
+				zone->start, zone->len, GFP_KERNEL);
+	memalloc_nofs_restore(nofs_flags);
 	if (ret == -EOPNOTSUPP) {
 		ret = blkdev_issue_zeroout(fdev->bdev, zone->wp,
 					zone->len - (zone->wp - zone->start),

-- 
2.43.0


