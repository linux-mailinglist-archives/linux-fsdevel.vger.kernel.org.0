Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E45C4AFE2E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbiBIUW7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:22:59 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiBIUW0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2069DE040CB9
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=F9Kmk1OwfrKVAPqgFCvyQXgXNhd3AeQiS98Fk6oOE04=; b=RgPUKAVZ/iqdcQHbs9epTthvCt
        pIpuXVefysrheK88AEC6TpQz9KZAdC6LFihFzJUJz4wED9h8f/8C6WEWoT4DHRjhzNAWM9uPwMrs3
        +E31DVkd0jd6Q60Z8djrraz6Az/QlBGbaYZcYAk8ngjGHL00aHnJ6vl8FHhUJGTTEIGPAu9krrE5r
        9J7rjWcGEZzxBzsNlae6x8+oXfHX+s4HWiMqDxYtBa6UhLf878FIu3yr5bVCScYHP5/tum1xaaTAg
        GnVNkqsAQVtmZCIh5XNBu/w9MmfyogbHWXvksFhqkHtroj0GcRt3AxvAlswbE4bUSYdetjEB7NJuJ
        a/G8heWA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTt-008cr2-SZ; Wed, 09 Feb 2022 20:22:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 26/56] gfs2: Convert invalidatepage to invalidate_folio
Date:   Wed,  9 Feb 2022 20:21:45 +0000
Message-Id: <20220209202215.2055748-27-willy@infradead.org>
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

This is a straightforward conversion.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/gfs2/aops.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 3d54e6101ed1..119cb38d99a7 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -672,22 +672,23 @@ static void gfs2_discard(struct gfs2_sbd *sdp, struct buffer_head *bh)
 	unlock_buffer(bh);
 }
 
-static void gfs2_invalidatepage(struct page *page, unsigned int offset,
-				unsigned int length)
+static void gfs2_invalidate_folio(struct folio *folio, size_t offset,
+				size_t length)
 {
-	struct gfs2_sbd *sdp = GFS2_SB(page->mapping->host);
-	unsigned int stop = offset + length;
-	int partial_page = (offset || length < PAGE_SIZE);
+	struct gfs2_sbd *sdp = GFS2_SB(folio->mapping->host);
+	size_t stop = offset + length;
+	int partial_page = (offset || length < folio_size(folio));
 	struct buffer_head *bh, *head;
 	unsigned long pos = 0;
 
-	BUG_ON(!PageLocked(page));
+	BUG_ON(!folio_test_locked(folio));
 	if (!partial_page)
-		ClearPageChecked(page);
-	if (!page_has_buffers(page))
+		folio_clear_checked(folio);
+	head = folio_buffers(folio);
+	if (!head)
 		goto out;
 
-	bh = head = page_buffers(page);
+	bh = head;
 	do {
 		if (pos + bh->b_size > stop)
 			return;
@@ -699,7 +700,7 @@ static void gfs2_invalidatepage(struct page *page, unsigned int offset,
 	} while (bh != head);
 out:
 	if (!partial_page)
-		try_to_release_page(page, 0);
+		filemap_release_folio(folio, 0);
 }
 
 /**
@@ -796,7 +797,7 @@ static const struct address_space_operations gfs2_jdata_aops = {
 	.readahead = gfs2_readahead,
 	.set_page_dirty = jdata_set_page_dirty,
 	.bmap = gfs2_bmap,
-	.invalidatepage = gfs2_invalidatepage,
+	.invalidate_folio = gfs2_invalidate_folio,
 	.releasepage = gfs2_releasepage,
 	.is_partially_uptodate = block_is_partially_uptodate,
 	.error_remove_page = generic_error_remove_page,
-- 
2.34.1

