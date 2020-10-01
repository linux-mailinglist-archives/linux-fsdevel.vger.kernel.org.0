Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717F12806E7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 20:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733094AbgJASjD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 14:39:03 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24779 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733057AbgJASjB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601577541; x=1633113541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yI/KJxjAm8LeiXiMXlzP2TfXUDSKNUEh2w5iz0S3Gls=;
  b=oX0heP7v2+PReOi3p2psxg4u+2pCLIvpzwJnJOyjcb8H65HtHgciRqV+
   wZj/64UOU7BEi2kNBV+C9LpukGWvprCstl5OW0Vx+8StZ46O3rhFqcG+d
   aIj4uXa/qbk0uHZJNEIQowGv0W4WrAfkSf+A+2g5ngovWkUb5O1+mPVcH
   2gPUrT/9IzZBKGWObvqLigrBDoYi6Wf0iOBqnRitAg7R9q3MlUNdpb4Xq
   h/7grm3sSqaV6ggo+ed1omoAl/rCQHxjMp742K7KzoWvS4iBUlYcKQMXt
   uSpxSIFveK7HLdbvgJf4S4FD/lmkn60y1NtcNJoNBK2MUVXAvSS8K6S/9
   w==;
IronPort-SDR: ArGNP25jA6J2ZFr5Z070WqpHjIqbp9MAJaFtfyPUuOd9EDX8TjolPXZOEW6G4Iotq6nd+Dptfc
 E4zLP4IX2HSkyp5f+Wh+FLXgnkGvUgv/R4/SLgrxz0JeVSRbV24CwT3gHo/8MllYp4/LoAj0g5
 dMmyq6RQbVy0YdeRi63c8sQw3Tl7SZVtnmGnoA4JGM2BJoAt9kFCtWBE2gaYwXvpuUURVQxSu8
 FfdmXD3ISt9hE0fMWBwW7swGmslyfgX7KIGRn/yYMydafVt4akaC88rEHLaJFsz4XOsztipWTe
 llU=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; 
   d="scan'208";a="150036817"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 02:38:30 +0800
IronPort-SDR: 88v3Oipava5ZdtcbH6Ob05O2Ge+Y79PP3huOW1s5bocWCY3riH8LxVRoNdd+2ORLPs3LSb5z60
 69/41yEj/RUg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:24:26 -0700
IronPort-SDR: Yi+gMHXjJNq0ZQjOo14n2BGU19IXkQpa2Jsw1ED9OESpitmu0V14bHW9QvfKzlilyAef3shTPy
 ZBuZJxeVU5aQ==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 11:38:29 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v8 24/41] btrfs: extend btrfs_rmap_block for specifying a device
Date:   Fri,  2 Oct 2020 03:36:31 +0900
Message-Id: <8bc03463cdb421fa62230aa4d8de5f93b5d502e2.1601574234.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
References: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 2241d04ad4aa..d39fa80d3d90 100644
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

