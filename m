Return-Path: <linux-fsdevel+bounces-48884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70176AB53C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 13:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0861F3AC0FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 11:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10C528D85D;
	Tue, 13 May 2025 11:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FWFyjDH6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A5323F424
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 11:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747135423; cv=none; b=aKYzW7FFVHPcgzO0d+F7/B5hRBzrq3KKnCFqtvUfe2ZI/c7FkD0oWQEwE9GdQZbDs+Hm6PSwDngpR1xuXspHrkBJkB+XBnJVEW91txYiCey+6VI8q3PKAbP2Itg0qrjQp1bqZH/vbtXb5sqe0keqCMaKfkc50q7fkfywNo5ovkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747135423; c=relaxed/simple;
	bh=pYxQU1zo+KJeMiYSyTKKTcb2oCzgpzVRGAzuvJNPyaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NE6jB5Vp7nmjOPfpzcwT1+Yg29cUATAFpV/Qvo36FRiCiJ+AnKYATZ0wsDyXjjtkWt/ThTbR2EiL93WncGpopl1LDOl800z3D6+KbLSvC4btgXtkzmKsY6EJNs7qlKccNKu92IgUlD99XMkvB7VfPoWHVi37yKGXl4CLxd2sHe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FWFyjDH6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747135420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gRKdIDEyDD/fNZ/oJwPxjhfHIx4sNd63cvAbcZj8/x8=;
	b=FWFyjDH61nOZjOsy2yAf6r3W4FsXxPUqmPdJ4sWsV80fC2VqSMEPJBBWQTFpG0kLr5KJBK
	2b300qiVyUO1nMxmnD/Zp92R2YaP5HBxFmnIZMG8RJPtKSTTVWeg/kgZzJWlaNJQXyR4x5
	Q13C51i9RHWWejiDx6OUAHyBEDnlYC0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-Lv2MgpZxPZmp9TGAZm3cQA-1; Tue, 13 May 2025 07:23:39 -0400
X-MC-Unique: Lv2MgpZxPZmp9TGAZm3cQA-1
X-Mimecast-MFC-AGG-ID: Lv2MgpZxPZmp9TGAZm3cQA_1747135418
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-442cd12d151so37289155e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 04:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747135418; x=1747740218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gRKdIDEyDD/fNZ/oJwPxjhfHIx4sNd63cvAbcZj8/x8=;
        b=LnORbTII/BssQlWH8qAqMCIdnrOpfyhAamtdlXTVY9PJfByo/Ru6Ap2fJ51uKupNOp
         /izS10PRj2KTc3rHu+FtBfZvJu4ntCFHIfkRuJ7Ae8S49dUlW4x2w80YbLtkqKum64nH
         SVFlHOnLmBwlrnrDZTxw5+lPnBfrKO8Fif6ol3s3+eU5a+fp+Z9MCk5yLko3+yRA7DxG
         vqJxNxAdEu8oE6g0LfwF1P//Qnnso9Hc2pe5ZfnCXV1ZZXjQ2pNTudhKW0bMNy2wg4KN
         ACVAJM7GzJbl9m+74VVLKd/vvYhWyw5XiV6frvcO7IvIZZ/Dj+jsSkjRnQBGg8ZtBJZg
         7f4A==
X-Gm-Message-State: AOJu0YzHN+iiVCj5ZE727zJwoAAavt3wrI1ELFsAsk8e2JnvaeP3ymAD
	mZC9F3t95YvB/jMKX70KV7uvw9q5dlaTpiiIiPz0E4+kwnT3dYAnhIqg0bLI6v3/a59gOTuMIm6
	UNq5JqPPLYczXOp1gxvpjh7rl46RjW4EhXU5n3bi2W4kEuH/vY4n4bXyqnJCplDIX8JwQceI52t
	YtwQ4c25pceGwG9ZRfw4DP4BBXSWMAiEzRCPPqF2IKrHwQB5Ghig==
X-Gm-Gg: ASbGncvQy6xAgfStpekcju0nFqAJTU+MSBUlYvR2nwZcpgNddFNOvuEVLe4mEfbkWOj
	3xS9MDpQebIpUEGkTqnzTOudF6SLJZuVJQJKJUFkGysVEMoBKboqgRUUvrDzM2/QYu3HwmjJUNG
	HwCfctwIrnfVqgAInDTohPFnrD5JBkrASCDOBJ9P0MKRgSX4+59gRNxLdbxa0gy6M4Y8cfI1eAM
	QNYEn9rMg/Tt+SyJeFWN09lNVEirZEhQJzQOydR3cwdtR2NB+B/DZb8hqw5nqzckFK4GcmbEVzw
	Hrbf9W1GK8Gb3KV1OMf7qFHAM0T3LP3+DFEqgr4sCVNYCzz2rUose7g4F9QM7VE=
X-Received: by 2002:a05:600c:1d1e:b0:43c:f78d:82eb with SMTP id 5b1f17b1804b1-442d6d5d03bmr151420625e9.15.1747135417692;
        Tue, 13 May 2025 04:23:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6zMGx2DlOT5a/dIhhhkmQIOWFr/CboUtucGHJMRd59almSd9enqht3LY97IAgtXZoR6TKoA==
X-Received: by 2002:a05:600c:1d1e:b0:43c:f78d:82eb with SMTP id 5b1f17b1804b1-442d6d5d03bmr151420405e9.15.1747135417302;
        Tue, 13 May 2025 04:23:37 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (91-82-178-33.pool.digikabel.hu. [91.82.178.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442eb85a3b1sm17787515e9.0.2025.05.13.04.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 04:23:36 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH] fuse: don't allow signals to interrupt getdents copying
Date: Tue, 13 May 2025 13:23:31 +0200
Message-ID: <20250513112335.1473177-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When getting the directory contents, the entries are first fetched to a
kernel buffer, then they are copied to userspace with dir_emit().  This
second phase is non-blocking as long as the userspace buffer is not paged
out, making it interruptible makes zero sense.

Overload d_type as flags, since it only uses 4 bits from 32.

Reviewed-by: Bernd Schubert <bschubert@ddn.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
rfc -> v1:
  Added BUILD_BUG_ON() to verify no overlap with S_DT_MASK

 fs/fuse/readdir.c  |  4 ++--
 fs/readdir.c       | 18 +++++++++++++++---
 include/linux/fs.h |  3 +++
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 46b7146f2c0d..59defad9d05e 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -120,7 +120,7 @@ static bool fuse_emit(struct file *file, struct dir_context *ctx,
 		fuse_add_dirent_to_cache(file, dirent, ctx->pos);
 
 	return dir_emit(ctx, dirent->name, dirent->namelen, dirent->ino,
-			dirent->type);
+			dirent->type | FILLDIR_FLAG_NOINTR);
 }
 
 static int parse_dirfile(char *buf, size_t nbytes, struct file *file,
@@ -422,7 +422,7 @@ static enum fuse_parse_result fuse_parse_cache(struct fuse_file *ff,
 		if (ff->readdir.pos == ctx->pos) {
 			res = FOUND_SOME;
 			if (!dir_emit(ctx, dirent->name, dirent->namelen,
-				      dirent->ino, dirent->type))
+				      dirent->ino, dirent->type | FILLDIR_FLAG_NOINTR))
 				return FOUND_ALL;
 			ctx->pos = dirent->off;
 		}
diff --git a/fs/readdir.c b/fs/readdir.c
index 0038efda417b..857d402bc531 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -266,6 +266,10 @@ static bool filldir(struct dir_context *ctx, const char *name, int namlen,
 	int reclen = ALIGN(offsetof(struct linux_dirent, d_name) + namlen + 2,
 		sizeof(long));
 	int prev_reclen;
+	unsigned int flags = d_type;
+
+	BUILD_BUG_ON(FILLDIR_FLAG_NOINTR & S_DT_MASK);
+	d_type &= S_DT_MASK;
 
 	buf->error = verify_dirent_name(name, namlen);
 	if (unlikely(buf->error))
@@ -279,7 +283,7 @@ static bool filldir(struct dir_context *ctx, const char *name, int namlen,
 		return false;
 	}
 	prev_reclen = buf->prev_reclen;
-	if (prev_reclen && signal_pending(current))
+	if (!(flags & FILLDIR_FLAG_NOINTR) && prev_reclen && signal_pending(current))
 		return false;
 	dirent = buf->current_dir;
 	prev = (void __user *) dirent - prev_reclen;
@@ -351,6 +355,10 @@ static bool filldir64(struct dir_context *ctx, const char *name, int namlen,
 	int reclen = ALIGN(offsetof(struct linux_dirent64, d_name) + namlen + 1,
 		sizeof(u64));
 	int prev_reclen;
+	unsigned int flags = d_type;
+
+	BUILD_BUG_ON(FILLDIR_FLAG_NOINTR & S_DT_MASK);
+	d_type &= S_DT_MASK;
 
 	buf->error = verify_dirent_name(name, namlen);
 	if (unlikely(buf->error))
@@ -359,7 +367,7 @@ static bool filldir64(struct dir_context *ctx, const char *name, int namlen,
 	if (reclen > buf->count)
 		return false;
 	prev_reclen = buf->prev_reclen;
-	if (prev_reclen && signal_pending(current))
+	if (!(flags & FILLDIR_FLAG_NOINTR) && prev_reclen && signal_pending(current))
 		return false;
 	dirent = buf->current_dir;
 	prev = (void __user *)dirent - prev_reclen;
@@ -513,6 +521,10 @@ static bool compat_filldir(struct dir_context *ctx, const char *name, int namlen
 	int reclen = ALIGN(offsetof(struct compat_linux_dirent, d_name) +
 		namlen + 2, sizeof(compat_long_t));
 	int prev_reclen;
+	unsigned int flags = d_type;
+
+	BUILD_BUG_ON(FILLDIR_FLAG_NOINTR & S_DT_MASK);
+	d_type &= S_DT_MASK;
 
 	buf->error = verify_dirent_name(name, namlen);
 	if (unlikely(buf->error))
@@ -526,7 +538,7 @@ static bool compat_filldir(struct dir_context *ctx, const char *name, int namlen
 		return false;
 	}
 	prev_reclen = buf->prev_reclen;
-	if (prev_reclen && signal_pending(current))
+	if (!(flags & FILLDIR_FLAG_NOINTR) && prev_reclen && signal_pending(current))
 		return false;
 	dirent = buf->current_dir;
 	prev = (void __user *) dirent - prev_reclen;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 016b0fe1536e..0f2a1a572e3a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2073,6 +2073,9 @@ struct dir_context {
 	loff_t pos;
 };
 
+/* If OR-ed with d_type, pending signals are not checked */
+#define FILLDIR_FLAG_NOINTR	0x1000
+
 /*
  * These flags let !MMU mmap() govern direct device mapping vs immediate
  * copying more easily for MAP_PRIVATE, especially for ROM filesystems.
-- 
2.49.0


