Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BBC2492DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 04:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgHSCZR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 22:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbgHSCZR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 22:25:17 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEFBC061389;
        Tue, 18 Aug 2020 19:25:16 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id t6so10626318qvw.1;
        Tue, 18 Aug 2020 19:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NRcr1uR+jWrXWzQj4QCI0O5tOCY1uyw+iu2TAziMeTw=;
        b=g6IVo8SNkSoc13ObF7oUgd3Gzgh8q53F3K8BgSOlps6OhWtNQvqUcss/Mk7DyGZfEz
         HtWw2IuxUFN0sB1Rh3IkVT28nccCyK3Kgg1tdvz39hIf6SqKI2dVu5IY2nUZFDookii7
         JfZ57jQZmunF9GVf9ezeTqLvNv8H6vxr/Z910Pidty32BYdKrhmXbxgkp1KfG+chdf/V
         0r/jLVtedaMf86ZlvC+i2W+ctu0gOyOrTo999TaPg3tUmR6P1APbTKy4Dw9blV/kRWpZ
         ZPpUH8i2JCMN/rrs1PsDi1yypkfPESV5qMhOI6tqCTOX7MmTwlFDBfjlK1nAaKK8jAKK
         T1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NRcr1uR+jWrXWzQj4QCI0O5tOCY1uyw+iu2TAziMeTw=;
        b=qQqlA1xmfvgZGYKPrX2uNVzmKQU61iZkeCgyAOnUt2Eoe5ZJVfc2JWKDWPduv9wFdZ
         nyqAdADqchO6T669yw3Z83g+GuANCZkQl8f3h2uAwJdxEwZ4EZdXY23vp470ZQibqsFt
         NqerYWG2449jBz3hdwlPTR8jBON6VKLOpSym5O+BHR8C9S3wGYw7J8lRvVkvqPGF72X+
         e8Ga5jxP1DRHcALnw2KY/FJ55YL/tPM8Zs2MuSUAusIOXTwToQVGyJziaBe1w0SDDCMC
         wl2HlMtO2aPtUDBnmVHyGuKYT3JvRZGnOxnMRUXs8utX0+hxNkgliXYHoR3GXU9QeD+w
         Dv6w==
X-Gm-Message-State: AOAM532GVO3PNWn3xcTcGETuz03jhJH5CVCTIXKezTF+wYQv5vV6JAQU
        oOx1avjoJsCcPOQhs7HjbQs=
X-Google-Smtp-Source: ABdhPJx8Kw+IH+QeI3+5U/fnvkMljo7NN7EJojoUfStufzv8ixioHaLNelz+8ih/iIifgLjuJC7kbw==
X-Received: by 2002:a0c:8b51:: with SMTP id d17mr22126354qvc.107.1597803915736;
        Tue, 18 Aug 2020 19:25:15 -0700 (PDT)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id t12sm21988275qkt.56.2020.08.18.19.25.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Aug 2020 19:25:15 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com,
        willy@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 1/2] mm: Add become_kswapd and restore_kswapd
Date:   Wed, 19 Aug 2020 10:24:24 +0800
Message-Id: <20200819022425.25188-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20200819022425.25188-1-laoar.shao@gmail.com>
References: <20200819022425.25188-1-laoar.shao@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Since XFS needs to pretend to be kswapd in some of its worker threads,
create methods to save & restore kswapd state.  Don't bother restoring
kswapd state in kswapd -- the only time we reach this code is when we're
exiting and the task_struct is about to be destroyed anyway.

Cc: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 fs/xfs/libxfs/xfs_btree.c | 14 ++++++++------
 include/linux/sched/mm.h  | 28 ++++++++++++++++++++++++++++
 mm/vmscan.c               | 16 +---------------
 3 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_btree.c b/fs/xfs/libxfs/xfs_btree.c
index 2d25bab68764..a04a44238aab 100644
--- a/fs/xfs/libxfs/xfs_btree.c
+++ b/fs/xfs/libxfs/xfs_btree.c
@@ -2813,8 +2813,9 @@ xfs_btree_split_worker(
 {
 	struct xfs_btree_split_args	*args = container_of(work,
 						struct xfs_btree_split_args, work);
+	bool			is_kswapd = args->kswapd;
 	unsigned long		pflags;
-	unsigned long		new_pflags = PF_MEMALLOC_NOFS;
+	int			memalloc_nofs;
 
 	/*
 	 * we are in a transaction context here, but may also be doing work
@@ -2822,16 +2823,17 @@ xfs_btree_split_worker(
 	 * temporarily to ensure that we don't block waiting for memory reclaim
 	 * in any way.
 	 */
-	if (args->kswapd)
-		new_pflags |= PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD;
-
-	current_set_flags_nested(&pflags, new_pflags);
+	if (is_kswapd)
+		pflags = become_kswapd();
+	memalloc_nofs = memalloc_nofs_save();
 
 	args->result = __xfs_btree_split(args->cur, args->level, args->ptrp,
 					 args->key, args->curp, args->stat);
 	complete(args->done);
 
-	current_restore_flags_nested(&pflags, new_pflags);
+	memalloc_nofs_restore(memalloc_nofs);
+	if (is_kswapd)
+		restore_kswapd(pflags);
 }
 
 /*
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index f889e332912f..80cc132f13a1 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -303,6 +303,34 @@ static inline void memalloc_nocma_restore(unsigned int flags)
 }
 #endif
 
+/*
+ * Tell the memory management that we're a "memory allocator",
+ * and that if we need more memory we should get access to it
+ * regardless (see "__alloc_pages()"). "kswapd" should
+ * never get caught in the normal page freeing logic.
+ *
+ * (Kswapd normally doesn't need memory anyway, but sometimes
+ * you need a small amount of memory in order to be able to
+ * page out something else, and this flag essentially protects
+ * us from recursively trying to free more memory as we're
+ * trying to free the first piece of memory in the first place).
+ */
+#define KSWAPD_PF_FLAGS		(PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD)
+
+static inline unsigned long become_kswapd(void)
+{
+	unsigned long flags = current->flags & KSWAPD_PF_FLAGS;
+
+	current->flags |= KSWAPD_PF_FLAGS;
+
+	return flags;
+}
+
+static inline void restore_kswapd(unsigned long flags)
+{
+	current->flags &= ~(flags ^ KSWAPD_PF_FLAGS);
+}
+
 #ifdef CONFIG_MEMCG
 /**
  * memalloc_use_memcg - Starts the remote memcg charging scope.
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 99e1796eb833..3a2615bfde35 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3859,19 +3859,7 @@ static int kswapd(void *p)
 	if (!cpumask_empty(cpumask))
 		set_cpus_allowed_ptr(tsk, cpumask);
 
-	/*
-	 * Tell the memory management that we're a "memory allocator",
-	 * and that if we need more memory we should get access to it
-	 * regardless (see "__alloc_pages()"). "kswapd" should
-	 * never get caught in the normal page freeing logic.
-	 *
-	 * (Kswapd normally doesn't need memory anyway, but sometimes
-	 * you need a small amount of memory in order to be able to
-	 * page out something else, and this flag essentially protects
-	 * us from recursively trying to free more memory as we're
-	 * trying to free the first piece of memory in the first place).
-	 */
-	tsk->flags |= PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD;
+	become_kswapd();
 	set_freezable();
 
 	WRITE_ONCE(pgdat->kswapd_order, 0);
@@ -3921,8 +3909,6 @@ static int kswapd(void *p)
 			goto kswapd_try_sleep;
 	}
 
-	tsk->flags &= ~(PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD);
-
 	return 0;
 }
 
-- 
2.18.1

