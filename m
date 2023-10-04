Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5907F7B85DD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 18:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243508AbjJDQyM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 12:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243562AbjJDQxl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:53:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5EFF9;
        Wed,  4 Oct 2023 09:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=D/8R0cQXGxymytv8qeJZP60gdDV9xdbcF13gSUAJ8s0=; b=P9PqackIT0b7fZvk2PUiwq2eEL
        ogL4pXi4p90LlQsy6dqVmscrou91ZCSdQPbrsXf44oAxDyO/BxwBm5Z2vIwKUlQlUDpjFbnFPG9fM
        BrJ63AckCUHqeJPCN9sjwAn+cG1XEsPXgyCNIWA2qvjPyp6VYgJA83cYUMVSJesCNkv4zWzv7yoTQ
        gP2Z1xQ6jEcNIyFm3dsMavIcKirjm580itF3FOEGmJRHUDqy4pF9sGf2LiGyEorzm8grd31hr/VVK
        KTTbbG5C8guCMxuwevbECmyH8mc5IYYAvCK+Lb8Nkenf0880jROkyzHaXctQk/+6ULTCzBapwqBs3
        erU9zo2g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qo57f-004SEv-92; Wed, 04 Oct 2023 16:53:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, torvalds@linux-foundation.org,
        npiggin@gmail.com
Subject: [PATCH v2 02/17] iomap: Protect read_bytes_pending with the state_lock
Date:   Wed,  4 Oct 2023 17:53:02 +0100
Message-Id: <20231004165317.1061855-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231004165317.1061855-1-willy@infradead.org>
References: <20231004165317.1061855-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Perform one atomic operation (acquiring the spinlock) instead of
two (spinlock & atomic_sub) per read completion.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6e780ca64ce3..4a996c5327ef 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -29,9 +29,9 @@ typedef int (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t length);
  * and I/O completions.
  */
 struct iomap_folio_state {
-	atomic_t		read_bytes_pending;
-	atomic_t		write_bytes_pending;
 	spinlock_t		state_lock;
+	unsigned int		read_bytes_pending;
+	atomic_t		write_bytes_pending;
 
 	/*
 	 * Each block has two bits in this bitmap:
@@ -183,7 +183,7 @@ static void ifs_free(struct folio *folio)
 
 	if (!ifs)
 		return;
-	WARN_ON_ONCE(atomic_read(&ifs->read_bytes_pending));
+	WARN_ON_ONCE(ifs->read_bytes_pending != 0);
 	WARN_ON_ONCE(atomic_read(&ifs->write_bytes_pending));
 	WARN_ON_ONCE(ifs_is_fully_uptodate(folio, ifs) !=
 			folio_test_uptodate(folio));
@@ -250,19 +250,29 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	*lenp = plen;
 }
 
-static void iomap_finish_folio_read(struct folio *folio, size_t offset,
+static void iomap_finish_folio_read(struct folio *folio, size_t off,
 		size_t len, int error)
 {
 	struct iomap_folio_state *ifs = folio->private;
+	bool uptodate = !error;
+	bool finished = true;
 
-	if (unlikely(error)) {
-		folio_clear_uptodate(folio);
-		folio_set_error(folio);
-	} else {
-		iomap_set_range_uptodate(folio, offset, len);
+	if (ifs) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&ifs->state_lock, flags);
+		if (!error)
+			uptodate = ifs_set_range_uptodate(folio, ifs, off, len);
+		ifs->read_bytes_pending -= len;
+		finished = !ifs->read_bytes_pending;
+		spin_unlock_irqrestore(&ifs->state_lock, flags);
 	}
 
-	if (!ifs || atomic_sub_and_test(len, &ifs->read_bytes_pending))
+	if (error)
+		folio_set_error(folio);
+	if (uptodate)
+		folio_mark_uptodate(folio);
+	if (finished)
 		folio_unlock(folio);
 }
 
@@ -360,8 +370,11 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	}
 
 	ctx->cur_folio_in_bio = true;
-	if (ifs)
-		atomic_add(plen, &ifs->read_bytes_pending);
+	if (ifs) {
+		spin_lock_irq(&ifs->state_lock);
+		ifs->read_bytes_pending += plen;
+		spin_unlock_irq(&ifs->state_lock);
+	}
 
 	sector = iomap_sector(iomap, pos);
 	if (!ctx->bio ||
-- 
2.40.1

