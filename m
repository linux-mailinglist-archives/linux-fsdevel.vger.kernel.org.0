Return-Path: <linux-fsdevel+bounces-70227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56778C93C90
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 11:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B3C3AD3BD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 10:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4682D1319;
	Sat, 29 Nov 2025 10:35:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF9A2C0268;
	Sat, 29 Nov 2025 10:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764412546; cv=none; b=spnnTzrblRSmtDE0sEvuNc7mcZBsSwZvri2gpyqoyiddLC4OyPPs2/eAW0ofD8NURI8zxvjK+/TFbV/FLld8HNxakX7iE6lc42hyFnMyuGy3KwmfUe35RWoNloRnv4iPqX/1PR7pcox14CxMaj08T1L21qxilIkPfjorBQUZPBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764412546; c=relaxed/simple;
	bh=w2SaBpsWy6o6mWPdQStJIN2ayFwYAVI1TulknmC9MnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXqNyNrwkTxKxrOKit02N+09aWhlaLoDd6ALvykCiphN5bzw8k73Na/rJYrzyOfEndSxD44lhEOb5c1kyXKNiq7lVbaQn0+SeZ0AKxxgS8zYLCOSbboK57BJnAUR26xBFH3wPMGWs1lJmjE+Ymmk3eJkxYGSY9YwPfsqFLWCE7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dJRPM6Sm8zKHMRN;
	Sat, 29 Nov 2025 18:34:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 189EA1A1727;
	Sat, 29 Nov 2025 18:35:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP2 (Coremail) with SMTP id Syh0CgAnhXtfzCpp_56qCQ--.62661S14;
	Sat, 29 Nov 2025 18:35:30 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	yizhang089@gmail.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v3 10/14] ext4: make __es_remove_extent() check extent status
Date: Sat, 29 Nov 2025 18:32:42 +0800
Message-ID: <20251129103247.686136-11-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20251129103247.686136-1-yi.zhang@huaweicloud.com>
References: <20251129103247.686136-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAnhXtfzCpp_56qCQ--.62661S14
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr1DCF1DGw47WFyfJw4Dtwb_yoW7urW8pF
	ZrZr1UGryUXayI93yxtw1UWr1ag3W0krW7JrZxKw1fuF15Jrya9F10yFy2vF9YqrW0g3WU
	ZF40yw1UGa12ga7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUWMKtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Currently, __es_remove_extent() unconditionally removes extent status
entries within the specified range. In order to prepare for extending
the ext4_es_cache_extent() function to cache on-disk extents, which may
overwrite some existing short-length extents with the same status, allow
__es_remove_extent() to check the specified extent type before removing
it, and return error and pass out the conflicting extent if the status
does not match.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/extents_status.c | 49 +++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 04d56f8f6c0c..818007bb613f 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -178,7 +178,8 @@ static struct kmem_cache *ext4_pending_cachep;
 static int __es_insert_extent(struct inode *inode, struct extent_status *newes,
 			      struct extent_status *prealloc);
 static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
-			      ext4_lblk_t end, int *reserved,
+			      ext4_lblk_t end, unsigned int status,
+			      int *reserved, struct extent_status *res,
 			      struct extent_status *prealloc);
 static int es_reclaim_extents(struct ext4_inode_info *ei, int *nr_to_scan);
 static int __es_shrink(struct ext4_sb_info *sbi, int nr_to_scan,
@@ -242,6 +243,21 @@ static inline void ext4_es_inc_seq(struct inode *inode)
 	WRITE_ONCE(ei->i_es_seq, ei->i_es_seq + 1);
 }
 
+static inline int __es_check_extent_status(struct extent_status *es,
+					   unsigned int status,
+					   struct extent_status *res)
+{
+	if (ext4_es_type(es) & status)
+		return 0;
+
+	if (res) {
+		res->es_lblk = es->es_lblk;
+		res->es_len = es->es_len;
+		res->es_pblk = es->es_pblk;
+	}
+	return -EINVAL;
+}
+
 /*
  * search through the tree for an delayed extent with a given offset.  If
  * it can't be found, try to find next extent.
@@ -929,7 +945,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 		pr = __alloc_pending(true);
 	write_lock(&EXT4_I(inode)->i_es_lock);
 
-	err1 = __es_remove_extent(inode, lblk, end, &resv_used, es1);
+	err1 = __es_remove_extent(inode, lblk, end, 0, &resv_used, NULL, es1);
 	if (err1 != 0)
 		goto error;
 	/* Free preallocated extent if it didn't get used. */
@@ -1409,23 +1425,27 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 	return rc->ndelayed;
 }
 
-
 /*
  * __es_remove_extent - removes block range from extent status tree
  *
  * @inode - file containing range
  * @lblk - first block in range
  * @end - last block in range
+ * @status - the extent status to be checked
  * @reserved - number of cluster reservations released
+ * @res - return the extent if the status is not match
  * @prealloc - pre-allocated es to avoid memory allocation failures
  *
  * If @reserved is not NULL and delayed allocation is enabled, counts
  * block/cluster reservations freed by removing range and if bigalloc
- * enabled cancels pending reservations as needed. Returns 0 on success,
- * error code on failure.
+ * enabled cancels pending reservations as needed. If @status is not
+ * zero, check extent status type while removing extent, return -EINVAL
+ * and pass out the extent through @res if not match.  Returns 0 on
+ * success, error code on failure.
  */
 static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
-			      ext4_lblk_t end, int *reserved,
+			      ext4_lblk_t end, unsigned int status,
+			      int *reserved, struct extent_status *res,
 			      struct extent_status *prealloc)
 {
 	struct ext4_es_tree *tree = &EXT4_I(inode)->i_es_tree;
@@ -1440,6 +1460,8 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 
 	if (reserved == NULL || !test_opt(inode->i_sb, DELALLOC))
 		count_reserved = false;
+	if (status == 0)
+		status = ES_TYPE_MASK;
 
 	es = __es_tree_search(&tree->root, lblk);
 	if (!es)
@@ -1447,6 +1469,10 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	if (es->es_lblk > end)
 		return 0;
 
+	err = __es_check_extent_status(es, status, res);
+	if (err)
+		return err;
+
 	/* Simply invalidate cache_es. */
 	tree->cache_es = NULL;
 	if (count_reserved)
@@ -1509,6 +1535,9 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	}
 
 	while (es && ext4_es_end(es) <= end) {
+		err = __es_check_extent_status(es, status, res);
+		if (err)
+			return err;
 		if (count_reserved)
 			count_rsvd(inode, es->es_lblk, es->es_len, es, &rc);
 		node = rb_next(&es->rb_node);
@@ -1524,6 +1553,10 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	if (es && es->es_lblk < end + 1) {
 		ext4_lblk_t orig_len = es->es_len;
 
+		err = __es_check_extent_status(es, status, res);
+		if (err)
+			return err;
+
 		len1 = ext4_es_end(es) - end;
 		if (count_reserved)
 			count_rsvd(inode, es->es_lblk, orig_len - len1,
@@ -1581,7 +1614,7 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	 * is reclaimed.
 	 */
 	write_lock(&EXT4_I(inode)->i_es_lock);
-	err = __es_remove_extent(inode, lblk, end, &reserved, es);
+	err = __es_remove_extent(inode, lblk, end, 0, &reserved, NULL, es);
 	if (err)
 		goto error;
 	/* Free preallocated extent if it didn't get used. */
@@ -2173,7 +2206,7 @@ void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
 	}
 	write_lock(&EXT4_I(inode)->i_es_lock);
 
-	err1 = __es_remove_extent(inode, lblk, end, NULL, es1);
+	err1 = __es_remove_extent(inode, lblk, end, 0, NULL, NULL, es1);
 	if (err1 != 0)
 		goto error;
 	/* Free preallocated extent if it didn't get used. */
-- 
2.46.1


