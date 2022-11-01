Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AB2614258
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 01:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiKAAec (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 20:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiKAAeW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 20:34:22 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB09615FC2
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 17:34:20 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d24so12187289pls.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 17:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHAzErwNVUuW7SwA2H3HgNg6ehcqGAE2cIaQYUuXWTY=;
        b=HRoy0hUhou5cxIn9OqcnqxWhUhZZE/wEtmN0B4AA2cwafqhqDI5lAKdUCkXwwVgrdh
         X9XnegJcUCZgxjtCOsczNHHtn1u3Ft9z0icQ/2zDtRGxi5SXqFETaZ17CKtdmIzaOM3h
         akNaPAnlmBiND16H4jzhok6kHW0Plb+iAWoAmVsbLj5pvW9Oaospod3jI2SgyEW7T4vi
         DYN+n+VveMmMlHRCte8t2qg1NfSP/gFeDczZSMc4skbmTJlFVrvYuaBkCywND3b1QrSp
         Qd1chrg5reGDpdvcNaqZJmAJmJyaEyUjXr2Uw5Uc8qSRDLTlBPBQcohphesjqCfwuCkg
         jXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RHAzErwNVUuW7SwA2H3HgNg6ehcqGAE2cIaQYUuXWTY=;
        b=DVKe+OYoYZphN5SZkLl63Xl0qnIe7pOfFlSezwliMS90gv8oaLBOyUqKL1AeTxVHIe
         E/2S72wFsc62t9JiEQjbKj3VfBe65Q49Tsif/hVFtxM1/9pPEMmh4vaZKB5d/y0rwRDC
         eIXk+Tnuo0LtyxLwSVVpC2h/meccEbxpKPPh9cgkByddHJXleKUY9j+Al9MGAoQXGm0b
         YjGtSBgf1RKfL5C+oh1SuRRpjQ6b+Sz/Yd7d5+tMGBu+SXLG0oa3IqnAfAPYt4wLYKHp
         w3KSw4mWatu1zKiENNSmhVFfj7MQlA8LpFvR7LBF6Aqc+N+jVkhsVE8Wh6L0FIwyzMmo
         Hb/Q==
X-Gm-Message-State: ACrzQf05+oF5hXr0Kzf7rkrUQvyRf5QVSmthDeHd18n+9jfI6eYW5nVP
        Yg/NU+AcxE6pzCG+5UF7aTcHzzAoqXivQA==
X-Google-Smtp-Source: AMsMyM4TW2mp78RxqU7H/uF7H13bro2scrrdFsQQcpq8+1X68AZ3M/txl90MjV0h60EBejV7Th+U5w==
X-Received: by 2002:a17:90b:2651:b0:20a:daaf:75f0 with SMTP id pa17-20020a17090b265100b0020adaaf75f0mr16989549pjb.142.1667262860129;
        Mon, 31 Oct 2022 17:34:20 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id i2-20020a170902cf0200b0018699e6afd8sm4998414plg.265.2022.10.31.17.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 17:34:19 -0700 (PDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1opfEN-008muT-8i; Tue, 01 Nov 2022 11:34:15 +1100
Received: from dave by discord.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1opfEN-00G7du-0k;
        Tue, 01 Nov 2022 11:34:15 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/7] xfs: use iomap_valid method to detect stale cached iomaps
Date:   Tue,  1 Nov 2022 11:34:11 +1100
Message-Id: <20221101003412.3842572-7-david@fromorbit.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221101003412.3842572-1-david@fromorbit.com>
References: <20221101003412.3842572-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/libxfs/xfs_bmap.c |  4 +--
 fs/xfs/xfs_aops.c        |  2 +-
 fs/xfs/xfs_iomap.c       | 69 ++++++++++++++++++++++++++++++----------
 fs/xfs/xfs_iomap.h       |  4 +--
 fs/xfs/xfs_pnfs.c        |  5 +--
 5 files changed, 61 insertions(+), 23 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 49d0d4ea63fc..db225130618c 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -4551,8 +4551,8 @@ xfs_bmapi_convert_delalloc(
 	 * the extent.  Just return the real extent at this offset.
 	 */
 	if (!isnullstartblock(bma.got.br_startblock)) {
-		xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags);
 		*seq = READ_ONCE(ifp->if_seq);
+		xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags, *seq);
 		goto out_trans_cancel;
 	}
 
@@ -4599,8 +4599,8 @@ xfs_bmapi_convert_delalloc(
 	XFS_STATS_INC(mp, xs_xstrat_quick);
 
 	ASSERT(!isnullstartblock(bma.got.br_startblock));
-	xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags);
 	*seq = READ_ONCE(ifp->if_seq);
+	xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags, *seq);
 
 	if (whichfork == XFS_COW_FORK)
 		xfs_refcount_alloc_cow_extent(tp, bma.blkno, bma.length);
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 5d1a995b15f8..ca5a9e45a48c 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -373,7 +373,7 @@ xfs_map_blocks(
 	    isnullstartblock(imap.br_startblock))
 		goto allocate_blocks;
 
-	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, 0);
+	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, 0, XFS_WPC(wpc)->data_seq);
 	trace_xfs_map_blocks_found(ip, offset, count, whichfork, &imap);
 	return 0;
 allocate_blocks:
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 2d48fcc7bd6f..5053ffcf10fe 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -54,7 +54,8 @@ xfs_bmbt_to_iomap(
 	struct iomap		*iomap,
 	struct xfs_bmbt_irec	*imap,
 	unsigned int		mapping_flags,
-	u16			iomap_flags)
+	u16			iomap_flags,
+	int			sequence)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
@@ -91,6 +92,9 @@ xfs_bmbt_to_iomap(
 	if (xfs_ipincount(ip) &&
 	    (ip->i_itemp->ili_fsync_fields & ~XFS_ILOG_TIMESTAMP))
 		iomap->flags |= IOMAP_F_DIRTY;
+
+	/* The extent tree sequence is needed for iomap validity checking. */
+	*((int *)&iomap->private) = sequence;
 	return 0;
 }
 
@@ -195,7 +199,8 @@ xfs_iomap_write_direct(
 	xfs_fileoff_t		offset_fsb,
 	xfs_fileoff_t		count_fsb,
 	unsigned int		flags,
-	struct xfs_bmbt_irec	*imap)
+	struct xfs_bmbt_irec	*imap,
+	int			*seq)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_trans	*tp;
@@ -285,6 +290,8 @@ xfs_iomap_write_direct(
 		error = xfs_alert_fsblock_zero(ip, imap);
 
 out_unlock:
+	if (seq)
+		*seq = READ_ONCE(ip->i_df.if_seq);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	return error;
 
@@ -743,6 +750,7 @@ xfs_direct_write_iomap_begin(
 	bool			shared = false;
 	u16			iomap_flags = 0;
 	unsigned int		lockmode = XFS_ILOCK_SHARED;
+	int			seq;
 
 	ASSERT(flags & (IOMAP_WRITE | IOMAP_ZERO));
 
@@ -811,9 +819,10 @@ xfs_direct_write_iomap_begin(
 			goto out_unlock;
 	}
 
+	seq = READ_ONCE(ip->i_df.if_seq);
 	xfs_iunlock(ip, lockmode);
 	trace_xfs_iomap_found(ip, offset, length, XFS_DATA_FORK, &imap);
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, iomap_flags);
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, iomap_flags, seq);
 
 allocate_blocks:
 	error = -EAGAIN;
@@ -839,24 +848,25 @@ xfs_direct_write_iomap_begin(
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
+	seq = READ_ONCE(ip->i_df.if_seq);
 	xfs_iunlock(ip, lockmode);
 	length = XFS_FSB_TO_B(mp, cmap.br_startoff + cmap.br_blockcount);
 	trace_xfs_iomap_found(ip, offset, length - offset, XFS_COW_FORK, &cmap);
 	if (imap.br_startblock != HOLESTARTBLOCK) {
-		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0);
+		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0, seq);
 		if (error)
 			return error;
 	}
-	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED);
+	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED, seq);
 
 out_unlock:
 	if (lockmode)
@@ -915,6 +925,7 @@ xfs_buffered_write_iomap_begin(
 	int			allocfork = XFS_DATA_FORK;
 	int			error = 0;
 	unsigned int		lockmode = XFS_ILOCK_EXCL;
+	int			seq;
 
 	if (xfs_is_shutdown(mp))
 		return -EIO;
@@ -1094,26 +1105,29 @@ xfs_buffered_write_iomap_begin(
 	 * Flag newly allocated delalloc blocks with IOMAP_F_NEW so we punch
 	 * them out if the write happens to fail.
 	 */
+	seq = READ_ONCE(ip->i_df.if_seq);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	trace_xfs_iomap_alloc(ip, offset, count, allocfork, &imap);
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, IOMAP_F_NEW);
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, IOMAP_F_NEW, seq);
 
 found_imap:
+	seq = READ_ONCE(ip->i_df.if_seq);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0);
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0, seq);
 
 found_cow:
+	seq = READ_ONCE(ip->i_df.if_seq);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	if (imap.br_startoff <= offset_fsb) {
-		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0);
+		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0, seq);
 		if (error)
 			return error;
 		return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags,
-					 IOMAP_F_SHARED);
+					 IOMAP_F_SHARED, seq);
 	}
 
 	xfs_trim_extent(&cmap, offset_fsb, imap.br_startoff - offset_fsb);
-	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, 0);
+	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, 0, seq);
 
 out_unlock:
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
@@ -1328,9 +1342,26 @@ xfs_buffered_write_iomap_end(
 	return 0;
 }
 
+/*
+ * Check that the iomap passed to us is still valid for the given offset and
+ * length.
+ */
+static bool
+xfs_buffered_write_iomap_valid(
+	struct inode		*inode,
+	const struct iomap	*iomap)
+{
+	int			seq = *((int *)&iomap->private);
+
+	if (seq != READ_ONCE(XFS_I(inode)->i_df.if_seq))
+		return false;
+	return true;
+}
+
 const struct iomap_ops xfs_buffered_write_iomap_ops = {
 	.iomap_begin		= xfs_buffered_write_iomap_begin,
 	.iomap_end		= xfs_buffered_write_iomap_end,
+	.iomap_valid		= xfs_buffered_write_iomap_valid,
 };
 
 /*
@@ -1359,6 +1390,7 @@ xfs_read_iomap_begin(
 	int			nimaps = 1, error = 0;
 	bool			shared = false;
 	unsigned int		lockmode = XFS_ILOCK_SHARED;
+	int			seq;
 
 	ASSERT(!(flags & (IOMAP_WRITE | IOMAP_ZERO)));
 
@@ -1372,13 +1404,14 @@ xfs_read_iomap_begin(
 			       &nimaps, 0);
 	if (!error && (flags & IOMAP_REPORT))
 		error = xfs_reflink_trim_around_shared(ip, &imap, &shared);
+	seq = READ_ONCE(ip->i_df.if_seq);
 	xfs_iunlock(ip, lockmode);
 
 	if (error)
 		return error;
 	trace_xfs_iomap_found(ip, offset, length, XFS_DATA_FORK, &imap);
 	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags,
-				 shared ? IOMAP_F_SHARED : 0);
+				 shared ? IOMAP_F_SHARED : 0, seq);
 }
 
 const struct iomap_ops xfs_read_iomap_ops = {
@@ -1438,7 +1471,7 @@ xfs_seek_iomap_begin(
 			end_fsb = min(end_fsb, data_fsb);
 		xfs_trim_extent(&cmap, offset_fsb, end_fsb);
 		error = xfs_bmbt_to_iomap(ip, iomap, &cmap, flags,
-					  IOMAP_F_SHARED);
+				IOMAP_F_SHARED, READ_ONCE(ip->i_cowfp->if_seq));
 		/*
 		 * This is a COW extent, so we must probe the page cache
 		 * because there could be dirty page cache being backed
@@ -1460,7 +1493,8 @@ xfs_seek_iomap_begin(
 	imap.br_state = XFS_EXT_NORM;
 done:
 	xfs_trim_extent(&imap, offset_fsb, end_fsb);
-	error = xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0);
+	error = xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0,
+			READ_ONCE(ip->i_df.if_seq));
 out_unlock:
 	xfs_iunlock(ip, lockmode);
 	return error;
@@ -1486,6 +1520,7 @@ xfs_xattr_iomap_begin(
 	struct xfs_bmbt_irec	imap;
 	int			nimaps = 1, error = 0;
 	unsigned		lockmode;
+	int			seq;
 
 	if (xfs_is_shutdown(mp))
 		return -EIO;
@@ -1502,12 +1537,14 @@ xfs_xattr_iomap_begin(
 	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb, &imap,
 			       &nimaps, XFS_BMAPI_ATTRFORK);
 out_unlock:
+
+	seq = READ_ONCE(ip->i_af.if_seq);
 	xfs_iunlock(ip, lockmode);
 
 	if (error)
 		return error;
 	ASSERT(nimaps);
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0);
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0, seq);
 }
 
 const struct iomap_ops xfs_xattr_iomap_ops = {
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index 0f62ab633040..792fed2a9072 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -13,14 +13,14 @@ struct xfs_bmbt_irec;
 
 int xfs_iomap_write_direct(struct xfs_inode *ip, xfs_fileoff_t offset_fsb,
 		xfs_fileoff_t count_fsb, unsigned int flags,
-		struct xfs_bmbt_irec *imap);
+		struct xfs_bmbt_irec *imap, int *sequence);
 int xfs_iomap_write_unwritten(struct xfs_inode *, xfs_off_t, xfs_off_t, bool);
 xfs_fileoff_t xfs_iomap_eof_align_last_fsb(struct xfs_inode *ip,
 		xfs_fileoff_t end_fsb);
 
 int xfs_bmbt_to_iomap(struct xfs_inode *ip, struct iomap *iomap,
 		struct xfs_bmbt_irec *imap, unsigned int mapping_flags,
-		u16 iomap_flags);
+		u16 iomap_flags, int sequence);
 
 int xfs_zero_range(struct xfs_inode *ip, loff_t pos, loff_t len,
 		bool *did_zero);
diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
index 37a24f0f7cd4..eea507a80c5c 100644
--- a/fs/xfs/xfs_pnfs.c
+++ b/fs/xfs/xfs_pnfs.c
@@ -125,6 +125,7 @@ xfs_fs_map_blocks(
 	int			nimaps = 1;
 	uint			lock_flags;
 	int			error = 0;
+	int			seq;
 
 	if (xfs_is_shutdown(mp))
 		return -EIO;
@@ -189,7 +190,7 @@ xfs_fs_map_blocks(
 		xfs_iunlock(ip, lock_flags);
 
 		error = xfs_iomap_write_direct(ip, offset_fsb,
-				end_fsb - offset_fsb, 0, &imap);
+				end_fsb - offset_fsb, 0, &imap, &seq);
 		if (error)
 			goto out_unlock;
 
@@ -209,7 +210,7 @@ xfs_fs_map_blocks(
 	}
 	xfs_iunlock(ip, XFS_IOLOCK_EXCL);
 
-	error = xfs_bmbt_to_iomap(ip, iomap, &imap, 0, 0);
+	error = xfs_bmbt_to_iomap(ip, iomap, &imap, 0, 0, seq);
 	*device_generation = mp->m_generation;
 	return error;
 out_unlock:
-- 
2.37.2

