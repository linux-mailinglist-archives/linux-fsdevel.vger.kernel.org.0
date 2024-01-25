Return-Path: <linux-fsdevel+bounces-8983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8758F83C91A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 18:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17A51B21C2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5E213D4F6;
	Thu, 25 Jan 2024 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EKxHzxeV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F02913B7BB;
	Thu, 25 Jan 2024 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201625; cv=none; b=kWB4i/aKRxQz1/ZiDEnvrioZJMbC/FRQF8MkGG3GaBbfPKZoqO8+iGIECxE1gkDu6SqGvUMflwGOqJ6xpKjXlJF3+SpDLzkey1VSU5lg7UgT7gCN6242jcBIvYuKHFfqmi/eAbem8NSC7zsfiKPX2qZIrGDl1gn2HRedjRsCBOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201625; c=relaxed/simple;
	bh=CVSDtwbfJeIFTP08Wyxu5GIZXiQgdv2rMRXO0YSre0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dQAvMXCMiKSEBTzFLhthRk/aqqRjs92HCVxe92eNPM1ZrO5mzcBCYZjTl2Hmj8jBJifjG6m/PpOBNrkb4ysRhBx6wy3/3xubkTdM71l/DBRqISByM5xeyEXhDD4I0BwYxAV76O7HTb/4lpSakdO/HeFmUw/gfpYUlgFMusgnRwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EKxHzxeV; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706201623; x=1737737623;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=CVSDtwbfJeIFTP08Wyxu5GIZXiQgdv2rMRXO0YSre0A=;
  b=EKxHzxeV9OP7sm2WII6cWssGHGeHQP7w1e9fSgLs9/vMNr31IDzkuvrZ
   4/GZ4V/aGiFUOLDWCia7ML/ww4BNnn4roS3b6cfxVPnm795ai+1WEhLRU
   C1/JkQyvmxU0EWqdgyotEJhwUmMj8AbQLl/+sCbnGQIYH/LD+m1ZaSFLs
   mQuXQ4rQMlwB5XCxqG3wBfEI0jW4zN/J4kwcB060wt6pBjwXhbpQTqJ7f
   +R8chbC4tFvz4DD++QrdP7buI5XP0WjzZY9AsA5zntcjmpwnSHruEOxo+
   UPw4svgVich+x/P3j+vabEnH/+RNvX6e4JdKAIQF5Y7gsRrrFGWuTu5B7
   w==;
X-CSE-ConnectionGUID: d5pI5UfDSvGR8uQoQ6CNZw==
X-CSE-MsgGUID: tuNJjbSRTNqaSsL51ocBHg==
X-IronPort-AV: E=Sophos;i="6.05,216,1701100800"; 
   d="scan'208";a="8248257"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2024 00:53:40 +0800
IronPort-SDR: PtFHGZmPlSke2CeAOaNzCPVGNoThLP4Joyn6/JStazN7dRQLsISrzAP+Cddw+im00H6FpgTaNH
 GFQ1JCLnWm4A==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jan 2024 08:03:40 -0800
IronPort-SDR: sBgbgkN5bVB0enbBw/iyb8cMMu+2pAh1JkthbGxPDDItWfESaHFsqFp68AyWN5LkQ+syR4acGA
 0IKcbDNJkDbA==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Jan 2024 08:53:37 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Thu, 25 Jan 2024 08:53:25 -0800
Subject: [PATCH v2 2/5] dm: dm-zoned: guard blkdev_zone_mgmt with noio
 scope
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-zonefs_nofs-v2-2-2d975c8c1690@wdc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706201608; l=1101;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=CVSDtwbfJeIFTP08Wyxu5GIZXiQgdv2rMRXO0YSre0A=;
 b=oFwFIqk+a1bu3Gme4liw+RG2cMT5QTjli7I99okyi7hJJltokvsxJSP+mr+nCDIrJWXq34TTT
 jsVdpNzfNZbAcO1z7yd2EbMw7/v2dBFV8630y+/qR9JS2+Bul5QIMOO
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Guard the calls to blkdev_zone_mgmt() with a memalloc_noio scope.
This helps us getting rid of the GFP_NOIO argument to blkdev_zone_mgmt();

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/dm-zoned-metadata.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
index fdfe30f7b697..165996cc966c 100644
--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -1655,10 +1655,13 @@ static int dmz_reset_zone(struct dmz_metadata *zmd, struct dm_zone *zone)
 
 	if (!dmz_is_empty(zone) || dmz_seq_write_err(zone)) {
 		struct dmz_dev *dev = zone->dev;
+		unsigned int noio_flag;
 
+		noio_flag = memalloc_noio_save();
 		ret = blkdev_zone_mgmt(dev->bdev, REQ_OP_ZONE_RESET,
 				       dmz_start_sect(zmd, zone),
-				       zmd->zone_nr_sectors, GFP_NOIO);
+				       zmd->zone_nr_sectors, GFP_KERNEL);
+		memalloc_noio_restore(noio_flag);
 		if (ret) {
 			dmz_dev_err(dev, "Reset zone %u failed %d",
 				    zone->id, ret);

-- 
2.43.0


