Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C3A3C427F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 06:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhGLEDM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 00:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhGLEDM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 00:03:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B1AC0613DD;
        Sun, 11 Jul 2021 21:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=HQqE213t09Jer832hRItwdruUECZ/N6RyJ/+VNJTVco=; b=Va8/imOROLjMOcwoFsBDwibVcC
        LtUlx38bpOBDN9+BWpK/BjFTNi7B3n5AxNpJEPN8vBQWVGxtz1d10jhyOqCZwYMqmT+EL/rKaf6Fe
        Ccj8J3u1SUBosqRtbMhPEgxFXFyeUmeHWMw8i1oRK4wdbM4ZTbKfXNQIhf6IemmGqpz6GK5/H63gq
        vhaNjizS6y18xY8hiSk0V44GTg93TGmaquN9AsBBLHCX7v2OFLkOvRNwQZDasCbaRxagspDJDy55i
        e9LZ8aVYkeIs8+uRCMrDpeQiP93OO3RjuRt9NYQCkBxUCT08H0oyEROvUp0GWPfNXOVXVRnV/mgAL
        s2WpgCBg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2n6c-00GqUp-QM; Mon, 12 Jul 2021 03:59:49 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 100/137] iomap: Convert iomap_page_mkwrite to use a folio
Date:   Mon, 12 Jul 2021 04:06:24 +0100
Message-Id: <20210712030701.4000097-101-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we write to any page in a folio, we have to mark the entire
folio as dirty, and potentially COW the entire folio, because it'll
all get written back as one unit.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index bdce467ed5d3..2ecfebdd1f4f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -951,23 +951,23 @@ iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
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
-	struct folio *folio = page_folio(page);
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
+		WARN_ON_ONCE(!folio_uptodate(folio));
 		iomap_page_create(inode, folio);
-		set_page_dirty(page);
+		folio_mark_dirty(folio);
 	}
 
 	return length;
@@ -975,33 +975,33 @@ iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
 
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

