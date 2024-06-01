Return-Path: <linux-fsdevel+bounces-20690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 975D78D6DCC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 05:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57579285B2B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 03:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1600E37143;
	Sat,  1 Jun 2024 03:42:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2657101E2;
	Sat,  1 Jun 2024 03:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717213326; cv=none; b=pSmR9YXssL7zfXpHhL4prt4KoSW+6YhZ5n4sG2/QRK8MGndFcof5f5qb3pOUtgBVJqq1+EllI15LOLr36qOROgsmWBl6/6RagqTSKCFbJQLzi5Nr/i/R19FXgj2/a62b4Pfa7VHW7bX1Wih+FgI1t6BWxEO7DKrSTgattAb/380=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717213326; c=relaxed/simple;
	bh=EQypYngzAQHg/Zc5pHG0SgFtSQb6lhgy/tuxA8eUUQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OM7GpKy6jsnIzgh0YwJMslBnjBisLaN8J0i/rVJDgTC4rm01usSOfOS7f97OiALcGLmTPsYkL41wI9ojsOAe8ckaVNvp+fnlRnjki2MTWAhnh1kbXC3f5qbiL8knA+HIw7zPOefQqxprWeqigLYJB5czFnJtaIP4wIbCR6ufNTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Vrm4p1FXJz4f3jdL;
	Sat,  1 Jun 2024 11:41:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9AA251A0170;
	Sat,  1 Jun 2024 11:41:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFumFpmHN_4OA--.4543S11;
	Sat, 01 Jun 2024 11:41:55 +0800 (CST)
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
Subject: [PATCH 07/10] ext4: drop ext4_es_delayed_clu()
Date: Sat,  1 Jun 2024 11:41:46 +0800
Message-Id: <20240601034149.2169771-8-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAX6RFumFpmHN_4OA--.4543S11
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1fZw43Zry7CrWxKrWrAFb_yoWrGF1Dp3
	43try7JrW3Xw409a1xtw18Xr15t3Wqk3yUGr9ay3WrKFyrAr1SkFnYyFyrZFyrtrWxuF1Y
	qFWj9a4UCF4jgFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Since we move ext4_da_update_reserve_space() to ext4_es_insert_extent(),
no one uses ext4_es_delayed_clu() and __es_delayed_clu(), just drop
them.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents_status.c | 88 ----------------------------------------
 fs/ext4/extents_status.h |  2 -
 2 files changed, 90 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 841f2f6d536d..f28435b2618f 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -2189,94 +2189,6 @@ void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
 	return;
 }
 
-/*
- * __es_delayed_clu - count number of clusters containing blocks that
- *                    are delayed only
- *
- * @inode - file containing block range
- * @start - logical block defining start of range
- * @end - logical block defining end of range
- *
- * Returns the number of clusters containing only delayed (not delayed
- * and unwritten) blocks in the range specified by @start and @end.  Any
- * cluster or part of a cluster within the range and containing a delayed
- * and not unwritten block within the range is counted as a whole cluster.
- */
-static unsigned int __es_delayed_clu(struct inode *inode, ext4_lblk_t start,
-				     ext4_lblk_t end)
-{
-	struct ext4_es_tree *tree = &EXT4_I(inode)->i_es_tree;
-	struct extent_status *es;
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
-	struct rb_node *node;
-	ext4_lblk_t first_lclu, last_lclu;
-	unsigned long long last_counted_lclu;
-	unsigned int n = 0;
-
-	/* guaranteed to be unequal to any ext4_lblk_t value */
-	last_counted_lclu = ~0ULL;
-
-	es = __es_tree_search(&tree->root, start);
-
-	while (es && (es->es_lblk <= end)) {
-		if (ext4_es_is_delonly(es)) {
-			if (es->es_lblk <= start)
-				first_lclu = EXT4_B2C(sbi, start);
-			else
-				first_lclu = EXT4_B2C(sbi, es->es_lblk);
-
-			if (ext4_es_end(es) >= end)
-				last_lclu = EXT4_B2C(sbi, end);
-			else
-				last_lclu = EXT4_B2C(sbi, ext4_es_end(es));
-
-			if (first_lclu == last_counted_lclu)
-				n += last_lclu - first_lclu;
-			else
-				n += last_lclu - first_lclu + 1;
-			last_counted_lclu = last_lclu;
-		}
-		node = rb_next(&es->rb_node);
-		if (!node)
-			break;
-		es = rb_entry(node, struct extent_status, rb_node);
-	}
-
-	return n;
-}
-
-/*
- * ext4_es_delayed_clu - count number of clusters containing blocks that
- *                       are both delayed and unwritten
- *
- * @inode - file containing block range
- * @lblk - logical block defining start of range
- * @len - number of blocks in range
- *
- * Locking for external use of __es_delayed_clu().
- */
-unsigned int ext4_es_delayed_clu(struct inode *inode, ext4_lblk_t lblk,
-				 ext4_lblk_t len)
-{
-	struct ext4_inode_info *ei = EXT4_I(inode);
-	ext4_lblk_t end;
-	unsigned int n;
-
-	if (len == 0)
-		return 0;
-
-	end = lblk + len - 1;
-	WARN_ON(end < lblk);
-
-	read_lock(&ei->i_es_lock);
-
-	n = __es_delayed_clu(inode, lblk, end);
-
-	read_unlock(&ei->i_es_lock);
-
-	return n;
-}
-
 /*
  * __revise_pending - makes, cancels, or leaves unchanged pending cluster
  *                    reservations for a specified block range depending
diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index 3c8e2edee5d5..5b49cb3b9aff 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -252,8 +252,6 @@ extern bool ext4_is_pending(struct inode *inode, ext4_lblk_t lblk);
 extern void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
 					  ext4_lblk_t len, bool lclu_allocated,
 					  bool end_allocated);
-extern unsigned int ext4_es_delayed_clu(struct inode *inode, ext4_lblk_t lblk,
-					ext4_lblk_t len);
 extern void ext4_clear_inode_es(struct inode *inode);
 
 #endif /* _EXT4_EXTENTS_STATUS_H */
-- 
2.31.1


