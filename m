Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6045F3D0FEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 15:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbhGUNFZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 09:05:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33471 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238702AbhGUNE6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 09:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626875125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l2ULAssdCvCuvxiyM6eqGFkpgO6JFY0hX9JtLUvVjhk=;
        b=SVIr604nd/jOLWcU/P+RUxMeg6x2JEI9WU9LhB+jbmud6ymBHf8ZsR2ncQZZx82Gu7NVlm
        SBRQNPCDWVOGgx7aQSzpMBW88upI2Py9msWBYTuqYi9eUVoONfRza1Z7sgDhcWxsQ5+SKo
        bFrcItALOhMgNHHd8gF/dgWAxGtVtGs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-REGEyuZqOumWlWTCvhfd0A-1; Wed, 21 Jul 2021 09:45:21 -0400
X-MC-Unique: REGEyuZqOumWlWTCvhfd0A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78771804140;
        Wed, 21 Jul 2021 13:45:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-62.rdu2.redhat.com [10.10.112.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A6E731036D14;
        Wed, 21 Jul 2021 13:45:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 03/12] netfs: Remove netfs_read_subrequest::transferred
From:   David Howells <dhowells@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Mike Marshall <hubcap@omnibond.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 21 Jul 2021 14:45:11 +0100
Message-ID: <162687511125.276387.15493860267582539643.stgit@warthog.procyon.org.uk>
In-Reply-To: <162687506932.276387.14456718890524355509.stgit@warthog.procyon.org.uk>
References: <162687506932.276387.14456718890524355509.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove netfs_read_subrequest::transferred as it's redundant as the count on
the iterator added to the subrequest can be used instead.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/file.c                |    4 ++--
 fs/netfs/read_helper.c       |   26 ++++----------------------
 include/linux/netfs.h        |    1 -
 include/trace/events/netfs.h |   12 ++++++------
 4 files changed, 12 insertions(+), 31 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index ca529f23515a..82e945dbe379 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -315,8 +315,8 @@ static void afs_req_issue_op(struct netfs_read_subrequest *subreq)
 		return netfs_subreq_terminated(subreq, -ENOMEM, false);
 
 	fsreq->subreq	= subreq;
-	fsreq->pos	= subreq->start + subreq->transferred;
-	fsreq->len	= subreq->len   - subreq->transferred;
+	fsreq->pos	= subreq->start + subreq->len - iov_iter_count(&subreq->iter);
+	fsreq->len	= iov_iter_count(&subreq->iter);
 	fsreq->key	= subreq->rreq->netfs_priv;
 	fsreq->vnode	= vnode;
 	fsreq->iter	= &subreq->iter;
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 715f3e9c380d..5e1a9be48130 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -148,12 +148,7 @@ static void __netfs_put_subrequest(struct netfs_read_subrequest *subreq,
  */
 static void netfs_clear_unread(struct netfs_read_subrequest *subreq)
 {
-	struct iov_iter iter;
-
-	iov_iter_xarray(&iter, READ, &subreq->rreq->mapping->i_pages,
-			subreq->start + subreq->transferred,
-			subreq->len   - subreq->transferred);
-	iov_iter_zero(iov_iter_count(&iter), &iter);
+	iov_iter_zero(iov_iter_count(&subreq->iter), &subreq->iter);
 }
 
 static void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error,
@@ -173,14 +168,9 @@ static void netfs_read_from_cache(struct netfs_read_request *rreq,
 				  bool seek_data)
 {
 	struct netfs_cache_resources *cres = &rreq->cache_resources;
-	struct iov_iter iter;
 
 	netfs_stat(&netfs_n_rh_read);
-	iov_iter_xarray(&iter, READ, &rreq->mapping->i_pages,
-			subreq->start + subreq->transferred,
-			subreq->len   - subreq->transferred);
-
-	cres->ops->read(cres, subreq->start, &iter, seek_data,
+	cres->ops->read(cres, subreq->start, &subreq->iter, seek_data,
 			netfs_cache_read_terminated, subreq);
 }
 
@@ -419,7 +409,7 @@ static void netfs_rreq_unlock(struct netfs_read_request *rreq)
 			if (pgend < iopos + subreq->len)
 				break;
 
-			account += subreq->transferred;
+			account += subreq->len - iov_iter_count(&subreq->iter);
 			iopos += subreq->len;
 			if (!list_is_last(&subreq->rreq_link, &rreq->subrequests)) {
 				subreq = list_next_entry(subreq, rreq_link);
@@ -635,15 +625,8 @@ void netfs_subreq_terminated(struct netfs_read_subrequest *subreq,
 		goto failed;
 	}
 
-	if (WARN(transferred_or_error > subreq->len - subreq->transferred,
-		 "Subreq overread: R%x[%x] %zd > %zu - %zu",
-		 rreq->debug_id, subreq->debug_index,
-		 transferred_or_error, subreq->len, subreq->transferred))
-		transferred_or_error = subreq->len - subreq->transferred;
-
 	subreq->error = 0;
-	subreq->transferred += transferred_or_error;
-	if (subreq->transferred < subreq->len)
+	if (iov_iter_count(&subreq->iter))
 		goto incomplete;
 
 complete:
@@ -667,7 +650,6 @@ void netfs_subreq_terminated(struct netfs_read_subrequest *subreq,
 incomplete:
 	if (test_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags)) {
 		netfs_clear_unread(subreq);
-		subreq->transferred = subreq->len;
 		goto complete;
 	}
 
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 5e4fafcc9480..45d40c622205 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -116,7 +116,6 @@ struct netfs_read_subrequest {
 	struct iov_iter		iter;		/* Iterator for this subrequest */
 	loff_t			start;		/* Where to start the I/O */
 	size_t			len;		/* Size of the I/O */
-	size_t			transferred;	/* Amount of data transferred */
 	refcount_t		usage;
 	short			error;		/* 0 or error that occurred */
 	unsigned short		debug_index;	/* Index in list (for debugging output) */
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 4d470bffd9f1..04ac29fc700f 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -190,7 +190,7 @@ TRACE_EVENT(netfs_sreq,
 		    __field(enum netfs_read_source,	source		)
 		    __field(enum netfs_sreq_trace,	what		)
 		    __field(size_t,			len		)
-		    __field(size_t,			transferred	)
+		    __field(size_t,			remain		)
 		    __field(loff_t,			start		)
 			     ),
 
@@ -202,7 +202,7 @@ TRACE_EVENT(netfs_sreq,
 		    __entry->source	= sreq->source;
 		    __entry->what	= what;
 		    __entry->len	= sreq->len;
-		    __entry->transferred = sreq->transferred;
+		    __entry->remain	= iov_iter_count(&sreq->iter);
 		    __entry->start	= sreq->start;
 			   ),
 
@@ -211,7 +211,7 @@ TRACE_EVENT(netfs_sreq,
 		      __print_symbolic(__entry->what, netfs_sreq_traces),
 		      __print_symbolic(__entry->source, netfs_sreq_sources),
 		      __entry->flags,
-		      __entry->start, __entry->transferred, __entry->len,
+		      __entry->start, __entry->len - __entry->remain, __entry->len,
 		      __entry->error)
 	    );
 
@@ -230,7 +230,7 @@ TRACE_EVENT(netfs_failure,
 		    __field(enum netfs_read_source,	source		)
 		    __field(enum netfs_failure,		what		)
 		    __field(size_t,			len		)
-		    __field(size_t,			transferred	)
+		    __field(size_t,			remain		)
 		    __field(loff_t,			start		)
 			     ),
 
@@ -242,7 +242,7 @@ TRACE_EVENT(netfs_failure,
 		    __entry->source	= sreq ? sreq->source : NETFS_INVALID_READ;
 		    __entry->what	= what;
 		    __entry->len	= sreq ? sreq->len : 0;
-		    __entry->transferred = sreq ? sreq->transferred : 0;
+		    __entry->remain	= sreq ? iov_iter_count(&sreq->iter) : 0;
 		    __entry->start	= sreq ? sreq->start : 0;
 			   ),
 
@@ -250,7 +250,7 @@ TRACE_EVENT(netfs_failure,
 		      __entry->rreq, __entry->index,
 		      __print_symbolic(__entry->source, netfs_sreq_sources),
 		      __entry->flags,
-		      __entry->start, __entry->transferred, __entry->len,
+		      __entry->start, __entry->len - __entry->remain, __entry->len,
 		      __print_symbolic(__entry->what, netfs_failures),
 		      __entry->error)
 	    );


