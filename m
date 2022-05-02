Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD3F516A8E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 07:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383440AbiEBGAn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 02:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383407AbiEBGA1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 02:00:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7CD1FA6B
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 May 2022 22:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VQ6jqtngGXvzx1zwMFkonroHqNpenCazJO7v657zZ4M=; b=NqxG2m/H2oeBLkupYDhQ+16yq8
        9hroAKnJsEQFrdvdh+7GBjRw5CRe9LOYWORk+quzIUQLjCHPb3VRURJwYtVGGS6tzUCf3uV6beIXd
        d1CBoaarXAWjUwu2fh07OmXRzdeOjjuMD4aoW7iI5zVksE3OHEM3P28mJH3mi878B8fncBz0Xeqrf
        ZRKYIfws3o13CdRZIRuULrbs9EWOTnKeYdbKaJ25m5495z2DHbKXqgN27KiHd6sF/CTSzlJHPRSId
        5dEExoaIZ6zGMFEJjNJJNE9wBfrKkn4D4QHHjOvYg0mexLl7ZSMWQbx10cTFXA+gL8+Z7uv+rypn1
        WAm6/8yw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlP2h-00EZX9-QJ; Mon, 02 May 2022 05:56:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 22/26] reiserfs: Convert release_buffer_page() to use a folio
Date:   Mon,  2 May 2022 06:56:10 +0100
Message-Id: <20220502055614.3473032-23-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220502055614.3473032-1-willy@infradead.org>
References: <20220502055614.3473032-1-willy@infradead.org>
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

Saves 671 bytes from an allmodconfig build (!)

Function                                     old     new   delta
release_buffer_page                         1617     946    -671
Total: Before=67656, After=66985, chg -0.99%

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/reiserfs/journal.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index b5b6f6201bed..99ba495b0f28 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -601,14 +601,14 @@ static int journal_list_still_alive(struct super_block *s,
  */
 static void release_buffer_page(struct buffer_head *bh)
 {
-	struct page *page = bh->b_page;
-	if (!page->mapping && trylock_page(page)) {
-		get_page(page);
+	struct folio *folio = page_folio(bh->b_page);
+	if (!folio->mapping && folio_trylock(folio)) {
+		folio_get(folio);
 		put_bh(bh);
-		if (!page->mapping)
-			try_to_free_buffers(page);
-		unlock_page(page);
-		put_page(page);
+		if (!folio->mapping)
+			try_to_free_buffers(&folio->page);
+		folio_unlock(folio);
+		folio_put(folio);
 	} else {
 		put_bh(bh);
 	}
-- 
2.34.1

