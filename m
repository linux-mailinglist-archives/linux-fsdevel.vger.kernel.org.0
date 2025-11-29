Return-Path: <linux-fsdevel+bounces-70216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507CEC93C2E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 11:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29FB73A8893
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 10:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD7F27EFE9;
	Sat, 29 Nov 2025 10:35:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5775019C540;
	Sat, 29 Nov 2025 10:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764412535; cv=none; b=eQiFT4k6qZ1CZOGb6nVM7fNlQfLbKmhWTdOepPJFyBFZP/topCIl1PAoNH+B2UVdwyXiiVyp83gHB6Z347K45CoqeBWSNg/7V4eyG1vHx/BvUxBNMgIR6uLCysE96ZvHVan8F+sfuDD5GGi9MugeEEy/CYSTUCxPr8U3QMYXegA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764412535; c=relaxed/simple;
	bh=19oN0uEZyg2y4qgD3lZNb8ms2AUhmHEcoCmgnYUmYFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KP7JxcGIByHVT6uxuqov1e8SOFbYZoqVTxbhd4+PryCHOtM/vm7+TaguEyViVT8OLvWZi06phlTEm9bOfa3B9PSiNARBYYLZwxgBcSowd3kq2pd86KOZp1BLs8I9SeeUoujmbliuCCXDIUoRbSU9nQoFEkXBTd5NqcqFr7xKCKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dJRP62jyYzYQtpm;
	Sat, 29 Nov 2025 18:34:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 27F681A07C0;
	Sat, 29 Nov 2025 18:35:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP2 (Coremail) with SMTP id Syh0CgAnhXtfzCpp_56qCQ--.62661S15;
	Sat, 29 Nov 2025 18:35:30 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	yizhang089@gmail.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v3 11/14] ext4: make ext4_es_cache_extent() support overwrite existing extents
Date: Sat, 29 Nov 2025 18:32:43 +0800
Message-ID: <20251129103247.686136-12-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20251129103247.686136-1-yi.zhang@huaweicloud.com>
References: <20251129103247.686136-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAnhXtfzCpp_56qCQ--.62661S15
X-Coremail-Antispam: 1UD129KBjvJXoWxury7GFW3Ar15Kw18JF4Utwb_yoWrCr1xp3
	9xCr15Jr1kXa4kKa4fJa1UXry5Kw4rJrW7Jr93Kr1fCFy5JFyagF1jka4jvryfWrW8Xr1Y
	vF40kw1UGa1UC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUWMKtUUUUU=
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
Reviewed-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/extents_status.c | 50 ++++++++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 818007bb613f..48f04aef2f2e 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -1014,17 +1014,24 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
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
+	int err;
 
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 		return;
@@ -1040,11 +1047,40 @@ void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
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
+		err = __es_remove_extent(inode, lblk, end, status, NULL,
+					 &chkes, NULL);
+		if (err) {
+			if (err == -EINVAL)
+				conflict = true;
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


