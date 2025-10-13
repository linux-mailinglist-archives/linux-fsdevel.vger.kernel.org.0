Return-Path: <linux-fsdevel+bounces-63881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBCBBD123F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 03:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C6204EB302
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 01:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FF02F9995;
	Mon, 13 Oct 2025 01:52:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934792F60D5;
	Mon, 13 Oct 2025 01:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760320376; cv=none; b=PlMA0UqucnrvnaIlfdo+99b6C/QutdAKBRbbjOpEx6t7sJRlOWVHVhwtegD3Go3auH3X+VvWo3klIxIfoTsXUhbxucvB9UzTP20Z6Ao1IJLUD1DwP0jZoQCJVpKS4m2uPbaCBW7ZeXfGAJJienQ8Ae2MuUjpAQsOtUShI3oGNHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760320376; c=relaxed/simple;
	bh=uEV0f0q6Dssyvh6MuMOd07vJYkH9J9MKsoWDlGOziSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAxHX1LBL1klW+hlZW9rOmiEBaHmomlctLr9oWmphxoFjwahhiBOdLwFYpVA/kv/j42FClUNmlJcap3IQfCXv4dsgIxRHGF5dXuowOx3OQG7p5MAhQGpYZTuObDloW5kLsmsjEO3FSZgAsSv6hXNDsoy6H5KrvgnKW8o8c6GUPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4clL1s4PzpzYQtn6;
	Mon, 13 Oct 2025 09:52:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 35E421A0F70;
	Mon, 13 Oct 2025 09:52:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP2 (Coremail) with SMTP id Syh0CgCn_UVfW+xoNhu7AA--.53067S15;
	Mon, 13 Oct 2025 09:52:40 +0800 (CST)
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
Subject: [PATCH v4 11/12] ext4: add large folios support for moving extents
Date: Mon, 13 Oct 2025 09:51:27 +0800
Message-ID: <20251013015128.499308-12-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20251013015128.499308-1-yi.zhang@huaweicloud.com>
References: <20251013015128.499308-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCn_UVfW+xoNhu7AA--.53067S15
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1xWrWrJr1rGFW8XrWUurg_yoW5WrWkpF
	1fKan3tFWkX34I9ry0qay7ZrW5Ka4xtr48WF4fJw1SyFyqvFyIgr1jy3WIvFyrtrW8ArWF
	qF4SkryUWa1Dt3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUljgxUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Pass the moving extent length into mext_folio_double_lock() so that it
can acquire a higher-order folio if the length exceeds PAGE_SIZE. This
can speed up extent moving when the extent is larger than one page.
Additionally, remove the unnecessary comments from
mext_folio_double_lock().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/move_extent.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 933c2afed550..f04755c2165a 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -54,23 +54,14 @@ ext4_double_up_write_data_sem(struct inode *orig_inode,
 	up_write(&EXT4_I(donor_inode)->i_data_sem);
 }
 
-/**
- * mext_folio_double_lock - Grab and lock folio on both @inode1 and @inode2
- *
- * @inode1:	the inode structure
- * @inode2:	the inode structure
- * @index1:	folio index
- * @index2:	folio index
- * @folio:	result folio vector
- *
- * Grab two locked folio for inode's by inode order
- */
-static int
-mext_folio_double_lock(struct inode *inode1, struct inode *inode2,
-		      pgoff_t index1, pgoff_t index2, struct folio *folio[2])
+/* Grab and lock folio on both @inode1 and @inode2 by inode order. */
+static int mext_folio_double_lock(struct inode *inode1, struct inode *inode2,
+				  pgoff_t index1, pgoff_t index2, size_t len,
+				  struct folio *folio[2])
 {
 	struct address_space *mapping[2];
 	unsigned int flags;
+	fgf_t fgp_flags = FGP_WRITEBEGIN;
 
 	BUG_ON(!inode1 || !inode2);
 	if (inode1 < inode2) {
@@ -83,14 +74,15 @@ mext_folio_double_lock(struct inode *inode1, struct inode *inode2,
 	}
 
 	flags = memalloc_nofs_save();
-	folio[0] = __filemap_get_folio(mapping[0], index1, FGP_WRITEBEGIN,
+	fgp_flags |= fgf_set_order(len);
+	folio[0] = __filemap_get_folio(mapping[0], index1, fgp_flags,
 			mapping_gfp_mask(mapping[0]));
 	if (IS_ERR(folio[0])) {
 		memalloc_nofs_restore(flags);
 		return PTR_ERR(folio[0]);
 	}
 
-	folio[1] = __filemap_get_folio(mapping[1], index2, FGP_WRITEBEGIN,
+	folio[1] = __filemap_get_folio(mapping[1], index2, fgp_flags,
 			mapping_gfp_mask(mapping[1]));
 	memalloc_nofs_restore(flags);
 	if (IS_ERR(folio[1])) {
@@ -214,7 +206,8 @@ static int mext_move_begin(struct mext_data *mext, struct folio *folio[2],
 	orig_pos = ((loff_t)mext->orig_map.m_lblk) << blkbits;
 	donor_pos = ((loff_t)mext->donor_lblk) << blkbits;
 	ret = mext_folio_double_lock(orig_inode, donor_inode,
-			orig_pos >> PAGE_SHIFT, donor_pos >> PAGE_SHIFT, folio);
+			orig_pos >> PAGE_SHIFT, donor_pos >> PAGE_SHIFT,
+			((size_t)mext->orig_map.m_len) << blkbits, folio);
 	if (ret)
 		return ret;
 
-- 
2.46.1


