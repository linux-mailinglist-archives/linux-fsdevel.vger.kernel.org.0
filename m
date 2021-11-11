Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647AE44D858
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 15:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbhKKOft (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 09:35:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48419 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233075AbhKKOfs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 09:35:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636641179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XDKEueG5NX5eOKTFR1aULx5OKCoFDGYW8PMUBL15la8=;
        b=a6SNGlQVIic6UrUqAU9bsVTm1mwzYTvYui6rSUsx4azRqyrBgAZHBLrwpAhT8SeVPAC22L
        nzBFBr+bnzszzL+UZo+V0mNBqaTyqeqo9FnjfQ208BgnfB9orary6tcacqRLFPh+mjeTAH
        bXZpJQm0s0zVf1XBidyX60UrHCINT5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-cn_nm5YRPDie_8ZFLR1Mtw-1; Thu, 11 Nov 2021 09:32:56 -0500
X-MC-Unique: cn_nm5YRPDie_8ZFLR1Mtw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C02F11006AA2;
        Thu, 11 Nov 2021 14:32:54 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.33.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5EF565C1B4;
        Thu, 11 Nov 2021 14:32:50 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 0954A220EED; Thu, 11 Nov 2021 09:32:50 -0500 (EST)
Date:   Thu, 11 Nov 2021 09:32:49 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, virtio-fs@redhat.com,
        chirantan@chromium.org, stephen.smalley.work@gmail.com,
        dwalsh@redhat.com, casey@schaufler-ca.com, omosnace@redhat.com
Subject: Re: [PATCH v3 1/1] fuse: Send security context of inode on file
 creation
Message-ID: <YY0pkR3tJuxuBQzD@redhat.com>
References: <20211110225528.48601-1-vgoyal@redhat.com>
 <20211110225528.48601-2-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110225528.48601-2-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a new inode is created, send its security context to server along
with creation request (FUSE_CREAT, FUSE_MKNOD, FUSE_MKDIR and FUSE_SYMLINK).
This gives server an opportunity to create new file and set security
context (possibly atomically). In all the configurations it might not
be possible to set context atomically.

Like nfs and ceph, use security_dentry_init_security() to dermine security
context of inode and send it with create, mkdir, mknod, and symlink requests.

Following is the information sent to server.

fuse_sectx_header, fuse_secctx, xattr_name, security_context

- struct fuse_secctx_header
  This contains total number of security contexts being sent and total
  size of all the security contexts (including size of fuse_secctx_header).

- struct fuse_secctx.
  This contains size of security context which follows this structure.
  There is one fuse_secctx instance per security context.

- xattr name string.
  This string represents name of xattr which should be used while setting
  security context.

- security context.
  This is the actual security context whose size is specified in fuse_secctx
  struct.

Also add the FUSE_SECURITY_CTX flag for the `flags` field of the
fuse_init_out struct.  When this flag is set the kernel will append the
security context for a newly created inode to the request (create,
mkdir, mknod, and symlink).  The server is responsible for ensuring that
the inode appears atomically (preferrably) with the requested security
context.

For example, If the server is using SELinux and backed by a "real" linux
file system that supports extended attributes it can write the security
context value to /proc/thread-self/attr/fscreate before making the syscall
to create the inode.

This patch is based on patch from Chirantan Ekbote <chirantan@chromium.org>.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/dir.c             |  103 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h          |    3 +
 fs/fuse/inode.c           |    4 +
 include/uapi/linux/fuse.h |   31 +++++++++++++
 4 files changed, 139 insertions(+), 2 deletions(-)

Index: redhat-linux/include/uapi/linux/fuse.h
===================================================================
--- redhat-linux.orig/include/uapi/linux/fuse.h	2021-11-11 08:53:18.570236125 -0500
+++ redhat-linux/include/uapi/linux/fuse.h	2021-11-11 08:58:38.970236125 -0500
@@ -187,6 +187,10 @@
  *
  *  7.35
  *  - add FOPEN_NOFLUSH
+ *
+ *  7.36
+ *  - add FUSE_SECURITY_CTX flag for fuse_init_out
+ *  - add security context to create, mkdir, symlink, and mknod requests
  */
 
 #ifndef _LINUX_FUSE_H
@@ -222,7 +226,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 35
+#define FUSE_KERNEL_MINOR_VERSION 36
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -341,6 +345,8 @@ struct fuse_file_lock {
  *			write/truncate sgid is killed only if file has group
  *			execute permission. (Same as Linux VFS behavior).
  * FUSE_SETXATTR_EXT:	Server supports extended struct fuse_setxattr_in
+ * FUSE_SECURITY_CTX:	add security context to create, mkdir, symlink, and
+ * 			mknod
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -372,6 +378,7 @@ struct fuse_file_lock {
 #define FUSE_SUBMOUNTS		(1 << 27)
 #define FUSE_HANDLE_KILLPRIV_V2	(1 << 28)
 #define FUSE_SETXATTR_EXT	(1 << 29)
+#define FUSE_SECURITY_CTX	(1 << 30)
 
 /**
  * CUSE INIT request/reply flags
@@ -984,4 +991,26 @@ struct fuse_syncfs_in {
 	uint64_t	padding;
 };
 
+/*
+ * For each security context, send fuse_secctx with size of security context
+ * fuse_secctx will be followed by security context name and this in turn
+ * will be followed by actual context label.
+ * fuse_secctx, name, context
+ * */
+struct fuse_secctx {
+	uint32_t	size;
+	uint32_t	padding;
+};
+
+/*
+ * Contains the information about how many fuse_secctx structures are being
+ * sent and what's the total size of all security contexts (including
+ * size of fuse_secctx_header).
+ *
+ */
+struct fuse_secctx_header {
+	uint32_t	size;
+	uint32_t	nr_secctx;
+};
+
 #endif /* _LINUX_FUSE_H */
Index: redhat-linux/fs/fuse/dir.c
===================================================================
--- redhat-linux.orig/fs/fuse/dir.c	2021-11-11 08:56:19.812236125 -0500
+++ redhat-linux/fs/fuse/dir.c	2021-11-11 08:57:10.575236125 -0500
@@ -17,6 +17,9 @@
 #include <linux/xattr.h>
 #include <linux/iversion.h>
 #include <linux/posix_acl.h>
+#include <linux/security.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
 
 static void fuse_advise_use_readdirplus(struct inode *dir)
 {
@@ -456,6 +459,69 @@ static struct dentry *fuse_lookup(struct
 	return ERR_PTR(err);
 }
 
+static int get_security_context(struct dentry *entry, umode_t mode,
+				void **security_ctx, u32 *security_ctxlen)
+{
+	struct fuse_secctx *fsecctx;
+	struct fuse_secctx_header *fsecctx_header;
+	void *ctx, *full_ctx;
+	u32 ctxlen, full_ctxlen;
+	int err = 0;
+	const char *name;
+
+	err = security_dentry_init_security(entry, mode, &entry->d_name,
+					    &name, &ctx, &ctxlen);
+	if (err) {
+		if (err != -EOPNOTSUPP)
+			goto out_err;
+		/* No LSM is supporting this security hook. Ignore error */
+		err = 0;
+		ctxlen = 0;
+	}
+
+	if (ctxlen > 0) {
+		void *ptr;
+
+		full_ctxlen = sizeof(*fsecctx_header) + sizeof(*fsecctx) +
+			      strlen(name) + ctxlen + 1;
+		full_ctx = kzalloc(full_ctxlen, GFP_KERNEL);
+		if (!full_ctx) {
+			err = -ENOMEM;
+			kfree(ctx);
+			goto out_err;
+		}
+
+		ptr = full_ctx;
+		fsecctx_header = (struct fuse_secctx_header*) ptr;
+		fsecctx_header->nr_secctx = 1;
+		fsecctx_header->size = full_ctxlen;
+		ptr += sizeof(*fsecctx_header);
+
+		fsecctx = (struct fuse_secctx*) ptr;
+		fsecctx->size = ctxlen;
+		ptr += sizeof(*fsecctx);
+
+		strcpy(ptr, name);
+		ptr += strlen(name) + 1;
+		memcpy(ptr, ctx, ctxlen);
+		kfree(ctx);
+	} else {
+		full_ctxlen = sizeof(*fsecctx_header);
+		full_ctx = kzalloc(full_ctxlen, GFP_KERNEL);
+		if (!full_ctx) {
+			err = -ENOMEM;
+			goto out_err;
+		}
+		fsecctx_header = full_ctx;
+		fsecctx_header->size = full_ctxlen;
+	}
+
+	*security_ctxlen = full_ctxlen;
+	*security_ctx = full_ctx;
+out_err:
+	return err;
+}
+
 /*
  * Atomic create+open operation
  *
@@ -476,6 +542,8 @@ static int fuse_create_open(struct inode
 	struct fuse_entry_out outentry;
 	struct fuse_inode *fi;
 	struct fuse_file *ff;
+	void *security_ctx = NULL;
+	u32 security_ctxlen;
 
 	/* Userspace expects S_IFREG in create mode */
 	BUG_ON((mode & S_IFMT) != S_IFREG);
@@ -517,6 +585,18 @@ static int fuse_create_open(struct inode
 	args.out_args[0].value = &outentry;
 	args.out_args[1].size = sizeof(outopen);
 	args.out_args[1].value = &outopen;
+
+	if (fm->fc->init_security) {
+		err = get_security_context(entry, mode, &security_ctx,
+					   &security_ctxlen);
+		if (err)
+			goto out_put_forget_req;
+
+		args.in_numargs = 3;
+		args.in_args[2].size = security_ctxlen;
+		args.in_args[2].value = security_ctx;
+	}
+
 	err = fuse_simple_request(fm, &args);
 	if (err)
 		goto out_free_ff;
@@ -554,6 +634,7 @@ static int fuse_create_open(struct inode
 
 out_free_ff:
 	fuse_file_free(ff);
+	kfree(security_ctx);
 out_put_forget_req:
 	kfree(forget);
 out_err:
@@ -620,6 +701,8 @@ static int create_new_entry(struct fuse_
 	struct dentry *d;
 	int err;
 	struct fuse_forget_link *forget;
+	void *security_ctx = NULL;
+	u32 security_ctxlen = 0;
 
 	if (fuse_is_bad(dir))
 		return -EIO;
@@ -633,7 +716,27 @@ static int create_new_entry(struct fuse_
 	args->out_numargs = 1;
 	args->out_args[0].size = sizeof(outarg);
 	args->out_args[0].value = &outarg;
+
+	if (fm->fc->init_security && args->opcode != FUSE_LINK) {
+		unsigned short idx = args->in_numargs;
+
+		if ((size_t)idx >= ARRAY_SIZE(args->in_args)) {
+			err = -ENOMEM;
+			goto out_put_forget_req;
+		}
+
+		err = get_security_context(entry, mode, &security_ctx,
+					   &security_ctxlen);
+		if (err)
+			goto out_put_forget_req;
+
+		args->in_args[idx].size = security_ctxlen;
+		args->in_args[idx].value = security_ctx;
+		args->in_numargs++;
+	}
+
 	err = fuse_simple_request(fm, args);
+	kfree(security_ctx);
 	if (err)
 		goto out_put_forget_req;
 
Index: redhat-linux/fs/fuse/fuse_i.h
===================================================================
--- redhat-linux.orig/fs/fuse/fuse_i.h	2021-11-11 08:56:19.814236125 -0500
+++ redhat-linux/fs/fuse/fuse_i.h	2021-11-11 08:57:10.576236125 -0500
@@ -765,6 +765,9 @@ struct fuse_conn {
 	/* Propagate syncfs() to server */
 	unsigned int sync_fs:1;
 
+	/* Initialize security xattrs when creating a new inode */
+	unsigned int init_security:1;
+
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
Index: redhat-linux/fs/fuse/inode.c
===================================================================
--- redhat-linux.orig/fs/fuse/inode.c	2021-11-11 08:56:19.815236125 -0500
+++ redhat-linux/fs/fuse/inode.c	2021-11-11 08:57:10.576236125 -0500
@@ -1176,6 +1176,8 @@ static void process_init_reply(struct fu
 			}
 			if (arg->flags & FUSE_SETXATTR_EXT)
 				fc->setxattr_ext = 1;
+			if (arg->flags & FUSE_SECURITY_CTX)
+				fc->init_security = 1;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1219,7 +1221,7 @@ void fuse_send_init(struct fuse_mount *f
 		FUSE_PARALLEL_DIROPS | FUSE_HANDLE_KILLPRIV | FUSE_POSIX_ACL |
 		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
 		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
-		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT;
+		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_SECURITY_CTX;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		ia->in.flags |= FUSE_MAP_ALIGNMENT;

