Return-Path: <linux-fsdevel+bounces-15767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7402892B17
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 13:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE471C2115D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 12:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017333BBC8;
	Sat, 30 Mar 2024 12:10:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21C936AE4;
	Sat, 30 Mar 2024 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711800640; cv=none; b=TYYab44f90HX94qTxNrnThnEJ3HuK+u6uy95PdHzPZDqEWT8nHPmnV4qJ7j5NkG9VZ0MC6nvWKSKUcVTUUUTD3hUpjz7Lr9MGPfeai/Q9q6xG48E3si1Yx7N5LTGfp5rSn4Lps1aFRSn6vTTAM2GZ7+Bqh7pQyqaJhMRw3SfA0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711800640; c=relaxed/simple;
	bh=Ga9Hwe4BjgnbSXAgyCDbcCHQY9GfnZKDbNV4vZMwgcM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cjEAJgdH1BcJtYxYfEJYAFlXBXPIHdE9Vt3wfghnH0v3zLXWQ+zF961JdZq40aO/TvjmvzsMsfxYvLhsfnBIHwrGjL0aHDap40aJVMOKi3Wj0W94ljVjOSmIZlYy1GIRgUHNTSmYXrauFIzKkHylpLOwLnSVXzJz8LNfgN+Iqss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V6GLm3VfQz4f3m7R;
	Sat, 30 Mar 2024 20:10:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B98DF1A0175;
	Sat, 30 Mar 2024 20:10:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+REsAQhmkPEjIg--.10652S7;
	Sat, 30 Mar 2024 20:10:32 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH 3/7] ext4: make ext4_es_insert_delayed_block() insert multi-blocks
Date: Sat, 30 Mar 2024 20:02:32 +0800
Message-Id: <20240330120236.3789589-4-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240330120236.3789589-1-yi.zhang@huaweicloud.com>
References: <20240330120236.3789589-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+REsAQhmkPEjIg--.10652S7
X-Coremail-Antispam: 1UD129KBjvJXoWxtFWfAw4ktw48Cw18ZF15XFb_yoWxKr4fpF
	Z8Cr18CrW5Xw1q93Zaqw1UXr13Xa1kGrWUGrZIvw1fZFWfJFy5KF1DtF1FvFWFvrWIy3Zx
	XFyjy347Ca1j9a7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd8n5UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Rename ext4_es_insert_delayed_block() to ext4_es_insert_delayed_extent()
and pass length parameter to make it insert multi delalloc blocks once a
time. For the case of bigalloc, expand the allocated parameter to
lclu_allocated and end_allocated. lclu_allocated indicates the allocate
state of the cluster which containing the lblk, end_allocated represents
the end, and the middle clusters must be unallocated.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents_status.c    | 63 ++++++++++++++++++++++++-------------
 fs/ext4/extents_status.h    |  5 +--
 fs/ext4/inode.c             |  2 +-
 include/trace/events/ext4.h | 16 +++++-----
 4 files changed, 55 insertions(+), 31 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 4a00e2f019d9..2320b0d71001 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -2052,34 +2052,42 @@ bool ext4_is_pending(struct inode *inode, ext4_lblk_t lblk)
 }
 
 /*
- * ext4_es_insert_delayed_block - adds a delayed block to the extents status
- *                                tree, adding a pending reservation where
- *                                needed
+ * ext4_es_insert_delayed_extent - adds some delayed blocks to the extents
+ *                                 status tree, adding a pending reservation
+ *                                 where needed
  *
  * @inode - file containing the newly added block
- * @lblk - logical block to be added
- * @allocated - indicates whether a physical cluster has been allocated for
- *              the logical cluster that contains the block
+ * @lblk - start logical block to be added
+ * @len - length of blocks to be added
+ * @lclu_allocated/end_allocated - indicates whether a physical cluster has
+ *                                 been allocated for the logical cluster
+ *                                 that contains the block
  */
-void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
-				  bool allocated)
+void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
+				   ext4_lblk_t len, bool lclu_allocated,
+				   bool end_allocated)
 {
 	struct extent_status newes;
+	ext4_lblk_t end = lblk + len - 1;
 	int err1 = 0, err2 = 0, err3 = 0;
 	struct extent_status *es1 = NULL;
 	struct extent_status *es2 = NULL;
-	struct pending_reservation *pr = NULL;
+	struct pending_reservation *pr1 = NULL;
+	struct pending_reservation *pr2 = NULL;
 
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
+	trace_ext4_es_insert_delayed_extent(inode, &newes, lclu_allocated,
+					    end_allocated);
 
 	ext4_es_insert_extent_check(inode, &newes);
 
@@ -2088,11 +2096,15 @@ void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 		es1 = __es_alloc_extent(true);
 	if ((err1 || err2) && !es2)
 		es2 = __es_alloc_extent(true);
-	if ((err1 || err2 || err3) && allocated && !pr)
-		pr = __alloc_pending(true);
+	if (err1 || err2 || err3) {
+		if (lclu_allocated && !pr1)
+			pr1 = __alloc_pending(true);
+		if (end_allocated && !pr2)
+			pr2 = __alloc_pending(true);
+	}
 	write_lock(&EXT4_I(inode)->i_es_lock);
 
-	err1 = __es_remove_extent(inode, lblk, lblk, NULL, es1);
+	err1 = __es_remove_extent(inode, lblk, end, NULL, es1);
 	if (err1 != 0)
 		goto error;
 	/* Free preallocated extent if it didn't get used. */
@@ -2112,13 +2124,22 @@ void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 		es2 = NULL;
 	}
 
-	if (allocated) {
-		err3 = __insert_pending(inode, lblk, &pr);
+	if (lclu_allocated) {
+		err3 = __insert_pending(inode, lblk, &pr1);
 		if (err3 != 0)
 			goto error;
-		if (pr) {
-			__free_pending(pr);
-			pr = NULL;
+		if (pr1) {
+			__free_pending(pr1);
+			pr1 = NULL;
+		}
+	}
+	if (end_allocated) {
+		err3 = __insert_pending(inode, end, &pr2);
+		if (err3 != 0)
+			goto error;
+		if (pr2) {
+			__free_pending(pr2);
+			pr2 = NULL;
 		}
 	}
 error:
diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index d9847a4a25db..3c8e2edee5d5 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -249,8 +249,9 @@ extern void ext4_exit_pending(void);
 extern void ext4_init_pending_tree(struct ext4_pending_tree *tree);
 extern void ext4_remove_pending(struct inode *inode, ext4_lblk_t lblk);
 extern bool ext4_is_pending(struct inode *inode, ext4_lblk_t lblk);
-extern void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
-					 bool allocated);
+extern void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
+					  ext4_lblk_t len, bool lclu_allocated,
+					  bool end_allocated);
 extern unsigned int ext4_es_delayed_clu(struct inode *inode, ext4_lblk_t lblk,
 					ext4_lblk_t len);
 extern void ext4_clear_inode_es(struct inode *inode);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 95f169801006..7918ae707716 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1673,7 +1673,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 		}
 	}
 
-	ext4_es_insert_delayed_block(inode, lblk, allocated);
+	ext4_es_insert_delayed_extent(inode, lblk, 1, allocated, false);
 	return 0;
 }
 
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index a697f4b77162..6b41ac61310f 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2478,11 +2478,11 @@ TRACE_EVENT(ext4_es_shrink,
 		  __entry->scan_time, __entry->nr_skipped, __entry->retried)
 );
 
-TRACE_EVENT(ext4_es_insert_delayed_block,
+TRACE_EVENT(ext4_es_insert_delayed_extent,
 	TP_PROTO(struct inode *inode, struct extent_status *es,
-		 bool allocated),
+		 bool lclu_allocated, bool end_allocated),
 
-	TP_ARGS(inode, es, allocated),
+	TP_ARGS(inode, es, lclu_allocated, end_allocated),
 
 	TP_STRUCT__entry(
 		__field(	dev_t,		dev		)
@@ -2491,7 +2491,8 @@ TRACE_EVENT(ext4_es_insert_delayed_block,
 		__field(	ext4_lblk_t,	len		)
 		__field(	ext4_fsblk_t,	pblk		)
 		__field(	char,		status		)
-		__field(	bool,		allocated	)
+		__field(	bool,		lclu_allocated	)
+		__field(	bool,		end_allocated	)
 	),
 
 	TP_fast_assign(
@@ -2501,16 +2502,17 @@ TRACE_EVENT(ext4_es_insert_delayed_block,
 		__entry->len		= es->es_len;
 		__entry->pblk		= ext4_es_show_pblock(es);
 		__entry->status		= ext4_es_status(es);
-		__entry->allocated	= allocated;
+		__entry->lclu_allocated	= lclu_allocated;
+		__entry->end_allocated	= end_allocated;
 	),
 
 	TP_printk("dev %d,%d ino %lu es [%u/%u) mapped %llu status %s "
-		  "allocated %d",
+		  "allocated %d %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  (unsigned long) __entry->ino,
 		  __entry->lblk, __entry->len,
 		  __entry->pblk, show_extent_status(__entry->status),
-		  __entry->allocated)
+		  __entry->lclu_allocated, __entry->end_allocated)
 );
 
 /* fsmap traces */
-- 
2.39.2


