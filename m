Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4304A662E1E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 19:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbjAISGd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 13:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237597AbjAIR6y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:58:54 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B6843E67;
        Mon,  9 Jan 2023 09:56:38 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id z8-20020a05600c220800b003d33b0bda11so7496139wml.0;
        Mon, 09 Jan 2023 09:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TU2G27z+BQ74J7jo/jGtpLowvGp8Cox//+E6uOZZ0EY=;
        b=MEFJ2tZhFVApgTycUf1TdZq/FUE8s54WZTZDHC/R6DyGowWBcpBS8Mso8+OknnNBMh
         K+bLS/wUkGgdw7UNrvnYuGCgHJH5PJ0tozRpgj0jz70t6EYT4JW8aVpOHOeodF3ojQkl
         4Uggix2jRfAP74yOqcXRv/GlV1Q84sRASvwr0+DSvv/cUrMCLDmCR0tzt0e9pr5lKz9z
         xUE23RmQq3lpfcD4RgFZ0r4JZKrIQ37oQYSHgdzXrdTStZ2q8fen4U4AeWtmTF1HijiS
         7ruTSMUwWXQ9S1g2c20JxkxHrdHnmJYEk00gf9jnTwfyIuxPn+qysWvfgnILfBOqZtAn
         alpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TU2G27z+BQ74J7jo/jGtpLowvGp8Cox//+E6uOZZ0EY=;
        b=MqUecnSPs+zNBxoTymBc/wBCROdvmu6cTttJ44S+mHWJkImou6nwYPg0dEMQRgq+s/
         eckk7MktFxP2PI5RjUc0X73a5Nn2PeH3jA0BKQ4cMqPnYzNNiC7KEYMU5EpUt30idfC8
         eUgeq57VSY22f+NAmxsT5SCrh1xsP9BWzb4GfXyO+suTtc+dYCAnhwkXr/uuQlEqsVzE
         ffkw/9tnPZ6QL79ykDYnhW4CrbRyOSty/Pn2Jg/UplCejJ1SdqTQ7viiXqaZIv3CoVGw
         6egT5ZO8EyxWEbGYAgKESWBXeRrH9eLvhz6a0JOAi9rTEIZxumy7VGuExXFMo73wP22H
         MIww==
X-Gm-Message-State: AFqh2koNsfs/4jw3i9NNUoEP25fJ4Y8b53l7QPnrLWsHm/77rAOrCxS0
        e2omJlnYZvW3LrBOqbbaYoY=
X-Google-Smtp-Source: AMrXdXs1cvhrRzSPN4WYXaVOjz3whuAZD18PrYPmAD5wCunM1gd9Qs6Mgq5RkpQbTXZ1fF4h6HK7nA==
X-Received: by 2002:a05:600c:34cd:b0:3d5:1175:92c3 with SMTP id d13-20020a05600c34cd00b003d5117592c3mr46480039wmq.23.1673286997283;
        Mon, 09 Jan 2023 09:56:37 -0800 (PST)
Received: from localhost.localdomain (host-79-13-98-249.retail.telecomitalia.it. [79.13.98.249])
        by smtp.gmail.com with ESMTPSA id ay13-20020a05600c1e0d00b003d34faca949sm12331161wmb.39.2023.01.09.09.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 09:56:36 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Benjamin LaHaise <bcrl@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Jeff Moyer <jmoyer@redhat.com>
Subject: [PATCH v2] fs/aio: Replace kmap{,_atomic}() with kmap_local_page()
Date:   Mon,  9 Jan 2023 18:56:29 +0100
Message-Id: <20230109175629.9482-1-fmdefrancesco@gmail.com>
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

