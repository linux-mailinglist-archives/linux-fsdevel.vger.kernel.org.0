Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0E946F073
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 18:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242249AbhLIRI6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 12:08:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53673 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242290AbhLIRH2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:07:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639069432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XDS6pAZ5iiewW2xn7LDKhya0bZfR+n1ncPZFnCQ1gO8=;
        b=UguTA7HGtNV9AWc5kJQ/CKj+WwyV/ccyKGXJ/v6MPkCnZm1h3L9h0yzR8FGxy1L0E1aL+E
        gPev+m9a6/2M3tuIrF4RfldMLQ1i+AfRJTa2tT+tx5UquZh0ZihAFUAX+GWHqx5ryduciu
        cao8n2pduFTKRkt6He2U54hlpds+6GI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-188-iMndwkgzOp-FUDE_q17dGw-1; Thu, 09 Dec 2021 12:03:48 -0500
X-MC-Unique: iMndwkgzOp-FUDE_q17dGw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1F5C81EE62;
        Thu,  9 Dec 2021 17:03:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5428219C59;
        Thu,  9 Dec 2021 17:03:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 45/67] cachefiles: Implement metadata/coherency data
 storage in xattrs
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 09 Dec 2021 17:03:42 +0000
Message-ID: <163906942248.143852.5423738045012094252.stgit@warthog.procyon.org.uk>
In-Reply-To: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
References: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use an xattr on each backing file in the cache to store some metadata, such
as the content type and the coherency data.

Five content types are defined:

 (0) No content stored.

 (1) The file contains a single monolithic blob and must be all or nothing.
     This would be used for something like an AFS directory or a symlink.

 (2) The file is populated with content completely up to a point with
     nothing beyond that.

 (3) The file has a map attached and is sparsely populated.  This would be
     stored in one or more additional xattrs.

 (4) The file is dirty, being in the process of local modification and the
     contents are not necessarily represented correctly by the metadata.
     The file should be deleted if this is seen on binding.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/163819641320.215744.16346770087799536862.stgit@warthog.procyon.org.uk/ # v1
---

 fs/cachefiles/Makefile            |    3 -
 fs/cachefiles/internal.h          |   21 ++++
 fs/cachefiles/xattr.c             |  181 +++++++++++++++++++++++++++++++++++++
 include/trace/events/cachefiles.h |   56 +++++++++++
 4 files changed, 260 insertions(+), 1 deletion(-)
 create mode 100644 fs/cachefiles/xattr.c

diff --git a/fs/cachefiles/Makefile b/fs/cachefiles/Makefile
index 6f025940a65c..cb7a6bcf51eb 100644
--- a/fs/cachefiles/Makefile
+++ b/fs/cachefiles/Makefile
@@ -11,7 +11,8 @@ cachefiles-y := \
 	main.o \
 	namei.o \
 	security.o \
-	volume.o
+	volume.o \
+	xattr.o
 
 cachefiles-$(CONFIG_CACHEFILES_ERROR_INJECTION) += error_inject.o
 
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 28e386b5b1f3..fbb38d3e6cac 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -55,6 +55,7 @@ struct cachefiles_object {
 	u8				d_name_len;	/* Length of filename */
 	enum cachefiles_content		content_info:8;	/* Info about content presence */
 	unsigned long			flags;
+#define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Have an unlinked tmpfile */
 };
 
 /*
@@ -218,6 +219,17 @@ void cachefiles_acquire_volume(struct fscache_volume *volume);
 void cachefiles_free_volume(struct fscache_volume *volume);
 void cachefiles_withdraw_volume(struct cachefiles_volume *volume);
 
+/*
+ * xattr.c
+ */
+extern int cachefiles_set_object_xattr(struct cachefiles_object *object);
+extern int cachefiles_check_auxdata(struct cachefiles_object *object,
+				    struct file *file);
+extern int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
+					  struct cachefiles_object *object,
+					  struct dentry *dentry);
+extern void cachefiles_prepare_to_write(struct fscache_cookie *cookie);
+
 /*
  * Error handling
  */
@@ -228,6 +240,15 @@ do {							\
 	set_bit(CACHEFILES_DEAD, &(___cache)->flags);	\
 } while (0)
 
+#define cachefiles_io_error_obj(object, FMT, ...)			\
+do {									\
+	struct cachefiles_cache *___cache;				\
+									\
+	___cache = (object)->volume->cache;				\
+	cachefiles_io_error(___cache, FMT " [o=%08x]", ##__VA_ARGS__,	\
+			    (object)->debug_id);			\
+} while (0)
+
 
 /*
  * Debug tracing
diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
new file mode 100644
index 000000000000..0601c46a22ef
--- /dev/null
+++ b/fs/cachefiles/xattr.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* CacheFiles extended attribute management
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/fsnotify.h>
+#include <linux/quotaops.h>
+#include <linux/xattr.h>
+#include <linux/slab.h>
+#include "internal.h"
+
+#define CACHEFILES_COOKIE_TYPE_DATA 1
+
+struct cachefiles_xattr {
+	__be64	object_size;	/* Actual size of the object */
+	__be64	zero_point;	/* Size after which server has no data not written by us */
+	__u8	type;		/* Type of object */
+	__u8	content;	/* Content presence (enum cachefiles_content) */
+	__u8	data[];		/* netfs coherency data */
+} __packed;
+
+static const char cachefiles_xattr_cache[] =
+	XATTR_USER_PREFIX "CacheFiles.cache";
+
+/*
+ * set the state xattr on a cache file
+ */
+int cachefiles_set_object_xattr(struct cachefiles_object *object)
+{
+	struct cachefiles_xattr *buf;
+	struct dentry *dentry;
+	struct file *file = object->file;
+	unsigned int len = object->cookie->aux_len;
+	int ret;
+
+	if (!file)
+		return -ESTALE;
+	dentry = file->f_path.dentry;
+
+	_enter("%x,#%d", object->debug_id, len);
+
+	buf = kmalloc(sizeof(struct cachefiles_xattr) + len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf->object_size	= cpu_to_be64(object->cookie->object_size);
+	buf->zero_point		= 0;
+	buf->type		= CACHEFILES_COOKIE_TYPE_DATA;
+	buf->content		= object->content_info;
+	if (test_bit(FSCACHE_COOKIE_LOCAL_WRITE, &object->cookie->flags))
+		buf->content	= CACHEFILES_CONTENT_DIRTY;
+	if (len > 0)
+		memcpy(buf->data, fscache_get_aux(object->cookie), len);
+
+	ret = cachefiles_inject_write_error();
+	if (ret == 0)
+		ret = vfs_setxattr(&init_user_ns, dentry, cachefiles_xattr_cache,
+				   buf, sizeof(struct cachefiles_xattr) + len, 0);
+	if (ret < 0) {
+		trace_cachefiles_vfs_error(object, file_inode(file), ret,
+					   cachefiles_trace_setxattr_error);
+		trace_cachefiles_coherency(object, file_inode(file)->i_ino,
+					   buf->content,
+					   cachefiles_coherency_set_fail);
+		if (ret != -ENOMEM)
+			cachefiles_io_error_obj(
+				object,
+				"Failed to set xattr with error %d", ret);
+	} else {
+		trace_cachefiles_coherency(object, file_inode(file)->i_ino,
+					   buf->content,
+					   cachefiles_coherency_set_ok);
+	}
+
+	kfree(buf);
+	_leave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * check the consistency between the backing cache and the FS-Cache cookie
+ */
+int cachefiles_check_auxdata(struct cachefiles_object *object, struct file *file)
+{
+	struct cachefiles_xattr *buf;
+	struct dentry *dentry = file->f_path.dentry;
+	unsigned int len = object->cookie->aux_len, tlen;
+	const void *p = fscache_get_aux(object->cookie);
+	enum cachefiles_coherency_trace why;
+	ssize_t xlen;
+	int ret = -ESTALE;
+
+	tlen = sizeof(struct cachefiles_xattr) + len;
+	buf = kmalloc(tlen, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	xlen = cachefiles_inject_read_error();
+	if (xlen == 0)
+		xlen = vfs_getxattr(&init_user_ns, dentry, cachefiles_xattr_cache, buf, tlen);
+	if (xlen != tlen) {
+		if (xlen < 0)
+			trace_cachefiles_vfs_error(object, file_inode(file), xlen,
+						   cachefiles_trace_getxattr_error);
+		if (xlen == -EIO)
+			cachefiles_io_error_obj(
+				object,
+				"Failed to read aux with error %zd", xlen);
+		why = cachefiles_coherency_check_xattr;
+	} else if (buf->type != CACHEFILES_COOKIE_TYPE_DATA) {
+		why = cachefiles_coherency_check_type;
+	} else if (memcmp(buf->data, p, len) != 0) {
+		why = cachefiles_coherency_check_aux;
+	} else if (be64_to_cpu(buf->object_size) != object->cookie->object_size) {
+		why = cachefiles_coherency_check_objsize;
+	} else if (buf->content == CACHEFILES_CONTENT_DIRTY) {
+		// TODO: Begin conflict resolution
+		pr_warn("Dirty object in cache\n");
+		why = cachefiles_coherency_check_dirty;
+	} else {
+		why = cachefiles_coherency_check_ok;
+		ret = 0;
+	}
+
+	trace_cachefiles_coherency(object, file_inode(file)->i_ino,
+				   buf->content, why);
+	kfree(buf);
+	return ret;
+}
+
+/*
+ * remove the object's xattr to mark it stale
+ */
+int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
+				   struct cachefiles_object *object,
+				   struct dentry *dentry)
+{
+	int ret;
+
+	ret = cachefiles_inject_remove_error();
+	if (ret == 0)
+		ret = vfs_removexattr(&init_user_ns, dentry, cachefiles_xattr_cache);
+	if (ret < 0) {
+		trace_cachefiles_vfs_error(object, d_inode(dentry), ret,
+					   cachefiles_trace_remxattr_error);
+		if (ret == -ENOENT || ret == -ENODATA)
+			ret = 0;
+		else if (ret != -ENOMEM)
+			cachefiles_io_error(cache,
+					    "Can't remove xattr from %lu"
+					    " (error %d)",
+					    d_backing_inode(dentry)->i_ino, -ret);
+	}
+
+	_leave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * Stick a marker on the cache object to indicate that it's dirty.
+ */
+void cachefiles_prepare_to_write(struct fscache_cookie *cookie)
+{
+	const struct cred *saved_cred;
+	struct cachefiles_object *object = cookie->cache_priv;
+	struct cachefiles_cache *cache = object->volume->cache;
+
+	_enter("c=%08x", object->cookie->debug_id);
+
+	if (!test_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags)) {
+		cachefiles_begin_secure(cache, &saved_cred);
+		cachefiles_set_object_xattr(object);
+		cachefiles_end_secure(cache, saved_cred);
+	}
+}
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index 493afa7fbfec..47b584b3ffab 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -42,6 +42,19 @@ enum fscache_why_object_killed {
 	FSCACHE_OBJECT_WAS_CULLED,
 };
 
+enum cachefiles_coherency_trace {
+	cachefiles_coherency_check_aux,
+	cachefiles_coherency_check_content,
+	cachefiles_coherency_check_dirty,
+	cachefiles_coherency_check_len,
+	cachefiles_coherency_check_objsize,
+	cachefiles_coherency_check_ok,
+	cachefiles_coherency_check_type,
+	cachefiles_coherency_check_xattr,
+	cachefiles_coherency_set_fail,
+	cachefiles_coherency_set_ok,
+};
+
 enum cachefiles_trunc_trace {
 	cachefiles_trunc_dio_adjust,
 	cachefiles_trunc_expand_tmpfile,
@@ -95,6 +108,18 @@ enum cachefiles_error_trace {
 	EM(cachefiles_obj_see_withdraw_cookie,	"SEE withdraw_cookie")	\
 	E_(cachefiles_obj_see_withdrawal,	"SEE withdrawal")
 
+#define cachefiles_coherency_traces					\
+	EM(cachefiles_coherency_check_aux,	"BAD aux ")		\
+	EM(cachefiles_coherency_check_content,	"BAD cont")		\
+	EM(cachefiles_coherency_check_dirty,	"BAD dirt")		\
+	EM(cachefiles_coherency_check_len,	"BAD len ")		\
+	EM(cachefiles_coherency_check_objsize,	"BAD osiz")		\
+	EM(cachefiles_coherency_check_ok,	"OK      ")		\
+	EM(cachefiles_coherency_check_type,	"BAD type")		\
+	EM(cachefiles_coherency_check_xattr,	"BAD xatt")		\
+	EM(cachefiles_coherency_set_fail,	"SET fail")		\
+	E_(cachefiles_coherency_set_ok,		"SET ok  ")
+
 #define cachefiles_trunc_traces						\
 	EM(cachefiles_trunc_dio_adjust,		"DIOADJ")		\
 	EM(cachefiles_trunc_expand_tmpfile,	"EXPTMP")		\
@@ -130,6 +155,7 @@ enum cachefiles_error_trace {
 
 cachefiles_obj_kill_traces;
 cachefiles_obj_ref_traces;
+cachefiles_coherency_traces;
 cachefiles_trunc_traces;
 cachefiles_error_traces;
 
@@ -287,6 +313,36 @@ TRACE_EVENT(cachefiles_rename,
 		      __print_symbolic(__entry->why, cachefiles_obj_kill_traces))
 	    );
 
+TRACE_EVENT(cachefiles_coherency,
+	    TP_PROTO(struct cachefiles_object *obj,
+		     ino_t ino,
+		     enum cachefiles_content content,
+		     enum cachefiles_coherency_trace why),
+
+	    TP_ARGS(obj, ino, content, why),
+
+	    /* Note that obj may be NULL */
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			obj	)
+		    __field(enum cachefiles_coherency_trace,	why	)
+		    __field(enum cachefiles_content,		content	)
+		    __field(u64,				ino	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj->debug_id;
+		    __entry->why	= why;
+		    __entry->content	= content;
+		    __entry->ino	= ino;
+			   ),
+
+	    TP_printk("o=%08x %s i=%llx c=%u",
+		      __entry->obj,
+		      __print_symbolic(__entry->why, cachefiles_coherency_traces),
+		      __entry->ino,
+		      __entry->content)
+	    );
+
 TRACE_EVENT(cachefiles_trunc,
 	    TP_PROTO(struct cachefiles_object *obj, struct inode *backer,
 		     loff_t from, loff_t to, enum cachefiles_trunc_trace why),


