Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAC075B0BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 16:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjGTOFH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 10:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjGTOFF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:05:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6351FD7;
        Thu, 20 Jul 2023 07:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mYeu0tyilbLfTglTrpUbKQUjimXqrsdI92ERouU7b00=; b=pfDrP84K4Ruw1GgshQgHzCQDme
        ++Yts7cPZnSbigxbVpQ//KJxOXm8sFa0ST/f3tVXzc4aoNC4NTzyGVWOsJs0CQ6BIng1WDivwIrxv
        cbwL0OaqvR6zPhBnHGiRdBvlmC3XeBQ4Xf/bQEJhRiXoAZEW+qaCdR+NL6pcGqu0AjW3ZyBoPuULc
        WRHzp62GGUcmNAPLYh+a/6YpTj0q2IUpeqzpUUUuDKNdq+4o+VyW/UcHE935/ZqiGfRVqQtrcIJ/W
        3Jci/0RWbpyIDvi3BZiP9uFT2dSiq+Zj480cqBscAOupKuyx3TGf1JfGUlFzaEhS4jnA8TDbHvNRU
        09ibZWpQ==;
Received: from [2001:4bb8:19a:298e:a587:c3ea:b692:5b8d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qMUH6-00BKof-0U;
        Thu, 20 Jul 2023 14:05:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] fs: rename and move block_page_mkwrite_return
Date:   Thu, 20 Jul 2023 16:04:48 +0200
Message-Id: <20230720140452.63817-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230720140452.63817-1-hch@lst.de>
References: <20230720140452.63817-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

block_page_mkwrite_return is neither block nor mkwrite specific, and
should not be under CONFIG_BLOCK.  Move it to mm.h and rename it to
vmf_fs_error.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/inode.c             |  2 +-
 fs/f2fs/file.c              |  2 +-
 fs/gfs2/file.c              | 16 ++++++++--------
 fs/iomap/buffered-io.c      |  2 +-
 fs/nilfs2/file.c            |  2 +-
 fs/udf/file.c               |  2 +-
 include/linux/buffer_head.h | 12 ------------
 include/linux/mm.h          | 18 ++++++++++++++++++
 8 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 43775a6ca5054a..6eea0886b88553 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6140,7 +6140,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	if (err == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
 		goto retry_alloc;
 out_ret:
-	ret = block_page_mkwrite_return(err);
+	ret = vmf_fs_error(err);
 out:
 	filemap_invalidate_unlock_shared(mapping);
 	sb_end_pagefault(inode->i_sb);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 093039dee99206..9b3871fb9bfc44 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -159,7 +159,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 	sb_end_pagefault(inode->i_sb);
 err:
-	return block_page_mkwrite_return(err);
+	return vmf_fs_error(err);
 }
 
 static const struct vm_operations_struct f2fs_file_vm_ops = {
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 1bf3c4453516f2..897ef62d6d77a7 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -432,7 +432,7 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &gh);
 	err = gfs2_glock_nq(&gh);
 	if (err) {
-		ret = block_page_mkwrite_return(err);
+		ret = vmf_fs_error(err);
 		goto out_uninit;
 	}
 
@@ -474,7 +474,7 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 
 	err = gfs2_rindex_update(sdp);
 	if (err) {
-		ret = block_page_mkwrite_return(err);
+		ret = vmf_fs_error(err);
 		goto out_unlock;
 	}
 
@@ -482,12 +482,12 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 	ap.target = data_blocks + ind_blocks;
 	err = gfs2_quota_lock_check(ip, &ap);
 	if (err) {
-		ret = block_page_mkwrite_return(err);
+		ret = vmf_fs_error(err);
 		goto out_unlock;
 	}
 	err = gfs2_inplace_reserve(ip, &ap);
 	if (err) {
-		ret = block_page_mkwrite_return(err);
+		ret = vmf_fs_error(err);
 		goto out_quota_unlock;
 	}
 
@@ -500,7 +500,7 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 	}
 	err = gfs2_trans_begin(sdp, rblocks, 0);
 	if (err) {
-		ret = block_page_mkwrite_return(err);
+		ret = vmf_fs_error(err);
 		goto out_trans_fail;
 	}
 
@@ -508,7 +508,7 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 	if (gfs2_is_stuffed(ip)) {
 		err = gfs2_unstuff_dinode(ip);
 		if (err) {
-			ret = block_page_mkwrite_return(err);
+			ret = vmf_fs_error(err);
 			goto out_trans_end;
 		}
 	}
@@ -524,7 +524,7 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 
 	err = gfs2_allocate_page_backing(page, length);
 	if (err)
-		ret = block_page_mkwrite_return(err);
+		ret = vmf_fs_error(err);
 
 out_page_locked:
 	if (ret != VM_FAULT_LOCKED)
@@ -558,7 +558,7 @@ static vm_fault_t gfs2_fault(struct vm_fault *vmf)
 	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
 	err = gfs2_glock_nq(&gh);
 	if (err) {
-		ret = block_page_mkwrite_return(err);
+		ret = vmf_fs_error(err);
 		goto out_uninit;
 	}
 	ret = filemap_fault(vmf);
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index adb92cdb24b009..0607790827b48a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1286,7 +1286,7 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
 	return VM_FAULT_LOCKED;
 out_unlock:
 	folio_unlock(folio);
-	return block_page_mkwrite_return(ret);
+	return vmf_fs_error(ret);
 }
 EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
 
diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
index a9eb3487efb2c2..740ce26d1e7657 100644
--- a/fs/nilfs2/file.c
+++ b/fs/nilfs2/file.c
@@ -108,7 +108,7 @@ static vm_fault_t nilfs_page_mkwrite(struct vm_fault *vmf)
 	wait_for_stable_page(page);
  out:
 	sb_end_pagefault(inode->i_sb);
-	return block_page_mkwrite_return(ret);
+	return vmf_fs_error(ret);
 }
 
 static const struct vm_operations_struct nilfs_file_vm_ops = {
diff --git a/fs/udf/file.c b/fs/udf/file.c
index 243840dc83addf..c0e2080e639eec 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -67,7 +67,7 @@ static vm_fault_t udf_page_mkwrite(struct vm_fault *vmf)
 		err = block_commit_write(page, 0, end);
 	if (err < 0) {
 		unlock_page(page);
-		ret = block_page_mkwrite_return(err);
+		ret = vmf_fs_error(err);
 		goto out_unlock;
 	}
 out_dirty:
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 6cb3e9af78c9ed..7002a9ff63a3da 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -291,18 +291,6 @@ int generic_cont_expand_simple(struct inode *inode, loff_t size);
 int block_commit_write(struct page *page, unsigned from, unsigned to);
 int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
 				get_block_t get_block);
-/* Convert errno to return value from ->page_mkwrite() call */
-static inline vm_fault_t block_page_mkwrite_return(int err)
-{
-	if (err == 0)
-		return VM_FAULT_LOCKED;
-	if (err == -EFAULT || err == -EAGAIN)
-		return VM_FAULT_NOPAGE;
-	if (err == -ENOMEM)
-		return VM_FAULT_OOM;
-	/* -ENOSPC, -EDQUOT, -EIO ... */
-	return VM_FAULT_SIGBUS;
-}
 sector_t generic_block_bmap(struct address_space *, sector_t, get_block_t *);
 int block_truncate_page(struct address_space *, loff_t, get_block_t *);
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2dd73e4f3d8e3a..75777eae1c9c26 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3386,6 +3386,24 @@ static inline vm_fault_t vmf_error(int err)
 	return VM_FAULT_SIGBUS;
 }
 
+/*
+ * Convert errno to return value for ->page_mkwrite() calls.
+ *
+ * This should eventually be merged with vmf_error() above, but will need a
+ * careful audit of all vmf_error() callers.
+ */
+static inline vm_fault_t vmf_fs_error(int err)
+{
+	if (err == 0)
+		return VM_FAULT_LOCKED;
+	if (err == -EFAULT || err == -EAGAIN)
+		return VM_FAULT_NOPAGE;
+	if (err == -ENOMEM)
+		return VM_FAULT_OOM;
+	/* -ENOSPC, -EDQUOT, -EIO ... */
+	return VM_FAULT_SIGBUS;
+}
+
 struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 			 unsigned int foll_flags);
 
-- 
2.39.2

