Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71AC37AE95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 20:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhEKSlk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 14:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhEKSlk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 14:41:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAC9C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 May 2021 11:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=IvW2j4oLNIARCibwuwgc8/hNevaAA1ymJqHmqVsh9EQ=; b=NDNo/FXhyOo4klHFt3S8LEzznG
        +ePDSYBAS4hg9wOtE1jfwBROa7Bz6dek/J3/JqLQAwWwOXlv5juYSKjNDKZDHJmGexLKWufZNVuLs
        kZJQzSaB6gF8CLjtwx2hABuZRSSD5reJw2V10PHaW+kVW/khvUOt8vHOqqbvY6pNzrgAxgelB72Vn
        ArF7BWI/PC81n2fbEfJ44989uZ7py70O21K6LyraJqf+cwWT2hT692t6lwQNLzbQfO5Y+Lkzc1hea
        d7F1NCLk/0y9F+jSaxKfsQ45Adebz5R1JNzvGIFIv1tkS4MkqSwxXDD3wVjl94rrRTcyWwaEq3C7N
        C6KRMkPA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgXIq-007Yor-8u; Tue, 11 May 2021 18:40:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, djwong@kernel.org,
        viro@zeniv.linux.org.uk
Subject: [PATCH v2] vfs/dedupe: Pass file pointer to read_mapping_page
Date:   Tue, 11 May 2021 19:40:19 +0100
Message-Id: <20210511184019.1802090-1-willy@infradead.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some filesystems (mostly networking) need a valid file pointer for
their ->readpage operation to supply credentials.  Since there are no
bug reports, I assume none of them currently support deduplication.
It's just as easy to pass the struct file around as it is to pass the
struct inode around, and it sets a good example for other users as well
as being good future-proofing.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/remap_range.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index e4a5fdd7ad7b..56f44a9b4ab6 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -158,11 +158,11 @@ static int generic_remap_check_len(struct inode *inode_in,
 }
 
 /* Read a page's worth of file data into the page cache. */
-static struct page *vfs_dedupe_get_page(struct inode *inode, loff_t offset)
+static struct page *vfs_dedupe_get_page(struct file *file, loff_t offset)
 {
 	struct page *page;
 
-	page = read_mapping_page(inode->i_mapping, offset >> PAGE_SHIFT, NULL);
+	page = read_mapping_page(file->f_mapping, offset >> PAGE_SHIFT, file);
 	if (IS_ERR(page))
 		return page;
 	if (!PageUptodate(page)) {
@@ -199,8 +199,8 @@ static void vfs_unlock_two_pages(struct page *page1, struct page *page2)
  * Compare extents of two files to see if they are the same.
  * Caller must have locked both inodes to prevent write races.
  */
-static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
-					 struct inode *dest, loff_t destoff,
+static int vfs_dedupe_file_range_compare(struct file *src, loff_t srcoff,
+					 struct file *dest, loff_t destoff,
 					 loff_t len, bool *is_same)
 {
 	loff_t src_poff;
@@ -244,8 +244,8 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 		 * someone is invalidating pages on us and we lose.
 		 */
 		if (!PageUptodate(src_page) || !PageUptodate(dest_page) ||
-		    src_page->mapping != src->i_mapping ||
-		    dest_page->mapping != dest->i_mapping) {
+		    src_page->mapping != src->f_mapping ||
+		    dest_page->mapping != dest->f_mapping) {
 			same = false;
 			goto unlock;
 		}
@@ -351,8 +351,8 @@ int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
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
2.30.2

