Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6A1296E52
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Oct 2020 14:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463583AbgJWMW0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Oct 2020 08:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S369869AbgJWMW0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Oct 2020 08:22:26 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCEEC0613CE
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2020 05:22:25 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h5so1572936wrv.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2020 05:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IgQVmlN66kTzdCBU8ZoKnJMQUq1PyY1GSJDM/XX0ojY=;
        b=SBvkme8oy7kGO+RfY6ceOp15GpaJIvk6RoLhvV/WueIm6Pg+oG/7v+xKkGaetsoFKT
         4Jrw4O5tvC4Old6EBSgoM8lbYnG5Co58mGGq/XlAbL+NJ+J1nzTnHFdqYbcE/fjum1hb
         sSY+nGawYtOErvna7ZMT/xH6GPplKKq36FBvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IgQVmlN66kTzdCBU8ZoKnJMQUq1PyY1GSJDM/XX0ojY=;
        b=Z/GKnFsoe3XeNgK2dJKCjI87XqGbouResjz3t01p2BgyGdHLcaKq2/A5PKqXRXRP0I
         cm3UHtjrg4+3MHZ4Pfj13wCpeHp/Ys7UCvFep03imRmZY58XKIUy7iqc4Vg6qM3zNfhh
         TVzEONgKNdb1LYF7B3/pFc/wpKlcodYiWEnMTwfWxQPhOjDzglUsj54nyw3jyUeyfgEA
         /KW95YTiUBT26Tqt0Bn7+Sxj6Ru04VqgI9JW+QutE5cMXIrevNjPXhnK/bpu3UKTwW6+
         CQICPe9mJvcecfb3hIoojMiwGXGaX4GJvib0kEh8jz/4p8py9j/kaYkzc6zt0WaCyg//
         laPQ==
X-Gm-Message-State: AOAM531xPxdxOifLgCYezad6LvRx99+raAZSalQz0mQ0IZMzvBYC/3O+
        jcxcE3Bh6SRkldrZwoh8tDmwKQ==
X-Google-Smtp-Source: ABdhPJznoMnt3wkQ258dPqEZNcn4LIp7cxpxLk7m7dixQUbSTt/QJMXc3d+QHpQiaKAR3urrcsOBqA==
X-Received: by 2002:adf:e8c7:: with SMTP id k7mr2365623wrn.102.1603455744516;
        Fri, 23 Oct 2020 05:22:24 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id y4sm3056484wrp.74.2020.10.23.05.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 05:22:23 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Qian Cai <cai@lca.pw>, linux-xfs@vger.kernel.org,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-mm@kvack.org,
        linux-rdma@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 03/65] mm: Track mmu notifiers in fs_reclaim_acquire/release
Date:   Fri, 23 Oct 2020 14:21:14 +0200
Message-Id: <20201023122216.2373294-3-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023122216.2373294-1-daniel.vetter@ffwll.ch>
References: <20201021163242.1458885-1-daniel.vetter@ffwll.ch>
 <20201023122216.2373294-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fs_reclaim_acquire/release nicely catch recursion issues when
allocating GFP_KERNEL memory against shrinkers (which gpu drivers tend
to use to keep the excessive caches in check). For mmu notifier
recursions we do have lockdep annotations since 23b68395c7c7
("mm/mmu_notifiers: add a lockdep map for invalidate_range_start/end").

But these only fire if a path actually results in some pte
invalidation - for most small allocations that's very rarely the case.
The other trouble is that pte invalidation can happen any time when
__GFP_RECLAIM is set. Which means only really GFP_ATOMIC is a safe
choice, GFP_NOIO isn't good enough to avoid potential mmu notifier
recursion.

I was pondering whether we should just do the general annotation, but
there's always the risk for false positives. Plus I'm assuming that
the core fs and io code is a lot better reviewed and tested than
random mmu notifier code in drivers. Hence why I decide to only
annotate for that specific case.

Furthermore even if we'd create a lockdep map for direct reclaim, we'd
still need to explicit pull in the mmu notifier map - there's a lot
more places that do pte invalidation than just direct reclaim, these
two contexts arent the same.

Note that the mmu notifiers needing their own independent lockdep map
is also the reason we can't hold them from fs_reclaim_acquire to
fs_reclaim_release - it would nest with the acquistion in the pte
invalidation code, causing a lockdep splat. And we can't remove the
annotations from pte invalidation and all the other places since
they're called from many other places than page reclaim. Hence we can
only do the equivalent of might_lock, but on the raw lockdep map.

With this we can also remove the lockdep priming added in 66204f1d2d1b
("mm/mmu_notifiers: prime lockdep") since the new annotations are
strictly more powerful.

v2: Review from Thomas Hellstrom:
- unbotch the fs_reclaim context check, I accidentally inverted it,
  but it didn't blow up because I inverted it immediately
- fix compiling for !CONFIG_MMU_NOTIFIER

v3: Unbreak the PF_MEMALLOC_ context flags. Thanks to Qian for the
report and Dave for explaining what I failed to see.

Cc: linux-fsdevel@vger.kernel.org
Cc: Dave Chinner <david@fromorbit.com>
Cc: Qian Cai <cai@lca.pw>
Cc: linux-xfs@vger.kernel.org
Cc: Thomas Hellström (Intel) <thomas_os@shipmail.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: linux-mm@kvack.org
Cc: linux-rdma@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 mm/mmu_notifier.c |  7 -------
 mm/page_alloc.c   | 31 ++++++++++++++++++++-----------
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 4fc918163dd3..6bf798373eb0 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -612,13 +612,6 @@ int __mmu_notifier_register(struct mmu_notifier *subscription,
 	mmap_assert_write_locked(mm);
 	BUG_ON(atomic_read(&mm->mm_users) <= 0);
 
-	if (IS_ENABLED(CONFIG_LOCKDEP)) {
-		fs_reclaim_acquire(GFP_KERNEL);
-		lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
-		lock_map_release(&__mmu_notifier_invalidate_range_start_map);
-		fs_reclaim_release(GFP_KERNEL);
-	}
-
 	if (!mm->notifier_subscriptions) {
 		/*
 		 * kmalloc cannot be called under mm_take_all_locks(), but we
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 780c8f023b28..2edd3fd447fa 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -57,6 +57,7 @@
 #include <trace/events/oom.h>
 #include <linux/prefetch.h>
 #include <linux/mm_inline.h>
+#include <linux/mmu_notifier.h>
 #include <linux/migrate.h>
 #include <linux/hugetlb.h>
 #include <linux/sched/rt.h>
@@ -4207,10 +4208,8 @@ should_compact_retry(struct alloc_context *ac, unsigned int order, int alloc_fla
 static struct lockdep_map __fs_reclaim_map =
 	STATIC_LOCKDEP_MAP_INIT("fs_reclaim", &__fs_reclaim_map);
 
-static bool __need_fs_reclaim(gfp_t gfp_mask)
+static bool __need_reclaim(gfp_t gfp_mask)
 {
-	gfp_mask = current_gfp_context(gfp_mask);
-
 	/* no reclaim without waiting on it */
 	if (!(gfp_mask & __GFP_DIRECT_RECLAIM))
 		return false;
@@ -4219,10 +4218,6 @@ static bool __need_fs_reclaim(gfp_t gfp_mask)
 	if (current->flags & PF_MEMALLOC)
 		return false;
 
-	/* We're only interested __GFP_FS allocations for now */
-	if (!(gfp_mask & __GFP_FS))
-		return false;
-
 	if (gfp_mask & __GFP_NOLOCKDEP)
 		return false;
 
@@ -4241,15 +4236,29 @@ void __fs_reclaim_release(void)
 
 void fs_reclaim_acquire(gfp_t gfp_mask)
 {
-	if (__need_fs_reclaim(gfp_mask))
-		__fs_reclaim_acquire();
+	gfp_mask = current_gfp_context(gfp_mask);
+
+	if (__need_reclaim(gfp_mask)) {
+		if (gfp_mask & __GFP_FS)
+			__fs_reclaim_acquire();
+
+#ifdef CONFIG_MMU_NOTIFIER
+		lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
+		lock_map_release(&__mmu_notifier_invalidate_range_start_map);
+#endif
+
+	}
 }
 EXPORT_SYMBOL_GPL(fs_reclaim_acquire);
 
 void fs_reclaim_release(gfp_t gfp_mask)
 {
-	if (__need_fs_reclaim(gfp_mask))
-		__fs_reclaim_release();
+	gfp_mask = current_gfp_context(gfp_mask);
+
+	if (__need_reclaim(gfp_mask)) {
+		if (gfp_mask & __GFP_FS)
+			__fs_reclaim_release();
+	}
 }
 EXPORT_SYMBOL_GPL(fs_reclaim_release);
 #endif
-- 
2.28.0

