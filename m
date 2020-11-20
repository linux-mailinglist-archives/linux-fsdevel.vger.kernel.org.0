Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC732BAE36
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgKTPOK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:14:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40618 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729138AbgKTPOJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605885246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LeGBhHGv6GBclHlt/8dfQ5fo0A4VKX6nHaerEPTu+aA=;
        b=HL2klszaAleQ20sR5WvmCoHCttpTMe8167nGyfFHT7hwMcGj5to2Zal4H1jois9N9h8xX5
        M0rZ6F4Q/PY0A1anDGaTLL0GYP8PQiGlEyi/3x+FhMVyAApQURSNoCLj2wVOjPESWDrja6
        Xti2RXLxRGhyYrzG2oXba3jouNMCB5o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-EmWzCOx-PcyukhOwVvBF1Q-1; Fri, 20 Nov 2020 10:14:04 -0500
X-MC-Unique: EmWzCOx-PcyukhOwVvBF1Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 896A6801B19;
        Fri, 20 Nov 2020 15:14:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58F9110021B3;
        Fri, 20 Nov 2020 15:13:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 53/76] fscache: Implement "will_modify" parameter on
 fscache_use_cookie()
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:13:55 +0000
Message-ID: <160588523556.3465195.5875233390723322661.stgit@warthog.procyon.org.uk>
In-Reply-To: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
References: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement the "will_modify" parameter passed to fscache_use_cookie().

Setting this to true will henceforth cause the affected object to be marked
as dirty on disk, subject to conflict resolution in the event that power
failure or a crash occurs or the filesystem operates in disconnected mode.

The dirty flag is removed when the fscache_object is discarded from memory.

A cache hook is provided to prepare for writing - and this can be used to
mark the object on disk.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/interface.c     |   68 +++++++++++++++++++++++++++++++++++++++++
 fs/cachefiles/internal.h      |    2 +
 fs/cachefiles/xattr.c         |   27 ++++++++++++++++
 fs/fscache/cookie.c           |   15 ++++++++-
 fs/fscache/internal.h         |    1 +
 fs/fscache/obj.c              |   28 ++++++++++++++---
 include/linux/fscache-cache.h |    4 ++
 7 files changed, 137 insertions(+), 8 deletions(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 4da10640611c..56ae8d956174 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -208,14 +208,81 @@ static void cachefiles_update_object(struct fscache_object *_object)
 	_leave("");
 }
 
+/*
+ * Shorten the backing object to discard any dirty data and free up
+ * any unused granules.
+ */
+static bool cachefiles_shorten_object(struct cachefiles_object *object, loff_t new_size)
+{
+	struct cachefiles_cache *cache;
+	struct inode *inode;
+	struct path path;
+	loff_t i_size;
+	int ret;
+
+	cache = container_of(object->fscache.cache,
+			     struct cachefiles_cache, cache);
+	path.mnt = cache->mnt;
+	path.dentry = object->dentry;
+
+	inode = d_inode(object->dentry);
+	trace_cachefiles_trunc(object, inode, i_size_read(inode), new_size);
+	ret = vfs_truncate(&path, new_size);
+	if (ret < 0) {
+		cachefiles_io_error_obj(object, "Trunc-to-size failed %d", ret);
+		cachefiles_remove_object_xattr(cache, object->dentry);
+		return false;
+	}
+
+	new_size = round_up(new_size, CACHEFILES_DIO_BLOCK_SIZE);
+	i_size = i_size_read(inode);
+	if (i_size < new_size) {
+		trace_cachefiles_trunc(object, inode, i_size, new_size);
+		ret = vfs_truncate(&path, new_size);
+		if (ret < 0) {
+			cachefiles_io_error_obj(object, "Trunc-to-dio-size failed %d", ret);
+			cachefiles_remove_object_xattr(cache, object->dentry);
+			return false;
+		}
+	}
+
+	return true;
+}
+
+/*
+ * Trim excess stored data off of an object.
+ */
+static bool cachefiles_trim_object(struct cachefiles_object *object)
+{
+	loff_t object_size;
+
+	_enter("{OBJ%x}", object->fscache.debug_id);
+
+	object_size = object->fscache.cookie->object_size;
+	if (i_size_read(d_inode(object->dentry)) <= object_size)
+		return true;
+
+	return cachefiles_shorten_object(object, object_size);
+}
+
 /*
  * Commit changes to the object as we drop it.
  */
 static bool cachefiles_commit_object(struct cachefiles_object *object,
 				     struct cachefiles_cache *cache)
 {
+	bool update = false;
+
 	if (object->content_map_changed)
 		cachefiles_save_content_map(object);
+	if (test_and_clear_bit(FSCACHE_OBJECT_LOCAL_WRITE, &object->fscache.flags))
+		update = true;
+	if (test_and_clear_bit(FSCACHE_OBJECT_NEEDS_UPDATE, &object->fscache.flags))
+		update = true;
+	if (update) {
+		if (cachefiles_trim_object(object))
+			cachefiles_set_object_xattr(object);
+	}
 
 	if (test_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags))
 		return cachefiles_commit_tmpfile(cache, object);
@@ -591,5 +658,6 @@ const struct fscache_cache_ops cachefiles_cache_ops = {
 	.get_object_usage	= cachefiles_get_object_usage,
 	.sync_cache		= cachefiles_sync_cache,
 	.begin_operation	= cachefiles_begin_operation,
+	.prepare_to_write	= cachefiles_prepare_to_write,
 	.display_object		= cachefiles_display_object,
 };
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index af68564598d5..e2d06c0860a2 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -258,7 +258,7 @@ extern int cachefiles_set_object_xattr(struct cachefiles_object *object);
 extern int cachefiles_check_auxdata(struct cachefiles_object *object);
 extern int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
 					  struct dentry *dentry);
-
+extern int cachefiles_prepare_to_write(struct fscache_object *object);
 
 /*
  * error handling
diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index 991ecda1f140..2f8623a7b864 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -124,6 +124,8 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object)
 	buf->zero_point		= cpu_to_be64(object->fscache.cookie->zero_point);
 	buf->type		= object->fscache.cookie->type;
 	buf->content		= object->content_info;
+	if (test_bit(FSCACHE_OBJECT_LOCAL_WRITE, &object->fscache.flags))
+		buf->content	= CACHEFILES_CONTENT_DIRTY;
 	if (len > 0)
 		memcpy(buf->data, fscache_get_aux(object->fscache.cookie), len);
 
@@ -184,6 +186,10 @@ int cachefiles_check_auxdata(struct cachefiles_object *object)
 		why = cachefiles_coherency_check_aux;
 	} else if (be64_to_cpu(buf->object_size) != object->fscache.cookie->object_size) {
 		why = cachefiles_coherency_check_objsize;
+	} else if (buf->content == CACHEFILES_CONTENT_DIRTY) {
+		// TODO: Begin conflict resolution
+		pr_warn("Dirty object in cache\n");
+		why = cachefiles_coherency_check_dirty;
 	} else {
 		object->fscache.cookie->zero_point = be64_to_cpu(buf->zero_point);
 		object->content_info = buf->content;
@@ -219,3 +225,24 @@ int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
 	_leave(" = %d", ret);
 	return ret;
 }
+
+/*
+ * Stick a marker on the cache object to indicate that it's dirty.
+ */
+int cachefiles_prepare_to_write(struct fscache_object *_object)
+{
+	int ret;
+	const struct cred *saved_cred;
+	struct cachefiles_object *object =
+		container_of(_object, struct cachefiles_object, fscache);
+	struct cachefiles_cache *cache =
+		container_of(_object->cache, struct cachefiles_cache, cache);
+
+	_enter("c=%08x", object->fscache.cookie->debug_id);
+
+	cachefiles_begin_secure(cache, &saved_cred);
+	ret = cachefiles_set_object_xattr(object);
+	cachefiles_end_secure(cache, saved_cred);
+
+	return ret;
+}
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index d20028535a86..bfea035af06d 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -363,6 +363,8 @@ EXPORT_SYMBOL(__fscache_acquire_cookie);
 void __fscache_use_cookie(struct fscache_cookie *cookie, bool will_modify)
 {
 	enum fscache_cookie_stage stage;
+	struct fscache_object *object;
+	bool write_set;
 
 	_enter("c=%08x", cookie->debug_id);
 
@@ -398,8 +400,17 @@ void __fscache_use_cookie(struct fscache_cookie *cookie, bool will_modify)
 	case FSCACHE_COOKIE_STAGE_NO_DATA_YET:
 	case FSCACHE_COOKIE_STAGE_ACTIVE:
 	case FSCACHE_COOKIE_STAGE_INVALIDATING:
-		// TODO: Handle will_modify
-		spin_unlock(&cookie->lock);
+		if (will_modify) {
+			object = hlist_entry(cookie->backing_objects.first,
+					     struct fscache_object, cookie_link);
+			write_set = test_and_set_bit(FSCACHE_OBJECT_LOCAL_WRITE,
+						     &object->flags);
+			spin_unlock(&cookie->lock);
+			if (!write_set)
+				fscache_dispatch(cookie, object, 0, fscache_prepare_to_write);
+		} else {
+			spin_unlock(&cookie->lock);
+		}
 		break;
 
 	case FSCACHE_COOKIE_STAGE_FAILED:
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index 73568e84fe3d..3c408da2c837 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -152,6 +152,7 @@ extern void fscache_lookup_object(struct fscache_cookie *, struct fscache_object
 extern void fscache_invalidate_object(struct fscache_cookie *, struct fscache_object *, int);
 extern void fscache_drop_object(struct fscache_cookie *, struct fscache_object *, bool);
 extern void fscache_relinquish_objects(struct fscache_cookie *, struct fscache_object *, int);
+extern void fscache_prepare_to_write(struct fscache_cookie *, struct fscache_object *, int);
 
 /*
  * object-list.c
diff --git a/fs/fscache/obj.c b/fs/fscache/obj.c
index 60c70c0e474d..a36de6af2182 100644
--- a/fs/fscache/obj.c
+++ b/fs/fscache/obj.c
@@ -117,7 +117,8 @@ static bool fscache_wrangle_object(struct fscache_cookie *cookie,
  * Create an object chain, making sure that the index chain is fully created.
  */
 static struct fscache_object *fscache_lookup_object_chain(struct fscache_cookie *cookie,
-							  struct fscache_cache *cache)
+							  struct fscache_cache *cache,
+							  bool will_modify)
 {
 	struct fscache_object *object = NULL, *parent, *xobject;
 
@@ -131,7 +132,7 @@ static struct fscache_object *fscache_lookup_object_chain(struct fscache_cookie
 	spin_unlock(&cookie->lock);
 
 	/* Recurse to look up/create the parent index. */
-	parent = fscache_lookup_object_chain(cookie->parent, cache);
+	parent = fscache_lookup_object_chain(cookie->parent, cache, false);
 	if (!parent)
 		goto error;
 
@@ -146,6 +147,9 @@ static struct fscache_object *fscache_lookup_object_chain(struct fscache_cookie
 	if (!object)
 		goto error;
 
+	if (will_modify)
+		__set_bit(FSCACHE_OBJECT_LOCAL_WRITE, &object->flags);
+
 	xobject = fscache_attach_object(cookie, object);
 	if (xobject != object) {
 		fscache_do_put_object(object, fscache_obj_put_alloc_dup);
@@ -207,7 +211,8 @@ static struct fscache_object *fscache_lookup_object_chain(struct fscache_cookie
  * - this must make sure the index chain is instantiated and instantiate the
  *   object representation too
  */
-static void fscache_lookup_object_locked(struct fscache_cookie *cookie)
+static void fscache_lookup_object_locked(struct fscache_cookie *cookie,
+					 bool will_modify)
 {
 	struct fscache_object *object;
 	struct fscache_cache *cache;
@@ -225,12 +230,16 @@ static void fscache_lookup_object_locked(struct fscache_cookie *cookie)
 
 	_debug("cache %s", cache->tag->name);
 
-	object = fscache_lookup_object_chain(cookie, cache);
+	object = fscache_lookup_object_chain(cookie, cache, will_modify);
 	if (!object) {
 		_leave(" [fail]");
 		return;
 	}
 
+	if (will_modify &&
+	    test_and_set_bit(FSCACHE_OBJECT_LOCAL_WRITE, &object->flags))
+		fscache_prepare_to_write(cookie, object, 0);
+
 	fscache_do_put_object(object, fscache_obj_put);
 	_leave(" [done]");
 }
@@ -239,7 +248,7 @@ void fscache_lookup_object(struct fscache_cookie *cookie,
 			   struct fscache_object *object, int param)
 {
 	down_read(&fscache_addremove_sem);
-	fscache_lookup_object_locked(cookie);
+	fscache_lookup_object_locked(cookie, param);
 	up_read(&fscache_addremove_sem);
 	__fscache_unuse_cookie(cookie, NULL, NULL);
 }
@@ -354,3 +363,12 @@ void fscache_relinquish_objects(struct fscache_cookie *cookie,
 
 	fscache_drop_cookie(cookie);
 }
+
+/*
+ * Prepare a cache object to be written to.
+ */
+void fscache_prepare_to_write(struct fscache_cookie *cookie,
+			      struct fscache_object *object, int param)
+{
+	object->cache->ops->prepare_to_write(object);
+}
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index a0bb526735b5..eb303deb39c1 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -142,6 +142,9 @@ struct fscache_cache_ops {
 	/* Begin an operation on a cache object */
 	void (*begin_operation)(struct fscache_op_resources *opr);
 
+	/* Prepare to write to a live cache object */
+	int (*prepare_to_write)(struct fscache_object *object);
+
 	/* Display object info in /proc/fs/fscache/objects */
 	int (*display_object)(struct seq_file *m, struct fscache_object *object);
 };
@@ -170,6 +173,7 @@ struct fscache_object {
 	spinlock_t		lock;		/* state and operations lock */
 
 	unsigned long		flags;
+#define FSCACHE_OBJECT_LOCAL_WRITE	1	/* T if the object is being modified locally */
 #define FSCACHE_OBJECT_NEEDS_INVAL	8	/* T if object needs invalidation */
 #define FSCACHE_OBJECT_NEEDS_UPDATE	9	/* T if object attrs need writing to disk */
 


