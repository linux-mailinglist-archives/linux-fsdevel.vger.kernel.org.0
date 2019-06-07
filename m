Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE64538B23
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 15:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbfFGNLq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 09:11:46 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53172 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729299AbfFGNLn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559913103; x=1591449103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3H1gt6qDbJK5L6WeE3cmLouxI5kw9amQgf6PfEfBzzA=;
  b=QcCBV67ouuY2x4AgZlim1TlaMQuqdgmdauxtG3nDWDgtFf4j2Uy1jsNC
   qSUcvolFI/TePTStSz++3z0rAwZOgkQZtxqG45MyVusVjLlwG/eebkfw0
   5vt6/0LWwyRdO92x3bf2VEDEeY5howW6jMCq6gzy0BYHP5JlOScy3MzEv
   X1WgZ8MOJbnkrhN7whQQYVPa6yXCNY0veuhXsHLg2j3xQaq1t1Z/nBTxs
   lok0sjAKSIHhBPZcTnT4nupL/VnpP87EzaXpPg8KezymFEwHphqNXarfk
   GBtI0a1KwARC4otq5Bm1W+DzX60iMBnaxNjVLfAoBrqZGX/NkSp4hHg4s
   A==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="110027822"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 21:11:43 +0800
IronPort-SDR: Y8tkiP48KrQxcmcbQHvY78pQG4VvLWFNRg1qw6o7Zm47+8ojon/l3Y5fXIBkEIO9PZGUxB1mmI
 oHUvnbIOZ9i4xORGrZ7XMP+jCtwtvC/2VjhyU0JQLNJ1RCRMgVYtRJ2+uRUH+0rvCP+Hq0V6FA
 vKXF2rSIwgoMbf44ui0qyVvff2g5V4p7KT5ryAvz7yOepXPJgzKBh009vj8/vfq0RfVqJTztVe
 iIBKYhHSIs+IPmTqxiyyAP1A8SjF1wT1suk9IaJ+ChJ2PljrXYx1Bf/bWtMAQXAwPpWE992SMw
 5U32klJwrHCwuqUVTERit2Sx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 05:48:59 -0700
IronPort-SDR: fkSvxhUQTL8482s8hxWPSBdBJN+Y/AGyg2D29sTHeMWlBI9W8owNFJL1UlI7L86o8Op3gEUotR
 XiYXVAzJ2LvaAXAARtrwmGFKW5Kd5Ye7b/pYwvUwV7UEBaeLM87dw+svFWATf/IZNlWSNMtUy2
 0vARqdFnHRK6PtP3lGbN9BpIQqeCwYHn3Nh6CucMNw9UUt/hvMwyQH7cbqwZOEL4u8NrkeuU0j
 aATi5zIP32XQeUDAf1GiSr2Jt0HtObLiCnnqQWoLGPpQgHvxyooK7i4XSB4HwuisNNllTmDIuM
 KW0=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 06:11:41 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 13/19] btrfs: avoid sync IO prioritization on checksum in HMZONED mode
Date:   Fri,  7 Jun 2019 22:10:19 +0900
Message-Id: <20190607131025.31996-14-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607131025.31996-1-naohiro.aota@wdc.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Btrfs prioritize sync I/Os to be handled by async checksum worker earlier.
As a result, checksumming sync I/Os to larger logical extent address can
finish faster than checksumming non-sync I/Os to smaller logical extent
address.

Since we have upper limit of number of checksum worker, it is possible that
sync I/Os to wait forever for non-starting checksum of I/Os for smaller
address.

This situation can be reproduced by e.g. fstests btrfs/073.

To avoid such disordering, disable sync IO prioritization for now. Note
that sync I/Os anyway must wait for I/Os to smaller address to finish. So,
actually prioritization have no benefit in HMZONED mode.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 56a416902ce7..6651986da470 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -838,7 +838,7 @@ blk_status_t btrfs_wq_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 
 	async->status = 0;
 
-	if (op_is_sync(bio->bi_opf))
+	if (op_is_sync(bio->bi_opf) && !btrfs_fs_incompat(fs_info, HMZONED))
 		btrfs_set_work_high_priority(&async->work);
 
 	btrfs_queue_work(fs_info->workers, &async->work);
-- 
2.21.0

