Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E992BAD92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgKTPIh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:08:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50793 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728907AbgKTPIf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:08:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605884913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JMNAHTCAjTwh70Q7McXz/EQugFKxJcb35XHm86NOyR0=;
        b=dT3GYu8NsUzhIby1fLWCn7S62oW4+WuI+VOI9t82xAfE3axhu0TwRWTNL1SCuHykD5rEiv
        WpDQgdYeQOIhqSWYKQk6qkKx9/vRhE596BhxaWyE7EiXZMuQAj9m1FWVOc4/GlXrV2pVKV
        jaXfll6Vjdzn3KvUtyJoEqWV/UiQL1A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-YBK7ucxvMO2Xq1tUAz8TKw-1; Fri, 20 Nov 2020 10:08:31 -0500
X-MC-Unique: YBK7ucxvMO2Xq1tUAz8TKw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A608018B9F01;
        Fri, 20 Nov 2020 15:08:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 083A55D6AD;
        Fri, 20 Nov 2020 15:08:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 27/76] fscache: Keep track of size of a file last set
 independently on the server
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
Date:   Fri, 20 Nov 2020 15:08:23 +0000
Message-ID: <160588490313.3465195.6021579928823503470.stgit@warthog.procyon.org.uk>
In-Reply-To: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
References: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Keep track of the size of a file that we're caching as last set
independently on the server by another client.  As long as this does not
change, we can make the assumption that anything over that boundary, if not
represented in the local cache, will not be represented on the server
either and can be just cleared rather than being read, thereby saving a
trip to the server.

This only works if we make space in the cache by zapping whole files and
not just punching bits out of them as if we write to the server but don't
keep a copy in the cache, the assumption mentioned above no longer holds
true.

We also need to update this size when invalidation occurs.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/inode.c          |    2 +-
 fs/fscache/cookie.c     |    6 +++++-
 include/linux/fscache.h |    8 +++++---
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index df999d703e2b..0ba2815f8152 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -569,7 +569,7 @@ static void afs_zap_data(struct afs_vnode *vnode)
 	_enter("{%llx:%llu}", vnode->fid.vid, vnode->fid.vnode);
 
 #ifdef CONFIG_AFS_FSCACHE
-	fscache_invalidate(vnode->cache);
+	fscache_invalidate(vnode->cache, i_size_read(&vnode->vfs_inode));
 #endif
 
 	/* nuke all the non-dirty pages that aren't locked, mapped or being
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index e6b87596b1d0..230025a1495c 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -159,6 +159,7 @@ struct fscache_cookie *fscache_alloc_cookie(
 	cookie->key_len = index_key_len;
 	cookie->aux_len = aux_data_len;
 	cookie->object_size = object_size;
+	cookie->zero_point = object_size;
 	strlcpy(cookie->type_name, type_name, sizeof(cookie->type_name));
 
 	if (fscache_set_key(cookie, index_key, index_key_len) < 0)
@@ -532,7 +533,7 @@ void fscache_set_cookie_stage(struct fscache_cookie *cookie,
 /*
  * Invalidate an object.  Callable with spinlocks held.
  */
-void __fscache_invalidate(struct fscache_cookie *cookie)
+void __fscache_invalidate(struct fscache_cookie *cookie, loff_t new_size)
 {
 	struct fscache_object *object = NULL;
 
@@ -548,6 +549,9 @@ void __fscache_invalidate(struct fscache_cookie *cookie)
 	ASSERTCMP(cookie->type, ==, FSCACHE_COOKIE_TYPE_DATAFILE);
 
 	spin_lock(&cookie->lock);
+	cookie->object_size = new_size;
+	cookie->zero_point = new_size;
+
 	if (!hlist_empty(&cookie->backing_objects))
 		object = hlist_entry(cookie->backing_objects.first,
 				     struct fscache_object, cookie_link);
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 3cd18ddc3903..8d47c7a08456 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -118,6 +118,7 @@ struct fscache_cookie {
 	struct list_head		proc_link;	/* Link in proc list */
 	char				type_name[8];	/* Cookie type name */
 	loff_t				object_size;	/* Size of the netfs object */
+	loff_t				zero_point;	/* Size after which no data on server */
 
 	unsigned long			flags;
 #define FSCACHE_COOKIE_RELINQUISHED	6		/* T if cookie has been relinquished */
@@ -201,7 +202,7 @@ extern int __fscache_begin_operation(struct fscache_cookie *, struct fscache_op_
 				     enum fscache_want_stage);
 extern void __fscache_relinquish_cookie(struct fscache_cookie *, bool);
 extern void __fscache_update_cookie(struct fscache_cookie *, const void *, const loff_t *);
-extern void __fscache_invalidate(struct fscache_cookie *);
+extern void __fscache_invalidate(struct fscache_cookie *, loff_t);
 
 /**
  * fscache_register_netfs - Register a filesystem as desiring caching services
@@ -427,6 +428,7 @@ void fscache_unpin_cookie(struct fscache_cookie *cookie)
 /**
  * fscache_invalidate - Notify cache that an object needs invalidation
  * @cookie: The cookie representing the cache object
+ * @size: The revised size of the object.
  *
  * Notify the cache that an object is needs to be invalidated and that it
  * should abort any retrievals or stores it is doing on the cache.  The object
@@ -438,10 +440,10 @@ void fscache_unpin_cookie(struct fscache_cookie *cookie)
  * description.
  */
 static inline
-void fscache_invalidate(struct fscache_cookie *cookie)
+void fscache_invalidate(struct fscache_cookie *cookie, loff_t size)
 {
 	if (fscache_cookie_valid(cookie))
-		__fscache_invalidate(cookie);
+		__fscache_invalidate(cookie, size);
 }
 
 /**


