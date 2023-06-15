Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9D5731669
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 13:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343689AbjFOLWq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 07:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238757AbjFOLWn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:22:43 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFAB2686;
        Thu, 15 Jun 2023 04:22:41 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f845060481so581161e87.3;
        Thu, 15 Jun 2023 04:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686828160; x=1689420160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iz55YEDhZSQAJy1WP1lUS5sASqcog3e5bJ4dVl61ol4=;
        b=Me78j7HyyaIuYx5qNwYhNtPhRItvU5WagepUmrZZzv5H1QLCTD3KoZEhYPBMxpsL6I
         cENHj6pucXHF9f8z/mOamp/yVBSJB2mgrHqweoC/4rXqI2lKPwleWQJt2UnvzkAX5IXy
         Kqra66joxh+SLOU19juByd2MLIJglPW/9/mAb3Qia6xd0orlC+PoEZooDQ/qxuwR6BRf
         QEgXjKW4pVnHwQMX/YNodPLEyoqTwvNqFU8LjWaNYsV/OLBYbbQbaJ0bdRyUvjbthN0V
         rBqJIoqjbSwRoM5fnmAgO5vlh5X/Xqsvt9R5LASn9w7xN9jMMieIwOGBdqlX9Uic1eJf
         lrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686828160; x=1689420160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iz55YEDhZSQAJy1WP1lUS5sASqcog3e5bJ4dVl61ol4=;
        b=I+VUbJwbFooMnJy00/u4ZtR05RTNDZ2fkuQNMUwlyqvFCycktvMHk5Z/Eb5OC6wKJT
         ddhBs6ulXy7bvae7oG9oOIeCaOgUrQ2RjzvCdvS+fRQpE78QyeHOKRwESx8DAmcaopJJ
         4UsEh2ISZkU+wKQqbq9H/LXLythteUISGcmm9CMSmTNHudSXAu6ERihje5IigN/Uf7QE
         n5s25GeSkUFffiQ+fsipmYS489+AosdFEWm37XvVFAjT91Zx20ItC8tjIrNVQOkNOSu1
         qcgMvH7CxRLrPbrX2exktXEsN79VEkmxQ/AnKnkbnZgFveoIjyPKoJdoxnaVpeNuQU3q
         y4Bw==
X-Gm-Message-State: AC+VfDydXjk1ExnjTt2FXqOKGkBcnlpco4bjWvQOmtjiGSzyOWFIP9OM
        pkC8PANxJz3EMV7HyxSjAIA=
X-Google-Smtp-Source: ACHHUZ4DVThAH1Pg8cBHdrvgjz/yGyoVBUhKCs81UGTk7XQozGuUFHOW6YMVMDZYKfNROGxPnB/TZw==
X-Received: by 2002:a05:6512:54a:b0:4f4:ba0d:3bbf with SMTP id h10-20020a056512054a00b004f4ba0d3bbfmr9404400lfl.60.1686828159925;
        Thu, 15 Jun 2023 04:22:39 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id h25-20020a197019000000b004f80f03d990sm355089lfc.259.2023.06.15.04.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 04:22:39 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH v5 1/5] fs: rename {vfs,kernel}_tmpfile_open()
Date:   Thu, 15 Jun 2023 14:22:25 +0300
Message-Id: <20230615112229.2143178-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230615112229.2143178-1-amir73il@gmail.com>
References: <20230615112229.2143178-1-amir73il@gmail.com>
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

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/cachefiles/namei.c    |  6 +++---
 fs/namei.c               | 24 +++++++++++++-----------
 fs/overlayfs/overlayfs.h |  5 +++--
 include/linux/fs.h       |  7 ++++---
 4 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 82219a8f6084..6c7d4e97c219 100644
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
index 21a981680856..62237beeac2a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1672,9 +1672,10 @@ static inline int vfs_whiteout(struct mnt_idmap *idmap,
 			 WHITEOUT_DEV);
 }
 
-struct file *vfs_tmpfile_open(struct mnt_idmap *idmap,
-			const struct path *parentpath,
-			umode_t mode, int open_flag, const struct cred *cred);
+struct file *kernel_tmpfile_open(struct mnt_idmap *idmap,
+				 const struct path *parentpath,
+				 umode_t mode, int open_flag,
+				 const struct cred *cred);
 
 int vfs_mkobj(struct dentry *, umode_t,
 		int (*f)(struct dentry *, umode_t, void *),
-- 
2.34.1

