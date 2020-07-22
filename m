Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471AE22947C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 11:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbgGVJJT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 05:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgGVJJS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:09:18 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D36C0619DE
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2020 02:09:18 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id m22so854145pgv.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2020 02:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JdQz6HfIR2nAcG7c6KrVPV2eWsbuTTTRsMjCbi9sdas=;
        b=ChdwMgdGCMfOQETkVeTsTF3QBOc8ASgwPEwOQNtnIPlvlnPhMH26I6snjib3aghOM+
         Q5c6DoBarjEuf9FkVBxbz2dZHaMumSAyRfXn7iuMiBXrkL0yl9i/+gJSx4/qdzAFUV5X
         6tD3n/JW9nQ8ghFR+V/3N07twERtNVcaRj62k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JdQz6HfIR2nAcG7c6KrVPV2eWsbuTTTRsMjCbi9sdas=;
        b=dwSxCzp/skGGmZGY37aUXFVySQVnKz5UKQDPClIY5piwnBP2EdAOdK1yTRHH5C/bnB
         S7SOS8buont/A5YdFMEn2X+pfUt5PkQv/04DfPb1RsWt+RYOiv9pjYM3TfMtZT9FEy+g
         fxdYO7UV1Xnvgvn7auT3SLviVwA5YKTKhzSH2zWzwN/T2zG7Sny/lIeLRTbtNrcn4osW
         CYsuctTR2MW8aRQJyagb5f7CZuvQ6eLj6PEq/bcia1JMU0ysb7UMFguGqSUBMG4znXeC
         XVYXSMu93LVf8jjj6mTHC2cZaDDIgCwz1sk3AAPcIHL/a3vX4Kic9WR259j+k9aAlf0c
         9lqA==
X-Gm-Message-State: AOAM5312kWH7BMJF6tNtCO8A7l9mfYZ21JAUwJykVbYrJDc0odpxyCA2
        Ofci8JjPmxsWtBZs00tG/GoYBw==
X-Google-Smtp-Source: ABdhPJwDazGYr6tNh7L+TJkRknh69QLWegvXUR3mUO5I7SyiX6nUOsOeAOR9znfGzV2bM7kpUTMToA==
X-Received: by 2002:a63:8b42:: with SMTP id j63mr26652063pge.131.1595408958264;
        Wed, 22 Jul 2020 02:09:18 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:2:f693:9fff:fef4:2537])
        by smtp.gmail.com with ESMTPSA id ci23sm5692133pjb.29.2020.07.22.02.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 02:09:17 -0700 (PDT)
From:   Chirantan Ekbote <chirantan@chromium.org>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        fuse-devel@lists.sourceforge.net, selinux@vger.kernel.org,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [RESEND] [PATCHv4 2/2] fuse: Call security hooks on new inodes
Date:   Wed, 22 Jul 2020 18:07:58 +0900
Message-Id: <20200722090758.3221812-2-chirantan@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
In-Reply-To: <20200722090758.3221812-1-chirantan@chromium.org>
References: <20200722090758.3221812-1-chirantan@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a new `init_security` field to `fuse_conn` that controls whether we
initialize security when a new inode is created.  Set this to true when
the `flags` field of the fuse_init_out struct contains
FUSE_SECURITY_CTX.

When set to true, get the security context for a newly created inode via
`security_dentry_init_security` and append it to the create, mkdir,
mknod, and symlink requests.

Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>
---
Changes in v4:
  * Added signoff to commit message.
  * Fixed style warnings reported by checkpatch.pl.

Changes in v3:
  * Moved uapi changes into a separate patch.
  * Refactored duplicated common code into create_new_entry.
  * Dropped check if security_ctxlen > 0 since kfree can handle NULL.

Changes in v2:
  * Added the FUSE_SECURITY_CTX flag for init_out responses.
  * Switched to security_dentry_init_security.
  * Send security context with create, mknod, mkdir, and symlink
    requests instead of applying it after creation.

 fs/fuse/dir.c    | 60 ++++++++++++++++++++++++++++++++++++++++++++----
 fs/fuse/fuse_i.h |  3 +++
 fs/fuse/inode.c  |  5 +++-
 3 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index ee190119f45cc..c6791c49afe4d 100644
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
@@ -513,6 +533,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	return err;
 
 out_free_ff:
+	kfree(security_ctx);
 	fuse_file_free(ff);
 out_put_forget_req:
 	kfree(forget);
@@ -569,13 +590,15 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
  */
 static int create_new_entry(struct fuse_conn *fc, struct fuse_args *args,
 			    struct inode *dir, struct dentry *entry,
-			    umode_t mode)
+			    umode_t mode, bool init_security)
 {
 	struct fuse_entry_out outarg;
 	struct inode *inode;
 	struct dentry *d;
 	int err;
 	struct fuse_forget_link *forget;
+	void *security_ctx = NULL;
+	u32 security_ctxlen = 0;
 
 	forget = fuse_alloc_forget();
 	if (!forget)
@@ -586,7 +609,29 @@ static int create_new_entry(struct fuse_conn *fc, struct fuse_args *args,
 	args->out_numargs = 1;
 	args->out_args[0].size = sizeof(outarg);
 	args->out_args[0].value = &outarg;
+
+	if (init_security) {
+		unsigned short idx = args->in_numargs;
+
+		if ((size_t)idx >= ARRAY_SIZE(args->in_args))
+			return -ENOMEM;
+
+		err = security_dentry_init_security(entry, mode, &entry->d_name,
+						    &security_ctx,
+						    &security_ctxlen);
+		if (err)
+			return err;
+
+		if (security_ctxlen > 0) {
+			args->in_args[idx].size = security_ctxlen;
+			args->in_args[idx].value = security_ctx;
+			args->in_numargs++;
+		}
+	}
+
 	err = fuse_simple_request(fc, args);
+	kfree(security_ctx);
+
 	if (err)
 		goto out_put_forget_req;
 
@@ -644,7 +689,8 @@ static int fuse_mknod(struct inode *dir, struct dentry *entry, umode_t mode,
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = entry->d_name.len + 1;
 	args.in_args[1].value = entry->d_name.name;
-	return create_new_entry(fc, &args, dir, entry, mode);
+
+	return create_new_entry(fc, &args, dir, entry, mode, fc->init_security);
 }
 
 static int fuse_create(struct inode *dir, struct dentry *entry, umode_t mode,
@@ -671,7 +717,9 @@ static int fuse_mkdir(struct inode *dir, struct dentry *entry, umode_t mode)
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = entry->d_name.len + 1;
 	args.in_args[1].value = entry->d_name.name;
-	return create_new_entry(fc, &args, dir, entry, S_IFDIR);
+
+	return create_new_entry(fc, &args, dir, entry, S_IFDIR,
+				fc->init_security);
 }
 
 static int fuse_symlink(struct inode *dir, struct dentry *entry,
@@ -687,7 +735,9 @@ static int fuse_symlink(struct inode *dir, struct dentry *entry,
 	args.in_args[0].value = entry->d_name.name;
 	args.in_args[1].size = len;
 	args.in_args[1].value = link;
-	return create_new_entry(fc, &args, dir, entry, S_IFLNK);
+
+	return create_new_entry(fc, &args, dir, entry, S_IFLNK,
+				fc->init_security);
 }
 
 void fuse_update_ctime(struct inode *inode)
@@ -858,7 +908,7 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = newent->d_name.len + 1;
 	args.in_args[1].value = newent->d_name.name;
-	err = create_new_entry(fc, &args, newdir, newent, inode->i_mode);
+	err = create_new_entry(fc, &args, newdir, newent, inode->i_mode, false);
 	/* Contrary to "normal" filesystems it can happen that link
 	   makes two "logical" inodes point to the same "physical"
 	   inode.  We invalidate the attributes of the old one, so it
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index d7cde216fc871..dd7422d83da3d 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -720,6 +720,9 @@ struct fuse_conn {
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
-- 
2.27.0.383.g050319c2ae-goog

