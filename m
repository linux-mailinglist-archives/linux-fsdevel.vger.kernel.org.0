Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC67B75FF68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 20:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjGXSyj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 14:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjGXSyi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:54:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139AAE55
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 11:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3AerkyW6jQd6y4z+nJVqv9X/P9KyvfBPmyU8zyX0gIY=; b=T5WZLqosM499I02fiX0L+Oh2WN
        UVgaWQNODE3toYL7Hkf9TqP02b83nLnWZK0d16D8E2EBKem+n5svfi/BWGCMHr9+JqGgq9wSB2cUZ
        Ul2RAEhjDKUkApuBDNwSO4vEr1GQ0rCAqJg/tEc/UP5d6/RpdIbRYVXtlvVBCJdZzViD0p6t3MFTR
        W2zX2H9kNr37fSa1DoYb3/SnNFsASa0KmyalF7lugxtR93Ykk3scERqFti65kmwu26eMSGo7evEHg
        ES2YTHDMR7hSv6+QZd3gF6jnzLamcbnFtqXQuCMCsUrYKjAotodfYGgMlts3LXVKYhDeRDybzsjUI
        9t1fww6Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qO0hA-004iR3-4n; Mon, 24 Jul 2023 18:54:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Arjun Roy <arjunroy@google.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v3 02/10] mm: Allow per-VMA locks on file-backed VMAs
Date:   Mon, 24 Jul 2023 19:54:02 +0100
Message-Id: <20230724185410.1124082-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230724185410.1124082-1-willy@infradead.org>
References: <20230724185410.1124082-1-willy@infradead.org>
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

Remove the TCP layering violation by allowing per-VMA locks on all VMAs.
The fault path will immediately fail in handle_mm_fault().  There may be
a small performance reduction from this patch as a little unnecessary work
will be done on each page fault.  See later patches for the improvement.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Cc: Arjun Roy <arjunroy@google.com>
Cc: Eric Dumazet <edumazet@google.com>
---
 MAINTAINERS            |  1 -
 include/linux/net_mm.h | 17 -----------------
 include/net/tcp.h      |  1 -
 mm/memory.c            | 12 ++++++------
 net/ipv4/tcp.c         | 11 ++++-------
 5 files changed, 10 insertions(+), 32 deletions(-)
 delete mode 100644 include/linux/net_mm.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 220566cd8da8..f5f5134219b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14874,7 +14874,6 @@ NETWORKING [TCP]
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
index d17cb8ab4c48..9d1d312c90c2 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -45,7 +45,6 @@
 #include <linux/memcontrol.h>
 #include <linux/bpf-cgroup.h>
 #include <linux/siphash.h>
-#include <linux/net_mm.h>
 
 extern struct inet_hashinfo tcp_hashinfo;
 
diff --git a/mm/memory.c b/mm/memory.c
index 7ff73a197cce..c7ad754dd8ed 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -77,7 +77,6 @@
 #include <linux/ptrace.h>
 #include <linux/vmalloc.h>
 #include <linux/sched/sysctl.h>
-#include <linux/net_mm.h>
 
 #include <trace/events/kmem.h>
 
@@ -5362,6 +5361,11 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 		goto out;
 	}
 
+	if ((flags & FAULT_FLAG_VMA_LOCK) && !vma_is_anonymous(vma)) {
+		vma_end_read(vma);
+		return VM_FAULT_RETRY;
+	}
+
 	/*
 	 * Enable the memcg OOM handling for faults triggered in user
 	 * space.  Kernel faults are handled more gracefully.
@@ -5533,12 +5537,8 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	if (!vma)
 		goto inval;
 
-	/* Only anonymous and tcp vmas are supported for now */
-	if (!vma_is_anonymous(vma) && !vma_is_tcp(vma))
-		goto inval;
-
 	/* find_mergeable_anon_vma uses adjacent vmas which are not locked */
-	if (!vma->anon_vma && !vma_is_tcp(vma))
+	if (vma_is_anonymous(vma) && !vma->anon_vma)
 		goto inval;
 
 	if (!vma_start_read(vma))
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index aca5620cf3ba..f7391d017c4c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1740,7 +1740,7 @@ void tcp_update_recv_tstamps(struct sk_buff *skb,
 }
 
 #ifdef CONFIG_MMU
-const struct vm_operations_struct tcp_vm_ops = {
+static const struct vm_operations_struct tcp_vm_ops = {
 };
 
 int tcp_mmap(struct file *file, struct socket *sock,
@@ -2043,13 +2043,10 @@ static struct vm_area_struct *find_tcp_vma(struct mm_struct *mm,
 					   unsigned long address,
 					   bool *mmap_locked)
 {
-	struct vm_area_struct *vma = NULL;
+	struct vm_area_struct *vma = lock_vma_under_rcu(mm, address);
 
-#ifdef CONFIG_PER_VMA_LOCK
-	vma = lock_vma_under_rcu(mm, address);
-#endif
 	if (vma) {
-		if (!vma_is_tcp(vma)) {
+		if (vma->vm_ops != &tcp_vm_ops) {
 			vma_end_read(vma);
 			return NULL;
 		}
@@ -2059,7 +2056,7 @@ static struct vm_area_struct *find_tcp_vma(struct mm_struct *mm,
 
 	mmap_read_lock(mm);
 	vma = vma_lookup(mm, address);
-	if (!vma || !vma_is_tcp(vma)) {
+	if (!vma || vma->vm_ops != &tcp_vm_ops) {
 		mmap_read_unlock(mm);
 		return NULL;
 	}
-- 
2.39.2

