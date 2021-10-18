Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C3843223D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 17:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbhJRPLo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 11:11:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55066 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233507AbhJRPLY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634569751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BKYI5BvDsOXffIFvPU9sYAc5vgRXUjZkZYpsLpIFF08=;
        b=gDRLKHG1KGkhS6uduM7BPdhOgEmw4h8cn+uOseB2Ow9T0EfB5cw6PD+8Yh/0bW6z9jLTS/
        zgFktqiwNY7UuVcIHq6bDw1ZT6mbb75KL+5QV7mn+W7l8ndu2CT+gaYeuaTs3kzHBrqVZN
        p79lVn2YnYduYgWwML0V5WnPiPP0XaI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-NsdXsi1qNtu5WRFNMvnvUQ-1; Mon, 18 Oct 2021 11:09:08 -0400
X-MC-Unique: NsdXsi1qNtu5WRFNMvnvUQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88EB81006AA6;
        Mon, 18 Oct 2021 15:09:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8629C167A4;
        Mon, 18 Oct 2021 15:08:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 66/67] cachefiles: Add error injection support
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Oct 2021 16:08:57 +0100
Message-ID: <163456973776.2614702.12301119633219400267.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support for injecting ENOSPC or EIO errors.  This needs to be enabled
by CONFIG_CACHEFILES_ERROR_INJECTION=y.  Once enabled, ENOSPC on things
like write and mkdir can be triggered by:

	echo 1 >/proc/sys/cachefiles/error_injection

and EIO can be triggered on most operations by:

	echo 2 >/proc/sys/cachefiles/error_injection

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/Kconfig        |    8 ++++++
 fs/cachefiles/Makefile       |    2 +
 fs/cachefiles/error_inject.c |   46 ++++++++++++++++++++++++++++++++++
 fs/cachefiles/interface.c    |   21 +++++++++++----
 fs/cachefiles/internal.h     |   39 +++++++++++++++++++++++++++++
 fs/cachefiles/io.c           |   34 ++++++++++++++++++-------
 fs/cachefiles/main.c         |    7 +++++
 fs/cachefiles/namei.c        |   57 +++++++++++++++++++++++++++++++++---------
 fs/cachefiles/xattr.c        |   14 +++++++---
 9 files changed, 197 insertions(+), 31 deletions(-)
 create mode 100644 fs/cachefiles/error_inject.c

diff --git a/fs/cachefiles/Kconfig b/fs/cachefiles/Kconfig
index 6827b40f7ddc..c19515dd253e 100644
--- a/fs/cachefiles/Kconfig
+++ b/fs/cachefiles/Kconfig
@@ -19,3 +19,11 @@ config CACHEFILES_DEBUG
 	  caching on files module.  If this is set, the debugging output may be
 	  enabled by setting bits in /sys/modules/cachefiles/parameter/debug or
 	  by including a debugging specifier in /etc/cachefilesd.conf.
+
+
+config CACHEFILES_ERROR_INJECTION
+	bool "Provide error injection for cachefiles"
+	depends on CACHEFILES && SYSCTL
+	help
+	  This permits error injection to be enabled in cachefiles whilst a
+	  cache is in service.
diff --git a/fs/cachefiles/Makefile b/fs/cachefiles/Makefile
index 9062767331e8..c0df4c42cb09 100644
--- a/fs/cachefiles/Makefile
+++ b/fs/cachefiles/Makefile
@@ -15,4 +15,6 @@ cachefiles-y := \
 	volume.o \
 	xattr.o
 
+cachefiles-$(CONFIG_CACHEFILES_ERROR_INJECTION) += error_inject.o
+
 obj-$(CONFIG_CACHEFILES) := cachefiles.o
diff --git a/fs/cachefiles/error_inject.c b/fs/cachefiles/error_inject.c
new file mode 100644
index 000000000000..58f8aec964e4
--- /dev/null
+++ b/fs/cachefiles/error_inject.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Error injection handling.
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/sysctl.h>
+#include "internal.h"
+
+unsigned int cachefiles_error_injection_state;
+
+static struct ctl_table_header *cachefiles_sysctl;
+static struct ctl_table cachefiles_sysctls[] = {
+	{
+		.procname	= "error_injection",
+		.data		= &cachefiles_error_injection_state,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec,
+	},
+	{}
+};
+
+static struct ctl_table cachefiles_sysctls_root[] = {
+	{
+		.procname	= "cachefiles",
+		.mode		= 0555,
+		.child		= cachefiles_sysctls,
+	},
+	{}
+};
+
+int __init cachefiles_register_error_injection(void)
+{
+	cachefiles_sysctl = register_sysctl_table(cachefiles_sysctls_root);
+	if (!cachefiles_sysctl)
+		return -ENOMEM;
+	return 0;
+
+}
+
+void cachefiles_unregister_error_injection(void)
+{
+	unregister_sysctl_table(cachefiles_sysctl);
+}
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 115be503b23a..3c9710ceae86 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -151,7 +151,9 @@ static bool cachefiles_shorten_object(struct cachefiles_object *object,
 
 	trace_cachefiles_trunc(object, inode, i_size, dio_size,
 			       cachefiles_trunc_shrink);
-	ret = vfs_truncate(&file->f_path, dio_size);
+	ret = cachefiles_inject_remove_error();
+	if (ret == 0)
+		ret = vfs_truncate(&file->f_path, dio_size);
 	if (ret < 0) {
 		trace_cachefiles_io_error(object, file_inode(file), ret,
 					  cachefiles_trace_trunc_error);
@@ -163,8 +165,10 @@ static bool cachefiles_shorten_object(struct cachefiles_object *object,
 	if (new_size < dio_size) {
 		trace_cachefiles_trunc(object, inode, dio_size, new_size,
 				       cachefiles_trunc_dio_adjust);
-		ret = vfs_fallocate(file, FALLOC_FL_ZERO_RANGE,
-				    new_size, dio_size);
+		ret = cachefiles_inject_write_error();
+		if (ret == 0)
+			ret = vfs_fallocate(file, FALLOC_FL_ZERO_RANGE,
+					    new_size, dio_size);
 		if (ret < 0) {
 			trace_cachefiles_io_error(object, file_inode(file), ret,
 						  cachefiles_trace_fallocate_error);
@@ -374,15 +378,20 @@ static int cachefiles_attr_changed(struct cachefiles_object *object)
 		_debug("discard tail %llx", oi_size);
 		newattrs.ia_valid = ATTR_SIZE;
 		newattrs.ia_size = oi_size & PAGE_MASK;
-		ret = notify_change(&init_user_ns, file->f_path.dentry,
-				    &newattrs, NULL);
+		ret = cachefiles_inject_remove_error();
+		if (ret == 0)
+			ret = notify_change(&init_user_ns, file->f_path.dentry,
+					    &newattrs, NULL);
 		if (ret < 0)
 			goto truncate_failed;
 	}
 
 	newattrs.ia_valid = ATTR_SIZE;
 	newattrs.ia_size = ni_size;
-	ret = notify_change(&init_user_ns, file->f_path.dentry, &newattrs, NULL);
+	ret = cachefiles_inject_write_error();
+	if (ret == 0)
+		ret = notify_change(&init_user_ns, file->f_path.dentry,
+				    &newattrs, NULL);
 
 truncate_failed:
 	inode_unlock(file_inode(file));
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 3dd3e13989d6..096ee6376f2a 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -155,6 +155,45 @@ extern const struct file_operations cachefiles_daemon_fops;
 extern int cachefiles_has_space(struct cachefiles_cache *cache,
 				unsigned fnr, unsigned bnr);
 
+/*
+ * error_inject.c
+ */
+#ifdef CONFIG_CACHEFILES_ERROR_INJECTION
+extern unsigned int cachefiles_error_injection_state;
+extern int cachefiles_register_error_injection(void);
+extern void cachefiles_unregister_error_injection(void);
+
+#else
+#define cachefiles_error_injection_state 0
+
+static inline int cachefiles_register_error_injection(void)
+{
+	return 0;
+}
+
+static inline void cachefiles_unregister_error_injection(void)
+{
+}
+#endif
+
+
+static inline int cachefiles_inject_read_error(void)
+{
+	return cachefiles_error_injection_state & 2 ? -EIO : 0;
+}
+
+static inline int cachefiles_inject_write_error(void)
+{
+	return cachefiles_error_injection_state & 2 ? -EIO :
+		cachefiles_error_injection_state & 1 ? -ENOSPC :
+		0;
+}
+
+static inline int cachefiles_inject_remove_error(void)
+{
+	return cachefiles_error_injection_state & 2 ? -EIO : 0;
+}
+
 /*
  * interface.c
  */
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 136d0ea0a7c9..78e6ef781f73 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -100,7 +100,9 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 	if (read_hole != NETFS_READ_HOLE_IGNORE) {
 		loff_t off = start_pos, off2;
 
-		off2 = vfs_llseek(file, off, SEEK_DATA);
+		off2 = cachefiles_inject_read_error();
+		if (off2 == 0)
+			off2 = vfs_llseek(file, off, SEEK_DATA);
 		if (off2 < 0 && off2 >= (loff_t)-MAX_ERRNO && off2 != -ENXIO) {
 			skipped = 0;
 			ret = off2;
@@ -152,7 +154,9 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 
 	trace_cachefiles_read(object, file_inode(file), ki->iocb.ki_pos, len - skipped);
 	old_nofs = memalloc_nofs_save();
-	ret = vfs_iocb_iter_read(file, &ki->iocb, iter);
+	ret = cachefiles_inject_read_error();
+	if (ret == 0)
+		ret = vfs_iocb_iter_read(file, &ki->iocb, iter);
 	memalloc_nofs_restore(old_nofs);
 	switch (ret) {
 	case -EIOCBQUEUED:
@@ -273,7 +277,9 @@ static int cachefiles_write(struct netfs_cache_resources *cres,
 
 	trace_cachefiles_write(object, inode, ki->iocb.ki_pos, len);
 	old_nofs = memalloc_nofs_save();
-	ret = vfs_iocb_iter_write(file, &ki->iocb, iter);
+	ret = cachefiles_inject_write_error();
+	if (ret == 0)
+		ret = vfs_iocb_iter_write(file, &ki->iocb, iter);
 	memalloc_nofs_restore(old_nofs);
 	switch (ret) {
 	case -EIOCBQUEUED:
@@ -355,7 +361,9 @@ static enum netfs_read_source cachefiles_prepare_read(struct netfs_read_subreque
 	cache = object->volume->cache;
 	cachefiles_begin_secure(cache, &saved_cred);
 
-	off = vfs_llseek(file, subreq->start, SEEK_DATA);
+	off = cachefiles_inject_read_error();
+	if (off == 0)
+		off = vfs_llseek(file, subreq->start, SEEK_DATA);
 	if (off < 0 && off >= (loff_t)-MAX_ERRNO) {
 		if (off == (loff_t)-ENXIO) {
 			why = cachefiles_trace_read_seek_nxio;
@@ -379,7 +387,9 @@ static enum netfs_read_source cachefiles_prepare_read(struct netfs_read_subreque
 		goto download_and_store;
 	}
 
-	to = vfs_llseek(file, subreq->start, SEEK_HOLE);
+	to = cachefiles_inject_read_error();
+	if (to == 0)
+		to = vfs_llseek(file, subreq->start, SEEK_HOLE);
 	if (to < 0 && to >= (loff_t)-MAX_ERRNO) {
 		trace_cachefiles_io_error(object, file_inode(file), to,
 					  cachefiles_trace_seek_error);
@@ -434,7 +444,9 @@ static int __cachefiles_prepare_write(struct netfs_cache_resources *cres,
 	if (no_space_allocated_yet)
 		goto check_space;
 
-	pos = vfs_llseek(file, *_start, SEEK_DATA);
+	pos = cachefiles_inject_read_error();
+	if (pos == 0)
+		pos = vfs_llseek(file, *_start, SEEK_DATA);
 	if (pos < 0 && pos >= (loff_t)-MAX_ERRNO) {
 		if (pos == -ENXIO)
 			goto check_space; /* Unallocated tail */
@@ -452,7 +464,9 @@ static int __cachefiles_prepare_write(struct netfs_cache_resources *cres,
 	if (cachefiles_has_space(cache, 0, *_len / PAGE_SIZE) == 0)
 		return 0; /* Enough space to simply overwrite the whole block */
 
-	pos = vfs_llseek(file, *_start, SEEK_HOLE);
+	pos = cachefiles_inject_read_error();
+	if (pos == 0)
+		pos = vfs_llseek(file, *_start, SEEK_HOLE);
 	if (pos < 0 && pos >= (loff_t)-MAX_ERRNO) {
 		trace_cachefiles_io_error(object, file_inode(file), pos,
 					  cachefiles_trace_seek_error);
@@ -462,8 +476,10 @@ static int __cachefiles_prepare_write(struct netfs_cache_resources *cres,
 		return 0; /* Fully allocated */
 
 	/* Partially allocated, but insufficient space: cull. */
-	ret = vfs_fallocate(file, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-			    *_start, *_len);
+	pos = cachefiles_inject_remove_error();
+	if (pos == 0)
+		ret = vfs_fallocate(file, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+				    *_start, *_len);
 	if (ret < 0) {
 		trace_cachefiles_io_error(object, file_inode(file), ret,
 					  cachefiles_trace_fallocate_error);
diff --git a/fs/cachefiles/main.c b/fs/cachefiles/main.c
index 522fda828563..83f8a221a890 100644
--- a/fs/cachefiles/main.c
+++ b/fs/cachefiles/main.c
@@ -46,6 +46,10 @@ static int __init cachefiles_init(void)
 {
 	int ret;
 
+	ret = cachefiles_register_error_injection();
+	if (ret < 0)
+		goto error_einj;
+
 	ret = misc_register(&cachefiles_dev);
 	if (ret < 0)
 		goto error_dev;
@@ -67,6 +71,8 @@ static int __init cachefiles_init(void)
 error_object_jar:
 	misc_deregister(&cachefiles_dev);
 error_dev:
+	cachefiles_unregister_error_injection();
+error_einj:
 	pr_err("failed to register: %d\n", ret);
 	return ret;
 }
@@ -82,6 +88,7 @@ static void __exit cachefiles_exit(void)
 
 	kmem_cache_destroy(cachefiles_object_jar);
 	misc_deregister(&cachefiles_dev);
+	cachefiles_unregister_error_injection();
 }
 
 module_exit(cachefiles_exit);
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 12266c90e5f8..686480120570 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -116,7 +116,9 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 			dget(rep); /* Stop the dentry being negated if it's
 				    * only pinned by a file struct.
 				    */
-			ret = vfs_unlink(&init_user_ns, d_inode(dir), rep, NULL);
+			ret = cachefiles_inject_remove_error();
+			if (ret == 0)
+				ret = vfs_unlink(&init_user_ns, d_inode(dir), rep, NULL);
 			dput(rep);
 		}
 
@@ -230,7 +232,9 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 			.new_dentry	= grave,
 		};
 		trace_cachefiles_rename(object, rep, grave, why);
-		ret = vfs_rename(&rd);
+		ret = cachefiles_inject_read_error();
+		if (ret == 0)
+			ret = vfs_rename(&rd);
 		if (ret != 0)
 			trace_cachefiles_vfs_error(object, d_inode(dir),
 						   PTR_ERR(grave),
@@ -258,6 +262,8 @@ static int cachefiles_unlink(struct cachefiles_object *object,
 
 	trace_cachefiles_unlink(object, dentry, why);
 	ret = security_path_unlink(&path, dentry);
+	if (ret == 0)
+		ret = cachefiles_inject_remove_error();
 	if (ret == 0)
 		ret = vfs_unlink(&init_user_ns, d_backing_inode(fan), dentry, NULL);
 	if (ret != 0)
@@ -400,7 +406,12 @@ bool cachefiles_look_up_object(struct cachefiles_object *object)
 	_enter("OBJ%x,%s,", object->debug_id, object->d_name);
 
 	/* Look up path "cache/vol/fanout/file". */
-	dentry = lookup_positive_unlocked(object->d_name, fan, object->d_name_len);
+	ret = cachefiles_inject_read_error();
+	if (ret == 0)
+		dentry = lookup_positive_unlocked(object->d_name, fan,
+						  object->d_name_len);
+	else
+		dentry = ERR_PTR(ret);
 	trace_cachefiles_lookup(object, dentry);
 	if (IS_ERR(dentry)) {
 		if (dentry == ERR_PTR(-ENOENT))
@@ -449,7 +460,11 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 	inode_lock(d_inode(dir));
 
 retry:
-	subdir = lookup_one_len(dirname, dir, strlen(dirname));
+	ret = cachefiles_inject_read_error();
+	if (ret == 0)
+		subdir = lookup_one_len(dirname, dir, strlen(dirname));
+	else
+		subdir = ERR_PTR(ret);
 	if (IS_ERR(subdir)) {
 		trace_cachefiles_vfs_error(NULL, d_backing_inode(dir),
 					   PTR_ERR(subdir),
@@ -477,7 +492,9 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 		ret = security_path_mkdir(&path, subdir, 0700);
 		if (ret < 0)
 			goto mkdir_error;
-		ret = vfs_mkdir(&init_user_ns, d_inode(dir), subdir, 0700);
+		ret = cachefiles_inject_write_error();
+		if (ret == 0)
+			ret = vfs_mkdir(&init_user_ns, d_inode(dir), subdir, 0700);
 		if (ret < 0) {
 			trace_cachefiles_vfs_error(NULL, d_inode(dir), ret,
 						   cachefiles_trace_mkdir_error);
@@ -717,8 +734,12 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 
 	cachefiles_begin_secure(cache, &saved_cred);
 
-	path.mnt = cache->mnt,
-	path.dentry = vfs_tmpfile(&init_user_ns, fan, S_IFREG, O_RDWR);
+	path.mnt = cache->mnt;
+	ret = cachefiles_inject_write_error();
+	if (ret == 0)
+		path.dentry = vfs_tmpfile(&init_user_ns, fan, S_IFREG, O_RDWR);
+	else
+		path.dentry = ERR_PTR(ret);
 	if (IS_ERR(path.dentry)) {
 		trace_cachefiles_vfs_error(object, d_inode(fan), PTR_ERR(path.dentry),
 					   cachefiles_trace_tmpfile_error);
@@ -738,7 +759,9 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 	if (ni_size > 0) {
 		trace_cachefiles_trunc(object, d_backing_inode(path.dentry), 0, ni_size,
 				       cachefiles_trunc_expand_tmpfile);
-		ret = vfs_truncate(&path, ni_size);
+		ret = cachefiles_inject_write_error();
+		if (ret == 0)
+			ret = vfs_truncate(&path, ni_size);
 		if (ret < 0) {
 			trace_cachefiles_vfs_error(
 				object, d_backing_inode(path.dentry), ret,
@@ -784,7 +807,11 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
 	_enter(",%pD", object->file);
 
 	inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
-	dentry = lookup_one_len(object->d_name, fan, object->d_name_len);
+	ret = cachefiles_inject_read_error();
+	if (ret == 0)
+		dentry = lookup_one_len(object->d_name, fan, object->d_name_len);
+	else
+		dentry = ERR_PTR(ret);
 	if (IS_ERR(dentry)) {
 		trace_cachefiles_vfs_error(object, d_inode(fan), PTR_ERR(dentry),
 					   cachefiles_trace_lookup_error);
@@ -806,7 +833,11 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
 		}
 
 		dput(dentry);
-		dentry = lookup_one_len(object->d_name, fan, object->d_name_len);
+		ret = cachefiles_inject_read_error();
+		if (ret == 0)
+			dentry = lookup_one_len(object->d_name, fan, object->d_name_len);
+		else
+			dentry = ERR_PTR(ret);
 		if (IS_ERR(dentry)) {
 			trace_cachefiles_vfs_error(object, d_inode(fan), PTR_ERR(dentry),
 						   cachefiles_trace_lookup_error);
@@ -815,8 +846,10 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
 		}
 	}
 
-	ret = vfs_link(object->file->f_path.dentry, &init_user_ns,
-		       d_inode(fan), dentry, NULL);
+	ret = cachefiles_inject_read_error();
+	if (ret == 0)
+		ret = vfs_link(object->file->f_path.dentry, &init_user_ns,
+			       d_inode(fan), dentry, NULL);
 	if (ret < 0) {
 		trace_cachefiles_vfs_error(object, d_inode(fan), PTR_ERR(dentry),
 					   cachefiles_trace_link_error);
diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index e0f77329c3ec..2555b82be7e2 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -58,8 +58,10 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object)
 	if (len > 0)
 		memcpy(buf->data, fscache_get_aux(object->cookie), len);
 
-	ret = vfs_setxattr(&init_user_ns, dentry, cachefiles_xattr_cache,
-			   buf, sizeof(struct cachefiles_xattr) + len, 0);
+	ret = cachefiles_inject_write_error();
+	if (ret == 0)
+		ret = vfs_setxattr(&init_user_ns, dentry, cachefiles_xattr_cache,
+				   buf, sizeof(struct cachefiles_xattr) + len, 0);
 	if (ret < 0) {
 		trace_cachefiles_vfs_error(object, file_inode(file), ret,
 					   cachefiles_trace_setxattr_error);
@@ -99,7 +101,9 @@ int cachefiles_check_auxdata(struct cachefiles_object *object, struct file *file
 	if (!buf)
 		return -ENOMEM;
 
-	xlen = vfs_getxattr(&init_user_ns, dentry, cachefiles_xattr_cache, buf, tlen);
+	xlen = cachefiles_inject_read_error();
+	if (xlen == 0)
+		xlen = vfs_getxattr(&init_user_ns, dentry, cachefiles_xattr_cache, buf, tlen);
 	if (xlen != tlen) {
 		if (xlen < 0)
 			trace_cachefiles_vfs_error(object, file_inode(file), xlen,
@@ -139,7 +143,9 @@ int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
 {
 	int ret;
 
-	ret = vfs_removexattr(&init_user_ns, dentry, cachefiles_xattr_cache);
+	ret = cachefiles_inject_remove_error();
+	if (ret == 0)
+		ret = vfs_removexattr(&init_user_ns, dentry, cachefiles_xattr_cache);
 	if (ret < 0) {
 		trace_cachefiles_vfs_error(object, d_inode(dentry), ret,
 					   cachefiles_trace_remxattr_error);


