Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA9067D640
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbjAZUYk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbjAZUYZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:24:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACE14C0D9;
        Thu, 26 Jan 2023 12:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=GNjx3dnJGxVhFqH4q5lVhBk6E+7IfMU9GlJw/UIY2j4=; b=cyh9ex1iU7eX2iRFWcp+dErSNd
        6WB+sTvrB2FcZwXSROYwcxYr09r+HaE8Y5FCxk4RiFHIlduetzkvtoT09XhoVwYAih5vR+ofj6T7F
        UWubPsP3TP7qu2OORK0VN8tflbc08B1ESueSJp/kKgj2++ZjQxcriP6xPc8lWsQ4a9bOCJWa55G6T
        f/sQ4747hj3FXj66L2N2nY/ZsBPNsaXkyU8GcMHDboA6QfX3UorAUq5rLz/P29+7LN+E0KKv/JESC
        D2HP0DWheg+FzcmOi8VqyCHhEvsWc0cPy6K9h73fEjXWkLnORCWjzlW8W3ckqOo4pPigDWNjqwRRQ
        Y5bjB25Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8nF-0073lt-Pk; Thu, 26 Jan 2023 20:24:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Theodore Tso" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 28/31] ext4: Use a folio iterator in __read_end_io()
Date:   Thu, 26 Jan 2023 20:24:12 +0000
Message-Id: <20230126202415.1682629-29-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230126202415.1682629-1-willy@infradead.org>
References: <20230126202415.1682629-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Iterate once per folio, not once per page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/readpage.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index 8092d2ace75e..442f6c507016 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -68,18 +68,16 @@ struct bio_post_read_ctx {
 
 static void __read_end_io(struct bio *bio)
 {
-	struct page *page;
-	struct bio_vec *bv;
-	struct bvec_iter_all iter_all;
+	struct folio_iter fi;
 
-	bio_for_each_segment_all(bv, bio, iter_all) {
-		page = bv->bv_page;
+	bio_for_each_folio_all(fi, bio) {
+		struct folio *folio = fi.folio;
 
 		if (bio->bi_status)
-			ClearPageUptodate(page);
+			folio_clear_uptodate(folio);
 		else
-			SetPageUptodate(page);
-		unlock_page(page);
+			folio_mark_uptodate(folio);
+		folio_unlock(folio);
 	}
 	if (bio->bi_private)
 		mempool_free(bio->bi_private, bio_post_read_ctx_pool);
-- 
2.35.1

