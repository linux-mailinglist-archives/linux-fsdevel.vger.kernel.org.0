Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABF41F5CB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgFJUQD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730560AbgFJUNu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06E9C008633;
        Wed, 10 Jun 2020 13:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=NF4IbJ7tnb1BDecklJKAGawEVJngscEaY/hk+Y65vZs=; b=igTBtfUmXt8Mznyh9YOcO59toO
        3vqpDxaK4c26kTmcie0ib46b+joeV0vZI044ZEzVKnl9axARAjdnM5utCYzbPKHgKBNio/S2phuVn
        2ucEZ+AlaK7ZFrwiwb6G8bnHHA/6Y3Sck4HLUVAX4Piv1COkFXSTQG6BFlnNIIHNQFKdLXlj4G606
        jxBeKSdAi86B4Yxpk2/HYIhrKw23tZsWvZvfjsvKZOBJ+SRX1VtQ8+auhYf853jKeZ+weKscFrH5C
        ZRn3S3st12cQtogLDrb3CGF56kritIFeUu6l5naRJaSbRf1kWwDnehV03zRwIeaFvMdNdEwQpDkUV
        9sE8Iz4Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76a-0003WG-Ga; Wed, 10 Jun 2020 20:13:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 31/51] iomap: Handle tail pages in iomap_page_mkwrite
Date:   Wed, 10 Jun 2020 13:13:25 -0700
Message-Id: <20200610201345.13273-32-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200610201345.13273-1-willy@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

iomap_page_mkwrite() can be called with a tail page.  If we are,
operate on the head page, since we're treating the entire thing as a
single unit and the whole page is dirtied at the same time.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 318c1ecc18c0..8359e369c4b5 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1046,7 +1046,7 @@ iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
 
 vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
 {
-	struct page *page = vmf->page;
+	struct page *page = thp_head(vmf->page);
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	unsigned long length;
 	loff_t offset;
-- 
2.26.2

