Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9A0296E55
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Oct 2020 14:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463589AbgJWMW2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Oct 2020 08:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S463586AbgJWMW2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Oct 2020 08:22:28 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF1EC0613D5
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2020 05:22:27 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id n15so1596535wrq.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2020 05:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Md4YAXpjpdGTyHyAgh2ay+AKQEd8Ro2fcgd8T+fjD4o=;
        b=GgfqsG68s8RU3qED2SP+ReACq0NGvEMRdgsY6b6ebZqvXlKJoL/Mx/M9P+m8eu/R51
         JiE6HK/crlCj0SnKoHO/QCCI3VkmWtqVIAyu4QXV/TZTZHYUHURHT9eDDCsbRIL7hGE7
         uWyhojoODyHuN4DFjcfQ46NFY2Khc8hMcQmkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Md4YAXpjpdGTyHyAgh2ay+AKQEd8Ro2fcgd8T+fjD4o=;
        b=KnRm/dWmQZe88bnm9kp4zTH3Ft0yFXKuISqagD/fErW/xfgh6C7O1e24xKSF4+taul
         FeiLxyZhjuMjAsoAsRUoVhwT5cLgIOnrMt4WITHG6aWHQ55Tzsw/ld7uDUIj8qTSKZDs
         xxrXu5Gu+tIDkR3yQRHX6fOYIFug7+D/gVOQGpjal5fGTjrOIFDStDlStALYHzmEriqQ
         I42Hke5l5Xsr55G8z7RK+FMAZQ3N2SwwB6JnnqyM4QdTdDNmOeuEMhqHThjsLQe/tsoc
         fwbU8dkDpRiqMw888dKBuVqqdt6COeg7NEu6e0k171znOzE2Z48gFz/1T99vDvKDYrzV
         MMXQ==
X-Gm-Message-State: AOAM531TEeY/tSWz2u6y8tv2h60dor0dJWKMpUoUrMbXpllVHy+/+bbu
        UXu5u4l0e/FUXVbFk3tEvFRPpQ==
X-Google-Smtp-Source: ABdhPJwY3k8N8hWJAzZAqbhvx4fpSD2M0kW3wHfJxLbpQ9x79iQZHoLA9FsW4Ur15mgIydU2Qpf3mw==
X-Received: by 2002:adf:f4ca:: with SMTP id h10mr2271950wrp.89.1603455746195;
        Fri, 23 Oct 2020 05:22:26 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id y4sm3056484wrp.74.2020.10.23.05.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 05:22:25 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michel Lespinasse <walken@google.com>,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Qian Cai <cai@lca.pw>, linux-xfs@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 04/65] mm: Extract might_alloc() debug check
Date:   Fri, 23 Oct 2020 14:21:15 +0200
Message-Id: <20201023122216.2373294-4-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023122216.2373294-1-daniel.vetter@ffwll.ch>
References: <20201021163242.1458885-1-daniel.vetter@ffwll.ch>
 <20201023122216.2373294-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Extracted from slab.h, which seems to have the most complete version
including the correct might_sleep() check. Roll it out to slob.c.

Motivated by a discussion with Paul about possibly changing call_rcu
behaviour to allocate memory, but only roughly every 500th call.

There are a lot fewer places in the kernel that care about whether
allocating memory is allowed or not (due to deadlocks with reclaim
code) than places that care whether sleeping is allowed. But debugging
these also tends to be a lot harder, so nice descriptive checks could
come in handy. I might have some use eventually for annotations in
drivers/gpu.

Note that unlike fs_reclaim_acquire/release gfpflags_allow_blocking
does not consult the PF_MEMALLOC flags. But there is no flag
equivalent for GFP_NOWAIT, hence this check can't go wrong due to
memalloc_no*_save/restore contexts.

Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Michel Lespinasse <walken@google.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Waiman Long <longman@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
Cc: Dave Chinner <david@fromorbit.com>
Cc: Qian Cai <cai@lca.pw>
Cc: linux-xfs@vger.kernel.org
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 include/linux/sched/mm.h | 16 ++++++++++++++++
 mm/slab.h                |  5 +----
 mm/slob.c                |  6 ++----
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index f889e332912f..2b0037abac0b 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -205,6 +205,22 @@ static inline void fs_reclaim_acquire(gfp_t gfp_mask) { }
 static inline void fs_reclaim_release(gfp_t gfp_mask) { }
 #endif
 
+/**
+ * might_alloc - Marks possible allocation sites
+ * @gfp_mask: gfp_t flags that would be use to allocate
+ *
+ * Similar to might_sleep() and other annotations this can be used in functions
+ * that might allocate, but often dont. Compiles to nothing without
+ * CONFIG_LOCKDEP. Includes a conditional might_sleep() if @gfp allows blocking.
+ */
+static inline void might_alloc(gfp_t gfp_mask)
+{
+	fs_reclaim_acquire(gfp_mask);
+	fs_reclaim_release(gfp_mask);
+
+	might_sleep_if(gfpflags_allow_blocking(gfp_mask));
+}
+
 /**
  * memalloc_noio_save - Marks implicit GFP_NOIO allocation scope.
  *
diff --git a/mm/slab.h b/mm/slab.h
index 6cc323f1313a..fedd789b2270 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -492,10 +492,7 @@ static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
 {
 	flags &= gfp_allowed_mask;
 
-	fs_reclaim_acquire(flags);
-	fs_reclaim_release(flags);
-
-	might_sleep_if(gfpflags_allow_blocking(flags));
+	might_alloc(flags);
 
 	if (should_failslab(s, flags))
 		return NULL;
diff --git a/mm/slob.c b/mm/slob.c
index 7cc9805c8091..8d4bfa46247f 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -474,8 +474,7 @@ __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
 
 	gfp &= gfp_allowed_mask;
 
-	fs_reclaim_acquire(gfp);
-	fs_reclaim_release(gfp);
+	might_alloc(gfp);
 
 	if (size < PAGE_SIZE - minalign) {
 		int align = minalign;
@@ -597,8 +596,7 @@ static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags, int node)
 
 	flags &= gfp_allowed_mask;
 
-	fs_reclaim_acquire(flags);
-	fs_reclaim_release(flags);
+	might_alloc(flags);
 
 	if (c->size < PAGE_SIZE) {
 		b = slob_alloc(c->size, flags, c->align, node, 0);
-- 
2.28.0

