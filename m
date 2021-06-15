Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F343A866E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 18:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhFOQ2s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 12:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhFOQ2r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:28:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5640EC061574;
        Tue, 15 Jun 2021 09:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=IgA0ITb/28gqrANhwnQlSfRMlKPHwC4hdag1REm1cwk=; b=C4+E1ozScipA1nQXxbmsIl9YiY
        PDF4SB9n/FiYOZLed38f+IRi3mr4QkVn+qihvf1cGnDcPebhDWz8DcJVm9SoBdwOrLhlBgTQd13Am
        Tr830zDOnT7Jrht8UN05LzR54YQEVZ3a2rbgbC8N2CnOSMZCLB5RCxRgyYdrYZ/p4v8kzdjDKFoRr
        PRFsMrfbLzlz+NLFKx5xc+1auNnwPPKx1iwS8FqhC7aHrO+/ikNJfhMu2SskonY8rwYLKfpbYQLf0
        HokflAUIUe9+U02OgNmw+XYRBLpsf/cKhTMMq0gyP3n8g6w2qJajlJoJxuc9ohsSYwOH/RYLCgBbA
        jWulEDrA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltBsC-0070Po-Rj; Tue, 15 Jun 2021 16:25:15 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 4/6] fs: Remove anon_set_page_dirty()
Date:   Tue, 15 Jun 2021 17:23:40 +0100
Message-Id: <20210615162342.1669332-5-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210615162342.1669332-1-willy@infradead.org>
References: <20210615162342.1669332-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use __set_page_dirty_no_writeback() instead.  This will set the dirty
bit on the page, which will be used to avoid calling set_page_dirty()
in the future.  It will have no effect on actually writing the page
back, as the pages are not on any LRU lists.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/libfs.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 2d7f086b93d6..3fdd89b156d6 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1217,19 +1217,10 @@ void kfree_link(void *p)
 }
 EXPORT_SYMBOL(kfree_link);
 
-/*
- * nop .set_page_dirty method so that people can use .page_mkwrite on
- * anon inodes.
- */
-static int anon_set_page_dirty(struct page *page)
-{
-	return 0;
-};
-
 struct inode *alloc_anon_inode(struct super_block *s)
 {
 	static const struct address_space_operations anon_aops = {
-		.set_page_dirty = anon_set_page_dirty,
+		.set_page_dirty = __set_page_dirty_no_writeback,
 	};
 	struct inode *inode = new_inode_pseudo(s);
 
-- 
2.30.2

