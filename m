Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF8E6C8433
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 19:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjCXSCd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 14:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbjCXSCR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:02:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E5B1CF74;
        Fri, 24 Mar 2023 11:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Sm8VJaNS2C4iveG985kCLNeDwuawDjvJBE0x6P2K6jI=; b=sUsB8B1gfIN7LHtUUR/4OPmZWd
        VUT2Q/PoR7FMy+VbBDkGO1zFMg6XC1bcGVH+mCLKl8INvJaclAE0vPDXmDD+4kh8t818QnFQQCqia
        mCdSdP3Jd4C63CJ5aAnO3geNOnrcFJEOd+Tr5fDzRqUMbtmZlGkWR21GAj8FCRcUJRlGvWezjzIbV
        INg+AFDu0rNcNb/SpZGI10tvT/J/rH+t3eSaseiDvHyDLyqJUojzg6ARaUNbGyRJ2goJRQot6aWyx
        QT8AQEurI2AxxphS3U3Cauvq10N0hqR04HxjksdZoPW+M+bUMr8BvVxIBQO9k80YB9HcGYpV1fAxM
        sYPqajMw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfljL-0057ZP-Po; Fri, 24 Mar 2023 18:01:35 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 09/29] ext4: Convert ext4_readpage_inline() to take a folio
Date:   Fri, 24 Mar 2023 18:01:09 +0000
Message-Id: <20230324180129.1220691-10-willy@infradead.org>
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

Use the folio API in this function, saves a few calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/ext4.h   |  2 +-
 fs/ext4/inline.c | 14 +++++++-------
 fs/ext4/inode.c  |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index bee344ebd385..1de5d838996a 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3550,7 +3550,7 @@ extern int ext4_init_inline_data(handle_t *handle, struct inode *inode,
 				 unsigned int len);
 extern int ext4_destroy_inline_data(handle_t *handle, struct inode *inode);
 
-extern int ext4_readpage_inline(struct inode *inode, struct page *page);
+int ext4_readpage_inline(struct inode *inode, struct folio *folio);
 extern int ext4_try_to_write_inline_data(struct address_space *mapping,
 					 struct inode *inode,
 					 loff_t pos, unsigned len,
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 1602d74b5eeb..e9bae3002319 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -501,7 +501,7 @@ static int ext4_read_inline_page(struct inode *inode, struct page *page)
 	return ret;
 }
 
-int ext4_readpage_inline(struct inode *inode, struct page *page)
+int ext4_readpage_inline(struct inode *inode, struct folio *folio)
 {
 	int ret = 0;
 
@@ -515,16 +515,16 @@ int ext4_readpage_inline(struct inode *inode, struct page *page)
 	 * Current inline data can only exist in the 1st page,
 	 * So for all the other pages, just set them uptodate.
 	 */
-	if (!page->index)
-		ret = ext4_read_inline_page(inode, page);
-	else if (!PageUptodate(page)) {
-		zero_user_segment(page, 0, PAGE_SIZE);
-		SetPageUptodate(page);
+	if (!folio->index)
+		ret = ext4_read_inline_page(inode, &folio->page);
+	else if (!folio_test_uptodate(folio)) {
+		folio_zero_segment(folio, 0, folio_size(folio));
+		folio_mark_uptodate(folio);
 	}
 
 	up_read(&EXT4_I(inode)->xattr_sem);
 
-	unlock_page(page);
+	folio_unlock(folio);
 	return ret >= 0 ? 0 : ret;
 }
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4119c63c1215..6287cd1aa97e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3155,7 +3155,7 @@ static int ext4_read_folio(struct file *file, struct folio *folio)
 	trace_ext4_readpage(page);
 
 	if (ext4_has_inline_data(inode))
-		ret = ext4_readpage_inline(inode, page);
+		ret = ext4_readpage_inline(inode, folio);
 
 	if (ret == -EAGAIN)
 		return ext4_mpage_readpages(inode, NULL, page);
-- 
2.39.2

