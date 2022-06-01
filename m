Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B839353AD64
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 21:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiFATsM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 15:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiFATsL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 15:48:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDB41CE79C
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jun 2022 12:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=yHw2wth7/QLOgYffmoVtxIbJyeLsT+RCXVJBn8zWZQY=; b=QG+ZQSqDYzChC/tXlZ0CU21mHr
        CVnJM+j61y6HDa5o2wWnKmDGvtcvf+7USIFccIBdEI2/Ek1WjbRh7/aj7iKPno6mwujQb9rLdAyzB
        A5paRudachwOhX7hC3eoWudfqfhaSHpWgVZRKJawguR6q4Rmh9X8CTJp3AwdtIRfB/OuYvCv+6Qw3
        l6HnPToPnuuS0Fay3pX1VYsf3kgvX9DOZCitMjlDjf01pMluR5/36XjEjbVwB9vcPym5y3HU4JKHr
        GfA8x4TB0OuhYd99LTybpScwKkNZI1GxnKEZyuHqaAF9xW2AoR30eOlC3KF26QyEBu3c3Hg7ZR/zp
        nI7WBKog==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwTwM-006Y2d-96; Wed, 01 Jun 2022 19:23:34 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 1/2] hugetlb: Convert huge_add_to_page_cache() to use a folio
Date:   Wed,  1 Jun 2022 20:23:32 +0100
Message-Id: <20220601192333.1560777-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
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

Remove the last caller of add_to_page_cache()

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/hugetlbfs/inode.c |  2 +-
 mm/hugetlb.c         | 14 ++++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 62408047e8d7..ae2524480f23 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -759,7 +759,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 
 		SetHPageMigratable(page);
 		/*
-		 * unlock_page because locked by add_to_page_cache()
+		 * unlock_page because locked by huge_add_to_page_cache()
 		 * put_page() due to reference from alloc_huge_page()
 		 */
 		unlock_page(page);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7c468ac1d069..eb9d6fe9c492 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5406,19 +5406,25 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
 int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
 			   pgoff_t idx)
 {
+	struct folio *folio = page_folio(page);
 	struct inode *inode = mapping->host;
 	struct hstate *h = hstate_inode(inode);
-	int err = add_to_page_cache(page, mapping, idx, GFP_KERNEL);
+	int err;
 
-	if (err)
+	__folio_set_locked(folio);
+	err = __filemap_add_folio(mapping, folio, idx, GFP_KERNEL, NULL);
+
+	if (unlikely(err)) {
+		__folio_clear_locked(folio);
 		return err;
+	}
 	ClearHPageRestoreReserve(page);
 
 	/*
-	 * set page dirty so that it will not be removed from cache/file
+	 * mark folio dirty so that it will not be removed from cache/file
 	 * by non-hugetlbfs specific code paths.
 	 */
-	set_page_dirty(page);
+	folio_mark_dirty(folio);
 
 	spin_lock(&inode->i_lock);
 	inode->i_blocks += blocks_per_huge_page(h);
-- 
2.34.1

