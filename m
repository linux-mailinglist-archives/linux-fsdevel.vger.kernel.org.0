Return-Path: <linux-fsdevel+bounces-73010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1947D077BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 08:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 913ED3048621
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 07:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14C82E7BDC;
	Fri,  9 Jan 2026 07:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pjGalkW1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3216D1E511;
	Fri,  9 Jan 2026 07:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767942077; cv=none; b=tBkN2Q8YWM0W2GwjeWSaqAn2iA+vfXW+H8eAiWZdexpFUwy7nDpWAK/eiiYBJqVc80e4jMB+p1NqltCpjejvO95LtXkmwcaw1bClZPJgL11t9D6nH8k61mBvpefFuC1JIWMhvwosbF42HZS+gCszlynUzC6ogdRJWz3kUNpGCrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767942077; c=relaxed/simple;
	bh=8zG6u3mXw5NcFdA9FL9qD5iAdkkam5pIZED0dvnzwVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LSu6EcI7qjxuxfYJDRfAVC0A//2ukV7r7OAtQltroXvofUTA9pFWDCk3xnNmuyUx1rFB/SOQ2W1Y1esius1SOCOYKmOstgzyJWkFQAhBly6CyRlN+vnfeS4mEp99iOO308FB80/BITbt10Ulq7TcxlGvDOinQHZ5ng/mBmYhku4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pjGalkW1; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767942070; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=R9EET8AOE1I0v+3n6GW12HAp6JQhapL2nHSNMXhwSaM=;
	b=pjGalkW1pBQnMXDqZHRnyh1f7p0JkUi1p2B43Sept2YAZki9xU7YhjD/3mhwtyiJcaexMUav1PtP7O9PPhSF9BAyJ4yoscHS+8Z3URX0HDKevoTNaFOnvmmqIPrOx6sc2bPd/E9cY7OfbdMvdDKDszHdJPAYXYV2SZ799CaX/14=
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WwfE40Q_1767942070 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 09 Jan 2026 15:01:10 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org,
	bschubert@ddn.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2] fuse: invalidate the page cache after direct write
Date: Fri,  9 Jan 2026 15:01:10 +0800
Message-Id: <20260109070110.18721-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes xfstests generic/451 (for both O_DIRECT and FOPEN_DIRECT_IO
direct write).

Commit b359af8275a9 ("fuse: Invalidate the page cache after
FOPEN_DIRECT_IO write") tries to fix the similar issue for
FOPEN_DIRECT_IO write, which can be reproduced by xfstests generic/209.
It only fixes the issue for synchronous direct write, while omitting
the case for asynchronous direct write (exactly targeted by
generic/451).

While for O_DIRECT direct write, it's somewhat more complicated.  For
synchronous direct write, generic_file_direct_write() will invalidate
the page cache after the write, and thus it can pass generic/209.  While
for asynchronous direct write, the invalidation in
generic_file_direct_write() is bypassed since the invalidation shall be
done when the asynchronous IO completes.  This is omitted in FUSE and
generic/451 fails whereby.

Fix this by conveying the invalidation for both synchronous and
asynchronous write.

- with FOPEN_DIRECT_IO
  - sync write,  invalidate in fuse_send_write()
  - async write, invalidate in fuse_aio_complete() with FUSE_ASYNC_DIO,
		 fuse_send_write() otherwise
- without FOPEN_DIRECT_IO
  - sync write,  invalidate in generic_file_direct_write()
  - async write, invalidate in fuse_aio_complete() with FUSE_ASYNC_DIO,
		 fuse_send_write() otherwise

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
changes since v1:
- remove the redundant invalidation for synchronous write without
  FOPEN_DIRECT_IO (Bernd)
v1: https://yhbt.net/lore/all/20260106075234.63364-1-jefflexu@linux.alibaba.com/
---
 fs/fuse/file.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 01bc894e9c2b..9751482601ea 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -667,6 +667,18 @@ static void fuse_aio_complete(struct fuse_io_priv *io, int err, ssize_t pos)
 			struct inode *inode = file_inode(io->iocb->ki_filp);
 			struct fuse_conn *fc = get_fuse_conn(inode);
 			struct fuse_inode *fi = get_fuse_inode(inode);
+			struct address_space *mapping = io->iocb->ki_filp->f_mapping;
+
+			/*
+			 * As in generic_file_direct_write(), invalidate after the
+			 * write, to invalidate read-ahead cache that may have competed
+			 * with the write.
+			 */
+			if (io->write && res && mapping->nrpages) {
+				invalidate_inode_pages2_range(mapping,
+						io->offset >> PAGE_SHIFT,
+						(io->offset + res - 1) >> PAGE_SHIFT);
+			}
 
 			spin_lock(&fi->lock);
 			fi->attr_version = atomic64_inc_return(&fc->attr_version);
@@ -1144,9 +1156,11 @@ static ssize_t fuse_send_write(struct fuse_io_args *ia, loff_t pos,
 {
 	struct kiocb *iocb = ia->io->iocb;
 	struct file *file = iocb->ki_filp;
+	struct address_space *mapping = file->f_mapping;
 	struct fuse_file *ff = file->private_data;
 	struct fuse_mount *fm = ff->fm;
 	struct fuse_write_in *inarg = &ia->write.in;
+	ssize_t written;
 	ssize_t err;
 
 	fuse_write_args_fill(ia, ff, pos, count);
@@ -1160,10 +1174,23 @@ static ssize_t fuse_send_write(struct fuse_io_args *ia, loff_t pos,
 		return fuse_async_req_send(fm, ia, count);
 
 	err = fuse_simple_request(fm, &ia->ap.args);
-	if (!err && ia->write.out.size > count)
+	written = ia->write.out.size;
+	if (!err && written > count)
 		err = -EIO;
 
-	return err ?: ia->write.out.size;
+	/*
+	 * As in generic_file_direct_write(), invalidate after the write, to
+	 * invalidate read-ahead cache that may have competed with the write.
+	 * Without FOPEN_DIRECT_IO, generic_file_direct_write() does the
+	 * invalidation for synchronous write.
+	 */
+	if (!err && written && mapping->nrpages &&
+	    ((ff->open_flags & FOPEN_DIRECT_IO) || !ia->io->blocking)) {
+		invalidate_inode_pages2_range(mapping, pos >> PAGE_SHIFT,
+					(pos + written - 1) >> PAGE_SHIFT);
+	}
+
+	return err ?: written;
 }
 
 bool fuse_write_update_attr(struct inode *inode, loff_t pos, ssize_t written)
@@ -1738,15 +1765,6 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 	if (res > 0)
 		*ppos = pos;
 
-	if (res > 0 && write && fopen_direct_io) {
-		/*
-		 * As in generic_file_direct_write(), invalidate after the
-		 * write, to invalidate read-ahead cache that may have competed
-		 * with the write.
-		 */
-		invalidate_inode_pages2_range(mapping, idx_from, idx_to);
-	}
-
 	return res > 0 ? res : err;
 }
 EXPORT_SYMBOL_GPL(fuse_direct_io);
-- 
2.19.1.6.gb485710b


