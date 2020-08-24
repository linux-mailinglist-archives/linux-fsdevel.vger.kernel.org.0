Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A162500B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 17:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgHXPQP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 11:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgHXPG5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:06:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA472C06179B;
        Mon, 24 Aug 2020 07:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=pESaBZIQUbmTuqEp0QvjJ/1J69UiEMBwpDyvyHVUJqY=; b=pmIh7UfdQ7/LQD7SvCjLKXe2jy
        0wpFTf2dGM/ZnEtdSJ6epnFIKDfGNnUmnku83ljK6wvI7+Ma5sKSCeqldh0oMYxGDqhJ0VVWgJnAr
        YyJzxIouvgs33CASyOTuDV1IE5IsaqfkXgAMt8zOMVnRq1GwpJJAtVyGRlN7LHscQu423L4+u7ngi
        MA6urfnXaOMrQazL/Dmzgda2GTnaRR8SXJps6PnsT9FvflPmKRR2F38sm8X58SfTK0U8yVcJLfH3s
        hWnpZYdxqcumvCJs15ueYg11+t2L6Uq8w4XegKtsGHsJjONe3hX8+cDbjotp3oYfinH4VlGveQ0t7
        JqWe1kyQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kADsO-0002lv-VY; Mon, 24 Aug 2020 14:55:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] iomap: Fix misplaced page flushing
Date:   Mon, 24 Aug 2020 15:55:02 +0100
Message-Id: <20200824145511.10500-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200824145511.10500-1-willy@infradead.org>
References: <20200824145511.10500-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If iomap_unshare_actor() unshares to an inline iomap, the page was
not being flushed.  block_write_end() and __iomap_write_end() already
contain flushes, so adding it to iomap_write_end_inline() seems like
the best place.  That means we can remove it from iomap_write_actor().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index bcfc288dba3f..cffd575e57b6 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -715,6 +715,7 @@ iomap_write_end_inline(struct inode *inode, struct page *page,
 {
 	void *addr;
 
+	flush_dcache_page(page);
 	WARN_ON_ONCE(!PageUptodate(page));
 	BUG_ON(pos + copied > PAGE_SIZE - offset_in_page(iomap->inline_data));
 
@@ -811,8 +812,6 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 
 		copied = iov_iter_copy_from_user_atomic(page, i, offset, bytes);
 
-		flush_dcache_page(page);
-
 		status = iomap_write_end(inode, pos, bytes, copied, page, iomap,
 				srcmap);
 		if (unlikely(status < 0))
-- 
2.28.0

