Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B775EADED5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 20:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbfIIS1g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 14:27:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35792 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730720AbfIIS1g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 14:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=h8zMHCpnwN+r3QtQfEIESvTg1f4EQL98cPoBjx3kxwM=; b=mqwZi+lXsRulfBL8zJcvTDocb
        vdXRdO1Wz8zwlTzOszCOXjnZwDkWzlnGNIZNk/aSdULPPKssJ6XJGWkQG0txmkqT+G2fQphxEjC7E
        r9i9JsWKSeh14V9KV4Wui4PwQwI9CFNU5wlA+MPa0HF55rVWISvgpqJYac0KRVBWo0vwVJz+S4Qtq
        +Fe3UhIXZQMCNug7ubyp+s9C60BWVSpqol896n9zwTgHY+PO4j2quZltfYZFdYTbHu4P36Vc7SZkd
        H45zEnAI9w6kt4ZzisatKbl9LaQ8HwKBHkfl+1TgaMUFJ6pXIm7xhmeYQ8fmaJgP6JphODE1WQZAA
        TF3UqGgGA==;
Received: from [2001:4bb8:180:57ff:412:4333:4bf9:9db2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i7ONz-0001ug-A1; Mon, 09 Sep 2019 18:27:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/19] iomap: always use AOP_FLAG_NOFS in iomap_write_begin
Date:   Mon,  9 Sep 2019 20:27:06 +0200
Message-Id: <20190909182722.16783-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909182722.16783-1-hch@lst.de>
References: <20190909182722.16783-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All callers pass AOP_FLAG_NOFS, so lift that flag to iomap_write_begin
to allow reusing the flags arguments for an internal flags namespace
soon.  Also remove the local index variable that is only used once.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 2a9b41352495..33e03992d8a7 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -606,7 +606,6 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 		struct page **pagep, struct iomap *iomap)
 {
 	const struct iomap_page_ops *page_ops = iomap->page_ops;
-	pgoff_t index = pos >> PAGE_SHIFT;
 	struct page *page;
 	int status = 0;
 
@@ -621,7 +620,8 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 			return status;
 	}
 
-	page = grab_cache_page_write_begin(inode->i_mapping, index, flags);
+	page = grab_cache_page_write_begin(inode->i_mapping, pos >> PAGE_SHIFT,
+			AOP_FLAG_NOFS);
 	if (!page) {
 		status = -ENOMEM;
 		goto out_no_page;
@@ -763,7 +763,6 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	struct iov_iter *i = data;
 	long status = 0;
 	ssize_t written = 0;
-	unsigned int flags = AOP_FLAG_NOFS;
 
 	do {
 		struct page *page;
@@ -793,8 +792,7 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 			break;
 		}
 
-		status = iomap_write_begin(inode, pos, bytes, flags, &page,
-				iomap);
+		status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap);
 		if (unlikely(status))
 			break;
 
@@ -892,8 +890,7 @@ iomap_dirty_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		if (IS_ERR(rpage))
 			return PTR_ERR(rpage);
 
-		status = iomap_write_begin(inode, pos, bytes,
-					   AOP_FLAG_NOFS, &page, iomap);
+		status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap);
 		put_page(rpage);
 		if (unlikely(status))
 			return status;
@@ -944,8 +941,7 @@ static int iomap_zero(struct inode *inode, loff_t pos, unsigned offset,
 	struct page *page;
 	int status;
 
-	status = iomap_write_begin(inode, pos, bytes, AOP_FLAG_NOFS, &page,
-				   iomap);
+	status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap);
 	if (status)
 		return status;
 
-- 
2.20.1

