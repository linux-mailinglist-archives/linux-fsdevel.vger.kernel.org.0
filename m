Return-Path: <linux-fsdevel+bounces-63890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3743BD14D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 05:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C212A3BF451
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 03:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937B32F1FF3;
	Mon, 13 Oct 2025 02:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KbGJyiH6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7FA280035;
	Mon, 13 Oct 2025 02:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760324361; cv=none; b=ovZU9Y7Q0YDXSS6dB2H8twnjINEfIPQvPHeJJUeowGt7CujtDpW/F3I4mzqoLkO9Ko5W02x/HYdWyDvCbAAn+DzaU4sEoRQAHIrqAKk+tMpWk+Cl3U7Ns4p4j9EF9BfEhGw/4JP+M+/ku1r99V5ThQI2M0gjTi+yzuKaoyA/y0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760324361; c=relaxed/simple;
	bh=sfVf+cYw8521nzfMdz06SQQ7nWCGIh6213Qqcfi8MV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGK+uMsFvFvreeQyMJbY1kLxrq10TVKHnQ+SOYvrXfZ1vlE/UH67NUAs5djlAPQvIK1ef2778Y2H+Q/xwuFRUIraxlsgUFBwa3Wp3HnrIa5aXqjZhUPQdmB62xW3tLnnCAPTjtTdxYXOqSSBUB/EuphJrHr+1hOaqpn+WX+0K/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KbGJyiH6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=I9Quh20hMw6W9Qj1ot0jk9p8OG9NByjcr8PhG1KTTjU=; b=KbGJyiH6VuiuLwWcwtTvpAbIsV
	9c08ehIVjJ4wCL4tPLDFSoVmuZjPrHSJ1BkqLGzGdOf/LoIJwOnH7r03ODP2B9FQUg/esvdgPimts
	BP4Eo9u4nqrxwHYQqCsWSY2TMIh4SKboqpMKanrjKEfP/uBeRDSCyWx8YEamIEK/jsvGekYEdmwee
	KNPENPtY+gch4zEMP79BYW5U4v7g6XAnKpUlLDO2enhu78cKN8Veqiqpth1ccLd+UhnFh+Cs0Di5/
	vVdDHZN4RSnQwUXiI7phr5dcuXH6SurbdovhYwjQ9m/4uLytnAWp90EQr890hOvNlIkv3sF1oN0bo
	hZIetDoA==;
Received: from [220.85.59.196] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v88mK-0000000C8Ky-0q9r;
	Mon, 13 Oct 2025 02:59:16 +0000
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
	linux-mm@kvack.org
Subject: [PATCH 08/10] mm: remove filemap_fdatawrite_wbc
Date: Mon, 13 Oct 2025 11:58:03 +0900
Message-ID: <20251013025808.4111128-9-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251013025808.4111128-1-hch@lst.de>
References: <20251013025808.4111128-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Replace filemap_fdatawrite_wbc, which exposes a writeback_control to the
callers with a __filemap_fdatawrite helper that takes all the possible
arguments and declares the writeback_control itself.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/pagemap.h |  2 --
 mm/filemap.c            | 54 ++++++++++++++---------------------------
 2 files changed, 18 insertions(+), 38 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index fc060ce2d31d..742ba1dd3990 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -61,8 +61,6 @@ int filemap_fdatawrite_range(struct address_space *mapping,
 		loff_t start, loff_t end);
 int filemap_check_errors(struct address_space *mapping);
 void __filemap_set_wb_err(struct address_space *mapping, int err);
-int filemap_fdatawrite_wbc(struct address_space *mapping,
-			   struct writeback_control *wbc);
 int kiocb_write_and_wait(struct kiocb *iocb, size_t count);
 
 static inline int filemap_write_and_wait(struct address_space *mapping)
diff --git a/mm/filemap.c b/mm/filemap.c
index bbd5d5eaa661..26b692dbf091 100644
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
+static int __filemap_fdatawrite(struct address_space *mapping, loff_t start,
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
+	return __filemap_fdatawrite(mapping, start, end, sync_mode, NULL);
 }
 
 int filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
@@ -475,18 +467,8 @@ EXPORT_SYMBOL(filemap_flush);
  */
 int filemap_fdatawrite_kick_nr(struct address_space *mapping, long *nr_to_write)
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
+	return __filemap_fdatawrite(mapping, 0, LLONG_MAX, WB_SYNC_NONE,
+			nr_to_write);
 }
 EXPORT_SYMBOL_FOR_MODULES(filemap_fdatawrite_kick_nr, "btrfs");
 
-- 
2.47.3


