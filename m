Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67BF7BF1BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 05:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442093AbjJJD6q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 23:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442086AbjJJD6p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 23:58:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A2EA7;
        Mon,  9 Oct 2023 20:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=xonbTILnfRDSSpwlD7/OIaZi3FMBcEwweuvW4yZCh2w=; b=aj1TKu+/EtwxufLyebFk8DMNnQ
        4UfGF4beGegRl9svNF5CGC8UMlk5h/XNEvviQQnRsb86wmbyKmOVzGmKiA9fTL3dadUOqvxayQgqr
        v16IZoYVhxC8zB7U+YMbEgAA7LrIoxiEftMqZzMDhtpXZFpDQxi9srXjZ2yE/hpaCZT1XzxEUlwzx
        7c+b9g4gVNvfVNbtsmPwZAH9nJsebScv8IRnSBF39BwyAFFYt0JA4STfeMYbCpY1bz7h4tYnF1lWf
        IUwcIoIkSJ4FkWrc17yeLi4vvxY5aVeUZP/oRUrew/Ldg7pZ3I5l96aVSVcb1R+Z5nQoub/S3+48R
        tOwzb87A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qq3tC-002Haa-ET; Tue, 10 Oct 2023 03:58:34 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Bin Lai <sclaibin@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, akpm@linux-foundation.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 1/2] filemap: Remove use of wait bookmarks
Date:   Tue, 10 Oct 2023 04:58:28 +0100
Message-Id: <20231010035829.544242-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231010032833.398033-1-robinlai@tencent.com>
References: <20231010032833.398033-1-robinlai@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The original problem of the overly long list of waiters on a
locked page was solved properly by commit 9a1ea439b16b ("mm:
put_and_wait_on_page_locked() while page is migrated").  In
the meantime, using bookmarks for the writeback bit can cause
livelocks, so we need to stop using them.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index f0a15ce1bd1b..1f9adad2d781 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1135,32 +1135,13 @@ static void folio_wake_bit(struct folio *folio, int bit_nr)
 	wait_queue_head_t *q = folio_waitqueue(folio);
 	struct wait_page_key key;
 	unsigned long flags;
-	wait_queue_entry_t bookmark;
 
 	key.folio = folio;
 	key.bit_nr = bit_nr;
 	key.page_match = 0;
 
-	bookmark.flags = 0;
-	bookmark.private = NULL;
-	bookmark.func = NULL;
-	INIT_LIST_HEAD(&bookmark.entry);
-
 	spin_lock_irqsave(&q->lock, flags);
-	__wake_up_locked_key_bookmark(q, TASK_NORMAL, &key, &bookmark);
-
-	while (bookmark.flags & WQ_FLAG_BOOKMARK) {
-		/*
-		 * Take a breather from holding the lock,
-		 * allow pages that finish wake up asynchronously
-		 * to acquire the lock and remove themselves
-		 * from wait queue
-		 */
-		spin_unlock_irqrestore(&q->lock, flags);
-		cpu_relax();
-		spin_lock_irqsave(&q->lock, flags);
-		__wake_up_locked_key_bookmark(q, TASK_NORMAL, &key, &bookmark);
-	}
+	__wake_up_locked_key(q, TASK_NORMAL, &key);
 
 	/*
 	 * It's possible to miss clearing waiters here, when we woke our page
-- 
2.40.1

