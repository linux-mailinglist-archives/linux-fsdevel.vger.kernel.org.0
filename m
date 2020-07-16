Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CAC2220B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 12:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgGPKh1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 06:37:27 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:15802 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgGPKh0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 06:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594895846; x=1626431846;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BGvYOWcLH2ldVjSghDjHj4cFv58uWURpxWhh4gALlj4=;
  b=FEE6u8tRzHR9xrDdbaVpKhN+JSbVRtUIpVwXw1fNXam8p+USLNShtMKP
   wnxg5RMIqyQgDXPfRtBh8Roz43q7KA3k/V8ZQ+7gRykN7WcGNk2t5tLrd
   K6DsKIdGv0CiiA4SKV3JKvzpncByJVbuHb/+V1edz0u+9W4KryVB3Ciy4
   sfh1XAephfq+Zj8mIXv6VqvG/U8jfNwlIzecR0phzhkdVTA+biSuo4zcG
   ll0UfOsLf0djaq280qEyLHEH2P1xHX5lvmTm723lk/7JIU1oblsdXT7Ia
   QV5AY8a6fjXQRG5WhJlIcIBT9530fE6aM9W6wST+nRwqDQ8LMl0wtLChm
   g==;
IronPort-SDR: eeP5ecPAXdwgckKliyYl4zdVhAuBknkrQk9+XuLfMKt+2FAy0YMxB/TG0q5UZkuKpKQbQqtEeU
 f0vE5Q7vM0US3slQwxF0u8B64V5jeubMPLnDkhAS+WJzI/WQhRLRtY7D5IvaR2blZbtzHPEO4s
 kHjXPPYtmhnP48nbdZheZX6PO+S9tHcpbo9TEIP6NV12zCS+vTO6sXk0aACzTsIWPUnYpiM/qZ
 SGe0SH19WQ8xo2enrIeAxevE3apUM2kBtgYXAhvEpIQ0otN7Z9TffxYgnpBkaaWu3Js/UQVBJN
 I1o=
X-IronPort-AV: E=Sophos;i="5.75,359,1589212800"; 
   d="scan'208";a="251864876"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2020 18:37:26 +0800
IronPort-SDR: i2mXiRIABXHhuaXWYXB+NVojwqPtS9ccbPdgqfwstIDDKhDgCFPn98mx0SgMvna9Qt9MZ/ahHU
 oNh57Bi6jE/0cKFhl+iRFpxmM5yX7+f4w=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 03:25:17 -0700
IronPort-SDR: 00/M6i+3aiIG7l12kHpqSOpoyudBPVpkIWCe2NL6B9ivFBAMRdMC5Ng96Rxb7CFboeuNlR5aHs
 uyoYK5yC11oA==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Jul 2020 03:37:27 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] zonefs: count pages after truncating the iterator
Date:   Thu, 16 Jul 2020 19:37:23 +0900
Message-Id: <20200716103723.31983-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Count pages after possible truncating the iterator to the maximum zone
append size, not before.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/zonefs/super.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 5b7ced5c643b..116bad28cd68 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -607,13 +607,14 @@ static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
 	int nr_pages;
 	ssize_t ret;
 
+	max = queue_max_zone_append_sectors(bdev_get_queue(bdev));
+	max = ALIGN_DOWN(max << SECTOR_SHIFT, inode->i_sb->s_blocksize);
+	iov_iter_truncate(from, max);
+
 	nr_pages = iov_iter_npages(from, BIO_MAX_PAGES);
 	if (!nr_pages)
 		return 0;
 
-	max = queue_max_zone_append_sectors(bdev_get_queue(bdev));
-	max = ALIGN_DOWN(max << SECTOR_SHIFT, inode->i_sb->s_blocksize);
-	iov_iter_truncate(from, max);
 
 	bio = bio_alloc_bioset(GFP_NOFS, nr_pages, &fs_bio_set);
 	if (!bio)
-- 
2.26.2

