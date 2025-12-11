Return-Path: <linux-fsdevel+bounces-71123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A6DCB61E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 14:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48015304B957
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 13:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8682C11DE;
	Thu, 11 Dec 2025 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="tVuKA5pG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247C02836A4;
	Thu, 11 Dec 2025 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765461390; cv=none; b=kbAXXiSYp50wVmhseOD5MkQgBeOwgOzSk6poj+ML9sk4kqAhXsHrwT/wJo6x4CPbculLRSM3sAVUJvxzrl7f7M8/riAFi2vIkQd2NaFTXI7YBZ21+aksnStsdowrNXh+BhwMA3PYZHdEZSDeFaIAxOfr6y1eit5R4wNH5aJU+LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765461390; c=relaxed/simple;
	bh=InudjFuQXNlEJxjSNbqkGDeXO4XrWdi4ssxgpJZSvvI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IsDKPzOcKnhMWkP0s+lbU7u5MTAR8amUJOoEWwstGWQgYdGI0gZ7GoW8iwlUa10+SoBDFO7pmbH5li2BpXKhkcTrPPUZncOkA9RSRB7IlJZwvTqZRqwdhL/tr0UDjiP+6jxYg8b3863Iw7NBe5B1cCAdTCbD+8o5yeeX5FH7YJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=tVuKA5pG; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 8220E1D77;
	Thu, 11 Dec 2025 13:46:16 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=tVuKA5pG;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 8FCC43AC;
	Thu, 11 Dec 2025 13:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1765460986;
	bh=oYD3lboZmFdXWlLx/fAmPEzwlZr3TRmYflSRMM25Jok=;
	h=From:To:CC:Subject:Date;
	b=tVuKA5pGP/vahuf2eMeuEz3QOyr+vd1vYvjsAO94U7Kj4ghb1ENymmiix2Cc0RGip
	 oEVMleI8CJ4ynSmbVpg0f6Jb458f4PiBp0ZPOHCEl6Mzh2Y/fgIhn+p/lD2VSljx2g
	 pt3eJYhyZABwR1AmC6zo7Q3yUVSkVXcMoWleFU0Y=
Received: from localhost.localdomain (172.30.20.154) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 11 Dec 2025 16:49:45 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: rename ni_readpage_cmpr into ni_read_folio_cmpr
Date: Thu, 11 Dec 2025 14:49:33 +0100
Message-ID: <20251211134934.13863-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

The old "readpage" naming is still used in ni_readpage_cmpr(), even though
the vfs has transitioned to the folio-based read_folio() API.

This patch performs a straightforward renaming of the helper:
ni_readpage_cmpr() -> ni_read_folio_cmpr().

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/frecord.c | 8 ++++----
 fs/ntfs3/inode.c   | 2 +-
 fs/ntfs3/ntfs_fs.h | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 641ddaf8d4a0..7e3d61de2f8f 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2046,18 +2046,18 @@ static struct page *ntfs_lock_new_page(struct address_space *mapping,
 }
 
 /*
- * ni_readpage_cmpr
+ * ni_read_folio_cmpr
  *
  * When decompressing, we typically obtain more than one page per reference.
  * We inject the additional pages into the page cache.
  */
-int ni_readpage_cmpr(struct ntfs_inode *ni, struct folio *folio)
+int ni_read_folio_cmpr(struct ntfs_inode *ni, struct folio *folio)
 {
 	int err;
 	struct ntfs_sb_info *sbi = ni->mi.sbi;
 	struct address_space *mapping = folio->mapping;
-	pgoff_t index = folio->index;
-	u64 frame_vbo, vbo = (u64)index << PAGE_SHIFT;
+	pgoff_t index;
+	u64 frame_vbo, vbo = folio_pos(folio);
 	struct page **pages = NULL; /* Array of at most 16 pages. stack? */
 	u8 frame_bits;
 	CLST frame;
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 9989c3592a04..3e790c7a14a9 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -736,7 +736,7 @@ static int ntfs_read_folio(struct file *file, struct folio *folio)
 
 	if (is_compressed(ni)) {
 		ni_lock(ni);
-		err = ni_readpage_cmpr(ni, folio);
+		err = ni_read_folio_cmpr(ni, folio);
 		ni_unlock(ni);
 		return err;
 	}
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index a4559c9f64e6..7b619bb151ce 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -568,7 +568,7 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint);
 #define _ni_write_inode(i, w) ni_write_inode(i, w, __func__)
 int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 	      __u64 vbo, __u64 len);
-int ni_readpage_cmpr(struct ntfs_inode *ni, struct folio *folio);
+int ni_read_folio_cmpr(struct ntfs_inode *ni, struct folio *folio);
 int ni_decompress_file(struct ntfs_inode *ni);
 int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 		  u32 pages_per_frame, int copy);
-- 
2.43.0


