Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA941A3BEC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 23:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgDIV3F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 17:29:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54404 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgDIV3F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 17:29:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id h2so305124wmb.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2020 14:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=GbAjGLPH5W6Xrx6ToG1Km3nryBoclhWpP1OORBAYGjc=;
        b=AX1iricMFhET7GDItWca0Om4sxX4CrnBIdj6QoOSsexVULSvzVF3pyXHgOEqSBqfaW
         JmBe85H+hZBv6+GqAvhYNTXXQEImz5qTRFfN8KH+RkpSWpXZ8onZF6jtb9Q3dj+ppGR7
         tb3Yj8tTVk8AswKSVG8XRbNtJpPevdO/7uHls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=GbAjGLPH5W6Xrx6ToG1Km3nryBoclhWpP1OORBAYGjc=;
        b=GlZTSbqGE862HYzclnuxznJPKyD6vVHHE3z6eEL8Yr2I+ysqB6cX8nO1iesodq6OGP
         Mj8ZOQVQUOIrLueFK5IzXWuM6oVJOyj/E1r2s77oA5t8tlzV3rh8fS0cArInliBtWemJ
         +5g1zTPAktK8hsAthPmhk1v4UY+yOs4D/gfIHNRzezathJAd7XsQ1Z3WnK+rNuRWot8m
         F/w5I1QNhlHuS0giVJutaOSmVKFtGMq+pCOLecRqjpsnKHsdg8AbJXITBvbLXe98jyv9
         i+l+QPQQ4TwEB2c71PIAH6HxOHzauTFVxfFTA5H5K4/9tJObfT/31JMY8zoqqHktHglj
         crow==
X-Gm-Message-State: AGi0PuahFt8bPUt2FuQcsPHJjLKNksz9Vhn32GGFiAHu2Yrmi18421kL
        ILR3y2Yg7cQ3eLJqVFeqFpGhNQ==
X-Google-Smtp-Source: APiQypL4loUhzCA+KdllpDFKqcly8Xu9FMORvdP09QKUSKWlI/qBKwwmiOOkoJke0W3AudkIDIBp3g==
X-Received: by 2002:a05:600c:290f:: with SMTP id i15mr1647044wmd.167.1586467742477;
        Thu, 09 Apr 2020 14:29:02 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id h26sm5181037wmb.19.2020.04.09.14.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 14:29:01 -0700 (PDT)
Date:   Thu, 9 Apr 2020 23:28:59 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] vfs: allow unprivileged whiteout creation
Message-ID: <20200409212859.GH28467@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Miklos Szeredi <mszeredi@redhat.com>

Whiteouts, unlike real device node should not require privileges to create.

The general concern with device nodes is that opening them can have side
effects.  The kernel already avoids zero major (see
Documentation/admin-guide/devices.txt).  To be on the safe side the patch
explicitly forbids registering a char device with 0/0 number (see
cdev_add()).

This guarantees that a non-O_PATH open on a whiteout will fail with ENODEV;
i.e. it won't have any side effect.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/char_dev.c                 |    3 +++
 fs/namei.c                    |   17 ++++-------------
 include/linux/device_cgroup.h |    3 +++
 3 files changed, 10 insertions(+), 13 deletions(-)

--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -483,6 +483,9 @@ int cdev_add(struct cdev *p, dev_t dev,
 	p->dev = dev;
 	p->count = count;
 
+	if (WARN_ON(dev == WHITEOUT_DEV))
+		return -EBUSY;
+
 	error = kobj_map(cdev_map, dev, count, NULL,
 			 exact_match, exact_lock, p);
 	if (error)
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3505,12 +3505,14 @@ EXPORT_SYMBOL(user_path_create);
 
 int vfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
 {
+	bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
 	int error = may_create(dir, dentry);
 
 	if (error)
 		return error;
 
-	if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD))
+	if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD) &&
+	    !is_whiteout)
 		return -EPERM;
 
 	if (!dir->i_op->mknod)
@@ -4345,9 +4347,6 @@ static int do_renameat2(int olddfd, cons
 	    (flags & RENAME_EXCHANGE))
 		return -EINVAL;
 
-	if ((flags & RENAME_WHITEOUT) && !capable(CAP_MKNOD))
-		return -EPERM;
-
 	if (flags & RENAME_EXCHANGE)
 		target_flags = 0;
 
@@ -4485,15 +4484,7 @@ SYSCALL_DEFINE2(rename, const char __use
 
 int vfs_whiteout(struct inode *dir, struct dentry *dentry)
 {
-	int error = may_create(dir, dentry);
-	if (error)
-		return error;
-
-	if (!dir->i_op->mknod)
-		return -EPERM;
-
-	return dir->i_op->mknod(dir, dentry,
-				S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV);
+	return vfs_mknod(dir, dentry, S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV);
 }
 EXPORT_SYMBOL(vfs_whiteout);
 
--- a/include/linux/device_cgroup.h
+++ b/include/linux/device_cgroup.h
@@ -51,6 +51,9 @@ static inline int devcgroup_inode_mknod(
 	if (!S_ISBLK(mode) && !S_ISCHR(mode))
 		return 0;
 
+	if (S_ISCHR(mode) && dev == WHITEOUT_DEV)
+		return 0;
+
 	if (S_ISBLK(mode))
 		type = DEVCG_DEV_BLOCK;
 	else
