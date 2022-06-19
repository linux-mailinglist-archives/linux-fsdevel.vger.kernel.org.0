Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FB7550B6E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jun 2022 17:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiFSPLx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jun 2022 11:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiFSPLv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jun 2022 11:11:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34352AE52;
        Sun, 19 Jun 2022 08:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rkDLWdA9qK6dJptJf/M5HrXtYhb5ttvBn9HErKKNMDI=; b=tmmoPedVacsHoBJuv77FbS1OIE
        7SC30HkfVjoJBDeZpX3j7OGOSuyv1LGvOS/awWV3auug2b3c7I/ens/EYBToPmtCdz0zIoLOHXJ39
        IiuJtdrJGFnx+KkF5jQywbM61r/8FFO2ymoz76cwqrNek1jICCAwHYhdwMnftyKJIx6WhCWFXO6X4
        UPqS0jgn1qeU7fRXgM4aAHBpgepX3EKHVoptrxqr2klZDX2Kb23EgkmjmnC1f5JOkXehYnd5JqR/U
        HvvcFM5kV8inFsizinujjrGoSQKLwq8X5M6qOWFW7PT2j3uJI6D7kHzUvq6OtHqlfo271eisrXDZI
        sYqmpVPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2waZ-004QOu-7l; Sun, 19 Jun 2022 15:11:47 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>
Subject: [PATCH 3/3] mm: Clear page->private when splitting or migrating a page
Date:   Sun, 19 Jun 2022 16:11:43 +0100
Message-Id: <20220619151143.1054746-4-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220619151143.1054746-1-willy@infradead.org>
References: <20220619151143.1054746-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In our efforts to remove uses of PG_private, we have found folios with
the private flag clear and folio->private not-NULL.  That is the root
cause behind 642d51fb0775 ("ceph: check folio PG_private bit instead
of folio->private").  It can also affect a few other filesystems that
haven't yet reported a problem.

compaction_alloc() can return a page with uninitialised page->private,
and rather than checking all the callers of migrate_pages(), just zero
page->private after calling get_new_page().  Similarly, the tail pages
from split_huge_page() may also have an uninitialised page->private.

Reported-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/huge_memory.c | 1 +
 mm/migrate.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f7248002dad9..9b31a50217b5 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2377,6 +2377,7 @@ static void __split_huge_page_tail(struct page *head, int tail,
 			page_tail);
 	page_tail->mapping = head->mapping;
 	page_tail->index = head->index + tail;
+	page_tail->private = NULL;
 
 	/* Page flags must be visible before we make the page non-compound. */
 	smp_wmb();
diff --git a/mm/migrate.c b/mm/migrate.c
index e51588e95f57..6c1ea61f39d8 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1106,6 +1106,7 @@ static int unmap_and_move(new_page_t get_new_page,
 	if (!newpage)
 		return -ENOMEM;
 
+	newpage->private = 0;
 	rc = __unmap_and_move(page, newpage, force, mode);
 	if (rc == MIGRATEPAGE_SUCCESS)
 		set_page_owner_migrate_reason(newpage, reason);
-- 
2.35.1

