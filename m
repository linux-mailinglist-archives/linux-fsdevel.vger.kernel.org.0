Return-Path: <linux-fsdevel+bounces-8982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E8683C913
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 18:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 792C01F28114
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB4D13BEA2;
	Thu, 25 Jan 2024 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="H9CroMtd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB3C130E30;
	Thu, 25 Jan 2024 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201623; cv=none; b=pwYjLG8p0buSGxcR0Geho0lhIdc48+DMdDrKgX9TycyBgrsOnMQSTZv/elqt6k1jOQ+Cg0RpHkxeg2Piu8M/GMaYsZKV+orlggLUN0HJSV9ZOrgUH9LPkUJLoOEOW6r5ud0MtY7W/rLSSg1mpIMkpovGb2aaIw0TrBhKgr0fbCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201623; c=relaxed/simple;
	bh=eGx4McY1FmrYKhrAp3TTxFkfkbSfbNbdZDzzsYbn3SA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sOGIIbKJqbh+v5BX+WQY7V5WWITAXfBvaDSCtiUdpBq2xY+0tgEdkCOqq/7ILXd7sntJ4HMTgckoCvEfeQqOQdHlAPZ5BCuUuazCfG/pOp7xte8cmn/ldwt4p5qXxqS8yq0FgI3DvnxQhvsBq/b0CGHHnBeUaCSOvbK2tvE/yfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=H9CroMtd; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706201621; x=1737737621;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=eGx4McY1FmrYKhrAp3TTxFkfkbSfbNbdZDzzsYbn3SA=;
  b=H9CroMtdfZeJvwoDp8vcbuwbgWvfACbwwCOwdsD7vadSy/+Qwl3PCV7u
   Zo79Ky/YmZDRMPQDyiNjo4gYsBzOCIC9Hhv1Jo15KUk95WkC5ZgD8qQMU
   QvIPMHCfQ1blQF0hJcddApdA93kzkwibl7/CJ0sulT2kEdCqo9iEY0SET
   TKLcKfNgwKaw5CQOlCnxpLii3BWL7+wK4ZXkbYvIa8kJ5P2UIgeyi0huD
   bXSbfnYcmBDaNmSFN+tpEjCi3+NpDu9ASMX4S1ugweoBf1wbyMEC9Pg1T
   Bz3zRrZForezOqB0FnBrIZJzbdgt3iooNvt7T0C6eq6EcrjQ+d/sgDgcA
   A==;
X-CSE-ConnectionGUID: nJChHqdATh+LSHNp4W4JeQ==
X-CSE-MsgGUID: ElLfphADREeTcCKR0BqMtQ==
X-IronPort-AV: E=Sophos;i="6.05,216,1701100800"; 
   d="scan'208";a="8248250"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2024 00:53:36 +0800
IronPort-SDR: pqUyTtPg87liih5vCOOIUt70z7W5lPFxCQMdE9sI2Wxfm9Lw5ybM0boj3zIK/4i54HdEgLvPpf
 FjAgH3XwZr6g==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jan 2024 08:03:36 -0800
IronPort-SDR: VOx0UIr5lbldPsjxQBhoPSsQoOEZNWGs3Yn004iQ+BbMXVrE9gDtrUz+juD/7EPs5IyZ7d6MAQ
 oXv5yVO5EAbg==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Jan 2024 08:53:33 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Thu, 25 Jan 2024 08:53:24 -0800
Subject: [PATCH v2 1/5] zonefs: pass GFP_KERNEL to blkdev_zone_mgmt() call
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-zonefs_nofs-v2-1-2d975c8c1690@wdc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706201608; l=1041;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=eGx4McY1FmrYKhrAp3TTxFkfkbSfbNbdZDzzsYbn3SA=;
 b=7i7rSG5FOL3Y+GFA5rvmzOGA1LPZcNa6uQEcp9OZuAhx8o+EuzcMQlp/v7AQwfxAOFFlfDgdz
 pJC/jmeDno3BoWXgTUVMLTNlb/W+P6XXYXlpj2p8o3WXeCGKXi91zBB
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Pass GFP_KERNEL instead of GFP_NOFS to the blkdev_zone_mgmt() call in
zonefs_zone_mgmt().

As as zonefs_zone_mgmt() and zonefs_inode_zone_mgmt() are never called
from a place that can recurse back into the filesystem on memory reclaim,
it is save to call blkdev_zone_mgmt() with GFP_KERNEL.

Link: https://lore.kernel.org/all/ZZcgXI46AinlcBDP@casper.infradead.org/
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


