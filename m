Return-Path: <linux-fsdevel+bounces-65432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E68C04FA4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 10:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4218519A215A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 08:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E2A302747;
	Fri, 24 Oct 2025 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D6AogjIs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6590B2FDC3E;
	Fri, 24 Oct 2025 08:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293189; cv=none; b=s56Sbwh1pIMNbLkgPLpjrDWUxmERVecFX6acl35/uyxq7Gxai5yzUOS6QFQeiyHQb7QyqTOWpcLXQsXigXvJc4ZwPbSoBvBCmHjeVhrHITFn/+lJ8nZgWIoY0nTEwIJLGf8NtUwIaIcBFiDNkART2YHUWabq3OX7Y7+eC/wqZPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293189; c=relaxed/simple;
	bh=fwUWvRaQsLFX3LqP3Ew3i68VLcwmDW8xgH2gbbo9sQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QwjxqzXILQca5L1PPiQv1W5S8LhMt1b3NuLfDV/4uZbHdrXTTiWT1o1evXQ5x68/8AV6Ca7y3OuaP41bbbnDsEC0QZ8mDInitWacy6UFozTLrD0mPFozcRmOA9i2wciyPee2qtsR8LtLn1V5GfjmdQw+26uQljL7WAoEBbgRK9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D6AogjIs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=CK4+A+XQ8xSWXf+Z9tTtAvh9OT31XsHF6kx6Btc5iA8=; b=D6AogjIsaOXIaEKMP8+nYzb2S/
	Oi9fBsDLQ/QDLj8zWUOszOIZUXoUGJEGD6oOe3/gwwa36ob+z5Y4jnXIMl/I47R2yybCHjHy9PVpp
	u9rk8NVCJvRsT7wc5scuOjf+d0qjgiv7xQKVzrHmYhwZolySV+SEki+Hm9VEk4MYwcBCOKWh8kE/L
	vlzlOWvLC6nPNVOCQn/9gA1eRi4wHGrw+7X1beFwTeRlaIDXxs6ij8o/wGIbY6gxmKmEmayQZ5noV
	iBvVRW/cRH9N2cvm1YrB7NcZkATFE2g0crlK/d+n5Fpb75Kk12b+O+FG+yCLdiKH/xMwQRP6Ju0xM
	N9qYV9hw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCCoa-00000008cQn-37yb;
	Fri, 24 Oct 2025 08:06:25 +0000
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
Subject: [PATCH 10/10] mm: rename filemap_fdatawrite_range_kick to filemap_flush_range
Date: Fri, 24 Oct 2025 10:04:21 +0200
Message-ID: <20251024080431.324236-11-hch@lst.de>
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

Rename filemap_fdatawrite_range_kick to filemap_flush_range because it
is the ranged version of filemap_flush.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/sync.c          | 3 +--
 include/linux/fs.h | 6 +++---
 mm/fadvise.c       | 2 +-
 mm/filemap.c       | 8 ++++----
 4 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/sync.c b/fs/sync.c
index 6d8b04e04c3c..1759f6ba36cd 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -285,8 +285,7 @@ int sync_file_range(struct file *file, loff_t offset, loff_t nbytes,
 			ret = filemap_fdatawrite_range(mapping, offset,
 					endbyte);
 		else
-			ret = filemap_fdatawrite_range_kick(mapping, offset,
-					endbyte);
+			ret = filemap_flush_range(mapping, offset, endbyte);
 		if (ret < 0)
 			goto out;
 	}
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c895146c1444..a5dbfa20f8d7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3014,7 +3014,7 @@ extern int __must_check file_fdatawait_range(struct file *file, loff_t lstart,
 extern int __must_check file_check_and_advance_wb_err(struct file *file);
 extern int __must_check file_write_and_wait_range(struct file *file,
 						loff_t start, loff_t end);
-int filemap_fdatawrite_range_kick(struct address_space *mapping, loff_t start,
+int filemap_flush_range(struct address_space *mapping, loff_t start,
 		loff_t end);
 
 static inline int file_write_and_wait(struct file *file)
@@ -3051,8 +3051,8 @@ static inline ssize_t generic_write_sync(struct kiocb *iocb, ssize_t count)
 	} else if (iocb->ki_flags & IOCB_DONTCACHE) {
 		struct address_space *mapping = iocb->ki_filp->f_mapping;
 
-		filemap_fdatawrite_range_kick(mapping, iocb->ki_pos - count,
-					      iocb->ki_pos - 1);
+		filemap_flush_range(mapping, iocb->ki_pos - count,
+				iocb->ki_pos - 1);
 	}
 
 	return count;
diff --git a/mm/fadvise.c b/mm/fadvise.c
index f1be619f0e58..67028e30aa91 100644
--- a/mm/fadvise.c
+++ b/mm/fadvise.c
@@ -111,7 +111,7 @@ int generic_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 		spin_unlock(&file->f_lock);
 		break;
 	case POSIX_FADV_DONTNEED:
-		filemap_fdatawrite_range_kick(mapping, offset, endbyte);
+		filemap_flush_range(mapping, offset, endbyte);
 
 		/*
 		 * First and last FULL page! Partial pages are deliberately
diff --git a/mm/filemap.c b/mm/filemap.c
index f90f5bb2b825..fa770768ea3a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -419,7 +419,7 @@ int filemap_fdatawrite(struct address_space *mapping)
 EXPORT_SYMBOL(filemap_fdatawrite);
 
 /**
- * filemap_fdatawrite_range_kick - start writeback on a range
+ * filemap_flush_range - start writeback on a range
  * @mapping:	target address_space
  * @start:	index to start writeback on
  * @end:	last (inclusive) index for writeback
@@ -429,12 +429,12 @@ EXPORT_SYMBOL(filemap_fdatawrite);
  *
  * Return: %0 on success, negative error code otherwise.
  */
-int filemap_fdatawrite_range_kick(struct address_space *mapping, loff_t start,
+int filemap_flush_range(struct address_space *mapping, loff_t start,
 				  loff_t end)
 {
 	return filemap_writeback(mapping, start, end, WB_SYNC_NONE, NULL);
 }
-EXPORT_SYMBOL_GPL(filemap_fdatawrite_range_kick);
+EXPORT_SYMBOL_GPL(filemap_flush_range);
 
 /**
  * filemap_flush - mostly a non-blocking flush
@@ -447,7 +447,7 @@ EXPORT_SYMBOL_GPL(filemap_fdatawrite_range_kick);
  */
 int filemap_flush(struct address_space *mapping)
 {
-	return filemap_fdatawrite_range_kick(mapping, 0, LLONG_MAX);
+	return filemap_flush_range(mapping, 0, LLONG_MAX);
 }
 EXPORT_SYMBOL(filemap_flush);
 
-- 
2.47.3


