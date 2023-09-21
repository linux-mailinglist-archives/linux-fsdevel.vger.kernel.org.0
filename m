Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF117AA004
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 22:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjIUUao (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 16:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjIUU3J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:29:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF3920A58;
        Thu, 21 Sep 2023 13:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bASu/IOMrOJhsjpuuCKwo2XljNyBiLu8hRgAXljsqsA=; b=LeWiBwHm6Dy1KuhtJrMbIlSx7c
        /CWK1VxvaI9dQOYM83Hm1vWyTed4vj9bxF8fIDCMuX90ShpzZzyoDwz8FhjRTY+fbrDvEtf5kLDWL
        hohMR2dJHPUTxe1V5/YlCshjaPIkYInDU3iiRok7ovRfCvp0mBQDt7WY56CPsqh6X4+j2tv0EU8rN
        fRQY8Tw73Bc60AVx3gk8GgxSunTtdLBrOl3LywsQfhGX4MGVMW8Yt/P8UN/TrA7fPCgEf3WNZdG7h
        14dRsOmO0XRLkopR0YSa+KaOk2vWHD4d0m+yewTlGJPgwQMQpJUVQHsCH24WHo90sH292wXvracsW
        gTY+AdsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qjPxj-00DrVk-Pr; Thu, 21 Sep 2023 20:07:47 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Jan Kara <jack@suse.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 03/10] ext2: Add ext2_get_folio()
Date:   Thu, 21 Sep 2023 21:07:40 +0100
Message-Id: <20230921200746.3303942-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230921200746.3303942-1-willy@infradead.org>
References: <20230921200746.3303942-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert ext2_get_page() into ext2_get_folio() and keep the original
function around as a temporary wrapper.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext2/dir.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index 03867381eec2..5c1b7bded535 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -180,34 +180,46 @@ static bool ext2_check_folio(struct folio *folio, int quiet, char *kaddr)
 }
 
 /*
- * Calls to ext2_get_page()/ext2_put_page() must be nested according to the
- * rules documented in kmap_local_page()/kunmap_local().
+ * Calls to ext2_get_folio()/folio_release_kmap() must be nested according
+ * to the rules documented in kmap_local_folio()/kunmap_local().
  *
- * NOTE: ext2_find_entry() and ext2_dotdot() act as a call to ext2_get_page()
- * and should be treated as a call to ext2_get_page() for nesting purposes.
+ * NOTE: ext2_find_entry() and ext2_dotdot() act as a call
+ * to folio_release_kmap() and should be treated as a call to
+ * folio_release_kmap() for nesting purposes.
  */
-static void *ext2_get_page(struct inode *dir, unsigned long n,
-				   int quiet, struct page **page)
+static void *ext2_get_folio(struct inode *dir, unsigned long n,
+				   int quiet, struct folio **foliop)
 {
 	struct address_space *mapping = dir->i_mapping;
 	struct folio *folio = read_mapping_folio(mapping, n, NULL);
-	void *page_addr;
+	void *kaddr;
 
 	if (IS_ERR(folio))
 		return ERR_CAST(folio);
-	page_addr = kmap_local_folio(folio, 0);
+	kaddr = kmap_local_folio(folio, 0);
 	if (unlikely(!folio_test_checked(folio))) {
-		if (!ext2_check_folio(folio, quiet, page_addr))
+		if (!ext2_check_folio(folio, quiet, kaddr))
 			goto fail;
 	}
-	*page = &folio->page;
-	return page_addr;
+	*foliop = folio;
+	return kaddr;
 
 fail:
-	ext2_put_page(&folio->page, page_addr);
+	folio_release_kmap(folio, kaddr);
 	return ERR_PTR(-EIO);
 }
 
+static void *ext2_get_page(struct inode *dir, unsigned long n,
+				   int quiet, struct page **pagep)
+{
+	struct folio *folio;
+	void *kaddr = ext2_get_folio(dir, n, quiet, &folio);
+
+	if (!IS_ERR(kaddr))
+		*pagep = &folio->page;
+	return kaddr;
+}
+
 /*
  * NOTE! unlike strncmp, ext2_match returns 1 for success, 0 for failure.
  *
-- 
2.40.1

