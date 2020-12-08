Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728892D20AA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 03:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgLHCQ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 21:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgLHCQ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 21:16:59 -0500
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3212CC0613D6;
        Mon,  7 Dec 2020 18:16:19 -0800 (PST)
Received: by mail-ua1-x941.google.com with SMTP id t15so5164799ual.6;
        Mon, 07 Dec 2020 18:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m+1GohZiu08TBGb+QZ95Ht2UJWzVkthZE/EPME/oCwk=;
        b=p+Vo22Ajj0KnaKJDOjLCWdum9GRkWkLPGj0o9AcWdZtvcNVz5rGJDgCkqCrDKLb6HR
         07gGPDmiz2npXEvGiA+LDy6Q3KvxzbzsexQe9RGeUpO4N8m7NixtQO6T5Dz0cArVtPAP
         eQRdT+IHaBkiCRTp+o+TxWgV9tKTj5kqEH+5oYd73+kY92dYa6nEvqMvMuHx56CTVnUr
         Hk0TaAwkFS0UZTfOtYx5/E5922Q+9vBv7uRctfagykQXrwS1p4y7enLf/R5hxBwuTvne
         +M4EURRe7uj3g2Bxb1bXSHY/XZ+1Fl+o3pZ42FIMuGw/YpMc4nNW9gP+ppH01AUZzEZ4
         Le/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m+1GohZiu08TBGb+QZ95Ht2UJWzVkthZE/EPME/oCwk=;
        b=qhNq4x8/e3CbP0sBWB4HVWCEMGuR7m+TcmZ4Uz75oKGh8elIlAf1v3BMIQl7Zke1e2
         puqJhJRF1LSYjkUF2I0JQuco/g8HnPg4a5QZC6poXV3rTjXHAaQiAOXonlQdu9+RxmLr
         aiIb3Sk7DZ6qYPZycZIlpLk6cSrrQnEZKbgi2vFyxhDNPTvf6SNGiKK0u3ONQU+M+jR0
         U/9ZGaXac0Zwx13XIbe6uZ1aAM8Z2nRfDEep3cRAFvxW4GwuSxOzrQPnNMmmFh0iGq2N
         4y103P+7m/Dli7wQipaHyMwx8Gf4HmXRWCwa/U7RsHMEHmE5uS26B+JjY6TNB7P0hs/l
         p+JA==
X-Gm-Message-State: AOAM530w5XTpRoTo/pyiSYn44gEESqAsKrmlR6FuSdlIyNbPTRqQufce
        IVlRxRFAiG/WLRlS3mM2pto=
X-Google-Smtp-Source: ABdhPJykWOCUKyytu1BnOcC+NQiG9kaP5230ROkGfHRFt5Xw95zgweMCGNA0vNbhM+PCV+YvuSadfg==
X-Received: by 2002:a9f:26c5:: with SMTP id 63mr15305401uay.25.1607393778460;
        Mon, 07 Dec 2020 18:16:18 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id o192sm1936000vko.19.2020.12.07.18.16.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 18:16:17 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     darrick.wong@oracle.com, willy@infradead.org, david@fromorbit.com,
        hch@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org,
        dhowells@redhat.com, jlayton@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>, Christoph Hellwig <hch@lst.de>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v10 1/4] mm: Add become_kswapd and restore_kswapd
Date:   Tue,  8 Dec 2020 10:15:40 +0800
Message-Id: <20201208021543.76501-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201208021543.76501-1-laoar.shao@gmail.com>
References: <20201208021543.76501-1-laoar.shao@gmail.com>
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
index d5ece7a9a403..2faf03e79a1e 100644
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
index 1b8f0e059767..77bc1dda75bf 100644
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
2.18.4

