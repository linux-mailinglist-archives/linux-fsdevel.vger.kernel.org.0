Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85AE7A25F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236577AbjIOShu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbjIOShf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:37:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859E0115;
        Fri, 15 Sep 2023 11:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3RDv1UzFpsOkAGzAbd6eo8f3gCp7HajbbasO9DDS7OQ=; b=l7/C+pIBN/0+OfCBSo8I+LYeOy
        mF+TpEuZNJw8+JiNsmRfWrhjnNLgd6Txx79Xz2XVo7OVest1Qi+dglnG1T25vyb0Xpc8NLATE9/Au
        ybl6Gu/i/Td0hGN+ZdVvfD8LF/2mk/oF4PUmAsSRMpnyTXOei1O3inZEkAt6HEz7IaCtxJRYNOxM0
        6GS70vkf9aU86BccdSHzK8DlUV7uejZVS8XHXtB4KyvwB8hapKImjlueOcr/dVW2WJbm4DdFvYPPw
        nbKZFLvA2rCr2J8VDHR9zw1FjnvHE8CpEr6SiUz+TbiJBEjFRsjX3erwBo5P1AshO50tSAoi8YhYN
        ECdR01vg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhDgj-00BMIQ-6i; Fri, 15 Sep 2023 18:37:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        torvalds@linux-foundation.org, Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 02/17] iomap: Protect read_bytes_pending with the state_lock
Date:   Fri, 15 Sep 2023 19:36:52 +0100
Message-Id: <20230915183707.2707298-3-willy@infradead.org>
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

Perform one atomic operation (acquiring the spinlock) instead of
two (spinlock & atomic_sub) per read completion.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4c05fd457ee7..cade15b70627 100644
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
@@ -250,19 +250,33 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	*lenp = plen;
 }
 
-static void iomap_finish_folio_read(struct folio *folio, size_t offset,
+static void iomap_finish_folio_read(struct folio *folio, size_t off,
 		size_t len, int error)
 {
 	struct iomap_folio_state *ifs = folio->private;
+	unsigned long flags;
+	bool uptodate;
+	bool finished = true;
+
+	if (ifs)
+		spin_lock_irqsave(&ifs->state_lock, flags);
 
 	if (unlikely(error)) {
-		folio_clear_uptodate(folio);
+		uptodate = false;
 		folio_set_error(folio);
 	} else {
-		iomap_set_range_uptodate(folio, offset, len);
+		uptodate = !ifs || ifs_set_range_uptodate(folio, ifs, off, len);
 	}
 
-	if (!ifs || atomic_sub_and_test(len, &ifs->read_bytes_pending))
+	if (ifs) {
+		ifs->read_bytes_pending -= len;
+		finished = !ifs->read_bytes_pending;
+		spin_unlock_irqrestore(&ifs->state_lock, flags);
+	}
+
+	if (uptodate)
+		folio_mark_uptodate(folio);
+	if (finished)
 		folio_unlock(folio);
 }
 
@@ -360,8 +374,11 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
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

