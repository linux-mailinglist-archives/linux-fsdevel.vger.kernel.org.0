Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437F3729D95
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 16:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238987AbjFIO7r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 10:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjFIO7p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:59:45 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AA818C;
        Fri,  9 Jun 2023 07:59:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30aeee7c8a0so1449607f8f.1;
        Fri, 09 Jun 2023 07:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686322782; x=1688914782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XI39v/7BPEpOgTd1ALuJFcrtG1R04Si+uRN4qfzVrdk=;
        b=JOwpClW4kxDpACnhAcaLLPR5zm45hHTlHF+6x2FqO0IEX4WGcGlz/H6b2nd6egp8i5
         Xpjl+QnSgcNXwBm75739S0XBZosZBOakIOur62fA7AsgKC2t2lmtLA5qHmYPg+MHsSg0
         sXCM/AR1/GGQ1uo5j1AKeHIrKOo9aKQQ2CJBzXKnFxzr5aIdkCsaJvDNlXNEXy2IJ5SQ
         Y4REPYLTCg7528tfe82OtJF2kqvG7diQtak2N6Sdl3ZbZPQ6FLMs3998Ww4nP+QR9Jpf
         tnZIL5+R7npG3luYHPeM4XOaslpkmATga3Rdmc+0rhUaBoutCQt1BmQ+32Bk0h6ajZFE
         BY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686322782; x=1688914782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XI39v/7BPEpOgTd1ALuJFcrtG1R04Si+uRN4qfzVrdk=;
        b=HF6Fi86aMDCrQp8nD3yrZyvJJsfmR05QS3ICEgtTmbjRwpLLyCQJa/DAF9QHonTBH5
         VNj7lXalk/mbohWgBMQTXTCny30oOV4fzKxxf67aSTsxybqsKEnTzLwgrwQaUzzFvKlo
         Zs6TUjAwLlZTP990675auG7OoJ197ZM8cmoumhwqR20RQTFyxGvzho6VtEoThVOuTtjx
         TtAeHMlpMfIYQYfxd7ultXA41lbmMSP82lgSjNL7Sf2TSdtbQBgwRVhX6548ZX6OVH90
         B7xbLuSHVjOgr6oVQyYM6KXs5U4HCKEo9Uvg+nqaY0pzYv8Xlh5QidkIfThuFoOKSCP2
         8+Kg==
X-Gm-Message-State: AC+VfDxTEmrv2FvpF63fjT4UGkPtavwnT10yk/dvjp3gb5WnL0Oh+WD5
        ioojqgZPG7r3JYa89PzMV90=
X-Google-Smtp-Source: ACHHUZ6dIZ+sbjDFcD2M2x+4e10P9a9GzWEM3rkygzIEfY/A25ZxwQISgmoYzwY6D0yXMEuHobuwiw==
X-Received: by 2002:a5d:4946:0:b0:30a:f20b:e71 with SMTP id r6-20020a5d4946000000b0030af20b0e71mr1808984wrs.33.1686322781508;
        Fri, 09 Jun 2023 07:59:41 -0700 (PDT)
Received: from localhost.localdomain (host-95-252-166-216.retail.telecomitalia.it. [95.252.166.216])
        by smtp.gmail.com with ESMTPSA id x14-20020adfec0e000000b002f6176cc6desm4703705wrn.110.2023.06.09.07.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:59:40 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Benjamin LaHaise <bcrl@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] fs/aio: Stop allocating aio rings from HIGHMEM
Date:   Fri,  9 Jun 2023 16:59:37 +0200
Message-Id: <20230609145937.17610-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no need to allocate aio rings from HIGHMEM because of very
little memory needed here.

Therefore, use GFP_USER flag in find_or_create_page() and get rid of
kmap*() mappings.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/aio.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index b0b17bd098bb..77e33619de40 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -530,7 +530,7 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 	for (i = 0; i < nr_pages; i++) {
 		struct page *page;
 		page = find_or_create_page(file->f_mapping,
-					   i, GFP_HIGHUSER | __GFP_ZERO);
+					   i, GFP_USER | __GFP_ZERO);
 		if (!page)
 			break;
 		pr_debug("pid(%d) page[%d]->count=%d\n",
@@ -571,7 +571,7 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 	ctx->user_id = ctx->mmap_base;
 	ctx->nr_events = nr_events; /* trusted copy */
 
-	ring = kmap_atomic(ctx->ring_pages[0]);
+	ring = page_address(ctx->ring_pages[0]);
 	ring->nr = nr_events;	/* user copy */
 	ring->id = ~0U;
 	ring->head = ring->tail = 0;
@@ -579,7 +579,6 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 	ring->compat_features = AIO_RING_COMPAT_FEATURES;
 	ring->incompat_features = AIO_RING_INCOMPAT_FEATURES;
 	ring->header_length = sizeof(struct aio_ring);
-	kunmap_atomic(ring);
 	flush_dcache_page(ctx->ring_pages[0]);
 
 	return 0;
@@ -682,9 +681,8 @@ static int ioctx_add_table(struct kioctx *ctx, struct mm_struct *mm)
 					 * we are protected from page migration
 					 * changes ring_pages by ->ring_lock.
 					 */
-					ring = kmap_atomic(ctx->ring_pages[0]);
+					ring = page_address(ctx->ring_pages[0]);
 					ring->id = ctx->id;
-					kunmap_atomic(ring);
 					return 0;
 				}
 
@@ -1025,9 +1023,8 @@ static void user_refill_reqs_available(struct kioctx *ctx)
 		 * against ctx->completed_events below will make sure we do the
 		 * safe/right thing.
 		 */
-		ring = kmap_atomic(ctx->ring_pages[0]);
+		ring = page_address(ctx->ring_pages[0]);
 		head = ring->head;
-		kunmap_atomic(ring);
 
 		refill_reqs_available(ctx, head, ctx->tail);
 	}
@@ -1133,12 +1130,11 @@ static void aio_complete(struct aio_kiocb *iocb)
 	if (++tail >= ctx->nr_events)
 		tail = 0;
 
-	ev_page = kmap_atomic(ctx->ring_pages[pos / AIO_EVENTS_PER_PAGE]);
+	ev_page = page_address(ctx->ring_pages[pos / AIO_EVENTS_PER_PAGE]);
 	event = ev_page + pos % AIO_EVENTS_PER_PAGE;
 
 	*event = iocb->ki_res;
 
-	kunmap_atomic(ev_page);
 	flush_dcache_page(ctx->ring_pages[pos / AIO_EVENTS_PER_PAGE]);
 
 	pr_debug("%p[%u]: %p: %p %Lx %Lx %Lx\n", ctx, tail, iocb,
@@ -1152,10 +1148,9 @@ static void aio_complete(struct aio_kiocb *iocb)
 
 	ctx->tail = tail;
 
-	ring = kmap_atomic(ctx->ring_pages[0]);
+	ring = page_address(ctx->ring_pages[0]);
 	head = ring->head;
 	ring->tail = tail;
-	kunmap_atomic(ring);
 	flush_dcache_page(ctx->ring_pages[0]);
 
 	ctx->completed_events++;
@@ -1215,10 +1210,9 @@ static long aio_read_events_ring(struct kioctx *ctx,
 	mutex_lock(&ctx->ring_lock);
 
 	/* Access to ->ring_pages here is protected by ctx->ring_lock. */
-	ring = kmap_atomic(ctx->ring_pages[0]);
+	ring = page_address(ctx->ring_pages[0]);
 	head = ring->head;
 	tail = ring->tail;
-	kunmap_atomic(ring);
 
 	/*
 	 * Ensure that once we've read the current tail pointer, that
@@ -1250,10 +1244,9 @@ static long aio_read_events_ring(struct kioctx *ctx,
 		avail = min(avail, nr - ret);
 		avail = min_t(long, avail, AIO_EVENTS_PER_PAGE - pos);
 
-		ev = kmap(page);
+		ev = page_address(page);
 		copy_ret = copy_to_user(event + ret, ev + pos,
 					sizeof(*ev) * avail);
-		kunmap(page);
 
 		if (unlikely(copy_ret)) {
 			ret = -EFAULT;
@@ -1265,9 +1258,8 @@ static long aio_read_events_ring(struct kioctx *ctx,
 		head %= ctx->nr_events;
 	}
 
-	ring = kmap_atomic(ctx->ring_pages[0]);
+	ring = page_address(ctx->ring_pages[0]);
 	ring->head = head;
-	kunmap_atomic(ring);
 	flush_dcache_page(ctx->ring_pages[0]);
 
 	pr_debug("%li  h%u t%u\n", ret, head, tail);
-- 
2.40.1

