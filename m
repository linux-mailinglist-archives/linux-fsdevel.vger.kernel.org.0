Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB2354364D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 17:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243800AbiFHPME (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 11:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242490AbiFHPL4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:11:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FAC4A0969;
        Wed,  8 Jun 2022 08:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jUHtPvxpwYn/CbCKtCO4gIDrDPVTvyaQoVGtIQShqV8=; b=F0wkIwdh5JarabWL7s440hCeed
        JG7M+RAPNvEs0qtJ0odlvedPM5u6UNyXbTmEBm4Hx35BoOjFV1oKCmRWs7a2p1I7DWzzzvlvH7zxb
        NwAy72/kutKMINfwHD8wNSSOmlkp/ZbcRgANHqqHoyDCAzRFMPKBCLvDG/+pf/SqWyA6xVonIuvPK
        3Vo2mRZDOuHUiWFb793CtPIl0KBu+BtlMkUJpzHLOBoi3MTThxjS7QgPBZ4bWXFBqmBv38WY81zoI
        IOHo+aIWKHbzH55lED0UDiMkvsiu5YHhPck8zRT5hnVZDoeLyNfO5FO+6YtWEQzYK/lnegSOXMkks
        Gp33NrTQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyxCu-00CjFe-U7; Wed, 08 Jun 2022 15:02:52 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ocfs2-devel@oss.oracle.com,
        linux-mtd@lists.infradead.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2 13/19] ubifs: Convert to filemap_migrate_folio()
Date:   Wed,  8 Jun 2022 16:02:43 +0100
Message-Id: <20220608150249.3033815-14-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220608150249.3033815-1-willy@infradead.org>
References: <20220608150249.3033815-1-willy@infradead.org>
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

filemap_migrate_folio() is a little more general than ubifs really needs,
but it's better to share the code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ubifs/file.c | 29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 04ced154960f..f2353dd676ef 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1461,29 +1461,6 @@ static bool ubifs_dirty_folio(struct address_space *mapping,
 	return ret;
 }
 
-#ifdef CONFIG_MIGRATION
-static int ubifs_migrate_page(struct address_space *mapping,
-		struct page *newpage, struct page *page, enum migrate_mode mode)
-{
-	int rc;
-
-	rc = migrate_page_move_mapping(mapping, newpage, page, 0);
-	if (rc != MIGRATEPAGE_SUCCESS)
-		return rc;
-
-	if (PagePrivate(page)) {
-		detach_page_private(page);
-		attach_page_private(newpage, (void *)1);
-	}
-
-	if (mode != MIGRATE_SYNC_NO_COPY)
-		migrate_page_copy(newpage, page);
-	else
-		migrate_page_states(newpage, page);
-	return MIGRATEPAGE_SUCCESS;
-}
-#endif
-
 static bool ubifs_release_folio(struct folio *folio, gfp_t unused_gfp_flags)
 {
 	struct inode *inode = folio->mapping->host;
@@ -1649,10 +1626,8 @@ const struct address_space_operations ubifs_file_address_operations = {
 	.write_end      = ubifs_write_end,
 	.invalidate_folio = ubifs_invalidate_folio,
 	.dirty_folio	= ubifs_dirty_folio,
-#ifdef CONFIG_MIGRATION
-	.migratepage	= ubifs_migrate_page,
-#endif
-	.release_folio    = ubifs_release_folio,
+	.migrate_folio	= filemap_migrate_folio,
+	.release_folio	= ubifs_release_folio,
 };
 
 const struct inode_operations ubifs_file_inode_operations = {
-- 
2.35.1

