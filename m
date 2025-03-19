Return-Path: <linux-fsdevel+bounces-44411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48885A685CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 08:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E81E98801D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 07:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BDF2500DF;
	Wed, 19 Mar 2025 07:31:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A054942A83;
	Wed, 19 Mar 2025 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742369461; cv=none; b=MpS/er//W/mk9VYK6jqzKe/59W4qR9KIQ7KY4KfYx+GzOZaqGd6UN3qOF/CzpYzZBr52RaM/gV022ffZNHtmPBnVA4Tyz8aPmKLzAH0OcJmfHp5yFI76S/4haF8JxZqaUUlaQBBOl3TJvwOZJpDNyrjWVKb6SCorhXyktcFt8ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742369461; c=relaxed/simple;
	bh=Sx2CVp5grQK0BXk7nLN+dSXLCrxu/lOLQuTNVw2MMIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8R4Hzwh5gF6kt+yuyCQRALahcuQQt4Jibv37c1EZtGl22PlBxSqVb4tjHOM5YMtUn4/0bcpTnWrzs2ltNlIIDqRNw+3TemypUZv++ipkedXULUvj5SiQJI9UXcEOBsSlWfIiRKHPmt5PlOC/6mkfnIwhZXROJl+saK3AYlCZUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 70C9B68BFE; Wed, 19 Mar 2025 08:30:46 +0100 (CET)
Date: Wed, 19 Mar 2025 08:30:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, brauner@kernel.org, djwong@kernel.org,
	cem@kernel.org, dchinner@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v6 10/13] xfs: iomap COW-based atomic write support
Message-ID: <20250319073045.GA25373@lst.de>
References: <20250313171310.1886394-1-john.g.garry@oracle.com> <20250313171310.1886394-11-john.g.garry@oracle.com> <Z9fOoE3LxcLNcddh@infradead.org> <eb7a6175-5637-4ea6-a08c-14776aa67d8b@oracle.com> <20250318053906.GD14470@lst.de> <eff45548-df5a-469b-a4ee-6d09845c86e2@oracle.com> <20250318083203.GA18902@lst.de> <de3f6e25-851a-4ed7-9511-397270785794@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de3f6e25-851a-4ed7-9511-397270785794@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 18, 2025 at 05:44:46PM +0000, John Garry wrote:
> Please suggest any further modifications to the following attempt. I have 
> XFS_REFLINK_FORCE_COW still being passed to xfs_reflink_fill_cow_hole(), 
> but xfs_reflink_fill_cow_hole() is quite a large function and I am not sure 
> if I want to duplicate lots of it.

As said I'd do away with the helpers.  Below is my completely
untested whiteboard coding attempt, based against the series you
sent out.

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 88d86cabb8a1..06ece7070cfd 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1083,67 +1083,104 @@ xfs_atomic_write_cow_iomap_begin(
 	struct iomap		*iomap,
 	struct iomap		*srcmap)
 {
-	ASSERT(flags & IOMAP_WRITE);
-	ASSERT(flags & IOMAP_DIRECT);
-
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
-	struct xfs_bmbt_irec	imap, cmap;
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
 	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
-	int			nimaps = 1, error;
-	bool			shared = false;
-	unsigned int		lockmode = XFS_ILOCK_EXCL;
+	xfs_filblks_t		count_fsb = end_fsb - offset_fsb;
+	int			nmaps = 1;
+	xfs_filblks_t		resaligned;
+	struct xfs_bmbt_irec	cmap;
+	struct xfs_iext_cursor	icur;
+	struct xfs_trans	*tp;
+	int			error;
 	u64			seq;
 
+	ASSERT(!XFS_IS_REALTIME_INODE(ip));
+	ASSERT(flags & IOMAP_WRITE);
+	ASSERT(flags & IOMAP_DIRECT);
+
 	if (xfs_is_shutdown(mp))
 		return -EIO;
 
-	if (!xfs_has_reflink(mp))
+	if (WARN_ON_ONCE(!xfs_has_reflink(mp)))
 		return -EINVAL;
 
-	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+
+	if (!ip->i_cowfp) {
+		ASSERT(!xfs_is_reflink_inode(ip));
+		xfs_ifork_init_cow(ip);
+	}
+
+	/*
+	 * If we don't find an overlapping extent, trim the range we need to
+	 * allocate to fit the hole we found.
+	 */
+	if (!xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, &cmap))
+		cmap.br_startoff = end_fsb;
+	if (cmap.br_startoff <= offset_fsb) {
+		xfs_trim_extent(&cmap, offset_fsb, count_fsb);
+		goto found;
+	}
+
+	end_fsb = cmap.br_startoff;
+	count_fsb = end_fsb - offset_fsb;
+	resaligned = xfs_aligned_fsb_count(offset_fsb, count_fsb,
+			xfs_get_cowextsz_hint(ip));
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+
+	error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_write,
+			XFS_DIOSTRAT_SPACE_RES(mp, resaligned), 0, false, &tp);
 	if (error)
 		return error;
 
-	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb, &imap,
-			&nimaps, 0);
-	if (error)
-		goto out_unlock;
+	if (!xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, &cmap))
+		cmap.br_startoff = end_fsb;
+	if (cmap.br_startoff <= offset_fsb) {
+		xfs_trim_extent(&cmap, offset_fsb, count_fsb);
+		xfs_trans_cancel(tp);
+		goto found;
+	}
 
-	 /*
-	  * Use XFS_REFLINK_ALLOC_EXTSZALIGN to hint at aligning new extents
-	  * according to extszhint, such that there will be a greater chance
-	  * that future atomic writes to that same range will be aligned (and
-	  * don't require this COW-based method).
-	  */
-	error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
-			&lockmode, XFS_REFLINK_CONVERT_UNWRITTEN |
-			XFS_REFLINK_FORCE_COW | XFS_REFLINK_ALLOC_EXTSZALIGN);
 	/*
-	 * Don't check @shared. For atomic writes, we should error when
-	 * we don't get a COW fork extent mapping.
+	 * Allocate the entire reservation as unwritten blocks.
+	 *
+	 * Use XFS_BMAPI_EXTSZALIGN to hint at aligning new extents according to
+	 * extszhint, such that there will be a greater chance that future
+	 * atomic writes to that same range will be aligned (and don't require
+	 * this COW-based method).
 	 */
-	if (error)
+	error = xfs_bmapi_write(tp, ip, offset_fsb, count_fsb,
+			XFS_BMAPI_COWFORK | XFS_BMAPI_PREALLOC |
+			XFS_BMAPI_EXTSZALIGN, 0, &cmap, &nmaps);
+	if (error) {
+		xfs_trans_cancel(tp);
 		goto out_unlock;
+	}
 
-	end_fsb = imap.br_startoff + imap.br_blockcount;
+	xfs_inode_set_cowblocks_tag(ip);
+	error = xfs_trans_commit(tp);
+	if (error)
+		goto out_unlock;
 
-	length = XFS_FSB_TO_B(mp, cmap.br_startoff + cmap.br_blockcount);
-	trace_xfs_iomap_found(ip, offset, length - offset, XFS_COW_FORK, &cmap);
-	if (imap.br_startblock != HOLESTARTBLOCK) {
-		seq = xfs_iomap_inode_sequence(ip, 0);
-		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0, seq);
+found:
+	if (cmap.br_state != XFS_EXT_NORM) {
+		error = xfs_reflink_convert_cow_locked(ip, offset_fsb,
+				count_fsb);
 		if (error)
 			goto out_unlock;
+		cmap.br_state = XFS_EXT_NORM;
 	}
+
+	length = XFS_FSB_TO_B(mp, cmap.br_startoff + cmap.br_blockcount);
+	trace_xfs_iomap_found(ip, offset, length - offset, XFS_COW_FORK, &cmap);
 	seq = xfs_iomap_inode_sequence(ip, IOMAP_F_SHARED);
-	xfs_iunlock(ip, lockmode);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED, seq);
 
 out_unlock:
-	if (lockmode)
-		xfs_iunlock(ip, lockmode);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	return error;
 }
 
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index b983f5413be6..71116e6a692c 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -293,7 +293,7 @@ xfs_bmap_trim_cow(
 	return xfs_reflink_trim_around_shared(ip, imap, shared);
 }
 
-static int
+int
 xfs_reflink_convert_cow_locked(
 	struct xfs_inode	*ip,
 	xfs_fileoff_t		offset_fsb,
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index 969006661a3f..ab3fa3c95196 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -45,6 +45,8 @@ int xfs_reflink_allocate_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
 		unsigned int flags);
 extern int xfs_reflink_convert_cow(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count);
+int xfs_reflink_convert_cow_locked(struct xfs_inode *ip,
+		xfs_fileoff_t offset_fsb, xfs_filblks_t count_fsb);
 
 extern int xfs_reflink_cancel_cow_blocks(struct xfs_inode *ip,
 		struct xfs_trans **tpp, xfs_fileoff_t offset_fsb,

