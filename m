Return-Path: <linux-fsdevel+bounces-23119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD5D927507
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 13:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85B961F22C61
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 11:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265271AE877;
	Thu,  4 Jul 2024 11:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="oBjypVax"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E421AE86F;
	Thu,  4 Jul 2024 11:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720092251; cv=none; b=j2o+Nd7ua8Zy0WVEu0twi+AcElaYzqiGckPv9gIqZ4/BS6o1c0MkWYFF+RbduFkskYmSs/bg22SjWmIJN+oHGDfFb4YwQDtP5u2gfn0D64Nanba/0Et/ZwTmSUz78Bl9VLjZI9OIpP61Tj3Y3jbGkr5/PzE+quoGw4zdkNPu9MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720092251; c=relaxed/simple;
	bh=XlaxbxnS2KDKk1TtAIjDCXMyoYxUzHIougEGrWOVd74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G256Tu3OMTZOs8zvf3ftJInhTKJW4eHL5XBeOr/7ovMWV3vB9gfpLL4zscsU2WcRvUQ4rUnuig2gNd3LvXSqqbWIlhZX8fe6br0eMg8CiGHjice4ngQaLqLkAkB9xMEvUuMQF/tXDI0YRju3XCUlSQZqcddDCY9TYQpvHVaqo3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=oBjypVax; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WFDn23JWSz9tKk;
	Thu,  4 Jul 2024 13:24:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1720092246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nv7t1+SeZeFQOoZa3NhjLEVFIBlYMe3kqcm8FqgaxW0=;
	b=oBjypVaxqJ1LHw3Y9yNKjm7fdKkn3SIqDFYY6OEEqE+hDdibf+1lIRmUFuqrzhEiB5Vs+h
	4DPN1I9ZeW4p3vRCe7DycD+Be8/UfCPP1PirdIVgPMrsV1g8SRlYGsHAR4ZgknqqqQuIbq
	Vn4dm8CMLGtq5aiEFEOkqeq2+DzBNitczvEVvwmfX5kraSdYuvhu/WlwTCp0xTl6l5LUyb
	brq1I1JnBgyGWOQd5z3M/2FQwpNcq3Wzr/Z/zbr4y9F5JRRroT9IBQW6J63SX4ddhIpY/Y
	C6LnNjsYXkFuk/HdxqO9So4eOxecg4OmSvD/FO6s8uVE1NF3gPQbvL9VhxSb6w==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: david@fromorbit.com,
	willy@infradead.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	brauner@kernel.org,
	akpm@linux-foundation.org
Cc: yang@os.amperecomputing.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org,
	hare@suse.de,
	p.raghav@samsung.com,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org,
	kernel@pankajraghav.com,
	hch@lst.de,
	Zi Yan <ziy@nvidia.com>,
	Dave Chinner <dchinner@redhat.com>
Subject: [PATCH v9 10/10] xfs: enable block size larger than page size support
Date: Thu,  4 Jul 2024 11:23:20 +0000
Message-ID: <20240704112320.82104-11-kernel@pankajraghav.com>
In-Reply-To: <20240704112320.82104-1-kernel@pankajraghav.com>
References: <20240704112320.82104-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

Page cache now has the ability to have a minimum order when allocating
a folio which is a prerequisite to add support for block size > page
size.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/libxfs/xfs_ialloc.c |  5 +++++
 fs/xfs/libxfs/xfs_shared.h |  3 +++
 fs/xfs/xfs_icache.c        |  6 ++++--
 fs/xfs/xfs_mount.c         |  1 -
 fs/xfs/xfs_super.c         | 18 ++++++++++--------
 5 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
index 14c81f227c5bb..1e76431d75a4b 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -3019,6 +3019,11 @@ xfs_ialloc_setup_geometry(
 		igeo->ialloc_align = mp->m_dalign;
 	else
 		igeo->ialloc_align = 0;
+
+	if (mp->m_sb.sb_blocksize > PAGE_SIZE)
+		igeo->min_folio_order = mp->m_sb.sb_blocklog - PAGE_SHIFT;
+	else
+		igeo->min_folio_order = 0;
 }
 
 /* Compute the location of the root directory inode that is laid out by mkfs. */
diff --git a/fs/xfs/libxfs/xfs_shared.h b/fs/xfs/libxfs/xfs_shared.h
index 34f104ed372c0..e67a1c7cc0b02 100644
--- a/fs/xfs/libxfs/xfs_shared.h
+++ b/fs/xfs/libxfs/xfs_shared.h
@@ -231,6 +231,9 @@ struct xfs_ino_geometry {
 	/* precomputed value for di_flags2 */
 	uint64_t	new_diflags2;
 
+	/* minimum folio order of a page cache allocation */
+	unsigned int	min_folio_order;
+
 };
 
 #endif /* __XFS_SHARED_H__ */
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index cf629302d48e7..0fcf235e50235 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -88,7 +88,8 @@ xfs_inode_alloc(
 
 	/* VFS doesn't initialise i_mode! */
 	VFS_I(ip)->i_mode = 0;
-	mapping_set_large_folios(VFS_I(ip)->i_mapping);
+	mapping_set_folio_min_order(VFS_I(ip)->i_mapping,
+				    M_IGEO(mp)->min_folio_order);
 
 	XFS_STATS_INC(mp, vn_active);
 	ASSERT(atomic_read(&ip->i_pincount) == 0);
@@ -325,7 +326,8 @@ xfs_reinit_inode(
 	inode->i_uid = uid;
 	inode->i_gid = gid;
 	inode->i_state = state;
-	mapping_set_large_folios(inode->i_mapping);
+	mapping_set_folio_min_order(inode->i_mapping,
+				    M_IGEO(mp)->min_folio_order);
 	return error;
 }
 
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 3949f720b5354..c6933440f8066 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -134,7 +134,6 @@ xfs_sb_validate_fsb_count(
 {
 	uint64_t		max_bytes;
 
-	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
 	ASSERT(sbp->sb_blocklog >= BBSHIFT);
 
 	if (check_shl_overflow(nblocks, sbp->sb_blocklog, &max_bytes))
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 27e9f749c4c7f..b8a93a8f35cac 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1638,16 +1638,18 @@ xfs_fs_fill_super(
 		goto out_free_sb;
 	}
 
-	/*
-	 * Until this is fixed only page-sized or smaller data blocks work.
-	 */
 	if (mp->m_sb.sb_blocksize > PAGE_SIZE) {
-		xfs_warn(mp,
-		"File system with blocksize %d bytes. "
-		"Only pagesize (%ld) or less will currently work.",
+		if (!xfs_has_crc(mp)) {
+			xfs_warn(mp,
+"V4 Filesystem with blocksize %d bytes. Only pagesize (%ld) or less is supported.",
 				mp->m_sb.sb_blocksize, PAGE_SIZE);
-		error = -ENOSYS;
-		goto out_free_sb;
+			error = -ENOSYS;
+			goto out_free_sb;
+		}
+
+		xfs_warn(mp,
+"EXPERIMENTAL: V5 Filesystem with Large Block Size (%d bytes) enabled.",
+			mp->m_sb.sb_blocksize);
 	}
 
 	/* Ensure this filesystem fits in the page cache limits */
-- 
2.44.1


