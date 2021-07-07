Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B533BE7E0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 14:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhGGMar (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 08:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbhGGMap (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 08:30:45 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F1CC061574;
        Wed,  7 Jul 2021 05:28:04 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id eb14so3210659edb.0;
        Wed, 07 Jul 2021 05:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AVmhH06SyxapkboM9opDUcgHzjT4U95zTavxicpRMho=;
        b=upSE5yHeww4HYoM4+pKocF9Ozos+dJsjmaO8raWLPMqfOLhsRAHz9+pmSXt9uEJG2R
         3vR12lBfOT5VDruqdMiyQMNNyeK1jTUgyNz1BF2fJ/OxDJWYw2BjGjqqB82ujAXXjYeV
         KNwe+ZBE4zTlpmxaqQHxlvGfVKpTAoYhyjbqf/9qKFZ9dpPykXDW9LdZiFVSFe7eQOpG
         lIWeHY9Tny1hInHaV9peiyPWcBK9H/8VHu2xARKeyjN+Oqg6fLOxknB+WFAvdWFcQIkT
         46dzuJBVvI1xyqt3S/gUZosAuvfKEb1MOCxuraAxO/2E9CPNjRSy79rm5xWXPkTJZnFV
         ZFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AVmhH06SyxapkboM9opDUcgHzjT4U95zTavxicpRMho=;
        b=mOKz/yriFlV5u+Kstu4F+4N/iVEAnSfPLNuB+v9aq9FIylbcUcGqPNacIUhnGM+GBU
         LT+g/NldJ7HSkHK3bFw8BKZv3UO0QV68k7CoSLt9qPqSq3We0QE/cpszcQEGqLjtZ3XN
         PxIZtTnywmVZSYblPpIIm+xQGHA0IuaHT94tUt0mUMmNli+4FrovVC0kTCiOy58YSlLv
         eYvXE+sB0nXsPzar0IyNMhFK75097Z+DHVT/NwVyy26YUYjcsqV5wWrMySae4sWmzyLS
         3BaUVZG6C3yXiQ/H4gLDx3E7+V0BzVYHqd/zu946FD+nGqXkHFyE5Fbi+OJtZvGyYgo/
         GPcg==
X-Gm-Message-State: AOAM532XzNdGFSICEvZOFgudaD6voeIdFnWyHHMbXyngL6i2aADFdZwv
        SquWpgYwnM8nCu22VrBQZ1M=
X-Google-Smtp-Source: ABdhPJz14fWXGBr6W6ANjeyi6Bo2zhMknAhJyMQwACPDlw9Fgb+M4UZt32B2LjZ00/rP9WXmoqVqaA==
X-Received: by 2002:a05:6402:10cc:: with SMTP id p12mr30196655edu.328.1625660883283;
        Wed, 07 Jul 2021 05:28:03 -0700 (PDT)
Received: from carbon.v ([108.61.166.58])
        by smtp.googlemail.com with ESMTPSA id ze15sm7019821ejb.79.2021.07.07.05.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 05:28:03 -0700 (PDT)
From:   Dmitry Kadashev <dkadashev@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        Dmitry Kadashev <dkadashev@gmail.com>
Subject: [PATCH v8 03/11] fs: make do_mkdirat() take struct filename
Date:   Wed,  7 Jul 2021 19:27:39 +0700
Message-Id: <20210707122747.3292388-4-dkadashev@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210707122747.3292388-1-dkadashev@gmail.com>
References: <20210707122747.3292388-1-dkadashev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pass in the struct filename pointers instead of the user string, and
update the three callers to do the same. This is heavily based on
commit dbea8d345177 ("fs: make do_renameat2() take struct filename").

This behaves like do_unlinkat() and do_renameat2().

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dmitry Kadashev <dkadashev@gmail.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/internal.h |  1 +
 fs/namei.c    | 26 +++++++++++++++++++-------
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 6aeae7ef3380..848e165ef0f1 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -77,6 +77,7 @@ long do_unlinkat(int dfd, struct filename *name);
 int may_linkat(struct user_namespace *mnt_userns, struct path *link);
 int do_renameat2(int olddfd, struct filename *oldname, int newdfd,
 		 struct filename *newname, unsigned int flags);
+long do_mkdirat(int dfd, struct filename *name, umode_t mode);
 
 /*
  * namespace.c
diff --git a/fs/namei.c b/fs/namei.c
index 2995b3695724..54d5f19ee1ce 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3563,7 +3563,7 @@ struct file *do_file_open_root(struct dentry *dentry, struct vfsmount *mnt,
 	return file;
 }
 
-static struct dentry *filename_create(int dfd, struct filename *name,
+static struct dentry *__filename_create(int dfd, struct filename *name,
 				struct path *path, unsigned int lookup_flags)
 {
 	struct dentry *dentry = ERR_PTR(-EEXIST);
@@ -3579,7 +3579,7 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	 */
 	lookup_flags &= LOOKUP_REVAL;
 
-	error = filename_parentat(dfd, name, lookup_flags, path, &last, &type);
+	error = __filename_parentat(dfd, name, lookup_flags, path, &last, &type);
 	if (error)
 		return ERR_PTR(error);
 
@@ -3632,6 +3632,15 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	return dentry;
 }
 
+static inline struct dentry *filename_create(int dfd, struct filename *name,
+				struct path *path, unsigned int lookup_flags)
+{
+	struct dentry *res = __filename_create(dfd, name, path, lookup_flags);
+
+	putname(name);
+	return res;
+}
+
 struct dentry *kern_path_create(int dfd, const char *pathname,
 				struct path *path, unsigned int lookup_flags)
 {
@@ -3822,7 +3831,7 @@ int vfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 }
 EXPORT_SYMBOL(vfs_mkdir);
 
-static long do_mkdirat(int dfd, const char __user *pathname, umode_t mode)
+long do_mkdirat(int dfd, struct filename *name, umode_t mode)
 {
 	struct dentry *dentry;
 	struct path path;
@@ -3830,9 +3839,10 @@ static long do_mkdirat(int dfd, const char __user *pathname, umode_t mode)
 	unsigned int lookup_flags = LOOKUP_DIRECTORY;
 
 retry:
-	dentry = user_path_create(dfd, pathname, &path, lookup_flags);
+	dentry = __filename_create(dfd, name, &path, lookup_flags);
+	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
-		return PTR_ERR(dentry);
+		goto out_putname;
 
 	if (!IS_POSIXACL(path.dentry->d_inode))
 		mode &= ~current_umask();
@@ -3848,17 +3858,19 @@ static long do_mkdirat(int dfd, const char __user *pathname, umode_t mode)
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
 	}
+out_putname:
+	putname(name);
 	return error;
 }
 
 SYSCALL_DEFINE3(mkdirat, int, dfd, const char __user *, pathname, umode_t, mode)
 {
-	return do_mkdirat(dfd, pathname, mode);
+	return do_mkdirat(dfd, getname(pathname), mode);
 }
 
 SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
 {
-	return do_mkdirat(AT_FDCWD, pathname, mode);
+	return do_mkdirat(AT_FDCWD, getname(pathname), mode);
 }
 
 /**
-- 
2.30.2

