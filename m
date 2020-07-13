Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16B621DD1B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 18:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbgGMQgu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 12:36:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37471 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730138AbgGMQgu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594658207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5BzTH+WaXOvL6izZWzLKZvvWnEGobEIEm3ZK8LEQzUA=;
        b=QpwLCYwKK0Vrn1kAvySvvCBZXbh3oNmzTobOHqFmvBD+NEu/0sbih7AojsmxLtT28CYBwn
        XT+ssSurGaK50VOkLdLXH8q1Q1GL3kWf3QGV00iJRiLh4PjloHlXfLk6zjrPc9aeZGyPJv
        2qNhzBCJrIzxjgnrbM/Rf4f8U/HnwMY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-WwDraCX2Plup5CiXp-724A-1; Mon, 13 Jul 2020 12:36:46 -0400
X-MC-Unique: WwDraCX2Plup5CiXp-724A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 056D31090;
        Mon, 13 Jul 2020 16:36:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-113.rdu2.redhat.com [10.10.112.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A63ED60BF3;
        Mon, 13 Jul 2020 16:36:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 31/32] fscache: Remove the update operation
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Dave Wysochanski <dwysocha@redhat.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 13 Jul 2020 17:36:37 +0100
Message-ID: <159465819792.1376674.9917789832076544130.stgit@warthog.procyon.org.uk>
In-Reply-To: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
References: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the cache-side of the object update operation as it doesn't
serialise with other setattr, O_TRUNC and write operations.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/interface.c     |   59 -----------------------------------------
 fs/fscache/internal.h         |    1 -
 fs/fscache/obj.c              |   14 ----------
 fs/fscache/stats.c            |    4 +--
 include/linux/fscache-cache.h |    2 -
 5 files changed, 1 insertion(+), 79 deletions(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index d4172a40ddc9..21a06dd575ca 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -152,64 +152,6 @@ struct fscache_object *cachefiles_grab_object(struct fscache_object *_object,
 	return &object->fscache;
 }
 
-/*
- * update the auxiliary data for an object object on disk
- */
-static void cachefiles_update_object(struct fscache_object *_object)
-{
-	struct cachefiles_object *object;
-	struct cachefiles_cache *cache;
-	const struct cred *saved_cred;
-	struct inode *inode;
-	loff_t object_size, i_size;
-	int ret;
-
-	_enter("{OBJ%x}", _object->debug_id);
-
-	object = container_of(_object, struct cachefiles_object, fscache);
-	cache = container_of(object->fscache.cache, struct cachefiles_cache,
-			     cache);
-
-	cachefiles_begin_secure(cache, &saved_cred);
-
-	object_size = object->fscache.cookie->object_size;
-	inode = d_inode(object->dentry);
-	i_size = i_size_read(inode);
-	if (i_size > object_size) {
-		struct path path = {
-			.mnt	= cache->mnt,
-			.dentry	= object->dentry
-		};
-		_debug("trunc %llx -> %llx", i_size, object_size);
-		trace_cachefiles_trunc(object, inode, i_size, object_size);
-		ret = vfs_truncate(&path, object_size);
-		if (ret < 0) {
-			cachefiles_io_error_obj(object, "Trunc-to-size failed");
-			cachefiles_remove_object_xattr(cache, object->dentry);
-			goto out;
-		}
-
-		object_size = round_up(object_size, CACHEFILES_DIO_BLOCK_SIZE);
-		i_size = i_size_read(inode);
-		_debug("trunc %llx -> %llx", i_size, object_size);
-		if (i_size < object_size) {
-			trace_cachefiles_trunc(object, inode, i_size, object_size);
-			ret = vfs_truncate(&path, object_size);
-			if (ret < 0) {
-				cachefiles_io_error_obj(object, "Trunc-to-dio-size failed");
-				cachefiles_remove_object_xattr(cache, object->dentry);
-				goto out;
-			}
-		}
-	}
-
-	cachefiles_set_object_xattr(object);
-
-out:
-	cachefiles_end_secure(cache, saved_cred);
-	_leave("");
-}
-
 /*
  * Shorten the backing object to discard any dirty data and free up
  * any unused granules.
@@ -653,7 +595,6 @@ const struct fscache_cache_ops cachefiles_cache_ops = {
 	.lookup_object		= cachefiles_lookup_object,
 	.free_lookup_data	= cachefiles_free_lookup_data,
 	.grab_object		= cachefiles_grab_object,
-	.update_object		= cachefiles_update_object,
 	.resize_object		= cachefiles_resize_object,
 	.invalidate_object	= cachefiles_invalidate_object,
 	.drop_object		= cachefiles_drop_object,
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index eb61e0716e20..ca74b0090e15 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -202,7 +202,6 @@ extern atomic_t fscache_n_cop_alloc_object;
 extern atomic_t fscache_n_cop_lookup_object;
 extern atomic_t fscache_n_cop_create_object;
 extern atomic_t fscache_n_cop_invalidate_object;
-extern atomic_t fscache_n_cop_update_object;
 extern atomic_t fscache_n_cop_drop_object;
 extern atomic_t fscache_n_cop_put_object;
 extern atomic_t fscache_n_cop_sync_cache;
diff --git a/fs/fscache/obj.c b/fs/fscache/obj.c
index 139b59472628..a2306f32044c 100644
--- a/fs/fscache/obj.c
+++ b/fs/fscache/obj.c
@@ -54,14 +54,6 @@ static int fscache_do_create_object(struct fscache_object *object, void *data)
 	return ret;
 }
 
-static void fscache_do_update_object(struct fscache_object *object)
-{
-	fscache_stat(&fscache_n_updates_run);
-	fscache_stat(&fscache_n_cop_update_object);
-	object->cache->ops->update_object(object);
-	fscache_stat_d(&fscache_n_cop_update_object);
-}
-
 static void fscache_do_drop_object(struct fscache_cache *cache,
 				   struct fscache_object *object,
 				   bool invalidate)
@@ -282,12 +274,6 @@ void fscache_drop_object(struct fscache_cookie *cookie,
 	_enter("{OBJ%x,%d},%u",
 	       object->debug_id, object->n_children, invalidate);
 
-	if (!invalidate &&
-	    test_bit(FSCACHE_OBJECT_NEEDS_UPDATE, &object->flags)) {
-		_debug("final update");
-		fscache_do_update_object(object);
-	}
-
 	spin_lock(&cache->object_list_lock);
 	list_del_init(&object->cache_link);
 	spin_unlock(&cache->object_list_lock);
diff --git a/fs/fscache/stats.c b/fs/fscache/stats.c
index 33cea7f527db..f35f22f9a7f3 100644
--- a/fs/fscache/stats.c
+++ b/fs/fscache/stats.c
@@ -50,7 +50,6 @@ atomic_t fscache_n_cop_alloc_object;
 atomic_t fscache_n_cop_lookup_object;
 atomic_t fscache_n_cop_create_object;
 atomic_t fscache_n_cop_invalidate_object;
-atomic_t fscache_n_cop_update_object;
 atomic_t fscache_n_cop_drop_object;
 atomic_t fscache_n_cop_put_object;
 atomic_t fscache_n_cop_sync_cache;
@@ -150,9 +149,8 @@ int fscache_stats_show(struct seq_file *m, void *v)
 	seq_printf(m, "CacheOp: alo=%d luo=%d\n",
 		   atomic_read(&fscache_n_cop_alloc_object),
 		   atomic_read(&fscache_n_cop_lookup_object));
-	seq_printf(m, "CacheOp: inv=%d upo=%d dro=%d pto=%d atc=%d syn=%d\n",
+	seq_printf(m, "CacheOp: inv=%d dro=%d pto=%d atc=%d syn=%d\n",
 		   atomic_read(&fscache_n_cop_invalidate_object),
-		   atomic_read(&fscache_n_cop_update_object),
 		   atomic_read(&fscache_n_cop_drop_object),
 		   atomic_read(&fscache_n_cop_put_object),
 		   atomic_read(&fscache_n_cop_attr_changed),
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index ba0ad89a968e..14ee82de2d79 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -116,8 +116,6 @@ struct fscache_cache_ops {
 	/* unpin an object in the cache */
 	void (*unpin_object)(struct fscache_object *object);
 
-	/* store the updated auxiliary data on an object */
-	void (*update_object)(struct fscache_object *object);
 	/* Change the size of a data object */
 	void (*resize_object)(struct fscache_object *object, loff_t new_size);
 


