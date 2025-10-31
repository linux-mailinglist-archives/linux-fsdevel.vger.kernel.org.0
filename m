Return-Path: <linux-fsdevel+bounces-66553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BE9C2369E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 07:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A2D3A5831
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 06:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6803D30B518;
	Fri, 31 Oct 2025 06:31:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595F622B8A6;
	Fri, 31 Oct 2025 06:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761892287; cv=none; b=p2xn36lKAZ6LEFP0kvacpIHTm45ydVj9xRnrIqIlJF5iGKdvc9iVTSjo4+OsqjTn52wt0eu0XVPTPEQmdzEfjDbb/ujighHP1A2u70lFzzhuSYGWN9RJg5F4XPzXoI03wYRa/jsNtpp/AT75PLJ8dkKHR1nUHA7RzlZI1IWKtho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761892287; c=relaxed/simple;
	bh=leoAbH0HXwb0I5NGo8h9qWyQO0l6o+QHE2KaGPaDlNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W86KzrVnaeAip6C2KP5vTe3GloYRs2sUzoXLOZaKnrOLTYY6iL5OkpPAIUWCQ2ZjQgeodvkTzUtUL+z5RX+uxSvKntycGIczyYEiDLA2N+6oAg0amRkJUHIDLMFEnnY2jfK4N0LunCrS06dcJyzvNSeDotOMWLfPbOt/tN4jfs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cyWMj0ZZDzYQtkN;
	Fri, 31 Oct 2025 14:31:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 0BEB21A084B;
	Fri, 31 Oct 2025 14:31:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP2 (Coremail) with SMTP id Syh0CgBHnESuVwRpEFrWCA--.33311S5;
	Fri, 31 Oct 2025 14:31:20 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 1/4] ext4: make ext4_es_cache_extent() support overwrite existing extents
Date: Fri, 31 Oct 2025 14:29:02 +0800
Message-ID: <20251031062905.4135909-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20251031062905.4135909-1-yi.zhang@huaweicloud.com>
References: <20251031062905.4135909-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHnESuVwRpEFrWCA--.33311S5
X-Coremail-Antispam: 1UD129KBjvJXoWxury5KFWfGFy5Xr45ZFy8uFg_yoWrurW7pr
	9Ikr4UJrWrX34vkayxJa1UXr1rKa4fG3y7Ary7Kw1SkFy5XFySqF1UtayjvFyFgFW8XF1Y
	vF40kw1UGa15C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUqkskUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Currently, ext4_es_cache_extent() is used to load extents into the
extent status tree when reading on-disk extent blocks. Since it may be
called while moving or modifying the extent tree, so it does not
overwrite existing extents in the extent status tree and is only used
for the initial loading.

There are many other places in ext4 where on-disk extents are inserted
into the extent status tree, such as in ext4_map_query_blocks().
Currently, they call ext4_es_insert_extent() to perform the insertion,
but they don't modify the extents, so ext4_es_cache_extent() would be a
more appropriate choice. However, when ext4_map_query_blocks() inserts
an extent, it may overwrite a short existing extent of the same type.
Therefore, to prepare for the replacements, we need to extend
ext4_es_cache_extent() to allow it to overwrite existing extents with
the same type.

In addition, since cached extents can be more lenient than the extents
they modify and do not involve modifying reserved blocks, it is not
necessary to ensure that the insertion operation succeeds as strictly as
in the ext4_es_insert_extent() function.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c        |  4 ++--
 fs/ext4/extents_status.c | 28 +++++++++++++++++++++-------
 fs/ext4/extents_status.h |  2 +-
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index ca5499e9412b..c42ceb5aae37 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -537,12 +537,12 @@ static void ext4_cache_extents(struct inode *inode,
 
 		if (prev && (prev != lblk))
 			ext4_es_cache_extent(inode, prev, lblk - prev, ~0,
-					     EXTENT_STATUS_HOLE);
+					     EXTENT_STATUS_HOLE, false);
 
 		if (ext4_ext_is_unwritten(ex))
 			status = EXTENT_STATUS_UNWRITTEN;
 		ext4_es_cache_extent(inode, lblk, len,
-				     ext4_ext_pblock(ex), status);
+				     ext4_ext_pblock(ex), status, false);
 		prev = lblk + len;
 	}
 }
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 31dc0496f8d0..f9546ecf7340 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -986,13 +986,19 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 }
 
 /*
- * ext4_es_cache_extent() inserts information into the extent status
- * tree if and only if there isn't information about the range in
- * question already.
+ * ext4_es_cache_extent() inserts extent information into the extent status
+ * tree. If 'overwrite' is not set, it inserts extent only if there isn't
+ * information about the specified range. Otherwise, it overwrites the
+ * current information.
+ *
+ * Note that this interface is only used for caching on-disk extent
+ * information and cannot be used to convert existing extents in the extent
+ * status tree. To convert existing extents, use ext4_es_insert_extent()
+ * instead.
  */
 void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
 			  ext4_lblk_t len, ext4_fsblk_t pblk,
-			  unsigned int status)
+			  unsigned int status, bool overwrite)
 {
 	struct extent_status *es;
 	struct extent_status newes;
@@ -1012,10 +1018,18 @@ void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
 	BUG_ON(end < lblk);
 
 	write_lock(&EXT4_I(inode)->i_es_lock);
-
 	es = __es_tree_search(&EXT4_I(inode)->i_es_tree.root, lblk);
-	if (!es || es->es_lblk > end)
-		__es_insert_extent(inode, &newes, NULL);
+	if (es && es->es_lblk <= end) {
+		if (!overwrite)
+			goto unlock;
+
+		/* Only extents of the same type can be overwritten. */
+		WARN_ON_ONCE(ext4_es_type(es) != status);
+		if (__es_remove_extent(inode, lblk, end, NULL, NULL))
+			goto unlock;
+	}
+	__es_insert_extent(inode, &newes, NULL);
+unlock:
 	write_unlock(&EXT4_I(inode)->i_es_lock);
 }
 
diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index 8f9c008d11e8..415f7c223a46 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -139,7 +139,7 @@ extern void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 				  bool delalloc_reserve_used);
 extern void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
 				 ext4_lblk_t len, ext4_fsblk_t pblk,
-				 unsigned int status);
+				 unsigned int status, bool overwrite);
 extern void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 				  ext4_lblk_t len);
 extern void ext4_es_find_extent_range(struct inode *inode,
-- 
2.46.1


