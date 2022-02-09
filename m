Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8E94AFE4B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbiBIUWb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:22:31 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiBIUWW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DFAE011172
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0yZv7fDtGjq1jEJd1QA34PNzKOGQFSPyil/6oZoj2ew=; b=H5mzUwEbJXLc3+pEl1S/tGwHCI
        npoM5hgK/KYRKuDdOqWsV44M3csH0C9sX03MowU70iQNz/E0k9fCHmFy6PB+9vcjIgMW15TYcNvM1
        Vs/kBP8x1HTK2jN7xOgTqUrAPvN3vJtijNsQVqfJY4uq8AW2um48yL6FA5uxJTPCoZFVYe5UVp7eX
        K/08EXtqXCMo2HJb5j9hWkb5jIn8j8olk9PA/3n0YD0fO9FAj8fYUylB/5r/TSD8RmGeWPJnPLCmD
        nOnL4gWTFQHudXw4ruGRVyOziDbRra9XbvpApavIp/+1H8C8kj+ZrEgBfH2X8tCjIkH1JO+n90/QY
        8pc9fZrQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTr-008cpB-2q; Wed, 09 Feb 2022 20:22:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 05/56] fs/remap_range: Pass the file pointer to read_mapping_folio()
Date:   Wed,  9 Feb 2022 20:21:24 +0000
Message-Id: <20220209202215.2055748-6-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209202215.2055748-1-willy@infradead.org>
References: <20220209202215.2055748-1-willy@infradead.org>
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

We have the struct file in generic_remap_file_range_prep() already;
we just need to pass it around instead of the inode.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/remap_range.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index 231159682907..45e032713839 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -146,11 +146,11 @@ static int generic_remap_check_len(struct inode *inode_in,
 }
 
 /* Read a page's worth of file data into the page cache. */
-static struct folio *vfs_dedupe_get_folio(struct inode *inode, loff_t pos)
+static struct folio *vfs_dedupe_get_folio(struct file *file, loff_t pos)
 {
 	struct folio *folio;
 
-	folio = read_mapping_folio(inode->i_mapping, pos >> PAGE_SHIFT, NULL);
+	folio = read_mapping_folio(file->f_mapping, pos >> PAGE_SHIFT, file);
 	if (IS_ERR(folio))
 		return folio;
 	if (!folio_test_uptodate(folio)) {
@@ -187,8 +187,8 @@ static void vfs_unlock_two_folios(struct folio *folio1, struct folio *folio2)
  * Compare extents of two files to see if they are the same.
  * Caller must have locked both inodes to prevent write races.
  */
-static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
-					 struct inode *dest, loff_t dstoff,
+static int vfs_dedupe_file_range_compare(struct file *src, loff_t srcoff,
+					 struct file *dest, loff_t dstoff,
 					 loff_t len, bool *is_same)
 {
 	bool same = true;
@@ -224,8 +224,8 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 		 * someone is invalidating pages on us and we lose.
 		 */
 		if (!folio_test_uptodate(src_folio) || !folio_test_uptodate(dst_folio) ||
-		    src_folio->mapping != src->i_mapping ||
-		    dst_folio->mapping != dest->i_mapping) {
+		    src_folio->mapping != src->f_mapping ||
+		    dst_folio->mapping != dest->f_mapping) {
 			same = false;
 			goto unlock;
 		}
@@ -333,8 +333,8 @@ int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 	if (remap_flags & REMAP_FILE_DEDUP) {
 		bool		is_same = false;
 
-		ret = vfs_dedupe_file_range_compare(inode_in, pos_in,
-				inode_out, pos_out, *len, &is_same);
+		ret = vfs_dedupe_file_range_compare(file_in, pos_in,
+				file_out, pos_out, *len, &is_same);
 		if (ret)
 			return ret;
 		if (!is_same)
-- 
2.34.1

