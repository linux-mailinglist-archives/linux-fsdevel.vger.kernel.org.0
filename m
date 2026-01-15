Return-Path: <linux-fsdevel+bounces-73889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9D1D22C9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 08:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98DFC30B6810
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 07:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AAB329E62;
	Thu, 15 Jan 2026 07:20:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B484242D6A;
	Thu, 15 Jan 2026 07:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768461647; cv=none; b=kD3rl3vEi0cE5JwaIZHzIKmYMz3+lJsk1XWxtHt6SH8KjAk+iGVgZZ2/nh/Ug2gdRB+z5IUkzCvwEbONk5ufxrQdEA7PbgatDk7UhmR6vQxsmXyxeaOaZVDMXZVoXsDfrCqFwkppTr/peq5HSj7cItojvTH0nLLZ2XHS6wDQSAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768461647; c=relaxed/simple;
	bh=D6xqF55KyEZmNte4+zYNhke3ZQp4WwZxQ2TZUQyQiYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnRyR5sGhN927eUwd7S+4K2zwqPkT1ndg0qHyEmSxnSgfZsusN30kRS92WqmLGzcSYKj+Hv/czkUwoHBVR6sItlXO8BaGefJIdpclY0Bmhh6Y2QdAnpYly/BbFZ7qlKXP3eTxGOXAYT6D4MURSI+HmWp+JOPw6LWWrrXpD9YkP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from localhost (unknown [14.22.11.161])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30be6f324;
	Thu, 15 Jan 2026 15:20:36 +0800 (GMT+08:00)
From: Chunsheng Luo <luochunsheng@ustc.edu>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: [RFC 2/2] fuse: Add new flag to reuse the backing file of fuse_inode
Date: Thu, 15 Jan 2026 15:20:31 +0800
Message-ID: <20260115072032.402-3-luochunsheng@ustc.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115072032.402-1-luochunsheng@ustc.edu>
References: <20260115072032.402-1-luochunsheng@ustc.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bc087132903a2kunm2b0de46421065c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTEkdVhgZSk1JSxpDSBlNH1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKT1VJSVVKSlVKTUpZV1kWGg8SFR0UWUFZS1VLVUtVS1kG

To simplify crash recovery and reduce performance impact, backing_ids
are not persisted across daemon restarts. However, this creates a
problem: when the daemon restarts and a process opens the same FUSE
file, a new backing_id may be allocated for the same backing file. If
the inode already has a cached backing file from before the restart,
subsequent open requests with the new backing_id will fail in
fuse_inode_uncached_io_start() due to fb mismatch, even though both
IDs reference the identical underlying file.

Introduce the FOPEN_PASSTHROUGH_INODE_CACHE flag to address this
issue. When set, the kernel reuses the backing file already cached in
the inode.

Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>
---
 fs/fuse/iomode.c          |  2 +-
 fs/fuse/passthrough.c     | 11 +++++++++++
 include/uapi/linux/fuse.h |  2 ++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
index 3728933188f3..b200bb248598 100644
--- a/fs/fuse/iomode.c
+++ b/fs/fuse/iomode.c
@@ -163,7 +163,7 @@ static void fuse_file_uncached_io_release(struct fuse_file *ff,
  */
 #define FOPEN_PASSTHROUGH_MASK \
 	(FOPEN_PASSTHROUGH | FOPEN_DIRECT_IO | FOPEN_PARALLEL_DIRECT_WRITES | \
-	 FOPEN_NOFLUSH)
+	 FOPEN_NOFLUSH | FOPEN_PASSTHROUGH_INODE_CACHE)
 
 static int fuse_file_passthrough_open(struct inode *inode, struct file *file)
 {
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 72de97c03d0e..fde4ac0c5737 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -147,16 +147,26 @@ ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma)
 /*
  * Setup passthrough to a backing file.
  *
+ * If fuse inode backing is provided and FOPEN_PASSTHROUGH_INODE_CACHE flag
+ * is set, try to reuse it first before looking up backing_id.
+ *
  * Returns an fb object with elevated refcount to be stored in fuse inode.
  */
 struct fuse_backing *fuse_passthrough_open(struct file *file, int backing_id)
 {
 	struct fuse_file *ff = file->private_data;
 	struct fuse_conn *fc = ff->fm->fc;
+	struct fuse_inode *fi = get_fuse_inode(file->f_inode);
 	struct fuse_backing *fb = NULL;
 	struct file *backing_file;
 	int err;
 
+	if (ff->open_flags & FOPEN_PASSTHROUGH_INODE_CACHE) {
+		fb = fuse_backing_get(fuse_inode_backing(fi));
+		if (fb)
+			goto do_open;
+	}
+
 	err = -EINVAL;
 	if (backing_id <= 0)
 		goto out;
@@ -166,6 +176,7 @@ struct fuse_backing *fuse_passthrough_open(struct file *file, int backing_id)
 	if (!fb)
 		goto out;
 
+do_open:
 	/* Allocate backing file per fuse file to store fuse path */
 	backing_file = backing_file_open(&file->f_path, file->f_flags,
 					 &fb->file->f_path, fb->cred);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index c13e1f9a2f12..3b681d502fc1 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -383,6 +383,7 @@ struct fuse_file_lock {
  * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
  * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on the same inode
  * FOPEN_PASSTHROUGH: passthrough read/write io for this open file
+ * FOPEN_PASSTHROUGH_INODE_CACHE: reuse the backing file for passthrough reads/writes
  */
 #define FOPEN_DIRECT_IO		(1 << 0)
 #define FOPEN_KEEP_CACHE	(1 << 1)
@@ -392,6 +393,7 @@ struct fuse_file_lock {
 #define FOPEN_NOFLUSH		(1 << 5)
 #define FOPEN_PARALLEL_DIRECT_WRITES	(1 << 6)
 #define FOPEN_PASSTHROUGH	(1 << 7)
+#define FOPEN_PASSTHROUGH_INODE_CACHE	(1 << 8)
 
 /**
  * INIT request/reply flags
-- 
2.43.0


