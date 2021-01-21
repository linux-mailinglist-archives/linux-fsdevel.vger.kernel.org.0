Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768D12FE0C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 05:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733197AbhAUEdB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 23:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729300AbhAUEcV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 23:32:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C71C061575
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jan 2021 20:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=L/kAHgpjppUCPJtFgtuXWn2k2U+9M1K3OHHff2LOzvg=; b=IbObjVQK/FbUqCBrRNWa8Y6jE0
        CKUqA4JoWZrMonCu4mo0QNWaAdZ/+XJXmy15tLqBUyPUYdAqiBRRs1d4wBwnNKBkIcLeIeNWegHnu
        n51nkbrnfyqp1oLh7Dou+qaorL+NyuDNJ2LyKsW3H4ZTDG3RMFaG+AWlTv2GbKG/3hS6JO+Pq8eQL
        tRSAXeeWf5GEZic6l8rXcXr3kQQuY06E+Sf1C3ywKl9TGaMPVyASDTiEdJ0XarKpAxilw36mAhsza
        RZH/lxHrHXXKr0n8Ec92svqv2e461EWnhDXcuP/iEGZG9iIQcRWnCCHTNU0+hPf65Ami0lVy3nvUi
        6CiEkHOQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2RaO-00GbkB-Nd; Thu, 21 Jan 2021 04:29:00 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH v4 16/18] mm/filemap: Don't relock the page after calling readpage
Date:   Thu, 21 Jan 2021 04:16:14 +0000
Message-Id: <20210121041616.3955703-17-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121041616.3955703-1-willy@infradead.org>
References: <20210121041616.3955703-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We don't need to get the page lock again; we just need to wait for
the I/O to finish, so use wait_on_page_locked_killable() like the
other callers of ->readpage.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 mm/filemap.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index e09f0f1209a90..5563bfe5e544b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2204,23 +2204,16 @@ static int filemap_read_page(struct file *file, struct address_space *mapping,
 	error = mapping->a_ops->readpage(file, page);
 	if (error)
 		return error;
-	if (PageUptodate(page))
-		return 0;
 
-	error = lock_page_killable(page);
+	error = wait_on_page_locked_killable(page);
 	if (error)
 		return error;
-	if (!PageUptodate(page)) {
-		if (page->mapping == NULL) {
-			/* page truncated */
-			error = AOP_TRUNCATED_PAGE;
-		} else {
-			shrink_readahead_size_eio(&file->f_ra);
-			error = -EIO;
-		}
-	}
-	unlock_page(page);
-	return error;
+	if (PageUptodate(page))
+		return 0;
+	if (!page->mapping)	/* page truncated */
+		return AOP_TRUNCATED_PAGE;
+	shrink_readahead_size_eio(&file->f_ra);
+	return -EIO;
 }
 
 static bool filemap_range_uptodate(struct address_space *mapping,
-- 
2.29.2

