Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570C35364E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 17:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352785AbiE0Pup (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 11:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242714AbiE0Puo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 11:50:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3771134E17
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 08:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=i2t/qLSgdmu/wJjlxbx86LZigla0S50FB+rJa/7oTp4=; b=HCcffH2/971xsM0+d7Gy9W0H/B
        iPootp9x8eswPq0Kv4uWn/Qk1XU1UEl63BQMinB1PphPvm9o51q8hhzdZR9QR66bHgFlSPGcT1dio
        yH1kBWZNcgdTkPaHJmlUO8qBPrxtlD9VlqozZdwPu0n75kzO+XJvEjZqS8MGj4tgSy1VyZt8jQPiT
        o+imv1RHzwTsBsxZ+VVlk7Jzf+JxP5t/RzBhBOlONxtggzLj5UzcdeLxxbJE3mlMaus6437664xgp
        yFAofy5Ce1vUeAUC5YoraA05b711s5O2FHcdn6NUgpj7wyoSXb9wvLerkXr/chh7l06BZy6wCPlZk
        eigNaKZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nucEb-002CWi-4C; Fri, 27 May 2022 15:50:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 12/24] reiserfs: Remove check for PageError
Date:   Fri, 27 May 2022 16:50:24 +0100
Message-Id: <20220527155036.524743-13-willy@infradead.org>
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
 fs/reiserfs/xattr.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index bd073836e141..436641369283 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -440,16 +440,9 @@ static struct page *reiserfs_get_page(struct inode *dir, size_t n)
 	 */
 	mapping_set_gfp_mask(mapping, GFP_NOFS);
 	page = read_mapping_page(mapping, n >> PAGE_SHIFT, NULL);
-	if (!IS_ERR(page)) {
+	if (!IS_ERR(page))
 		kmap(page);
-		if (PageError(page))
-			goto fail;
-	}
 	return page;
-
-fail:
-	reiserfs_put_page(page);
-	return ERR_PTR(-EIO);
 }
 
 static inline __u32 xattr_hash(const char *msg, int len)
-- 
2.34.1

