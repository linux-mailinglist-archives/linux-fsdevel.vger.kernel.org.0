Return-Path: <linux-fsdevel+bounces-64819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF07BF4E59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 09:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E39B350246E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 07:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2547279798;
	Tue, 21 Oct 2025 07:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="rQJv4+T5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-001.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-001.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.156.205.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49F7227E83;
	Tue, 21 Oct 2025 07:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.156.205.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761030675; cv=none; b=HZrfidmMLCRUmV/EYjfcS8Nsx6ueg3XOT/UIm0eWnXyA2SA91gPxuNJhzaTEtyUentPgWqgcLBJtTi1ifEBcd2UHhEH6j6XeBKTIpNPO1d422lzj8m6sgyCp2MJjdSLOBU1V+wr7fbWVrirbxz5qjkvgzQczWXUE00ezoPZP7Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761030675; c=relaxed/simple;
	bh=NedYjdt3harctfQHy2LxknH3Up6TsR4kfMruhCy+Qhw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DWFvMEsuOYxk+wrJPIIuZSvsuRrQ3377iu7MJFqu6BG2sVw1ZkgjFL8PEaVG2OVqVtHvROtKSp8Zfdjq2XuPUz3yWw3f4Dh8UZjB1DHlLF7YqT4eMlFSmgb7YbsocLVN2A/O4yx9OustFix84A6IPAJD7CgkH/ja9tU504ydDnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=rQJv4+T5; arc=none smtp.client-ip=18.156.205.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1761030673; x=1792566673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EWT2gm3mr1yTWppm7hvARyuErTtEe+bWsoFO42B5tnI=;
  b=rQJv4+T5EupMGoyFYEesF8+/V+dC8ClJggBStXH2vNXzu3URTi577vG3
   SiuGAIMFAozfFfyM7ifbIVKlCxV+ie2eJJjhxN/f4IVwjea6nSDe0YPy1
   +0pSr7hr9YKN9U0DAblQ7Oi8xgiColtPvs3ZCNV1ntQikpfCIpnGhsY/j
   WhZkAhf5tKGqRR96O7Igz3DPh54S1+gz0x71JSNjT1M4Oa1YVCnWNjDel
   wyv8nS4gny9qU7eSn0Br9GYXxLrxw8qvpPu7GS62UPF4k6RdfdLuP0QFu
   NNC6zh5eg1sTRYNtAg+NBmI5pR7EL9EVBG+Bkl7s94zK6Yub93OkShClY
   w==;
X-CSE-ConnectionGUID: DKfSEOkqQQKB8ERoq7WY2A==
X-CSE-MsgGUID: DEt+B/AnQgG5Vzyn9KIMpA==
X-IronPort-AV: E=Sophos;i="6.19,244,1754956800"; 
   d="scan'208";a="3933276"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-001.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 07:10:59 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.228:11521]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.29.7:2525] with esmtp (Farcaster)
 id 72943488-d8d8-46a1-a014-aaf1f5c61ddd; Tue, 21 Oct 2025 07:10:59 +0000 (UTC)
X-Farcaster-Flow-ID: 72943488-d8d8-46a1-a014-aaf1f5c61ddd
Received: from EX19D013EUB004.ant.amazon.com (10.252.51.92) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 21 Oct 2025 07:10:59 +0000
Received: from dev-dsk-mngyadam-1c-cb3f7548.eu-west-1.amazon.com
 (10.253.107.175) by EX19D013EUB004.ant.amazon.com (10.252.51.92) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Tue, 21 Oct 2025
 07:10:48 +0000
From: Mahmoud Adam <mngyadam@amazon.de>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <nagy@khwaternagy.com>, Christoph Hellwig
	<hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>, Miklos Szeredi
	<mszeredi@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>, Al Viro
	<viro@zeniv.linux.org.uk>, Andreas Gruenbacher <agruenba@redhat.com>, "Anna
 Schumaker" <anna@kernel.org>, Chao Yu <chao@kernel.org>, Christian Brauner
	<brauner@kernel.org>, Hannes Reinecke <hare@suse.de>, Ilya Dryomov
	<idryomov@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe
	<axboe@kernel.dk>, Johannes Thumshirn <johannes.thumshirn@wdc.com>, "Matthew
 Wilcox" <willy@infradead.org>, Miklos Szeredi <miklos@szeredi.hu>, "Theodore
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
Subject: [PATCH 6.1 4/8] fs: factor out a direct_write_fallback helper
Date: Tue, 21 Oct 2025 09:03:39 +0200
Message-ID: <20251021070353.96705-6-mngyadam@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251021070353.96705-2-mngyadam@amazon.de>
References: <20251021070353.96705-2-mngyadam@amazon.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D013EUB004.ant.amazon.com (10.252.51.92)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Christoph Hellwig <hch@lst.de>

commit 44fff0fa08ec5a6d9d5fb05443a36d854d0ece4d upstream.

Add a helper dealing with handling the syncing of a buffered write
fallback for direct I/O.

Link: https://lkml.kernel.org/r/20230601145904.1385409-10-hch@lst.de
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Anna Schumaker <anna@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[backing_dev_info still being used here. do small changes to the patch
to keep the out label. Which means replacing all returns to goto out.]
Signed-off-by: Mahmoud Adam <mngyadam@amazon.de>
---
 fs/libfs.c         | 41 +++++++++++++++++++++++++++++++
 include/linux/fs.h |  2 ++
 mm/filemap.c       | 61 +++++++++++-----------------------------------
 3 files changed, 57 insertions(+), 47 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index cbd42d76fbd018..a5bbe8e31d6616 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1582,3 +1582,44 @@ bool inode_maybe_inc_iversion(struct inode *inode, bool force)
 	return true;
 }
 EXPORT_SYMBOL(inode_maybe_inc_iversion);
+
+ssize_t direct_write_fallback(struct kiocb *iocb, struct iov_iter *iter,
+		ssize_t direct_written, ssize_t buffered_written)
+{
+	struct address_space *mapping = iocb->ki_filp->f_mapping;
+	loff_t pos = iocb->ki_pos - buffered_written;
+	loff_t end = iocb->ki_pos - 1;
+	int err;
+
+	/*
+	 * If the buffered write fallback returned an error, we want to return
+	 * the number of bytes which were written by direct I/O, or the error
+	 * code if that was zero.
+	 *
+	 * Note that this differs from normal direct-io semantics, which will
+	 * return -EFOO even if some bytes were written.
+	 */
+	if (unlikely(buffered_written < 0)) {
+		if (direct_written)
+			return direct_written;
+		return buffered_written;
+	}
+
+	/*
+	 * We need to ensure that the page cache pages are written to disk and
+	 * invalidated to preserve the expected O_DIRECT semantics.
+	 */
+	err = filemap_write_and_wait_range(mapping, pos, end);
+	if (err < 0) {
+		/*
+		 * We don't know how much we wrote, so just return the number of
+		 * bytes which were direct-written
+		 */
+		if (direct_written)
+			return direct_written;
+		return err;
+	}
+	invalidate_mapping_pages(mapping, pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
+	return direct_written + buffered_written;
+}
+EXPORT_SYMBOL_GPL(direct_write_fallback);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4e8a3e4f894c0f..02c83cd07d4f20 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3278,6 +3278,8 @@ extern ssize_t __generic_file_write_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t generic_file_write_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t generic_file_direct_write(struct kiocb *, struct iov_iter *);
 ssize_t generic_perform_write(struct kiocb *, struct iov_iter *);
+ssize_t direct_write_fallback(struct kiocb *iocb, struct iov_iter *iter,
+		ssize_t direct_written, ssize_t buffered_written);
 
 ssize_t vfs_iter_read(struct file *file, struct iov_iter *iter, loff_t *ppos,
 		rwf_t flags);
diff --git a/mm/filemap.c b/mm/filemap.c
index e2045266d2f2c9..b77f534dfad35a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3923,25 +3923,21 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
-	struct inode 	*inode = mapping->host;
-	ssize_t		written = 0;
-	ssize_t		err;
-	ssize_t		status;
+	struct inode *inode = mapping->host;
+	ssize_t ret;
 
 	/* We can write back this queue in page reclaim */
 	current->backing_dev_info = inode_to_bdi(inode);
-	err = file_remove_privs(file);
-	if (err)
+	ret = file_remove_privs(file);
+	if (ret)
 		goto out;
 
-	err = file_update_time(file);
-	if (err)
+	ret = file_update_time(file);
+	if (ret)
 		goto out;
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
-		loff_t pos, endbyte;
-
-		written = generic_file_direct_write(iocb, from);
+		ret = generic_file_direct_write(iocb, from);
 		/*
 		 * If the write stopped short of completing, fall back to
 		 * buffered writes.  Some filesystems do this for writes to
@@ -3949,46 +3945,17 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		 * not succeed (even if it did, DAX does not handle dirty
 		 * page-cache pages correctly).
 		 */
-		if (written < 0 || !iov_iter_count(from) || IS_DAX(inode))
+		if (ret < 0 || !iov_iter_count(from) || IS_DAX(inode))
 			goto out;
-
-		pos = iocb->ki_pos;
-		status = generic_perform_write(iocb, from);
-		/*
-		 * If generic_perform_write() returned a synchronous error
-		 * then we want to return the number of bytes which were
-		 * direct-written, or the error code if that was zero.  Note
-		 * that this differs from normal direct-io semantics, which
-		 * will return -EFOO even if some bytes were written.
-		 */
-		if (unlikely(status < 0)) {
-			err = status;
-			goto out;
-		}
-		/*
-		 * We need to ensure that the page cache pages are written to
-		 * disk and invalidated to preserve the expected O_DIRECT
-		 * semantics.
-		 */
-		endbyte = pos + status - 1;
-		err = filemap_write_and_wait_range(mapping, pos, endbyte);
-		if (err == 0) {
-			written += status;
-			invalidate_mapping_pages(mapping,
-						 pos >> PAGE_SHIFT,
-						 endbyte >> PAGE_SHIFT);
-		} else {
-			/*
-			 * We don't know how much we wrote, so just return
-			 * the number of bytes which were direct-written
-			 */
-		}
-	} else {
-		written = generic_perform_write(iocb, from);
+		ret = direct_write_fallback(iocb, from, ret,
+				generic_perform_write(iocb, from));
+		goto out;
 	}
+
+	ret = generic_perform_write(iocb, from);
 out:
 	current->backing_dev_info = NULL;
-	return written ? written : err;
+	return ret;
 }
 EXPORT_SYMBOL(__generic_file_write_iter);
 
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


