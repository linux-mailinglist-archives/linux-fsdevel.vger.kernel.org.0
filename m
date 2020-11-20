Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84F72BAC87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgKTPDh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:03:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20066 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728353AbgKTPDg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:03:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605884613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gha9PQJmMtUxloPOCll9l364OZsFf4jduRcuOjWDnz4=;
        b=PoZpdxRWIpjdafjUVpTnWyYqH3MTyf0rMv/cBSbM7JqPofFoACuS0j0ys+wXaYj1rcPxYi
        tFfmgikPVGk4NUqgzNlMtHBDi3D/0EEf8xtCNb3/fI750aMg3yH80tMrUnHMX4e+E8SduH
        0exAeVO8pkPyWxYZXijqs0qhKDG3BAA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-RJxBwpHWPMSm1ALkzjmseg-1; Fri, 20 Nov 2020 10:03:28 -0500
X-MC-Unique: RJxBwpHWPMSm1ALkzjmseg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4B2663CC1;
        Fri, 20 Nov 2020 15:03:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C11E05D9D5;
        Fri, 20 Nov 2020 15:03:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 03/76] fscache: Add a cookie debug ID and use that in
 traces
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
Date:   Fri, 20 Nov 2020 15:03:11 +0000
Message-ID: <160588459097.3465195.1273313637721852165.stgit@warthog.procyon.org.uk>
In-Reply-To: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
References: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a cookie debug ID and use that in traces and in procfiles rather than
displaying the (hashed) pointer to the cookie.  This is easier to correlate
and we don't lose anything when interpreting oops output since that shows
unhashed addresses and registers that aren't comparable to the hashed
values.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fscache/cookie.c               |   29 ++++++---
 fs/fscache/fsdef.c                |    1 
 fs/fscache/object-list.c          |   14 ++--
 include/linux/fscache.h           |    1 
 include/trace/events/cachefiles.h |   68 +++++++++++-----------
 include/trace/events/fscache.h    |  116 +++++++++++++++++++------------------
 6 files changed, 121 insertions(+), 108 deletions(-)

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 751bc5b1cddf..f2be98d2c64d 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -29,21 +29,29 @@ static int fscache_attach_object(struct fscache_cookie *cookie,
 
 static void fscache_print_cookie(struct fscache_cookie *cookie, char prefix)
 {
-	struct hlist_node *object;
+	struct fscache_object *object;
+	struct hlist_node *o;
 	const u8 *k;
 	unsigned loop;
 
-	pr_err("%c-cookie c=%p [p=%p fl=%lx nc=%u na=%u]\n",
-	       prefix, cookie, cookie->parent, cookie->flags,
+	pr_err("%c-cookie c=%08x [p=%08x fl=%lx nc=%u na=%u]\n",
+	       prefix,
+	       cookie->debug_id,
+	       cookie->parent ? cookie->parent->debug_id : 0,
+	       cookie->flags,
 	       atomic_read(&cookie->n_children),
 	       atomic_read(&cookie->n_active));
-	pr_err("%c-cookie d=%p n=%p\n",
-	       prefix, cookie->def, cookie->netfs_data);
+	pr_err("%c-cookie d=%p{%s} n=%p\n",
+	       prefix,
+	       cookie->def,
+	       cookie->def ? cookie->def->name : "?",
+	       cookie->netfs_data);
 
-	object = READ_ONCE(cookie->backing_objects.first);
-	if (object)
-		pr_err("%c-cookie o=%p\n",
-		       prefix, hlist_entry(object, struct fscache_object, cookie_link));
+	o = READ_ONCE(cookie->backing_objects.first);
+	if (o) {
+		object = hlist_entry(o, struct fscache_object, cookie_link);
+		pr_err("%c-cookie o=%u\n", prefix, object->debug_id);
+	}
 
 	pr_err("%c-key=[%u] '", prefix, cookie->key_len);
 	k = (cookie->key_len <= sizeof(cookie->inline_key)) ?
@@ -129,6 +137,8 @@ static long fscache_compare_cookie(const struct fscache_cookie *a,
 	return memcmp(ka, kb, a->key_len);
 }
 
+static atomic_t fscache_cookie_debug_id = ATOMIC_INIT(1);
+
 /*
  * Allocate a cookie.
  */
@@ -163,6 +173,7 @@ struct fscache_cookie *fscache_alloc_cookie(
 
 	atomic_set(&cookie->usage, 1);
 	atomic_set(&cookie->n_children, 0);
+	cookie->debug_id = atomic_inc_return(&fscache_cookie_debug_id);
 
 	/* We keep the active count elevated until relinquishment to prevent an
 	 * attempt to wake up every time the object operations queue quiesces.
diff --git a/fs/fscache/fsdef.c b/fs/fscache/fsdef.c
index 09ed8795ad86..5f8f6fe243fe 100644
--- a/fs/fscache/fsdef.c
+++ b/fs/fscache/fsdef.c
@@ -45,6 +45,7 @@ static struct fscache_cookie_def fscache_fsdef_index_def = {
 };
 
 struct fscache_cookie fscache_fsdef_index = {
+	.debug_id	= 1,
 	.usage		= ATOMIC_INIT(1),
 	.n_active	= ATOMIC_INIT(1),
 	.lock		= __SPIN_LOCK_UNLOCKED(fscache_fsdef_index.lock),
diff --git a/fs/fscache/object-list.c b/fs/fscache/object-list.c
index e106a1a1600d..1a0dc32c0a33 100644
--- a/fs/fscache/object-list.c
+++ b/fs/fscache/object-list.c
@@ -170,7 +170,7 @@ static int fscache_objlist_show(struct seq_file *m, void *v)
 	if ((unsigned long) v == 1) {
 		seq_puts(m, "OBJECT   PARENT   STAT CHLDN OPS OOP IPR EX READS"
 			 " EM EV FL S"
-			 " | NETFS_COOKIE_DEF TY FL NETFS_DATA");
+			 " | COOKIE   NETFS_COOKIE_DEF TY FL NETFS_DATA");
 		if (config & (FSCACHE_OBJLIST_CONFIG_KEY |
 			      FSCACHE_OBJLIST_CONFIG_AUX))
 			seq_puts(m, "       ");
@@ -189,7 +189,7 @@ static int fscache_objlist_show(struct seq_file *m, void *v)
 	if ((unsigned long) v == 2) {
 		seq_puts(m, "======== ======== ==== ===== === === === == ====="
 			 " == == == ="
-			 " | ================ == == ================");
+			 " | ======== ================ == === ================");
 		if (config & (FSCACHE_OBJLIST_CONFIG_KEY |
 			      FSCACHE_OBJLIST_CONFIG_AUX))
 			seq_puts(m, " ================");
@@ -231,9 +231,9 @@ static int fscache_objlist_show(struct seq_file *m, void *v)
 	}
 
 	seq_printf(m,
-		   "%8x %8x %s %5u %3u %3u %3u %2u %5u %2lx %2lx %2lx %1x | ",
+		   "%08x %08x %s %5u %3u %3u %3u %2u %5u %2lx %2lx %2lx %1x | ",
 		   obj->debug_id,
-		   obj->parent ? obj->parent->debug_id : -1,
+		   obj->parent ? obj->parent->debug_id : UINT_MAX,
 		   obj->state->short_name,
 		   obj->n_children,
 		   obj->n_ops,
@@ -246,7 +246,7 @@ static int fscache_objlist_show(struct seq_file *m, void *v)
 		   obj->flags,
 		   work_busy(&obj->work));
 
-	if (fscache_use_cookie(obj)) {
+	if (obj->cookie) {
 		uint16_t keylen = 0, auxlen = 0;
 
 		switch (cookie->type) {
@@ -263,7 +263,8 @@ static int fscache_objlist_show(struct seq_file *m, void *v)
 			break;
 		}
 
-		seq_printf(m, "%-16s %s %2lx %16p",
+		seq_printf(m, "%08x %-16s %s %3lx %16p",
+			   cookie->debug_id,
 			   cookie->def->name,
 			   type,
 			   cookie->flags,
@@ -292,7 +293,6 @@ static int fscache_objlist_show(struct seq_file *m, void *v)
 		}
 
 		seq_puts(m, "\n");
-		fscache_unuse_cookie(obj);
 	} else {
 		seq_puts(m, "<no_netfs>\n");
 	}
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index a1c928fe98e7..f31df9a075f6 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -134,6 +134,7 @@ struct fscache_cookie {
 	atomic_t			usage;		/* number of users of this cookie */
 	atomic_t			n_children;	/* number of children of this cookie */
 	atomic_t			n_active;	/* number of active users of netfs ptrs */
+	unsigned int			debug_id;
 	spinlock_t			lock;
 	spinlock_t			stores_lock;	/* lock on page store tree */
 	struct hlist_head		backing_objects; /* object(s) backing this file/index */
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index 5d9de24cb9c0..9a448fe9355d 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -78,20 +78,20 @@ TRACE_EVENT(cachefiles_ref,
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
-		    __field(struct cachefiles_object *,		obj		)
-		    __field(struct fscache_cookie *,		cookie		)
+		    __field(unsigned int,			obj		)
+		    __field(unsigned int,			cookie		)
 		    __field(enum cachefiles_obj_ref_trace,	why		)
 		    __field(int,				usage		)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->obj	= obj;
-		    __entry->cookie	= cookie;
+		    __entry->obj	= obj->fscache.debug_id;
+		    __entry->cookie	= cookie->debug_id;
 		    __entry->usage	= usage;
 		    __entry->why	= why;
 			   ),
 
-	    TP_printk("c=%p o=%p u=%d %s",
+	    TP_printk("c=%08x o=%08x u=%d %s",
 		      __entry->cookie, __entry->obj, __entry->usage,
 		      __print_symbolic(__entry->why, cachefiles_obj_ref_traces))
 	    );
@@ -104,18 +104,18 @@ TRACE_EVENT(cachefiles_lookup,
 	    TP_ARGS(obj, de, inode),
 
 	    TP_STRUCT__entry(
-		    __field(struct cachefiles_object *,	obj	)
+		    __field(unsigned int,		obj	)
 		    __field(struct dentry *,		de	)
 		    __field(struct inode *,		inode	)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->obj	= obj;
+		    __entry->obj	= obj->fscache.debug_id;
 		    __entry->de		= de;
 		    __entry->inode	= inode;
 			   ),
 
-	    TP_printk("o=%p d=%p i=%p",
+	    TP_printk("o=%08x d=%p i=%p",
 		      __entry->obj, __entry->de, __entry->inode)
 	    );
 
@@ -126,18 +126,18 @@ TRACE_EVENT(cachefiles_mkdir,
 	    TP_ARGS(obj, de, ret),
 
 	    TP_STRUCT__entry(
-		    __field(struct cachefiles_object *,	obj	)
+		    __field(unsigned int,		obj	)
 		    __field(struct dentry *,		de	)
 		    __field(int,			ret	)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->obj	= obj;
+		    __entry->obj	= obj->fscache.debug_id;
 		    __entry->de		= de;
 		    __entry->ret	= ret;
 			   ),
 
-	    TP_printk("o=%p d=%p r=%u",
+	    TP_printk("o=%08x d=%p r=%u",
 		      __entry->obj, __entry->de, __entry->ret)
 	    );
 
@@ -148,18 +148,18 @@ TRACE_EVENT(cachefiles_create,
 	    TP_ARGS(obj, de, ret),
 
 	    TP_STRUCT__entry(
-		    __field(struct cachefiles_object *,	obj	)
+		    __field(unsigned int,		obj	)
 		    __field(struct dentry *,		de	)
 		    __field(int,			ret	)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->obj	= obj;
+		    __entry->obj	= obj->fscache.debug_id;
 		    __entry->de		= de;
 		    __entry->ret	= ret;
 			   ),
 
-	    TP_printk("o=%p d=%p r=%u",
+	    TP_printk("o=%08x d=%p r=%u",
 		      __entry->obj, __entry->de, __entry->ret)
 	    );
 
@@ -172,18 +172,18 @@ TRACE_EVENT(cachefiles_unlink,
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
-		    __field(struct cachefiles_object *,	obj		)
+		    __field(unsigned int,		obj		)
 		    __field(struct dentry *,		de		)
 		    __field(enum fscache_why_object_killed, why		)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->obj	= obj;
+		    __entry->obj	= obj->fscache.debug_id;
 		    __entry->de		= de;
 		    __entry->why	= why;
 			   ),
 
-	    TP_printk("o=%p d=%p w=%s",
+	    TP_printk("o=%08x d=%p w=%s",
 		      __entry->obj, __entry->de,
 		      __print_symbolic(__entry->why, cachefiles_obj_kill_traces))
 	    );
@@ -198,20 +198,20 @@ TRACE_EVENT(cachefiles_rename,
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
-		    __field(struct cachefiles_object *,	obj		)
+		    __field(unsigned int,		obj		)
 		    __field(struct dentry *,		de		)
 		    __field(struct dentry *,		to		)
 		    __field(enum fscache_why_object_killed, why		)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->obj	= obj;
+		    __entry->obj	= obj->fscache.debug_id;
 		    __entry->de		= de;
 		    __entry->to		= to;
 		    __entry->why	= why;
 			   ),
 
-	    TP_printk("o=%p d=%p t=%p w=%s",
+	    TP_printk("o=%08x d=%p t=%p w=%s",
 		      __entry->obj, __entry->de, __entry->to,
 		      __print_symbolic(__entry->why, cachefiles_obj_kill_traces))
 	    );
@@ -224,16 +224,16 @@ TRACE_EVENT(cachefiles_mark_active,
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
-		    __field(struct cachefiles_object *,	obj		)
+		    __field(unsigned int,		obj		)
 		    __field(struct dentry *,		de		)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->obj	= obj;
+		    __entry->obj	= obj->fscache.debug_id;
 		    __entry->de		= de;
 			   ),
 
-	    TP_printk("o=%p d=%p",
+	    TP_printk("o=%08x d=%p",
 		      __entry->obj, __entry->de)
 	    );
 
@@ -246,22 +246,22 @@ TRACE_EVENT(cachefiles_wait_active,
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
-		    __field(struct cachefiles_object *,	obj		)
+		    __field(unsigned int,		obj		)
+		    __field(unsigned int,		xobj		)
 		    __field(struct dentry *,		de		)
-		    __field(struct cachefiles_object *,	xobj		)
 		    __field(u16,			flags		)
 		    __field(u16,			fsc_flags	)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->obj	= obj;
+		    __entry->obj	= obj->fscache.debug_id;
 		    __entry->de		= de;
-		    __entry->xobj	= xobj;
+		    __entry->xobj	= xobj->fscache.debug_id;
 		    __entry->flags	= xobj->flags;
 		    __entry->fsc_flags	= xobj->fscache.flags;
 			   ),
 
-	    TP_printk("o=%p d=%p wo=%p wf=%x wff=%x",
+	    TP_printk("o=%08x d=%p wo=%08x wf=%x wff=%x",
 		      __entry->obj, __entry->de, __entry->xobj,
 		      __entry->flags, __entry->fsc_flags)
 	    );
@@ -275,18 +275,18 @@ TRACE_EVENT(cachefiles_mark_inactive,
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
-		    __field(struct cachefiles_object *,	obj		)
+		    __field(unsigned int,		obj		)
 		    __field(struct dentry *,		de		)
 		    __field(struct inode *,		inode		)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->obj	= obj;
+		    __entry->obj	= obj->fscache.debug_id;
 		    __entry->de		= de;
 		    __entry->inode	= inode;
 			   ),
 
-	    TP_printk("o=%p d=%p i=%p",
+	    TP_printk("o=%08x d=%p i=%p",
 		      __entry->obj, __entry->de, __entry->inode)
 	    );
 
@@ -299,18 +299,18 @@ TRACE_EVENT(cachefiles_mark_buried,
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
-		    __field(struct cachefiles_object *,	obj		)
+		    __field(unsigned int,		obj		)
 		    __field(struct dentry *,		de		)
 		    __field(enum fscache_why_object_killed, why		)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->obj	= obj;
+		    __entry->obj	= obj->fscache.debug_id;
 		    __entry->de		= de;
 		    __entry->why	= why;
 			   ),
 
-	    TP_printk("o=%p d=%p w=%s",
+	    TP_printk("o=%08x d=%p w=%s",
 		      __entry->obj, __entry->de,
 		      __print_symbolic(__entry->why, cachefiles_obj_kill_traces))
 	    );
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index d16fe6ed78a2..0b9e058aba4d 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -167,8 +167,8 @@ TRACE_EVENT(fscache_cookie,
 	    TP_ARGS(cookie, where, usage),
 
 	    TP_STRUCT__entry(
-		    __field(struct fscache_cookie *,	cookie		)
-		    __field(struct fscache_cookie *,	parent		)
+		    __field(unsigned int,		cookie		)
+		    __field(unsigned int,		parent		)
 		    __field(enum fscache_cookie_trace,	where		)
 		    __field(int,			usage		)
 		    __field(int,			n_children	)
@@ -177,8 +177,8 @@ TRACE_EVENT(fscache_cookie,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->cookie	= cookie;
-		    __entry->parent	= cookie->parent;
+		    __entry->cookie	= cookie->debug_id;
+		    __entry->parent	= cookie->parent ? cookie->parent->debug_id : 0;
 		    __entry->where	= where;
 		    __entry->usage	= usage;
 		    __entry->n_children	= atomic_read(&cookie->n_children);
@@ -186,7 +186,7 @@ TRACE_EVENT(fscache_cookie,
 		    __entry->flags	= cookie->flags;
 			   ),
 
-	    TP_printk("%s c=%p u=%d p=%p Nc=%d Na=%d f=%02x",
+	    TP_printk("%s c=%08x u=%d p=%08x Nc=%d Na=%d f=%02x",
 		      __print_symbolic(__entry->where, fscache_cookie_traces),
 		      __entry->cookie, __entry->usage,
 		      __entry->parent, __entry->n_children, __entry->n_active,
@@ -199,17 +199,17 @@ TRACE_EVENT(fscache_netfs,
 	    TP_ARGS(netfs),
 
 	    TP_STRUCT__entry(
-		    __field(struct fscache_cookie *,	cookie		)
+		    __field(unsigned int,		cookie		)
 		    __array(char,			name, 8		)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->cookie		= netfs->primary_index;
+		    __entry->cookie		= netfs->primary_index->debug_id;
 		    strncpy(__entry->name, netfs->name, 8);
 		    __entry->name[7]		= 0;
 			   ),
 
-	    TP_printk("c=%p n=%s",
+	    TP_printk("c=%08x n=%s",
 		      __entry->cookie, __entry->name)
 	    );
 
@@ -219,8 +219,8 @@ TRACE_EVENT(fscache_acquire,
 	    TP_ARGS(cookie),
 
 	    TP_STRUCT__entry(
-		    __field(struct fscache_cookie *,	cookie		)
-		    __field(struct fscache_cookie *,	parent		)
+		    __field(unsigned int,		cookie		)
+		    __field(unsigned int,		parent		)
 		    __array(char,			name, 8		)
 		    __field(int,			p_usage		)
 		    __field(int,			p_n_children	)
@@ -228,8 +228,8 @@ TRACE_EVENT(fscache_acquire,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->cookie		= cookie;
-		    __entry->parent		= cookie->parent;
+		    __entry->cookie		= cookie->debug_id;
+		    __entry->parent		= cookie->parent->debug_id;
 		    __entry->p_usage		= atomic_read(&cookie->parent->usage);
 		    __entry->p_n_children	= atomic_read(&cookie->parent->n_children);
 		    __entry->p_flags		= cookie->parent->flags;
@@ -237,7 +237,7 @@ TRACE_EVENT(fscache_acquire,
 		    __entry->name[7]		= 0;
 			   ),
 
-	    TP_printk("c=%p p=%p pu=%d pc=%d pf=%02x n=%s",
+	    TP_printk("c=%08x p=%08x pu=%d pc=%d pf=%02x n=%s",
 		      __entry->cookie, __entry->parent, __entry->p_usage,
 		      __entry->p_n_children, __entry->p_flags, __entry->name)
 	    );
@@ -248,8 +248,8 @@ TRACE_EVENT(fscache_relinquish,
 	    TP_ARGS(cookie, retire),
 
 	    TP_STRUCT__entry(
-		    __field(struct fscache_cookie *,	cookie		)
-		    __field(struct fscache_cookie *,	parent		)
+		    __field(unsigned int,		cookie		)
+		    __field(unsigned int,		parent		)
 		    __field(int,			usage		)
 		    __field(int,			n_children	)
 		    __field(int,			n_active	)
@@ -258,8 +258,8 @@ TRACE_EVENT(fscache_relinquish,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->cookie	= cookie;
-		    __entry->parent	= cookie->parent;
+		    __entry->cookie	= cookie->debug_id;
+		    __entry->parent	= cookie->parent->debug_id;
 		    __entry->usage	= atomic_read(&cookie->usage);
 		    __entry->n_children	= atomic_read(&cookie->n_children);
 		    __entry->n_active	= atomic_read(&cookie->n_active);
@@ -267,7 +267,7 @@ TRACE_EVENT(fscache_relinquish,
 		    __entry->retire	= retire;
 			   ),
 
-	    TP_printk("c=%p u=%d p=%p Nc=%d Na=%d f=%02x r=%u",
+	    TP_printk("c=%08x u=%d p=%08x Nc=%d Na=%d f=%02x r=%u",
 		      __entry->cookie, __entry->usage,
 		      __entry->parent, __entry->n_children, __entry->n_active,
 		      __entry->flags, __entry->retire)
@@ -279,7 +279,7 @@ TRACE_EVENT(fscache_enable,
 	    TP_ARGS(cookie),
 
 	    TP_STRUCT__entry(
-		    __field(struct fscache_cookie *,	cookie		)
+		    __field(unsigned int,		cookie		)
 		    __field(int,			usage		)
 		    __field(int,			n_children	)
 		    __field(int,			n_active	)
@@ -287,14 +287,14 @@ TRACE_EVENT(fscache_enable,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->cookie	= cookie;
+		    __entry->cookie	= cookie->debug_id;
 		    __entry->usage	= atomic_read(&cookie->usage);
 		    __entry->n_children	= atomic_read(&cookie->n_children);
 		    __entry->n_active	= atomic_read(&cookie->n_active);
 		    __entry->flags	= cookie->flags;
 			   ),
 
-	    TP_printk("c=%p u=%d Nc=%d Na=%d f=%02x",
+	    TP_printk("c=%08x u=%d Nc=%d Na=%d f=%02x",
 		      __entry->cookie, __entry->usage,
 		      __entry->n_children, __entry->n_active, __entry->flags)
 	    );
@@ -305,7 +305,7 @@ TRACE_EVENT(fscache_disable,
 	    TP_ARGS(cookie),
 
 	    TP_STRUCT__entry(
-		    __field(struct fscache_cookie *,	cookie		)
+		    __field(unsigned int,		cookie		)
 		    __field(int,			usage		)
 		    __field(int,			n_children	)
 		    __field(int,			n_active	)
@@ -313,14 +313,14 @@ TRACE_EVENT(fscache_disable,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->cookie	= cookie;
+		    __entry->cookie	= cookie->debug_id;
 		    __entry->usage	= atomic_read(&cookie->usage);
 		    __entry->n_children	= atomic_read(&cookie->n_children);
 		    __entry->n_active	= atomic_read(&cookie->n_active);
 		    __entry->flags	= cookie->flags;
 			   ),
 
-	    TP_printk("c=%p u=%d Nc=%d Na=%d f=%02x",
+	    TP_printk("c=%08x u=%d Nc=%d Na=%d f=%02x",
 		      __entry->cookie, __entry->usage,
 		      __entry->n_children, __entry->n_active, __entry->flags)
 	    );
@@ -333,8 +333,8 @@ TRACE_EVENT(fscache_osm,
 	    TP_ARGS(object, state, wait, oob, event_num),
 
 	    TP_STRUCT__entry(
-		    __field(struct fscache_cookie *,	cookie		)
-		    __field(struct fscache_object *,	object		)
+		    __field(unsigned int,		cookie		)
+		    __field(unsigned int,		object		)
 		    __array(char,			state, 8	)
 		    __field(bool,			wait		)
 		    __field(bool,			oob		)
@@ -342,15 +342,15 @@ TRACE_EVENT(fscache_osm,
 			     ),
 
 	    TP_fast_assign(
-		    __entry->cookie		= object->cookie;
-		    __entry->object		= object;
+		    __entry->cookie		= object->cookie->debug_id;
+		    __entry->object		= object->debug_id;
 		    __entry->wait		= wait;
 		    __entry->oob		= oob;
 		    __entry->event_num		= event_num;
 		    memcpy(__entry->state, state->short_name, 8);
 			   ),
 
-	    TP_printk("c=%p o=%p %s %s%sev=%d",
+	    TP_printk("c=%08x o=%08d %s %s%sev=%d",
 		      __entry->cookie,
 		      __entry->object,
 		      __entry->state,
@@ -370,18 +370,18 @@ TRACE_EVENT(fscache_page,
 	    TP_ARGS(cookie, page, why),
 
 	    TP_STRUCT__entry(
-		    __field(struct fscache_cookie *,	cookie		)
+		    __field(unsigned int,		cookie		)
 		    __field(pgoff_t,			page		)
 		    __field(enum fscache_page_trace,	why		)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->cookie		= cookie;
+		    __entry->cookie		= cookie->debug_id;
 		    __entry->page		= page->index;
 		    __entry->why		= why;
 			   ),
 
-	    TP_printk("c=%p %s pg=%lx",
+	    TP_printk("c=%08x %s pg=%lx",
 		      __entry->cookie,
 		      __print_symbolic(__entry->why, fscache_page_traces),
 		      __entry->page)
@@ -394,20 +394,20 @@ TRACE_EVENT(fscache_check_page,
 	    TP_ARGS(cookie, page, val, n),
 
 	    TP_STRUCT__entry(
-		    __field(struct fscache_cookie *,	cookie		)
+		    __field(unsigned int,		cookie		)
 		    __field(void *,			page		)
 		    __field(void *,			val		)
 		    __field(int,			n		)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->cookie		= cookie;
+		    __entry->cookie		= cookie->debug_id;
 		    __entry->page		= page;
 		    __entry->val		= val;
 		    __entry->n			= n;
 			   ),
 
-	    TP_printk("c=%p pg=%p val=%p n=%d",
+	    TP_printk("c=%08x pg=%p val=%p n=%d",
 		      __entry->cookie, __entry->page, __entry->val, __entry->n)
 	    );
 
@@ -417,14 +417,14 @@ TRACE_EVENT(fscache_wake_cookie,
 	    TP_ARGS(cookie),
 
 	    TP_STRUCT__entry(
-		    __field(struct fscache_cookie *,	cookie		)
+		    __field(unsigned int,		cookie		)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->cookie		= cookie;
+		    __entry->cookie		= cookie->debug_id;
 			   ),
 
-	    TP_printk("c=%p", __entry->cookie)
+	    TP_printk("c=%08x", __entry->cookie)
 	    );
 
 TRACE_EVENT(fscache_op,
@@ -434,18 +434,18 @@ TRACE_EVENT(fscache_op,
 	    TP_ARGS(cookie, op, why),
 
 	    TP_STRUCT__entry(
-		    __field(struct fscache_cookie *,	cookie		)
-		    __field(struct fscache_operation *,	op		)
+		    __field(unsigned int,		cookie		)
+		    __field(unsigned int,		op		)
 		    __field(enum fscache_op_trace,	why		)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->cookie		= cookie;
-		    __entry->op			= op;
+		    __entry->cookie		= cookie->debug_id;
+		    __entry->op			= op->debug_id;
 		    __entry->why		= why;
 			   ),
 
-	    TP_printk("c=%p op=%p %s",
+	    TP_printk("c=%08x op=%08x %s",
 		      __entry->cookie, __entry->op,
 		      __print_symbolic(__entry->why, fscache_op_traces))
 	    );
@@ -457,20 +457,20 @@ TRACE_EVENT(fscache_page_op,
 	    TP_ARGS(cookie, page, op, what),
 
 	    TP_STRUCT__entry(
-		    __field(struct fscache_cookie *,	cookie		)
+		    __field(unsigned int,		cookie		)
+		    __field(unsigned int,		op		)
 		    __field(pgoff_t,			page		)
-		    __field(struct fscache_operation *,	op		)
 		    __field(enum fscache_page_op_trace,	what		)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->cookie		= cookie;
+		    __entry->cookie		= cookie->debug_id;
 		    __entry->page		= page ? page->index : 0;
-		    __entry->op			= op;
+		    __entry->op			= op->debug_id;
 		    __entry->what		= what;
 			   ),
 
-	    TP_printk("c=%p %s pg=%lx op=%p",
+	    TP_printk("c=%08x %s pg=%lx op=%08x",
 		      __entry->cookie,
 		      __print_symbolic(__entry->what, fscache_page_op_traces),
 		      __entry->page, __entry->op)
@@ -483,20 +483,20 @@ TRACE_EVENT(fscache_wrote_page,
 	    TP_ARGS(cookie, page, op, ret),
 
 	    TP_STRUCT__entry(
-		    __field(struct fscache_cookie *,	cookie		)
+		    __field(unsigned int,		cookie		)
+		    __field(unsigned int,		op		)
 		    __field(pgoff_t,			page		)
-		    __field(struct fscache_operation *,	op		)
 		    __field(int,			ret		)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->cookie		= cookie;
+		    __entry->cookie		= cookie->debug_id;
 		    __entry->page		= page->index;
-		    __entry->op			= op;
+		    __entry->op			= op->debug_id;
 		    __entry->ret		= ret;
 			   ),
 
-	    TP_printk("c=%p pg=%lx op=%p ret=%d",
+	    TP_printk("c=%08x pg=%lx op=%08x ret=%d",
 		      __entry->cookie, __entry->page, __entry->op, __entry->ret)
 	    );
 
@@ -507,22 +507,22 @@ TRACE_EVENT(fscache_gang_lookup,
 	    TP_ARGS(cookie, op, results, n, store_limit),
 
 	    TP_STRUCT__entry(
-		    __field(struct fscache_cookie *,	cookie		)
-		    __field(struct fscache_operation *,	op		)
+		    __field(unsigned int,		cookie		)
+		    __field(unsigned int,		op		)
 		    __field(pgoff_t,			results0	)
 		    __field(int,			n		)
 		    __field(pgoff_t,			store_limit	)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->cookie		= cookie;
-		    __entry->op			= op;
+		    __entry->cookie		= cookie->debug_id;
+		    __entry->op			= op->debug_id;
 		    __entry->results0		= results[0] ? ((struct page *)results[0])->index : (pgoff_t)-1;
 		    __entry->n			= n;
 		    __entry->store_limit	= store_limit;
 			   ),
 
-	    TP_printk("c=%p op=%p r0=%lx n=%d sl=%lx",
+	    TP_printk("c=%08x op=%08x r0=%lx n=%d sl=%lx",
 		      __entry->cookie, __entry->op, __entry->results0, __entry->n,
 		      __entry->store_limit)
 	    );


