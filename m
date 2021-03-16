Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2BD333D886
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 17:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238324AbhCPQCb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 12:02:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57324 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238319AbhCPQCL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615910530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RpDoQ8AsOCss8gD1PBUiqK6NIlIvAEU5+RvCWdVWyPQ=;
        b=E7nl/+oG+drWt1KH+3FZn9of/km/QUb6wB7hi5aaa0F8e38SmcrYi/KzDFlpAvBrLXOkSe
        4USO8FZjkNEO4OJv9xpVnW3N6uHXgNB6q/fgdNiuUj+kDqSeNLNQJo3gMytWyF94QF3GGG
        P3ACMTBH9tG8/QvmMVUNOw2xdC2tVU4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-4xFXcoZ3MryxGQL6Un3wfg-1; Tue, 16 Mar 2021 12:02:08 -0400
X-MC-Unique: 4xFXcoZ3MryxGQL6Un3wfg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2554580D69E;
        Tue, 16 Mar 2021 16:02:07 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-57.rdu2.redhat.com [10.10.114.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD24B1001281;
        Tue, 16 Mar 2021 16:02:01 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 68445223D98; Tue, 16 Mar 2021 12:02:01 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        miklos@szeredi.hu
Cc:     lhenriques@suse.de, dgilbert@redhat.com,
        seth.forshee@canonical.com, Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 1/1] fuse: send file mode updates using SETATTR
Date:   Tue, 16 Mar 2021 12:01:47 -0400
Message-Id: <20210316160147.289193-2-vgoyal@redhat.com>
In-Reply-To: <20210316160147.289193-1-vgoyal@redhat.com>
References: <20210316160147.289193-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If ACL changes, it is possible that file mode permission bits change. As of
now fuse client relies on file server to make those changes. But it does
not send enough information to server so that it can decide where SGID
bit should be cleared or not. Server does not know if caller has CAP_FSETID
or not. It also does not know what are caller's group memberships and if any
of the groups match file owner group.

So add a flag FUSE_POSIX_ACL_UPDATE_MODE where server can specify that if
mode changes due to ACL change, then client needs to send explicit SETATTR
to update mode.

Reported-by: Luis Henriques <lhenriques@suse.de>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/acl.c             | 54 ++++++++++++++++++++++++++++++++++++---
 fs/fuse/dir.c             | 11 ++++----
 fs/fuse/fuse_i.h          |  9 ++++++-
 fs/fuse/inode.c           |  4 ++-
 include/uapi/linux/fuse.h |  5 ++++
 5 files changed, 71 insertions(+), 12 deletions(-)

diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index e9c0f916349d..38920dcfb710 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -50,10 +50,31 @@ struct posix_acl *fuse_get_acl(struct inode *inode, int type)
 	return acl;
 }
 
+static int fuse_acl_mode_setattr(struct inode *inode, umode_t mode)
+{
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	FUSE_ARGS(args);
+	struct fuse_setattr_in inarg;
+	struct fuse_attr_out outarg;
+
+	memset(&inarg, 0, sizeof(inarg));
+	memset(&outarg, 0, sizeof(outarg));
+
+	inarg.valid = FATTR_MODE;
+	inarg.mode = mode;
+	fuse_setattr_fill(fm->fc, &args, inode, &inarg, &outarg);
+
+	return fuse_simple_request(fm, &args);
+}
+
 int fuse_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 		 struct posix_acl *acl, int type)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
+	umode_t new_mode;
+	bool update_mode = false;
+	size_t size = 0;
+	void *value =  NULL;
 	const char *name;
 	int ret;
 
@@ -63,9 +84,24 @@ int fuse_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 	if (!fc->posix_acl || fc->no_setxattr)
 		return -EOPNOTSUPP;
 
-	if (type == ACL_TYPE_ACCESS)
+	if (type == ACL_TYPE_ACCESS) {
 		name = XATTR_NAME_POSIX_ACL_ACCESS;
-	else if (type == ACL_TYPE_DEFAULT)
+		if (acl && fc->posix_acl_update_mode) {
+			/*
+			 * Setting access ACL might clear SGID.
+			 * Refresh inode->i_mode before making a decision.
+			 */
+			ret = fuse_do_getattr(inode, NULL, NULL);
+			if (ret)
+				return ret;
+			ret = posix_acl_update_mode(&init_user_ns, inode,
+						    &new_mode, &acl);
+			if (ret)
+				return ret;
+			if (new_mode != inode->i_mode)
+				update_mode = true;
+		}
+	} else if (type == ACL_TYPE_DEFAULT)
 		name = XATTR_NAME_POSIX_ACL_DEFAULT;
 	else
 		return -EINVAL;
@@ -78,8 +114,7 @@ int fuse_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 		 * them to be refreshed the next time they are used,
 		 * and it also updates i_ctime.
 		 */
-		size_t size = posix_acl_xattr_size(acl->a_count);
-		void *value;
+		size = posix_acl_xattr_size(acl->a_count);
 
 		if (size > PAGE_SIZE)
 			return -E2BIG;
@@ -93,8 +128,19 @@ int fuse_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 			kfree(value);
 			return ret;
 		}
+	}
+
+	if (update_mode) {
+		ret = fuse_acl_mode_setattr(inode, new_mode);
+		if (ret < 0) {
+			kfree(value);
+			return ret;
+		}
+	}
 
+	if (acl) {
 		ret = fuse_setxattr(inode, name, value, size, 0);
+		/* TODO: If setxattr failed, should we restore mode ? */
 		kfree(value);
 	} else {
 		ret = fuse_removexattr(inode, name);
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 06a18700a845..1d5c5aafb82d 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1022,8 +1022,7 @@ static void fuse_fillattr(struct inode *inode, struct fuse_attr *attr,
 	stat->blksize = 1 << blkbits;
 }
 
-static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
-			   struct file *file)
+int fuse_do_getattr(struct inode *inode, struct kstat *stat, struct file *file)
 {
 	int err;
 	struct fuse_getattr_in inarg;
@@ -1541,10 +1540,10 @@ void fuse_release_nowrite(struct inode *inode)
 	spin_unlock(&fi->lock);
 }
 
-static void fuse_setattr_fill(struct fuse_conn *fc, struct fuse_args *args,
-			      struct inode *inode,
-			      struct fuse_setattr_in *inarg_p,
-			      struct fuse_attr_out *outarg_p)
+void fuse_setattr_fill(struct fuse_conn *fc, struct fuse_args *args,
+		       struct inode *inode,
+		       struct fuse_setattr_in *inarg_p,
+		       struct fuse_attr_out *outarg_p)
 {
 	args->opcode = FUSE_SETATTR;
 	args->nodeid = get_node_id(inode);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 68cca8d4db6e..ba836daecd08 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -731,6 +731,9 @@ struct fuse_conn {
 	/** Does the filesystem support posix acls? */
 	unsigned posix_acl:1;
 
+	/** If posix acl results in file mode change, send update to fs */
+	unsigned posix_acl_update_mode:1;
+
 	/** Check permissions based on the file mode or not? */
 	unsigned default_permissions:1;
 
@@ -1097,6 +1100,7 @@ u64 fuse_lock_owner_id(struct fuse_conn *fc, fl_owner_t id);
 
 void fuse_update_ctime(struct inode *inode);
 
+int fuse_do_getattr(struct inode *inode, struct kstat *stat, struct file *file);
 int fuse_update_attributes(struct inode *inode, struct file *file);
 
 void fuse_flush_writepages(struct inode *inode);
@@ -1162,7 +1166,10 @@ int fuse_write_inode(struct inode *inode, struct writeback_control *wbc);
 
 int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 		    struct file *file);
-
+void fuse_setattr_fill(struct fuse_conn *fc, struct fuse_args *args,
+                       struct inode *inode,
+                       struct fuse_setattr_in *inarg_p,
+                       struct fuse_attr_out *outarg_p);
 void fuse_set_initialized(struct fuse_conn *fc);
 
 void fuse_unlock_inode(struct inode *inode, bool locked);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index b0e18b470e91..678145f987d1 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1052,6 +1052,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 				fc->handle_killpriv_v2 = 1;
 				fm->sb->s_flags |= SB_NOSEC;
 			}
+			if (arg->flags & FUSE_POSIX_ACL_UPDATE_MODE)
+				fc->posix_acl_update_mode = 1;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1095,7 +1097,7 @@ void fuse_send_init(struct fuse_mount *fm)
 		FUSE_PARALLEL_DIROPS | FUSE_HANDLE_KILLPRIV | FUSE_POSIX_ACL |
 		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
 		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
-		FUSE_HANDLE_KILLPRIV_V2;
+		FUSE_HANDLE_KILLPRIV_V2 | FUSE_POSIX_ACL_UPDATE_MODE;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		ia->in.flags |= FUSE_MAP_ALIGNMENT;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 98ca64d1beb6..89c3a88354f4 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -179,6 +179,7 @@
  *  7.33
  *  - add FUSE_HANDLE_KILLPRIV_V2, FUSE_WRITE_KILL_SUIDGID, FATTR_KILL_SUIDGID
  *  - add FUSE_OPEN_KILL_SUIDGID
+ *  - add FUSE_POSIX_ACL_UPDATE_MODE
  */
 
 #ifndef _LINUX_FUSE_H
@@ -330,6 +331,9 @@ struct fuse_file_lock {
  *			does not have CAP_FSETID. Additionally upon
  *			write/truncate sgid is killed only if file has group
  *			execute permission. (Same as Linux VFS behavior).
+ * FUSE_POSIX_ACL_UPDATE_MODE: When posix acl setting results in a mode change,
+ *                             client should send explicit setattr message to
+ *                             update mode.
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -360,6 +364,7 @@ struct fuse_file_lock {
 #define FUSE_MAP_ALIGNMENT	(1 << 26)
 #define FUSE_SUBMOUNTS		(1 << 27)
 #define FUSE_HANDLE_KILLPRIV_V2	(1 << 28)
+#define FUSE_POSIX_ACL_UPDATE_MODE	(1 << 29)
 
 /**
  * CUSE INIT request/reply flags
-- 
2.25.4

