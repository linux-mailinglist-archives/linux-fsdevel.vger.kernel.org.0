Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F065D1F511F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 11:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgFJJ1z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 05:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgFJJ1y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 05:27:54 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731C3C03E96B
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2020 02:27:54 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a127so846160pfa.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2020 02:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g5zkZKTN+9Pwa1H+ZwZQErrRQBCq/NTm9XsGCeUK92c=;
        b=jl4GQo4LJUzYtck/CItWh5pjD/Q8fdg5mLlk/SEXkptLcklSB5+bg/6iY1ni/gAhby
         mKWOPYJPzRywdX4LCpytW/FJdymee+9fzLlYa0gqNAbgv+VZ5jYNf4RH/Y4cJ266+vGS
         VLIHu957ODkcWPXz6hmcHbDr8uzJlDVElFQjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g5zkZKTN+9Pwa1H+ZwZQErrRQBCq/NTm9XsGCeUK92c=;
        b=PPDeKLLnwufGiYc2uafZWNBI9FDl7uv35IxAmprVfRS3LplwTIlaJlGUSuvchHmNE4
         9LYc8RjD5tYhqvhXv5RJ609ngPGuy//Mfd0GkevereugqbPFnQfqsFNAHXJd+ZmuhmR4
         s1KNS05CQOhs1wn7rkk/nfOIIo/B/d31thyrMwDgIa6X6TW+28Fl+MC6pFaLO7lNjsF4
         1dhacRm49lRrCajX7vAF1W6WTbq2Btxf23g89ZQUntl3ou8pWnl2LtN2H+OxIdR1O8A2
         Dms87GzDBDngrST8rnorQRCqiTZ03Ef0pF24O84cWZfzkaBwXXaLdDx33FkDrHhGDAX4
         vFEg==
X-Gm-Message-State: AOAM532+v4xLbGHjfBIl0VIQW1dMFiOhEDSf07AS+DYocTm68chK9P84
        09y4KQF2MJYvG49n+P62lO1M/Q==
X-Google-Smtp-Source: ABdhPJymriX6ftrm3CuauWVsdfK8DluwD7B/MKE1JpZ7r3lLVRPvr4/nt6rbVFkYvdImzJqEdDxs8g==
X-Received: by 2002:a65:5902:: with SMTP id f2mr1800905pgu.283.1591781273915;
        Wed, 10 Jun 2020 02:27:53 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:2:1c5:cb1a:7c95:326])
        by smtp.gmail.com with ESMTPSA id l63sm12559000pfd.122.2020.06.10.02.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 02:27:53 -0700 (PDT)
From:   Chirantan Ekbote <chirantan@chromium.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH v2] RFC: fuse: Call security hooks on new inodes
Date:   Wed, 10 Jun 2020 18:27:44 +0900
Message-Id: <20200610092744.140038-1-chirantan@chromium.org>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
In-Reply-To: <20200601053214.201723-1-chirantan@chromium.org>
References: <20200601053214.201723-1-chirantan@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a new `init_security` field to `fuse_conn` that controls whether we
initialize security when a new inode is created.  Also add a
`FUSE_SECURITY_CTX` flag that can be set in the `flags` field of the
`fuse_init_out` struct that controls when the `init_security` field is
set.

When set to true, get the security context for a newly created inode via
`security_dentry_init_security` and append it to the create, mkdir,
mknod, and symlink requests.  The server should use this context by
writing it to `/proc/thread-self/attr/fscreate` before creating the
requested inode.

Calling security hooks is needed for `setfscreatecon` to work since it
is applied as part of the selinux security hook.

Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>
---
Changes in v2:
  * Added the FUSE_SECURITY_CTX flag for init_out responses.
  * Switched to security_dentry_init_security.
  * Send security context with create, mknod, mkdir, and symlink
    requests instead of applying it after creation.

 fs/fuse/dir.c             | 99 +++++++++++++++++++++++++++++++++++++--
 fs/fuse/fuse_i.h          |  3 ++
 fs/fuse/inode.c           |  5 +-
 include/uapi/linux/fuse.h |  8 +++-
 4 files changed, 110 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index ee190119f45cc..86bc073bb4f0a 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -16,6 +16,9 @@
 #include <linux/xattr.h>
 #include <linux/iversion.h>
 #include <linux/posix_acl.h>
+#include <linux/security.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
 
 static void fuse_advise_use_readdirplus(struct inode *dir)
 {
@@ -442,6 +445,8 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	struct fuse_entry_out outentry;
 	struct fuse_inode *fi;
 	struct fuse_file *ff;
+	void *security_ctx = NULL;
+	u32 security_ctxlen = 0;
 
 	/* Userspace expects S_IFREG in create mode */
 	BUG_ON((mode & S_IFMT) != S_IFREG);
@@ -477,6 +482,21 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	args.out_args[0].value = &outentry;
 	args.out_args[1].size = sizeof(outopen);
 	args.out_args[1].value = &outopen;
+
+	if (fc->init_security) {
+		err = security_dentry_init_security(entry, mode, &entry->d_name,
+						    &security_ctx,
+						    &security_ctxlen);
+		if (err)
+			goto out_put_forget_req;
+
+		if (security_ctxlen > 0) {
+			args.in_numargs = 3;
+			args.in_args[2].size = security_ctxlen;
+			args.in_args[2].value = security_ctx;
+		}
+	}
+
 	err = fuse_simple_request(fc, &args);
 	if (err)
 		goto out_free_ff;
@@ -513,6 +533,8 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	return err;
 
 out_free_ff:
+	if (security_ctxlen > 0)
+		kfree(security_ctx);
 	fuse_file_free(ff);
 out_put_forget_req:
 	kfree(forget);
@@ -629,6 +651,9 @@ static int fuse_mknod(struct inode *dir, struct dentry *entry, umode_t mode,
 {
 	struct fuse_mknod_in inarg;
 	struct fuse_conn *fc = get_fuse_conn(dir);
+	void *security_ctx = NULL;
+	u32 security_ctxlen = 0;
+	int ret;
 	FUSE_ARGS(args);
 
 	if (!fc->dont_mask)
@@ -644,7 +669,27 @@ static int fuse_mknod(struct inode *dir, struct dentry *entry, umode_t mode,
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = entry->d_name.len + 1;
 	args.in_args[1].value = entry->d_name.name;
-	return create_new_entry(fc, &args, dir, entry, mode);
+
+	if (fc->init_security) {
+		ret = security_dentry_init_security(entry, mode, &entry->d_name,
+						    &security_ctx,
+						    &security_ctxlen);
+		if (ret)
+			goto out;
+
+		if (security_ctxlen > 0) {
+			args.in_numargs = 3;
+			args.in_args[2].size = security_ctxlen;
+			args.in_args[2].value = security_ctx;
+		}
+	}
+
+	ret = create_new_entry(fc, &args, dir, entry, mode);
+
+	if (security_ctxlen > 0)
+		kfree(security_ctx);
+out:
+	return ret;
 }
 
 static int fuse_create(struct inode *dir, struct dentry *entry, umode_t mode,
@@ -657,6 +702,9 @@ static int fuse_mkdir(struct inode *dir, struct dentry *entry, umode_t mode)
 {
 	struct fuse_mkdir_in inarg;
 	struct fuse_conn *fc = get_fuse_conn(dir);
+	void *security_ctx = NULL;
+	u32 security_ctxlen = 0;
+	int ret;
 	FUSE_ARGS(args);
 
 	if (!fc->dont_mask)
@@ -671,7 +719,28 @@ static int fuse_mkdir(struct inode *dir, struct dentry *entry, umode_t mode)
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = entry->d_name.len + 1;
 	args.in_args[1].value = entry->d_name.name;
-	return create_new_entry(fc, &args, dir, entry, S_IFDIR);
+
+	if (fc->init_security) {
+		ret = security_dentry_init_security(entry, S_IFDIR,
+						    &entry->d_name,
+						    &security_ctx,
+						    &security_ctxlen);
+		if (ret)
+			goto out;
+
+		if (security_ctxlen > 0) {
+			args.in_numargs = 3;
+			args.in_args[2].size = security_ctxlen;
+			args.in_args[2].value = security_ctx;
+		}
+	}
+
+	ret = create_new_entry(fc, &args, dir, entry, S_IFDIR);
+
+	if (security_ctxlen > 0)
+		kfree(security_ctx);
+out:
+	return ret;
 }
 
 static int fuse_symlink(struct inode *dir, struct dentry *entry,
@@ -679,6 +748,9 @@ static int fuse_symlink(struct inode *dir, struct dentry *entry,
 {
 	struct fuse_conn *fc = get_fuse_conn(dir);
 	unsigned len = strlen(link) + 1;
+	void *security_ctx = NULL;
+	u32 security_ctxlen = 0;
+	int ret;
 	FUSE_ARGS(args);
 
 	args.opcode = FUSE_SYMLINK;
@@ -687,7 +759,28 @@ static int fuse_symlink(struct inode *dir, struct dentry *entry,
 	args.in_args[0].value = entry->d_name.name;
 	args.in_args[1].size = len;
 	args.in_args[1].value = link;
-	return create_new_entry(fc, &args, dir, entry, S_IFLNK);
+
+	if (fc->init_security) {
+		ret = security_dentry_init_security(entry, S_IFLNK,
+						    &entry->d_name,
+						    &security_ctx,
+						    &security_ctxlen);
+		if (ret)
+			goto out;
+
+		if (security_ctxlen > 0) {
+			args.in_numargs = 3;
+			args.in_args[2].size = security_ctxlen;
+			args.in_args[2].value = security_ctx;
+		}
+	}
+
+	ret = create_new_entry(fc, &args, dir, entry, S_IFLNK);
+
+	if (security_ctxlen > 0)
+		kfree(security_ctx);
+out:
+	return ret;
 }
 
 void fuse_update_ctime(struct inode *inode)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index ca344bf714045..5ea9212b0a71c 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -719,6 +719,9 @@ struct fuse_conn {
 	/* Do not show mount options */
 	unsigned int no_mount_options:1;
 
+	/* Initialize security xattrs when creating a new inode */
+	unsigned int init_security : 1;
+
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 16aec32f7f3d7..1a311771c5555 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -951,6 +951,8 @@ static void process_init_reply(struct fuse_conn *fc, struct fuse_args *args,
 					min_t(unsigned int, FUSE_MAX_MAX_PAGES,
 					max_t(unsigned int, arg->max_pages, 1));
 			}
+			if (arg->flags & FUSE_SECURITY_CTX)
+				fc->init_security = 1;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -988,7 +990,8 @@ void fuse_send_init(struct fuse_conn *fc)
 		FUSE_WRITEBACK_CACHE | FUSE_NO_OPEN_SUPPORT |
 		FUSE_PARALLEL_DIROPS | FUSE_HANDLE_KILLPRIV | FUSE_POSIX_ACL |
 		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
-		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA;
+		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
+		FUSE_SECURITY_CTX;
 	ia->args.opcode = FUSE_INIT;
 	ia->args.in_numargs = 1;
 	ia->args.in_args[0].size = sizeof(ia->in);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 373cada898159..00919c214149d 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -172,6 +172,10 @@
  *  - add FUSE_WRITE_KILL_PRIV flag
  *  - add FUSE_SETUPMAPPING and FUSE_REMOVEMAPPING
  *  - add map_alignment to fuse_init_out, add FUSE_MAP_ALIGNMENT flag
+ *
+ *  7.32
+ *  - add FUSE_SECURITY_CTX flag for fuse_init_out
+ *  - add security context to create, mkdir, and mknod requests
  */
 
 #ifndef _LINUX_FUSE_H
@@ -207,7 +211,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 31
+#define FUSE_KERNEL_MINOR_VERSION 32
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -314,6 +318,7 @@ struct fuse_file_lock {
  * FUSE_NO_OPENDIR_SUPPORT: kernel supports zero-message opendir
  * FUSE_EXPLICIT_INVAL_DATA: only invalidate cached pages on explicit request
  * FUSE_MAP_ALIGNMENT: map_alignment field is valid
+ * FUSE_SECURITY_CTX: add security context to create, mkdir, symlink, and mknod
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -342,6 +347,7 @@ struct fuse_file_lock {
 #define FUSE_NO_OPENDIR_SUPPORT (1 << 24)
 #define FUSE_EXPLICIT_INVAL_DATA (1 << 25)
 #define FUSE_MAP_ALIGNMENT	(1 << 26)
+#define FUSE_SECURITY_CTX	(1 << 27)
 
 /**
  * CUSE INIT request/reply flags
-- 
2.27.0.278.ge193c7cf3a9-goog

