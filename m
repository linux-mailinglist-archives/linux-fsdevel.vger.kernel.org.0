Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B268C6C8453
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 19:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbjCXSDd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 14:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjCXSCY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:02:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005D21D916;
        Fri, 24 Mar 2023 11:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jeLVbEl4yXZYpRJwtY0rVlxnFijO5EjU1OfFLcACE9g=; b=Rr7oK2joj+5DXmKqJcDDjGoYv5
        xTFG04HCMaL94dWl0oVoua3OBrLBOAIgXdYRnrvpUUkHqFZJsdW1MOMOOKUeTfAGrlPbDVEXqL7N3
        AT+DHHSQMZgLj4NKIZjU2gWiyWCU443dw4JDUgOeKe6IHlbvTpIfrZA2ErnoIIMtSkw2JhhxbsohR
        591Gs+I4P1InnuHY8Gje1Q61q7g+s6n5LFfPc0HkaiDH2tWb4VmXUS93cD94LeTP78NHvPSJ9hfb9
        x/41wkHmj/Ztixa3c3gTShckCzVf2jXx5JXwbZxHF55Xq/V9vDsrVcrzs98FGK3sX3hzBPZKQI6SQ
        QDVH0MjA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfljN-0057ac-IM; Fri, 24 Mar 2023 18:01:37 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 21/29] ext4: Convert ext4_page_nomap_can_writeout to ext4_folio_nomap_can_writeout
Date:   Fri, 24 Mar 2023 18:01:21 +0000
Message-Id: <20230324180129.1220691-22-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230324180129.1220691-1-willy@infradead.org>
References: <20230324180129.1220691-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Its one caller already uses a folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index a81540a6e8c6..acb2345fb379 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2335,12 +2335,12 @@ static int ext4_da_writepages_trans_blocks(struct inode *inode)
 				MAX_WRITEPAGES_EXTENT_LEN + bpp - 1, bpp);
 }
 
-/* Return true if the page needs to be written as part of transaction commit */
-static bool ext4_page_nomap_can_writeout(struct page *page)
+/* Return true if the folio needs to be written as part of transaction commit */
+static bool ext4_folio_nomap_can_writeout(struct folio *folio)
 {
 	struct buffer_head *bh, *head;
 
-	bh = head = page_buffers(page);
+	bh = head = folio_buffers(folio);
 	do {
 		if (buffer_dirty(bh) && buffer_mapped(bh) && !buffer_delay(bh))
 			return true;
@@ -2533,7 +2533,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			 * range operations before discarding the page cache.
 			 */
 			if (!mpd->can_map) {
-				if (ext4_page_nomap_can_writeout(&folio->page)) {
+				if (ext4_folio_nomap_can_writeout(folio)) {
 					WARN_ON_ONCE(sb->s_writers.frozen ==
 						     SB_FREEZE_COMPLETE);
 					err = mpage_submit_folio(mpd, folio);
-- 
2.39.2

