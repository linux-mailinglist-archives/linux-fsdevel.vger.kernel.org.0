Return-Path: <linux-fsdevel+bounces-20685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE268D6DC0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 05:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 779041F235AC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 03:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F11014A84;
	Sat,  1 Jun 2024 03:42:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FD6AD31;
	Sat,  1 Jun 2024 03:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717213324; cv=none; b=BAvZbSTosJxtjg7L8uQBwOaVHRwIYn2aOGIWrBE1hBK4lgVk+s/nnFbOoPnKphL1cs5cly6ByxIV+egXPhGLJ8cvRq6jSlCFCuGUjzMZlxmj9mLULqvNy49+MTNjiU1k6oFCZ/U5ED3nzvAXSNH0QDSjaSLXNaIinWsIrwaQ0mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717213324; c=relaxed/simple;
	bh=vb5f09ANoCMjAADmZ26fTIjgIEf1Qbeyx6lKACB+osc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nfjj3I28rcag0OIoe7surKH1CsXBsz24x1hDDrgcmGutdgUZiEwrcRX6uYhdwbO/cJFQ2A1l/yo6Whjwq7pFiMeljz3lwi8DtIa9j11nAy9gKzfZHXTX5hlQ6Af5FYb9YM4417I1/XmCZqW/Pd9A/bJmUHaNHVCUVWzxnkiQVKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vrm4l22N3z4f3mHW;
	Sat,  1 Jun 2024 11:41:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 365511A0185;
	Sat,  1 Jun 2024 11:41:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFumFpmHN_4OA--.4543S8;
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
Subject: [PATCH 04/10] ext4: let __revise_pending() return newly inserted pendings
Date: Sat,  1 Jun 2024 11:41:43 +0800
Message-Id: <20240601034149.2169771-5-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAX6RFumFpmHN_4OA--.4543S8
X-Coremail-Antispam: 1UD129KBjvJXoWxKFyfXw47WrWkWF15AryrJFb_yoW7GF1xp3
	ya9as8CryrXw1jg3yFyF4UZr1Yg3W8JFWDXrZakrySyFWrJFy5KF10yF1avF1rCrWxJw13
	XFWjk34Uua1UKaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF18B
	UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Let __insert_pending() return 1 after successfully inserting a new
pending cluster, and also let __revise_pending() to return the number of
of newly inserted pendings.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents_status.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 084ea0a753ee..e54e15eb05b9 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -885,7 +885,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 		es1 = __es_alloc_extent(true);
 	if ((err1 || err2) && !es2)
 		es2 = __es_alloc_extent(true);
-	if ((err1 || err2 || err3) && revise_pending && !pr)
+	if ((err1 || err2 || err3 < 0) && revise_pending && !pr)
 		pr = __alloc_pending(true);
 	write_lock(&EXT4_I(inode)->i_es_lock);
 
@@ -913,7 +913,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 
 	if (revise_pending) {
 		err3 = __revise_pending(inode, lblk, len, &pr);
-		if (err3 != 0)
+		if (err3 < 0)
 			goto error;
 		if (pr) {
 			__free_pending(pr);
@@ -922,7 +922,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	}
 error:
 	write_unlock(&EXT4_I(inode)->i_es_lock);
-	if (err1 || err2 || err3)
+	if (err1 || err2 || err3 < 0)
 		goto retry;
 
 	ext4_es_print_tree(inode);
@@ -1931,7 +1931,7 @@ static struct pending_reservation *__get_pending(struct inode *inode,
  * @lblk - logical block in the cluster to be added
  * @prealloc - preallocated pending entry
  *
- * Returns 0 on successful insertion and -ENOMEM on failure.  If the
+ * Returns 1 on successful insertion and -ENOMEM on failure.  If the
  * pending reservation is already in the set, returns successfully.
  */
 static int __insert_pending(struct inode *inode, ext4_lblk_t lblk,
@@ -1975,6 +1975,7 @@ static int __insert_pending(struct inode *inode, ext4_lblk_t lblk,
 
 	rb_link_node(&pr->rb_node, parent, p);
 	rb_insert_color(&pr->rb_node, &tree->root);
+	ret = 1;
 
 out:
 	return ret;
@@ -2096,7 +2097,7 @@ void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
 		es1 = __es_alloc_extent(true);
 	if ((err1 || err2) && !es2)
 		es2 = __es_alloc_extent(true);
-	if (err1 || err2 || err3) {
+	if (err1 || err2 || err3 < 0) {
 		if (lclu_allocated && !pr1)
 			pr1 = __alloc_pending(true);
 		if (end_allocated && !pr2)
@@ -2126,7 +2127,7 @@ void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
 
 	if (lclu_allocated) {
 		err3 = __insert_pending(inode, lblk, &pr1);
-		if (err3 != 0)
+		if (err3 < 0)
 			goto error;
 		if (pr1) {
 			__free_pending(pr1);
@@ -2135,7 +2136,7 @@ void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
 	}
 	if (end_allocated) {
 		err3 = __insert_pending(inode, end, &pr2);
-		if (err3 != 0)
+		if (err3 < 0)
 			goto error;
 		if (pr2) {
 			__free_pending(pr2);
@@ -2144,7 +2145,7 @@ void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
 	}
 error:
 	write_unlock(&EXT4_I(inode)->i_es_lock);
-	if (err1 || err2 || err3)
+	if (err1 || err2 || err3 < 0)
 		goto retry;
 
 	ext4_es_print_tree(inode);
@@ -2254,7 +2255,9 @@ unsigned int ext4_es_delayed_clu(struct inode *inode, ext4_lblk_t lblk,
  *
  * Used after a newly allocated extent is added to the extents status tree.
  * Requires that the extents in the range have either written or unwritten
- * status.  Must be called while holding i_es_lock.
+ * status.  Must be called while holding i_es_lock. Returns number of new
+ * inserts pending cluster on insert pendings, returns 0 on remove pendings,
+ * return -ENOMEM on failure.
  */
 static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 			    ext4_lblk_t len,
@@ -2264,6 +2267,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 	ext4_lblk_t end = lblk + len - 1;
 	ext4_lblk_t first, last;
 	bool f_del = false, l_del = false;
+	int pendings = 0;
 	int ret = 0;
 
 	if (len == 0)
@@ -2291,6 +2295,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 			ret = __insert_pending(inode, first, prealloc);
 			if (ret < 0)
 				goto out;
+			pendings += ret;
 		} else {
 			last = EXT4_LBLK_CMASK(sbi, end) +
 			       sbi->s_cluster_ratio - 1;
@@ -2302,6 +2307,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 				ret = __insert_pending(inode, last, prealloc);
 				if (ret < 0)
 					goto out;
+				pendings += ret;
 			} else
 				__remove_pending(inode, last);
 		}
@@ -2314,6 +2320,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 			ret = __insert_pending(inode, first, prealloc);
 			if (ret < 0)
 				goto out;
+			pendings += ret;
 		} else
 			__remove_pending(inode, first);
 
@@ -2325,9 +2332,10 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 			ret = __insert_pending(inode, last, prealloc);
 			if (ret < 0)
 				goto out;
+			pendings += ret;
 		} else
 			__remove_pending(inode, last);
 	}
 out:
-	return ret;
+	return (ret < 0) ? ret : pendings;
 }
-- 
2.31.1


