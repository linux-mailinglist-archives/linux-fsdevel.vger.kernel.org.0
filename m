Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0B8673E90
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 17:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjASQVk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 11:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjASQVL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:21:11 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3BF8A0E9;
        Thu, 19 Jan 2023 08:21:01 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id j17so1990615wms.0;
        Thu, 19 Jan 2023 08:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k4NpyI3zb9wVlCKCJ/xuTMFB4MtidWKieRg7FBUYu1E=;
        b=i9i6egUnPreoSDeZhrSkJk1l31ER8it2irbo/InNoPp1A5Ad8t17LOzTXakbQzpUvh
         bjbWvJfMSPVC6qpBknfsDjgaMWe4exdOFF+L6NVl4a0v8vk14Db6zRuOor3TMXn1rhu6
         xZ1nQnEYlJYNnOfacdfe/zJWbjNGiTpvfO6eQuvaM+hbuRMvgY6B0E3ulTlmU/aslqJt
         NcabjA0Wc0ZTinwBjRD44MHXdkw4FicvWAeec0jr5VhX+blwkDfZ/oxpim+uSlDNXoZy
         oyYESXwFHhD3koN7iKErvcyB8dba9pk6B6lxg/VU1dHFf+1dQ0DwaVbsm2B5SzEM5HkS
         0x4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k4NpyI3zb9wVlCKCJ/xuTMFB4MtidWKieRg7FBUYu1E=;
        b=nL3VToIP/GPJ4GBYPLk98yd0q0qjGnOQWrjQEirtqlqeG3h9BoPcAeDQRoJEognaVf
         CGWeNp1jPy0Di6uTB31cjH4SG3bi9n0an59oyXi2SMD1reRo6ytqRPb6m/TMMNnAkTjE
         zrt8WhX1hLOCuGlkUSm864KlX4TbCLrPE297XpFYm+5w/fGq30eKpD5PceDzigzKe04w
         jSYedJtcIZGPAzpu2QGmX0KnHvNa36UWuuyxpcD3B79e6rfYwKQexEkc3Bh/cP+7JDl4
         3WokfJhBV8wyaPPSRzbCjkU6Xax0pZqsxvwVlPcLGple5bNmqN7CUoxdCxObBwVy7Cqr
         q/ag==
X-Gm-Message-State: AFqh2kqtCZKR6wO9SpSkvemgpi/ml0QJjLqOWfEALGDU/u1Jn5iA36jb
        skgqjkduOcDo+ee57vlyo/c=
X-Google-Smtp-Source: AMrXdXs0kqYJMGFRODHqs8DLy+1IZiZQPfrUfu0qa8een+OdLggHsKOiJ0qUueN87M+Hw5XjAquFrQ==
X-Received: by 2002:a7b:cbd6:0:b0:3db:622:4962 with SMTP id n22-20020a7bcbd6000000b003db06224962mr10811984wmi.21.1674145259615;
        Thu, 19 Jan 2023 08:20:59 -0800 (PST)
Received: from localhost.localdomain (host-82-55-106-56.retail.telecomitalia.it. [82.55.106.56])
        by smtp.gmail.com with ESMTPSA id ay22-20020a05600c1e1600b003dafbd859a6sm5385919wmb.43.2023.01.19.08.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 08:20:58 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH v3] fs/aio: Replace kmap{,_atomic}() with kmap_local_page()
Date:   Thu, 19 Jan 2023 17:20:55 +0100
Message-Id: <20230119162055.20944-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
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

The use of kmap_local_page() in fs/aio.c is "safe" in the sense that the
code don't hands the returned kernel virtual addresses to other threads
and there are no nestings which should be handled with the stack based
(LIFO) mappings/un-mappings order. Furthermore, the code between the old
kmap_atomic()/kunmap_atomic() did not depend on disabling page-faults
and/or preemption, so that there is no need to call pagefault_disable()
and/or preempt_disable() before the mappings.

Therefore, replace kmap() and kmap_atomic() with kmap_local_page() in
fs/aio.c.

Tested with xfstests on a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel
with HIGHMEM64GB enabled.

Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

I've tested with "./check -g aio". The tests in this group fail 3/26
times, with and without my patch. Therefore, these changes don't introduce
further errors. I'm not aware of any other tests which I may run, so that
any suggestions would be precious and much appreciated :-)

I'm resending this patch because some recipients were missing in the
previous submissions. In the meantime I'm also adding some more information
in the commit message. There are no changes in the code.

Changes from v1:
        Add further information in the commit message, and the
        "Reviewed-by" tags from Ira and Jeff (thanks!).

Changes from v2:
	Rewrite a block of code between mapping/un-mapping to improve
	readability in aio_setup_ring() and add a missing call to
	flush_dcache_page() in ioctx_add_table() (thanks to Al Viro);
	Add a "Reviewed-by" tag from Kent Overstreet (thanks).
 
 fs/aio.c | 46 +++++++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 562916d85cba..9b39063dc7ac 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -486,7 +486,6 @@ static const struct address_space_operations aio_ctx_aops = {
 
 static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 {
-	struct aio_ring *ring;
 	struct mm_struct *mm = current->mm;
 	unsigned long size, unused;
 	int nr_pages;
@@ -567,16 +566,12 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 	ctx->user_id = ctx->mmap_base;
 	ctx->nr_events = nr_events; /* trusted copy */
 
-	ring = kmap_atomic(ctx->ring_pages[0]);
-	ring->nr = nr_events;	/* user copy */
-	ring->id = ~0U;
-	ring->head = ring->tail = 0;
-	ring->magic = AIO_RING_MAGIC;
-	ring->compat_features = AIO_RING_COMPAT_FEATURES;
-	ring->incompat_features = AIO_RING_INCOMPAT_FEATURES;
-	ring->header_length = sizeof(struct aio_ring);
-	kunmap_atomic(ring);
-	flush_dcache_page(ctx->ring_pages[0]);
+	memcpy_to_page(ctx->ring_pages[0], 0, (const char *)&(struct aio_ring) {
+		       .nr = nr_events, .id = ~0U, .magic = AIO_RING_MAGIC,
+		       .compat_features = AIO_RING_COMPAT_FEATURES,
+		       .incompat_features = AIO_RING_INCOMPAT_FEATURES,
+		       .header_length = sizeof(struct aio_ring) },
+		       sizeof(struct aio_ring));
 
 	return 0;
 }
@@ -678,9 +673,10 @@ static int ioctx_add_table(struct kioctx *ctx, struct mm_struct *mm)
 					 * we are protected from page migration
 					 * changes ring_pages by ->ring_lock.
 					 */
-					ring = kmap_atomic(ctx->ring_pages[0]);
+					ring = kmap_local_page(ctx->ring_pages[0]);
 					ring->id = ctx->id;
-					kunmap_atomic(ring);
+					kunmap_local(ring);
+					flush_dcache_page(ctx->ring_pages[0]);
 					return 0;
 				}
 
@@ -1021,9 +1017,9 @@ static void user_refill_reqs_available(struct kioctx *ctx)
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
@@ -1129,12 +1125,12 @@ static void aio_complete(struct aio_kiocb *iocb)
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
@@ -1148,10 +1144,10 @@ static void aio_complete(struct aio_kiocb *iocb)
 
 	ctx->tail = tail;
 
-	ring = kmap_atomic(ctx->ring_pages[0]);
+	ring = kmap_local_page(ctx->ring_pages[0]);
 	head = ring->head;
 	ring->tail = tail;
-	kunmap_atomic(ring);
+	kunmap_local(ring);
 	flush_dcache_page(ctx->ring_pages[0]);
 
 	ctx->completed_events++;
@@ -1211,10 +1207,10 @@ static long aio_read_events_ring(struct kioctx *ctx,
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
@@ -1246,10 +1242,10 @@ static long aio_read_events_ring(struct kioctx *ctx,
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
@@ -1261,9 +1257,9 @@ static long aio_read_events_ring(struct kioctx *ctx,
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
2.39.0

