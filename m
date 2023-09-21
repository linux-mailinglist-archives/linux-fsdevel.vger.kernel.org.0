Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86ED7AA007
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 22:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjIUUan (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 16:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjIUU3K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:29:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1D72698;
        Thu, 21 Sep 2023 13:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=OmhYxZWP+Y6kyZIC9zAP6b0+avnvzgP9pmdSogeenOc=; b=Ycq5ZDJTRsyt+3zqybhj/R4da6
        dOJvPT0dU3J7JyyP4QsAc5PloybfGsg/eLdduDO3+Jhzu9LLSOKV0yECLF58J8f3wHKEwQXqcw2ty
        zQPem6fl3DUSjIoVpbd52Mer9BcNebshD+HvbmGW+UCJfrGKqLWE80nc1QTEs85wUmGI3xWjDilAd
        sCB5jkxA9gwLuZSrPgjaxyDx7qgv1k6LBlaNUTV51Zlp4y4GtQXzQS7LPoA3WzWUPOwC3wngqLlwW
        sbLH8vS9ozrpUL8faO4PeNotIyf7nKkVh70ajctKV8fAxF6fniBTa1NGMOqibiBKdKAItVE6FeIb3
        NTlpRCDw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qjPxk-00DrVq-1E; Thu, 21 Sep 2023 20:07:48 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Jan Kara <jack@suse.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 06/10] ext2: Convert ext2_empty_dir() to use a folio
Date:   Thu, 21 Sep 2023 21:07:43 +0100
Message-Id: <20230921200746.3303942-6-willy@infradead.org>
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

Save two calls to compound_head() by using the folio API.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext2/dir.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index 31333b23adf3..2fc910e99234 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -669,16 +669,16 @@ int ext2_make_empty(struct inode *inode, struct inode *parent)
 /*
  * routine to check that the specified directory is empty (for rmdir)
  */
-int ext2_empty_dir (struct inode * inode)
+int ext2_empty_dir(struct inode *inode)
 {
-	struct page *page;
+	struct folio *folio;
 	char *kaddr;
 	unsigned long i, npages = dir_pages(inode);
 
 	for (i = 0; i < npages; i++) {
 		ext2_dirent *de;
 
-		kaddr = ext2_get_page(inode, i, 0, &page);
+		kaddr = ext2_get_folio(inode, i, 0, &folio);
 		if (IS_ERR(kaddr))
 			return 0;
 
@@ -707,12 +707,12 @@ int ext2_empty_dir (struct inode * inode)
 			}
 			de = ext2_next_entry(de);
 		}
-		ext2_put_page(page, kaddr);
+		folio_release_kmap(folio, kaddr);
 	}
 	return 1;
 
 not_empty:
-	ext2_put_page(page, kaddr);
+	folio_release_kmap(folio, kaddr);
 	return 0;
 }
 
-- 
2.40.1

