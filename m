Return-Path: <linux-fsdevel+bounces-34378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8007F9C4D66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 04:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C2D1B2BF7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 03:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D527F209F3E;
	Tue, 12 Nov 2024 03:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C1v6cZ6g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4580220820C;
	Tue, 12 Nov 2024 03:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731382557; cv=none; b=FXHz+ZfvQsJtTW9swr+hdFzaxVLPFZ7FB0FnOWyoh+cTtDFaEMu1BPKpzFSzcDl+CcgxfuPdZXModShSholsOg2i1javWPYfFaWi2uAJnp0oRz1QhmjOIDR9X+XpyL3qnSI9v0bm2lvZtTjEtiUbTZzlr4bJ4C4KgJN5mEB8XAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731382557; c=relaxed/simple;
	bh=zHmwQulg1MvbJYGzS449ik058moQ+ZYOiWbt3WPw6ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TurjNmKu6MSmmOVn8CIPwnSzj7ZTTdVYrVBdLBUvmgDTaCcv2uuDnMuLb/gxTDVF3N2qxwaxGpsuA2hqZzj9K4uDBCSuQISu7HoB0fH1BsCamLE+bcDKghjOslOiykaKB2j7l8GG1XV1DMbiZF3hrnKFNJIMy/O+nPJB0IqxLsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C1v6cZ6g; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731382553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bCticokvXt7/tOdCxkHfyP03KxKjjn7PUqvu3AUUC1A=;
	b=C1v6cZ6gwawECS1GePw3eZYcphj5A24LO4Ps/OcfCCXoRbqGRjtbmM5XjOwhm5NYqyuzOh
	9shW4ucLLrICIW0BHPJA3ryk2AtARRzs508XC/gfdhZPT8QryOZRhA6eZhSpxWUtxfuvFD
	hYBTD8VjdbfpHTY1Rj0cV7ai5PiaA0Q=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	brauner@kernel.org,
	sforshee@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: [PATCH 3/3] bcachefs: Option changes now get propagated to reflinked data
Date: Mon, 11 Nov 2024 22:35:35 -0500
Message-ID: <20241112033539.105989-4-kent.overstreet@linux.dev>
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

Now that bch2_move_get_io_opts() re-propagates changed inode io options
to bch_extent_rebalance, we can properly suport changing IO path options
for reflinked data.

Changing a per-file IO path option, either via the xattr interface or
via the BCHFS_IOC_REINHERIT_ATTRS ioctl, will now trigger a scan (the
inode number is marked as needing a scan, via
bch2_set_rebalance_needs_scan()), and rebalance will use
bch2_move_data(), which will walk the inode number and pick up the new
options.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/move.c | 51 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/fs/bcachefs/move.c b/fs/bcachefs/move.c
index a6b503278519..27f885cf998a 100644
--- a/fs/bcachefs/move.c
+++ b/fs/bcachefs/move.c
@@ -22,6 +22,7 @@
 #include "keylist.h"
 #include "move.h"
 #include "rebalance.h"
+#include "reflink.h"
 #include "replicas.h"
 #include "snapshot.h"
 #include "super-io.h"
@@ -389,6 +390,7 @@ int bch2_move_extent(struct moving_context *ctxt,
 
 static struct bch_io_opts *bch2_move_get_io_opts(struct btree_trans *trans,
 			  struct per_snapshot_io_opts *io_opts,
+			  struct bpos extent_pos, /* extent_iter, extent_k may be in reflink btree */
 			  struct btree_iter *extent_iter,
 			  struct bkey_s_c extent_k)
 {
@@ -400,12 +402,12 @@ static struct bch_io_opts *bch2_move_get_io_opts(struct btree_trans *trans,
 	if (extent_k.k->type == KEY_TYPE_reflink_v)
 		goto out;
 
-	if (io_opts->cur_inum != extent_k.k->p.inode) {
+	if (io_opts->cur_inum != extent_pos.inode) {
 		io_opts->d.nr = 0;
 
-		ret = for_each_btree_key(trans, iter, BTREE_ID_inodes, POS(0, extent_k.k->p.inode),
+		ret = for_each_btree_key(trans, iter, BTREE_ID_inodes, POS(0, extent_pos.inode),
 					 BTREE_ITER_all_snapshots, k, ({
-			if (k.k->p.offset != extent_k.k->p.inode)
+			if (k.k->p.offset != extent_pos.inode)
 				break;
 
 			if (!bkey_is_inode(k.k))
@@ -419,7 +421,7 @@ static struct bch_io_opts *bch2_move_get_io_opts(struct btree_trans *trans,
 
 			darray_push(&io_opts->d, e);
 		}));
-		io_opts->cur_inum = extent_k.k->p.inode;
+		io_opts->cur_inum = extent_pos.inode;
 	}
 
 	ret = ret ?: trans_was_restarted(trans, restart_count);
@@ -525,9 +527,15 @@ static int bch2_move_data_btree(struct moving_context *ctxt,
 	struct per_snapshot_io_opts snapshot_io_opts;
 	struct bch_io_opts *io_opts;
 	struct bkey_buf sk;
-	struct btree_iter iter;
+	struct btree_iter iter, reflink_iter = {};
 	struct bkey_s_c k;
 	struct data_update_opts data_opts;
+	/*
+	 * If we're moving a single file, also process reflinked data it points
+	 * to (this includes propagating changed io_opts from the inode to the
+	 * extent):
+	 */
+	bool walk_indirect = start.inode == end.inode;
 	int ret = 0, ret2;
 
 	per_snapshot_io_opts_init(&snapshot_io_opts, c);
@@ -547,6 +555,8 @@ static int bch2_move_data_btree(struct moving_context *ctxt,
 		bch2_ratelimit_reset(ctxt->rate);
 
 	while (!bch2_move_ratelimit(ctxt)) {
+		struct btree_iter *extent_iter = &iter;
+
 		bch2_trans_begin(trans);
 
 		k = bch2_btree_iter_peek(&iter);
@@ -565,10 +575,36 @@ static int bch2_move_data_btree(struct moving_context *ctxt,
 		if (ctxt->stats)
 			ctxt->stats->pos = BBPOS(iter.btree_id, iter.pos);
 
+		if (walk_indirect &&
+		    k.k->type == KEY_TYPE_reflink_p &&
+		    REFLINK_P_MAY_UPDATE_OPTIONS(bkey_s_c_to_reflink_p(k).v)) {
+			struct bkey_s_c_reflink_p p = bkey_s_c_to_reflink_p(k);
+			s64 offset_into_extent	= iter.pos.offset - bkey_start_offset(k.k);
+
+			bch2_trans_iter_exit(trans, &reflink_iter);
+			k = bch2_lookup_indirect_extent(trans, &reflink_iter, &offset_into_extent, p, true, 0);
+			ret = bkey_err(k);
+			if (bch2_err_matches(ret, BCH_ERR_transaction_restart))
+				continue;
+			if (ret)
+				break;
+
+			if (bkey_deleted(k.k))
+				goto next_nondata;
+
+			/*
+			 * XXX: reflink pointers may point to multiple indirect
+			 * extents, so don't advance past the entire reflink
+			 * pointer - need to fixup iter->k
+			 */
+			extent_iter = &reflink_iter;
+		}
+
 		if (!bkey_extent_is_direct_data(k.k))
 			goto next_nondata;
 
-		io_opts = bch2_move_get_io_opts(trans, &snapshot_io_opts, &iter, k);
+		io_opts = bch2_move_get_io_opts(trans, &snapshot_io_opts,
+						iter.pos, extent_iter, k);
 		ret = PTR_ERR_OR_ZERO(io_opts);
 		if (ret)
 			continue;
@@ -584,7 +620,7 @@ static int bch2_move_data_btree(struct moving_context *ctxt,
 		bch2_bkey_buf_reassemble(&sk, c, k);
 		k = bkey_i_to_s_c(sk.k);
 
-		ret2 = bch2_move_extent(ctxt, NULL, &iter, k, *io_opts, data_opts);
+		ret2 = bch2_move_extent(ctxt, NULL, extent_iter, k, *io_opts, data_opts);
 		if (ret2) {
 			if (bch2_err_matches(ret2, BCH_ERR_transaction_restart))
 				continue;
@@ -605,6 +641,7 @@ static int bch2_move_data_btree(struct moving_context *ctxt,
 		bch2_btree_iter_advance(&iter);
 	}
 
+	bch2_trans_iter_exit(trans, &reflink_iter);
 	bch2_trans_iter_exit(trans, &iter);
 	bch2_bkey_buf_exit(&sk, c);
 	per_snapshot_io_opts_exit(&snapshot_io_opts);
-- 
2.45.2


