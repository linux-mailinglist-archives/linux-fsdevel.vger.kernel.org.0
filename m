Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F57C53F088
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jun 2022 22:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbiFFUsb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 16:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbiFFUrX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:47:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70F8E9;
        Mon,  6 Jun 2022 13:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Nbr9wUy4GZu/A9I5fNiEUH8YjHUTRzvYZO3QnrtHfqs=; b=Gd3hSiL+/E0dfHLBarUzOacZ5+
        RgLt/HR3/LRhEZeLymFVkZyeDV4o45ibioJi0eraHf6ehCGQbtosb1TjID04N286tCzWwDmpddr27
        H3ByN9G6hK5riWHYLqRkTy3GsEZUgLnYhezqas1+XNq5pmGlpRnM2NevyEDgUXJ8ZYsVlaLiCT3RO
        8Ehpw8He8k5yQNPfIvPT9F5a/3yz8jOKKKyGe7pM1yVoqkDKz2YPmFcUn0VPuUW3SPY9tPOvKaZJU
        1Vf1NH8uVC9GEQzwQCTJYo35GSSSaLqMV3XH1X1fzAEkojyoaH3wkOkh+Z2rcUydL6L7kLEvUr3mZ
        LKB+9tpQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyJWx-00B19q-Uf; Mon, 06 Jun 2022 20:40:55 +0000
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
        virtualization@lists.linux-foundation.org
Subject: [PATCH 17/20] z3fold: Convert to migrate_folio
Date:   Mon,  6 Jun 2022 21:40:47 +0100
Message-Id: <20220606204050.2625949-18-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220606204050.2625949-1-willy@infradead.org>
References: <20220606204050.2625949-1-willy@infradead.org>
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

z3fold doesn't really use folios, but it needs to be called like this
in order to migrate an individual page.  Convert from a folio back to
a page until we decide how to handle migration better for z3fold.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/z3fold.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index f41f8b0d9e9a..5d091c41fb35 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -1554,9 +1554,11 @@ static bool z3fold_page_isolate(struct page *page, isolate_mode_t mode)
 	return false;
 }
 
-static int z3fold_page_migrate(struct address_space *mapping, struct page *newpage,
-			       struct page *page, enum migrate_mode mode)
+static int z3fold_migrate_folio(struct address_space *mapping,
+		struct folio *dst, struct folio *src, enum migrate_mode mode)
 {
+	struct page *newpage = &dst->page;
+	struct page *page = &src->page;
 	struct z3fold_header *zhdr, *new_zhdr;
 	struct z3fold_pool *pool;
 	struct address_space *new_mapping;
@@ -1644,7 +1646,7 @@ static void z3fold_page_putback(struct page *page)
 
 static const struct address_space_operations z3fold_aops = {
 	.isolate_page = z3fold_page_isolate,
-	.migratepage = z3fold_page_migrate,
+	.migrate_folio = z3fold_migrate_folio,
 	.putback_page = z3fold_page_putback,
 };
 
-- 
2.35.1

