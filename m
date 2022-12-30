Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9212659EFE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 00:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbiL3XzL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 18:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235820AbiL3XzJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:55:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D631E3C5;
        Fri, 30 Dec 2022 15:55:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D007B81DDC;
        Fri, 30 Dec 2022 23:55:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B08C433D2;
        Fri, 30 Dec 2022 23:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672444505;
        bh=n+t8AJoQoQqXtCJCs0m7XC3U25YgcVJYyNfHESyEMIA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BO4LK37suIoJZKW0FdvETqC0n/c7psy2gB4xmLsxFBsDPo+PnqavBlT3AvJE/FJ4e
         1ytXKV4obFWpCXFgrhBIwpWRKas2Xqhn4PvCecHKxNafc43irMk9i1QoI1QRJf4y5e
         0v+0fiye3OmiimGVZE8FQwGfLyOTyWP5wi/cV/73m5wuXnkYdUz038nt8L6Lj+fGpP
         gyllnPWGFX6gg6BdYYWqt0Hyr108Frh7edYIX6NjA5yu0Di5UUtpRRC8uG1N77gfDi
         zzwQuGUCdqWnfqVwENPAOeO0qsiyk3JL/CFwZtO1FoKCeHorzlcee1aEWJjPdZUWWI
         KCN/9NTzdz3aQ==
Subject: [PATCH 19/21] xfs: make atomic extent swapping support realtime files
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Fri, 30 Dec 2022 14:13:58 -0800
Message-ID: <167243843800.699466.8306225646421918407.stgit@magnolia>
In-Reply-To: <167243843494.699466.5163281976943635014.stgit@magnolia>
References: <167243843494.699466.5163281976943635014.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Now that bmap items support the realtime device, we can add the
necessary pieces to the atomic extent swapping code to support such
things.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_swapext.c |  109 +++++++++++++++++++++++++++++++++-
 fs/xfs/libxfs/xfs_swapext.h |    5 +-
 fs/xfs/xfs_bmap_util.c      |    2 -
 fs/xfs/xfs_file.c           |    2 -
 fs/xfs/xfs_inode.h          |    5 ++
 fs/xfs/xfs_rtalloc.c        |  136 +++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_rtalloc.h        |    3 +
 fs/xfs/xfs_trace.h          |   11 ++-
 fs/xfs/xfs_xchgrange.c      |   71 ++++++++++++++++++++++
 fs/xfs/xfs_xchgrange.h      |    2 -
 10 files changed, 329 insertions(+), 17 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_swapext.c b/fs/xfs/libxfs/xfs_swapext.c
index b27ceeb93a16..69812594fd71 100644
--- a/fs/xfs/libxfs/xfs_swapext.c
+++ b/fs/xfs/libxfs/xfs_swapext.c
@@ -142,6 +142,108 @@ sxi_advance(
 	sxi->sxi_blockcount -= irec->br_blockcount;
 }
 
+#ifdef DEBUG
+static inline bool
+xfs_swapext_need_rt_conversion(
+	const struct xfs_swapext_req	*req)
+{
+	struct xfs_inode		*ip = req->ip2;
+	struct xfs_mount		*mp = ip->i_mount;
+
+	/* xattrs don't live on the rt device */
+	if (req->whichfork == XFS_ATTR_FORK)
+		return false;
+
+	/*
+	 * Caller got permission to use logged swapext, so log recovery will
+	 * finish the swap and not leave us with partially swapped rt extents
+	 * exposed to userspace.
+	 */
+	if (req->req_flags & XFS_SWAP_REQ_LOGGED)
+		return false;
+
+	/*
+	 * If we can't use log intent items at all, the only supported
+	 * operation is full fork swaps.
+	 */
+	if (!xfs_swapext_supported(mp))
+		return false;
+
+	/* Conversion is only needed for realtime files with big rt extents */
+	return xfs_inode_has_bigrtextents(ip);
+}
+
+static inline int
+xfs_swapext_check_rt_extents(
+	struct xfs_mount		*mp,
+	const struct xfs_swapext_req	*req)
+{
+	struct xfs_bmbt_irec		irec1, irec2;
+	xfs_fileoff_t			startoff1 = req->startoff1;
+	xfs_fileoff_t			startoff2 = req->startoff2;
+	xfs_filblks_t			blockcount = req->blockcount;
+	uint32_t			mod;
+	int				nimaps;
+	int				error;
+
+	if (!xfs_swapext_need_rt_conversion(req))
+		return 0;
+
+	while (blockcount > 0) {
+		/* Read extent from the first file */
+		nimaps = 1;
+		error = xfs_bmapi_read(req->ip1, startoff1, blockcount,
+				&irec1, &nimaps, 0);
+		if (error)
+			return error;
+		ASSERT(nimaps == 1);
+
+		/* Read extent from the second file */
+		nimaps = 1;
+		error = xfs_bmapi_read(req->ip2, startoff2,
+				irec1.br_blockcount, &irec2, &nimaps,
+				0);
+		if (error)
+			return error;
+		ASSERT(nimaps == 1);
+
+		/*
+		 * We can only swap as many blocks as the smaller of the two
+		 * extent maps.
+		 */
+		irec1.br_blockcount = min(irec1.br_blockcount,
+					  irec2.br_blockcount);
+
+		/* Both mappings must be aligned to the realtime extent size. */
+		div_u64_rem(irec1.br_startoff, mp->m_sb.sb_rextsize, &mod);
+		if (mod) {
+			ASSERT(mod == 0);
+			return -EINVAL;
+		}
+
+		div_u64_rem(irec2.br_startoff, mp->m_sb.sb_rextsize, &mod);
+		if (mod) {
+			ASSERT(mod == 0);
+			return -EINVAL;
+		}
+
+		div_u64_rem(irec1.br_blockcount, mp->m_sb.sb_rextsize, &mod);
+		if (mod) {
+			ASSERT(mod == 0);
+			return -EINVAL;
+		}
+
+		startoff1 += irec1.br_blockcount;
+		startoff2 += irec1.br_blockcount;
+		blockcount -= irec1.br_blockcount;
+	}
+
+	return 0;
+}
+#else
+# define xfs_swapext_check_rt_extents(mp, req)		(0)
+#endif
+
 /* Check all extents to make sure we can actually swap them. */
 int
 xfs_swapext_check_extents(
@@ -161,12 +263,7 @@ xfs_swapext_check_extents(
 	    ifp2->if_format == XFS_DINODE_FMT_LOCAL)
 		return -EINVAL;
 
-	/* We don't support realtime data forks yet. */
-	if (!XFS_IS_REALTIME_INODE(req->ip1))
-		return 0;
-	if (req->whichfork == XFS_ATTR_FORK)
-		return 0;
-	return -EINVAL;
+	return xfs_swapext_check_rt_extents(mp, req);
 }
 
 #ifdef CONFIG_XFS_QUOTA
diff --git a/fs/xfs/libxfs/xfs_swapext.h b/fs/xfs/libxfs/xfs_swapext.h
index 6b610fea150a..155add23d8e2 100644
--- a/fs/xfs/libxfs/xfs_swapext.h
+++ b/fs/xfs/libxfs/xfs_swapext.h
@@ -13,12 +13,11 @@
  * This can be done to individual file extents by using the block mapping log
  * intent items introduced with reflink and rmap; or to entire file ranges
  * using swapext log intent items to track the overall progress across multiple
- * extent mappings.  Realtime is not supported yet.
+ * extent mappings.
  */
 static inline bool xfs_swapext_supported(struct xfs_mount *mp)
 {
-	return (xfs_has_reflink(mp) || xfs_has_rmapbt(mp)) &&
-	       !xfs_has_realtime(mp);
+	return xfs_has_reflink(mp) || xfs_has_rmapbt(mp);
 }
 
 /*
diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 47a583a94d58..3593c0f0ce13 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -989,7 +989,7 @@ xfs_free_file_space(
 	endoffset_fsb = XFS_B_TO_FSBT(mp, offset + len);
 
 	/* We can only free complete realtime extents. */
-	if (XFS_IS_REALTIME_INODE(ip) && mp->m_sb.sb_rextsize > 1) {
+	if (xfs_inode_has_bigrtextents(ip)) {
 		startoffset_fsb = roundup_64(startoffset_fsb,
 					     mp->m_sb.sb_rextsize);
 		endoffset_fsb = rounddown_64(endoffset_fsb,
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index b4629c8aa6b7..87dfb05640a8 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1181,7 +1181,7 @@ xfs_file_xchg_range(
 		goto out_err;
 
 	/* Prepare and then exchange file contents. */
-	error = xfs_xchg_range_prep(file1, file2, fxr);
+	error = xfs_xchg_range_prep(file1, file2, fxr, priv_flags);
 	if (error)
 		goto out_unlock;
 
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 4b01d078ace2..444c43571e31 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -287,6 +287,11 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
 	return ip->i_diflags2 & XFS_DIFLAG2_NREXT64;
 }
 
+static inline bool xfs_inode_has_bigrtextents(struct xfs_inode *ip)
+{
+	return XFS_IS_REALTIME_INODE(ip) && ip->i_mount->m_sb.sb_rextsize > 1;
+}
+
 /*
  * Return the buftarg used for data allocations on a given inode.
  */
diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
index 790191316a32..883333036519 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -21,6 +21,7 @@
 #include "xfs_sb.h"
 #include "xfs_log_priv.h"
 #include "xfs_health.h"
+#include "xfs_trace.h"
 
 /*
  * Read and return the summary information for a given extent size,
@@ -1461,3 +1462,138 @@ xfs_rtpick_extent(
 	*pick = b;
 	return 0;
 }
+
+/*
+ * Decide if this is an unwritten extent that isn't aligned to a rt extent
+ * boundary.  If it is, shorten the mapping so that we're ready to convert
+ * everything up to the next rt extent to a zeroed written extent.  If not,
+ * return false.
+ */
+static inline bool
+xfs_rtfile_want_conversion(
+	struct xfs_mount	*mp,
+	struct xfs_bmbt_irec	*irec)
+{
+	xfs_fileoff_t		rext_next;
+	uint32_t		modoff, modcnt;
+
+	if (irec->br_state != XFS_EXT_UNWRITTEN)
+		return false;
+
+	div_u64_rem(irec->br_startoff, mp->m_sb.sb_rextsize, &modoff);
+	if (modoff == 0) {
+		uint64_t	rexts = div_u64_rem(irec->br_blockcount,
+						mp->m_sb.sb_rextsize, &modcnt);
+
+		if (rexts > 0) {
+			/*
+			 * Unwritten mapping starts at an rt extent boundary
+			 * and is longer than one rt extent.  Round the length
+			 * down to the nearest extent but don't select it for
+			 * conversion.
+			 */
+			irec->br_blockcount -= modcnt;
+			modcnt = 0;
+		}
+
+		/* Unwritten mapping is perfectly aligned, do not convert. */
+		if (modcnt == 0)
+			return false;
+	}
+
+	/*
+	 * Unaligned and unwritten; trim to the current rt extent and select it
+	 * for conversion.
+	 */
+	rext_next = (irec->br_startoff - modoff) + mp->m_sb.sb_rextsize;
+	xfs_trim_extent(irec, irec->br_startoff, rext_next - irec->br_startoff);
+	return true;
+}
+
+/*
+ * For all realtime extents backing the given range of a file, search for
+ * unwritten mappings that do not cover a full rt extent and convert them
+ * to zeroed written mappings.  The goal is to end up with one mapping per rt
+ * extent so that we can perform a remapping operation.  Callers must ensure
+ * that there are no dirty pages in the given range.
+ */
+int
+xfs_rtfile_convert_unwritten(
+	struct xfs_inode	*ip,
+	loff_t			pos,
+	uint64_t		len)
+{
+	struct xfs_bmbt_irec	irec;
+	struct xfs_trans	*tp;
+	struct xfs_mount	*mp = ip->i_mount;
+	xfs_fileoff_t		off;
+	xfs_fileoff_t		endoff;
+	unsigned int		resblks;
+	int			ret;
+
+	if (mp->m_sb.sb_rextsize == 1)
+		return 0;
+
+	off = rounddown_64(XFS_B_TO_FSBT(mp, pos), mp->m_sb.sb_rextsize);
+	endoff = roundup_64(XFS_B_TO_FSB(mp, pos + len), mp->m_sb.sb_rextsize);
+
+	trace_xfs_rtfile_convert_unwritten(ip, pos, len);
+
+	while (off < endoff) {
+		int		nmap = 1;
+
+		if (fatal_signal_pending(current))
+			return -EINTR;
+
+		resblks = XFS_DIOSTRAT_SPACE_RES(mp, 1);
+		ret = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0, 0,
+				&tp);
+		if (ret)
+			return ret;
+
+		xfs_ilock(ip, XFS_ILOCK_EXCL);
+		xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL);
+
+		/*
+		 * Read the mapping.  If we find an unwritten extent that isn't
+		 * aligned to an rt extent boundary...
+		 */
+		ret = xfs_bmapi_read(ip, off, endoff - off, &irec, &nmap, 0);
+		if (ret)
+			goto err;
+		ASSERT(nmap == 1);
+		ASSERT(irec.br_startoff == off);
+		if (!xfs_rtfile_want_conversion(mp, &irec)) {
+			xfs_trans_cancel(tp);
+			off += irec.br_blockcount;
+			continue;
+		}
+
+		/*
+		 * ...make sure this partially unwritten rt extent gets
+		 * converted to a zeroed written extent that we can remap.
+		 */
+		nmap = 1;
+		ret = xfs_bmapi_write(tp, ip, off, irec.br_blockcount,
+				XFS_BMAPI_CONVERT | XFS_BMAPI_ZERO, 0, &irec,
+				&nmap);
+		if (ret)
+			goto err;
+		ASSERT(nmap == 1);
+		if (irec.br_state != XFS_EXT_NORM) {
+			ASSERT(0);
+			ret = -EIO;
+			goto err;
+		}
+		ret = xfs_trans_commit(tp);
+		if (ret)
+			return ret;
+
+		off += irec.br_blockcount;
+	}
+
+	return 0;
+err:
+	xfs_trans_cancel(tp);
+	return ret;
+}
diff --git a/fs/xfs/xfs_rtalloc.h b/fs/xfs/xfs_rtalloc.h
index 3b2f1b499a11..e440f793dd98 100644
--- a/fs/xfs/xfs_rtalloc.h
+++ b/fs/xfs/xfs_rtalloc.h
@@ -140,6 +140,8 @@ int xfs_rtalloc_extent_is_free(struct xfs_mount *mp, struct xfs_trans *tp,
 			       xfs_rtblock_t start, xfs_extlen_t len,
 			       bool *is_free);
 int xfs_rtalloc_reinit_frextents(struct xfs_mount *mp);
+int xfs_rtfile_convert_unwritten(struct xfs_inode *ip, loff_t pos,
+		uint64_t len);
 #else
 # define xfs_rtallocate_extent(t,b,min,max,l,f,p,rb)    (ENOSYS)
 # define xfs_rtfree_extent(t,b,l)                       (ENOSYS)
@@ -164,6 +166,7 @@ xfs_rtmount_init(
 }
 # define xfs_rtmount_inodes(m)  (((mp)->m_sb.sb_rblocks == 0)? 0 : (ENOSYS))
 # define xfs_rtunmount_inodes(m)
+# define xfs_rtfile_convert_unwritten(ip, pos, len)	(0)
 #endif	/* CONFIG_XFS_RT */
 
 #endif	/* __XFS_RTALLOC_H__ */
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index b0ced76af3b9..0802f078a945 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -1519,7 +1519,7 @@ DEFINE_IMAP_EVENT(xfs_iomap_alloc);
 DEFINE_IMAP_EVENT(xfs_iomap_found);
 
 DECLARE_EVENT_CLASS(xfs_simple_io_class,
-	TP_PROTO(struct xfs_inode *ip, xfs_off_t offset, ssize_t count),
+	TP_PROTO(struct xfs_inode *ip, xfs_off_t offset, u64 count),
 	TP_ARGS(ip, offset, count),
 	TP_STRUCT__entry(
 		__field(dev_t, dev)
@@ -1527,7 +1527,7 @@ DECLARE_EVENT_CLASS(xfs_simple_io_class,
 		__field(loff_t, isize)
 		__field(loff_t, disize)
 		__field(loff_t, offset)
-		__field(size_t, count)
+		__field(u64, count)
 	),
 	TP_fast_assign(
 		__entry->dev = VFS_I(ip)->i_sb->s_dev;
@@ -1538,7 +1538,7 @@ DECLARE_EVENT_CLASS(xfs_simple_io_class,
 		__entry->count = count;
 	),
 	TP_printk("dev %d:%d ino 0x%llx isize 0x%llx disize 0x%llx "
-		  "pos 0x%llx bytecount 0x%zx",
+		  "pos 0x%llx bytecount 0x%llx",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->ino,
 		  __entry->isize,
@@ -1549,7 +1549,7 @@ DECLARE_EVENT_CLASS(xfs_simple_io_class,
 
 #define DEFINE_SIMPLE_IO_EVENT(name)	\
 DEFINE_EVENT(xfs_simple_io_class, name,	\
-	TP_PROTO(struct xfs_inode *ip, xfs_off_t offset, ssize_t count),	\
+	TP_PROTO(struct xfs_inode *ip, xfs_off_t offset, u64 count),	\
 	TP_ARGS(ip, offset, count))
 DEFINE_SIMPLE_IO_EVENT(xfs_delalloc_enospc);
 DEFINE_SIMPLE_IO_EVENT(xfs_unwritten_convert);
@@ -3741,6 +3741,9 @@ TRACE_EVENT(xfs_ioctl_clone,
 /* unshare tracepoints */
 DEFINE_SIMPLE_IO_EVENT(xfs_reflink_unshare);
 DEFINE_INODE_ERROR_EVENT(xfs_reflink_unshare_error);
+#ifdef CONFIG_XFS_RT
+DEFINE_SIMPLE_IO_EVENT(xfs_rtfile_convert_unwritten);
+#endif /* CONFIG_XFS_RT */
 
 /* copy on write */
 DEFINE_INODE_IREC_EVENT(xfs_reflink_trim_around_shared);
diff --git a/fs/xfs/xfs_xchgrange.c b/fs/xfs/xfs_xchgrange.c
index 27bb88dcf228..6a66d09099b0 100644
--- a/fs/xfs/xfs_xchgrange.c
+++ b/fs/xfs/xfs_xchgrange.c
@@ -28,6 +28,7 @@
 #include "xfs_sb.h"
 #include "xfs_icache.h"
 #include "xfs_log.h"
+#include "xfs_rtalloc.h"
 
 /* Lock (and optionally join) two inodes for a file range exchange. */
 void
@@ -370,12 +371,58 @@ xfs_swap_extent_forks(
 	return 0;
 }
 
+/*
+ * There may be partially written rt extents lurking in the ranges to be
+ * swapped.  According to the rules for realtime files with big rt extents, we
+ * must guarantee that an outside observer (an IO thread, realistically) never
+ * can see multiple physical rt extents mapped to the same logical file rt
+ * extent.  The deferred bmap log intent items that we use under the hood
+ * operate on single block mappings and not rt extents, which means we must
+ * have a strategy to ensure that log recovery after a failure won't stop in
+ * the middle of an rt extent.
+ *
+ * The preferred strategy is to use deferred extent swap log intent items to
+ * track the status of the overall swap operation so that we can complete the
+ * work during crash recovery.  If that isn't possible, we fall back to
+ * requiring the selected mappings in both forks to be aligned to rt extent
+ * boundaries.  As an aside, the old fork swap routine didn't have this
+ * requirement, but at an extreme cost in flexibilty (full files only, and no
+ * support if rmapbt is enabled).
+ */
+static bool
+xfs_xchg_range_need_rt_conversion(
+	struct xfs_inode		*ip,
+	unsigned int			xchg_flags)
+{
+	struct xfs_mount		*mp = ip->i_mount;
+
+	/*
+	 * Caller got permission to use logged swapext, so log recovery will
+	 * finish the swap and not leave us with partially swapped rt extents
+	 * exposed to userspace.
+	 */
+	if (xchg_flags & XFS_XCHG_RANGE_LOGGED)
+		return false;
+
+	/*
+	 * If we can't use log intent items at all, the only supported
+	 * operation is full fork swaps, so no conversions are needed.
+	 * The range requirements are enforced by the swapext code itself.
+	 */
+	if (!xfs_swapext_supported(mp))
+		return false;
+
+	/* Conversion is only needed for realtime files with big rt extents */
+	return xfs_inode_has_bigrtextents(ip);
+}
+
 /* Prepare two files to have their data exchanged. */
 int
 xfs_xchg_range_prep(
 	struct file		*file1,
 	struct file		*file2,
-	struct file_xchg_range	*fxr)
+	struct file_xchg_range	*fxr,
+	unsigned int		xchg_flags)
 {
 	struct xfs_inode	*ip1 = XFS_I(file_inode(file1));
 	struct xfs_inode	*ip2 = XFS_I(file_inode(file2));
@@ -439,6 +486,19 @@ xfs_xchg_range_prep(
 			return error;
 	}
 
+	/* Convert unwritten sub-extent mappings if required. */
+	if (xfs_xchg_range_need_rt_conversion(ip2, xchg_flags)) {
+		error = xfs_rtfile_convert_unwritten(ip2, fxr->file2_offset,
+				fxr->length);
+		if (error)
+			return error;
+
+		error = xfs_rtfile_convert_unwritten(ip1, fxr->file1_offset,
+				fxr->length);
+		if (error)
+			return error;
+	}
+
 	return 0;
 }
 
@@ -656,6 +716,15 @@ xfs_xchg_range(
 	if (xchg_flags & XFS_XCHG_RANGE_LOGGED)
 		req.req_flags |= XFS_SWAP_REQ_LOGGED;
 
+	/*
+	 * Round the request length up to the nearest fundamental unit of
+	 * allocation.  The prep function already checked that the request
+	 * offsets and length in @fxr are safe to round up.
+	 */
+	if (XFS_IS_REALTIME_INODE(ip2))
+		req.blockcount = roundup_64(req.blockcount,
+					    mp->m_sb.sb_rextsize);
+
 	error = xfs_xchg_range_estimate(&req);
 	if (error)
 		return error;
diff --git a/fs/xfs/xfs_xchgrange.h b/fs/xfs/xfs_xchgrange.h
index a0e64408784a..e356fe09a40c 100644
--- a/fs/xfs/xfs_xchgrange.h
+++ b/fs/xfs/xfs_xchgrange.h
@@ -35,6 +35,6 @@ void xfs_xchg_range_rele_log_assist(struct xfs_mount *mp);
 int xfs_xchg_range(struct xfs_inode *ip1, struct xfs_inode *ip2,
 		const struct file_xchg_range *fxr, unsigned int xchg_flags);
 int xfs_xchg_range_prep(struct file *file1, struct file *file2,
-		struct file_xchg_range *fxr);
+		struct file_xchg_range *fxr, unsigned int xchg_flags);
 
 #endif /* __XFS_XCHGRANGE_H__ */

