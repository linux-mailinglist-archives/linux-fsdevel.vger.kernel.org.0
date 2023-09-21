Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AFE7A9FE2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 22:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjIUU2p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 16:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbjIUU2W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:28:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078A41BD2;
        Thu, 21 Sep 2023 13:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gtOgVtPNNezeOOLRmkyVuxJoCCJKpeE8vQ+YG/Md84M=; b=sKtNSRPfQU/7zpwYkvIktptbwR
        RBADHF+phFGuL1VHlDwY5huLCyLFz0SocfDDk7cNI6Wnbfs1q1SmoL0NIaXwVOgD+BiijAa+lj5Df
        5Hc7ZkX2816GWoG34J1X0EieS9upenpo+fndZC29VeFCPE3q/vOGQjyE/cTYTvJx1g05ufp6mvEhH
        GocL78U7ZRlZ5xPhmDcchbbJYRuDspKNIugnXEKOCYihaDwQWcfOA8VEMeuFpfFK40qzXKrjQp6Mt
        5/WSiClAAADJlrUHFZlIJj6xuoxigDO/FJPKUIMrL6h0+akOI1hdK67X3MyQb9wSqTYaJ8VtR7wvd
        B+6yztMg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qjPxj-00DrVo-Up; Thu, 21 Sep 2023 20:07:47 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Jan Kara <jack@suse.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 05/10] ext2: Convert ext2_add_link() to use a folio
Date:   Thu, 21 Sep 2023 21:07:42 +0100
Message-Id: <20230921200746.3303942-5-willy@infradead.org>
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

Remove five hidden calls to compound_head() and fix a couple of
places that assumed PAGE_SIZE.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext2/dir.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index 5a8a02d6be9a..31333b23adf3 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -497,7 +497,7 @@ int ext2_add_link (struct dentry *dentry, struct inode *inode)
 	unsigned chunk_size = ext2_chunk_size(dir);
 	unsigned reclen = EXT2_DIR_REC_LEN(namelen);
 	unsigned short rec_len, name_len;
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	ext2_dirent * de;
 	unsigned long npages = dir_pages(dir);
 	unsigned long n;
@@ -506,19 +506,19 @@ int ext2_add_link (struct dentry *dentry, struct inode *inode)
 
 	/*
 	 * We take care of directory expansion in the same loop.
-	 * This code plays outside i_size, so it locks the page
+	 * This code plays outside i_size, so it locks the folio
 	 * to protect that region.
 	 */
 	for (n = 0; n <= npages; n++) {
-		char *kaddr = ext2_get_page(dir, n, 0, &page);
+		char *kaddr = ext2_get_folio(dir, n, 0, &folio);
 		char *dir_end;
 
 		if (IS_ERR(kaddr))
 			return PTR_ERR(kaddr);
-		lock_page(page);
+		folio_lock(folio);
 		dir_end = kaddr + ext2_last_byte(dir, n);
 		de = (ext2_dirent *)kaddr;
-		kaddr += PAGE_SIZE - reclen;
+		kaddr += folio_size(folio) - reclen;
 		while ((char *)de <= kaddr) {
 			if ((char *)de == dir_end) {
 				/* We hit i_size */
@@ -545,15 +545,15 @@ int ext2_add_link (struct dentry *dentry, struct inode *inode)
 				goto got_it;
 			de = (ext2_dirent *) ((char *) de + rec_len);
 		}
-		unlock_page(page);
-		ext2_put_page(page, kaddr);
+		folio_unlock(folio);
+		folio_release_kmap(folio, kaddr);
 	}
 	BUG();
 	return -EINVAL;
 
 got_it:
-	pos = page_offset(page) + offset_in_page(de);
-	err = ext2_prepare_chunk(page, pos, rec_len);
+	pos = folio_pos(folio) + offset_in_folio(folio, de);
+	err = ext2_prepare_chunk(&folio->page, pos, rec_len);
 	if (err)
 		goto out_unlock;
 	if (de->inode) {
@@ -566,17 +566,17 @@ int ext2_add_link (struct dentry *dentry, struct inode *inode)
 	memcpy(de->name, name, namelen);
 	de->inode = cpu_to_le32(inode->i_ino);
 	ext2_set_de_type (de, inode);
-	ext2_commit_chunk(page, pos, rec_len);
+	ext2_commit_chunk(&folio->page, pos, rec_len);
 	dir->i_mtime = inode_set_ctime_current(dir);
 	EXT2_I(dir)->i_flags &= ~EXT2_BTREE_FL;
 	mark_inode_dirty(dir);
 	err = ext2_handle_dirsync(dir);
 	/* OFFSET_CACHE */
 out_put:
-	ext2_put_page(page, de);
+	folio_release_kmap(folio, de);
 	return err;
 out_unlock:
-	unlock_page(page);
+	folio_unlock(folio);
 	goto out_put;
 }
 
-- 
2.40.1

