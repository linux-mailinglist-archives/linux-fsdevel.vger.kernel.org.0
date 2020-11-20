Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4532BAD75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgKTPHr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:07:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48117 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728859AbgKTPHq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:07:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605884864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fxw9MqRSom4YR2c/UlEEk3hI5xryV7xCf3wIFtRO6yw=;
        b=VRewh3NHLeqCeMI9gYtJ4E+aUvyl4UXqYxSRTaaVqzS6VJBYL0yK2VtOWMa+JRelMsckS6
        HdpitFgnmQ/AHRQgG1qrbe8O4OVXfgk96893oUay9PuPlILmOdf8KLGbQe0GPhszMoXLBL
        ttsUiizt8qnz46wr311shsXOkzaCz7c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-qLRuzJ0yMJ2CQ_xiFPUG_w-1; Fri, 20 Nov 2020 10:07:39 -0500
X-MC-Unique: qLRuzJ0yMJ2CQ_xiFPUG_w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E834B1005D5F;
        Fri, 20 Nov 2020 15:07:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B52A60C17;
        Fri, 20 Nov 2020 15:07:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 23/76] cachefiles: Remove tree of active files and use
 S_CACHE_FILE inode flag
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
Date:   Fri, 20 Nov 2020 15:07:30 +0000
Message-ID: <160588485057.3465195.2344469072172194193.stgit@warthog.procyon.org.uk>
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

Remove the tree of active dentries from the cachefiles_cache struct and
instead set a flag, S_CACHE_FILE, on the backing inode to indicate that
this file is in use by the kernel so as to ward off other kernel users.

This simplifies the code a lot and also prevents two overlain caches from
fighting with each other.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/daemon.c            |    4 
 fs/cachefiles/interface.c         |   20 --
 fs/cachefiles/internal.h          |   10 -
 fs/cachefiles/namei.c             |  375 +++++++------------------------------
 include/trace/events/cachefiles.h |   29 ---
 5 files changed, 78 insertions(+), 360 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 752c1e43416f..8a937d6d5e22 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -102,8 +102,6 @@ static int cachefiles_daemon_open(struct inode *inode, struct file *file)
 	}
 
 	mutex_init(&cache->daemon_mutex);
-	cache->active_nodes = RB_ROOT;
-	rwlock_init(&cache->active_lock);
 	init_waitqueue_head(&cache->daemon_pollwq);
 
 	/* set default caching limits
@@ -138,8 +136,6 @@ static int cachefiles_daemon_release(struct inode *inode, struct file *file)
 
 	cachefiles_daemon_unbind(cache);
 
-	ASSERT(!cache->active_nodes.rb_node);
-
 	/* clean up the control file interface */
 	cache->cachefilesd = NULL;
 	file->private_data = NULL;
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 7e10793352fd..dc2cfbed4250 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -36,7 +36,6 @@ static struct fscache_object *cachefiles_alloc_object(
 
 	ASSERTCMP(object->backer, ==, NULL);
 
-	BUG_ON(test_bit(CACHEFILES_OBJECT_ACTIVE, &object->flags));
 	atomic_set(&object->usage, 1);
 
 	fscache_object_init(&object->fscache, cookie, &cache->cache);
@@ -74,7 +73,6 @@ static struct fscache_object *cachefiles_alloc_object(
 nomem_key:
 	kfree(buffer);
 nomem_buffer:
-	BUG_ON(test_bit(CACHEFILES_OBJECT_ACTIVE, &object->flags));
 	kmem_cache_free(cachefiles_object_jar, object);
 	fscache_object_destroyed(&cache->cache);
 nomem_object:
@@ -190,8 +188,6 @@ static void cachefiles_drop_object(struct fscache_object *_object)
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
 	const struct cred *saved_cred;
-	struct inode *inode;
-	blkcnt_t i_blocks = 0;
 
 	ASSERT(_object);
 
@@ -218,10 +214,6 @@ static void cachefiles_drop_object(struct fscache_object *_object)
 		    _object != cache->cache.fsdef
 		    ) {
 			_debug("- retire object OBJ%x", object->fscache.debug_id);
-			inode = d_backing_inode(object->dentry);
-			if (inode)
-				i_blocks = inode->i_blocks;
-
 			cachefiles_begin_secure(cache, &saved_cred);
 			cachefiles_delete_object(cache, object);
 			cachefiles_end_secure(cache, saved_cred);
@@ -231,14 +223,11 @@ static void cachefiles_drop_object(struct fscache_object *_object)
 		if (object->backer != object->dentry)
 			dput(object->backer);
 		object->backer = NULL;
-	}
 
-	/* note that the object is now inactive */
-	if (test_bit(CACHEFILES_OBJECT_ACTIVE, &object->flags))
-		cachefiles_mark_object_inactive(cache, object, i_blocks);
-
-	dput(object->dentry);
-	object->dentry = NULL;
+		cachefiles_unmark_inode_in_use(object, object->dentry);
+		dput(object->dentry);
+		object->dentry = NULL;
+	}
 
 	_leave("");
 }
@@ -274,7 +263,6 @@ static void cachefiles_put_object(struct fscache_object *_object,
 	if (u == 0) {
 		_debug("- kill object OBJ%x", object->fscache.debug_id);
 
-		ASSERT(!test_bit(CACHEFILES_OBJECT_ACTIVE, &object->flags));
 		ASSERTCMP(object->fscache.parent, ==, NULL);
 		ASSERTCMP(object->backer, ==, NULL);
 		ASSERTCMP(object->dentry, ==, NULL);
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index a5d48f271ce1..f8f308ce7385 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -38,12 +38,9 @@ struct cachefiles_object {
 	struct dentry			*dentry;	/* the file/dir representing this object */
 	struct dentry			*backer;	/* backing file */
 	loff_t				i_size;		/* object size */
-	unsigned long			flags;
-#define CACHEFILES_OBJECT_ACTIVE	0		/* T if marked active */
 	atomic_t			usage;		/* object usage count */
 	uint8_t				type;		/* object type */
 	uint8_t				new;		/* T if object new */
-	struct rb_node			active_node;	/* link in active tree (dentry is key) */
 };
 
 extern struct kmem_cache *cachefiles_object_jar;
@@ -59,8 +56,6 @@ struct cachefiles_cache {
 	const struct cred		*cache_cred;	/* security override for accessing cache */
 	struct mutex			daemon_mutex;	/* command serialisation mutex */
 	wait_queue_head_t		daemon_pollwq;	/* poll waitqueue for daemon */
-	struct rb_root			active_nodes;	/* active nodes (can't be culled) */
-	rwlock_t			active_lock;	/* lock for active_nodes */
 	atomic_t			gravecounter;	/* graveyard uniquifier */
 	atomic_t			f_released;	/* number of objects released lately */
 	atomic_long_t			b_released;	/* number of blocks released lately */
@@ -126,9 +121,8 @@ extern char *cachefiles_cook_key(const u8 *raw, int keylen, uint8_t type);
 /*
  * namei.c
  */
-extern void cachefiles_mark_object_inactive(struct cachefiles_cache *cache,
-					    struct cachefiles_object *object,
-					    blkcnt_t i_blocks);
+extern void cachefiles_unmark_inode_in_use(struct cachefiles_object *object,
+				    struct dentry *dentry);
 extern int cachefiles_delete_object(struct cachefiles_cache *cache,
 				    struct cachefiles_object *object);
 extern int cachefiles_walk_to_object(struct cachefiles_object *parent,
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 2f37451691b0..1fb011474765 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -21,251 +21,51 @@
 #define CACHEFILES_KEYBUF_SIZE 512
 
 /*
- * dump debugging info about an object
+ * Mark the backing file as being a cache file if it's not already in use so.
  */
-static noinline
-void __cachefiles_printk_object(struct cachefiles_object *object,
-				const char *prefix)
+static bool cachefiles_mark_inode_in_use(struct cachefiles_object *object,
+					 struct dentry *dentry)
 {
-	struct fscache_cookie *cookie;
-	const u8 *k;
-	unsigned loop;
-
-	pr_err("%sobject: OBJ%x\n", prefix, object->fscache.debug_id);
-	pr_err("%sobjstate=%s fl=%lx wbusy=%x ev=%lx[%lx]\n",
-	       prefix, object->fscache.state->name,
-	       object->fscache.flags, work_busy(&object->fscache.work),
-	       object->fscache.events, object->fscache.event_mask);
-	pr_err("%sops=%u\n",
-	       prefix, object->fscache.n_ops);
-	pr_err("%sparent=%x\n",
-	       prefix, object->fscache.parent ? object->fscache.parent->debug_id : 0);
-
-	spin_lock(&object->fscache.lock);
-	cookie = object->fscache.cookie;
-	if (cookie) {
-		pr_err("%scookie=%x [pr=%x fl=%lx]\n",
-		       prefix,
-		       cookie->debug_id,
-		       cookie->parent ? cookie->parent->debug_id : 0,
-		       cookie->flags);
-		pr_err("%skey=[%u] '", prefix, cookie->key_len);
-		k = (cookie->key_len <= sizeof(cookie->inline_key)) ?
-			cookie->inline_key : cookie->key;
-		for (loop = 0; loop < cookie->key_len; loop++)
-			pr_cont("%02x", k[loop]);
-		pr_cont("'\n");
-	} else {
-		pr_err("%scookie=NULL\n", prefix);
-	}
-	spin_unlock(&object->fscache.lock);
-}
-
-/*
- * dump debugging info about a pair of objects
- */
-static noinline void cachefiles_printk_object(struct cachefiles_object *object,
-					      struct cachefiles_object *xobject)
-{
-	if (object)
-		__cachefiles_printk_object(object, "");
-	if (xobject)
-		__cachefiles_printk_object(xobject, "x");
-}
-
-/*
- * mark the owner of a dentry, if there is one, to indicate that that dentry
- * has been preemptively deleted
- * - the caller must hold the i_mutex on the dentry's parent as required to
- *   call vfs_unlink(), vfs_rmdir() or vfs_rename()
- */
-static void cachefiles_mark_object_buried(struct cachefiles_cache *cache,
-					  struct dentry *dentry,
-					  enum fscache_why_object_killed why)
-{
-	struct cachefiles_object *object;
-	struct rb_node *p;
-
-	_enter(",'%pd'", dentry);
-
-	write_lock(&cache->active_lock);
-
-	p = cache->active_nodes.rb_node;
-	while (p) {
-		object = rb_entry(p, struct cachefiles_object, active_node);
-		if (object->dentry > dentry)
-			p = p->rb_left;
-		else if (object->dentry < dentry)
-			p = p->rb_right;
-		else
-			goto found_dentry;
-	}
-
-	write_unlock(&cache->active_lock);
-	trace_cachefiles_mark_buried(NULL, dentry, why);
-	_leave(" [no owner]");
-	return;
+	struct inode *inode = d_backing_inode(dentry);
+	bool can_use = false;
 
-	/* found the dentry for  */
-found_dentry:
-	kdebug("preemptive burial: OBJ%x [%s] %pd",
-	       object->fscache.debug_id,
-	       object->fscache.state->name,
-	       dentry);
+	_enter(",%x", object->fscache.debug_id);
 
-	trace_cachefiles_mark_buried(object, dentry, why);
+	inode_lock(inode);
 
-	if (fscache_object_is_live(&object->fscache)) {
-		pr_err("\n");
-		pr_err("Error: Can't preemptively bury live object\n");
-		cachefiles_printk_object(object, NULL);
+	if (!(inode->i_flags & S_CACHE_FILE)) {
+		inode->i_flags |= S_CACHE_FILE;
+		trace_cachefiles_mark_active(object, dentry);
+		can_use = true;
 	} else {
-		if (why != FSCACHE_OBJECT_IS_STALE)
-			fscache_object_mark_killed(&object->fscache, why);
+		pr_notice("cachefiles: Inode already in use: %pd\n", dentry);
 	}
 
-	write_unlock(&cache->active_lock);
-	_leave(" [owner marked]");
+	inode_unlock(inode);
+	return can_use;
 }
 
 /*
- * record the fact that an object is now active
+ * Unmark a backing inode.
  */
-static int cachefiles_mark_object_active(struct cachefiles_cache *cache,
-					 struct cachefiles_object *object)
+void cachefiles_unmark_inode_in_use(struct cachefiles_object *object,
+				    struct dentry *dentry)
 {
-	struct cachefiles_object *xobject;
-	struct rb_node **_p, *_parent = NULL;
-	struct dentry *dentry;
-
-	_enter(",%x", object->fscache.debug_id);
-
-try_again:
-	write_lock(&cache->active_lock);
-
-	dentry = object->dentry;
-	trace_cachefiles_mark_active(object, dentry);
-
-	if (test_and_set_bit(CACHEFILES_OBJECT_ACTIVE, &object->flags)) {
-		pr_err("Error: Object already active\n");
-		cachefiles_printk_object(object, NULL);
-		BUG();
-	}
-
-	_p = &cache->active_nodes.rb_node;
-	while (*_p) {
-		_parent = *_p;
-		xobject = rb_entry(_parent,
-				   struct cachefiles_object, active_node);
-
-		ASSERT(xobject != object);
-
-		if (xobject->dentry > dentry)
-			_p = &(*_p)->rb_left;
-		else if (xobject->dentry < dentry)
-			_p = &(*_p)->rb_right;
-		else
-			goto wait_for_old_object;
-	}
-
-	rb_link_node(&object->active_node, _parent, _p);
-	rb_insert_color(&object->active_node, &cache->active_nodes);
-
-	write_unlock(&cache->active_lock);
-	_leave(" = 0");
-	return 0;
-
-	/* an old object from a previous incarnation is hogging the slot - we
-	 * need to wait for it to be destroyed */
-wait_for_old_object:
-	trace_cachefiles_wait_active(object, dentry, xobject);
-	clear_bit(CACHEFILES_OBJECT_ACTIVE, &object->flags);
-
-	if (fscache_object_is_live(&xobject->fscache)) {
-		pr_err("\n");
-		pr_err("Error: Unexpected object collision\n");
-		cachefiles_printk_object(object, xobject);
-	}
-	atomic_inc(&xobject->usage);
-	write_unlock(&cache->active_lock);
-
-	if (test_bit(CACHEFILES_OBJECT_ACTIVE, &xobject->flags)) {
-		wait_queue_head_t *wq;
-
-		signed long timeout = 60 * HZ;
-		wait_queue_entry_t wait;
-		bool requeue;
-
-		/* if the object we're waiting for is queued for processing,
-		 * then just put ourselves on the queue behind it */
-		if (work_pending(&xobject->fscache.work)) {
-			_debug("queue OBJ%x behind OBJ%x immediately",
-			       object->fscache.debug_id,
-			       xobject->fscache.debug_id);
-			goto requeue;
-		}
-
-		/* otherwise we sleep until either the object we're waiting for
-		 * is done, or the fscache_object is congested */
-		wq = bit_waitqueue(&xobject->flags, CACHEFILES_OBJECT_ACTIVE);
-		init_wait(&wait);
-		requeue = false;
-		do {
-			prepare_to_wait(wq, &wait, TASK_UNINTERRUPTIBLE);
-			if (!test_bit(CACHEFILES_OBJECT_ACTIVE, &xobject->flags))
-				break;
-
-			requeue = fscache_object_sleep_till_congested(&timeout);
-		} while (timeout > 0 && !requeue);
-		finish_wait(wq, &wait);
-
-		if (requeue &&
-		    test_bit(CACHEFILES_OBJECT_ACTIVE, &xobject->flags)) {
-			_debug("queue OBJ%x behind OBJ%x after wait",
-			       object->fscache.debug_id,
-			       xobject->fscache.debug_id);
-			goto requeue;
-		}
-
-		if (timeout <= 0) {
-			pr_err("\n");
-			pr_err("Error: Overlong wait for old active object to go away\n");
-			cachefiles_printk_object(object, xobject);
-			goto requeue;
-		}
-	}
-
-	ASSERT(!test_bit(CACHEFILES_OBJECT_ACTIVE, &xobject->flags));
-
-	cache->cache.ops->put_object(&xobject->fscache,
-		(enum fscache_obj_ref_trace)cachefiles_obj_put_wait_retry);
-	goto try_again;
+	struct inode *inode = d_backing_inode(dentry);
 
-requeue:
-	cache->cache.ops->put_object(&xobject->fscache,
-		(enum fscache_obj_ref_trace)cachefiles_obj_put_wait_timeo);
-	_leave(" = -ETIMEDOUT");
-	return -ETIMEDOUT;
+	inode_lock(inode);
+	inode->i_flags &= ~S_CACHE_FILE;
+	inode_unlock(inode);
+	trace_cachefiles_mark_inactive(object, dentry, inode);
 }
 
 /*
  * Mark an object as being inactive.
  */
-void cachefiles_mark_object_inactive(struct cachefiles_cache *cache,
-				     struct cachefiles_object *object,
-				     blkcnt_t i_blocks)
+static void cachefiles_mark_object_inactive(struct cachefiles_cache *cache,
+					    struct cachefiles_object *object)
 {
-	struct dentry *dentry = object->dentry;
-	struct inode *inode = d_backing_inode(dentry);
-
-	trace_cachefiles_mark_inactive(object, dentry, inode);
-
-	write_lock(&cache->active_lock);
-	rb_erase(&object->active_node, &cache->active_nodes);
-	clear_bit(CACHEFILES_OBJECT_ACTIVE, &object->flags);
-	write_unlock(&cache->active_lock);
-
-	wake_up_bit(&object->flags, CACHEFILES_OBJECT_ACTIVE);
+	blkcnt_t i_blocks = d_backing_inode(object->dentry)->i_blocks;
 
 	/* This object can now be culled, so we need to let the daemon know
 	 * that there is something it can remove if it needs to.
@@ -286,7 +86,6 @@ static int cachefiles_bury_object(struct cachefiles_cache *cache,
 				  struct cachefiles_object *object,
 				  struct dentry *dir,
 				  struct dentry *rep,
-				  bool preemptive,
 				  enum fscache_why_object_killed why)
 {
 	struct dentry *grave, *trap;
@@ -308,9 +107,6 @@ static int cachefiles_bury_object(struct cachefiles_cache *cache,
 		} else {
 			trace_cachefiles_unlink(object, rep, why);
 			ret = vfs_unlink(d_inode(dir), rep, NULL);
-
-			if (preemptive)
-				cachefiles_mark_object_buried(cache, rep, why);
 		}
 
 		inode_unlock(d_inode(dir));
@@ -371,8 +167,7 @@ static int cachefiles_bury_object(struct cachefiles_cache *cache,
 			return -ENOMEM;
 		}
 
-		cachefiles_io_error(cache, "Lookup error %ld",
-				    PTR_ERR(grave));
+		cachefiles_io_error(cache, "Lookup error %ld", PTR_ERR(grave));
 		return -EIO;
 	}
 
@@ -414,9 +209,6 @@ static int cachefiles_bury_object(struct cachefiles_cache *cache,
 		if (ret != 0 && ret != -ENOMEM)
 			cachefiles_io_error(cache,
 					    "Rename failed with error %d", ret);
-
-		if (preemptive)
-			cachefiles_mark_object_buried(cache, rep, why);
 	}
 
 	unlock_rename(cache->graveyard, dir);
@@ -444,26 +236,18 @@ int cachefiles_delete_object(struct cachefiles_cache *cache,
 
 	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
 
-	if (test_bit(FSCACHE_OBJECT_KILLED_BY_CACHE, &object->fscache.flags)) {
-		/* object allocation for the same key preemptively deleted this
-		 * object's file so that it could create its own file */
-		_debug("object preemptively buried");
+	/* We need to check that our parent is _still_ our parent - it may have
+	 * been renamed.
+	 */
+	if (dir == object->dentry->d_parent) {
+		ret = cachefiles_bury_object(cache, object, dir, object->dentry,
+					     FSCACHE_OBJECT_WAS_RETIRED);
+	} else {
+		/* It got moved, presumably by cachefilesd culling it, so it's
+		 * no longer in the key path and we can ignore it.
+		 */
 		inode_unlock(d_inode(dir));
 		ret = 0;
-	} else {
-		/* we need to check that our parent is _still_ our parent - it
-		 * may have been renamed */
-		if (dir == object->dentry->d_parent) {
-			ret = cachefiles_bury_object(cache, object, dir,
-						     object->dentry, false,
-						     FSCACHE_OBJECT_WAS_RETIRED);
-		} else {
-			/* it got moved, presumably by cachefilesd culling it,
-			 * so it's no longer in the key path and we can ignore
-			 * it */
-			inode_unlock(d_inode(dir));
-			ret = 0;
-		}
 	}
 
 	dput(dir);
@@ -485,6 +269,7 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
 	struct path path;
 	unsigned long start;
 	const char *name;
+	bool marked = false;
 	int ret, nlen;
 
 	_enter("OBJ%x{%pd},OBJ%x,%s,",
@@ -527,6 +312,7 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
 	cachefiles_hist(cachefiles_lookup_histogram, start);
 	if (IS_ERR(next)) {
 		trace_cachefiles_lookup(object, next, NULL);
+		ret = PTR_ERR(next);
 		goto lookup_error;
 	}
 
@@ -626,6 +412,13 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
 	/* we've found the object we were looking for */
 	object->dentry = next;
 
+	/* note that we're now using this object */
+	if (!cachefiles_mark_inode_in_use(object, object->dentry)) {
+		ret = -EBUSY;
+		goto check_error_unlock;
+	}
+	marked = true;
+
 	/* if we've found that the terminal object exists, then we need to
 	 * check its attributes and delete it if it's out of date */
 	if (!object->new) {
@@ -638,13 +431,12 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
 			object->dentry = NULL;
 
 			ret = cachefiles_bury_object(cache, object, dir, next,
-						     true,
 						     FSCACHE_OBJECT_IS_STALE);
 			dput(next);
 			next = NULL;
 
 			if (ret < 0)
-				goto delete_error;
+				goto error_out2;
 
 			_debug("redo lookup");
 			fscache_object_retrying_stale(&object->fscache);
@@ -652,16 +444,10 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
 		}
 	}
 
-	/* note that we're now using this object */
-	ret = cachefiles_mark_object_active(cache, object);
-
 	inode_unlock(d_inode(dir));
 	dput(dir);
 	dir = NULL;
 
-	if (ret == -ETIMEDOUT)
-		goto mark_active_timed_out;
-
 	_debug("=== OBTAINED_OBJECT ===");
 
 	if (object->new) {
@@ -710,26 +496,19 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
 		cachefiles_io_error(cache, "Create/mkdir failed");
 	goto error;
 
-mark_active_timed_out:
-	_debug("mark active timed out");
-	goto release_dentry;
-
+check_error_unlock:
+	inode_unlock(d_inode(dir));
+	dput(dir);
 check_error:
-	_debug("check error %d", ret);
-	cachefiles_mark_object_inactive(
-		cache, object, d_backing_inode(object->dentry)->i_blocks);
-release_dentry:
+	if (marked)
+		cachefiles_unmark_inode_in_use(object, object->dentry);
+	cachefiles_mark_object_inactive(cache, object);
 	dput(object->dentry);
 	object->dentry = NULL;
 	goto error_out;
 
-delete_error:
-	_debug("delete error %d", ret);
-	goto error_out2;
-
 lookup_error:
-	_debug("lookup error %ld", PTR_ERR(next));
-	ret = PTR_ERR(next);
+	_debug("lookup error %d", ret);
 	if (ret == -EIO)
 		cachefiles_io_error(cache, "Lookup failed");
 	next = NULL;
@@ -857,8 +636,6 @@ static struct dentry *cachefiles_check_active(struct cachefiles_cache *cache,
 					      struct dentry *dir,
 					      char *filename)
 {
-	struct cachefiles_object *object;
-	struct rb_node *_n;
 	struct dentry *victim;
 	unsigned long start;
 	int ret;
@@ -888,34 +665,9 @@ static struct dentry *cachefiles_check_active(struct cachefiles_cache *cache,
 		return ERR_PTR(-ENOENT);
 	}
 
-	/* check to see if we're using this object */
-	read_lock(&cache->active_lock);
-
-	_n = cache->active_nodes.rb_node;
-
-	while (_n) {
-		object = rb_entry(_n, struct cachefiles_object, active_node);
-
-		if (object->dentry > victim)
-			_n = _n->rb_left;
-		else if (object->dentry < victim)
-			_n = _n->rb_right;
-		else
-			goto object_in_use;
-	}
-
-	read_unlock(&cache->active_lock);
-
 	//_leave(" = %pd", victim);
 	return victim;
 
-object_in_use:
-	read_unlock(&cache->active_lock);
-	inode_unlock(d_inode(dir));
-	dput(victim);
-	//_leave(" = -EBUSY [in use]");
-	return ERR_PTR(-EBUSY);
-
 lookup_error:
 	inode_unlock(d_inode(dir));
 	ret = PTR_ERR(victim);
@@ -944,6 +696,7 @@ int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
 		    char *filename)
 {
 	struct dentry *victim;
+	struct inode *inode;
 	int ret;
 
 	_enter(",%pd/,%s", dir, filename);
@@ -952,6 +705,19 @@ int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
 	if (IS_ERR(victim))
 		return PTR_ERR(victim);
 
+	/* check to see if someone is using this object */
+	inode = d_inode(victim);
+	inode_lock(inode);
+	if (inode->i_flags & S_CACHE_FILE) {
+		ret = -EBUSY;
+	} else {
+		inode->i_flags |= S_CACHE_FILE;
+		ret = 0;
+	}
+	inode_unlock(inode);
+	if (ret < 0)
+		goto error_unlock;
+
 	_debug("victim -> %pd %s",
 	       victim, d_backing_inode(victim) ? "positive" : "negative");
 
@@ -967,7 +733,7 @@ int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
 	/*  actually remove the victim (drops the dir mutex) */
 	_debug("bury");
 
-	ret = cachefiles_bury_object(cache, NULL, dir, victim, false,
+	ret = cachefiles_bury_object(cache, NULL, dir, victim,
 				     FSCACHE_OBJECT_WAS_CULLED);
 	if (ret < 0)
 		goto error;
@@ -1004,6 +770,7 @@ int cachefiles_check_in_use(struct cachefiles_cache *cache, struct dentry *dir,
 			    char *filename)
 {
 	struct dentry *victim;
+	int ret = 0;
 
 	//_enter(",%pd/,%s",
 	//       dir, filename);
@@ -1013,7 +780,9 @@ int cachefiles_check_in_use(struct cachefiles_cache *cache, struct dentry *dir,
 		return PTR_ERR(victim);
 
 	inode_unlock(d_inode(dir));
+	if (d_inode(victim)->i_flags & S_CACHE_FILE)
+		ret = -EBUSY;
 	dput(victim);
 	//_leave(" = 0");
-	return 0;
+	return ret;
 }
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index 9a448fe9355d..c877035c2946 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -237,35 +237,6 @@ TRACE_EVENT(cachefiles_mark_active,
 		      __entry->obj, __entry->de)
 	    );
 
-TRACE_EVENT(cachefiles_wait_active,
-	    TP_PROTO(struct cachefiles_object *obj,
-		     struct dentry *de,
-		     struct cachefiles_object *xobj),
-
-	    TP_ARGS(obj, de, xobj),
-
-	    /* Note that obj may be NULL */
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj		)
-		    __field(unsigned int,		xobj		)
-		    __field(struct dentry *,		de		)
-		    __field(u16,			flags		)
-		    __field(u16,			fsc_flags	)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->obj	= obj->fscache.debug_id;
-		    __entry->de		= de;
-		    __entry->xobj	= xobj->fscache.debug_id;
-		    __entry->flags	= xobj->flags;
-		    __entry->fsc_flags	= xobj->fscache.flags;
-			   ),
-
-	    TP_printk("o=%08x d=%p wo=%08x wf=%x wff=%x",
-		      __entry->obj, __entry->de, __entry->xobj,
-		      __entry->flags, __entry->fsc_flags)
-	    );
-
 TRACE_EVENT(cachefiles_mark_inactive,
 	    TP_PROTO(struct cachefiles_object *obj,
 		     struct dentry *de,


