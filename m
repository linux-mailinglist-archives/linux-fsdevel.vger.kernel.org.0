Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1EBC3570EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 17:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353816AbhDGPuG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 11:50:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47694 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353839AbhDGPsZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617810495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7YU5TzFZ1fF+KiaedglYdJEmeLs3Li2P31LqwaTTSpo=;
        b=QnXYmr3Xgl0tkQcnSYPRnS0DA9N1csu/mros94x1IlPmw6b0PS/PDVQl7Res+Nmt6B054t
        8Za86SyIa+9l0Kc6ZYnMLmPDemx4Ww2klad6eIkxJztG0g9xBYZZMsW+qZdTetl1R8fKPY
        QPXy1rEqtLgGxOvo1sR8VRRjuhS4Grg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-ktl_34jXP5u2gIG_aOuEhA-1; Wed, 07 Apr 2021 11:48:12 -0400
X-MC-Unique: ktl_34jXP5u2gIG_aOuEhA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 466788026AD;
        Wed,  7 Apr 2021 15:48:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-201.rdu2.redhat.com [10.10.115.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 010496A033;
        Wed,  7 Apr 2021 15:48:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 5/5] netfs: Add a tracepoint to log failures that would be
 otherwise unseen
From:   David Howells <dhowells@redhat.com>
To:     jlayton@kernel.org
Cc:     dwysocha@redhat.com, linux-cachefs@redhat.com,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 07 Apr 2021 16:48:08 +0100
Message-ID: <161781048813.463527.1557000804674707986.stgit@warthog.procyon.org.uk>
In-Reply-To: <161781041339.463527.18139104281901492882.stgit@warthog.procyon.org.uk>
References: <161781041339.463527.18139104281901492882.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a tracepoint to log internal failures (such as cache errors) that we
don't otherwise want to pass back to the netfs.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/netfs/read_helper.c       |   14 +++++++++-
 include/trace/events/netfs.h |   58 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index ce2f31d20250..762a15350242 100644
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
@@ -1074,6 +1081,7 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
 		/* Allow the netfs (eg. ceph) to flush conflicts. */
 		ret = ops->check_write_begin(file, pos, len, page, _fsdata);
 		if (ret < 0) {
+			trace_netfs_failure(NULL, NULL, ret, netfs_fail_check_write_begin);
 			if (ret == -EAGAIN)
 				goto retry;
 			goto error;
@@ -1150,8 +1158,10 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
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


