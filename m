Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D253F2806E3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 20:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733098AbgJASjD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 14:39:03 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24722 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732431AbgJASjB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601577541; x=1633113541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8/xQVD50/d8enj2n99W6cqIQvZ/32vR2MauPROXbtf0=;
  b=PXmA4SoP+jqynUCiQsJkkni0cfBC2aaREGNsa1qWYjBlIU5xHLps8Esc
   uyF8JWyCSW+8X+8R7MVPOQGpORc4LScDSWE7jLTnfmthW7xgsjNqdGbBJ
   azuL/4trRc9KWcIRBZQA8go4wsmxN8VG558RKQ8EbgLwVE5jXH6mKqiWu
   vntHoJl7vhmscJ0r1iZK1PfQmMSgCXtW9+mpOtQSQ8NuwGRpQnEAN5ksI
   GoazID8otYAhG0LQu0ba5jNgbVYFQA2gTCjZ9MoF3gx9nTJVjyl2SAgup
   So8vGzmHz9nPNt4IoCvzQs1cArqZSiOJfNYaedw9nakU8AFZpk/HNUAKV
   w==;
IronPort-SDR: PlzSZ4+CL92Yeu4bjZN7rI2kbJoKUIzqVBI+0JGNtExwCuhXKLD7BFJqGg0wIYahuE8IZ1qYAB
 GwNLdH0QCSB190SvC9B+8is1H7ng+ZXr142Q5jYXscxPI+Xe+CdsO6XCC5XE2mriub8iUv+WHt
 WKUT+OVzhIQUDwPQF1du+8dShxaer9SC1KhMcwoGgBsCWJdWsDht/tyGzp5D9z0YFtuQeT1bdl
 q9mZA41aAX2y/A8u+jcRyyhF5NQN3VwhWHIFYbEjxju2JxwPtuMYxqZY3ZchpGTXB7hkUzJASY
 YQ0=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; 
   d="scan'208";a="150036816"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 02:38:28 +0800
IronPort-SDR: gS+wUv/+2L0lcO+vfZKVGIXQoM6K+QqbTdTFh/+ykPbisqZK2gDPCf0W6jnSkSlJhosJtIzBdb
 NWVhD55XRhrg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:24:25 -0700
IronPort-SDR: c4lfygpGO0mILy/fNtyFqlQWnbzT1LG+0+kvmhlLcLWmmEGuEB89gZUzKcaH0glTztr6rBuHND
 MVQBa1fg+eHA==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 11:38:28 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v8 23/41] btrfs: split ordered extent when bio is sent
Date:   Fri,  2 Oct 2020 03:36:30 +0900
Message-Id: <d193aa0f9ddaa4c008158851b16d7bfe220904cd.1601574234.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
References: <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The device decides the written location of ZONE_APPEND write IO. Thus, we
cannot ensure two bios to be written continuously on the device. So, we
need to follow "one bio == one ordered extent" rule to ensure the region of
ordered extent maps to contiguous region on the disk.

This commit implements splitting of an ordered extent and an extent map on
submitting bio to follow the rule.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c        | 87 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/ordered-data.c | 73 ++++++++++++++++++++++++++++++++++
 fs/btrfs/ordered-data.h |  2 +
 3 files changed, 162 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 36efed0a24de..4bc975eafbd8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2158,6 +2158,87 @@ static blk_status_t btrfs_submit_bio_start(void *private_data, struct bio *bio,
 	return btrfs_csum_one_bio(BTRFS_I(inode), bio, 0, 0);
 }
 
+int extract_ordered_extent(struct inode *inode, struct bio *bio)
+{
+	struct btrfs_ordered_extent *ordered;
+	struct extent_map *em = NULL, *em_new = NULL;
+	struct page *page = bio_first_bvec_all(bio)->bv_page;
+	struct extent_map_tree *em_tree = &BTRFS_I(inode)->extent_tree;
+	u64 start = (u64)bio->bi_iter.bi_sector << SECTOR_SHIFT;
+	u64 len = bio->bi_iter.bi_size;
+	u64 end = start + len;
+	u64 ordered_end;
+	u64 pre, post;
+	int ret = 0;
+
+	ordered = btrfs_lookup_ordered_extent(BTRFS_I(inode),
+					      page_offset(page));
+	if (WARN_ON_ONCE(!ordered))
+		return -EIO;
+
+	/* no need to split */
+	if (ordered->disk_num_bytes == len)
+		goto out;
+
+	/* cannot split once end_bio'd ordered extent */
+	if (WARN_ON_ONCE(ordered->bytes_left != ordered->disk_num_bytes)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* we cannot split compressed ordered extent */
+	if (WARN_ON_ONCE(ordered->disk_num_bytes != ordered->num_bytes)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* cannot split waietd ordered extent */
+	if (WARN_ON_ONCE(wq_has_sleeper(&ordered->wait))) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ordered_end = ordered->disk_bytenr + ordered->disk_num_bytes;
+	/* bio must be in one ordered extent */
+	if (WARN_ON_ONCE(start < ordered->disk_bytenr || end > ordered_end)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* checksum list should be empty */
+	if (WARN_ON_ONCE(!list_empty(&ordered->list))) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	pre = start - ordered->disk_bytenr;
+	post = ordered_end - end;
+
+	btrfs_split_ordered_extent(ordered, pre, post);
+
+	read_lock(&em_tree->lock);
+	em = lookup_extent_mapping(em_tree, ordered->file_offset, len);
+	if (!em) {
+		read_unlock(&em_tree->lock);
+		ret = -EIO;
+		goto out;
+	}
+	read_unlock(&em_tree->lock);
+
+	ASSERT(!test_bit(EXTENT_FLAG_COMPRESSED, &em->flags));
+	em_new = create_io_em(BTRFS_I(inode), em->start + pre, len,
+			      em->start + pre, em->block_start + pre, len,
+			      len, len, BTRFS_COMPRESS_NONE,
+			      BTRFS_ORDERED_REGULAR);
+	free_extent_map(em_new);
+
+out:
+	free_extent_map(em);
+	btrfs_put_ordered_extent(ordered);
+
+	return ret;
+}
+
 /*
  * extent_io.c submission hook. This does the right thing for csum calculation
  * on write, or reading the csums from the tree before a read.
@@ -2192,6 +2273,12 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 	if (btrfs_is_free_space_inode(BTRFS_I(inode)))
 		metadata = BTRFS_WQ_ENDIO_FREE_SPACE;
 
+	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+		ret = extract_ordered_extent(inode, bio);
+		if (ret)
+			goto out;
+	}
+
 	if (bio_op(bio) != REQ_OP_WRITE) {
 		ret = btrfs_bio_wq_end_io(fs_info, bio, metadata);
 		if (ret)
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 87bac9ecdf4c..7cd22cb07f26 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -943,6 +943,79 @@ void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
 	}
 }
 
+static void clone_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pos,
+				 u64 len)
+{
+	struct inode *inode = ordered->inode;
+	u64 file_offset = ordered->file_offset + pos;
+	u64 disk_bytenr = ordered->disk_bytenr + pos;
+	u64 num_bytes = len;
+	u64 disk_num_bytes = len;
+	int type;
+	unsigned long flags_masked =
+		ordered->flags & ~(1 << BTRFS_ORDERED_DIRECT);
+	int compress_type = ordered->compress_type;
+	unsigned long weight;
+
+	weight = hweight_long(flags_masked);
+	WARN_ON_ONCE(weight > 1);
+	if (!weight)
+		type = 0;
+	else
+		type = __ffs(flags_masked);
+
+	ASSERT(!test_bit(BTRFS_ORDERED_DIRECT, &ordered->flags));
+	if (test_bit(BTRFS_ORDERED_COMPRESSED, &ordered->flags)) {
+		WARN_ON_ONCE(1);
+		btrfs_add_ordered_extent_compress(BTRFS_I(inode), file_offset,
+						  disk_bytenr, num_bytes,
+						  disk_num_bytes, type,
+						  compress_type);
+	} else {
+		btrfs_add_ordered_extent(BTRFS_I(inode), file_offset,
+					 disk_bytenr, num_bytes, disk_num_bytes,
+					 type);
+	}
+}
+
+void btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pre,
+				u64 post)
+{
+	struct inode *inode = ordered->inode;
+	struct btrfs_ordered_inode_tree *tree = &BTRFS_I(inode)->ordered_tree;
+	struct rb_node *node;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+
+	spin_lock_irq(&tree->lock);
+	/* remove from tree once */
+	node = &ordered->rb_node;
+	rb_erase(node, &tree->tree);
+	RB_CLEAR_NODE(node);
+	if (tree->last == node)
+		tree->last = NULL;
+
+	ordered->file_offset += pre;
+	ordered->disk_bytenr += pre;
+	ordered->num_bytes -= (pre + post);
+	ordered->disk_num_bytes -= (pre + post);
+	ordered->bytes_left -= (pre + post);
+
+	/* re-insert the node */
+	node = tree_insert(&tree->tree, ordered->file_offset,
+			   &ordered->rb_node);
+	if (node)
+		btrfs_panic(fs_info, -EEXIST,
+				"inconsistency in ordered tree at offset %llu",
+				ordered->file_offset);
+
+	spin_unlock_irq(&tree->lock);
+
+	if (pre)
+		clone_ordered_extent(ordered, 0, pre);
+	if (post)
+		clone_ordered_extent(ordered, pre + ordered->disk_num_bytes, post);
+}
+
 int __init ordered_data_init(void)
 {
 	btrfs_ordered_extent_cache = kmem_cache_create("btrfs_ordered_extent",
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index c3a2325e64a4..e346b03bd66a 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -193,6 +193,8 @@ void btrfs_wait_ordered_roots(struct btrfs_fs_info *fs_info, u64 nr,
 void btrfs_lock_and_flush_ordered_range(struct btrfs_inode *inode, u64 start,
 					u64 end,
 					struct extent_state **cached_state);
+void btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pre,
+				u64 post);
 int __init ordered_data_init(void);
 void __cold ordered_data_exit(void);
 
-- 
2.27.0

