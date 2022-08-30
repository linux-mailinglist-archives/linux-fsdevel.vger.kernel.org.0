Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67B95A6769
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 17:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiH3P3R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 11:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiH3P3O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:29:14 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2D2ABF06;
        Tue, 30 Aug 2022 08:29:11 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id nc14so18006671ejc.4;
        Tue, 30 Aug 2022 08:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=M1HXwyEcd++E/R6zgxghv02STU/J6NrnltrFeRQx87w=;
        b=YfZ5Li5sJwcBJfPpYw/yBBGFDNq6tSEVPW8FZHuBhSdlOUfX0vC1fjiuEapCBM+c9d
         bheNE9OFppJvQ73vGPimlBE/9hB0JDT6nlCwhbWItuR9jJjjDHBeDixcH+Wmz/R0mf2x
         Nn9tqn90FJYuCNn1WGu9pP1n/+4EsI2xZasBWu+PxINY4S5VxOsjKra2SNrM9aexqtP1
         WEFT+zIdug+LmYW8wBhvNaZ1WSlHs7CHH/tsE1dVXOvwiTjFaFf1YTv1l0Fwm9LlKWxH
         KSEOkPh15sdTRrn34Y6gV7X8DQFSAAEUNKNwJEC1ly0ryYvbLzTdx9lZy6s4MgG6jV1Q
         lpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=M1HXwyEcd++E/R6zgxghv02STU/J6NrnltrFeRQx87w=;
        b=tk8aLNKGBvQ74+UdkaLXgbXhTg9JATfzqYpbCd6nhkJTJt4JiFzl97BxFlrZdSjA1m
         Yys95BAoDwATDstbsdNkfaBs2p3iSh1Na1Rz4qbBhACi3V4QWFO0NEe8pcYRURAU2rS5
         /vnCgSkowiuDvW5Byx9EkY0IRcJvVEq0zKGBUlOYPukd8ZibgYbQeJfhSGpQyksfN2v+
         BzKdFxQgbYvioPda7so8wVfUayj823zC/whs7uwrW05kxn0GpDJQJVM8xSYilCjDeCYw
         8yDDxq8RwEn9Ak99J83n6S+NQUD/4VLH8tl4/iFMtv+m0zVh6Bj71RTeAR0i83/nHgHX
         ojzw==
X-Gm-Message-State: ACgBeo0jm8Jr04VVgayq1lb4dqoRPQg/WQWwGAhiJSboo76Ry744bMkh
        zfQHVklxy80/CBM51GXlSDqqB4NP17eCTA==
X-Google-Smtp-Source: AA6agR6ubcU1uGb6eduHiWHHyoGSQiQMVybPDJFmh2DMJnGtu0AKMknMqCN3iS7P/OowMSPdZOtpQg==
X-Received: by 2002:a17:907:2723:b0:741:4fbf:4658 with SMTP id d3-20020a170907272300b007414fbf4658mr9904118ejl.424.1661873350066;
        Tue, 30 Aug 2022 08:29:10 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-163-172.95.116.pool.telefonica.de. [95.116.163.172])
        by smtp.gmail.com with ESMTPSA id t19-20020a056402525300b00445bda73fbesm5473947edd.33.2022.08.30.08.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 08:29:09 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] fs/xattr: add *at family syscalls
Date:   Tue, 30 Aug 2022 17:28:39 +0200
Message-Id: <20220830152858.14866-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830152858.14866-1-cgzones@googlemail.com>
References: <20220830152858.14866-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add the four syscalls setxattrat(), getxattrat(), listxattrat() and
removexattrat() to enable extended attribute operations via file
descriptors.  This can be used from userspace to avoid race conditions,
especially on security related extended attributes, like SELinux labels
("security.selinux") via setfiles(8).

Use the do_{name}at() pattern from fs/open.c.
Use a single flag parameter for extended attribute flags (currently
XATTR_CREATE and XATTR_REPLACE) and *at() flags to not exceed six
syscall arguments in setxattrat().

Previous discussion ("f*xattr: allow O_PATH descriptors"): https://lore.kernel.org/all/20220607153139.35588-1-cgzones@googlemail.com/

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 fs/xattr.c | 108 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 85 insertions(+), 23 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index a1f4998bc6be..a4738e28be8c 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -27,6 +27,8 @@
 
 #include "internal.h"
 
+#define XATTR__FLAGS (XATTR_CREATE | XATTR_REPLACE)
+
 static const char *
 strcmp_prefix(const char *a, const char *a_prefix)
 {
@@ -559,7 +561,7 @@ int setxattr_copy(const char __user *name, struct xattr_ctx *ctx)
 {
 	int error;
 
-	if (ctx->flags & ~(XATTR_CREATE|XATTR_REPLACE))
+	if (ctx->flags & ~XATTR__FLAGS)
 		return -EINVAL;
 
 	error = strncpy_from_user(ctx->kname->name, name,
@@ -626,21 +628,31 @@ setxattr(struct user_namespace *mnt_userns, struct dentry *d,
 	return error;
 }
 
-static int path_setxattr(const char __user *pathname,
+static int do_setxattrat(int dfd, const char __user *pathname,
 			 const char __user *name, const void __user *value,
-			 size_t size, int flags, unsigned int lookup_flags)
+			 size_t size, int flags)
 {
 	struct path path;
 	int error;
+	int lookup_flags;
+
+	/* AT_ and XATTR_ flags must not overlap. */
+	BUILD_BUG_ON(((AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH) & XATTR__FLAGS) != 0);
+
+	if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH | XATTR__FLAGS)) != 0)
+		return -EINVAL;
 
+	lookup_flags = (flags & AT_SYMLINK_NOFOLLOW) ? 0 : LOOKUP_FOLLOW;
+	if (flags & AT_EMPTY_PATH)
+		lookup_flags |= LOOKUP_EMPTY;
 retry:
-	error = user_path_at(AT_FDCWD, pathname, lookup_flags, &path);
+	error = user_path_at(dfd, pathname, lookup_flags, &path);
 	if (error)
 		return error;
 	error = mnt_want_write(path.mnt);
 	if (!error) {
 		error = setxattr(mnt_user_ns(path.mnt), path.dentry, name,
-				 value, size, flags);
+				 value, size, flags & XATTR__FLAGS);
 		mnt_drop_write(path.mnt);
 	}
 	path_put(&path);
@@ -651,18 +663,25 @@ static int path_setxattr(const char __user *pathname,
 	return error;
 }
 
+SYSCALL_DEFINE6(setxattrat, int, dfd, const char __user *, pathname,
+		const char __user *, name, const void __user *, value,
+		size_t, size, int, flags)
+{
+	return do_setxattrat(dfd, pathname, name, value, size, flags);
+}
+
 SYSCALL_DEFINE5(setxattr, const char __user *, pathname,
 		const char __user *, name, const void __user *, value,
 		size_t, size, int, flags)
 {
-	return path_setxattr(pathname, name, value, size, flags, LOOKUP_FOLLOW);
+	return do_setxattrat(AT_FDCWD, pathname, name, value, size, flags);
 }
 
 SYSCALL_DEFINE5(lsetxattr, const char __user *, pathname,
 		const char __user *, name, const void __user *, value,
 		size_t, size, int, flags)
 {
-	return path_setxattr(pathname, name, value, size, flags, 0);
+	return do_setxattrat(AT_FDCWD, pathname, name, value, size, flags | AT_SYMLINK_NOFOLLOW);
 }
 
 SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
@@ -745,14 +764,22 @@ getxattr(struct user_namespace *mnt_userns, struct dentry *d,
 	return error;
 }
 
-static ssize_t path_getxattr(const char __user *pathname,
+static ssize_t do_getxattrat(int dfd, const char __user *pathname,
 			     const char __user *name, void __user *value,
-			     size_t size, unsigned int lookup_flags)
+			     size_t size, int flags)
 {
 	struct path path;
 	ssize_t error;
+	int lookup_flags;
+
+	if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
+		return -EINVAL;
+
+	lookup_flags = (flags & AT_SYMLINK_NOFOLLOW) ? 0 : LOOKUP_FOLLOW;
+	if (flags & AT_EMPTY_PATH)
+		lookup_flags |= LOOKUP_EMPTY;
 retry:
-	error = user_path_at(AT_FDCWD, pathname, lookup_flags, &path);
+	error = user_path_at(dfd, pathname, lookup_flags, &path);
 	if (error)
 		return error;
 	error = getxattr(mnt_user_ns(path.mnt), path.dentry, name, value, size);
@@ -764,16 +791,23 @@ static ssize_t path_getxattr(const char __user *pathname,
 	return error;
 }
 
+SYSCALL_DEFINE6(getxattrat, int, dfd, const char __user *, pathname,
+		const char __user *, name, void __user *, value, size_t, size,
+		int, flags)
+{
+	return do_getxattrat(dfd, pathname, name, value, size, flags);
+}
+
 SYSCALL_DEFINE4(getxattr, const char __user *, pathname,
 		const char __user *, name, void __user *, value, size_t, size)
 {
-	return path_getxattr(pathname, name, value, size, LOOKUP_FOLLOW);
+	return do_getxattrat(AT_FDCWD, pathname, name, value, size, 0);
 }
 
 SYSCALL_DEFINE4(lgetxattr, const char __user *, pathname,
 		const char __user *, name, void __user *, value, size_t, size)
 {
-	return path_getxattr(pathname, name, value, size, 0);
+	return do_getxattrat(AT_FDCWD, pathname, name, value, size, AT_SYMLINK_NOFOLLOW);
 }
 
 SYSCALL_DEFINE4(fgetxattr, int, fd, const char __user *, name,
@@ -823,13 +857,21 @@ listxattr(struct dentry *d, char __user *list, size_t size)
 	return error;
 }
 
-static ssize_t path_listxattr(const char __user *pathname, char __user *list,
-			      size_t size, unsigned int lookup_flags)
+static ssize_t do_listxattrat(int dfd, const char __user *pathname, char __user *list,
+			      size_t size, int flags)
 {
 	struct path path;
 	ssize_t error;
+	int lookup_flags;
+
+	if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
+		return -EINVAL;
+
+	lookup_flags = (flags & AT_SYMLINK_NOFOLLOW) ? 0 : LOOKUP_FOLLOW;
+	if (flags & AT_EMPTY_PATH)
+		lookup_flags |= LOOKUP_EMPTY;
 retry:
-	error = user_path_at(AT_FDCWD, pathname, lookup_flags, &path);
+	error = user_path_at(dfd, pathname, lookup_flags, &path);
 	if (error)
 		return error;
 	error = listxattr(path.dentry, list, size);
@@ -841,16 +883,22 @@ static ssize_t path_listxattr(const char __user *pathname, char __user *list,
 	return error;
 }
 
+SYSCALL_DEFINE5(listxattrat, int, dfd, const char __user *, pathname, char __user *, list,
+		size_t, size, int, flags)
+{
+	return do_listxattrat(dfd, pathname, list, size, flags);
+}
+
 SYSCALL_DEFINE3(listxattr, const char __user *, pathname, char __user *, list,
 		size_t, size)
 {
-	return path_listxattr(pathname, list, size, LOOKUP_FOLLOW);
+	return do_listxattrat(AT_FDCWD, pathname, list, size, 0);
 }
 
 SYSCALL_DEFINE3(llistxattr, const char __user *, pathname, char __user *, list,
 		size_t, size)
 {
-	return path_listxattr(pathname, list, size, 0);
+	return do_listxattrat(AT_FDCWD, pathname, list, size, AT_SYMLINK_NOFOLLOW);
 }
 
 SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, list, size_t, size)
@@ -869,7 +917,7 @@ SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, list, size_t, size)
 /*
  * Extended attribute REMOVE operations
  */
-static long
+static int
 removexattr(struct user_namespace *mnt_userns, struct dentry *d,
 	    const char __user *name)
 {
@@ -885,13 +933,21 @@ removexattr(struct user_namespace *mnt_userns, struct dentry *d,
 	return vfs_removexattr(mnt_userns, d, kname);
 }
 
-static int path_removexattr(const char __user *pathname,
-			    const char __user *name, unsigned int lookup_flags)
+static int do_removexattrat(int dfd, const char __user *pathname,
+			    const char __user *name, int flags)
 {
 	struct path path;
 	int error;
+	int lookup_flags;
+
+	if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
+		return -EINVAL;
+
+	lookup_flags = (flags & AT_SYMLINK_NOFOLLOW) ? 0 : LOOKUP_FOLLOW;
+	if (flags & AT_EMPTY_PATH)
+		lookup_flags |= LOOKUP_EMPTY;
 retry:
-	error = user_path_at(AT_FDCWD, pathname, lookup_flags, &path);
+	error = user_path_at(dfd, pathname, lookup_flags, &path);
 	if (error)
 		return error;
 	error = mnt_want_write(path.mnt);
@@ -907,16 +963,22 @@ static int path_removexattr(const char __user *pathname,
 	return error;
 }
 
+SYSCALL_DEFINE4(removexattrat, int, dfd, const char __user *, pathname,
+		const char __user *, name, int, flags)
+{
+	return do_removexattrat(dfd, pathname, name, flags);
+}
+
 SYSCALL_DEFINE2(removexattr, const char __user *, pathname,
 		const char __user *, name)
 {
-	return path_removexattr(pathname, name, LOOKUP_FOLLOW);
+	return do_removexattrat(AT_FDCWD, pathname, name, 0);
 }
 
 SYSCALL_DEFINE2(lremovexattr, const char __user *, pathname,
 		const char __user *, name)
 {
-	return path_removexattr(pathname, name, 0);
+	return do_removexattrat(AT_FDCWD, pathname, name, AT_SYMLINK_NOFOLLOW);
 }
 
 SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
-- 
2.37.2

