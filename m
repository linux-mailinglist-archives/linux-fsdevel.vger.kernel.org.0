Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E808BEA81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 04:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbfIZCPA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 22:15:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35484 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfIZCPA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 22:15:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id y21so753643wmi.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2019 19:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tc76zzp+cLsNIF3taJlc89n9fKXApFgLIyKW9N9Ao+k=;
        b=CUZonNodkXHqOBBuGyaOaKoo5EJx9gAGvPzvjHYF72OC5JE98XUjOEVDleIS+ZwLh3
         Qxffd/xu2fyFQM2DFWZviL4YWI1YwchPSE5/PP+oK/KrTSrPfqacTx9lhriWA16ii15v
         IPZgPAhCjIMnPbGiTVEam30f70nItrVJWpFCeWCxT9BdC+BxYMK17Z1NwES0UlarC5Wf
         Ecr0gegUMKCGiXi++BuxcNFUHBTnd0HBsTS01bRy68QKYOrdtxjJQi5oiWUe/yUcST4q
         6JPvjSpAvWSam7iMa6ncDm7T5esIa7uOaWd1eR4iAavLhdnvfIaD+0FCUCFRJcsiGV4B
         XSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tc76zzp+cLsNIF3taJlc89n9fKXApFgLIyKW9N9Ao+k=;
        b=Gf+jwjIpG5VcUJ0/ExjM8rvsqHprnerU5tcvHBuC5YdIFM2Fy1mHaNDuZfFmu3hD9D
         /DlQWNTj36m7pojPG1pblW61pnCdOI5yscg7cytekjmQUrAUIInBlW4k0zlsT3K+ba5n
         3stKBzV4ffsBLoVi0sqS2jBuvqMYTuUFCBIHu374z+tsPMVSmQGhV9tU0WUDRCbC5k6p
         CpEhwEQFK8v2PzY3cU8egFf1BUKkL9xHMILeDaUG46jDHHTofFJx+VBV1jIjGaIPaZqi
         rvhsZ5sJBVFx0dxrctQ013FP0HrHka3DCH3QS9RFxeRpCztnkG4NcVRABhmS5oU2Wn0p
         XW/w==
X-Gm-Message-State: APjAAAUlMngAy5LeSfGvgYqQBa/ILOaO3LGGemYiIzVRyGhDAaEiZpom
        aXaZDSq3XToR5I6H2reFnQ9mkpBppno=
X-Google-Smtp-Source: APXvYqyDV8za4JpAf/Lru17wJg5qPye/vwxH/KJSrqqwqBFTEAHHGocOhbJpvETsHXKvOiAA1Lhqsw==
X-Received: by 2002:a1c:2d44:: with SMTP id t65mr839294wmt.12.1569464093319;
        Wed, 25 Sep 2019 19:14:53 -0700 (PDT)
Received: from Bfire.plexistor.com ([217.70.210.43])
        by smtp.googlemail.com with ESMTPSA id o19sm968751wro.50.2019.09.25.19.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 19:14:52 -0700 (PDT)
From:   Boaz Harrosh <boaz@plexistor.com>
X-Google-Original-From: Boaz Harrosh <boazh@netapp.com>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matt Benjamin <mbenjami@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Sagi Manole <sagim@netapp.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 15/16] zuf: xattr && acl implementation
Date:   Thu, 26 Sep 2019 05:07:24 +0300
Message-Id: <20190926020725.19601-16-boazh@netapp.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926020725.19601-1-boazh@netapp.com>
References: <20190926020725.19601-1-boazh@netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We establish the usual dispatch API to user-mode,
for get/set/list_xattr.
Since the buffers are variable length we utilize the
zdo->overflow_handler for the extra copy from Server.
(see also zuf-core.c)

The ACL support is all in Kernel. There is no new API
with zusFS.
We define the internal structure of the ACL inside
an opec xattr and store via the xattr zus_api.

TODO:
  Future FSs that have their own ACL on-disk-format, and/or
  Network zusFS that have their own verifiers for the ACL
  will need to establish an alternative API for the acl.

Signed-off-by: Boaz Harrosh <boazh@netapp.com>
---
 fs/zuf/Makefile   |   2 +-
 fs/zuf/_extern.h  |  20 +++
 fs/zuf/acl.c      | 270 +++++++++++++++++++++++++++++++++++++++
 fs/zuf/file.c     |   3 +
 fs/zuf/inode.c    |  18 +++
 fs/zuf/namei.c    |   6 +
 fs/zuf/super.c    |   2 +
 fs/zuf/symlink.c  |   1 +
 fs/zuf/xattr.c    | 314 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/zuf/zuf-core.c |   3 +
 fs/zuf/zuf.h      |  34 +++++
 fs/zuf/zus_api.h  |  25 +++-
 12 files changed, 696 insertions(+), 2 deletions(-)
 create mode 100644 fs/zuf/acl.c
 create mode 100644 fs/zuf/xattr.c

diff --git a/fs/zuf/Makefile b/fs/zuf/Makefile
index d3257bfc69ba..abc7dcda0029 100644
--- a/fs/zuf/Makefile
+++ b/fs/zuf/Makefile
@@ -17,7 +17,7 @@ zuf-y += md.o t1.o t2.o
 zuf-y += zuf-core.o zuf-root.o
 
 # Main FS
-zuf-y += ioctl.o
+zuf-y += ioctl.o acl.o xattr.o
 zuf-y += rw.o mmap.o
 zuf-y += super.o inode.o directory.o namei.o file.o symlink.o
 zuf-y += module.o
diff --git a/fs/zuf/_extern.h b/fs/zuf/_extern.h
index 04e0515469e7..d0d83eae75c1 100644
--- a/fs/zuf/_extern.h
+++ b/fs/zuf/_extern.h
@@ -132,6 +132,26 @@ long zuf_ioctl(struct file *filp, uint cmd, ulong arg);
 long zuf_compat_ioctl(struct file *file, uint cmd, ulong arg);
 #endif
 
+/* xattr.c */
+int zuf_initxattrs(struct inode *inode, const struct xattr *xattr_array,
+		   void *fs_info);
+ssize_t __zuf_getxattr(struct inode *inode, int type, const char *name,
+		       void *buffer, size_t size);
+int __zuf_setxattr(struct inode *inode, int type, const char *name,
+		   const void *value, size_t size, int flags);
+ssize_t zuf_listxattr(struct dentry *dentry, char *buffer, size_t size);
+extern const struct xattr_handler *zuf_xattr_handlers[];
+
+/* acl.c */
+int zuf_set_acl(struct inode *inode, struct posix_acl *acl, int type);
+struct posix_acl *zuf_get_acl(struct inode *inode, int type);
+int zuf_acls_create_pre(struct inode *dir, umode_t *mode,
+			struct posix_acl **def_acl, struct posix_acl **acl);
+int zuf_acls_create_post(struct inode *dir, struct inode *inode,
+			 struct posix_acl *def_acl, struct posix_acl *acl);
+extern const struct xattr_handler zuf_acl_access_xattr_handler;
+extern const struct xattr_handler zuf_acl_default_xattr_handler;
+
 /*
  * Inode and files operations
  */
diff --git a/fs/zuf/acl.c b/fs/zuf/acl.c
new file mode 100644
index 000000000000..fe2bcd2096bf
--- /dev/null
+++ b/fs/zuf/acl.c
@@ -0,0 +1,270 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Access Control List
+ *
+ * Copyright (c) 2018 NetApp Inc. All rights reserved.
+ *
+ * ZUFS-License: GPL-2.0. See module.c for LICENSE details.
+ *
+ * Authors:
+ *	Boaz Harrosh <boazh@netapp.com>
+ */
+
+#include <linux/fs.h>
+#include <linux/posix_acl_xattr.h>
+#include <linux/xattr.h>
+#include "zuf.h"
+
+static void _acl_to_value(const struct posix_acl *acl, void *value)
+{
+	int n;
+	struct zuf_acl *macl = value;
+
+	zuf_dbg_acl("acl->count=%d\n", acl->a_count);
+
+	for (n = 0; n < acl->a_count; n++) {
+		const struct posix_acl_entry *entry = &acl->a_entries[n];
+
+		zuf_dbg_acl("aclno=%d tag=0x%x perm=0x%x\n",
+			     n, entry->e_tag, entry->e_perm);
+
+		macl->tag = cpu_to_le16(entry->e_tag);
+		macl->perm = cpu_to_le16(entry->e_perm);
+
+		switch (entry->e_tag) {
+		case ACL_USER:
+			macl->id = cpu_to_le32(
+				from_kuid(&init_user_ns, entry->e_uid));
+			break;
+		case ACL_GROUP:
+			macl->id = cpu_to_le32(
+				from_kgid(&init_user_ns, entry->e_gid));
+			break;
+		case ACL_USER_OBJ:
+		case ACL_GROUP_OBJ:
+		case ACL_MASK:
+		case ACL_OTHER:
+			break;
+		default:
+			zuf_dbg_err("e_tag=0x%x\n", entry->e_tag);
+			return;
+		}
+		macl++;
+	}
+}
+
+static int __set_acl(struct inode *inode, struct posix_acl *acl, int type,
+		     bool set_mode)
+{
+	char *name = NULL;
+	void *buf;
+	int err;
+	size_t size;
+	umode_t old_mode = inode->i_mode;
+
+	zuf_dbg_acl("[%ld] acl=%p type=0x%x\n", inode->i_ino, acl, type);
+
+	switch (type) {
+	case ACL_TYPE_ACCESS: {
+		struct zus_inode *zi = ZUII(inode)->zi;
+
+		name = XATTR_POSIX_ACL_ACCESS;
+		if (acl && set_mode) {
+			err = posix_acl_update_mode(inode, &inode->i_mode,
+						    &acl);
+			if (err)
+				return err;
+
+			zuf_dbg_acl("old=0x%x new=0x%x acl_count=%d\n",
+				    old_mode, inode->i_mode,
+				    acl ? acl->a_count : -1);
+			inode->i_ctime = current_time(inode);
+			timespec_to_mt(&zi->i_ctime, &inode->i_ctime);
+			zi->i_mode = cpu_to_le16(inode->i_mode);
+		}
+		break;
+	}
+	case ACL_TYPE_DEFAULT:
+		name = XATTR_POSIX_ACL_DEFAULT;
+		if (!S_ISDIR(inode->i_mode))
+			return acl ? -EACCES : 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	size = acl ? acl->a_count * sizeof(struct zuf_acl) : 0;
+	buf = kmalloc(size, GFP_KERNEL);
+	if (unlikely(!buf))
+		return -ENOMEM;
+
+	if (acl)
+		_acl_to_value(acl, buf);
+
+	/* NOTE: Server's zus_setxattr implementers should cl_flush the zi.
+	 *  In the case it returned an error it should not cl_flush.
+	 *  We will restore to old i_mode.
+	 */
+	err = __zuf_setxattr(inode, ZUF_XF_SYSTEM, name, buf, size, 0);
+	if (likely(!err)) {
+		set_cached_acl(inode, type, acl);
+	} else {
+		/* Error need to restore changes (xfstest/generic/449) */
+		struct zus_inode *zi = ZUII(inode)->zi;
+
+		inode->i_mode = old_mode;
+		zi->i_mode = cpu_to_le16(inode->i_mode);
+	}
+
+	kfree(buf);
+	return err;
+}
+
+int zuf_set_acl(struct inode *inode, struct posix_acl *acl, int type)
+{
+	return __set_acl(inode, acl, type, true);
+}
+
+static struct posix_acl *_value_to_acl(void *value, size_t size)
+{
+	int n, count;
+	struct posix_acl *acl;
+	struct zuf_acl *macl = value;
+	void *end = value + size;
+
+	if (!value)
+		return NULL;
+
+	count = size / sizeof(struct zuf_acl);
+	if (count < 0)
+		return ERR_PTR(-EINVAL);
+	if (count == 0)
+		return NULL;
+
+	acl = posix_acl_alloc(count, GFP_NOFS);
+	if (unlikely(!acl))
+		return ERR_PTR(-ENOMEM);
+
+	for (n = 0; n < count; n++) {
+		if (end < (void *)macl + sizeof(struct zuf_acl))
+			goto fail;
+
+		zuf_dbg_acl("aclno=%d tag=0x%x perm=0x%x id=0x%x\n",
+			     n, le16_to_cpu(macl->tag), le16_to_cpu(macl->perm),
+			     le32_to_cpu(macl->id));
+
+		acl->a_entries[n].e_tag  = le16_to_cpu(macl->tag);
+		acl->a_entries[n].e_perm = le16_to_cpu(macl->perm);
+
+		switch (acl->a_entries[n].e_tag) {
+		case ACL_USER_OBJ:
+		case ACL_GROUP_OBJ:
+		case ACL_MASK:
+		case ACL_OTHER:
+			macl++;
+			break;
+		case ACL_USER:
+			acl->a_entries[n].e_uid = make_kuid(&init_user_ns,
+							le32_to_cpu(macl->id));
+			macl++;
+			if (end < (void *)macl)
+				goto fail;
+			break;
+		case ACL_GROUP:
+			acl->a_entries[n].e_gid = make_kgid(&init_user_ns,
+							le32_to_cpu(macl->id));
+			macl++;
+			if (end < (void *)macl)
+				goto fail;
+			break;
+
+		default:
+			goto fail;
+		}
+	}
+	if (macl != end)
+		goto fail;
+	return acl;
+
+fail:
+	posix_acl_release(acl);
+	return ERR_PTR(-EINVAL);
+}
+
+struct posix_acl *zuf_get_acl(struct inode *inode, int type)
+{
+	struct zuf_inode_info *zii = ZUII(inode);
+	char *name = NULL;
+	void *buf;
+	struct posix_acl *acl = NULL;
+	int ret;
+
+	zuf_dbg_acl("[%ld] type=0x%x\n", inode->i_ino, type);
+
+	buf = (void *)__get_free_page(GFP_KERNEL);
+	if (unlikely(!buf))
+		return ERR_PTR(-ENOMEM);
+
+	switch (type) {
+	case ACL_TYPE_ACCESS:
+		name = XATTR_POSIX_ACL_ACCESS;
+		break;
+	case ACL_TYPE_DEFAULT:
+		name = XATTR_POSIX_ACL_DEFAULT;
+		break;
+	default:
+		WARN_ON(1);
+		return ERR_PTR(-EINVAL);
+	}
+
+	zuf_smr_lock(zii);
+
+	ret = __zuf_getxattr(inode, ZUF_XF_SYSTEM, name, buf, PAGE_SIZE);
+	if (likely(ret > 0)) {
+		acl = _value_to_acl(buf, ret);
+	} else if (ret != -ENODATA) {
+		if (ret != 0)
+			zuf_dbg_err("failed to getattr ret=%d\n", ret);
+		acl = ERR_PTR(ret);
+	}
+
+	if (!IS_ERR(acl))
+		set_cached_acl(inode, type, acl);
+
+	zuf_smr_unlock(zii);
+
+	free_page((ulong)buf);
+
+	return acl;
+}
+
+/* Used by creation of new inodes */
+int zuf_acls_create_pre(struct inode *dir, umode_t *mode,
+			struct posix_acl **def_acl, struct posix_acl **acl)
+{
+	int err = posix_acl_create(dir, mode, def_acl, acl);
+
+	return err;
+}
+
+int zuf_acls_create_post(struct inode *dir, struct inode *inode,
+			 struct posix_acl *def_acl, struct posix_acl *acl)
+{
+	int err = 0, err2 = 0;
+
+	zuf_dbg_acl("def_acl_count=%d acl_count=%d\n",
+			def_acl ? def_acl->a_count : -1,
+			acl ? acl->a_count : -1);
+
+	if (def_acl)
+		err = __set_acl(inode, def_acl, ACL_TYPE_DEFAULT, false);
+	else
+		inode->i_default_acl = NULL;
+
+	if (acl)
+		err2 = __set_acl(inode, acl, ACL_TYPE_ACCESS, false);
+	else
+		inode->i_acl = NULL;
+
+	return err ?: err2;
+}
diff --git a/fs/zuf/file.c b/fs/zuf/file.c
index e0bd60e095e7..a4a788dcdc87 100644
--- a/fs/zuf/file.c
+++ b/fs/zuf/file.c
@@ -819,4 +819,7 @@ const struct inode_operations zuf_file_inode_operations = {
 	.getattr	= zuf_getattr,
 	.update_time	= zuf_update_time,
 	.fiemap		= zuf_fiemap,
+	.get_acl	= zuf_get_acl,
+	.set_acl	= zuf_set_acl,
+	.listxattr	= zuf_listxattr,
 };
diff --git a/fs/zuf/inode.c b/fs/zuf/inode.c
index 1e3dba654f34..ed324701a20b 100644
--- a/fs/zuf/inode.c
+++ b/fs/zuf/inode.c
@@ -287,6 +287,7 @@ void zuf_evict_inode(struct inode *inode)
 			_warn_inode_dirty(inode, zii->zi);
 
 		zuf_w_lock(zii);
+		zuf_xaw_lock(zii); /* Needed? probably not but palying safe */
 
 		zufc_goose_all_zts(ZUF_ROOT(SBI(sb)), inode);
 
@@ -295,6 +296,7 @@ void zuf_evict_inode(struct inode *inode)
 		inode->i_mtime = inode->i_ctime = current_time(inode);
 		inode->i_size = 0;
 
+		zuf_xaw_unlock(zii);
 		zuf_w_unlock(zii);
 	} else {
 		zuf_dbg_vfs("[%ld] inode is going down?\n", inode->i_ino);
@@ -341,6 +343,7 @@ struct inode *zuf_new_inode(struct inode *dir, umode_t mode,
 		.flags = tmpfile ? ZI_TMPFILE : 0,
 		.str.len = qstr->len,
 	};
+	struct posix_acl *acl = NULL, *def_acl = NULL;
 	struct inode *inode;
 	struct zus_inode *zi = NULL;
 	struct page *pages[2];
@@ -360,6 +363,15 @@ struct inode *zuf_new_inode(struct inode *dir, umode_t mode,
 
 	zuf_dbg_verbose("inode=%p name=%s\n", inode, qstr->name);
 
+	err = security_inode_init_security(inode, dir, qstr, zuf_initxattrs,
+					   NULL);
+	if (err && err != -EOPNOTSUPP)
+		goto fail;
+
+	err = zuf_acls_create_pre(dir, &inode->i_mode, &def_acl, &acl);
+	if (unlikely(err))
+		goto fail;
+
 	zuf_set_inode_flags(inode, &ioc_new_inode.zi);
 
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
@@ -400,6 +412,12 @@ struct inode *zuf_new_inode(struct inode *dir, umode_t mode,
 
 	zuf_dbg_verbose("allocating inode %ld (zi=%p)\n", _zi_ino(zi), zi);
 
+	if ((def_acl || acl) && !symname) {
+		err = zuf_acls_create_post(dir, inode, def_acl, acl);
+		if (unlikely(err))
+			goto fail;
+	}
+
 	err = insert_inode_locked(inode);
 	if (unlikely(err)) {
 		zuf_dbg_err("[%ld:%s] generation=%lld insert_inode_locked => %d\n",
diff --git a/fs/zuf/namei.c b/fs/zuf/namei.c
index e78aa04f10d5..a33745c328b9 100644
--- a/fs/zuf/namei.c
+++ b/fs/zuf/namei.c
@@ -420,10 +420,16 @@ const struct inode_operations zuf_dir_inode_operations = {
 	.setattr	= zuf_setattr,
 	.getattr	= zuf_getattr,
 	.update_time	= zuf_update_time,
+	.get_acl	= zuf_get_acl,
+	.set_acl	= zuf_set_acl,
+	.listxattr	= zuf_listxattr,
 };
 
 const struct inode_operations zuf_special_inode_operations = {
 	.setattr	= zuf_setattr,
 	.getattr	= zuf_getattr,
 	.update_time	= zuf_update_time,
+	.get_acl	= zuf_get_acl,
+	.set_acl	= zuf_set_acl,
+	.listxattr	= zuf_listxattr,
 };
diff --git a/fs/zuf/super.c b/fs/zuf/super.c
index 2a0db11b51d6..8f760e8b3fdc 100644
--- a/fs/zuf/super.c
+++ b/fs/zuf/super.c
@@ -553,6 +553,7 @@ static int zuf_fill_super(struct super_block *sb, void *data, int silent)
 		sb->s_flags |= SB_POSIXACL;
 
 	sb->s_op = &zuf_sops;
+	sb->s_xattr = zuf_xattr_handlers;
 
 	root_i = zuf_iget(sb, ioc_mount->zmi.zus_ii, ioc_mount->zmi._zi,
 			  &exist);
@@ -845,6 +846,7 @@ static void _init_once(void *foo)
 	inode_init_once(&zii->vfs_inode);
 	INIT_LIST_HEAD(&zii->i_mmap_dirty);
 	zii->zi = NULL;
+	init_rwsem(&zii->xa_rwsem);
 	init_rwsem(&zii->in_sync);
 	atomic_set(&zii->vma_count, 0);
 	atomic_set(&zii->write_mapped, 0);
diff --git a/fs/zuf/symlink.c b/fs/zuf/symlink.c
index 1446bdf60cb9..5e9115ba4cbd 100644
--- a/fs/zuf/symlink.c
+++ b/fs/zuf/symlink.c
@@ -70,4 +70,5 @@ const struct inode_operations zuf_symlink_inode_operations = {
 	.update_time	= zuf_update_time,
 	.setattr	= zuf_setattr,
 	.getattr	= zuf_getattr,
+	.listxattr	= zuf_listxattr,
 };
diff --git a/fs/zuf/xattr.c b/fs/zuf/xattr.c
new file mode 100644
index 000000000000..3c239bb7ec7e
--- /dev/null
+++ b/fs/zuf/xattr.c
@@ -0,0 +1,314 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Extended Attributes
+ *
+ * Copyright (c) 2018 NetApp Inc. All rights reserved.
+ *
+ * ZUFS-License: GPL-2.0. See module.c for LICENSE details.
+ *
+ * Authors:
+ *	Boaz Harrosh <boazh@netapp.com>
+ */
+
+#include <linux/fs.h>
+#include <linux/posix_acl_xattr.h>
+#include <linux/xattr.h>
+
+#include "zuf.h"
+
+/* ~~~~~~~~~~~~~~~ xattr get ~~~~~~~~~~~~~~~ */
+
+struct _xxxattr {
+	void *user_buffer;
+	union {
+		struct zufs_ioc_xattr ioc_xattr;
+		char buf[512];
+	} d;
+};
+
+static inline uint _XXXATTR_SIZE(uint ioc_size)
+{
+	struct _xxxattr *_xxxattr;
+
+	return ioc_size + (sizeof(*_xxxattr) - sizeof(_xxxattr->d));
+}
+
+static int _xattr_oh(struct zuf_dispatch_op *zdo, void *parg, ulong max_bytes)
+{
+	struct zufs_ioc_hdr *hdr = zdo->hdr;
+	struct zufs_ioc_xattr *ioc_xattr =
+			container_of(hdr, typeof(*ioc_xattr), hdr);
+	struct _xxxattr *_xxattr =
+			container_of(ioc_xattr, typeof(*_xxattr), d.ioc_xattr);
+	struct zufs_ioc_xattr *user_ioc_xattr = parg;
+
+	if (hdr->err)
+		return 0;
+
+	ioc_xattr->user_buf_size = user_ioc_xattr->user_buf_size;
+
+	hdr->out_len -= sizeof(ioc_xattr->user_buf_size);
+	memcpy(_xxattr->user_buffer, user_ioc_xattr->buf, hdr->out_len);
+	return 0;
+}
+
+ssize_t __zuf_getxattr(struct inode *inode, int type, const char *name,
+		       void *buffer, size_t size)
+{
+	size_t name_len = strlen(name) + 1; /* plus \NUL */
+	struct _xxxattr *p_xattr;
+	struct _xxxattr s_xattr;
+	enum big_alloc_type bat;
+	struct zufs_ioc_xattr *ioc_xattr;
+	size_t ioc_size = sizeof(*ioc_xattr) + name_len;
+	struct zuf_dispatch_op zdo;
+	int err;
+	ssize_t ret;
+
+	zuf_dbg_vfs("[%ld] type=%d name=%s size=%lu ioc_size=%lu\n",
+			inode->i_ino, type, name, size, ioc_size);
+
+	p_xattr = big_alloc(_XXXATTR_SIZE(ioc_size), sizeof(s_xattr), &s_xattr,
+			    GFP_KERNEL, &bat);
+	if (unlikely(!p_xattr))
+		return -ENOMEM;
+
+	ioc_xattr = &p_xattr->d.ioc_xattr;
+	memset(ioc_xattr, 0, sizeof(*ioc_xattr));
+	p_xattr->user_buffer = buffer;
+
+	ioc_xattr->hdr.in_len = ioc_size;
+	ioc_xattr->hdr.out_start =
+				offsetof(struct zufs_ioc_xattr, user_buf_size);
+	 /* out_len updated by zus */
+	ioc_xattr->hdr.out_len = sizeof(ioc_xattr->user_buf_size);
+	ioc_xattr->hdr.out_max = 0;
+	ioc_xattr->hdr.operation = ZUFS_OP_XATTR_GET;
+	ioc_xattr->zus_ii = ZUII(inode)->zus_ii;
+	ioc_xattr->type = type;
+	ioc_xattr->name_len = name_len;
+	ioc_xattr->user_buf_size = size;
+
+	strcpy(ioc_xattr->buf, name);
+
+	zuf_dispatch_init(&zdo, &ioc_xattr->hdr, NULL, 0);
+	zdo.oh = _xattr_oh;
+	err = __zufc_dispatch(ZUF_ROOT(SBI(inode->i_sb)), &zdo);
+	ret = ioc_xattr->user_buf_size;
+
+	big_free(p_xattr, bat);
+
+	if (unlikely(err))
+		return err;
+
+	return ret;
+}
+
+/* ~~~~~~~~~~~~~~~ xattr set ~~~~~~~~~~~~~~~ */
+
+int __zuf_setxattr(struct inode *inode, int type, const char *name,
+		   const void *value, size_t size, int flags)
+{
+	size_t name_len = strlen(name) + 1;
+	struct _xxxattr *p_xattr;
+	struct _xxxattr s_xattr;
+	enum big_alloc_type bat;
+	struct zufs_ioc_xattr *ioc_xattr;
+	size_t ioc_size = sizeof(*ioc_xattr) + name_len + size;
+	int err;
+
+	zuf_dbg_vfs("[%ld] type=%d name=%s size=%lu ioc_size=%lu\n",
+			inode->i_ino, type, name, size, ioc_size);
+
+	p_xattr = big_alloc(_XXXATTR_SIZE(ioc_size), sizeof(s_xattr), &s_xattr,
+			    GFP_KERNEL, &bat);
+	if (unlikely(!p_xattr))
+		return -ENOMEM;
+
+	ioc_xattr = &p_xattr->d.ioc_xattr;
+	memset(ioc_xattr, 0, sizeof(*ioc_xattr));
+
+	ioc_xattr->hdr.in_len = ioc_size;
+	ioc_xattr->hdr.out_len = 0;
+	ioc_xattr->hdr.operation = ZUFS_OP_XATTR_SET;
+	ioc_xattr->zus_ii = ZUII(inode)->zus_ii;
+	ioc_xattr->type = type;
+	ioc_xattr->name_len = name_len;
+	ioc_xattr->user_buf_size = size;
+	ioc_xattr->flags = flags;
+
+	if (value && !size)
+		ioc_xattr->ioc_flags = ZUFS_XATTR_SET_EMPTY;
+
+	strcpy(ioc_xattr->buf, name);
+	if (value)
+		memcpy(ioc_xattr->buf + name_len, value, size);
+
+	err = zufc_dispatch(ZUF_ROOT(SBI(inode->i_sb)), &ioc_xattr->hdr,
+			    NULL, 0);
+
+	big_free(p_xattr, bat);
+
+	return err;
+}
+
+/* ~~~~~~~~~~~~~~~ xattr list ~~~~~~~~~~~~~~~ */
+
+static ssize_t __zuf_listxattr(struct inode *inode, char *buffer, size_t size)
+{
+	struct zuf_inode_info *zii = ZUII(inode);
+	struct _xxxattr s_xattr;
+	struct zufs_ioc_xattr *ioc_xattr;
+	struct zuf_dispatch_op zdo;
+
+	int err;
+
+	zuf_dbg_vfs("[%ld] size=%lu\n", inode->i_ino, size);
+
+	ioc_xattr = &s_xattr.d.ioc_xattr;
+	memset(ioc_xattr, 0, sizeof(*ioc_xattr));
+	s_xattr.user_buffer = buffer;
+
+	ioc_xattr->hdr.in_len = sizeof(*ioc_xattr);
+	ioc_xattr->hdr.out_start =
+				offsetof(struct zufs_ioc_xattr, user_buf_size);
+	 /* out_len updated by zus */
+	ioc_xattr->hdr.out_len = sizeof(ioc_xattr->user_buf_size);
+	ioc_xattr->hdr.out_max = 0;
+	ioc_xattr->hdr.operation = ZUFS_OP_XATTR_LIST;
+	ioc_xattr->zus_ii = zii->zus_ii;
+	ioc_xattr->name_len = 0;
+	ioc_xattr->user_buf_size = size;
+	ioc_xattr->ioc_flags = capable(CAP_SYS_ADMIN) ? ZUFS_XATTR_TRUSTED : 0;
+
+	zuf_dispatch_init(&zdo, &ioc_xattr->hdr, NULL, 0);
+	zdo.oh = _xattr_oh;
+	err = __zufc_dispatch(ZUF_ROOT(SBI(inode->i_sb)), &zdo);
+	if (unlikely(err))
+		return err;
+
+	return ioc_xattr->user_buf_size;
+}
+
+ssize_t zuf_listxattr(struct dentry *dentry, char *buffer, size_t size)
+{
+	struct inode *inode = dentry->d_inode;
+	struct zuf_inode_info *zii = ZUII(inode);
+	ssize_t ret;
+
+	zuf_xar_lock(zii);
+
+	ret = __zuf_listxattr(inode, buffer, size);
+
+	zuf_xar_unlock(zii);
+
+	return ret;
+}
+
+/* ~~~~~~~~~~~~~~~ xattr sb handlers ~~~~~~~~~~~~~~~ */
+static bool zuf_xattr_handler_list(struct dentry *dentry)
+{
+	return true;
+}
+
+static
+int zuf_xattr_handler_get(const struct xattr_handler *handler,
+			  struct dentry *dentry, struct inode *inode,
+			  const char *name, void *value, size_t size)
+{
+	struct zuf_inode_info *zii = ZUII(inode);
+	int ret;
+
+	zuf_dbg_xattr("[%ld] name=%s\n", inode->i_ino, name);
+
+	zuf_xar_lock(zii);
+
+	ret = __zuf_getxattr(inode, handler->flags, name, value, size);
+
+	zuf_xar_unlock(zii);
+
+	return ret;
+}
+
+static
+int zuf_xattr_handler_set(const struct xattr_handler *handler,
+			  struct dentry *d_notused, struct inode *inode,
+			  const char *name, const void *value, size_t size,
+			  int flags)
+{
+	struct zuf_inode_info *zii = ZUII(inode);
+	int err;
+
+	zuf_dbg_xattr("[%ld] name=%s size=0x%lx flags=0x%x\n",
+			inode->i_ino, name, size, flags);
+
+	zuf_xaw_lock(zii);
+
+	err = __zuf_setxattr(inode, handler->flags, name, value, size, flags);
+
+	zuf_xaw_unlock(zii);
+
+	return err;
+}
+
+const struct xattr_handler zuf_xattr_security_handler = {
+	.prefix	= XATTR_SECURITY_PREFIX,
+	.flags = ZUF_XF_SECURITY,
+	.list	= zuf_xattr_handler_list,
+	.get	= zuf_xattr_handler_get,
+	.set	= zuf_xattr_handler_set,
+};
+
+const struct xattr_handler zuf_xattr_trusted_handler = {
+	.prefix	= XATTR_TRUSTED_PREFIX,
+	.flags = ZUF_XF_TRUSTED,
+	.list	= zuf_xattr_handler_list,
+	.get	= zuf_xattr_handler_get,
+	.set	= zuf_xattr_handler_set,
+};
+
+const struct xattr_handler zuf_xattr_user_handler = {
+	.prefix	= XATTR_USER_PREFIX,
+	.flags = ZUF_XF_USER,
+	.list	= zuf_xattr_handler_list,
+	.get	= zuf_xattr_handler_get,
+	.set	= zuf_xattr_handler_set,
+};
+
+const struct xattr_handler *zuf_xattr_handlers[] = {
+	&zuf_xattr_user_handler,
+	&zuf_xattr_trusted_handler,
+	&zuf_xattr_security_handler,
+	&posix_acl_access_xattr_handler,
+	&posix_acl_default_xattr_handler,
+	NULL
+};
+
+/*
+ * Callback for security_inode_init_security() for acquiring xattrs.
+ */
+int zuf_initxattrs(struct inode *inode, const struct xattr *xattr_array,
+		   void *fs_info)
+{
+	const struct xattr *xattr;
+
+	for (xattr = xattr_array; xattr->name != NULL; xattr++) {
+		int err;
+
+		/* REMOVEME: We had a BUG here for a long time that never
+		 * crashed, I want to see this is called, please.
+		 */
+		zuf_warn("Yes it is name=%s value-size=%zd\n",
+			  xattr->name, xattr->value_len);
+
+		err = zuf_xattr_handler_set(&zuf_xattr_security_handler, NULL,
+					    inode, xattr->name, xattr->value,
+					    xattr->value_len, 0);
+		if (unlikely(err)) {
+			zuf_err("[%ld] failed to init xattrs err=%d\n",
+				 inode->i_ino, err);
+			return err;
+		}
+	}
+	return 0;
+}
diff --git a/fs/zuf/zuf-core.c b/fs/zuf/zuf-core.c
index 9b8fe3bff0cd..d3252ca7d2d1 100644
--- a/fs/zuf/zuf-core.c
+++ b/fs/zuf/zuf-core.c
@@ -107,6 +107,9 @@ const char *zuf_op_name(enum e_zufs_operation op)
 		CASE_ENUM_NAME(ZUFS_OP_FALLOCATE);
 		CASE_ENUM_NAME(ZUFS_OP_LLSEEK);
 		CASE_ENUM_NAME(ZUFS_OP_IOCTL);
+		CASE_ENUM_NAME(ZUFS_OP_XATTR_GET);
+		CASE_ENUM_NAME(ZUFS_OP_XATTR_SET);
+		CASE_ENUM_NAME(ZUFS_OP_XATTR_LIST);
 		CASE_ENUM_NAME(ZUFS_OP_FIEMAP);
 
 		CASE_ENUM_NAME(ZUFS_OP_GET_MULTY);
diff --git a/fs/zuf/zuf.h b/fs/zuf/zuf.h
index fe479cb70f97..4a1d474eb80b 100644
--- a/fs/zuf/zuf.h
+++ b/fs/zuf/zuf.h
@@ -130,6 +130,8 @@ enum {
 struct zuf_inode_info {
 	struct inode		vfs_inode;
 
+	/* Lock for xattr operations */
+	struct rw_semaphore	xa_rwsem;
 	/* Stuff for mmap write */
 	struct rw_semaphore	in_sync;
 	struct list_head	i_mmap_dirty;
@@ -313,6 +315,38 @@ static inline void ZUF_CHECK_I_W_LOCK(struct inode *inode)
 		up_write(&inode->i_rwsem);
 #endif
 }
+static inline void zuf_xar_lock(struct zuf_inode_info *zii)
+{
+	down_read(&zii->xa_rwsem);
+}
+
+static inline void zuf_xar_unlock(struct zuf_inode_info *zii)
+{
+	up_read(&zii->xa_rwsem);
+}
+
+static inline void zuf_xaw_lock(struct zuf_inode_info *zii)
+{
+	down_write(&zii->xa_rwsem);
+}
+
+static inline void zuf_xaw_unlock(struct zuf_inode_info *zii)
+{
+	up_write(&zii->xa_rwsem);
+}
+
+/* xattr types */
+enum {	ZUF_XF_SECURITY    = 1,
+	ZUF_XF_SYSTEM      = 2,
+	ZUF_XF_TRUSTED     = 3,
+	ZUF_XF_USER        = 4,
+};
+
+struct zuf_acl {
+	__le16	tag;
+	__le16	perm;
+	__le32	id;
+};
 
 enum big_alloc_type { ba_stack, ba_8k, ba_vmalloc };
 #define S_8K (1024UL * 8)
diff --git a/fs/zuf/zus_api.h b/fs/zuf/zus_api.h
index 4ebb067c0719..1359f0384f82 100644
--- a/fs/zuf/zus_api.h
+++ b/fs/zuf/zus_api.h
@@ -467,6 +467,9 @@ enum e_zufs_operation {
 	ZUFS_OP_FALLOCATE	= 21,
 	ZUFS_OP_LLSEEK		= 22,
 	ZUFS_OP_IOCTL		= 23,
+	ZUFS_OP_XATTR_GET	= 24,
+	ZUFS_OP_XATTR_SET	= 25,
+	ZUFS_OP_XATTR_LIST	= 27,
 	ZUFS_OP_FIEMAP		= 28,
 
 	ZUFS_OP_GET_MULTY	= 29,
@@ -745,6 +748,26 @@ struct zufs_ioc_ioctl {
 	};
 };
 
+/* ZUFS_OP_XATTR */
+/* xattr ioc_flags */
+#define ZUFS_XATTR_SET_EMPTY	(1 << 0)
+#define ZUFS_XATTR_TRUSTED	(1 << 1)
+
+struct zufs_ioc_xattr {
+	struct zufs_ioc_hdr hdr;
+	/* IN */
+	struct zus_inode_info *zus_ii;
+	__u32	flags;
+	__u32	type;
+	__u16	name_len;
+	__u16	ioc_flags;
+
+	/* OUT */
+	__u32	user_buf_size;
+	char	buf[0];
+};
+
+
 /* ZUFS_OP_FIEMAP */
 struct zufs_ioc_fiemap {
 	struct zufs_ioc_hdr hdr;
@@ -760,7 +783,7 @@ struct zufs_ioc_fiemap {
 	__u32	extents_mapped;
 	__u32	pad;
 
-} __packed;
+};
 
 struct zufs_fiemap_extent_info {
 	struct fiemap_extent *fi_extents_start;
-- 
2.21.0

