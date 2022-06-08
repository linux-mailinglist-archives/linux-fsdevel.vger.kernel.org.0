Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD153543685
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 17:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243940AbiFHPM7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 11:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242276AbiFHPLk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:11:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8EB3A5F7;
        Wed,  8 Jun 2022 08:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=WUpG8Ni861ynrjDUWCnLTkzTIfxUJKXosLuHAm7Cnl4=; b=TZRY1wF8ksrrIs1o9KbjlHWauY
        4i3hvUjlM2cIjRUnhetVv8G6jMyi14dv6mXReUhlvxDOk++478UFLwnOTQRcW2OAzYRGsNtgSvdbm
        rzbNL4L83yv6t9VuZB7jb2fZTbAOWlo5a8uudsYH/7aOxtrNzw8CLlAmsabS+HdXV4gWCKA8QRNjP
        TEB2Mf9KWDrGrK8TMAo35J12l2+xg69zacyrBtimmMBqI0hEgYTGk5qIEXSbuwxPZt8S1FzoWckM/
        zJjg6W8idqpi/4VI0InsOV4Q7s8MeTv9rUBHDNK/kOpKOuF3YHJ2V9jmVvRttDYxzg4YE4S5tdNTF
        ViZ46uBg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyxCv-00CjFi-3n; Wed, 08 Jun 2022 15:02:53 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ocfs2-devel@oss.oracle.com,
        linux-mtd@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 15/19] aio: Convert to migrate_folio
Date:   Wed,  8 Jun 2022 16:02:45 +0100
Message-Id: <20220608150249.3033815-16-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220608150249.3033815-1-willy@infradead.org>
References: <20220608150249.3033815-1-willy@infradead.org>
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

Use a folio throughout this function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/aio.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 3c249b938632..a1911e86859c 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -400,8 +400,8 @@ static const struct file_operations aio_ring_fops = {
 };
 
 #if IS_ENABLED(CONFIG_MIGRATION)
-static int aio_migratepage(struct address_space *mapping, struct page *new,
-			struct page *old, enum migrate_mode mode)
+static int aio_migrate_folio(struct address_space *mapping, struct folio *dst,
+			struct folio *src, enum migrate_mode mode)
 {
 	struct kioctx *ctx;
 	unsigned long flags;
@@ -435,10 +435,10 @@ static int aio_migratepage(struct address_space *mapping, struct page *new,
 		goto out;
 	}
 
-	idx = old->index;
+	idx = src->index;
 	if (idx < (pgoff_t)ctx->nr_pages) {
-		/* Make sure the old page hasn't already been changed */
-		if (ctx->ring_pages[idx] != old)
+		/* Make sure the old folio hasn't already been changed */
+		if (ctx->ring_pages[idx] != &src->page)
 			rc = -EAGAIN;
 	} else
 		rc = -EINVAL;
@@ -447,27 +447,27 @@ static int aio_migratepage(struct address_space *mapping, struct page *new,
 		goto out_unlock;
 
 	/* Writeback must be complete */
-	BUG_ON(PageWriteback(old));
-	get_page(new);
+	BUG_ON(folio_test_writeback(src));
+	folio_get(dst);
 
-	rc = migrate_page_move_mapping(mapping, new, old, 1);
+	rc = folio_migrate_mapping(mapping, dst, src, 1);
 	if (rc != MIGRATEPAGE_SUCCESS) {
-		put_page(new);
+		folio_put(dst);
 		goto out_unlock;
 	}
 
 	/* Take completion_lock to prevent other writes to the ring buffer
-	 * while the old page is copied to the new.  This prevents new
+	 * while the old folio is copied to the new.  This prevents new
 	 * events from being lost.
 	 */
 	spin_lock_irqsave(&ctx->completion_lock, flags);
-	migrate_page_copy(new, old);
-	BUG_ON(ctx->ring_pages[idx] != old);
-	ctx->ring_pages[idx] = new;
+	folio_migrate_copy(dst, src);
+	BUG_ON(ctx->ring_pages[idx] != &src->page);
+	ctx->ring_pages[idx] = &dst->page;
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
 
-	/* The old page is no longer accessible. */
-	put_page(old);
+	/* The old folio is no longer accessible. */
+	folio_put(src);
 
 out_unlock:
 	mutex_unlock(&ctx->ring_lock);
@@ -475,13 +475,13 @@ static int aio_migratepage(struct address_space *mapping, struct page *new,
 	spin_unlock(&mapping->private_lock);
 	return rc;
 }
+#else
+#define aio_migrate_folio NULL
 #endif
 
 static const struct address_space_operations aio_ctx_aops = {
 	.dirty_folio	= noop_dirty_folio,
-#if IS_ENABLED(CONFIG_MIGRATION)
-	.migratepage	= aio_migratepage,
-#endif
+	.migrate_folio	= aio_migrate_folio,
 };
 
 static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
-- 
2.35.1

