Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 655DA38B35
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 15:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbfFGNLg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 09:11:36 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53172 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729202AbfFGNLc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559913092; x=1591449092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3bAmdgIxyty7Z14az/12nbHorxCPMZonbxqA68tGk5c=;
  b=Nli57SDBAOxmImS3eWAfyXQHH2rSMpLykA2yF0NpCF5WnC2yxi4fUbHX
   kc03VXV5hBX1KpJyHOYdP2FSaC2A3t9bAoyln8pNUDjnANZcsady/Fwpg
   L2sXn3aFQl8A9lkmFd4mtF52WwgvXHAUyyo/qz6xBkNT6TnbcxWx0rYpa
   CRglnxDWW1dyVeHfHmBGvuNkmPVlU34+9T+pbsAluNoid360rLXZAU/qM
   UWtwjZ0UvD2t4bseQ2X54+K1LWF1/HHC80jkuL07KVYap1pRmeXgmxj1P
   +CLTtPTDmyNQVosf0yF0qFRVlhfWytwcaiQYLMqsAcVCRA66gOfrXRG9G
   w==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="110027808"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 21:11:32 +0800
IronPort-SDR: CCqCKZuRz33+0hF/Fif4eTafdXCw53t/vEnu8l+lsei+Ws7h4klDz89W7W3UnK8/3bktc37P0n
 oeUyENIZsJj9Z76jCHc31bsS3SI8PBQ9DljEHen2k4jqmud+zq0YLXryPSKVvvEV33+qh9WuJ2
 B6aLFhEsDnZqCvin1rtSXOTJbIgSWt5eMV/5E7ocB8HKc30VTa+6MsarDdj9bMK8SSPwAJsPnQ
 cTQpzSL5/NdU3ImxdEH51R8PA+f4gT5alMZVF1U4fvC/zXf43mfHfVOg8ojRbU9YV7mopmUBVQ
 DceQaC2vgsKi2RZIhY4t8k1c
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 05:48:49 -0700
IronPort-SDR: LERPIoMDAu8EulzSRTx1WTxMy0zUcYeAl54vVYEBP3Slghj8Dvvt864i3oygsiyTO5XtUrPWnv
 6E4BmyMBG9F39N8DUsb50gM1pCslo42THAkGwCra6FgvcDT+/12o/wXYK+TlVp7UmPLWyXtrU2
 837GKd30eqKoPR9wLdR+IXVUr5PTDvvaF0LTeLP4kZd14kDxPtxf0Y4+Mn3Y496YtBqPmtjMej
 /WZDr6Om6YmQxx5bHmUOg5jq2athotKO1RWJ7epc/5qTJz1e0ZESdFCpf18Aex2I8/UIYzIqR1
 3Js=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 06:11:30 -0700
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
Subject: [PATCH 09/19] btrfs: limit super block locations in HMZONED mode
Date:   Fri,  7 Jun 2019 22:10:15 +0900
Message-Id: <20190607131025.31996-10-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607131025.31996-1-naohiro.aota@wdc.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When in HMZONED mode, make sure that device super blocks are located in
randomly writable zones of zoned block devices. That is, do not write super
blocks in sequential write required zones of host-managed zoned block
devices as update would not be possible.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c     | 11 +++++++++++
 fs/btrfs/disk-io.h     |  1 +
 fs/btrfs/extent-tree.c |  4 ++++
 fs/btrfs/scrub.c       |  2 ++
 4 files changed, 18 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7c1404c76768..ddbb02906042 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3466,6 +3466,13 @@ struct buffer_head *btrfs_read_dev_super(struct block_device *bdev)
 	return latest;
 }
 
+int btrfs_check_super_location(struct btrfs_device *device, u64 pos)
+{
+	/* any address is good on a regular (zone_size == 0) device */
+	/* non-SEQUENTIAL WRITE REQUIRED zones are capable on a zoned device */
+	return device->zone_size == 0 || !btrfs_dev_is_sequential(device, pos);
+}
+
 /*
  * Write superblock @sb to the @device. Do not wait for completion, all the
  * buffer heads we write are pinned.
@@ -3495,6 +3502,8 @@ static int write_dev_supers(struct btrfs_device *device,
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
 		    device->commit_total_bytes)
 			break;
+		if (!btrfs_check_super_location(device, bytenr))
+			continue;
 
 		btrfs_set_super_bytenr(sb, bytenr);
 
@@ -3561,6 +3570,8 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
 		    device->commit_total_bytes)
 			break;
+		if (!btrfs_check_super_location(device, bytenr))
+			continue;
 
 		bh = __find_get_block(device->bdev,
 				      bytenr / BTRFS_BDEV_BLOCKSIZE,
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index a0161aa1ea0b..70e97cd6fa76 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -141,6 +141,7 @@ struct extent_map *btree_get_extent(struct btrfs_inode *inode,
 		struct page *page, size_t pg_offset, u64 start, u64 len,
 		int create);
 int btrfs_get_num_tolerated_disk_barrier_failures(u64 flags);
+int btrfs_check_super_location(struct btrfs_device *device, u64 pos);
 int __init btrfs_end_io_wq_init(void);
 void __cold btrfs_end_io_wq_exit(void);
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 3d41d840fe5c..ae2c895d08c4 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -267,6 +267,10 @@ static int exclude_super_stripes(struct btrfs_block_group_cache *cache)
 			return ret;
 	}
 
+	/* we won't have super stripes in sequential zones */
+	if (cache->alloc_type == BTRFS_ALLOC_SEQ)
+		return 0;
+
 	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
 		bytenr = btrfs_sb_offset(i);
 		ret = btrfs_rmap_block(fs_info, cache->key.objectid,
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index f7b29f9db5e2..36ad4fad7eaf 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3720,6 +3720,8 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >
 		    scrub_dev->commit_total_bytes)
 			break;
+		if (!btrfs_check_super_location(scrub_dev, bytenr))
+			continue;
 
 		ret = scrub_pages(sctx, bytenr, BTRFS_SUPER_INFO_SIZE, bytenr,
 				  scrub_dev, BTRFS_EXTENT_FLAG_SUPER, gen, i,
-- 
2.21.0

