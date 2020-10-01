Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9E82806E0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 20:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733074AbgJASjB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 14:39:01 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24779 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730079AbgJASis (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601577529; x=1633113529;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7uXZKRaKpQXl1PgUFHO2cQUccxPb0XkkDSSLIJVs/vg=;
  b=quBXaI4dlxB3cL5UgT1wt/QMD6Ewf2wkE/uylHdRnQLMhHZBA3qiBXVK
   Nd+U8zduLPoAUHmyAA5tg46wvig4DXJxYQy2Ixe2xhJvIZdHqcWlUiRF2
   OcBdNbN7+qpXek1yp1AgpI/PBKJOCqRHcurMnsRbvxqR/rOFAQ7h+Xd1x
   Ns+yXkrEK2Q0HCpvoUCMqT1tXvN/rQmxINRIzXKY3vpuUSMu4865mg/8G
   sLJ6mtA5ceqPIxkEi/OtNQoY0Mtg0k/5rjOzZrmY5idenJMU8cncZaKQk
   +pE5ihLMUqMqhjOO7nP2IEA31j5U9xFD4EAanFD9uHsFK4Ki2t+FncCQV
   A==;
IronPort-SDR: heYcixwjIXWJfEdC9Dd1sfA6ZtXL07YrDh2tpO0xXOkkMfzjdEXZNrw8TfPXs56vgIUCmWVe6q
 4/DjM8IK2y2gQev34+Pya8Sy+RACMwVq2wBCb+k2rnf2NtVizCzRqXTIm39sZ0WUO2sk/As80k
 JsNgNh11Bfed8EXKjG9Zt8av1vVn6798EJrL2iYlu/Stn59JWQjDftTMVTRmKdVZmWlEafXFGz
 wEyt+9awmKM167UgbybYwYBnpAt2yJtUGwgsmemmXZ2tQaNgtillUHZsSrB9ve0qSHTth1fbCw
 rGg=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; 
   d="scan'208";a="150036812"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 02:38:26 +0800
IronPort-SDR: 1JgJnueFmHdn5UJ8oAmwVm2N1DAmzSK0oAngoAPmuu8ms/Tm+9nObQvnWpqi0cJLufVh083mqu
 +6Zh6Int0O3w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:24:23 -0700
IronPort-SDR: +eoH4BA8kPoFE77+VleXHjwWGRjpzzwzAgkIkO50K2YtbQleC0y5kI1qG4uq1kCpMPy+gD2hNj
 USZg1iRth9bQ==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 11:38:25 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v8 21/41] btrfs: use bio_add_zone_append_page for zoned btrfs
Date:   Fri,  2 Oct 2020 03:36:28 +0900
Message-Id: <6ed1ae6271e25066ff179c94e638958e1cdd23f5.1601574234.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
References: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Zoned device has its own hardware restrictions e.g. max_zone_append_size
when using REQ_OP_ZONE_APPEND. To follow the restrictions, use
bio_add_zone_append_page() instead of bio_add_page(). We need target device
to use bio_add_zone_append_page(), so this commit reads the chunk
information to memoize the target device to btrfs_io_bio(bio)->device.

Currently, zoned btrfs only supports SINGLE profile. In the feature,
btrfs_io_bio can hold extent_map and check the restrictions for all the
devices the bio will be mapped.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent_io.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 17285048fb5a..5ee94a2ffa22 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3032,6 +3032,7 @@ bool btrfs_bio_add_page(struct bio *bio, struct page *page, u64 logical,
 {
 	sector_t sector = logical >> SECTOR_SHIFT;
 	bool contig;
+	int ret;
 
 	if (prev_bio_flags != bio_flags)
 		return false;
@@ -3046,7 +3047,19 @@ bool btrfs_bio_add_page(struct bio *bio, struct page *page, u64 logical,
 	if (btrfs_bio_fits_in_stripe(page, size, bio, bio_flags))
 		return false;
 
-	return bio_add_page(bio, page, size, pg_offset) == size;
+	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+		struct bio orig_bio;
+
+		memset(&orig_bio, 0, sizeof(orig_bio));
+		bio_copy_dev(&orig_bio, bio);
+		bio_set_dev(bio, btrfs_io_bio(bio)->device->bdev);
+		ret = bio_add_zone_append_page(bio, page, size, pg_offset);
+		bio_copy_dev(bio, &orig_bio);
+	} else {
+		ret = bio_add_page(bio, page, size, pg_offset);
+	}
+
+	return ret == size;
 }
 
 /*
@@ -3077,7 +3090,9 @@ static int submit_extent_page(unsigned int opf,
 	int ret = 0;
 	struct bio *bio;
 	size_t page_size = min_t(size_t, size, PAGE_SIZE);
-	struct extent_io_tree *tree = &BTRFS_I(page->mapping->host)->io_tree;
+	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
+	struct extent_io_tree *tree = &inode->io_tree;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 
 	ASSERT(bio_ret);
 
@@ -3108,11 +3123,27 @@ static int submit_extent_page(unsigned int opf,
 	if (wbc) {
 		struct block_device *bdev;
 
-		bdev = BTRFS_I(page->mapping->host)->root->fs_info->fs_devices->latest_bdev;
+		bdev = fs_info->fs_devices->latest_bdev;
 		bio_set_dev(bio, bdev);
 		wbc_init_bio(wbc, bio);
 		wbc_account_cgroup_owner(wbc, page, page_size);
 	}
+	if (btrfs_fs_incompat(fs_info, ZONED) &&
+	    bio_op(bio) == REQ_OP_ZONE_APPEND) {
+		struct extent_map *em;
+		struct map_lookup *map;
+
+		em = btrfs_get_chunk_map(fs_info, offset, page_size);
+		if (IS_ERR(em))
+			return PTR_ERR(em);
+
+		map = em->map_lookup;
+		/* only support SINGLE profile for now */
+		ASSERT(map->num_stripes == 1);
+		btrfs_io_bio(bio)->device = map->stripes[0].dev;
+
+		free_extent_map(em);
+	}
 
 	*bio_ret = bio;
 
-- 
2.27.0

