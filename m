Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DE475170A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 05:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbjGMDzn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 23:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjGMDzk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:55:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D73E1BF2;
        Wed, 12 Jul 2023 20:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jYGr8ODFn2NMtrawIS2Yz1RKc1fA/K4tKHEsM65sMaE=; b=aU2YHRc9daHN+V6qJy3ls9y5WI
        pEeuHSjUwf0LcruyUze/uhjuturw2lvaJWJunAHkc7g8nTM4rnWysCCHU2Iow5jKivM2cbNWO2VF5
        CEgtu3zl69TS/qsCiCBEh4nlv1Do/63Etui6LLLOiq52UjloG9dqBSNswd9tcFkGXZFIBGgILQfeu
        9XRn2FXx4wmE7gZQZDoAHPtFzR2NoMRM3bGfJQloGzGuopffaHV/O7KthX5s7LjXWN99NGOvhiMS+
        EBtPgjf2p6SzYgznFS4EPFaNUc6ppFQcwUiAYTVBiMG4+/KVYx6JAeTJ2vusoOjLuGTQZHOzBNGhH
        rBX+QdYQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJnQA-00HMrg-As; Thu, 13 Jul 2023 03:55:14 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, "Theodore Tso" <tytso@mit.edu>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org
Subject: [PATCH 2/7] affs: Convert affs_symlink_read_folio() to use the folio
Date:   Thu, 13 Jul 2023 04:55:07 +0100
Message-Id: <20230713035512.4139457-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230713035512.4139457-1-willy@infradead.org>
References: <20230713035512.4139457-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove use of the old page APIs.  That includes use of setting PageError
on error; simply not setting the uptodate flag is sufficient.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/affs/symlink.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/affs/symlink.c b/fs/affs/symlink.c
index 31d6446dc166..094aec8d17b8 100644
--- a/fs/affs/symlink.c
+++ b/fs/affs/symlink.c
@@ -13,10 +13,9 @@
 
 static int affs_symlink_read_folio(struct file *file, struct folio *folio)
 {
-	struct page *page = &folio->page;
 	struct buffer_head *bh;
-	struct inode *inode = page->mapping->host;
-	char *link = page_address(page);
+	struct inode *inode = folio->mapping->host;
+	char *link = folio_address(folio);
 	struct slink_front *lf;
 	int			 i, j;
 	char			 c;
@@ -58,12 +57,11 @@ static int affs_symlink_read_folio(struct file *file, struct folio *folio)
 	}
 	link[i] = '\0';
 	affs_brelse(bh);
-	SetPageUptodate(page);
-	unlock_page(page);
+	folio_mark_uptodate(folio);
+	folio_unlock(folio);
 	return 0;
 fail:
-	SetPageError(page);
-	unlock_page(page);
+	folio_unlock(folio);
 	return -EIO;
 }
 
-- 
2.39.2

