Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB9EA38B25
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 15:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbfFGNLq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 09:11:46 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53172 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729244AbfFGNLp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559913105; x=1591449105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LSxy5uEmyBPfWWJ/8qZvZdh0ZR6TZdvGA+vF1AEs9MI=;
  b=lRKKx55UjD6fkkbTkp7pEEs8XZxToOXKlklDE/FJuMevHbuzHp44Xhzo
   V+MI5LA721x95TcJbPccTs7w9iaWt7uvEsBQLuRvQGlWi1KiksqwTZA5y
   O5zFKwNEVstr8LnVxCnGGkH1lBQBfHvHHkJX8E5/HVZg8eFBHxTvfQGsD
   YnYaxXrMgOdVe67kDzz/qfb4RgILlF/ydP7b1iX2ql01FQDQX0E+R0jRI
   n6cOf4BwXQjtzUyGMlHRhi+meFhUB1F50vF9C/b/NnvaxbqXrM41+0Ghm
   F+nGndLECMZmlVp31TF4jaNFUeTLF8cXHNxqAqMXkZZfblV7n17w77fgU
   A==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="110027825"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 21:11:45 +0800
IronPort-SDR: oF1LCejUPoDVXs8+Xnfz5NGFEjyF2GKHZoKHg/Pl06rm5suAYv7NINborRfE7iNeGto/WPACxu
 auBkVMJ0mR/vqv7dlTLT2NOuw0wEeZFuBWxQFKI7VcNIeaDpYLESoYxFsQR6EcY+xFr90SWWPo
 XutlGR+qvc6RxQpNlgSesEQb+XZYOa01ylJZmivZwcqGLEdRpLTFffJIiwFMQ/d8+2/ekLgE5N
 +mRTCiGbjxJOIZNqzYRMb7gn2o+mNR2wt/SJqkwINUXM52yM1WX00vIIna+9JYhcUhix7vPBar
 yv2D71qExRbMn/aoPMVNeNpL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 05:49:02 -0700
IronPort-SDR: CsIXMpv7pCkU43XH4e+ANxqeC2A/NnFNqyQ5afRdlALMPA5UUIx8RfF76FKrrxLfiUhtEtJtjo
 gzxvupaL7h+Z1abHiS7eLCP5Z5K3BidCF98pncwwBQoqHo7ob9Wm9AXN6O88KK0e5SVLm9SsJQ
 FADkCCmicOobWAuPHKG62vEuKSzDdgXlHIIRJfY/jz9zXLUKUWfpSOJ4ZLVnnmT3BAIBNs8X59
 Ep1BOJIv6eP1At3UnIZPsS/P8vgqXOFATSO0+0aiY2Q4IclDFsCkHFWc6nvPdjNy9S1S582Khd
 FXA=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 06:11:43 -0700
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
Subject: [PATCH 14/19] btrfs: redirty released extent buffers in sequential BGs
Date:   Fri,  7 Jun 2019 22:10:20 +0900
Message-Id: <20190607131025.31996-15-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607131025.31996-1-naohiro.aota@wdc.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tree manipulating operations like merging nodes often release
once-allocated tree nodes. Btrfs cleans such nodes so that pages in the
node are not uselessly written out. On HMZONED drives, however, such
optimization blocks the following IOs as the cancellation of the write out
of the freed blocks breaks the sequential write sequence expected by the
device.

This patch introduces a list of clean extent buffers that have been
released in a transaction. Btrfs consult the list before writing out and
waiting for the IOs, and it redirties a buffer if 1) it's in sequential BG,
2) it's in un-submit range, and 3) it's not under IO. Thus, such buffers
are marked for IO in btrfs_write_and_wait_transaction() to send proper bios
to the disk.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c     | 27 ++++++++++++++++++++++++---
 fs/btrfs/extent_io.c   |  1 +
 fs/btrfs/extent_io.h   |  2 ++
 fs/btrfs/transaction.c | 35 +++++++++++++++++++++++++++++++++++
 fs/btrfs/transaction.h |  3 +++
 5 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 6651986da470..c6147fce648f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -535,7 +535,9 @@ static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct page *page)
 	if (csum_tree_block(eb, result))
 		return -EINVAL;
 
-	if (btrfs_header_level(eb))
+	if (test_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags))
+		ret = 0;
+	else if (btrfs_header_level(eb))
 		ret = btrfs_check_node(eb);
 	else
 		ret = btrfs_check_leaf_full(eb);
@@ -1115,10 +1117,20 @@ struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 void btrfs_clean_tree_block(struct extent_buffer *buf)
 {
 	struct btrfs_fs_info *fs_info = buf->fs_info;
-	if (btrfs_header_generation(buf) ==
-	    fs_info->running_transaction->transid) {
+	struct btrfs_transaction *cur_trans = fs_info->running_transaction;
+
+	if (btrfs_header_generation(buf) == cur_trans->transid) {
 		btrfs_assert_tree_locked(buf);
 
+		if (btrfs_fs_incompat(fs_info, HMZONED) &&
+		    list_empty(&buf->release_list)) {
+			atomic_inc(&buf->refs);
+			spin_lock(&cur_trans->releasing_ebs_lock);
+			list_add_tail(&buf->release_list,
+				      &cur_trans->releasing_ebs);
+			spin_unlock(&cur_trans->releasing_ebs_lock);
+		}
+
 		if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &buf->bflags)) {
 			percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
 						 -buf->len,
@@ -4533,6 +4545,15 @@ void btrfs_cleanup_one_transaction(struct btrfs_transaction *cur_trans,
 	btrfs_destroy_pinned_extent(fs_info,
 				    fs_info->pinned_extents);
 
+	while (!list_empty(&cur_trans->releasing_ebs)) {
+		struct extent_buffer *eb;
+
+		eb = list_first_entry(&cur_trans->releasing_ebs,
+				      struct extent_buffer, release_list);
+		list_del_init(&eb->release_list);
+		free_extent_buffer(eb);
+	}
+
 	cur_trans->state =TRANS_STATE_COMPLETED;
 	wake_up(&cur_trans->commit_wait);
 }
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 13fca7bfc1f2..c73c69e2bef4 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4816,6 +4816,7 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
 	init_waitqueue_head(&eb->read_lock_wq);
 
 	btrfs_leak_debug_add(&eb->leak_list, &buffers);
+	INIT_LIST_HEAD(&eb->release_list);
 
 	spin_lock_init(&eb->refs_lock);
 	atomic_set(&eb->refs, 1);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index aa18a16a6ed7..2987a01f84f9 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -58,6 +58,7 @@ enum {
 	EXTENT_BUFFER_IN_TREE,
 	/* write IO error */
 	EXTENT_BUFFER_WRITE_ERR,
+	EXTENT_BUFFER_NO_CHECK,
 };
 
 /* these are flags for __process_pages_contig */
@@ -186,6 +187,7 @@ struct extent_buffer {
 	 */
 	wait_queue_head_t read_lock_wq;
 	struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
+	struct list_head release_list;
 #ifdef CONFIG_BTRFS_DEBUG
 	atomic_t spinning_writers;
 	atomic_t spinning_readers;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 3f6811cdf803..ded40ad75419 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -236,6 +236,8 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 	spin_lock_init(&cur_trans->dirty_bgs_lock);
 	INIT_LIST_HEAD(&cur_trans->deleted_bgs);
 	spin_lock_init(&cur_trans->dropped_roots_lock);
+	INIT_LIST_HEAD(&cur_trans->releasing_ebs);
+	spin_lock_init(&cur_trans->releasing_ebs_lock);
 	list_add_tail(&cur_trans->list, &fs_info->trans_list);
 	extent_io_tree_init(fs_info, &cur_trans->dirty_pages,
 			IO_TREE_TRANS_DIRTY_PAGES, fs_info->btree_inode);
@@ -2219,7 +2221,31 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 
 	wake_up(&fs_info->transaction_wait);
 
+	if (btrfs_fs_incompat(fs_info, HMZONED)) {
+		struct extent_buffer *eb;
+
+		list_for_each_entry(eb, &cur_trans->releasing_ebs,
+				    release_list) {
+			struct btrfs_block_group_cache *cache;
+
+			cache = btrfs_lookup_block_group(fs_info, eb->start);
+			if (!cache)
+				continue;
+			mutex_lock(&cache->submit_lock);
+			if (cache->alloc_type == BTRFS_ALLOC_SEQ &&
+			    cache->submit_offset <= eb->start &&
+			    !extent_buffer_under_io(eb)) {
+				set_extent_buffer_dirty(eb);
+				cache->space_info->bytes_readonly += eb->len;
+				set_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags);
+			}
+			mutex_unlock(&cache->submit_lock);
+			btrfs_put_block_group(cache);
+		}
+	}
+
 	ret = btrfs_write_and_wait_transaction(trans);
+
 	if (ret) {
 		btrfs_handle_fs_error(fs_info, ret,
 				      "Error while writing out transaction");
@@ -2227,6 +2253,15 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 		goto scrub_continue;
 	}
 
+	while (!list_empty(&cur_trans->releasing_ebs)) {
+		struct extent_buffer *eb;
+
+		eb = list_first_entry(&cur_trans->releasing_ebs,
+				      struct extent_buffer, release_list);
+		list_del_init(&eb->release_list);
+		free_extent_buffer(eb);
+	}
+
 	ret = write_all_supers(fs_info, 0);
 	/*
 	 * the super is written, we can safely allow the tree-loggers
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 78c446c222b7..7984a7f01dd8 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -85,6 +85,9 @@ struct btrfs_transaction {
 	spinlock_t dropped_roots_lock;
 	struct btrfs_delayed_ref_root delayed_refs;
 	struct btrfs_fs_info *fs_info;
+
+	spinlock_t releasing_ebs_lock;
+	struct list_head releasing_ebs;
 };
 
 #define __TRANS_FREEZABLE	(1U << 0)
-- 
2.21.0

