Return-Path: <linux-fsdevel+bounces-69356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FB0C77899
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 07:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 675394EA321
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 06:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A351D304BD6;
	Fri, 21 Nov 2025 06:10:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC872FFDED;
	Fri, 21 Nov 2025 06:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763705436; cv=none; b=RAYi6wm5e4ha3N5wKyUsJ/2aQ7RkHCY9eZ6K9TP8CrX0wgfQke5uaLVLVHUpo+2oSb/KxjRuK4sHiH+BNJNJTa0PFVxzLqFlkYhJau09P/ZQnwkFQR6AQo8n/9FpSF1wi6u1QE4JYlzmbZ1I0IYjZEFWQpKhOagPIQ6R6HePr4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763705436; c=relaxed/simple;
	bh=OZJLwBCrIAEq12lU7vFFrCObmgIi+k8a2wBnBYgJdM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VerV0Qn4C3gjjLheaI+TzyuOXDkZDg5E96iLhEGv9cRBlkrFbssWS45LUv3/mstTWjPIAN5wkeUOLK1xRv0KtG4cxnQm0jZ6gDdz/NdnPG8hx9Lb8xb/IluxKFWeoRrrhZgnDBY8eDFyzghD23WaWZrj6cdme/O/e/ZRZdCvU2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dCPvS2sF8zKHMgB;
	Fri, 21 Nov 2025 14:09:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 2A1921A0EE7;
	Fri, 21 Nov 2025 14:10:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP2 (Coremail) with SMTP id Syh0CgD3VHtAAiBp_of0BQ--.63807S14;
	Fri, 21 Nov 2025 14:10:26 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	yizhang089@gmail.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 10/13] ext4: make ext4_es_cache_extent() support overwrite existing extents
Date: Fri, 21 Nov 2025 14:08:08 +0800
Message-ID: <20251121060811.1685783-11-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgD3VHtAAiBp_of0BQ--.63807S14
X-Coremail-Antispam: 1UD129KBjvJXoWxury7GFW3Ar15Kw18JF4Utwb_yoWrArykp3
	9xCr15Jr18Xa4kKayfJa1UXr1rKw4rJrW7Jry3Kr1fCFy5JFyagF1jka4jvFyfWrW8Xr1Y
	vF40kw1UWa1DC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUQFxUUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Currently, ext4_es_cache_extent() is used to load extents into the
extent status tree when reading on-disk extent blocks. But it inserts
information into the extent status tree if and only if there isn't
information about the specified range already. So it only used for the
initial loading and does not support overwrit extents.

However, there are many other places in ext4 where on-disk extents are
inserted into the extent status tree, such as in ext4_map_query_blocks().
Currently, they call ext4_es_insert_extent() to perform the insertion,
but they don't modify the extents, so ext4_es_cache_extent() would be a
more appropriate choice. However, when ext4_map_query_blocks() inserts
an extent, it may overwrite a short existing extent of the same type.
Therefore, to prepare for the replacements, we need to extend
ext4_es_cache_extent() to allow it to overwrite existing extents with
the same status. So it checks the found extents before removing and
inserting. (There is one exception, a hole in the on-disk extent but a
delayed extent in the extent status tree is allowed.)

In addition, since cached extents can be more lenient than the extents
they modify and do not involve modifying reserved blocks, it is not
necessary to ensure that the insertion operation succeeds as strictly as
in the ext4_es_insert_extent() function.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents_status.c | 47 ++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 818007bb613f..2643d7a31e7b 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -1014,17 +1014,23 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 }
 
 /*
- * ext4_es_cache_extent() inserts information into the extent status
- * tree if and only if there isn't information about the range in
- * question already.
+ * ext4_es_cache_extent() inserts information into the extent status tree
+ * only if there is no existing information about the specified range or
+ * if the existing extents have the same status.
+ *
+ * Note that this interface is only used for caching on-disk extent
+ * information and cannot be used to convert existing extents in the extent
+ * status tree. To convert existing extents, use ext4_es_insert_extent()
+ * instead.
  */
 void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
 			  ext4_lblk_t len, ext4_fsblk_t pblk,
 			  unsigned int status)
 {
 	struct extent_status *es;
-	struct extent_status newes;
+	struct extent_status chkes, newes;
 	ext4_lblk_t end = lblk + len - 1;
+	bool conflict = false;
 
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 		return;
@@ -1040,11 +1046,38 @@ void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
 	BUG_ON(end < lblk);
 
 	write_lock(&EXT4_I(inode)->i_es_lock);
-
 	es = __es_tree_search(&EXT4_I(inode)->i_es_tree.root, lblk);
-	if (!es || es->es_lblk > end)
-		__es_insert_extent(inode, &newes, NULL);
+	if (es && es->es_lblk <= end) {
+		/* Found an extent that covers the entire range. */
+		if (es->es_lblk <= lblk && es->es_lblk + es->es_len > end) {
+			if (__es_check_extent_status(es, status, &chkes))
+				conflict = true;
+			goto unlock;
+		}
+		/* Check and remove all extents in range. */
+		if (__es_remove_extent(inode, lblk, end, status, NULL,
+				       &chkes, NULL)) {
+			conflict = true;
+			goto unlock;
+		}
+	}
+	__es_insert_extent(inode, &newes, NULL);
+unlock:
 	write_unlock(&EXT4_I(inode)->i_es_lock);
+	if (!conflict)
+		return;
+	/*
+	 * A hole in the on-disk extent but a delayed extent in the extent
+	 * status tree, is allowed.
+	 */
+	if (status == EXTENT_STATUS_HOLE &&
+	    ext4_es_type(&chkes) == EXTENT_STATUS_DELAYED)
+		return;
+
+	ext4_warning_inode(inode,
+			   "ES cache extent failed: add [%d,%d,%llu,0x%x] conflict with existing [%d,%d,%llu,0x%x]\n",
+			   lblk, len, pblk, status, chkes.es_lblk, chkes.es_len,
+			   ext4_es_pblock(&chkes), ext4_es_status(&chkes));
 }
 
 /*
-- 
2.46.1


