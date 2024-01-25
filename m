Return-Path: <linux-fsdevel+bounces-8981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 519D083C90F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 18:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759BD1C265DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640F613B7BD;
	Thu, 25 Jan 2024 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="H8RO9z9M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6895A1353F5;
	Thu, 25 Jan 2024 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201622; cv=none; b=nYkm4osvq9h/glYwJ9a5XJ8AxCyJR5IYITTgkU+2XBxk9zqwcGSXoldWHkn0ZePO0Bl1R+gS9h8L+i7oODA/G4G8/ojvgKuiT3fJMED+bt/pYcQUgrDmyYLlIizFQnXVEZvKBqipdb+CqftT8WvbYALZ5m+75UnNZfay3wnGZlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201622; c=relaxed/simple;
	bh=0N4F/gjOaEHcA1EmZZhcmvU+dQFlqf6CupFhM16+QGk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ezU1zmJXENWuguN4aOCj0mi/kzB6AuIdlnm064NiymksMDqgexKHO5rPG3zbv7/w2w/dS7tdPpaMQ6ZgCsTvFnqyVrzcLm0PyVg1KjYb+TY9sbaPcoQov1KO+BmMZxUJnzgp+oe156WWGaY1ZJx3CoH4YvCSZatyWFrOpE+flnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=H8RO9z9M; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706201620; x=1737737620;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=0N4F/gjOaEHcA1EmZZhcmvU+dQFlqf6CupFhM16+QGk=;
  b=H8RO9z9M4JzEsXfJ/iJwt16qt/EJEEE+a9KzFnTwCWXi0scmbnea/yXb
   BvMZJnltkLVgWUpE923Jl5L0Qo57PBmRplh4ZTg/Gb5abidUp62TTqjB7
   c/Q2nTwnwKzrxINkMtMErzucyJyAubobopAXhzVy7zXA2Fn1LXtgcBC3y
   Go6pAOdAs0HD86N6ytNhJ8zR+IkRdLUN9RUEeMMDsczWKM0N/7vv+vGW6
   3bbwtZK17GxgPpURCpOeLaBF7coERF1lhv0yZN7OoP0IY+uaKUge70M5V
   ek2M9nZjC0snW/R09yr0jSh84L8MiezpnURfbXsUf3k0mtyyG0G/vQF0y
   A==;
X-CSE-ConnectionGUID: SLtgWUqwSFiSDx8PwaGf4Q==
X-CSE-MsgGUID: S5aX1V9mQVOclfDjxcofgQ==
X-IronPort-AV: E=Sophos;i="6.05,216,1701100800"; 
   d="scan'208";a="8248247"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2024 00:53:32 +0800
IronPort-SDR: UlaRYi/mm3wurEb8x0tmGlxeSFNSbtEMOUa0qrcayk73aEt8h8L7aiSgs2m+pi0J8+W8nyak/g
 vs0Juk/DByzg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jan 2024 08:03:32 -0800
IronPort-SDR: OE+tRkmMpFkhDRa1z/PeEZo8HAAoGZY5dfaVEn8/s2a64gELw2HyRSw+9hYcenKw2PYuCiSi5y
 qsHOshAr8N7g==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Jan 2024 08:53:29 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 0/5] block: remove gfp_mask for blkdev_zone_mgmt()
Date: Thu, 25 Jan 2024 08:53:23 -0800
Message-Id: <20240125-zonefs_nofs-v2-0-2d975c8c1690@wdc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAOSsmUC/1XMywrCMBCF4VcpszYymVYRV76HFLHJxM7CRDISL
 6XvbixuXP4HzjeBchZW2DcTZC6ikmINWjXgxnO8sBFfGwipQ2vRvFPkoKeYghrvLRMNxNhtoT5
 umYM8F+3Y1x5F7ym/FrzY7/pzqP1zijVonMMBW9xxoM3h4d3apSv08zx/AOnqE66kAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706201608; l=1733;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=0N4F/gjOaEHcA1EmZZhcmvU+dQFlqf6CupFhM16+QGk=;
 b=UDiRHl7vyONFeE/+Uc9h4ZkfV2sLDGr/bQXidpKeyTTKnEZ1boUAGnz1/g8SHkp2NIP1u8WfY
 k+ntypLEWF8Dk7T6KptUtV/AFpEKDBwUlfE02SJfrjkjKtMj15vuipc
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
Changes in v2:
- guard blkdev_zone_mgmt in dm-zoned-metadata.c with memalloc_noio context
- Link to v1: https://lore.kernel.org/r/20240123-zonefs_nofs-v1-0-cc0b0308ef25@wdc.com

---
Johannes Thumshirn (5):
      zonefs: pass GFP_KERNEL to blkdev_zone_mgmt() call
      dm: dm-zoned: guard blkdev_zone_mgmt with noio scope
      btrfs: zoned: call blkdev_zone_mgmt in nofs scope
      f2fs: guard blkdev_zone_mgmt with nofs scope
      block: remove gfp_flags from blkdev_zone_mgmt

 block/blk-zoned.c              | 19 ++++++++-----------
 drivers/md/dm-zoned-metadata.c |  5 ++++-
 drivers/nvme/target/zns.c      |  5 ++---
 fs/btrfs/zoned.c               | 35 +++++++++++++++++++++++++----------
 fs/f2fs/segment.c              | 15 ++++++++++++---
 fs/zonefs/super.c              |  2 +-
 include/linux/blkdev.h         |  2 +-
 7 files changed, 53 insertions(+), 30 deletions(-)
---
base-commit: 615d300648869c774bd1fe54b4627bb0c20faed4
change-id: 20240110-zonefs_nofs-dd1e22b2e046

Best regards,
-- 
Johannes Thumshirn <johannes.thumshirn@wdc.com>


