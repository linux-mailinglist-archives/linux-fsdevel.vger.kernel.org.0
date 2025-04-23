Return-Path: <linux-fsdevel+bounces-47072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 312C8A98499
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 11:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC25A189A5A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 09:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36DE25C809;
	Wed, 23 Apr 2025 09:03:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0931F4CAB;
	Wed, 23 Apr 2025 09:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745399013; cv=none; b=L5ZYmHgDnwMG9WyJsHru25s8LFF1PFumNaeuClmiAeHom7UEuM//ei1ji7gwE1MJAgPQTWRLmcQ+qWRjf/mu8MxDj7EH1OJ2qcXfpN4iK1tKIWjf/GplxCHuM1+gTVZiYAP7B+t527Ve1edB2epnfJGtHvU60MY0AaM8hgS7ZS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745399013; c=relaxed/simple;
	bh=yAlMglq+y6vsv7ewTFbaTZ+Cqsqx8wf8fK0bBboZhsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAIn6wCm9zp2hASJfS3pX1o7wcZxwmXoNJBm89l2IxZzgllz+2QNTAWAPqYIdPD0dWS7f9H1wPh0fFcNAke+eMVzP0aIbYAfjqhMvDxzsobwqX7dF3u4sMauRQySZqdi2nq/Y4afP3hcfmJM0HY64VRsAILkDCEFfoxb5aNoQtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZjCn21lYDz4f3jtT;
	Wed, 23 Apr 2025 17:03:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id D959E1A1C68;
	Wed, 23 Apr 2025 17:03:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP3 (Coremail) with SMTP id _Ch0CgAXacPQrAhoJkGrKA--.8976S5;
	Wed, 23 Apr 2025 17:03:20 +0800 (CST)
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
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 1/9] ext4: ext4: unify EXT4_EX_NOCACHE|NOFAIL flags in ext4_ext_remove_space()
Date: Wed, 23 Apr 2025 16:52:49 +0800
Message-ID: <20250423085257.122685-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250423085257.122685-1-yi.zhang@huaweicloud.com>
References: <20250423085257.122685-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAXacPQrAhoJkGrKA--.8976S5
X-Coremail-Antispam: 1UD129KBjvJXoWxWFW5tr43Ww18ur1fWw4kZwb_yoW5try3pr
	sIyFn5Gr4fW3409FWIqF47Zr1ag3W8Aa1UJFyfC3W3XFyUJ3s5KFyftFW5AFy5tFWruayF
	yFWrtw15Ga17KaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUxDGrUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

When removing space, we should use EXT4_EX_NOCACHE because we don't
need to cache extents, and we should also use EXT4_EX_NOFAIL to prevent
metadata inconsistencies that may arise from memory allocation failures.
While ext4_ext_remove_space() already uses these two flags in most
places, they are missing in ext4_ext_search_right() and
read_extent_tree_block() calls. Unify the flags to ensure consistent
behavior throughout the extent removal process.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c616a16a9f36..d8eac736cc9a 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1530,7 +1530,7 @@ static int ext4_ext_search_left(struct inode *inode,
 static int ext4_ext_search_right(struct inode *inode,
 				 struct ext4_ext_path *path,
 				 ext4_lblk_t *logical, ext4_fsblk_t *phys,
-				 struct ext4_extent *ret_ex)
+				 struct ext4_extent *ret_ex, int flags)
 {
 	struct buffer_head *bh = NULL;
 	struct ext4_extent_header *eh;
@@ -1604,7 +1604,8 @@ static int ext4_ext_search_right(struct inode *inode,
 	ix++;
 	while (++depth < path->p_depth) {
 		/* subtract from p_depth to get proper eh_depth */
-		bh = read_extent_tree_block(inode, ix, path->p_depth - depth, 0);
+		bh = read_extent_tree_block(inode, ix, path->p_depth - depth,
+					    flags);
 		if (IS_ERR(bh))
 			return PTR_ERR(bh);
 		eh = ext_block_hdr(bh);
@@ -1612,7 +1613,7 @@ static int ext4_ext_search_right(struct inode *inode,
 		put_bh(bh);
 	}
 
-	bh = read_extent_tree_block(inode, ix, path->p_depth - depth, 0);
+	bh = read_extent_tree_block(inode, ix, path->p_depth - depth, flags);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 	eh = ext_block_hdr(bh);
@@ -2821,6 +2822,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 	struct partial_cluster partial;
 	handle_t *handle;
 	int i = 0, err = 0;
+	int flags = EXT4_EX_NOCACHE | EXT4_EX_NOFAIL;
 
 	partial.pclu = 0;
 	partial.lblk = 0;
@@ -2851,8 +2853,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 		ext4_fsblk_t pblk;
 
 		/* find extent for or closest extent to this block */
-		path = ext4_find_extent(inode, end, NULL,
-					EXT4_EX_NOCACHE | EXT4_EX_NOFAIL);
+		path = ext4_find_extent(inode, end, NULL, flags);
 		if (IS_ERR(path)) {
 			ext4_journal_stop(handle);
 			return PTR_ERR(path);
@@ -2918,7 +2919,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 			 */
 			lblk = ex_end + 1;
 			err = ext4_ext_search_right(inode, path, &lblk, &pblk,
-						    NULL);
+						    NULL, flags);
 			if (err < 0)
 				goto out;
 			if (pblk) {
@@ -2994,8 +2995,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 				  i + 1, ext4_idx_pblock(path[i].p_idx));
 			memset(path + i + 1, 0, sizeof(*path));
 			bh = read_extent_tree_block(inode, path[i].p_idx,
-						    depth - i - 1,
-						    EXT4_EX_NOCACHE);
+						    depth - i - 1, flags);
 			if (IS_ERR(bh)) {
 				/* should we reset i_size? */
 				err = PTR_ERR(bh);
@@ -4314,7 +4314,8 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	if (err)
 		goto out;
 	ar.lright = map->m_lblk;
-	err = ext4_ext_search_right(inode, path, &ar.lright, &ar.pright, &ex2);
+	err = ext4_ext_search_right(inode, path, &ar.lright, &ar.pright,
+				    &ex2, 0);
 	if (err < 0)
 		goto out;
 
-- 
2.46.1


