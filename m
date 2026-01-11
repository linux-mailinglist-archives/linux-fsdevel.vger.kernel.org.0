Return-Path: <linux-fsdevel+bounces-73146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 017B5D0E21B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 08:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DB99301356B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 07:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992CB2F5313;
	Sun, 11 Jan 2026 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GLdLcGC1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ACE22259F;
	Sun, 11 Jan 2026 07:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768117968; cv=none; b=rVeddyhCHJMNIsojcz1vsv7IT/YOm9olV4mbRphrc33anQlVLbBhPCncGbCupdnGYiF1TVAmQ6eu7Pqk0XWVhGiQhl2lPNUgCdHNO3I6SkassKxkYIVbNnxmgohaUVhJx9ojySdvzmPj4cMMcHOY4BVta0RGPrMMCKp4kGzmwhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768117968; c=relaxed/simple;
	bh=2tAnJGboiKWISZau3Eik16dF53KXk1wFnW5FTHTQuYk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pyO5w+Dc8FhJ+o6jmXpbbJlblsfApRBM5q4yuja3XFPmHBN9fRe27+S/n1BH/KxE4CQ2ManemYK3ukUBAPEN+TFTnRssm3fFbhS8W+vUD7/GSN0cGzlvCtf3ccafbuLdOgEu0/qmKNTQiDdzjkTCWlZF4xqIjfW3hmP1Aat8QM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GLdLcGC1; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768117962; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=fzYtEMG7YPKtRSaAm83qPT8QmOnagNJzmG9FhKWuRhs=;
	b=GLdLcGC1ZhPfG0xuV+apngT/2YFtkt/jzJfGO/ukFSwkQsH4ChR4wYTuGb4Waj+XCszboz/wdb5csZaZaaw2tNe94q34Ko5uFYY9Zo5cxO6ykXKif7n8yVB6PN55Gblh/ovNPxYbfH0F7lRbq0hH6FaW2yaHF3pHWHn4NAwdN2w=
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WwloiGR_1768117021 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 11 Jan 2026 15:37:02 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org,
	bschubert@ddn.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v3] fuse: invalidate the page cache after direct write
Date: Sun, 11 Jan 2026 15:37:01 +0800
Message-Id: <20260111073701.6071-1-jefflexu@linux.alibaba.com>
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
		 generic_file_direct_write() otherwise

Reviewed-by: Bernd Schubert <bschubert@ddn.com>
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
changes:
- drop "|| !ia->io->blocking" in fuse_send_write() (Bernd)
---
 fs/fuse/file.c | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 01bc894e9c2b..625d236b881b 100644
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
@@ -1160,10 +1174,26 @@ static ssize_t fuse_send_write(struct fuse_io_args *ia, loff_t pos,
 		return fuse_async_req_send(fm, ia, count);
 
 	err = fuse_simple_request(fm, &ia->ap.args);
-	if (!err && ia->write.out.size > count)
+	written = ia->write.out.size;
+	if (!err && written > count)
 		err = -EIO;
 
-	return err ?: ia->write.out.size;
+	/*
+	 * Without FOPEN_DIRECT_IO, generic_file_direct_write() does the
+	 * invalidation for us.
+	 */
+	if (!err && written && mapping->nrpages &&
+	    (ff->open_flags & FOPEN_DIRECT_IO)) {
+		/*
+		 * As in generic_file_direct_write(), invalidate after the
+		 * write, to invalidate read-ahead cache that may have competed
+		 * with the write.
+		 */
+		invalidate_inode_pages2_range(mapping, pos >> PAGE_SHIFT,
+					(pos + written - 1) >> PAGE_SHIFT);
+	}
+
+	return err ?: written;
 }
 
 bool fuse_write_update_attr(struct inode *inode, loff_t pos, ssize_t written)
@@ -1738,15 +1768,6 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
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


