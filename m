Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF45B1C415B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 19:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbgEDRLZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 13:11:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21659 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730111AbgEDRLY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 13:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588612283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q2dwHmud7/NDmbwwfbiKB+mNnuxnVSXeRCB1yE7zU/Q=;
        b=JrvV9MmFwJqd0SPYIgb/GaozfgtbGXJ8fcsVtuLBBLwp9gMhjig90p8Fp9lHxtogH0vl9Q
        Zu0Wdhc9ijMw/1wzF0h5tZo0n8C9Va9yFxO5c/CcxQSdIBMXgRpJaGhsk35D/KFt8IS+Ni
        4scadFdm5s0jL9svGUp1dXO2jw9D/hg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-sqW27Sm0PBaPaiVq6hhpBw-1; Mon, 04 May 2020 13:11:22 -0400
X-MC-Unique: sqW27Sm0PBaPaiVq6hhpBw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E329872FE2;
        Mon,  4 May 2020 17:11:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8BF435C1B2;
        Mon,  4 May 2020 17:11:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 25/61] fscache: Keep track of size of a file last set
 independently on the server
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Jeff Layton <jlayton@redhat.com>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 04 May 2020 18:11:16 +0100
Message-ID: <158861227669.340223.13334555808194661763.stgit@warthog.procyon.org.uk>
In-Reply-To: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
References: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
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
 fs/fscache/cookie.c     |    8 +++++++-
 include/linux/fscache.h |    8 +++++---
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 9485a5afa13d..1f248181d47d 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -577,7 +577,7 @@ static void afs_zap_data(struct afs_vnode *vnode)
 	_enter("{%llx:%llu}", vnode->fid.vid, vnode->fid.vnode);
 
 #ifdef CONFIG_AFS_FSCACHE
-	fscache_invalidate(vnode->cache);
+	fscache_invalidate(vnode->cache, i_size_read(&vnode->vfs_inode));
 #endif
 
 	/* nuke all the non-dirty pages that aren't locked, mapped or being
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 38b8fcf33114..284017fe4a5d 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -159,6 +159,7 @@ struct fscache_cookie *fscache_alloc_cookie(
 	cookie->key_len = index_key_len;
 	cookie->aux_len = aux_data_len;
 	cookie->object_size = object_size;
+	cookie->zero_point = object_size;
 	strlcpy(cookie->type_name, type_name, sizeof(cookie->type_name));
 
 	if (fscache_set_key(cookie, index_key, index_key_len) < 0)
@@ -473,7 +474,7 @@ void fscache_set_cookie_stage(struct fscache_cookie *cookie,
 /*
  * Invalidate an object.  Callable with spinlocks held.
  */
-void __fscache_invalidate(struct fscache_cookie *cookie)
+void __fscache_invalidate(struct fscache_cookie *cookie, loff_t new_size)
 {
 	_enter("{%s}", cookie->type_name);
 
@@ -486,6 +487,11 @@ void __fscache_invalidate(struct fscache_cookie *cookie)
 	 */
 	ASSERTCMP(cookie->type, ==, FSCACHE_COOKIE_TYPE_DATAFILE);
 
+	spin_lock(&cookie->lock);
+	cookie->object_size = new_size;
+	cookie->zero_point = new_size;
+	spin_unlock(&cookie->lock);
+
 	if (!hlist_empty(&cookie->backing_objects) &&
 	    test_and_set_bit(FSCACHE_COOKIE_INVALIDATING, &cookie->flags))
 		fscache_dispatch(cookie, NULL, 0, fscache_invalidate_object);
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 607249ff1bc5..b46df865911c 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -102,6 +102,7 @@ struct fscache_cookie {
 	struct list_head		proc_link;	/* Link in proc list */
 	char				type_name[8];	/* Cookie type name */
 	loff_t				object_size;	/* Size of the netfs object */
+	loff_t				zero_point;	/* Size after which no data on server */
 
 	unsigned long			flags;
 #define FSCACHE_COOKIE_INVALIDATING	4	/* T if cookie is being invalidated */
@@ -187,7 +188,7 @@ extern void __fscache_use_cookie(struct fscache_cookie *, bool);
 extern void __fscache_unuse_cookie(struct fscache_cookie *, const void *, const loff_t *);
 extern void __fscache_relinquish_cookie(struct fscache_cookie *, bool);
 extern void __fscache_update_cookie(struct fscache_cookie *, const void *, const loff_t *);
-extern void __fscache_invalidate(struct fscache_cookie *);
+extern void __fscache_invalidate(struct fscache_cookie *, loff_t);
 extern unsigned int __fscache_shape_extent(struct fscache_cookie *,
 					   struct fscache_extent *,
 					   loff_t, bool);
@@ -421,6 +422,7 @@ void fscache_unpin_cookie(struct fscache_cookie *cookie)
 /**
  * fscache_invalidate - Notify cache that an object needs invalidation
  * @cookie: The cookie representing the cache object
+ * @size: The revised size of the object.
  *
  * Notify the cache that an object is needs to be invalidated and that it
  * should abort any retrievals or stores it is doing on the cache.  The object
@@ -432,10 +434,10 @@ void fscache_unpin_cookie(struct fscache_cookie *cookie)
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


