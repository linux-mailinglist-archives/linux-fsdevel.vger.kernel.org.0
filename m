Return-Path: <linux-fsdevel+bounces-63887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9CFBD1490
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 04:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76AA64EBE07
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 02:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC84E2F1FF3;
	Mon, 13 Oct 2025 02:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IGISrT4A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B8A23958D;
	Mon, 13 Oct 2025 02:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760324336; cv=none; b=IAdSVJTPZw7dLirxFJ18wos33T4k+9PKbfwH4+SkIi1qB3hQNEswHvAUQHw1+Y6a3/3DJjWPBOl7oQaID/a7Gz+ipOoDtn6ZnKuca0WF8nRcHZXluI/rj25tGcvjOeqFKO+plYbCnm6q7svtFBKAbPSCdMeOjZwGANtDWsWER+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760324336; c=relaxed/simple;
	bh=rDogdbUsAOUNdSL+zaXtWw/5L0MyFzOYx9t4qV+OFu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWUQbCTFLJNGya4+DMADbosGF7bd7vo7g0rLsxixAV5MDEl/0YmyDuct703gbLMYTISSIgDxhqGPux/wLd8N9fyWDThCQzIGydbl4VDlfuz33ITZRLd50jspzC9Xs6JihuDEWIAOlB4cEkeupHKCN2GCSEZFDeJ+2icM2EK3/Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IGISrT4A; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Z4Pvwj709tUIujzcrgBwlwYYOtJwMTZtthARYMcLmnU=; b=IGISrT4A0zRp9+72rVC63vG+be
	MeouiH2AEc+hK7VS+eL1rgjzwyHPvzKg4hX/NWwh6A8jTl/bqkfGVgAywt5EKWplmYrMYmzbSYOhQ
	rbt2127+Op8UfselRfLJauGl3NMOwkPdvohF3jws5kPXlzjAxqy06JT2PkQhSmATn5ZOy4U8EAvu/
	DJFH+eQvhZ8geZEyeDO10vAxVXO2XELnDebigYpYzwYF/viNaVIPhk43fsHoXpKP6p2Zsx8iPT6Pn
	y0HQEISCdiFCziTkwVsQTfBW9DTOT6qKRyBMbUAa12/U4J94pmOhlG8Hqq4v64CjUC4iC33ck1vS7
	te4NMnvQ==;
Received: from [220.85.59.196] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v88lv-0000000C8D8-0VSF;
	Mon, 13 Oct 2025 02:58:51 +0000
From: Christoph Hellwig <hch@lst.de>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jan Kara <jack@suse.cz>,
	linux-block@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net,
	ocfs2-devel@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 05/10] btrfs: push struct writeback_control into start_delalloc_inodes
Date: Mon, 13 Oct 2025 11:58:00 +0900
Message-ID: <20251013025808.4111128-6-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251013025808.4111128-1-hch@lst.de>
References: <20251013025808.4111128-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

In preparation for changing the filemap_fdatawrite_wbc API to not expose
the writeback_control to the callers, push the wbc declaration next to
the filemap_fdatawrite_wbc call and just pass thr nr_to_write value to
start_delalloc_inodes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 51 ++++++++++++++++++++----------------------------
 1 file changed, 21 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9edb78fc57fc..b97d6c1f7772 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8709,15 +8709,13 @@ static struct btrfs_delalloc_work *btrfs_alloc_delalloc_work(struct inode *inode
  * some fairly slow code that needs optimization. This walks the list
  * of all the inodes with pending delalloc and forces them to disk.
  */
-static int start_delalloc_inodes(struct btrfs_root *root,
-				 struct writeback_control *wbc, bool snapshot,
-				 bool in_reclaim_context)
+static int start_delalloc_inodes(struct btrfs_root *root, long *nr_to_write,
+				 bool snapshot, bool in_reclaim_context)
 {
 	struct btrfs_delalloc_work *work, *next;
 	LIST_HEAD(works);
 	LIST_HEAD(splice);
 	int ret = 0;
-	bool full_flush = wbc->nr_to_write == LONG_MAX;
 
 	mutex_lock(&root->delalloc_mutex);
 	spin_lock(&root->delalloc_lock);
@@ -8743,7 +8741,7 @@ static int start_delalloc_inodes(struct btrfs_root *root,
 
 		if (snapshot)
 			set_bit(BTRFS_INODE_SNAPSHOT_FLUSH, &inode->runtime_flags);
-		if (full_flush) {
+		if (nr_to_write == NULL) {
 			work = btrfs_alloc_delalloc_work(tmp_inode);
 			if (!work) {
 				iput(tmp_inode);
@@ -8754,9 +8752,20 @@ static int start_delalloc_inodes(struct btrfs_root *root,
 			btrfs_queue_work(root->fs_info->flush_workers,
 					 &work->work);
 		} else {
-			ret = filemap_fdatawrite_wbc(tmp_inode->i_mapping, wbc);
+			struct writeback_control wbc = {
+				.nr_to_write = *nr_to_write,
+				.sync_mode = WB_SYNC_NONE,
+				.range_start = 0,
+				.range_end = LLONG_MAX,
+			};
+
+			ret = filemap_fdatawrite_wbc(tmp_inode->i_mapping,
+					&wbc);
 			btrfs_add_delayed_iput(inode);
-			if (ret || wbc->nr_to_write <= 0)
+
+			if (*nr_to_write != LONG_MAX)
+				*nr_to_write = wbc.nr_to_write;
+			if (ret || *nr_to_write <= 0)
 				goto out;
 		}
 		cond_resched();
@@ -8782,29 +8791,17 @@ static int start_delalloc_inodes(struct btrfs_root *root,
 
 int btrfs_start_delalloc_snapshot(struct btrfs_root *root, bool in_reclaim_context)
 {
-	struct writeback_control wbc = {
-		.nr_to_write = LONG_MAX,
-		.sync_mode = WB_SYNC_NONE,
-		.range_start = 0,
-		.range_end = LLONG_MAX,
-	};
 	struct btrfs_fs_info *fs_info = root->fs_info;
 
 	if (BTRFS_FS_ERROR(fs_info))
 		return -EROFS;
-
-	return start_delalloc_inodes(root, &wbc, true, in_reclaim_context);
+	return start_delalloc_inodes(root, NULL, true, in_reclaim_context);
 }
 
 int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
 			       bool in_reclaim_context)
 {
-	struct writeback_control wbc = {
-		.nr_to_write = nr,
-		.sync_mode = WB_SYNC_NONE,
-		.range_start = 0,
-		.range_end = LLONG_MAX,
-	};
+	long *nr_to_write = nr == LONG_MAX ? NULL : &nr;
 	struct btrfs_root *root;
 	LIST_HEAD(splice);
 	int ret;
@@ -8816,13 +8813,6 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
 	spin_lock(&fs_info->delalloc_root_lock);
 	list_splice_init(&fs_info->delalloc_roots, &splice);
 	while (!list_empty(&splice)) {
-		/*
-		 * Reset nr_to_write here so we know that we're doing a full
-		 * flush.
-		 */
-		if (nr == LONG_MAX)
-			wbc.nr_to_write = LONG_MAX;
-
 		root = list_first_entry(&splice, struct btrfs_root,
 					delalloc_root);
 		root = btrfs_grab_root(root);
@@ -8831,9 +8821,10 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
 			       &fs_info->delalloc_roots);
 		spin_unlock(&fs_info->delalloc_root_lock);
 
-		ret = start_delalloc_inodes(root, &wbc, false, in_reclaim_context);
+		ret = start_delalloc_inodes(root, nr_to_write, false,
+				in_reclaim_context);
 		btrfs_put_root(root);
-		if (ret < 0 || wbc.nr_to_write <= 0)
+		if (ret < 0 || nr <= 0)
 			goto out;
 		spin_lock(&fs_info->delalloc_root_lock);
 	}
-- 
2.47.3


