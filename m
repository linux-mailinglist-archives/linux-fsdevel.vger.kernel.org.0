Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887336AE2B5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 15:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjCGOir (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 09:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjCGOiX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:38:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A340907AD;
        Tue,  7 Mar 2023 06:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=DOdTgLf35ydRPhAUtTqGnhMAFPKhMEWQTwS1vfOj9sA=; b=FiHVIwcsDu+ndeHzk6EWd+nGqo
        UYlDj93dbp9kRox0m0240+2Y2+7RIaJXnC+SCRr2a1OSd5V40RhN1bHw3Kr06IvqIEC5w2Jy9NUeh
        F821dVlrNBPtovMrZbKNRp/cwgwH8s+pvTRlZZCjgNlPmX5lEHLNJDBa/AI7PNJwIJ/3sZMOHSrbG
        v5hCwOUnYfzy7fJwh7fryav1gVZNmhY5Z8Y1XZeSa37bi+2TP9IWJQTVoqyIn5zi8naX8IAv2+GTh
        kFzEHjrB0ld6bGeMFdvmFQKIZJshKy2xZWXuLIqC5Lryk5z2WRPZ8bVCqVfMEZsXGI6gtE64dYPH2
        G44UPoLw==;
Received: from [46.183.103.17] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZYOO-000q40-QA; Tue, 07 Mar 2023 14:34:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Cc:     linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nilfs@vger.kernel.org
Subject: [PATCH 1/7] mm: don't look at xarray value entries in split_huge_pages_in_file
Date:   Tue,  7 Mar 2023 15:34:04 +0100
Message-Id: <20230307143410.28031-2-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230307143410.28031-1-hch@lst.de>
References: <20230307143410.28031-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

split_huge_pages_in_file never wants to do anything with the special
value enties.  Switch to using filemap_get_folio to not even see them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/huge_memory.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4fc43859e59a31..62843afeb7946d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3090,11 +3090,10 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
 	mapping = candidate->f_mapping;
 
 	for (index = off_start; index < off_end; index += nr_pages) {
-		struct folio *folio = __filemap_get_folio(mapping, index,
-						FGP_ENTRY, 0);
+		struct folio *folio = filemap_get_folio(mapping, index);
 
 		nr_pages = 1;
-		if (xa_is_value(folio) || !folio)
+		if (!folio)
 			continue;
 
 		if (!folio_test_large(folio))
-- 
2.39.1

