Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B872BACDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgKTPGP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:06:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42734 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728706AbgKTPGO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:06:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605884771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3cmElf377VV5pCaI3ZacaDWr2Vk1dfkCNkh+Zy78XCE=;
        b=VDm4iLJLK7XBZkoEzOrWil6EeuNPkhm0ZYWx53uaiziTvjE5vOC2D+Q6DSJbyWsrp82hBh
        /aRJU4d3cq3iPxeMnHUrd9T21uDijKlvtmNY0cI/KD+rUauD8Pwr62+Y/DPhMrqPjuFcld
        jzGUDUOAgrv5EAfFHeZNqMpBZWv6G5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-DZ7F8qW9NdqT_zr_ech__A-1; Fri, 20 Nov 2020 10:06:09 -0500
X-MC-Unique: DZ7F8qW9NdqT_zr_ech__A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B098100C612;
        Fri, 20 Nov 2020 15:06:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4391F60C15;
        Fri, 20 Nov 2020 15:06:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 16/76] cachefiles: Change %p in format strings to
 something else
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
Date:   Fri, 20 Nov 2020 15:06:00 +0000
Message-ID: <160588476042.3465195.6837847445880367183.stgit@warthog.procyon.org.uk>
In-Reply-To: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
References: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change plain %p in format strings in cachefiles code to something more
useful, since %p is now hashed before printing and thus no longer matches
the contents of an oops register dump.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/bind.c      |    2 --
 fs/cachefiles/interface.c |    6 +++---
 fs/cachefiles/key.c       |    2 +-
 fs/cachefiles/namei.c     |   46 +++++++++++++++++++++------------------------
 fs/cachefiles/xattr.c     |    4 ++--
 5 files changed, 27 insertions(+), 33 deletions(-)

diff --git a/fs/cachefiles/bind.c b/fs/cachefiles/bind.c
index dfb14dbddf51..2e9d01a9d53f 100644
--- a/fs/cachefiles/bind.c
+++ b/fs/cachefiles/bind.c
@@ -108,8 +108,6 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
 	atomic_set(&fsdef->usage, 1);
 	fsdef->type = FSCACHE_COOKIE_TYPE_INDEX;
 
-	_debug("- fsdef %p", fsdef);
-
 	/* look up the directory at the root of the cache */
 	ret = kern_path(cache->rootdirname, LOOKUP_DIRECTORY, &path);
 	if (ret < 0)
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 99f42d216ef7..7e10793352fd 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -27,7 +27,7 @@ static struct fscache_object *cachefiles_alloc_object(
 
 	cache = container_of(_cache, struct cachefiles_cache, cache);
 
-	_enter("{%s},%p,", cache->cache.identifier, cookie);
+	_enter("{%s},%x,", cache->cache.identifier, cookie->debug_id);
 
 	/* create a new object record and a temporary leaf image */
 	object = kmem_cache_alloc(cachefiles_object_jar, cachefiles_gfp);
@@ -68,7 +68,7 @@ static struct fscache_object *cachefiles_alloc_object(
 
 	object->lookup_key = key;
 
-	_leave(" = %p [%s]", &object->fscache, key);
+	_leave(" = %x [%s]", object->fscache.debug_id, key);
 	return &object->fscache;
 
 nomem_key:
@@ -301,7 +301,7 @@ static void cachefiles_sync_cache(struct fscache_cache *_cache)
 	const struct cred *saved_cred;
 	int ret;
 
-	_enter("%p", _cache);
+	_enter("%s", _cache->tag->name);
 
 	cache = container_of(_cache, struct cachefiles_cache, cache);
 
diff --git a/fs/cachefiles/key.c b/fs/cachefiles/key.c
index be96f5fc5cac..7f94efc97e23 100644
--- a/fs/cachefiles/key.c
+++ b/fs/cachefiles/key.c
@@ -150,6 +150,6 @@ char *cachefiles_cook_key(const u8 *raw, int keylen, uint8_t type)
 	key[len++] = 0;
 	key[len] = 0;
 
-	_leave(" = %p %d", key, len);
+	_leave(" = %s %d", key, len);
 	return key;
 }
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 924042e8cced..2f37451691b0 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -38,17 +38,17 @@ void __cachefiles_printk_object(struct cachefiles_object *object,
 	       object->fscache.events, object->fscache.event_mask);
 	pr_err("%sops=%u\n",
 	       prefix, object->fscache.n_ops);
-	pr_err("%sparent=%p\n",
-	       prefix, object->fscache.parent);
+	pr_err("%sparent=%x\n",
+	       prefix, object->fscache.parent ? object->fscache.parent->debug_id : 0);
 
 	spin_lock(&object->fscache.lock);
 	cookie = object->fscache.cookie;
 	if (cookie) {
-		pr_err("%scookie=%p [pr=%p fl=%lx]\n",
+		pr_err("%scookie=%x [pr=%x fl=%lx]\n",
 		       prefix,
-		       object->fscache.cookie,
-		       object->fscache.cookie->parent,
-		       object->fscache.cookie->flags);
+		       cookie->debug_id,
+		       cookie->parent ? cookie->parent->debug_id : 0,
+		       cookie->flags);
 		pr_err("%skey=[%u] '", prefix, cookie->key_len);
 		k = (cookie->key_len <= sizeof(cookie->inline_key)) ?
 			cookie->inline_key : cookie->key;
@@ -108,7 +108,7 @@ static void cachefiles_mark_object_buried(struct cachefiles_cache *cache,
 
 	/* found the dentry for  */
 found_dentry:
-	kdebug("preemptive burial: OBJ%x [%s] %p",
+	kdebug("preemptive burial: OBJ%x [%s] %pd",
 	       object->fscache.debug_id,
 	       object->fscache.state->name,
 	       dentry);
@@ -138,7 +138,7 @@ static int cachefiles_mark_object_active(struct cachefiles_cache *cache,
 	struct rb_node **_p, *_parent = NULL;
 	struct dentry *dentry;
 
-	_enter(",%p", object);
+	_enter(",%x", object->fscache.debug_id);
 
 try_again:
 	write_lock(&cache->active_lock);
@@ -296,8 +296,6 @@ static int cachefiles_bury_object(struct cachefiles_cache *cache,
 
 	_enter(",'%pd','%pd'", dir, rep);
 
-	_debug("remove %p from %p", rep, dir);
-
 	/* non-directories can just be unlinked */
 	if (!d_is_dir(rep)) {
 		_debug("unlink stale object");
@@ -436,7 +434,7 @@ int cachefiles_delete_object(struct cachefiles_cache *cache,
 	struct dentry *dir;
 	int ret;
 
-	_enter(",OBJ%x{%p}", object->fscache.debug_id, object->dentry);
+	_enter(",OBJ%x{%pd}", object->fscache.debug_id, object->dentry);
 
 	ASSERT(object->dentry);
 	ASSERT(d_backing_inode(object->dentry));
@@ -489,7 +487,7 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
 	const char *name;
 	int ret, nlen;
 
-	_enter("OBJ%x{%p},OBJ%x,%s,",
+	_enter("OBJ%x{%pd},OBJ%x,%s,",
 	       parent->fscache.debug_id, parent->dentry,
 	       object->fscache.debug_id, key);
 
@@ -534,7 +532,7 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
 
 	inode = d_backing_inode(next);
 	trace_cachefiles_lookup(object, next, inode);
-	_debug("next -> %p %s", next, inode ? "positive" : "negative");
+	_debug("next -> %pd %s", next, inode ? "positive" : "negative");
 
 	if (!key)
 		object->new = !inode;
@@ -572,8 +570,8 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
 			}
 			ASSERT(d_backing_inode(next));
 
-			_debug("mkdir -> %p{%p{ino=%lu}}",
-			       next, d_backing_inode(next), d_backing_inode(next)->i_ino);
+			_debug("mkdir -> %pd{ino=%lu}",
+			       next, d_backing_inode(next)->i_ino);
 
 		} else if (!d_can_lookup(next)) {
 			pr_err("inode %lu is not a directory\n",
@@ -602,8 +600,8 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
 
 			ASSERT(d_backing_inode(next));
 
-			_debug("create -> %p{%p{ino=%lu}}",
-			       next, d_backing_inode(next), d_backing_inode(next)->i_ino);
+			_debug("create -> %pd{ino=%lu}",
+			       next, d_backing_inode(next)->i_ino);
 
 		} else if (!d_can_lookup(next) &&
 			   !d_is_reg(next)
@@ -772,7 +770,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 		goto lookup_error;
 	}
 
-	_debug("subdir -> %p %s",
+	_debug("subdir -> %pd %s",
 	       subdir, d_backing_inode(subdir) ? "positive" : "negative");
 
 	/* we need to create the subdir if it doesn't exist yet */
@@ -798,10 +796,8 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 		}
 		ASSERT(d_backing_inode(subdir));
 
-		_debug("mkdir -> %p{%p{ino=%lu}}",
-		       subdir,
-		       d_backing_inode(subdir),
-		       d_backing_inode(subdir)->i_ino);
+		_debug("mkdir -> %pd{ino=%lu}",
+		       subdir, d_backing_inode(subdir)->i_ino);
 	}
 
 	inode_unlock(d_inode(dir));
@@ -879,7 +875,7 @@ static struct dentry *cachefiles_check_active(struct cachefiles_cache *cache,
 	if (IS_ERR(victim))
 		goto lookup_error;
 
-	//_debug("victim -> %p %s",
+	//_debug("victim -> %pd %s",
 	//       victim, d_backing_inode(victim) ? "positive" : "negative");
 
 	/* if the object is no longer there then we probably retired the object
@@ -910,7 +906,7 @@ static struct dentry *cachefiles_check_active(struct cachefiles_cache *cache,
 
 	read_unlock(&cache->active_lock);
 
-	//_leave(" = %p", victim);
+	//_leave(" = %pd", victim);
 	return victim;
 
 object_in_use:
@@ -956,7 +952,7 @@ int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
 	if (IS_ERR(victim))
 		return PTR_ERR(victim);
 
-	_debug("victim -> %p %s",
+	_debug("victim -> %pd %s",
 	       victim, d_backing_inode(victim) ? "positive" : "negative");
 
 	/* okay... the victim is not being used so we can cull it
diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index a4f1eddebe6f..46913d4157dd 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -41,7 +41,7 @@ int cachefiles_check_object_type(struct cachefiles_object *object)
 	else
 		snprintf(type, 3, "%02x", object->fscache.cookie->type);
 
-	_enter("%p{%s}", object, type);
+	_enter("%x{%s}", object->fscache.debug_id, type);
 
 	/* attempt to install a type label directly */
 	ret = vfs_setxattr(dentry, cachefiles_xattr_cache, type, 2,
@@ -112,7 +112,7 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object,
 	if (!dentry)
 		return -ESTALE;
 
-	_enter("%p,#%d", object, len);
+	_enter("%x,#%d", object->fscache.debug_id, len);
 
 	buf = kmalloc(sizeof(struct cachefiles_xattr) + len, GFP_KERNEL);
 	if (!buf)


