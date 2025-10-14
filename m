Return-Path: <linux-fsdevel+bounces-64111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA10ABD93FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 14:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9CE719249F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 12:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E6D311968;
	Tue, 14 Oct 2025 12:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ewj2sDZc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EB22874ED
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 12:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760443831; cv=none; b=Gb6SGQVmBns6pv/X6W/q8sIvoYZ5RPKUNlmPG9trOyShr/iJJz9a0M2w+qgaHVIQaNGvp6+bsoljLh4gCKXFDB6TrJj2w4V2vp1OU0jAZ9NrBEpJnrPMsBXUHoUbBtrn7ZydjrklMO8EZ7ROmfXnAkD8kZJdrUUiTCrU0uXDfc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760443831; c=relaxed/simple;
	bh=p33eRl9QTt0xs46zKL3bTKsA6ksdsHvFocluEkYR0sE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=oLIX7Vgt06uwqD2YKAijjD84WaMcOnirc2zGbU53thR0iCbNv67S12gig420w5be+F88Hme98Bf7ajuwvpmfseX7JFMAuZglCG5ownsSgitphtV9J2YBT0zny9bjN5c+6sKvFJ+wH8x27UBB0HjRAC1QzeHpBG6qjrIAoFgEd7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ewj2sDZc; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251014121016epoutp046e2aeb09dbd87448ea896e8680718025~uWlLxL_Nn0942109421epoutp049
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 12:10:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251014121016epoutp046e2aeb09dbd87448ea896e8680718025~uWlLxL_Nn0942109421epoutp049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760443816;
	bh=5pPv6CvjbSVppBCw+rMHjXT/SOwyBHWCuL3I45d/2ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ewj2sDZcCK83vRRuNTqkRhLBRn8fh6gBWyaY0NGQzr9GzV2PV+jKjLyTc3x1YEcN7
	 QUuZAmWu32mHz1r0qAU8JUun+xJtr6mjhDFsw3kYF/m+PESTlcLBvXS5PR+QzDXet0
	 PPmXoOXkscd0E7wokgWFCGwqAL3au539bSBMrISc=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20251014121015epcas5p34659ecd5e47a61951d741728bc0c8c33~uWlK2YyRg0426604266epcas5p3f;
	Tue, 14 Oct 2025 12:10:15 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.95]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cmChk4hF9z3hhTC; Tue, 14 Oct
	2025 12:10:14 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20251014121014epcas5p11d254fd09fcc157ea69c39bd9c5984ed~uWlJYyPe70200502005epcas5p1D;
	Tue, 14 Oct 2025 12:10:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251014120959epsmtip11fda150fcc29b4442c14818df9e13a12~uWk7_PFNW1240212402epsmtip1K;
	Tue, 14 Oct 2025 12:09:59 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, akpm@linux-foundation.org,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com, david@fromorbit.com,
	amir73il@gmail.com, axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com,
	djwong@kernel.org, dave@stgolabs.net, wangyufei@vivo.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, kundan.kumar@samsung.com, anuj20.g@samsung.com,
	vishak.g@samsung.com, joshi.k@samsung.com
Subject: [PATCH v2 01/16] writeback: add infra for parallel writeback
Date: Tue, 14 Oct 2025 17:38:30 +0530
Message-Id: <20251014120845.2361-2-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251014120845.2361-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251014121014epcas5p11d254fd09fcc157ea69c39bd9c5984ed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251014121014epcas5p11d254fd09fcc157ea69c39bd9c5984ed
References: <20251014120845.2361-1-kundan.kumar@samsung.com>
	<CGME20251014121014epcas5p11d254fd09fcc157ea69c39bd9c5984ed@epcas5p1.samsung.com>

This is a prep patch which introduces a new bdi_writeback_ctx structure
that enables us to have multiple writeback contexts for parallel
writeback. Each bdi now can have multiple writeback contexts, with each
writeback context having has its own cgwb tree.

Modify all the functions/places that operate on bdi's wb, wb_list,
cgwb_tree, wb_switch_rwsem, wb_waitq as these fields have now been moved
to bdi_writeback_ctx.

This patch mechanically replaces bdi->wb to bdi->wb_ctx[0]->wb and there
is no functional change.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
---
 fs/f2fs/node.c                   |   4 +-
 fs/f2fs/segment.h                |   2 +-
 fs/fs-writeback.c                |  78 +++++++++++++--------
 fs/fuse/file.c                   |   6 +-
 fs/gfs2/super.c                  |   2 +-
 fs/nfs/internal.h                |   3 +-
 fs/nfs/write.c                   |   3 +-
 include/linux/backing-dev-defs.h |  32 +++++----
 include/linux/backing-dev.h      |  41 +++++++----
 include/linux/fs.h               |   1 -
 mm/backing-dev.c                 | 113 +++++++++++++++++++------------
 mm/page-writeback.c              |   5 +-
 12 files changed, 179 insertions(+), 111 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 27743b93e186..1693da9417f9 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -73,7 +73,7 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 		if (excess_cached_nats(sbi))
 			res = false;
 	} else if (type == DIRTY_DENTS) {
-		if (sbi->sb->s_bdi->wb.dirty_exceeded)
+		if (sbi->sb->s_bdi->wb_ctx[0]->wb.dirty_exceeded)
 			return false;
 		mem_size = get_pages(sbi, F2FS_DIRTY_DENTS);
 		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 1);
@@ -114,7 +114,7 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 		res = false;
 #endif
 	} else {
-		if (!sbi->sb->s_bdi->wb.dirty_exceeded)
+		if (!sbi->sb->s_bdi->wb_ctx[0]->wb.dirty_exceeded)
 			return true;
 	}
 	return res;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 5e2ee5c686b1..7e5b7b1a5d2b 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -993,7 +993,7 @@ static inline bool sec_usage_check(struct f2fs_sb_info *sbi, unsigned int secno)
  */
 static inline int nr_pages_to_skip(struct f2fs_sb_info *sbi, int type)
 {
-	if (sbi->sb->s_bdi->wb.dirty_exceeded)
+	if (sbi->sb->s_bdi->wb_ctx[0]->wb.dirty_exceeded)
 		return 0;
 
 	if (type == DATA)
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a07b8cf73ae2..0715a7617391 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -265,23 +265,26 @@ void __inode_attach_wb(struct inode *inode, struct folio *folio)
 {
 	struct backing_dev_info *bdi = inode_to_bdi(inode);
 	struct bdi_writeback *wb = NULL;
+	struct bdi_writeback_ctx *bdi_writeback_ctx = bdi->wb_ctx[0];
 
 	if (inode_cgwb_enabled(inode)) {
 		struct cgroup_subsys_state *memcg_css;
 
 		if (folio) {
 			memcg_css = mem_cgroup_css_from_folio(folio);
-			wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
+			wb = wb_get_create(bdi, bdi_writeback_ctx, memcg_css,
+					   GFP_ATOMIC);
 		} else {
 			/* must pin memcg_css, see wb_get_create() */
 			memcg_css = task_get_css(current, memory_cgrp_id);
-			wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
+			wb = wb_get_create(bdi, bdi_writeback_ctx, memcg_css,
+					   GFP_ATOMIC);
 			css_put(memcg_css);
 		}
 	}
 
 	if (!wb)
-		wb = &bdi->wb;
+		wb = &bdi_writeback_ctx->wb;
 
 	/*
 	 * There may be multiple instances of this function racing to
@@ -307,7 +310,7 @@ static void inode_cgwb_move_to_attached(struct inode *inode,
 	WARN_ON_ONCE(inode->i_state & I_FREEING);
 
 	inode->i_state &= ~I_SYNC_QUEUED;
-	if (wb != &wb->bdi->wb)
+	if (wb != &wb->bdi_wb_ctx->wb)
 		list_move(&inode->i_io_list, &wb->b_attached);
 	else
 		list_del_init(&inode->i_io_list);
@@ -382,14 +385,16 @@ struct inode_switch_wbs_context {
 	struct inode		*inodes[];
 };
 
-static void bdi_down_write_wb_switch_rwsem(struct backing_dev_info *bdi)
+static void
+bdi_down_write_wb_ctx_switch_rwsem(struct bdi_writeback_ctx *bdi_wb_ctx)
 {
-	down_write(&bdi->wb_switch_rwsem);
+	down_write(&bdi_wb_ctx->wb_switch_rwsem);
 }
 
-static void bdi_up_write_wb_switch_rwsem(struct backing_dev_info *bdi)
+static void
+bdi_up_write_wb_ctx_switch_rwsem(struct bdi_writeback_ctx *bdi_wb_ctx)
 {
-	up_write(&bdi->wb_switch_rwsem);
+	up_write(&bdi_wb_ctx->wb_switch_rwsem);
 }
 
 static bool inode_do_switch_wbs(struct inode *inode,
@@ -490,7 +495,8 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
 {
 	struct inode_switch_wbs_context *isw =
 		container_of(to_rcu_work(work), struct inode_switch_wbs_context, work);
-	struct backing_dev_info *bdi = inode_to_bdi(isw->inodes[0]);
+	struct bdi_writeback_ctx *bdi_wb_ctx =
+		fetch_bdi_writeback_ctx(isw->inodes[0]);
 	struct bdi_writeback *old_wb = isw->inodes[0]->i_wb;
 	struct bdi_writeback *new_wb = isw->new_wb;
 	unsigned long nr_switched = 0;
@@ -500,7 +506,7 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
 	 * If @inode switches cgwb membership while sync_inodes_sb() is
 	 * being issued, sync_inodes_sb() might miss it.  Synchronize.
 	 */
-	down_read(&bdi->wb_switch_rwsem);
+	down_read(&bdi_wb_ctx->wb_switch_rwsem);
 
 	/*
 	 * By the time control reaches here, RCU grace period has passed
@@ -529,7 +535,7 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
 	spin_unlock(&new_wb->list_lock);
 	spin_unlock(&old_wb->list_lock);
 
-	up_read(&bdi->wb_switch_rwsem);
+	up_read(&bdi_wb_ctx->wb_switch_rwsem);
 
 	if (nr_switched) {
 		wb_wakeup(new_wb);
@@ -583,6 +589,7 @@ static bool inode_prepare_wbs_switch(struct inode *inode,
 static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 {
 	struct backing_dev_info *bdi = inode_to_bdi(inode);
+	struct bdi_writeback_ctx *bdi_wb_ctx = fetch_bdi_writeback_ctx(inode);
 	struct cgroup_subsys_state *memcg_css;
 	struct inode_switch_wbs_context *isw;
 
@@ -609,7 +616,7 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 	if (!memcg_css)
 		goto out_free;
 
-	isw->new_wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
+	isw->new_wb = wb_get_create(bdi, bdi_wb_ctx, memcg_css, GFP_ATOMIC);
 	css_put(memcg_css);
 	if (!isw->new_wb)
 		goto out_free;
@@ -678,12 +685,14 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 
 	for (memcg_css = wb->memcg_css->parent; memcg_css;
 	     memcg_css = memcg_css->parent) {
-		isw->new_wb = wb_get_create(wb->bdi, memcg_css, GFP_KERNEL);
+		isw->new_wb = wb_get_create(wb->bdi, wb->bdi_wb_ctx,
+					    memcg_css, GFP_KERNEL);
 		if (isw->new_wb)
 			break;
 	}
+	/* wb_get() is noop for bdi's wb */
 	if (unlikely(!isw->new_wb))
-		isw->new_wb = &wb->bdi->wb; /* wb_get() is noop for bdi's wb */
+		isw->new_wb = &wb->bdi_wb_ctx->wb;
 
 	nr = 0;
 	spin_lock(&wb->list_lock);
@@ -994,18 +1003,19 @@ static long wb_split_bdi_pages(struct bdi_writeback *wb, long nr_pages)
  * total active write bandwidth of @bdi.
  */
 static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
+				  struct bdi_writeback_ctx *bdi_wb_ctx,
 				  struct wb_writeback_work *base_work,
 				  bool skip_if_busy)
 {
 	struct bdi_writeback *last_wb = NULL;
-	struct bdi_writeback *wb = list_entry(&bdi->wb_list,
+	struct bdi_writeback *wb = list_entry(&bdi_wb_ctx->wb_list,
 					      struct bdi_writeback, bdi_node);
 
 	might_sleep();
 restart:
 	rcu_read_lock();
-	list_for_each_entry_continue_rcu(wb, &bdi->wb_list, bdi_node) {
-		DEFINE_WB_COMPLETION(fallback_work_done, bdi);
+	list_for_each_entry_continue_rcu(wb, &bdi_wb_ctx->wb_list, bdi_node) {
+		DEFINE_WB_COMPLETION(fallback_work_done, bdi_wb_ctx);
 		struct wb_writeback_work fallback_work;
 		struct wb_writeback_work *work;
 		long nr_pages;
@@ -1103,7 +1113,7 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
 	 * And find the associated wb.  If the wb isn't there already
 	 * there's nothing to flush, don't create one.
 	 */
-	wb = wb_get_lookup(bdi, memcg_css);
+	wb = wb_get_lookup(bdi->wb_ctx[0], memcg_css);
 	if (!wb) {
 		ret = -ENOENT;
 		goto out_css_put;
@@ -1189,8 +1199,13 @@ fs_initcall(cgroup_writeback_init);
 
 #else	/* CONFIG_CGROUP_WRITEBACK */
 
-static void bdi_down_write_wb_switch_rwsem(struct backing_dev_info *bdi) { }
-static void bdi_up_write_wb_switch_rwsem(struct backing_dev_info *bdi) { }
+static void
+bdi_down_write_wb_ctx_switch_rwsem(struct bdi_writeback_ctx *bdi_wb_ctx)
+{ }
+
+static void
+bdi_up_write_wb_ctx_switch_rwsem(struct bdi_writeback_ctx *bdi_wb_ctx)
+{ }
 
 static void inode_cgwb_move_to_attached(struct inode *inode,
 					struct bdi_writeback *wb)
@@ -1231,14 +1246,15 @@ static long wb_split_bdi_pages(struct bdi_writeback *wb, long nr_pages)
 }
 
 static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
+				  struct bdi_writeback_ctx *bdi_wb_ctx,
 				  struct wb_writeback_work *base_work,
 				  bool skip_if_busy)
 {
 	might_sleep();
 
-	if (!skip_if_busy || !writeback_in_progress(&bdi->wb)) {
+	if (!skip_if_busy || !writeback_in_progress(&bdi_wb_ctx->wb)) {
 		base_work->auto_free = 0;
-		wb_queue_work(&bdi->wb, base_work);
+		wb_queue_work(&bdi_wb_ctx->wb, base_work);
 	}
 }
 
@@ -2371,7 +2387,7 @@ static void __wakeup_flusher_threads_bdi(struct backing_dev_info *bdi,
 	if (!bdi_has_dirty_io(bdi))
 		return;
 
-	list_for_each_entry_rcu(wb, &bdi->wb_list, bdi_node)
+	list_for_each_entry_rcu(wb, &bdi->wb_ctx[0]->wb_list, bdi_node)
 		wb_start_writeback(wb, reason);
 }
 
@@ -2427,7 +2443,8 @@ static void wakeup_dirtytime_writeback(struct work_struct *w)
 	list_for_each_entry_rcu(bdi, &bdi_list, bdi_list) {
 		struct bdi_writeback *wb;
 
-		list_for_each_entry_rcu(wb, &bdi->wb_list, bdi_node)
+		list_for_each_entry_rcu(wb, &bdi->wb_ctx[0]->wb_list,
+					bdi_node)
 			if (!list_empty(&wb->b_dirty_time))
 				wb_wakeup(wb);
 	}
@@ -2730,7 +2747,7 @@ static void __writeback_inodes_sb_nr(struct super_block *sb, unsigned long nr,
 				     enum wb_reason reason, bool skip_if_busy)
 {
 	struct backing_dev_info *bdi = sb->s_bdi;
-	DEFINE_WB_COMPLETION(done, bdi);
+	DEFINE_WB_COMPLETION(done, bdi->wb_ctx[0]);
 	struct wb_writeback_work work = {
 		.sb			= sb,
 		.sync_mode		= WB_SYNC_NONE,
@@ -2744,7 +2761,8 @@ static void __writeback_inodes_sb_nr(struct super_block *sb, unsigned long nr,
 		return;
 	WARN_ON(!rwsem_is_locked(&sb->s_umount));
 
-	bdi_split_work_to_wbs(sb->s_bdi, &work, skip_if_busy);
+	bdi_split_work_to_wbs(sb->s_bdi, bdi->wb_ctx[0], &work,
+			      skip_if_busy);
 	wb_wait_for_completion(&done);
 }
 
@@ -2808,7 +2826,7 @@ EXPORT_SYMBOL(try_to_writeback_inodes_sb);
 void sync_inodes_sb(struct super_block *sb)
 {
 	struct backing_dev_info *bdi = sb->s_bdi;
-	DEFINE_WB_COMPLETION(done, bdi);
+	DEFINE_WB_COMPLETION(done, bdi->wb_ctx[0]);
 	struct wb_writeback_work work = {
 		.sb		= sb,
 		.sync_mode	= WB_SYNC_ALL,
@@ -2829,10 +2847,10 @@ void sync_inodes_sb(struct super_block *sb)
 	WARN_ON(!rwsem_is_locked(&sb->s_umount));
 
 	/* protect against inode wb switch, see inode_switch_wbs_work_fn() */
-	bdi_down_write_wb_switch_rwsem(bdi);
-	bdi_split_work_to_wbs(bdi, &work, false);
+	bdi_down_write_wb_ctx_switch_rwsem(bdi->wb_ctx[0]);
+	bdi_split_work_to_wbs(bdi, bdi->wb_ctx[0], &work, false);
 	wb_wait_for_completion(&done);
-	bdi_up_write_wb_switch_rwsem(bdi);
+	bdi_up_write_wb_ctx_switch_rwsem(bdi->wb_ctx[0]);
 
 	wait_sb_inodes(sb);
 }
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 4adcf09d4b01..8c823a661139 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1833,8 +1833,8 @@ static void fuse_writepage_finish(struct fuse_writepage_args *wpa)
 		 * contention and noticeably improves performance.
 		 */
 		iomap_finish_folio_write(inode, ap->folios[i], 1);
-		dec_wb_stat(&bdi->wb, WB_WRITEBACK);
-		wb_writeout_inc(&bdi->wb);
+		dec_wb_stat(&bdi->wb_ctx[0]->wb, WB_WRITEBACK);
+		wb_writeout_inc(&bdi->wb_ctx[0]->wb);
 	}
 
 	wake_up(&fi->page_waitq);
@@ -2017,7 +2017,7 @@ static void fuse_writepage_args_page_fill(struct fuse_writepage_args *wpa, struc
 	ap->descs[folio_index].offset = offset;
 	ap->descs[folio_index].length = len;
 
-	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
+	inc_wb_stat(&inode_to_bdi(inode)->wb_ctx[0]->wb, WB_WRITEBACK);
 }
 
 static struct fuse_writepage_args *fuse_writepage_args_setup(struct folio *folio,
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index b42e2110084b..bd11d5e6cf63 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -447,7 +447,7 @@ static int gfs2_write_inode(struct inode *inode, struct writeback_control *wbc)
 		gfs2_log_flush(GFS2_SB(inode), ip->i_gl,
 			       GFS2_LOG_HEAD_FLUSH_NORMAL |
 			       GFS2_LFC_WRITE_INODE);
-	if (bdi->wb.dirty_exceeded)
+	if (bdi->wb_ctx[0]->wb.dirty_exceeded)
 		gfs2_ail1_flush(sdp, wbc);
 	else
 		filemap_fdatawrite(metamapping);
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index c0a44f389f8f..5b3c84104b5b 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -857,7 +857,8 @@ static inline void nfs_folio_mark_unstable(struct folio *folio,
 		 * writeback is happening on the server now.
 		 */
 		node_stat_mod_folio(folio, NR_WRITEBACK, nr);
-		wb_stat_mod(&inode_to_bdi(inode)->wb, WB_WRITEBACK, nr);
+		wb_stat_mod(&inode_to_bdi(inode)->wb_ctx[0]->wb,
+			    WB_WRITEBACK, nr);
 		__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
 	}
 }
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 647c53d1418a..4317b93bc2af 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -865,9 +865,10 @@ static void nfs_folio_clear_commit(struct folio *folio)
 {
 	if (folio) {
 		long nr = folio_nr_pages(folio);
+		struct inode *inode = folio->mapping->host;
 
 		node_stat_mod_folio(folio, NR_WRITEBACK, -nr);
-		wb_stat_mod(&inode_to_bdi(folio->mapping->host)->wb,
+		wb_stat_mod(&inode_to_bdi(inode)->wb_ctx[0]->wb,
 			    WB_WRITEBACK, -nr);
 	}
 }
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 2ad261082bba..692ec7be73e2 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -75,10 +75,11 @@ struct wb_completion {
  * can wait for the completion of all using wb_wait_for_completion().  Work
  * items which are waited upon aren't freed automatically on completion.
  */
-#define WB_COMPLETION_INIT(bdi)		__WB_COMPLETION_INIT(&(bdi)->wb_waitq)
+#define WB_COMPLETION_INIT(bdi_wb_ctx)	\
+	__WB_COMPLETION_INIT(&(bdi_wb_ctx)->wb_waitq)
 
-#define DEFINE_WB_COMPLETION(cmpl, bdi)	\
-	struct wb_completion cmpl = WB_COMPLETION_INIT(bdi)
+#define DEFINE_WB_COMPLETION(cmpl, bdi_wb_ctx)	\
+	struct wb_completion cmpl = WB_COMPLETION_INIT(bdi_wb_ctx)
 
 /*
  * Each wb (bdi_writeback) can perform writeback operations, is measured
@@ -104,6 +105,7 @@ struct wb_completion {
  */
 struct bdi_writeback {
 	struct backing_dev_info *bdi;	/* our parent bdi */
+	struct bdi_writeback_ctx *bdi_wb_ctx;
 
 	unsigned long state;		/* Always use atomic bitops on this */
 	unsigned long last_old_flush;	/* last old data flush */
@@ -160,6 +162,16 @@ struct bdi_writeback {
 #endif
 };
 
+struct bdi_writeback_ctx {
+	struct bdi_writeback wb;  /* the root writeback info for this bdi */
+	struct list_head wb_list; /* list of all wbs */
+#ifdef CONFIG_CGROUP_WRITEBACK
+	struct radix_tree_root cgwb_tree; /* radix tree of active cgroup wbs */
+	struct rw_semaphore wb_switch_rwsem; /* no cgwb switch while syncing */
+#endif
+	wait_queue_head_t wb_waitq;
+};
+
 struct backing_dev_info {
 	u64 id;
 	struct rb_node rb_node; /* keyed by ->id */
@@ -183,15 +195,11 @@ struct backing_dev_info {
 	 */
 	unsigned long last_bdp_sleep;
 
-	struct bdi_writeback wb;  /* the root writeback info for this bdi */
-	struct list_head wb_list; /* list of all wbs */
+	int nr_wb_ctx;
+	struct bdi_writeback_ctx **wb_ctx;
 #ifdef CONFIG_CGROUP_WRITEBACK
-	struct radix_tree_root cgwb_tree; /* radix tree of active cgroup wbs */
 	struct mutex cgwb_release_mutex;  /* protect shutdown of wb structs */
-	struct rw_semaphore wb_switch_rwsem; /* no cgwb switch while syncing */
 #endif
-	wait_queue_head_t wb_waitq;
-
 	struct device *dev;
 	char dev_name[64];
 	struct device *owner;
@@ -216,7 +224,7 @@ struct wb_lock_cookie {
  */
 static inline bool wb_tryget(struct bdi_writeback *wb)
 {
-	if (wb != &wb->bdi->wb)
+	if (wb != &wb->bdi_wb_ctx->wb)
 		return percpu_ref_tryget(&wb->refcnt);
 	return true;
 }
@@ -227,7 +235,7 @@ static inline bool wb_tryget(struct bdi_writeback *wb)
  */
 static inline void wb_get(struct bdi_writeback *wb)
 {
-	if (wb != &wb->bdi->wb)
+	if (wb != &wb->bdi_wb_ctx->wb)
 		percpu_ref_get(&wb->refcnt);
 }
 
@@ -246,7 +254,7 @@ static inline void wb_put_many(struct bdi_writeback *wb, unsigned long nr)
 		return;
 	}
 
-	if (wb != &wb->bdi->wb)
+	if (wb != &wb->bdi_wb_ctx->wb)
 		percpu_ref_put_many(&wb->refcnt, nr);
 }
 
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index e721148c95d0..92674543ac8a 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -148,11 +148,20 @@ static inline bool mapping_can_writeback(struct address_space *mapping)
 	return inode_to_bdi(mapping->host)->capabilities & BDI_CAP_WRITEBACK;
 }
 
+static inline struct bdi_writeback_ctx *
+fetch_bdi_writeback_ctx(struct inode *inode)
+{
+	struct backing_dev_info *bdi = inode_to_bdi(inode);
+
+	return bdi->wb_ctx[0];
+}
+
 #ifdef CONFIG_CGROUP_WRITEBACK
 
-struct bdi_writeback *wb_get_lookup(struct backing_dev_info *bdi,
+struct bdi_writeback *wb_get_lookup(struct bdi_writeback_ctx *bdi_wb_ctx,
 				    struct cgroup_subsys_state *memcg_css);
 struct bdi_writeback *wb_get_create(struct backing_dev_info *bdi,
+				    struct bdi_writeback_ctx *bdi_wb_ctx,
 				    struct cgroup_subsys_state *memcg_css,
 				    gfp_t gfp);
 void wb_memcg_offline(struct mem_cgroup *memcg);
@@ -187,16 +196,18 @@ static inline bool inode_cgwb_enabled(struct inode *inode)
  * Must be called under rcu_read_lock() which protects the returend wb.
  * NULL if not found.
  */
-static inline struct bdi_writeback *wb_find_current(struct backing_dev_info *bdi)
+static inline struct bdi_writeback *
+wb_find_current(struct backing_dev_info *bdi,
+		struct bdi_writeback_ctx *bdi_wb_ctx)
 {
 	struct cgroup_subsys_state *memcg_css;
 	struct bdi_writeback *wb;
 
 	memcg_css = task_css(current, memory_cgrp_id);
 	if (!memcg_css->parent)
-		return &bdi->wb;
+		return &bdi_wb_ctx->wb;
 
-	wb = radix_tree_lookup(&bdi->cgwb_tree, memcg_css->id);
+	wb = radix_tree_lookup(&bdi_wb_ctx->cgwb_tree, memcg_css->id);
 
 	/*
 	 * %current's blkcg equals the effective blkcg of its memcg.  No
@@ -217,12 +228,13 @@ static inline struct bdi_writeback *wb_find_current(struct backing_dev_info *bdi
  * wb_find_current().
  */
 static inline struct bdi_writeback *
-wb_get_create_current(struct backing_dev_info *bdi, gfp_t gfp)
+wb_get_create_current(struct backing_dev_info *bdi,
+		      struct bdi_writeback_ctx *bdi_wb_ctx, gfp_t gfp)
 {
 	struct bdi_writeback *wb;
 
 	rcu_read_lock();
-	wb = wb_find_current(bdi);
+	wb = wb_find_current(bdi, bdi_wb_ctx);
 	if (wb && unlikely(!wb_tryget(wb)))
 		wb = NULL;
 	rcu_read_unlock();
@@ -231,7 +243,7 @@ wb_get_create_current(struct backing_dev_info *bdi, gfp_t gfp)
 		struct cgroup_subsys_state *memcg_css;
 
 		memcg_css = task_get_css(current, memory_cgrp_id);
-		wb = wb_get_create(bdi, memcg_css, gfp);
+		wb = wb_get_create(bdi, bdi_wb_ctx, memcg_css, gfp);
 		css_put(memcg_css);
 	}
 	return wb;
@@ -265,7 +277,7 @@ static inline struct bdi_writeback *inode_to_wb_wbc(
 	 * If wbc does not have inode attached, it means cgroup writeback was
 	 * disabled when wbc started. Just use the default wb in that case.
 	 */
-	return wbc->wb ? wbc->wb : &inode_to_bdi(inode)->wb;
+	return wbc->wb ? wbc->wb : &fetch_bdi_writeback_ctx(inode)->wb;
 }
 
 /**
@@ -325,20 +337,23 @@ static inline bool inode_cgwb_enabled(struct inode *inode)
 	return false;
 }
 
-static inline struct bdi_writeback *wb_find_current(struct backing_dev_info *bdi)
+static inline struct bdi_writeback *wb_find_current(
+		struct backing_dev_info *bdi,
+		struct bdi_writeback_ctx *bdi_wb_ctx)
 {
-	return &bdi->wb;
+	return &bdi_wb_ctx->wb;
 }
 
 static inline struct bdi_writeback *
-wb_get_create_current(struct backing_dev_info *bdi, gfp_t gfp)
+wb_get_create_current(struct backing_dev_info *bdi,
+		      struct bdi_writeback_ctx *bdi_wb_ctx, gfp_t gfp)
 {
-	return &bdi->wb;
+	return &bdi_wb_ctx->wb;
 }
 
 static inline struct bdi_writeback *inode_to_wb(struct inode *inode)
 {
-	return &inode_to_bdi(inode)->wb;
+	return &fetch_bdi_writeback_ctx(inode)->wb;
 }
 
 static inline struct bdi_writeback *inode_to_wb_wbc(
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 601d036a6c78..754fec84f350 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2342,7 +2342,6 @@ struct super_operations {
    	struct inode *(*alloc_inode)(struct super_block *sb);
 	void (*destroy_inode)(struct inode *);
 	void (*free_inode)(struct inode *);
-
    	void (*dirty_inode) (struct inode *, int flags);
 	int (*write_inode) (struct inode *, struct writeback_control *wbc);
 	int (*drop_inode) (struct inode *);
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 783904d8c5ef..8b7125349f6c 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -84,13 +84,14 @@ static void collect_wb_stats(struct wb_stats *stats,
 }
 
 #ifdef CONFIG_CGROUP_WRITEBACK
+
 static void bdi_collect_stats(struct backing_dev_info *bdi,
 			      struct wb_stats *stats)
 {
 	struct bdi_writeback *wb;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(wb, &bdi->wb_list, bdi_node) {
+	list_for_each_entry_rcu(wb, &bdi->wb_ctx[0]->wb_list, bdi_node) {
 		if (!wb_tryget(wb))
 			continue;
 
@@ -103,7 +104,7 @@ static void bdi_collect_stats(struct backing_dev_info *bdi,
 static void bdi_collect_stats(struct backing_dev_info *bdi,
 			      struct wb_stats *stats)
 {
-	collect_wb_stats(stats, &bdi->wb);
+	collect_wb_stats(stats, &bdi->wb_ctx[0]->wb);
 }
 #endif
 
@@ -149,7 +150,7 @@ static int bdi_debug_stats_show(struct seq_file *m, void *v)
 		   stats.nr_io,
 		   stats.nr_more_io,
 		   stats.nr_dirty_time,
-		   !list_empty(&bdi->bdi_list), bdi->wb.state);
+		   !list_empty(&bdi->bdi_list), bdi->wb_ctx[0]->wb.state);
 
 	return 0;
 }
@@ -193,14 +194,14 @@ static void wb_stats_show(struct seq_file *m, struct bdi_writeback *wb,
 static int cgwb_debug_stats_show(struct seq_file *m, void *v)
 {
 	struct backing_dev_info *bdi = m->private;
+	struct bdi_writeback *wb;
 	unsigned long background_thresh;
 	unsigned long dirty_thresh;
-	struct bdi_writeback *wb;
 
 	global_dirty_limits(&background_thresh, &dirty_thresh);
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(wb, &bdi->wb_list, bdi_node) {
+	list_for_each_entry_rcu(wb, &bdi->wb_ctx[0]->wb_list, bdi_node) {
 		struct wb_stats stats = { .dirty_thresh = dirty_thresh };
 
 		if (!wb_tryget(wb))
@@ -520,6 +521,7 @@ static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
 	memset(wb, 0, sizeof(*wb));
 
 	wb->bdi = bdi;
+	wb->bdi_wb_ctx = bdi->wb_ctx[0];
 	wb->last_old_flush = jiffies;
 	INIT_LIST_HEAD(&wb->b_dirty);
 	INIT_LIST_HEAD(&wb->b_io);
@@ -643,11 +645,12 @@ static void cgwb_release(struct percpu_ref *refcnt)
 	queue_work(cgwb_release_wq, &wb->release_work);
 }
 
-static void cgwb_kill(struct bdi_writeback *wb)
+static void cgwb_kill(struct bdi_writeback *wb,
+		      struct bdi_writeback_ctx *bdi_wb_ctx)
 {
 	lockdep_assert_held(&cgwb_lock);
 
-	WARN_ON(!radix_tree_delete(&wb->bdi->cgwb_tree, wb->memcg_css->id));
+	WARN_ON(!radix_tree_delete(&bdi_wb_ctx->cgwb_tree, wb->memcg_css->id));
 	list_del(&wb->memcg_node);
 	list_del(&wb->blkcg_node);
 	list_add(&wb->offline_node, &offline_cgwbs);
@@ -662,6 +665,7 @@ static void cgwb_remove_from_bdi_list(struct bdi_writeback *wb)
 }
 
 static int cgwb_create(struct backing_dev_info *bdi,
+		       struct bdi_writeback_ctx *bdi_wb_ctx,
 		       struct cgroup_subsys_state *memcg_css, gfp_t gfp)
 {
 	struct mem_cgroup *memcg;
@@ -678,9 +682,9 @@ static int cgwb_create(struct backing_dev_info *bdi,
 
 	/* look up again under lock and discard on blkcg mismatch */
 	spin_lock_irqsave(&cgwb_lock, flags);
-	wb = radix_tree_lookup(&bdi->cgwb_tree, memcg_css->id);
+	wb = radix_tree_lookup(&bdi_wb_ctx->cgwb_tree, memcg_css->id);
 	if (wb && wb->blkcg_css != blkcg_css) {
-		cgwb_kill(wb);
+		cgwb_kill(wb, bdi_wb_ctx);
 		wb = NULL;
 	}
 	spin_unlock_irqrestore(&cgwb_lock, flags);
@@ -721,12 +725,13 @@ static int cgwb_create(struct backing_dev_info *bdi,
 	 */
 	ret = -ENODEV;
 	spin_lock_irqsave(&cgwb_lock, flags);
-	if (test_bit(WB_registered, &bdi->wb.state) &&
+	if (test_bit(WB_registered, &bdi_wb_ctx->wb.state) &&
 	    blkcg_cgwb_list->next && memcg_cgwb_list->next) {
 		/* we might have raced another instance of this function */
-		ret = radix_tree_insert(&bdi->cgwb_tree, memcg_css->id, wb);
+		ret = radix_tree_insert(&bdi_wb_ctx->cgwb_tree,
+					memcg_css->id, wb);
 		if (!ret) {
-			list_add_tail_rcu(&wb->bdi_node, &bdi->wb_list);
+			list_add_tail_rcu(&wb->bdi_node, &bdi_wb_ctx->wb_list);
 			list_add(&wb->memcg_node, memcg_cgwb_list);
 			list_add(&wb->blkcg_node, blkcg_cgwb_list);
 			blkcg_pin_online(blkcg_css);
@@ -779,16 +784,16 @@ static int cgwb_create(struct backing_dev_info *bdi,
  * each lookup.  On mismatch, the existing wb is discarded and a new one is
  * created.
  */
-struct bdi_writeback *wb_get_lookup(struct backing_dev_info *bdi,
+struct bdi_writeback *wb_get_lookup(struct bdi_writeback_ctx *bdi_wb_ctx,
 				    struct cgroup_subsys_state *memcg_css)
 {
 	struct bdi_writeback *wb;
 
 	if (!memcg_css->parent)
-		return &bdi->wb;
+		return &bdi_wb_ctx->wb;
 
 	rcu_read_lock();
-	wb = radix_tree_lookup(&bdi->cgwb_tree, memcg_css->id);
+	wb = radix_tree_lookup(&bdi_wb_ctx->cgwb_tree, memcg_css->id);
 	if (wb) {
 		struct cgroup_subsys_state *blkcg_css;
 
@@ -813,6 +818,7 @@ struct bdi_writeback *wb_get_lookup(struct backing_dev_info *bdi,
  * create one.  See wb_get_lookup() for more details.
  */
 struct bdi_writeback *wb_get_create(struct backing_dev_info *bdi,
+				    struct bdi_writeback_ctx *bdi_wb_ctx,
 				    struct cgroup_subsys_state *memcg_css,
 				    gfp_t gfp)
 {
@@ -821,8 +827,8 @@ struct bdi_writeback *wb_get_create(struct backing_dev_info *bdi,
 	might_alloc(gfp);
 
 	do {
-		wb = wb_get_lookup(bdi, memcg_css);
-	} while (!wb && !cgwb_create(bdi, memcg_css, gfp));
+		wb = wb_get_lookup(bdi_wb_ctx, memcg_css);
+	} while (!wb && !cgwb_create(bdi, bdi_wb_ctx, memcg_css, gfp));
 
 	return wb;
 }
@@ -830,36 +836,40 @@ struct bdi_writeback *wb_get_create(struct backing_dev_info *bdi,
 static int cgwb_bdi_init(struct backing_dev_info *bdi)
 {
 	int ret;
+	struct bdi_writeback_ctx *bdi_wb_ctx = bdi->wb_ctx[0];
 
-	INIT_RADIX_TREE(&bdi->cgwb_tree, GFP_ATOMIC);
+	INIT_RADIX_TREE(&bdi_wb_ctx->cgwb_tree, GFP_ATOMIC);
 	mutex_init(&bdi->cgwb_release_mutex);
-	init_rwsem(&bdi->wb_switch_rwsem);
+	init_rwsem(&bdi_wb_ctx->wb_switch_rwsem);
 
-	ret = wb_init(&bdi->wb, bdi, GFP_KERNEL);
+	ret = wb_init(&bdi_wb_ctx->wb, bdi, GFP_KERNEL);
 	if (!ret) {
-		bdi->wb.memcg_css = &root_mem_cgroup->css;
-		bdi->wb.blkcg_css = blkcg_root_css;
+		bdi_wb_ctx->wb.memcg_css = &root_mem_cgroup->css;
+		bdi_wb_ctx->wb.blkcg_css = blkcg_root_css;
 	}
 	return ret;
 }
 
-static void cgwb_bdi_unregister(struct backing_dev_info *bdi)
+/* callers should create a loop and pass bdi_wb_ctx */
+static void cgwb_bdi_unregister(struct backing_dev_info *bdi,
+	struct bdi_writeback_ctx *bdi_wb_ctx)
 {
 	struct radix_tree_iter iter;
 	void **slot;
 	struct bdi_writeback *wb;
 
-	WARN_ON(test_bit(WB_registered, &bdi->wb.state));
+	WARN_ON(test_bit(WB_registered, &bdi_wb_ctx->wb.state));
 
 	spin_lock_irq(&cgwb_lock);
-	radix_tree_for_each_slot(slot, &bdi->cgwb_tree, &iter, 0)
-		cgwb_kill(*slot);
+	radix_tree_for_each_slot(slot, &bdi_wb_ctx->cgwb_tree, &iter, 0)
+		cgwb_kill(*slot, bdi_wb_ctx);
 	spin_unlock_irq(&cgwb_lock);
 
 	mutex_lock(&bdi->cgwb_release_mutex);
 	spin_lock_irq(&cgwb_lock);
-	while (!list_empty(&bdi->wb_list)) {
-		wb = list_first_entry(&bdi->wb_list, struct bdi_writeback,
+	while (!list_empty(&bdi_wb_ctx->wb_list)) {
+		wb = list_first_entry(&bdi_wb_ctx->wb_list,
+				      struct bdi_writeback,
 				      bdi_node);
 		spin_unlock_irq(&cgwb_lock);
 		wb_shutdown(wb);
@@ -930,7 +940,7 @@ void wb_memcg_offline(struct mem_cgroup *memcg)
 
 	spin_lock_irq(&cgwb_lock);
 	list_for_each_entry_safe(wb, next, memcg_cgwb_list, memcg_node)
-		cgwb_kill(wb);
+		cgwb_kill(wb, wb->bdi_wb_ctx);
 	memcg_cgwb_list->next = NULL;	/* prevent new wb's */
 	spin_unlock_irq(&cgwb_lock);
 
@@ -950,15 +960,16 @@ void wb_blkcg_offline(struct cgroup_subsys_state *css)
 
 	spin_lock_irq(&cgwb_lock);
 	list_for_each_entry_safe(wb, next, list, blkcg_node)
-		cgwb_kill(wb);
+		cgwb_kill(wb, wb->bdi_wb_ctx);
 	list->next = NULL;	/* prevent new wb's */
 	spin_unlock_irq(&cgwb_lock);
 }
 
-static void cgwb_bdi_register(struct backing_dev_info *bdi)
+static void cgwb_bdi_register(struct backing_dev_info *bdi,
+		struct bdi_writeback_ctx *bdi_wb_ctx)
 {
 	spin_lock_irq(&cgwb_lock);
-	list_add_tail_rcu(&bdi->wb.bdi_node, &bdi->wb_list);
+	list_add_tail_rcu(&bdi_wb_ctx->wb.bdi_node, &bdi_wb_ctx->wb_list);
 	spin_unlock_irq(&cgwb_lock);
 }
 
@@ -981,14 +992,18 @@ subsys_initcall(cgwb_init);
 
 static int cgwb_bdi_init(struct backing_dev_info *bdi)
 {
-	return wb_init(&bdi->wb, bdi, GFP_KERNEL);
+	return wb_init(&bdi->wb_ctx[0]->wb, bdi, GFP_KERNEL);
 }
 
-static void cgwb_bdi_unregister(struct backing_dev_info *bdi) { }
+static void cgwb_bdi_unregister(struct backing_dev_info *bdi,
+		struct bdi_writeback_ctx *bdi_wb_ctx)
+{ }
 
-static void cgwb_bdi_register(struct backing_dev_info *bdi)
+/* callers should create a loop and pass bdi_wb_ctx */
+static void cgwb_bdi_register(struct backing_dev_info *bdi,
+		struct bdi_writeback_ctx *bdi_wb_ctx)
 {
-	list_add_tail_rcu(&bdi->wb.bdi_node, &bdi->wb_list);
+	list_add_tail_rcu(&bdi_wb_ctx->wb.bdi_node, &bdi_wb_ctx->wb_list);
 }
 
 static void cgwb_remove_from_bdi_list(struct bdi_writeback *wb)
@@ -1006,9 +1021,15 @@ int bdi_init(struct backing_dev_info *bdi)
 	bdi->min_ratio = 0;
 	bdi->max_ratio = 100 * BDI_RATIO_SCALE;
 	bdi->max_prop_frac = FPROP_FRAC_BASE;
+	bdi->nr_wb_ctx = 1;
+	bdi->wb_ctx = kcalloc(bdi->nr_wb_ctx,
+				  sizeof(struct bdi_writeback_ctx *),
+				  GFP_KERNEL);
 	INIT_LIST_HEAD(&bdi->bdi_list);
-	INIT_LIST_HEAD(&bdi->wb_list);
-	init_waitqueue_head(&bdi->wb_waitq);
+	bdi->wb_ctx[0] = (struct bdi_writeback_ctx *)
+			kzalloc(sizeof(struct bdi_writeback_ctx), GFP_KERNEL);
+	INIT_LIST_HEAD(&bdi->wb_ctx[0]->wb_list);
+	init_waitqueue_head(&bdi->wb_ctx[0]->wb_waitq);
 	bdi->last_bdp_sleep = jiffies;
 
 	return cgwb_bdi_init(bdi);
@@ -1023,6 +1044,8 @@ struct backing_dev_info *bdi_alloc(int node_id)
 		return NULL;
 
 	if (bdi_init(bdi)) {
+		kfree(bdi->wb_ctx[0]);
+		kfree(bdi->wb_ctx);
 		kfree(bdi);
 		return NULL;
 	}
@@ -1095,11 +1118,11 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
 	if (IS_ERR(dev))
 		return PTR_ERR(dev);
 
-	cgwb_bdi_register(bdi);
+	cgwb_bdi_register(bdi, bdi->wb_ctx[0]);
+	set_bit(WB_registered, &bdi->wb_ctx[0]->wb.state);
 	bdi->dev = dev;
 
 	bdi_debug_register(bdi, dev_name(dev));
-	set_bit(WB_registered, &bdi->wb.state);
 
 	spin_lock_bh(&bdi_lock);
 
@@ -1155,8 +1178,8 @@ void bdi_unregister(struct backing_dev_info *bdi)
 
 	/* make sure nobody finds us on the bdi_list anymore */
 	bdi_remove_from_list(bdi);
-	wb_shutdown(&bdi->wb);
-	cgwb_bdi_unregister(bdi);
+	wb_shutdown(&bdi->wb_ctx[0]->wb);
+	cgwb_bdi_unregister(bdi, bdi->wb_ctx[0]);
 
 	/*
 	 * If this BDI's min ratio has been set, use bdi_set_min_ratio() to
@@ -1183,9 +1206,11 @@ static void release_bdi(struct kref *ref)
 	struct backing_dev_info *bdi =
 			container_of(ref, struct backing_dev_info, refcnt);
 
-	WARN_ON_ONCE(test_bit(WB_registered, &bdi->wb.state));
 	WARN_ON_ONCE(bdi->dev);
-	wb_exit(&bdi->wb);
+	WARN_ON_ONCE(test_bit(WB_registered, &bdi->wb_ctx[0]->wb.state));
+	wb_exit(&bdi->wb_ctx[0]->wb);
+	kfree(bdi->wb_ctx[0]);
+	kfree(bdi->wb_ctx);
 	kfree(bdi);
 }
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 3e248d1c3969..6f283a777da6 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2048,6 +2048,7 @@ int balance_dirty_pages_ratelimited_flags(struct address_space *mapping,
 {
 	struct inode *inode = mapping->host;
 	struct backing_dev_info *bdi = inode_to_bdi(inode);
+	struct bdi_writeback_ctx *bdi_wb_ctx = fetch_bdi_writeback_ctx(inode);
 	struct bdi_writeback *wb = NULL;
 	int ratelimit;
 	int ret = 0;
@@ -2057,9 +2058,9 @@ int balance_dirty_pages_ratelimited_flags(struct address_space *mapping,
 		return ret;
 
 	if (inode_cgwb_enabled(inode))
-		wb = wb_get_create_current(bdi, GFP_KERNEL);
+		wb = wb_get_create_current(bdi, bdi_wb_ctx, GFP_KERNEL);
 	if (!wb)
-		wb = &bdi->wb;
+		wb = &bdi_wb_ctx->wb;
 
 	ratelimit = current->nr_dirtied_pause;
 	if (wb->dirty_exceeded)
-- 
2.25.1


