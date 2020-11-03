Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195CB2A4619
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 14:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgKCNS1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 08:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729183AbgKCNS0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:18:26 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA251C0613D1;
        Tue,  3 Nov 2020 05:18:26 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id t16so957206oie.11;
        Tue, 03 Nov 2020 05:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wcewLsncu9ZYLAdf8Dj+b3i3xIrhlEzCNXPbs1EqjSc=;
        b=U4Sq0WIhR9xhMN9zPWhvg/zls9REX7I5XS/eUk2Dmrg1PTGMlH1hqkaQhkJsZW4aFs
         HrzLLXJxQx4kGNkUK94cTwvSumfEUW+OSbdZYyoZx3Qqee+1b7NjQowPXNXKtQlMcqqs
         iIwgdq+MNQBS+u0Kn4Wn/U+aAR5ZdkGh1ICGYhD3fNGn8gb9XE2GKYGBV8WcpbRtaw/c
         htJYPkbAEBUYmJK0SGX2FdKMPK33YSZtRS1HdZ836qNuvDSdrIw2S1FOvdcd053EIuuK
         6A+2buP86nqP0qO5t2ucS15ZhxZM9yku26PMyApS3/c48JLNnV9oo4FYG8a1AhbrcZwm
         UGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wcewLsncu9ZYLAdf8Dj+b3i3xIrhlEzCNXPbs1EqjSc=;
        b=KjEgh4d7UfB0ycaOsIZSjUv6W2Ru0Io8N2GdvjzpYhKvqh6zDmpRuHp0+5+nGaplLo
         /Fyf2+S1vaSW1NvFRYS9410Qp6iz7j4X6nkEa+PkKxFEZY1kn0X4fc1e4yYl34Vv7VnU
         BbquqQQysV3hpAXAYU/KeGzU2v4HWh7sYDcqTbQICh9Th8CfIJjFzKeMto4Sntf8tK+R
         tKZrKGpVsyu9zP/ALPbD8juxDsYbEtJ3YJncKULsX8WCcXtz4S+ypJYGMwwlKgdN2wM6
         3rjz1n85ATmhhoFm8y3Cpf51lDvGV7aFbjIiwsCQYLWKPOr+I6gcyd6efCpVqpdKQFH0
         A1kg==
X-Gm-Message-State: AOAM530hPtbKdfgva52q7NGs2UX3MH+hwfT6l+3kW3UXgygmjYKqh3Ba
        WiLJQFSn8LvGEs4YFQUEe4g=
X-Google-Smtp-Source: ABdhPJxxY1oARG/kzprtfN6LQpvSv/dkZkBdU/f6ENapc5lPESBoit+o9PJKuZzR/35lv0PKgZQ8Aw==
X-Received: by 2002:aca:1e08:: with SMTP id m8mr1763659oic.168.1604409506161;
        Tue, 03 Nov 2020 05:18:26 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id f18sm4396138otf.55.2020.11.03.05.18.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2020 05:18:25 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     akpm@linux-foundation.org
Cc:     david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com,
        willy@infradead.org, mhocko@kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v8 resend 1/2] mm: Add become_kswapd and restore_kswapd
Date:   Tue,  3 Nov 2020 21:17:53 +0800
Message-Id: <20201103131754.94949-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20201103131754.94949-1-laoar.shao@gmail.com>
References: <20201103131754.94949-1-laoar.shao@gmail.com>
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
 include/linux/sched/mm.h  | 23 +++++++++++++++++++++++
 mm/vmscan.c               | 16 +---------------
 3 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_btree.c b/fs/xfs/libxfs/xfs_btree.c
index 2d25bab..a04a442 100644
--- a/fs/xfs/libxfs/xfs_btree.c
+++ b/fs/xfs/libxfs/xfs_btree.c
@@ -2813,8 +2813,9 @@ struct xfs_btree_split_args {
 {
 	struct xfs_btree_split_args	*args = container_of(work,
 						struct xfs_btree_split_args, work);
+	bool			is_kswapd = args->kswapd;
 	unsigned long		pflags;
-	unsigned long		new_pflags = PF_MEMALLOC_NOFS;
+	int			memalloc_nofs;
 
 	/*
 	 * we are in a transaction context here, but may also be doing work
@@ -2822,16 +2823,17 @@ struct xfs_btree_split_args {
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
index d5ece7a..2faf03e 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -278,6 +278,29 @@ static inline void memalloc_nocma_restore(unsigned int flags)
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
 DECLARE_PER_CPU(struct mem_cgroup *, int_active_memcg);
 /**
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1b8f0e0..77bc1dd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3869,19 +3869,7 @@ static int kswapd(void *p)
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
@@ -3931,8 +3919,6 @@ static int kswapd(void *p)
 			goto kswapd_try_sleep;
 	}
 
-	tsk->flags &= ~(PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD);
-
 	return 0;
 }
 
-- 
1.8.3.1

