Return-Path: <linux-fsdevel+bounces-56329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD00B160F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 15:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3EC616E681
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 13:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47AE296148;
	Wed, 30 Jul 2025 13:06:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD53224898;
	Wed, 30 Jul 2025 13:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753880781; cv=none; b=PWqFmvSmju65FpOib5utCF5EDPJIWYhOCEQuViZXlx83nzVgY+4m0/VaheMHNdR9Bh/k03Cxr44vEaQs+JQ5IybULov6CCRWfbU/f6yVe07CfRhlFpHy1Wi9yBcRJSK1aji/e8V7YISt7BIavUkHrJ8bkZ50npvX+XLEY4KyC+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753880781; c=relaxed/simple;
	bh=jK42f7rbDddqApZMNBx4yN+EyqOmwpVWL3zq1JEOfdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RWh+TkEdPyV5oYruvcRRFVJVTdD0LPxpjmb1mao+rGIOkk8in4FI3IzM/V5BJe1q9T8+U74q+pbGff8v6LiWgLKLOfZslhM+5SbGc+lQQ4dU7Zg1yQDnn2vgDUrF5B/ce+06VpMA/S1i0LzHRqJyAx2OmcJfYgDL7MLNcfKTQgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from localhost (unknown [14.116.239.35])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1dc0b96c7;
	Wed, 30 Jul 2025 21:06:06 +0800 (GMT+08:00)
From: Chunsheng Luo <luochunsheng@ustc.edu>
To: miklos@szeredi.hu
Cc: mszeredi@redhat.com,
	amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: [PATCH] fuse: remove unused 'inode' parameter in fuse_passthrough_open
Date: Wed, 30 Jul 2025 21:06:03 +0800
Message-ID: <20250730130604.4374-1-luochunsheng@ustc.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a985b70a8a203a2kunm841eb85624d4d8
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHUxCVklJTEtOHkJPSB5CQlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKT1VKSk1VSUhCVUhOWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg++

The 'inode' parameter in fuse_passthrough_open() is never referenced
in the function implementation.

Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>
---
 fs/fuse/fuse_i.h      | 4 +---
 fs/fuse/iomode.c      | 3 +--
 fs/fuse/passthrough.c | 4 +---
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index ec248d13c8bf..92c2932daea1 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1538,9 +1538,7 @@ void fuse_backing_files_free(struct fuse_conn *fc);
 int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map);
 int fuse_backing_close(struct fuse_conn *fc, int backing_id);
 
-struct fuse_backing *fuse_passthrough_open(struct file *file,
-					   struct inode *inode,
-					   int backing_id);
+struct fuse_backing *fuse_passthrough_open(struct file *file, int backing_id);
 void fuse_passthrough_release(struct fuse_file *ff, struct fuse_backing *fb);
 
 static inline struct file *fuse_file_passthrough(struct fuse_file *ff)
diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
index c99e285f3183..3728933188f3 100644
--- a/fs/fuse/iomode.c
+++ b/fs/fuse/iomode.c
@@ -177,8 +177,7 @@ static int fuse_file_passthrough_open(struct inode *inode, struct file *file)
 	    (ff->open_flags & ~FOPEN_PASSTHROUGH_MASK))
 		return -EINVAL;
 
-	fb = fuse_passthrough_open(file, inode,
-				   ff->args->open_outarg.backing_id);
+	fb = fuse_passthrough_open(file, ff->args->open_outarg.backing_id);
 	if (IS_ERR(fb))
 		return PTR_ERR(fb);
 
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 607ef735ad4a..0c8e36db41ba 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -301,9 +301,7 @@ int fuse_backing_close(struct fuse_conn *fc, int backing_id)
  *
  * Returns an fb object with elevated refcount to be stored in fuse inode.
  */
-struct fuse_backing *fuse_passthrough_open(struct file *file,
-					   struct inode *inode,
-					   int backing_id)
+struct fuse_backing *fuse_passthrough_open(struct file *file, int backing_id)
 {
 	struct fuse_file *ff = file->private_data;
 	struct fuse_conn *fc = ff->fm->fc;
-- 
2.43.0


