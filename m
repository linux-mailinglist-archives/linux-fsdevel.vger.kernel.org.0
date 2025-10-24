Return-Path: <linux-fsdevel+bounces-65431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9657C05016
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 10:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC88406DA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 08:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CD0302773;
	Fri, 24 Oct 2025 08:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4hfAQJA3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D38C2FDC37;
	Fri, 24 Oct 2025 08:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293179; cv=none; b=DuQFXz1/jtProIFxXSYOOsnqLt+d5JC+2Gg/Oapq1hsTbaNTJ9W8ycePyacHiiOGKpAk1lru4zcSq100fnFGPm/RY1ADg2c24b+KG99ljraDXDisyME+t4OwWBCFiUWfcA8+rIbP4Iw6ZXSHtMIoBaQX7EMQ0dYNp4dHFSNn/t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293179; c=relaxed/simple;
	bh=D23s/qPcO4HeaJJgNBpsZPKf0w1GzxArcNRGseVWpvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cF3m9UX1jPPOuBiW5ANSYCAoGNsfuBTjRYnn3l0+iThb63YxgCjuqvRPSc6qCM+/5niWMoibn/j/WjQFax3jkO4ahSGJoNNMb3B+DiRXcbAkxng/t3FDqSmpDjr0CSmNFLtJ2GQeHi9+aCcKCIcTjW1EI7NDHAjG1zwhu5wO+5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4hfAQJA3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=F5xkr4XmJjPQvb2MdEVftXia+X6i5Gwk5N6/ltFfj3A=; b=4hfAQJA34diibzRB9j6FpjgscA
	j2GSpM9W9Piz8C/KKTKK9nFxs6QPJ4VNLHk14XNgb3ptHW3IEgOcHsAQ1ttCparGnefefzrLVu7yh
	0aS9zBBClbDjUl72om/4U8UmjjTNstU+Li/IFwwucTfArM2fn6WZ5wgiyqoaNPVJ4AXbcghkrjxQV
	H8SMv331u/xD+JCEkcqGqBlEXwkADHQP4jMevGF35dVqCjlyfQv5oEXtAmyhTjhxl5zsAbHUrTnhH
	gUJwU/xWtwUn1DE3RIUdMBDINvpSbOLjQXaJqGl2QRdpICZM17BeHLnR/mu0jnxdb8LMTVu34rK/k
	8KQzvgMw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCCoP-00000008cNL-2sV3;
	Fri, 24 Oct 2025 08:06:14 +0000
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
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 09/10] mm: remove __filemap_fdatawrite_range
Date: Fri, 24 Oct 2025 10:04:20 +0200
Message-ID: <20251024080431.324236-10-hch@lst.de>
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

Use filemap_fdatawrite_range and filemap_fdatawrite_range_kick instead
of the low-level __filemap_fdatawrite_range that requires the caller
to know the internals of the writeback_control structure and remove
__filemap_fdatawrite_range now that it is trivial and only two callers
would be left.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/sync.c               | 11 +++++------
 include/linux/pagemap.h |  2 --
 mm/fadvise.c            |  3 +--
 mm/filemap.c            | 25 +++++++------------------
 4 files changed, 13 insertions(+), 28 deletions(-)

diff --git a/fs/sync.c b/fs/sync.c
index 2955cd4c77a3..6d8b04e04c3c 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -280,14 +280,13 @@ int sync_file_range(struct file *file, loff_t offset, loff_t nbytes,
 	}
 
 	if (flags & SYNC_FILE_RANGE_WRITE) {
-		int sync_mode = WB_SYNC_NONE;
-
 		if ((flags & SYNC_FILE_RANGE_WRITE_AND_WAIT) ==
 			     SYNC_FILE_RANGE_WRITE_AND_WAIT)
-			sync_mode = WB_SYNC_ALL;
-
-		ret = __filemap_fdatawrite_range(mapping, offset, endbyte,
-						 sync_mode);
+			ret = filemap_fdatawrite_range(mapping, offset,
+					endbyte);
+		else
+			ret = filemap_fdatawrite_range_kick(mapping, offset,
+					endbyte);
 		if (ret < 0)
 			goto out;
 	}
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 678d8ae23d01..d0a7dd43c835 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -54,8 +54,6 @@ static inline int filemap_fdatawait(struct address_space *mapping)
 bool filemap_range_has_page(struct address_space *, loff_t lstart, loff_t lend);
 int filemap_write_and_wait_range(struct address_space *mapping,
 		loff_t lstart, loff_t lend);
-int __filemap_fdatawrite_range(struct address_space *mapping,
-		loff_t start, loff_t end, int sync_mode);
 int filemap_fdatawrite_range(struct address_space *mapping,
 		loff_t start, loff_t end);
 int filemap_check_errors(struct address_space *mapping);
diff --git a/mm/fadvise.c b/mm/fadvise.c
index 588fe76c5a14..f1be619f0e58 100644
--- a/mm/fadvise.c
+++ b/mm/fadvise.c
@@ -111,8 +111,7 @@ int generic_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 		spin_unlock(&file->f_lock);
 		break;
 	case POSIX_FADV_DONTNEED:
-		__filemap_fdatawrite_range(mapping, offset, endbyte,
-					   WB_SYNC_NONE);
+		filemap_fdatawrite_range_kick(mapping, offset, endbyte);
 
 		/*
 		 * First and last FULL page! Partial pages are deliberately
diff --git a/mm/filemap.c b/mm/filemap.c
index 7126d0587c94..f90f5bb2b825 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -392,32 +392,23 @@ static int filemap_writeback(struct address_space *mapping, loff_t start,
 }
 
 /**
- * __filemap_fdatawrite_range - start writeback on mapping dirty pages in range
+ * filemap_fdatawrite_range - start writeback on mapping dirty pages in range
  * @mapping:	address space structure to write
  * @start:	offset in bytes where the range starts
  * @end:	offset in bytes where the range ends (inclusive)
- * @sync_mode:	enable synchronous operation
  *
  * Start writeback against all of a mapping's dirty pages that lie
  * within the byte offsets <start, end> inclusive.
  *
- * If sync_mode is WB_SYNC_ALL then this is a "data integrity" operation, as
- * opposed to a regular memory cleansing writeback.  The difference between
- * these two operations is that if a dirty page/buffer is encountered, it must
- * be waited upon, and not just skipped over.
+ * This is a data integrity operation that waits upon dirty or in writeback
+ * pages.
  *
  * Return: %0 on success, negative error code otherwise.
  */
-int __filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
-				loff_t end, int sync_mode)
-{
-	return filemap_writeback(mapping, start, end, sync_mode, NULL);
-}
-
 int filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
 		loff_t end)
 {
-	return __filemap_fdatawrite_range(mapping, start, end, WB_SYNC_ALL);
+	return filemap_writeback(mapping, start, end, WB_SYNC_ALL, NULL);
 }
 EXPORT_SYMBOL(filemap_fdatawrite_range);
 
@@ -441,7 +432,7 @@ EXPORT_SYMBOL(filemap_fdatawrite);
 int filemap_fdatawrite_range_kick(struct address_space *mapping, loff_t start,
 				  loff_t end)
 {
-	return __filemap_fdatawrite_range(mapping, start, end, WB_SYNC_NONE);
+	return filemap_writeback(mapping, start, end, WB_SYNC_NONE, NULL);
 }
 EXPORT_SYMBOL_GPL(filemap_fdatawrite_range_kick);
 
@@ -689,8 +680,7 @@ int filemap_write_and_wait_range(struct address_space *mapping,
 		return 0;
 
 	if (mapping_needs_writeback(mapping)) {
-		err = __filemap_fdatawrite_range(mapping, lstart, lend,
-						 WB_SYNC_ALL);
+		err = filemap_fdatawrite_range(mapping, lstart, lend);
 		/*
 		 * Even if the above returned error, the pages may be
 		 * written partially (e.g. -ENOSPC), so we wait for it.
@@ -792,8 +782,7 @@ int file_write_and_wait_range(struct file *file, loff_t lstart, loff_t lend)
 		return 0;
 
 	if (mapping_needs_writeback(mapping)) {
-		err = __filemap_fdatawrite_range(mapping, lstart, lend,
-						 WB_SYNC_ALL);
+		err = filemap_fdatawrite_range(mapping, lstart, lend);
 		/* See comment of filemap_write_and_wait() */
 		if (err != -EIO)
 			__filemap_fdatawait_range(mapping, lstart, lend);
-- 
2.47.3


