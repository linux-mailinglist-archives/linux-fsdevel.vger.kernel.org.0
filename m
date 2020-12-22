Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5378B2E03CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 02:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgLVBWr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 20:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgLVBWr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 20:22:47 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC535C0613D6;
        Mon, 21 Dec 2020 17:22:06 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id d20so10595020otl.3;
        Mon, 21 Dec 2020 17:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3L0osnWCCNspwjgiTnY7o7GFkOk19djKZdTx6lTRDIw=;
        b=RpXqOfbhkd/My709dzANuCJbRKRpph1ReJtl6s+An19SstIDuDTzZK4UxV8ZweKYpA
         IvdHHFSI6fXKHC7RTTIh9lVh95Jq8DGIG3pATl5fEGEthjnFnjLxNAW72xDZ/oFY8uly
         LFFyPUQKRL0sLD0lxj8kbASoo2EZQBO8kxLer81YaYE3x8Ho7zu4kajBguPx9CskxQoW
         AP8bJhJRtdC4hrE+jLlamW23Nr35Mib2QujZDBp1jFOZD7JsFQp6964yFMFMPacsFgo8
         KUZuwN2hyTQPZrnOHiWDHmJE2oFnadwWbCe9pmA5nLqPQ+pBxCGOylEQ1yqNZ+rrERpT
         LDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3L0osnWCCNspwjgiTnY7o7GFkOk19djKZdTx6lTRDIw=;
        b=JZuJA1Bz4S6CtJojT2aWo18y/wuq2shzk5w6f6aw41z5BeLfgolKGSF4JynqXInO6e
         B+iU81s0QjGL6P02u/D6I6lwhkXqdjYn9V7D2Z9PDnETgWMdbSN4wY9NJLE5ywS3cca/
         fS33pcEX9FdZDEbL/phKJVS0CMl/k2A2E9P3YC+TIpaj3oOAk45A3ae2xbIgtruNC6lj
         aCJVAqg1DfPV90EflcwP9UB53tWWLujUGYDuI8uV7QfaDwkeK8woBCJAhptHkSzGbr9G
         31XcRmIPx1xaa3RR5uY1uenFO2tDTpU9zS0fGRzvdku77GQqcsizxEd2ZBTe5VPrVrrw
         Ra0w==
X-Gm-Message-State: AOAM530vKQtIIUFZX8JkiPZwsU+NosoWxFLZO7IDX77Pa0gdSI4bD86N
        SnI+Z+yixQ+nY6qpXe1xvX0=
X-Google-Smtp-Source: ABdhPJzglWOOK9n3ZJvS4V6/3DnmRgOgzj2uqLh7pwvVBmxgOfW/XIq2c+hoiTEijTKX5aAZdnDW+g==
X-Received: by 2002:a05:6830:16d9:: with SMTP id l25mr14305025otr.314.1608600126310;
        Mon, 21 Dec 2020 17:22:06 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id x20sm4070098oov.33.2020.12.21.17.22.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Dec 2020 17:22:05 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     darrick.wong@oracle.com, willy@infradead.org, david@fromorbit.com,
        hch@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org,
        dhowells@redhat.com, jlayton@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>, Christoph Hellwig <hch@lst.de>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v14 1/4] mm: Add become_kswapd and restore_kswapd
Date:   Tue, 22 Dec 2020 09:21:28 +0800
Message-Id: <20201222012131.47020-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201222012131.47020-1-laoar.shao@gmail.com>
References: <20201222012131.47020-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Since XFS needs to pretend to be kswapd in some of its worker threads,
create methods to save & restore kswapd state.  Don't bother restoring
kswapd state in kswapd -- the only time we reach this code is when we're
exiting and the task_struct is about to be destroyed anyway.

Cc: Dave Chinner <david@fromorbit.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 fs/xfs/libxfs/xfs_btree.c | 14 ++++++++------
 include/linux/sched/mm.h  | 22 ++++++++++++++++++++++
 mm/vmscan.c               | 16 +---------------
 3 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_btree.c b/fs/xfs/libxfs/xfs_btree.c
index 51dbff9b0908..0f35b7a38e76 100644
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
index d5ece7a9a403..7195e542a54d 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -278,6 +278,28 @@ static inline void memalloc_nocma_restore(unsigned int flags)
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
+	return flags;
+}
+
+static inline void restore_kswapd(unsigned long flags)
+{
+	current->flags = (current->flags & ~KSWAPD_PF_FLAGS) | flags;
+}
+
 #ifdef CONFIG_MEMCG
 DECLARE_PER_CPU(struct mem_cgroup *, int_active_memcg);
 /**
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7b4e31eac2cf..15af99d1f3f7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3870,19 +3870,7 @@ static int kswapd(void *p)
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
@@ -3932,8 +3920,6 @@ static int kswapd(void *p)
 			goto kswapd_try_sleep;
 	}
 
-	tsk->flags &= ~(PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD);
-
 	return 0;
 }
 
-- 
2.18.4

