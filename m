Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC585364F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 17:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353678AbiE0PvK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 11:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347152AbiE0Pu4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 11:50:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9863A134E29
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 08:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qQEqXPIAXhUgwxBQ6QCQQiUDHFUM6Ol8abPdc//PdiU=; b=AEvZLXAZaZa8elyEnFJg5ybISg
        NLks/WO1fkcraDEOC20sRV53DbHf/RH9vvAuBNrFaN9Vde28KDKOyQmaadzu4ZMkaH4ri6WmsUWOZ
        +R5vkEjpecbxOrtxX0qC8mIY1FQ549yEy0L4UD40sWuv6Qc6sRDr7LeuBm1scC1MVXhk0paclE9O1
        iR9QC/W+b98Zy/za24PRlyDawBJrAmPxDpQUxX8f13MPSFMzmwVDu1BJV9pN/KFfdUmPy/mnKHZQm
        rmlqqaCKmYQxe4atKaquqgAe+nCN1+vYYUuBJlCdRmKfgs7p6KSIAYwTrsFDt9mpYaDqm8JWs8NJF
        KP2IGpSA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nucEa-002CWe-W6; Fri, 27 May 2022 15:50:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 10/24] ntfs: Remove check for PageError
Date:   Fri, 27 May 2022 16:50:22 +0100
Message-Id: <20220527155036.524743-11-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220527155036.524743-1-willy@infradead.org>
References: <20220527155036.524743-1-willy@infradead.org>
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

If read_mapping_page() encounters an error, it returns an errno, not a
page with PageError set, so this is dead code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs/aops.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/ntfs/aops.h b/fs/ntfs/aops.h
index 934d5f79b9e7..0cac5458c023 100644
--- a/fs/ntfs/aops.h
+++ b/fs/ntfs/aops.h
@@ -74,13 +74,8 @@ static inline struct page *ntfs_map_page(struct address_space *mapping,
 {
 	struct page *page = read_mapping_page(mapping, index, NULL);
 
-	if (!IS_ERR(page)) {
+	if (!IS_ERR(page))
 		kmap(page);
-		if (!PageError(page))
-			return page;
-		ntfs_unmap_page(page);
-		return ERR_PTR(-EIO);
-	}
 	return page;
 }
 
-- 
2.34.1

