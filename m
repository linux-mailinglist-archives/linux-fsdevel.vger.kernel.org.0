Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D67637982C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 22:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhEJUOP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 16:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbhEJUOO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 16:14:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8A8C061574;
        Mon, 10 May 2021 13:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Av10VQK0cWDtBZkWDT+sFT3o0hxbN01FBpT7/7EgVmU=; b=pqle9OdGTq4YUSz5vuovTaxWDe
        3Ej5WR7cvvqJbUv+3XK4qTqo0qQUlrCWMgFWyPi2WFcQPzkUpVs344v5Tewj3eNpBvMzjNpuSarGz
        4ljgTdRxcF9zVhkjOKDlAy8WkL2dfCwROwgxP4tzxCIYLjfiLaJpybWj1MPaX6snt68X3awafReNl
        mTvpcDhFnJM3xYvHLlTZ6VLwBhRSOzU6SJtaQtgyFX/JdCr4lfjse6zQv+Sz8WU5+nfcMM2+8/uVu
        dt6wAtPLouz1YdaMLGt8iOWWFkZ209dTorbtNg4HLQWgfBFyKv7j5J0MWtaSs4PRxMT8AddHk6kyQ
        j0DdLmFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgCG3-006XZk-JS; Mon, 10 May 2021 20:12:28 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH] mm/filemap: Fix readahead return types
Date:   Mon, 10 May 2021 21:12:01 +0100
Message-Id: <20210510201201.1558972-1-willy@infradead.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A readahead request will not allocate more memory than can be represented
by a size_t, even on systems that have HIGHMEM available.  Change the
length functions from returning an loff_t to a size_t.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c  | 4 ++--
 include/linux/pagemap.h | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f2cd2034a87b..9023717c5188 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -394,7 +394,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 {
 	struct inode *inode = rac->mapping->host;
 	loff_t pos = readahead_pos(rac);
-	loff_t length = readahead_length(rac);
+	size_t length = readahead_length(rac);
 	struct iomap_readpage_ctx ctx = {
 		.rac	= rac,
 	};
@@ -402,7 +402,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 	trace_iomap_readahead(inode, readahead_count(rac));
 
 	while (length > 0) {
-		loff_t ret = iomap_apply(inode, pos, length, 0, ops,
+		ssize_t ret = iomap_apply(inode, pos, length, 0, ops,
 				&ctx, iomap_readahead_actor);
 		if (ret <= 0) {
 			WARN_ON_ONCE(ret == 0);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index a4bd41128bf3..e89df447fae3 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -997,9 +997,9 @@ static inline loff_t readahead_pos(struct readahead_control *rac)
  * readahead_length - The number of bytes in this readahead request.
  * @rac: The readahead request.
  */
-static inline loff_t readahead_length(struct readahead_control *rac)
+static inline size_t readahead_length(struct readahead_control *rac)
 {
-	return (loff_t)rac->_nr_pages * PAGE_SIZE;
+	return rac->_nr_pages * PAGE_SIZE;
 }
 
 /**
@@ -1024,7 +1024,7 @@ static inline unsigned int readahead_count(struct readahead_control *rac)
  * readahead_batch_length - The number of bytes in the current batch.
  * @rac: The readahead request.
  */
-static inline loff_t readahead_batch_length(struct readahead_control *rac)
+static inline size_t readahead_batch_length(struct readahead_control *rac)
 {
 	return rac->_batch_count * PAGE_SIZE;
 }
-- 
2.30.2

