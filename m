Return-Path: <linux-fsdevel+bounces-54117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D474AFB5D7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 16:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 585EC3B4DEA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 14:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566FC2D9ECF;
	Mon,  7 Jul 2025 14:23:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91622D8DAA;
	Mon,  7 Jul 2025 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898181; cv=none; b=cmuThspm3AByi6mGSC4Tbzv4uAdz3YuNAoLL0rog98bwxqlUmbdtSv5adX+I/tTtsecWIkCrqEIOrxqdU3I75R9L8ujZ2HL+dADygEtUiFAztEX+fUb/QP/q6idU0fRNhYWDrAmJtluGsbmqI5csHgF+STqo6pkITLWUfcW2jAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898181; c=relaxed/simple;
	bh=XO6d4bPTCkVk1lbDioUFFaw4Np8AxFS9/x8a88uVd08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSDkJ+KQfR2tLAUnfzwhaQ0syqqGQZgxdfcMX1VAZeksSHHuB2uu1cOKN66XakfQipD5S8VyepoJX/xc6Ifaj/aOrgQ65+zuHwXJthmbz1oFzd1vyj+B/8IYiwnpoL8oIL/Bk5t8v1nuQfIs9xl9qvzKy4Fw2sPU1tzdGtg4lVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bbRKb2NjlzKHMhj;
	Mon,  7 Jul 2025 22:22:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id C4C8E1A1A74;
	Mon,  7 Jul 2025 22:22:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP3 (Coremail) with SMTP id _Ch0CgBnxyQ22GtoNazLAw--.46745S8;
	Mon, 07 Jul 2025 22:22:57 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	sashal@kernel.org,
	naresh.kamboju@linaro.org,
	jiangqi903@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v4 04/11] ext4: refactor the block allocation process of ext4_page_mkwrite()
Date: Mon,  7 Jul 2025 22:08:07 +0800
Message-ID: <20250707140814.542883-5-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250707140814.542883-1-yi.zhang@huaweicloud.com>
References: <20250707140814.542883-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBnxyQ22GtoNazLAw--.46745S8
X-Coremail-Antispam: 1UD129KBjvJXoWxAF15KF4DGFW5WFyUXFWkJFb_yoWruF4Upr
	y3Kr95ur47u34DWFs3WF4DZF13Ka4vgrWUGFyxGr1fZ3W3trnxKF4rt3WvyF4UtrW3Xan2
	qF4UAFyUu3WjgrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjfUriihUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

The block allocation process and error handling in ext4_page_mkwrite()
is complex now. Refactor it by introducing a new helper function,
ext4_block_page_mkwrite(). It will call ext4_block_write_begin() to
allocate blocks instead of directly calling block_page_mkwrite().
Preparing to implement retry logic in a subsequent patch to address
situations where the reserved journal credits are insufficient.
Additionally, this modification will help prevent potential deadlocks
that may occur when waiting for folio writeback while holding the
transaction handle.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 95 ++++++++++++++++++++++++++-----------------------
 1 file changed, 50 insertions(+), 45 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index a59d148b9185..e73d5379b8f0 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6605,6 +6605,53 @@ static int ext4_bh_unmapped(handle_t *handle, struct inode *inode,
 	return !buffer_mapped(bh);
 }
 
+static int ext4_block_page_mkwrite(struct inode *inode, struct folio *folio,
+				   get_block_t get_block)
+{
+	handle_t *handle;
+	loff_t size;
+	unsigned long len;
+	int ret;
+
+	handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE,
+				    ext4_writepage_trans_blocks(inode));
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+
+	folio_lock(folio);
+	size = i_size_read(inode);
+	/* Page got truncated from under us? */
+	if (folio->mapping != inode->i_mapping || folio_pos(folio) > size) {
+		ret = -EFAULT;
+		goto out_error;
+	}
+
+	len = folio_size(folio);
+	if (folio_pos(folio) + len > size)
+		len = size - folio_pos(folio);
+
+	ret = ext4_block_write_begin(handle, folio, 0, len, get_block);
+	if (ret)
+		goto out_error;
+
+	if (!ext4_should_journal_data(inode)) {
+		block_commit_write(folio, 0, len);
+		folio_mark_dirty(folio);
+	} else {
+		ret = ext4_journal_folio_buffers(handle, folio, len);
+		if (ret)
+			goto out_error;
+	}
+	ext4_journal_stop(handle);
+	folio_wait_stable(folio);
+	return ret;
+
+out_error:
+	folio_unlock(folio);
+	ext4_journal_stop(handle);
+	return ret;
+}
+
 vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
@@ -6616,8 +6663,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	struct file *file = vma->vm_file;
 	struct inode *inode = file_inode(file);
 	struct address_space *mapping = inode->i_mapping;
-	handle_t *handle;
-	get_block_t *get_block;
+	get_block_t *get_block = ext4_get_block;
 	int retries = 0;
 
 	if (unlikely(IS_IMMUTABLE(inode)))
@@ -6685,46 +6731,9 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	/* OK, we need to fill the hole... */
 	if (ext4_should_dioread_nolock(inode))
 		get_block = ext4_get_block_unwritten;
-	else
-		get_block = ext4_get_block;
 retry_alloc:
-	handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE,
-				    ext4_writepage_trans_blocks(inode));
-	if (IS_ERR(handle)) {
-		ret = VM_FAULT_SIGBUS;
-		goto out;
-	}
-	/*
-	 * Data journalling can't use block_page_mkwrite() because it
-	 * will set_buffer_dirty() before do_journal_get_write_access()
-	 * thus might hit warning messages for dirty metadata buffers.
-	 */
-	if (!ext4_should_journal_data(inode)) {
-		err = block_page_mkwrite(vma, vmf, get_block);
-	} else {
-		folio_lock(folio);
-		size = i_size_read(inode);
-		/* Page got truncated from under us? */
-		if (folio->mapping != mapping || folio_pos(folio) > size) {
-			ret = VM_FAULT_NOPAGE;
-			goto out_error;
-		}
-
-		len = folio_size(folio);
-		if (folio_pos(folio) + len > size)
-			len = size - folio_pos(folio);
-
-		err = ext4_block_write_begin(handle, folio, 0, len,
-					     ext4_get_block);
-		if (!err) {
-			ret = VM_FAULT_SIGBUS;
-			if (ext4_journal_folio_buffers(handle, folio, len))
-				goto out_error;
-		} else {
-			folio_unlock(folio);
-		}
-	}
-	ext4_journal_stop(handle);
+	/* Start journal and allocate blocks */
+	err = ext4_block_page_mkwrite(inode, folio, get_block);
 	if (err == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
 		goto retry_alloc;
 out_ret:
@@ -6733,8 +6742,4 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	filemap_invalidate_unlock_shared(mapping);
 	sb_end_pagefault(inode->i_sb);
 	return ret;
-out_error:
-	folio_unlock(folio);
-	ext4_journal_stop(handle);
-	goto out;
 }
-- 
2.46.1


