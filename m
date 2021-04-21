Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AEC367110
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 19:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242948AbhDURPb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 13:15:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60776 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241733AbhDURP1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 13:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619025293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CH/H9EMCPzTVO17F0AhVsjZvQyeIY3RFQ1xi2LaIF3U=;
        b=Rk5tbT+OUvf4fsiy5qTM0F+z1UIX5mOSKkkDLE3YUtPW6bORuAo6gWjw1j7TM8+nWkF+mX
        NXP6Ksnl3fRbsDXOZ+2UcqevzSdHmf9UU3WtLJIYBxH1K+dC2OcIkCBVv0tuypwG+Ij4zg
        WOFfU5dgUniOck9NcRFfkNx+Anr/zKY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-f4P_UXN-OX-kKgoVuisicw-1; Wed, 21 Apr 2021 13:14:51 -0400
X-MC-Unique: f4P_UXN-OX-kKgoVuisicw-1
Received: by mail-ed1-f71.google.com with SMTP id w15-20020a056402268fb02903828f878ec5so15387333edd.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Apr 2021 10:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CH/H9EMCPzTVO17F0AhVsjZvQyeIY3RFQ1xi2LaIF3U=;
        b=KgpyWmVbfsbTn0OkqHUpm69G2unCa0+7XcVee8FwtuhwJZ6PfUt36y9G1CAF5DDRMh
         JY0/8fE11WYBRD+Zz83Omm57fnxXUNf3U4dRsuIHqTAq8wGSHkjA/+qxkHobLatRbhEQ
         9F3iu80L935hTbgSKD8qQpUxR3u/d03MKj6xPFO2VUj5OVYzd4gCNuUq54bxULJXO0Ru
         mGrsRHK2ba0Bi4I2g6ZtSiH3zDgfqCZ709t+I4jgvHKI1268cK2+svncuwvl4Rtz1Uvh
         3VKtc38lsiAHvH7/6LYh7G4xB2avM1s4b+3GKl5COfdfxrOyaJHX9R0C7h2EqlvTSiGl
         XW4w==
X-Gm-Message-State: AOAM531wv3incGb7fXEwK7i2mbicpemi3GhnAet8yB3nAqh29bdqciff
        NQ2ZAkRfChQej1RaGh0gzbEbsMK6RMkzQQwkY4UYLq4xq2493HsKF4esz7XDm5/5DEbW5Inetam
        vu40m6y8yIVC7fpERMe/fvc7qLA==
X-Received: by 2002:a17:906:cc48:: with SMTP id mm8mr35075126ejb.58.1619025290664;
        Wed, 21 Apr 2021 10:14:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfY4E6B1rqiCEVZTtJIhVGRKBMsxhaixFISYRx97QdosCAdLI1H8CPlvqMBiK9Dx8yD8FXlw==
X-Received: by 2002:a17:906:cc48:: with SMTP id mm8mr35075104ejb.58.1619025290485;
        Wed, 21 Apr 2021 10:14:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id i1sm22905edt.33.2021.04.21.10.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 10:14:49 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lokesh Gidra <lokeshgidra@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 1/2] LSM,anon_inodes: explicitly distinguish anon inode types
Date:   Wed, 21 Apr 2021 19:14:45 +0200
Message-Id: <20210421171446.785507-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210421171446.785507-1-omosnace@redhat.com>
References: <20210421171446.785507-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add an enum to <linux/security.h> that allows LSMs to reliably
distinguish types of anon inodes created via anon_inode_getfd_secure()
and require callers of this function to pass the type as an argument.
For the single current user of this function (userfaultfd), add the
corresponding type and pass it in its anon_inode_getfd_secure() call.

While the "name" argument can be used to distinguish different types as
well, some users of anon_inode_getfd() put some additional information
here (e.g. KVM anon inodes), so using an explicit numeric identifier is
preferred to parsing this information from strings.

The new type information will be used by SELinux in a subsequent patch.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 fs/anon_inodes.c              | 42 ++++++++++++++++++++++-------------
 fs/userfaultfd.c              |  6 +++--
 include/linux/anon_inodes.h   |  4 +++-
 include/linux/lsm_hook_defs.h |  3 ++-
 include/linux/security.h      | 19 ++++++++++++++++
 security/security.c           |  3 ++-
 security/selinux/hooks.c      |  1 +
 7 files changed, 57 insertions(+), 21 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index a280156138ed..0c8e77b69893 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -56,6 +56,7 @@ static struct file_system_type anon_inode_fs_type = {
 };
 
 static struct inode *anon_inode_make_secure_inode(
+	enum lsm_anon_inode_type type,
 	const char *name,
 	const struct inode *context_inode)
 {
@@ -67,7 +68,8 @@ static struct inode *anon_inode_make_secure_inode(
 	if (IS_ERR(inode))
 		return inode;
 	inode->i_flags &= ~S_PRIVATE;
-	error =	security_inode_init_security_anon(inode, &qname, context_inode);
+	error =	security_inode_init_security_anon(inode, type, &qname,
+						  context_inode);
 	if (error) {
 		iput(inode);
 		return ERR_PTR(error);
@@ -75,11 +77,11 @@ static struct inode *anon_inode_make_secure_inode(
 	return inode;
 }
 
-static struct file *__anon_inode_getfile(const char *name,
+static struct file *__anon_inode_getfile(enum lsm_anon_inode_type type,
+					 const char *name,
 					 const struct file_operations *fops,
 					 void *priv, int flags,
-					 const struct inode *context_inode,
-					 bool secure)
+					 const struct inode *context_inode)
 {
 	struct inode *inode;
 	struct file *file;
@@ -87,8 +89,8 @@ static struct file *__anon_inode_getfile(const char *name,
 	if (fops->owner && !try_module_get(fops->owner))
 		return ERR_PTR(-ENOENT);
 
-	if (secure) {
-		inode =	anon_inode_make_secure_inode(name, context_inode);
+	if (type != LSM_ANON_INODE_NONE) {
+		inode =	anon_inode_make_secure_inode(type, name, context_inode);
 		if (IS_ERR(inode)) {
 			file = ERR_CAST(inode);
 			goto err;
@@ -144,15 +146,16 @@ struct file *anon_inode_getfile(const char *name,
 				const struct file_operations *fops,
 				void *priv, int flags)
 {
-	return __anon_inode_getfile(name, fops, priv, flags, NULL, false);
+	return __anon_inode_getfile(LSM_ANON_INODE_NONE, name, fops, priv,
+				    flags, NULL);
 }
 EXPORT_SYMBOL_GPL(anon_inode_getfile);
 
-static int __anon_inode_getfd(const char *name,
+static int __anon_inode_getfd(enum lsm_anon_inode_type type,
+			      const char *name,
 			      const struct file_operations *fops,
 			      void *priv, int flags,
-			      const struct inode *context_inode,
-			      bool secure)
+			      const struct inode *context_inode)
 {
 	int error, fd;
 	struct file *file;
@@ -162,8 +165,8 @@ static int __anon_inode_getfd(const char *name,
 		return error;
 	fd = error;
 
-	file = __anon_inode_getfile(name, fops, priv, flags, context_inode,
-				    secure);
+	file = __anon_inode_getfile(type, name, fops, priv, flags,
+				    context_inode);
 	if (IS_ERR(file)) {
 		error = PTR_ERR(file);
 		goto err_put_unused_fd;
@@ -197,7 +200,8 @@ err_put_unused_fd:
 int anon_inode_getfd(const char *name, const struct file_operations *fops,
 		     void *priv, int flags)
 {
-	return __anon_inode_getfd(name, fops, priv, flags, NULL, false);
+	return __anon_inode_getfd(LSM_ANON_INODE_NONE, name, fops, priv,
+				  flags, NULL);
 }
 EXPORT_SYMBOL_GPL(anon_inode_getfd);
 
@@ -207,7 +211,9 @@ EXPORT_SYMBOL_GPL(anon_inode_getfd);
  * the inode_init_security_anon() LSM hook. This allows the inode to have its
  * own security context and for a LSM to reject creation of the inode.
  *
- * @name:    [in]    name of the "class" of the new file
+ * @type:    [in]    type of the file recognizable by LSMs
+ * @name:    [in]    name of the "class" of the new file (may be more specific
+ *                   than @type)
  * @fops:    [in]    file operations for the new file
  * @priv:    [in]    private data for the new file (will be file's private_data)
  * @flags:   [in]    flags
@@ -217,11 +223,15 @@ EXPORT_SYMBOL_GPL(anon_inode_getfd);
  * The LSM may use @context_inode in inode_init_security_anon(), but a
  * reference to it is not held.
  */
-int anon_inode_getfd_secure(const char *name, const struct file_operations *fops,
+int anon_inode_getfd_secure(enum lsm_anon_inode_type type, const char *name,
+			    const struct file_operations *fops,
 			    void *priv, int flags,
 			    const struct inode *context_inode)
 {
-	return __anon_inode_getfd(name, fops, priv, flags, context_inode, true);
+	/* The caller must pass a valid type! */
+	if (WARN_ON(type <= LSM_ANON_INODE_NONE || type > LSM_ANON_INODE_MAX))
+		return -EINVAL;
+	return __anon_inode_getfd(type, name, fops, priv, flags, context_inode);
 }
 EXPORT_SYMBOL_GPL(anon_inode_getfd_secure);
 
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 0be8cdd4425a..003f65d752c4 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -985,7 +985,8 @@ static int resolve_userfault_fork(struct userfaultfd_ctx *new,
 {
 	int fd;
 
-	fd = anon_inode_getfd_secure("[userfaultfd]", &userfaultfd_fops, new,
+	fd = anon_inode_getfd_secure(LSM_ANON_INODE_USERFAULTFD,
+			"[userfaultfd]", &userfaultfd_fops, new,
 			O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS), inode);
 	if (fd < 0)
 		return fd;
@@ -2000,7 +2001,8 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	/* prevent the mm struct to be freed */
 	mmgrab(ctx->mm);
 
-	fd = anon_inode_getfd_secure("[userfaultfd]", &userfaultfd_fops, ctx,
+	fd = anon_inode_getfd_secure(LSM_ANON_INODE_USERFAULTFD,
+			"[userfaultfd]", &userfaultfd_fops, ctx,
 			O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
 	if (fd < 0) {
 		mmdrop(ctx->mm);
diff --git a/include/linux/anon_inodes.h b/include/linux/anon_inodes.h
index 71881a2b6f78..37137e994ceb 100644
--- a/include/linux/anon_inodes.h
+++ b/include/linux/anon_inodes.h
@@ -9,6 +9,8 @@
 #ifndef _LINUX_ANON_INODES_H
 #define _LINUX_ANON_INODES_H
 
+#include <linux/security.h>
+
 struct file_operations;
 struct inode;
 
@@ -17,7 +19,7 @@ struct file *anon_inode_getfile(const char *name,
 				void *priv, int flags);
 int anon_inode_getfd(const char *name, const struct file_operations *fops,
 		     void *priv, int flags);
-int anon_inode_getfd_secure(const char *name,
+int anon_inode_getfd_secure(enum lsm_anon_inode_type type, const char *name,
 			    const struct file_operations *fops,
 			    void *priv, int flags,
 			    const struct inode *context_inode);
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 61f04f7dc1a4..ba03a7d0bf1a 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -115,7 +115,8 @@ LSM_HOOK(int, 0, inode_init_security, struct inode *inode,
 	 struct inode *dir, const struct qstr *qstr, const char **name,
 	 void **value, size_t *len)
 LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
-	 const struct qstr *name, const struct inode *context_inode)
+	 enum lsm_anon_inode_type type, const struct qstr *name,
+	 const struct inode *context_inode)
 LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
 	 umode_t mode)
 LSM_HOOK(int, 0, inode_link, struct dentry *old_dentry, struct inode *dir,
diff --git a/include/linux/security.h b/include/linux/security.h
index 9aeda3f9e838..7c5117676f29 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -79,6 +79,23 @@ enum lsm_event {
 	LSM_POLICY_CHANGE,
 };
 
+/*
+ * Types of anonymous inodes that may be interesting to LSMs.
+ * Passed to anon_inode_getfd_secure() and
+ * security_inode_init_security_anon().
+ */
+enum lsm_anon_inode_type {
+	/* anon inodes invisible to the LSMs */
+	LSM_ANON_INODE_NONE = 0,
+	/* userfaultfd anon inodes */
+	LSM_ANON_INODE_USERFAULTFD,
+	/* (add new types above this line) */
+
+	__LSM_ANON_INODE_MAX,
+	/* max value used for asserts */
+	LSM_ANON_INODE_MAX = __LSM_ANON_INODE_MAX - 1,
+};
+
 /*
  * These are reasons that can be passed to the security_locked_down()
  * LSM hook. Lockdown reasons that protect kernel integrity (ie, the
@@ -329,6 +346,7 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const struct qstr *qstr,
 				 initxattrs initxattrs, void *fs_data);
 int security_inode_init_security_anon(struct inode *inode,
+				      enum lsm_anon_inode_type type,
 				      const struct qstr *name,
 				      const struct inode *context_inode);
 int security_old_inode_init_security(struct inode *inode, struct inode *dir,
@@ -759,6 +777,7 @@ static inline int security_inode_init_security(struct inode *inode,
 }
 
 static inline int security_inode_init_security_anon(struct inode *inode,
+						    enum lsm_anon_inode_type type,
 						    const struct qstr *name,
 						    const struct inode *context_inode)
 {
diff --git a/security/security.c b/security/security.c
index 94383f83ba42..3786932c576c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1067,10 +1067,11 @@ out:
 EXPORT_SYMBOL(security_inode_init_security);
 
 int security_inode_init_security_anon(struct inode *inode,
+				      enum lsm_anon_inode_type type,
 				      const struct qstr *name,
 				      const struct inode *context_inode)
 {
-	return call_int_hook(inode_init_security_anon, 0, inode, name,
+	return call_int_hook(inode_init_security_anon, 0, inode, type, name,
 			     context_inode);
 }
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 92f909a2e8f7..dc57ba21d8ff 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3048,6 +3048,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 }
 
 static int selinux_inode_init_security_anon(struct inode *inode,
+					    enum lsm_anon_inode_type type,
 					    const struct qstr *name,
 					    const struct inode *context_inode)
 {
-- 
2.30.2

