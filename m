Return-Path: <linux-fsdevel+bounces-25774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1FE950536
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 14:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F38A11C22A0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 12:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00E519CCFC;
	Tue, 13 Aug 2024 12:39:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB1E1607B9;
	Tue, 13 Aug 2024 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552765; cv=none; b=i86rpYqt/DN2mLKOmcniLe+BRsFl2mK4gpcEdE6K3Sy7TidePdpt1ilFtY3gHh/Cy70SBKjrh6J1r34O2lPHn+HryzMR8YMfJcyGAXVLUuX2mYv+SdmvzAlutDYZXhtz75YgSNDi0PF0H/OvN+bDBa2PNZ+xpbnVNvQHGSIvsuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552765; c=relaxed/simple;
	bh=DjX4Dr1CAQuNOmHbIR5fG9Vcx3MSn1qjv3GW5dmsB3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rqwSWLbgoui/zYoDKsk4uWLhl+kInatlbvIgS4XWMoB1XcXp895M0j1odEKl/vqySE/llWsRpOAjOflWyXhrxTZu2P0H6ELDbRRKGeGXf89u23Rk6iEwnObSORZmmPrlUcAhs1s7fKeu3bsN729oJNsAyNyBImNfsAnikRTT2eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WjrY45jj9z4f3jMW;
	Tue, 13 Aug 2024 20:39:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7CAD51A1743;
	Tue, 13 Aug 2024 20:39:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBnj4XkU7tmejNSBg--.17625S8;
	Tue, 13 Aug 2024 20:39:18 +0800 (CST)
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
Subject: [PATCH v3 04/12] ext4: let __revise_pending() return newly inserted pendings
Date: Tue, 13 Aug 2024 20:34:44 +0800
Message-Id: <20240813123452.2824659-5-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240813123452.2824659-1-yi.zhang@huaweicloud.com>
References: <20240813123452.2824659-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnj4XkU7tmejNSBg--.17625S8
X-Coremail-Antispam: 1UD129KBjvJXoWxKFyfXw47WF4ktFW8Ar13Jwb_yoW7GF1xp3
	yY9F98CryrXw1jg3yFyF4UZr1Yg3W8tFWDXrZayrySkFWrJFyYkF10yF1avF1rCrWxJw13
	XFWjk34Uua1UKaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUma14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7VUbPC7UUUUUU==
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
index 024cd37d53b3..4d24b56cfaf0 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -887,7 +887,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 		es1 = __es_alloc_extent(true);
 	if ((err1 || err2) && !es2)
 		es2 = __es_alloc_extent(true);
-	if ((err1 || err2 || err3) && revise_pending && !pr)
+	if ((err1 || err2 || err3 < 0) && revise_pending && !pr)
 		pr = __alloc_pending(true);
 	write_lock(&EXT4_I(inode)->i_es_lock);
 
@@ -915,7 +915,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 
 	if (revise_pending) {
 		err3 = __revise_pending(inode, lblk, len, &pr);
-		if (err3 != 0)
+		if (err3 < 0)
 			goto error;
 		if (pr) {
 			__free_pending(pr);
@@ -924,7 +924,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	}
 error:
 	write_unlock(&EXT4_I(inode)->i_es_lock);
-	if (err1 || err2 || err3)
+	if (err1 || err2 || err3 < 0)
 		goto retry;
 
 	ext4_es_print_tree(inode);
@@ -1933,7 +1933,7 @@ static struct pending_reservation *__get_pending(struct inode *inode,
  * @lblk - logical block in the cluster to be added
  * @prealloc - preallocated pending entry
  *
- * Returns 0 on successful insertion and -ENOMEM on failure.  If the
+ * Returns 1 on successful insertion and -ENOMEM on failure.  If the
  * pending reservation is already in the set, returns successfully.
  */
 static int __insert_pending(struct inode *inode, ext4_lblk_t lblk,
@@ -1977,6 +1977,7 @@ static int __insert_pending(struct inode *inode, ext4_lblk_t lblk,
 
 	rb_link_node(&pr->rb_node, parent, p);
 	rb_insert_color(&pr->rb_node, &tree->root);
+	ret = 1;
 
 out:
 	return ret;
@@ -2098,7 +2099,7 @@ void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
 		es1 = __es_alloc_extent(true);
 	if ((err1 || err2) && !es2)
 		es2 = __es_alloc_extent(true);
-	if (err1 || err2 || err3) {
+	if (err1 || err2 || err3 < 0) {
 		if (lclu_allocated && !pr1)
 			pr1 = __alloc_pending(true);
 		if (end_allocated && !pr2)
@@ -2128,7 +2129,7 @@ void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
 
 	if (lclu_allocated) {
 		err3 = __insert_pending(inode, lblk, &pr1);
-		if (err3 != 0)
+		if (err3 < 0)
 			goto error;
 		if (pr1) {
 			__free_pending(pr1);
@@ -2137,7 +2138,7 @@ void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
 	}
 	if (end_allocated) {
 		err3 = __insert_pending(inode, end, &pr2);
-		if (err3 != 0)
+		if (err3 < 0)
 			goto error;
 		if (pr2) {
 			__free_pending(pr2);
@@ -2146,7 +2147,7 @@ void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
 	}
 error:
 	write_unlock(&EXT4_I(inode)->i_es_lock);
-	if (err1 || err2 || err3)
+	if (err1 || err2 || err3 < 0)
 		goto retry;
 
 	ext4_es_print_tree(inode);
@@ -2256,7 +2257,9 @@ unsigned int ext4_es_delayed_clu(struct inode *inode, ext4_lblk_t lblk,
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
@@ -2266,6 +2269,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 	ext4_lblk_t end = lblk + len - 1;
 	ext4_lblk_t first, last;
 	bool f_del = false, l_del = false;
+	int pendings = 0;
 	int ret = 0;
 
 	if (len == 0)
@@ -2293,6 +2297,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 			ret = __insert_pending(inode, first, prealloc);
 			if (ret < 0)
 				goto out;
+			pendings += ret;
 		} else {
 			last = EXT4_LBLK_CMASK(sbi, end) +
 			       sbi->s_cluster_ratio - 1;
@@ -2304,6 +2309,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 				ret = __insert_pending(inode, last, prealloc);
 				if (ret < 0)
 					goto out;
+				pendings += ret;
 			} else
 				__remove_pending(inode, last);
 		}
@@ -2316,6 +2322,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 			ret = __insert_pending(inode, first, prealloc);
 			if (ret < 0)
 				goto out;
+			pendings += ret;
 		} else
 			__remove_pending(inode, first);
 
@@ -2327,9 +2334,10 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
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
2.39.2


