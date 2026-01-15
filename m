Return-Path: <linux-fsdevel+bounces-73888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A06C9D22C9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 08:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 142FF301AB15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 07:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0F232862F;
	Thu, 15 Jan 2026 07:20:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2274204E;
	Thu, 15 Jan 2026 07:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768461647; cv=none; b=j3RocsLUXfPF6goaJHyNFXmzlq/HZAnnF9qRFSZjifargvqD0hQgUaoJVYng/kKe0cCG1Gug5i9UyIjFu6v6GZqdX6sgq2RAOBExm3Txig2Ah6V+4MpQ0VWMg3BUNCkNEmGX+dBCHa/62TEgA75ISLOkRwhXsRqcvU+mfUScVBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768461647; c=relaxed/simple;
	bh=wUNSlyypXlzxPlXl5ctGY4XYbu282bLOapg2yFlkoJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUYY2fUU7ooQuRdehmuKava+Nj3bsePfmszALS50WFnqMjciYpkLq/ffbmq2s6rQKDFtdPxaUmQ26jAMrc4l9maG1x/5hq/f37Tx2WVR0apJIvItjfsvy0ViEE8+6PqdLEY4WFVx/sPUsx4SPTiPa1ZjMPgqtqse6EAdilMlAeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from localhost (unknown [14.116.239.37])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30be6f31e;
	Thu, 15 Jan 2026 15:20:34 +0800 (GMT+08:00)
From: Chunsheng Luo <luochunsheng@ustc.edu>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: [RFC 1/2] fuse: add close all in passthrough backing close for crash recovery
Date: Thu, 15 Jan 2026 15:20:30 +0800
Message-ID: <20260115072032.402-2-luochunsheng@ustc.edu>
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
X-HM-Tid: 0a9bc0870ce403a2kunma4e4bb7821064b
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCS0sfVkhKHx4dSUhDHR9DQlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKT1VKSk1VSUhCVUhMWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg++

Simplify FUSE daemon crash recovery by avoiding persistence of
backing_ids, thereby improving availability and reducing performance
overhead.

Non-persistent backing_ids after crash recovery may lead to resource
leaks if backing file resources are not properly cleaned up during
daemon restart.

Add a close_all handler to the backing close operation. This ensures
comprehensive cleanup of all backing file resources when the FUSE
daemon restarts, preventing resource leaks while maintaining the
simplified recovery approach.

Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>
---
 fs/fuse/backing.c | 14 ++++++++++++++
 fs/fuse/dev.c     |  5 +++++
 fs/fuse/fuse_i.h  |  1 +
 3 files changed, 20 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 4afda419dd14..34d0ea62fb9b 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -166,6 +166,20 @@ int fuse_backing_close(struct fuse_conn *fc, int backing_id)
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
+void fuse_backing_close_all(struct fuse_conn *fc)
+{
+	idr_for_each(&fc->backing_files_map, fuse_backing_close_one, fc);
+}
+
 struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc, int backing_id)
 {
 	struct fuse_backing *fb;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 6d59cbc877c6..25f6bb58623d 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2651,6 +2651,11 @@ static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
 	if (get_user(backing_id, argp))
 		return -EFAULT;
 
+	if (backing_id == -1) {
+		fuse_backing_close_all(fud->fc);
+		return 0;
+	}
+
 	return fuse_backing_close(fud->fc, backing_id);
 }
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7f16049387d1..6191c02b9ccc 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1573,6 +1573,7 @@ void fuse_backing_files_init(struct fuse_conn *fc);
 void fuse_backing_files_free(struct fuse_conn *fc);
 int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map);
 int fuse_backing_close(struct fuse_conn *fc, int backing_id);
+void fuse_backing_close_all(struct fuse_conn *fc);
 
 /* passthrough.c */
 static inline struct fuse_backing *fuse_inode_backing(struct fuse_inode *fi)
-- 
2.43.0


