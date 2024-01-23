Return-Path: <linux-fsdevel+bounces-8522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82ADE838A94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 10:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C101287DED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 09:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5FC5C91A;
	Tue, 23 Jan 2024 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AhPqJ9ds"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249DD5C5FB;
	Tue, 23 Jan 2024 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003044; cv=none; b=buqQ07x7ssABAQCFttrUoocP9ocwXCDmybmk5GgNsjq+kIoeHiptu/hSML7cXrm8iT3qdoBOM77kwxssSku8q/ZaFaXzEid7yySgr9J9RbDKSXNLBoWVnRHEGnghABW9TRNN44gnuCavyDFvFkvKWLF2PY5kpFSQyJ8nzxFl4Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003044; c=relaxed/simple;
	bh=aNukikOqhJIFNWqZ0ODBJWyAugGq+LPMMd8TTS5AKQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QDlQyw+FLP0TDmt/VQ6WdrIIzf03CxMTYLfTo8ZS9eeH7AwqwwQXuEwnVgc+jmfF8dsHZdS7BWVp8HuyikN/v1sbNhKNT/VOdgJ4YwAYZ6UYQfH8J+/kHYfpFdDQwE2Jq5YP3VmSCXIYf603PaH1QJOSG6KDVNzj11ZbIQpD80Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AhPqJ9ds; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706003043; x=1737539043;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=aNukikOqhJIFNWqZ0ODBJWyAugGq+LPMMd8TTS5AKQ4=;
  b=AhPqJ9ds8m6BG21acx/H75tbnuvqT/Qa3uMBK2+kYOfu7FlQkPzybcEF
   yJnUmhMOMiUtGDpF4TSqwU1uhHWspcl3kmLIYUTjMzVkLWSkUFxBR5Row
   SgJT6BvPsHVLFlDB7T94Uf5x0eXG/J8GOxe3kZ09nUqnE9dcvUMEoVCjn
   CPLZpdmVN+kBQ/t7nrb1+zstvC2c9k8v3WJbJf9DTMLyvTC7Y22BMDLDc
   NFBhC/+tx5+RYYg9NnsjoiYyS7k/FAYSBTKI9VtOBzApVl2HvAkdf8LDQ
   R2KPthGebB/BdD1gKlUWsz3B2MhWnFt6cOLVfTt8fEpzf65XwuHW/9ach
   w==;
X-CSE-ConnectionGUID: KNF/eWqqTuSD/fIF0lBFKQ==
X-CSE-MsgGUID: YtLdZ5llSzyzHq2I2uCvRw==
X-IronPort-AV: E=Sophos;i="6.05,214,1701100800"; 
   d="scan'208";a="7514656"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2024 17:43:58 +0800
IronPort-SDR: Spj8xNqUKqypWYLaeNqVXaVV/wkQ/edLp1GOZveakoHp/xfFFhUh7GzHGrzHlIqRzOfR+tiBth
 eeFO3gA2+v/A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2024 00:54:01 -0800
IronPort-SDR: dAsmsPa7PoEjEqCMQJaraanxOd8c/fk8dACLylRy5NqXD//OMj6y9vGDZHd8BuQxOm/a02BIsW
 R+tMuSbewV1Q==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Jan 2024 01:43:54 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Tue, 23 Jan 2024 01:43:43 -0800
Subject: [PATCH 2/5] dm: dm-zoned: pass GFP_KERNEL to blkdev_zone_mgmt
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-zonefs_nofs-v1-2-cc0b0308ef25@wdc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706003027; l=991;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=aNukikOqhJIFNWqZ0ODBJWyAugGq+LPMMd8TTS5AKQ4=;
 b=ikAnavOye/kaxQOEWNUwKqvdUxWGtXZzJ7FWZYYfiyPrwIlpkg/V/fzRFKDthgXe8Ohpt6KhU
 /FHlNMKNb/eDriIYAew0yBQo7R6HpuBpWUzFGRY/CanTb/8FmZgdOJV
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

The call to blkdev_zone_mgmt() in dm-zoned is only used to perform a
ZONE_RESET operation when freeing a zone.

This is not done in the IO path, so we can use GFP_KERNEL here, as it will
never recurse back into the driver on reclaim.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/dm-zoned-metadata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
index fdfe30f7b697..a39734f0cb7d 100644
--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -1658,7 +1658,7 @@ static int dmz_reset_zone(struct dmz_metadata *zmd, struct dm_zone *zone)
 
 		ret = blkdev_zone_mgmt(dev->bdev, REQ_OP_ZONE_RESET,
 				       dmz_start_sect(zmd, zone),
-				       zmd->zone_nr_sectors, GFP_NOIO);
+				       zmd->zone_nr_sectors, GFP_KERNEL);
 		if (ret) {
 			dmz_dev_err(dev, "Reset zone %u failed %d",
 				    zone->id, ret);

-- 
2.43.0


