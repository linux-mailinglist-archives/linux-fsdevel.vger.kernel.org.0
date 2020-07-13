Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC1421D286
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 11:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgGMJJi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 05:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgGMJJi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 05:09:38 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23420C061755
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2020 02:09:38 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e8so5758850pgc.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2020 02:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zi+PKKm5ivgUA9X2phH4cAxKnmF/vG0BrCUQIVSsbjQ=;
        b=gpBVOKi2NEre+AygRyUvgwlN9NGez9nqlgz8AVvjoKbGaJWCYrzLH2spWGGmbDOFxn
         koNqlh36yMt/McJAytRh4L+AhY6vPmpMumz2xU9xOGpktZoNlt6ShAozvbRzamWNwAMy
         BhH3TLWPSnrCy0c2ZmXBLqMPm71DRfrjMD1Vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zi+PKKm5ivgUA9X2phH4cAxKnmF/vG0BrCUQIVSsbjQ=;
        b=fsbpsH73zmKDl3GvHKJHSeD/xJJL+5Fe60TIJaPW2XtQTNzUVb/ao1iGvkv78EfE82
         o5qPknYSe2Ji/JxFtYVLKtHRFiACyis1kAcl09N6gGtLmerSgDk02WZLYGtWgZiyf/14
         Ir6ighkgbRCXKstu9mX3QCcqq9yUGTgmbBdnq6elP3lOYOkHC4J+kgK1AOJzX0ZruHCR
         tjuqIJwen5/IHUT916NbKbnMMcivJa5tUcWK2VivH7KBEq27vLt/7GoucM67RVdyl7GW
         ZtlqWfkEWYF/4R+4EzSdkwXQIoalrV4/BByiDmCYTQsXwwde9DRqZk4k/WHl7ItlSItn
         9Lvw==
X-Gm-Message-State: AOAM533TlNn4+WErm5gCbyFt8qLrfEMgD4e2wDNYCfu9eTxMSv5lCL2b
        jXs+uBKC8yd21B6es0DJBKfzSg==
X-Google-Smtp-Source: ABdhPJxnM0KM8UP+XV6oClCL3RFHi93iB1AVBl8Qq/8v7f0WsECoz/JrwWnvuG5o7o7QUOaAq53+ew==
X-Received: by 2002:a63:182:: with SMTP id 124mr63760050pgb.288.1594631377586;
        Mon, 13 Jul 2020 02:09:37 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:2:f693:9fff:fef4:2537])
        by smtp.gmail.com with ESMTPSA id v15sm12455869pgo.15.2020.07.13.02.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 02:09:36 -0700 (PDT)
From:   Chirantan Ekbote <chirantan@chromium.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        fuse-devel@lists.sourceforge.net,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCHv3 2/2] fuse: Call security hooks on new inodes
Date:   Mon, 13 Jul 2020 18:09:21 +0900
Message-Id: <20200713090921.312962-2-chirantan@chromium.org>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
In-Reply-To: <20200713090921.312962-1-chirantan@chromium.org>
References: <20200610092744.140038-1-chirantan@chromium.org>
 <20200713090921.312962-1-chirantan@chromium.org>
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

---
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
index ee190119f45cc..b4045dc55bccd 100644
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
+		if ((size_t)idx >= ARRAY_SIZE(args->in_args)) {
+			return -ENOMEM;
+		}
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
+	unsigned int init_security:1;
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

