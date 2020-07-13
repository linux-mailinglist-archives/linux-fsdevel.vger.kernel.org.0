Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD7121DC21
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 18:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbgGMQaq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 12:30:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49517 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730105AbgGMQap (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594657841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PSqGS9xhcW+E7O3WOq0ZK8FQsEYjiToVBe6ISKKIqAE=;
        b=ha5i0QPecORP8c9F3HDif7LQDuTmuWpPklthMkmJG2RK1duZqdSDXQje73LkIbSpVMInsr
        N/zcmxt+LdX9wNGSf/obOpjyw5s3pG1z9+WpAJ7IooQYOXYaX9t7JFOdUfKBaCrmPFHOkX
        AgaSFsRdVlNRGgpcsjp0nPYt1WH2GlA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-70lr_g_PPhGJsvMdjX4BIA-1; Mon, 13 Jul 2020 12:30:38 -0400
X-MC-Unique: 70lr_g_PPhGJsvMdjX4BIA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E67C480040A;
        Mon, 13 Jul 2020 16:30:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-113.rdu2.redhat.com [10.10.112.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A0685D9DC;
        Mon, 13 Jul 2020 16:30:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 14/14] fscache: Remove the I/O operation manager
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
Date:   Mon, 13 Jul 2020 17:30:30 +0100
Message-ID: <159465783031.1376105.16780751382049297363.stgit@warthog.procyon.org.uk>
In-Reply-To: <159465766378.1376105.11619976251039287525.stgit@warthog.procyon.org.uk>
References: <159465766378.1376105.11619976251039287525.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the fscache I/O operation manager.  Getting operation-operation
interactions and object-operation interactions correct has proven really
difficult; furthermore, the operations are being replaced with kiocb-driven
stuff on the cache front.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/namei.c          |    5 
 fs/fscache/Makefile            |    3 
 fs/fscache/cache.c             |    3 
 fs/fscache/cookie.c            |    1 
 fs/fscache/internal.h          |   13 -
 fs/fscache/object-list.c       |   25 --
 fs/fscache/object.c            |   24 --
 fs/fscache/operation.c         |  633 ----------------------------------------
 include/linux/fscache-cache.h  |   71 ----
 include/trace/events/fscache.h |   57 ----
 10 files changed, 7 insertions(+), 828 deletions(-)
 delete mode 100644 fs/fscache/operation.c

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 432002080b83..924042e8cced 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -36,9 +36,8 @@ void __cachefiles_printk_object(struct cachefiles_object *object,
 	       prefix, object->fscache.state->name,
 	       object->fscache.flags, work_busy(&object->fscache.work),
 	       object->fscache.events, object->fscache.event_mask);
-	pr_err("%sops=%u inp=%u exc=%u\n",
-	       prefix, object->fscache.n_ops, object->fscache.n_in_progress,
-	       object->fscache.n_exclusive);
+	pr_err("%sops=%u\n",
+	       prefix, object->fscache.n_ops);
 	pr_err("%sparent=%p\n",
 	       prefix, object->fscache.parent);
 
diff --git a/fs/fscache/Makefile b/fs/fscache/Makefile
index 565a3441d31d..ac3fcd909fff 100644
--- a/fs/fscache/Makefile
+++ b/fs/fscache/Makefile
@@ -9,8 +9,7 @@ fscache-y := \
 	fsdef.o \
 	main.o \
 	netfs.o \
-	object.o \
-	operation.o
+	object.o
 
 fscache-$(CONFIG_PROC_FS) += proc.o
 fscache-$(CONFIG_FSCACHE_STATS) += stats.o
diff --git a/fs/fscache/cache.c b/fs/fscache/cache.c
index 2231691845b8..92f747b72ec3 100644
--- a/fs/fscache/cache.c
+++ b/fs/fscache/cache.c
@@ -182,12 +182,9 @@ void fscache_init_cache(struct fscache_cache *cache,
 	vsnprintf(cache->identifier, sizeof(cache->identifier), idfmt, va);
 	va_end(va);
 
-	INIT_WORK(&cache->op_gc, fscache_operation_gc);
 	INIT_LIST_HEAD(&cache->link);
 	INIT_LIST_HEAD(&cache->object_list);
-	INIT_LIST_HEAD(&cache->op_gc_list);
 	spin_lock_init(&cache->object_list_lock);
-	spin_lock_init(&cache->op_gc_list_lock);
 }
 EXPORT_SYMBOL(fscache_init_cache);
 
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 30394b32a91c..aa33d16711e1 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -756,7 +756,6 @@ void __fscache_disable_cookie(struct fscache_cookie *cookie,
 		hlist_for_each_entry(object, &cookie->backing_objects, cookie_link) {
 			if (invalidate)
 				set_bit(FSCACHE_OBJECT_RETIRED, &object->flags);
-			clear_bit(FSCACHE_OBJECT_PENDING_WRITE, &object->flags);
 			fscache_raise_event(object, FSCACHE_OBJECT_EV_KILL);
 		}
 	} else {
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index 360137fd19a7..bc5539d2157b 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -138,19 +138,6 @@ extern void fscache_objlist_remove(struct fscache_object *);
 #define fscache_objlist_remove(object) do {} while(0)
 #endif
 
-/*
- * operation.c
- */
-extern int fscache_submit_exclusive_op(struct fscache_object *,
-				       struct fscache_operation *);
-extern int fscache_submit_op(struct fscache_object *,
-			     struct fscache_operation *);
-extern int fscache_cancel_op(struct fscache_operation *, bool);
-extern void fscache_cancel_all_ops(struct fscache_object *);
-extern void fscache_abort_object(struct fscache_object *);
-extern void fscache_start_operations(struct fscache_object *);
-extern void fscache_operation_gc(struct work_struct *);
-
 /*
  * proc.c
  */
diff --git a/fs/fscache/object-list.c b/fs/fscache/object-list.c
index fc28de4738ec..147c556ee01b 100644
--- a/fs/fscache/object-list.c
+++ b/fs/fscache/object-list.c
@@ -23,10 +23,6 @@ struct fscache_objlist_data {
 #define FSCACHE_OBJLIST_CONFIG_AUX	0x00000002	/* show object auxdata */
 #define FSCACHE_OBJLIST_CONFIG_BUSY	0x00000010	/* show busy objects */
 #define FSCACHE_OBJLIST_CONFIG_IDLE	0x00000020	/* show idle objects */
-#define FSCACHE_OBJLIST_CONFIG_PENDWR	0x00000040	/* show objects with pending writes */
-#define FSCACHE_OBJLIST_CONFIG_NOPENDWR	0x00000080	/* show objects without pending writes */
-#define FSCACHE_OBJLIST_CONFIG_READS	0x00000100	/* show objects with active reads */
-#define FSCACHE_OBJLIST_CONFIG_NOREADS	0x00000200	/* show objects without active reads */
 #define FSCACHE_OBJLIST_CONFIG_EVENTS	0x00000400	/* show objects with events */
 #define FSCACHE_OBJLIST_CONFIG_NOEVENTS	0x00000800	/* show objects without no events */
 #define FSCACHE_OBJLIST_CONFIG_WORK	0x00001000	/* show objects with work */
@@ -166,7 +162,7 @@ static int fscache_objlist_show(struct seq_file *m, void *v)
 	u8 *p;
 
 	if ((unsigned long) v == 1) {
-		seq_puts(m, "OBJECT   PARENT   STAT CHLDN OPS OOP IPR EX READS"
+		seq_puts(m, "OBJECT   PARENT   STAT CHLDN OPS OOP"
 			 " EM EV FL S"
 			 " | COOKIE   TYPE    TY FL");
 		if (config & (FSCACHE_OBJLIST_CONFIG_KEY |
@@ -185,7 +181,7 @@ static int fscache_objlist_show(struct seq_file *m, void *v)
 	}
 
 	if ((unsigned long) v == 2) {
-		seq_puts(m, "======== ======== ==== ===== === === === == ====="
+		seq_puts(m, "======== ======== ==== ===== === ==="
 			 " == == == ="
 			 " | ======== ======= == ===");
 		if (config & (FSCACHE_OBJLIST_CONFIG_KEY |
@@ -217,26 +213,19 @@ static int fscache_objlist_show(struct seq_file *m, void *v)
 		       obj->flags ||
 		       !list_empty(&obj->dependents),
 		       BUSY, IDLE);
-		FILTER(test_bit(FSCACHE_OBJECT_PENDING_WRITE, &obj->flags),
-		       PENDWR, NOPENDWR);
-		FILTER(atomic_read(&obj->n_reads),
-		       READS, NOREADS);
 		FILTER(obj->events & obj->event_mask,
 		       EVENTS, NOEVENTS);
 		FILTER(work_busy(&obj->work), WORK, NOWORK);
 	}
 
 	seq_printf(m,
-		   "%08x %08x %s %5u %3u %3u %3u %2u %5u %2lx %2lx %2lx %1x | ",
+		   "%08x %08x %s %5u %3u %3u %2lx %2lx %2lx %1x | ",
 		   obj->debug_id,
 		   obj->parent ? obj->parent->debug_id : UINT_MAX,
 		   obj->state->short_name,
 		   obj->n_children,
 		   obj->n_ops,
 		   obj->n_obj_ops,
-		   obj->n_in_progress,
-		   obj->n_exclusive,
-		   atomic_read(&obj->n_reads),
 		   obj->event_mask,
 		   obj->events,
 		   obj->flags,
@@ -336,10 +325,6 @@ static void fscache_objlist_config(struct fscache_objlist_data *data)
 		case 'A': config |= FSCACHE_OBJLIST_CONFIG_AUX;		break;
 		case 'B': config |= FSCACHE_OBJLIST_CONFIG_BUSY;	break;
 		case 'b': config |= FSCACHE_OBJLIST_CONFIG_IDLE;	break;
-		case 'W': config |= FSCACHE_OBJLIST_CONFIG_PENDWR;	break;
-		case 'w': config |= FSCACHE_OBJLIST_CONFIG_NOPENDWR;	break;
-		case 'R': config |= FSCACHE_OBJLIST_CONFIG_READS;	break;
-		case 'r': config |= FSCACHE_OBJLIST_CONFIG_NOREADS;	break;
 		case 'S': config |= FSCACHE_OBJLIST_CONFIG_WORK;	break;
 		case 's': config |= FSCACHE_OBJLIST_CONFIG_NOWORK;	break;
 		}
@@ -350,10 +335,6 @@ static void fscache_objlist_config(struct fscache_objlist_data *data)
 
 	if (!(config & (FSCACHE_OBJLIST_CONFIG_BUSY | FSCACHE_OBJLIST_CONFIG_IDLE)))
 	    config   |= FSCACHE_OBJLIST_CONFIG_BUSY | FSCACHE_OBJLIST_CONFIG_IDLE;
-	if (!(config & (FSCACHE_OBJLIST_CONFIG_PENDWR | FSCACHE_OBJLIST_CONFIG_NOPENDWR)))
-	    config   |= FSCACHE_OBJLIST_CONFIG_PENDWR | FSCACHE_OBJLIST_CONFIG_NOPENDWR;
-	if (!(config & (FSCACHE_OBJLIST_CONFIG_READS | FSCACHE_OBJLIST_CONFIG_NOREADS)))
-	    config   |= FSCACHE_OBJLIST_CONFIG_READS | FSCACHE_OBJLIST_CONFIG_NOREADS;
 	if (!(config & (FSCACHE_OBJLIST_CONFIG_EVENTS | FSCACHE_OBJLIST_CONFIG_NOEVENTS)))
 	    config   |= FSCACHE_OBJLIST_CONFIG_EVENTS | FSCACHE_OBJLIST_CONFIG_NOEVENTS;
 	if (!(config & (FSCACHE_OBJLIST_CONFIG_WORK | FSCACHE_OBJLIST_CONFIG_NOWORK)))
diff --git a/fs/fscache/object.c b/fs/fscache/object.c
index 5eda1cd265ef..5d50976bf379 100644
--- a/fs/fscache/object.c
+++ b/fs/fscache/object.c
@@ -315,9 +315,8 @@ void fscache_object_init(struct fscache_object *object,
 	INIT_WORK(&object->work, fscache_object_work_func);
 	INIT_LIST_HEAD(&object->dependents);
 	INIT_LIST_HEAD(&object->dep_link);
-	INIT_LIST_HEAD(&object->pending_ops);
 	object->n_children = 0;
-	object->n_ops = object->n_in_progress = object->n_exclusive = 0;
+	object->n_ops = 0;
 	object->events = 0;
 	object->cache = cache;
 	object->cookie = cookie;
@@ -580,14 +579,6 @@ static const struct fscache_state *fscache_object_available(struct fscache_objec
 	spin_lock(&object->lock);
 
 	fscache_done_parent_op(object);
-	if (object->n_in_progress == 0) {
-		if (object->n_ops > 0) {
-			ASSERTCMP(object->n_ops, >=, object->n_obj_ops);
-			fscache_start_operations(object);
-		} else {
-			ASSERT(list_empty(&object->pending_ops));
-		}
-	}
 	spin_unlock(&object->lock);
 
 	fscache_stat(&fscache_n_cop_lookup_complete);
@@ -654,24 +645,11 @@ static const struct fscache_state *fscache_kill_object(struct fscache_object *ob
 	fscache_mark_object_dead(object);
 	object->oob_event_mask = 0;
 
-	if (test_bit(FSCACHE_OBJECT_RETIRED, &object->flags)) {
-		/* Reject any new read/write ops and abort any that are pending. */
-		clear_bit(FSCACHE_OBJECT_PENDING_WRITE, &object->flags);
-		fscache_cancel_all_ops(object);
-	}
-
 	if (list_empty(&object->dependents) &&
 	    object->n_ops == 0 &&
 	    object->n_children == 0)
 		return transit_to(DROP_OBJECT);
 
-	if (object->n_in_progress == 0) {
-		spin_lock(&object->lock);
-		if (object->n_ops > 0 && object->n_in_progress == 0)
-			fscache_start_operations(object);
-		spin_unlock(&object->lock);
-	}
-
 	if (!list_empty(&object->dependents))
 		return transit_to(KILL_DEPENDENTS);
 
diff --git a/fs/fscache/operation.c b/fs/fscache/operation.c
deleted file mode 100644
index 4a5651d4904e..000000000000
--- a/fs/fscache/operation.c
+++ /dev/null
@@ -1,633 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* FS-Cache worker operation management routines
- *
- * Copyright (C) 2008 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- *
- * See Documentation/filesystems/caching/operations.rst
- */
-
-#define FSCACHE_DEBUG_LEVEL OPERATION
-#include <linux/module.h>
-#include <linux/seq_file.h>
-#include <linux/slab.h>
-#include "internal.h"
-
-atomic_t fscache_op_debug_id;
-EXPORT_SYMBOL(fscache_op_debug_id);
-
-static void fscache_operation_dummy_cancel(struct fscache_operation *op)
-{
-}
-
-/**
- * fscache_operation_init - Do basic initialisation of an operation
- * @op: The operation to initialise
- * @release: The release function to assign
- *
- * Do basic initialisation of an operation.  The caller must still set flags,
- * object and processor if needed.
- */
-void fscache_operation_init(struct fscache_cookie *cookie,
-			    struct fscache_operation *op,
-			    fscache_operation_processor_t processor,
-			    fscache_operation_cancel_t cancel,
-			    fscache_operation_release_t release)
-{
-	INIT_WORK(&op->work, fscache_op_work_func);
-	atomic_set(&op->usage, 1);
-	op->state = FSCACHE_OP_ST_INITIALISED;
-	op->debug_id = atomic_inc_return(&fscache_op_debug_id);
-	op->processor = processor;
-	op->cancel = cancel ?: fscache_operation_dummy_cancel;
-	op->release = release;
-	INIT_LIST_HEAD(&op->pend_link);
-	fscache_stat(&fscache_n_op_initialised);
-	trace_fscache_op(cookie, op, fscache_op_init);
-}
-EXPORT_SYMBOL(fscache_operation_init);
-
-/**
- * fscache_enqueue_operation - Enqueue an operation for processing
- * @op: The operation to enqueue
- *
- * Enqueue an operation for processing by the FS-Cache thread pool.
- *
- * This will get its own ref on the object.
- */
-void fscache_enqueue_operation(struct fscache_operation *op)
-{
-	struct fscache_cookie *cookie = op->object->cookie;
-	
-	_enter("{OBJ%x OP%x,%u}",
-	       op->object->debug_id, op->debug_id, atomic_read(&op->usage));
-
-	ASSERT(list_empty(&op->pend_link));
-	ASSERT(op->processor != NULL);
-	ASSERT(fscache_object_is_available(op->object));
-	ASSERTCMP(atomic_read(&op->usage), >, 0);
-	ASSERTIFCMP(op->state != FSCACHE_OP_ST_IN_PROGRESS,
-		    op->state, ==,  FSCACHE_OP_ST_CANCELLED);
-
-	fscache_stat(&fscache_n_op_enqueue);
-	switch (op->flags & FSCACHE_OP_TYPE) {
-	case FSCACHE_OP_ASYNC:
-		trace_fscache_op(cookie, op, fscache_op_enqueue_async);
-		_debug("queue async");
-		atomic_inc(&op->usage);
-		if (!queue_work(fscache_op_wq, &op->work))
-			fscache_put_operation(op);
-		break;
-	case FSCACHE_OP_MYTHREAD:
-		trace_fscache_op(cookie, op, fscache_op_enqueue_mythread);
-		_debug("queue for caller's attention");
-		break;
-	default:
-		pr_err("Unexpected op type %lx", op->flags);
-		BUG();
-		break;
-	}
-}
-EXPORT_SYMBOL(fscache_enqueue_operation);
-
-/*
- * start an op running
- */
-static void fscache_run_op(struct fscache_object *object,
-			   struct fscache_operation *op)
-{
-	ASSERTCMP(op->state, ==, FSCACHE_OP_ST_PENDING);
-
-	op->state = FSCACHE_OP_ST_IN_PROGRESS;
-	object->n_in_progress++;
-	if (test_and_clear_bit(FSCACHE_OP_WAITING, &op->flags))
-		wake_up_bit(&op->flags, FSCACHE_OP_WAITING);
-	if (op->processor)
-		fscache_enqueue_operation(op);
-	else
-		trace_fscache_op(object->cookie, op, fscache_op_run);
-	fscache_stat(&fscache_n_op_run);
-}
-
-/*
- * report an unexpected submission
- */
-static void fscache_report_unexpected_submission(struct fscache_object *object,
-						 struct fscache_operation *op,
-						 const struct fscache_state *ostate)
-{
-	static bool once_only;
-	struct fscache_operation *p;
-	unsigned n;
-
-	if (once_only)
-		return;
-	once_only = true;
-
-	kdebug("unexpected submission OP%x [OBJ%x %s]",
-	       op->debug_id, object->debug_id, object->state->name);
-	kdebug("objstate=%s [%s]", object->state->name, ostate->name);
-	kdebug("objflags=%lx", object->flags);
-	kdebug("objevent=%lx [%lx]", object->events, object->event_mask);
-	kdebug("ops=%u inp=%u exc=%u",
-	       object->n_ops, object->n_in_progress, object->n_exclusive);
-
-	if (!list_empty(&object->pending_ops)) {
-		n = 0;
-		list_for_each_entry(p, &object->pending_ops, pend_link) {
-			ASSERTCMP(p->object, ==, object);
-			kdebug("%p %p", op->processor, op->release);
-			n++;
-		}
-
-		kdebug("n=%u", n);
-	}
-
-	dump_stack();
-}
-
-/*
- * submit an exclusive operation for an object
- * - other ops are excluded from running simultaneously with this one
- * - this gets any extra refs it needs on an op
- */
-int fscache_submit_exclusive_op(struct fscache_object *object,
-				struct fscache_operation *op)
-{
-	const struct fscache_state *ostate;
-	unsigned long flags;
-	int ret;
-
-	_enter("{OBJ%x OP%x},", object->debug_id, op->debug_id);
-
-	trace_fscache_op(object->cookie, op, fscache_op_submit_ex);
-
-	ASSERTCMP(op->state, ==, FSCACHE_OP_ST_INITIALISED);
-	ASSERTCMP(atomic_read(&op->usage), >, 0);
-
-	spin_lock(&object->lock);
-	ASSERTCMP(object->n_ops, >=, object->n_in_progress);
-	ASSERTCMP(object->n_ops, >=, object->n_exclusive);
-	ASSERT(list_empty(&op->pend_link));
-
-	ostate = object->state;
-	smp_rmb();
-
-	op->state = FSCACHE_OP_ST_PENDING;
-	flags = READ_ONCE(object->flags);
-	if (unlikely(!(flags & BIT(FSCACHE_OBJECT_IS_LIVE)))) {
-		fscache_stat(&fscache_n_op_rejected);
-		op->cancel(op);
-		op->state = FSCACHE_OP_ST_CANCELLED;
-		ret = -ENOBUFS;
-	} else if (unlikely(fscache_cache_is_broken(object))) {
-		op->cancel(op);
-		op->state = FSCACHE_OP_ST_CANCELLED;
-		ret = -EIO;
-	} else if (flags & BIT(FSCACHE_OBJECT_IS_AVAILABLE)) {
-		op->object = object;
-		object->n_ops++;
-		object->n_exclusive++;	/* reads and writes must wait */
-
-		if (object->n_in_progress > 0) {
-			atomic_inc(&op->usage);
-			list_add_tail(&op->pend_link, &object->pending_ops);
-			fscache_stat(&fscache_n_op_pend);
-		} else if (!list_empty(&object->pending_ops)) {
-			atomic_inc(&op->usage);
-			list_add_tail(&op->pend_link, &object->pending_ops);
-			fscache_stat(&fscache_n_op_pend);
-			fscache_start_operations(object);
-		} else {
-			ASSERTCMP(object->n_in_progress, ==, 0);
-			fscache_run_op(object, op);
-		}
-
-		/* need to issue a new write op after this */
-		clear_bit(FSCACHE_OBJECT_PENDING_WRITE, &object->flags);
-		ret = 0;
-	} else if (flags & BIT(FSCACHE_OBJECT_IS_LOOKED_UP)) {
-		op->object = object;
-		object->n_ops++;
-		object->n_exclusive++;	/* reads and writes must wait */
-		atomic_inc(&op->usage);
-		list_add_tail(&op->pend_link, &object->pending_ops);
-		fscache_stat(&fscache_n_op_pend);
-		ret = 0;
-	} else if (flags & BIT(FSCACHE_OBJECT_KILLED_BY_CACHE)) {
-		op->cancel(op);
-		op->state = FSCACHE_OP_ST_CANCELLED;
-		ret = -ENOBUFS;
-	} else {
-		fscache_report_unexpected_submission(object, op, ostate);
-		op->cancel(op);
-		op->state = FSCACHE_OP_ST_CANCELLED;
-		ret = -ENOBUFS;
-	}
-
-	spin_unlock(&object->lock);
-	return ret;
-}
-
-/*
- * submit an operation for an object
- * - objects may be submitted only in the following states:
- *   - during object creation (write ops may be submitted)
- *   - whilst the object is active
- *   - after an I/O error incurred in one of the two above states (op rejected)
- * - this gets any extra refs it needs on an op
- */
-int fscache_submit_op(struct fscache_object *object,
-		      struct fscache_operation *op)
-{
-	const struct fscache_state *ostate;
-	unsigned long flags;
-	int ret;
-
-	_enter("{OBJ%x OP%x},{%u}",
-	       object->debug_id, op->debug_id, atomic_read(&op->usage));
-
-	trace_fscache_op(object->cookie, op, fscache_op_submit);
-
-	ASSERTCMP(op->state, ==, FSCACHE_OP_ST_INITIALISED);
-	ASSERTCMP(atomic_read(&op->usage), >, 0);
-
-	spin_lock(&object->lock);
-	ASSERTCMP(object->n_ops, >=, object->n_in_progress);
-	ASSERTCMP(object->n_ops, >=, object->n_exclusive);
-	ASSERT(list_empty(&op->pend_link));
-
-	ostate = object->state;
-	smp_rmb();
-
-	op->state = FSCACHE_OP_ST_PENDING;
-	flags = READ_ONCE(object->flags);
-	if (unlikely(!(flags & BIT(FSCACHE_OBJECT_IS_LIVE)))) {
-		fscache_stat(&fscache_n_op_rejected);
-		op->cancel(op);
-		op->state = FSCACHE_OP_ST_CANCELLED;
-		ret = -ENOBUFS;
-	} else if (unlikely(fscache_cache_is_broken(object))) {
-		op->cancel(op);
-		op->state = FSCACHE_OP_ST_CANCELLED;
-		ret = -EIO;
-	} else if (flags & BIT(FSCACHE_OBJECT_IS_AVAILABLE)) {
-		op->object = object;
-		object->n_ops++;
-
-		if (object->n_exclusive > 0) {
-			atomic_inc(&op->usage);
-			list_add_tail(&op->pend_link, &object->pending_ops);
-			fscache_stat(&fscache_n_op_pend);
-		} else if (!list_empty(&object->pending_ops)) {
-			atomic_inc(&op->usage);
-			list_add_tail(&op->pend_link, &object->pending_ops);
-			fscache_stat(&fscache_n_op_pend);
-			fscache_start_operations(object);
-		} else {
-			ASSERTCMP(object->n_exclusive, ==, 0);
-			fscache_run_op(object, op);
-		}
-		ret = 0;
-	} else if (flags & BIT(FSCACHE_OBJECT_IS_LOOKED_UP)) {
-		op->object = object;
-		object->n_ops++;
-		atomic_inc(&op->usage);
-		list_add_tail(&op->pend_link, &object->pending_ops);
-		fscache_stat(&fscache_n_op_pend);
-		ret = 0;
-	} else if (flags & BIT(FSCACHE_OBJECT_KILLED_BY_CACHE)) {
-		op->cancel(op);
-		op->state = FSCACHE_OP_ST_CANCELLED;
-		ret = -ENOBUFS;
-	} else {
-		fscache_report_unexpected_submission(object, op, ostate);
-		ASSERT(!fscache_object_is_active(object));
-		op->cancel(op);
-		op->state = FSCACHE_OP_ST_CANCELLED;
-		ret = -ENOBUFS;
-	}
-
-	spin_unlock(&object->lock);
-	return ret;
-}
-
-/*
- * queue an object for withdrawal on error, aborting all following asynchronous
- * operations
- */
-void fscache_abort_object(struct fscache_object *object)
-{
-	_enter("{OBJ%x}", object->debug_id);
-
-	fscache_raise_event(object, FSCACHE_OBJECT_EV_ERROR);
-}
-
-/*
- * Jump start the operation processing on an object.  The caller must hold
- * object->lock.
- */
-void fscache_start_operations(struct fscache_object *object)
-{
-	struct fscache_operation *op;
-	bool stop = false;
-
-	while (!list_empty(&object->pending_ops) && !stop) {
-		op = list_entry(object->pending_ops.next,
-				struct fscache_operation, pend_link);
-
-		if (test_bit(FSCACHE_OP_EXCLUSIVE, &op->flags)) {
-			if (object->n_in_progress > 0)
-				break;
-			stop = true;
-		}
-		list_del_init(&op->pend_link);
-		fscache_run_op(object, op);
-
-		/* the pending queue was holding a ref on the object */
-		fscache_put_operation(op);
-	}
-
-	ASSERTCMP(object->n_in_progress, <=, object->n_ops);
-
-	_debug("woke %d ops on OBJ%x",
-	       object->n_in_progress, object->debug_id);
-}
-
-/*
- * cancel an operation that's pending on an object
- */
-int fscache_cancel_op(struct fscache_operation *op,
-		      bool cancel_in_progress_op)
-{
-	struct fscache_object *object = op->object;
-	bool put = false;
-	int ret;
-
-	_enter("OBJ%x OP%x}", op->object->debug_id, op->debug_id);
-
-	trace_fscache_op(object->cookie, op, fscache_op_cancel);
-
-	ASSERTCMP(op->state, >=, FSCACHE_OP_ST_PENDING);
-	ASSERTCMP(op->state, !=, FSCACHE_OP_ST_CANCELLED);
-	ASSERTCMP(atomic_read(&op->usage), >, 0);
-
-	spin_lock(&object->lock);
-
-	ret = -EBUSY;
-	if (op->state == FSCACHE_OP_ST_PENDING) {
-		ASSERT(!list_empty(&op->pend_link));
-		list_del_init(&op->pend_link);
-		put = true;
-
-		fscache_stat(&fscache_n_op_cancelled);
-		op->cancel(op);
-		op->state = FSCACHE_OP_ST_CANCELLED;
-		if (test_bit(FSCACHE_OP_EXCLUSIVE, &op->flags))
-			object->n_exclusive--;
-		if (test_and_clear_bit(FSCACHE_OP_WAITING, &op->flags))
-			wake_up_bit(&op->flags, FSCACHE_OP_WAITING);
-		ret = 0;
-	} else if (op->state == FSCACHE_OP_ST_IN_PROGRESS && cancel_in_progress_op) {
-		ASSERTCMP(object->n_in_progress, >, 0);
-		if (test_bit(FSCACHE_OP_EXCLUSIVE, &op->flags))
-			object->n_exclusive--;
-		object->n_in_progress--;
-		if (object->n_in_progress == 0)
-			fscache_start_operations(object);
-
-		fscache_stat(&fscache_n_op_cancelled);
-		op->cancel(op);
-		op->state = FSCACHE_OP_ST_CANCELLED;
-		if (test_bit(FSCACHE_OP_EXCLUSIVE, &op->flags))
-			object->n_exclusive--;
-		if (test_and_clear_bit(FSCACHE_OP_WAITING, &op->flags))
-			wake_up_bit(&op->flags, FSCACHE_OP_WAITING);
-		ret = 0;
-	}
-
-	if (put)
-		fscache_put_operation(op);
-	spin_unlock(&object->lock);
-	_leave(" = %d", ret);
-	return ret;
-}
-
-/*
- * Cancel all pending operations on an object
- */
-void fscache_cancel_all_ops(struct fscache_object *object)
-{
-	struct fscache_operation *op;
-
-	_enter("OBJ%x", object->debug_id);
-
-	spin_lock(&object->lock);
-
-	while (!list_empty(&object->pending_ops)) {
-		op = list_entry(object->pending_ops.next,
-				struct fscache_operation, pend_link);
-		fscache_stat(&fscache_n_op_cancelled);
-		list_del_init(&op->pend_link);
-
-		trace_fscache_op(object->cookie, op, fscache_op_cancel_all);
-
-		ASSERTCMP(op->state, ==, FSCACHE_OP_ST_PENDING);
-		op->cancel(op);
-		op->state = FSCACHE_OP_ST_CANCELLED;
-
-		if (test_bit(FSCACHE_OP_EXCLUSIVE, &op->flags))
-			object->n_exclusive--;
-		if (test_and_clear_bit(FSCACHE_OP_WAITING, &op->flags))
-			wake_up_bit(&op->flags, FSCACHE_OP_WAITING);
-		fscache_put_operation(op);
-		cond_resched_lock(&object->lock);
-	}
-
-	spin_unlock(&object->lock);
-	_leave("");
-}
-
-/*
- * Record the completion or cancellation of an in-progress operation.
- */
-void fscache_op_complete(struct fscache_operation *op, bool cancelled)
-{
-	struct fscache_object *object = op->object;
-
-	_enter("OBJ%x", object->debug_id);
-
-	ASSERTCMP(op->state, ==, FSCACHE_OP_ST_IN_PROGRESS);
-	ASSERTCMP(object->n_in_progress, >, 0);
-	ASSERTIFCMP(test_bit(FSCACHE_OP_EXCLUSIVE, &op->flags),
-		    object->n_exclusive, >, 0);
-	ASSERTIFCMP(test_bit(FSCACHE_OP_EXCLUSIVE, &op->flags),
-		    object->n_in_progress, ==, 1);
-
-	spin_lock(&object->lock);
-
-	if (!cancelled) {
-		trace_fscache_op(object->cookie, op, fscache_op_completed);
-		op->state = FSCACHE_OP_ST_COMPLETE;
-	} else {
-		op->cancel(op);
-		trace_fscache_op(object->cookie, op, fscache_op_cancelled);
-		op->state = FSCACHE_OP_ST_CANCELLED;
-	}
-
-	if (test_bit(FSCACHE_OP_EXCLUSIVE, &op->flags))
-		object->n_exclusive--;
-	object->n_in_progress--;
-	if (object->n_in_progress == 0)
-		fscache_start_operations(object);
-
-	spin_unlock(&object->lock);
-	_leave("");
-}
-EXPORT_SYMBOL(fscache_op_complete);
-
-/*
- * release an operation
- * - queues pending ops if this is the last in-progress op
- */
-void fscache_put_operation(struct fscache_operation *op)
-{
-	struct fscache_object *object;
-	struct fscache_cache *cache;
-
-	_enter("{OBJ%x OP%x,%d}",
-	       op->object ? op->object->debug_id : 0,
-	       op->debug_id, atomic_read(&op->usage));
-
-	ASSERTCMP(atomic_read(&op->usage), >, 0);
-
-	if (!atomic_dec_and_test(&op->usage))
-		return;
-
-	trace_fscache_op(op->object ? op->object->cookie : NULL, op, fscache_op_put);
-
-	_debug("PUT OP");
-	ASSERTIFCMP(op->state != FSCACHE_OP_ST_INITIALISED &&
-		    op->state != FSCACHE_OP_ST_COMPLETE,
-		    op->state, ==, FSCACHE_OP_ST_CANCELLED);
-
-	fscache_stat(&fscache_n_op_release);
-
-	if (op->release) {
-		op->release(op);
-		op->release = NULL;
-	}
-	op->state = FSCACHE_OP_ST_DEAD;
-
-	object = op->object;
-	if (likely(object)) {
-		if (test_bit(FSCACHE_OP_DEC_READ_CNT, &op->flags))
-			atomic_dec(&object->n_reads);
-		if (test_bit(FSCACHE_OP_UNUSE_COOKIE, &op->flags))
-			fscache_unuse_cookie(object);
-
-		/* now... we may get called with the object spinlock held, so we
-		 * complete the cleanup here only if we can immediately acquire the
-		 * lock, and defer it otherwise */
-		if (!spin_trylock(&object->lock)) {
-			_debug("defer put");
-			fscache_stat(&fscache_n_op_deferred_release);
-
-			cache = object->cache;
-			spin_lock(&cache->op_gc_list_lock);
-			list_add_tail(&op->pend_link, &cache->op_gc_list);
-			spin_unlock(&cache->op_gc_list_lock);
-			schedule_work(&cache->op_gc);
-			_leave(" [defer]");
-			return;
-		}
-
-		ASSERTCMP(object->n_ops, >, 0);
-		object->n_ops--;
-		if (object->n_ops == 0)
-			fscache_raise_event(object, FSCACHE_OBJECT_EV_CLEARED);
-
-		spin_unlock(&object->lock);
-	}
-
-	kfree(op);
-	_leave(" [done]");
-}
-EXPORT_SYMBOL(fscache_put_operation);
-
-/*
- * garbage collect operations that have had their release deferred
- */
-void fscache_operation_gc(struct work_struct *work)
-{
-	struct fscache_operation *op;
-	struct fscache_object *object;
-	struct fscache_cache *cache =
-		container_of(work, struct fscache_cache, op_gc);
-	int count = 0;
-
-	_enter("");
-
-	do {
-		spin_lock(&cache->op_gc_list_lock);
-		if (list_empty(&cache->op_gc_list)) {
-			spin_unlock(&cache->op_gc_list_lock);
-			break;
-		}
-
-		op = list_entry(cache->op_gc_list.next,
-				struct fscache_operation, pend_link);
-		list_del(&op->pend_link);
-		spin_unlock(&cache->op_gc_list_lock);
-
-		object = op->object;
-		trace_fscache_op(object->cookie, op, fscache_op_gc);
-
-		spin_lock(&object->lock);
-
-		_debug("GC DEFERRED REL OBJ%x OP%x",
-		       object->debug_id, op->debug_id);
-		fscache_stat(&fscache_n_op_gc);
-
-		ASSERTCMP(atomic_read(&op->usage), ==, 0);
-		ASSERTCMP(op->state, ==, FSCACHE_OP_ST_DEAD);
-
-		ASSERTCMP(object->n_ops, >, 0);
-		object->n_ops--;
-		if (object->n_ops == 0)
-			fscache_raise_event(object, FSCACHE_OBJECT_EV_CLEARED);
-
-		spin_unlock(&object->lock);
-		kfree(op);
-
-	} while (count++ < 20);
-
-	if (!list_empty(&cache->op_gc_list))
-		schedule_work(&cache->op_gc);
-
-	_leave("");
-}
-
-/*
- * execute an operation using fs_op_wq to provide processing context -
- * the caller holds a ref to this object, so we don't need to hold one
- */
-void fscache_op_work_func(struct work_struct *work)
-{
-	struct fscache_operation *op =
-		container_of(work, struct fscache_operation, work);
-	unsigned long start;
-
-	_enter("{OBJ%x OP%x,%d}",
-	       op->object->debug_id, op->debug_id, atomic_read(&op->usage));
-
-	trace_fscache_op(op->object->cookie, op, fscache_op_work);
-
-	ASSERT(op->processor != NULL);
-	start = jiffies;
-	op->processor(op);
-	fscache_hist(fscache_ops_histogram, start);
-	fscache_put_operation(op);
-
-	_leave("");
-}
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 0fbe25b1271b..8b6aa11dee54 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -23,7 +23,6 @@
 struct fscache_cache;
 struct fscache_cache_ops;
 struct fscache_object;
-struct fscache_operation;
 
 enum fscache_obj_ref_trace {
 	fscache_obj_get_add_to_deps,
@@ -62,11 +61,8 @@ struct fscache_cache {
 	char			identifier[36];	/* cache label */
 
 	/* node management */
-	struct work_struct	op_gc;		/* operation garbage collector */
 	struct list_head	object_list;	/* list of data/index objects */
-	struct list_head	op_gc_list;	/* list of ops to be deleted */
 	spinlock_t		object_list_lock;
-	spinlock_t		op_gc_list_lock;
 	atomic_t		object_count;	/* no. of live objects in this cache */
 	struct fscache_object	*fsdef;		/* object for the fsdef index */
 	unsigned long		flags;
@@ -76,68 +72,6 @@ struct fscache_cache {
 
 extern wait_queue_head_t fscache_cache_cleared_wq;
 
-/*
- * operation to be applied to a cache object
- * - retrieval initiation operations are done in the context of the process
- *   that issued them, and not in an async thread pool
- */
-typedef void (*fscache_operation_release_t)(struct fscache_operation *op);
-typedef void (*fscache_operation_processor_t)(struct fscache_operation *op);
-typedef void (*fscache_operation_cancel_t)(struct fscache_operation *op);
-
-enum fscache_operation_state {
-	FSCACHE_OP_ST_BLANK,		/* Op is not yet submitted */
-	FSCACHE_OP_ST_INITIALISED,	/* Op is initialised */
-	FSCACHE_OP_ST_PENDING,		/* Op is blocked from running */
-	FSCACHE_OP_ST_IN_PROGRESS,	/* Op is in progress */
-	FSCACHE_OP_ST_COMPLETE,		/* Op is complete */
-	FSCACHE_OP_ST_CANCELLED,	/* Op has been cancelled */
-	FSCACHE_OP_ST_DEAD		/* Op is now dead */
-};
-
-struct fscache_operation {
-	struct work_struct	work;		/* record for async ops */
-	struct list_head	pend_link;	/* link in object->pending_ops */
-	struct fscache_object	*object;	/* object to be operated upon */
-
-	unsigned long		flags;
-#define FSCACHE_OP_TYPE		0x000f	/* operation type */
-#define FSCACHE_OP_ASYNC	0x0001	/* - async op, processor may sleep for disk */
-#define FSCACHE_OP_MYTHREAD	0x0002	/* - processing is done be issuing thread, not pool */
-#define FSCACHE_OP_WAITING	4	/* cleared when op is woken */
-#define FSCACHE_OP_EXCLUSIVE	5	/* exclusive op, other ops must wait */
-#define FSCACHE_OP_DEC_READ_CNT	6	/* decrement object->n_reads on destruction */
-#define FSCACHE_OP_UNUSE_COOKIE	7	/* call fscache_unuse_cookie() on completion */
-#define FSCACHE_OP_KEEP_FLAGS	0x00f0	/* flags to keep when repurposing an op */
-
-	enum fscache_operation_state state;
-	atomic_t		usage;
-	unsigned		debug_id;	/* debugging ID */
-
-	/* operation processor callback
-	 * - can be NULL if FSCACHE_OP_WAITING is going to be used to perform
-	 *   the op in a non-pool thread */
-	fscache_operation_processor_t processor;
-
-	/* Operation cancellation cleanup (optional) */
-	fscache_operation_cancel_t cancel;
-
-	/* operation releaser */
-	fscache_operation_release_t release;
-};
-
-extern atomic_t fscache_op_debug_id;
-extern void fscache_op_work_func(struct work_struct *work);
-
-extern void fscache_enqueue_operation(struct fscache_operation *);
-extern void fscache_op_complete(struct fscache_operation *, bool);
-extern void fscache_put_operation(struct fscache_operation *);
-extern void fscache_operation_init(struct fscache_cookie *,
-				   struct fscache_operation *,
-				   fscache_operation_processor_t,
-				   fscache_operation_cancel_t,
-				   fscache_operation_release_t);
-
 /*
  * cache operations
  */
@@ -232,9 +166,6 @@ struct fscache_object {
 	int			n_children;	/* number of child objects */
 	int			n_ops;		/* number of extant ops on object */
 	int			n_obj_ops;	/* number of object ops outstanding on object */
-	int			n_in_progress;	/* number of ops in progress */
-	int			n_exclusive;	/* number of exclusive ops queued or in progress */
-	atomic_t		n_reads;	/* number of read ops in progress */
 	spinlock_t		lock;		/* state and operations lock */
 
 	unsigned long		lookup_jif;	/* time at which lookup started */
@@ -245,7 +176,6 @@ struct fscache_object {
 
 	unsigned long		flags;
 #define FSCACHE_OBJECT_LOCK		0	/* T if object is busy being processed */
-#define FSCACHE_OBJECT_PENDING_WRITE	1	/* T if object has pending write */
 #define FSCACHE_OBJECT_WAITING		2	/* T if object is waiting on its parent */
 #define FSCACHE_OBJECT_IS_LIVE		3	/* T if object is not withdrawn or relinquished */
 #define FSCACHE_OBJECT_IS_LOOKED_UP	4	/* T if object has been looked up */
@@ -262,7 +192,6 @@ struct fscache_object {
 	struct work_struct	work;		/* attention scheduling record */
 	struct list_head	dependents;	/* FIFO of dependent objects */
 	struct list_head	dep_link;	/* link in parent's dependents list */
-	struct list_head	pending_ops;	/* unstarted operations on this object */
 #ifdef CONFIG_FSCACHE_OBJECT_LIST
 	struct rb_node		objlist_link;	/* link in global object list */
 #endif
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index 2ebfd688a7c2..08d7de72409d 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -33,24 +33,6 @@ enum fscache_cookie_trace {
 	fscache_cookie_put_parent,
 };
 
-enum fscache_op_trace {
-	fscache_op_cancel,
-	fscache_op_cancel_all,
-	fscache_op_cancelled,
-	fscache_op_completed,
-	fscache_op_enqueue_async,
-	fscache_op_enqueue_mythread,
-	fscache_op_gc,
-	fscache_op_init,
-	fscache_op_put,
-	fscache_op_run,
-	fscache_op_signal,
-	fscache_op_submit,
-	fscache_op_submit_ex,
-	fscache_op_work,
-	fscache_op_trace__nr
-};
-
 #endif
 
 /*
@@ -69,22 +51,6 @@ enum fscache_op_trace {
 	EM(fscache_cookie_put_object,		"PUT obj")		\
 	E_(fscache_cookie_put_parent,		"PUT prn")
 
-#define fscache_op_traces						\
-	EM(fscache_op_cancel,			"Cancel1")		\
-	EM(fscache_op_cancel_all,		"CancelA")		\
-	EM(fscache_op_cancelled,		"Canclld")		\
-	EM(fscache_op_completed,		"Complet")		\
-	EM(fscache_op_enqueue_async,		"EnqAsyn")		\
-	EM(fscache_op_enqueue_mythread,		"EnqMyTh")		\
-	EM(fscache_op_gc,			"GC     ")		\
-	EM(fscache_op_init,			"Init   ")		\
-	EM(fscache_op_put,			"Put    ")		\
-	EM(fscache_op_run,			"Run    ")		\
-	EM(fscache_op_signal,			"Signal ")		\
-	EM(fscache_op_submit,			"Submit ")		\
-	EM(fscache_op_submit_ex,		"SubmitX")		\
-	E_(fscache_op_work,			"Work   ")
-
 /*
  * Export enum symbols via userspace.
  */
@@ -309,29 +275,6 @@ TRACE_EVENT(fscache_osm,
 		      __entry->event_num)
 	    );
 
-TRACE_EVENT(fscache_op,
-	    TP_PROTO(struct fscache_cookie *cookie, struct fscache_operation *op,
-		     enum fscache_op_trace why),
-
-	    TP_ARGS(cookie, op, why),
-
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		cookie		)
-		    __field(unsigned int,		op		)
-		    __field(enum fscache_op_trace,	why		)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->cookie		= cookie->debug_id;
-		    __entry->op			= op->debug_id;
-		    __entry->why		= why;
-			   ),
-
-	    TP_printk("c=%08x op=%08x %s",
-		      __entry->cookie, __entry->op,
-		      __print_symbolic(__entry->why, fscache_op_traces))
-	    );
-
 #endif /* _TRACE_FSCACHE_H */
 
 /* This part must be outside protection */


