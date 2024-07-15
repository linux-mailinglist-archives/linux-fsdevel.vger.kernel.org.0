Return-Path: <linux-fsdevel+bounces-23676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E91F59311A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 11:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1724D1C2220F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 09:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4A0189F5E;
	Mon, 15 Jul 2024 09:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="pEoF3Vcs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D17B189F4F;
	Mon, 15 Jul 2024 09:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721036763; cv=none; b=HTckmHpjFpQsRO6oWVUs05zEP3qFSsRjcGm+7JxJ9zPCsU3pLWakvRGmSjtnEupoAekFFEu/VX+VixhlgixZtecfkAvE1/sOuo7PL9OlMy25eQegcpEkYWYuULhxSI/Fb4jb/HFZNW6vhnnICpH+iRvRYNUqxf/LDCWNGCkwE1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721036763; c=relaxed/simple;
	bh=CC2Eef9nMA8UH8t/TvX52lTN18nJJisIAw8Us/eeEF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjbVbpKGFTABtLuSGJgv1lkVSKIsnazgB1kNW9iqTnG3dFCzWaaxLrEjqvJbsOtpCUdw+crJM7HMCy0j2cUa6iKhWDkOFp+B3Sb4mITbn6IiAZksKTQ5U6M9Ht57YWq2S+EVAVLAqv3WYTA7mVikQMEmZsrCatM7jYB9afGYuIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=pEoF3Vcs; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WMy4c2QVsz9sVv;
	Mon, 15 Jul 2024 11:45:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1721036752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SSKSy4tqVH5b+XJ+esQOWgPyYLwKFVSkaMyHSBptbYg=;
	b=pEoF3VcskAxTuU6XHDhgHjwJ9erMiPjrqp5XIw1iZC3NNGusMPc8tUJOyAY0su5r/+fi6f
	7IehDXNP9w5IRjHE7w2n5wWsibSBIbUPOd1ZmaOTOtvGbmIzx9D6OcQiIBO61pANyMxZZY
	Gffes6zz4RN5/Y/KoDF0h6mhldCZ8oGJIgFhgGuT4vYM4FNFqD/N5HfrNrB8z96ZXkgCeQ
	COP/sZp2v1AwK+zIdinzquJyEDZ9ug0CMLoU2tP3epENmowKDWWdVbkFyVqFUT+gxWzjCG
	fsJSRy1S4YeYWGyPpOpWtOUT7KHV79N78GvHuC+7DwfCZM4W66WLWuJoouezhA==
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
	ryan.roberts@arm.com,
	hch@lst.de,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v10 10/10] xfs: enable block size larger than page size support
Date: Mon, 15 Jul 2024 11:44:57 +0200
Message-ID: <20240715094457.452836-11-kernel@pankajraghav.com>
In-Reply-To: <20240715094457.452836-1-kernel@pankajraghav.com>
References: <20240715094457.452836-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4WMy4c2QVsz9sVv

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
 fs/xfs/xfs_super.c         | 30 ++++++++++++++++++++++--------
 5 files changed, 34 insertions(+), 11 deletions(-)

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
index 27e9f749c4c7f..3c455ef588d48 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1638,16 +1638,30 @@ xfs_fs_fill_super(
 		goto out_free_sb;
 	}
 
-	/*
-	 * Until this is fixed only page-sized or smaller data blocks work.
-	 */
 	if (mp->m_sb.sb_blocksize > PAGE_SIZE) {
-		xfs_warn(mp,
-		"File system with blocksize %d bytes. "
-		"Only pagesize (%ld) or less will currently work.",
+		size_t max_folio_size = mapping_max_folio_size_supported();
+
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
+		if (mp->m_sb.sb_blocksize > max_folio_size) {
+			xfs_warn(mp,
+"block size (%u bytes) not supported; maximum folio size supported in "\
+"the page cache is (%ld bytes). Check MAX_PAGECACHE_ORDER (%d)",
+			mp->m_sb.sb_blocksize, max_folio_size,
+			MAX_PAGECACHE_ORDER);
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


