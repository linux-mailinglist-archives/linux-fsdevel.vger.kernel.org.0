Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2342F4896
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 11:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbhAMKXy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 05:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbhAMKXx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 05:23:53 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A92EC061786;
        Wed, 13 Jan 2021 02:23:13 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id d203so1577111oia.0;
        Wed, 13 Jan 2021 02:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Yc1Bbct8Nbc3LO9koCFr8h15MIb1wQ1a9mmnGoYcpk=;
        b=F6RNMrMlYlzlU+fcPLjxov7vGoK83JqogMt3GbZw5C8ko+w0YNb0VU9TfYdJyEi+QB
         N0S9gSR1qUCJgdrm/9aW4x5oGrccJAAbnKWrchroHLgAM9fco5zocBW1pJpV/3nFGaSF
         HmG0TR4ferxT2svYXpxc5gCbyROpUmdy6FfbL4nuMfCmInSBnbqLctn8nr9EAe94rk1U
         FV9YxvNfI5eRr7JcOCMffZs/t9uXopakVv0pDxbbKMwcHydriwbTcGBbtaRH2I9ID8IW
         ZjRz3zbGVfLn1cnUu58Nu3EWCtOpEZrkYH/gaMoFBeLpx3cOLnGmmbcaoyQjQQ8B08et
         ew5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Yc1Bbct8Nbc3LO9koCFr8h15MIb1wQ1a9mmnGoYcpk=;
        b=YODrpaCvw8ixFMSngHxqPqDBUdFKaZJ3RDb4hvdG0t8DMayG0iiVxD0pm4xX2Fag5I
         NL0W+uToR1b36IIFE0pOHIHVAzJu7olsfTeSOHTxUwKvBpv3ujSWWxKpOYm3K4k1psA2
         1Fkh4klIfpnLAHr7e2Yv4o/Au5brzYdnhi4149rAjVf65+28sDjCfrqxpgtQqwjm1EG5
         6QZUPdwXaZklViGhA2DpjjuHCd+z+tXsYeiqRHFuoWLyeNGsQp7G8iiPM5e+L4lbxWhp
         oAvFUvbnEd8ZLoGYHAtj0hH2LxOBj8EYlwPiqv41zh7Ouems8FEccNE+qNGdfJJd7kSr
         9DrA==
X-Gm-Message-State: AOAM532ttrur5IO4xiIb/p6BW12otj81cnf92Lvzd/e/ogFbV2EncQzK
        ai4Tkh9Q3WilAYu1e1hlp9o=
X-Google-Smtp-Source: ABdhPJzUiAkWIHr2kwijHoq+jSnJ10xMB1fk4Dfd7rhcx9Shi9eFjtqGc0F+UWJoXBSC8NNwusBIFQ==
X-Received: by 2002:a54:4391:: with SMTP id u17mr728149oiv.30.1610533392875;
        Wed, 13 Jan 2021 02:23:12 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id z8sm335571oon.10.2021.01.13.02.23.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jan 2021 02:23:12 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     darrick.wong@oracle.com, willy@infradead.org, david@fromorbit.com,
        hch@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org,
        dhowells@redhat.com, jlayton@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        oliver.sang@intel.com, Michal Hocko <mhocko@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v15 1/4] mm: Add become_kswapd and restore_kswapd
Date:   Wed, 13 Jan 2021 18:22:21 +0800
Message-Id: <20210113102224.13655-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210113102224.13655-1-laoar.shao@gmail.com>
References: <20210113102224.13655-1-laoar.shao@gmail.com>
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
index c4d7a9241dc3..c43f2ad85af9 100644
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
2.17.1

