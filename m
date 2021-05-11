Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC31937A9FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 16:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbhEKO5n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 10:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbhEKO5k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 10:57:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A88C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 May 2021 07:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Bqx4zatTG9LmseQND5BN8vqwgtUaqfUr9GxZe/UaUbY=; b=LLDyv+xqvxzoNWNByG32QOnLa/
        F/DVxzLToKc4ZrSx4CXShCf2CF8PIBmQT+kODZfFZ/xDGAKxQXOl2spmYlkrhFnbE0GffQEyl44gZ
        nNWaH1SKFMYJptX1rapJ4IwEPevmczGDeqTetRaZZ535Jmz+7BJlHepY55MZTR3gU0mPZ+g4GD0Fu
        MCvW9+OS3N056CZ/BNVUhrRG5jf/BP5Orp2J9Hy4V+12VRnY910ezzL985WulFEZNZv0XtzKuOG2z
        wfmUo0uWxmCIJjhdMSsoG/kgQ0Kx0jheEmgKhmMbAZuvdegTxGH6heADwjA8Z1QaHMF6gy5AudXKd
        pJCs1yfA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgTnt-007Nju-Gx; Tue, 11 May 2021 14:56:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-afs@lists.infradead.org, dhowells@redhat.com,
        marc.dionne@auristor.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk
Subject: [PATCH] vfs/dedupe: Pass file pointer to read_mapping_page
Date:   Tue, 11 May 2021 15:56:08 +0100
Message-Id: <20210511145608.1759501-1-willy@infradead.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some filesystems (eg AFS) need a valid file pointer for their ->readpage
operation.  Presumably none of them currently support deduplication,
but it's just as easy to pass the struct file around as it is to pass
the struct inode around, and it sets a good example for other users.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/remap_range.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index e4a5fdd7ad7b..982ba89aeeb6 100644
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
+					 struct file *dst, loff_t destoff,
 					 loff_t len, bool *is_same)
 {
 	loff_t src_poff;
@@ -229,7 +229,7 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 			error = PTR_ERR(src_page);
 			goto out_error;
 		}
-		dest_page = vfs_dedupe_get_page(dest, destoff);
+		dest_page = vfs_dedupe_get_page(dst, destoff);
 		if (IS_ERR(dest_page)) {
 			error = PTR_ERR(dest_page);
 			put_page(src_page);
@@ -244,8 +244,8 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 		 * someone is invalidating pages on us and we lose.
 		 */
 		if (!PageUptodate(src_page) || !PageUptodate(dest_page) ||
-		    src_page->mapping != src->i_mapping ||
-		    dest_page->mapping != dest->i_mapping) {
+		    src_page->mapping != src->f_mapping ||
+		    dest_page->mapping != dst->f_mapping) {
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

