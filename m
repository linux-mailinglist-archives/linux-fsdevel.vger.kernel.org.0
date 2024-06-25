Return-Path: <linux-fsdevel+bounces-22332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 702A2916684
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 13:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD3228A7FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 11:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2513153506;
	Tue, 25 Jun 2024 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="JUEjC0St"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9927114AD38;
	Tue, 25 Jun 2024 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719315910; cv=none; b=gZ3p5a3+P3mIkaxiDlr1MTn2xu5w5o1OhdUc6fzeKtCTrFHP3R6RzVtIxnMj7sRnCVLAUTfH8mF5EzemMrenjkdJ72tX3kfjepFMCLjVuTHN/YSgWcSSRlRgawDqZXWhqS5TORLhoTNhUjDhdowN8Q/MgsTwMtzxoEplR/cwWN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719315910; c=relaxed/simple;
	bh=O0/2LUKfYiFUblD3u9m7Y13StU5ozfkcPwrLPBl3W0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGHYDSeqPaFwelrIymKB42ReuVOIhoAsxHTc/eMLV7ve7QiuuF5T5p2S73pq6gqFVd+cJ70coLeDK7iakaSIThlzope4t2Vvec3uXdpP/1CUWhy8RLj+lSNd2wusgvuaJHj0QVnw4zLFP92xW2tslLCUk2P6tXrzBldcRDBOfVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=JUEjC0St; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W7jgN6pNYz9spK;
	Tue, 25 Jun 2024 13:45:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1719315905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fyS4GVf4PvByyE0IUbrr3l1s3P7v70XANt/sXrYXYDk=;
	b=JUEjC0StwOgXBgGlDaXdgJYKqaINIckvwir1VzS6vaPsaIuGOoRoH4bIEBnAPSiFaBTsij
	Wg2CeEeSf29wU8MOtLW7DEWlkJx7/q2myVSyUGY5xc9IZvT+AKXe2l99KwhqW1jGBua1DY
	PO4ofn3aJAnp4NBPB0RiKD2wMATzgAVn0gOz1gYoxGohcI4Odo85hvIEI/JYspGsH/3XKh
	bgJrG01RH+pzSMq8l41ho4jHg0lItICn8DvmfnmldRRQAMKy7e/U573JD1xzBsoh4GFzkh
	Pii6SUSGTYeX37Tx0bkk7i3xlrnBQ5+9hkU5tj7xhJ8HJ/fGXAPpPx5/7kqEzA==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: david@fromorbit.com,
	willy@infradead.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	brauner@kernel.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com,
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
	Zi Yan <zi.yan@sent.com>
Subject: [PATCH v8 10/10] xfs: enable block size larger than page size support
Date: Tue, 25 Jun 2024 11:44:20 +0000
Message-ID: <20240625114420.719014-11-kernel@pankajraghav.com>
In-Reply-To: <20240625114420.719014-1-kernel@pankajraghav.com>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
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

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
@hch and @Dave I have retained the min_folio_order to be in the inode
struct as the discussion about moving this to xfs_mount is still open.

 fs/xfs/libxfs/xfs_ialloc.c |  5 +++++
 fs/xfs/libxfs/xfs_shared.h |  3 +++
 fs/xfs/xfs_icache.c        |  6 ++++--
 fs/xfs/xfs_mount.c         |  1 -
 fs/xfs/xfs_super.c         | 18 ++++++++++--------
 5 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
index 14c81f227c5b..1e76431d75a4 100644
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
index 34f104ed372c..e67a1c7cc0b0 100644
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
index 088ac200b026..e0f911f326e6 100644
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
index 3949f720b535..c6933440f806 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -134,7 +134,6 @@ xfs_sb_validate_fsb_count(
 {
 	uint64_t		max_bytes;
 
-	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
 	ASSERT(sbp->sb_blocklog >= BBSHIFT);
 
 	if (check_shl_overflow(nblocks, sbp->sb_blocklog, &max_bytes))
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 27e9f749c4c7..b8a93a8f35ca 100644
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


