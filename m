Return-Path: <linux-fsdevel+bounces-24319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3087493D2BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 14:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546841C21CD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 12:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1199817CA11;
	Fri, 26 Jul 2024 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="WhYRX2zo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5882217C9FE;
	Fri, 26 Jul 2024 12:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721995257; cv=none; b=QaBGSelU0ZKhsxjGW0AevPcjLH4jjV+6Ke+/bWm96VnDLWNAyv9QKPDxyqQrpkrXxlRDtwA7cQyTkzVe0rzOD5KkhOysZxUYto/EhlXupZWGBxX4ExI+Ox7LC006Gs0EC4ib+6eentKg9XuFhddKafTyQQfhqMrNUxTyV49Otkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721995257; c=relaxed/simple;
	bh=qK0flnnBrvtZBNAuPWWTpJbzjHU8TUWV20LrGnfhcPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2J7JkIMYOrxCY64ANIsPMKJ3T/qPaxpunnVM3gbcwOc4TgceVKu3YqtpniyOdUoN5ZuOGZC3xDOXmdmUxE5zSa61RymjD9az3va3QolTLpg883rVkjk+sGLVoiCzVimMjI9DkvsqKTubjueyu9aNKzFdZVEui2NF/eAo2P+V7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=WhYRX2zo; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WVmYH3fHRz9tCK;
	Fri, 26 Jul 2024 14:00:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1721995251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F5f9Z6yQ2HFDvQ0pXyKnZ1CF8pk601QiTcma43W9nDA=;
	b=WhYRX2zoWCyU64ct7fWgdmTh0apq/E/Lo9f4nPIwy1jVr1lBXETBOP9sCtAyvGXLYY64Kf
	ACFyhbhl58Pq/6UVIJUEUMxXpZOaxv2wxOOOQJBt0wjTLAccoVhwQBdBsAPOlqxrkW1F4B
	OKmo+ew6Nbny60i6utNWuB8Wy/rj1DZg6+kNImhyghxzGAscWxe9ZxcYh2lFTNDSu+Pos6
	lTphduaqav0l2aMCgBJe7ubQ5wiv1VTqkOeIg2c+WYTYF4oF5G/C1DESw7UkFVJoO3ak8H
	54roaIrREc2n52i6R/5gl84b4437MmrABkWiUEonTikoaixiAkTo2AXmyKbGWQ==
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
	ryan.roberts@arm.com,
	hch@lst.de,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v11 10/10] xfs: enable block size larger than page size support
Date: Fri, 26 Jul 2024 13:59:56 +0200
Message-ID: <20240726115956.643538-11-kernel@pankajraghav.com>
In-Reply-To: <20240726115956.643538-1-kernel@pankajraghav.com>
References: <20240726115956.643538-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4WVmYH3fHRz9tCK

From: Pankaj Raghav <p.raghav@samsung.com>

Page cache now has the ability to have a minimum order when allocating
a folio which is a prerequisite to add support for block size > page
size.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_ialloc.c |  5 +++++
 fs/xfs/libxfs/xfs_shared.h |  3 +++
 fs/xfs/xfs_icache.c        |  6 ++++--
 fs/xfs/xfs_mount.c         |  1 -
 fs/xfs/xfs_super.c         | 28 ++++++++++++++++++++--------
 include/linux/pagemap.h    | 13 +++++++++++++
 6 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
index 0af5b7a33d055..1921b689888b8 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -3033,6 +3033,11 @@ xfs_ialloc_setup_geometry(
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
index 2f7413afbf46c..33b84a3a83ff6 100644
--- a/fs/xfs/libxfs/xfs_shared.h
+++ b/fs/xfs/libxfs/xfs_shared.h
@@ -224,6 +224,9 @@ struct xfs_ino_geometry {
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
index 27e9f749c4c7f..b2f5a1706c59d 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1638,16 +1638,28 @@ xfs_fs_fill_super(
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
+"block size (%u bytes) not supported; Only block size (%ld) or less is supported",
+			mp->m_sb.sb_blocksize, max_folio_size);
+			error = -ENOSYS;
+			goto out_free_sb;
+		}
+
+		xfs_warn(mp,
+"EXPERIMENTAL: V5 Filesystem with Large Block Size (%d bytes) enabled.",
+			mp->m_sb.sb_blocksize);
 	}
 
 	/* Ensure this filesystem fits in the page cache limits */
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 3a876d6801a90..61a7649d86e57 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -373,6 +373,19 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
 #define MAX_XAS_ORDER		(XA_CHUNK_SHIFT * 2 - 1)
 #define MAX_PAGECACHE_ORDER	min(MAX_XAS_ORDER, PREFERRED_MAX_PAGECACHE_ORDER)
 
+/*
+ * mapping_max_folio_size_supported() - Check the max folio size supported
+ *
+ * The filesystem should call this function at mount time if there is a
+ * requirement on the folio mapping size in the page cache.
+ */
+static inline size_t mapping_max_folio_size_supported(void)
+{
+	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
+		return 1U << (PAGE_SHIFT + MAX_PAGECACHE_ORDER);
+	return PAGE_SIZE;
+}
+
 /*
  * mapping_set_folio_order_range() - Set the orders supported by a file.
  * @mapping: The address space of the file.
-- 
2.44.1


