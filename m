Return-Path: <linux-fsdevel+bounces-74125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67546D32A48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C7EE314B6F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 14:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FD034847A;
	Fri, 16 Jan 2026 14:28:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A7D332EAA;
	Fri, 16 Jan 2026 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573735; cv=none; b=RqUgIqNWozyZ5YI19vYfmiY2RYax8AqDU4Bu+y17GnSZeluebwFTMKGNOhYTJH4t1982eXLUFF1sIObpFy3w9ztxDsBFb3JRqfYUqg2GLoJCHJt866fbg2kIrGnhadIqMoRQAg0WjSteWFEUblhP5sLbzWkyzmaYjzent7HwfiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573735; c=relaxed/simple;
	bh=Hc+pmX+YG1JfhJcGFa0KQuoVXAK1vkPo/8xVqXo6HjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVCoJjncv/xur2iJqD+i534mSvj2U5+FOh2zj5rc9vMRIow0HgCgTy6EEIJtnggkV9V2SfwtmnY54Pd0Lyo+6Fvpang1QktKwwiiLbFHjgsXoczaFmrJYXA2BBKoYtmLRSg0P0Oegz2E8PdEKtuX4tLhkAhSn0n77TwelX2Iz4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from localhost (unknown [14.22.11.164])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30ef1dc9d;
	Fri, 16 Jan 2026 22:28:48 +0800 (GMT+08:00)
From: Chunsheng Luo <luochunsheng@ustc.edu>
To: miklos@szeredi.hu
Cc: amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: [PATCH 1/2] fuse: add ioctl to cleanup all backing files
Date: Fri, 16 Jan 2026 22:28:44 +0800
Message-ID: <20260116142845.422-2-luochunsheng@ustc.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116142845.422-1-luochunsheng@ustc.edu>
References: <20260116142845.422-1-luochunsheng@ustc.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bc735771303a2kunm2ada7c83268fe7
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGU9NVksdSUkaGksfQxkeS1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKT1VJSVVKSlVKTU9ZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0xVSktLVUtZBg
	++

To simplify crash recovery and reduce performance impact, backing_ids
are not persisted across daemon restarts. After crash recovery, this
may lead to resource leaks if backing file resources are not properly
cleaned up.

Add FUSE_DEV_IOC_BACKING_CLOSE_ALL ioctl to release all backing_ids
and put backing files. When the FUSE daemon restarts, it can use this
ioctl to cleanup all backing file resources.

Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>
---
 fs/fuse/backing.c         | 19 +++++++++++++++++++
 fs/fuse/dev.c             | 16 ++++++++++++++++
 fs/fuse/fuse_i.h          |  1 +
 include/uapi/linux/fuse.h |  1 +
 4 files changed, 37 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 4afda419dd14..e93d797a2cde 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -166,6 +166,25 @@ int fuse_backing_close(struct fuse_conn *fc, int backing_id)
 	return err;
 }
 
+static int fuse_backing_close_one(int id, void *p, void *data)
+{
+	struct fuse_conn *fc = data;
+
+	fuse_backing_close(fc, id);
+
+	return 0;
+}
+
+int fuse_backing_close_all(struct fuse_conn *fc)
+{
+	if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	idr_for_each(&fc->backing_files_map, fuse_backing_close_one, fc);
+
+	return 0;
+}
+
 struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc, int backing_id)
 {
 	struct fuse_backing *fb;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 6d59cbc877c6..f05d55302598 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2654,6 +2654,19 @@ static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
 	return fuse_backing_close(fud->fc, backing_id);
 }
 
+static long fuse_dev_ioctl_backing_close_all(struct file *file)
+{
+	struct fuse_dev *fud = fuse_get_dev(file);
+
+	if (IS_ERR(fud))
+		return PTR_ERR(fud);
+
+	if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+		return -EOPNOTSUPP;
+
+	return fuse_backing_close_all(fud->fc);
+}
+
 static long fuse_dev_ioctl_sync_init(struct file *file)
 {
 	int err = -EINVAL;
@@ -2682,6 +2695,9 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 	case FUSE_DEV_IOC_BACKING_CLOSE:
 		return fuse_dev_ioctl_backing_close(file, argp);
 
+	case FUSE_DEV_IOC_BACKING_CLOSE_ALL:
+		return fuse_dev_ioctl_backing_close_all(file);
+
 	case FUSE_DEV_IOC_SYNC_INIT:
 		return fuse_dev_ioctl_sync_init(file);
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7f16049387d1..33e91a5d3765 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1573,6 +1573,7 @@ void fuse_backing_files_init(struct fuse_conn *fc);
 void fuse_backing_files_free(struct fuse_conn *fc);
 int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map);
 int fuse_backing_close(struct fuse_conn *fc, int backing_id);
+int fuse_backing_close_all(struct fuse_conn *fc);
 
 /* passthrough.c */
 static inline struct fuse_backing *fuse_inode_backing(struct fuse_inode *fi)
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index c13e1f9a2f12..e4ff28a4ff40 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1139,6 +1139,7 @@ struct fuse_backing_map {
 					     struct fuse_backing_map)
 #define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
 #define FUSE_DEV_IOC_SYNC_INIT		_IO(FUSE_DEV_IOC_MAGIC, 3)
+#define FUSE_DEV_IOC_BACKING_CLOSE_ALL	_IO(FUSE_DEV_IOC_MAGIC, 4)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
-- 
2.43.0


