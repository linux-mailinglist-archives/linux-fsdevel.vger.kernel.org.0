Return-Path: <linux-fsdevel+bounces-7099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDACE821BE6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 13:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67071283371
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 12:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFE31401B;
	Tue,  2 Jan 2024 12:42:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4BC11734;
	Tue,  2 Jan 2024 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T4CCw4Q8jz4f3nKP;
	Tue,  2 Jan 2024 20:42:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 41CAE1A09B7;
	Tue,  2 Jan 2024 20:42:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBnwUGUBJRl+EvDFQ--.31823S13;
	Tue, 02 Jan 2024 20:42:10 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	willy@infradead.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	wangkefeng.wang@huawei.com
Subject: [RFC PATCH v2 09/25] ext4: allow inserting delalloc extents with multi-blocks
Date: Tue,  2 Jan 2024 20:39:02 +0800
Message-Id: <20240102123918.799062-10-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240102123918.799062-1-yi.zhang@huaweicloud.com>
References: <20240102123918.799062-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnwUGUBJRl+EvDFQ--.31823S13
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr4xKr43GrW8tw1xtF18Krg_yoWfKryDpF
	Z8CF18GrWag34vgFWSqr4UZr1S9a4xtrWUJr9agw1fZFy8JFySqF1UtF1YvFyrtrZ5Jrn0
	qFyYy34Uua1jga7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUl
	2NtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Introduce a new helper ext4_insert_delayed_blocks() to replace
ext4_insert_delayed_block() that we could add multi-delayed blocks into
the extent status tree once a time. But for now, it doesn't support
bigalloc feature yet. Also rename ext4_es_insert_delayed_block() to
ext4_es_insert_delayed_extent(), which matches the name style of other
ext4_es_{insert|remove}_extent() functions.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents_status.c    | 26 ++++++++++++++-----------
 fs/ext4/extents_status.h    |  4 ++--
 fs/ext4/inode.c             | 39 ++++++++++++++++++++++---------------
 include/trace/events/ext4.h | 12 +++++++-----
 4 files changed, 47 insertions(+), 34 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 4a00e2f019d9..324a6b0a6283 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -2052,19 +2052,21 @@ bool ext4_is_pending(struct inode *inode, ext4_lblk_t lblk)
 }
 
 /*
- * ext4_es_insert_delayed_block - adds a delayed block to the extents status
- *                                tree, adding a pending reservation where
- *                                needed
+ * ext4_es_insert_delayed_extent - adds delayed blocks to the extents status
+ *                                 tree, adding a pending reservation where
+ *                                 needed
  *
  * @inode - file containing the newly added block
- * @lblk - logical block to be added
+ * @lblk - first logical block to be added
+ * @len - length of blocks to be added
  * @allocated - indicates whether a physical cluster has been allocated for
  *              the logical cluster that contains the block
  */
-void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
-				  bool allocated)
+void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
+				   unsigned int len, bool allocated)
 {
 	struct extent_status newes;
+	ext4_lblk_t end = lblk + len - 1;
 	int err1 = 0, err2 = 0, err3 = 0;
 	struct extent_status *es1 = NULL;
 	struct extent_status *es2 = NULL;
@@ -2073,13 +2075,15 @@ void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 		return;
 
-	es_debug("add [%u/1) delayed to extent status tree of inode %lu\n",
-		 lblk, inode->i_ino);
+	es_debug("add [%u/%u) delayed to extent status tree of inode %lu\n",
+		 lblk, len, inode->i_ino);
+	if (!len)
+		return;
 
 	newes.es_lblk = lblk;
-	newes.es_len = 1;
+	newes.es_len = len;
 	ext4_es_store_pblock_status(&newes, ~0, EXTENT_STATUS_DELAYED);
-	trace_ext4_es_insert_delayed_block(inode, &newes, allocated);
+	trace_ext4_es_insert_delayed_extent(inode, &newes, allocated);
 
 	ext4_es_insert_extent_check(inode, &newes);
 
@@ -2092,7 +2096,7 @@ void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 		pr = __alloc_pending(true);
 	write_lock(&EXT4_I(inode)->i_es_lock);
 
-	err1 = __es_remove_extent(inode, lblk, lblk, NULL, es1);
+	err1 = __es_remove_extent(inode, lblk, end, NULL, es1);
 	if (err1 != 0)
 		goto error;
 	/* Free preallocated extent if it didn't get used. */
diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index d9847a4a25db..24493e682ab4 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -249,8 +249,8 @@ extern void ext4_exit_pending(void);
 extern void ext4_init_pending_tree(struct ext4_pending_tree *tree);
 extern void ext4_remove_pending(struct inode *inode, ext4_lblk_t lblk);
 extern bool ext4_is_pending(struct inode *inode, ext4_lblk_t lblk);
-extern void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
-					 bool allocated);
+extern void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
+					  unsigned int len, bool allocated);
 extern unsigned int ext4_es_delayed_clu(struct inode *inode, ext4_lblk_t lblk,
 					ext4_lblk_t len);
 extern void ext4_clear_inode_es(struct inode *inode);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0458d7f0c059..bc29c2e92750 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1452,7 +1452,7 @@ static int ext4_journalled_write_end(struct file *file,
 /*
  * Reserve space for a single cluster
  */
-static int ext4_da_reserve_space(struct inode *inode)
+static int ext4_da_reserve_space(struct inode *inode, unsigned int len)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct ext4_inode_info *ei = EXT4_I(inode);
@@ -1463,18 +1463,18 @@ static int ext4_da_reserve_space(struct inode *inode)
 	 * us from metadata over-estimation, though we may go over by
 	 * a small amount in the end.  Here we just reserve for data.
 	 */
-	ret = dquot_reserve_block(inode, EXT4_C2B(sbi, 1));
+	ret = dquot_reserve_block(inode, EXT4_C2B(sbi, len));
 	if (ret)
 		return ret;
 
 	spin_lock(&ei->i_block_reservation_lock);
-	if (ext4_claim_free_clusters(sbi, 1, 0)) {
+	if (ext4_claim_free_clusters(sbi, len, 0)) {
 		spin_unlock(&ei->i_block_reservation_lock);
-		dquot_release_reservation_block(inode, EXT4_C2B(sbi, 1));
+		dquot_release_reservation_block(inode, EXT4_C2B(sbi, len));
 		return -ENOSPC;
 	}
-	ei->i_reserved_data_blocks++;
-	trace_ext4_da_reserve_space(inode);
+	ei->i_reserved_data_blocks += len;
+	trace_ext4_da_reserve_space(inode, len);
 	spin_unlock(&ei->i_block_reservation_lock);
 
 	return 0;       /* success */
@@ -1620,18 +1620,21 @@ static void ext4_print_free_blocks(struct inode *inode)
 	return;
 }
 
+
 /*
- * ext4_insert_delayed_block - adds a delayed block to the extents status
- *                             tree, incrementing the reserved cluster/block
- *                             count or making a pending reservation
- *                             where needed
+ * ext4_insert_delayed_blocks - adds multi-delayed blocks to the extents
+ *                              status tree, incrementing the reserved
+ *                              cluster/block count or making a pending
+ *                              reservation where needed.
  *
  * @inode - file containing the newly added block
- * @lblk - logical block to be added
+ * @lblk - start logical block to be added
+ * @len - length of blocks to be added
  *
  * Returns 0 on success, negative error code on failure.
  */
-static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
+static int ext4_insert_delayed_blocks(struct inode *inode, ext4_lblk_t lblk,
+				      ext4_lblk_t len)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	int ret;
@@ -1649,10 +1652,14 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 	 * extents status tree doesn't get a match.
 	 */
 	if (sbi->s_cluster_ratio == 1) {
-		ret = ext4_da_reserve_space(inode);
+		ret = ext4_da_reserve_space(inode, len);
 		if (ret != 0)   /* ENOSPC */
 			return ret;
 	} else {   /* bigalloc */
+		/* TODO: support bigalloc for multi-blocks. */
+		if (len != 1)
+			return -EOPNOTSUPP;
+
 		if (!ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk)) {
 			if (!ext4_es_scan_clu(inode,
 					      &ext4_es_is_mapped, lblk)) {
@@ -1661,7 +1668,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 				if (ret < 0)
 					return ret;
 				if (ret == 0) {
-					ret = ext4_da_reserve_space(inode);
+					ret = ext4_da_reserve_space(inode, 1);
 					if (ret != 0)   /* ENOSPC */
 						return ret;
 				} else {
@@ -1673,7 +1680,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 		}
 	}
 
-	ext4_es_insert_delayed_block(inode, lblk, allocated);
+	ext4_es_insert_delayed_extent(inode, lblk, len, allocated);
 	return 0;
 }
 
@@ -1774,7 +1781,7 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 
 add_delayed:
 	down_write(&EXT4_I(inode)->i_data_sem);
-	retval = ext4_insert_delayed_block(inode, map->m_lblk);
+	retval = ext4_insert_delayed_blocks(inode, map->m_lblk, map->m_len);
 	up_write(&EXT4_I(inode)->i_data_sem);
 	if (retval)
 		return retval;
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 65029dfb92fb..53aa7a7fb3be 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -1249,14 +1249,15 @@ TRACE_EVENT(ext4_da_update_reserve_space,
 );
 
 TRACE_EVENT(ext4_da_reserve_space,
-	TP_PROTO(struct inode *inode),
+	TP_PROTO(struct inode *inode, int reserved_blocks),
 
-	TP_ARGS(inode),
+	TP_ARGS(inode, reserved_blocks),
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
 		__field(	ino_t,	ino			)
 		__field(	__u64,	i_blocks		)
+		__field(	int,	reserved_blocks		)
 		__field(	int,	reserved_data_blocks	)
 		__field(	__u16,  mode			)
 	),
@@ -1265,16 +1266,17 @@ TRACE_EVENT(ext4_da_reserve_space,
 		__entry->dev	= inode->i_sb->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->i_blocks = inode->i_blocks;
+		__entry->reserved_blocks = reserved_blocks;
 		__entry->reserved_data_blocks = EXT4_I(inode)->i_reserved_data_blocks;
 		__entry->mode	= inode->i_mode;
 	),
 
-	TP_printk("dev %d,%d ino %lu mode 0%o i_blocks %llu "
+	TP_printk("dev %d,%d ino %lu mode 0%o i_blocks %llu reserved_blocks %u "
 		  "reserved_data_blocks %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  (unsigned long) __entry->ino,
 		  __entry->mode, __entry->i_blocks,
-		  __entry->reserved_data_blocks)
+		  __entry->reserved_blocks, __entry->reserved_data_blocks)
 );
 
 TRACE_EVENT(ext4_da_release_space,
@@ -2481,7 +2483,7 @@ TRACE_EVENT(ext4_es_shrink,
 		  __entry->scan_time, __entry->nr_skipped, __entry->retried)
 );
 
-TRACE_EVENT(ext4_es_insert_delayed_block,
+TRACE_EVENT(ext4_es_insert_delayed_extent,
 	TP_PROTO(struct inode *inode, struct extent_status *es,
 		 bool allocated),
 
-- 
2.39.2


