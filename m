Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88AA04320D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 16:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbhJRO67 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 10:58:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37184 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232308AbhJRO66 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634569007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3wB94hRxoMsUUmAQY8enc2qloPgpN4ISb3zVuHp6Vs0=;
        b=I+EZxVusEK6Qdqkd2NG/ufui0jnm/drf/bFItFQQuLlmsunBV7E1Mtmde4D8hCSX8GU7Lm
        AigldF6qbh3dv7zHN0Mh/DArVhF7nDiFZfn4EyCzO+Qv7ntVr59Toy8CvtFFo6bRC+avdx
        SB09B0581uLj22RALGp4MweGvZEjpq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-xpI-AF4UMTCEDfiNkQix0Q-1; Mon, 18 Oct 2021 10:56:42 -0400
X-MC-Unique: xpI-AF4UMTCEDfiNkQix0Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80C4779EDC;
        Mon, 18 Oct 2021 14:56:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C7B7078B20;
        Mon, 18 Oct 2021 14:56:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 22/67] cachefiles: Simplify the pathwalk and save the filename
 for an object
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
Date:   Mon, 18 Oct 2021 15:56:15 +0100
Message-ID: <163456897591.2614702.16753183518371622819.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the future, I want to move to an invalidation model where invalidation
on a live cache object is achieved by opening a tmpfile, changing the
pointer to cut over I/O and then linking it into place in the parent
directory later rather than by truncating the file on the spot.

To this make this work, however, I need the filename to pass to
vfs_link()[*].  I can either copy it from the outgoing dentry (which I then
need to unlink) or

[*] Unless I can pass a flag to vfs_link() to tell it to replace the file
    at that dentry.

The filename concocted by cook key is a path relative to the parent index,
and may contain multiple components if the object key gets rendered to a
size larger than NAME_MAX.

However, apart from one exception, none of the filesystems have a key
that's anywhere near that large - even NFS filehandles top out at about 128
bytes, which encoded in base64 increase by a quarter to 192 plus a few
extra chars of markup.  The exception is the AFS cell name, which is a
domain name and can be up to 255 chars in size.  Restricting this allows
simplification of the pathwalk.

So, to this end, the following changes are made:

 (1) Restrict keys to those that can be rendered in NAME_MAX size.

 (2) Simplify the filename generation to store the fanout selection
     separately from the key filename and put the key filename alone into
     the filename string.

     As before, if suitable, the key is rendered directly, prefixed by
     I/D/S and an encoded length.  Otherwise, it has the length prepended
     and the whole lot is rendered into base64 and then prefixed with
     J/E/T.

     (The lengths are at least partially redundant, but a later patch is
     going to fully overhaul the encodings anyway).

     Allocating a temporary buffer to expand the key is only necessary when
     rendering to base64.

 (3) cachefiles_cook_key() now returns a bool and attaches the name string
     and key hash (fanout selection) directly to the object.  The name is
     freed when the object is freed.

 (4) Simplify the pathwalk to assume there are exactly two steps in looking
     up an object: one fanout dir and then one directory or file
     representing the object itself.  The fanout filename is rendered on
     the fly.

 (5) Assume that data objects are always going to be files and not a
     directory with further structure therein.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/bind.c              |    4 
 fs/cachefiles/interface.c         |   41 +---
 fs/cachefiles/internal.h          |   17 +-
 fs/cachefiles/key.c               |  179 +++++++---------
 fs/cachefiles/namei.c             |  403 +++++++++++++++++--------------------
 include/trace/events/cachefiles.h |   22 --
 6 files changed, 279 insertions(+), 387 deletions(-)

diff --git a/fs/cachefiles/bind.c b/fs/cachefiles/bind.c
index 0bc748081f59..fbc8577477c1 100644
--- a/fs/cachefiles/bind.c
+++ b/fs/cachefiles/bind.c
@@ -188,7 +188,7 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
 	       (unsigned long long) cache->bstop);
 
 	/* get the cache directory and check its type */
-	cachedir = cachefiles_get_directory(cache, root, "cache");
+	cachedir = cachefiles_get_directory(cache, root, "cache", NULL);
 	if (IS_ERR(cachedir)) {
 		ret = PTR_ERR(cachedir);
 		goto error_unsupported;
@@ -198,7 +198,7 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
 	fsdef->fscache.cookie = NULL;
 
 	/* get the graveyard directory */
-	graveyard = cachefiles_get_directory(cache, root, "graveyard");
+	graveyard = cachefiles_get_directory(cache, root, "graveyard", NULL);
 	if (IS_ERR(graveyard)) {
 		ret = PTR_ERR(graveyard);
 		goto error_unsupported;
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index bc28bb6c7ef5..2083aca6bd0c 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -21,9 +21,6 @@ static struct fscache_object *cachefiles_alloc_object(
 {
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
-	unsigned keylen;
-	void *buffer, *p;
-	char *key;
 
 	cache = container_of(_cache, struct cachefiles_cache, cache);
 
@@ -42,37 +39,14 @@ static struct fscache_object *cachefiles_alloc_object(
 
 	object->type = cookie->type;
 
-	/* get hold of the raw key
-	 * - stick the length on the front and leave space on the back for the
-	 *   encoder
-	 */
-	buffer = kmalloc((2 + 512) + 3, cachefiles_gfp);
-	if (!buffer)
-		goto nomem_buffer;
-
-	keylen = cookie->key_len;
-	p = fscache_get_key(cookie);
-	memcpy(buffer + 2, p, keylen);
-
-	*(uint16_t *)buffer = keylen;
-	((char *)buffer)[keylen + 2] = 0;
-	((char *)buffer)[keylen + 3] = 0;
-	((char *)buffer)[keylen + 4] = 0;
-
 	/* turn the raw key into something that can work with as a filename */
-	key = cachefiles_cook_key(buffer, keylen + 2, object->type);
-	kfree(buffer);
-	if (!key)
+	if (!cachefiles_cook_key(object))
 		goto nomem_key;
 
-	object->lookup_key = key;
-
-	_leave(" = %x [%s]", object->fscache.debug_id, key);
+	_leave(" = %x [%s]", object->fscache.debug_id, object->d_name);
 	return &object->fscache;
 
 nomem_key:
-	kfree(buffer);
-nomem_buffer:
 	kmem_cache_free(cachefiles_object_jar, object);
 	fscache_object_destroyed(&cache->cache);
 nomem_object:
@@ -98,11 +72,11 @@ static int cachefiles_lookup_object(struct fscache_object *_object)
 			      struct cachefiles_object, fscache);
 	object = container_of(_object, struct cachefiles_object, fscache);
 
-	ASSERTCMP(object->lookup_key, !=, NULL);
+	ASSERT(object->d_name);
 
 	/* look up the key, creating any missing bits */
 	cachefiles_begin_secure(cache, &saved_cred);
-	ret = cachefiles_walk_to_object(parent, object, object->lookup_key);
+	ret = cachefiles_walk_to_object(parent, object);
 	cachefiles_end_secure(cache, saved_cred);
 
 	/* polish off by setting the attributes of non-index files */
@@ -130,9 +104,6 @@ static void cachefiles_lookup_complete(struct fscache_object *_object)
 	object = container_of(_object, struct cachefiles_object, fscache);
 
 	_enter("{OBJ%x}", object->fscache.debug_id);
-
-	kfree(object->lookup_key);
-	object->lookup_key = NULL;
 }
 
 /*
@@ -224,7 +195,7 @@ static void cachefiles_drop_object(struct fscache_object *_object)
 			dput(object->backer);
 		object->backer = NULL;
 
-		cachefiles_unmark_inode_in_use(object, object->dentry);
+		cachefiles_unmark_inode_in_use(object);
 		dput(object->dentry);
 		object->dentry = NULL;
 	}
@@ -269,7 +240,7 @@ void cachefiles_put_object(struct fscache_object *_object,
 		ASSERTCMP(object->fscache.n_ops, ==, 0);
 		ASSERTCMP(object->fscache.n_children, ==, 0);
 
-		kfree(object->lookup_key);
+		kfree(object->d_name);
 
 		cache = object->fscache.cache;
 		fscache_object_destroy(&object->fscache);
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 6464a6821bfb..83911cf24769 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -34,13 +34,15 @@ extern unsigned cachefiles_debug;
  */
 struct cachefiles_object {
 	struct fscache_object		fscache;	/* fscache handle */
-	char				*lookup_key;	/* key to look up */
+	char				*d_name;	/* Filename */
 	struct dentry			*dentry;	/* the file/dir representing this object */
 	struct dentry			*backer;	/* backing file */
 	loff_t				i_size;		/* object size */
 	atomic_t			usage;		/* object usage count */
 	uint8_t				type;		/* object type */
-	uint8_t				new;		/* T if object new */
+	bool				new;		/* T if object new */
+	u8				d_name_len;	/* Length of filename */
+	u8				key_hash;
 };
 
 extern struct kmem_cache *cachefiles_object_jar;
@@ -119,21 +121,20 @@ void cachefiles_put_object(struct fscache_object *_object,
 /*
  * key.c
  */
-extern char *cachefiles_cook_key(const u8 *raw, int keylen, uint8_t type);
+extern bool cachefiles_cook_key(struct cachefiles_object *object);
 
 /*
  * namei.c
  */
-extern void cachefiles_unmark_inode_in_use(struct cachefiles_object *object,
-				    struct dentry *dentry);
+extern void cachefiles_unmark_inode_in_use(struct cachefiles_object *object);
 extern int cachefiles_delete_object(struct cachefiles_cache *cache,
 				    struct cachefiles_object *object);
 extern int cachefiles_walk_to_object(struct cachefiles_object *parent,
-				     struct cachefiles_object *object,
-				     const char *key);
+				     struct cachefiles_object *object);
 extern struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 					       struct dentry *dir,
-					       const char *name);
+					       const char *name,
+					       struct cachefiles_object *object);
 
 extern int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
 			   char *filename);
diff --git a/fs/cachefiles/key.c b/fs/cachefiles/key.c
index 7f94efc97e23..56a9b3201b41 100644
--- a/fs/cachefiles/key.c
+++ b/fs/cachefiles/key.c
@@ -24,132 +24,107 @@ static const char cachefiles_filecharmap[256] = {
 
 /*
  * turn the raw key into something cooked
- * - the raw key should include the length in the two bytes at the front
- * - the key may be up to 514 bytes in length (including the length word)
+ * - the key may be up to NAME_MAX in length (including the length word)
  *   - "base64" encode the strange keys, mapping 3 bytes of raw to four of
  *     cooked
  *   - need to cut the cooked key into 252 char lengths (189 raw bytes)
  */
-char *cachefiles_cook_key(const u8 *raw, int keylen, uint8_t type)
+bool cachefiles_cook_key(struct cachefiles_object *object)
 {
-	unsigned char csum, ch;
-	unsigned int acc;
-	char *key;
-	int loop, len, max, seg, mark, print;
+	const u8 *key = fscache_get_key(object->fscache.cookie);
+	unsigned int acc, sum, keylen = object->fscache.cookie->key_len;
+	char *name;
+	u8 *buffer, *p;
+	int i, len, elem3, print;
+	u8 type;
 
 	_enter(",%d", keylen);
 
-	BUG_ON(keylen < 2 || keylen > 514);
+	BUG_ON(keylen > NAME_MAX - 3);
 
-	csum = raw[0] + raw[1];
+	sum = 0;
 	print = 1;
-	for (loop = 2; loop < keylen; loop++) {
-		ch = raw[loop];
-		csum += ch;
+	for (i = 0; i < keylen; i++) {
+		u8 ch = key[i];
+		sum += ch;
 		print &= cachefiles_filecharmap[ch];
 	}
+	object->key_hash = sum;
 
+	/* If the path is usable ASCII, then we render it directly */
 	if (print) {
-		/* if the path is usable ASCII, then we render it directly */
-		max = keylen - 2;
-		max += 2;	/* two base64'd length chars on the front */
-		max += 5;	/* @checksum/M */
-		max += 3 * 2;	/* maximum number of segment dividers (".../M")
-				 * is ((514 + 251) / 252) = 3
-				 */
-		max += 1;	/* NUL on end */
-	} else {
-		/* calculate the maximum length of the cooked key */
-		keylen = (keylen + 2) / 3;
-
-		max = keylen * 4;
-		max += 5;	/* @checksum/M */
-		max += 3 * 2;	/* maximum number of segment dividers (".../M")
-				 * is ((514 + 188) / 189) = 3
-				 */
-		max += 1;	/* NUL on end */
-	}
+		name = kmalloc(3 + keylen + 1, cachefiles_gfp);
+		if (!name)
+			return false;
 
-	max += 1;	/* 2nd NUL on end */
+		switch (object->fscache.cookie->type) {
+		case FSCACHE_COOKIE_TYPE_INDEX:		type = 'I';	break;
+		case FSCACHE_COOKIE_TYPE_DATAFILE:	type = 'D';	break;
+		default:				type = 'S';	break;
+		}
 
-	_debug("max: %d", max);
+		name[0] = type;
+		name[1] = cachefiles_charmap[(keylen >> 6) & 63];
+		name[2] = cachefiles_charmap[keylen & 63];
 
-	key = kmalloc(max, cachefiles_gfp);
-	if (!key)
-		return NULL;
+		memcpy(name + 3, key, keylen);
+		name[3 + keylen] = 0;
+		object->d_name = name;
+		object->d_name_len = 3 + keylen;
+		goto success;
+	}
 
-	len = 0;
+	/* Construct the key we actually want to render.  We stick the length
+	 * on the front and leave NULs on the back for the encoder to overread.
+	 */
+	buffer = kmalloc(2 + keylen + 3, cachefiles_gfp);
+	if (!buffer)
+		return false;
 
-	/* build the cooked key */
-	sprintf(key, "@%02x%c+", (unsigned) csum, 0);
-	len = 5;
-	mark = len - 1;
+	memcpy(buffer + 2, key, keylen);
 
-	if (print) {
-		acc = *(uint16_t *) raw;
-		raw += 2;
+	*(uint16_t *)buffer = keylen;
+	((char *)buffer)[keylen + 2] = 0;
+	((char *)buffer)[keylen + 3] = 0;
+	((char *)buffer)[keylen + 4] = 0;
 
-		key[len + 1] = cachefiles_charmap[acc & 63];
-		acc >>= 6;
-		key[len] = cachefiles_charmap[acc & 63];
-		len += 2;
-
-		seg = 250;
-		for (loop = keylen; loop > 0; loop--) {
-			if (seg <= 0) {
-				key[len++] = '\0';
-				mark = len;
-				key[len++] = '+';
-				seg = 252;
-			}
-
-			key[len++] = *raw++;
-			ASSERT(len < max);
-		}
+	elem3 = DIV_ROUND_UP(2 + keylen, 3); /* Count of 3-byte elements */
+	len = elem3 * 4;
 
-		switch (type) {
-		case FSCACHE_COOKIE_TYPE_INDEX:		type = 'I';	break;
-		case FSCACHE_COOKIE_TYPE_DATAFILE:	type = 'D';	break;
-		default:				type = 'S';	break;
-		}
-	} else {
-		seg = 252;
-		for (loop = keylen; loop > 0; loop--) {
-			if (seg <= 0) {
-				key[len++] = '\0';
-				mark = len;
-				key[len++] = '+';
-				seg = 252;
-			}
-
-			acc = *raw++;
-			acc |= *raw++ << 8;
-			acc |= *raw++ << 16;
-
-			_debug("acc: %06x", acc);
-
-			key[len++] = cachefiles_charmap[acc & 63];
-			acc >>= 6;
-			key[len++] = cachefiles_charmap[acc & 63];
-			acc >>= 6;
-			key[len++] = cachefiles_charmap[acc & 63];
-			acc >>= 6;
-			key[len++] = cachefiles_charmap[acc & 63];
-
-			ASSERT(len < max);
-		}
+	name = kmalloc(1 + len + 1, cachefiles_gfp);
+	if (!name) {
+		kfree(buffer);
+		return false;
+	}
 
-		switch (type) {
-		case FSCACHE_COOKIE_TYPE_INDEX:		type = 'J';	break;
-		case FSCACHE_COOKIE_TYPE_DATAFILE:	type = 'E';	break;
-		default:				type = 'T';	break;
-		}
+	switch (object->fscache.cookie->type) {
+	case FSCACHE_COOKIE_TYPE_INDEX:		type = 'J';	break;
+	case FSCACHE_COOKIE_TYPE_DATAFILE:	type = 'E';	break;
+	default:				type = 'T';	break;
 	}
 
-	key[mark] = type;
-	key[len++] = 0;
-	key[len] = 0;
+	name[0] = type;
+	len = 1;
+	p = buffer;
+	for (i = 0; i < elem3; i++) {
+		acc = *p++;
+		acc |= *p++ << 8;
+		acc |= *p++ << 16;
+
+		name[len++] = cachefiles_charmap[acc & 63];
+		acc >>= 6;
+		name[len++] = cachefiles_charmap[acc & 63];
+		acc >>= 6;
+		name[len++] = cachefiles_charmap[acc & 63];
+		acc >>= 6;
+		name[len++] = cachefiles_charmap[acc & 63];
+	}
 
-	_leave(" = %s %d", key, len);
-	return key;
+	name[len] = 0;
+	object->d_name = name;
+	object->d_name_len = len;
+	kfree(buffer);
+success:
+	_leave(" = %s", object->d_name);
+	return true;
 }
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 04c767624e3d..10b6d571eda8 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -23,9 +23,9 @@
 /*
  * Mark the backing file as being a cache file if it's not already in use so.
  */
-static bool cachefiles_mark_inode_in_use(struct cachefiles_object *object,
-					 struct dentry *dentry)
+static bool cachefiles_mark_inode_in_use(struct cachefiles_object *object)
 {
+	struct dentry *dentry = object->dentry;
 	struct inode *inode = d_backing_inode(dentry);
 	bool can_use = false;
 
@@ -48,9 +48,9 @@ static bool cachefiles_mark_inode_in_use(struct cachefiles_object *object,
 /*
  * Unmark a backing inode.
  */
-void cachefiles_unmark_inode_in_use(struct cachefiles_object *object,
-				    struct dentry *dentry)
+void cachefiles_unmark_inode_in_use(struct cachefiles_object *object)
 {
+	struct dentry *dentry = object->dentry;
 	struct inode *inode = d_backing_inode(dentry);
 
 	inode_lock(inode);
@@ -265,263 +265,221 @@ int cachefiles_delete_object(struct cachefiles_cache *cache,
 }
 
 /*
- * walk from the parent object to the child object through the backing
- * filesystem, creating directories as we go
+ * Check and open the terminal object.
  */
-int cachefiles_walk_to_object(struct cachefiles_object *parent,
-			      struct cachefiles_object *object,
-			      const char *key)
+static int cachefiles_check_open_object(struct cachefiles_cache *cache,
+					struct cachefiles_object *object,
+					struct dentry *fan)
 {
-	struct cachefiles_cache *cache;
-	struct dentry *dir, *next = NULL;
-	struct inode *inode;
 	struct path path;
-	const char *name;
-	bool marked = false;
-	int ret, nlen;
+	int ret;
 
-	_enter("OBJ%x{%pd},OBJ%x,%s,",
-	       parent->fscache.debug_id, parent->dentry,
-	       object->fscache.debug_id, key);
+	if (!cachefiles_mark_inode_in_use(object))
+		return -EBUSY;
 
-	cache = container_of(parent->fscache.cache,
-			     struct cachefiles_cache, cache);
-	path.mnt = cache->mnt;
+	/* if we've found that the terminal object exists, then we need to
+	 * check its attributes and delete it if it's out of date */
+	if (!object->new) {
+		_debug("validate '%pd'", object->dentry);
 
-	ASSERT(parent->dentry);
-	ASSERT(d_backing_inode(parent->dentry));
+		ret = cachefiles_check_auxdata(object);
+		if (ret == -ESTALE)
+			goto stale;
+		if (ret < 0)
+			goto error_unmark;
+	}
+
+	_debug("=== OBTAINED_OBJECT ===");
 
-	if (!(d_is_dir(parent->dentry))) {
-		// TODO: convert file to dir
-		_leave("looking up in none directory");
-		return -ENOBUFS;
+	if (object->new) {
+		/* attach data to a newly constructed terminal object */
+		ret = cachefiles_set_object_xattr(object, XATTR_CREATE);
+		if (ret < 0)
+			goto error_unmark;
+	} else {
+		/* always update the atime on an object we've just looked up
+		 * (this is used to keep track of culling, and atimes are only
+		 * updated by read, write and readdir but not lookup or
+		 * open) */
+		path.mnt = cache->mnt;
+		path.dentry = object->dentry;
+		touch_atime(&path);
 	}
 
-	dir = dget(parent->dentry);
+	return 0;
 
-advance:
-	/* attempt to transit the first directory component */
-	name = key;
-	nlen = strlen(key);
+stale:
+	cachefiles_unmark_inode_in_use(object);
+	inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
+	ret = cachefiles_bury_object(cache, object, fan, object->dentry,
+				     FSCACHE_OBJECT_IS_STALE);
+	if (ret < 0)
+		return ret;
+	_debug("redo lookup");
+	return -ESTALE;
 
-	/* key ends in a double NUL */
-	key = key + nlen + 1;
-	if (!*key)
-		key = NULL;
+error_unmark:
+	cachefiles_unmark_inode_in_use(object);
+	return ret;
+}
 
-lookup_again:
-	/* search the current directory for the element name */
-	_debug("lookup '%s'", name);
+/*
+ * Walk to a file, creating it if necessary.
+ */
+static int cachefiles_walk_to_file(struct cachefiles_cache *cache,
+				   struct cachefiles_object *object,
+				   struct dentry *fan)
+{
+	struct dentry *dentry;
+	struct inode *dinode = d_backing_inode(fan);
+	struct path fan_path;
+	int ret;
 
-	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
+	_enter("%pd %s", fan, object->d_name);
 
-	next = lookup_one_len(name, dir, nlen);
-	if (IS_ERR(next)) {
-		trace_cachefiles_lookup(object, next, NULL);
-		ret = PTR_ERR(next);
-		goto lookup_error;
-	}
+	inode_lock_nested(dinode, I_MUTEX_PARENT);
 
-	inode = d_backing_inode(next);
-	trace_cachefiles_lookup(object, next, inode);
-	_debug("next -> %pd %s", next, inode ? "positive" : "negative");
+	dentry = lookup_one_len(object->d_name, fan, object->d_name_len);
+	if (IS_ERR(dentry)) {
+		trace_cachefiles_lookup(object, dentry, NULL);
+		ret = PTR_ERR(dentry);
+		goto error;
+	}
 
-	if (!key)
-		object->new = !inode;
+	trace_cachefiles_lookup(object, dentry, d_backing_inode(dentry));
 
-	/* if this element of the path doesn't exist, then the lookup phase
-	 * failed, and we can release any readers in the certain knowledge that
-	 * there's nothing for them to actually read */
-	if (d_is_negative(next))
+	if (d_is_negative(dentry)) {
+		/* This element of the path doesn't exist, so we can release
+		 * any readers in the certain knowledge that there's nothing
+		 * for them to actually read */
 		fscache_object_lookup_negative(&object->fscache);
 
-	/* we need to create the object if it's negative */
-	if (key || object->type == FSCACHE_COOKIE_TYPE_INDEX) {
-		/* index objects and intervening tree levels must be subdirs */
-		if (d_is_negative(next)) {
-			ret = cachefiles_has_space(cache, 1, 0);
-			if (ret < 0)
-				goto no_space_error;
-
-			path.dentry = dir;
-			ret = security_path_mkdir(&path, next, 0);
-			if (ret < 0)
-				goto create_error;
-			ret = vfs_mkdir(&init_user_ns, d_inode(dir), next, 0);
-			if (!key)
-				trace_cachefiles_mkdir(object, next, ret);
-			if (ret < 0)
-				goto create_error;
-
-			if (unlikely(d_unhashed(next))) {
-				dput(next);
-				inode_unlock(d_inode(dir));
-				goto lookup_again;
-			}
-			ASSERT(d_backing_inode(next));
-
-			_debug("mkdir -> %pd{ino=%lu}",
-			       next, d_backing_inode(next)->i_ino);
-
-		} else if (!d_can_lookup(next)) {
-			pr_err("inode %lu is not a directory\n",
-			       d_backing_inode(next)->i_ino);
-			ret = -ENOBUFS;
-			goto error;
+		ret = cachefiles_has_space(cache, 1, 0);
+		if (ret < 0) {
+			fscache_object_mark_killed(&object->fscache, FSCACHE_OBJECT_NO_SPACE);
+			goto error_dput;
 		}
 
-	} else {
-		/* non-index objects start out life as files */
-		if (d_is_negative(next)) {
-			ret = cachefiles_has_space(cache, 1, 0);
-			if (ret < 0)
-				goto no_space_error;
-
-			path.dentry = dir;
-			ret = security_path_mknod(&path, next, S_IFREG, 0);
-			if (ret < 0)
-				goto create_error;
-			ret = vfs_create(&init_user_ns, d_inode(dir), next,
-					 S_IFREG, true);
-			trace_cachefiles_create(object, next, ret);
-			if (ret < 0)
-				goto create_error;
-
-			ASSERT(d_backing_inode(next));
-
-			_debug("create -> %pd{ino=%lu}",
-			       next, d_backing_inode(next)->i_ino);
-
-		} else if (!d_can_lookup(next) &&
-			   !d_is_reg(next)
-			   ) {
-			pr_err("inode %lu is not a file or directory\n",
-			       d_backing_inode(next)->i_ino);
-			ret = -ENOBUFS;
-			goto error;
-		}
-	}
+		fan_path.mnt = cache->mnt;
+		fan_path.dentry = fan;
+		ret = security_path_mknod(&fan_path, dentry, S_IFREG, 0);
+		if (ret < 0)
+			goto error_dput;
+		ret = vfs_create(&init_user_ns, dinode, dentry, S_IFREG, true);
+		trace_cachefiles_create(object, dentry, ret);
+		if (ret < 0)
+			goto error_dput;
 
-	/* process the next component */
-	if (key) {
-		_debug("advance");
-		inode_unlock(d_inode(dir));
-		dput(dir);
-		dir = next;
-		next = NULL;
-		goto advance;
-	}
+		_debug("create -> %pd{ino=%lu}",
+		       dentry, d_backing_inode(dentry)->i_ino);
+		object->new = true;
 
-	/* we've found the object we were looking for */
-	object->dentry = next;
+	} else if (!d_is_reg(dentry)) {
+		pr_err("inode %lu is not a file\n",
+		       d_backing_inode(dentry)->i_ino);
+		ret = -EIO;
+		goto error_dput;
+	} else {
+		_debug("file -> %pd positive", dentry);
+	}
 
-	/* note that we're now using this object */
-	if (!cachefiles_mark_inode_in_use(object, object->dentry)) {
-		ret = -EBUSY;
-		goto check_error_unlock;
+	if (dentry->d_sb->s_blocksize > PAGE_SIZE) {
+		pr_warn("cachefiles: Block size too large\n");
+		ret = -EIO;
+		goto error_dput;
 	}
-	marked = true;
 
-	/* if we've found that the terminal object exists, then we need to
-	 * check its attributes and delete it if it's out of date */
-	if (!object->new) {
-		_debug("validate '%pd'", next);
+	object->dentry = dentry;
+	inode_unlock(dinode);
+	return 0;
 
-		ret = cachefiles_check_auxdata(object);
-		if (ret == -ESTALE) {
-			/* delete the object (the deleter drops the directory
-			 * mutex) */
-			object->dentry = NULL;
-
-			ret = cachefiles_bury_object(cache, object, dir, next,
-						     FSCACHE_OBJECT_IS_STALE);
-			dput(next);
-			next = NULL;
-
-			if (ret < 0)
-				goto error_out2;
-
-			_debug("redo lookup");
-			fscache_object_retrying_stale(&object->fscache);
-			goto lookup_again;
-		}
-	}
+error_dput:
+	dput(dentry);
+error:
+	inode_unlock(dinode);
+	return ret;
+}
 
-	inode_unlock(d_inode(dir));
-	dput(dir);
-	dir = NULL;
+/*
+ * Walk over the fanout directory.
+ */
+static struct dentry *cachefiles_walk_over_fanout(struct cachefiles_object *object,
+						  struct cachefiles_cache *cache,
+						  struct dentry *dir)
+{
+	char name[4];
 
-	_debug("=== OBTAINED_OBJECT ===");
+	snprintf(name, sizeof(name), "@%02x", object->key_hash);
+	return cachefiles_get_directory(cache, dir, name, object);
+}
 
-	if (object->new) {
-		/* attach data to a newly constructed terminal object */
-		ret = cachefiles_set_object_xattr(object, XATTR_CREATE);
-		if (ret < 0)
-			goto check_error;
-	} else {
-		/* always update the atime on an object we've just looked up
-		 * (this is used to keep track of culling, and atimes are only
-		 * updated by read, write and readdir but not lookup or
-		 * open) */
-		path.dentry = next;
-		touch_atime(&path);
-	}
+/*
+ * walk from the parent object to the child object through the backing
+ * filesystem, creating directories as we go
+ */
+int cachefiles_walk_to_object(struct cachefiles_object *parent,
+			      struct cachefiles_object *object)
+{
+	struct cachefiles_cache *cache;
+	struct dentry *fan, *dentry;
+	int ret;
 
-	/* open a file interface onto a data file */
-	if (object->type != FSCACHE_COOKIE_TYPE_INDEX) {
-		if (d_is_reg(object->dentry)) {
-			const struct address_space_operations *aops;
+	_enter("OBJ%x{%pd},OBJ%x,%s,",
+	       parent->fscache.debug_id, parent->dentry,
+	       object->fscache.debug_id, object->d_name);
 
-			ret = -EPERM;
-			aops = d_backing_inode(object->dentry)->i_mapping->a_ops;
-			if (!aops->bmap)
-				goto check_error;
-			if (object->dentry->d_sb->s_blocksize > PAGE_SIZE)
-				goto check_error;
+	cache = container_of(parent->fscache.cache,
+			     struct cachefiles_cache, cache);
+	ASSERT(parent->dentry);
+	ASSERT(d_backing_inode(parent->dentry));
 
-			object->backer = object->dentry;
-		} else {
-			BUG(); // TODO: open file in data-class subdir
+lookup_again:
+	fan = cachefiles_walk_over_fanout(object, cache, parent->dentry);
+	if (IS_ERR(fan))
+		return PTR_ERR(fan);
+
+	/* Walk over path "parent/fanout/object". */
+	if (object->type == FSCACHE_COOKIE_TYPE_INDEX) {
+		dentry = cachefiles_get_directory(cache, fan, object->d_name,
+						  object);
+		if (IS_ERR(dentry)) {
+			dput(fan);
+			return PTR_ERR(dentry);
+		}
+		object->dentry = dentry;
+	} else {
+		ret = cachefiles_walk_to_file(cache, object, fan);
+		if (ret < 0) {
+			dput(fan);
+			return ret;
 		}
 	}
 
-	object->new = 0;
-	fscache_obtained_object(&object->fscache);
+	ret = cachefiles_check_open_object(cache, object, fan);
+	dput(fan);
+	fan = NULL;
+	if (ret < 0)
+		goto check_error;
 
+	object->backer = object->dentry;
+	object->new = false;
+	fscache_obtained_object(&object->fscache);
 	_leave(" = 0 [%lu]", d_backing_inode(object->dentry)->i_ino);
 	return 0;
 
-no_space_error:
-	fscache_object_mark_killed(&object->fscache, FSCACHE_OBJECT_NO_SPACE);
-create_error:
-	_debug("create error %d", ret);
-	if (ret == -EIO)
-		cachefiles_io_error(cache, "Create/mkdir failed");
-	goto error;
-
-check_error_unlock:
-	inode_unlock(d_inode(dir));
-	dput(dir);
 check_error:
-	if (marked)
-		cachefiles_unmark_inode_in_use(object, object->dentry);
+	if (ret == -ESTALE) {
+		dput(object->dentry);
+		object->dentry = NULL;
+		fscache_object_retrying_stale(&object->fscache);
+		goto lookup_again;
+	}
+	if (ret == -EIO)
+		cachefiles_io_error_obj(object, "Lookup failed");
 	cachefiles_mark_object_inactive(cache, object);
 	dput(object->dentry);
 	object->dentry = NULL;
-	goto error_out;
-
-lookup_error:
-	_debug("lookup error %d", ret);
-	if (ret == -EIO)
-		cachefiles_io_error(cache, "Lookup failed");
-	next = NULL;
-error:
-	inode_unlock(d_inode(dir));
-	dput(next);
-error_out2:
-	dput(dir);
-error_out:
-	_leave(" = error %d", -ret);
+	_leave(" = error %d", ret);
 	return ret;
 }
 
@@ -530,7 +488,8 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
  */
 struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 					struct dentry *dir,
-					const char *dirname)
+					const char *dirname,
+					struct cachefiles_object *object)
 {
 	struct dentry *subdir;
 	struct path path;
@@ -554,6 +513,12 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 
 	/* we need to create the subdir if it doesn't exist yet */
 	if (d_is_negative(subdir)) {
+		/* This element of the path doesn't exist, so we can release
+		 * any readers in the certain knowledge that there's nothing
+		 * for them to actually read */
+		if (object)
+			fscache_object_lookup_negative(&object->fscache);
+
 		ret = cachefiles_has_space(cache, 1, 0);
 		if (ret < 0)
 			goto mkdir_error;
@@ -577,6 +542,8 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 
 		_debug("mkdir -> %pd{ino=%lu}",
 		       subdir, d_backing_inode(subdir)->i_ino);
+		if (object)
+			object->new = true;
 	}
 
 	inode_unlock(d_inode(dir));
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index 57d811718953..bd0b5bbd3889 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -119,28 +119,6 @@ TRACE_EVENT(cachefiles_lookup,
 		      __entry->obj, __entry->de, __entry->inode)
 	    );
 
-TRACE_EVENT(cachefiles_mkdir,
-	    TP_PROTO(struct cachefiles_object *obj,
-		     struct dentry *de, int ret),
-
-	    TP_ARGS(obj, de, ret),
-
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj	)
-		    __field(struct dentry *,		de	)
-		    __field(int,			ret	)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->obj	= obj->fscache.debug_id;
-		    __entry->de		= de;
-		    __entry->ret	= ret;
-			   ),
-
-	    TP_printk("o=%08x d=%p r=%u",
-		      __entry->obj, __entry->de, __entry->ret)
-	    );
-
 TRACE_EVENT(cachefiles_create,
 	    TP_PROTO(struct cachefiles_object *obj,
 		     struct dentry *de, int ret),


