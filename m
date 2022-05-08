Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF8951F185
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbiEHUiJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbiEHUhN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:37:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4162812087
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=GktsyPqiie+UTZ3VfBYb3dZ5GFilFsPa+JxmsZDmRB4=; b=CdvarnJCLVhtnTRjwoSAjHJ1zm
        FvNxWivLlOOa0/IQE7z7/ILlQEkXPbjmsImwoSB+NCvEM1OV1SnSVhh/1QpcWUFNHnjL300Kn95FG
        SLugkRwdL8AnoOiPnCFn+XAreQ1GKwYfHf98uCsS1nlyR+Twc3wfl1zSMsTdir4uX+SoE3tPmf57R
        KoDh0pOirgawJ8JUYrJC7xLe523sncXTH3Vs0mGDx7DBb0lTI4KTp2yXlOlsDtIrAWmE6IP1K2tWG
        juy6lTXAzJ1vacVdSiPNh6HYWqiz+0gCbEVeUs1o5zjRbHwYLM+R8uCvGxl7a8IIGXTXBRhn7iED+
        /+ZMS9rg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnaF-002o2g-Ie; Sun, 08 May 2022 20:32:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 21/26] fs: Remove last vestiges of releasepage
Date:   Sun,  8 May 2022 21:32:42 +0100
Message-Id: <20220508203247.668791-22-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203247.668791-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203247.668791-1-willy@infradead.org>
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

All users are now converted to release_folio

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/fs.h         | 1 -
 include/linux/page-flags.h | 2 +-
 mm/filemap.c               | 2 --
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index ad768f13f485..1cee64d9724b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -356,7 +356,6 @@ struct address_space_operations {
 	sector_t (*bmap)(struct address_space *, sector_t);
 	void (*invalidate_folio) (struct folio *, size_t offset, size_t len);
 	bool (*release_folio)(struct folio *, gfp_t);
-	int (*releasepage) (struct page *, gfp_t);
 	void (*freepage)(struct page *);
 	ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
 	/*
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 9d8eeaa67d05..af10149a6c31 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -516,7 +516,7 @@ PAGEFLAG(SwapBacked, swapbacked, PF_NO_TAIL)
 /*
  * Private page markings that may be used by the filesystem that owns the page
  * for its own purposes.
- * - PG_private and PG_private_2 cause releasepage() and co to be invoked
+ * - PG_private and PG_private_2 cause release_folio() and co to be invoked
  */
 PAGEFLAG(Private, private, PF_ANY)
 PAGEFLAG(Private2, private_2, PF_ANY) TESTSCFLAG(Private2, private_2, PF_ANY)
diff --git a/mm/filemap.c b/mm/filemap.c
index 78e4a7dc3a56..ee892853a214 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3957,8 +3957,6 @@ bool filemap_release_folio(struct folio *folio, gfp_t gfp)
 
 	if (mapping && mapping->a_ops->release_folio)
 		return mapping->a_ops->release_folio(folio, gfp);
-	if (mapping && mapping->a_ops->releasepage)
-		return mapping->a_ops->releasepage(&folio->page, gfp);
 	return try_to_free_buffers(&folio->page);
 }
 EXPORT_SYMBOL(filemap_release_folio);
-- 
2.34.1

