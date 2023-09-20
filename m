Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBE27A70A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 04:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjITCl2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 22:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjITCl1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 22:41:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49ABC9
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 19:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695177635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wtByIizq1oqoLet5lc3wFHGCuy/bq0Tz0BlNxy5hyas=;
        b=Q7uoVBXYpds/9DR6SIUuFK1FxqTZPpy84yXhx+uAUKHhVPaxsbVFjGKanpOCWj3Vmh4IuP
        H4fX4NNirUY4GIKiu3mCobtNk4p6Td97ganKJhCUxEhwJ1oYyLbB/npoPEjTGoo9gnyO6i
        t2yrwUo0ZIZ9unXfHvb2BAO9E3rUmII=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-1mXczzGkOYSer61hbYOKRg-1; Tue, 19 Sep 2023 22:40:33 -0400
X-MC-Unique: 1mXczzGkOYSer61hbYOKRg-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-41219864601so71543761cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 19:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695177631; x=1695782431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtByIizq1oqoLet5lc3wFHGCuy/bq0Tz0BlNxy5hyas=;
        b=cgJqD5uhzmtV7LiBcJqwS8rNZOsxb6GvXhx+ztLPk2Zv0/RMAwb7BKX1pJWAsQlBhN
         EWQRw4/CecXv9naNIJlHm+J1y/YN4n4mQc2B23dZ2J4vchhp6Du9ny8PK5NkJgDbaWPO
         V9rNKdIPQTD4gcvQhDZ7hYsDKmmF2CXZQTczAwvIiAlzEcPXqaDY7ZoMHw4hm6LmkpXr
         4hZIHYbzA/dXfalVlqiy0xRwxf2QBm6zs85tnqzAa2+hJ1v0WdKHNtkGt0Y+DGtpNAec
         02agyDnOOvJfQEwK8X3yxfjwZ8qO9W0y7IZO3xgMyS8vEajHHy2V7XqIKg/DBnRy9oJ7
         Ew2g==
X-Gm-Message-State: AOJu0Yy75xymDpNDbhfrhUJY9rPOy5BdTcPtanKLBIafiww8Q++PU0bC
        /zLLBGuvB1I4fctddTU5nrgjq4fYlFlRdzWhTqei6FwOv7rI/7wxU3q3HERsPopQxxi33a/4gKL
        3IVrNFMSLwGBbMMGsdIJrzv8YU79Ik9+H4KbhfU91hdsr15NBu43OwpK8i4RMz9SGuGDDyp8Xn2
        puUOlGvF8DzPYw
X-Received: by 2002:a05:622a:1807:b0:412:1e4c:e858 with SMTP id t7-20020a05622a180700b004121e4ce858mr1519645qtc.36.1695177631238;
        Tue, 19 Sep 2023 19:40:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWefF0g6cI15fLY1uvEDpSr0fmIvj/d7MpuaymDQwRvzmXxN7b/ik2Ic1/yXyPUr4Dt1kP5A==
X-Received: by 2002:a05:622a:1807:b0:412:1e4c:e858 with SMTP id t7-20020a05622a180700b004121e4ce858mr1519631qtc.36.1695177630940;
        Tue, 19 Sep 2023 19:40:30 -0700 (PDT)
Received: from fedora.redhat.com ([2600:4040:7c46:e800:32a2:d966:1af4:8863])
        by smtp.gmail.com with ESMTPSA id j23-20020ac84417000000b0041020e8e261sm4277093qtn.1.2023.09.19.19.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 19:40:29 -0700 (PDT)
From:   Tyler Fanelli <tfanelli@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     mszeredi@redhat.com, gmaglione@redhat.com, hreitz@redhat.com,
        Tyler Fanelli <tfanelli@redhat.com>
Subject: [PATCH 1/2] fs/fuse: Rename DIRECT_IO_RELAX to DIRECT_IO_ALLOW_MMAP
Date:   Tue, 19 Sep 2023 22:40:00 -0400
Message-Id: <20230920024001.493477-2-tfanelli@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230920024001.493477-1-tfanelli@redhat.com>
References: <20230920024001.493477-1-tfanelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Although DIRECT_IO_RELAX's initial usage is to allow shared mmap, its
description indicates a purpose of reducing memory footprint. This
may imply that it could be further used to relax other DIRECT_IO
operations in the future.

Replace it with a flag DIRECT_IO_ALLOW_MMAP which does only one thing,
allow shared mmap of DIRECT_IO files while still bypassing the cache
on regular reads and writes.

Signed-off-by: Tyler Fanelli <tfanelli@redhat.com>
---
 fs/fuse/file.c            | 6 +++---
 fs/fuse/fuse_i.h          | 4 ++--
 fs/fuse/inode.c           | 6 +++---
 include/uapi/linux/fuse.h | 7 +++----
 4 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 1cdb6327511e..89e870d1a526 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1448,7 +1448,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 	if (!ia)
 		return -ENOMEM;
 
-	if (fopen_direct_io && fc->direct_io_relax) {
+	if (fopen_direct_io && fc->direct_io_allow_mmap) {
 		res = filemap_write_and_wait_range(mapping, pos, pos + count - 1);
 		if (res) {
 			fuse_io_free(ia);
@@ -2466,9 +2466,9 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 
 	if (ff->open_flags & FOPEN_DIRECT_IO) {
 		/* Can't provide the coherency needed for MAP_SHARED
-		 * if FUSE_DIRECT_IO_RELAX isn't set.
+		 * if FUSE_DIRECT_IO_ALLOW_MMAP isn't set.
 		 */
-		if ((vma->vm_flags & VM_MAYSHARE) && !fc->direct_io_relax)
+		if ((vma->vm_flags & VM_MAYSHARE) && !fc->direct_io_allow_mmap)
 			return -ENODEV;
 
 		invalidate_inode_pages2(file->f_mapping);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index bf0b85d0b95c..bc3b7d10b929 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -797,8 +797,8 @@ struct fuse_conn {
 	/* Is tmpfile not implemented by fs? */
 	unsigned int no_tmpfile:1;
 
-	/* relax restrictions in FOPEN_DIRECT_IO mode */
-	unsigned int direct_io_relax:1;
+	/* Relax restrictions to allow shared mmap in FOPEN_DIRECT_IO mode */
+	unsigned int direct_io_allow_mmap:1;
 
 	/* Is statx not implemented by fs? */
 	unsigned int no_statx:1;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 2e4eb7cf26fb..444418e240c8 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1232,8 +1232,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 				fc->init_security = 1;
 			if (flags & FUSE_CREATE_SUPP_GROUP)
 				fc->create_supp_group = 1;
-			if (flags & FUSE_DIRECT_IO_RELAX)
-				fc->direct_io_relax = 1;
+			if (flags & FUSE_DIRECT_IO_ALLOW_MMAP)
+				fc->direct_io_allow_mmap = 1;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1280,7 +1280,7 @@ void fuse_send_init(struct fuse_mount *fm)
 		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
 		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
-		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_RELAX;
+		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index db92a7202b34..f4e3c083aede 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -209,7 +209,7 @@
  *  - add FUSE_HAS_EXPIRE_ONLY
  *
  *  7.39
- *  - add FUSE_DIRECT_IO_RELAX
+ *  - add FUSE_DIRECT_IO_ALLOW_MMAP
  *  - add FUSE_STATX and related structures
  */
 
@@ -409,8 +409,7 @@ struct fuse_file_lock {
  * FUSE_CREATE_SUPP_GROUP: add supplementary group info to create, mkdir,
  *			symlink and mknod (single group that matches parent)
  * FUSE_HAS_EXPIRE_ONLY: kernel supports expiry-only entry invalidation
- * FUSE_DIRECT_IO_RELAX: relax restrictions in FOPEN_DIRECT_IO mode, for now
- *                       allow shared mmap
+ * FUSE_DIRECT_IO_ALLOW_MMAP: allow shared mmap in FOPEN_DIRECT_IO mode.
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -449,7 +448,7 @@ struct fuse_file_lock {
 #define FUSE_HAS_INODE_DAX	(1ULL << 33)
 #define FUSE_CREATE_SUPP_GROUP	(1ULL << 34)
 #define FUSE_HAS_EXPIRE_ONLY	(1ULL << 35)
-#define FUSE_DIRECT_IO_RELAX	(1ULL << 36)
+#define FUSE_DIRECT_IO_ALLOW_MMAP (1ULL << 36)
 
 /**
  * CUSE INIT request/reply flags
-- 
2.40.1

