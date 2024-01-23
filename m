Return-Path: <linux-fsdevel+bounces-8520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 843B7838A88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 10:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74B91C225C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 09:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D545C5EF;
	Tue, 23 Jan 2024 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="klyV34Le"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2265BAE1;
	Tue, 23 Jan 2024 09:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003042; cv=none; b=Msw3mbrXs7AjekOoFGLapTlF+1iTIohmZgncqgJy62Uc9EUdjSlWfiGony0QPJQjnn0GodvaUlS5IS4Oi0Mk8DUmTPK5LNmY9NoSigwLJiDKCZtixxFvBpRARgnOO1+a2vHEwRhTWhY4KHEdL1VNjfgU7BcP+BGbvYrIGWbgiHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003042; c=relaxed/simple;
	bh=/4h6qYS/eHpSlVim37uPdGcbFkvmnDTQ5JZLyrLcZnE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Bq7p31t/eidxr6Q622mS7e2KSbLszGFUwhvZVnh8kXw2SQseV6MjUgpkaS9+lmoGAmo9+eR5FPS8KRU5oHYuj8A8Acef/Qx0KEspKglQYCKq1dlw7D9i544HJUGYLW9CybdSJS7ufC9oz7OeDsUEP1YvaBYHwhpKBW2ac52CB0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=klyV34Le; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706003040; x=1737539040;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=/4h6qYS/eHpSlVim37uPdGcbFkvmnDTQ5JZLyrLcZnE=;
  b=klyV34LehoM/bKGpsEoje1bsQvWnEdkBJm3CmcnxHI+HRti6ZJ/+u1HC
   76xo81pd3t54FEBqSixPxSZsd4+ixpHRWPY1QeoerQ+TXk7dQRRE/0z/d
   BdUk5ztm8cSHoDG+j0zrVHFVdqfFia+Q+iwBTDBwaxeoUwfTOwIKxyO/a
   SnMwMXm4Q6mzQswYf2Mqjkh4M9p2UkvbwRXftOAS8HcD2XkB+qnyRJUQt
   Toij5t7e3KHfBaDAXNfVRr4TQB2+egWSu5qhj2igJI0n4whAoJLGNukGL
   9DcqMmmKYCT7f9nMS4XgxBNS3nXU0TXjgLG4HBK1YO7xiGWqIw6uz84Xp
   A==;
X-CSE-ConnectionGUID: fbbQ3aUnSa+jfjkiYUqLHg==
X-CSE-MsgGUID: 9vYZCiNdSh+ZfSVKjIc7BA==
X-IronPort-AV: E=Sophos;i="6.05,214,1701100800"; 
   d="scan'208";a="7514644"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2024 17:43:50 +0800
IronPort-SDR: TwR3OQ6czbuBwupgP2Pw5/UU9AIJprA4iK31Yg5UGdeifAB7nVUszKOeanYCR1XWjuTUkYP9y8
 XGwGimQPDegQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2024 00:53:53 -0800
IronPort-SDR: zUnRHHmVsKHmYWHqPESmgsAEmU5gU8xkWm6MN/q4pTyWM+A4c3LciGXWMEKUbx1GLBqQ7hfn4G
 QMsyEBuf/JKg==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Jan 2024 01:43:47 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/5] block: remove gfp_mask for blkdev_zone_mgmt()
Date: Tue, 23 Jan 2024 01:43:41 -0800
Message-Id: <20240123-zonefs_nofs-v1-0-cc0b0308ef25@wdc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE2Kr2UC/x3MMQqAMAxA0atIZgtpKA5eRUTUppqllQZELL27x
 fEN/xdQzsIKY1cg8y0qKTbYvoP9XOPBRnwzEJJDa9G8KXLQJaagxnvLRBsxugFacWUO8vy3aa7
 1AzrU4INdAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706003027; l=1540;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=/4h6qYS/eHpSlVim37uPdGcbFkvmnDTQ5JZLyrLcZnE=;
 b=XWApU1yRY0zet3szE9Y5YwxO0lp/MB+nH+oGhmBdyhChEBIQpYa6r7zw4rgXKerbrVnIXc2mT
 UtgASe05xPWAqN+bStf/4/hcrd6JLPpuUKW556WA7lZY9ZeLtErtKq6
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Fueled by the LSFMM discussion on removing GFP_NOFS initiated by Willy,
I've looked into the sole GFP_NOFS allocation in zonefs. As it turned out,
it is only done for zone management commands and can be removed.

After digging into more callers of blkdev_zone_mgmt() I came to the
conclusion that the gfp_mask parameter can be removed alltogether.

So this series switches all callers of blkdev_zone_mgmt() to either use
GFP_KERNEL where possible or grab a memalloc_no{fs,io} context.

The final patch in this series is getting rid of the gfp_mask parameter.

Link: https://lore.kernel.org/all/ZZcgXI46AinlcBDP@casper.infradead.org/

---
Johannes Thumshirn (5):
      zonefs: pass GFP_KERNEL to blkdev_zone_mgmt() call
      dm: dm-zoned: pass GFP_KERNEL to blkdev_zone_mgmt
      btrfs: zoned: call blkdev_zone_mgmt in nofs scope
      f2fs: guard blkdev_zone_mgmt with nofs scope
      block: remove gfp_flags from blkdev_zone_mgmt

 block/blk-zoned.c              | 19 ++++++++-----------
 drivers/md/dm-zoned-metadata.c |  2 +-
 drivers/nvme/target/zns.c      |  5 ++---
 fs/btrfs/zoned.c               | 35 +++++++++++++++++++++++++----------
 fs/f2fs/segment.c              | 15 ++++++++++++---
 fs/zonefs/super.c              |  2 +-
 include/linux/blkdev.h         |  2 +-
 7 files changed, 50 insertions(+), 30 deletions(-)
---
base-commit: 7ed2632ec7d72e926b9e8bcc9ad1bb0cd37274bf
change-id: 20240110-zonefs_nofs-dd1e22b2e046

Best regards,
-- 
Johannes Thumshirn <johannes.thumshirn@wdc.com>


