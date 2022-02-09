Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21144AFE60
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbiBIUXU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:23:20 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiBIUWa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339F5E011172
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=h1y2nr7OZAdZI0OL8cahJSGo6D/YsFQmBsqKa5sUPdE=; b=gUudRMe5FUB0k7esqWCbHD2jLz
        /Ww4wJN5BojwN8tqeQ3zybyzlGeb70k8Jgh+l3aiftpZ0mYI8pqCk4B15VPobkPiq/ftW9jmqj9ta
        ZjlTDSFTFySCZIspXFUvCJlAH08NivjGunP0M/UMAfu/1waLOdrxVP7orkpFFR4y6QO7kw7B6kEQH
        BM9byupj+IPSCKhQaHeLX2GklLp4m7oVRtgLzGwgx0x2tKHtoU2GXUP4vf4FDlF4ecLFcEHWZzENw
        dRNl1OHeZNC8UqDL0wrEslDM3sFwOm0vx7/C+Gyc11sZXGW2WWIg+fD5+Vd/mQBNZ8EmXVJRKdr4g
        BqXrs8vw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTw-008css-Ar; Wed, 09 Feb 2022 20:22:28 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 45/56] btrfs: Convert extent_range_redirty_for_io() to use folios
Date:   Wed,  9 Feb 2022 20:22:04 +0000
Message-Id: <20220209202215.2055748-46-willy@infradead.org>
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

This removes a call to __set_page_dirty_nobuffers().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/extent_io.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9c9952ce33a2..3d6dc9121315 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1507,17 +1507,17 @@ void extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end)
 
 void extent_range_redirty_for_io(struct inode *inode, u64 start, u64 end)
 {
+	struct address_space *mapping = inode->i_mapping;
 	unsigned long index = start >> PAGE_SHIFT;
 	unsigned long end_index = end >> PAGE_SHIFT;
-	struct page *page;
+	struct folio *folio;
 
 	while (index <= end_index) {
-		page = find_get_page(inode->i_mapping, index);
-		BUG_ON(!page); /* Pages should be in the extent_io_tree */
-		__set_page_dirty_nobuffers(page);
-		account_page_redirty(page);
-		put_page(page);
-		index++;
+		folio = filemap_get_folio(mapping, index);
+		filemap_dirty_folio(mapping, folio);
+		folio_account_redirty(folio);
+		index += folio_nr_pages(folio);
+		folio_put(folio);
 	}
 }
 
-- 
2.34.1

