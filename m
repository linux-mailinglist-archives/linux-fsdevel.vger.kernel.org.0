Return-Path: <linux-fsdevel+bounces-64815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91815BF4D67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 09:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7791A18C5FB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 07:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0DE274B5C;
	Tue, 21 Oct 2025 07:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="EossVXMv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.72.182.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB0C1369B4;
	Tue, 21 Oct 2025 07:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.72.182.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761030587; cv=none; b=sO8qeh8TJAjiA7FIpCkWRmBQAbW84gdlNJgITDz6qv958q63RyFjSyVIXzuM6rEZ40kY7RpZyAKuwPUTFxp9c1y+AtEm31Y/pnXe084X6nRzJJzzpVkv6Ez5VCXPU5bgdHcov87YJxnJ3RnPkdeqPfk9TWOqoYo88hBXddaypFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761030587; c=relaxed/simple;
	bh=xUSk8LiAjBR7wIY9a1W1AM/GYvH5kT/DZkSS34KxDMM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mhirVlnNAIHubuc6Z9t9XT2nVshAIbtP4uCycTZTRl6g9rF5Xg30yU9SjB0YpqWEpZBMflCxZguV23WSkdVBJj8z4nhdE7weZonLaEAwplNYMWBpASKxjhqk0yqE/iIDC3Z8HVOYUOSvqaqB9B6tifXHQAcHcXBh940W7feC4D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=EossVXMv; arc=none smtp.client-ip=3.72.182.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1761030583; x=1792566583;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IRrO90fketCOWk9bfh6aaz0EBHE6DKiahtipOxhwoDQ=;
  b=EossVXMvvN620OzMFydwN38Q+dSohdkJ0u2MAistdkiXFELcteFT5149
   R3LhEbwrHJTEeW6ubz16FW5/KEPOxIJhebz9L/N6jC3Qv9GPaYvosWPIA
   IPsAjhI+wO3+bUC49sMv18tOuhxEIP/rgWOXwO7H4PhyG3aq93gPxmmP3
   7CjZEcrrYYM1CnPaOhvXy2AnjbkSE56rKHSQZH08wg1Gjau12NcpNjGqr
   T7FK7MQIa3qQB+rnwuky09rNfbP0sxk2yEZl2XsY+FffDGDX0E/ZE0j8w
   lh2HTU7E4ftTATorEg4AHg9EzzNU6+wVrFs+K7sTTzG+xkGRDGY0CjkHH
   g==;
X-CSE-ConnectionGUID: TslvYmjVRZ67KeFhlmCKUA==
X-CSE-MsgGUID: BZ4tqt3BSO+r/jg1BcNIPQ==
X-IronPort-AV: E=Sophos;i="6.19,244,1754956800"; 
   d="scan'208";a="3938994"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 07:09:31 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.226:2712]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.15.203:2525] with esmtp (Farcaster)
 id 3b019c0e-37f5-4041-9549-5b8fdb60007b; Tue, 21 Oct 2025 07:09:31 +0000 (UTC)
X-Farcaster-Flow-ID: 3b019c0e-37f5-4041-9549-5b8fdb60007b
Received: from EX19D013EUB004.ant.amazon.com (10.252.51.92) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 21 Oct 2025 07:09:28 +0000
Received: from dev-dsk-mngyadam-1c-cb3f7548.eu-west-1.amazon.com
 (10.253.107.175) by EX19D013EUB004.ant.amazon.com (10.252.51.92) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Tue, 21 Oct 2025
 07:09:18 +0000
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
Subject: [PATCH 6.1 1/8] filemap: add a kiocb_invalidate_pages helper
Date: Tue, 21 Oct 2025 09:03:36 +0200
Message-ID: <20251021070353.96705-3-mngyadam@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251021070353.96705-2-mngyadam@amazon.de>
References: <20251021070353.96705-2-mngyadam@amazon.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
 EX19D013EUB004.ant.amazon.com (10.252.51.92)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Christoph Hellwig <hch@lst.de>

commit e003f74afbd2feadbb9ffbf9135e2d2fb5d320a5 upstream.

Factor out a helper that calls filemap_write_and_wait_range and
invalidate_inode_pages2_range for the range covered by a write kiocb or
returns -EAGAIN if the kiocb is marked as nowait and there would be pages
to write or invalidate.

Link: https://lkml.kernel.org/r/20230601145904.1385409-6-hch@lst.de
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
 include/linux/pagemap.h |  1 +
 mm/filemap.c            | 48 ++++++++++++++++++++++++-----------------
 2 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 1be5a1fa6a3a84..bb462e5a91e28d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -30,6 +30,7 @@ static inline void invalidate_remote_inode(struct inode *inode)
 int invalidate_inode_pages2(struct address_space *mapping);
 int invalidate_inode_pages2_range(struct address_space *mapping,
 		pgoff_t start, pgoff_t end);
+int kiocb_invalidate_pages(struct kiocb *iocb, size_t count);
 int write_inode_now(struct inode *, int sync);
 int filemap_fdatawrite(struct address_space *);
 int filemap_flush(struct address_space *);
diff --git a/mm/filemap.c b/mm/filemap.c
index 2ae6c6146d848a..0923b8df285886 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2839,6 +2839,33 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 }
 EXPORT_SYMBOL_GPL(filemap_read);
 
+int kiocb_invalidate_pages(struct kiocb *iocb, size_t count)
+{
+	struct address_space *mapping = iocb->ki_filp->f_mapping;
+	loff_t pos = iocb->ki_pos;
+	loff_t end = pos + count - 1;
+	int ret;
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		/* we could block if there are any pages in the range */
+		if (filemap_range_has_page(mapping, pos, end))
+			return -EAGAIN;
+	} else {
+		ret = filemap_write_and_wait_range(mapping, pos, end);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * After a write we want buffered reads to be sure to go to disk to get
+	 * the new data.  We invalidate clean cached page from the region we're
+	 * about to write.  We do this *before* the write so that we can return
+	 * without clobbering -EIOCBQUEUED from ->direct_IO().
+	 */
+	return invalidate_inode_pages2_range(mapping, pos >> PAGE_SHIFT,
+					     end >> PAGE_SHIFT);
+}
+
 /**
  * generic_file_read_iter - generic filesystem read routine
  * @iocb:	kernel I/O control block
@@ -3737,30 +3764,11 @@ generic_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	write_len = iov_iter_count(from);
 	end = (pos + write_len - 1) >> PAGE_SHIFT;
 
-	if (iocb->ki_flags & IOCB_NOWAIT) {
-		/* If there are pages to writeback, return */
-		if (filemap_range_has_page(file->f_mapping, pos,
-					   pos + write_len - 1))
-			return -EAGAIN;
-	} else {
-		written = filemap_write_and_wait_range(mapping, pos,
-							pos + write_len - 1);
-		if (written)
-			goto out;
-	}
-
-	/*
-	 * After a write we want buffered reads to be sure to go to disk to get
-	 * the new data.  We invalidate clean cached page from the region we're
-	 * about to write.  We do this *before* the write so that we can return
-	 * without clobbering -EIOCBQUEUED from ->direct_IO().
-	 */
-	written = invalidate_inode_pages2_range(mapping,
-					pos >> PAGE_SHIFT, end);
 	/*
 	 * If a page can not be invalidated, return 0 to fall back
 	 * to buffered write.
 	 */
+	written = kiocb_invalidate_pages(iocb, write_len);
 	if (written) {
 		if (written == -EBUSY)
 			return 0;
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


