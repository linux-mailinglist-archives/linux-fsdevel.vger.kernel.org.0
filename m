Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B37E34268C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 20:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhCST4n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 15:56:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52004 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229912AbhCST4K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 15:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616183769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rHW8ynUufSJO3sBpTf1Y0b3Ylr5myqW3HxMSPyzCTJ0=;
        b=QjVO+naxn8TQku/RMb6WygXjbFBmHLDop+2l4WIFWNYSrZnhN5rSq0Kjhv71cyVXvrjS/7
        6yD4Pqk5HTBVC8IA1X1IKqe7F/b6Cwk+Qw4MfHQstdigJg81YJOZd/5VCZcaJgwIuTU0SC
        +tVkDDvyMxloFwLcj8KCSTTGpC9+OgM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-CjFlVhYHOIWrEz3fNK2EJA-1; Fri, 19 Mar 2021 15:56:07 -0400
X-MC-Unique: CjFlVhYHOIWrEz3fNK2EJA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AE47180FCA5;
        Fri, 19 Mar 2021 19:56:06 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-114.rdu2.redhat.com [10.10.114.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3EA760C16;
        Fri, 19 Mar 2021 19:56:02 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 425E9223D99; Fri, 19 Mar 2021 15:56:02 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, lhenriques@suse.de, dgilbert@redhat.com,
        seth.forshee@canonical.com
Subject: [PATCH 2/3] fuse: Add support for FUSE_SETXATTR_V2
Date:   Fri, 19 Mar 2021 15:55:46 -0400
Message-Id: <20210319195547.427371-3-vgoyal@redhat.com>
In-Reply-To: <20210319195547.427371-1-vgoyal@redhat.com>
References: <20210319195547.427371-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fuse client needs to send additional information to file server when
it calls SETXATTR(system.posix_acl_access). Right now there is no extra
space in fuse_setxattr_in. So introduce a v2 of the structure which has
more space in it and can be used to send extra flags.

"struct fuse_setxattr_in_v2" is only used if file server opts-in for it using
flag FUSE_SETXATTR_V2 during feature negotiations.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/acl.c             |  2 +-
 fs/fuse/fuse_i.h          |  5 ++++-
 fs/fuse/inode.c           |  4 +++-
 fs/fuse/xattr.c           | 21 +++++++++++++++------
 include/uapi/linux/fuse.h | 10 ++++++++++
 5 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index e9c0f916349d..d31260a139d4 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -94,7 +94,7 @@ int fuse_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 			return ret;
 		}
 
-		ret = fuse_setxattr(inode, name, value, size, 0);
+		ret = fuse_setxattr(inode, name, value, size, 0, 0);
 		kfree(value);
 	} else {
 		ret = fuse_removexattr(inode, name);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 63d97a15ffde..d00bf0b9a38c 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -668,6 +668,9 @@ struct fuse_conn {
 	/** Is setxattr not implemented by fs? */
 	unsigned no_setxattr:1;
 
+	/** Does file server support setxattr_v2 */
+	unsigned setxattr_v2:1;
+
 	/** Is getxattr not implemented by fs? */
 	unsigned no_getxattr:1;
 
@@ -1170,7 +1173,7 @@ void fuse_unlock_inode(struct inode *inode, bool locked);
 bool fuse_lock_inode(struct inode *inode);
 
 int fuse_setxattr(struct inode *inode, const char *name, const void *value,
-		  size_t size, int flags);
+		  size_t size, int flags, unsigned extra_flags);
 ssize_t fuse_getxattr(struct inode *inode, const char *name, void *value,
 		      size_t size);
 ssize_t fuse_listxattr(struct dentry *entry, char *list, size_t size);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index b0e18b470e91..1c726df13f80 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1052,6 +1052,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 				fc->handle_killpriv_v2 = 1;
 				fm->sb->s_flags |= SB_NOSEC;
 			}
+			if (arg->flags & FUSE_SETXATTR_V2)
+				fc->setxattr_v2 = 1;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1095,7 +1097,7 @@ void fuse_send_init(struct fuse_mount *fm)
 		FUSE_PARALLEL_DIROPS | FUSE_HANDLE_KILLPRIV | FUSE_POSIX_ACL |
 		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
 		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
-		FUSE_HANDLE_KILLPRIV_V2;
+		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_V2;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		ia->in.flags |= FUSE_MAP_ALIGNMENT;
diff --git a/fs/fuse/xattr.c b/fs/fuse/xattr.c
index 1a7d7ace54e1..f2aae72653dc 100644
--- a/fs/fuse/xattr.c
+++ b/fs/fuse/xattr.c
@@ -12,24 +12,33 @@
 #include <linux/posix_acl_xattr.h>
 
 int fuse_setxattr(struct inode *inode, const char *name, const void *value,
-		  size_t size, int flags)
+		  size_t size, int flags, unsigned extra_flags)
 {
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	FUSE_ARGS(args);
 	struct fuse_setxattr_in inarg;
+	struct fuse_setxattr_in_v2 inarg_v2;
+	bool setxattr_v2 = fm->fc->setxattr_v2;
 	int err;
 
 	if (fm->fc->no_setxattr)
 		return -EOPNOTSUPP;
 
 	memset(&inarg, 0, sizeof(inarg));
-	inarg.size = size;
-	inarg.flags = flags;
+	memset(&inarg_v2, 0, sizeof(inarg_v2));
+	if (setxattr_v2) {
+		inarg_v2.size = size;
+		inarg_v2.flags = flags;
+		inarg_v2.setxattr_flags = extra_flags;
+	} else {
+		inarg.size = size;
+		inarg.flags = flags;
+	}
 	args.opcode = FUSE_SETXATTR;
 	args.nodeid = get_node_id(inode);
 	args.in_numargs = 3;
-	args.in_args[0].size = sizeof(inarg);
-	args.in_args[0].value = &inarg;
+	args.in_args[0].size = setxattr_v2 ? sizeof(inarg_v2) : sizeof(inarg);
+	args.in_args[0].value = setxattr_v2 ? &inarg_v2 : (void *)&inarg;
 	args.in_args[1].size = strlen(name) + 1;
 	args.in_args[1].value = name;
 	args.in_args[2].size = size;
@@ -199,7 +208,7 @@ static int fuse_xattr_set(const struct xattr_handler *handler,
 	if (!value)
 		return fuse_removexattr(inode, name);
 
-	return fuse_setxattr(inode, name, value, size, flags);
+	return fuse_setxattr(inode, name, value, size, flags, 0);
 }
 
 static bool no_xattr_list(struct dentry *dentry)
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 54442612c48b..1bb555c1c117 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -179,6 +179,7 @@
  *  7.33
  *  - add FUSE_HANDLE_KILLPRIV_V2, FUSE_WRITE_KILL_SUIDGID, FATTR_KILL_SUIDGID
  *  - add FUSE_OPEN_KILL_SUIDGID
+ *  - add FUSE_SETXATTR_V2
  */
 
 #ifndef _LINUX_FUSE_H
@@ -330,6 +331,7 @@ struct fuse_file_lock {
  *			does not have CAP_FSETID. Additionally upon
  *			write/truncate sgid is killed only if file has group
  *			execute permission. (Same as Linux VFS behavior).
+ * FUSE_SETXATTR_V2:	Does file server support V2 of struct fuse_setxattr_in
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -360,6 +362,7 @@ struct fuse_file_lock {
 #define FUSE_MAP_ALIGNMENT	(1 << 26)
 #define FUSE_SUBMOUNTS		(1 << 27)
 #define FUSE_HANDLE_KILLPRIV_V2	(1 << 28)
+#define FUSE_SETXATTR_V2	(1 << 29)
 
 /**
  * CUSE INIT request/reply flags
@@ -686,6 +689,13 @@ struct fuse_setxattr_in {
 	uint32_t	flags;
 };
 
+struct fuse_setxattr_in_v2 {
+	uint32_t	size;
+	uint32_t	flags;
+	uint32_t	setxattr_flags;
+	uint32_t	padding;
+};
+
 struct fuse_getxattr_in {
 	uint32_t	size;
 	uint32_t	padding;
-- 
2.25.4

