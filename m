Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECB3288955
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 14:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbgJIMwD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 08:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387784AbgJIMv4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 08:51:56 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B99FC0613D2;
        Fri,  9 Oct 2020 05:51:54 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id w141so10105600oia.2;
        Fri, 09 Oct 2020 05:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IWHS/EzbCD9llYg4YvlRdsM69gVjza4DYN+VKGEIyMg=;
        b=h5vw1Q6ehhkRgK4e44tdZ+0HbAzNFI8qUb/ZJPMtabBsNhLZC9e6HKpsztK7jAt9zr
         2i5M2i1Oye0qU6ht4nMYcGYcAE0YpADJFHp5owXWgqW3dlo/rZZdsks5gs+2L236iPcN
         jjP3G3gxh+mnqrv76oor3DuZqjElcgaj0ZCnJQ6m28rRrFFpIP0GFGFifKC2y7xCWFYx
         PAw2DtxrYxJqHsoLsy2EuN36BFX6medYFN/26vXu0owsFjZk6d1QQPaJYSKGnqiytOYJ
         TotWyoiAkkcLcnpGh58jepjHzi7wotjSkrgEixplaUz9oNutWevFbhGwTtO44U89wgAq
         grDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IWHS/EzbCD9llYg4YvlRdsM69gVjza4DYN+VKGEIyMg=;
        b=S+HuG1xLBrmgpVzeXklKEnORa4t0w2qcJDqIV5OLnpndMGQHYK5uu+8jAddFB8QOIF
         5oQWjqz6X4PTwf9s5kBLi4dDo8ZtIfUmDrCTikgYXEzNGbVYlfkWMYyTMGXvdm9iDx2/
         T1MdhHqELQMFvkqBA1901xT9m6JnecjRSaLKM12aPmwOZNJfocZg/Vl4dYPlKOcG9c9I
         1q6JoDyy2WHJBpDvNz37c7pc3r6YrveT5MSmCWZ7oxQGVFMhpLDdGXwKUYiFpgDnA25h
         cCz6zLuL4Qq6xVMM++sSQMS07lOyLYz2G0TwHhpsk37Qx1hL0e9pRzi7w0tSR7pgt6Ah
         oozg==
X-Gm-Message-State: AOAM532GZ3HLW4adKmZ1iu+4VWtZ8VHh651I7Q8P6D8VBZE7+3sLHVVR
        MQQoU+QXxwoL3YxsptYGE9w=
X-Google-Smtp-Source: ABdhPJywSKrlmzTUV7BRYRzAJplTpQbx7iJIc7TG42ucjslz9rub42PFEY/nsBW/GI1ccLRmnf4a3w==
X-Received: by 2002:aca:4ad0:: with SMTP id x199mr2315208oia.113.1602247913752;
        Fri, 09 Oct 2020 05:51:53 -0700 (PDT)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id l25sm6736861otb.4.2020.10.09.05.51.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Oct 2020 05:51:52 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com,
        willy@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v8 1/2] mm: Add become_kswapd and restore_kswapd
Date:   Fri,  9 Oct 2020 20:51:26 +0800
Message-Id: <20201009125127.37435-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20201009125127.37435-1-laoar.shao@gmail.com>
References: <20201009125127.37435-1-laoar.shao@gmail.com>
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
Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 fs/xfs/libxfs/xfs_btree.c | 14 ++++++++------
 include/linux/sched/mm.h  | 23 +++++++++++++++++++++++
 mm/vmscan.c               | 16 +---------------
 3 files changed, 32 insertions(+), 21 deletions(-)

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
index f889e332912f..b38fdcb977a4 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -303,6 +303,29 @@ static inline void memalloc_nocma_restore(unsigned int flags)
 }
 #endif
 
+/*
+ * Tell the memory management code that this thread is working on behalf
+ * of background memory reclaim (like kswapd).  That means that it will
+ * get access to memory reserves should it need to allocate memory in
+ * order to make forward progress.  With this great power comes great
+ * responsibility to not exhaust those reserves.
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
index 466fc3144fff..eb6f6e8103c1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3867,19 +3867,7 @@ static int kswapd(void *p)
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
@@ -3929,8 +3917,6 @@ static int kswapd(void *p)
 			goto kswapd_try_sleep;
 	}
 
-	tsk->flags &= ~(PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD);
-
 	return 0;
 }
 
-- 
2.17.1

