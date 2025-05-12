Return-Path: <linux-fsdevel+bounces-48700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B13AB3003
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 08:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E8BD3A53C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 06:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F9D258CEB;
	Mon, 12 May 2025 06:44:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF6A2561BD;
	Mon, 12 May 2025 06:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747032296; cv=none; b=BrbLfkVDwRaZurT3slYvkEXpqD7OemlR5kcXl8WNxK7tlE37rkowZdsn4SFwIQL4Zcd4w5US8G0ui0/m+iTsDDVN5a8DmPUDiCFbxORUbYn8Y6RVM7YBMCeaL1/+i04IntgBbC7XCn3FjpgxpDnMWZ9KbHRfyXNkJmnu551JlKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747032296; c=relaxed/simple;
	bh=irdP3CzgURtsh6QuDJeADkTt5p41B+LOr+y+2gGkARU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXJowxYo2snmzl0eOe6zR4brFAH2iW+tAl6yvV43im2+2ffGGxYzCMdR47lJIq+vzD18wQ1290p6yfE5ZCYBayo49S4GRRQtKY5DhKeOT8OHHoaDu1K7ri9FJBoWe8moZx+SZSclc/V9ZLviVq6v9yiba/XafonnV1IK3wH65GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4Zwqps2DyNzKHMmf;
	Mon, 12 May 2025 14:44:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 008541A1C69;
	Mon, 12 May 2025 14:44:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgDHK2DXmCFoxF6sMA--.62010S11;
	Mon, 12 May 2025 14:44:51 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 7/8] ext4: make online defragmentation support large folios
Date: Mon, 12 May 2025 14:33:18 +0800
Message-ID: <20250512063319.3539411-8-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
References: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHK2DXmCFoxF6sMA--.62010S11
X-Coremail-Antispam: 1UD129KBjvJXoWxGr1fAryfKrW7WF4kJr13urg_yoW5XFW5pF
	y7Crn8KrW8Jas7Wws7JF4DZrn5Kas3Wr4UGFWfAr9xZFyjyry0gry8ta1rAayaqrZ7Ww1F
	vFWjkrnrX3ZrJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUljgxUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

move_extent_per_page() currently assumes that each folio is the size of
PAGE_SIZE and only copies data for one page. ext4_move_extents() should
call move_extent_per_page() for each page. To support larger folios,
simply modify the calculations for the block start and end offsets
within the folio based on the provided range of 'data_offset_in_page'
and 'block_len_in_page'. This function will continue to handle PAGE_SIZE
of data at a time and will not convert this function to manage an entire
folio. Additionally, we use the source folio to copy data, so it doesn't
matter if the source and dest folios are different in size.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/move_extent.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 48649be64d6a..1f8493a56e8f 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -269,7 +269,7 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 	unsigned int tmp_data_size, data_size, replaced_size;
 	int i, err2, jblocks, retries = 0;
 	int replaced_count = 0;
-	int from = data_offset_in_page << orig_inode->i_blkbits;
+	int from;
 	int blocks_per_page = PAGE_SIZE >> orig_inode->i_blkbits;
 	struct super_block *sb = orig_inode->i_sb;
 	struct buffer_head *bh = NULL;
@@ -323,11 +323,6 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 	 * hold page's lock, if it is still the case data copy is not
 	 * necessary, just swap data blocks between orig and donor.
 	 */
-
-	VM_BUG_ON_FOLIO(folio_test_large(folio[0]), folio[0]);
-	VM_BUG_ON_FOLIO(folio_test_large(folio[1]), folio[1]);
-	VM_BUG_ON_FOLIO(folio_nr_pages(folio[0]) != folio_nr_pages(folio[1]), folio[1]);
-
 	if (unwritten) {
 		ext4_double_down_write_data_sem(orig_inode, donor_inode);
 		/* If any of extents in range became initialized we have to
@@ -360,6 +355,8 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 		goto unlock_folios;
 	}
 data_copy:
+	from = offset_in_folio(folio[0],
+			       orig_blk_offset << orig_inode->i_blkbits);
 	*err = mext_page_mkuptodate(folio[0], from, from + replaced_size);
 	if (*err)
 		goto unlock_folios;
@@ -390,7 +387,7 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 	if (!bh)
 		bh = create_empty_buffers(folio[0],
 				1 << orig_inode->i_blkbits, 0);
-	for (i = 0; i < data_offset_in_page; i++)
+	for (i = 0; i < from >> orig_inode->i_blkbits; i++)
 		bh = bh->b_this_page;
 	for (i = 0; i < block_len_in_page; i++) {
 		*err = ext4_get_block(orig_inode, orig_blk_offset + i, bh, 0);
-- 
2.46.1


