Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0FF79D931
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 20:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjILSyW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 14:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjILSyS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:54:18 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7994C12E
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 11:54:14 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5007616b756so9862862e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 11:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694544853; x=1695149653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uWTXMHXn6GtpXUIS9kZdIuCwHA1GsXtqL/99JsQ2V3s=;
        b=Zj+5RnNSEZsD53xQlxkB+6Uo4oTGPytvAVTW9nJLafIG+ywgVx18MSb3tHHmF0ehl7
         BYp8UKd1ekyMWn562E0NMhr35ZdHlA3Mp18v2PVFmkh9ikYpCzdJ3yGSdH/lFa76NYeh
         hY8uG48v8VqhS3qi25V5ptaYoQMjMFbaYdxEAHZuIZH5eTWQoW+o2cdD8k8qVGcDJ1WD
         BReuKWcFJiUwJn/bU3viHhPidykwESlhWc7UQlUVkL97aE9NihH/aWPG6yK8BO0ozCln
         cqjIuxn/cRHL2cxk0AEoa9LtkmSDogWLr4bihJs4hSqylZH6fAZiC5xRW+EFJiBUQGkG
         jNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694544853; x=1695149653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uWTXMHXn6GtpXUIS9kZdIuCwHA1GsXtqL/99JsQ2V3s=;
        b=S2xPbzPziSx+z7gKuh64bT/dWFc0xucVL0eD3TsjVF8xiDg+nHTyrTCqxUl4OrdN9+
         WH6iCo8TTAOARCWZ4DuSlh5qSeaWPYbIFoLWS3Yc9cVP3qOR2lE4T6rhjAI9gR61vyia
         VhfWKh5k3IlBoyrmdRCmbv6HZfBHlqmB7yDOE7EHtOI57dbmm6Xf71BY6e3qjQ1vJH0E
         0a7zKPzEgsyV8QWgy39ldMV4rWQo0WY4wgzAVnAfg9j4SwruYBfG5IxpERt2uUonbTPe
         F+Xu41ZeTtTIfbnJIte0Ned8zqgJC9AA1CG6MQfdZPhNMg2lrTRHvCFV3BunuOeNsCPo
         8gxg==
X-Gm-Message-State: AOJu0Yy2ezRnS9ZIQrxL1Bj+Sq2VbyaFFpurnD2i9+u+2j68FhM1i8BO
        JBjpS9zeFH+fX03pvtNDmq0=
X-Google-Smtp-Source: AGHT+IHyPfMeQOMGhDLJm1NcpAwk+0PyJWaTbPssS6YC3e0O49/kBXQFJMBlrMmndjMi/43ZEoHwvA==
X-Received: by 2002:a19:8c08:0:b0:500:9d4a:89ff with SMTP id o8-20020a198c08000000b005009d4a89ffmr285573lfd.62.1694544852244;
        Tue, 12 Sep 2023 11:54:12 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id s8-20020a056402164800b0052ea03b9d05sm6252069edx.85.2023.09.12.11.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 11:54:11 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] ovl: factor out some common helpers for backing files io
Date:   Tue, 12 Sep 2023 21:54:08 +0300
Message-Id: <20230912185408.3343163-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Overlayfs stores its files data in backing files on other filesystems.

Factor out some common helpers to perform io to backing files, that will
later be reused by fuse passthrough code.

Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
Link: https://lore.kernel.org/r/CAJfpeguhmZbjP3JLqtUy0AdWaHOkAPWeP827BBWwRFEAUgnUcQ@mail.gmail.com
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Miklos,

This is the re-factoring that you suggested in the FUSE passthrough
patches discussion linked above.

This patch is based on the overlayfs prep patch set I just posted [1].

Although overlayfs currently is the only user of these backing file
helpers, I am sending this patch to a wider audience in case other
filesystem developers want to comment on the abstraction.

We could perhaps later considering moving backing_file_open() helper
and related code to backing_file.c.

In any case, if there are no objections, I plan to queue this work
for 6.7 via the overlayfs tree.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-unionfs/20230912173653.3317828-1-amir73il@gmail.com/


 MAINTAINERS                  |   2 +
 fs/Kconfig                   |   4 +
 fs/Makefile                  |   1 +
 fs/backing_file.c            | 160 +++++++++++++++++++++++++++++++++++
 fs/overlayfs/Kconfig         |   1 +
 fs/overlayfs/file.c          | 137 ++----------------------------
 fs/overlayfs/overlayfs.h     |   2 -
 fs/overlayfs/super.c         |  11 +--
 include/linux/backing_file.h |  22 +++++
 9 files changed, 199 insertions(+), 141 deletions(-)
 create mode 100644 fs/backing_file.c
 create mode 100644 include/linux/backing_file.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 90f13281d297..4e1d21773e0e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16092,7 +16092,9 @@ L:	linux-unionfs@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git
 F:	Documentation/filesystems/overlayfs.rst
+F:	fs/backing_file.c
 F:	fs/overlayfs/
+F:	include/linux/backing_file.h
 
 P54 WIRELESS DRIVER
 M:	Christian Lamparter <chunkeey@googlemail.com>
diff --git a/fs/Kconfig b/fs/Kconfig
index aa7e03cc1941..9027a88ffa47 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -26,6 +26,10 @@ config LEGACY_DIRECT_IO
 	depends on BUFFER_HEAD
 	bool
 
+# Common backing file helpers
+config FS_BACKING_FILE
+	bool
+
 if BLOCK
 
 source "fs/ext2/Kconfig"
diff --git a/fs/Makefile b/fs/Makefile
index f9541f40be4e..95ef06cff388 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_COMPAT_BINFMT_ELF)	+= compat_binfmt_elf.o
 obj-$(CONFIG_BINFMT_ELF_FDPIC)	+= binfmt_elf_fdpic.o
 obj-$(CONFIG_BINFMT_FLAT)	+= binfmt_flat.o
 
+obj-$(CONFIG_FS_BACKING_FILE)	+= backing_file.o
 obj-$(CONFIG_FS_MBCACHE)	+= mbcache.o
 obj-$(CONFIG_FS_POSIX_ACL)	+= posix_acl.o
 obj-$(CONFIG_NFS_COMMON)	+= nfs_common/
diff --git a/fs/backing_file.c b/fs/backing_file.c
new file mode 100644
index 000000000000..ea895ca1639d
--- /dev/null
+++ b/fs/backing_file.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Common helpers for backing file io.
+ * Forked from fs/overlayfs/file.c.
+ *
+ * Copyright (C) 2017 Red Hat, Inc.
+ * Copyright (C) 2023 CTERA Networks.
+ */
+
+#include <linux/backing_file.h>
+
+struct backing_aio_req {
+	struct kiocb iocb;
+	refcount_t ref;
+	struct kiocb *orig_iocb;
+	void (*cleanup)(struct kiocb *, long);
+};
+
+static struct kmem_cache *backing_aio_req_cachep;
+
+#define BACKING_IOCB_MASK \
+	(IOCB_NOWAIT | IOCB_HIPRI | IOCB_DSYNC | IOCB_SYNC | IOCB_APPEND)
+
+static rwf_t iocb_to_rw_flags(int flags)
+{
+	return (__force rwf_t)(flags & BACKING_IOCB_MASK);
+}
+
+static void backing_aio_put(struct backing_aio_req *aio_req)
+{
+	if (refcount_dec_and_test(&aio_req->ref)) {
+		fput(aio_req->iocb.ki_filp);
+		kmem_cache_free(backing_aio_req_cachep, aio_req);
+	}
+}
+
+/* Completion for submitted/failed async rw io */
+static void backing_aio_cleanup(struct backing_aio_req *aio_req, long res)
+{
+	struct kiocb *iocb = &aio_req->iocb;
+	struct kiocb *orig_iocb = aio_req->orig_iocb;
+
+	if (iocb->ki_flags & IOCB_WRITE)
+		kiocb_end_write(iocb);
+
+	orig_iocb->ki_pos = iocb->ki_pos;
+	if (aio_req->cleanup)
+		aio_req->cleanup(orig_iocb, res);
+
+	backing_aio_put(aio_req);
+}
+
+/* Completion for submitted async rw io */
+static void backing_aio_rw_complete(struct kiocb *iocb, long res)
+{
+	struct backing_aio_req *aio_req = container_of(iocb,
+					       struct backing_aio_req, iocb);
+	struct kiocb *orig_iocb = aio_req->orig_iocb;
+
+	backing_aio_cleanup(aio_req, res);
+	orig_iocb->ki_complete(orig_iocb, res);
+}
+
+
+ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
+			       struct kiocb *iocb, int flags,
+			       void (*cleanup)(struct kiocb *, long))
+{
+	struct backing_aio_req *aio_req = NULL;
+	ssize_t ret;
+
+	if (!iov_iter_count(iter))
+		return 0;
+
+	if (iocb->ki_flags & IOCB_DIRECT &&
+	    !(file->f_mode & FMODE_CAN_ODIRECT))
+		return -EINVAL;
+
+	if (is_sync_kiocb(iocb)) {
+		rwf_t rwf = iocb_to_rw_flags(flags);
+
+		ret = vfs_iter_read(file, iter, &iocb->ki_pos, rwf);
+		if (cleanup)
+			cleanup(iocb, ret);
+	} else {
+		aio_req = kmem_cache_zalloc(backing_aio_req_cachep, GFP_KERNEL);
+		if (!aio_req)
+			return -ENOMEM;
+
+		aio_req->orig_iocb = iocb;
+		aio_req->cleanup = cleanup;
+		kiocb_clone(&aio_req->iocb, iocb, get_file(file));
+		aio_req->iocb.ki_complete = backing_aio_rw_complete;
+		refcount_set(&aio_req->ref, 2);
+		ret = vfs_iocb_iter_read(file, &aio_req->iocb, iter);
+		backing_aio_put(aio_req);
+		if (ret != -EIOCBQUEUED)
+			backing_aio_cleanup(aio_req, ret);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(backing_file_read_iter);
+
+ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
+				struct kiocb *iocb, int flags,
+				void (*cleanup)(struct kiocb *, long))
+{
+	ssize_t ret;
+
+	if (!iov_iter_count(iter))
+		return 0;
+
+	if (iocb->ki_flags & IOCB_DIRECT &&
+	    !(file->f_mode & FMODE_CAN_ODIRECT))
+		return -EINVAL;
+
+	if (is_sync_kiocb(iocb)) {
+		rwf_t rwf = iocb_to_rw_flags(flags);
+
+		file_start_write(file);
+		ret = vfs_iter_write(file, iter, &iocb->ki_pos, rwf);
+		file_end_write(file);
+		if (cleanup)
+			cleanup(iocb, ret);
+	} else {
+		struct backing_aio_req *aio_req;
+
+		aio_req = kmem_cache_zalloc(backing_aio_req_cachep, GFP_KERNEL);
+		if (!aio_req)
+			return -ENOMEM;
+
+		aio_req->orig_iocb = iocb;
+		aio_req->cleanup = cleanup;
+		kiocb_clone(&aio_req->iocb, iocb, get_file(file));
+		aio_req->iocb.ki_flags = flags;
+		aio_req->iocb.ki_complete = backing_aio_rw_complete;
+		refcount_set(&aio_req->ref, 2);
+		kiocb_start_write(&aio_req->iocb);
+		ret = vfs_iocb_iter_write(file, &aio_req->iocb, iter);
+		backing_aio_put(aio_req);
+		if (ret != -EIOCBQUEUED)
+			backing_aio_cleanup(aio_req, ret);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(backing_file_write_iter);
+
+static int __init backing_aio_init(void)
+{
+	backing_aio_req_cachep = kmem_cache_create("backing_aio_req",
+					   sizeof(struct backing_aio_req),
+					   0, SLAB_HWCACHE_ALIGN, NULL);
+	if (!backing_aio_req_cachep)
+		return -ENOMEM;
+
+	return 0;
+}
+fs_initcall(backing_aio_init);
diff --git a/fs/overlayfs/Kconfig b/fs/overlayfs/Kconfig
index fec5020c3495..7f52d9031cff 100644
--- a/fs/overlayfs/Kconfig
+++ b/fs/overlayfs/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config OVERLAY_FS
 	tristate "Overlay filesystem support"
+	select FS_BACKING_FILE
 	select EXPORTFS
 	help
 	  An overlay filesystem combines two filesystems - an 'upper' filesystem
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 05ec614f7054..81fe6a85cad9 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -13,16 +13,9 @@
 #include <linux/security.h>
 #include <linux/mm.h>
 #include <linux/fs.h>
+#include <linux/backing_file.h>
 #include "overlayfs.h"
 
-struct ovl_aio_req {
-	struct kiocb iocb;
-	refcount_t ref;
-	struct kiocb *orig_iocb;
-};
-
-static struct kmem_cache *ovl_aio_request_cachep;
-
 static char ovl_whatisit(struct inode *inode, struct inode *realinode)
 {
 	if (realinode != ovl_inode_upper(inode))
@@ -262,24 +255,8 @@ static void ovl_file_accessed(struct file *file)
 	touch_atime(&file->f_path);
 }
 
-#define OVL_IOCB_MASK \
-	(IOCB_NOWAIT | IOCB_HIPRI | IOCB_DSYNC | IOCB_SYNC | IOCB_APPEND)
-
-static rwf_t iocb_to_rw_flags(int flags)
-{
-	return (__force rwf_t)(flags & OVL_IOCB_MASK);
-}
-
-static inline void ovl_aio_put(struct ovl_aio_req *aio_req)
-{
-	if (refcount_dec_and_test(&aio_req->ref)) {
-		fput(aio_req->iocb.ki_filp);
-		kmem_cache_free(ovl_aio_request_cachep, aio_req);
-	}
-}
-
 /* Completion for submitted/failed sync/async rw io */
-static void ovl_rw_complete(struct kiocb *orig_iocb)
+static void ovl_rw_complete(struct kiocb *orig_iocb, long res)
 {
 	struct file *file = orig_iocb->ki_filp;
 
@@ -292,32 +269,6 @@ static void ovl_rw_complete(struct kiocb *orig_iocb)
 	}
 }
 
-/* Completion for submitted/failed async rw io */
-static void ovl_aio_cleanup(struct ovl_aio_req *aio_req)
-{
-	struct kiocb *iocb = &aio_req->iocb;
-	struct kiocb *orig_iocb = aio_req->orig_iocb;
-
-	if (iocb->ki_flags & IOCB_WRITE)
-		kiocb_end_write(iocb);
-
-	orig_iocb->ki_pos = iocb->ki_pos;
-	ovl_rw_complete(orig_iocb);
-
-	ovl_aio_put(aio_req);
-}
-
-/* Completion for submitted async rw io */
-static void ovl_aio_rw_complete(struct kiocb *iocb, long res)
-{
-	struct ovl_aio_req *aio_req = container_of(iocb,
-						   struct ovl_aio_req, iocb);
-	struct kiocb *orig_iocb = aio_req->orig_iocb;
-
-	ovl_aio_cleanup(aio_req);
-	orig_iocb->ki_complete(orig_iocb, res);
-}
-
 static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
@@ -332,38 +283,10 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	if (ret)
 		return ret;
 
-	ret = -EINVAL;
-	if (iocb->ki_flags & IOCB_DIRECT &&
-	    !(real.file->f_mode & FMODE_CAN_ODIRECT))
-		goto out_fdput;
-
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	if (is_sync_kiocb(iocb)) {
-		rwf_t rwf = iocb_to_rw_flags(iocb->ki_flags);
-
-		ret = vfs_iter_read(real.file, iter, &iocb->ki_pos, rwf);
-		ovl_rw_complete(iocb);
-	} else {
-		struct ovl_aio_req *aio_req;
-
-		ret = -ENOMEM;
-		aio_req = kmem_cache_zalloc(ovl_aio_request_cachep, GFP_KERNEL);
-		if (!aio_req)
-			goto out;
-
-		real.flags = 0;
-		aio_req->orig_iocb = iocb;
-		kiocb_clone(&aio_req->iocb, iocb, get_file(real.file));
-		aio_req->iocb.ki_complete = ovl_aio_rw_complete;
-		refcount_set(&aio_req->ref, 2);
-		ret = vfs_iocb_iter_read(real.file, &aio_req->iocb, iter);
-		ovl_aio_put(aio_req);
-		if (ret != -EIOCBQUEUED)
-			ovl_aio_cleanup(aio_req);
-	}
-out:
+	ret = backing_file_read_iter(real.file, iter, iocb, iocb->ki_flags,
+				     ovl_rw_complete);
 	revert_creds(old_cred);
-out_fdput:
 	fdput(real);
 
 	return ret;
@@ -392,45 +315,13 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	if (ret)
 		goto out_unlock;
 
-	ret = -EINVAL;
-	if (iocb->ki_flags & IOCB_DIRECT &&
-	    !(real.file->f_mode & FMODE_CAN_ODIRECT))
-		goto out_fdput;
-
 	if (!ovl_should_sync(OVL_FS(inode->i_sb)))
 		flags &= ~(IOCB_DSYNC | IOCB_SYNC);
 
 	old_cred = ovl_override_creds(inode->i_sb);
-	if (is_sync_kiocb(iocb)) {
-		rwf_t rwf = iocb_to_rw_flags(flags);
-
-		file_start_write(real.file);
-		ret = vfs_iter_write(real.file, iter, &iocb->ki_pos, rwf);
-		file_end_write(real.file);
-		ovl_rw_complete(iocb);
-	} else {
-		struct ovl_aio_req *aio_req;
-
-		ret = -ENOMEM;
-		aio_req = kmem_cache_zalloc(ovl_aio_request_cachep, GFP_KERNEL);
-		if (!aio_req)
-			goto out;
-
-		real.flags = 0;
-		aio_req->orig_iocb = iocb;
-		kiocb_clone(&aio_req->iocb, iocb, get_file(real.file));
-		aio_req->iocb.ki_flags = flags;
-		aio_req->iocb.ki_complete = ovl_aio_rw_complete;
-		refcount_set(&aio_req->ref, 2);
-		kiocb_start_write(&aio_req->iocb);
-		ret = vfs_iocb_iter_write(real.file, &aio_req->iocb, iter);
-		ovl_aio_put(aio_req);
-		if (ret != -EIOCBQUEUED)
-			ovl_aio_cleanup(aio_req);
-	}
-out:
+	ret = backing_file_write_iter(real.file, iter, iocb, flags,
+				      ovl_rw_complete);
 	revert_creds(old_cred);
-out_fdput:
 	fdput(real);
 
 out_unlock:
@@ -742,19 +633,3 @@ const struct file_operations ovl_file_operations = {
 	.copy_file_range	= ovl_copy_file_range,
 	.remap_file_range	= ovl_remap_file_range,
 };
-
-int __init ovl_aio_request_cache_init(void)
-{
-	ovl_aio_request_cachep = kmem_cache_create("ovl_aio_req",
-						   sizeof(struct ovl_aio_req),
-						   0, SLAB_HWCACHE_ALIGN, NULL);
-	if (!ovl_aio_request_cachep)
-		return -ENOMEM;
-
-	return 0;
-}
-
-void ovl_aio_request_cache_destroy(void)
-{
-	kmem_cache_destroy(ovl_aio_request_cachep);
-}
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 9817b2dcb132..64b98e67e826 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -799,8 +799,6 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdir,
 
 /* file.c */
 extern const struct file_operations ovl_file_operations;
-int __init ovl_aio_request_cache_init(void);
-void ovl_aio_request_cache_destroy(void);
 int ovl_real_fileattr_get(const struct path *realpath, struct fileattr *fa);
 int ovl_real_fileattr_set(const struct path *realpath, struct fileattr *fa);
 int ovl_fileattr_get(struct dentry *dentry, struct fileattr *fa);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index def266b5e2a3..8c132467fca1 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1530,14 +1530,10 @@ static int __init ovl_init(void)
 	if (ovl_inode_cachep == NULL)
 		return -ENOMEM;
 
-	err = ovl_aio_request_cache_init();
-	if (!err) {
-		err = register_filesystem(&ovl_fs_type);
-		if (!err)
-			return 0;
+	err = register_filesystem(&ovl_fs_type);
+	if (!err)
+		return 0;
 
-		ovl_aio_request_cache_destroy();
-	}
 	kmem_cache_destroy(ovl_inode_cachep);
 
 	return err;
@@ -1553,7 +1549,6 @@ static void __exit ovl_exit(void)
 	 */
 	rcu_barrier();
 	kmem_cache_destroy(ovl_inode_cachep);
-	ovl_aio_request_cache_destroy();
 }
 
 module_init(ovl_init);
diff --git a/include/linux/backing_file.h b/include/linux/backing_file.h
new file mode 100644
index 000000000000..1428fe7b26bb
--- /dev/null
+++ b/include/linux/backing_file.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Common helpers for backing file io.
+ *
+ * Copyright (C) 2023 CTERA Networks.
+ */
+
+#ifndef _LINUX_BACKING_FILE_H
+#define _LINUX_BACKING_FILE_H
+
+#include <linux/file.h>
+#include <linux/uio.h>
+#include <linux/fs.h>
+
+ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
+			       struct kiocb *iocb, int flags,
+			       void (*cleanup)(struct kiocb *, long));
+ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
+				struct kiocb *iocb, int flags,
+				void (*cleanup)(struct kiocb *, long));
+
+#endif	/* _LINUX_BACKING_FILE_H */
-- 
2.34.1

