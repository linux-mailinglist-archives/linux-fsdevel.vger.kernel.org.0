Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A071E62FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 15:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390728AbgE1NzY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 09:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390716AbgE1NzW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 09:55:22 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C1CC05BD1E;
        Thu, 28 May 2020 06:55:22 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id z80so3155395qka.0;
        Thu, 28 May 2020 06:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xdQ5z1ksn2zGVq7EzDi+MjQVhReBbbpTpmOESCfEEX4=;
        b=hmVwED5zUKuJxKCfzDCS2KiXSvVHTHkr7UcIWpKBx03rriA533svefREB4D+PiTzm3
         ecrfa+dd7H6xGbgDgi4grae6QgeljFodUTYDAvJsnS7Vd9nwwi9U50+y0E6/AJ+uyjbx
         b5iBc1LJvwzYrcQhhRJUo91Gvk7dPcXStiCclPD3xabbqYcQaAzMAApjbnj3Wxzh4Ap6
         imu3NpGpZWRt2mrqo3O4rPj+X7dzJJ67fXsU1pvjaCw4btThuvzH8XDBK2x6splXdd9e
         25+IlF5Oh/SlIhHIgk5XJQ+770lsR1JjvnQ+Bg7NePQtyNnkfLzf70fHhvMH7u+wpTcC
         SKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xdQ5z1ksn2zGVq7EzDi+MjQVhReBbbpTpmOESCfEEX4=;
        b=LKJ/2eO/YjdvmGGFW6uahbgPhGuYx5gDVEbt0wG68C+tHPMtsJpgwtpAQ0fxVOl+1a
         tiJCAufy6KzAS8DZwGrvqv4LIGzV17MPB1P3MLF1sOCglOSCvDMGrYD6vUic9o5Ztpxu
         frajLsEp1gdhRW0f+8lofyRJd4hM/d/S0vMsDrt/39fSuNaC1PTyV/+Tg9aOhzCO+c71
         uzHhyJidCMUmfSATys7P+zNeuB6Hyif8JysqqfhxTpUVLHBFljbLy1XmE8WhrA0zIL5d
         aMRQOWr5e1deGwdQz2DgW3MtFqBQyBWeO+jw++ABLgHotMzwUrEfTb0SnIcqZFrdIsLJ
         3Z8A==
X-Gm-Message-State: AOAM532v0511Qxet8loz+s0um5d8TwaFAduoZolLxSoZqG0FrCglB0B8
        nHufhwAI/ZelrgUMjZ9udIs=
X-Google-Smtp-Source: ABdhPJyEoyMbQ8G21O8guSL9i01ABUiPOY3z4UBZnTPGSCVe+vyGkea+k5buVcG0lU+uzQj4QJZHrw==
X-Received: by 2002:a05:620a:64f:: with SMTP id a15mr2866901qka.10.1590674121502;
        Thu, 28 May 2020 06:55:21 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN.thefacebook.com ([2620:10d:c091:480::1:1cb7])
        by smtp.gmail.com with ESMTPSA id l186sm4890889qkf.89.2020.05.28.06.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 06:55:20 -0700 (PDT)
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure)),
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-mm@kvack.org (open list:CONTROL GROUP - MEMORY RESOURCE
        CONTROLLER (MEMCG))
Subject: [PATCH 2/4] mm: support nesting memalloc_use_memcg()
Date:   Thu, 28 May 2020 09:54:37 -0400
Message-Id: <20200528135444.11508-3-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200528135444.11508-1-schatzberg.dan@gmail.com>
References: <20200528135444.11508-1-schatzberg.dan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Johannes Weiner <hannes@cmpxchg.org>

The memalloc_use_memcg() function to override the default memcg
accounting context currently doesn't nest. But the patches to make the
loop driver cgroup-aware will end up nesting:

[   98.137605]  alloc_page_buffers+0x210/0x288
[   98.141799]  __getblk_gfp+0x1d4/0x400
[   98.145475]  ext4_read_block_bitmap_nowait+0x148/0xbc8
[   98.150628]  ext4_mb_init_cache+0x25c/0x9b0
[   98.154821]  ext4_mb_init_group+0x270/0x390
[   98.159014]  ext4_mb_good_group+0x264/0x270
[   98.163208]  ext4_mb_regular_allocator+0x480/0x798
[   98.168011]  ext4_mb_new_blocks+0x958/0x10f8
[   98.172294]  ext4_ext_map_blocks+0xec8/0x1618
[   98.176660]  ext4_map_blocks+0x1b8/0x8a0
[   98.180592]  ext4_writepages+0x830/0xf10
[   98.184523]  do_writepages+0xb4/0x198
[   98.188195]  __filemap_fdatawrite_range+0x170/0x1c8
[   98.193086]  filemap_write_and_wait_range+0x40/0xb0
[   98.197974]  ext4_punch_hole+0x4a4/0x660
[   98.201907]  ext4_fallocate+0x294/0x1190
[   98.205839]  loop_process_work+0x690/0x1100
[   98.210032]  loop_workfn+0x2c/0x110
[   98.213529]  process_one_work+0x3e0/0x648
[   98.217546]  worker_thread+0x70/0x670
[   98.221217]  kthread+0x1b8/0x1c0
[   98.224452]  ret_from_fork+0x10/0x18

where loop_process_work() sets the memcg override to the memcg that
submitted the IO request, and alloc_page_buffers() sets the override
to the memcg that instantiated the cache page, which may differ.

Make memalloc_use_memcg() return the old memcg and convert existing
users to a stacking model. Delete the unused memalloc_unuse_memcg().

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Roman Gushchin <guro@fb.com>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 fs/buffer.c                          |  6 +++---
 fs/notify/fanotify/fanotify.c        |  5 +++--
 fs/notify/inotify/inotify_fsnotify.c |  5 +++--
 include/linux/sched/mm.h             | 28 +++++++++-------------------
 4 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index a60f60396cfa..585416dec6a2 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -851,13 +851,13 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 	struct buffer_head *bh, *head;
 	gfp_t gfp = GFP_NOFS | __GFP_ACCOUNT;
 	long offset;
-	struct mem_cgroup *memcg;
+	struct mem_cgroup *memcg, *old_memcg;
 
 	if (retry)
 		gfp |= __GFP_NOFAIL;
 
 	memcg = get_mem_cgroup_from_page(page);
-	memalloc_use_memcg(memcg);
+	old_memcg = memalloc_use_memcg(memcg);
 
 	head = NULL;
 	offset = PAGE_SIZE;
@@ -876,7 +876,7 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 		set_bh_page(bh, page, offset);
 	}
 out:
-	memalloc_unuse_memcg();
+	memalloc_use_memcg(old_memcg);
 	mem_cgroup_put(memcg);
 	return head;
 /*
diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 5435a40f82be..6b869d95bfb6 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -353,6 +353,7 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	gfp_t gfp = GFP_KERNEL_ACCOUNT;
 	struct inode *id = fanotify_fid_inode(inode, mask, data, data_type);
 	const struct path *path = fsnotify_data_path(data, data_type);
+	struct mem_cgroup *old_memcg;
 
 	/*
 	 * For queues with unlimited length lost events are not expected and
@@ -366,7 +367,7 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 		gfp |= __GFP_RETRY_MAYFAIL;
 
 	/* Whoever is interested in the event, pays for the allocation. */
-	memalloc_use_memcg(group->memcg);
+	old_memcg = memalloc_use_memcg(group->memcg);
 
 	if (fanotify_is_perm_event(mask)) {
 		struct fanotify_perm_event *pevent;
@@ -451,7 +452,7 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 		}
 	}
 out:
-	memalloc_unuse_memcg();
+	memalloc_use_memcg(old_memcg);
 	return event;
 }
 
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index 2ebc89047153..52f38e6e81b7 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -69,6 +69,7 @@ int inotify_handle_event(struct fsnotify_group *group,
 	int ret;
 	int len = 0;
 	int alloc_len = sizeof(struct inotify_event_info);
+	struct mem_cgroup *old_memcg;
 
 	if (WARN_ON(fsnotify_iter_vfsmount_mark(iter_info)))
 		return 0;
@@ -93,9 +94,9 @@ int inotify_handle_event(struct fsnotify_group *group,
 	 * trigger OOM killer in the target monitoring memcg as it may have
 	 * security repercussion.
 	 */
-	memalloc_use_memcg(group->memcg);
+	old_memcg = memalloc_use_memcg(group->memcg);
 	event = kmalloc(alloc_len, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
-	memalloc_unuse_memcg();
+	memalloc_use_memcg(old_memcg);
 
 	if (unlikely(!event)) {
 		/*
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index c49257a3b510..95e8bfb0cab1 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -316,31 +316,21 @@ static inline void memalloc_nocma_restore(unsigned int flags)
  * __GFP_ACCOUNT allocations till the end of the scope will be charged to the
  * given memcg.
  *
- * NOTE: This function is not nesting safe.
+ * NOTE: This function can nest. Users must save the return value and
+ * reset the previous value after their own charging scope is over
  */
-static inline void memalloc_use_memcg(struct mem_cgroup *memcg)
+static inline struct mem_cgroup *
+memalloc_use_memcg(struct mem_cgroup *memcg)
 {
-	WARN_ON_ONCE(current->active_memcg);
+	struct mem_cgroup *old = current->active_memcg;
 	current->active_memcg = memcg;
-}
-
-/**
- * memalloc_unuse_memcg - Ends the remote memcg charging scope.
- *
- * This function marks the end of the remote memcg charging scope started by
- * memalloc_use_memcg().
- */
-static inline void memalloc_unuse_memcg(void)
-{
-	current->active_memcg = NULL;
+	return old;
 }
 #else
-static inline void memalloc_use_memcg(struct mem_cgroup *memcg)
-{
-}
-
-static inline void memalloc_unuse_memcg(void)
+static inline struct mem_cgroup *
+memalloc_use_memcg(struct mem_cgroup *memcg)
 {
+	return NULL;
 }
 #endif
 
-- 
2.24.1

