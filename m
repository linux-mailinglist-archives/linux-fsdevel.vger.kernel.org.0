Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4AA6C8462
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 19:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjCXSDp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 14:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjCXSC0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:02:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F0D1043D;
        Fri, 24 Mar 2023 11:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8wtG5pL+c845tPb7mUPEq3cgUeiR4ZIEdtN0rAHMMTw=; b=rT1U5yCfZmXdQA20cNxQLWxpEn
        jGxvYFi93JRdfYqeg19pPZfUJi5IWZubZS5uyeXpbCevweYn0jqphUyRaiKTUv9DEFD97coWT29ZG
        9lKZd0i5FVw1dF4bGkGSr+rhWU5FxFUaC5SrL/vSfgOa34W9uXwVSkKScAWzy4SmEVXQTUQTZYwHt
        4gHUOz0YfWLJnSxl1GtsYPflulgIconSKIaecTvXPcdkDIWlU1pDoTBYegxUCXbJbGsIr6u+m4es3
        ZS9qZVGg6XjMIODUGIndMZVDeN+eTn8Tg/KDEX5bvpKskRsaHU1aKeW1NVncN+QoPD2j8nhC+UpU6
        qbpe4Cmg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfljO-0057bk-A8; Fri, 24 Mar 2023 18:01:38 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 26/29] ext4: Use a folio iterator in __read_end_io()
Date:   Fri, 24 Mar 2023 18:01:26 +0000
Message-Id: <20230324180129.1220691-27-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230324180129.1220691-1-willy@infradead.org>
References: <20230324180129.1220691-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index fed4ddb652df..6f46823fba61 100644
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
2.39.2

