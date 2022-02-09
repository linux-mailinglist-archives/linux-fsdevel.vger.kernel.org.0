Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0FC4AFE49
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbiBIUWd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:22:33 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiBIUWX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2ACE03AE44
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=HWeIghh6FAnJs2JO8wrhLNLIgqE7jTq9sTGA0926qx8=; b=Wu/cLX+CWnBKv6i3MqMCyOMozA
        a2i/1yqb5a1GFbEeWkWAyaWybdaCAY7QHq2kJj2EE0GXQbyLrOJalybL4tgiEqKRP2H/XbO4oRoo5
        5grdty9ykRWEBrvrH9DI+crT7725+wowMLYVGNmPBtJDXFt0drYBX2RTUXENBTdp6VcF+cgXha10j
        Sjmn0JIq3nL3IYgY/ypZl7QfZfSciZseXNPoKz6rBxFPIycT2FRjWFOLWptRLOsvhXzsE51g//Bqd
        mWEbKJoe5a5RW6ClaOid3p1e/fiYpJU3/8TKPuwA9H6DqGluIRuSkhr6F7NVbJLw5p6g7ImnrAhUg
        H/VI6LWg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTr-008cpd-Rz; Wed, 09 Feb 2022 20:22:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 10/56] btrfs: Use folio_invalidate()
Date:   Wed,  9 Feb 2022 20:21:29 +0000
Message-Id: <20220209202215.2055748-11-willy@infradead.org>
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

Instead of calling ->invalidatepage directly, use folio_invalidate().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/extent_io.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 409bad3928db..1e6bf7f1639a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4048,6 +4048,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 			      struct extent_page_data *epd)
 {
+	struct folio *folio = page_folio(page);
 	struct inode *inode = page->mapping->host;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	const u64 page_start = page_offset(page);
@@ -4068,8 +4069,8 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	pg_offset = offset_in_page(i_size);
 	if (page->index > end_index ||
 	   (page->index == end_index && !pg_offset)) {
-		page->mapping->a_ops->invalidatepage(page, 0, PAGE_SIZE);
-		unlock_page(page);
+		folio_invalidate(folio, 0, folio_size(folio));
+		folio_unlock(folio);
 		return 0;
 	}
 
-- 
2.34.1

