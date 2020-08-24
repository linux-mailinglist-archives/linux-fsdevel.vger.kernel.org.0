Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F7124F0EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 03:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgHXBnS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Aug 2020 21:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgHXBnR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Aug 2020 21:43:17 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAEFC061573;
        Sun, 23 Aug 2020 18:43:16 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id v1so3104227qvn.3;
        Sun, 23 Aug 2020 18:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HSviFJCpw83eFSkNKYg4Z96JUEkZ+NJpzpGZSayRsVY=;
        b=mdYKCDjSJOo0w9iUtvWFLnZo4dThfXKQOE79XjBlZGhS9Yhb59h4bgpCJKYbmb0KpC
         ZnpBv0cLQD2wnGAhAtvyQ8esk9E4XNNrNvuqANorsAUFQ5e7K269RywYqXtEccZerWBc
         5MgYCNe6ScwA7TGzCsg58X+eDnMPLDUOTIJ6SmQbt/VvwRzvLVLegbJzw4JWaAGUtg+D
         pf0LQaiG6FiVeFPbLpojQapNpkx4hTQIUi0tOtzEYYG2N3l2CbtodKeZnPXlJoKvea0k
         1ziwRt+fdfpXnAKOsFxP51ZlRCe8gKDoVlvM8+0QzuJEZDI0ooNoG+hbnRCCtJF973Zy
         4haQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HSviFJCpw83eFSkNKYg4Z96JUEkZ+NJpzpGZSayRsVY=;
        b=kpKCqTXgkpoNk4GNwY/xKOJ5lYEzOYXGk0mEF4kDPFZmeOgb5hb8Z3pcbGU/HveDwv
         Lt+gf7QyhKJ6qrn8zZeKIzaCYtChJ5JePQ+f7jGyvY+LVDPVFuxpHdOsZiTlF9B6knoX
         U5BHqz7z2fe+f8Brxln2Y1AYhFRnM/YV9JluvNgUTQZGGAGwvTY/i5gZUe7mIM/n+a4o
         3f/hERdivMHALorZBAyPYElwZ8iziMXqHeB3SOv3j1t2P9K6h9+Dnm1ZDa/Hj5f9cae5
         RzGtKJ6SRI5WNxyPL46ogOES8UG3z+4jmp5bJCzo9kK30JgqoWSUqNQFI9Oj3qRMm9l1
         s2Nw==
X-Gm-Message-State: AOAM5301M+LE6wvuDsceD7ZbDzhCfZAcy80uBs4HXbrK6n0dmthT6534
        kF0sKGu7ibNy87m0Em5unWw=
X-Google-Smtp-Source: ABdhPJylHP/+mTa0EKoUj5q0EHUCdw80GAeRz4zllvLRrzIE8MOJOYgkA8J5131Z5T09DJZlWmQ8+Q==
X-Received: by 2002:ad4:4984:: with SMTP id t4mr3030693qvx.110.1598233395243;
        Sun, 23 Aug 2020 18:43:15 -0700 (PDT)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id t8sm10205236qtc.50.2020.08.23.18.43.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Aug 2020 18:43:14 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com,
        willy@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 1/2] mm: Add become_kswapd and restore_kswapd
Date:   Mon, 24 Aug 2020 09:42:33 +0800
Message-Id: <20200824014234.7109-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20200824014234.7109-1-laoar.shao@gmail.com>
References: <20200824014234.7109-1-laoar.shao@gmail.com>
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

