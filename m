Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7D631B481
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 05:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhBOEZM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Feb 2021 23:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhBOEZJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Feb 2021 23:25:09 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EE1C061574;
        Sun, 14 Feb 2021 20:24:29 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id gb24so2977013pjb.4;
        Sun, 14 Feb 2021 20:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dc52RJMFGbh/YC/FYB6BFalirRTnRGBAM9OW4sOUqhU=;
        b=QpCTEjvTHOy+X8eXZRXePyxISqjTEjIZXlCEeG5xmKNx5YnqVTSBtHB4LwB6VQQdmv
         pH9Kwzb+0C4GR3XpRIDKmv3RGU5eWuHgY990xwZrrSFMqxwwjSTeml4FLwF4x2YqQJil
         bcPfKnuzJiBDOYct9rl1s9oLk3chZXCyF22zkyVltyFY6hHNo+1NQ38/0Nl1KoIuSLSh
         sZa//odgi7NmnXeTutmCMPYu0jzfKELbFn8orhCzP0U7pm1HHVUTYDxDZw14G7kn8/Ds
         FjfYfDH8ZwRgKZTiOPqGlS2o3PpAkuYpoWulmVHFQ1mMIfApKkmIMpcaqzRkKxxW8SBH
         fKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dc52RJMFGbh/YC/FYB6BFalirRTnRGBAM9OW4sOUqhU=;
        b=nt3FprELCkPdAoEs5GL3aE7deBfmNZ5lQQFLPqRmwR+hFFz0Kn7GttTGNeg2Gmk8Is
         vdKU00uFNex6HI6kgzh8I3SwX9ERRzKptibGLgALgVnc0zPGsbrEXJTZ+LaGlEHRG7FQ
         0yVSeEQMB7/OiUEG9XWBVDEiK0b74+7064saFRFMQi6UjkVRw86xBSnXxiMB//PddGsv
         X5kty+rhBBgqx9XNiTPzS4iLN3O+QOAqnNNneNoOA031TxPO4LTSXPXh9ihKgNaJcKvd
         aCYRNl0PsiJtTqAOnUYUoGKk1af66WIWHZ85czY4Hv0CbQ/NGOl0D9S1oGFn9qJEUwff
         Av8Q==
X-Gm-Message-State: AOAM532xw4xfAXVWt1EYrkoYiXNRFjF62bX2PC35DB/PDiNBsL0XITq1
        z8diOv4Yp4LilapxWdp8cHc=
X-Google-Smtp-Source: ABdhPJxjLufyHDD+idZExaMH5kuNoeMudAhe315XTqyYUGcdIbh4IoQPWVdZep7M0tSH1MeCqoaRVw==
X-Received: by 2002:a17:902:a3c7:b029:e3:3827:d7e6 with SMTP id q7-20020a170902a3c7b02900e33827d7e6mr8728000plb.66.1613363068937;
        Sun, 14 Feb 2021 20:24:28 -0800 (PST)
Received: from localhost.localdomain ([27.122.242.75])
        by smtp.gmail.com with ESMTPSA id o135sm15768241pfg.21.2021.02.14.20.24.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Feb 2021 20:24:28 -0800 (PST)
From:   Hyeongseok Kim <hyeongseok@gmail.com>
To:     namjae.jeon@samsung.com, sj1557.seo@samsung.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hyeongseok Kim <hyeongseok@gmail.com>
Subject: [PATCH 1/2] exfat: add initial ioctl function
Date:   Mon, 15 Feb 2021 13:24:10 +0900
Message-Id: <20210215042411.119392-1-hyeongseok@gmail.com>
X-Mailer: git-send-email 2.27.0.83.g0313f36
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Initialize empty ioctl function

Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>
---
 fs/exfat/dir.c      |  5 +++++
 fs/exfat/exfat_fs.h |  3 +++
 fs/exfat/file.c     | 21 +++++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 916797077aad..e1d5536de948 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/slab.h>
+#include <linux/compat.h>
 #include <linux/bio.h>
 #include <linux/buffer_head.h>
 
@@ -306,6 +307,10 @@ const struct file_operations exfat_dir_operations = {
 	.llseek		= generic_file_llseek,
 	.read		= generic_read_dir,
 	.iterate	= exfat_iterate,
+	.unlocked_ioctl = exfat_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = exfat_compat_ioctl,
+#endif
 	.fsync		= exfat_file_fsync,
 };
 
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 764bc645241e..a183021ae31d 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -420,6 +420,9 @@ int exfat_setattr(struct dentry *dentry, struct iattr *attr);
 int exfat_getattr(const struct path *path, struct kstat *stat,
 		unsigned int request_mask, unsigned int query_flags);
 int exfat_file_fsync(struct file *file, loff_t start, loff_t end, int datasync);
+long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
+long exfat_compat_ioctl(struct file *filp, unsigned int cmd,
+				unsigned long arg);
 
 /* namei.c */
 extern const struct dentry_operations exfat_dentry_ops;
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index a92478eabfa4..679828e7be07 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/slab.h>
+#include <linux/compat.h>
 #include <linux/cred.h>
 #include <linux/buffer_head.h>
 #include <linux/blkdev.h>
@@ -348,6 +349,22 @@ int exfat_setattr(struct dentry *dentry, struct iattr *attr)
 	return error;
 }
 
+long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	default:
+		return -ENOTTY;
+	}
+}
+
+#ifdef CONFIG_COMPAT
+long exfat_compat_ioctl(struct file *filp, unsigned int cmd,
+				unsigned long arg)
+{
+	return exfat_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
+}
+#endif
+
 int exfat_file_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
 {
 	struct inode *inode = filp->f_mapping->host;
@@ -368,6 +385,10 @@ const struct file_operations exfat_file_operations = {
 	.llseek		= generic_file_llseek,
 	.read_iter	= generic_file_read_iter,
 	.write_iter	= generic_file_write_iter,
+	.unlocked_ioctl = exfat_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = exfat_compat_ioctl,
+#endif
 	.mmap		= generic_file_mmap,
 	.fsync		= exfat_file_fsync,
 	.splice_read	= generic_file_splice_read,
-- 
2.27.0.83.g0313f36

