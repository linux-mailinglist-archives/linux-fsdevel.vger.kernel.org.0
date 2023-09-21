Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7887A9FE6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 22:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjIUU2q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 16:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjIUU2X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:28:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F6E2D51F;
        Thu, 21 Sep 2023 13:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=o3WA9VWfKtc+QA0R8dkgUvuS8cRUOwuJgLVOfSfVzjc=; b=oL5FMM2cmhJpJ96VKnqw0Jq+V4
        TsZHrBM/C7MM+hNS0Aac0C/rk/B0lnCnzf+YB40dRI4yIT6EOLh9310RnT/arOygFFLY9h6MULjIm
        0w8UTXmXt7xd04TgP2cOtl7epaXJYkVkPpfbFlJ/FWSWzf94Fj0ipbcMq6sz8YeK47Q/sU/30DVhI
        uoz3QHP7cCtLumJCO4uvjpt8H/rop74pI7PD5LeOCj1SrcN8e3MSsHfzR6B4Bz6/HOPpcstS6ybly
        Sv3Ik/NUo9U/Lvq4o5O1xqsoXNyMFJ6pW6s0u5KXIFChwqp6mOTyuntXGqWzu9tH4FPNSTWOB00bg
        inV62J0w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qjPxj-00DrVm-S6; Thu, 21 Sep 2023 20:07:47 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Jan Kara <jack@suse.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 04/10] ext2: Convert ext2_readdir to use a folio
Date:   Thu, 21 Sep 2023 21:07:41 +0100
Message-Id: <20230921200746.3303942-4-willy@infradead.org>
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

Saves a hidden call to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext2/dir.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index 5c1b7bded535..5a8a02d6be9a 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -286,8 +286,8 @@ ext2_readdir(struct file *file, struct dir_context *ctx)
 
 	for ( ; n < npages; n++, offset = 0) {
 		ext2_dirent *de;
-		struct page *page;
-		char *kaddr = ext2_get_page(inode, n, 0, &page);
+		struct folio *folio;
+		char *kaddr = ext2_get_folio(inode, n, 0, &folio);
 		char *limit;
 
 		if (IS_ERR(kaddr)) {
@@ -311,7 +311,7 @@ ext2_readdir(struct file *file, struct dir_context *ctx)
 			if (de->rec_len == 0) {
 				ext2_error(sb, __func__,
 					"zero-length directory entry");
-				ext2_put_page(page, de);
+				folio_release_kmap(folio, de);
 				return -EIO;
 			}
 			if (de->inode) {
@@ -323,13 +323,13 @@ ext2_readdir(struct file *file, struct dir_context *ctx)
 				if (!dir_emit(ctx, de->name, de->name_len,
 						le32_to_cpu(de->inode),
 						d_type)) {
-					ext2_put_page(page, de);
+					folio_release_kmap(folio, de);
 					return 0;
 				}
 			}
 			ctx->pos += ext2_rec_len_from_disk(de->rec_len);
 		}
-		ext2_put_page(page, kaddr);
+		folio_release_kmap(folio, kaddr);
 	}
 	return 0;
 }
-- 
2.40.1

