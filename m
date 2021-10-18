Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D6D43210C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 16:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbhJRPAZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 11:00:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49124 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233213AbhJRPAQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634569084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GruXL50DosX11u6Eiitd3mjK2Wt4qFrfQfU0liRNHgw=;
        b=ezz9LvF5r5NMcQoJtpTKPRJlqP/BTK3pAHeJ0W3lFxlvs1f5RU4pJ9HxXFTpBxkbKYngDn
        AEtmFq0Fw8tmT5W62n9VbYwqhv5IccCC0NLr/LTW/68g2YoZ/v5/aXCVH3psGaJqdCOl6b
        3/WkzKe4VCWdljzsjfLzy5bm6+6LZTw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-o6RxVNI9Ph2jSiIgLDSOyw-1; Mon, 18 Oct 2021 10:58:01 -0400
X-MC-Unique: o6RxVNI9Ph2jSiIgLDSOyw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 147A510A8E06;
        Mon, 18 Oct 2021 14:57:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 08C63641AB;
        Mon, 18 Oct 2021 14:57:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 29/67] cachefiles: Trace read and write operations
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
Date:   Mon, 18 Oct 2021 15:57:52 +0100
Message-ID: <163456907226.2614702.16135532021542996215.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add tracepoints for read and write operations on cache files.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/io.c                |    6 +++-
 include/trace/events/cachefiles.h |   58 +++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 0e1fb44b5d04..f703a93e238b 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -62,6 +62,7 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 			   netfs_io_terminated_t term_func,
 			   void *term_func_priv)
 {
+	struct cachefiles_object *object = cres->cache_priv;
 	struct cachefiles_kiocb *ki;
 	struct file *file = cachefiles_cres_file(cres);
 	unsigned int old_nofs;
@@ -124,6 +125,7 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 
 	get_file(ki->iocb.ki_filp);
 
+	trace_cachefiles_read(object, file_inode(file), ki->iocb.ki_pos, len - skipped);
 	old_nofs = memalloc_nofs_save();
 	ret = vfs_iocb_iter_read(file, &ki->iocb, iter);
 	memalloc_nofs_restore(old_nofs);
@@ -188,6 +190,7 @@ static int cachefiles_write(struct netfs_cache_resources *cres,
 			    netfs_io_terminated_t term_func,
 			    void *term_func_priv)
 {
+	struct cachefiles_object *object = cres->cache_priv;
 	struct cachefiles_kiocb *ki;
 	struct inode *inode;
 	struct file *file = cachefiles_cres_file(cres);
@@ -229,6 +232,7 @@ static int cachefiles_write(struct netfs_cache_resources *cres,
 
 	get_file(ki->iocb.ki_filp);
 
+	trace_cachefiles_write(object, inode, ki->iocb.ki_pos, len);
 	old_nofs = memalloc_nofs_save();
 	ret = vfs_iocb_iter_write(file, &ki->iocb, iter);
 	memalloc_nofs_restore(old_nofs);
@@ -418,7 +422,7 @@ int cachefiles_begin_operation(struct netfs_cache_resources *cres)
 
 	_enter("");
 
-	cres->cache_priv	= op;
+	cres->cache_priv	= object;
 	cres->cache_priv2	= get_file(object->file);
 	cres->ops		= &cachefiles_netfs_cache_ops;
 	cres->debug_id		= object->cookie->debug_id;
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index 09d76c160451..47df44550ad6 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -302,6 +302,64 @@ TRACE_EVENT(cachefiles_coherency,
 		      __entry->content)
 	    );
 
+TRACE_EVENT(cachefiles_read,
+	    TP_PROTO(struct cachefiles_object *obj,
+		     struct inode *backer,
+		     loff_t start,
+		     size_t len),
+
+	    TP_ARGS(obj, backer, start, len),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			obj	)
+		    __field(unsigned int,			backer	)
+		    __field(size_t,				len	)
+		    __field(loff_t,				start	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj->debug_id;
+		    __entry->backer	= backer->i_ino;
+		    __entry->start	= start;
+		    __entry->len	= len;
+			   ),
+
+	    TP_printk("o=%08x b=%08x s=%llx l=%zx",
+		      __entry->obj,
+		      __entry->backer,
+		      __entry->start,
+		      __entry->len)
+	    );
+
+TRACE_EVENT(cachefiles_write,
+	    TP_PROTO(struct cachefiles_object *obj,
+		     struct inode *backer,
+		     loff_t start,
+		     size_t len),
+
+	    TP_ARGS(obj, backer, start, len),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			obj	)
+		    __field(unsigned int,			backer	)
+		    __field(size_t,				len	)
+		    __field(loff_t,				start	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj->debug_id;
+		    __entry->backer	= backer->i_ino;
+		    __entry->start	= start;
+		    __entry->len	= len;
+			   ),
+
+	    TP_printk("o=%08x b=%08x s=%llx l=%zx",
+		      __entry->obj,
+		      __entry->backer,
+		      __entry->start,
+		      __entry->len)
+	    );
+
 TRACE_EVENT(cachefiles_trunc,
 	    TP_PROTO(struct cachefiles_object *obj, struct inode *backer,
 		     loff_t from, loff_t to, enum cachefiles_trunc_trace why),


