Return-Path: <linux-fsdevel+bounces-70239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AB7C941A2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 16:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D6F3A5C27
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 15:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BAA1C860C;
	Sat, 29 Nov 2025 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFvYxQiR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BA31EE7B9
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Nov 2025 15:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764431709; cv=none; b=Sd3qeHMxebPe3oWshp3+dWUx1483FscXcPCnN8rV58vVhuHRkq/1ll+arx8X5fgCg7K61f+VEs3Gvq1ou9CCU3jJWoftBO8vMuOYgkX4uFNcOP0MvjUGsOsTdJyqIU0Azv2Mro9xMmZ10qF5v2+Zl+cio655Vr+pRoHNhskrCTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764431709; c=relaxed/simple;
	bh=HvAxUzJkGXn2qFdccmTMQrW6uWMggHj8e1fpYhNC0RY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RwIyBDWd6h9ijpBp4p9mwpvNm+nzL9lhRvTLyPMM7AhXWt7biR8pzyVmonbvYdVm6K6pfHbB36veGerGGz7AlE+l9ZABQQNma/RjlFKvkF9bqJrSia8GA/ZY3p/QhA4pdbUkL43NRDh7T9IhdQCnEKDcNruElNTY6fgQQjuL2o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFvYxQiR; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b736d883ac4so293105666b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Nov 2025 07:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764431706; x=1765036506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X1eC10We295VV65umPfobtygoRy82cfYMzrL4jRtdf4=;
        b=RFvYxQiRxplSMSCCHCGcOoussVeuf2fSIZMnDBiGUi3sm8fGCvbXJuD9DoJ0xDJB95
         aVmq4lNj5vK88M9ADeBiUWxfmdoNaT3CQcHvc2qm+3UyRF5T4XC2pc6pXSnQtHXGzOTa
         rGMROAZwwXt/Gk260QC1rXxU+ENMGZPP8vmt83XGkWvXMrDHoHHBadTE5hXz0aHq0AaI
         KY15GKNOeSTB2dS6j8ytGrf/muBlDAAAEXGbpdg6Yqdl+OU5uLgyfCiinsPzXCPmgbB2
         lMAMk88OZXgv02mB8ccFYSw29/i8kYuXqvfpQApqUgJbA6P6XjP+SpLJFA9303Ux3KKZ
         x7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764431706; x=1765036506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1eC10We295VV65umPfobtygoRy82cfYMzrL4jRtdf4=;
        b=sEzTxwUj/X+N9bhnfXXqOG7L10/ha0HpYYUfw6oK7EOysQkI8T0J+OCAFGdkQTxOZ8
         KkcJTTbNCFjBYlwmdMtZ0F8BcxgnlDmn6I+D2/n28Un9uEd+ArwBnUxs8F0h3fKABoOw
         +uo6aQykZ68A9ES7yqmOIUAppg+5H2v79K1xLSMkArxX//5OC/rlX+Ea6iZtOIPk3U1S
         2NhyxQyVIICpAqOXdAg1gNmvecYe+mFXFf6VNZeqdfj7rRBvz0EOaTUHJEHoEzMx6S8p
         4+aZ+nwcxdlQRVFudlFdLQI/bATbdYhzgR+Y4YXalfxJanVuPZ3k6Z5cDGT8ztC3lo+z
         2d2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzyjkg48ns0YUnR0D+dHHN0KJQ4/yc4xbp6WXkoN1tE52AlTToaIinNEadA1uEvk7mXUBpxJMcjTTIn7cZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzomJtDq/ErIl+viZFB+01A+H8bpxPVCK5AHDLYrbZevsWCDlwD
	UaBAp7A/Hcwnl0yy19Fi7f6R7cVnn/F1rhUGFiHrIkubTE9YBJx22M57
X-Gm-Gg: ASbGncuRulX9jLVS7Lq6O0UBQBA+7RlI+GhyQppcspRwsp8c/YmXSWWFBMyOJUr95+k
	25qgxgkqteTgCA4i6DfngaZ0Bo/MJ1jI11skXzqBesN0vFbyIsnOYZBCAQhQdGp00CvMmQwdhbS
	gLuWm4z1Ok76vCspIUYvzwk89lKAgK5E2NkSYXSfti4kosqehjT47iSV1wlX7seAOqFSgHpzsJw
	8sIgi1y6TlW4p/mg58XUlT1F4WsKyhbJro3qdpIq3ZPDV4aeFmfGK49J/MrNlWp/HmVc0Owyxfc
	0P9KaDcr7AHihhi+zsyQ28jyicQnGEtZ4pG4F8Yg9z7jFasoGws+Nge7aCXEjOA2PCFaOgdoxvg
	8kKIfVv6PUBmAeWZBamNIBMvWJrbdI3QXcEN23N4Ey0EYyfWtrX5KFPwV0GJI0cjXFCH2ouxWzJ
	XOBGCIRk+KcOfUbkHpp9jLkEMIxQ8nK63qVzS73KeteLDboRI8LT4U8x+kWqM=
X-Google-Smtp-Source: AGHT+IElEh/cpVKjqvOyJ1pXnUpKsUtxPJQlyIWsiDMugYc0pMhFt+kg3jl0s1rlfy+4HeSOU2sZzA==
X-Received: by 2002:a17:907:8e95:b0:b73:5958:7e6c with SMTP id a640c23a62f3a-b767153ee44mr3577062966b.3.1764431705861;
        Sat, 29 Nov 2025 07:55:05 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5162c5csm746364766b.6.2025.11.29.07.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 07:55:05 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 1/2] fs: move getname and putname handlers into namei.h
Date: Sat, 29 Nov 2025 16:54:59 +0100
Message-ID: <20251129155500.43116-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will enable use of runtime const machinery for namei_cachep.
Existing header spaghetti makes it impossible to use while in fs.h

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

This may end up creating merge conflicts against the work which messed
with audit and atomic refcounts on struct filename, but they should be
trivially resolvable. Things just got moved fs.h -> namei.h

tested with allmodconfig

 drivers/base/firmware_loader/main.c |  1 +
 fs/ceph/mds_client.h                |  1 +
 fs/d_path.c                         |  1 +
 fs/exfat/dir.c                      |  1 +
 fs/f2fs/f2fs.h                      |  1 +
 fs/fat/dir.c                        |  1 +
 fs/filesystems.c                    |  1 +
 fs/ntfs3/dir.c                      |  1 +
 fs/ntfs3/fsntfs.c                   |  1 +
 fs/ntfs3/namei.c                    |  1 +
 fs/ntfs3/xattr.c                    |  1 +
 fs/smb/client/cifsproto.h           |  1 +
 fs/vboxsf/file.c                    |  1 +
 include/linux/fs.h                  | 42 +----------------------------
 include/linux/namei.h               | 41 ++++++++++++++++++++++++++++
 io_uring/statx.c                    |  1 +
 mm/huge_memory.c                    |  1 +
 security/integrity/ima/ima_api.c    |  1 +
 security/integrity/ima/ima_main.c   |  1 +
 19 files changed, 59 insertions(+), 41 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 4ebdca9e4da4..ac5a86d7692f 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -29,6 +29,7 @@
 #include <linux/file.h>
 #include <linux/list.h>
 #include <linux/fs.h>
+#include <linux/namei.h>
 #include <linux/async.h>
 #include <linux/pm.h>
 #include <linux/suspend.h>
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 0428a5eaf28c..bc0b8da9fca2 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -11,6 +11,7 @@
 #include <linux/refcount.h>
 #include <linux/utsname.h>
 #include <linux/ktime.h>
+#include <linux/namei.h>
 
 #include <linux/ceph/types.h>
 #include <linux/ceph/messenger.h>
diff --git a/fs/d_path.c b/fs/d_path.c
index bb365511066b..19cde8b57771 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -4,6 +4,7 @@
 #include <linux/uaccess.h>
 #include <linux/fs_struct.h>
 #include <linux/fs.h>
+#include <linux/namei.h>
 #include <linux/slab.h>
 #include <linux/prefetch.h>
 #include "mount.h"
diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 3045a58e124a..9d588a64e5dd 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -7,6 +7,7 @@
 #include <linux/compat.h>
 #include <linux/bio.h>
 #include <linux/buffer_head.h>
+#include <linux/namei.h>
 
 #include "exfat_raw.h"
 #include "exfat_fs.h"
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5f104518c414..78d97ccb646e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -24,6 +24,7 @@
 #include <linux/quotaops.h>
 #include <linux/part_stat.h>
 #include <linux/rw_hint.h>
+#include <linux/namei.h>
 
 #include <linux/fscrypt.h>
 #include <linux/fsverity.h>
diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 92b091783966..6dd7d0f6043f 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -18,6 +18,7 @@
 #include <linux/compat.h>
 #include <linux/uaccess.h>
 #include <linux/iversion.h>
+#include <linux/namei.h>
 #include "fat.h"
 
 /*
diff --git a/fs/filesystems.c b/fs/filesystems.c
index 95e5256821a5..fb0dac8aa916 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/fs_parser.h>
+#include <linux/namei.h>
 
 /*
  * Handling of filesystem drivers list.
diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index b98e95d6b4d9..5e778cac4197 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/namei.h>
 #include <linux/nls.h>
 
 #include "debug.h"
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 5f138f715835..5099c8fbe6b2 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -8,6 +8,7 @@
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>
 #include <linux/fs.h>
+#include <linux/namei.h>
 #include <linux/kernel.h>
 #include <linux/nls.h>
 
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 3b24ca02de61..1251dae282bb 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/namei.h>
 #include <linux/nls.h>
 #include <linux/ctype.h>
 #include <linux/posix_acl.h>
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index c93df55e98d0..1211a0859000 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/namei.h>
 #include <linux/posix_acl.h>
 #include <linux/posix_acl_xattr.h>
 #include <linux/xattr.h>
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 3528c365a452..6438a2dc77c3 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -9,6 +9,7 @@
 #define _CIFSPROTO_H
 #include <linux/nls.h>
 #include <linux/ctype.h>
+#include <linux/namei.h>
 #include "cifsglob.h"
 #include "trace.h"
 #ifdef CONFIG_CIFS_DFS_UPCALL
diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
index 4bebd947314a..bb05e99c1d24 100644
--- a/fs/vboxsf/file.c
+++ b/fs/vboxsf/file.c
@@ -10,6 +10,7 @@
 #include <linux/pagemap.h>
 #include <linux/highmem.h>
 #include <linux/sizes.h>
+#include <linux/namei.h>
 #include "vfsmod.h"
 
 struct vboxsf_handle {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 04ceeca12a0d..8b6f8e373ac7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -55,6 +55,7 @@ struct bdi_writeback;
 struct bio;
 struct io_comp_batch;
 struct fiemap_extent_info;
+struct filename;
 struct hd_geometry;
 struct iovec;
 struct kiocb;
@@ -2408,16 +2409,6 @@ extern struct kobject *fs_kobj;
 #define MAX_RW_COUNT (INT_MAX & PAGE_MASK)
 
 /* fs/open.c */
-struct audit_names;
-struct filename {
-	const char		*name;	/* pointer to actual string */
-	const __user char	*uptr;	/* original userland pointer */
-	atomic_t		refcnt;
-	struct audit_names	*aname;
-	const char		iname[];
-};
-static_assert(offsetof(struct filename, iname) % sizeof(long) == 0);
-
 static inline struct mnt_idmap *file_mnt_idmap(const struct file *file)
 {
 	return mnt_idmap(file->f_path.mnt);
@@ -2491,32 +2482,6 @@ static inline struct file *file_clone_open(struct file *file)
 }
 extern int filp_close(struct file *, fl_owner_t id);
 
-extern struct filename *getname_flags(const char __user *, int);
-extern struct filename *getname_uflags(const char __user *, int);
-static inline struct filename *getname(const char __user *name)
-{
-	return getname_flags(name, 0);
-}
-extern struct filename *getname_kernel(const char *);
-extern struct filename *__getname_maybe_null(const char __user *);
-static inline struct filename *getname_maybe_null(const char __user *name, int flags)
-{
-	if (!(flags & AT_EMPTY_PATH))
-		return getname(name);
-
-	if (!name)
-		return NULL;
-	return __getname_maybe_null(name);
-}
-extern void putname(struct filename *name);
-DEFINE_FREE(putname, struct filename *, if (!IS_ERR_OR_NULL(_T)) putname(_T))
-
-static inline struct filename *refname(struct filename *name)
-{
-	atomic_inc(&name->refcnt);
-	return name;
-}
-
 extern int finish_open(struct file *file, struct dentry *dentry,
 			int (*open)(struct inode *, struct file *));
 extern int finish_no_open(struct file *file, struct dentry *dentry);
@@ -2534,11 +2499,6 @@ static inline int finish_open_simple(struct file *file, int error)
 extern void __init vfs_caches_init_early(void);
 extern void __init vfs_caches_init(void);
 
-extern struct kmem_cache *names_cachep;
-
-#define __getname()		kmem_cache_alloc(names_cachep, GFP_KERNEL)
-#define __putname(name)		kmem_cache_free(names_cachep, (void *)(name))
-
 void emergency_thaw_all(void);
 extern int sync_filesystem(struct super_block *);
 extern const struct file_operations def_blk_fops;
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 58600cf234bc..bd4a7b058f97 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -52,6 +52,47 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
 
 extern int path_pts(struct path *path);
 
+struct audit_names;
+struct filename {
+	const char		*name;	/* pointer to actual string */
+	const __user char	*uptr;	/* original userland pointer */
+	atomic_t		refcnt;
+	struct audit_names	*aname;
+	const char		iname[];
+};
+static_assert(offsetof(struct filename, iname) % sizeof(long) == 0);
+
+struct filename *getname_flags(const char __user *, int);
+struct filename *getname_uflags(const char __user *, int);
+static inline struct filename *getname(const char __user *name)
+{
+	return getname_flags(name, 0);
+}
+struct filename *getname_kernel(const char *);
+struct filename *__getname_maybe_null(const char __user *);
+static inline struct filename *getname_maybe_null(const char __user *name, int flags)
+{
+	if (!(flags & AT_EMPTY_PATH))
+		return getname(name);
+
+	if (!name)
+		return NULL;
+	return __getname_maybe_null(name);
+}
+void putname(struct filename *name);
+DEFINE_FREE(putname, struct filename *, if (!IS_ERR_OR_NULL(_T)) putname(_T))
+
+static inline struct filename *refname(struct filename *name)
+{
+	atomic_inc(&name->refcnt);
+	return name;
+}
+
+extern struct kmem_cache *names_cachep;
+
+#define __getname()		kmem_cache_alloc(names_cachep, GFP_KERNEL)
+#define __putname(name)		kmem_cache_free(names_cachep, (void *)(name))
+
 extern int user_path_at(int, const char __user *, unsigned, struct path *);
 
 struct dentry *lookup_one_qstr_excl(const struct qstr *name,
diff --git a/io_uring/statx.c b/io_uring/statx.c
index 5111e9befbfe..ba6442633214 100644
--- a/io_uring/statx.c
+++ b/io_uring/statx.c
@@ -2,6 +2,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/file.h>
+#include <linux/namei.h>
 #include <linux/io_uring.h>
 
 #include <uapi/linux/io_uring.h>
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f7c565f11a98..69c1eee121a4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -40,6 +40,7 @@
 #include <linux/pgalloc.h>
 #include <linux/pgalloc_tag.h>
 #include <linux/pagewalk.h>
+#include <linux/namei.h>
 
 #include <asm/tlb.h>
 #include "internal.h"
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index c35ea613c9f8..7b1d73a7e7e3 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/namei.h>
 #include <linux/xattr.h>
 #include <linux/evm.h>
 #include <linux/fsverity.h>
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 5770cf691912..5fd40401d89f 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -25,6 +25,7 @@
 #include <linux/xattr.h>
 #include <linux/ima.h>
 #include <linux/fs.h>
+#include <linux/namei.h>
 #include <linux/iversion.h>
 #include <linux/evm.h>
 #include <linux/crash_dump.h>
-- 
2.48.1


