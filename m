Return-Path: <linux-fsdevel+bounces-10481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E9484B7CA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 15:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF341C20CE5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 14:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8D1132484;
	Tue,  6 Feb 2024 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXmFee9E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8049132C13
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229512; cv=none; b=fV4AnkOJCUQbQEYpNPhjVOAJqbw9yBothMGQvw3Qvj1rM+uv3wi1JWCSjYlqzv48nEBx8hKQ6hdAjdC8d380/Phk/NT7OsKyjJm0oiE1FQXNqtAF/Bt2hl0+Khf+0WRANZRf7eBDfl88kmeh9cSEyLUYZiAGKJNxfLtMZWpLcfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229512; c=relaxed/simple;
	bh=FIKWwn8qUIa/349NQRgrEQCCO6Ls3szt4TRLuwbkTAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LoG6kYH80VUUNpvalq4V2s3aP/Vs9RJlLHMPPG8iVh9BdkJ2p9E4FI8ZoAjtRP+0EKRzLtjcjkjIo74alsPx1Ze+x6ZoEPSx9/2iI5dHcc/+bq03zZDB82gwTHqORKnrAZ8t+xl6vXoqskx1fU1jOgpoJGKZe/mxRXBvnbFHCqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXmFee9E; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33b436dbdcfso935809f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 06:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707229509; x=1707834309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2WiMh2LRrBIs7GLc9i6LGZkDarGIitoi6Al8x+Sqf4=;
        b=gXmFee9EpTETlZOxMB9cVXqrgA3uVjx4q8p6VBUNjJmSlD818B1YTQ/FKDTB3Kx0Es
         RVXA/eg2gDrYFdxI12NiXqQDuR1H8YwYukilmS4uAQYkPVmC9BkajchpwsYsLiC/aamm
         aRiRxodS7t5gRIHBr5QRhTAtYj9dqaREy0Vfgq+uhxC/ooioH1agB1d98QFVY6ks211z
         gFOSqhvOfxtUuRltXM4ejWhezH4ApvSdyjGmAfIFM0jFdPhcyo/Zd0tevyshqan5a7mC
         5w/zkJ7PaJEnhGWcvqu1FDaTSZEm54/1KsmS9jB7vMCBDB0j5947G3xg8C5KADkf4DpY
         T7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707229509; x=1707834309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z2WiMh2LRrBIs7GLc9i6LGZkDarGIitoi6Al8x+Sqf4=;
        b=uI2Y6wIwZWpdZ2jP9h2xUZbfaJFsHmQKae8+r+ZeER5yRXjW25XGH8cEKXfFI/hLNl
         SmlGjdAOkFvazHOh/woRAk1nuK+naxeu5vtCawAB1vaO+oi7d9kiFJQcsnOBZ5Jq4Yd2
         Jz+y7xiOAkdRB4MkKNMujbweTxqTi/3wazp0FtwlSIjF+tjd2ZDLWcfZ8WzukkJ0L6gX
         SO90TRtGMOMqfuT3sE27ocQhx3K7PiHztNJT8XHfwIwANi7GU7806AucUsU8fLl+OvS/
         RnztY9/sR6MgWR2v18vnLb2bWPxWTQx59QWWVqcYeeiO2g6Dh+y7dPLAXh/zbY3tFnh0
         VMLg==
X-Gm-Message-State: AOJu0Yx4aAgjNayOrerJoXSaXwZEnMXecfMaftiBY8bXtmSlKu180V5b
	a9baBjCh+0YOyQ2d2aU4BHStj3uQEmKcs6P91fxlTGDrVkT6F1i5ZL+gpHLj
X-Google-Smtp-Source: AGHT+IH7R3pzKj38YtmNUKBvPobt5oPA3o5vFuJv0It7k2avJ3JKdjncAh9pguJAcEZGBHZI280zsg==
X-Received: by 2002:adf:f346:0:b0:33b:3275:2721 with SMTP id e6-20020adff346000000b0033b32752721mr1324252wrp.40.1707229508882;
        Tue, 06 Feb 2024 06:25:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW8iq8X3xA1WHosD+yXpcsNtTKeLLpRCoRoawsu7NfFMp1YkcDUVqQCg9TS9y6INJjdJ292HgrLaH1pmGs9Lxsczqa902X12BhWW98qJA==
Received: from amir-ThinkPad-T480.lan (46-117-242-41.bb.netvision.net.il. [46.117.242.41])
        by smtp.gmail.com with ESMTPSA id c28-20020adfa31c000000b0033b4a6f46d7sm629728wrb.87.2024.02.06.06.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:25:08 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 7/9] fuse: implement splice read/write passthrough
Date: Tue,  6 Feb 2024 16:24:51 +0200
Message-Id: <20240206142453.1906268-8-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206142453.1906268-1-amir73il@gmail.com>
References: <20240206142453.1906268-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows passing fstests generic/249 and generic/591.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/file.c        | 29 ++++++++++++++++++++++++++--
 fs/fuse/fuse_i.h      |  6 ++++++
 fs/fuse/passthrough.c | 45 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 0f7c53ea2f13..80f98affbe7d 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1718,6 +1718,31 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		return fuse_cache_write_iter(iocb, from);
 }
 
+static ssize_t fuse_splice_read(struct file *in, loff_t *ppos,
+				struct pipe_inode_info *pipe, size_t len,
+				unsigned int flags)
+{
+	struct fuse_file *ff = in->private_data;
+
+	/* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
+	if (fuse_file_passthrough(ff) && !(ff->open_flags & FOPEN_DIRECT_IO))
+		return fuse_passthrough_splice_read(in, ppos, pipe, len, flags);
+	else
+		return filemap_splice_read(in, ppos, pipe, len, flags);
+}
+
+static ssize_t fuse_splice_write(struct pipe_inode_info *pipe, struct file *out,
+				 loff_t *ppos, size_t len, unsigned int flags)
+{
+	struct fuse_file *ff = out->private_data;
+
+	/* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
+	if (fuse_file_passthrough(ff) && !(ff->open_flags & FOPEN_DIRECT_IO))
+		return fuse_passthrough_splice_write(pipe, out, ppos, len, flags);
+	else
+		return iter_file_splice_write(pipe, out, ppos, len, flags);
+}
+
 static void fuse_writepage_free(struct fuse_writepage_args *wpa)
 {
 	struct fuse_args_pages *ap = &wpa->ia.ap;
@@ -3298,8 +3323,8 @@ static const struct file_operations fuse_file_operations = {
 	.lock		= fuse_file_lock,
 	.get_unmapped_area = thp_get_unmapped_area,
 	.flock		= fuse_file_flock,
-	.splice_read	= filemap_splice_read,
-	.splice_write	= iter_file_splice_write,
+	.splice_read	= fuse_splice_read,
+	.splice_write	= fuse_splice_write,
 	.unlocked_ioctl	= fuse_file_ioctl,
 	.compat_ioctl	= fuse_file_compat_ioctl,
 	.poll		= fuse_file_poll,
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index e47d7e8e4285..c495eaa11b49 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1473,5 +1473,11 @@ static inline struct file *fuse_file_passthrough(struct fuse_file *ff)
 
 ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *iter);
 ssize_t fuse_passthrough_write_iter(struct kiocb *iocb, struct iov_iter *iter);
+ssize_t fuse_passthrough_splice_read(struct file *in, loff_t *ppos,
+				     struct pipe_inode_info *pipe,
+				     size_t len, unsigned int flags);
+ssize_t fuse_passthrough_splice_write(struct pipe_inode_info *pipe,
+				      struct file *out, loff_t *ppos,
+				      size_t len, unsigned int flags);
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 206eedbf6bf8..df8343cebd0a 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -9,6 +9,7 @@
 
 #include <linux/file.h>
 #include <linux/backing-file.h>
+#include <linux/splice.h>
 
 static void fuse_file_accessed(struct file *file)
 {
@@ -96,6 +97,50 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb,
 	return ret;
 }
 
+ssize_t fuse_passthrough_splice_read(struct file *in, loff_t *ppos,
+				     struct pipe_inode_info *pipe,
+				     size_t len, unsigned int flags)
+{
+	struct fuse_file *ff = in->private_data;
+	struct file *backing_file = fuse_file_passthrough(ff);
+	struct backing_file_ctx ctx = {
+		.cred = ff->cred,
+		.user_file = in,
+		.accessed = fuse_file_accessed,
+	};
+
+	pr_debug("%s: backing_file=0x%p, pos=%lld, len=%zu, flags=0x%x\n", __func__,
+		 backing_file, ppos ? *ppos : 0, len, flags);
+
+	return backing_file_splice_read(backing_file, ppos, pipe, len, flags,
+					&ctx);
+}
+
+ssize_t fuse_passthrough_splice_write(struct pipe_inode_info *pipe,
+				      struct file *out, loff_t *ppos,
+				      size_t len, unsigned int flags)
+{
+	struct fuse_file *ff = out->private_data;
+	struct file *backing_file = fuse_file_passthrough(ff);
+	struct inode *inode = file_inode(out);
+	ssize_t ret;
+	struct backing_file_ctx ctx = {
+		.cred = ff->cred,
+		.user_file = out,
+		.end_write = fuse_file_modified,
+	};
+
+	pr_debug("%s: backing_file=0x%p, pos=%lld, len=%zu, flags=0x%x\n", __func__,
+		 backing_file, ppos ? *ppos : 0, len, flags);
+
+	inode_lock(inode);
+	ret = backing_file_splice_write(pipe, backing_file, ppos, len, flags,
+					&ctx);
+	inode_unlock(inode);
+
+	return ret;
+}
+
 struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
 {
 	if (fb && refcount_inc_not_zero(&fb->count))
-- 
2.34.1


