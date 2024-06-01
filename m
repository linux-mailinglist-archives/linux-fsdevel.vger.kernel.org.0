Return-Path: <linux-fsdevel+bounces-20688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5538D6DC7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 05:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF604284E93
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 03:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEF11F959;
	Sat,  1 Jun 2024 03:42:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EAEAD32;
	Sat,  1 Jun 2024 03:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717213325; cv=none; b=RpZHqGgFzhnxHqxak0We+DYybOq+PAbi8xVRJ0/NCXdA/rUl9HMwG7nKoXqhB65CFotPgV32kL3AZGjhxVIBJob1kS1RZMmVhKuWg1vz6J9S+CnN5wxlPy4JTiJRFkDzox21sXJteFzVHKceOuN1JtJJI5dVSGZiXqB9u39eiTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717213325; c=relaxed/simple;
	bh=uq2DmoTr2ZcCxYLZH1epSjEgMRCfHtIhb7PO3ysFAJY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rGK+HQMOKVnFqECgdY3TmHWTw+Jw/NEnD+1FVGfDAeKTxzwHVdFF864R1Aqj+umxlRN/3+5s8ycuGi3htTleohP3y/5J/1PKrTXVhIzZ9S+7e9S5xRWN6dTATekXxVF9lwfDYZsfDfkw/SFBzH/uVLahdjxcDgyhm6HAvdR6jpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vrm4l5NvYz4f3mHX;
	Sat,  1 Jun 2024 11:41:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A87821A0A99;
	Sat,  1 Jun 2024 11:41:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFumFpmHN_4OA--.4543S9;
	Sat, 01 Jun 2024 11:41:54 +0800 (CST)
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
Subject: [PATCH 05/10] ext4: count removed reserved blocks for delalloc only extent entry
Date: Sat,  1 Jun 2024 11:41:44 +0800
Message-Id: <20240601034149.2169771-6-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240601034149.2169771-1-yi.zhang@huaweicloud.com>
References: <20240601034149.2169771-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RFumFpmHN_4OA--.4543S9
X-Coremail-Antispam: 1UD129KBjvJXoWxtF1xKrWDWry7Ww4DCF1DAwb_yoW3XrWxpF
	W5WF15KrnxZ3409r4ftws7Zr1Sga40qayUJ34ak34ruF1rtrySvF18CFy2vFyrKrW8uw4j
	qFWYk34Uua1UKa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF18B
	UUUUU
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
index e54e15eb05b9..ced9826682bb 100644
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
@@ -1042,7 +1047,8 @@ int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
 }
 
 struct rsvd_count {
-	int ndelonly;
+	int ndelonly_cluster;
+	int ndelonly_block;
 	bool first_do_lblk_found;
 	ext4_lblk_t first_do_lblk;
 	ext4_lblk_t last_do_lblk;
@@ -1068,7 +1074,8 @@ static void init_rsvd(struct inode *inode, ext4_lblk_t lblk,
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct rb_node *node;
 
-	rc->ndelonly = 0;
+	rc->ndelonly_cluster = 0;
+	rc->ndelonly_block = 0;
 
 	/*
 	 * for bigalloc, note the first delonly block in the range has not
@@ -1116,11 +1123,13 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
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
@@ -1140,7 +1149,7 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
 	 * doesn't start with it, count it and stop tracking
 	 */
 	if (rc->partial && (rc->lclu != EXT4_B2C(sbi, i))) {
-		rc->ndelonly++;
+		rc->ndelonly_cluster++;
 		rc->partial = false;
 	}
 
@@ -1150,7 +1159,7 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
 	 */
 	if (EXT4_LBLK_COFF(sbi, i) != 0) {
 		if (end >= EXT4_LBLK_CFILL(sbi, i)) {
-			rc->ndelonly++;
+			rc->ndelonly_cluster++;
 			rc->partial = false;
 			i = EXT4_LBLK_CFILL(sbi, i) + 1;
 		}
@@ -1162,7 +1171,7 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
 	 */
 	if ((i + sbi->s_cluster_ratio - 1) <= end) {
 		nclu = (end - i + 1) >> sbi->s_cluster_bits;
-		rc->ndelonly += nclu;
+		rc->ndelonly_cluster += nclu;
 		i += nclu << sbi->s_cluster_bits;
 	}
 
@@ -1242,9 +1251,9 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 	if (sbi->s_cluster_ratio > 1) {
 		/* count any remaining partial cluster */
 		if (rc->partial)
-			rc->ndelonly++;
+			rc->ndelonly_cluster++;
 
-		if (rc->ndelonly == 0)
+		if (rc->ndelonly_cluster == 0)
 			return 0;
 
 		first_lclu = EXT4_B2C(sbi, rc->first_do_lblk);
@@ -1261,7 +1270,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 		while (es && ext4_es_end(es) >=
 		       EXT4_LBLK_CMASK(sbi, rc->first_do_lblk)) {
 			if (ext4_es_is_delonly(es)) {
-				rc->ndelonly--;
+				rc->ndelonly_cluster--;
 				left_delonly = true;
 				break;
 			}
@@ -1281,7 +1290,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 			while (es && es->es_lblk <=
 			       EXT4_LBLK_CFILL(sbi, rc->last_do_lblk)) {
 				if (ext4_es_is_delonly(es)) {
-					rc->ndelonly--;
+					rc->ndelonly_cluster--;
 					right_delonly = true;
 					break;
 				}
@@ -1327,7 +1336,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 		if (count_pending) {
 			pr = __pr_tree_search(&tree->root, first_lclu);
 			while (pr && pr->lclu <= last_lclu) {
-				rc->ndelonly--;
+				rc->ndelonly_cluster--;
 				node = rb_next(&pr->rb_node);
 				rb_erase(&pr->rb_node, &tree->root);
 				__free_pending(pr);
@@ -1338,7 +1347,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 			}
 		}
 	}
-	return rc->ndelonly;
+	return rc->ndelonly_cluster;
 }
 
 
@@ -1348,16 +1357,17 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
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
@@ -1367,11 +1377,15 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
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
@@ -1469,8 +1483,10 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
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
@@ -1489,8 +1505,8 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 			   ext4_lblk_t len)
 {
 	ext4_lblk_t end;
+	struct rsvd_info rinfo;
 	int err = 0;
-	int reserved = 0;
 	struct extent_status *es = NULL;
 
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
@@ -1515,7 +1531,7 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	 * is reclaimed.
 	 */
 	write_lock(&EXT4_I(inode)->i_es_lock);
-	err = __es_remove_extent(inode, lblk, end, &reserved, es);
+	err = __es_remove_extent(inode, lblk, end, &rinfo, es);
 	/* Free preallocated extent if it didn't get used. */
 	if (es) {
 		if (!es->es_len)
@@ -1527,7 +1543,7 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 		goto retry;
 
 	ext4_es_print_tree(inode);
-	ext4_da_release_space(inode, reserved);
+	ext4_da_release_space(inode, rinfo.delonly_cluster);
 	return;
 }
 
-- 
2.31.1


