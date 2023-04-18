Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7260A6E6D3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 22:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjDRUGv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 16:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjDRUGu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 16:06:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991821FD7
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Apr 2023 13:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=nra3jp3jKA3tPfqlH724qwOf4XVq9URsXISvLGTpKcg=; b=UHMzLex2lxjw/5HFYp16QeAiIP
        qeb3IkHviaC7fP8Dw1yahyHAOltLpHXv1Oy3BsCHlWgHF31E6Tu/Wccv9dUbhhvmeB1qVCDcMvDqq
        DPXWa445O6rX2ly1NLTGNQUZhcrvBbtOLsMPhPEYqXJ3226vZAQyqVwCWjAz88EKx3SuS+crEG+Xp
        p6XohZG0pMSiKUVfa6wsMKU5u7IOOhmwFFV8Iszv4/IYMIl/p1G9Q8tnk8gHkmZZB2ZI0GHely/1F
        QGNR2PEll25L3iPJMjxJjcKsBy63cExbCakYyFZJJJo1kCy0L+H9OYELg3SHZrbdnKkHLGk2Fbm5S
        oapLdGAg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1porb6-00Cc6n-B9; Tue, 18 Apr 2023 20:06:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, tytso@mit.edu,
        akpm@linux-foundation.org, broonie@kernel.org,
        sfr@canb.auug.org.au, hch@lst.de
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>,
        syzbot+d1ae544e6e9dc29bcba5@syzkaller.appspotmail.com,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH] ext4: Handle error pointers being returned from __filemap_get_folio
Date:   Tue, 18 Apr 2023 21:06:35 +0100
Message-Id: <20230418200636.3006418-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit "mm: return an ERR_PTR from __filemap_get_folio" changed from
returning NULL to returning an ERR_PTR().  This cannot be fixed in either
the ext4 tree or the mm tree, so this patch should be applied as part
of merging the two trees.

Reported-by: Eric Biggers <ebiggers@kernel.org>
Reported-by: syzbot+d1ae544e6e9dc29bcba5@syzkaller.appspotmail.com
Debugged-by: William Kucharski <william.kucharski@oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inline.c | 17 +++++++++--------
 fs/ext4/inode.c  | 12 ++++++------
 fs/ext4/verity.c |  6 ++++--
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index b9fb1177fff6..ab220d4bf73f 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -566,8 +566,9 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 	 * started */
 	folio = __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN | FGP_NOFS,
 			mapping_gfp_mask(mapping));
-	if (!folio) {
-		ret = -ENOMEM;
+	if (IS_ERR(folio)) {
+		ret = PTR_ERR(folio);
+		folio = NULL;
 		goto out;
 	}
 
@@ -693,8 +694,8 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 
 	folio = __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN | FGP_NOFS,
 					mapping_gfp_mask(mapping));
-	if (!folio) {
-		ret = -ENOMEM;
+	if (IS_ERR(folio)) {
+		ret = PTR_ERR(folio);
 		goto out;
 	}
 
@@ -854,8 +855,8 @@ static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
 
 	folio = __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN,
 					mapping_gfp_mask(mapping));
-	if (!folio)
-		return -ENOMEM;
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
 
 	down_read(&EXT4_I(inode)->xattr_sem);
 	if (!ext4_has_inline_data(inode)) {
@@ -947,8 +948,8 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 	 */
 	folio = __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN | FGP_NOFS,
 					mapping_gfp_mask(mapping));
-	if (!folio) {
-		ret = -ENOMEM;
+	if (IS_ERR(folio)) {
+		ret = PTR_ERR(folio);
 		goto out_journal;
 	}
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 974747a6eb99..9052c90215eb 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1177,8 +1177,8 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 retry_grab:
 	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
 					mapping_gfp_mask(mapping));
-	if (!folio)
-		return -ENOMEM;
+	if (IS_ERR(folio))
+		return PTE_ERR(folio);
 	/*
 	 * The same as page allocation, we prealloc buffer heads before
 	 * starting the handle.
@@ -2932,8 +2932,8 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 retry:
 	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
 			mapping_gfp_mask(mapping));
-	if (!folio)
-		return -ENOMEM;
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
 
 	/* In case writeback began while the folio was unlocked */
 	folio_wait_stable(folio);
@@ -3675,8 +3675,8 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 	folio = __filemap_get_folio(mapping, from >> PAGE_SHIFT,
 				    FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
 				    mapping_gfp_constraint(mapping, ~__GFP_FS));
-	if (!folio)
-		return -ENOMEM;
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
 
 	blocksize = inode->i_sb->s_blocksize;
 
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index 3b01247066dd..ce4b720f19a1 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -366,14 +366,16 @@ static struct page *ext4_read_merkle_tree_page(struct inode *inode,
 	index += ext4_verity_metadata_pos(inode) >> PAGE_SHIFT;
 
 	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
-	if (!folio || !folio_test_uptodate(folio)) {
+	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
 		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
 
-		if (folio)
+		if (!IS_ERR(folio))
 			folio_put(folio);
 		else if (num_ra_pages > 1)
 			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
 		folio = read_mapping_folio(inode->i_mapping, index, NULL);
+		if (IS_ERR(folio))
+			return &folio->page;
 	}
 	return folio_file_page(folio, index);
 }
-- 
2.39.2

