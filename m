Return-Path: <linux-fsdevel+bounces-20447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC428D3857
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 15:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2D62B25A81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 13:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9729B5FEE5;
	Wed, 29 May 2024 13:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="XOB+N42p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8325D54FAE;
	Wed, 29 May 2024 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716990370; cv=none; b=ILkCSH/roY0b6jgTOFuIKl/bMSJ0NDS82ZrlDIaqdSuojJyDH0MlejHIhaxu2rkSu9zQx49hGMWLvp39GKhq9uwwoVS98of1DxbxDqaodOiBXDnUiZ79i3Ut0Zrug8THqxgT/5KKGhZFx8x/XGoIuzU6jfvvnR5TiZ7RMm7Lliw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716990370; c=relaxed/simple;
	bh=Bd1DidW1VaQFsu722u8hSC2d9nc3WHgEr4MJCAsqorg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OpBNnOeBoOM/uwLtBkuMB67MGT9AaXtcEqSKYBVkIcJ+LX1E1RhiXNRbQgC2WrQ2bIatshw7wtoqgEmuLB7jezf9UXIo9K6eCZ5vAZzFC7UCcMGpso2YaHnYsLsK9iiDiC0I3f6kaG+1dzhLbei76+rJFSSwX04FQrJkiB9pldM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=XOB+N42p; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Vq9dT0Tshz9shb;
	Wed, 29 May 2024 15:46:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1716990365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CqWeILzukHgisrDT2Qez2BasOK0ht2d7BaH6ApZlpmc=;
	b=XOB+N42pJ9+3yh+2a6EE3JxrNjiMx8gcmgcydGpbQbIokRbFL9n3t1fou4c1PKi/QVZjOS
	dTxNmxENzLyvTp1SXADWg964pMqyPN3GvoMMuBfee0rb00QvHSqiAOuULn+UyqpRJTRgTN
	9e9oJyX7ba+wT93bWncZTvZBfDTMvOZmPihPM4+cO/q40fueOR+XsgPF3Wgq2fBwarvFlU
	zPAKTlze5cXDwRdOdd9G2L1s1oqtTlVZUbyy89yBU89iVhZ2zyAWqcJlR9CK5IIol98vkB
	iFvGPn/UHeDLe6u78yR2gJyiiDC3TA7k7Ux5UUp++B4SSoEcLTqVFSyWzsjLBA==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: david@fromorbit.com,
	chandan.babu@oracle.com,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	willy@infradead.org,
	djwong@kernel.org
Cc: linux-kernel@vger.kernel.org,
	hare@suse.de,
	john.g.garry@oracle.com,
	gost.dev@samsung.com,
	yang@os.amperecomputing.com,
	p.raghav@samsung.com,
	cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org,
	hch@lst.de,
	mcgrof@kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 11/11] xfs: enable block size larger than page size support
Date: Wed, 29 May 2024 15:45:09 +0200
Message-Id: <20240529134509.120826-12-kernel@pankajraghav.com>
In-Reply-To: <20240529134509.120826-1-kernel@pankajraghav.com>
References: <20240529134509.120826-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Vq9dT0Tshz9shb

From: Pankaj Raghav <p.raghav@samsung.com>

Page cache now has the ability to have a minimum order when allocating
a folio which is a prerequisite to add support for block size > page
size.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
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
index 0953163a2d84..5ed3dc9e7d90 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -89,7 +89,8 @@ xfs_inode_alloc(
 	/* VFS doesn't initialise i_mode or i_state! */
 	VFS_I(ip)->i_mode = 0;
 	VFS_I(ip)->i_state = 0;
-	mapping_set_large_folios(VFS_I(ip)->i_mapping);
+	mapping_set_folio_min_order(VFS_I(ip)->i_mapping,
+				    M_IGEO(mp)->min_folio_order);
 
 	XFS_STATS_INC(mp, vn_active);
 	ASSERT(atomic_read(&ip->i_pincount) == 0);
@@ -324,7 +325,8 @@ xfs_reinit_inode(
 	inode->i_rdev = dev;
 	inode->i_uid = uid;
 	inode->i_gid = gid;
-	mapping_set_large_folios(inode->i_mapping);
+	mapping_set_folio_min_order(inode->i_mapping,
+				    M_IGEO(mp)->min_folio_order);
 	return error;
 }
 
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 46cb0384143b..a99454208807 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -135,7 +135,6 @@ xfs_sb_validate_fsb_count(
 	uint64_t		max_index;
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
2.34.1


