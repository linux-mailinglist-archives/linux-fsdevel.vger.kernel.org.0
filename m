Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5FF7A2612
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236698AbjIOSiU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236548AbjIOShs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:37:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760DC1BDA;
        Fri, 15 Sep 2023 11:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wP0bf/c0k4lziBracMplPOL5jGzdkJZTznJybrN+G0o=; b=nmNahHbU8N6VQC3bwwkYcMi5SK
        9z62LhVFB97uUetddKzSC5oxvrkgAa/37C9YLshZHa2WYGzbLW1TAnnZNykG8eoRg+AOQq8BqL20h
        TfICsXD5xZCp5JrkQ4Q1sz/lfXN+iKm2bI9bS0rzLlmR6H21VLEf8YRxZaKEZUmUCNVMKfXfEh5aO
        jns8hqlgjEOLgpJQUGWwTWmGwpgmYz8XJ09lPpNE96iue3gnjaEUr3FLrhGJIr5rUkDm6pkOnyjLu
        eKXEzJKBOlS5VYgsfvPQtgf/zPmG3M/q0F4HUD9j5wJj9j7ISu1xfFpZQYsQ8GjQvM65661Wvg30j
        F47ncT9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhDgj-00BMId-FC; Fri, 15 Sep 2023 18:37:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        torvalds@linux-foundation.org, Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 05/17] buffer: Use folio_end_read()
Date:   Fri, 15 Sep 2023 19:36:55 +0100
Message-Id: <20230915183707.2707298-6-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230915183707.2707298-1-willy@infradead.org>
References: <20230915183707.2707298-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are two places that we can use this new helper.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 2379564e5aea..345a9a42610f 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -282,13 +282,7 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 	} while (tmp != bh);
 	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
 
-	/*
-	 * If all of the buffers are uptodate then we can set the page
-	 * uptodate.
-	 */
-	if (folio_uptodate)
-		folio_mark_uptodate(folio);
-	folio_unlock(folio);
+	folio_end_read(folio, folio_uptodate);
 	return;
 
 still_busy:
@@ -2413,12 +2407,10 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 
 	if (!nr) {
 		/*
-		 * All buffers are uptodate - we can set the folio uptodate
-		 * as well. But not if get_block() returned an error.
+		 * All buffers are uptodate or get_block() returned an
+		 * error when trying to map them - we can finish the read.
 		 */
-		if (!page_error)
-			folio_mark_uptodate(folio);
-		folio_unlock(folio);
+		folio_end_read(folio, !page_error);
 		return 0;
 	}
 
-- 
2.40.1

