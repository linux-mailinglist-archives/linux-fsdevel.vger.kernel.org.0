Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6231E3CEF39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 00:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389523AbhGSVfh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 17:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383767AbhGSSKR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:10:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61E6C0617A7;
        Mon, 19 Jul 2021 11:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vdlwBejAxJc0A/oAoZS0rkuvhx+5SsxgXdoh50bXO1A=; b=SX9p5G+peIEkXSMdc5vIdxs88f
        RwU1X7SjRf3lrgdK28iPf5QVPUuFMvmf1peTwW8ltbfqFGtgk0plIo4nEeoThLP2QggA8tcgKuQqZ
        X2kcBXIFqqvUqve03Xx4yRl+Ytk0XZVAZkc57fQnQcvKSfvj2qVXnM/HMooQyQrU5GENCSkXjVoIm
        ujqCYdTQTjbK7RtIvTYX+7zpa0jpk4q6XcwF+VkzT/Lr6hh5b9G7Wl0R6oMYDaz0SJ7M4mScOseYT
        ZxfNuAIm9P9D6slVquR69usQ7Mx6Mpp+xiVi6fS2pDNo52ZiANGDl772hzmHFu0kD6/u143/gsalB
        pGvXn+6A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5YK8-007MBx-F5; Mon, 19 Jul 2021 18:49:33 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v15 12/17] iomap: Convert iomap_page_mkwrite to use a folio
Date:   Mon, 19 Jul 2021 19:39:56 +0100
Message-Id: <20210719184001.1750630-13-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210719184001.1750630-1-willy@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we write to any page in a folio, we have to mark the entire
folio as dirty, and potentially COW the entire folio, because it'll
all get written back as one unit.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index dfb2eec520bd..dd05db36e135 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -953,21 +953,22 @@ iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 }
 EXPORT_SYMBOL_GPL(iomap_truncate_page);
 
-static loff_t
-iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
-		void *data, struct iomap *iomap, struct iomap *srcmap)
+static loff_t iomap_folio_mkwrite_actor(struct inode *inode, loff_t pos,
+		loff_t length, void *data, struct iomap *iomap,
+		struct iomap *srcmap)
 {
-	struct page *page = data;
+	struct folio *folio = data;
 	int ret;
 
 	if (iomap->flags & IOMAP_F_BUFFER_HEAD) {
-		ret = __block_write_begin_int(page, pos, length, NULL, iomap);
+		ret = __block_write_begin_int(&folio->page, pos, length, NULL,
+						iomap);
 		if (ret)
 			return ret;
-		block_commit_write(page, 0, length);
+		block_commit_write(&folio->page, 0, length);
 	} else {
-		WARN_ON_ONCE(!PageUptodate(page));
-		set_page_dirty(page);
+		WARN_ON_ONCE(!folio_test_uptodate(folio));
+		folio_mark_dirty(folio);
 	}
 
 	return length;
@@ -975,33 +976,33 @@ iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
 
 vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
 {
-	struct page *page = vmf->page;
+	struct folio *folio = page_folio(vmf->page);
 	struct inode *inode = file_inode(vmf->vma->vm_file);
-	unsigned long length;
-	loff_t offset;
+	size_t length;
+	loff_t pos;
 	ssize_t ret;
 
-	lock_page(page);
-	ret = page_mkwrite_check_truncate(page, inode);
+	folio_lock(folio);
+	ret = folio_mkwrite_check_truncate(folio, inode);
 	if (ret < 0)
 		goto out_unlock;
 	length = ret;
 
-	offset = page_offset(page);
+	pos = folio_pos(folio);
 	while (length > 0) {
-		ret = iomap_apply(inode, offset, length,
-				IOMAP_WRITE | IOMAP_FAULT, ops, page,
-				iomap_page_mkwrite_actor);
+		ret = iomap_apply(inode, pos, length,
+				IOMAP_WRITE | IOMAP_FAULT, ops, folio,
+				iomap_folio_mkwrite_actor);
 		if (unlikely(ret <= 0))
 			goto out_unlock;
-		offset += ret;
+		pos += ret;
 		length -= ret;
 	}
 
-	wait_for_stable_page(page);
+	folio_wait_stable(folio);
 	return VM_FAULT_LOCKED;
 out_unlock:
-	unlock_page(page);
+	folio_unlock(folio);
 	return block_page_mkwrite_return(ret);
 }
 EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
-- 
2.30.2

