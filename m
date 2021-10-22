Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6BEA437D06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 21:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbhJVTDV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 15:03:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31513 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233790AbhJVTDT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634929261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lggmOOD7ybM9LnFkd/u/PSJr+Z4vKCVPqfpMIrG0iuQ=;
        b=GMHiQNvHnlH85Wvb7sju2IOuzXQ9VWQc5iOImA3mlBmyKFWqcfDli2drpxkSv8rSbq/ckO
        LJavmb0SAnYFktxsRC9pGrF7vaY5CJ84u1f/CK5WLFSWzpZZ6KXTDahkyV/552s/j0EfyA
        yQ8fwiuD6KDgO9zfoRq4xGmlF+jWRBU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-up371D9zOsKNIVzAROnkYA-1; Fri, 22 Oct 2021 15:00:55 -0400
X-MC-Unique: up371D9zOsKNIVzAROnkYA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 497391006AA2;
        Fri, 22 Oct 2021 19:00:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 258BC6A916;
        Fri, 22 Oct 2021 19:00:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 06/53] netfs: Pass a flag to ->prepare_write() to say if
 there's no alloc'd space
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 22 Oct 2021 20:00:02 +0100
Message-ID: <163492920230.1038219.499626497892850661.stgit@warthog.procyon.org.uk>
In-Reply-To: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
References: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pass a flag to ->prepare_write() to indicate if there's definitely no
space allocated in the cache yet (for instance if we've already checked as
we were asked to do a read).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/cachefiles_old/io.c |    3 ++-
 fs/netfs/read_helper.c |    2 +-
 include/linux/netfs.h  |    3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/cachefiles_old/io.c b/fs/cachefiles_old/io.c
index 5ead97de4bb7..eab8641de994 100644
--- a/fs/cachefiles_old/io.c
+++ b/fs/cachefiles_old/io.c
@@ -341,7 +341,8 @@ static enum netfs_read_source cachefiles_prepare_read(struct netfs_read_subreque
  * Prepare for a write to occur.
  */
 static int cachefiles_prepare_write(struct netfs_cache_resources *cres,
-				    loff_t *_start, size_t *_len, loff_t i_size)
+				    loff_t *_start, size_t *_len, loff_t i_size,
+				    bool no_space_allocated_yet)
 {
 	loff_t start = *_start;
 	size_t len = *_len, down;
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index dfc60c79a9f3..80f8e334371d 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -323,7 +323,7 @@ static void netfs_rreq_do_write_to_cache(struct netfs_read_request *rreq)
 		}
 
 		ret = cres->ops->prepare_write(cres, &subreq->start, &subreq->len,
-					       rreq->i_size);
+					       rreq->i_size, true);
 		if (ret < 0) {
 			trace_netfs_failure(rreq, subreq, ret, netfs_fail_prepare_write);
 			trace_netfs_sreq(subreq, netfs_sreq_trace_write_skip);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 014fb502fd91..99137486d351 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -220,7 +220,8 @@ struct netfs_cache_ops {
 	 * actually do.
 	 */
 	int (*prepare_write)(struct netfs_cache_resources *cres,
-			     loff_t *_start, size_t *_len, loff_t i_size);
+			     loff_t *_start, size_t *_len, loff_t i_size,
+			     bool no_space_allocated_yet);
 
 	/* Prepare a write operation for the fallback fscache API, working out
 	 * whether we can cache a page or not.


