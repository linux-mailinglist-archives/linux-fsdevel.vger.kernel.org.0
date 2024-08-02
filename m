Return-Path: <linux-fsdevel+bounces-24866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAD6945D80
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 13:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B2CDB2325E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 11:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE201E4EFB;
	Fri,  2 Aug 2024 11:55:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CA71DF689;
	Fri,  2 Aug 2024 11:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722599710; cv=none; b=sn6Lifq5tcjYzz4pny5vwTFgdyHBNJeJs/70kKtc7qDXlpvXytbq57aWrSK8Z6q0mr5ek4XzLN9BuM/YEHItWOef4xcSHFiSQ6ySw/TMGZfU2xo/6o7TCI9GXV6L3hl/eNIG67OoexV8kiumSXJBlVvJcmQ4icpYulhdgngjE00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722599710; c=relaxed/simple;
	bh=fxTczSb2+GuZbxZXsMy3rzYnPpmFGUzePnHX8pxKImQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EA7U9Pv1UULL+ppJKGkw3GuEpy6D7QyYyS76kD5BR0oKs3oCZZ/d/nHryCLDsK9iS07VoN/b1KXMNA329VUtNDjnNzyeeCpi7LgxeHsKSAisYKIi8MX7ji16jqiO6FQg94juiKhlshYwjOYIAzWG1Tfv6IrVml/NAfVd0LGXNk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wb4575KN6z4f3jsB;
	Fri,  2 Aug 2024 19:54:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C31BC1A0E0F;
	Fri,  2 Aug 2024 19:55:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB3n4UJyaxmamI8Ag--.7970S9;
	Fri, 02 Aug 2024 19:55:04 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v2 05/10] ext4: count removed reserved blocks for delalloc only extent entry
Date: Fri,  2 Aug 2024 19:51:15 +0800
Message-Id: <20240802115120.362902-6-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240802115120.362902-1-yi.zhang@huaweicloud.com>
References: <20240802115120.362902-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3n4UJyaxmamI8Ag--.7970S9
X-Coremail-Antispam: 1UD129KBjvJXoWxtF1xKrWDWry7Ww4DCF1DAwb_yoW3XrWxpF
	W5WF15KrnxX3409r4ftws7Zr1Sga40qayUJ34ak34ruF18trySvF18CFyavFyrKrW8uw4q
	qFWYk34Uua1UKa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUriihUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

If bigalloc feature is enabled, __es_remove_extent() only counts
reserved clusters when removing delalloc extent entry, it doesn't count
reserved blocks. However, it's useful to distinguish whether we are
allocating blocks that contains a delalloc range in one cluster, so
let's count the reserved blocks number too.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents_status.c | 64 +++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 24 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 4d24b56cfaf0..3107e07ffe46 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -141,13 +141,18 @@
  *   -- Extent-level locking
  */
 
+struct rsvd_info {
+	int delonly_cluster;	/* reserved clusters for delalloc es entry */
+	int delonly_block;	/* reserved blocks for delalloc es entry */
+};
+
 static struct kmem_cache *ext4_es_cachep;
 static struct kmem_cache *ext4_pending_cachep;
 
 static int __es_insert_extent(struct inode *inode, struct extent_status *newes,
 			      struct extent_status *prealloc);
 static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
-			      ext4_lblk_t end, int *reserved,
+			      ext4_lblk_t end, struct rsvd_info *rinfo,
 			      struct extent_status *prealloc);
 static int es_reclaim_extents(struct ext4_inode_info *ei, int *nr_to_scan);
 static int __es_shrink(struct ext4_sb_info *sbi, int nr_to_scan,
@@ -1044,7 +1049,8 @@ int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
 }
 
 struct rsvd_count {
-	int ndelonly;
+	int ndelonly_cluster;
+	int ndelonly_block;
 	bool first_do_lblk_found;
 	ext4_lblk_t first_do_lblk;
 	ext4_lblk_t last_do_lblk;
@@ -1070,7 +1076,8 @@ static void init_rsvd(struct inode *inode, ext4_lblk_t lblk,
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct rb_node *node;
 
-	rc->ndelonly = 0;
+	rc->ndelonly_cluster = 0;
+	rc->ndelonly_block = 0;
 
 	/*
 	 * for bigalloc, note the first delonly block in the range has not
@@ -1118,11 +1125,13 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
 	WARN_ON(len <= 0);
 
 	if (sbi->s_cluster_ratio == 1) {
-		rc->ndelonly += (int) len;
+		rc->ndelonly_cluster += (int) len;
+		rc->ndelonly_block = rc->ndelonly_cluster;
 		return;
 	}
 
 	/* bigalloc */
+	rc->ndelonly_block += (int)len;
 
 	i = (lblk < es->es_lblk) ? es->es_lblk : lblk;
 	end = lblk + (ext4_lblk_t) len - 1;
@@ -1142,7 +1151,7 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
 	 * doesn't start with it, count it and stop tracking
 	 */
 	if (rc->partial && (rc->lclu != EXT4_B2C(sbi, i))) {
-		rc->ndelonly++;
+		rc->ndelonly_cluster++;
 		rc->partial = false;
 	}
 
@@ -1152,7 +1161,7 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
 	 */
 	if (EXT4_LBLK_COFF(sbi, i) != 0) {
 		if (end >= EXT4_LBLK_CFILL(sbi, i)) {
-			rc->ndelonly++;
+			rc->ndelonly_cluster++;
 			rc->partial = false;
 			i = EXT4_LBLK_CFILL(sbi, i) + 1;
 		}
@@ -1164,7 +1173,7 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
 	 */
 	if ((i + sbi->s_cluster_ratio - 1) <= end) {
 		nclu = (end - i + 1) >> sbi->s_cluster_bits;
-		rc->ndelonly += nclu;
+		rc->ndelonly_cluster += nclu;
 		i += nclu << sbi->s_cluster_bits;
 	}
 
@@ -1244,9 +1253,9 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 	if (sbi->s_cluster_ratio > 1) {
 		/* count any remaining partial cluster */
 		if (rc->partial)
-			rc->ndelonly++;
+			rc->ndelonly_cluster++;
 
-		if (rc->ndelonly == 0)
+		if (rc->ndelonly_cluster == 0)
 			return 0;
 
 		first_lclu = EXT4_B2C(sbi, rc->first_do_lblk);
@@ -1263,7 +1272,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 		while (es && ext4_es_end(es) >=
 		       EXT4_LBLK_CMASK(sbi, rc->first_do_lblk)) {
 			if (ext4_es_is_delonly(es)) {
-				rc->ndelonly--;
+				rc->ndelonly_cluster--;
 				left_delonly = true;
 				break;
 			}
@@ -1283,7 +1292,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 			while (es && es->es_lblk <=
 			       EXT4_LBLK_CFILL(sbi, rc->last_do_lblk)) {
 				if (ext4_es_is_delonly(es)) {
-					rc->ndelonly--;
+					rc->ndelonly_cluster--;
 					right_delonly = true;
 					break;
 				}
@@ -1329,7 +1338,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 		if (count_pending) {
 			pr = __pr_tree_search(&tree->root, first_lclu);
 			while (pr && pr->lclu <= last_lclu) {
-				rc->ndelonly--;
+				rc->ndelonly_cluster--;
 				node = rb_next(&pr->rb_node);
 				rb_erase(&pr->rb_node, &tree->root);
 				__free_pending(pr);
@@ -1340,7 +1349,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 			}
 		}
 	}
-	return rc->ndelonly;
+	return rc->ndelonly_cluster;
 }
 
 
@@ -1350,16 +1359,17 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
  * @inode - file containing range
  * @lblk - first block in range
  * @end - last block in range
- * @reserved - number of cluster reservations released
+ * @rinfo - reserved information collected, includes number of
+ *          block/cluster reservations released
  * @prealloc - pre-allocated es to avoid memory allocation failures
  *
- * If @reserved is not NULL and delayed allocation is enabled, counts
+ * If @rinfo is not NULL and delayed allocation is enabled, counts
  * block/cluster reservations freed by removing range and if bigalloc
  * enabled cancels pending reservations as needed. Returns 0 on success,
  * error code on failure.
  */
 static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
-			      ext4_lblk_t end, int *reserved,
+			      ext4_lblk_t end, struct rsvd_info *rinfo,
 			      struct extent_status *prealloc)
 {
 	struct ext4_es_tree *tree = &EXT4_I(inode)->i_es_tree;
@@ -1369,11 +1379,15 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	ext4_lblk_t len1, len2;
 	ext4_fsblk_t block;
 	int err = 0;
-	bool count_reserved = true;
+	bool count_reserved = false;
 	struct rsvd_count rc;
 
-	if (reserved == NULL || !test_opt(inode->i_sb, DELALLOC))
-		count_reserved = false;
+	if (rinfo) {
+		rinfo->delonly_cluster = 0;
+		rinfo->delonly_block = 0;
+		if (test_opt(inode->i_sb, DELALLOC))
+			count_reserved = true;
+	}
 
 	es = __es_tree_search(&tree->root, lblk);
 	if (!es)
@@ -1471,8 +1485,10 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	}
 
 out_get_reserved:
-	if (count_reserved)
-		*reserved = get_rsvd(inode, end, es, &rc);
+	if (count_reserved) {
+		rinfo->delonly_cluster = get_rsvd(inode, end, es, &rc);
+		rinfo->delonly_block = rc.ndelonly_block;
+	}
 out:
 	return err;
 }
@@ -1491,8 +1507,8 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 			   ext4_lblk_t len)
 {
 	ext4_lblk_t end;
+	struct rsvd_info rinfo;
 	int err = 0;
-	int reserved = 0;
 	struct extent_status *es = NULL;
 
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
@@ -1517,7 +1533,7 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	 * is reclaimed.
 	 */
 	write_lock(&EXT4_I(inode)->i_es_lock);
-	err = __es_remove_extent(inode, lblk, end, &reserved, es);
+	err = __es_remove_extent(inode, lblk, end, &rinfo, es);
 	/* Free preallocated extent if it didn't get used. */
 	if (es) {
 		if (!es->es_len)
@@ -1529,7 +1545,7 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 		goto retry;
 
 	ext4_es_print_tree(inode);
-	ext4_da_release_space(inode, reserved);
+	ext4_da_release_space(inode, rinfo.delonly_cluster);
 	return;
 }
 
-- 
2.39.2


