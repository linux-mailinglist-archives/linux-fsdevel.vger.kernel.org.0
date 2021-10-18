Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2A0432235
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 17:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbhJRPLc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 11:11:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28051 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233278AbhJRPLH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634569736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PltcY/PEBQU8nQ+jHuQECKOprYLw179l3iQuj0DcTgA=;
        b=Lh9+gcqlLNXvDC8jcGYu1knhbhoWfakK7eHRr5B1n0DuRcNFU3tSJB5jPBnCLGa+hsDwW7
        Fhq+XMFLOsIkyF6J4vMbQN4c9/h0FWEkh9wlP+5HqSL0YMON146Qkhp6Cwyuze2ioZ8Uwy
        AUXY5L1HdJhxdYohY7VGcGd8ux3obgI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-tvN1ktKEO-OuF2x78SQuFw-1; Mon, 18 Oct 2021 11:08:54 -0400
X-MC-Unique: tvN1ktKEO-OuF2x78SQuFw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85B328F516;
        Mon, 18 Oct 2021 15:08:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C78525C1D0;
        Mon, 18 Oct 2021 15:08:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 65/67] cachefiles: Add tracepoints to log errors from ops on
 the backing fs
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
Date:   Mon, 18 Oct 2021 16:08:47 +0100
Message-ID: <163456972797.2614702.14297945722771991084.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a couple of tracepoints to log errors that cachefiles gets from making
calls to manipulate the backing filesystem.  These calls are divided into
two categories - VFS manipulation (eg. mkdir) and data I/O - with a
separate tracepoint for each.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/daemon.c            |    2 +
 fs/cachefiles/interface.c         |   11 ++++
 fs/cachefiles/internal.h          |    1 
 fs/cachefiles/io.c                |   22 ++++++++-
 fs/cachefiles/namei.c             |   59 ++++++++++++++++++++---
 fs/cachefiles/xattr.c             |    8 +++
 include/trace/events/cachefiles.h |   94 +++++++++++++++++++++++++++++++++++++
 7 files changed, 187 insertions(+), 10 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 6d31fba31ce9..2b926af39f43 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -692,6 +692,8 @@ int cachefiles_has_space(struct cachefiles_cache *cache,
 
 	ret = vfs_statfs(&path, &stats);
 	if (ret < 0) {
+		trace_cachefiles_vfs_error(NULL, d_inode(cache->store), ret,
+					   cachefiles_trace_statfs_error);
 		if (ret == -EIO)
 			cachefiles_io_error(cache, "statfs failed");
 		_leave(" = %d", ret);
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 96f30eba585a..115be503b23a 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -153,8 +153,10 @@ static bool cachefiles_shorten_object(struct cachefiles_object *object,
 			       cachefiles_trunc_shrink);
 	ret = vfs_truncate(&file->f_path, dio_size);
 	if (ret < 0) {
+		trace_cachefiles_io_error(object, file_inode(file), ret,
+					  cachefiles_trace_trunc_error);
 		cachefiles_io_error_obj(object, "Trunc-to-size failed %d", ret);
-		cachefiles_remove_object_xattr(cache, file->f_path.dentry);
+		cachefiles_remove_object_xattr(cache, object, file->f_path.dentry);
 		return false;
 	}
 
@@ -164,8 +166,10 @@ static bool cachefiles_shorten_object(struct cachefiles_object *object,
 		ret = vfs_fallocate(file, FALLOC_FL_ZERO_RANGE,
 				    new_size, dio_size);
 		if (ret < 0) {
+			trace_cachefiles_io_error(object, file_inode(file), ret,
+						  cachefiles_trace_fallocate_error);
 			cachefiles_io_error_obj(object, "Trunc-to-dio-size failed %d", ret);
-			cachefiles_remove_object_xattr(cache, file->f_path.dentry);
+			cachefiles_remove_object_xattr(cache, object, file->f_path.dentry);
 			return false;
 		}
 	}
@@ -384,6 +388,9 @@ static int cachefiles_attr_changed(struct cachefiles_object *object)
 	inode_unlock(file_inode(file));
 	cachefiles_end_secure(cache, saved_cred);
 
+	if (ret < 0)
+		trace_cachefiles_io_error(NULL, file_inode(file), ret,
+					  cachefiles_trace_notify_change_error);
 	if (ret == -EIO) {
 		cachefiles_io_error_obj(object, "Size set failed");
 		ret = -ENOBUFS;
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 83cf2ca3a763..3dd3e13989d6 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -238,6 +238,7 @@ extern int cachefiles_set_object_xattr(struct cachefiles_object *object);
 extern int cachefiles_check_auxdata(struct cachefiles_object *object,
 				    struct file *file);
 extern int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
+					  struct cachefiles_object *object,
 					  struct dentry *dentry);
 extern void cachefiles_prepare_to_write(struct fscache_cookie *cookie);
 
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 5e3579800689..136d0ea0a7c9 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -44,9 +44,14 @@ static inline void cachefiles_put_kiocb(struct cachefiles_kiocb *ki)
 static void cachefiles_read_complete(struct kiocb *iocb, long ret, long ret2)
 {
 	struct cachefiles_kiocb *ki = container_of(iocb, struct cachefiles_kiocb, iocb);
+	struct inode *inode = file_inode(ki->iocb.ki_filp);
 
 	_enter("%ld,%ld", ret, ret2);
 
+	if (ret < 0)
+		trace_cachefiles_io_error(ki->object, inode, ret,
+					  cachefiles_trace_read_error);
+
 	if (ki->term_func) {
 		if (ret >= 0) {
 			if (ki->object->cookie->inval_counter == ki->inval_counter)
@@ -195,6 +200,10 @@ static void cachefiles_write_complete(struct kiocb *iocb, long ret, long ret2)
 	__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
 	__sb_end_write(inode->i_sb, SB_FREEZE_WRITE);
 
+	if (ret < 0)
+		trace_cachefiles_io_error(ki->object, inode, ret,
+					  cachefiles_trace_write_error);
+
 	set_bit(FSCACHE_COOKIE_HAVE_DATA, &ki->object->cookie->flags);
 	if (ki->term_func)
 		ki->term_func(ki->term_func_priv, ret, ki->was_async);
@@ -352,6 +361,8 @@ static enum netfs_read_source cachefiles_prepare_read(struct netfs_read_subreque
 			why = cachefiles_trace_read_seek_nxio;
 			goto download_and_store;
 		}
+		trace_cachefiles_io_error(object, file_inode(file), off,
+					  cachefiles_trace_seek_error);
 		why = cachefiles_trace_read_seek_error;
 		goto out;
 	}
@@ -370,6 +381,8 @@ static enum netfs_read_source cachefiles_prepare_read(struct netfs_read_subreque
 
 	to = vfs_llseek(file, subreq->start, SEEK_HOLE);
 	if (to < 0 && to >= (loff_t)-MAX_ERRNO) {
+		trace_cachefiles_io_error(object, file_inode(file), to,
+					  cachefiles_trace_seek_error);
 		why = cachefiles_trace_read_seek_error;
 		goto out;
 	}
@@ -425,6 +438,8 @@ static int __cachefiles_prepare_write(struct netfs_cache_resources *cres,
 	if (pos < 0 && pos >= (loff_t)-MAX_ERRNO) {
 		if (pos == -ENXIO)
 			goto check_space; /* Unallocated tail */
+		trace_cachefiles_io_error(object, file_inode(file), pos,
+					  cachefiles_trace_seek_error);
 		return pos;
 	}
 	if ((u64)pos >= (u64)*_start + *_len)
@@ -438,8 +453,11 @@ static int __cachefiles_prepare_write(struct netfs_cache_resources *cres,
 		return 0; /* Enough space to simply overwrite the whole block */
 
 	pos = vfs_llseek(file, *_start, SEEK_HOLE);
-	if (pos < 0 && pos >= (loff_t)-MAX_ERRNO)
+	if (pos < 0 && pos >= (loff_t)-MAX_ERRNO) {
+		trace_cachefiles_io_error(object, file_inode(file), pos,
+					  cachefiles_trace_seek_error);
 		return pos;
+	}
 	if ((u64)pos >= (u64)*_start + *_len)
 		return 0; /* Fully allocated */
 
@@ -447,6 +465,8 @@ static int __cachefiles_prepare_write(struct netfs_cache_resources *cres,
 	ret = vfs_fallocate(file, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
 			    *_start, *_len);
 	if (ret < 0) {
+		trace_cachefiles_io_error(object, file_inode(file), ret,
+					  cachefiles_trace_fallocate_error);
 		cachefiles_io_error_obj(object,
 					"CacheFiles: fallocate failed (%d)\n", ret);
 		ret = -EIO;
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 989df918570b..12266c90e5f8 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -122,8 +122,12 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 
 		inode_unlock(d_inode(dir));
 
-		if (ret == -EIO)
-			cachefiles_io_error(cache, "Unlink failed");
+		if (ret < 0) {
+			trace_cachefiles_vfs_error(object, d_inode(dir), ret,
+						   cachefiles_trace_unlink_error);
+			if (ret == -EIO)
+				cachefiles_io_error(cache, "Unlink failed");
+		}
 
 		_leave(" = %d", ret);
 		return ret;
@@ -172,6 +176,9 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 	grave = lookup_one_len(nbuffer, cache->graveyard, strlen(nbuffer));
 	if (IS_ERR(grave)) {
 		unlock_rename(cache->graveyard, dir);
+		trace_cachefiles_vfs_error(object, d_inode(cache->graveyard),
+					   PTR_ERR(grave),
+					   cachefiles_trace_lookup_error);
 
 		if (PTR_ERR(grave) == -ENOMEM) {
 			_leave(" = -ENOMEM");
@@ -224,6 +231,10 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 		};
 		trace_cachefiles_rename(object, rep, grave, why);
 		ret = vfs_rename(&rd);
+		if (ret != 0)
+			trace_cachefiles_vfs_error(object, d_inode(dir),
+						   PTR_ERR(grave),
+						   cachefiles_trace_rename_error);
 		if (ret != 0 && ret != -ENOMEM)
 			cachefiles_io_error(cache,
 					    "Rename failed with error %d", ret);
@@ -249,6 +260,9 @@ static int cachefiles_unlink(struct cachefiles_object *object,
 	ret = security_path_unlink(&path, dentry);
 	if (ret == 0)
 		ret = vfs_unlink(&init_user_ns, d_backing_inode(fan), dentry, NULL);
+	if (ret != 0)
+		trace_cachefiles_vfs_error(object, d_backing_inode(fan), ret,
+					   cachefiles_trace_unlink_error);
 	return ret;
 }
 
@@ -273,6 +287,9 @@ int cachefiles_delete_object(struct cachefiles_object *object,
 	inode_unlock(d_backing_inode(fan));
 	dput(dentry);
 
+	if (ret < 0)
+		trace_cachefiles_vfs_error(object, d_backing_inode(fan), ret,
+					   cachefiles_trace_unlink_error);
 	if (ret < 0 && ret != -ENOENT)
 		cachefiles_io_error(volume->cache, "Unlink failed");
 	return ret;
@@ -326,8 +343,12 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
 	path.dentry = dentry;
 	file = open_with_fake_path(&path, O_RDWR | O_LARGEFILE | O_DIRECT,
 				   d_backing_inode(dentry), cache->cache_cred);
-	if (IS_ERR(file))
+	if (IS_ERR(file)) {
+		trace_cachefiles_vfs_error(object, d_backing_inode(dentry),
+					   PTR_ERR(file),
+					   cachefiles_trace_open_error);
 		goto error;
+	}
 
 	if (unlikely(!file->f_op->read_iter) ||
 	    unlikely(!file->f_op->write_iter)) {
@@ -430,6 +451,9 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 retry:
 	subdir = lookup_one_len(dirname, dir, strlen(dirname));
 	if (IS_ERR(subdir)) {
+		trace_cachefiles_vfs_error(NULL, d_backing_inode(dir),
+					   PTR_ERR(subdir),
+					   cachefiles_trace_lookup_error);
 		if (PTR_ERR(subdir) == -ENOMEM)
 			goto nomem_d_alloc;
 		goto lookup_error;
@@ -454,8 +478,11 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 		if (ret < 0)
 			goto mkdir_error;
 		ret = vfs_mkdir(&init_user_ns, d_inode(dir), subdir, 0700);
-		if (ret < 0)
+		if (ret < 0) {
+			trace_cachefiles_vfs_error(NULL, d_inode(dir), ret,
+						   cachefiles_trace_mkdir_error);
 			goto mkdir_error;
+		}
 
 		if (unlikely(d_unhashed(subdir))) {
 			dput(subdir);
@@ -610,7 +637,7 @@ int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
 	 */
 	_debug("victim is cullable");
 
-	ret = cachefiles_remove_object_xattr(cache, victim);
+	ret = cachefiles_remove_object_xattr(cache, NULL, victim);
 	if (ret < 0)
 		goto error_unlock;
 
@@ -693,6 +720,8 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 	path.mnt = cache->mnt,
 	path.dentry = vfs_tmpfile(&init_user_ns, fan, S_IFREG, O_RDWR);
 	if (IS_ERR(path.dentry)) {
+		trace_cachefiles_vfs_error(object, d_inode(fan), PTR_ERR(path.dentry),
+					   cachefiles_trace_tmpfile_error);
 		if (PTR_ERR(path.dentry) == -EIO)
 			cachefiles_io_error_obj(object, "Failed to create tmpfile");
 		file = ERR_CAST(path.dentry);
@@ -711,6 +740,9 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 				       cachefiles_trunc_expand_tmpfile);
 		ret = vfs_truncate(&path, ni_size);
 		if (ret < 0) {
+			trace_cachefiles_vfs_error(
+				object, d_backing_inode(path.dentry), ret,
+				cachefiles_trace_trunc_error);
 			file = ERR_PTR(ret);
 			goto out_dput;
 		}
@@ -718,8 +750,12 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 
 	file = open_with_fake_path(&path, O_RDWR | O_LARGEFILE | O_DIRECT,
 				   d_backing_inode(path.dentry), cache->cache_cred);
-	if (IS_ERR(file))
+	if (IS_ERR(file)) {
+		trace_cachefiles_vfs_error(object, d_backing_inode(path.dentry),
+					   PTR_ERR(file),
+					   cachefiles_trace_open_error);
 		goto out_dput;
+	}
 	if (unlikely(!file->f_op->read_iter) ||
 	    unlikely(!file->f_op->write_iter)) {
 		fput(file);
@@ -750,6 +786,8 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
 	inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
 	dentry = lookup_one_len(object->d_name, fan, object->d_name_len);
 	if (IS_ERR(dentry)) {
+		trace_cachefiles_vfs_error(object, d_inode(fan), PTR_ERR(dentry),
+					   cachefiles_trace_lookup_error);
 		_debug("lookup fail %ld", PTR_ERR(dentry));
 		goto out_unlock;
 	}
@@ -761,12 +799,17 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
 		}
 
 		ret = cachefiles_unlink(object, fan, dentry, FSCACHE_OBJECT_IS_STALE);
-		if (ret < 0)
+		if (ret < 0) {
+			trace_cachefiles_vfs_error(object, d_inode(fan), ret,
+						   cachefiles_trace_unlink_error);
 			goto out_dput;
+		}
 
 		dput(dentry);
 		dentry = lookup_one_len(object->d_name, fan, object->d_name_len);
 		if (IS_ERR(dentry)) {
+			trace_cachefiles_vfs_error(object, d_inode(fan), PTR_ERR(dentry),
+						   cachefiles_trace_lookup_error);
 			_debug("lookup fail %ld", PTR_ERR(dentry));
 			goto out_unlock;
 		}
@@ -775,6 +818,8 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
 	ret = vfs_link(object->file->f_path.dentry, &init_user_ns,
 		       d_inode(fan), dentry, NULL);
 	if (ret < 0) {
+		trace_cachefiles_vfs_error(object, d_inode(fan), PTR_ERR(dentry),
+					   cachefiles_trace_link_error);
 		_debug("link fail %d", ret);
 	} else {
 		trace_cachefiles_link(object, file_inode(object->file));
diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index 30adca42883b..e0f77329c3ec 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -61,6 +61,8 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object)
 	ret = vfs_setxattr(&init_user_ns, dentry, cachefiles_xattr_cache,
 			   buf, sizeof(struct cachefiles_xattr) + len, 0);
 	if (ret < 0) {
+		trace_cachefiles_vfs_error(object, file_inode(file), ret,
+					   cachefiles_trace_setxattr_error);
 		trace_cachefiles_coherency(object, file_inode(file)->i_ino,
 					   buf->content,
 					   cachefiles_coherency_set_fail);
@@ -99,6 +101,9 @@ int cachefiles_check_auxdata(struct cachefiles_object *object, struct file *file
 
 	xlen = vfs_getxattr(&init_user_ns, dentry, cachefiles_xattr_cache, buf, tlen);
 	if (xlen != tlen) {
+		if (xlen < 0)
+			trace_cachefiles_vfs_error(object, file_inode(file), xlen,
+						   cachefiles_trace_getxattr_error);
 		if (xlen == -EIO)
 			cachefiles_io_error_obj(
 				object,
@@ -129,12 +134,15 @@ int cachefiles_check_auxdata(struct cachefiles_object *object, struct file *file
  * remove the object's xattr to mark it stale
  */
 int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
+				   struct cachefiles_object *object,
 				   struct dentry *dentry)
 {
 	int ret;
 
 	ret = vfs_removexattr(&init_user_ns, dentry, cachefiles_xattr_cache);
 	if (ret < 0) {
+		trace_cachefiles_vfs_error(object, d_inode(dentry), ret,
+					   cachefiles_trace_remxattr_error);
 		if (ret == -ENOENT || ret == -ENODATA)
 			ret = 0;
 		else if (ret != -ENOMEM)
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index 11447b20fc83..6a41a36ce581 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -72,6 +72,26 @@ enum cachefiles_prepare_read_trace {
 	cachefiles_trace_read_seek_nxio,
 };
 
+enum cachefiles_error_trace {
+	cachefiles_trace_fallocate_error,
+	cachefiles_trace_getxattr_error,
+	cachefiles_trace_link_error,
+	cachefiles_trace_lookup_error,
+	cachefiles_trace_mkdir_error,
+	cachefiles_trace_notify_change_error,
+	cachefiles_trace_open_error,
+	cachefiles_trace_read_error,
+	cachefiles_trace_remxattr_error,
+	cachefiles_trace_rename_error,
+	cachefiles_trace_seek_error,
+	cachefiles_trace_setxattr_error,
+	cachefiles_trace_statfs_error,
+	cachefiles_trace_tmpfile_error,
+	cachefiles_trace_trunc_error,
+	cachefiles_trace_unlink_error,
+	cachefiles_trace_write_error,
+};
+
 #endif
 
 /*
@@ -126,6 +146,25 @@ enum cachefiles_prepare_read_trace {
 	EM(cachefiles_trace_read_seek_error,	"seek-error")		\
 	E_(cachefiles_trace_read_seek_nxio,	"seek-enxio")
 
+#define cachefiles_error_traces						\
+	EM(cachefiles_trace_fallocate_error,	"fallocate")		\
+	EM(cachefiles_trace_getxattr_error,	"getxattr")		\
+	EM(cachefiles_trace_link_error,		"link")			\
+	EM(cachefiles_trace_lookup_error,	"lookup")		\
+	EM(cachefiles_trace_mkdir_error,	"mkdir")		\
+	EM(cachefiles_trace_notify_change_error, "notify_change")	\
+	EM(cachefiles_trace_open_error,		"open")			\
+	EM(cachefiles_trace_read_error,		"read")			\
+	EM(cachefiles_trace_remxattr_error,	"remxattr")		\
+	EM(cachefiles_trace_rename_error,	"rename")		\
+	EM(cachefiles_trace_seek_error,		"seek")			\
+	EM(cachefiles_trace_setxattr_error,	"setxattr")		\
+	EM(cachefiles_trace_statfs_error,	"statfs")		\
+	EM(cachefiles_trace_tmpfile_error,	"tmpfile")		\
+	EM(cachefiles_trace_trunc_error,	"trunc")		\
+	EM(cachefiles_trace_unlink_error,	"unlink")		\
+	E_(cachefiles_trace_write_error,	"write")
+
 
 /*
  * Export enum symbols via userspace.
@@ -140,6 +179,7 @@ cachefiles_obj_ref_traces;
 cachefiles_coherency_traces;
 cachefiles_trunc_traces;
 cachefiles_prepare_read_traces;
+cachefiles_error_traces;
 
 /*
  * Now redefine the EM() and E_() macros to map the enums to the strings that
@@ -496,6 +536,60 @@ TRACE_EVENT(cachefiles_trunc,
 		      __entry->to)
 	    );
 
+TRACE_EVENT(cachefiles_vfs_error,
+	    TP_PROTO(struct cachefiles_object *obj, struct inode *backer,
+		     int error, enum cachefiles_error_trace where),
+
+	    TP_ARGS(obj, backer, error, where),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			obj	)
+		    __field(unsigned int,			backer	)
+		    __field(enum cachefiles_error_trace,	where	)
+		    __field(short,				error	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj ? obj->debug_id : 0;
+		    __entry->backer	= backer->i_ino;
+		    __entry->error	= error;
+		    __entry->where	= where;
+			   ),
+
+	    TP_printk("o=%08x b=%08x %s e=%d",
+		      __entry->obj,
+		      __entry->backer,
+		      __print_symbolic(__entry->where, cachefiles_error_traces),
+		      __entry->error)
+	    );
+
+TRACE_EVENT(cachefiles_io_error,
+	    TP_PROTO(struct cachefiles_object *obj, struct inode *backer,
+		     int error, enum cachefiles_error_trace where),
+
+	    TP_ARGS(obj, backer, error, where),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			obj	)
+		    __field(unsigned int,			backer	)
+		    __field(enum cachefiles_error_trace,	where	)
+		    __field(short,				error	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj ? obj->debug_id : 0;
+		    __entry->backer	= backer->i_ino;
+		    __entry->error	= error;
+		    __entry->where	= where;
+			   ),
+
+	    TP_printk("o=%08x b=%08x %s e=%d",
+		      __entry->obj,
+		      __entry->backer,
+		      __print_symbolic(__entry->where, cachefiles_error_traces),
+		      __entry->error)
+	    );
+
 #endif /* _TRACE_CACHEFILES_H */
 
 /* This part must be outside protection */


