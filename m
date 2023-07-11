Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973B474F8F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 22:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjGKUVX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 16:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjGKUVW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:21:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D85C10DF
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jul 2023 13:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/8ipsblXmqhBdjmpy7pSUutiQ9uV/NjS0hvvOESjZ3g=; b=oRIKjCgdAvLsraMKft9V0w2oKZ
        gA8+g5HvWxvz4J9SdjP/9qtxqWDS4jIJdweAuxxJ07yxaaSCu0MhExZ19AW2OuvPf+CA6aC+NYOqT
        QsgdUoumFuLkq5/WvVKVt/mYvxzsa7oZ1+my3VBjHQ7LrQYRRkh7iEd+/l6iwx5E4Lo3bhWFbXcen
        HXyLgW8Wd4jARBTL4Z6MZxVI6s9jQrSqITbeKUWsnlYMYZms9rU81kzYHlX62UPOop87gF1igohrk
        6TJx6U6NbyQJBf3mNlRd3N7lTbJ8mI8y5XtZtR6ZhMIGyIzri2Zmj1h68QaAbAoenY2dJY9625Dzi
        2yTOA1Xg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJJqs-00G1QN-D5; Tue, 11 Jul 2023 20:20:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     Arjun Roy <arjunroy@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>,
        "David S . Miller" <davem@davemloft.net>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 9/9] tcp: Use per-vma locking for receive zerocopy
Date:   Tue, 11 Jul 2023 21:20:47 +0100
Message-Id: <20230711202047.3818697-10-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230711202047.3818697-1-willy@infradead.org>
References: <20230711202047.3818697-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Arjun Roy <arjunroy@google.com>

Per-VMA locking allows us to lock a struct vm_area_struct without
taking the process-wide mmap lock in read mode.

Consider a process workload where the mmap lock is taken constantly in
write mode. In this scenario, all zerocopy receives are periodically
blocked during that period of time - though in principle, the memory
ranges being used by TCP are not touched by the operations that need
the mmap write lock. This results in performance degradation.

Now consider another workload where the mmap lock is never taken in
write mode, but there are many TCP connections using receive zerocopy
that are concurrently receiving. These connections all take the mmap
lock in read mode, but this does induce a lot of contention and atomic
ops for this process-wide lock. This results in additional CPU
overhead caused by contending on the cache line for this lock.

However, with per-vma locking, both of these problems can be avoided.

As a test, I ran an RPC-style request/response workload with 4KB
payloads and receive zerocopy enabled, with 100 simultaneous TCP
connections. I measured perf cycles within the
find_tcp_vma/mmap_read_lock/mmap_read_unlock codepath, with and
without per-vma locking enabled.

When using process-wide mmap semaphore read locking, about 1% of
measured perf cycles were within this path. With per-VMA locking, this
value dropped to about 0.45%.

Signed-off-by: Arjun Roy <arjunroy@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 net/ipv4/tcp.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 1542de3f66f7..7118ec6cf886 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2038,6 +2038,30 @@ static void tcp_zc_finalize_rx_tstamp(struct sock *sk,
 	}
 }
 
+static struct vm_area_struct *find_tcp_vma(struct mm_struct *mm,
+		unsigned long address, bool *mmap_locked)
+{
+	struct vm_area_struct *vma = lock_vma_under_rcu(mm, address);
+
+	if (vma) {
+		if (vma->vm_ops != &tcp_vm_ops) {
+			vma_end_read(vma);
+			return NULL;
+		}
+		*mmap_locked = false;
+		return vma;
+	}
+
+	mmap_read_lock(mm);
+	vma = vma_lookup(mm, address);
+	if (!vma || vma->vm_ops != &tcp_vm_ops) {
+		mmap_read_unlock(mm);
+		return NULL;
+	}
+	*mmap_locked = true;
+	return vma;
+}
+
 #define TCP_ZEROCOPY_PAGE_BATCH_SIZE 32
 static int tcp_zerocopy_receive(struct sock *sk,
 				struct tcp_zerocopy_receive *zc,
@@ -2055,6 +2079,7 @@ static int tcp_zerocopy_receive(struct sock *sk,
 	u32 seq = tp->copied_seq;
 	u32 total_bytes_to_map;
 	int inq = tcp_inq(sk);
+	bool mmap_locked;
 	int ret;
 
 	zc->copybuf_len = 0;
@@ -2079,13 +2104,10 @@ static int tcp_zerocopy_receive(struct sock *sk,
 		return 0;
 	}
 
-	mmap_read_lock(current->mm);
-
-	vma = vma_lookup(current->mm, address);
-	if (!vma || vma->vm_ops != &tcp_vm_ops) {
-		mmap_read_unlock(current->mm);
+	vma = find_tcp_vma(current->mm, address, &mmap_locked);
+	if (!vma)
 		return -EINVAL;
-	}
+
 	vma_len = min_t(unsigned long, zc->length, vma->vm_end - address);
 	avail_len = min_t(u32, vma_len, inq);
 	total_bytes_to_map = avail_len & ~(PAGE_SIZE - 1);
@@ -2159,7 +2181,10 @@ static int tcp_zerocopy_receive(struct sock *sk,
 						   zc, total_bytes_to_map);
 	}
 out:
-	mmap_read_unlock(current->mm);
+	if (mmap_locked)
+		mmap_read_unlock(current->mm);
+	else
+		vma_end_read(vma);
 	/* Try to copy straggler data. */
 	if (!ret)
 		copylen = tcp_zc_handle_leftover(zc, sk, skb, &seq, copybuf_len, tss);
-- 
2.39.2

