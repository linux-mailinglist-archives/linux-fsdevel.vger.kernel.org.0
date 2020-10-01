Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F501280706
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 20:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733171AbgJASj2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 14:39:28 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24728 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733038AbgJASjC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601577542; x=1633113542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SUpU5ae8xi0dcVpozR41vTzLShl0EEP65BEoTYKUtaI=;
  b=N4yTsJZcTLxJZZimQeFrVgB+o4Mbyt4sl3rVA9SF/ofMnmJJSVvMP6bT
   8kIN0ONfmNGPl/MwT40cjgF7XuWxGzyWutaAaZOPHdj4SNOGopFxdkRVr
   f1BEb/ZJk0NMvSsJ2Mqu7ti3TZu0MSKBxPX5H2gfg1a6aUOxY6DFSnCAL
   0z6o4rB0t/88dk+zU+nf71OTsGMzJoPUgE/Vp4EvUWyZfcln7uxeuf3rl
   JaA1Cv8gjk5XoiqtgB10qCXrss1amklEYBwhjseGIxw9x+Xu18YLN5ceW
   CC9gTlmxh3BGw1ISEoUZHU0cmaF6Xw/ns07R11k9ABZNETaSx+Xfn2aIm
   w==;
IronPort-SDR: H/dA3BJXYjIE+4if2wcGA1j9xREa0ICsDJMwSP76zO2gzFPSwPz4X33hrY12zw3tc/PNVl+76L
 7TZjvBVyoo8YvupqlvNpWXbYyjsU2igsFFHPOEUEgqRzo0EBEUmvXWD7IULXuGlPhT1Gy2M0Nw
 2u17257irUkQYGg0Bd9T+rWHE5Z5aK1a7z7Ba7ZPFynOZx2mL3YjeEJXKuHGMJ642ieNMxeonY
 yfnadRypD6XVCNC/FPpx+08L5sbvWUAcNwGU5P1Uw4MdsMG+RIPM3LpBbOtenN+fSEvp/VQ+SF
 734=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; 
   d="scan'208";a="150036819"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 02:38:32 +0800
IronPort-SDR: TvYmX/LlNkHrRWeSfCz23MbQPdzlRM+2C/sil269fHOtDep5YMHPDwtdn43RVtq97HHpryF5HO
 kY9TiNp3IMMA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:24:28 -0700
IronPort-SDR: cwrxMZXafPIYIbL8x+MToL9/9O4Geb+o3b4eHB7ggPbx1goK6a+UeCYC9w5IdVXCaY77j9KfPc
 N7+ITzmnfa1w==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 11:38:31 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v8 26/41] btrfs: enable zone append writing for direct IO
Date:   Fri,  2 Oct 2020 03:36:33 +0900
Message-Id: <6f42df516fd9a7a8fc5dddbe73a048749e12ebea.1601574234.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
References: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit enables zone append writing as same as in buffered write.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b5fdc93b319f..37d85c062f3a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7422,6 +7422,11 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	       current->journal_info == BTRFS_DIO_SYNC_STUB);
 	current->journal_info = NULL;
 
+	if (write && fs_info->max_zone_append_size) {
+		length = min_t(u64, length, fs_info->max_zone_append_size);
+		len = length;
+	}
+
 	if (!write)
 		len = min_t(u64, len, fs_info->sectorsize);
 
@@ -7777,6 +7782,8 @@ static void btrfs_end_dio_bio(struct bio *bio)
 	if (err)
 		dip->dio_bio->bi_status = err;
 
+	btrfs_record_physical_zoned(dip->inode, dip->logical_offset, bio);
+
 	bio_put(bio);
 	btrfs_dio_private_put(dip);
 }
@@ -7786,7 +7793,8 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_dio_private *dip = bio->bi_private;
-	bool write = bio_op(bio) == REQ_OP_WRITE;
+	bool write = bio_op(bio) == REQ_OP_WRITE ||
+		     bio_op(bio) == REQ_OP_ZONE_APPEND;
 	blk_status_t ret;
 
 	/* Check btrfs_submit_bio_hook() for rules about async submit. */
@@ -7931,6 +7939,12 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
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

