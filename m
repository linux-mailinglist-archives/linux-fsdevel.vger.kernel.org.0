Return-Path: <linux-fsdevel+bounces-15987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D82896693
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 09:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4A6288027
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 07:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725DF80031;
	Wed,  3 Apr 2024 07:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="ShLq06yR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7899678286;
	Wed,  3 Apr 2024 07:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129606; cv=none; b=W+W88JhHe8we9jseDpI/+OEPmFoIxPuA9/8H3GQZcY2pENOL6ktPmR+JCv2SHvTcUP80JRNzGWL0lH2Fogoxxgh47y7hXmK2fySJ5/Mzlf6/rJxeyPNTrY6zmBWO4lU4JIF8mopDvOUTe99Tdw5y0IRwKWpPDXzrzIEOFe2ve3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129606; c=relaxed/simple;
	bh=LnQUExMEi4K5Eq4tutxz2pOoBuBB93Ng5m6J9LLHIv8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQzEmkHnkk/ZiAYYe6ndI9DcLA9WQ4MjyN2cAc4+Ptc1AzrsqYyRLLTeHYmR11oNg67LHzTZRtIBWsj906YCk4QQHDRNbRUGKmtbtyuymVWG/CWbT07MrpOzWya5G1nylBbAf+V9junk8uY5XUFsYskZN1sTW/Bui+3YukurzG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=ShLq06yR; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id BDBF98089D;
	Wed,  3 Apr 2024 03:33:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1712129605; bh=LnQUExMEi4K5Eq4tutxz2pOoBuBB93Ng5m6J9LLHIv8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ShLq06yRFTESpZJwiWHcJo16tBtJUgnqA9agoyQSzZAWKNutSxyYios9BpbTInyZk
	 ScSiv6shQNZnemhUNUlVK2nqEIApjUSOluBjpuf2tmZJn8tx2zsV7xYlxyDuSUDP+5
	 JR4dJlnpOG6rCx+Bgqk/kHpkK61yY3GXzTQ1RAljAGTG8f8bA+dNbrf7psorjEw+SH
	 HHsns8Qgyx50zcnfxXrLvu27AaOv9tnb4ZHCDSYtifvkkKPYCogkQa6FrqvBR59QAP
	 T/O7VI6Y41ZUJaargTyw3VjXUaZoNxhNjUUOri0m9QA0XtsCxey/Q/c+brGFL7QGe7
	 BhSc4Llv+6ngQ==
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To: Jonathan Corbet <corbet@lwn.net>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 09/13] f2fs: fiemap: return correct extent physical length
Date: Wed,  3 Apr 2024 03:22:50 -0400
Message-ID: <3bcdf126c1db6b4119d4bbdd4dc621c3ca3e2ae1.1712126039.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1712126039.git.sweettea-kernel@dorminy.me>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/f2fs/data.c   | 25 ++++++++++++++++---------
 fs/f2fs/inline.c |  2 +-
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 34af1673461b..2a3625c10125 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1829,7 +1829,9 @@ static int f2fs_xattr_fiemap(struct inode *inode,
 
 		f2fs_put_page(page, 1);
 
-		flags = FIEMAP_EXTENT_DATA_INLINE | FIEMAP_EXTENT_NOT_ALIGNED;
+		flags = FIEMAP_EXTENT_DATA_INLINE |
+			FIEMAP_EXTENT_NOT_ALIGNED |
+			FIEMAP_EXTENT_HAS_PHYS_LEN;
 
 		if (!xnid)
 			flags |= FIEMAP_EXTENT_LAST;
@@ -1857,7 +1859,7 @@ static int f2fs_xattr_fiemap(struct inode *inode,
 
 		f2fs_put_page(page, 1);
 
-		flags = FIEMAP_EXTENT_LAST;
+		flags = FIEMAP_EXTENT_LAST | FIEMAP_EXTENT_HAS_PHYS_LEN;
 	}
 
 	if (phys) {
@@ -1894,8 +1896,8 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	struct f2fs_map_blocks map;
 	sector_t start_blk, last_blk;
 	pgoff_t next_pgofs;
-	u64 logical = 0, phys = 0, size = 0;
-	u32 flags = 0;
+	u64 logical = 0, phys = 0, size = 0, phys_size = 0;
+	u32 flags = FIEMAP_EXTENT_HAS_PHYS_LEN;
 	int ret = 0;
 	bool compr_cluster = false, compr_appended;
 	unsigned int cluster_size = F2FS_I(inode)->i_cluster_size;
@@ -1981,11 +1983,12 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			flags |= FIEMAP_EXTENT_DATA_ENCRYPTED;
 
 		ret = fiemap_fill_next_extent(fieinfo, logical,
-				phys, size, 0, flags);
-		trace_f2fs_fiemap(inode, logical, phys, size, 0, flags, ret);
+				phys, size, phys_size, flags);
+		trace_f2fs_fiemap(inode, logical, phys, size, phys_size, flags, ret);
 		if (ret)
 			goto out;
 		size = 0;
+		phys_size = 0;
 	}
 
 	if (start_blk > last_blk)
@@ -2006,17 +2009,21 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		phys = __is_valid_data_blkaddr(map.m_pblk) ?
 			blks_to_bytes(inode, map.m_pblk) : 0;
 		size = blks_to_bytes(inode, map.m_len);
-		flags = 0;
+		phys_size = blks_to_bytes(inode, map.m_len);
+		flags = FIEMAP_EXTENT_HAS_PHYS_LEN;
 
 		if (compr_cluster) {
-			flags = FIEMAP_EXTENT_ENCODED;
+			flags = FIEMAP_EXTENT_ENCODED |
+				FIEMAP_EXTENT_HAS_PHYS_LEN;
 			count_in_cluster += map.m_len;
 			if (count_in_cluster == cluster_size) {
 				compr_cluster = false;
 				size += blks_to_bytes(inode, 1);
+				phys_size += blks_to_bytes(inode, 1);
 			}
 		} else if (map.m_flags & F2FS_MAP_DELALLOC) {
-			flags = FIEMAP_EXTENT_UNWRITTEN;
+			flags = FIEMAP_EXTENT_UNWRITTEN |
+				FIEMAP_EXTENT_HAS_PHYS_LEN;
 		}
 
 		start_blk += bytes_to_blks(inode, size);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 235b0d72f6fc..c1c804a754de 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -772,7 +772,7 @@ int f2fs_inline_data_fiemap(struct inode *inode,
 {
 	__u64 byteaddr, ilen;
 	__u32 flags = FIEMAP_EXTENT_DATA_INLINE | FIEMAP_EXTENT_NOT_ALIGNED |
-		FIEMAP_EXTENT_LAST;
+		FIEMAP_EXTENT_HAS_PHYS_LEN | FIEMAP_EXTENT_LAST;
 	struct node_info ni;
 	struct page *ipage;
 	int err = 0;
-- 
2.43.0


