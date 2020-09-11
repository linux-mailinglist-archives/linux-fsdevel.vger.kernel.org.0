Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD81026676C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 19:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgIKRmi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 13:42:38 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38428 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgIKMhM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599827831; x=1631363831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EhqTsQY3IK2cQ7n7/gAdtr1dRvNODqPQppBEQS8Qx6s=;
  b=V23/Pfa+hcuRGQrDjIuxtAikW5/ueg73FvkZ4CsqJibYAFs1G5vNIuP5
   KO3ao++vlZQzwY+Mb8Qc1isX6qP778E9pfj5cIrwOEpAAFCaulgbHs6lS
   yaXw4Y2ZgRXJYtaognq8W8KsV9qjdcvp3oe45T3lPJTJTSFpdU3TgtOft
   pD4fftcGTDX+Q3Gwf9qRw+63PoxdxEeBUhi9m26FChBulx6tPkrjPimNE
   qzTTo/tov1vhuRWo92pHhyWWOEhKxY95qoTlly4AnIFyxhSX8hOTFedrx
   jcauOHdemoK00MlWWWNYLSAIMpJIMJ8mAjHTY9XVCFR5pUzhr5g6+RR+f
   w==;
IronPort-SDR: P2X6Vu8lsSJCFzUZ3Ot/eoZI08ByMkmf6dN2AWONFv+u9dpnvNPVCHym1h5LPSrLUqk7y3jkJE
 qagFmUnYNIDlxp6TO74zHNJ9xk4hyu1DgBC34uhqTYFKOF6KXXVxaYgZxRNab9dsX+J5Gd2XRg
 QxibF8ad0UX1Dhy0eBEJR/9bmAUg/E0mT2c2XxxDQhogo+PcXpRXJyNqTmfpuR/pQBaOR5Lq1Z
 e0Vi4efz84FJ9D7VVGgIJCnseS48FN/4lZ9ODZNqIZ+qrwn8OVsPFxiTTa4ssCe+G9Q6ZTwQMk
 gpg=
X-IronPort-AV: E=Sophos;i="5.76,415,1592841600"; 
   d="scan'208";a="147126004"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 20:33:38 +0800
IronPort-SDR: Gzij4V1Lvdd17il0rcWjCDCx0QbyrEwmrf9S7TThqWHvxKHZvzHr2VHEca1uUTquGgx/gxB7In
 djy6jNROBYsQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 05:19:59 -0700
IronPort-SDR: UWTDcaBuKINMEV3IWLuD384ylUM67TBagnMGU1rcpGxhQHfXwoGyxmz3AnjshlzR4RPLnBT50g
 TT0G99ULTFiA==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 05:33:36 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v7 21/39] btrfs: extend btrfs_rmap_block for specifying a device
Date:   Fri, 11 Sep 2020 21:32:41 +0900
Message-Id: <20200911123259.3782926-22-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200911123259.3782926-1-naohiro.aota@wdc.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

btrfs_rmap_block currently reverse-map the physical address on all devices
to logical addresses. This commit extends the function to match to a
specified device. You can still query all devices by specifying NULL as a
device.

This commit also exporet the function for later use.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c | 23 ++++++++++++++++++-----
 fs/btrfs/block-group.h |  3 +++
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index fbc22f0a6744..be5394c8ec3a 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1655,9 +1655,9 @@ static void set_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
  * Used primarily to exclude those portions of a block group that contain super
  * block copies.
  */
-EXPORT_FOR_TESTS
-int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
-		     u64 physical, u64 **logical, int *naddrs, int *stripe_len)
+int __btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
+		       struct block_device *bdev, u64 physical, u64 **logical,
+		       int *naddrs, int *stripe_len)
 {
 	struct extent_map *em;
 	struct map_lookup *map;
@@ -1675,6 +1675,7 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 	map = em->map_lookup;
 	data_stripe_length = em->orig_block_len;
 	io_stripe_size = map->stripe_len;
+	chunk_start = em->start;
 
 	/* For RAID5/6 adjust to a full IO stripe length */
 	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
@@ -1689,14 +1690,18 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 	for (i = 0; i < map->num_stripes; i++) {
 		bool already_inserted = false;
 		u64 stripe_nr;
+		u64 offset;
 		int j;
 
 		if (!in_range(physical, map->stripes[i].physical,
 			      data_stripe_length))
 			continue;
 
+		if (bdev && map->stripes[i].dev->bdev != bdev)
+			continue;
+
 		stripe_nr = physical - map->stripes[i].physical;
-		stripe_nr = div64_u64(stripe_nr, map->stripe_len);
+		stripe_nr = div64_u64_rem(stripe_nr, map->stripe_len, &offset);
 
 		if (map->type & BTRFS_BLOCK_GROUP_RAID10) {
 			stripe_nr = stripe_nr * map->num_stripes + i;
@@ -1710,7 +1715,7 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 		 * instead of map->stripe_len
 		 */
 
-		bytenr = chunk_start + stripe_nr * io_stripe_size;
+		bytenr = chunk_start + stripe_nr * io_stripe_size + offset;
 
 		/* Ensure we don't add duplicate addresses */
 		for (j = 0; j < nr; j++) {
@@ -1732,6 +1737,14 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 	return ret;
 }
 
+EXPORT_FOR_TESTS
+int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
+		     u64 physical, u64 **logical, int *naddrs, int *stripe_len)
+{
+	return __btrfs_rmap_block(fs_info, chunk_start, NULL, physical, logical,
+				  naddrs, stripe_len);
+}
+
 static int exclude_super_stripes(struct btrfs_block_group *cache)
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 5be47f4bfea7..401e9bcefaec 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -275,6 +275,9 @@ void check_system_chunk(struct btrfs_trans_handle *trans, const u64 type);
 u64 btrfs_get_alloc_profile(struct btrfs_fs_info *fs_info, u64 orig_flags);
 void btrfs_put_block_group_cache(struct btrfs_fs_info *info);
 int btrfs_free_block_groups(struct btrfs_fs_info *info);
+int __btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
+		       struct block_device *bdev, u64 physical, u64 **logical,
+		       int *naddrs, int *stripe_len);
 
 static inline u64 btrfs_data_alloc_profile(struct btrfs_fs_info *fs_info)
 {
-- 
2.27.0

