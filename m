Return-Path: <linux-fsdevel+bounces-64817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFFEBF4E16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 09:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFCB45008AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 07:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A052797BD;
	Tue, 21 Oct 2025 07:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="dik6jM5D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.72.182.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FA92737F6;
	Tue, 21 Oct 2025 07:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.72.182.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761030604; cv=none; b=S1JSKZMG+ECW9vUeKKnQ/+Lo9z7LTJP86DpUHABu+z0VJexDSzpraD2csOJaUVmSK5CEg0Igt9YSsfZ91DvICepCT1KXoUM8wVSacn4QCIsUp8R2jarrusRBIeqFtif3afDCeH8LWQZ6zLKXYkYnfbQ7uHD1dyi+gr4/8pGBlWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761030604; c=relaxed/simple;
	bh=lVvsV5rW7CuZZaMc1NIWyfTh/22AIUZxBL01RldT99o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/1m813p0spCEDKs5+e/OotFde0kyi8KlwwJpiRReY9TxJHnTBdza7sa8+QZ2CyapRJMEcUH3ypaZ89z85E2iIpf9S0ub/wuWBbDFWNsYky5R2J2EGG2FVGqd7thNPvfx3aMpSTKJJgPdWbTAcc1OSfnaBP+GmWqZLMJch28mgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=dik6jM5D; arc=none smtp.client-ip=3.72.182.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1761030602; x=1792566602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c9ehURESYE/FlGbnKhMBWJDg3bnRGJGCmyBZSmWKczc=;
  b=dik6jM5DfDfKT0dR6kaTBo5FoaizFbTJxqftkYYfUeJRXIyFmmBH96CG
   00El+WbsZekOsqcltqMCjVLBjbBZBTHxsCO1aZd15WKKZ00eaqK5SRHh5
   oChnHqZZiUR8qM6crskA9PmOHaw3paiHcRLs+m+k8AZVQSqPQaFfckvp1
   xg6lGzEhhppzWNUFuJ6THOgLcDhbJ6zwMW7i0ezqwz/XMgH+ASRJaPLda
   u0bf3Y0aJ3ukGvjXtEFMnRsIdMWi8s7iJH1hi34yuqAKOtUGqKj1eWNx1
   w3xvblNYCqSYoY6TLiWYU81VntuVfEKKPQMnSpN/2MZ7+AK1rMJfS1NvU
   g==;
X-CSE-ConnectionGUID: bVruJ4WDRMK5ZgB6aLYZ9g==
X-CSE-MsgGUID: ey+Ss73iRgm2E0Ht00LPgQ==
X-IronPort-AV: E=Sophos;i="6.19,244,1754956800"; 
   d="scan'208";a="3939069"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 07:09:59 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.228:28056]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.11.58:2525] with esmtp (Farcaster)
 id 533d5b60-49a1-492a-8ab5-004364c4dd08; Tue, 21 Oct 2025 07:09:59 +0000 (UTC)
X-Farcaster-Flow-ID: 533d5b60-49a1-492a-8ab5-004364c4dd08
Received: from EX19D013EUB004.ant.amazon.com (10.252.51.92) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 21 Oct 2025 07:09:59 +0000
Received: from dev-dsk-mngyadam-1c-cb3f7548.eu-west-1.amazon.com
 (10.253.107.175) by EX19D013EUB004.ant.amazon.com (10.252.51.92) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Tue, 21 Oct 2025
 07:09:48 +0000
From: Mahmoud Adam <mngyadam@amazon.de>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <nagy@khwaternagy.com>, Christoph Hellwig
	<hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke
	<hare@suse.de>, "Darrick J. Wong" <djwong@kernel.org>, Al Viro
	<viro@zeniv.linux.org.uk>, Andreas Gruenbacher <agruenba@redhat.com>, "Anna
 Schumaker" <anna@kernel.org>, Chao Yu <chao@kernel.org>, Christian Brauner
	<brauner@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Jaegeuk Kim
	<jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, Johannes Thumshirn
	<johannes.thumshirn@wdc.com>, Matthew Wilcox <willy@infradead.org>, "Miklos
 Szeredi" <miklos@szeredi.hu>, Miklos Szeredi <mszeredi@redhat.com>, "Theodore
 Ts'o" <tytso@mit.edu>, Trond Myklebust <trond.myklebust@hammerspace.com>,
	Xiubo Li <xiubli@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	"Jeff Layton" <jlayton@kernel.org>, Andreas Dilger
	<adilger.kernel@dilger.ca>, Christoph Hellwig <hch@infradead.org>, Ryusuke
 Konishi <konishi.ryusuke@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ceph-devel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>,
	<linux-xfs@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<linux-nilfs@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH 6.1 2/8] filemap: add a kiocb_invalidate_post_direct_write helper
Date: Tue, 21 Oct 2025 09:03:37 +0200
Message-ID: <20251021070353.96705-4-mngyadam@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251021070353.96705-2-mngyadam@amazon.de>
References: <20251021070353.96705-2-mngyadam@amazon.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D013EUB004.ant.amazon.com (10.252.51.92)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Christoph Hellwig <hch@lst.de>

commit c402a9a9430b670926decbb284b756ee6f47c1ec upstream.

Add a helper to invalidate page cache after a dio write.

Link: https://lkml.kernel.org/r/20230601145904.1385409-7-hch@lst.de
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Acked-by: Darrick J. Wong <djwong@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Anna Schumaker <anna@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Mahmoud Adam <mngyadam@amazon.de>
---
 fs/direct-io.c          | 10 ++--------
 fs/iomap/direct-io.c    | 12 ++----------
 include/linux/fs.h      |  5 -----
 include/linux/pagemap.h |  1 +
 mm/filemap.c            | 37 ++++++++++++++++++++-----------------
 5 files changed, 25 insertions(+), 40 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 03d381377ae10a..514042f12aea76 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -286,14 +286,8 @@ static ssize_t dio_complete(struct dio *dio, ssize_t ret, unsigned int flags)
 	 * zeros from unwritten extents.
 	 */
 	if (flags & DIO_COMPLETE_INVALIDATE &&
-	    ret > 0 && dio_op == REQ_OP_WRITE &&
-	    dio->inode->i_mapping->nrpages) {
-		err = invalidate_inode_pages2_range(dio->inode->i_mapping,
-					offset >> PAGE_SHIFT,
-					(offset + ret - 1) >> PAGE_SHIFT);
-		if (err)
-			dio_warn_stale_pagecache(dio->iocb->ki_filp);
-	}
+	    ret > 0 && dio_op == REQ_OP_WRITE)
+		kiocb_invalidate_post_direct_write(dio->iocb, ret);
 
 	inode_dio_end(dio->inode);
 
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 105c4a1d20a20b..9acfc9e847cdcb 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -81,7 +81,6 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
 {
 	const struct iomap_dio_ops *dops = dio->dops;
 	struct kiocb *iocb = dio->iocb;
-	struct inode *inode = file_inode(iocb->ki_filp);
 	loff_t offset = iocb->ki_pos;
 	ssize_t ret = dio->error;
 
@@ -108,15 +107,8 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
 	 * ->end_io() when necessary, otherwise a racing buffer read would cache
 	 * zeros from unwritten extents.
 	 */
-	if (!dio->error && dio->size &&
-	    (dio->flags & IOMAP_DIO_WRITE) && inode->i_mapping->nrpages) {
-		int err;
-		err = invalidate_inode_pages2_range(inode->i_mapping,
-				offset >> PAGE_SHIFT,
-				(offset + dio->size - 1) >> PAGE_SHIFT);
-		if (err)
-			dio_warn_stale_pagecache(iocb->ki_filp);
-	}
+	if (!dio->error && dio->size && (dio->flags & IOMAP_DIO_WRITE))
+		kiocb_invalidate_post_direct_write(iocb, dio->size);
 
 	inode_dio_end(file_inode(iocb->ki_filp));
 	if (ret > 0) {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 48758ab2910087..4e8a3e4f894c0f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3371,11 +3371,6 @@ static inline void inode_dio_end(struct inode *inode)
 		wake_up_bit(&inode->i_state, __I_DIO_WAKEUP);
 }
 
-/*
- * Warn about a page cache invalidation failure diring a direct I/O write.
- */
-void dio_warn_stale_pagecache(struct file *filp);
-
 extern void inode_set_flags(struct inode *inode, unsigned int flags,
 			    unsigned int mask);
 
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index bb462e5a91e28d..dfaa0990186716 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -31,6 +31,7 @@ int invalidate_inode_pages2(struct address_space *mapping);
 int invalidate_inode_pages2_range(struct address_space *mapping,
 		pgoff_t start, pgoff_t end);
 int kiocb_invalidate_pages(struct kiocb *iocb, size_t count);
+void kiocb_invalidate_post_direct_write(struct kiocb *iocb, size_t count);
 int write_inode_now(struct inode *, int sync);
 int filemap_fdatawrite(struct address_space *);
 int filemap_flush(struct address_space *);
diff --git a/mm/filemap.c b/mm/filemap.c
index 0923b8df285886..39484af4300e3c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3733,7 +3733,7 @@ EXPORT_SYMBOL(read_cache_page_gfp);
 /*
  * Warn about a page cache invalidation failure during a direct I/O write.
  */
-void dio_warn_stale_pagecache(struct file *filp)
+static void dio_warn_stale_pagecache(struct file *filp)
 {
 	static DEFINE_RATELIMIT_STATE(_rs, 86400 * HZ, DEFAULT_RATELIMIT_BURST);
 	char pathname[128];
@@ -3750,19 +3750,23 @@ void dio_warn_stale_pagecache(struct file *filp)
 	}
 }
 
+void kiocb_invalidate_post_direct_write(struct kiocb *iocb, size_t count)
+{
+	struct address_space *mapping = iocb->ki_filp->f_mapping;
+
+	if (mapping->nrpages &&
+	    invalidate_inode_pages2_range(mapping,
+			iocb->ki_pos >> PAGE_SHIFT,
+			(iocb->ki_pos + count - 1) >> PAGE_SHIFT))
+		dio_warn_stale_pagecache(iocb->ki_filp);
+}
+
 ssize_t
 generic_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct file	*file = iocb->ki_filp;
-	struct address_space *mapping = file->f_mapping;
-	struct inode	*inode = mapping->host;
-	loff_t		pos = iocb->ki_pos;
-	ssize_t		written;
-	size_t		write_len;
-	pgoff_t		end;
-
-	write_len = iov_iter_count(from);
-	end = (pos + write_len - 1) >> PAGE_SHIFT;
+	struct address_space *mapping = iocb->ki_filp->f_mapping;
+	size_t write_len = iov_iter_count(from);
+	ssize_t written;
 
 	/*
 	 * If a page can not be invalidated, return 0 to fall back
@@ -3772,7 +3776,7 @@ generic_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	if (written) {
 		if (written == -EBUSY)
 			return 0;
-		goto out;
+		return written;
 	}
 
 	written = mapping->a_ops->direct_IO(iocb, from);
@@ -3794,11 +3798,11 @@ generic_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	 *
 	 * Skip invalidation for async writes or if mapping has no pages.
 	 */
-	if (written > 0 && mapping->nrpages &&
-	    invalidate_inode_pages2_range(mapping, pos >> PAGE_SHIFT, end))
-		dio_warn_stale_pagecache(file);
-
 	if (written > 0) {
+		struct inode *inode = mapping->host;
+		loff_t pos = iocb->ki_pos;
+
+		kiocb_invalidate_post_direct_write(iocb, written);
 		pos += written;
 		write_len -= written;
 		if (pos > i_size_read(inode) && !S_ISBLK(inode->i_mode)) {
@@ -3809,7 +3813,6 @@ generic_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	}
 	if (written != -EIOCBQUEUED)
 		iov_iter_revert(from, write_len - iov_iter_count(from));
-out:
 	return written;
 }
 EXPORT_SYMBOL(generic_file_direct_write);
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


