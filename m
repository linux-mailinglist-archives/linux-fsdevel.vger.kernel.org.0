Return-Path: <linux-fsdevel+bounces-48109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C839BAA97AB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 17:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFAFD7A507A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 15:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E906F25DD11;
	Mon,  5 May 2025 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L1Ao8tpQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8026F1DFF7
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746459717; cv=none; b=HjEVOO24ieYRRy5fvLd2fzKAy0E+BBCxGiplAwxje3Pf3M7uLXttkJVwgdVEY80rCDTO5CYiLwEgNWI1sQK5iwLdSSoRwXo1czH34mbYY1Jkz3ETBRhdczcSZCC42TCGFV+DsUGmlMYhQmACvSzmD3Lq+JjR9gXjnOik5jsI100=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746459717; c=relaxed/simple;
	bh=8SUR3eIjJyiV5mOznaY1XN0Vrlv2AV0j80ctEezBTio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cTSjy2ZhmD6FOf2/YhWWer8Ept77tdafssjppqJLhdHarBuyqB0i7NXrVLbkDtb54rPXyS7BDZYKisDz1TWleZaCuAlOHUoOjk/nt2j7uE3lKlAoiHhMzqJrq3p4EjAcE+GleAxP87qOyx3DhGvtRicviSDP/TFWRFAD6ZLNmsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L1Ao8tpQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746459714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BgMn8Y7RIA5Dg2IX0x5PF8QY+c+X8RduvdrPNnF9iCs=;
	b=L1Ao8tpQtSHFAuDw10oaUMyQcXkWjBqOzDR0khw8LabIFRwnu8cebfdnqKpMDko+JeF9vQ
	AvkC1iz/Hju2r+NQ9GbzZD/P0jZMNwfT9uDYeG3EbcH4ZHcn6ZZoAhggRhkABa/Cg0EuEk
	+PnqPKofgDnmWxrlx/Wod/pjCSJlJnA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-apboQGd8ODuSlMSTfdQMRw-1; Mon, 05 May 2025 11:41:53 -0400
X-MC-Unique: apboQGd8ODuSlMSTfdQMRw-1
X-Mimecast-MFC-AGG-ID: apboQGd8ODuSlMSTfdQMRw_1746459712
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d733063cdso33442485e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 May 2025 08:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746459712; x=1747064512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BgMn8Y7RIA5Dg2IX0x5PF8QY+c+X8RduvdrPNnF9iCs=;
        b=sl3fColR4/utPW8Yt9lU0jdezWk4xJ2Fx4Q9aVPb+vxgRaKfXY5/eW2sVjjs6BEq2L
         qgovTqxMlEjMq11fr52NkPfNK7+k6qjwGFGo3xhsiGWlqUCZw8xlKg34TOGalpbbC87v
         bg1YwStyKQld6ENyldQj/VHpeZg+YKHz//QldnP3pbXM2Xp8VBqv8MsMXrfK1OkWYSm2
         KgwJrUsbGEIeB0+QwdzgaOK1YLbph0ZLKUxCZGaXG61A21GeY22TYHYx1q4Cmn99KfME
         3hu5iM98Te1cdevb6TG/WluJiFi653TFWnlmW4MnOCuZZrfz/SJrz65OuStvOLFnhgsN
         IZ8A==
X-Gm-Message-State: AOJu0YwrCln5VZwsIX7oiFhdpPj8g+UdneHqf8/BlqLNncyYa6lIe9uK
	hFqeRTuyFFQDjPE0C5ot6zuQP33LxIt26T+U4e9m1ir9jLL8TFEssSWTvRqml5uI+XeUBqMCymw
	OWP4y9kYdNv4xDOh3CzZY/MqBityd0SyPJmmta6k2tX2c8LexY1imhClZWq2RynX4tZbFQrQIBi
	L1fJb45GUcF/ISyHfqpP+21lvhmUBHrikp2Y8MAWWh+EUzNWM=
X-Gm-Gg: ASbGncsdGIn9MYX4+UFgBak/9YM7SvGc9K+qvNLQZeWtTdi44lgI7/sqpZ+gGeSJ4yI
	GuWJ7hyvQHDFpBByybY9/Ypoegy7tZLiM/0GhK78FbMU2uotuFJWkQYPAE2xATvoDiexp+Cg1WT
	pjVtHxH9UdNPhU2pJBUqcz2O7XsAA4AH1HkJTWemvUVjBiX+tD2yMJjvXUR/SuKMnDAiR2edlEI
	FLsE643T0/eKtWogFGfesDA96reHPYbWqjzo0XA+X3JrBnXb7rR9sN1FKSC6atRIJWAxdEt9xVJ
	pmrT+H0CkFDg0PzwV1kNzRg/+hgOu5L2B62z5pDx9j5qliasQ5TUMQwbxoEN
X-Received: by 2002:a05:6000:1867:b0:3a0:82d1:f3c2 with SMTP id ffacd0b85a97d-3a09cea6910mr7711607f8f.10.1746459711771;
        Mon, 05 May 2025 08:41:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEejKsM1gDbt9iE1rpnhSlw0xY6e0GTmB1wzLQG7mBxhKJbWxs7mdbSIeEnh34KN2/bhCIT8w==
X-Received: by 2002:a05:6000:1867:b0:3a0:82d1:f3c2 with SMTP id ffacd0b85a97d-3a09cea6910mr7711582f8f.10.1746459711442;
        Mon, 05 May 2025 08:41:51 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (87-97-19-85.pool.digikabel.hu. [87.97.19.85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2b28045sm181392515e9.35.2025.05.05.08.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 08:41:50 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-unionfs@vger.kernel.org,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	John Schoenick <johns@valvesoftware.com>
Subject: [PATCH] vfs: change 'struct file *' argument to 'const struct file *' where possible
Date: Mon,  5 May 2025 17:41:47 +0200
Message-ID: <20250505154149.301235-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let file_user_path(), file_user_inode() and file_clone_open() take const
pointer.

This allows removing a cast in ovl_open_realfile() when calling
backing_file_open().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---

This depends on commit 924577e4f6ca ("ovl: Fix nested backing file paths") in

  git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-fixes

 fs/file_table.c     | 10 ++++++----
 fs/internal.h       |  1 +
 fs/overlayfs/file.c |  2 +-
 include/linux/fs.h  | 12 ++++++------
 4 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index c04ed94cdc4b..3b3f920a9175 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -52,16 +52,18 @@ struct backing_file {
 	};
 };
 
-static inline struct backing_file *backing_file(struct file *f)
+#define backing_file(f) container_of(f, struct backing_file, file)
+
+struct path *backing_file_user_path(struct file *f)
 {
-	return container_of(f, struct backing_file, file);
+	return &backing_file(f)->user_path;
 }
 
-struct path *backing_file_user_path(struct file *f)
+const struct path *backing_file_user_path_c(const struct file *f)
 {
 	return &backing_file(f)->user_path;
 }
-EXPORT_SYMBOL_GPL(backing_file_user_path);
+EXPORT_SYMBOL_GPL(backing_file_user_path_c);
 
 static inline void file_free(struct file *f)
 {
diff --git a/fs/internal.h b/fs/internal.h
index b9b3e29a73fd..84a330763343 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -100,6 +100,7 @@ extern void chroot_fs_refs(const struct path *, const struct path *);
 struct file *alloc_empty_file(int flags, const struct cred *cred);
 struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred);
 struct file *alloc_empty_backing_file(int flags, const struct cred *cred);
+struct path *backing_file_user_path(struct file *f);
 
 static inline void file_put_write_access(struct file *file)
 {
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index dfea7bd800cb..f5b8877d5fe2 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -48,7 +48,7 @@ static struct file *ovl_open_realfile(const struct file *file,
 		if (!inode_owner_or_capable(real_idmap, realinode))
 			flags &= ~O_NOATIME;
 
-		realfile = backing_file_open(file_user_path((struct file *) file),
+		realfile = backing_file_open(file_user_path(file),
 					     flags, realpath, current_cred());
 	}
 	ovl_revert_creds(old_cred);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 016b0fe1536e..7db9cd5a4bee 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2813,7 +2813,7 @@ struct file *dentry_open_nonotify(const struct path *path, int flags,
 				  const struct cred *cred);
 struct file *dentry_create(const struct path *path, int flags, umode_t mode,
 			   const struct cred *cred);
-struct path *backing_file_user_path(struct file *f);
+const struct path *backing_file_user_path_c(const struct file *f);
 
 /*
  * When mmapping a file on a stackable filesystem (e.g., overlayfs), the file
@@ -2825,21 +2825,21 @@ struct path *backing_file_user_path(struct file *f);
  * by fstat() on that same fd.
  */
 /* Get the path to display in /proc/<pid>/maps */
-static inline const struct path *file_user_path(struct file *f)
+static inline const struct path *file_user_path(const struct file *f)
 {
 	if (unlikely(f->f_mode & FMODE_BACKING))
-		return backing_file_user_path(f);
+		return backing_file_user_path_c(f);
 	return &f->f_path;
 }
 /* Get the inode whose inode number to display in /proc/<pid>/maps */
-static inline const struct inode *file_user_inode(struct file *f)
+static inline const struct inode *file_user_inode(const struct file *f)
 {
 	if (unlikely(f->f_mode & FMODE_BACKING))
-		return d_inode(backing_file_user_path(f)->dentry);
+		return d_inode(backing_file_user_path_c(f)->dentry);
 	return file_inode(f);
 }
 
-static inline struct file *file_clone_open(struct file *file)
+static inline struct file *file_clone_open(const struct file *file)
 {
 	return dentry_open(&file->f_path, file->f_flags, file->f_cred);
 }
-- 
2.49.0


