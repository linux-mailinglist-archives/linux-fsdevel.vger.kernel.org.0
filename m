Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DFC2BADD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgKTPKd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:10:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41907 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729024AbgKTPKa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:10:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605885027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Im8HRq4DABDY5FtqrDa23AHB5iQAdOCiN8Sx3QngDQk=;
        b=ZSljGOEn4EaTEhI33/TxFTpYM6FK55QeYJbhxJfLAGx03IiK+uS61lVF3lHZFroEwmQ8+g
        nYVcda6vreu+loctXX4GFkdC2JAj1OB6xws9XAZEZGIk+9721+eNo6ape+CzTgJHMrNZ2q
        heNJXOXOhuQlLTtTvPYJUmqnjN8UeWI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-ArZa48PpP3efDEZj8W9pbg-1; Fri, 20 Nov 2020 10:10:23 -0500
X-MC-Unique: ArZa48PpP3efDEZj8W9pbg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 627CC873163;
        Fri, 20 Nov 2020 15:10:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 07C0E5D6BA;
        Fri, 20 Nov 2020 15:10:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 35/76] fscache: read-helper: Add tracepoints
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
Date:   Fri, 20 Nov 2020 15:10:14 +0000
Message-ID: <160588501418.3465195.3819311073293372410.stgit@warthog.procyon.org.uk>
In-Reply-To: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
References: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add three tracepoints to track the activity of the read helpers:

 (1) fscache_support/fscache_read

     This logs entry to the read helpers and also expansion of the range in
     a readahead request.

 (2) fscache_support/fscache_rreq

     This logs the progress of fscache_read_request objects which track
     read requests.  A read request may be a compound of multiple
     subrequests.

 (3) fscache_support/fscache_sreq

     This logs the progress of fscache_read_subrequest objects, which track
     the contributions from various sources to a read request.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/netfs/read_helper.c       |   37 ++++++++
 include/linux/netfs.h        |    2 
 include/trace/events/netfs.h |  200 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 239 insertions(+)
 create mode 100644 include/trace/events/netfs.h

diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index f5185402b504..21d3578c6979 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -16,6 +16,8 @@
 #include <linux/netfs.h>
 #include <linux/fscache.h>
 #include "internal.h"
+#define CREATE_TRACE_POINTS
+#include <trace/events/netfs.h>
 
 MODULE_DESCRIPTION("Network fs support");
 MODULE_AUTHOR("Red Hat, Inc.");
@@ -38,6 +40,7 @@ static struct netfs_read_request *netfs_alloc_read_request(
 	const struct netfs_read_request_ops *ops, void *netfs_priv,
 	struct file *file)
 {
+	static atomic_t debug_ids;
 	struct netfs_read_request *rreq;
 
 	rreq = kzalloc(sizeof(struct netfs_read_request), GFP_KERNEL);
@@ -46,6 +49,7 @@ static struct netfs_read_request *netfs_alloc_read_request(
 		rreq->netfs_priv = netfs_priv;
 		rreq->inode	= file_inode(file);
 		rreq->i_size	= i_size_read(rreq->inode);
+		rreq->debug_id	= atomic_inc_return(&debug_ids);
 		INIT_LIST_HEAD(&rreq->subrequests);
 		INIT_WORK(&rreq->work, netfs_rreq_work);
 		refcount_set(&rreq->usage, 1);
@@ -80,6 +84,7 @@ static void netfs_put_read_request(struct netfs_read_request *rreq)
 		if (rreq->netfs_priv)
 			rreq->netfs_ops->cleanup(rreq->mapping, rreq->netfs_priv);
 		fscache_end_operation(&rreq->cache_resources);
+		trace_netfs_rreq(rreq, netfs_rreq_trace_free);
 		kfree(rreq);
 	}
 }
@@ -109,6 +114,7 @@ static void netfs_get_read_subrequest(struct netfs_read_subrequest *subreq)
 
 static void __netfs_put_subrequest(struct netfs_read_subrequest *subreq)
 {
+	trace_netfs_sreq(subreq, netfs_sreq_trace_free);
 	netfs_put_read_request(subreq->rreq);
 	kfree(subreq);
 }
@@ -188,6 +194,7 @@ static void netfs_read_from_server(struct netfs_read_request *rreq,
  */
 static void netfs_rreq_completed(struct netfs_read_request *rreq)
 {
+	trace_netfs_rreq(rreq, netfs_rreq_trace_done);
 	netfs_rreq_clear_subreqs(rreq);
 	netfs_put_read_request(rreq);
 }
@@ -205,6 +212,8 @@ static void netfs_rreq_unmark_after_write(struct netfs_read_request *rreq)
 	pgoff_t unlocked = 0;
 	bool have_unlocked = false;
 
+	trace_netfs_rreq(rreq, netfs_rreq_trace_unmark);
+
 	rcu_read_lock();
 
 	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
@@ -236,6 +245,8 @@ static void netfs_rreq_copy_terminated(void *priv, ssize_t transferred_or_error)
 	else
 		subreq->error = 0;
 
+	trace_netfs_sreq(subreq, netfs_sreq_trace_write_term);
+
 	/* If we decrement nr_wr_ops to 0, the ref belongs to us. */
 	if (atomic_dec_and_test(&rreq->nr_wr_ops))
 		netfs_rreq_unmark_after_write(rreq);
@@ -252,6 +263,8 @@ static void netfs_rreq_do_write_to_cache(struct netfs_read_request *rreq)
 	struct netfs_read_subrequest *subreq, *next, *p;
 	struct iov_iter iter;
 
+	trace_netfs_rreq(rreq, netfs_rreq_trace_write);
+
 	/* We don't want terminating writes trying to wake us up whilst we're
 	 * still going through the list.
 	 */
@@ -275,6 +288,8 @@ static void netfs_rreq_do_write_to_cache(struct netfs_read_request *rreq)
 			netfs_put_subrequest(next);
 		}
 
+		trace_netfs_sreq(subreq, netfs_sreq_trace_write);
+
 		iov_iter_xarray(&iter, WRITE, &rreq->mapping->i_pages,
 				subreq->start, subreq->len);
 
@@ -342,6 +357,8 @@ static void netfs_rreq_unlock(struct netfs_read_request *rreq)
 	iopos = 0;
 	subreq_failed = (subreq->error < 0);
 
+	trace_netfs_rreq(rreq, netfs_rreq_trace_unlock);
+
 	rcu_read_lock();
 	xas_for_each(&xas, page, last_page) {
 		unsigned int pgpos = (page->index - start_page) * PAGE_SIZE;
@@ -398,6 +415,8 @@ static void netfs_rreq_short_read(struct netfs_read_request *rreq,
 	__clear_bit(NETFS_SREQ_SHORT_READ, &subreq->flags);
 	__set_bit(NETFS_SREQ_SEEK_DATA_READ, &subreq->flags);
 
+	trace_netfs_sreq(subreq, netfs_sreq_trace_resubmit_short);
+
 	netfs_get_read_subrequest(subreq);
 	atomic_inc(&rreq->nr_rd_ops);
 	if (subreq->source == NETFS_READ_FROM_CACHE)
@@ -416,6 +435,8 @@ static bool netfs_rreq_perform_resubmissions(struct netfs_read_request *rreq)
 
 	WARN_ON(in_softirq());
 
+	trace_netfs_rreq(rreq, netfs_rreq_trace_resubmit);
+
 	/* We don't want terminating submissions trying to wake us up whilst
 	 * we're still going through the list.
 	 */
@@ -428,6 +449,7 @@ static bool netfs_rreq_perform_resubmissions(struct netfs_read_request *rreq)
 				break;
 			subreq->source = NETFS_DOWNLOAD_FROM_SERVER;
 			subreq->error = 0;
+			trace_netfs_sreq(subreq, netfs_sreq_trace_download_instead);
 			netfs_get_read_subrequest(subreq);
 			atomic_inc(&rreq->nr_rd_ops);
 			netfs_read_from_server(rreq, subreq);
@@ -471,6 +493,8 @@ static void netfs_rreq_is_still_valid(struct netfs_read_request *rreq)
  */
 static void netfs_rreq_assess(struct netfs_read_request *rreq)
 {
+	trace_netfs_rreq(rreq, netfs_rreq_trace_assess);
+
 again:
 	netfs_rreq_is_still_valid(rreq);
 
@@ -558,6 +582,8 @@ void netfs_subreq_terminated(struct netfs_read_subrequest *subreq,
 		set_bit(NETFS_RREQ_WRITE_TO_CACHE, &rreq->flags);
 
 out:
+	trace_netfs_sreq(subreq, netfs_sreq_trace_terminated);
+
 	/* If we decrement nr_rd_ops to 0, the ref belongs to us. */
 	u = atomic_dec_return(&rreq->nr_rd_ops);
 	if (u == 0)
@@ -650,6 +676,7 @@ netfs_rreq_prepare_read(struct netfs_read_request *rreq,
 
 out:
 	subreq->source = source;
+	trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
 	return source;
 }
 
@@ -690,6 +717,7 @@ static bool netfs_rreq_submit_slice(struct netfs_read_request *rreq,
 
 	rreq->submitted += subreq->len;
 
+	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 	switch (source) {
 	case NETFS_FILL_WITH_ZEROES:
 		netfs_fill_with_zeroes(rreq, subreq);
@@ -750,6 +778,9 @@ static void netfs_rreq_expand(struct netfs_read_request *rreq,
 		readahead_expand(ractl, rreq->start, rreq->len);
 		rreq->start  = readahead_pos(ractl);
 		rreq->len = readahead_length(ractl);
+
+		trace_netfs_read(rreq, readahead_pos(ractl), readahead_length(ractl),
+				 netfs_read_trace_expanded);
 	}
 }
 
@@ -791,6 +822,9 @@ void netfs_readahead(struct readahead_control *ractl,
 	rreq->start	= readahead_pos(ractl);
 	rreq->len	= readahead_length(ractl);
 
+	trace_netfs_read(rreq, readahead_pos(ractl), readahead_length(ractl),
+			 netfs_read_trace_readahead);
+
 	if (ops->begin_cache_operation)
 		ops->begin_cache_operation(rreq);
 	netfs_rreq_expand(rreq, ractl);
@@ -863,6 +897,9 @@ int netfs_readpage(struct file *file,
 	rreq->start		= page->index * PAGE_SIZE;
 	rreq->len		= thp_size(page);
 
+	trace_netfs_read(rreq, page->index * PAGE_SIZE, thp_size(page),
+			 netfs_read_trace_readpage);
+
 	if (ops->begin_cache_operation)
 		ops->begin_cache_operation(rreq);
 	netfs_get_read_request(rreq);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index f2ffea11ea9b..c4276eb9914d 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -53,6 +53,8 @@ struct netfs_read_request {
 	struct list_head	subrequests;	/* Requests to fetch I/O from disk or net */
 	struct work_struct	work;
 	void			*netfs_priv;	/* Private data for the netfs */
+	unsigned int		debug_id;
+	unsigned int		cookie_debug_id;
 	atomic_t		nr_rd_ops;	/* Number of read ops in progress */
 	atomic_t		nr_wr_ops;	/* Number of write ops in progress */
 	size_t			submitted;	/* Amount submitted for I/O so far */
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
new file mode 100644
index 000000000000..56a734a3fb0d
--- /dev/null
+++ b/include/trace/events/netfs.h
@@ -0,0 +1,200 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Network filesystem support module tracepoints
+ *
+ * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM netfs
+
+#if !defined(_TRACE_NETFS_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_NETFS_H
+
+#include <linux/fscache.h>
+#include <linux/tracepoint.h>
+
+/*
+ * Define enums for tracing information.
+ */
+#ifndef __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
+#define __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
+
+enum netfs_read_trace {
+	netfs_read_trace_expanded,
+	netfs_read_trace_readahead,
+	netfs_read_trace_readpage,
+};
+
+enum netfs_rreq_trace {
+	netfs_rreq_trace_assess,
+	netfs_rreq_trace_done,
+	netfs_rreq_trace_free,
+	netfs_rreq_trace_resubmit,
+	netfs_rreq_trace_unlock,
+	netfs_rreq_trace_unmark,
+	netfs_rreq_trace_write,
+};
+
+enum netfs_sreq_trace {
+	netfs_sreq_trace_download_instead,
+	netfs_sreq_trace_free,
+	netfs_sreq_trace_prepare,
+	netfs_sreq_trace_resubmit_short,
+	netfs_sreq_trace_submit,
+	netfs_sreq_trace_terminated,
+	netfs_sreq_trace_write,
+	netfs_sreq_trace_write_term,
+};
+
+#endif
+
+#define netfs_read_traces					\
+	EM(netfs_read_trace_expanded,		"EXPANDED ")	\
+	EM(netfs_read_trace_readahead,		"READAHEAD")	\
+	E_(netfs_read_trace_readpage,		"READPAGE ")
+
+#define netfs_rreq_traces					\
+	EM(netfs_rreq_trace_assess,		"ASSESS")	\
+	EM(netfs_rreq_trace_done,		"DONE  ")	\
+	EM(netfs_rreq_trace_free,		"FREE  ")	\
+	EM(netfs_rreq_trace_resubmit,		"RESUBM")	\
+	EM(netfs_rreq_trace_unlock,		"UNLOCK")	\
+	EM(netfs_rreq_trace_unmark,		"UNMARK")	\
+	E_(netfs_rreq_trace_write,		"WRITE ")
+
+#define netfs_sreq_sources					\
+	EM(NETFS_FILL_WITH_ZEROES,		"ZERO")		\
+	EM(NETFS_DOWNLOAD_FROM_SERVER,		"DOWN")		\
+	EM(NETFS_READ_FROM_CACHE,		"READ")		\
+	E_(NETFS_INVALID_READ,			"INVL")		\
+
+#define netfs_sreq_traces					\
+	EM(netfs_sreq_trace_download_instead,	"RDOWN")	\
+	EM(netfs_sreq_trace_free,		"FREE ")	\
+	EM(netfs_sreq_trace_prepare,		"PREP ")	\
+	EM(netfs_sreq_trace_resubmit_short,	"SHORT")	\
+	EM(netfs_sreq_trace_submit,		"SUBMT")	\
+	EM(netfs_sreq_trace_terminated,		"TERM ")	\
+	EM(netfs_sreq_trace_write,		"WRITE")	\
+	E_(netfs_sreq_trace_write_term,		"WTERM")
+
+
+/*
+ * Export enum symbols via userspace.
+ */
+#undef EM
+#undef E_
+#define EM(a, b) TRACE_DEFINE_ENUM(a);
+#define E_(a, b) TRACE_DEFINE_ENUM(a);
+
+netfs_read_traces;
+netfs_rreq_traces;
+netfs_sreq_sources;
+netfs_sreq_traces;
+
+/*
+ * Now redefine the EM() and E_() macros to map the enums to the strings that
+ * will be printed in the output.
+ */
+#undef EM
+#undef E_
+#define EM(a, b)	{ a, b },
+#define E_(a, b)	{ a, b }
+
+TRACE_EVENT(netfs_read,
+	    TP_PROTO(struct netfs_read_request *rreq,
+		     loff_t start, size_t len,
+		     enum netfs_read_trace what),
+
+	    TP_ARGS(rreq, start, len, what),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		rreq		)
+		    __field(unsigned int,		cookie		)
+		    __field(loff_t,			start		)
+		    __field(size_t,			len		)
+		    __field(enum netfs_read_trace,	what		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->rreq	= rreq->debug_id;
+		    __entry->cookie	= rreq->cookie_debug_id;
+		    __entry->start	= start;
+		    __entry->len	= len;
+		    __entry->what	= what;
+			   ),
+
+	    TP_printk("R=%08x %s c=%08x s=%llx %zx",
+		      __entry->rreq,
+		      __print_symbolic(__entry->what, netfs_read_traces),
+		      __entry->cookie,
+		      __entry->start, __entry->len)
+	    );
+
+TRACE_EVENT(netfs_rreq,
+	    TP_PROTO(struct netfs_read_request *rreq,
+		     enum netfs_rreq_trace what),
+
+	    TP_ARGS(rreq, what),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		rreq		)
+		    __field(unsigned short,		flags		)
+		    __field(enum netfs_rreq_trace,	what		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->rreq	= rreq->debug_id;
+		    __entry->flags	= rreq->flags;
+		    __entry->what	= what;
+			   ),
+
+	    TP_printk("R=%08x %s f=%02x",
+		      __entry->rreq,
+		      __print_symbolic(__entry->what, netfs_rreq_traces),
+		      __entry->flags)
+	    );
+
+TRACE_EVENT(netfs_sreq,
+	    TP_PROTO(struct netfs_read_subrequest *sreq,
+		     enum netfs_sreq_trace what),
+
+	    TP_ARGS(sreq, what),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		rreq		)
+		    __field(unsigned short,		index		)
+		    __field(short,			error		)
+		    __field(unsigned short,		flags		)
+		    __field(enum netfs_read_source,	source		)
+		    __field(enum netfs_sreq_trace,	what		)
+		    __field(size_t,			len		)
+		    __field(size_t,			transferred	)
+		    __field(loff_t,			start		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->rreq	= sreq->rreq->debug_id;
+		    __entry->index	= sreq->debug_index;
+		    __entry->error	= sreq->error;
+		    __entry->flags	= sreq->flags;
+		    __entry->source	= sreq->source;
+		    __entry->what	= what;
+		    __entry->len	= sreq->len;
+		    __entry->transferred = sreq->transferred;
+		    __entry->start	= sreq->start;
+			   ),
+
+	    TP_printk("R=%08x[%u] %s %s f=%02x s=%llx %zx/%zx e=%d",
+		      __entry->rreq, __entry->index,
+		      __print_symbolic(__entry->what, netfs_sreq_traces),
+		      __print_symbolic(__entry->source, netfs_sreq_sources),
+		      __entry->flags,
+		      __entry->start, __entry->transferred, __entry->len,
+		      __entry->error)
+	    );
+
+#endif /* _TRACE_NETFS_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>


