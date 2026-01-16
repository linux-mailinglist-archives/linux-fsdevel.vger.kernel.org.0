Return-Path: <linux-fsdevel+bounces-74103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E42C9D2F698
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 11:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18118310DC47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 10:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3B535EDA5;
	Fri, 16 Jan 2026 10:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jjvE2GKY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD5935C1B3
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768558391; cv=none; b=llCyYlPN6AUBXP/7nZJhraYcugPemrJiqbClMH6BUO034ZTsCLAebQ6lu/NEpEWcDTkntA4U0CZoGR9nmfNuGoilDH6bb7AEjNe5sdjiF1TDMcXb49rGBXqFbzxXdwllvHHLUFqKUge6q7UN9EmcAk0mHQOSWaMy5dB5sVq2SYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768558391; c=relaxed/simple;
	bh=KU18nXwBAwAR0RrTK8crHuV+XPkuPEXd4LZk2xzsVjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=GnD5DNVqzPP5uXnGITCiezoum3Ar7x7Xdt0wNwnWGFU0Jc5woS96XIiVnKd/KQZkqApy/tqMFzffgBuvg1fZiI1XE97yGX39Muftusg16XkWQ2qbhip1j8oHhdpgEjLw5ZpfJXjPmjwGq6ZwP9UJV+9oV7yNP45Vu8Zibzvod/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jjvE2GKY; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260116101307epoutp03a61beba08058b6fae6b09373a84166ab~LLnvFAYI02778827788epoutp033
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 10:13:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260116101307epoutp03a61beba08058b6fae6b09373a84166ab~LLnvFAYI02778827788epoutp033
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1768558387;
	bh=XlCHSeFlA1HYaGvLiSk9R+HfjopCZ3pdVXy3ICJlSGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jjvE2GKYR75v0zIDAbIb8KOPpIvrc6NGMLn+lXoTtYfbicvYSWzoNGBa+MPNXV1Nj
	 YLCUZKBV9Wv6z3a1zJ/G4DVQkl7CyaGqEFVqZm35MIrdRI8kg153UmGZ5aiGkIsE1u
	 StL7/FdeUfapG2DKv9LLTl18DebsguBtuM7rEWTo=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260116101307epcas5p4fbee8b3aeafc6de8c006769961b34482~LLnuhh-Kx2325623256epcas5p4P;
	Fri, 16 Jan 2026 10:13:07 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.90]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4dswfB1G0Tz6B9m7; Fri, 16 Jan
	2026 10:13:06 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260116101305epcas5p497cd6d9027301853669f1c1aaffbf128~LLntHUbqu3257132571epcas5p4D;
	Fri, 16 Jan 2026 10:13:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260116101300epsmtip27dc0a597055b27d334ed909f6acc148e~LLnn5AZqB0634506345epsmtip2R;
	Fri, 16 Jan 2026 10:12:59 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com, david@fromorbit.com,
	amir73il@gmail.com, axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com,
	djwong@kernel.org, dave@stgolabs.net, cem@kernel.org, wangyufei@vivo.com
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, gost.dev@samsung.com, kundan.kumar@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com
Subject: [PATCH v3 6/6] xfs: offload writeback by AG using per-inode dirty
 bitmap and per-AG workers
Date: Fri, 16 Jan 2026 15:38:18 +0530
Message-Id: <20260116100818.7576-7-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260116100818.7576-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260116101305epcas5p497cd6d9027301853669f1c1aaffbf128
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260116101305epcas5p497cd6d9027301853669f1c1aaffbf128
References: <20260116100818.7576-1-kundan.kumar@samsung.com>
	<CGME20260116101305epcas5p497cd6d9027301853669f1c1aaffbf128@epcas5p4.samsung.com>

Offload XFS writeback to per-AG workers based on the inode dirty-AG
bitmap. Each worker scans and submits writeback only for folios
belonging to its AG.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/xfs/xfs_aops.c | 178 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 178 insertions(+)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 9d5b65922cd2..55c3154fb2b5 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -678,6 +678,180 @@ xfs_zoned_writeback_submit(
 	return 0;
 }
 
+static bool xfs_agp_match(struct xfs_inode *ip, pgoff_t index,
+			  xfs_agnumber_t agno)
+{
+	void *ent;
+	u32 v;
+	bool match = false;
+
+	ent = xa_load(&ip->i_ag_pmap, index);
+	if (ent && xa_is_value(ent)) {
+		v = xa_to_value(ent);
+		if (xfs_agp_valid(v))
+			match = (xfs_agp_agno(v) == (u32)agno);
+	}
+
+	return match;
+}
+
+static bool xfs_folio_matches_ag(struct folio *folio, xfs_agnumber_t agno)
+{
+	struct xfs_inode *ip = XFS_I(folio_mapping(folio)->host);
+
+	return xfs_agp_match(ip, folio->index, agno);
+}
+
+static int xfs_writepages_ag(struct xfs_inode *ip,
+			     struct writeback_control *wbc,
+			     xfs_agnumber_t agno)
+{
+	struct inode *inode = VFS_I(ip);
+	struct address_space *mapping = inode->i_mapping;
+	struct folio_batch *fbatch = &wbc->fbatch;
+	int ret = 0;
+	pgoff_t index, end;
+
+	wbc->range_cyclic = 0;
+
+	folio_batch_init(fbatch);
+	index = wbc->range_start >> PAGE_SHIFT;
+	end = wbc->range_end >> PAGE_SHIFT;
+
+	struct xfs_writepage_ctx wpc = {
+		.ctx = {
+			.inode = inode,
+			.wbc = wbc,
+			.ops = &xfs_writeback_ops,
+		},
+	};
+
+	while (index <= end) {
+		int i, nr;
+
+		/* get a batch of DIRTY folios starting at index */
+		nr = filemap_get_folios_tag(mapping, &index, end,
+					    PAGECACHE_TAG_DIRTY, fbatch);
+		if (!nr)
+			break;
+
+		for (i = 0; i < nr; i++) {
+			struct folio *folio = fbatch->folios[i];
+
+			/* Filter BEFORE locking */
+			if (!xfs_folio_matches_ag(folio, agno))
+				continue;
+
+			folio_lock(folio);
+
+			/*
+			 * Now it's ours: clear dirty and submit.
+			 * This prevents *this AG worker* from seeing it again
+			 * next time.
+			 */
+			if (!folio_clear_dirty_for_io(folio)) {
+				folio_unlock(folio);
+				continue;
+			}
+			xa_erase(&ip->i_ag_pmap, folio->index);
+
+			ret = iomap_writeback_folio(&wpc.ctx, folio);
+			folio_unlock(folio);
+
+			if (ret) {
+				folio_batch_release(fbatch);
+				goto out;
+			}
+		}
+
+		folio_batch_release(fbatch);
+		cond_resched();
+	}
+
+out:
+	if (wpc.ctx.wb_ctx && wpc.ctx.ops && wpc.ctx.ops->writeback_submit)
+		wpc.ctx.ops->writeback_submit(&wpc.ctx, ret);
+
+	return ret;
+}
+
+static void xfs_ag_writeback_work(struct work_struct *work)
+{
+	struct xfs_ag_wb *awb = container_of(to_delayed_work(work),
+					     struct xfs_ag_wb, ag_work);
+	struct xfs_ag_wb_task *task;
+	struct xfs_mount *mp;
+	struct inode *inode;
+	struct xfs_inode *ip;
+	int ret;
+
+	for (;;) {
+		spin_lock(&awb->lock);
+		task = list_first_entry_or_null(&awb->task_list,
+						struct xfs_ag_wb_task, list);
+		if (task)
+			list_del_init(&task->list);
+		spin_unlock(&awb->lock);
+
+		if (!task)
+			break;
+
+		ip = task->ip;
+		mp = ip->i_mount;
+		inode = VFS_I(ip);
+
+		ret = xfs_writepages_ag(ip, &task->wbc, task->agno);
+
+		/* If didn't submit everything for this AG, set its bit */
+		if (ret)
+			set_bit(task->agno, ip->i_ag_dirty_bitmap);
+
+		iput(inode); /* drop igrab */
+		mempool_free(task, mp->m_ag_task_pool);
+	}
+}
+
+static int xfs_vm_writepages_offload(struct address_space *mapping,
+				     struct writeback_control *wbc)
+{
+	struct inode *inode = mapping->host;
+	struct xfs_inode *ip = XFS_I(inode);
+	struct xfs_mount *mp = ip->i_mount;
+	struct xfs_ag_wb *awb;
+	struct xfs_ag_wb_task *task;
+	xfs_agnumber_t agno;
+
+	if (!ip->i_ag_dirty_bits)
+		return 0;
+
+	for_each_set_bit(agno, ip->i_ag_dirty_bitmap, ip->i_ag_dirty_bits) {
+		if (!test_and_clear_bit(agno, ip->i_ag_dirty_bitmap))
+			continue;
+
+		task =  mempool_alloc(mp->m_ag_task_pool, GFP_NOFS);
+		if (!task) {
+			set_bit(agno, ip->i_ag_dirty_bitmap);
+			continue;
+		}
+
+		INIT_LIST_HEAD(&task->list);
+		task->ip = ip;
+		task->agno = agno;
+		task->wbc = *wbc;
+		igrab(inode); /* worker owns inode ref */
+
+		awb = &mp->m_ag_wb[agno];
+
+		spin_lock(&awb->lock);
+		list_add_tail(&task->list, &awb->task_list);
+		spin_unlock(&awb->lock);
+
+		mod_delayed_work(mp->m_ag_wq, &awb->ag_work, 0);
+	}
+
+	return 0;
+}
+
 static const struct iomap_writeback_ops xfs_zoned_writeback_ops = {
 	.writeback_range	= xfs_zoned_writeback_range,
 	.writeback_submit	= xfs_zoned_writeback_submit,
@@ -706,6 +880,7 @@ xfs_init_ag_writeback(struct xfs_mount *mp)
 	for (agno = 0; agno < mp->m_sb.sb_agcount; agno++) {
 		struct xfs_ag_wb *awb = &mp->m_ag_wb[agno];
 
+		INIT_DELAYED_WORK(&awb->ag_work, xfs_ag_writeback_work);
 		spin_lock_init(&awb->lock);
 		INIT_LIST_HEAD(&awb->task_list);
 		awb->agno = agno;
@@ -769,6 +944,9 @@ xfs_vm_writepages(
 			xfs_open_zone_put(xc.open_zone);
 		return error;
 	} else {
+		if (wbc->sync_mode != WB_SYNC_ALL)
+			return xfs_vm_writepages_offload(mapping, wbc);
+
 		struct xfs_writepage_ctx	wpc = {
 			.ctx = {
 				.inode	= mapping->host,
-- 
2.25.1


