Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633733E3FEA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 08:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbhHIG2A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 02:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbhHIG2A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 02:28:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2EAC0613CF;
        Sun,  8 Aug 2021 23:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gV3p5HVJ8FmxgQY9sNFvfUl5Pqu5FwTdLFprH/w8EkQ=; b=gLi43Atl5eV6fIG2RAfQwMJQzD
        8ZycFifZNxYX1tGY5zPtI03k1IcR2uBZIGPUz7fk2YoHhdapLtScFQ1rxSWyQLutmLkjjjds7yoMz
        dxBfkgDbL5L2aEppgSLNDoJiKMvpHf1Trpj4s5pRFteEHlHU8A2143S08PR8e1NUbuaWsLFojyXaH
        0/Y7EUynnajnSmCKbAJ1x8F53gwixYsjct5KoUmdsxMEsM4HXq5c+3HxHcWN3NmAbcEcix5I/WKY6
        mW2NZEC2YzSSWu0/UZIUbhh8hs/zVc39k3en47/WXdwkEVgEuiXkOKgWfOVB53OjRtXxi5opPIvn4
        PY31F50Q==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCyj9-00AhJ4-Pb; Mon, 09 Aug 2021 06:25:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: [PATCH 16/30] iomap: switch iomap_page_mkwrite to use iomap_iter
Date:   Mon,  9 Aug 2021 08:12:30 +0200
Message-Id: <20210809061244.1196573-17-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210809061244.1196573-1-hch@lst.de>
References: <20210809061244.1196573-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch iomap_page_mkwrite to use iomap_iter.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 3a23f7346938fb..5ab464937d4886 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -961,15 +961,15 @@ iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 }
 EXPORT_SYMBOL_GPL(iomap_truncate_page);
 
-static loff_t
-iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
-		void *data, struct iomap *iomap, struct iomap *srcmap)
+static loff_t iomap_page_mkwrite_iter(struct iomap_iter *iter,
+		struct page *page)
 {
-	struct page *page = data;
+	loff_t length = iomap_length(iter);
 	int ret;
 
-	if (iomap->flags & IOMAP_F_BUFFER_HEAD) {
-		ret = __block_write_begin_int(page, pos, length, NULL, iomap);
+	if (iter->iomap.flags & IOMAP_F_BUFFER_HEAD) {
+		ret = __block_write_begin_int(page, iter->pos, length, NULL,
+					      &iter->iomap);
 		if (ret)
 			return ret;
 		block_commit_write(page, 0, length);
@@ -983,29 +983,24 @@ iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
 
 vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
 {
+	struct iomap_iter iter = {
+		.inode		= file_inode(vmf->vma->vm_file),
+		.flags		= IOMAP_WRITE | IOMAP_FAULT,
+	};
 	struct page *page = vmf->page;
-	struct inode *inode = file_inode(vmf->vma->vm_file);
-	unsigned long length;
-	loff_t offset;
 	ssize_t ret;
 
 	lock_page(page);
-	ret = page_mkwrite_check_truncate(page, inode);
+	ret = page_mkwrite_check_truncate(page, iter.inode);
 	if (ret < 0)
 		goto out_unlock;
-	length = ret;
-
-	offset = page_offset(page);
-	while (length > 0) {
-		ret = iomap_apply(inode, offset, length,
-				IOMAP_WRITE | IOMAP_FAULT, ops, page,
-				iomap_page_mkwrite_actor);
-		if (unlikely(ret <= 0))
-			goto out_unlock;
-		offset += ret;
-		length -= ret;
-	}
+	iter.pos = page_offset(page);
+	iter.len = ret;
+	while ((ret = iomap_iter(&iter, ops)) > 0)
+		iter.processed = iomap_page_mkwrite_iter(&iter, page);
 
+	if (ret < 0)
+		goto out_unlock;
 	wait_for_stable_page(page);
 	return VM_FAULT_LOCKED;
 out_unlock:
-- 
2.30.2

