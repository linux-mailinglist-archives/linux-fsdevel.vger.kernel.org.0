Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D809B4927AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 14:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244053AbiARNyP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 08:54:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51688 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243652AbiARNyH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:54:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642514046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+py/gRGrREoMG+NM+Uf9rJAEg0pDCMyCGnd93uOAb1I=;
        b=CUnQavjghuTNvqSJcS5wTv/D86NoCZ2CbOkvZoXw0yOzcCRWa8Z233AGOacxMA6kLE4ZzY
        /JCHUA0eimABpZgZ0gKiT/wDpgkmq+5nk0NP+Rz0YO3Cu14MonI+Fh4lIo0GKGKjhF5F9P
        qFYsZvNLQYY2LsJgKmixNKaqlAQ8408=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-258-47CvRf9qPZSy91azXS3j6Q-1; Tue, 18 Jan 2022 08:54:03 -0500
X-MC-Unique: 47CvRf9qPZSy91azXS3j6Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A4111018723;
        Tue, 18 Jan 2022 13:54:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFC1C78ABA;
        Tue, 18 Jan 2022 13:53:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 04/11] cachefiles: Make some tracepoint adjustments
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <smfrench@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 18 Jan 2022 13:53:56 +0000
Message-ID: <164251403694.3435901.9797725381831316715.stgit@warthog.procyon.org.uk>
In-Reply-To: <164251396932.3435901.344517748027321142.stgit@warthog.procyon.org.uk>
References: <164251396932.3435901.344517748027321142.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make some adjustments to tracepoints to make the tracing a bit more
followable:

 (1) Standardise on displaying the backing inode number as "B=<hex>" with
     no leading zeros.

 (2) Make the cachefiles_lookup tracepoint log the directory inode number
     as well as the looked-up inode number.

 (3) Add a cachefiles_lookup tracepoint into cachefiles_get_directory() to
     log directory lookup.

 (4) Add a new cachefiles_mkdir tracepoint and use that to log a successful
     mkdir from cachefiles_get_directory().

 (5) Make the cachefiles_unlink and cachefiles_rename tracepoints log the
     inode number of the affected file/dir rather than dentry struct
     pointers.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/cachefiles/namei.c             |    8 ++--
 include/trace/events/cachefiles.h |   82 +++++++++++++++++++++++--------------
 2 files changed, 56 insertions(+), 34 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 9bd692870617..52c9f0864a87 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -101,6 +101,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 		subdir = lookup_one_len(dirname, dir, strlen(dirname));
 	else
 		subdir = ERR_PTR(ret);
+	trace_cachefiles_lookup(NULL, dir, subdir);
 	if (IS_ERR(subdir)) {
 		trace_cachefiles_vfs_error(NULL, d_backing_inode(dir),
 					   PTR_ERR(subdir),
@@ -135,6 +136,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 						   cachefiles_trace_mkdir_error);
 			goto mkdir_error;
 		}
+		trace_cachefiles_mkdir(dir, subdir);
 
 		if (unlikely(d_unhashed(subdir))) {
 			cachefiles_put_directory(subdir);
@@ -233,7 +235,7 @@ static int cachefiles_unlink(struct cachefiles_cache *cache,
 	};
 	int ret;
 
-	trace_cachefiles_unlink(object, dentry, why);
+	trace_cachefiles_unlink(object, d_inode(dentry)->i_ino, why);
 	ret = security_path_unlink(&path, dentry);
 	if (ret < 0) {
 		cachefiles_io_error(cache, "Unlink security error");
@@ -386,7 +388,7 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 			.new_dir	= d_inode(cache->graveyard),
 			.new_dentry	= grave,
 		};
-		trace_cachefiles_rename(object, rep, grave, why);
+		trace_cachefiles_rename(object, d_inode(rep)->i_ino, why);
 		ret = cachefiles_inject_read_error();
 		if (ret == 0)
 			ret = vfs_rename(&rd);
@@ -617,7 +619,7 @@ bool cachefiles_look_up_object(struct cachefiles_object *object)
 						  object->d_name_len);
 	else
 		dentry = ERR_PTR(ret);
-	trace_cachefiles_lookup(object, dentry);
+	trace_cachefiles_lookup(object, fan, dentry);
 	if (IS_ERR(dentry)) {
 		if (dentry == ERR_PTR(-ENOENT))
 			goto new_file;
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index 1172529b5b49..093c4acb7a3a 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -233,25 +233,48 @@ TRACE_EVENT(cachefiles_ref,
 
 TRACE_EVENT(cachefiles_lookup,
 	    TP_PROTO(struct cachefiles_object *obj,
+		     struct dentry *dir,
 		     struct dentry *de),
 
-	    TP_ARGS(obj, de),
+	    TP_ARGS(obj, dir, de),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		obj	)
 		    __field(short,			error	)
+		    __field(unsigned long,		dino	)
 		    __field(unsigned long,		ino	)
 			     ),
 
 	    TP_fast_assign(
-		    __entry->obj	= obj->debug_id;
+		    __entry->obj	= obj ? obj->debug_id : 0;
+		    __entry->dino	= d_backing_inode(dir)->i_ino;
 		    __entry->ino	= (!IS_ERR(de) && d_backing_inode(de) ?
 					   d_backing_inode(de)->i_ino : 0);
 		    __entry->error	= IS_ERR(de) ? PTR_ERR(de) : 0;
 			   ),
 
-	    TP_printk("o=%08x i=%lx e=%d",
-		      __entry->obj, __entry->ino, __entry->error)
+	    TP_printk("o=%08x dB=%lx B=%lx e=%d",
+		      __entry->obj, __entry->dino, __entry->ino, __entry->error)
+	    );
+
+TRACE_EVENT(cachefiles_mkdir,
+	    TP_PROTO(struct dentry *dir, struct dentry *subdir),
+
+	    TP_ARGS(dir, subdir),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			dir	)
+		    __field(unsigned int,			subdir	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->dir	= d_backing_inode(dir)->i_ino;
+		    __entry->subdir	= d_backing_inode(subdir)->i_ino;
+			   ),
+
+	    TP_printk("dB=%x sB=%x",
+		      __entry->dir,
+		      __entry->subdir)
 	    );
 
 TRACE_EVENT(cachefiles_tmpfile,
@@ -269,7 +292,7 @@ TRACE_EVENT(cachefiles_tmpfile,
 		    __entry->backer	= backer->i_ino;
 			   ),
 
-	    TP_printk("o=%08x b=%08x",
+	    TP_printk("o=%08x B=%x",
 		      __entry->obj,
 		      __entry->backer)
 	    );
@@ -289,61 +312,58 @@ TRACE_EVENT(cachefiles_link,
 		    __entry->backer	= backer->i_ino;
 			   ),
 
-	    TP_printk("o=%08x b=%08x",
+	    TP_printk("o=%08x B=%x",
 		      __entry->obj,
 		      __entry->backer)
 	    );
 
 TRACE_EVENT(cachefiles_unlink,
 	    TP_PROTO(struct cachefiles_object *obj,
-		     struct dentry *de,
+		     ino_t ino,
 		     enum fscache_why_object_killed why),
 
-	    TP_ARGS(obj, de, why),
+	    TP_ARGS(obj, ino, why),
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		obj		)
-		    __field(struct dentry *,		de		)
+		    __field(unsigned int,		ino		)
 		    __field(enum fscache_why_object_killed, why		)
 			     ),
 
 	    TP_fast_assign(
 		    __entry->obj	= obj ? obj->debug_id : UINT_MAX;
-		    __entry->de		= de;
+		    __entry->ino	= ino;
 		    __entry->why	= why;
 			   ),
 
-	    TP_printk("o=%08x d=%p w=%s",
-		      __entry->obj, __entry->de,
+	    TP_printk("o=%08x B=%x w=%s",
+		      __entry->obj, __entry->ino,
 		      __print_symbolic(__entry->why, cachefiles_obj_kill_traces))
 	    );
 
 TRACE_EVENT(cachefiles_rename,
 	    TP_PROTO(struct cachefiles_object *obj,
-		     struct dentry *de,
-		     struct dentry *to,
+		     ino_t ino,
 		     enum fscache_why_object_killed why),
 
-	    TP_ARGS(obj, de, to, why),
+	    TP_ARGS(obj, ino, why),
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		obj		)
-		    __field(struct dentry *,		de		)
-		    __field(struct dentry *,		to		)
+		    __field(unsigned int,		ino		)
 		    __field(enum fscache_why_object_killed, why		)
 			     ),
 
 	    TP_fast_assign(
 		    __entry->obj	= obj ? obj->debug_id : UINT_MAX;
-		    __entry->de		= de;
-		    __entry->to		= to;
+		    __entry->ino	= ino;
 		    __entry->why	= why;
 			   ),
 
-	    TP_printk("o=%08x d=%p t=%p w=%s",
-		      __entry->obj, __entry->de, __entry->to,
+	    TP_printk("o=%08x B=%x w=%s",
+		      __entry->obj, __entry->ino,
 		      __print_symbolic(__entry->why, cachefiles_obj_kill_traces))
 	    );
 
@@ -370,7 +390,7 @@ TRACE_EVENT(cachefiles_coherency,
 		    __entry->ino	= ino;
 			   ),
 
-	    TP_printk("o=%08x %s i=%llx c=%u",
+	    TP_printk("o=%08x %s B=%llx c=%u",
 		      __entry->obj,
 		      __print_symbolic(__entry->why, cachefiles_coherency_traces),
 		      __entry->ino,
@@ -397,7 +417,7 @@ TRACE_EVENT(cachefiles_vol_coherency,
 		    __entry->ino	= ino;
 			   ),
 
-	    TP_printk("V=%08x %s i=%llx",
+	    TP_printk("V=%08x %s B=%llx",
 		      __entry->vol,
 		      __print_symbolic(__entry->why, cachefiles_coherency_traces),
 		      __entry->ino)
@@ -435,7 +455,7 @@ TRACE_EVENT(cachefiles_prep_read,
 		    __entry->cache_inode = cache_inode;
 			   ),
 
-	    TP_printk("R=%08x[%u] %s %s f=%02x s=%llx %zx ni=%x b=%x",
+	    TP_printk("R=%08x[%u] %s %s f=%02x s=%llx %zx ni=%x B=%x",
 		      __entry->rreq, __entry->index,
 		      __print_symbolic(__entry->source, netfs_sreq_sources),
 		      __print_symbolic(__entry->why, cachefiles_prepare_read_traces),
@@ -466,7 +486,7 @@ TRACE_EVENT(cachefiles_read,
 		    __entry->len	= len;
 			   ),
 
-	    TP_printk("o=%08x b=%08x s=%llx l=%zx",
+	    TP_printk("o=%08x B=%x s=%llx l=%zx",
 		      __entry->obj,
 		      __entry->backer,
 		      __entry->start,
@@ -495,7 +515,7 @@ TRACE_EVENT(cachefiles_write,
 		    __entry->len	= len;
 			   ),
 
-	    TP_printk("o=%08x b=%08x s=%llx l=%zx",
+	    TP_printk("o=%08x B=%x s=%llx l=%zx",
 		      __entry->obj,
 		      __entry->backer,
 		      __entry->start,
@@ -524,7 +544,7 @@ TRACE_EVENT(cachefiles_trunc,
 		    __entry->why	= why;
 			   ),
 
-	    TP_printk("o=%08x b=%08x %s l=%llx->%llx",
+	    TP_printk("o=%08x B=%x %s l=%llx->%llx",
 		      __entry->obj,
 		      __entry->backer,
 		      __print_symbolic(__entry->why, cachefiles_trunc_traces),
@@ -549,7 +569,7 @@ TRACE_EVENT(cachefiles_mark_active,
 		    __entry->inode	= inode->i_ino;
 			   ),
 
-	    TP_printk("o=%08x i=%lx",
+	    TP_printk("o=%08x B=%lx",
 		      __entry->obj, __entry->inode)
 	    );
 
@@ -570,7 +590,7 @@ TRACE_EVENT(cachefiles_mark_inactive,
 		    __entry->inode	= inode->i_ino;
 			   ),
 
-	    TP_printk("o=%08x i=%lx",
+	    TP_printk("o=%08x B=%lx",
 		      __entry->obj, __entry->inode)
 	    );
 
@@ -594,7 +614,7 @@ TRACE_EVENT(cachefiles_vfs_error,
 		    __entry->where	= where;
 			   ),
 
-	    TP_printk("o=%08x b=%08x %s e=%d",
+	    TP_printk("o=%08x B=%x %s e=%d",
 		      __entry->obj,
 		      __entry->backer,
 		      __print_symbolic(__entry->where, cachefiles_error_traces),
@@ -621,7 +641,7 @@ TRACE_EVENT(cachefiles_io_error,
 		    __entry->where	= where;
 			   ),
 
-	    TP_printk("o=%08x b=%08x %s e=%d",
+	    TP_printk("o=%08x B=%x %s e=%d",
 		      __entry->obj,
 		      __entry->backer,
 		      __print_symbolic(__entry->where, cachefiles_error_traces),


