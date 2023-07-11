Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B059D74F8F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 22:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjGKUV2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 16:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjGKUVZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:21:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BC210D4
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jul 2023 13:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5FN0HiT2a6i6oQBEDqgGmkCDTbMkD96qK8TmIcdDOvU=; b=BzG7fNesDSv9f5c/jHckIpGYxr
        1AjjHU4Ah6jva8EK1Xcg1/biocRXvpql2nETap2r1zt63XApMDK8MNuoMrkEge7p433afITqveoC3
        Lh9PyA4r1OYCcI8kixo3vPG870zrKJVBOEc45zm+IEQoWThCsGK0JCfwO5zglXVRuurCxIV49tMb6
        tlkYbLY36M0L1CpBIWxZD89hARza9OQ7yNWvq3+9zcyasAmecs0SbqtEGsAY8bVkyE7Y/8n3U9YG8
        hOj3abiKh2aB7siI996/oscxpg5i29HTOtetWXWuMHJK8XmiAJaslK8w9KiTK8fuihRlHUcdFaRBh
        GJRAiejQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJJqr-00G1Q6-EC; Tue, 11 Jul 2023 20:20:49 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Arjun Roy <arjunroy@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Subject: [PATCH v2 1/9] Revert "tcp: Use per-vma locking for receive zerocopy"
Date:   Tue, 11 Jul 2023 21:20:39 +0100
Message-Id: <20230711202047.3818697-2-willy@infradead.org>
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

This reverts commit 7a7f094635349a7d0314364ad50bdeb770b6df4f.
---
 MAINTAINERS            |  1 -
 include/linux/net_mm.h | 17 ----------------
 include/net/tcp.h      |  1 -
 mm/memory.c            |  7 +++----
 net/ipv4/tcp.c         | 45 ++++++++----------------------------------
 5 files changed, 11 insertions(+), 60 deletions(-)
 delete mode 100644 include/linux/net_mm.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 18cd0ce2c7d2..00047800cff1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14816,7 +14816,6 @@ NETWORKING [TCP]
 M:	Eric Dumazet <edumazet@google.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
-F:	include/linux/net_mm.h
 F:	include/linux/tcp.h
 F:	include/net/tcp.h
 F:	include/trace/events/tcp.h
diff --git a/include/linux/net_mm.h b/include/linux/net_mm.h
deleted file mode 100644
index b298998bd5a0..000000000000
--- a/include/linux/net_mm.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-#ifdef CONFIG_MMU
-
-#ifdef CONFIG_INET
-extern const struct vm_operations_struct tcp_vm_ops;
-static inline bool vma_is_tcp(const struct vm_area_struct *vma)
-{
-	return vma->vm_ops == &tcp_vm_ops;
-}
-#else
-static inline bool vma_is_tcp(const struct vm_area_struct *vma)
-{
-	return false;
-}
-#endif /* CONFIG_INET*/
-
-#endif /* CONFIG_MMU */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 226bce6d1e8c..95e4507febed 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -45,7 +45,6 @@
 #include <linux/memcontrol.h>
 #include <linux/bpf-cgroup.h>
 #include <linux/siphash.h>
-#include <linux/net_mm.h>
 
 extern struct inet_hashinfo tcp_hashinfo;
 
diff --git a/mm/memory.c b/mm/memory.c
index 0a265ac6246e..2c7967632866 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -77,7 +77,6 @@
 #include <linux/ptrace.h>
 #include <linux/vmalloc.h>
 #include <linux/sched/sysctl.h>
-#include <linux/net_mm.h>
 
 #include <trace/events/kmem.h>
 
@@ -5419,12 +5418,12 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	if (!vma)
 		goto inval;
 
-	/* Only anonymous and tcp vmas are supported for now */
-	if (!vma_is_anonymous(vma) && !vma_is_tcp(vma))
+	/* Only anonymous vmas are supported for now */
+	if (!vma_is_anonymous(vma))
 		goto inval;
 
 	/* find_mergeable_anon_vma uses adjacent vmas which are not locked */
-	if (!vma->anon_vma && !vma_is_tcp(vma))
+	if (!vma->anon_vma)
 		goto inval;
 
 	if (!vma_start_read(vma))
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e03e08745308..1542de3f66f7 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1739,7 +1739,7 @@ void tcp_update_recv_tstamps(struct sk_buff *skb,
 }
 
 #ifdef CONFIG_MMU
-const struct vm_operations_struct tcp_vm_ops = {
+static const struct vm_operations_struct tcp_vm_ops = {
 };
 
 int tcp_mmap(struct file *file, struct socket *sock,
@@ -2038,34 +2038,6 @@ static void tcp_zc_finalize_rx_tstamp(struct sock *sk,
 	}
 }
 
-static struct vm_area_struct *find_tcp_vma(struct mm_struct *mm,
-					   unsigned long address,
-					   bool *mmap_locked)
-{
-	struct vm_area_struct *vma = NULL;
-
-#ifdef CONFIG_PER_VMA_LOCK
-	vma = lock_vma_under_rcu(mm, address);
-#endif
-	if (vma) {
-		if (!vma_is_tcp(vma)) {
-			vma_end_read(vma);
-			return NULL;
-		}
-		*mmap_locked = false;
-		return vma;
-	}
-
-	mmap_read_lock(mm);
-	vma = vma_lookup(mm, address);
-	if (!vma || !vma_is_tcp(vma)) {
-		mmap_read_unlock(mm);
-		return NULL;
-	}
-	*mmap_locked = true;
-	return vma;
-}
-
 #define TCP_ZEROCOPY_PAGE_BATCH_SIZE 32
 static int tcp_zerocopy_receive(struct sock *sk,
 				struct tcp_zerocopy_receive *zc,
@@ -2083,7 +2055,6 @@ static int tcp_zerocopy_receive(struct sock *sk,
 	u32 seq = tp->copied_seq;
 	u32 total_bytes_to_map;
 	int inq = tcp_inq(sk);
-	bool mmap_locked;
 	int ret;
 
 	zc->copybuf_len = 0;
@@ -2108,10 +2079,13 @@ static int tcp_zerocopy_receive(struct sock *sk,
 		return 0;
 	}
 
-	vma = find_tcp_vma(current->mm, address, &mmap_locked);
-	if (!vma)
-		return -EINVAL;
+	mmap_read_lock(current->mm);
 
+	vma = vma_lookup(current->mm, address);
+	if (!vma || vma->vm_ops != &tcp_vm_ops) {
+		mmap_read_unlock(current->mm);
+		return -EINVAL;
+	}
 	vma_len = min_t(unsigned long, zc->length, vma->vm_end - address);
 	avail_len = min_t(u32, vma_len, inq);
 	total_bytes_to_map = avail_len & ~(PAGE_SIZE - 1);
@@ -2185,10 +2159,7 @@ static int tcp_zerocopy_receive(struct sock *sk,
 						   zc, total_bytes_to_map);
 	}
 out:
-	if (mmap_locked)
-		mmap_read_unlock(current->mm);
-	else
-		vma_end_read(vma);
+	mmap_read_unlock(current->mm);
 	/* Try to copy straggler data. */
 	if (!ret)
 		copylen = tcp_zc_handle_leftover(zc, sk, skb, &seq, copybuf_len, tss);
-- 
2.39.2

