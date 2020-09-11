Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A4426675E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 19:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgIKRmP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 13:42:15 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38375 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgIKMiK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599827890; x=1631363890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=62/TEj5IsMLbAyIeTMsUle83Lmf9YQfLDgUJffHyhVA=;
  b=IF/vcM40BU3reN1H1+cAEEUa3q14CORixdlInhELobOJuZ2TtZLfGEMg
   quyb27NstMENUo3ElzrIzgO7aVT4ShAKGU40vHFJmK54y9+fCQWs1Ie7H
   6lI7MPU5v9kr+a0ZN93otbkiMSAehO8m3jJc7mc7eGvXmpCtITTrfD0hD
   EIO7hVl50g9K4/CYchQXC+/BHdbin6gCnXXerEPeZ/xJFf4N2ze/BXUti
   m+POx17tXAzwWmQ6EYzz26FS7WBHokTV4n4Tpv3CCm/D6CpIFdzlY7wcK
   e0QgKyBJk14Dug8kBBjhoxU2QUh1eqyrxMqCOb9shyNq65sxorF5Y7Dbt
   g==;
IronPort-SDR: Q17tBUeDnYXVHKRkojVuAU4Y6FXKVqURgmdZNSXpH1AerupNeeMfldvgFvdWKkOZpTz+egPrpr
 YTB6mpNOTVJozzr5VsKQt6Ssxy/6HVzB5ShEa9fP9+sgQe6N9A3um4XnBIehTOOue7IszADWwz
 ZU6u92qB8iXF7LE4ZswSyo7pZqtIMQHj3XSGKo8aOt4m5sDqnhOOWCns5OssLIrOdpOSvj0wtX
 CX4LivJXap/847ATxTBVPMOXuyL/3pOG0mPP/YvqlH9neOyDD3NbouslDEbqozYjyRooP5vTQk
 BBc=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147126011"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:33:42 +0800
IronPort-SDR: PPSP1I7BzJa2bxfsV/a6OTyW16JU3uNGktEGLIzcEFwo70q27cRCZCh7fQ0h2vT/iwdnTJL7fe
 BinxE31kcavA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:20:03 -0700
IronPort-SDR: sHX0k0zZCpbftdvE6D5vRWZ49nwKQiITq0kyzHxi4FRHSEzY6DjwWsctiP+KBShxboVZdjLYD/
 iLRkhfqkkzYQ==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:33:40 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v7 24/39] btrfs: enable zone append writing for direct IO
Date:   Fri, 11 Sep 2020 21:32:44 +0900
Message-Id: <20200911123259.3782926-25-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit enables zone append writing as same as in buffered write.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7fe28a77f9b8..422940d7bb4b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7351,6 +7351,11 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	u64 len = length;
 	bool unlock_extents = false;
 
+	if (write && fs_info->max_zone_append_size) {
+		length = min_t(u64, length, fs_info->max_zone_append_size);
+		len = length;
+	}
+
 	if (!write)
 		len = min_t(u64, len, fs_info->sectorsize);
 
@@ -7692,6 +7697,8 @@ static void btrfs_end_dio_bio(struct bio *bio)
 	if (err)
 		dip->dio_bio->bi_status = err;
 
+	btrfs_record_physical_zoned(dip->inode, dip->logical_offset, bio);
+
 	bio_put(bio);
 	btrfs_dio_private_put(dip);
 }
@@ -7701,7 +7708,8 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_dio_private *dip = bio->bi_private;
-	bool write = bio_op(bio) == REQ_OP_WRITE;
+	bool write = bio_op(bio) == REQ_OP_WRITE ||
+		     bio_op(bio) == REQ_OP_ZONE_APPEND;
 	blk_status_t ret;
 
 	/* Check btrfs_submit_bio_hook() for rules about async submit. */
@@ -7846,6 +7854,12 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 		bio->bi_end_io = btrfs_end_dio_bio;
 		btrfs_io_bio(bio)->logical = file_offset;
 
+		if (write && btrfs_fs_incompat(fs_info, ZONED) &&
+		    fs_info->max_zone_append_size) {
+			bio->bi_opf &= ~REQ_OP_MASK;
+			bio->bi_opf |= REQ_OP_ZONE_APPEND;
+		}
+
 		ASSERT(submit_len >= clone_len);
 		submit_len -= clone_len;
 
-- 
2.27.0

