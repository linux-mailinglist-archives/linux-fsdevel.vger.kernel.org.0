Return-Path: <linux-fsdevel+bounces-72458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5332CF736A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 09:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98A1831293E4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 08:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C759F30C608;
	Tue,  6 Jan 2026 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="c6PyFi+E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B74530AAD7;
	Tue,  6 Jan 2026 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767685968; cv=none; b=WXQjNWnL/nqtol6QdWqL6UrpRSm0BFNhvlcTkMtiBB6Uo93x2g7SwAMIfIHgnbH/dJ7foIlV/xS5HtQj6B5tCtkkUtn/MI4oz0T//7AMdgmmnklHg7jxEQBUct/qjLCPK4t1nwQh3k5s4T+O5uwTJWUNGrFOl35pW2k8LR+a3MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767685968; c=relaxed/simple;
	bh=y67ezT2yo7NAjfG/24lZOuReDHCgurKvcmkAFACo3TU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lp7LjxPw5uVsc1CTmMA1nmS8FejLrk9fnKK+9Kb2nc5o2ju7Y24l4qTsqEOrb2sufRw/Lu5zf/4kI/4AVBiQ9uR+wShSxb//Wb+NgdUXQ/LxJufk0yGJwzEot1B1xskIUbTl6P84xNrL2o3UijrK/S92vpFK0IsHd4AYvTOYp0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=c6PyFi+E; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767685955; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=SpD40QTjviMYph6gxf7A3LrYyXUucrfILD2f/BYeKT8=;
	b=c6PyFi+ELdUtSpb5bsdJWFEtQhLFj9pTEawZ+3xdP3cASzAD/OMtoGd/Jg89fxYXEK/jdAOTLcg+oAMsnbxfM6ue0zhzIEzJQKCk/ISmZRAFTMnIzHzNNrZ7lsUqYeShbI6sasA/taVL4UGoQNO5PZAHQpRI1+944dP5pWFMgSE=
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WwV3-Ee_1767685954 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 06 Jan 2026 15:52:35 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org,
	bschubert@ddn.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fuse: invalidate the page cache after direct write
Date: Tue,  6 Jan 2026 15:52:34 +0800
Message-Id: <20260106075234.63364-1-jefflexu@linux.alibaba.com>
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

Fix this by conveying the invalidation in both sync and async
(FUSE_ASYNC_DIO) request submission.  The only side effect is that
there's a redundant invalidation for synchronous direct write when
FUSE_ASYNC_DIO is disabled (in fuse_send_write()), given the same
range has been invalidated once in generic_file_direct_write().

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/file.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 01bc894e9c2b..d6ae3b4652f8 100644
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
@@ -1160,10 +1174,20 @@ static ssize_t fuse_send_write(struct fuse_io_args *ia, loff_t pos,
 		return fuse_async_req_send(fm, ia, count);
 
 	err = fuse_simple_request(fm, &ia->ap.args);
-	if (!err && ia->write.out.size > count)
+	written = ia->write.out.size;
+	if (!err && written > count)
 		err = -EIO;
+	if (!err && written && mapping->nrpages) {
+		/*
+		 * As in generic_file_direct_write(), invalidate after the
+		 * write, to invalidate read-ahead cache that may have competed
+		 * with the write.
+		 */
+		invalidate_inode_pages2_range(mapping, pos >> PAGE_SHIFT,
+					(pos + written - 1) >> PAGE_SHIFT);
+	}
 
-	return err ?: ia->write.out.size;
+	return err ?: written;
 }
 
 bool fuse_write_update_attr(struct inode *inode, loff_t pos, ssize_t written)
@@ -1738,15 +1762,6 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
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


