Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C7E4AFE3D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiBIUWk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:22:40 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiBIUWZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0ECDE011172
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ZkcVQSQT1NyxhPr5NnaPJL4VGyAn52J6sWpJO3sDH5g=; b=cex66x7ojAPgSnhplwFCeG8Uql
        SeGcyYEBQ8/AC6yWSbVyAO3AALGMdGKqqxPTPnRSE0J10iqjs3Hr/rnak7iPDeUzOt6xezsPolGxr
        F8G9AuZIAM0urCxlP1t3RFsaXmwbUFXv7DeQpvWGrUE60IwgFC2ZysVigDukcQi19hziRb9BBs4Bg
        PGrL7VFI40kTAK69l+jxr1lyOmfmYYWscCFhdKB/ZdjZpswwzyTmDzYgk3qpP0XoJ//ovuHamICKP
        xD5qGROl24e269VuYggyHAOPayfvW8VkHUIEDFhbk8BSsUiRiGgD+SoVrDQpmViLPy0rodkSYl9z3
        QbdQK5TQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTs-008cqI-SH; Wed, 09 Feb 2022 20:22:24 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 18/56] afs: Convert directory aops to invalidate_folio
Date:   Wed,  9 Feb 2022 20:21:37 +0000
Message-Id: <20220209202215.2055748-19-willy@infradead.org>
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

Use folio->index instead of folio_index() because there's no way we're
writing a page from the swapcache to a directory.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/afs/dir.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index da9b4f8577a1..d30b137be476 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -42,8 +42,8 @@ static int afs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 		      struct dentry *old_dentry, struct inode *new_dir,
 		      struct dentry *new_dentry, unsigned int flags);
 static int afs_dir_releasepage(struct page *page, gfp_t gfp_flags);
-static void afs_dir_invalidatepage(struct page *page, unsigned int offset,
-				   unsigned int length);
+static void afs_dir_invalidate_folio(struct folio *folio, size_t offset,
+				   size_t length);
 
 static int afs_dir_set_page_dirty(struct page *page)
 {
@@ -75,7 +75,7 @@ const struct inode_operations afs_dir_inode_operations = {
 const struct address_space_operations afs_dir_aops = {
 	.set_page_dirty	= afs_dir_set_page_dirty,
 	.releasepage	= afs_dir_releasepage,
-	.invalidatepage	= afs_dir_invalidatepage,
+	.invalidate_folio = afs_dir_invalidate_folio,
 };
 
 const struct dentry_operations afs_fs_dentry_operations = {
@@ -2019,13 +2019,12 @@ static int afs_dir_releasepage(struct page *subpage, gfp_t gfp_flags)
 /*
  * Invalidate part or all of a folio.
  */
-static void afs_dir_invalidatepage(struct page *subpage, unsigned int offset,
-				   unsigned int length)
+static void afs_dir_invalidate_folio(struct folio *folio, size_t offset,
+				   size_t length)
 {
-	struct folio *folio = page_folio(subpage);
 	struct afs_vnode *dvnode = AFS_FS_I(folio_inode(folio));
 
-	_enter("{%lu},%u,%u", folio_index(folio), offset, length);
+	_enter("{%lu},%zu,%zu", folio->index, offset, length);
 
 	BUG_ON(!folio_test_locked(folio));
 
-- 
2.34.1

