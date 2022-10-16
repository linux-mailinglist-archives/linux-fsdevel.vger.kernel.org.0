Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA06A600065
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Oct 2022 17:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiJPPGx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Oct 2022 11:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiJPPGw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Oct 2022 11:06:52 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197F31659F;
        Sun, 16 Oct 2022 08:06:51 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a10so14687238wrm.12;
        Sun, 16 Oct 2022 08:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mSANhTB5Zz4UC3KsIc8lXyn9giGudjvJ/sHgGjqk5pM=;
        b=hpET3coX8+u76QtArP03ZgDQK3NzQELvextbpUV3lG/18lHkFjd9xpzR0OVfiWPRc7
         lVxae9IN9hAbnqlXdi8Ypg6+u0dYOYa3uE83Qdx4X+SUUcs3glQJ9gBqqkfrvJl6PggB
         8Zo2FRgM324wxP7GJBXbhtNLxFrlp8wuw8BZ/msJBpg9SPxRDVJNJPZh+HFBjANp6eIi
         OdhulgCSwhBqHFq6wIWNTmPaUhyPDJ/73umzuh9rEPFbYnk9+9zhAm6N39UTLv2vZDWw
         IEiFJqgrWcQvjFgySSH9rlqO4ogHMaRxxWsd7A0yyBBWtBigMFQ5JODpdsSSzpkJ+flV
         7/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mSANhTB5Zz4UC3KsIc8lXyn9giGudjvJ/sHgGjqk5pM=;
        b=4H1hAoSkt1as6RBrkkNHE0isMUwSOmV7g1TeDgwSNPlb2nZSZeFz+7O5XdhlkzRSev
         G6wdB7WNBhHZpPBVyxLBpkfpJwUSGx9gKg8yKz3qsHyuKuCYubVDe+vAYUhNNSa1HVjh
         xqZLoxjfq3us9AfxJ1VxS2ciWoRPeLxsiwd9J7Iei7MN/z6pr/G7yBcO+DV5a7XC02qh
         Z04pL5Edn7fhHh/ZPAd+Ab0geMiJDw9rgUnnJteD93rrv7q5M6J68I/UyJp1hBpmhacJ
         ByAxhzc8i70K/hH3hkt/F2lTo4f2408mg9ULgO/wmj7oVuiTB5iUFxU3twBupf35VIlE
         A+xg==
X-Gm-Message-State: ACrzQf0ikFNbWK+dMWsMw/u3ZcCtxGW5IFasVftoMb1wdBDBtNFZYQT+
        iIsKCVik8monXT0A0bpjm3Cu47k4y7243Q==
X-Google-Smtp-Source: AMsMyM5Da0zut1pkh/t/C4+xqZrJPsiNmaA0XEsNhbevLOL6SdtnPO5Qb3rNEZDP2c9WfuyZMNXNkQ==
X-Received: by 2002:adf:ffc8:0:b0:231:ce45:7e02 with SMTP id x8-20020adfffc8000000b00231ce457e02mr3795030wrs.383.1665932809400;
        Sun, 16 Oct 2022 08:06:49 -0700 (PDT)
Received: from localhost.localdomain (host-95-250-231-122.retail.telecomitalia.it. [95.250.231.122])
        by smtp.gmail.com with ESMTPSA id p39-20020a05600c1da700b003c6d21a19a0sm7615465wms.29.2022.10.16.08.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 08:06:48 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [RESEND PATCH] fs/aio: Replace kmap{,_atomic}() with kmap_local_page()
Date:   Sun, 16 Oct 2022 17:06:56 +0200
Message-Id: <20221016150656.5803-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

I've tested with "./check -g aio". The tests in this group fail 3/26
times, with and without my patch. Therefore, these changes don't introduce
further errors. I'm not aware of any further tests I may run, so that
any suggestions would be precious and much appreciated :-)

I'm resending this patch because some recipients were missing in the 
previous submissions. In the meantime I'm also adding some more information 
in the commit message. There are no changes in the code.

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

