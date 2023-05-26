Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0204711C92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 03:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbjEZB2G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 21:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjEZB2F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 21:28:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B58189;
        Thu, 25 May 2023 18:28:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24CA764C2D;
        Fri, 26 May 2023 01:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8604FC433D2;
        Fri, 26 May 2023 01:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685064481;
        bh=7J6J2SC2LevUTrt2+TicqWnOH7unmSFLICjT171wWa8=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=juXjjz94flmLVy5OMRG10T3l1IZmE4SYFjjTstmGUnbpxwmQjVYSfNdSwwrZ2VWtT
         U36VR7kafp0Rfwer5aCfPLHeHgNbwhGz993Vj1OU9i5bG7vMqMdwVTo1cxybJUiEWa
         ZeZn+yh6U+s3hOCYLQ5RobQjwtdRtyM8kQQB6nfCjHxn18RgI9Yc/hW1cp0M+Ltyx1
         N5cAazM/e6VwSybFEHdxTDLZSGqi+R8jhMNWY+KE3sVbMJ87wm8V7DWIRvbYPbVhJ5
         zGBMiSXUSj5K25j0OsEZz9XUd3K954/no0hq784lVobrsAuWdmc8OpHuSb7ojhn9Te
         1H1xqBROLRwNg==
Date:   Thu, 25 May 2023 18:28:01 -0700
Subject: [PATCH 23/25] xfs: make atomic extent swapping support realtime files
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Message-ID: <168506065313.3734442.9911572870312003245.stgit@frogsfrogsfrogs>
In-Reply-To: <168506064947.3734442.7654653738998941813.stgit@frogsfrogsfrogs>
References: <168506064947.3734442.7654653738998941813.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 fs/xfs/libxfs/xfs_swapext.c |  169 +++++++++++++++++++++++++++++++++++++++++--
 fs/xfs/libxfs/xfs_swapext.h |    5 +
 fs/xfs/xfs_bmap_util.c      |    2 -
 fs/xfs/xfs_inode.h          |    5 +
 fs/xfs/xfs_rtalloc.c        |  159 ++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_rtalloc.h        |    3 +
 fs/xfs/xfs_trace.h          |   11 ++-
 fs/xfs/xfs_xchgrange.c      |   73 ++++++++++++++++++-
 fs/xfs/xfs_xchgrange.h      |    2 -
 9 files changed, 409 insertions(+), 20 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_swapext.c b/fs/xfs/libxfs/xfs_swapext.c
index b72d9c6ae6e2..69d08e32df1a 100644
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
@@ -207,6 +304,8 @@ xfs_swapext_can_skip_mapping(
 	struct xfs_swapext_intent	*sxi,
 	struct xfs_bmbt_irec		*irec)
 {
+	struct xfs_mount		*mp = sxi->sxi_ip1->i_mount;
+
 	/* Do not skip this mapping if the caller did not tell us to. */
 	if (!(sxi->sxi_flags & XFS_SWAP_EXT_INO1_WRITTEN))
 		return false;
@@ -219,10 +318,62 @@ xfs_swapext_can_skip_mapping(
 	 * The mapping is unwritten or a hole.  It cannot be a delalloc
 	 * reservation because we already excluded those.  It cannot be an
 	 * unwritten extent with dirty page cache because we flushed the page
-	 * cache.  We don't support realtime files yet, so we needn't (yet)
-	 * deal with them.
+	 * cache.  For files where the allocation unit is 1FSB (files on the
+	 * data dev, rt files if the extent size is 1FSB), we can safely
+	 * skip this mapping.
 	 */
-	return true;
+	if (!xfs_inode_has_bigrtextents(sxi->sxi_ip1))
+		return true;
+
+	/*
+	 * For a realtime file with a multi-fsb allocation unit, the decision
+	 * is trickier because we can only swap full allocation units.
+	 * Unwritten mappings can appear in the middle of an rtx if the rtx is
+	 * partially written, but they can also appear for preallocations.
+	 *
+	 * If the mapping is a hole, skip it entirely.  Holes should align with
+	 * rtx boundaries.
+	 */
+	if (!xfs_bmap_is_real_extent(irec))
+		return true;
+
+	/*
+	 * All mappings below this point are unwritten.
+	 *
+	 * - If the beginning is not aligned to an rtx, trim the end of the
+	 *   mapping so that it does not cross an rtx boundary, and swap it.
+	 *
+	 * - If both ends are aligned to an rtx, skip the entire mapping.
+	 */
+	if (!isaligned_64(irec->br_startoff, mp->m_sb.sb_rextsize)) {
+		xfs_fileoff_t	new_end;
+
+		new_end = roundup_64(irec->br_startoff, mp->m_sb.sb_rextsize);
+		irec->br_blockcount = new_end - irec->br_startoff;
+		return false;
+	}
+	if (isaligned_64(irec->br_blockcount, mp->m_sb.sb_rextsize))
+		return true;
+
+	/*
+	 * All mappings below this point are unwritten, start on an rtx
+	 * boundary, and do not end on an rtx boundary.
+	 *
+	 * - If the mapping is longer than one rtx, trim the end of the mapping
+	 *   down to an rtx boundary and skip it.
+	 *
+	 * - The mapping is shorter than one rtx.  Swap it.
+	 */
+	if (irec->br_blockcount > mp->m_sb.sb_rextsize) {
+		xfs_fileoff_t	new_end;
+
+		new_end = rounddown_64(irec->br_startoff + irec->br_blockcount,
+				mp->m_sb.sb_rextsize);
+		irec->br_blockcount = new_end - irec->br_startoff;
+		return true;
+	}
+
+	return false;
 }
 
 /*
diff --git a/fs/xfs/libxfs/xfs_swapext.h b/fs/xfs/libxfs/xfs_swapext.h
index 01e02c5d277f..ac13b0e4a74e 100644
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
index eef19e07f581..9782c950f252 100644
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
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 1c037455fe47..6c68b900d05d 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -293,6 +293,11 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
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
index 790191316a32..f1ecc0b4c1bd 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -21,6 +21,7 @@
 #include "xfs_sb.h"
 #include "xfs_log_priv.h"
 #include "xfs_health.h"
+#include "xfs_trace.h"
 
 /*
  * Read and return the summary information for a given extent size,
@@ -1461,3 +1462,161 @@ xfs_rtpick_extent(
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
+ * Find an unwritten extent in the given file range, zero it, and convert the
+ * mapping to written.  Adjust the scan cursor on the way out.
+ */
+STATIC int
+xfs_rtfile_convert_one(
+	struct xfs_inode	*ip,
+	xfs_fileoff_t		*offp,
+	xfs_fileoff_t		endoff)
+{
+	struct xfs_bmbt_irec	irec;
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_trans	*tp;
+	unsigned int		resblks;
+	int			nmap;
+	int			error;
+
+	resblks = XFS_DIOSTRAT_SPACE_RES(mp, 1);
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0, 0, &tp);
+	if (error)
+		return error;
+
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+	xfs_trans_ijoin(tp, ip, 0);
+
+	/*
+	 * Read the mapping.  If we find an unwritten extent that isn't aligned
+	 * to an rt extent boundary...
+	 */
+retry:
+	nmap = 1;
+	error = xfs_bmapi_read(ip, *offp, endoff - *offp, &irec, &nmap, 0);
+	if (error)
+		goto out_cancel;
+	ASSERT(nmap == 1);
+	ASSERT(irec.br_startoff == *offp);
+	if (!xfs_rtfile_want_conversion(mp, &irec)) {
+		*offp = irec.br_startoff + irec.br_blockcount;
+		if (*offp >= endoff)
+			goto out_cancel;
+		goto retry;
+	}
+
+	/*
+	 * ...make sure this partially unwritten rt extent gets converted to a
+	 * zeroed written extent that we can remap.
+	 */
+	nmap = 1;
+	error = xfs_bmapi_write(tp, ip, irec.br_startoff, irec.br_blockcount,
+			XFS_BMAPI_CONVERT | XFS_BMAPI_ZERO, 0, &irec, &nmap);
+	if (error)
+		goto out_cancel;
+	ASSERT(nmap == 1);
+	if (irec.br_state != XFS_EXT_NORM) {
+		ASSERT(0);
+		error = -EIO;
+		goto out_cancel;
+	}
+	error = xfs_trans_commit(tp);
+	if (error)
+		goto out_unlock;
+
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	*offp = irec.br_startoff + irec.br_blockcount;
+	return 0;
+
+out_cancel:
+	xfs_trans_cancel(tp);
+out_unlock:
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return error;
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
+	struct xfs_mount	*mp = ip->i_mount;
+	xfs_fileoff_t		off;
+	xfs_fileoff_t		endoff;
+	int			error;
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
+		if (fatal_signal_pending(current))
+			return -EINTR;
+
+		error = xfs_rtfile_convert_one(ip, &off, endoff);
+		if (error)
+			return error;
+	}
+
+	return 0;
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
index 59f740863e70..965a5f5b50ee 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -1525,7 +1525,7 @@ DEFINE_IMAP_EVENT(xfs_iomap_alloc);
 DEFINE_IMAP_EVENT(xfs_iomap_found);
 
 DECLARE_EVENT_CLASS(xfs_simple_io_class,
-	TP_PROTO(struct xfs_inode *ip, xfs_off_t offset, ssize_t count),
+	TP_PROTO(struct xfs_inode *ip, xfs_off_t offset, u64 count),
 	TP_ARGS(ip, offset, count),
 	TP_STRUCT__entry(
 		__field(dev_t, dev)
@@ -1533,7 +1533,7 @@ DECLARE_EVENT_CLASS(xfs_simple_io_class,
 		__field(loff_t, isize)
 		__field(loff_t, disize)
 		__field(loff_t, offset)
-		__field(size_t, count)
+		__field(u64, count)
 	),
 	TP_fast_assign(
 		__entry->dev = VFS_I(ip)->i_sb->s_dev;
@@ -1544,7 +1544,7 @@ DECLARE_EVENT_CLASS(xfs_simple_io_class,
 		__entry->count = count;
 	),
 	TP_printk("dev %d:%d ino 0x%llx isize 0x%llx disize 0x%llx "
-		  "pos 0x%llx bytecount 0x%zx",
+		  "pos 0x%llx bytecount 0x%llx",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->ino,
 		  __entry->isize,
@@ -1555,7 +1555,7 @@ DECLARE_EVENT_CLASS(xfs_simple_io_class,
 
 #define DEFINE_SIMPLE_IO_EVENT(name)	\
 DEFINE_EVENT(xfs_simple_io_class, name,	\
-	TP_PROTO(struct xfs_inode *ip, xfs_off_t offset, ssize_t count),	\
+	TP_PROTO(struct xfs_inode *ip, xfs_off_t offset, u64 count),	\
 	TP_ARGS(ip, offset, count))
 DEFINE_SIMPLE_IO_EVENT(xfs_delalloc_enospc);
 DEFINE_SIMPLE_IO_EVENT(xfs_unwritten_convert);
@@ -3749,6 +3749,9 @@ TRACE_EVENT(xfs_ioctl_clone,
 /* unshare tracepoints */
 DEFINE_SIMPLE_IO_EVENT(xfs_reflink_unshare);
 DEFINE_INODE_ERROR_EVENT(xfs_reflink_unshare_error);
+#ifdef CONFIG_XFS_RT
+DEFINE_SIMPLE_IO_EVENT(xfs_rtfile_convert_unwritten);
+#endif /* CONFIG_XFS_RT */
 
 /* copy on write */
 DEFINE_INODE_IREC_EVENT(xfs_reflink_trim_around_shared);
diff --git a/fs/xfs/xfs_xchgrange.c b/fs/xfs/xfs_xchgrange.c
index 619cf9c0e67d..1c26290b992d 100644
--- a/fs/xfs/xfs_xchgrange.c
+++ b/fs/xfs/xfs_xchgrange.c
@@ -27,6 +27,7 @@
 #include "xfs_sb.h"
 #include "xfs_icache.h"
 #include "xfs_log.h"
+#include "xfs_rtalloc.h"
 #include <linux/fsnotify.h>
 
 /*
@@ -391,7 +392,7 @@ xfs_file_xchg_range(
 		goto out_err;
 
 	/* Prepare and then exchange file contents. */
-	error = xfs_xchg_range_prep(file1, file2, fxr);
+	error = xfs_xchg_range_prep(file1, file2, fxr, priv_flags);
 	if (error)
 		goto out_unlock;
 
@@ -770,12 +771,58 @@ xfs_swap_extent_forks(
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
-	struct xfs_exch_range	*fxr)
+	struct xfs_exch_range	*fxr,
+	unsigned int		xchg_flags)
 {
 	struct xfs_inode	*ip1 = XFS_I(file_inode(file1));
 	struct xfs_inode	*ip2 = XFS_I(file_inode(file2));
@@ -839,6 +886,19 @@ xfs_xchg_range_prep(
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
 
@@ -1056,6 +1116,15 @@ xfs_xchg_range(
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
index 1f79f16e4a95..691f020a724d 100644
--- a/fs/xfs/xfs_xchgrange.h
+++ b/fs/xfs/xfs_xchgrange.h
@@ -51,6 +51,6 @@ void xfs_xchg_range_rele_log_assist(struct xfs_mount *mp);
 int xfs_xchg_range(struct xfs_inode *ip1, struct xfs_inode *ip2,
 		const struct xfs_exch_range *fxr, unsigned int xchg_flags);
 int xfs_xchg_range_prep(struct file *file1, struct file *file2,
-		struct xfs_exch_range *fxr);
+		struct xfs_exch_range *fxr, unsigned int xchg_flags);
 
 #endif /* __XFS_XCHGRANGE_H__ */

