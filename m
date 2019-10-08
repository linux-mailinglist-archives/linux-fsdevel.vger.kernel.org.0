Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9860CCF34E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 09:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbfJHHPk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 03:15:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53436 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730057AbfJHHPj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=K6zUxcrwBNs4tsHrFrP9qY0S2RgWfgkTn1VDnXAGqbM=; b=piyEXE9qXQWkRSlkcLxdWwnPML
        ckdwqKb/OQguMHXTN5TR6sDgcnX2XnMguwohCxipyxVSwg6buXUBzyRJkZDwjpE5NX+AD7leOOWZv
        k4SxLzepH+JAQ6wcZy+LGwh+XtW7qsvxOvtv3TMjfy4bGlNlkTzZZx+qal2Invrt8LJ0TydLl6S7u
        wvo5JfQ1FNw+adKS95Picl2g0afRa7Kg/m/5FGmtFMxF46LCt0vSwMfUZPvpAG1vXRqYptoj5vBVw
        +mQwQ1Z8mnjZdYcQfWMtS+2BTMjEnepIQlsyHfU8nsDK2I5V5KyKk1/7StmGZa51taGMXbD7XXGK7
        RiRvHbaA==;
Received: from [2001:4bb8:188:141c:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHjid-0005eU-4s; Tue, 08 Oct 2019 07:15:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: [PATCH 03/20] iomap: always use AOP_FLAG_NOFS in iomap_write_begin
Date:   Tue,  8 Oct 2019 09:15:10 +0200
Message-Id: <20191008071527.29304-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008071527.29304-1-hch@lst.de>
References: <20191008071527.29304-1-hch@lst.de>
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
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/iomap/buffered-io.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 672f5d8efdbe..bf6a0e0b92a5 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -621,7 +621,6 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 		struct page **pagep, struct iomap *iomap)
 {
 	const struct iomap_page_ops *page_ops = iomap->page_ops;
-	pgoff_t index = pos >> PAGE_SHIFT;
 	struct page *page;
 	int status = 0;
 
@@ -636,7 +635,8 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 			return status;
 	}
 
-	page = grab_cache_page_write_begin(inode->i_mapping, index, flags);
+	page = grab_cache_page_write_begin(inode->i_mapping, pos >> PAGE_SHIFT,
+			AOP_FLAG_NOFS);
 	if (!page) {
 		status = -ENOMEM;
 		goto out_no_page;
@@ -778,7 +778,6 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	struct iov_iter *i = data;
 	long status = 0;
 	ssize_t written = 0;
-	unsigned int flags = AOP_FLAG_NOFS;
 
 	do {
 		struct page *page;
@@ -808,8 +807,7 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 			break;
 		}
 
-		status = iomap_write_begin(inode, pos, bytes, flags, &page,
-				iomap);
+		status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap);
 		if (unlikely(status))
 			break;
 
@@ -907,8 +905,7 @@ iomap_dirty_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		if (IS_ERR(rpage))
 			return PTR_ERR(rpage);
 
-		status = iomap_write_begin(inode, pos, bytes,
-					   AOP_FLAG_NOFS, &page, iomap);
+		status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap);
 		put_page(rpage);
 		if (unlikely(status))
 			return status;
@@ -959,8 +956,7 @@ static int iomap_zero(struct inode *inode, loff_t pos, unsigned offset,
 	struct page *page;
 	int status;
 
-	status = iomap_write_begin(inode, pos, bytes, AOP_FLAG_NOFS, &page,
-				   iomap);
+	status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap);
 	if (status)
 		return status;
 
-- 
2.20.1

