Return-Path: <linux-fsdevel+bounces-9318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D230A83FF6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 08:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72D2D1F23725
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 07:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F286C55E59;
	Mon, 29 Jan 2024 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LLs5ki5P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A2F54FAC;
	Mon, 29 Jan 2024 07:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706514763; cv=none; b=fD7trqdtpew42KDbOfhSXy5dY45IniPjdjnz+xyLylhWJAudLVaZmhqqU5ZZqR3HsMjk6WfbQSBaWxFohXACrHPw1hYIqkAw8HR0LRsvKiVD7o7yRiKniAMmra+h7mFQXwj+GKbIhFB04wIGccNSQCWZiOg3LJsAZslFRlJazpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706514763; c=relaxed/simple;
	bh=jxy1iW5YBQpx2L/2XzM+MqzG0Ug1dnhtomAoOd2ZnbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MnOl4yW4ax2b1vfi56BWuk+T1Qsw6M+Wqz+r6yRKuKTQrBXE2w77sPejneIHMEbroxVKgTDLNbLBTubPWp9+FzTtSz9aMbn3D27S3kad0s8mO36pqfLSN9Hg44IQ4PIWm+ZPhMaw6U5adbMC8REWJFwaK9EMVb8J+iWv53gVsTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LLs5ki5P; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706514761; x=1738050761;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=jxy1iW5YBQpx2L/2XzM+MqzG0Ug1dnhtomAoOd2ZnbI=;
  b=LLs5ki5P7p4tIlwCHZ8IokUa+QAnY53bYyj9Tsstn4no5tEeiXgRzp6x
   JHypCUm2oAc/aArXycLz/yElfTI5K5HubfOk0Y+shHBC0hYFHjJv4eOZm
   c2+zzZLlx45rTCDPeRhpQ1qA8t8a2uRl6Gyyv0ZM92vyCD1AqcW3GGFI+
   XRSBPACrRX4EaoA6ugWJinmBMnFJF9nBko3zpNrFIW6KW5dZ6/XZttOgH
   06y7n0Jushiw1JCNWEEVpBsJucJ6zLGy6qg+2JWAwPf/fPbpTqn9bEETp
   sSUkmlNfhjSslHVnwyeJTMcwe8TSVbHZZ7a1k44j/15N5yZ6RV/6zOsz9
   w==;
X-CSE-ConnectionGUID: HFhZjRb7QRWOFmR/LvmBTw==
X-CSE-MsgGUID: urPmD0xASTevSJa8jmrupA==
X-IronPort-AV: E=Sophos;i="6.05,226,1701100800"; 
   d="scan'208";a="8194638"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2024 15:52:41 +0800
IronPort-SDR: KTQ3lJrMIj/4DNsUTqm/EbPG5L5/tVZ89YUKuXekVCMw9khOpa1iQ9V2p1TrsdSy5DaZi1eH5/
 1Nmndr/UYi1g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jan 2024 22:56:56 -0800
IronPort-SDR: a6fqmhL2Ifron5h/FtoAVEOrd9znA+k+ph2NG7O67agAlvm0Y7V7iCtpbCu6M/MJk4AD1wdZc5
 lY5ZpgbYrY7w==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Jan 2024 23:52:38 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Sun, 28 Jan 2024 23:52:19 -0800
Subject: [PATCH v3 4/5] f2fs: guard blkdev_zone_mgmt with nofs scope
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240128-zonefs_nofs-v3-4-ae3b7c8def61@wdc.com>
References: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
In-Reply-To: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706514743; l=1916;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=jxy1iW5YBQpx2L/2XzM+MqzG0Ug1dnhtomAoOd2ZnbI=;
 b=WNhlN/WUiVsCIwNsWqvPqEUFWWkuiJG89IzBO1pf2asviyjGf9vbFRjhczVfFzZ0feh+zpKXW
 lyy5ndmQY+iB2Brlr6oHL1WocSEl93rc1te3zHZBE7MogUUIPxesD7d
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


