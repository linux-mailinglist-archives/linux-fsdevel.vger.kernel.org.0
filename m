Return-Path: <linux-fsdevel+bounces-34377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B87E9C4D5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 04:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D667F2887A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 03:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89ABD209664;
	Tue, 12 Nov 2024 03:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hLcHmJRW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE1E207A14
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 03:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731382556; cv=none; b=aTGQpnwD1ZAl2Dss4QqBFBX0au+dVU2WTJ6oQMQHXPG3sRhbCK5n/GjIWGQW0yYPz1HnjqVd0UU7Ln6lR9bhE9c848DAkqitIJtg3k+C84/SOzBph7U8zYPbxq4vFeKQwAAGT6Ph/wQGAzAatQP8gkOETF4F9xdaSskW5oOqGDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731382556; c=relaxed/simple;
	bh=Y1EPveu5naa9jj7v9WRJIz6z7etKIKOxHn8yIXiDIrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUvenKK0fG/hqn6lMYmzZZOwRv+X168Z8kmp3GdE+aC9m3hLvVa+WQ5YRsIqLGtFXV6X66Xlr9tl5qUrZz5x7FmrMEbQiNuc1P1G+dlRcpJgXubFtdOqluz3AhekSU/SvvEMPJ6TGXB4INhOAB9bSCeV5Grc46L9u5wWoy7MkZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hLcHmJRW; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731382552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l83HiOD0V7Xy4HOwqgf3Lz+8xs1QE/EPRChE+TTdVD0=;
	b=hLcHmJRWXkveqy7Wm3Vvj7FmMWhjTCsMG/0Yc6NCbjU4JSjrnz6zUYFitX7OrZTtPLlxkr
	pDG+TdAI8AAZE9NGr0alI0XwA7PoK7DssiBeeEaolzyLfcypTynAJGbxDM0Fy156EjnOhG
	KtfGjhP2oGGpkbYdlrK4jVeKRBRfkvk=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	brauner@kernel.org,
	sforshee@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: [PATCH 2/3] bcachefs: bcachefs_metadata_version_reflink_p_may_update_opts
Date: Mon, 11 Nov 2024 22:35:34 -0500
Message-ID: <20241112033539.105989-3-kent.overstreet@linux.dev>
In-Reply-To: <20241112033539.105989-1-kent.overstreet@linux.dev>
References: <20241112033539.105989-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Previously, io path option changes on a file would be picked up
automatically and applied to existing data - but not for reflinked data,
as we had no way of doing this safely. A user may have had permission to
copy (and reflink) a given file, but not write to it, and if so they
shouldn't be allowed to change e.g. nr_replicas or other options.

This uses the incompat feature mechanism in the previous patch to add a
new incompatible flag to bch_reflink_p, indicating whether a given
reflink pointer may propagate io path option changes back to the
indirect extent.

In this initial patch we're only setting it for the source extents.

We'd like to set it for the destination in a reflink copy, when the user
has write access to the source, but that requires mnt_idmap which is not
curretly plumbed up to remap_file_range.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/bcachefs_format.h |  3 ++-
 fs/bcachefs/fs-io.c           |  9 ++++++++-
 fs/bcachefs/reflink.c         | 18 +++++++++++++++---
 fs/bcachefs/reflink.h         |  3 ++-
 fs/bcachefs/reflink_format.h  |  2 ++
 5 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/fs/bcachefs/bcachefs_format.h b/fs/bcachefs/bcachefs_format.h
index 043390ce4b53..8cdf4ddf2d5c 100644
--- a/fs/bcachefs/bcachefs_format.h
+++ b/fs/bcachefs/bcachefs_format.h
@@ -677,7 +677,8 @@ struct bch_sb_field_ext {
 	x(disk_accounting_v3,		BCH_VERSION(1, 10))		\
 	x(disk_accounting_inum,		BCH_VERSION(1, 11))		\
 	x(rebalance_work_acct_fix,	BCH_VERSION(1, 12))		\
-	x(inode_has_child_snapshots,	BCH_VERSION(1, 13))
+	x(inode_has_child_snapshots,	BCH_VERSION(1, 13))		\
+	x(reflink_p_may_update_opts,	BCH_VERSION(1, 14))
 
 enum bcachefs_metadata_version {
 	bcachefs_metadata_version_min = 9,
diff --git a/fs/bcachefs/fs-io.c b/fs/bcachefs/fs-io.c
index c6fdfec51082..12a747f20f6d 100644
--- a/fs/bcachefs/fs-io.c
+++ b/fs/bcachefs/fs-io.c
@@ -877,11 +877,18 @@ loff_t bch2_remap_file_range(struct file *file_src, loff_t pos_src,
 	bch2_mark_pagecache_unallocated(src, pos_src >> 9,
 				   (pos_src + aligned_len) >> 9);
 
+	/*
+	 * XXX: we'd like to be telling bch2_remap_range() if we have
+	 * permission to write to the source file, and thus if io path option
+	 * changes should be propagated through the copy, but we need mnt_idmap
+	 * from the pathwalk, awkward
+	 */
 	ret = bch2_remap_range(c,
 			       inode_inum(dst), pos_dst >> 9,
 			       inode_inum(src), pos_src >> 9,
 			       aligned_len >> 9,
-			       pos_dst + len, &i_sectors_delta);
+			       pos_dst + len, &i_sectors_delta,
+			       false);
 	if (ret < 0)
 		goto err;
 
diff --git a/fs/bcachefs/reflink.c b/fs/bcachefs/reflink.c
index 38db5a011702..c243cd9aa63b 100644
--- a/fs/bcachefs/reflink.c
+++ b/fs/bcachefs/reflink.c
@@ -482,7 +482,8 @@ int bch2_trigger_indirect_inline_data(struct btree_trans *trans,
 
 static int bch2_make_extent_indirect(struct btree_trans *trans,
 				     struct btree_iter *extent_iter,
-				     struct bkey_i *orig)
+				     struct bkey_i *orig,
+				     bool reflink_p_may_update_opts_field)
 {
 	struct bch_fs *c = trans->c;
 	struct btree_iter reflink_iter = { NULL };
@@ -548,6 +549,9 @@ static int bch2_make_extent_indirect(struct btree_trans *trans,
 
 	SET_REFLINK_P_IDX(&r_p->v, bkey_start_offset(&r_v->k));
 
+	if (reflink_p_may_update_opts_field)
+		SET_REFLINK_P_MAY_UPDATE_OPTIONS(&r_p->v, true);
+
 	ret = bch2_trans_update(trans, extent_iter, &r_p->k_i,
 				BTREE_UPDATE_internal_snapshot_node);
 err:
@@ -578,7 +582,8 @@ s64 bch2_remap_range(struct bch_fs *c,
 		     subvol_inum dst_inum, u64 dst_offset,
 		     subvol_inum src_inum, u64 src_offset,
 		     u64 remap_sectors,
-		     u64 new_i_size, s64 *i_sectors_delta)
+		     u64 new_i_size, s64 *i_sectors_delta,
+		     bool may_change_src_io_path_opts)
 {
 	struct btree_trans *trans;
 	struct btree_iter dst_iter, src_iter;
@@ -591,6 +596,8 @@ s64 bch2_remap_range(struct bch_fs *c,
 	struct bpos src_want;
 	u64 dst_done = 0;
 	u32 dst_snapshot, src_snapshot;
+	bool reflink_p_may_update_opts_field =
+		bch2_request_incompat_feature(c, bcachefs_metadata_version_reflink_p_may_update_opts);
 	int ret = 0, ret2 = 0;
 
 	if (!bch2_write_ref_tryget(c, BCH_WRITE_REF_reflink))
@@ -672,7 +679,8 @@ s64 bch2_remap_range(struct bch_fs *c,
 			src_k = bkey_i_to_s_c(new_src.k);
 
 			ret = bch2_make_extent_indirect(trans, &src_iter,
-						new_src.k);
+						new_src.k,
+						reflink_p_may_update_opts_field);
 			if (ret)
 				continue;
 
@@ -690,6 +698,10 @@ s64 bch2_remap_range(struct bch_fs *c,
 				 bkey_start_offset(src_k.k));
 
 			SET_REFLINK_P_IDX(&dst_p->v, offset);
+
+			if (reflink_p_may_update_opts_field &&
+			    may_change_src_io_path_opts)
+				SET_REFLINK_P_MAY_UPDATE_OPTIONS(&dst_p->v, true);
 		} else {
 			BUG();
 		}
diff --git a/fs/bcachefs/reflink.h b/fs/bcachefs/reflink.h
index b61a4bdd8e82..ddeb0803af67 100644
--- a/fs/bcachefs/reflink.h
+++ b/fs/bcachefs/reflink.h
@@ -78,7 +78,8 @@ struct bkey_s_c bch2_lookup_indirect_extent(struct btree_trans *, struct btree_i
 					    bool, unsigned);
 
 s64 bch2_remap_range(struct bch_fs *, subvol_inum, u64,
-		     subvol_inum, u64, u64, u64, s64 *);
+		     subvol_inum, u64, u64, u64, s64 *,
+		     bool);
 
 int bch2_gc_reflink_done(struct bch_fs *);
 int bch2_gc_reflink_start(struct bch_fs *);
diff --git a/fs/bcachefs/reflink_format.h b/fs/bcachefs/reflink_format.h
index 53502627b2c5..92995e4f898e 100644
--- a/fs/bcachefs/reflink_format.h
+++ b/fs/bcachefs/reflink_format.h
@@ -19,6 +19,8 @@ struct bch_reflink_p {
 
 LE64_BITMASK(REFLINK_P_IDX,	struct bch_reflink_p, idx_flags,  0, 56);
 LE64_BITMASK(REFLINK_P_ERROR,	struct bch_reflink_p, idx_flags, 56, 57);
+LE64_BITMASK(REFLINK_P_MAY_UPDATE_OPTIONS,
+				struct bch_reflink_p, idx_flags, 57, 58);
 
 struct bch_reflink_v {
 	struct bch_val		v;
-- 
2.45.2


