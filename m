Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94FD3570E5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 17:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353825AbhDGPsz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 11:48:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47159 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353823AbhDGPsQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617810486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WULWsN3uOe2W6umAHISiBdK6m4Z+piU8XcyQ1XGELSQ=;
        b=Yjm2Vd7Jz9ybVFFdQdqXCYvbYVritq4QqXf9NKRk11jcFClLAuJomzVwMHdA2L/z+BfqUa
        UTk+SGtYzeQ3ODxqa0rHMDsoxCQ/KUaCDaZsHvLB3A7rQC9Kq/gRIqHAdLYeLqrd1tEYmj
        OLAPOcBGLhuY08SB37NdK6rFRAh5DHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-mZS2mNHpOlyDiFJYF0vuxA-1; Wed, 07 Apr 2021 11:48:04 -0400
X-MC-Unique: mZS2mNHpOlyDiFJYF0vuxA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E55425B364;
        Wed,  7 Apr 2021 15:48:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-201.rdu2.redhat.com [10.10.115.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C805160C5C;
        Wed,  7 Apr 2021 15:47:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 4/5] netfs: Fix copy-to-cache amalgamation
From:   David Howells <dhowells@redhat.com>
To:     jlayton@kernel.org
Cc:     dwysocha@redhat.com, linux-cachefs@redhat.com,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 07 Apr 2021 16:47:56 +0100
Message-ID: <161781047695.463527.7463536103593997492.stgit@warthog.procyon.org.uk>
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

Fix the amalgamation of subrequests when copying to the cache.  We
shouldn't be rounding up the size to PAGE_SIZE as we go along as that ends
up with the composite subrequest length being too long - and this leads to
EIO from the cache write because the source iterator doesn't contain enough
data.

Instead, we only need to deal with contiguous subreqs and then ask the
cache to round off as it needs - which also means we don't have to make any
assumptions about the cache granularity.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/io.c           |   17 +++++++++++++++++
 fs/netfs/read_helper.c       |   19 +++++++++----------
 include/linux/netfs.h        |    6 ++++++
 include/trace/events/netfs.h |    2 ++
 4 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 620959d1e95b..b13fb45fc3f3 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -330,6 +330,22 @@ static enum netfs_read_source cachefiles_prepare_read(struct netfs_read_subreque
 	return NETFS_DOWNLOAD_FROM_SERVER;
 }
 
+/*
+ * Prepare for a write to occur.
+ */
+static int cachefiles_prepare_write(struct netfs_cache_resources *cres,
+				    loff_t *_start, size_t *_len, loff_t i_size)
+{
+	loff_t start = *_start;
+	size_t len = *_len, down;
+
+	/* Round to DIO size */
+	down = start - round_down(start, PAGE_SIZE);
+	*_start = start - down;
+	*_len = round_up(down + len, PAGE_SIZE);
+	return 0;
+}
+
 /*
  * Clean up an operation.
  */
@@ -355,6 +371,7 @@ static const struct netfs_cache_ops cachefiles_netfs_cache_ops = {
 	.read			= cachefiles_read,
 	.write			= cachefiles_write,
 	.prepare_read		= cachefiles_prepare_read,
+	.prepare_write		= cachefiles_prepare_write,
 };
 
 /*
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index ad0dc01319ce..ce2f31d20250 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -293,7 +293,7 @@ static void netfs_rreq_do_write_to_cache(struct netfs_read_request *rreq)
 	struct netfs_cache_resources *cres = &rreq->cache_resources;
 	struct netfs_read_subrequest *subreq, *next, *p;
 	struct iov_iter iter;
-	loff_t pos;
+	int ret;
 
 	trace_netfs_rreq(rreq, netfs_rreq_trace_write);
 
@@ -311,23 +311,22 @@ static void netfs_rreq_do_write_to_cache(struct netfs_read_request *rreq)
 
 	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
 		/* Amalgamate adjacent writes */
-		pos = round_down(subreq->start, PAGE_SIZE);
-		if (pos != subreq->start) {
-			subreq->len += subreq->start - pos;
-			subreq->start = pos;
-		}
-		subreq->len = round_up(subreq->len, PAGE_SIZE);
-
 		while (!list_is_last(&subreq->rreq_link, &rreq->subrequests)) {
 			next = list_next_entry(subreq, rreq_link);
-			if (next->start > subreq->start + subreq->len)
+			if (next->start != subreq->start + subreq->len)
 				break;
 			subreq->len += next->len;
-			subreq->len = round_up(subreq->len, PAGE_SIZE);
 			list_del_init(&next->rreq_link);
 			netfs_put_subrequest(next, false);
 		}
 
+		ret = cres->ops->prepare_write(cres, &subreq->start, &subreq->len,
+					       rreq->i_size);
+		if (ret < 0) {
+			trace_netfs_sreq(subreq, netfs_sreq_trace_write_skip);
+			continue;
+		}
+
 		iov_iter_xarray(&iter, WRITE, &rreq->mapping->i_pages,
 				subreq->start, subreq->len);
 
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 2299e7662ff0..9062adfa2fb9 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -206,6 +206,12 @@ struct netfs_cache_ops {
 	 */
 	enum netfs_read_source (*prepare_read)(struct netfs_read_subrequest *subreq,
 					       loff_t i_size);
+
+	/* Prepare a write operation, working out what part of the write we can
+	 * actually do.
+	 */
+	int (*prepare_write)(struct netfs_cache_resources *cres,
+			     loff_t *_start, size_t *_len, loff_t i_size);
 };
 
 struct readahead_control;
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index a2bf6cd84bd4..e3ebeabd3852 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -43,6 +43,7 @@ enum netfs_sreq_trace {
 	netfs_sreq_trace_submit,
 	netfs_sreq_trace_terminated,
 	netfs_sreq_trace_write,
+	netfs_sreq_trace_write_skip,
 	netfs_sreq_trace_write_term,
 };
 
@@ -77,6 +78,7 @@ enum netfs_sreq_trace {
 	EM(netfs_sreq_trace_submit,		"SUBMT")	\
 	EM(netfs_sreq_trace_terminated,		"TERM ")	\
 	EM(netfs_sreq_trace_write,		"WRITE")	\
+	EM(netfs_sreq_trace_write_skip,		"SKIP ")	\
 	E_(netfs_sreq_trace_write_term,		"WTERM")
 
 


