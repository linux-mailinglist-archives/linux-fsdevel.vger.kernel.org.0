Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76A842A58A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 15:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbhJLNZ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 09:25:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27234 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236601AbhJLNZT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 09:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634044995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=16Pi/Vl3z4Y6fWeRQLWZMbFJzaAfXOnksHfTN4qiRaM=;
        b=T464ilO0MzkK7hRRpBtP41rxFU1nItnGbJh/H1mEzWULLsjdDayWq+mPii2CVswppJOrBm
        ahZWWnIr8dINJW87eocsDa0P9AmCs7hD1E4GQasdApmCMOIki0uz4Ta78uIpCUNZR/EypS
        eg9jDJpbpYvWBxUhCR8cx1irK5d3xRs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-N96qR4scM5GRFblvNBpOUQ-1; Tue, 12 Oct 2021 09:23:12 -0400
X-MC-Unique: N96qR4scM5GRFblvNBpOUQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7615A801AA7;
        Tue, 12 Oct 2021 13:23:09 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.9.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFA845D9C6;
        Tue, 12 Oct 2021 13:23:07 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 1DA0822023A; Tue, 12 Oct 2021 09:23:07 -0400 (EDT)
Date:   Tue, 12 Oct 2021 09:23:07 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, serge@hallyn.com
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        Miklos Szeredi <miklos@szeredi.hu>, dwalsh@redhat.com,
        jlayton@kernel.org, idryomov@gmail.com, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, bfields@fieldses.org,
        chuck.lever@oracle.com, anna.schumaker@netapp.com,
        trond.myklebust@hammerspace.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v2] security: Return xattr name from
 security_dentry_init_security()
Message-ID: <YWWMO/ZDrvDZ5X4c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Right now security_dentry_init_security() only supports single security
label and is used by SELinux only. There are two users of of this hook,
namely ceph and nfs.

NFS does not care about xattr name. Ceph hardcodes the xattr name to
security.selinux (XATTR_NAME_SELINUX).

I am making changes to fuse/virtiofs to send security label to virtiofsd
and I need to send xattr name as well. I also hardcoded the name of
xattr to security.selinux.

Stephen Smalley suggested that it probably is a good idea to modify
security_dentry_init_security() to also return name of xattr so that
we can avoid this hardcoding in the callers.

This patch adds a new parameter "const char **xattr_name" to
security_dentry_init_security() and LSM puts the name of xattr
too if caller asked for it (xattr_name != NULL).

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---

Changes since v1:
- Updated comment to make it clear caller does not have to free the
  xattr_name. (Jeff Layton).
- Captured Jeff's Reviewed-by ack.

I have tested this patch with virtiofs and compile tested for ceph and nfs.

NFS changes are trivial. Looking for an ack from NFS maintainers.

---
 fs/ceph/xattr.c               |    3 +--
 fs/nfs/nfs4proc.c             |    3 ++-
 include/linux/lsm_hook_defs.h |    3 ++-
 include/linux/lsm_hooks.h     |    3 +++
 include/linux/security.h      |    6 ++++--
 security/security.c           |    7 ++++---
 security/selinux/hooks.c      |    6 +++++-
 7 files changed, 21 insertions(+), 10 deletions(-)

Index: redhat-linux/security/selinux/hooks.c
===================================================================
--- redhat-linux.orig/security/selinux/hooks.c	2021-10-04 15:40:28.978453324 -0400
+++ redhat-linux/security/selinux/hooks.c	2021-10-06 15:20:57.745247170 -0400
@@ -2948,7 +2948,8 @@ static void selinux_inode_free_security(
 }
 
 static int selinux_dentry_init_security(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
+					const struct qstr *name,
+					const char **xattr_name, void **ctx,
 					u32 *ctxlen)
 {
 	u32 newsid;
@@ -2961,6 +2962,9 @@ static int selinux_dentry_init_security(
 	if (rc)
 		return rc;
 
+	if (xattr_name)
+		*xattr_name = XATTR_NAME_SELINUX;
+
 	return security_sid_to_context(&selinux_state, newsid, (char **)ctx,
 				       ctxlen);
 }
Index: redhat-linux/security/security.c
===================================================================
--- redhat-linux.orig/security/security.c	2021-10-04 15:40:28.978453324 -0400
+++ redhat-linux/security/security.c	2021-10-06 15:20:57.749247170 -0400
@@ -1052,11 +1052,12 @@ void security_inode_free(struct inode *i
 }
 
 int security_dentry_init_security(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen)
+				  const struct qstr *name,
+				  const char **xattr_name, void **ctx,
+				  u32 *ctxlen)
 {
 	return call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
-				name, ctx, ctxlen);
+				name, xattr_name, ctx, ctxlen);
 }
 EXPORT_SYMBOL(security_dentry_init_security);
 
Index: redhat-linux/include/linux/lsm_hooks.h
===================================================================
--- redhat-linux.orig/include/linux/lsm_hooks.h	2021-10-04 15:40:28.978453324 -0400
+++ redhat-linux/include/linux/lsm_hooks.h	2021-10-12 09:05:00.830399245 -0400
@@ -196,6 +196,9 @@
  *	@dentry dentry to use in calculating the context.
  *	@mode mode used to determine resource type.
  *	@name name of the last path component used to create file
+ *	@xattr_name pointer to place the pointer to security xattr name.
+ *		    Caller does not have to free the resulting pointer. Its
+ *		    a pointer to static string.
  *	@ctx pointer to place the pointer to the resulting context in.
  *	@ctxlen point to place the length of the resulting context.
  * @dentry_create_files_as:
Index: redhat-linux/include/linux/security.h
===================================================================
--- redhat-linux.orig/include/linux/security.h	2021-10-04 15:40:28.978453324 -0400
+++ redhat-linux/include/linux/security.h	2021-10-06 15:20:57.751247170 -0400
@@ -317,8 +317,9 @@ int security_add_mnt_opt(const char *opt
 				int len, void **mnt_opts);
 int security_move_mount(const struct path *from_path, const struct path *to_path);
 int security_dentry_init_security(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen);
+				  const struct qstr *name,
+				  const char **xattr_name, void **ctx,
+				  u32 *ctxlen);
 int security_dentry_create_files_as(struct dentry *dentry, int mode,
 					struct qstr *name,
 					const struct cred *old,
@@ -739,6 +740,7 @@ static inline void security_inode_free(s
 static inline int security_dentry_init_security(struct dentry *dentry,
 						 int mode,
 						 const struct qstr *name,
+						 const char **xattr_name,
 						 void **ctx,
 						 u32 *ctxlen)
 {
Index: redhat-linux/include/linux/lsm_hook_defs.h
===================================================================
--- redhat-linux.orig/include/linux/lsm_hook_defs.h	2021-10-04 15:40:28.978453324 -0400
+++ redhat-linux/include/linux/lsm_hook_defs.h	2021-10-06 15:20:57.752247170 -0400
@@ -83,7 +83,8 @@ LSM_HOOK(int, 0, sb_add_mnt_opt, const c
 LSM_HOOK(int, 0, move_mount, const struct path *from_path,
 	 const struct path *to_path)
 LSM_HOOK(int, 0, dentry_init_security, struct dentry *dentry,
-	 int mode, const struct qstr *name, void **ctx, u32 *ctxlen)
+	 int mode, const struct qstr *name, const char **xattr_name,
+	 void **ctx, u32 *ctxlen)
 LSM_HOOK(int, 0, dentry_create_files_as, struct dentry *dentry, int mode,
 	 struct qstr *name, const struct cred *old, struct cred *new)
 
Index: redhat-linux/fs/nfs/nfs4proc.c
===================================================================
--- redhat-linux.orig/fs/nfs/nfs4proc.c	2021-10-04 15:40:28.978453324 -0400
+++ redhat-linux/fs/nfs/nfs4proc.c	2021-10-06 15:20:57.754247170 -0400
@@ -127,7 +127,8 @@ nfs4_label_init_security(struct inode *d
 		return NULL;
 
 	err = security_dentry_init_security(dentry, sattr->ia_mode,
-				&dentry->d_name, (void **)&label->label, &label->len);
+				&dentry->d_name, NULL,
+				(void **)&label->label, &label->len);
 	if (err == 0)
 		return label;
 
Index: redhat-linux/fs/ceph/xattr.c
===================================================================
--- redhat-linux.orig/fs/ceph/xattr.c	2021-10-04 15:40:28.978453324 -0400
+++ redhat-linux/fs/ceph/xattr.c	2021-10-06 15:20:57.756247170 -0400
@@ -1311,7 +1311,7 @@ int ceph_security_init_secctx(struct den
 	int err;
 
 	err = security_dentry_init_security(dentry, mode, &dentry->d_name,
-					    &as_ctx->sec_ctx,
+					    &name, &as_ctx->sec_ctx,
 					    &as_ctx->sec_ctxlen);
 	if (err < 0) {
 		WARN_ON_ONCE(err != -EOPNOTSUPP);
@@ -1335,7 +1335,6 @@ int ceph_security_init_secctx(struct den
 	 * It only supports single security module and only selinux has
 	 * dentry_init_security hook.
 	 */
-	name = XATTR_NAME_SELINUX;
 	name_len = strlen(name);
 	err = ceph_pagelist_reserve(pagelist,
 				    4 * 2 + name_len + as_ctx->sec_ctxlen);

