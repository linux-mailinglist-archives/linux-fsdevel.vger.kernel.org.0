Return-Path: <linux-fsdevel+bounces-30956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B429900E5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 12:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE7E1C204AB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 10:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDAC155742;
	Fri,  4 Oct 2024 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUqTvUFf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63C5155306;
	Fri,  4 Oct 2024 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728037431; cv=none; b=d/ta9JUSbYwZR1IrH4Hw2gas/qkkTphVINFABQcMM7cKFiXdod5itn2aRd3ZymGl7A1hBbgaACV8vvYKTSajVLdf30ZZ0K2W15WB3DYmXjrWoh1UvI430qev1naPnPd00TobeRkYYDNCxAk8gD0nHKiGEuzrnfscyeL7U6k/OV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728037431; c=relaxed/simple;
	bh=BXkzaglW4+jRuPwhZoh/aebYfKiekhmAu9qGUL7LW9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MwpBHS3gIvOHaIUWLfmiTfx+LV8km0uijJnz39aiCjpE0/2Ev72HuUfO10Qft93lPaijh3yUKNadOwLctB2L9J/ZLEZMwDldg+Oyi2hMB/NK5jZS7p00XBDH7FSVBKyBvJ7psZPWCqQmpgp7rqM22hXjIKNoiY63oM9R9o+XFGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUqTvUFf; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c89e66012aso2361765a12.2;
        Fri, 04 Oct 2024 03:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728037428; x=1728642228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWP0jpAoiej3BcoDH86TODk7hrmTa/gBacoaHbjPjx4=;
        b=HUqTvUFfN/pYXZungZtexWgVCxqmdDwvh43Q6kWTBXN2fuLW6vvKCJVP5MZ2WOcOLH
         gFdXKieacgZUWAsx+QNisDzVtBXjdrd7N6dfYhIaOyPLhPGD+IWPQO/bsJsZF6Vu6B9z
         nwqOY71y2Q4A1O3Fa6lt6Eiv25zu+h6Y36zxXD/EBa37i5LCUo/AjZTF0cOFhEDhsOcp
         CIfTyj+r4Fcjbslgn0vJayPf3wBXhBUX73roblBkHnp7JbilUlJ+IpBXjxg4QHHn3azm
         lnxljwJk4GMrkILCNkpscrn9orJCtqvg+qdtOp25SjlLG9l/2JWITh+uIdZ4vUrv/qTy
         BqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728037428; x=1728642228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWP0jpAoiej3BcoDH86TODk7hrmTa/gBacoaHbjPjx4=;
        b=ORoxzOTno4oBdXwzgklfU8orpcQ3HPYIr+PjHKKNuwTxesMpxxSj/e+FDjVEKl3KsY
         wilm58DUwMJWlmaogy7Klx8FE/7yzJhWWOMlxv0aMZM/Z6selCnM6/VwVvr0yveqfg6+
         PzF2+xN0KCqFYFSm5Js80gE8TACB2Ez0EbELvlgi1hsysUNDXPSb/b30GdJG58bmTUdD
         uBaa+6Wzm7WhcIhryTIr2tnsu4OGFiy0UaVGvhNVEzxlXWAotqzmS5vlw/SPco5zoYiQ
         3tbwtbOsGTXEahBCQVU+fJgrbiGneveRhBVN3utAEfJ//r/xJQiwAAJVjmH8h5h/RrLl
         eZ6g==
X-Forwarded-Encrypted: i=1; AJvYcCUrIn4tE8a4sQJObxmAjCq3uj1kJhiovYZ8t6LjGpxsUY/j3PCRVSG4xZ8kRl/hmkLxTImf0EGnHnr/hykkvQ==@vger.kernel.org, AJvYcCXjsr/Wyelm9jTBKU8R6mswGe0cUa7ZycvBJMcxmi2/cGozeijI5m+XVZFLpoyaoihb9QliCwu8pmTDPb5D@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg1X92Nv1N+hAVsEg6kjhB4tOSR+YGrNif658TXXzyxVXnO77F
	YNuvUqbRXzo+32obhBY7jAWpoolZxLnC3aNrYJTksHfx9e6big5C
X-Google-Smtp-Source: AGHT+IGqOQCnt2QrDxppRqjbEx4D/Npv0apCuoH4OR7s/N41fTbasVxZGDbiUaBYHZl8mbdyZFuySw==
X-Received: by 2002:a17:907:9726:b0:a8d:5472:b591 with SMTP id a640c23a62f3a-a991bce5c40mr233674166b.5.1728037427655;
        Fri, 04 Oct 2024 03:23:47 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99100a37cdsm207335066b.3.2024.10.04.03.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 03:23:47 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH 2/4] ovl: stash upper real file in backing_file struct
Date: Fri,  4 Oct 2024 12:23:40 +0200
Message-Id: <20241004102342.179434-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004102342.179434-1-amir73il@gmail.com>
References: <20241004102342.179434-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an overlayfs file is opened as lower and then the file is copied up,
every operation on the overlayfs open file will open a temporary backing
file to the upper dentry and close it at the end of the operation.

The original (lower) real file is stored in file->private_data pointer.
We could have allocated a struct ovl_real_file to potentially store two
backing files, the lower and the upper, but the original backing file
struct is not very space optimized (it has no memcache pool), so add a
private_data pointer to the backing_file struct and store the optional
second backing upper file in there instead of opening a temporary upper
file on every operation.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/file_table.c     |  7 +++++++
 fs/internal.h       |  6 ++++++
 fs/overlayfs/file.c | 48 ++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 54 insertions(+), 7 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index eed5ffad9997..1c2c08a5a66a 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -47,6 +47,7 @@ static struct percpu_counter nr_files __cacheline_aligned_in_smp;
 struct backing_file {
 	struct file file;
 	struct path user_path;
+	void *private_data;
 };
 
 static inline struct backing_file *backing_file(struct file *f)
@@ -60,6 +61,12 @@ struct path *backing_file_user_path(struct file *f)
 }
 EXPORT_SYMBOL_GPL(backing_file_user_path);
 
+void **backing_file_private_ptr(struct file *f)
+{
+	return &backing_file(f)->private_data;
+}
+EXPORT_SYMBOL_GPL(backing_file_private_ptr);
+
 static inline void file_free(struct file *f)
 {
 	security_file_free(f);
diff --git a/fs/internal.h b/fs/internal.h
index 8c1b7acbbe8f..b1152a3e8ba2 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -100,6 +100,12 @@ extern void chroot_fs_refs(const struct path *, const struct path *);
 struct file *alloc_empty_file(int flags, const struct cred *cred);
 struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred);
 struct file *alloc_empty_backing_file(int flags, const struct cred *cred);
+void **backing_file_private_ptr(struct file *f);
+
+static inline void *backing_file_private(struct file *f)
+{
+	return READ_ONCE(*backing_file_private_ptr(f));
+}
 
 static inline void file_put_write_access(struct file *file)
 {
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 3d64d00ef981..60a543b9a834 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -14,6 +14,8 @@
 #include <linux/backing-file.h>
 #include "overlayfs.h"
 
+#include "../internal.h"	/* for backing_file_private{,_ptr}() */
+
 static char ovl_whatisit(struct inode *inode, struct inode *realinode)
 {
 	if (realinode != ovl_inode_upper(inode))
@@ -94,6 +96,7 @@ static int ovl_real_fdget_meta(const struct file *file, struct fd *real,
 {
 	struct dentry *dentry = file_dentry(file);
 	struct file *realfile = file->private_data;
+	struct file *upperfile = backing_file_private(realfile);
 	struct path realpath;
 	int err;
 
@@ -114,15 +117,37 @@ static int ovl_real_fdget_meta(const struct file *file, struct fd *real,
 	if (!realpath.dentry)
 		return -EIO;
 
-	/* Has it been copied up since we'd opened it? */
+stashed_upper:
+	if (upperfile && file_inode(upperfile) == d_inode(realpath.dentry))
+		realfile = upperfile;
+
+	/*
+	 * If realfile is lower and has been copied up since we'd opened it,
+	 * open the real upper file and stash it in backing_file_private().
+	 */
 	if (unlikely(file_inode(realfile) != d_inode(realpath.dentry))) {
-		struct file *f = ovl_open_realfile(file, &realpath);
-		if (IS_ERR(f))
-			return PTR_ERR(f);
-		real->word = (unsigned long)f | FDPUT_FPUT;
-		return 0;
+		struct file *old;
+
+		/* Stashed upperfile has a mismatched inode */
+		if (unlikely(upperfile))
+			return -EIO;
+
+		upperfile = ovl_open_realfile(file, &realpath);
+		if (IS_ERR(upperfile))
+			return PTR_ERR(upperfile);
+
+		old = cmpxchg_release(backing_file_private_ptr(realfile), NULL,
+				      upperfile);
+		if (old) {
+			fput(upperfile);
+			upperfile = old;
+		}
+
+		goto stashed_upper;
 	}
 
+	real->word = (unsigned long)realfile;
+
 	/* Did the flags change since open? */
 	if (unlikely((file->f_flags ^ realfile->f_flags) & ~OVL_OPEN_FLAGS))
 		return ovl_change_flags(realfile, file->f_flags);
@@ -177,7 +202,16 @@ static int ovl_open(struct inode *inode, struct file *file)
 
 static int ovl_release(struct inode *inode, struct file *file)
 {
-	fput(file->private_data);
+	struct file *realfile = file->private_data;
+	struct file *upperfile = backing_file_private(realfile);
+
+	fput(realfile);
+	/*
+	 * If realfile is lower and file was copied up and accessed, we need
+	 * to put reference also on the stashed real upperfile.
+	 */
+	if (upperfile)
+		fput(upperfile);
 
 	return 0;
 }
-- 
2.34.1


