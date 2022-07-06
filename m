Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13A85695E2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jul 2022 01:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbiGFXdk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jul 2022 19:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiGFXdj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jul 2022 19:33:39 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E2D2C13F;
        Wed,  6 Jul 2022 16:33:38 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-fe023ab520so23275476fac.10;
        Wed, 06 Jul 2022 16:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dzOHVv+XbHrZsgZSc3OOkERaguxtxPA+pM05lL+6VEQ=;
        b=TP6mmgadAGE06un4m7cHhzx09Aza0OFLYZrPwuVrd+U5Il94rd+JBQQulyK3OvzSFB
         QD/fryC7srd5WiUkne7pSs+ZiY4gG5eyP7bmoRE3w43DSRhflWl1F0XmqQXlzibTm4NL
         7jWxpT4UvTah1DZxv4XSGjXjdjywgMVCQtDd7dZIvqj6MZ5vl7+YooKPZEd9aFmEhUjI
         3KEqpFYL7pCLFE0uXW1Rw1qY6rJxsSGm3Rcnc9Jr+kB+k3T7LpC692ib6zHcl0X/I0+y
         kOYoZGdmdqcQlseB8QLuH8RbmMViP52kjUrgK7BBn5b0l9ELA9FIL814V8dU3tWA86tV
         MEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dzOHVv+XbHrZsgZSc3OOkERaguxtxPA+pM05lL+6VEQ=;
        b=6GmkNOry4qLAGW6WvXKmjIj3eJunKTGYjgNpFus8kl/ujFu42mb7LbyxDJXNHRU3+v
         Qrxp8N3xkmCHN6z7cfgGJGG65ZmLYZho4VfDFeablZRtMcqbzw1DRGb9qUUFHezzJE+l
         A4IR8MX3P6z/Z9HkDmt7YGrzH04j75qLQRm/HzxpQ9JEMCwCikuO9kHEvNN91AMJ5/CC
         052dYvrQW0hXFXfTXMhOSv1bcFCM2Iz8Eo8qXS8QFTRgPj1BnR/J9eeOgRWEGkmo3H3w
         2HwQUUK2HY2BpgBDzUqFmSgGrrR2ziaArnkqd/EFHO1+cHERcUtPNQ7hz+64+MZZGF+/
         Kv9w==
X-Gm-Message-State: AJIora+opnPDGYVyRE1WZomZ2yn/LZg60CsyTHk/7T7YI7oIDe5+ONBA
        vdfzYWihHbbwD3Kropouybo=
X-Google-Smtp-Source: AGRyM1uAlBkPBvG9rksI3+esyDpbN2qye6njZ6On8tiP2U/lcinWRfHTouianYxDWxwy6R7mWpKQYA==
X-Received: by 2002:a05:6870:a70c:b0:10c:3bb7:ea15 with SMTP id g12-20020a056870a70c00b0010c3bb7ea15mr104203oam.69.1657150417374;
        Wed, 06 Jul 2022 16:33:37 -0700 (PDT)
Received: from localhost.localdomain (host-79-53-109-127.retail.telecomitalia.it. [79.53.109.127])
        by smtp.gmail.com with ESMTPSA id f19-20020a056830057300b0060bd2d06a1csm17583363otc.47.2022.07.06.16.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 16:33:36 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] aio: Replace kmap{,_atomic}() with kmap_local_page()
Date:   Thu,  7 Jul 2022 01:33:28 +0200
Message-Id: <20220706233328.18582-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.36.1
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

The use of kmap() and kmap_atomic() are being deprecated in favor of
kmap_local_page().

With kmap_local_page(), the mappings are per thread, CPU local and not
globally visible. Furthermore, the mappings can be acquired from any
context (including interrupts).

Therefore, use kmap_local_page() in aio.c because these mappings are per
thread, CPU local, and not globally visible.

Tested with xfstests on a QEMU + KVM 32-bits VM booting a kernel with
HIGHMEM64GB enabled.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

I've tested with "./check -g aio". The tests in this group fail 3/26
times, with and without my patch. Therefore, these changes don't introduce
further errors.

 fs/aio.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 3c249b938632..343fea0c6d1a 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -567,7 +567,7 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 	ctx->user_id = ctx->mmap_base;
 	ctx->nr_events = nr_events; /* trusted copy */
 
-	ring = kmap_atomic(ctx->ring_pages[0]);
+	ring = kmap_local_page(ctx->ring_pages[0]);
 	ring->nr = nr_events;	/* user copy */
 	ring->id = ~0U;
 	ring->head = ring->tail = 0;
@@ -575,7 +575,7 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 	ring->compat_features = AIO_RING_COMPAT_FEATURES;
 	ring->incompat_features = AIO_RING_INCOMPAT_FEATURES;
 	ring->header_length = sizeof(struct aio_ring);
-	kunmap_atomic(ring);
+	kunmap_local(ring);
 	flush_dcache_page(ctx->ring_pages[0]);
 
 	return 0;
@@ -678,9 +678,9 @@ static int ioctx_add_table(struct kioctx *ctx, struct mm_struct *mm)
 					 * we are protected from page migration
 					 * changes ring_pages by ->ring_lock.
 					 */
-					ring = kmap_atomic(ctx->ring_pages[0]);
+					ring = kmap_local_page(ctx->ring_pages[0]);
 					ring->id = ctx->id;
-					kunmap_atomic(ring);
+					kunmap_local(ring);
 					return 0;
 				}
 
@@ -1024,9 +1024,9 @@ static void user_refill_reqs_available(struct kioctx *ctx)
 		 * against ctx->completed_events below will make sure we do the
 		 * safe/right thing.
 		 */
-		ring = kmap_atomic(ctx->ring_pages[0]);
+		ring = kmap_local_page(ctx->ring_pages[0]);
 		head = ring->head;
-		kunmap_atomic(ring);
+		kunmap_local(ring);
 
 		refill_reqs_available(ctx, head, ctx->tail);
 	}
@@ -1132,12 +1132,12 @@ static void aio_complete(struct aio_kiocb *iocb)
 	if (++tail >= ctx->nr_events)
 		tail = 0;
 
-	ev_page = kmap_atomic(ctx->ring_pages[pos / AIO_EVENTS_PER_PAGE]);
+	ev_page = kmap_local_page(ctx->ring_pages[pos / AIO_EVENTS_PER_PAGE]);
 	event = ev_page + pos % AIO_EVENTS_PER_PAGE;
 
 	*event = iocb->ki_res;
 
-	kunmap_atomic(ev_page);
+	kunmap_local(ev_page);
 	flush_dcache_page(ctx->ring_pages[pos / AIO_EVENTS_PER_PAGE]);
 
 	pr_debug("%p[%u]: %p: %p %Lx %Lx %Lx\n", ctx, tail, iocb,
@@ -1151,10 +1151,10 @@ static void aio_complete(struct aio_kiocb *iocb)
 
 	ctx->tail = tail;
 
-	ring = kmap_atomic(ctx->ring_pages[0]);
+	ring = kmap_local_page(ctx->ring_pages[0]);
 	head = ring->head;
 	ring->tail = tail;
-	kunmap_atomic(ring);
+	kunmap_local(ring);
 	flush_dcache_page(ctx->ring_pages[0]);
 
 	ctx->completed_events++;
@@ -1214,10 +1214,10 @@ static long aio_read_events_ring(struct kioctx *ctx,
 	mutex_lock(&ctx->ring_lock);
 
 	/* Access to ->ring_pages here is protected by ctx->ring_lock. */
-	ring = kmap_atomic(ctx->ring_pages[0]);
+	ring = kmap_local_page(ctx->ring_pages[0]);
 	head = ring->head;
 	tail = ring->tail;
-	kunmap_atomic(ring);
+	kunmap_local(ring);
 
 	/*
 	 * Ensure that once we've read the current tail pointer, that
@@ -1249,10 +1249,10 @@ static long aio_read_events_ring(struct kioctx *ctx,
 		avail = min(avail, nr - ret);
 		avail = min_t(long, avail, AIO_EVENTS_PER_PAGE - pos);
 
-		ev = kmap(page);
+		ev = kmap_local_page(page);
 		copy_ret = copy_to_user(event + ret, ev + pos,
 					sizeof(*ev) * avail);
-		kunmap(page);
+		kunmap_local(ev);
 
 		if (unlikely(copy_ret)) {
 			ret = -EFAULT;
@@ -1264,9 +1264,9 @@ static long aio_read_events_ring(struct kioctx *ctx,
 		head %= ctx->nr_events;
 	}
 
-	ring = kmap_atomic(ctx->ring_pages[0]);
+	ring = kmap_local_page(ctx->ring_pages[0]);
 	ring->head = head;
-	kunmap_atomic(ring);
+	kunmap_local(ring);
 	flush_dcache_page(ctx->ring_pages[0]);
 
 	pr_debug("%li  h%u t%u\n", ret, head, tail);
-- 
2.36.1

