Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E4C5A9D0C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 18:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbiIAQ1n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 12:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbiIAQ10 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:27:26 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF7B5AA2C;
        Thu,  1 Sep 2022 09:27:22 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id s11so23250673edd.13;
        Thu, 01 Sep 2022 09:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=+0L2eClwsYHKJeXwvZYuWRKn+FjwoNn5ZEAvWBll6m0=;
        b=ACc7zrT169Ua1FVZex6ZCHgP4BuYWGFxhVzF51e4NFzAFmt2vyRARTrtEeaEZ0pmEu
         ynhMCS4bJgsy2LQ+Kh+JUBy8Rn6DGhz8F8ipUiNavfw/os0ii3yx8/ykRFfwvMlD4Ei6
         tawh0TF4yoXoHuiuat3LN2yyQ2/6YCaH/vnVznruo40J0RYyLL0NKFIGvS0tvGRlYHRg
         wgLbyaKPN+oC8ve8Nvlvtqg3R9ufMcOtyO1lPw1izNPvvwCnCyDW6j3TdUpnciLA7CtO
         d6Dppa6TC2DMAMAZkx7EwxmtEpybqj20UiTiQ0RXXg0qGcJl3LInnVDBRY/xddZPDUI3
         7cvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=+0L2eClwsYHKJeXwvZYuWRKn+FjwoNn5ZEAvWBll6m0=;
        b=astnkAgitOPaMMlktWFAoV8aLxrWSB9gLx1xAJQpzlXh2FKY71zbbCjNNRm0eKLEkJ
         33z0rPxx9kpf3NkhL3RAKfARQPkiQVlqyvWLVthzx6qH8xnbi+Vw/ngy8MzmoQ07xEs6
         sJiRp/MVq10knbDUz7nwa8t9884Lq5NPyD6E1ag22iS8VJVf4sd0NkxA1gfYpQx97836
         9bAGrdXa04mH5oAF5Y+MjTV6saxMAvqsNaXe+knBjNWc5q0inSxmOauxDC1qYho9Toi8
         HyynfNxR5iFfS/52I0ov7i7by359/WTimuPAwJoqD7Z33CEQVmThUbRxWInVrCAWGmUj
         teRA==
X-Gm-Message-State: ACgBeo0r4pvxS8bGzhhHYkRLjcQ2UoIruVGa0l33ulci3K/iF2RuYRMH
        NBggcwiRkTo8yMzc5KwKE+E=
X-Google-Smtp-Source: AA6agR66W/BK8tzwCWWoLIWVGbBUAC1Wi7eWWthXQBDYDdP23dChnEBehgKjee7rgOzwyyBalzCMfA==
X-Received: by 2002:a05:6402:401a:b0:448:2ce5:652a with SMTP id d26-20020a056402401a00b004482ce5652amr16907012eda.322.1662049640715;
        Thu, 01 Sep 2022 09:27:20 -0700 (PDT)
Received: from localhost.localdomain (host-87-1-103-238.retail.telecomitalia.it. [87.1.103.238])
        by smtp.gmail.com with ESMTPSA id k19-20020a1709061c1300b00730f0c19108sm8573444ejg.86.2022.09.01.09.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 09:27:18 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [RESEND PATCH] aio: Replace kmap{,_atomic}() with kmap_local_page()
Date:   Thu,  1 Sep 2022 18:27:13 +0200
Message-Id: <20220901162713.27501-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

There are two main problems with kmap(): (1) It comes with an overhead as
the mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and still valid.

Since its use in fs/aio.c is safe everywhere, it should be preferred.

Therefore, replace kmap() and kmap_atomic() with kmap_local_page() in
fs/aio.c.

Tested with xfstests on a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel
with HIGHMEM64GB enabled.

Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

I'm resending this patch because some recipients were missing in the 
previous submission. In the meantime I'm also adding some more information 
in the commit message. There are no changes in the code.

 fs/aio.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 606613e9d1f4..83c2c2e3e428 100644
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
2.37.2

