Return-Path: <linux-fsdevel+bounces-24868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D89945D85
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 13:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB87283F8B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 11:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1721E672B;
	Fri,  2 Aug 2024 11:55:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94AF1E3CC2;
	Fri,  2 Aug 2024 11:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722599710; cv=none; b=JsBKKYdfAR/DvpaCBFJD/I0/Z6Wse2N4aVCFwf08eKDjDlCCDTz60FGwhegpBWyaZYdWP52Zu7IJg76wEG6pTxQIpVV58dbL0TU5wWA963LFrIs+SxUBKYMCFE2179GzJa0yS2XsIvyX83z2WV0RY0fGpzHhYxmOprBCJXfHu1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722599710; c=relaxed/simple;
	bh=uFZUtc/yjnDXIk7Jef/o/A5WQYSWixEKKGXOdHr6qRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZmxfPmR9ENlxdKl7EjpjD4Ysxni1H50yLNlhcpjTqOcgfnfQ6+vNN56oHncKiBfs5PcLJsHok8I3hPDOYa5Jf24LKektXyEmn8+c06NA5yFSfUKaAN3u+GRcx5yMnJaSWWfa+mKz22OBIxS/Ep9CvDsjJl1U8VubbZmdEPIbEwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wb4574FCqz4f3mHk;
	Fri,  2 Aug 2024 19:54:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A40121A17D5;
	Fri,  2 Aug 2024 19:55:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB3n4UJyaxmamI8Ag--.7970S11;
	Fri, 02 Aug 2024 19:55:05 +0800 (CST)
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
Subject: [PATCH v2 07/10] ext4: drop ext4_es_delayed_clu()
Date: Fri,  2 Aug 2024 19:51:17 +0800
Message-Id: <20240802115120.362902-8-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgB3n4UJyaxmamI8Ag--.7970S11
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1fZw4UZF4kJFyfJF1rtFb_yoWrGF1Dp3
	43try7JrW3Xw4j9a1xtw1xXr15t3Wqk3yUGr93t3WrKFyrAr1SkFnYyFyrZFyrtrWxZF1Y
	qFWj9a4UCF4jgFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUma14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7VU1zpBDUUUUU==
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
index 2daf61cfcf58..e482ac818317 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -2191,94 +2191,6 @@ void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
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


