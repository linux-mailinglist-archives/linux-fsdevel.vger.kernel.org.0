Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189733AF7D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 23:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhFUVsj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 17:48:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32648 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231882AbhFUVsi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 17:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624311983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fd0eKXWWIFYSj5Goz3J1iPoFFKRbPYrWtc1BpxAgCpY=;
        b=YBxZDkHnEJUXIg7t8BjNeZ2cRjMIOByPs2IHsaPEsx63vh2okXKD0Bk4hXpxoT0Q+5jYot
        VW1dzdrqoXz2UpbQoPrPT/dWwW8ZxOjj56X1xTNsgy3XOhCG6zrLu2IYWHXd2LAgOIHCya
        c5cdFH8P4TUvAj35qXmYGMu2Q1cquNU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-lhWIBs8uMW2zLAtDMy4jMQ-1; Mon, 21 Jun 2021 17:46:19 -0400
X-MC-Unique: lhWIBs8uMW2zLAtDMy4jMQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BBE150754;
        Mon, 21 Jun 2021 21:46:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52D68100AE35;
        Mon, 21 Jun 2021 21:46:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 06/12] fscache, cachefiles: Remove the histogram stuff
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
Date:   Mon, 21 Jun 2021 22:45:59 +0100
Message-ID: <162431195953.2908479.16770977195634296638.stgit@warthog.procyon.org.uk>
In-Reply-To: <162431188431.2908479.14031376932042135080.stgit@warthog.procyon.org.uk>
References: <162431188431.2908479.14031376932042135080.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the histogram stuff as it's mostly going to be outdated.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/Kconfig         |   19 -------
 fs/cachefiles/Makefile        |    2 -
 fs/cachefiles/internal.h      |   25 ---------
 fs/cachefiles/main.c          |    7 ---
 fs/cachefiles/namei.c         |   13 -----
 fs/cachefiles/proc.c          |  114 -----------------------------------------
 fs/fscache/Kconfig            |   17 ------
 fs/fscache/Makefile           |    1 
 fs/fscache/histogram.c        |   87 -------------------------------
 fs/fscache/internal.h         |   24 ---------
 fs/fscache/object.c           |    5 --
 fs/fscache/operation.c        |    3 -
 fs/fscache/page.c             |    6 --
 fs/fscache/proc.c             |   13 -----
 include/linux/fscache-cache.h |    1 
 15 files changed, 337 deletions(-)
 delete mode 100644 fs/cachefiles/proc.c
 delete mode 100644 fs/fscache/histogram.c

diff --git a/fs/cachefiles/Kconfig b/fs/cachefiles/Kconfig
index ff9ca55a9ae9..6827b40f7ddc 100644
--- a/fs/cachefiles/Kconfig
+++ b/fs/cachefiles/Kconfig
@@ -19,22 +19,3 @@ config CACHEFILES_DEBUG
 	  caching on files module.  If this is set, the debugging output may be
 	  enabled by setting bits in /sys/modules/cachefiles/parameter/debug or
 	  by including a debugging specifier in /etc/cachefilesd.conf.
-
-config CACHEFILES_HISTOGRAM
-	bool "Gather latency information on CacheFiles"
-	depends on CACHEFILES && PROC_FS
-	help
-
-	  This option causes latency information to be gathered on CacheFiles
-	  operation and exported through file:
-
-		/proc/fs/cachefiles/histogram
-
-	  The generation of this histogram adds a certain amount of overhead to
-	  execution as there are a number of points at which data is gathered,
-	  and on a multi-CPU system these may be on cachelines that keep
-	  bouncing between CPUs.  On the other hand, the histogram may be
-	  useful for debugging purposes.  Saying 'N' here is recommended.
-
-	  See Documentation/filesystems/caching/cachefiles.rst for more
-	  information.
diff --git a/fs/cachefiles/Makefile b/fs/cachefiles/Makefile
index 2227dc2d5498..02fd17731769 100644
--- a/fs/cachefiles/Makefile
+++ b/fs/cachefiles/Makefile
@@ -15,6 +15,4 @@ cachefiles-y := \
 	security.o \
 	xattr.o
 
-cachefiles-$(CONFIG_CACHEFILES_HISTOGRAM) += proc.o
-
 obj-$(CONFIG_CACHEFILES) := cachefiles.o
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 4ed83aa5253b..0a511c36dab8 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -180,31 +180,6 @@ extern int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
 extern int cachefiles_check_in_use(struct cachefiles_cache *cache,
 				   struct dentry *dir, char *filename);
 
-/*
- * proc.c
- */
-#ifdef CONFIG_CACHEFILES_HISTOGRAM
-extern atomic_t cachefiles_lookup_histogram[HZ];
-extern atomic_t cachefiles_mkdir_histogram[HZ];
-extern atomic_t cachefiles_create_histogram[HZ];
-
-extern int __init cachefiles_proc_init(void);
-extern void cachefiles_proc_cleanup(void);
-static inline
-void cachefiles_hist(atomic_t histogram[], unsigned long start_jif)
-{
-	unsigned long jif = jiffies - start_jif;
-	if (jif >= HZ)
-		jif = HZ - 1;
-	atomic_inc(&histogram[jif]);
-}
-
-#else
-#define cachefiles_proc_init()		(0)
-#define cachefiles_proc_cleanup()	do {} while (0)
-#define cachefiles_hist(hist, start_jif) do {} while (0)
-#endif
-
 /*
  * rdwr.c
  */
diff --git a/fs/cachefiles/main.c b/fs/cachefiles/main.c
index ddf0cd58d60c..9c8d34c49b12 100644
--- a/fs/cachefiles/main.c
+++ b/fs/cachefiles/main.c
@@ -69,15 +69,9 @@ static int __init cachefiles_init(void)
 		goto error_object_jar;
 	}
 
-	ret = cachefiles_proc_init();
-	if (ret < 0)
-		goto error_proc;
-
 	pr_info("Loaded\n");
 	return 0;
 
-error_proc:
-	kmem_cache_destroy(cachefiles_object_jar);
 error_object_jar:
 	misc_deregister(&cachefiles_dev);
 error_dev:
@@ -94,7 +88,6 @@ static void __exit cachefiles_exit(void)
 {
 	pr_info("Unloading\n");
 
-	cachefiles_proc_cleanup();
 	kmem_cache_destroy(cachefiles_object_jar);
 	misc_deregister(&cachefiles_dev);
 }
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 7bf0732ae25c..92aa550dae7e 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -496,7 +496,6 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
 	struct dentry *dir, *next = NULL;
 	struct inode *inode;
 	struct path path;
-	unsigned long start;
 	const char *name;
 	int ret, nlen;
 
@@ -535,9 +534,7 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
 
 	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
 
-	start = jiffies;
 	next = lookup_one_len(name, dir, nlen);
-	cachefiles_hist(cachefiles_lookup_histogram, start);
 	if (IS_ERR(next)) {
 		trace_cachefiles_lookup(object, next, NULL);
 		goto lookup_error;
@@ -568,9 +565,7 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
 			ret = security_path_mkdir(&path, next, 0);
 			if (ret < 0)
 				goto create_error;
-			start = jiffies;
 			ret = vfs_mkdir(&init_user_ns, d_inode(dir), next, 0);
-			cachefiles_hist(cachefiles_mkdir_histogram, start);
 			if (!key)
 				trace_cachefiles_mkdir(object, next, ret);
 			if (ret < 0)
@@ -604,10 +599,8 @@ int cachefiles_walk_to_object(struct cachefiles_object *parent,
 			ret = security_path_mknod(&path, next, S_IFREG, 0);
 			if (ret < 0)
 				goto create_error;
-			start = jiffies;
 			ret = vfs_create(&init_user_ns, d_inode(dir), next,
 					 S_IFREG, true);
-			cachefiles_hist(cachefiles_create_histogram, start);
 			trace_cachefiles_create(object, next, ret);
 			if (ret < 0)
 				goto create_error;
@@ -765,7 +758,6 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 					const char *dirname)
 {
 	struct dentry *subdir;
-	unsigned long start;
 	struct path path;
 	int ret;
 
@@ -775,9 +767,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 	inode_lock(d_inode(dir));
 
 retry:
-	start = jiffies;
 	subdir = lookup_one_len(dirname, dir, strlen(dirname));
-	cachefiles_hist(cachefiles_lookup_histogram, start);
 	if (IS_ERR(subdir)) {
 		if (PTR_ERR(subdir) == -ENOMEM)
 			goto nomem_d_alloc;
@@ -876,7 +866,6 @@ static struct dentry *cachefiles_check_active(struct cachefiles_cache *cache,
 	struct cachefiles_object *object;
 	struct rb_node *_n;
 	struct dentry *victim;
-	unsigned long start;
 	int ret;
 
 	//_enter(",%pd/,%s",
@@ -885,9 +874,7 @@ static struct dentry *cachefiles_check_active(struct cachefiles_cache *cache,
 	/* look up the victim */
 	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
 
-	start = jiffies;
 	victim = lookup_one_len(filename, dir, strlen(filename));
-	cachefiles_hist(cachefiles_lookup_histogram, start);
 	if (IS_ERR(victim))
 		goto lookup_error;
 
diff --git a/fs/cachefiles/proc.c b/fs/cachefiles/proc.c
deleted file mode 100644
index 6e67aea0f24e..000000000000
--- a/fs/cachefiles/proc.c
+++ /dev/null
@@ -1,114 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* CacheFiles statistics
- *
- * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#include <linux/module.h>
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
-#include "internal.h"
-
-atomic_t cachefiles_lookup_histogram[HZ];
-atomic_t cachefiles_mkdir_histogram[HZ];
-atomic_t cachefiles_create_histogram[HZ];
-
-/*
- * display the latency histogram
- */
-static int cachefiles_histogram_show(struct seq_file *m, void *v)
-{
-	unsigned long index;
-	unsigned x, y, z, t;
-
-	switch ((unsigned long) v) {
-	case 1:
-		seq_puts(m, "JIFS  SECS  LOOKUPS   MKDIRS    CREATES\n");
-		return 0;
-	case 2:
-		seq_puts(m, "===== ===== ========= ========= =========\n");
-		return 0;
-	default:
-		index = (unsigned long) v - 3;
-		x = atomic_read(&cachefiles_lookup_histogram[index]);
-		y = atomic_read(&cachefiles_mkdir_histogram[index]);
-		z = atomic_read(&cachefiles_create_histogram[index]);
-		if (x == 0 && y == 0 && z == 0)
-			return 0;
-
-		t = (index * 1000) / HZ;
-
-		seq_printf(m, "%4lu  0.%03u %9u %9u %9u\n", index, t, x, y, z);
-		return 0;
-	}
-}
-
-/*
- * set up the iterator to start reading from the first line
- */
-static void *cachefiles_histogram_start(struct seq_file *m, loff_t *_pos)
-{
-	if ((unsigned long long)*_pos >= HZ + 2)
-		return NULL;
-	if (*_pos == 0)
-		*_pos = 1;
-	return (void *)(unsigned long) *_pos;
-}
-
-/*
- * move to the next line
- */
-static void *cachefiles_histogram_next(struct seq_file *m, void *v, loff_t *pos)
-{
-	(*pos)++;
-	return (unsigned long long)*pos > HZ + 2 ?
-		NULL : (void *)(unsigned long) *pos;
-}
-
-/*
- * clean up after reading
- */
-static void cachefiles_histogram_stop(struct seq_file *m, void *v)
-{
-}
-
-static const struct seq_operations cachefiles_histogram_ops = {
-	.start		= cachefiles_histogram_start,
-	.stop		= cachefiles_histogram_stop,
-	.next		= cachefiles_histogram_next,
-	.show		= cachefiles_histogram_show,
-};
-
-/*
- * initialise the /proc/fs/cachefiles/ directory
- */
-int __init cachefiles_proc_init(void)
-{
-	_enter("");
-
-	if (!proc_mkdir("fs/cachefiles", NULL))
-		goto error_dir;
-
-	if (!proc_create_seq("fs/cachefiles/histogram", S_IFREG | 0444, NULL,
-			 &cachefiles_histogram_ops))
-		goto error_histogram;
-
-	_leave(" = 0");
-	return 0;
-
-error_histogram:
-	remove_proc_entry("fs/cachefiles", NULL);
-error_dir:
-	_leave(" = -ENOMEM");
-	return -ENOMEM;
-}
-
-/*
- * clean up the /proc/fs/cachefiles/ directory
- */
-void cachefiles_proc_cleanup(void)
-{
-	remove_proc_entry("fs/cachefiles/histogram", NULL);
-	remove_proc_entry("fs/cachefiles", NULL);
-}
diff --git a/fs/fscache/Kconfig b/fs/fscache/Kconfig
index 92c87d8e0913..5e3a5b3f950d 100644
--- a/fs/fscache/Kconfig
+++ b/fs/fscache/Kconfig
@@ -29,23 +29,6 @@ config FSCACHE_STATS
 
 	  See Documentation/filesystems/caching/fscache.rst for more information.
 
-config FSCACHE_HISTOGRAM
-	bool "Gather latency information on local caching"
-	depends on FSCACHE && PROC_FS
-	help
-	  This option causes latency information to be gathered on local
-	  caching and exported through file:
-
-		/proc/fs/fscache/histogram
-
-	  The generation of this histogram adds a certain amount of overhead to
-	  execution as there are a number of points at which data is gathered,
-	  and on a multi-CPU system these may be on cachelines that keep
-	  bouncing between CPUs.  On the other hand, the histogram may be
-	  useful for debugging purposes.  Saying 'N' here is recommended.
-
-	  See Documentation/filesystems/caching/fscache.rst for more information.
-
 config FSCACHE_DEBUG
 	bool "Debug FS-Cache"
 	depends on FSCACHE
diff --git a/fs/fscache/Makefile b/fs/fscache/Makefile
index 3b2ffa93ac18..45d5235a449b 100644
--- a/fs/fscache/Makefile
+++ b/fs/fscache/Makefile
@@ -16,7 +16,6 @@ fscache-y := \
 
 fscache-$(CONFIG_PROC_FS) += proc.o
 fscache-$(CONFIG_FSCACHE_STATS) += stats.o
-fscache-$(CONFIG_FSCACHE_HISTOGRAM) += histogram.o
 fscache-$(CONFIG_FSCACHE_OBJECT_LIST) += object-list.o
 
 obj-$(CONFIG_FSCACHE) := fscache.o
diff --git a/fs/fscache/histogram.c b/fs/fscache/histogram.c
deleted file mode 100644
index 4e5beeaaf454..000000000000
--- a/fs/fscache/histogram.c
+++ /dev/null
@@ -1,87 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* FS-Cache latency histogram
- *
- * Copyright (C) 2008 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#define FSCACHE_DEBUG_LEVEL THREAD
-#include <linux/module.h>
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
-#include "internal.h"
-
-atomic_t fscache_obj_instantiate_histogram[HZ];
-atomic_t fscache_objs_histogram[HZ];
-atomic_t fscache_ops_histogram[HZ];
-atomic_t fscache_retrieval_delay_histogram[HZ];
-atomic_t fscache_retrieval_histogram[HZ];
-
-/*
- * display the time-taken histogram
- */
-static int fscache_histogram_show(struct seq_file *m, void *v)
-{
-	unsigned long index;
-	unsigned n[5], t;
-
-	switch ((unsigned long) v) {
-	case 1:
-		seq_puts(m, "JIFS  SECS  OBJ INST  OP RUNS   OBJ RUNS  RETRV DLY RETRIEVLS\n");
-		return 0;
-	case 2:
-		seq_puts(m, "===== ===== ========= ========= ========= ========= =========\n");
-		return 0;
-	default:
-		index = (unsigned long) v - 3;
-		n[0] = atomic_read(&fscache_obj_instantiate_histogram[index]);
-		n[1] = atomic_read(&fscache_ops_histogram[index]);
-		n[2] = atomic_read(&fscache_objs_histogram[index]);
-		n[3] = atomic_read(&fscache_retrieval_delay_histogram[index]);
-		n[4] = atomic_read(&fscache_retrieval_histogram[index]);
-		if (!(n[0] | n[1] | n[2] | n[3] | n[4]))
-			return 0;
-
-		t = (index * 1000) / HZ;
-
-		seq_printf(m, "%4lu  0.%03u %9u %9u %9u %9u %9u\n",
-			   index, t, n[0], n[1], n[2], n[3], n[4]);
-		return 0;
-	}
-}
-
-/*
- * set up the iterator to start reading from the first line
- */
-static void *fscache_histogram_start(struct seq_file *m, loff_t *_pos)
-{
-	if ((unsigned long long)*_pos >= HZ + 2)
-		return NULL;
-	if (*_pos == 0)
-		*_pos = 1;
-	return (void *)(unsigned long) *_pos;
-}
-
-/*
- * move to the next line
- */
-static void *fscache_histogram_next(struct seq_file *m, void *v, loff_t *pos)
-{
-	(*pos)++;
-	return (unsigned long long)*pos > HZ + 2 ?
-		NULL : (void *)(unsigned long) *pos;
-}
-
-/*
- * clean up after reading
- */
-static void fscache_histogram_stop(struct seq_file *m, void *v)
-{
-}
-
-const struct seq_operations fscache_histogram_ops = {
-	.start		= fscache_histogram_start,
-	.stop		= fscache_histogram_stop,
-	.next		= fscache_histogram_next,
-	.show		= fscache_histogram_show,
-};
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index 207a6bc81ca9..796678b2b32a 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -63,30 +63,6 @@ extern void fscache_cookie_put(struct fscache_cookie *,
 extern struct fscache_cookie fscache_fsdef_index;
 extern struct fscache_cookie_def fscache_fsdef_netfs_def;
 
-/*
- * histogram.c
- */
-#ifdef CONFIG_FSCACHE_HISTOGRAM
-extern atomic_t fscache_obj_instantiate_histogram[HZ];
-extern atomic_t fscache_objs_histogram[HZ];
-extern atomic_t fscache_ops_histogram[HZ];
-extern atomic_t fscache_retrieval_delay_histogram[HZ];
-extern atomic_t fscache_retrieval_histogram[HZ];
-
-static inline void fscache_hist(atomic_t histogram[], unsigned long start_jif)
-{
-	unsigned long jif = jiffies - start_jif;
-	if (jif >= HZ)
-		jif = HZ - 1;
-	atomic_inc(&histogram[jif]);
-}
-
-extern const struct seq_operations fscache_histogram_ops;
-
-#else
-#define fscache_hist(hist, start_jif) do {} while (0)
-#endif
-
 /*
  * main.c
  */
diff --git a/fs/fscache/object.c b/fs/fscache/object.c
index cb2146e02cd5..5dbaab2e1262 100644
--- a/fs/fscache/object.c
+++ b/fs/fscache/object.c
@@ -277,13 +277,10 @@ static void fscache_object_work_func(struct work_struct *work)
 {
 	struct fscache_object *object =
 		container_of(work, struct fscache_object, work);
-	unsigned long start;
 
 	_enter("{OBJ%x}", object->debug_id);
 
-	start = jiffies;
 	fscache_object_sm_dispatcher(object);
-	fscache_hist(fscache_objs_histogram, start);
 	fscache_put_object(object, fscache_obj_put_work);
 }
 
@@ -436,7 +433,6 @@ static const struct fscache_state *fscache_parent_ready(struct fscache_object *o
 	spin_lock(&parent->lock);
 	parent->n_ops++;
 	parent->n_obj_ops++;
-	object->lookup_jif = jiffies;
 	spin_unlock(&parent->lock);
 
 	_leave("");
@@ -596,7 +592,6 @@ static const struct fscache_state *fscache_object_available(struct fscache_objec
 	object->cache->ops->lookup_complete(object);
 	fscache_stat_d(&fscache_n_cop_lookup_complete);
 
-	fscache_hist(fscache_obj_instantiate_histogram, object->lookup_jif);
 	fscache_stat(&fscache_n_object_avail);
 
 	_leave("");
diff --git a/fs/fscache/operation.c b/fs/fscache/operation.c
index 4a5651d4904e..433877107700 100644
--- a/fs/fscache/operation.c
+++ b/fs/fscache/operation.c
@@ -616,7 +616,6 @@ void fscache_op_work_func(struct work_struct *work)
 {
 	struct fscache_operation *op =
 		container_of(work, struct fscache_operation, work);
-	unsigned long start;
 
 	_enter("{OBJ%x OP%x,%d}",
 	       op->object->debug_id, op->debug_id, atomic_read(&op->usage));
@@ -624,9 +623,7 @@ void fscache_op_work_func(struct work_struct *work)
 	trace_fscache_op(op->object->cookie, op, fscache_op_work);
 
 	ASSERT(op->processor != NULL);
-	start = jiffies;
 	op->processor(op);
-	fscache_hist(fscache_ops_histogram, start);
 	fscache_put_operation(op);
 
 	_leave("");
diff --git a/fs/fscache/page.c b/fs/fscache/page.c
index 991b0a871744..27df94ef0e0b 100644
--- a/fs/fscache/page.c
+++ b/fs/fscache/page.c
@@ -289,7 +289,6 @@ static void fscache_release_retrieval_op(struct fscache_operation *_op)
 	ASSERTIFCMP(op->op.state != FSCACHE_OP_ST_INITIALISED,
 		    atomic_read(&op->n_pages), ==, 0);
 
-	fscache_hist(fscache_retrieval_histogram, op->start_time);
 	if (op->context)
 		fscache_put_context(op->cookie, op->context);
 
@@ -324,7 +323,6 @@ struct fscache_retrieval *fscache_alloc_retrieval(
 	op->mapping	= mapping;
 	op->end_io_func	= end_io_func;
 	op->context	= context;
-	op->start_time	= jiffies;
 	INIT_LIST_HEAD(&op->to_do);
 
 	/* Pin the netfs read context in case we need to do the actual netfs
@@ -340,8 +338,6 @@ struct fscache_retrieval *fscache_alloc_retrieval(
  */
 int fscache_wait_for_deferred_lookup(struct fscache_cookie *cookie)
 {
-	unsigned long jif;
-
 	_enter("");
 
 	if (!test_bit(FSCACHE_COOKIE_LOOKING_UP, &cookie->flags)) {
@@ -351,7 +347,6 @@ int fscache_wait_for_deferred_lookup(struct fscache_cookie *cookie)
 
 	fscache_stat(&fscache_n_retrievals_wait);
 
-	jif = jiffies;
 	if (wait_on_bit(&cookie->flags, FSCACHE_COOKIE_LOOKING_UP,
 			TASK_INTERRUPTIBLE) != 0) {
 		fscache_stat(&fscache_n_retrievals_intr);
@@ -362,7 +357,6 @@ int fscache_wait_for_deferred_lookup(struct fscache_cookie *cookie)
 	ASSERT(!test_bit(FSCACHE_COOKIE_LOOKING_UP, &cookie->flags));
 
 	smp_rmb();
-	fscache_hist(fscache_retrieval_delay_histogram, jif);
 	_leave(" = 0 [dly]");
 	return 0;
 }
diff --git a/fs/fscache/proc.c b/fs/fscache/proc.c
index da51fdfc8641..061df8f61ffc 100644
--- a/fs/fscache/proc.c
+++ b/fs/fscache/proc.c
@@ -31,12 +31,6 @@ int __init fscache_proc_init(void)
 		goto error_stats;
 #endif
 
-#ifdef CONFIG_FSCACHE_HISTOGRAM
-	if (!proc_create_seq("fs/fscache/histogram", S_IFREG | 0444, NULL,
-			 &fscache_histogram_ops))
-		goto error_histogram;
-#endif
-
 #ifdef CONFIG_FSCACHE_OBJECT_LIST
 	if (!proc_create("fs/fscache/objects", S_IFREG | 0444, NULL,
 			 &fscache_objlist_proc_ops))
@@ -49,10 +43,6 @@ int __init fscache_proc_init(void)
 #ifdef CONFIG_FSCACHE_OBJECT_LIST
 error_objects:
 #endif
-#ifdef CONFIG_FSCACHE_HISTOGRAM
-	remove_proc_entry("fs/fscache/histogram", NULL);
-error_histogram:
-#endif
 #ifdef CONFIG_FSCACHE_STATS
 	remove_proc_entry("fs/fscache/stats", NULL);
 error_stats:
@@ -73,9 +63,6 @@ void fscache_proc_cleanup(void)
 #ifdef CONFIG_FSCACHE_OBJECT_LIST
 	remove_proc_entry("fs/fscache/objects", NULL);
 #endif
-#ifdef CONFIG_FSCACHE_HISTOGRAM
-	remove_proc_entry("fs/fscache/histogram", NULL);
-#endif
 #ifdef CONFIG_FSCACHE_STATS
 	remove_proc_entry("fs/fscache/stats", NULL);
 #endif
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 3235ddbdcc09..fbff0b7e3ef1 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -147,7 +147,6 @@ struct fscache_retrieval {
 	fscache_rw_complete_t	end_io_func;	/* function to call on I/O completion */
 	void			*context;	/* netfs read context (pinned) */
 	struct list_head	to_do;		/* list of things to be done by the backend */
-	unsigned long		start_time;	/* time at which retrieval started */
 	atomic_t		n_pages;	/* number of pages to be retrieved */
 };
 


