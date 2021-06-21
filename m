Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079303AF7D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 23:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbhFUVsw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 17:48:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52522 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232101AbhFUVsr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 17:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624311992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VTOLOobucEswi3fCJQ7qjMh+WGxNa1Sji2oxaslCuLU=;
        b=HZhVJ30TpjipIzLgS7qYrheTPrW+jjSljKb2C5UPklXqgsMrl0n552oBPTtlI/9k2whahL
        gzN/3N4wmK/nqvZyWyTmnrzoBPAbDJmc5hU2OhdunHdqZHSr45dUyKGPBGL0wY7/UmNxuY
        JraqMllhG6+We4AUcfHjz6rL79juY6M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-2zDFsDF7PgW9B0VT9PKUCQ-1; Mon, 21 Jun 2021 17:46:31 -0400
X-MC-Unique: 2zDFsDF7PgW9B0VT9PKUCQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D74C919611A2;
        Mon, 21 Jun 2021 21:46:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 206645F714;
        Mon, 21 Jun 2021 21:46:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 07/12] fscache: Remove the object list procfile
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 21 Jun 2021 22:46:23 +0100
Message-ID: <162431198332.2908479.5847286163455099669.stgit@warthog.procyon.org.uk>
In-Reply-To: <162431188431.2908479.14031376932042135080.stgit@warthog.procyon.org.uk>
References: <162431188431.2908479.14031376932042135080.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the object list procfile from fscache as objects will become
entirely internal to the cache.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fscache/Kconfig            |    7 -
 fs/fscache/Makefile           |    1 
 fs/fscache/cache.c            |    1 
 fs/fscache/cookie.c           |    2 
 fs/fscache/internal.h         |   13 -
 fs/fscache/object-list.c      |  414 -----------------------------------------
 fs/fscache/object.c           |    2 
 include/linux/fscache-cache.h |    3 
 8 files changed, 443 deletions(-)
 delete mode 100644 fs/fscache/object-list.c

diff --git a/fs/fscache/Kconfig b/fs/fscache/Kconfig
index 5e3a5b3f950d..b313a978ae0a 100644
--- a/fs/fscache/Kconfig
+++ b/fs/fscache/Kconfig
@@ -38,10 +38,3 @@ config FSCACHE_DEBUG
 	  enabled by setting bits in /sys/modules/fscache/parameter/debug.
 
 	  See Documentation/filesystems/caching/fscache.rst for more information.
-
-config FSCACHE_OBJECT_LIST
-	bool "Maintain global object list for debugging purposes"
-	depends on FSCACHE && PROC_FS
-	help
-	  Maintain a global list of active fscache objects that can be
-	  retrieved through /proc/fs/fscache/objects for debugging purposes
diff --git a/fs/fscache/Makefile b/fs/fscache/Makefile
index 45d5235a449b..03a871d689bb 100644
--- a/fs/fscache/Makefile
+++ b/fs/fscache/Makefile
@@ -16,6 +16,5 @@ fscache-y := \
 
 fscache-$(CONFIG_PROC_FS) += proc.o
 fscache-$(CONFIG_FSCACHE_STATS) += stats.o
-fscache-$(CONFIG_FSCACHE_OBJECT_LIST) += object-list.o
 
 obj-$(CONFIG_FSCACHE) := fscache.o
diff --git a/fs/fscache/cache.c b/fs/fscache/cache.c
index fcc136361415..8a6ffcac867f 100644
--- a/fs/fscache/cache.c
+++ b/fs/fscache/cache.c
@@ -261,7 +261,6 @@ int fscache_add_cache(struct fscache_cache *cache,
 	spin_lock(&cache->object_list_lock);
 	list_add_tail(&ifsdef->cache_link, &cache->object_list);
 	spin_unlock(&cache->object_list_lock);
-	fscache_objlist_add(ifsdef);
 
 	/* add the cache's netfs definition index object to the top level index
 	 * cookie as a known backing object */
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index c7047544972b..2f4d5271ad2e 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -620,8 +620,6 @@ static int fscache_attach_object(struct fscache_cookie *cookie,
 
 	/* Attach to the cookie.  The object already has a ref on it. */
 	hlist_add_head(&object->cookie_link, &cookie->backing_objects);
-
-	fscache_objlist_add(object);
 	ret = 0;
 
 cant_attach_object:
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index 796678b2b32a..200082cafdda 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -84,19 +84,6 @@ static inline bool fscache_object_congested(void)
  */
 extern void fscache_enqueue_object(struct fscache_object *);
 
-/*
- * object-list.c
- */
-#ifdef CONFIG_FSCACHE_OBJECT_LIST
-extern const struct proc_ops fscache_objlist_proc_ops;
-
-extern void fscache_objlist_add(struct fscache_object *);
-extern void fscache_objlist_remove(struct fscache_object *);
-#else
-#define fscache_objlist_add(object) do {} while(0)
-#define fscache_objlist_remove(object) do {} while(0)
-#endif
-
 /*
  * operation.c
  */
diff --git a/fs/fscache/object-list.c b/fs/fscache/object-list.c
deleted file mode 100644
index 1a0dc32c0a33..000000000000
--- a/fs/fscache/object-list.c
+++ /dev/null
@@ -1,414 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* Global fscache object list maintainer and viewer
- *
- * Copyright (C) 2009 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#define FSCACHE_DEBUG_LEVEL COOKIE
-#include <linux/module.h>
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
-#include <linux/slab.h>
-#include <linux/key.h>
-#include <keys/user-type.h>
-#include "internal.h"
-
-static struct rb_root fscache_object_list;
-static DEFINE_RWLOCK(fscache_object_list_lock);
-
-struct fscache_objlist_data {
-	unsigned long	config;		/* display configuration */
-#define FSCACHE_OBJLIST_CONFIG_KEY	0x00000001	/* show object keys */
-#define FSCACHE_OBJLIST_CONFIG_AUX	0x00000002	/* show object auxdata */
-#define FSCACHE_OBJLIST_CONFIG_COOKIE	0x00000004	/* show objects with cookies */
-#define FSCACHE_OBJLIST_CONFIG_NOCOOKIE	0x00000008	/* show objects without cookies */
-#define FSCACHE_OBJLIST_CONFIG_BUSY	0x00000010	/* show busy objects */
-#define FSCACHE_OBJLIST_CONFIG_IDLE	0x00000020	/* show idle objects */
-#define FSCACHE_OBJLIST_CONFIG_PENDWR	0x00000040	/* show objects with pending writes */
-#define FSCACHE_OBJLIST_CONFIG_NOPENDWR	0x00000080	/* show objects without pending writes */
-#define FSCACHE_OBJLIST_CONFIG_READS	0x00000100	/* show objects with active reads */
-#define FSCACHE_OBJLIST_CONFIG_NOREADS	0x00000200	/* show objects without active reads */
-#define FSCACHE_OBJLIST_CONFIG_EVENTS	0x00000400	/* show objects with events */
-#define FSCACHE_OBJLIST_CONFIG_NOEVENTS	0x00000800	/* show objects without no events */
-#define FSCACHE_OBJLIST_CONFIG_WORK	0x00001000	/* show objects with work */
-#define FSCACHE_OBJLIST_CONFIG_NOWORK	0x00002000	/* show objects without work */
-};
-
-/*
- * Add an object to the object list
- * - we use the address of the fscache_object structure as the key into the
- *   tree
- */
-void fscache_objlist_add(struct fscache_object *obj)
-{
-	struct fscache_object *xobj;
-	struct rb_node **p = &fscache_object_list.rb_node, *parent = NULL;
-
-	ASSERT(RB_EMPTY_NODE(&obj->objlist_link));
-
-	write_lock(&fscache_object_list_lock);
-
-	while (*p) {
-		parent = *p;
-		xobj = rb_entry(parent, struct fscache_object, objlist_link);
-
-		if (obj < xobj)
-			p = &(*p)->rb_left;
-		else if (obj > xobj)
-			p = &(*p)->rb_right;
-		else
-			BUG();
-	}
-
-	rb_link_node(&obj->objlist_link, parent, p);
-	rb_insert_color(&obj->objlist_link, &fscache_object_list);
-
-	write_unlock(&fscache_object_list_lock);
-}
-
-/*
- * Remove an object from the object list.
- */
-void fscache_objlist_remove(struct fscache_object *obj)
-{
-	if (RB_EMPTY_NODE(&obj->objlist_link))
-		return;
-
-	write_lock(&fscache_object_list_lock);
-
-	BUG_ON(RB_EMPTY_ROOT(&fscache_object_list));
-	rb_erase(&obj->objlist_link, &fscache_object_list);
-
-	write_unlock(&fscache_object_list_lock);
-}
-
-/*
- * find the object in the tree on or after the specified index
- */
-static struct fscache_object *fscache_objlist_lookup(loff_t *_pos)
-{
-	struct fscache_object *pobj, *obj = NULL, *minobj = NULL;
-	struct rb_node *p;
-	unsigned long pos;
-
-	if (*_pos >= (unsigned long) ERR_PTR(-ENOENT))
-		return NULL;
-	pos = *_pos;
-
-	/* banners (can't represent line 0 by pos 0 as that would involve
-	 * returning a NULL pointer) */
-	if (pos == 0)
-		return (struct fscache_object *)(long)++(*_pos);
-	if (pos < 3)
-		return (struct fscache_object *)pos;
-
-	pobj = (struct fscache_object *)pos;
-	p = fscache_object_list.rb_node;
-	while (p) {
-		obj = rb_entry(p, struct fscache_object, objlist_link);
-		if (pobj < obj) {
-			if (!minobj || minobj > obj)
-				minobj = obj;
-			p = p->rb_left;
-		} else if (pobj > obj) {
-			p = p->rb_right;
-		} else {
-			minobj = obj;
-			break;
-		}
-		obj = NULL;
-	}
-
-	if (!minobj)
-		*_pos = (unsigned long) ERR_PTR(-ENOENT);
-	else if (minobj != obj)
-		*_pos = (unsigned long) minobj;
-	return minobj;
-}
-
-/*
- * set up the iterator to start reading from the first line
- */
-static void *fscache_objlist_start(struct seq_file *m, loff_t *_pos)
-	__acquires(&fscache_object_list_lock)
-{
-	read_lock(&fscache_object_list_lock);
-	return fscache_objlist_lookup(_pos);
-}
-
-/*
- * move to the next line
- */
-static void *fscache_objlist_next(struct seq_file *m, void *v, loff_t *_pos)
-{
-	(*_pos)++;
-	return fscache_objlist_lookup(_pos);
-}
-
-/*
- * clean up after reading
- */
-static void fscache_objlist_stop(struct seq_file *m, void *v)
-	__releases(&fscache_object_list_lock)
-{
-	read_unlock(&fscache_object_list_lock);
-}
-
-/*
- * display an object
- */
-static int fscache_objlist_show(struct seq_file *m, void *v)
-{
-	struct fscache_objlist_data *data = m->private;
-	struct fscache_object *obj = v;
-	struct fscache_cookie *cookie;
-	unsigned long config = data->config;
-	char _type[3], *type;
-	u8 *p;
-
-	if ((unsigned long) v == 1) {
-		seq_puts(m, "OBJECT   PARENT   STAT CHLDN OPS OOP IPR EX READS"
-			 " EM EV FL S"
-			 " | COOKIE   NETFS_COOKIE_DEF TY FL NETFS_DATA");
-		if (config & (FSCACHE_OBJLIST_CONFIG_KEY |
-			      FSCACHE_OBJLIST_CONFIG_AUX))
-			seq_puts(m, "       ");
-		if (config & FSCACHE_OBJLIST_CONFIG_KEY)
-			seq_puts(m, "OBJECT_KEY");
-		if ((config & (FSCACHE_OBJLIST_CONFIG_KEY |
-			       FSCACHE_OBJLIST_CONFIG_AUX)) ==
-		    (FSCACHE_OBJLIST_CONFIG_KEY | FSCACHE_OBJLIST_CONFIG_AUX))
-			seq_puts(m, ", ");
-		if (config & FSCACHE_OBJLIST_CONFIG_AUX)
-			seq_puts(m, "AUX_DATA");
-		seq_puts(m, "\n");
-		return 0;
-	}
-
-	if ((unsigned long) v == 2) {
-		seq_puts(m, "======== ======== ==== ===== === === === == ====="
-			 " == == == ="
-			 " | ======== ================ == === ================");
-		if (config & (FSCACHE_OBJLIST_CONFIG_KEY |
-			      FSCACHE_OBJLIST_CONFIG_AUX))
-			seq_puts(m, " ================");
-		seq_puts(m, "\n");
-		return 0;
-	}
-
-	/* filter out any unwanted objects */
-#define FILTER(criterion, _yes, _no)					\
-	do {								\
-		unsigned long yes = FSCACHE_OBJLIST_CONFIG_##_yes;	\
-		unsigned long no = FSCACHE_OBJLIST_CONFIG_##_no;	\
-		if (criterion) {					\
-			if (!(config & yes))				\
-				return 0;				\
-		} else {						\
-			if (!(config & no))				\
-				return 0;				\
-		}							\
-	} while(0)
-
-	cookie = obj->cookie;
-	if (~config) {
-		FILTER(cookie->def,
-		       COOKIE, NOCOOKIE);
-		FILTER(fscache_object_is_active(obj) ||
-		       obj->n_ops != 0 ||
-		       obj->n_obj_ops != 0 ||
-		       obj->flags ||
-		       !list_empty(&obj->dependents),
-		       BUSY, IDLE);
-		FILTER(test_bit(FSCACHE_OBJECT_PENDING_WRITE, &obj->flags),
-		       PENDWR, NOPENDWR);
-		FILTER(atomic_read(&obj->n_reads),
-		       READS, NOREADS);
-		FILTER(obj->events & obj->event_mask,
-		       EVENTS, NOEVENTS);
-		FILTER(work_busy(&obj->work), WORK, NOWORK);
-	}
-
-	seq_printf(m,
-		   "%08x %08x %s %5u %3u %3u %3u %2u %5u %2lx %2lx %2lx %1x | ",
-		   obj->debug_id,
-		   obj->parent ? obj->parent->debug_id : UINT_MAX,
-		   obj->state->short_name,
-		   obj->n_children,
-		   obj->n_ops,
-		   obj->n_obj_ops,
-		   obj->n_in_progress,
-		   obj->n_exclusive,
-		   atomic_read(&obj->n_reads),
-		   obj->event_mask,
-		   obj->events,
-		   obj->flags,
-		   work_busy(&obj->work));
-
-	if (obj->cookie) {
-		uint16_t keylen = 0, auxlen = 0;
-
-		switch (cookie->type) {
-		case 0:
-			type = "IX";
-			break;
-		case 1:
-			type = "DT";
-			break;
-		default:
-			snprintf(_type, sizeof(_type), "%02u",
-				 cookie->type);
-			type = _type;
-			break;
-		}
-
-		seq_printf(m, "%08x %-16s %s %3lx %16p",
-			   cookie->debug_id,
-			   cookie->def->name,
-			   type,
-			   cookie->flags,
-			   cookie->netfs_data);
-
-		if (config & FSCACHE_OBJLIST_CONFIG_KEY)
-			keylen = cookie->key_len;
-
-		if (config & FSCACHE_OBJLIST_CONFIG_AUX)
-			auxlen = cookie->aux_len;
-
-		if (keylen > 0 || auxlen > 0) {
-			seq_puts(m, " ");
-			p = keylen <= sizeof(cookie->inline_key) ?
-				cookie->inline_key : cookie->key;
-			for (; keylen > 0; keylen--)
-				seq_printf(m, "%02x", *p++);
-			if (auxlen > 0) {
-				if (config & FSCACHE_OBJLIST_CONFIG_KEY)
-					seq_puts(m, ", ");
-				p = auxlen <= sizeof(cookie->inline_aux) ?
-					cookie->inline_aux : cookie->aux;
-				for (; auxlen > 0; auxlen--)
-					seq_printf(m, "%02x", *p++);
-			}
-		}
-
-		seq_puts(m, "\n");
-	} else {
-		seq_puts(m, "<no_netfs>\n");
-	}
-	return 0;
-}
-
-static const struct seq_operations fscache_objlist_ops = {
-	.start		= fscache_objlist_start,
-	.stop		= fscache_objlist_stop,
-	.next		= fscache_objlist_next,
-	.show		= fscache_objlist_show,
-};
-
-/*
- * get the configuration for filtering the list
- */
-static void fscache_objlist_config(struct fscache_objlist_data *data)
-{
-#ifdef CONFIG_KEYS
-	const struct user_key_payload *confkey;
-	unsigned long config;
-	struct key *key;
-	const char *buf;
-	int len;
-
-	key = request_key(&key_type_user, "fscache:objlist", NULL);
-	if (IS_ERR(key))
-		goto no_config;
-
-	config = 0;
-	rcu_read_lock();
-
-	confkey = user_key_payload_rcu(key);
-	if (!confkey) {
-		/* key was revoked */
-		rcu_read_unlock();
-		key_put(key);
-		goto no_config;
-	}
-
-	buf = confkey->data;
-
-	for (len = confkey->datalen - 1; len >= 0; len--) {
-		switch (buf[len]) {
-		case 'K': config |= FSCACHE_OBJLIST_CONFIG_KEY;		break;
-		case 'A': config |= FSCACHE_OBJLIST_CONFIG_AUX;		break;
-		case 'C': config |= FSCACHE_OBJLIST_CONFIG_COOKIE;	break;
-		case 'c': config |= FSCACHE_OBJLIST_CONFIG_NOCOOKIE;	break;
-		case 'B': config |= FSCACHE_OBJLIST_CONFIG_BUSY;	break;
-		case 'b': config |= FSCACHE_OBJLIST_CONFIG_IDLE;	break;
-		case 'W': config |= FSCACHE_OBJLIST_CONFIG_PENDWR;	break;
-		case 'w': config |= FSCACHE_OBJLIST_CONFIG_NOPENDWR;	break;
-		case 'R': config |= FSCACHE_OBJLIST_CONFIG_READS;	break;
-		case 'r': config |= FSCACHE_OBJLIST_CONFIG_NOREADS;	break;
-		case 'S': config |= FSCACHE_OBJLIST_CONFIG_WORK;	break;
-		case 's': config |= FSCACHE_OBJLIST_CONFIG_NOWORK;	break;
-		}
-	}
-
-	rcu_read_unlock();
-	key_put(key);
-
-	if (!(config & (FSCACHE_OBJLIST_CONFIG_COOKIE | FSCACHE_OBJLIST_CONFIG_NOCOOKIE)))
-	    config   |= FSCACHE_OBJLIST_CONFIG_COOKIE | FSCACHE_OBJLIST_CONFIG_NOCOOKIE;
-	if (!(config & (FSCACHE_OBJLIST_CONFIG_BUSY | FSCACHE_OBJLIST_CONFIG_IDLE)))
-	    config   |= FSCACHE_OBJLIST_CONFIG_BUSY | FSCACHE_OBJLIST_CONFIG_IDLE;
-	if (!(config & (FSCACHE_OBJLIST_CONFIG_PENDWR | FSCACHE_OBJLIST_CONFIG_NOPENDWR)))
-	    config   |= FSCACHE_OBJLIST_CONFIG_PENDWR | FSCACHE_OBJLIST_CONFIG_NOPENDWR;
-	if (!(config & (FSCACHE_OBJLIST_CONFIG_READS | FSCACHE_OBJLIST_CONFIG_NOREADS)))
-	    config   |= FSCACHE_OBJLIST_CONFIG_READS | FSCACHE_OBJLIST_CONFIG_NOREADS;
-	if (!(config & (FSCACHE_OBJLIST_CONFIG_EVENTS | FSCACHE_OBJLIST_CONFIG_NOEVENTS)))
-	    config   |= FSCACHE_OBJLIST_CONFIG_EVENTS | FSCACHE_OBJLIST_CONFIG_NOEVENTS;
-	if (!(config & (FSCACHE_OBJLIST_CONFIG_WORK | FSCACHE_OBJLIST_CONFIG_NOWORK)))
-	    config   |= FSCACHE_OBJLIST_CONFIG_WORK | FSCACHE_OBJLIST_CONFIG_NOWORK;
-
-	data->config = config;
-	return;
-
-no_config:
-#endif
-	data->config = ULONG_MAX;
-}
-
-/*
- * open "/proc/fs/fscache/objects" to provide a list of active objects
- * - can be configured by a user-defined key added to the caller's keyrings
- */
-static int fscache_objlist_open(struct inode *inode, struct file *file)
-{
-	struct fscache_objlist_data *data;
-
-	data = __seq_open_private(file, &fscache_objlist_ops, sizeof(*data));
-	if (!data)
-		return -ENOMEM;
-
-	/* get the configuration key */
-	fscache_objlist_config(data);
-
-	return 0;
-}
-
-/*
- * clean up on close
- */
-static int fscache_objlist_release(struct inode *inode, struct file *file)
-{
-	struct seq_file *m = file->private_data;
-
-	kfree(m->private);
-	m->private = NULL;
-	return seq_release(inode, file);
-}
-
-const struct proc_ops fscache_objlist_proc_ops = {
-	.proc_open	= fscache_objlist_open,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
-	.proc_release	= fscache_objlist_release,
-};
diff --git a/fs/fscache/object.c b/fs/fscache/object.c
index 5dbaab2e1262..b3853274733f 100644
--- a/fs/fscache/object.c
+++ b/fs/fscache/object.c
@@ -794,8 +794,6 @@ static void fscache_put_object(struct fscache_object *object,
  */
 void fscache_object_destroy(struct fscache_object *object)
 {
-	fscache_objlist_remove(object);
-
 	/* We can get rid of the cookie now */
 	fscache_cookie_put(object->cookie, fscache_cookie_put_object);
 	object->cookie = NULL;
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index fbff0b7e3ef1..8d39491c5f9f 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -384,9 +384,6 @@ struct fscache_object {
 	struct list_head	dependents;	/* FIFO of dependent objects */
 	struct list_head	dep_link;	/* link in parent's dependents list */
 	struct list_head	pending_ops;	/* unstarted operations on this object */
-#ifdef CONFIG_FSCACHE_OBJECT_LIST
-	struct rb_node		objlist_link;	/* link in global object list */
-#endif
 	pgoff_t			store_limit;	/* current storage limit */
 	loff_t			store_limit_l;	/* current storage limit */
 };


