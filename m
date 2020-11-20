Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11D52BAE41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbgKTPOd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:14:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20617 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728727AbgKTPOc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605885271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kHfpulYYWv1XYUZpZHjx8JJlCiKyf38JLaCifjX8p1U=;
        b=Db031zoUcy8XAV/QNbz9AXbsvjPZXHzSuID+oxnS7/3Tr+QULYb28LVHFPJBPrNzmKCsxZ
        3YUorw9XHH1ywdMtmv9vJ7MJDIzJR22NJsND/w0z4FV2zwSzmAThDjcdz7yQVytnKP4twD
        Fy7CtFIcPTuARBtIk5wGfA2i/ipdSlw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-ccBDG6boPhmWPz0l6NQG8A-1; Fri, 20 Nov 2020 10:14:28 -0500
X-MC-Unique: ccBDG6boPhmWPz0l6NQG8A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9862B8144F1;
        Fri, 20 Nov 2020 15:14:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA2336085D;
        Fri, 20 Nov 2020 15:14:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 55/76] fscache: Remove the update operation
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
Date:   Fri, 20 Nov 2020 15:14:19 +0000
Message-ID: <160588525990.3465195.11175224125263070400.stgit@warthog.procyon.org.uk>
In-Reply-To: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
References: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the cache-side of the object update operation as it doesn't
serialise with other setattr, O_TRUNC and write operations.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/interface.c     |   59 -----------------------------------------
 fs/fscache/internal.h         |    2 -
 fs/fscache/obj.c              |   14 ----------
 fs/fscache/stats.c            |    6 +---
 include/linux/fscache-cache.h |    2 -
 5 files changed, 2 insertions(+), 81 deletions(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index aca08e4227b9..3609ff2fb491 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -150,64 +150,6 @@ struct fscache_object *cachefiles_grab_object(struct fscache_object *_object,
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
@@ -681,7 +623,6 @@ const struct fscache_cache_ops cachefiles_cache_ops = {
 	.lookup_object		= cachefiles_lookup_object,
 	.free_lookup_data	= cachefiles_free_lookup_data,
 	.grab_object		= cachefiles_grab_object,
-	.update_object		= cachefiles_update_object,
 	.resize_object		= cachefiles_resize_object,
 	.invalidate_object	= cachefiles_invalidate_object,
 	.drop_object		= cachefiles_drop_object,
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index ff193f61a4c5..510f166103bf 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -189,7 +189,6 @@ extern atomic_t fscache_n_acquires_oom;
 extern atomic_t fscache_n_invalidates;
 
 extern atomic_t fscache_n_updates;
-extern atomic_t fscache_n_updates_run;
 
 extern atomic_t fscache_n_relinquishes;
 extern atomic_t fscache_n_relinquishes_retire;
@@ -214,7 +213,6 @@ extern atomic_t fscache_n_cop_alloc_object;
 extern atomic_t fscache_n_cop_lookup_object;
 extern atomic_t fscache_n_cop_create_object;
 extern atomic_t fscache_n_cop_invalidate_object;
-extern atomic_t fscache_n_cop_update_object;
 extern atomic_t fscache_n_cop_drop_object;
 extern atomic_t fscache_n_cop_put_object;
 extern atomic_t fscache_n_cop_sync_cache;
diff --git a/fs/fscache/obj.c b/fs/fscache/obj.c
index a36de6af2182..2b0c99095a42 100644
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
@@ -291,12 +283,6 @@ void fscache_drop_object(struct fscache_cookie *cookie,
 	_enter("{o=%08x,%d},%u",
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
index 2a2df9d1649e..350e65870dff 100644
--- a/fs/fscache/stats.c
+++ b/fs/fscache/stats.c
@@ -102,9 +102,8 @@ static int fscache_stats_show(struct seq_file *m, void *v)
 	seq_printf(m, "Invals : n=%u\n",
 		   atomic_read(&fscache_n_invalidates));
 
-	seq_printf(m, "Updates: n=%u nul=%u rsz=%u rsn=%u\n",
+	seq_printf(m, "Updates: n=%u rsz=%u rsn=%u\n",
 		   atomic_read(&fscache_n_updates),
-		   atomic_read(&fscache_n_updates_run),
 		   atomic_read(&fscache_n_resizes),
 		   atomic_read(&fscache_n_resizes_null));
 
@@ -115,9 +114,8 @@ static int fscache_stats_show(struct seq_file *m, void *v)
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
index 958fa899917d..74a09738c899 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -115,8 +115,6 @@ struct fscache_cache_ops {
 	/* unpin an object in the cache */
 	void (*unpin_object)(struct fscache_object *object);
 
-	/* store the updated auxiliary data on an object */
-	void (*update_object)(struct fscache_object *object);
 	/* Change the size of a data object */
 	void (*resize_object)(struct fscache_object *object, loff_t new_size);
 


