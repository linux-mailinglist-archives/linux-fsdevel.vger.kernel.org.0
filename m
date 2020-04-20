Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66E71B19AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 00:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgDTWlj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 18:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgDTWli (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 18:41:38 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83260C061A0C;
        Mon, 20 Apr 2020 15:41:38 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id q17so10096849qtp.4;
        Mon, 20 Apr 2020 15:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PF+r9U7T5dFzMfmZ2H0sB6HLsz2rHKKvLwEVcGuIpcE=;
        b=s0ppksDPgiSOKM/KyEDwVugxCmb68ObCnOTlITDua9AHhazdNHlaSsX/KW4jFbGBhM
         pvUIpAr0MRoq3iv+YMnxYsAhJT6r9WiVNjR/5WwnD91XtuI2M62sKocensWqKopi4kMe
         trU21vd4mymUKSAapwtiANNo7l8praDENDhXtymMn/IYpSm/ERxRn2Z8AZCkccuy9e3L
         7061fVDHGmriR7TKsT/ISC3xfVKc6KQ2QcZnLMqhY9erQC0h5wlkNLyx4tvVsBsozLt3
         D2VPllTthDJzXvx+fdkFFCeds2NiAWkwf0ix6m2soi2cino3ITqoi84RKQ+AJJd2eytV
         UMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PF+r9U7T5dFzMfmZ2H0sB6HLsz2rHKKvLwEVcGuIpcE=;
        b=J5Wm2zMaEj4CiASvwe7n3YzfuOnL+JeOvcFIzhWiY/qhspz3x6PpibNfzHrfdHQI96
         vBAUVM420s4JeZuo0aowikwLMjUV6rEmpOoA11U3UjzbnSCF9xBna99B9mfW99fIBMiL
         Jxt+CGe/9B3PahBlTWbp3x2lZgmWPAALUwFkh/CXEwe7ex4g6ocCseTtY7EbnZrdlObj
         hE0Fk+4sU9sA9ZsJsaLvHGrygx2bthQtWmbQ58FapfQpjQQm5pi8mSVPQtbSvkebD6fo
         ZsfFieIlkPo/g6jCYLOEobc3R9OTnFmnkiaM9j/yAKsGYNw3Pdn4Fsoone2tLs6utM6B
         69Jw==
X-Gm-Message-State: AGi0PuZTBWFAYsrqVZVxv+JraZqUTmS3rMYnNAVVRwJmrwoaaz5J1OpQ
        qfv2eQW8rNxMxujDtg1KrNs=
X-Google-Smtp-Source: APiQypJGk7yzl7B27FXZuzmRx3Qzwgn98bKgk5SustM+NXz9qsMst0hrcMBafzm+J+VhYleyAKcBCw==
X-Received: by 2002:ac8:3025:: with SMTP id f34mr19014333qte.219.1587422497596;
        Mon, 20 Apr 2020 15:41:37 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN.thefacebook.com ([2620:10d:c091:480::1:b0d9])
        by smtp.gmail.com with ESMTPSA id j90sm511052qte.20.2020.04.20.15.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:41:36 -0700 (PDT)
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure)),
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-mm@kvack.org (open list:CONTROL GROUP - MEMORY RESOURCE
        CONTROLLER (MEMCG))
Subject: [PATCH 2/4] mm: support nesting memalloc_use_memcg()
Date:   Mon, 20 Apr 2020 18:39:30 -0400
Message-Id: <20200420223936.6773-3-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200420223936.6773-1-schatzberg.dan@gmail.com>
References: <20200420223936.6773-1-schatzberg.dan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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

Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
---
 fs/buffer.c                          |  6 +++---
 fs/notify/fanotify/fanotify.c        |  5 +++--
 fs/notify/inotify/inotify_fsnotify.c |  5 +++--
 include/linux/sched/mm.h             | 28 +++++++++-------------------
 4 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 599a0bf7257b..e39e05985323 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -851,13 +851,13 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 	struct buffer_head *bh, *head;
 	gfp_t gfp = GFP_NOFS | __GFP_ACCOUNT;
 	long offset;
-	struct mem_cgroup *memcg;
+	struct mem_cgroup *memcg, *oldmemcg;
 
 	if (retry)
 		gfp |= __GFP_NOFAIL;
 
 	memcg = get_mem_cgroup_from_page(page);
-	memalloc_use_memcg(memcg);
+	oldmemcg = memalloc_use_memcg(memcg);
 
 	head = NULL;
 	offset = PAGE_SIZE;
@@ -876,7 +876,7 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 		set_bh_page(bh, page, offset);
 	}
 out:
-	memalloc_unuse_memcg();
+	memalloc_use_memcg(oldmemcg);
 	mem_cgroup_put(memcg);
 	return head;
 /*
diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 5435a40f82be..54c787cd6efb 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -353,6 +353,7 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	gfp_t gfp = GFP_KERNEL_ACCOUNT;
 	struct inode *id = fanotify_fid_inode(inode, mask, data, data_type);
 	const struct path *path = fsnotify_data_path(data, data_type);
+	struct mem_cgroup *oldmemcg;
 
 	/*
 	 * For queues with unlimited length lost events are not expected and
@@ -366,7 +367,7 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 		gfp |= __GFP_RETRY_MAYFAIL;
 
 	/* Whoever is interested in the event, pays for the allocation. */
-	memalloc_use_memcg(group->memcg);
+	oldmemcg = memalloc_use_memcg(group->memcg);
 
 	if (fanotify_is_perm_event(mask)) {
 		struct fanotify_perm_event *pevent;
@@ -451,7 +452,7 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 		}
 	}
 out:
-	memalloc_unuse_memcg();
+	memalloc_use_memcg(oldmemcg);
 	return event;
 }
 
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index 2ebc89047153..d27c6e83cea6 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -69,6 +69,7 @@ int inotify_handle_event(struct fsnotify_group *group,
 	int ret;
 	int len = 0;
 	int alloc_len = sizeof(struct inotify_event_info);
+	struct mem_cgroup *oldmemcg;
 
 	if (WARN_ON(fsnotify_iter_vfsmount_mark(iter_info)))
 		return 0;
@@ -93,9 +94,9 @@ int inotify_handle_event(struct fsnotify_group *group,
 	 * trigger OOM killer in the target monitoring memcg as it may have
 	 * security repercussion.
 	 */
-	memalloc_use_memcg(group->memcg);
+	oldmemcg = memalloc_use_memcg(group->memcg);
 	event = kmalloc(alloc_len, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
-	memalloc_unuse_memcg();
+	memalloc_use_memcg(oldmemcg);
 
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

