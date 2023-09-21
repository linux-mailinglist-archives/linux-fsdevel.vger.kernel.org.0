Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3275A7A9FE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 22:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjIUU2l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 16:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjIUU2V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:28:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5AF72A5;
        Thu, 21 Sep 2023 13:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=DpcGBZFseQaBcbzBaplzUJIEQ4KhgQ0pIV/RSG6D0J4=; b=VDPXuH+nctu3+Y0e/1+wC+wO5n
        CR62cr6GO7K1jGLHiIlH+HdNuLDl4yanrRYRpTdJNPgQvwH96duOFQY17d87Di+T3m5geOYEpxecP
        pTcDjHrrHPjqYYXau+S7F3sNmQPcAMO3O50Yq4y+4z4lQbYDgYAxM+p5tTEsijMH9OYzmMajEulup
        PrnN9BjLgn0JxXDJ2JUMTGdJmr11UfiuC2pKYP4CbqxjSooU4sTwllcMcs6RzoJ/RZqJp3uv4s0Lo
        XFYzVmFnMqLk5lnP3/3DXXzgAP1wAkR7qoB6+hNGl3acwl2ZGWVGyVsw5eziWqNtoodV1iCc8l0a9
        /y+PREuQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qjPxk-00DrW4-AN; Thu, 21 Sep 2023 20:07:48 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Jan Kara <jack@suse.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 09/10] ext2: Convert ext2_make_empty() to use a folio
Date:   Thu, 21 Sep 2023 21:07:46 +0100
Message-Id: <20230921200746.3303942-9-willy@infradead.org>
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

Remove two hidden calls to compound_head() by using the folio API.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext2/dir.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index dad71ef38395..414680bdb170 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -618,21 +618,21 @@ int ext2_delete_entry(struct ext2_dir_entry_2 *dir, struct folio *folio)
  */
 int ext2_make_empty(struct inode *inode, struct inode *parent)
 {
-	struct page *page = grab_cache_page(inode->i_mapping, 0);
+	struct folio *folio = filemap_grab_folio(inode->i_mapping, 0);
 	unsigned chunk_size = ext2_chunk_size(inode);
 	struct ext2_dir_entry_2 * de;
 	int err;
 	void *kaddr;
 
-	if (!page)
-		return -ENOMEM;
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
 
-	err = ext2_prepare_chunk(page, 0, chunk_size);
+	err = ext2_prepare_chunk(&folio->page, 0, chunk_size);
 	if (err) {
-		unlock_page(page);
+		folio_unlock(folio);
 		goto fail;
 	}
-	kaddr = kmap_local_page(page);
+	kaddr = kmap_local_folio(folio, 0);
 	memset(kaddr, 0, chunk_size);
 	de = (struct ext2_dir_entry_2 *)kaddr;
 	de->name_len = 1;
@@ -648,10 +648,10 @@ int ext2_make_empty(struct inode *inode, struct inode *parent)
 	memcpy (de->name, "..\0", 4);
 	ext2_set_de_type (de, inode);
 	kunmap_local(kaddr);
-	ext2_commit_chunk(page, 0, chunk_size);
+	ext2_commit_chunk(&folio->page, 0, chunk_size);
 	err = ext2_handle_dirsync(inode);
 fail:
-	put_page(page);
+	folio_put(folio);
 	return err;
 }
 
-- 
2.40.1

