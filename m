Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F07E3AF7B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 23:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhFUVrh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 17:47:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58079 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231809AbhFUVrg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 17:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624311921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5pOORLyx9xwuGC0Xz0tLtpUvQ+XLGPJYb5PgrsJW+cg=;
        b=G8Q7K7LUteQjUxH9htdw6SNxMbYdFEbj1J95W1p7lZ9xKF8SFDl2gdzVudR0rKIQM3+tO6
        6gJKngfr9tqVX8RpS2gRqSsQOhV/Mg4W1wHYTmfpIgVrgiqL+JaWglPFxNyfW+RQUxK7f1
        6FL6FLRilZqHy103OIkktKcRky+5rbw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-7jkP4K3LPs6p49UiZi4Whg-1; Mon, 21 Jun 2021 17:45:20 -0400
X-MC-Unique: 7jkP4K3LPs6p49UiZi4Whg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C30AF100C611;
        Mon, 21 Jun 2021 21:45:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A89E969FAD;
        Mon, 21 Jun 2021 21:45:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 02/12] netfs: Move cookie debug ID to struct
 netfs_cache_resources
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 21 Jun 2021 22:45:07 +0100
Message-ID: <162431190784.2908479.13386972676539789127.stgit@warthog.procyon.org.uk>
In-Reply-To: <162431188431.2908479.14031376932042135080.stgit@warthog.procyon.org.uk>
References: <162431188431.2908479.14031376932042135080.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the cookie debug ID from struct netfs_read_request to struct
netfs_cache_resources and drop the 'cookie_' prefix.  This makes it
available for things that want to use netfs_cache_resources without having
a netfs_read_request.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/io.c           |    2 +-
 include/linux/netfs.h        |    2 +-
 include/trace/events/netfs.h |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index b13fb45fc3f3..ca68bb97ca00 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -410,7 +410,7 @@ int cachefiles_begin_read_operation(struct netfs_read_request *rreq,
 	rreq->cache_resources.cache_priv = op;
 	rreq->cache_resources.cache_priv2 = file;
 	rreq->cache_resources.ops = &cachefiles_netfs_cache_ops;
-	rreq->cookie_debug_id = object->fscache.debug_id;
+	rreq->cache_resources.debug_id = object->fscache.debug_id;
 	_leave("");
 	return 0;
 
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 9062adfa2fb9..5d6a4158a9a6 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -102,6 +102,7 @@ struct netfs_cache_resources {
 	const struct netfs_cache_ops	*ops;
 	void				*cache_priv;
 	void				*cache_priv2;
+	unsigned int			debug_id;	/* Cookie debug ID */
 };
 
 /*
@@ -137,7 +138,6 @@ struct netfs_read_request {
 	struct list_head	subrequests;	/* Requests to fetch I/O from disk or net */
 	void			*netfs_priv;	/* Private data for the netfs */
 	unsigned int		debug_id;
-	unsigned int		cookie_debug_id;
 	atomic_t		nr_rd_ops;	/* Number of read ops in progress */
 	atomic_t		nr_wr_ops;	/* Number of write ops in progress */
 	size_t			submitted;	/* Amount submitted for I/O so far */
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index de1c64635e42..4d470bffd9f1 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -139,7 +139,7 @@ TRACE_EVENT(netfs_read,
 
 	    TP_fast_assign(
 		    __entry->rreq	= rreq->debug_id;
-		    __entry->cookie	= rreq->cookie_debug_id;
+		    __entry->cookie	= rreq->cache_resources.debug_id;
 		    __entry->start	= start;
 		    __entry->len	= len;
 		    __entry->what	= what;


