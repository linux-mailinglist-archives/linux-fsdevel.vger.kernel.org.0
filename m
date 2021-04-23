Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6275E369375
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 15:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243141AbhDWNdF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 09:33:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22292 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242823AbhDWNcZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 09:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619184708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JwXA95xpkdvKsThFqSoFgKkVO4UJfYvDK51YUGC/Cz0=;
        b=T4JuCpHvbaWzhgYd9gBzad0lRU/j3MDzTJti6zonWe9uSb7XYyCj55JCM5DX6JApz4DU4Q
        6/nf6EEjcx1lBtmQYR2nZrQLHSBVLwya8AD3rmIt9Ba9S6xnYiA0WER0WNWyYHVfCB7rvC
        ANBpvGdnS0Q46YXmrHAmWFl7T4sci0Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-j8WNcCryMEWhxNu3vGpGAA-1; Fri, 23 Apr 2021 09:31:45 -0400
X-MC-Unique: j8WNcCryMEWhxNu3vGpGAA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C3F1343BA;
        Fri, 23 Apr 2021 13:31:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-124.rdu2.redhat.com [10.10.112.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC5C05C3FD;
        Fri, 23 Apr 2021 13:31:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v7 16/31] netfs: Add a tracepoint to log failures that would
 be otherwise unseen
From:   David Howells <dhowells@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Jeff Layton <jlayton@kernel.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        dhowells@redhat.com,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Fri, 23 Apr 2021 14:31:27 +0100
Message-ID: <161918468704.3145707.1831226581568224387.stgit@warthog.procyon.org.uk>
In-Reply-To: <161918446704.3145707.14418606303992174310.stgit@warthog.procyon.org.uk>
References: <161918446704.3145707.14418606303992174310.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a tracepoint to log internal failures (such as cache errors) that we
don't otherwise want to pass back to the netfs.

Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Dave Wysochanski <dwysocha@redhat.com>
Tested-By: Marc Dionne <marc.dionne@auristor.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-mm@kvack.org
cc: linux-cachefs@redhat.com
cc: linux-afs@lists.infradead.org
cc: linux-nfs@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: ceph-devel@vger.kernel.org
cc: v9fs-developer@lists.sourceforge.net
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/161781048813.463527.1557000804674707986.stgit@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/161789082749.6155.15498680577213140870.stgit@warthog.procyon.org.uk/ # v6
---

 fs/netfs/read_helper.c       |   14 +++++++++-
 include/trace/events/netfs.h |   58 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index cd3b61d5e192..1d3b50c5db6d 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -271,6 +271,8 @@ static void netfs_rreq_copy_terminated(void *priv, ssize_t transferred_or_error,
 
 	if (IS_ERR_VALUE(transferred_or_error)) {
 		netfs_stat(&netfs_n_rh_write_failed);
+		trace_netfs_failure(rreq, subreq, transferred_or_error,
+				    netfs_fail_copy_to_cache);
 	} else {
 		netfs_stat(&netfs_n_rh_write_done);
 	}
@@ -323,6 +325,7 @@ static void netfs_rreq_do_write_to_cache(struct netfs_read_request *rreq)
 		ret = cres->ops->prepare_write(cres, &subreq->start, &subreq->len,
 					       rreq->i_size);
 		if (ret < 0) {
+			trace_netfs_failure(rreq, subreq, ret, netfs_fail_prepare_write);
 			trace_netfs_sreq(subreq, netfs_sreq_trace_write_skip);
 			continue;
 		}
@@ -627,6 +630,8 @@ void netfs_subreq_terminated(struct netfs_read_subrequest *subreq,
 
 	if (IS_ERR_VALUE(transferred_or_error)) {
 		subreq->error = transferred_or_error;
+		trace_netfs_failure(rreq, subreq, transferred_or_error,
+				    netfs_fail_read);
 		goto failed;
 	}
 
@@ -996,8 +1001,10 @@ int netfs_readpage(struct file *file,
 	} while (test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags));
 
 	ret = rreq->error;
-	if (ret == 0 && rreq->submitted < rreq->len)
+	if (ret == 0 && rreq->submitted < rreq->len) {
+		trace_netfs_failure(rreq, NULL, ret, netfs_fail_short_readpage);
 		ret = -EIO;
+	}
 out:
 	netfs_put_read_request(rreq, false);
 	return ret;
@@ -1069,6 +1076,7 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 		/* Allow the netfs (eg. ceph) to flush conflicts. */
 		ret = ops->check_write_begin(file, pos, len, page, _fsdata);
 		if (ret < 0) {
+			trace_netfs_failure(NULL, NULL, ret, netfs_fail_check_write_begin);
 			if (ret == -EAGAIN)
 				goto retry;
 			goto error;
@@ -1145,8 +1153,10 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 	}
 
 	ret = rreq->error;
-	if (ret == 0 && rreq->submitted < rreq->len)
+	if (ret == 0 && rreq->submitted < rreq->len) {
+		trace_netfs_failure(rreq, NULL, ret, netfs_fail_short_write_begin);
 		ret = -EIO;
+	}
 	netfs_put_read_request(rreq, false);
 	if (ret < 0)
 		goto error;
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index e3ebeabd3852..de1c64635e42 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -47,6 +47,15 @@ enum netfs_sreq_trace {
 	netfs_sreq_trace_write_term,
 };
 
+enum netfs_failure {
+	netfs_fail_check_write_begin,
+	netfs_fail_copy_to_cache,
+	netfs_fail_read,
+	netfs_fail_short_readpage,
+	netfs_fail_short_write_begin,
+	netfs_fail_prepare_write,
+};
+
 #endif
 
 #define netfs_read_traces					\
@@ -81,6 +90,14 @@ enum netfs_sreq_trace {
 	EM(netfs_sreq_trace_write_skip,		"SKIP ")	\
 	E_(netfs_sreq_trace_write_term,		"WTERM")
 
+#define netfs_failures							\
+	EM(netfs_fail_check_write_begin,	"check-write-begin")	\
+	EM(netfs_fail_copy_to_cache,		"copy-to-cache")	\
+	EM(netfs_fail_read,			"read")			\
+	EM(netfs_fail_short_readpage,		"short-readpage")	\
+	EM(netfs_fail_short_write_begin,	"short-write-begin")	\
+	E_(netfs_fail_prepare_write,		"prep-write")
+
 
 /*
  * Export enum symbols via userspace.
@@ -94,6 +111,7 @@ netfs_read_traces;
 netfs_rreq_traces;
 netfs_sreq_sources;
 netfs_sreq_traces;
+netfs_failures;
 
 /*
  * Now redefine the EM() and E_() macros to map the enums to the strings that
@@ -197,6 +215,46 @@ TRACE_EVENT(netfs_sreq,
 		      __entry->error)
 	    );
 
+TRACE_EVENT(netfs_failure,
+	    TP_PROTO(struct netfs_read_request *rreq,
+		     struct netfs_read_subrequest *sreq,
+		     int error, enum netfs_failure what),
+
+	    TP_ARGS(rreq, sreq, error, what),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		rreq		)
+		    __field(unsigned short,		index		)
+		    __field(short,			error		)
+		    __field(unsigned short,		flags		)
+		    __field(enum netfs_read_source,	source		)
+		    __field(enum netfs_failure,		what		)
+		    __field(size_t,			len		)
+		    __field(size_t,			transferred	)
+		    __field(loff_t,			start		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->rreq	= rreq->debug_id;
+		    __entry->index	= sreq ? sreq->debug_index : 0;
+		    __entry->error	= error;
+		    __entry->flags	= sreq ? sreq->flags : 0;
+		    __entry->source	= sreq ? sreq->source : NETFS_INVALID_READ;
+		    __entry->what	= what;
+		    __entry->len	= sreq ? sreq->len : 0;
+		    __entry->transferred = sreq ? sreq->transferred : 0;
+		    __entry->start	= sreq ? sreq->start : 0;
+			   ),
+
+	    TP_printk("R=%08x[%u] %s f=%02x s=%llx %zx/%zx %s e=%d",
+		      __entry->rreq, __entry->index,
+		      __print_symbolic(__entry->source, netfs_sreq_sources),
+		      __entry->flags,
+		      __entry->start, __entry->transferred, __entry->len,
+		      __print_symbolic(__entry->what, netfs_failures),
+		      __entry->error)
+	    );
+
 #endif /* _TRACE_NETFS_H */
 
 /* This part must be outside protection */


