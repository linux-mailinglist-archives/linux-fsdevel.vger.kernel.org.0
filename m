Return-Path: <linux-fsdevel+bounces-16591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7EA89FA55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 16:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85ED1F22ACE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 14:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C4A1802A8;
	Wed, 10 Apr 2024 14:38:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E6B179958;
	Wed, 10 Apr 2024 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712759923; cv=none; b=H1pGUpwdqmA5apPVMdS2OCQ4mKiXwCnywxvsH58KNUpSEFQJYX7gfj+4BFciHb7ut9Ox+PXvxz+yiml/Pf6mNlP4ztYCSstURJb75sjeO2VDsYg56LdHw9ziuFUIPs8cKaesN80Qkwb6xwf0Ylt7bWLFnq5hhqR7NOioouPRry0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712759923; c=relaxed/simple;
	bh=PbVMzklWWkeB+qOFt4ZXfDH2XYddz1UOIdfWIAItkEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FlsOlmXXWkDo4bMFZfOSJoU4QmvqX+YUehPsfpsGyCx8h4yE7aUFo0YIO5avaK6gcd4oDkJz4kGtX3QVrtTRWF5UOwDhjv4KmsZ8IiR6lgowDOvfgwtkt5dUIvq3hknTJb70s7VW4ZhpUQJcHOuaR8FFhUx8GXzkYDN/zv0YMKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VF56W3Ybnz4f3m7T;
	Wed, 10 Apr 2024 22:38:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2627E1A0568;
	Wed, 10 Apr 2024 22:38:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFSpBZmcwR8Jg--.63000S20;
	Wed, 10 Apr 2024 22:38:35 +0800 (CST)
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
Subject: [RFC PATCH v4 16/34] ext4: drop ext4_es_delayed_clu()
Date: Wed, 10 Apr 2024 22:29:30 +0800
Message-Id: <20240410142948.2817554-17-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAX6RFSpBZmcwR8Jg--.63000S20
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1fZw45Xw1xGrWrJF1rXrb_yoWrJFWDp3
	43try7JrW3Xw4v9a1xtw18Xr15t3Wqk3yUGr93t3WFkFyrAr1SkFnYyryfZFyrtrWxZF1Y
	qFWj9a4UCF4jgFDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	Jr1lIxAIcVC2z280aVCY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuYvjTRtOzsDU
	UUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

ext4_es_delayed_clu() and __es_delayed_clu() are not used, drop them.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents_status.c | 88 ----------------------------------------
 fs/ext4/extents_status.h |  2 -
 2 files changed, 90 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 75227f151b8f..9cac4ea57b73 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -2182,94 +2182,6 @@ void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
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
2.39.2


