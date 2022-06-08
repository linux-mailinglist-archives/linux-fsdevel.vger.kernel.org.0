Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CAF543678
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 17:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243877AbiFHPMw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 11:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242464AbiFHPLt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:11:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992814A0037;
        Wed,  8 Jun 2022 08:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=L/W62gIhDvny0+evT6hKu8mfiF8YLXl9JHSXNMT2CL8=; b=E/cR7+jnh4MZjUekK6MX3paPTV
        rpyCm/XiDAOZDdkAxiR6ENBOGDspVwZofRubYVUCyfBG/q0G2P76APSKvJQYDoJJHnpbIZIfvndzv
        b2tINK8pbPtEv8uVgJlVmXLf0Zb7aTLK/Av4cH/ZFWlwIwtyIRzsKjAlUgHGt/pj4W+imiRHLVDU6
        HWs4rwESaohScBPmkWkya7wcDDvYQG1mSEtqOj+cki1hdMlVwH8fFsV0sNL2uKq8yjL+T8WmSb+iF
        zAP5EwizELetbeBerNs7aFo2HX55u2FQyB9sVWH9wzoFE+fXlWb8vKSJpwwQJNZs4KPFu+kaJl/nK
        iSwBCYeA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyxCu-00CjFS-Ds; Wed, 08 Jun 2022 15:02:52 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ocfs2-devel@oss.oracle.com,
        linux-mtd@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 07/19] mm/migrate: Convert expected_page_refs() to folio_expected_refs()
Date:   Wed,  8 Jun 2022 16:02:37 +0100
Message-Id: <20220608150249.3033815-8-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220608150249.3033815-1-willy@infradead.org>
References: <20220608150249.3033815-1-willy@infradead.org>
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

Now that both callers have a folio, convert this function to
take a folio & rename it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/migrate.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 2975f0c4d7cf..2e2f41572066 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -336,13 +336,18 @@ void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
 }
 #endif
 
-static int expected_page_refs(struct address_space *mapping, struct page *page)
+static int folio_expected_refs(struct address_space *mapping,
+		struct folio *folio)
 {
-	int expected_count = 1;
+	int refs = 1;
+	if (!mapping)
+		return refs;
 
-	if (mapping)
-		expected_count += compound_nr(page) + page_has_private(page);
-	return expected_count;
+	refs += folio_nr_pages(folio);
+	if (folio_get_private(folio))
+		refs++;
+
+	return refs;
 }
 
 /*
@@ -359,7 +364,7 @@ int folio_migrate_mapping(struct address_space *mapping,
 	XA_STATE(xas, &mapping->i_pages, folio_index(folio));
 	struct zone *oldzone, *newzone;
 	int dirty;
-	int expected_count = expected_page_refs(mapping, &folio->page) + extra_count;
+	int expected_count = folio_expected_refs(mapping, folio) + extra_count;
 	long nr = folio_nr_pages(folio);
 
 	if (!mapping) {
@@ -669,7 +674,7 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 		return migrate_page(mapping, &dst->page, &src->page, mode);
 
 	/* Check whether page does not have extra refs before we do more work */
-	expected_count = expected_page_refs(mapping, &src->page);
+	expected_count = folio_expected_refs(mapping, src);
 	if (folio_ref_count(src) != expected_count)
 		return -EAGAIN;
 
-- 
2.35.1

