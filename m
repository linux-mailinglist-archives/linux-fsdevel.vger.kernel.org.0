Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA524CCC7E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 05:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237862AbiCDENo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 23:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiCDENn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 23:13:43 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D45E0C6
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Mar 2022 20:12:55 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id x193so6830644oix.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Mar 2022 20:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=PRuNNSOaSPA1xJ1Kn/a3aLc5/2s1VKsF2eYgh8kaOK8=;
        b=ffbMpA3udYH5SJDZGY794b10RjeR79MyVBPEL8Pk6yDcJrslXeTV7d3D30jq6hhuQV
         PNq2s6sM+k/KsxTaQDumhFJY9Bqp4TC6/jigQ7ehBqw5NRNBIrRXkYT6gHaENJgx2JwQ
         yWxXnnY66X0TB7/zwgR6Tu6Fv8LH/zeSEgCZbAt0HTJm/TuWUmfBgyo7hYpXVDLHPyIP
         5mPJxDF51Nh3O5YR76OxoR2fLeK96VPVK5DugQPXq3fymLmBNiE3XcshbxNTmRtRdWKA
         KwkxP/uqjQH67RmBoTgR8liJKRTkzUwNtzbW3rwzaxtluUMsyJviAFRxUzL9X4PWxdcW
         5pfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=PRuNNSOaSPA1xJ1Kn/a3aLc5/2s1VKsF2eYgh8kaOK8=;
        b=Tql+8fCike1TEQNW849hDDCqdJpMNC2sznWCAjqUBCjCEhhSg29BT8jUcJV+HGmcsE
         ektT0Vo/eShxOVxtHA7AvdGpuCuTFImTpkDLN2JHIpyWCXyzS/kHUWkXHj03lHQBdexO
         YUJH4/l514lyx2blH6qZp1TH9ehTIXZ1v5C47Qa3duwVWEKHarsnrSLcr7u9sWOienoH
         J9HFvsuLlBJGeBz1CKUrLpFD7pPBVSrlqZxxmyhcjQc/3ZtS5ZYbfjtx2cywLmrWYbln
         3ZHltknAunuFyZwIB54TPH4+q/5wGBnONSkVNPkB+nkuxEV1pe49FRhgrW28z/dhAcpU
         xAbw==
X-Gm-Message-State: AOAM532uQVvGjDJkYM0nJDXdi0wsP7Nahqwlqopq+Yhh7RW4Csax3Kj2
        2RZVhuteop1g4BtALMmFwQgEnw==
X-Google-Smtp-Source: ABdhPJzJOYSwvCqZJgqd6vKDLYMe+HwMW1LMi6psUIWLsK20bcIfjqHtLsUYRN3sw8yZO7xuQiApTg==
X-Received: by 2002:a05:6808:20a4:b0:2d5:1d0f:bba3 with SMTP id s36-20020a05680820a400b002d51d0fbba3mr7666408oiw.55.1646367174608;
        Thu, 03 Mar 2022 20:12:54 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id ec47-20020a0568708c2f00b000d9ca2e1904sm723354oab.45.2022.03.03.20.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 20:12:53 -0800 (PST)
Date:   Thu, 3 Mar 2022 20:12:42 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     NeilBrown <neilb@suse.de>, Jan Kara <jack@suse.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kerne.org,
        linux-mm@kvack.org
Subject: [PATCH mmotm] mm/fs: delete PF_SWAPWRITE
Message-ID: <75e80e7-742d-e3bd-531-614db8961e4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PF_SWAPWRITE has been redundant since v3.2 commit ee72886d8ed5
("mm: vmscan: do not writeback filesystem pages in direct reclaim").

Coincidentally, NeilBrown's current patch "remove inode_congested()"
deletes may_write_to_inode(), which appeared to be the one function
which took notice of PF_SWAPWRITE.  But if you study the old logic,
and the conditions under which may_write_to_inode() was called, you
discover that flag and function have been pointless for a decade.

Signed-off-by: Hugh Dickins <hughd@google.com>
---

 fs/fs-writeback.c         | 3 ---
 fs/xfs/libxfs/xfs_btree.c | 2 +-
 include/linux/sched.h     | 1 -
 mm/migrate.c              | 7 -------
 mm/vmscan.c               | 8 ++------
 5 files changed, 3 insertions(+), 18 deletions(-)

--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2196,7 +2196,6 @@ void wb_workfn(struct work_struct *work)
 	long pages_written;
 
 	set_worker_desc("flush-%s", bdi_dev_name(wb->bdi));
-	current->flags |= PF_SWAPWRITE;
 
 	if (likely(!current_is_workqueue_rescuer() ||
 		   !test_bit(WB_registered, &wb->state))) {
@@ -2225,8 +2224,6 @@ void wb_workfn(struct work_struct *work)
 		wb_wakeup(wb);
 	else if (wb_has_dirty_io(wb) && dirty_writeback_interval)
 		wb_wakeup_delayed(wb);
-
-	current->flags &= ~PF_SWAPWRITE;
 }
 
 /*
--- a/fs/xfs/libxfs/xfs_btree.c
+++ b/fs/xfs/libxfs/xfs_btree.c
@@ -2818,7 +2818,7 @@ struct xfs_btree_split_args {
 	 * in any way.
 	 */
 	if (args->kswapd)
-		new_pflags |= PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD;
+		new_pflags |= PF_MEMALLOC | PF_KSWAPD;
 
 	current_set_flags_nested(&pflags, new_pflags);
 	xfs_trans_set_context(args->cur->bc_tp);
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1700,7 +1700,6 @@ static inline int is_global_init(struct task_struct *tsk)
 						 * I am cleaning dirty pages from some other bdi. */
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
-#define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
 #define PF_MEMALLOC_PIN		0x10000000	/* Allocation context constrained to zones which allow long term pinning. */
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1350,7 +1350,6 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	bool is_thp = false;
 	struct page *page;
 	struct page *page2;
-	int swapwrite = current->flags & PF_SWAPWRITE;
 	int rc, nr_subpages;
 	LIST_HEAD(ret_pages);
 	LIST_HEAD(thp_split_pages);
@@ -1359,9 +1358,6 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 
 	trace_mm_migrate_pages_start(mode, reason);
 
-	if (!swapwrite)
-		current->flags |= PF_SWAPWRITE;
-
 thp_subpage_migration:
 	for (pass = 0; pass < 10 && (retry || thp_retry); pass++) {
 		retry = 0;
@@ -1516,9 +1512,6 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	trace_mm_migrate_pages(nr_succeeded, nr_failed_pages, nr_thp_succeeded,
 			       nr_thp_failed, nr_thp_split, mode, reason);
 
-	if (!swapwrite)
-		current->flags &= ~PF_SWAPWRITE;
-
 	if (ret_succeeded)
 		*ret_succeeded = nr_succeeded;
 
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4468,7 +4468,7 @@ static int kswapd(void *p)
 	 * us from recursively trying to free more memory as we're
 	 * trying to free the first piece of memory in the first place).
 	 */
-	tsk->flags |= PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD;
+	tsk->flags |= PF_MEMALLOC | PF_KSWAPD;
 	set_freezable();
 
 	WRITE_ONCE(pgdat->kswapd_order, 0);
@@ -4519,7 +4519,7 @@ static int kswapd(void *p)
 			goto kswapd_try_sleep;
 	}
 
-	tsk->flags &= ~(PF_MEMALLOC | PF_SWAPWRITE | PF_KSWAPD);
+	tsk->flags &= ~(PF_MEMALLOC | PF_KSWAPD);
 
 	return 0;
 }
@@ -4760,11 +4760,8 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
 	fs_reclaim_acquire(sc.gfp_mask);
 	/*
 	 * We need to be able to allocate from the reserves for RECLAIM_UNMAP
-	 * and we also need to be able to write out pages for RECLAIM_WRITE
-	 * and RECLAIM_UNMAP.
 	 */
 	noreclaim_flag = memalloc_noreclaim_save();
-	p->flags |= PF_SWAPWRITE;
 	set_task_reclaim_state(p, &sc.reclaim_state);
 
 	if (node_pagecache_reclaimable(pgdat) > pgdat->min_unmapped_pages) {
@@ -4778,7 +4775,6 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
 	}
 
 	set_task_reclaim_state(p, NULL);
-	current->flags &= ~PF_SWAPWRITE;
 	memalloc_noreclaim_restore(noreclaim_flag);
 	fs_reclaim_release(sc.gfp_mask);
 	psi_memstall_leave(&pflags);
