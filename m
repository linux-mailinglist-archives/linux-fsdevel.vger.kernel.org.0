Return-Path: <linux-fsdevel+bounces-31918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B64C899D778
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 21:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F2F1C21F4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 19:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5371CF2A1;
	Mon, 14 Oct 2024 19:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bpc2HXm5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1E11CEAC4
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 19:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728934087; cv=none; b=aOzkAOrxh1nQ544gNaUbZP1NhVC25W8ZWrA1ZOtQdCpn9XUTy2FzigFBgT+dW5DUcLt1BL61i8UgpKJsDUhA/Rc2vyqGUI9euudHbHsbRoEaBHyzaW+oqehHvNjorQfPPJALFn4P8poQvvb+85Z/9znVHFRNA5nh642Gmw4YSU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728934087; c=relaxed/simple;
	bh=8RDQ/R4hkZ/x9mWEiH+lBNsVpnfJZnchSGUla84F2Sw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CQgNvph7Eu3F5sHX1cSIpdK3Lyl3td/OqdQAWME3DsSPODItCoUAjZUMoW5/0iuqUKiiu4oJ+H7ai9pJsnrdzTEQVZyCbWHnyp6yaVOyDISa6Nf2GVolJr8eZPyR3sJTWZ7y4spScrHL6F/+CCgwQRBpELq9NCSgDIzQxvTpPMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bpc2HXm5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-431291b27f1so20738325e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 12:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728934083; x=1729538883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxUYDaTssH8ifkrwyn4I3RkTk/Ab07xNZ1Jc7IDbK38=;
        b=Bpc2HXm5PK3zNl9VTeJrZhry9moWr3+4rpjfQ3cddv2hSu3zskb04CZnFeXtmIK+Qk
         d0o86VuLOo0Q/qleJfsxnB/A0nS/mOXPgMnnQq/QKLm1XAtxE8WvtoHE7ZxaVbHz09Mq
         UODddi8Qz0UhYDqZ+bfzuRDSfQvfM4EAuDArEJpU0/w+ZhIYjGwGZmM1Z1l2v7n16+CS
         b63Jl5RnQei266/V7Fj43EUoCl0lR2LsM9ZxK1mPOM3a9ByaL6omr8POK9s9aoUCStV7
         NQTJ9PQCQR3aS+KCfNsvyk9QRpMeXT3oKQwIjUGLHMTSdKLO6k9kajHbKns/Kxzn1heC
         ufmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728934083; x=1729538883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YxUYDaTssH8ifkrwyn4I3RkTk/Ab07xNZ1Jc7IDbK38=;
        b=adl1R6GADpsgtDbehCwacnqlhS6/zDuHAkocTvH2PLwHekWWwaSsRWnM3adT8ToZ2D
         TgwXR8nz8e9ZXPp4pABIjQnjCu+vmLOlIxPnrWHas9uqBOjI3EvfnLh/lozlwelGTEZ4
         8jlCJLLj7lfOqX9dBgo2QnDE6UvOnLRUI6qKk5S3vTycKgCtsj2bo24pacwTmXhphKZy
         +YzucC/EMiHlTF5CW7igDY1vS63zXcE1RxQdVT9HIYv7HFWl/p5yVz6OwCTPmOJa5irU
         KqFPm3ZgPNT3Gx77gAWhn+2vYO55cL8YqmKF6T1cUDoGNwv1cpjNMPCEUpQTJSPHf6an
         3EBg==
X-Forwarded-Encrypted: i=1; AJvYcCXwoh2QZGUa6ICLEIflwoVFfHwSwTmaCKg8pKSufMeDMRKTEqY5MhoWqcmQTs57EWQEMPrwxMXUPE+eA006@vger.kernel.org
X-Gm-Message-State: AOJu0YyZihC8KBznsCnnSnyzflCvX0Dt9SAturfKpn3tjzP+8/ZRu5um
	jI+ZBImFgm6KM4lYvRho5H/mk6GEM7LB3CMUO6hGzeZIrr8LYuMB
X-Google-Smtp-Source: AGHT+IE1ujgYkfsYKWdMFAIws5RRTzjBj922CEgcJUDvGrF0VmNT24UsYvrSRs0hlwmEBsHElw2MMA==
X-Received: by 2002:a05:600c:358d:b0:42c:b45d:4a7b with SMTP id 5b1f17b1804b1-4311df4236cmr108922845e9.25.1728934083168;
        Mon, 14 Oct 2024 12:28:03 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79f9d9sm12162673f8f.77.2024.10.14.12.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 12:28:02 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	yangyun <yangyun50@huawei.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/2] fs: pass offset and result to backing_file end_write() callback
Date: Mon, 14 Oct 2024 21:27:58 +0200
Message-Id: <20241014192759.863031-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014192759.863031-1-amir73il@gmail.com>
References: <20241014192759.863031-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is needed for extending fuse inode size after fuse passthrough write.

Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
Link: https://lore.kernel.org/linux-fsdevel/CAJfpegs=cvZ_NYy6Q_D42XhYS=Sjj5poM1b5TzXzOVvX=R36aA@mail.gmail.com/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/backing-file.c            | 8 ++++----
 fs/fuse/passthrough.c        | 6 +++---
 fs/overlayfs/file.c          | 9 +++++++--
 include/linux/backing-file.h | 2 +-
 4 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 8860dac58c37..09a9be945d45 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -80,7 +80,7 @@ struct backing_aio {
 	refcount_t ref;
 	struct kiocb *orig_iocb;
 	/* used for aio completion */
-	void (*end_write)(struct file *);
+	void (*end_write)(struct file *, loff_t, ssize_t);
 	struct work_struct work;
 	long res;
 };
@@ -109,7 +109,7 @@ static void backing_aio_cleanup(struct backing_aio *aio, long res)
 	struct kiocb *orig_iocb = aio->orig_iocb;
 
 	if (aio->end_write)
-		aio->end_write(orig_iocb->ki_filp);
+		aio->end_write(orig_iocb->ki_filp, iocb->ki_pos, res);
 
 	orig_iocb->ki_pos = iocb->ki_pos;
 	backing_aio_put(aio);
@@ -239,7 +239,7 @@ ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
 
 		ret = vfs_iter_write(file, iter, &iocb->ki_pos, rwf);
 		if (ctx->end_write)
-			ctx->end_write(ctx->user_file);
+			ctx->end_write(ctx->user_file, iocb->ki_pos, ret);
 	} else {
 		struct backing_aio *aio;
 
@@ -317,7 +317,7 @@ ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
 	revert_creds(old_cred);
 
 	if (ctx->end_write)
-		ctx->end_write(ctx->user_file);
+		ctx->end_write(ctx->user_file, ppos ? *ppos : 0, ret);
 
 	return ret;
 }
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index ba3207f6c4ce..c80b9712eff7 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -18,7 +18,7 @@ static void fuse_file_accessed(struct file *file)
 	fuse_invalidate_atime(inode);
 }
 
-static void fuse_file_modified(struct file *file)
+static void fuse_passthrough_end_write(struct file *file, loff_t, ssize_t)
 {
 	struct inode *inode = file_inode(file);
 
@@ -63,7 +63,7 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb,
 	struct backing_file_ctx ctx = {
 		.cred = ff->cred,
 		.user_file = file,
-		.end_write = fuse_file_modified,
+		.end_write = fuse_passthrough_end_write,
 	};
 
 	pr_debug("%s: backing_file=0x%p, pos=%lld, len=%zu\n", __func__,
@@ -110,7 +110,7 @@ ssize_t fuse_passthrough_splice_write(struct pipe_inode_info *pipe,
 	struct backing_file_ctx ctx = {
 		.cred = ff->cred,
 		.user_file = out,
-		.end_write = fuse_file_modified,
+		.end_write = fuse_passthrough_end_write,
 	};
 
 	pr_debug("%s: backing_file=0x%p, pos=%lld, len=%zu, flags=0x%x\n", __func__,
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 4504493b20be..24a36d61bb0c 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -231,6 +231,11 @@ static void ovl_file_modified(struct file *file)
 	ovl_copyattr(file_inode(file));
 }
 
+static void ovl_file_end_write(struct file *file, loff_t, ssize_t)
+{
+	ovl_file_modified(file);
+}
+
 static void ovl_file_accessed(struct file *file)
 {
 	struct inode *inode, *upperinode;
@@ -294,7 +299,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	struct backing_file_ctx ctx = {
 		.cred = ovl_creds(inode->i_sb),
 		.user_file = file,
-		.end_write = ovl_file_modified,
+		.end_write = ovl_file_end_write,
 	};
 
 	if (!iov_iter_count(iter))
@@ -364,7 +369,7 @@ static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
 	struct backing_file_ctx ctx = {
 		.cred = ovl_creds(inode->i_sb),
 		.user_file = out,
-		.end_write = ovl_file_modified,
+		.end_write = ovl_file_end_write,
 	};
 
 	inode_lock(inode);
diff --git a/include/linux/backing-file.h b/include/linux/backing-file.h
index 4b61b0e57720..2eed0ffb5e8f 100644
--- a/include/linux/backing-file.h
+++ b/include/linux/backing-file.h
@@ -16,7 +16,7 @@ struct backing_file_ctx {
 	const struct cred *cred;
 	struct file *user_file;
 	void (*accessed)(struct file *);
-	void (*end_write)(struct file *);
+	void (*end_write)(struct file *, loff_t, ssize_t);
 };
 
 struct file *backing_file_open(const struct path *user_path, int flags,
-- 
2.34.1


