Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED881711C0F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 03:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjEZBHU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 21:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbjEZBHT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 21:07:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB8819C;
        Thu, 25 May 2023 18:06:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFBA4647D0;
        Fri, 26 May 2023 01:06:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DEDC433EF;
        Fri, 26 May 2023 01:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685063216;
        bh=I/Xlv3lbixieitB1zxg+DOjpSlIYFhEXILuxHnXbAM0=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=BdlBXoejBrg3bIaVACnYRGWB2aYhRdfirjtQvJjsSov63NIcpl7KuK8XUFwEupdf4
         e9wVjsWog+zSr7rzXXqsq8GUHcj51vWgJ881CxxGUEXsFmSEksKbFT0hdhGs+phE2+
         0C6fqeg2Jx5oD/EYfby/viaF9jlBjcOQ/tZXHhxDec/zCioCQOTVspLLu++kirzu+V
         xCt4eIm+M1bXfflk42NBm71GLl7giGc40/zH8VSXbEUL6yLHR+RdjVBTmkNWJVC8CN
         kq5N4jnPE6Vp0IOd0ZRWgt3NJVHkLZV3NVhBAQcVnPmiOL5TLnYWBiDP0CxGTGAieI
         GJjrBmHQWcKww==
Date:   Thu, 25 May 2023 18:06:55 -0700
Subject: [PATCH 9/9] xfs: connect in-memory btrees to xfiles
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org
Message-ID: <168506061984.3733082.16963285502416228181.stgit@frogsfrogsfrogs>
In-Reply-To: <168506061839.3733082.9818919714772025609.stgit@frogsfrogsfrogs>
References: <168506061839.3733082.9818919714772025609.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Add to our stubbed-out in-memory btrees the ability to connect them with
an actual in-memory backing file (aka xfiles) and the necessary pieces
to track free space in the xfile and flush dirty xfbtree buffers on
demand, which we'll need for online repair.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_btree_mem.h |   41 ++++
 fs/xfs/scrub/bitmap.c         |   28 ++
 fs/xfs/scrub/bitmap.h         |    3 
 fs/xfs/scrub/scrub.c          |    5 
 fs/xfs/scrub/scrub.h          |    3 
 fs/xfs/scrub/trace.c          |   12 +
 fs/xfs/scrub/trace.h          |  110 ++++++++++
 fs/xfs/scrub/xfbtree.c        |  466 +++++++++++++++++++++++++++++++++++++++++
 fs/xfs/scrub/xfbtree.h        |   25 ++
 fs/xfs/scrub/xfile.c          |   83 +++++++
 fs/xfs/scrub/xfile.h          |    2 
 fs/xfs/xfs_trace.h            |    1 
 fs/xfs/xfs_trans.h            |    1 
 fs/xfs/xfs_trans_buf.c        |   42 ++++
 14 files changed, 820 insertions(+), 2 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_btree_mem.h b/fs/xfs/libxfs/xfs_btree_mem.h
index 5e3d58175596..c82d3e6d220a 100644
--- a/fs/xfs/libxfs/xfs_btree_mem.h
+++ b/fs/xfs/libxfs/xfs_btree_mem.h
@@ -8,6 +8,26 @@
 
 struct xfbtree;
 
+struct xfbtree_config {
+	/* Buffer ops for the btree root block */
+	const struct xfs_btree_ops	*btree_ops;
+
+	/* Buffer target for the xfile backing this btree. */
+	struct xfs_buftarg		*target;
+
+	/* Owner of this btree. */
+	unsigned long long		owner;
+
+	/* Btree type number */
+	xfs_btnum_t			btnum;
+
+	/* XFBTREE_CREATE_* flags */
+	unsigned int			flags;
+};
+
+/* btree has long pointers */
+#define XFBTREE_CREATE_LONG_PTRS	(1U << 0)
+
 #ifdef CONFIG_XFS_BTREE_IN_XFILE
 unsigned int xfs_btree_mem_head_nlevels(struct xfs_buf *head_bp);
 
@@ -35,6 +55,16 @@ xfs_failaddr_t xfbtree_lblock_verify(struct xfs_buf *bp, unsigned int max_recs);
 xfs_failaddr_t xfbtree_sblock_verify(struct xfs_buf *bp, unsigned int max_recs);
 unsigned long long xfbtree_buf_to_xfoff(struct xfs_btree_cur *cur,
 		struct xfs_buf *bp);
+
+int xfbtree_get_minrecs(struct xfs_btree_cur *cur, int level);
+int xfbtree_get_maxrecs(struct xfs_btree_cur *cur, int level);
+
+int xfbtree_create(struct xfs_mount *mp, const struct xfbtree_config *cfg,
+		struct xfbtree **xfbtreep);
+int xfbtree_alloc_block(struct xfs_btree_cur *cur,
+		const union xfs_btree_ptr *start, union xfs_btree_ptr *ptr,
+		int *stat);
+int xfbtree_free_block(struct xfs_btree_cur *cur, struct xfs_buf *bp);
 #else
 static inline unsigned int xfs_btree_mem_head_nlevels(struct xfs_buf *head_bp)
 {
@@ -77,11 +107,22 @@ static inline unsigned int xfbtree_bbsize(void)
 #define xfbtree_set_root			NULL
 #define xfbtree_init_ptr_from_cur		NULL
 #define xfbtree_dup_cursor			NULL
+#define xfbtree_get_minrecs			NULL
+#define xfbtree_get_maxrecs			NULL
+#define xfbtree_alloc_block			NULL
+#define xfbtree_free_block			NULL
 #define xfbtree_verify_xfileoff(cur, xfoff)	(false)
 #define xfbtree_check_block_owner(cur, block)	NULL
 #define xfbtree_owner(cur)			(0ULL)
 #define xfbtree_buf_to_xfoff(cur, bp)		(-1)
 
+static inline int
+xfbtree_create(struct xfs_mount *mp, const struct xfbtree_config *cfg,
+		struct xfbtree **xfbtreep)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_XFS_BTREE_IN_XFILE */
 
 #endif /* __XFS_BTREE_MEM_H__ */
diff --git a/fs/xfs/scrub/bitmap.c b/fs/xfs/scrub/bitmap.c
index e0c89a9a0ca0..d74f706ff33c 100644
--- a/fs/xfs/scrub/bitmap.c
+++ b/fs/xfs/scrub/bitmap.c
@@ -379,3 +379,31 @@ xbitmap_test(
 	*len = bn->bn_start - start;
 	return false;
 }
+
+/*
+ * Find the first set bit in this bitmap, clear it, and return the index of
+ * that bit in @valp.  Returns -ENODATA if no bits were set, or the usual
+ * negative errno.
+ */
+int
+xbitmap_take_first_set(
+	struct xbitmap		*bitmap,
+	uint64_t		start,
+	uint64_t		last,
+	uint64_t		*valp)
+{
+	struct xbitmap_node	*bn;
+	uint64_t		val;
+	int			error;
+
+	bn = xbitmap_tree_iter_first(&bitmap->xb_root, start, last);
+	if (!bn)
+		return -ENODATA;
+
+	val = bn->bn_start;
+	error = xbitmap_clear(bitmap, bn->bn_start, 1);
+	if (error)
+		return error;
+	*valp = val;
+	return 0;
+}
diff --git a/fs/xfs/scrub/bitmap.h b/fs/xfs/scrub/bitmap.h
index 2518e642f4d3..8159a3c4173d 100644
--- a/fs/xfs/scrub/bitmap.h
+++ b/fs/xfs/scrub/bitmap.h
@@ -32,6 +32,9 @@ int xbitmap_walk(struct xbitmap *bitmap, xbitmap_walk_fn fn,
 bool xbitmap_empty(struct xbitmap *bitmap);
 bool xbitmap_test(struct xbitmap *bitmap, uint64_t start, uint64_t *len);
 
+int xbitmap_take_first_set(struct xbitmap *bitmap, uint64_t start,
+		uint64_t last, uint64_t *valp);
+
 /* Bitmaps, but for type-checked for xfs_agblock_t */
 
 struct xagb_bitmap {
diff --git a/fs/xfs/scrub/scrub.c b/fs/xfs/scrub/scrub.c
index cf8e78c16670..e57c8e7ad48a 100644
--- a/fs/xfs/scrub/scrub.c
+++ b/fs/xfs/scrub/scrub.c
@@ -17,6 +17,7 @@
 #include "xfs_scrub.h"
 #include "xfs_btree.h"
 #include "xfs_btree_staging.h"
+#include "xfs_buf_xfile.h"
 #include "scrub/scrub.h"
 #include "scrub/common.h"
 #include "scrub/trace.h"
@@ -191,6 +192,10 @@ xchk_teardown(
 		sc->flags &= ~XCHK_HAVE_FREEZE_PROT;
 		mnt_drop_write_file(sc->file);
 	}
+	if (sc->xfile_buftarg) {
+		xfile_free_buftarg(sc->xfile_buftarg);
+		sc->xfile_buftarg = NULL;
+	}
 	if (sc->xfile) {
 		xfile_destroy(sc->xfile);
 		sc->xfile = NULL;
diff --git a/fs/xfs/scrub/scrub.h b/fs/xfs/scrub/scrub.h
index a41ba8d319b6..2f8da220c9e7 100644
--- a/fs/xfs/scrub/scrub.h
+++ b/fs/xfs/scrub/scrub.h
@@ -99,6 +99,9 @@ struct xfs_scrub {
 	/* xfile used by the scrubbers; freed at teardown. */
 	struct xfile			*xfile;
 
+	/* buffer target for the xfile; also freed at teardown. */
+	struct xfs_buftarg		*xfile_buftarg;
+
 	/* Lock flags for @ip. */
 	uint				ilock_flags;
 
diff --git a/fs/xfs/scrub/trace.c b/fs/xfs/scrub/trace.c
index 1fe5c5a9a1ba..d3164c59b0ba 100644
--- a/fs/xfs/scrub/trace.c
+++ b/fs/xfs/scrub/trace.c
@@ -12,15 +12,18 @@
 #include "xfs_mount.h"
 #include "xfs_inode.h"
 #include "xfs_btree.h"
+#include "xfs_btree_mem.h"
 #include "xfs_ag.h"
 #include "xfs_quota_defs.h"
 #include "xfs_dir2.h"
+#include "xfs_da_format.h"
 #include "scrub/scrub.h"
 #include "scrub/xfile.h"
 #include "scrub/xfarray.h"
 #include "scrub/iscan.h"
 #include "scrub/nlinks.h"
 #include "scrub/fscounters.h"
+#include "scrub/xfbtree.h"
 
 /* Figure out which block the btree cursor was pointing to. */
 static inline xfs_fsblock_t
@@ -39,6 +42,15 @@ xchk_btree_cur_fsbno(
 	return NULLFSBLOCK;
 }
 
+#ifdef CONFIG_XFS_BTREE_IN_XFILE
+static inline unsigned long
+xfbtree_ino(
+	struct xfbtree		*xfbt)
+{
+	return file_inode(xfbt->target->bt_xfile->file)->i_ino;
+}
+#endif /* CONFIG_XFS_BTREE_IN_XFILE */
+
 /*
  * We include this last to have the helpers above available for the trace
  * event implementations.
diff --git a/fs/xfs/scrub/trace.h b/fs/xfs/scrub/trace.h
index 4aefa0533a12..edc86a06da21 100644
--- a/fs/xfs/scrub/trace.h
+++ b/fs/xfs/scrub/trace.h
@@ -24,6 +24,8 @@ struct xfarray_sortinfo;
 struct xchk_iscan;
 struct xchk_nlink;
 struct xchk_fscounters;
+struct xfbtree;
+struct xfbtree_config;
 
 /*
  * ftrace's __print_symbolic requires that all enum values be wrapped in the
@@ -866,6 +868,8 @@ DEFINE_XFILE_EVENT(xfile_pwrite);
 DEFINE_XFILE_EVENT(xfile_seek_data);
 DEFINE_XFILE_EVENT(xfile_get_page);
 DEFINE_XFILE_EVENT(xfile_put_page);
+DEFINE_XFILE_EVENT(xfile_discard);
+DEFINE_XFILE_EVENT(xfile_prealloc);
 
 TRACE_EVENT(xfarray_create,
 	TP_PROTO(struct xfarray *xfa, unsigned long long required_capacity),
@@ -2023,8 +2027,114 @@ DEFINE_XREP_DQUOT_EVENT(xrep_quotacheck_dquot);
 DEFINE_SCRUB_NLINKS_DIFF_EVENT(xrep_nlinks_update_inode);
 DEFINE_SCRUB_NLINKS_DIFF_EVENT(xrep_nlinks_unfixable_inode);
 
+TRACE_EVENT(xfbtree_create,
+	TP_PROTO(struct xfs_mount *mp, const struct xfbtree_config *cfg,
+		 struct xfbtree *xfbt),
+	TP_ARGS(mp, cfg, xfbt),
+	TP_STRUCT__entry(
+		__field(xfs_btnum_t, btnum)
+		__field(unsigned int, xfbtree_flags)
+		__field(unsigned long, xfino)
+		__field(unsigned int, leaf_mxr)
+		__field(unsigned int, leaf_mnr)
+		__field(unsigned int, node_mxr)
+		__field(unsigned int, node_mnr)
+		__field(unsigned long long, owner)
+	),
+	TP_fast_assign(
+		__entry->btnum = cfg->btnum;
+		__entry->xfbtree_flags = cfg->flags;
+		__entry->xfino = xfbtree_ino(xfbt);
+		__entry->leaf_mxr = xfbt->maxrecs[0];
+		__entry->node_mxr = xfbt->maxrecs[1];
+		__entry->leaf_mnr = xfbt->minrecs[0];
+		__entry->node_mnr = xfbt->minrecs[1];
+		__entry->owner = cfg->owner;
+	),
+	TP_printk("xfino 0x%lx btnum %s owner 0x%llx leaf_mxr %u leaf_mnr %u node_mxr %u node_mnr %u",
+		  __entry->xfino,
+		  __print_symbolic(__entry->btnum, XFS_BTNUM_STRINGS),
+		  __entry->owner,
+		  __entry->leaf_mxr,
+		  __entry->leaf_mnr,
+		  __entry->node_mxr,
+		  __entry->node_mnr)
+);
+
+DECLARE_EVENT_CLASS(xfbtree_buf_class,
+	TP_PROTO(struct xfbtree *xfbt, struct xfs_buf *bp),
+	TP_ARGS(xfbt, bp),
+	TP_STRUCT__entry(
+		__field(unsigned long, xfino)
+		__field(xfs_daddr_t, bno)
+		__field(int, nblks)
+		__field(int, hold)
+		__field(int, pincount)
+		__field(unsigned, lockval)
+		__field(unsigned, flags)
+	),
+	TP_fast_assign(
+		__entry->xfino = xfbtree_ino(xfbt);
+		__entry->bno = xfs_buf_daddr(bp);
+		__entry->nblks = bp->b_length;
+		__entry->hold = atomic_read(&bp->b_hold);
+		__entry->pincount = atomic_read(&bp->b_pin_count);
+		__entry->lockval = bp->b_sema.count;
+		__entry->flags = bp->b_flags;
+	),
+	TP_printk("xfino 0x%lx daddr 0x%llx bbcount 0x%x hold %d pincount %d "
+		  "lock %d flags %s",
+		  __entry->xfino,
+		  (unsigned long long)__entry->bno,
+		  __entry->nblks,
+		  __entry->hold,
+		  __entry->pincount,
+		  __entry->lockval,
+		  __print_flags(__entry->flags, "|", XFS_BUF_FLAGS))
+)
+
+#define DEFINE_XFBTREE_BUF_EVENT(name) \
+DEFINE_EVENT(xfbtree_buf_class, name, \
+	TP_PROTO(struct xfbtree *xfbt, struct xfs_buf *bp), \
+	TP_ARGS(xfbt, bp))
+DEFINE_XFBTREE_BUF_EVENT(xfbtree_create_root_buf);
+DEFINE_XFBTREE_BUF_EVENT(xfbtree_trans_commit_buf);
+DEFINE_XFBTREE_BUF_EVENT(xfbtree_trans_cancel_buf);
+
+DECLARE_EVENT_CLASS(xfbtree_freesp_class,
+	TP_PROTO(struct xfbtree *xfbt, struct xfs_btree_cur *cur,
+		 xfs_fileoff_t fileoff),
+	TP_ARGS(xfbt, cur, fileoff),
+	TP_STRUCT__entry(
+		__field(unsigned long, xfino)
+		__field(xfs_btnum_t, btnum)
+		__field(int, nlevels)
+		__field(xfs_fileoff_t, fileoff)
+	),
+	TP_fast_assign(
+		__entry->xfino = xfbtree_ino(xfbt);
+		__entry->btnum = cur->bc_btnum;
+		__entry->nlevels = cur->bc_nlevels;
+		__entry->fileoff = fileoff;
+	),
+	TP_printk("xfino 0x%lx btree %s nlevels %d fileoff 0x%llx",
+		  __entry->xfino,
+		  __print_symbolic(__entry->btnum, XFS_BTNUM_STRINGS),
+		  __entry->nlevels,
+		  (unsigned long long)__entry->fileoff)
+)
+
+#define DEFINE_XFBTREE_FREESP_EVENT(name) \
+DEFINE_EVENT(xfbtree_freesp_class, name, \
+	TP_PROTO(struct xfbtree *xfbt, struct xfs_btree_cur *cur, \
+		 xfs_fileoff_t fileoff), \
+	TP_ARGS(xfbt, cur, fileoff))
+DEFINE_XFBTREE_FREESP_EVENT(xfbtree_alloc_block);
+DEFINE_XFBTREE_FREESP_EVENT(xfbtree_free_block);
+
 #endif /* IS_ENABLED(CONFIG_XFS_ONLINE_REPAIR) */
 
+
 #endif /* _TRACE_XFS_SCRUB_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/xfs/scrub/xfbtree.c b/fs/xfs/scrub/xfbtree.c
index 41aed95a1ee7..5cd03457091c 100644
--- a/fs/xfs/scrub/xfbtree.c
+++ b/fs/xfs/scrub/xfbtree.c
@@ -9,14 +9,19 @@
 #include "xfs_format.h"
 #include "xfs_log_format.h"
 #include "xfs_trans_resv.h"
+#include "xfs_bit.h"
 #include "xfs_mount.h"
 #include "xfs_trans.h"
+#include "xfs_buf_item.h"
 #include "xfs_btree.h"
 #include "xfs_error.h"
 #include "xfs_btree_mem.h"
 #include "xfs_ag.h"
+#include "scrub/scrub.h"
 #include "scrub/xfile.h"
 #include "scrub/xfbtree.h"
+#include "scrub/bitmap.h"
+#include "scrub/trace.h"
 
 /* btree ops functions for in-memory btrees. */
 
@@ -142,9 +147,18 @@ xfbtree_check_ptr(
 	else
 		bt_xfoff = be32_to_cpu(ptr->s);
 
-	if (!xfbtree_verify_xfileoff(cur, bt_xfoff))
+	if (!xfbtree_verify_xfileoff(cur, bt_xfoff)) {
 		fa = __this_address;
+		goto done;
+	}
 
+	/* Can't point to the head or anything before it */
+	if (bt_xfoff < XFBTREE_INIT_LEAF_BLOCK) {
+		fa = __this_address;
+		goto done;
+	}
+
+done:
 	if (fa) {
 		xfs_err(cur->bc_mp,
 "In-memory: Corrupt btree %d flags 0x%x pointer at level %d index %d fa %pS.",
@@ -350,3 +364,453 @@ xfbtree_sblock_verify(
 
 	return NULL;
 }
+
+/* Close the btree xfile and release all resources. */
+void
+xfbtree_destroy(
+	struct xfbtree		*xfbt)
+{
+	xbitmap_destroy(xfbt->freespace);
+	kfree(xfbt->freespace);
+	xfs_buftarg_drain(xfbt->target);
+	kfree(xfbt);
+}
+
+/* Compute the number of bytes available for records. */
+static inline unsigned int
+xfbtree_rec_bytes(
+	struct xfs_mount		*mp,
+	const struct xfbtree_config	*cfg)
+{
+	unsigned int			blocklen = xfo_to_b(1);
+
+	if (cfg->flags & XFBTREE_CREATE_LONG_PTRS) {
+		if (xfs_has_crc(mp))
+			return blocklen - XFS_BTREE_LBLOCK_CRC_LEN;
+
+		return blocklen - XFS_BTREE_LBLOCK_LEN;
+	}
+
+	if (xfs_has_crc(mp))
+		return blocklen - XFS_BTREE_SBLOCK_CRC_LEN;
+
+	return blocklen - XFS_BTREE_SBLOCK_LEN;
+}
+
+/* Initialize an empty leaf block as the btree root. */
+STATIC int
+xfbtree_init_leaf_block(
+	struct xfs_mount		*mp,
+	struct xfbtree			*xfbt,
+	const struct xfbtree_config	*cfg)
+{
+	struct xfs_buf			*bp;
+	xfs_daddr_t			daddr;
+	int				error;
+	unsigned int			bc_flags = 0;
+
+	if (cfg->flags & XFBTREE_CREATE_LONG_PTRS)
+		bc_flags |= XFS_BTREE_LONG_PTRS;
+
+	daddr = xfo_to_daddr(XFBTREE_INIT_LEAF_BLOCK);
+	error = xfs_buf_get(xfbt->target, daddr, xfbtree_bbsize(), &bp);
+	if (error)
+		return error;
+
+	trace_xfbtree_create_root_buf(xfbt, bp);
+
+	bp->b_ops = cfg->btree_ops->buf_ops;
+	xfs_btree_init_block_int(mp, bp->b_addr, daddr, cfg->btnum, 0, 0,
+			cfg->owner, bc_flags);
+	error = xfs_bwrite(bp);
+	xfs_buf_relse(bp);
+	if (error)
+		return error;
+
+	xfbt->xf_used++;
+	return 0;
+}
+
+/* Initialize the in-memory btree header block. */
+STATIC int
+xfbtree_init_head(
+	struct xfbtree		*xfbt)
+{
+	struct xfs_buf		*bp;
+	xfs_daddr_t		daddr;
+	int			error;
+
+	daddr = xfo_to_daddr(XFBTREE_HEAD_BLOCK);
+	error = xfs_buf_get(xfbt->target, daddr, xfbtree_bbsize(), &bp);
+	if (error)
+		return error;
+
+	xfs_btree_mem_head_init(bp, xfbt->owner, XFBTREE_INIT_LEAF_BLOCK);
+	error = xfs_bwrite(bp);
+	xfs_buf_relse(bp);
+	if (error)
+		return error;
+
+	xfbt->xf_used++;
+	return 0;
+}
+
+/* Create an xfile btree backing thing that can be used for in-memory btrees. */
+int
+xfbtree_create(
+	struct xfs_mount		*mp,
+	const struct xfbtree_config	*cfg,
+	struct xfbtree			**xfbtreep)
+{
+	struct xfbtree			*xfbt;
+	unsigned int			blocklen = xfbtree_rec_bytes(mp, cfg);
+	unsigned int			keyptr_len = cfg->btree_ops->key_len;
+	int				error;
+
+	/* Requires an xfile-backed buftarg. */
+	if (!(cfg->target->bt_flags & XFS_BUFTARG_XFILE)) {
+		ASSERT(cfg->target->bt_flags & XFS_BUFTARG_XFILE);
+		return -EINVAL;
+	}
+
+	xfbt = kzalloc(sizeof(struct xfbtree), XCHK_GFP_FLAGS);
+	if (!xfbt)
+		return -ENOMEM;
+
+	/* Assign our memory file and the free space bitmap. */
+	xfbt->target = cfg->target;
+	xfbt->freespace = kmalloc(sizeof(struct xbitmap), XCHK_GFP_FLAGS);
+	if (!xfbt->freespace) {
+		error = -ENOMEM;
+		goto err_buftarg;
+	}
+	xbitmap_init(xfbt->freespace);
+
+	/* Set up min/maxrecs for this btree. */
+	if (cfg->flags & XFBTREE_CREATE_LONG_PTRS)
+		keyptr_len += sizeof(__be64);
+	else
+		keyptr_len += sizeof(__be32);
+	xfbt->maxrecs[0] = blocklen / cfg->btree_ops->rec_len;
+	xfbt->maxrecs[1] = blocklen / keyptr_len;
+	xfbt->minrecs[0] = xfbt->maxrecs[0] / 2;
+	xfbt->minrecs[1] = xfbt->maxrecs[1] / 2;
+	xfbt->owner = cfg->owner;
+
+	/* Initialize the empty btree. */
+	error = xfbtree_init_leaf_block(mp, xfbt, cfg);
+	if (error)
+		goto err_freesp;
+
+	error = xfbtree_init_head(xfbt);
+	if (error)
+		goto err_freesp;
+
+	trace_xfbtree_create(mp, cfg, xfbt);
+
+	*xfbtreep = xfbt;
+	return 0;
+
+err_freesp:
+	xbitmap_destroy(xfbt->freespace);
+	kfree(xfbt->freespace);
+err_buftarg:
+	xfs_buftarg_drain(xfbt->target);
+	kfree(xfbt);
+	return error;
+}
+
+/* Read the in-memory btree head. */
+int
+xfbtree_head_read_buf(
+	struct xfbtree		*xfbt,
+	struct xfs_trans	*tp,
+	struct xfs_buf		**bpp)
+{
+	struct xfs_buftarg	*btp = xfbt->target;
+	struct xfs_mount	*mp = btp->bt_mount;
+	struct xfs_btree_mem_head *mhead;
+	struct xfs_buf		*bp;
+	xfs_daddr_t		daddr;
+	int			error;
+
+	daddr = xfo_to_daddr(XFBTREE_HEAD_BLOCK);
+	error = xfs_trans_read_buf(mp, tp, btp, daddr, xfbtree_bbsize(), 0,
+			&bp, &xfs_btree_mem_head_buf_ops);
+	if (error)
+		return error;
+
+	mhead = bp->b_addr;
+	if (be64_to_cpu(mhead->mh_owner) != xfbt->owner) {
+		xfs_verifier_error(bp, -EFSCORRUPTED, __this_address);
+		xfs_trans_brelse(tp, bp);
+		return -EFSCORRUPTED;
+	}
+
+	*bpp = bp;
+	return 0;
+}
+
+static inline struct xfile *xfbtree_xfile(struct xfbtree *xfbt)
+{
+	return xfbt->target->bt_xfile;
+}
+
+/* Allocate a block to our in-memory btree. */
+int
+xfbtree_alloc_block(
+	struct xfs_btree_cur		*cur,
+	const union xfs_btree_ptr	*start,
+	union xfs_btree_ptr		*new,
+	int				*stat)
+{
+	struct xfbtree			*xfbt = cur->bc_mem.xfbtree;
+	xfileoff_t			bt_xfoff;
+	loff_t				pos;
+	int				error;
+
+	ASSERT(cur->bc_flags & XFS_BTREE_IN_XFILE);
+
+	/*
+	 * Find the first free block in the free space bitmap and take it.  If
+	 * none are found, seek to end of the file.
+	 */
+	error = xbitmap_take_first_set(xfbt->freespace, 0, -1ULL, &bt_xfoff);
+	if (error == -ENODATA) {
+		bt_xfoff = xfbt->xf_used;
+		xfbt->xf_used++;
+	} else if (error) {
+		return error;
+	}
+
+	trace_xfbtree_alloc_block(xfbt, cur, bt_xfoff);
+
+	/* Fail if the block address exceeds the maximum for short pointers. */
+	if (!(cur->bc_flags & XFS_BTREE_LONG_PTRS) && bt_xfoff >= INT_MAX) {
+		*stat = 0;
+		return 0;
+	}
+
+	/* Make sure we actually can write to the block before we return it. */
+	pos = xfo_to_b(bt_xfoff);
+	error = xfile_prealloc(xfbtree_xfile(xfbt), pos, xfo_to_b(1));
+	if (error)
+		return error;
+
+	if (cur->bc_flags & XFS_BTREE_LONG_PTRS)
+		new->l = cpu_to_be64(bt_xfoff);
+	else
+		new->s = cpu_to_be32(bt_xfoff);
+
+	*stat = 1;
+	return 0;
+}
+
+/* Free a block from our in-memory btree. */
+int
+xfbtree_free_block(
+	struct xfs_btree_cur	*cur,
+	struct xfs_buf		*bp)
+{
+	struct xfbtree		*xfbt = cur->bc_mem.xfbtree;
+	xfileoff_t		bt_xfoff, bt_xflen;
+
+	ASSERT(cur->bc_flags & XFS_BTREE_IN_XFILE);
+
+	bt_xfoff = xfs_daddr_to_xfot(xfs_buf_daddr(bp));
+	bt_xflen = xfs_daddr_to_xfot(bp->b_length);
+
+	trace_xfbtree_free_block(xfbt, cur, bt_xfoff);
+
+	return xbitmap_set(xfbt->freespace, bt_xfoff, bt_xflen);
+}
+
+/* Return the minimum number of records for a btree block. */
+int
+xfbtree_get_minrecs(
+	struct xfs_btree_cur	*cur,
+	int			level)
+{
+	struct xfbtree		*xfbt = cur->bc_mem.xfbtree;
+
+	return xfbt->minrecs[level != 0];
+}
+
+/* Return the maximum number of records for a btree block. */
+int
+xfbtree_get_maxrecs(
+	struct xfs_btree_cur	*cur,
+	int			level)
+{
+	struct xfbtree		*xfbt = cur->bc_mem.xfbtree;
+
+	return xfbt->maxrecs[level != 0];
+}
+
+/* If this log item is a buffer item that came from the xfbtree, return it. */
+static inline struct xfs_buf *
+xfbtree_buf_match(
+	struct xfbtree			*xfbt,
+	const struct xfs_log_item	*lip)
+{
+	const struct xfs_buf_log_item	*bli;
+	struct xfs_buf			*bp;
+
+	if (lip->li_type != XFS_LI_BUF)
+		return NULL;
+
+	bli = container_of(lip, struct xfs_buf_log_item, bli_item);
+	bp = bli->bli_buf;
+	if (bp->b_target != xfbt->target)
+		return NULL;
+
+	return bp;
+}
+
+/*
+ * Detach this (probably dirty) xfbtree buffer from the transaction by any
+ * means necessary.  Returns true if the buffer needs to be written.
+ */
+STATIC bool
+xfbtree_trans_bdetach(
+	struct xfs_trans	*tp,
+	struct xfs_buf		*bp)
+{
+	struct xfs_buf_log_item	*bli = bp->b_log_item;
+	bool			dirty;
+
+	ASSERT(bli != NULL);
+
+	dirty = bli->bli_flags & (XFS_BLI_DIRTY | XFS_BLI_ORDERED);
+
+	bli->bli_flags &= ~(XFS_BLI_DIRTY | XFS_BLI_ORDERED |
+			    XFS_BLI_LOGGED | XFS_BLI_STALE);
+	clear_bit(XFS_LI_DIRTY, &bli->bli_item.li_flags);
+
+	while (bp->b_log_item != NULL)
+		xfs_trans_bdetach(tp, bp);
+
+	return dirty;
+}
+
+/*
+ * Commit changes to the incore btree immediately by writing all dirty xfbtree
+ * buffers to the backing xfile.  This detaches all xfbtree buffers from the
+ * transaction, even on failure.  The buffer locks are dropped between the
+ * delwri queue and submit, so the caller must synchronize btree access.
+ *
+ * Normally we'd let the buffers commit with the transaction and get written to
+ * the xfile via the log, but online repair stages ephemeral btrees in memory
+ * and uses the btree_staging functions to write new btrees to disk atomically.
+ * The in-memory btree (and its backing store) are discarded at the end of the
+ * repair phase, which means that xfbtree buffers cannot commit with the rest
+ * of a transaction.
+ *
+ * In other words, online repair only needs the transaction to collect buffer
+ * pointers and to avoid buffer deadlocks, not to guarantee consistency of
+ * updates.
+ */
+int
+xfbtree_trans_commit(
+	struct xfbtree		*xfbt,
+	struct xfs_trans	*tp)
+{
+	LIST_HEAD(buffer_list);
+	struct xfs_log_item	*lip, *n;
+	bool			corrupt = false;
+	bool			tp_dirty = false;
+
+	/*
+	 * For each xfbtree buffer attached to the transaction, write the dirty
+	 * buffers to the xfile and release them.
+	 */
+	list_for_each_entry_safe(lip, n, &tp->t_items, li_trans) {
+		struct xfs_buf	*bp = xfbtree_buf_match(xfbt, lip);
+		bool		dirty;
+
+		if (!bp) {
+			if (test_bit(XFS_LI_DIRTY, &lip->li_flags))
+				tp_dirty |= true;
+			continue;
+		}
+
+		trace_xfbtree_trans_commit_buf(xfbt, bp);
+
+		dirty = xfbtree_trans_bdetach(tp, bp);
+		if (dirty && !corrupt) {
+			xfs_failaddr_t	fa = bp->b_ops->verify_struct(bp);
+
+			/*
+			 * Because this btree is ephemeral, validate the buffer
+			 * structure before delwri_submit so that we can return
+			 * corruption errors to the caller without shutting
+			 * down the filesystem.
+			 *
+			 * If the buffer fails verification, log the failure
+			 * but continue walking the transaction items so that
+			 * we remove all ephemeral btree buffers.
+			 */
+			if (fa) {
+				corrupt = true;
+				xfs_verifier_error(bp, -EFSCORRUPTED, fa);
+			} else {
+				xfs_buf_delwri_queue_here(bp, &buffer_list);
+			}
+		}
+
+		xfs_buf_relse(bp);
+	}
+
+	/*
+	 * Reset the transaction's dirty flag to reflect the dirty state of the
+	 * log items that are still attached.
+	 */
+	tp->t_flags = (tp->t_flags & ~XFS_TRANS_DIRTY) |
+			(tp_dirty ? XFS_TRANS_DIRTY : 0);
+
+	if (corrupt) {
+		xfs_buf_delwri_cancel(&buffer_list);
+		return -EFSCORRUPTED;
+	}
+
+	if (list_empty(&buffer_list))
+		return 0;
+
+	return xfs_buf_delwri_submit(&buffer_list);
+}
+
+/*
+ * Cancel changes to the incore btree by detaching all the xfbtree buffers.
+ * Changes are not written to the backing store.  This is needed for online
+ * repair btrees, which are by nature ephemeral.
+ */
+void
+xfbtree_trans_cancel(
+	struct xfbtree		*xfbt,
+	struct xfs_trans	*tp)
+{
+	struct xfs_log_item	*lip, *n;
+	bool			tp_dirty = false;
+
+	list_for_each_entry_safe(lip, n, &tp->t_items, li_trans) {
+		struct xfs_buf	*bp = xfbtree_buf_match(xfbt, lip);
+
+		if (!bp) {
+			if (test_bit(XFS_LI_DIRTY, &lip->li_flags))
+				tp_dirty |= true;
+			continue;
+		}
+
+		trace_xfbtree_trans_cancel_buf(xfbt, bp);
+
+		xfbtree_trans_bdetach(tp, bp);
+		xfs_buf_relse(bp);
+	}
+
+	/*
+	 * Reset the transaction's dirty flag to reflect the dirty state of the
+	 * log items that are still attached.
+	 */
+	tp->t_flags = (tp->t_flags & ~XFS_TRANS_DIRTY) |
+			(tp_dirty ? XFS_TRANS_DIRTY : 0);
+}
diff --git a/fs/xfs/scrub/xfbtree.h b/fs/xfs/scrub/xfbtree.h
index e8d8c67641f8..8bd4f2bee1a8 100644
--- a/fs/xfs/scrub/xfbtree.h
+++ b/fs/xfs/scrub/xfbtree.h
@@ -22,13 +22,36 @@ struct xfs_btree_mem_head {
 /* xfile-backed in-memory btrees */
 
 struct xfbtree {
-	/* buffer cache target for this in-memory btree */
+	/* buffer cache target for the xfile backing this in-memory btree */
 	struct xfs_buftarg		*target;
 
+	/* Bitmap of free space from pos to used */
+	struct xbitmap			*freespace;
+
+	/* Number of xfile blocks actually used by this xfbtree. */
+	xfileoff_t			xf_used;
+
 	/* Owner of this btree. */
 	unsigned long long		owner;
+
+	/* Minimum and maximum records per block. */
+	unsigned int			maxrecs[2];
+	unsigned int			minrecs[2];
 };
 
+/* The head of the in-memory btree is always at block 0 */
+#define XFBTREE_HEAD_BLOCK		0
+
+/* in-memory btrees are always created with an empty leaf block at block 1 */
+#define XFBTREE_INIT_LEAF_BLOCK		1
+
+int xfbtree_head_read_buf(struct xfbtree *xfbt, struct xfs_trans *tp,
+		struct xfs_buf **bpp);
+
+void xfbtree_destroy(struct xfbtree *xfbt);
+int xfbtree_trans_commit(struct xfbtree *xfbt, struct xfs_trans *tp);
+void xfbtree_trans_cancel(struct xfbtree *xfbt, struct xfs_trans *tp);
+
 #endif /* CONFIG_XFS_BTREE_IN_XFILE */
 
 #endif /* XFS_SCRUB_XFBTREE_H__ */
diff --git a/fs/xfs/scrub/xfile.c b/fs/xfs/scrub/xfile.c
index 851aeb244660..40801b08a2b2 100644
--- a/fs/xfs/scrub/xfile.c
+++ b/fs/xfs/scrub/xfile.c
@@ -292,6 +292,89 @@ xfile_pwrite(
 	return error;
 }
 
+/* Discard pages backing a range of the xfile. */
+void
+xfile_discard(
+	struct xfile		*xf,
+	loff_t			pos,
+	u64			count)
+{
+	trace_xfile_discard(xf, pos, count);
+	shmem_truncate_range(file_inode(xf->file), pos, pos + count - 1);
+}
+
+/* Ensure that there is storage backing the given range. */
+int
+xfile_prealloc(
+	struct xfile		*xf,
+	loff_t			pos,
+	u64			count)
+{
+	struct inode		*inode = file_inode(xf->file);
+	struct address_space	*mapping = inode->i_mapping;
+	const struct address_space_operations *aops = mapping->a_ops;
+	struct page		*page = NULL;
+	unsigned int		pflags;
+	int			error = 0;
+
+	if (count > MAX_RW_COUNT)
+		return -E2BIG;
+	if (inode->i_sb->s_maxbytes - pos < count)
+		return -EFBIG;
+
+	trace_xfile_prealloc(xf, pos, count);
+
+	pflags = memalloc_nofs_save();
+	while (count > 0) {
+		void		*fsdata = NULL;
+		unsigned int	len;
+		int		ret;
+
+		len = min_t(ssize_t, count, PAGE_SIZE - offset_in_page(pos));
+
+		/*
+		 * We call write_begin directly here to avoid all the freezer
+		 * protection lock-taking that happens in the normal path.
+		 * shmem doesn't support fs freeze, but lockdep doesn't know
+		 * that and will trip over that.
+		 */
+		error = aops->write_begin(NULL, mapping, pos, len, &page,
+				&fsdata);
+		if (error)
+			break;
+
+		/*
+		 * xfile pages must never be mapped into userspace, so we skip
+		 * the dcache flush.  If the page is not uptodate, zero it to
+		 * ensure we never go lacking for space here.
+		 */
+		if (!PageUptodate(page)) {
+			void	*kaddr = kmap_local_page(page);
+
+			memset(kaddr, 0, PAGE_SIZE);
+			SetPageUptodate(page);
+			kunmap_local(kaddr);
+		}
+
+		ret = aops->write_end(NULL, mapping, pos, len, len, page,
+				fsdata);
+		if (ret < 0) {
+			error = ret;
+			break;
+		}
+		if (ret != len) {
+			error = -EIO;
+			break;
+		}
+
+		count -= len;
+		pos += len;
+	}
+	memalloc_nofs_restore(pflags);
+
+	return error;
+}
+
 /* Find the next written area in the xfile data for a given offset. */
 loff_t
 xfile_seek_data(
diff --git a/fs/xfs/scrub/xfile.h b/fs/xfs/scrub/xfile.h
index c6d7851b01ca..d3b52f8069f2 100644
--- a/fs/xfs/scrub/xfile.h
+++ b/fs/xfs/scrub/xfile.h
@@ -65,6 +65,8 @@ xfile_obj_store(struct xfile *xf, const void *buf, size_t count, loff_t pos)
 	return 0;
 }
 
+void xfile_discard(struct xfile *xf, loff_t pos, u64 count);
+int xfile_prealloc(struct xfile *xf, loff_t pos, u64 count);
 loff_t xfile_seek_data(struct xfile *xf, loff_t pos);
 
 struct xfile_stat {
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index ab9217c1c3d8..e4fd81549e00 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -637,6 +637,7 @@ DEFINE_BUF_ITEM_EVENT(xfs_trans_read_buf);
 DEFINE_BUF_ITEM_EVENT(xfs_trans_read_buf_recur);
 DEFINE_BUF_ITEM_EVENT(xfs_trans_log_buf);
 DEFINE_BUF_ITEM_EVENT(xfs_trans_brelse);
+DEFINE_BUF_ITEM_EVENT(xfs_trans_bdetach);
 DEFINE_BUF_ITEM_EVENT(xfs_trans_bjoin);
 DEFINE_BUF_ITEM_EVENT(xfs_trans_bhold);
 DEFINE_BUF_ITEM_EVENT(xfs_trans_bhold_release);
diff --git a/fs/xfs/xfs_trans.h b/fs/xfs/xfs_trans.h
index d32abdd1e014..83e29bd2b2fd 100644
--- a/fs/xfs/xfs_trans.h
+++ b/fs/xfs/xfs_trans.h
@@ -219,6 +219,7 @@ struct xfs_buf	*xfs_trans_getsb(struct xfs_trans *);
 
 void		xfs_trans_brelse(xfs_trans_t *, struct xfs_buf *);
 void		xfs_trans_bjoin(xfs_trans_t *, struct xfs_buf *);
+void		xfs_trans_bdetach(struct xfs_trans *tp, struct xfs_buf *bp);
 void		xfs_trans_bhold(xfs_trans_t *, struct xfs_buf *);
 void		xfs_trans_bhold_release(xfs_trans_t *, struct xfs_buf *);
 void		xfs_trans_binval(xfs_trans_t *, struct xfs_buf *);
diff --git a/fs/xfs/xfs_trans_buf.c b/fs/xfs/xfs_trans_buf.c
index 6549e50d852c..e28ab74af4f0 100644
--- a/fs/xfs/xfs_trans_buf.c
+++ b/fs/xfs/xfs_trans_buf.c
@@ -392,6 +392,48 @@ xfs_trans_brelse(
 	xfs_buf_relse(bp);
 }
 
+/*
+ * Forcibly detach a buffer previously joined to the transaction.  The caller
+ * will retain its locked reference to the buffer after this function returns.
+ * The buffer must be completely clean and must not be held to the transaction.
+ */
+void
+xfs_trans_bdetach(
+	struct xfs_trans	*tp,
+	struct xfs_buf		*bp)
+{
+	struct xfs_buf_log_item	*bip = bp->b_log_item;
+
+	ASSERT(tp != NULL);
+	ASSERT(bp->b_transp == tp);
+	ASSERT(bip->bli_item.li_type == XFS_LI_BUF);
+	ASSERT(atomic_read(&bip->bli_refcount) > 0);
+
+	trace_xfs_trans_bdetach(bip);
+
+	/*
+	 * Erase all recursion count, since we're removing this buffer from the
+	 * transaction.
+	 */
+	bip->bli_recur = 0;
+
+	/*
+	 * The buffer must be completely clean.  Specifically, it had better
+	 * not be dirty, stale, logged, ordered, or held to the transaction.
+	 */
+	ASSERT(!test_bit(XFS_LI_DIRTY, &bip->bli_item.li_flags));
+	ASSERT(!(bip->bli_flags & XFS_BLI_DIRTY));
+	ASSERT(!(bip->bli_flags & XFS_BLI_HOLD));
+	ASSERT(!(bip->bli_flags & XFS_BLI_LOGGED));
+	ASSERT(!(bip->bli_flags & XFS_BLI_ORDERED));
+	ASSERT(!(bip->bli_flags & XFS_BLI_STALE));
+
+	/* Unlink the log item from the transaction and drop the log item. */
+	xfs_trans_del_item(&bip->bli_item);
+	xfs_buf_item_put(bip);
+	bp->b_transp = NULL;
+}
+
 /*
  * Mark the buffer as not needing to be unlocked when the buf item's
  * iop_committing() routine is called.  The buffer must already be locked

