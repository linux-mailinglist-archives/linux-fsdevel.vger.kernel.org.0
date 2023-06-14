Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0B372FDED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 14:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243818AbjFNMKg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 08:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243511AbjFNMJx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:09:53 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF42269E;
        Wed, 14 Jun 2023 05:09:24 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f8d176396bso5683085e9.2;
        Wed, 14 Jun 2023 05:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686744563; x=1689336563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F1z4WgWnKubqQU1x1f+lfITmeekP4TqC1ly1bGig6G4=;
        b=WO1iuFwgqiqrZnRN9XG7IClnqpyo/yJJRkhI6sRxZ0X1Sci313svccx5gJ+PAMJCGW
         2N0BCiMlJ/JVuUtNlYN1WVaBEUdrM2hYA7jNiQ6Q/As1nXYn8r5s+bnWRISD+YWiv5FZ
         xkSnhhfgjyKdLpchN0h2Y7Qrm3FfOooB7Zrc5W8oFyECIIogP8Dguz7D7pv5bCE6Z0Ui
         KrSwHl/fF2+jDDjr0fLMX9OHi4KDgMiLhWhTdAovKKiNWw1V6QwIpi5XmxN2WnKRiWAN
         FjgDuYPDe+tNV0tFv31ei4IsAKhvIbIhpNRFYZIIvMXEdglVz13lh+39uuz4zkMEkiJf
         uHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686744563; x=1689336563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F1z4WgWnKubqQU1x1f+lfITmeekP4TqC1ly1bGig6G4=;
        b=Gj3ebyER3pXluIzN78c8w6Y/dRme3POHtmxL5lKp0UTUOjl5/fUsipoTNqgaNJgzxa
         o/zu/Q7D3g9gjyZVtf5b9t9cvX0cBYOY98hXsW1DUYRw/v22vapmM39EH/jAUc6+MQpO
         Npxi0DQDyr3Apca7AmFCLGtVhZ1o7j+v8y0waoR20uthbOeNcm6nKx2NdPEKdArQ7XK/
         Ytr3+3hXXTYR2W+sSvn0dgOle2b6zDsYE5oJh99hud7MWZtH8ye/NdObGKN8GqstSiqd
         9KChnX/5E+ZLoXa1E8HkxEWms2AmOwvTlteRSPUbq9KKrNNDDVqT5UsrfGhtz5WPm9OA
         kYJw==
X-Gm-Message-State: AC+VfDw6x5cc7mNfk2X7Y3wANOTpncTqxG0BFPXdmkKy487QcA6tqllQ
        4X/lgV6jmsj5UqQkW3tcF48=
X-Google-Smtp-Source: ACHHUZ5nCN4lBQZchugVlW3SgvrWC2CcgE1pYFo3XCNwuVBmrUyltnHO1XU9DEAwdFbyaGd/mHqTTQ==
X-Received: by 2002:a7b:cb98:0:b0:3f7:948f:5f17 with SMTP id m24-20020a7bcb98000000b003f7948f5f17mr10553715wmi.7.1686744562678;
        Wed, 14 Jun 2023 05:09:22 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id m41-20020a05600c3b2900b003f7f475c3bcsm7941375wms.1.2023.06.14.05.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 05:09:22 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH] fs: use helpers for opening kernel internal files
Date:   Wed, 14 Jun 2023 15:09:17 +0300
Message-Id: <20230614120917.2037482-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Overlayfs and cachefiles use vfs_open_tmpfile() to open a tmpfile
without accounting for nr_files.

Rename this helper to kernel_tmpfile_open() to better reflect this
helper is used for kernel internal users.

cachefiles uses open_with_fake_path() without the need for a fake path
only to use the noaccount feature of open_with_fake_path().

Fork open_with_fake_path() to kernel_file_open() which only does the
noaccount feature and use it in cachefiles.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Christian,

Per your request, here is an extra patch to decouple cachefiles
from open_with_fake_path().

This patch comes before the backing_file patches [1].
There is a minor merge conflict with backing_file patches
please see how I resolved it on my branch [2] -
Note that the mention of 'cachefiles' was removed from the
backing_file commit message and there is a slight rewording
that you also requested s/open_backing_file/backing_file_open,
to be consistent with kernel_file_open.

I truely hope that this patch is not going to steer a bike shedding
session over the names of the helpers.

Note that all the inernal kernel files opened by cachefiles using the
new kernel_*_open() helpers also have the S_KERNEL_FILE inode flag.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20230614074907.1943007-1-amir73il@gmail.com/
[2] https://github.com/amir73il/linux/commits/ovl_fake_path

 fs/cachefiles/namei.c    | 10 +++++-----
 fs/namei.c               | 24 +++++++++++++-----------
 fs/open.c                | 31 +++++++++++++++++++++++++++++++
 fs/overlayfs/overlayfs.h |  5 +++--
 include/linux/fs.h       |  9 ++++++---
 5 files changed, 58 insertions(+), 21 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 82219a8f6084..499cf73f097b 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -451,9 +451,9 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 
 	ret = cachefiles_inject_write_error();
 	if (ret == 0) {
-		file = vfs_tmpfile_open(&nop_mnt_idmap, &parentpath, S_IFREG,
-					O_RDWR | O_LARGEFILE | O_DIRECT,
-					cache->cache_cred);
+		file = kernel_tmpfile_open(&nop_mnt_idmap, &parentpath, S_IFREG,
+					   O_RDWR | O_LARGEFILE | O_DIRECT,
+					   cache->cache_cred);
 		ret = PTR_ERR_OR_ZERO(file);
 	}
 	if (ret) {
@@ -560,8 +560,8 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
 	 */
 	path.mnt = cache->mnt;
 	path.dentry = dentry;
-	file = open_with_fake_path(&path, O_RDWR | O_LARGEFILE | O_DIRECT,
-				   d_backing_inode(dentry), cache->cache_cred);
+	file = kernel_file_open(&path, O_RDWR | O_LARGEFILE | O_DIRECT,
+				d_backing_inode(dentry), cache->cache_cred);
 	if (IS_ERR(file)) {
 		trace_cachefiles_vfs_error(object, d_backing_inode(dentry),
 					   PTR_ERR(file),
diff --git a/fs/namei.c b/fs/namei.c
index e4fe0879ae55..36e335c39c44 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3703,7 +3703,7 @@ static int vfs_tmpfile(struct mnt_idmap *idmap,
 }
 
 /**
- * vfs_tmpfile_open - open a tmpfile for kernel internal use
+ * kernel_tmpfile_open - open a tmpfile for kernel internal use
  * @idmap:	idmap of the mount the inode was found from
  * @parentpath:	path of the base directory
  * @mode:	mode of the new tmpfile
@@ -3714,24 +3714,26 @@ static int vfs_tmpfile(struct mnt_idmap *idmap,
  * hence this is only for kernel internal use, and must not be installed into
  * file tables or such.
  */
-struct file *vfs_tmpfile_open(struct mnt_idmap *idmap,
-			  const struct path *parentpath,
-			  umode_t mode, int open_flag, const struct cred *cred)
+struct file *kernel_tmpfile_open(struct mnt_idmap *idmap,
+				 const struct path *parentpath,
+				 umode_t mode, int open_flag,
+				 const struct cred *cred)
 {
 	struct file *file;
 	int error;
 
 	file = alloc_empty_file_noaccount(open_flag, cred);
-	if (!IS_ERR(file)) {
-		error = vfs_tmpfile(idmap, parentpath, file, mode);
-		if (error) {
-			fput(file);
-			file = ERR_PTR(error);
-		}
+	if (IS_ERR(file))
+		return file;
+
+	error = vfs_tmpfile(idmap, parentpath, file, mode);
+	if (error) {
+		fput(file);
+		file = ERR_PTR(error);
 	}
 	return file;
 }
-EXPORT_SYMBOL(vfs_tmpfile_open);
+EXPORT_SYMBOL(kernel_tmpfile_open);
 
 static int do_tmpfile(struct nameidata *nd, unsigned flags,
 		const struct open_flags *op,
diff --git a/fs/open.c b/fs/open.c
index 005ca91a173b..c3491ecd9ae8 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1121,6 +1121,37 @@ struct file *dentry_create(const struct path *path, int flags, umode_t mode,
 }
 EXPORT_SYMBOL(dentry_create);
 
+/**
+ * kernel_file_open - open a file for kernel internal use
+ * @path:	path of the file to open
+ * @flags:	open flags
+ * @inode:	the inode
+ * @cred:	credentials for open
+ *
+ * Open a file that is not accounted in nr_files.
+ * This is only for kernel internal use, and must not be installed into
+ * file tables or such.
+ */
+struct file *kernel_file_open(const struct path *path, int flags,
+				struct inode *inode, const struct cred *cred)
+{
+	struct file *f;
+	int error;
+
+	f = alloc_empty_file_noaccount(flags, cred);
+	if (IS_ERR(f))
+		return f;
+
+	f->f_path = *path;
+	error = do_dentry_open(f, inode, NULL);
+	if (error) {
+		fput(f);
+		f = ERR_PTR(error);
+	}
+	return f;
+}
+EXPORT_SYMBOL(kernel_file_open);
+
 struct file *open_with_fake_path(const struct path *path, int flags,
 				struct inode *inode, const struct cred *cred)
 {
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index fcac4e2c56ab..6129f0984cf7 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -329,8 +329,9 @@ static inline struct file *ovl_do_tmpfile(struct ovl_fs *ofs,
 					  struct dentry *dentry, umode_t mode)
 {
 	struct path path = { .mnt = ovl_upper_mnt(ofs), .dentry = dentry };
-	struct file *file = vfs_tmpfile_open(ovl_upper_mnt_idmap(ofs), &path, mode,
-					O_LARGEFILE | O_WRONLY, current_cred());
+	struct file *file = kernel_tmpfile_open(ovl_upper_mnt_idmap(ofs), &path,
+						mode, O_LARGEFILE | O_WRONLY,
+						current_cred());
 	int err = PTR_ERR_OR_ZERO(file);
 
 	pr_debug("tmpfile(%pd2, 0%o) = %i\n", dentry, mode, err);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 21a981680856..1f8486e773af 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1672,9 +1672,12 @@ static inline int vfs_whiteout(struct mnt_idmap *idmap,
 			 WHITEOUT_DEV);
 }
 
-struct file *vfs_tmpfile_open(struct mnt_idmap *idmap,
-			const struct path *parentpath,
-			umode_t mode, int open_flag, const struct cred *cred);
+struct file *kernel_tmpfile_open(struct mnt_idmap *idmap,
+				 const struct path *parentpath,
+				 umode_t mode, int open_flag,
+				 const struct cred *cred);
+struct file *kernel_file_open(const struct path *path, int flags,
+			      struct inode *inode, const struct cred *cred);
 
 int vfs_mkobj(struct dentry *, umode_t,
 		int (*f)(struct dentry *, umode_t, void *),
-- 
2.34.1

