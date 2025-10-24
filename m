Return-Path: <linux-fsdevel+bounces-65430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE48C04F5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 10:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA1BA4F835E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 08:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F403019B3;
	Fri, 24 Oct 2025 08:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k5lOzMG0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF68C2FDC37;
	Fri, 24 Oct 2025 08:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293167; cv=none; b=dVkP6PejsZOsqs4QgVwPH1AZePPxIPTWF53wjh5ofUUZR9U1CwPcAhO8aJKHMUPJVHCJaKayMJy7W1D7VXhQCKpzYCUqb++gfQtQbvDsR7yrnt9x0MMEKFhJEEh/mKMEwswhN3jf/7EHqNA2OK3sFsSgJP8pCzh8aEC6FK2N8M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293167; c=relaxed/simple;
	bh=Gxr9UW3hvUFTBB05zCu+DkxlypN4VAH3xRZbg5uWmBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IAitQPx+2EcsphL9fKHDiMoirT0vQzgp4bbB6oRvTgMkbhIebIfHWwZWTHIxhHDg3YGFETiMG/T2EZjvJOXYup/7wFuYKP2qTvgs8bSJItCVqRYGy5C+YrfGjbEPTjtbNO42FcKij51WazjdepYQVJXNUviyYHkLGUKs9ENBcIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k5lOzMG0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gCwoA6+ChcsIaRaI3yMWo9YEdWFV0agcuinYhHfWt00=; b=k5lOzMG0Ppf0+EZXIOQFf73oUb
	2iS54DPXlzj4+9rvCxXFtFSCBiWsn6gsEOrglZ00o2PPG1gLXP5K+6EqxFGvGDQ5C4YWIcaT/e23N
	nReVeiyprQQAiUVnGi1FMD5vO4kGJZF3lCdPivkpLvvWY5+y3aEtDUui9lNBrGMqh7gDJIVniH4u5
	xrjhtX6CUo5QGsYFF3/j9lXmwzqzG+fNvNPuX8mG3Zce1KrTA09mP/Qjlf//4J2rbTgDBq3VG7Gb6
	1F1z2Y/yOY5Dr2JTGHeTnfhPXKLZNZAL95pItESpEC3sVU5rZpgGYgp70Ob16Ubxplk3No8g/vBB7
	qMXVco+A==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCCoD-00000008cJg-2y2A;
	Fri, 24 Oct 2025 08:06:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jan Kara <jack@suse.cz>,
	linux-block@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net,
	ocfs2-devel@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 08/10] mm: remove filemap_fdatawrite_wbc
Date: Fri, 24 Oct 2025 10:04:19 +0200
Message-ID: <20251024080431.324236-9-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251024080431.324236-1-hch@lst.de>
References: <20251024080431.324236-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Replace filemap_fdatawrite_wbc, which exposes a writeback_control to the
callers with a filemap_writeback helper that takes all the possible
arguments and declares the writeback_control itself.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/fs-writeback.c       |  6 ++---
 include/linux/pagemap.h |  2 --
 mm/filemap.c            | 54 ++++++++++++++---------------------------
 3 files changed, 21 insertions(+), 41 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 2b35e80037fe..d40b47132de3 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -807,9 +807,9 @@ static void wbc_attach_and_unlock_inode(struct writeback_control *wbc,
  * @wbc: writeback_control of interest
  * @inode: target inode
  *
- * This function is to be used by __filemap_fdatawrite_range(), which is an
- * alternative entry point into writeback code, and first ensures @inode is
- * associated with a bdi_writeback and attaches it to @wbc.
+ * This function is to be used by filemap_writeback(), which is an alternative
+ * entry point into writeback code, and first ensures @inode is associated with
+ * a bdi_writeback and attaches it to @wbc.
  */
 void wbc_attach_fdatawrite_inode(struct writeback_control *wbc,
 		struct inode *inode)
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index cebdf160d3dd..678d8ae23d01 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -60,8 +60,6 @@ int filemap_fdatawrite_range(struct address_space *mapping,
 		loff_t start, loff_t end);
 int filemap_check_errors(struct address_space *mapping);
 void __filemap_set_wb_err(struct address_space *mapping, int err);
-int filemap_fdatawrite_wbc(struct address_space *mapping,
-			   struct writeback_control *wbc);
 int kiocb_write_and_wait(struct kiocb *iocb, size_t count);
 
 static inline int filemap_write_and_wait(struct address_space *mapping)
diff --git a/mm/filemap.c b/mm/filemap.c
index 3d4c4a96c586..7126d0587c94 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -366,31 +366,30 @@ static int filemap_check_and_keep_errors(struct address_space *mapping)
 	return 0;
 }
 
-/**
- * filemap_fdatawrite_wbc - start writeback on mapping dirty pages in range
- * @mapping:	address space structure to write
- * @wbc:	the writeback_control controlling the writeout
- *
- * Call writepages on the mapping using the provided wbc to control the
- * writeout.
- *
- * Return: %0 on success, negative error code otherwise.
- */
-int filemap_fdatawrite_wbc(struct address_space *mapping,
-			   struct writeback_control *wbc)
+static int filemap_writeback(struct address_space *mapping, loff_t start,
+		loff_t end, enum writeback_sync_modes sync_mode,
+		long *nr_to_write)
 {
+	struct writeback_control wbc = {
+		.sync_mode	= sync_mode,
+		.nr_to_write	= nr_to_write ? *nr_to_write : LONG_MAX,
+		.range_start	= start,
+		.range_end	= end,
+	};
 	int ret;
 
 	if (!mapping_can_writeback(mapping) ||
 	    !mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
 		return 0;
 
-	wbc_attach_fdatawrite_inode(wbc, mapping->host);
-	ret = do_writepages(mapping, wbc);
-	wbc_detach_inode(wbc);
+	wbc_attach_fdatawrite_inode(&wbc, mapping->host);
+	ret = do_writepages(mapping, &wbc);
+	wbc_detach_inode(&wbc);
+
+	if (!ret && nr_to_write)
+		*nr_to_write = wbc.nr_to_write;
 	return ret;
 }
-EXPORT_SYMBOL(filemap_fdatawrite_wbc);
 
 /**
  * __filemap_fdatawrite_range - start writeback on mapping dirty pages in range
@@ -412,14 +411,7 @@ EXPORT_SYMBOL(filemap_fdatawrite_wbc);
 int __filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
 				loff_t end, int sync_mode)
 {
-	struct writeback_control wbc = {
-		.sync_mode = sync_mode,
-		.nr_to_write = LONG_MAX,
-		.range_start = start,
-		.range_end = end,
-	};
-
-	return filemap_fdatawrite_wbc(mapping, &wbc);
+	return filemap_writeback(mapping, start, end, sync_mode, NULL);
 }
 
 int filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
@@ -475,18 +467,8 @@ EXPORT_SYMBOL(filemap_flush);
  */
 int filemap_flush_nr(struct address_space *mapping, long *nr_to_write)
 {
-	struct writeback_control wbc = {
-		.nr_to_write = *nr_to_write,
-		.sync_mode = WB_SYNC_NONE,
-		.range_start = 0,
-		.range_end = LLONG_MAX,
-	};
-	int ret;
-
-	ret = filemap_fdatawrite_wbc(mapping, &wbc);
-	if (!ret)
-		*nr_to_write = wbc.nr_to_write;
-	return ret;
+	return filemap_writeback(mapping, 0, LLONG_MAX, WB_SYNC_NONE,
+			nr_to_write);
 }
 EXPORT_SYMBOL_FOR_MODULES(filemap_flush_nr, "btrfs");
 
-- 
2.47.3


