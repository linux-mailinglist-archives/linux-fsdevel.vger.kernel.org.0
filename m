Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1901C41A8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 19:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbgEDRNQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 13:13:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43161 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730450AbgEDRNP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 13:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588612393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+I7+tjYkt0ap5fvLu7XtxGvLJ9Ld+6cb2lClRNagcug=;
        b=LEA9axZg25qdCFB2W+VZWF3iSdvaMRSPxuW+aG0qR0TGgzyqalZrshDkUdTunrxS/1+2Gc
        pS05jH5Rra+dlEXg/2L8IhROLvnCKivVx8uogo+eGKTpp0TwIf5tHo3HFlX7iWRSiVEuRK
        bT73R3xjfAFJjhkIyhYFPsZtHY6kV40=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-NWr7UfiaNaa-yMxFWlUiaw-1; Mon, 04 May 2020 13:13:11 -0400
X-MC-Unique: NWr7UfiaNaa-yMxFWlUiaw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2C9380B713;
        Mon,  4 May 2020 17:13:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D08770520;
        Mon,  4 May 2020 17:13:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 37/61] cachefiles: Add I/O tracepoints
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
Date:   Mon, 04 May 2020 18:13:06 +0100
Message-ID: <158861238642.340223.8962664382713166792.stgit@warthog.procyon.org.uk>
In-Reply-To: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
References: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


---

 fs/cachefiles/interface.c         |   16 +++--
 fs/cachefiles/io.c                |    2 +
 include/trace/events/cachefiles.h |  123 +++++++++++++++++++++++++++++++++++++
 3 files changed, 136 insertions(+), 5 deletions(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index aa063857272a..feff39dff0f5 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -160,7 +160,8 @@ static void cachefiles_update_object(struct fscache_object *_object)
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
 	const struct cred *saved_cred;
-	loff_t object_size;
+	struct inode *inode;
+	loff_t object_size, i_size;
 	int ret;
 
 	_enter("{OBJ%x}", _object->debug_id);
@@ -172,12 +173,15 @@ static void cachefiles_update_object(struct fscache_object *_object)
 	cachefiles_begin_secure(cache, &saved_cred);
 
 	object_size = object->fscache.cookie->object_size;
-	if (i_size_read(d_inode(object->dentry)) > object_size) {
+	inode = d_inode(object->dentry);
+	i_size = i_size_read(inode);
+	if (i_size > object_size) {
 		struct path path = {
 			.mnt	= cache->mnt,
 			.dentry	= object->dentry
 		};
-		_debug("trunc %llx -> %llx", i_size_read(d_inode(object->dentry)), object_size);
+		_debug("trunc %llx -> %llx", i_size, object_size);
+		trace_cachefiles_trunc(object, inode, i_size, object_size);
 		ret = vfs_truncate(&path, object_size);
 		if (ret < 0) {
 			cachefiles_io_error_obj(object, "Trunc-to-size failed");
@@ -186,8 +190,10 @@ static void cachefiles_update_object(struct fscache_object *_object)
 		}
 
 		object_size = round_up(object_size, CACHEFILES_DIO_BLOCK_SIZE);
-		_debug("trunc %llx -> %llx", i_size_read(d_inode(object->dentry)), object_size);
-		if (i_size_read(d_inode(object->dentry)) < object_size) {
+		i_size = i_size_read(inode);
+		_debug("trunc %llx -> %llx", i_size, object_size);
+		if (i_size < object_size) {
+			trace_cachefiles_trunc(object, inode, i_size, object_size);
 			ret = vfs_truncate(&path, object_size);
 			if (ret < 0) {
 				cachefiles_io_error_obj(object, "Trunc-to-dio-size failed");
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 42e0d620d778..268e6f69ba9c 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -88,6 +88,7 @@ int cachefiles_read(struct fscache_object *obj,
 		goto presubmission_error_free;
 
 	fscache_get_io_request(req);
+	trace_cachefiles_read(object, file_inode(file), req);
 	ret = call_read_iter(file, &ki->iocb, iter);
 	switch (ret) {
 	case -EIOCBQUEUED:
@@ -198,6 +199,7 @@ int cachefiles_write(struct fscache_object *obj,
 	__sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
 
 	fscache_get_io_request(req);
+	trace_cachefiles_write(object, inode, req);
 	ret = call_write_iter(file, &ki->iocb, iter);
 	switch (ret) {
 	case -EIOCBQUEUED:
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index e7af1d683009..d83568e8fee8 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -351,6 +351,129 @@ TRACE_EVENT(cachefiles_coherency,
 		      __entry->content)
 	    );
 
+TRACE_EVENT(cachefiles_read,
+	    TP_PROTO(struct cachefiles_object *obj,
+		     struct inode *backer,
+		     struct fscache_io_request *req),
+
+	    TP_ARGS(obj, backer, req),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			obj	)
+		    __field(unsigned int,			backer	)
+		    __field(unsigned int,			len	)
+		    __field(loff_t,				pos	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj->fscache.debug_id;
+		    __entry->backer	= backer->i_ino;
+		    __entry->pos	= req->pos;
+		    __entry->len	= req->len;
+			   ),
+
+	    TP_printk("o=%08x b=%08x p=%llx l=%x",
+		      __entry->obj,
+		      __entry->backer,
+		      __entry->pos,
+		      __entry->len)
+	    );
+
+TRACE_EVENT(cachefiles_write,
+	    TP_PROTO(struct cachefiles_object *obj,
+		     struct inode *backer,
+		     struct fscache_io_request *req),
+
+	    TP_ARGS(obj, backer, req),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			obj	)
+		    __field(unsigned int,			backer	)
+		    __field(unsigned int,			len	)
+		    __field(loff_t,				pos	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj->fscache.debug_id;
+		    __entry->backer	= backer->i_ino;
+		    __entry->pos	= req->pos;
+		    __entry->len	= req->len;
+			   ),
+
+	    TP_printk("o=%08x b=%08x p=%llx l=%x",
+		      __entry->obj,
+		      __entry->backer,
+		      __entry->pos,
+		      __entry->len)
+	    );
+
+TRACE_EVENT(cachefiles_trunc,
+	    TP_PROTO(struct cachefiles_object *obj, struct inode *backer,
+		     loff_t from, loff_t to),
+
+	    TP_ARGS(obj, backer, from, to),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			obj	)
+		    __field(unsigned int,			backer	)
+		    __field(loff_t,				from	)
+		    __field(loff_t,				to	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj->fscache.debug_id;
+		    __entry->backer	= backer->i_ino;
+		    __entry->from	= from;
+		    __entry->to		= to;
+			   ),
+
+	    TP_printk("o=%08x b=%08x l=%llx->%llx",
+		      __entry->obj,
+		      __entry->backer,
+		      __entry->from,
+		      __entry->to)
+	    );
+
+TRACE_EVENT(cachefiles_tmpfile,
+	    TP_PROTO(struct cachefiles_object *obj, struct inode *backer),
+
+	    TP_ARGS(obj, backer),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			obj	)
+		    __field(unsigned int,			backer	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj->fscache.debug_id;
+		    __entry->backer	= backer->i_ino;
+			   ),
+
+	    TP_printk("o=%08x b=%08x",
+		      __entry->obj,
+		      __entry->backer)
+	    );
+
+TRACE_EVENT(cachefiles_link,
+	    TP_PROTO(struct cachefiles_object *obj, struct inode *backer),
+
+	    TP_ARGS(obj, backer),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			obj	)
+		    __field(unsigned int,			backer	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj->fscache.debug_id;
+		    __entry->backer	= backer->i_ino;
+			   ),
+
+	    TP_printk("o=%08x b=%08x",
+		      __entry->obj,
+		      __entry->backer)
+	    );
+
 #endif /* _TRACE_CACHEFILES_H */
 
 /* This part must be outside protection */


