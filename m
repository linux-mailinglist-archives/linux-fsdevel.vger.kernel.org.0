Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC0C4AFE69
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiBIUYq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:24:46 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiBIUWb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6615E040C91
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ZARDHYRCwJ5K3eBzNF5ktK7HsBljkgCNrKj9vdVXrFs=; b=K7ErIOzzqhoKEyhLM7uF2yNsEB
        8RxRQLNNfpifGzlf+0FSJ1aWjV1efW6zKUz4EVx8jyXncCfjoo5d0Qyw1vLrF49tcQ+BYqpjatbC9
        LCtmVcJ6Yg4Hj/nAUsaw4LsG78Kz7Oj7Q2AzDZlw5S/bwn6u12tXnoX/mzDkrWHiEiJ7eEWYn326X
        yhoaZRv8U6RDliRQZ1h1oKx+6cJs6TA2zldqzYdumUjVNXy96nIK1xO4cUQikNbuF34FStD0DYrlf
        16IzkpZJZQA65oZ/Ahtijrbq43KoOPsw4kz+Dn9GSfjn8ndn2GYip0uitXm5S97jsuNsXoHAYzNDL
        kvPW2UZg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTw-008ctN-So; Wed, 09 Feb 2022 20:22:28 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 49/56] f2fs: Convert f2fs_set_node_page_dirty to f2fs_dirty_node_folio
Date:   Wed,  9 Feb 2022 20:22:08 +0000
Message-Id: <20220209202215.2055748-50-willy@infradead.org>
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
 fs/f2fs/node.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 803c2b55ce86..7c73340133e6 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2132,23 +2132,24 @@ static int f2fs_write_node_pages(struct address_space *mapping,
 	return 0;
 }
 
-static int f2fs_set_node_page_dirty(struct page *page)
+static bool f2fs_dirty_node_folio(struct address_space *mapping,
+		struct folio *folio)
 {
-	trace_f2fs_set_page_dirty(page, NODE);
+	trace_f2fs_set_page_dirty(&folio->page, NODE);
 
-	if (!PageUptodate(page))
-		SetPageUptodate(page);
+	if (!folio_test_uptodate(folio))
+		folio_mark_uptodate(folio);
 #ifdef CONFIG_F2FS_CHECK_FS
-	if (IS_INODE(page))
-		f2fs_inode_chksum_set(F2FS_P_SB(page), page);
+	if (IS_INODE(&folio->page))
+		f2fs_inode_chksum_set(F2FS_P_SB(&folio->page), &folio->page);
 #endif
-	if (!PageDirty(page)) {
-		__set_page_dirty_nobuffers(page);
-		inc_page_count(F2FS_P_SB(page), F2FS_DIRTY_NODES);
-		set_page_private_reference(page);
-		return 1;
+	if (!folio_test_dirty(folio)) {
+		filemap_dirty_folio(mapping, folio);
+		inc_page_count(F2FS_P_SB(&folio->page), F2FS_DIRTY_NODES);
+		set_page_private_reference(&folio->page);
+		return true;
 	}
-	return 0;
+	return false;
 }
 
 /*
@@ -2157,7 +2158,7 @@ static int f2fs_set_node_page_dirty(struct page *page)
 const struct address_space_operations f2fs_node_aops = {
 	.writepage	= f2fs_write_node_page,
 	.writepages	= f2fs_write_node_pages,
-	.set_page_dirty	= f2fs_set_node_page_dirty,
+	.dirty_folio	= f2fs_dirty_node_folio,
 	.invalidate_folio = f2fs_invalidate_folio,
 	.releasepage	= f2fs_release_page,
 #ifdef CONFIG_MIGRATION
-- 
2.34.1

