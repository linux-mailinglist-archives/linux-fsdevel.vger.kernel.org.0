Return-Path: <linux-fsdevel+bounces-9316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E14C83FF62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 08:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3E2283F03
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 07:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DFF54F83;
	Mon, 29 Jan 2024 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cIeHO5gU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D904524D9;
	Mon, 29 Jan 2024 07:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706514760; cv=none; b=E72Ni3azhwItUekcIZOC/C/cjZBDZRT9O15A5G341ombmPLkpj4ILOHyaHJKj7ltWZgxT5WlWLQKZbuFasgXOzga7uQr2q1ZaUaL1IX3ois5rNiisNY4oJZj7dwSzPvuVzWT2GSUersw7OvKs6RJ6kNoUrFo/sjU4nopcUeZirk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706514760; c=relaxed/simple;
	bh=CVSDtwbfJeIFTP08Wyxu5GIZXiQgdv2rMRXO0YSre0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zzk3xo30I+5ciFi2waMOdkcpXFFEHjVe7y1nPsEis5M/JcJFWguNNBIhm3zB6Z7dRrNgwnt72LGEN2kyxWpgDIyQ+DCVjbcVlAbcPESBCA1WCyPlhLj8SeYLQLzyHq7ElzJE1HsjvFG4B7AhzFzQGBdTOYaBpl+Uzwekf2WW+3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cIeHO5gU; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706514758; x=1738050758;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=CVSDtwbfJeIFTP08Wyxu5GIZXiQgdv2rMRXO0YSre0A=;
  b=cIeHO5gUmaolR2+TuXNR2Mhd5H5PxDWi2eLCwyGJ+3yrEM4g57c3PjHe
   9+0G7dbkWHYF7JpLbCiN66bF740habwanWsrMqfS6AofT7FL7Vc6vuMCd
   TrwC5LQMLglVDozz5TQzKZRqkCBgezDUhbYz3K/HNZHQxW7cRXSzdYAqD
   jqeVEH3Syd93Ykizk3HPtkbWSfZUhgAyYQGYdJaLpxbeFloAU+BkD8ZH6
   opn4o/eDUAg8AlTeiagLR06AIlvDV59djlzTzGv5j5uZvhBNElTVM3LB8
   zwAqG4CFQ1c9RPUpC4iCvKreiviQuomsEiQmTtYRB04grBU3R79gQKKpf
   g==;
X-CSE-ConnectionGUID: 9qpe2AmyTP2km5RtZ7POhQ==
X-CSE-MsgGUID: tBKQWf/8QPyvmmJFnkJeJA==
X-IronPort-AV: E=Sophos;i="6.05,226,1701100800"; 
   d="scan'208";a="8194621"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2024 15:52:34 +0800
IronPort-SDR: juEHckVfd/WpwnLMuI+KpjGDG2cXOBMlRz/E1E+x+CDszvsrCDKep6bo7dVVLC0es4jxbz5adJ
 p/XsTjjm3jvw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jan 2024 22:56:49 -0800
IronPort-SDR: X23CH+3d3A3FF6NEzAAKeGeexyHJK2ijaqA78yg+E155A1PkvJ9a3HFhhD042eDEA3L5FpbOTj
 Kt5GBf8LBQfw==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Jan 2024 23:52:31 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Sun, 28 Jan 2024 23:52:17 -0800
Subject: [PATCH v3 2/5] dm: dm-zoned: guard blkdev_zone_mgmt with noio
 scope
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240128-zonefs_nofs-v3-2-ae3b7c8def61@wdc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706514743; l=1101;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=CVSDtwbfJeIFTP08Wyxu5GIZXiQgdv2rMRXO0YSre0A=;
 b=yRnVuaXdTnXKe1OQL8z+2PQD65t2opZ+cZ1QIFwSpziKiiFJonren+b9FfKdwqrq5iL08iJ5r
 oHOIOYDruwGAUlsSl5D+/sgv4o0Bwq7ylNk0fIqz52NebMmJzP0AEnu
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


