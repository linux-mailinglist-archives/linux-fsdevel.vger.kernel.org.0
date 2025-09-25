Return-Path: <linux-fsdevel+bounces-62708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77A3B9E5AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 11:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9467C386764
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 09:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED2C2F25FF;
	Thu, 25 Sep 2025 09:27:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962042EFD95;
	Thu, 25 Sep 2025 09:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792439; cv=none; b=fuVRrvXfaov9RwkuPtsGCErw1SkocIE4qQpAFbhDDShvWt/LaNmP29LmqCZUr8wB3mTyPodvtzFp5nmLF28Ak2HY3kr0M9cCy9cijMvi5UWEHUs87wVCQZENqO94PpumX5DOJM5qjxMaoufvnXPFyUPAqAu1VGQNiilhC0WdCgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792439; c=relaxed/simple;
	bh=QWOXgcdqSDDWYoKsf3nVNw523NVWijE0cZcGoJP9qQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bePWobUivyN8I15VSGeFkqLT6YNYBWKpsxBt9QoGQVZCnd3W6mcprgE0j+Kta7kQxilWBkYSgKX4w/vlWF1NtQsnnFN/5gp1qQ4rihUhOMHjD96jZ4j9puPCut9rS8ls5n4jfgKXftutZiAk8MhCt5YARKRK+K/Q4OCfvobDkW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cXSz70L9SzKHN6k;
	Thu, 25 Sep 2025 17:26:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id ED53F1A12FB;
	Thu, 25 Sep 2025 17:27:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with SMTP id gCh0CgD3CGHeCtVovAkNAw--.52999S16;
	Thu, 25 Sep 2025 17:27:06 +0800 (CST)
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
Subject: [PATCH v2 12/13] ext4: add large folios support for moving extents
Date: Thu, 25 Sep 2025 17:26:08 +0800
Message-ID: <20250925092610.1936929-13-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250925092610.1936929-1-yi.zhang@huaweicloud.com>
References: <20250925092610.1936929-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3CGHeCtVovAkNAw--.52999S16
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1xWrWrJr1rGFWUKrWruFg_yoW5Xw43pF
	1xKan3tFWkX34I9ry0qay7Zr15Ka4xtr4UWF4fGw1SyFyqvFyIgr1jy3WIvFyrtrW8ArWF
	qF4SkryUWa1Dt3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Pass the moving extent length into mext_folio_double_lock() so that it
can acquire a higher-order folio if the length exceeds PAGE_SIZE. This
can speed up extent moving when the extent is larger than one page.
Additionally, remove the unnecessary comments from
mext_folio_double_lock().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/move_extent.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 40cfc2625b33..0fa97c207274 100644
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
+			mext->orig_map.m_len << blkbits, folio);
 	if (ret)
 		return ret;
 
-- 
2.46.1


