Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6B84AFE61
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiBIUXe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:23:34 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbiBIUWa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1CBE036C12
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=d8uybxLwI+Lfek5sfukx5So2VITTZMAUbz8ac1UZrjs=; b=YgpSO3bo9wygIunuHYygUMAIU8
        rK1Bs73t6kcKP2jA5FgTXVLXGNBg2jRtLGjcMU59e1JHLW7hGlH/jc7lYJ2OY+AVK5btfKAexcAA1
        Qbpj58FcqGG/fMH1CggKIRoHg7NBhre2IiTaziL2ios5HSwKLq4r3jl1PWgrx2WdkaDwxxsrCzDc9
        bpYeQOSvVs3sI5YLaV/RJsdVFcPBX3Ya/ZSXq6fqMgECsz+nnXI1zqoSYCNP7Fq9rA/yUdIlLiLx3
        eX5TqCobbDPkHYKz73kU9me99pmN0R1UsK2DaoqboqoJBXdcnylhI+Qhy1kG6nE6qSxLXG13zCGHx
        afCxlYLw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTw-008ctC-Ks; Wed, 09 Feb 2022 20:22:28 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 47/56] f2fs: Convert f2fs_set_meta_page_dirty to f2fs_dirty_meta_folio
Date:   Wed,  9 Feb 2022 20:22:06 +0000
Message-Id: <20220209202215.2055748-48-willy@infradead.org>
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

Removes a call to __set_page_dirty_nobuffers().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/checkpoint.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 097d792723cb..49100ae0c17f 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -436,25 +436,26 @@ long f2fs_sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 	return nwritten;
 }
 
-static int f2fs_set_meta_page_dirty(struct page *page)
+static bool f2fs_dirty_meta_folio(struct address_space *mapping,
+		struct folio *folio)
 {
-	trace_f2fs_set_page_dirty(page, META);
-
-	if (!PageUptodate(page))
-		SetPageUptodate(page);
-	if (!PageDirty(page)) {
-		__set_page_dirty_nobuffers(page);
-		inc_page_count(F2FS_P_SB(page), F2FS_DIRTY_META);
-		set_page_private_reference(page);
-		return 1;
+	trace_f2fs_set_page_dirty(&folio->page, META);
+
+	if (!folio_test_uptodate(folio))
+		folio_mark_uptodate(folio);
+	if (!folio_test_dirty(folio)) {
+		filemap_dirty_folio(mapping, folio);
+		inc_page_count(F2FS_P_SB(&folio->page), F2FS_DIRTY_META);
+		set_page_private_reference(&folio->page);
+		return true;
 	}
-	return 0;
+	return false;
 }
 
 const struct address_space_operations f2fs_meta_aops = {
 	.writepage	= f2fs_write_meta_page,
 	.writepages	= f2fs_write_meta_pages,
-	.set_page_dirty	= f2fs_set_meta_page_dirty,
+	.dirty_folio	= f2fs_dirty_meta_folio,
 	.invalidate_folio = f2fs_invalidate_folio,
 	.releasepage	= f2fs_release_page,
 #ifdef CONFIG_MIGRATION
-- 
2.34.1

