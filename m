Return-Path: <linux-fsdevel+bounces-14311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4012F87AF2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715A61C25253
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CD719A58D;
	Wed, 13 Mar 2024 17:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="Qsht05+U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1780019A56A;
	Wed, 13 Mar 2024 17:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349424; cv=none; b=qEOGB3w0Rb6DOrK0TxK6LjA5jOywhgViD8w517wOK7yTxx21mqi8lCt41+LaJoHIaqVe00TGpXvbTks+Fgish6Syfb3VMTMuPcy07MqnFAlkuTg43+tOAIwMNFxfxUeYInL5kNMlFUaCK6nk07h9Z8WOIF6MYaKY2nEIQ3wL/P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349424; c=relaxed/simple;
	bh=3L4GbT2GGY6ZkVB0Gbmb4Xhq7Pezq97Uzm/KdVsUIvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aIYuPuy2L5vPXnb0ZY8sPafwDYe3mETGWRhNeRff+hHfSuxbCwnRe1KgRbIhwyjeiFW+o0JWbAjgYh7U/fDnf1TZ6n4iXOoKSyfuyaht+8ksbmv3jPQNUMTeR01RezyUFvyI68QlmkKBGeJvPTEZFu58SFRVKFMT3AP6I0FCmLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=Qsht05+U; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Tvxfz2mzqz9srv;
	Wed, 13 Mar 2024 18:03:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1710349419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K/DUVmmSdMYXfogG3VkAiYhU6qYgNVi5gtPJ5i04LEI=;
	b=Qsht05+Uu/iP54oqngBXP2qLeNxikfv1Eh/QI13SRmymWufjW1qsMdPY+89rtgm6i4g39y
	SWW8c6kh0MkZTAY9/vDjZV0NUuGdfEDYIvP8SiXji0DUHluzyiOXftszOjn9q5H1LKy/1C
	Wmuim/RYXM+z/vXQclsx99izmsENZc4h3Rx1QHNx1sH/37t7Egj0nIEXHyTQVY2eGhYv6O
	juM46526/LJPKkmSZaGglSY7Z+d/pVduLN+qUMl02bRL2+VEd2C2B1ztr6Pz8AjlF74Dwr
	r544zElg3fjru2Ijy1ZG+m2sSurj0ux4aO+w3OnINoA1SJvA+sNnSqIZUgG9Vg==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: willy@infradead.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: gost.dev@samsung.com,
	chandan.babu@oracle.com,
	hare@suse.de,
	mcgrof@kernel.org,
	djwong@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	david@fromorbit.com,
	akpm@linux-foundation.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v3 11/11] xfs: enable block size larger than page size support
Date: Wed, 13 Mar 2024 18:02:53 +0100
Message-ID: <20240313170253.2324812-12-kernel@pankajraghav.com>
In-Reply-To: <20240313170253.2324812-1-kernel@pankajraghav.com>
References: <20240313170253.2324812-1-kernel@pankajraghav.com>
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
---
 fs/xfs/libxfs/xfs_ialloc.c |  5 +++++
 fs/xfs/libxfs/xfs_shared.h |  3 +++
 fs/xfs/xfs_icache.c        |  6 ++++--
 fs/xfs/xfs_mount.c         |  1 -
 fs/xfs/xfs_super.c         | 10 ++--------
 5 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
index 2361a22035b0..c040bd6271fd 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -2892,6 +2892,11 @@ xfs_ialloc_setup_geometry(
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
index 4220d3584c1b..67ed406e7a81 100644
--- a/fs/xfs/libxfs/xfs_shared.h
+++ b/fs/xfs/libxfs/xfs_shared.h
@@ -188,6 +188,9 @@ struct xfs_ino_geometry {
 	/* precomputed value for di_flags2 */
 	uint64_t	new_diflags2;
 
+	/* minimum folio order of a page cache allocation */
+	unsigned int	min_folio_order;
+
 };
 
 #endif /* __XFS_SHARED_H__ */
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index dba514a2c84d..a1857000e2cd 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -88,7 +88,8 @@ xfs_inode_alloc(
 	/* VFS doesn't initialise i_mode or i_state! */
 	VFS_I(ip)->i_mode = 0;
 	VFS_I(ip)->i_state = 0;
-	mapping_set_large_folios(VFS_I(ip)->i_mapping);
+	mapping_set_folio_min_order(VFS_I(ip)->i_mapping,
+				    M_IGEO(mp)->min_folio_order);
 
 	XFS_STATS_INC(mp, vn_active);
 	ASSERT(atomic_read(&ip->i_pincount) == 0);
@@ -323,7 +324,8 @@ xfs_reinit_inode(
 	inode->i_rdev = dev;
 	inode->i_uid = uid;
 	inode->i_gid = gid;
-	mapping_set_large_folios(inode->i_mapping);
+	mapping_set_folio_min_order(inode->i_mapping,
+				    M_IGEO(mp)->min_folio_order);
 	return error;
 }
 
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 9cf800586da7..a77e927807e5 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -131,7 +131,6 @@ xfs_sb_validate_fsb_count(
 	xfs_sb_t	*sbp,
 	uint64_t	nblocks)
 {
-	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
 	ASSERT(sbp->sb_blocklog >= BBSHIFT);
 	uint64_t max_index;
 	uint64_t max_bytes;
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 98401de832ee..4f5f4cb772d4 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1624,16 +1624,10 @@ xfs_fs_fill_super(
 		goto out_free_sb;
 	}
 
-	/*
-	 * Until this is fixed only page-sized or smaller data blocks work.
-	 */
 	if (mp->m_sb.sb_blocksize > PAGE_SIZE) {
 		xfs_warn(mp,
-		"File system with blocksize %d bytes. "
-		"Only pagesize (%ld) or less will currently work.",
-				mp->m_sb.sb_blocksize, PAGE_SIZE);
-		error = -ENOSYS;
-		goto out_free_sb;
+"EXPERIMENTAL: Filesystem with Large Block Size (%d bytes) enabled.",
+			mp->m_sb.sb_blocksize);
 	}
 
 	/* Ensure this filesystem fits in the page cache limits */
-- 
2.43.0


