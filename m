Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7F262D31C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 06:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239313AbiKQF6c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 00:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239257AbiKQF6T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 00:58:19 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA486712D
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 21:58:17 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id h14so740865pjv.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 21:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPsvTS2BI2IeXfVqfQ6H3wTeT3xMq3QJNEv8pCZIwxs=;
        b=dm5IZtJ6aWASthefILjJwaBZNYzkQg+LxYIg6r32IYbXw48QH9XXAqSVozqrDTqXmJ
         9VPopdSkw+kdVzJI/+sHi4HygNskgr8PFijaG/qNfed+s6eD4P8OBBaz1fSd0dAaKDH6
         peyCOJhQgykqJou6747Qvjva5ns97rkWFgihlcMX8iTJc91E89M9TVQ1MbXGwUy8sM8z
         jbwhIdLAR1cohAYLtME6hq+qnOGSyVrpqzk+VfeKp2iPeY9YZGs2E594IFhNisrOn8tY
         xx7rtEwU/QfPou/UCsNE66epmMNE0CMaTpGBmscFxHrElNLUV6g0DiJwHWhz+1s6OHRx
         wIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPsvTS2BI2IeXfVqfQ6H3wTeT3xMq3QJNEv8pCZIwxs=;
        b=ECAMAaXgQvT29AGfm4CicCM+0qxY7/x4lClMmXL5CXtBda8azyitN6ZYHGGL/hw0iG
         sk46S6+vjKqAIJxKISUE954pXI9HNp84aDVbszK/E9sMOLivIlVHyDUtMF0Y4m7EGFor
         VYCqlAESFam2kpQxPENfOoxd/jDTTo7EYlErv8LvObcZe7C3BeUzV7ylIx5ibuL2tn/2
         +ErMA0v/WqW43VhkITWP0ptfzugFeuJL9Yq6joCSLQkqVxCL8w0cQVl/fbPL2X4lmC5w
         vukxbil+kml7PEVpGt1mnvXOUfHcNZj4qDzNiOXrHbDNdvTQFRyzRsy9ZDvP3vEoNuq5
         +6Ug==
X-Gm-Message-State: ANoB5pnKY3aXqE5VFy0bHia8ZWF1heM2mVs4BOW+4zNlkQAzJHTvPOno
        nL9jBF0NJMek8KhhHuvWHzGoZg==
X-Google-Smtp-Source: AA0mqf4b+qXd1PKQSKcgcvhuu0k87PcVdojP8LgnmThWzx0L1wGSoJ15DPQUytOn2p44R5a6JnBWlQ==
X-Received: by 2002:a17:90a:ac07:b0:20a:f75d:b9af with SMTP id o7-20020a17090aac0700b0020af75db9afmr7029670pjq.222.1668664696853;
        Wed, 16 Nov 2022 21:58:16 -0800 (PST)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id h19-20020a656393000000b0044ed37dbca8sm205318pgv.2.2022.11.16.21.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 21:58:15 -0800 (PST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ovXue-00FBpY-E9; Thu, 17 Nov 2022 16:58:12 +1100
Received: from dave by discord.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1ovXue-0025cm-1G;
        Thu, 17 Nov 2022 16:58:12 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 8/9] xfs: use iomap_valid method to detect stale cached iomaps
Date:   Thu, 17 Nov 2022 16:58:09 +1100
Message-Id: <20221117055810.498014-9-david@fromorbit.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221117055810.498014-1-david@fromorbit.com>
References: <20221117055810.498014-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Now that iomap supports a mechanism to validate cached iomaps for
buffered write operations, hook it up to the XFS buffered write ops
so that we can avoid data corruptions that result from stale cached
iomaps. See:

https://lore.kernel.org/linux-xfs/20220817093627.GZ3600936@dread.disaster.area/

or the ->iomap_valid() introduction commit for exact details of the
corruption vector.

The validity cookie we store in the iomap is based on the type of
iomap we return. It is expected that the iomap->flags we set in
xfs_bmbt_to_iomap() is not perturbed by the iomap core and are
returned to us in the iomap passed via the .iomap_valid() callback.
This ensures that the validity cookie is always checking the correct
inode fork sequence numbers to detect potential changes that affect
the extent cached by the iomap.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/libxfs/xfs_bmap.c |  6 ++-
 fs/xfs/xfs_aops.c        |  2 +-
 fs/xfs/xfs_iomap.c       | 96 +++++++++++++++++++++++++++++++---------
 fs/xfs/xfs_iomap.h       |  5 ++-
 fs/xfs/xfs_pnfs.c        |  6 ++-
 5 files changed, 88 insertions(+), 27 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 49d0d4ea63fc..56b9b7db38bb 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -4551,7 +4551,8 @@ xfs_bmapi_convert_delalloc(
 	 * the extent.  Just return the real extent at this offset.
 	 */
 	if (!isnullstartblock(bma.got.br_startblock)) {
-		xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags);
+		xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags,
+				xfs_iomap_inode_sequence(ip, flags));
 		*seq = READ_ONCE(ifp->if_seq);
 		goto out_trans_cancel;
 	}
@@ -4599,7 +4600,8 @@ xfs_bmapi_convert_delalloc(
 	XFS_STATS_INC(mp, xs_xstrat_quick);
 
 	ASSERT(!isnullstartblock(bma.got.br_startblock));
-	xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags);
+	xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags,
+				xfs_iomap_inode_sequence(ip, flags));
 	*seq = READ_ONCE(ifp->if_seq);
 
 	if (whichfork == XFS_COW_FORK)
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 6aadc5815068..a22d90af40c8 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -372,7 +372,7 @@ xfs_map_blocks(
 	    isnullstartblock(imap.br_startblock))
 		goto allocate_blocks;
 
-	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, 0);
+	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, 0, XFS_WPC(wpc)->data_seq);
 	trace_xfs_map_blocks_found(ip, offset, count, whichfork, &imap);
 	return 0;
 allocate_blocks:
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 09676ff6940e..a9b3a1bcc3fd 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -48,13 +48,45 @@ xfs_alert_fsblock_zero(
 	return -EFSCORRUPTED;
 }
 
+u64
+xfs_iomap_inode_sequence(
+	struct xfs_inode	*ip,
+	u16			iomap_flags)
+{
+	u64			cookie = 0;
+
+	if (iomap_flags & IOMAP_F_XATTR)
+		return READ_ONCE(ip->i_af.if_seq);
+	if ((iomap_flags & IOMAP_F_SHARED) && ip->i_cowfp)
+		cookie = (u64)READ_ONCE(ip->i_cowfp->if_seq) << 32;
+	return cookie | READ_ONCE(ip->i_df.if_seq);
+}
+
+/*
+ * Check that the iomap passed to us is still valid for the given offset and
+ * length.
+ */
+static bool
+xfs_iomap_valid(
+	struct inode		*inode,
+	const struct iomap	*iomap)
+{
+	return iomap->validity_cookie ==
+			xfs_iomap_inode_sequence(XFS_I(inode), iomap->flags);
+}
+
+const struct iomap_page_ops xfs_iomap_page_ops = {
+	.iomap_valid		= xfs_iomap_valid,
+};
+
 int
 xfs_bmbt_to_iomap(
 	struct xfs_inode	*ip,
 	struct iomap		*iomap,
 	struct xfs_bmbt_irec	*imap,
 	unsigned int		mapping_flags,
-	u16			iomap_flags)
+	u16			iomap_flags,
+	u64			sequence_cookie)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
@@ -91,6 +123,9 @@ xfs_bmbt_to_iomap(
 	if (xfs_ipincount(ip) &&
 	    (ip->i_itemp->ili_fsync_fields & ~XFS_ILOG_TIMESTAMP))
 		iomap->flags |= IOMAP_F_DIRTY;
+
+	iomap->validity_cookie = sequence_cookie;
+	iomap->page_ops = &xfs_iomap_page_ops;
 	return 0;
 }
 
@@ -195,7 +230,8 @@ xfs_iomap_write_direct(
 	xfs_fileoff_t		offset_fsb,
 	xfs_fileoff_t		count_fsb,
 	unsigned int		flags,
-	struct xfs_bmbt_irec	*imap)
+	struct xfs_bmbt_irec	*imap,
+	u64			*seq)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_trans	*tp;
@@ -285,6 +321,8 @@ xfs_iomap_write_direct(
 		error = xfs_alert_fsblock_zero(ip, imap);
 
 out_unlock:
+	if (seq)
+		*seq = xfs_iomap_inode_sequence(ip, 0);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	return error;
 
@@ -743,6 +781,7 @@ xfs_direct_write_iomap_begin(
 	bool			shared = false;
 	u16			iomap_flags = 0;
 	unsigned int		lockmode = XFS_ILOCK_SHARED;
+	u64			seq;
 
 	ASSERT(flags & (IOMAP_WRITE | IOMAP_ZERO));
 
@@ -811,9 +850,10 @@ xfs_direct_write_iomap_begin(
 			goto out_unlock;
 	}
 
+	seq = xfs_iomap_inode_sequence(ip, iomap_flags);
 	xfs_iunlock(ip, lockmode);
 	trace_xfs_iomap_found(ip, offset, length, XFS_DATA_FORK, &imap);
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, iomap_flags);
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, iomap_flags, seq);
 
 allocate_blocks:
 	error = -EAGAIN;
@@ -839,24 +879,26 @@ xfs_direct_write_iomap_begin(
 	xfs_iunlock(ip, lockmode);
 
 	error = xfs_iomap_write_direct(ip, offset_fsb, end_fsb - offset_fsb,
-			flags, &imap);
+			flags, &imap, &seq);
 	if (error)
 		return error;
 
 	trace_xfs_iomap_alloc(ip, offset, length, XFS_DATA_FORK, &imap);
 	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags,
-				 iomap_flags | IOMAP_F_NEW);
+				 iomap_flags | IOMAP_F_NEW, seq);
 
 out_found_cow:
-	xfs_iunlock(ip, lockmode);
 	length = XFS_FSB_TO_B(mp, cmap.br_startoff + cmap.br_blockcount);
 	trace_xfs_iomap_found(ip, offset, length - offset, XFS_COW_FORK, &cmap);
 	if (imap.br_startblock != HOLESTARTBLOCK) {
-		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0);
+		seq = xfs_iomap_inode_sequence(ip, 0);
+		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0, seq);
 		if (error)
-			return error;
+			goto out_unlock;
 	}
-	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED);
+	seq = xfs_iomap_inode_sequence(ip, IOMAP_F_SHARED);
+	xfs_iunlock(ip, lockmode);
+	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED, seq);
 
 out_unlock:
 	if (lockmode)
@@ -915,6 +957,7 @@ xfs_buffered_write_iomap_begin(
 	int			allocfork = XFS_DATA_FORK;
 	int			error = 0;
 	unsigned int		lockmode = XFS_ILOCK_EXCL;
+	u64			seq;
 
 	if (xfs_is_shutdown(mp))
 		return -EIO;
@@ -1094,26 +1137,31 @@ xfs_buffered_write_iomap_begin(
 	 * Flag newly allocated delalloc blocks with IOMAP_F_NEW so we punch
 	 * them out if the write happens to fail.
 	 */
+	seq = xfs_iomap_inode_sequence(ip, IOMAP_F_NEW);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	trace_xfs_iomap_alloc(ip, offset, count, allocfork, &imap);
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, IOMAP_F_NEW);
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, IOMAP_F_NEW, seq);
 
 found_imap:
+	seq = xfs_iomap_inode_sequence(ip, 0);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0);
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0, seq);
 
 found_cow:
-	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	seq = xfs_iomap_inode_sequence(ip, 0);
 	if (imap.br_startoff <= offset_fsb) {
-		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0);
+		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0, seq);
 		if (error)
-			return error;
+			goto out_unlock;
+		seq = xfs_iomap_inode_sequence(ip, IOMAP_F_SHARED);
+		xfs_iunlock(ip, XFS_ILOCK_EXCL);
 		return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags,
-					 IOMAP_F_SHARED);
+					 IOMAP_F_SHARED, seq);
 	}
 
 	xfs_trim_extent(&cmap, offset_fsb, imap.br_startoff - offset_fsb);
-	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, 0);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, 0, seq);
 
 out_unlock:
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
@@ -1193,6 +1241,7 @@ xfs_read_iomap_begin(
 	int			nimaps = 1, error = 0;
 	bool			shared = false;
 	unsigned int		lockmode = XFS_ILOCK_SHARED;
+	u64			seq;
 
 	ASSERT(!(flags & (IOMAP_WRITE | IOMAP_ZERO)));
 
@@ -1206,13 +1255,14 @@ xfs_read_iomap_begin(
 			       &nimaps, 0);
 	if (!error && (flags & IOMAP_REPORT))
 		error = xfs_reflink_trim_around_shared(ip, &imap, &shared);
+	seq = xfs_iomap_inode_sequence(ip, shared ? IOMAP_F_SHARED : 0);
 	xfs_iunlock(ip, lockmode);
 
 	if (error)
 		return error;
 	trace_xfs_iomap_found(ip, offset, length, XFS_DATA_FORK, &imap);
 	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags,
-				 shared ? IOMAP_F_SHARED : 0);
+				 shared ? IOMAP_F_SHARED : 0, seq);
 }
 
 const struct iomap_ops xfs_read_iomap_ops = {
@@ -1237,6 +1287,7 @@ xfs_seek_iomap_begin(
 	struct xfs_bmbt_irec	imap, cmap;
 	int			error = 0;
 	unsigned		lockmode;
+	u64			seq;
 
 	if (xfs_is_shutdown(mp))
 		return -EIO;
@@ -1271,8 +1322,9 @@ xfs_seek_iomap_begin(
 		if (data_fsb < cow_fsb + cmap.br_blockcount)
 			end_fsb = min(end_fsb, data_fsb);
 		xfs_trim_extent(&cmap, offset_fsb, end_fsb);
+		seq = xfs_iomap_inode_sequence(ip, IOMAP_F_SHARED);
 		error = xfs_bmbt_to_iomap(ip, iomap, &cmap, flags,
-					  IOMAP_F_SHARED);
+				IOMAP_F_SHARED, seq);
 		/*
 		 * This is a COW extent, so we must probe the page cache
 		 * because there could be dirty page cache being backed
@@ -1293,8 +1345,9 @@ xfs_seek_iomap_begin(
 	imap.br_startblock = HOLESTARTBLOCK;
 	imap.br_state = XFS_EXT_NORM;
 done:
+	seq = xfs_iomap_inode_sequence(ip, 0);
 	xfs_trim_extent(&imap, offset_fsb, end_fsb);
-	error = xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0);
+	error = xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0, seq);
 out_unlock:
 	xfs_iunlock(ip, lockmode);
 	return error;
@@ -1320,6 +1373,7 @@ xfs_xattr_iomap_begin(
 	struct xfs_bmbt_irec	imap;
 	int			nimaps = 1, error = 0;
 	unsigned		lockmode;
+	int			seq;
 
 	if (xfs_is_shutdown(mp))
 		return -EIO;
@@ -1336,12 +1390,14 @@ xfs_xattr_iomap_begin(
 	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb, &imap,
 			       &nimaps, XFS_BMAPI_ATTRFORK);
 out_unlock:
+
+	seq = xfs_iomap_inode_sequence(ip, IOMAP_F_XATTR);
 	xfs_iunlock(ip, lockmode);
 
 	if (error)
 		return error;
 	ASSERT(nimaps);
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0);
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, IOMAP_F_XATTR, seq);
 }
 
 const struct iomap_ops xfs_xattr_iomap_ops = {
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index 0f62ab633040..4da13440bae9 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -13,14 +13,15 @@ struct xfs_bmbt_irec;
 
 int xfs_iomap_write_direct(struct xfs_inode *ip, xfs_fileoff_t offset_fsb,
 		xfs_fileoff_t count_fsb, unsigned int flags,
-		struct xfs_bmbt_irec *imap);
+		struct xfs_bmbt_irec *imap, u64 *sequence);
 int xfs_iomap_write_unwritten(struct xfs_inode *, xfs_off_t, xfs_off_t, bool);
 xfs_fileoff_t xfs_iomap_eof_align_last_fsb(struct xfs_inode *ip,
 		xfs_fileoff_t end_fsb);
 
+u64 xfs_iomap_inode_sequence(struct xfs_inode *ip, u16 iomap_flags);
 int xfs_bmbt_to_iomap(struct xfs_inode *ip, struct iomap *iomap,
 		struct xfs_bmbt_irec *imap, unsigned int mapping_flags,
-		u16 iomap_flags);
+		u16 iomap_flags, u64 sequence_cookie);
 
 int xfs_zero_range(struct xfs_inode *ip, loff_t pos, loff_t len,
 		bool *did_zero);
diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
index 37a24f0f7cd4..38d23f0e703a 100644
--- a/fs/xfs/xfs_pnfs.c
+++ b/fs/xfs/xfs_pnfs.c
@@ -125,6 +125,7 @@ xfs_fs_map_blocks(
 	int			nimaps = 1;
 	uint			lock_flags;
 	int			error = 0;
+	u64			seq;
 
 	if (xfs_is_shutdown(mp))
 		return -EIO;
@@ -176,6 +177,7 @@ xfs_fs_map_blocks(
 	lock_flags = xfs_ilock_data_map_shared(ip);
 	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb,
 				&imap, &nimaps, bmapi_flags);
+	seq = xfs_iomap_inode_sequence(ip, 0);
 
 	ASSERT(!nimaps || imap.br_startblock != DELAYSTARTBLOCK);
 
@@ -189,7 +191,7 @@ xfs_fs_map_blocks(
 		xfs_iunlock(ip, lock_flags);
 
 		error = xfs_iomap_write_direct(ip, offset_fsb,
-				end_fsb - offset_fsb, 0, &imap);
+				end_fsb - offset_fsb, 0, &imap, &seq);
 		if (error)
 			goto out_unlock;
 
@@ -209,7 +211,7 @@ xfs_fs_map_blocks(
 	}
 	xfs_iunlock(ip, XFS_IOLOCK_EXCL);
 
-	error = xfs_bmbt_to_iomap(ip, iomap, &imap, 0, 0);
+	error = xfs_bmbt_to_iomap(ip, iomap, &imap, 0, 0, seq);
 	*device_generation = mp->m_generation;
 	return error;
 out_unlock:
-- 
2.37.2

