Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84263661E5B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 06:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbjAIFSo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 00:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbjAIFST (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 00:18:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C4DDEBB;
        Sun,  8 Jan 2023 21:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/TboxjvLj2LzaTPo6wOwSPdZqcAQLPCIOhhkOsSnAto=; b=nb4a5StFHAwGzV5DL8zXSWnxJw
        zX600UOuwgmVsgmjNFBmqtMFxS3xy8oIktPbQkH8TRK7ibTOd9FSpSh760MmC9CNX44HBqsWmi/N/
        UDlCxOA7LujBoWs15c9vzwZdsHq5P+N6jwyH3KWvAvYzHO2vlJFU9V1QNqyBGQRrdrZwNcdugBvtP
        3zAHtqfRrI9/eo03r3LBI3D0DlE6gp7IrVEkLzTfqFcNiqtxYLZGQs5aDUuOlcHvk31wtghpU8Omp
        15oltxC23wFZYvXnu2blmo/TycCTrH3pEYJvW4N4bLOfpWYrtEf0G6ZhxHe1M6ij03Kc3FJ4BHc5S
        19VIUrTA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEkYC-0020wm-NL; Mon, 09 Jan 2023 05:18:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 01/11] memory-failure: Remove comment referencing AS_EIO
Date:   Mon,  9 Jan 2023 05:18:13 +0000
Message-Id: <20230109051823.480289-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230109051823.480289-1-willy@infradead.org>
References: <20230109051823.480289-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The EIO is now reported to every caller which has the file open on
the next operation which returns an error.  We obviously cannot check
whether the user took action correctly on that error, but we can remove
this comment as wb_err is never cleared, unlike AS_EIO.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory-failure.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index c77a9e37e27e..1a1c66f7e5dd 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -992,34 +992,6 @@ static int me_pagecache_dirty(struct page_state *ps, struct page *p)
 		 * who check the mapping.
 		 * This way the application knows that something went
 		 * wrong with its dirty file data.
-		 *
-		 * There's one open issue:
-		 *
-		 * The EIO will be only reported on the next IO
-		 * operation and then cleared through the IO map.
-		 * Normally Linux has two mechanisms to pass IO error
-		 * first through the AS_EIO flag in the address space
-		 * and then through the PageError flag in the page.
-		 * Since we drop pages on memory failure handling the
-		 * only mechanism open to use is through AS_AIO.
-		 *
-		 * This has the disadvantage that it gets cleared on
-		 * the first operation that returns an error, while
-		 * the PageError bit is more sticky and only cleared
-		 * when the page is reread or dropped.  If an
-		 * application assumes it will always get error on
-		 * fsync, but does other operations on the fd before
-		 * and the page is dropped between then the error
-		 * will not be properly reported.
-		 *
-		 * This can already happen even without hwpoisoned
-		 * pages: first on metadata IO errors (which only
-		 * report through AS_EIO) or when the page is dropped
-		 * at the wrong time.
-		 *
-		 * So right now we assume that the application DTRT on
-		 * the first EIO, but we're not worse than other parts
-		 * of the kernel.
 		 */
 		mapping_set_error(mapping, -EIO);
 	}
-- 
2.35.1

