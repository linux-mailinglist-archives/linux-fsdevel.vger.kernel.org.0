Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76874AFE51
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbiBIUXJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:23:09 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiBIUWa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD94EE03A433
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=zugh9hBAAkYkphkH1c3wCenfbulJS5BjBEV6MUWNWag=; b=GEG+CoTzb2Hj+G4EBb0QREmxAs
        H8p9WVHOfmWB/5EwtTnmJNmrfetniliqa6+Y/mLhKVFHxfmmL8q7+02hAK4dcS3nK5VP1ylTIeStI
        zpl8FXV9I9NnDkqUI25bQ5EV1N6pT4zaKDXC8ojCupWCqhLfjFYIB5QFwo9OJXGmdZF+qDWl0j2KZ
        LZxQaARFoH/ASoRRwbDqPvsrv5AYDRfqR2giiZJfU1ookIofqvWvr/kGmqCcciGg5RknEeevT4Tw6
        5lFJiHtgc3m2Mu4rmeQoJOEeyOBHVrsZJhbdI1lGOC9x4A34CEIasdisMca1nPXfeSoZiH7zSp8Eo
        zy2+AaBQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTv-008crw-1Y; Wed, 09 Feb 2022 20:22:27 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 35/56] afs: Convert from launder_page to launder_folio
Date:   Wed,  9 Feb 2022 20:21:54 +0000
Message-Id: <20220209202215.2055748-36-willy@infradead.org>
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

Straightforward conversion.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/afs/file.c     | 2 +-
 fs/afs/internal.h | 2 +-
 fs/afs/write.c    | 5 ++---
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 699ea2dd01e4..56b20b922751 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -55,7 +55,7 @@ const struct address_space_operations afs_file_aops = {
 	.readpage	= afs_readpage,
 	.readahead	= afs_readahead,
 	.set_page_dirty	= afs_set_page_dirty,
-	.launder_page	= afs_launder_page,
+	.launder_folio	= afs_launder_folio,
 	.releasepage	= afs_releasepage,
 	.invalidate_folio = afs_invalidate_folio,
 	.write_begin	= afs_write_begin,
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index b6f02321fc09..4023d8e6ab30 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1537,7 +1537,7 @@ extern ssize_t afs_file_write(struct kiocb *, struct iov_iter *);
 extern int afs_fsync(struct file *, loff_t, loff_t, int);
 extern vm_fault_t afs_page_mkwrite(struct vm_fault *vmf);
 extern void afs_prune_wb_keys(struct afs_vnode *);
-extern int afs_launder_page(struct page *);
+int afs_launder_folio(struct folio *);
 
 /*
  * xattr.c
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 5e9157d0da29..5864411bd006 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -972,9 +972,8 @@ void afs_prune_wb_keys(struct afs_vnode *vnode)
 /*
  * Clean up a page during invalidation.
  */
-int afs_launder_page(struct page *subpage)
+int afs_launder_folio(struct folio *folio)
 {
-	struct folio *folio = page_folio(subpage);
 	struct afs_vnode *vnode = AFS_FS_I(folio_inode(folio));
 	struct iov_iter iter;
 	struct bio_vec bv[1];
@@ -982,7 +981,7 @@ int afs_launder_page(struct page *subpage)
 	unsigned int f, t;
 	int ret = 0;
 
-	_enter("{%lx}", folio_index(folio));
+	_enter("{%lx}", folio->index);
 
 	priv = (unsigned long)folio_get_private(folio);
 	if (folio_clear_dirty_for_io(folio)) {
-- 
2.34.1

