Return-Path: <linux-fsdevel+bounces-16586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB1B89FA44
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 16:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B6D1F20EC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 14:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FF417B4E0;
	Wed, 10 Apr 2024 14:38:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79125179207;
	Wed, 10 Apr 2024 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712759920; cv=none; b=dewyg5OgT8G8LI9aDBYsIw8XPpWkB4jrhKQWQNZXCcK1rglOVy4j3/D+/Z5rtKuOr4pd7DrdIPrUnMUP4bndFJCJfI2fi5p5fXurSb2pDsgXre5S7UsIf5zLkZgFQ5Ze98Fjj22wfghwIvtfxkZc7n8f5iop1Odzt314M25sFGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712759920; c=relaxed/simple;
	bh=4tMA2vNZHD2ixLAjA/Ewoyi3qj6kIdLJZrbgH4O9fAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GqPBc0+syXf+pFOqXTKR+DvmyBkEfoFbU+li+9jphUJ5wo9/4m1LsyLqbY9lLlK4CpWMc138N9ShisFr43ofirxBwDzPCEHfWdCTdV0iww0gzi+igd7q4FS7czOywTgpmkn8Eig3eys0mGtZBm7p9FgeB7qWICIjy404PByHXgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VF56W2ZrRz4f3kj7;
	Wed, 10 Apr 2024 22:38:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 339311A0175;
	Wed, 10 Apr 2024 22:38:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFSpBZmcwR8Jg--.63000S17;
	Wed, 10 Apr 2024 22:38:33 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	david@fromorbit.com,
	willy@infradead.org,
	zokeefe@google.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	wangkefeng.wang@huawei.com
Subject: [RFC PATCH v4 13/34] ext4: let __revise_pending() return newly inserted pendings
Date: Wed, 10 Apr 2024 22:29:27 +0800
Message-Id: <20240410142948.2817554-14-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240410142948.2817554-1-yi.zhang@huaweicloud.com>
References: <20240410142948.2817554-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RFSpBZmcwR8Jg--.63000S17
X-Coremail-Antispam: 1UD129KBjvJXoWxKFyfXw47WrWkWF15AryrJFb_yoW7GF1xp3
	yY9as8CryrXw1jg3yFyF4UZr1Yg3W8JFWDXrZakrySkFyrJFyYkF10yF1avF1rCrWxJw13
	XFWjk34Uu3WUKaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I
	8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCF
	s4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFI
	xGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_tr0E3s1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4UJVWx
	Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7sRibyCP
	UUUUU==
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
index 952a38eaea0f..382a96c1bc5c 100644
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
@@ -2089,7 +2090,7 @@ void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
 		es1 = __es_alloc_extent(true);
 	if ((err1 || err2) && !es2)
 		es2 = __es_alloc_extent(true);
-	if (err1 || err2 || err3) {
+	if (err1 || err2 || err3 < 0) {
 		if (lclu_allocated && !pr1)
 			pr1 = __alloc_pending(true);
 		if (end_allocated && !pr2)
@@ -2119,7 +2120,7 @@ void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
 
 	if (lclu_allocated) {
 		err3 = __insert_pending(inode, lblk, &pr1);
-		if (err3 != 0)
+		if (err3 < 0)
 			goto error;
 		if (pr1) {
 			__free_pending(pr1);
@@ -2128,7 +2129,7 @@ void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
 	}
 	if (end_allocated) {
 		err3 = __insert_pending(inode, end, &pr2);
-		if (err3 != 0)
+		if (err3 < 0)
 			goto error;
 		if (pr2) {
 			__free_pending(pr2);
@@ -2137,7 +2138,7 @@ void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
 	}
 error:
 	write_unlock(&EXT4_I(inode)->i_es_lock);
-	if (err1 || err2 || err3)
+	if (err1 || err2 || err3 < 0)
 		goto retry;
 
 	ext4_es_print_tree(inode);
@@ -2247,7 +2248,9 @@ unsigned int ext4_es_delayed_clu(struct inode *inode, ext4_lblk_t lblk,
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
@@ -2257,6 +2260,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 	ext4_lblk_t end = lblk + len - 1;
 	ext4_lblk_t first, last;
 	bool f_del = false, l_del = false;
+	int pendings = 0;
 	int ret = 0;
 
 	if (len == 0)
@@ -2284,6 +2288,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 			ret = __insert_pending(inode, first, prealloc);
 			if (ret < 0)
 				goto out;
+			pendings += ret;
 		} else {
 			last = EXT4_LBLK_CMASK(sbi, end) +
 			       sbi->s_cluster_ratio - 1;
@@ -2295,6 +2300,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 				ret = __insert_pending(inode, last, prealloc);
 				if (ret < 0)
 					goto out;
+				pendings += ret;
 			} else
 				__remove_pending(inode, last);
 		}
@@ -2307,6 +2313,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 			ret = __insert_pending(inode, first, prealloc);
 			if (ret < 0)
 				goto out;
+			pendings += ret;
 		} else
 			__remove_pending(inode, first);
 
@@ -2318,9 +2325,10 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
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


