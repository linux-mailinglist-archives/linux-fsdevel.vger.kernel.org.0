Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDB63D0FE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 15:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238726AbhGUNFP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 09:05:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59589 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238681AbhGUNEd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 09:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626875109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J5baltngtCF+TZPYyjQGfSjHE6wKJdApaIxxJbNWIuk=;
        b=GQ58vZitHUMPR55/4FxSVf1rO5O/8QubNviFch0OukO8otx7BvKwZBtxBlexqaPtybw/K+
        zkPRWxAPOH9x6kuATm4zeL33IfCMrXgULv1pkx3XURZtNfTBmpuQ4HA7GPkAbrFct9kCGy
        Psw99ZSYaIhCI029ekwxJRU49fR2XiM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-juduQtDvMdOf3GwQ6nMtaw-1; Wed, 21 Jul 2021 09:45:08 -0400
X-MC-Unique: juduQtDvMdOf3GwQ6nMtaw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07317804142;
        Wed, 21 Jul 2021 13:45:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-62.rdu2.redhat.com [10.10.112.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C4BB5DD86;
        Wed, 21 Jul 2021 13:44:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 02/12] netfs: Add an iov_iter to the read subreq for the
 network fs/cache to use
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
Date:   Wed, 21 Jul 2021 14:44:53 +0100
Message-ID: <162687509306.276387.7579641363406546284.stgit@warthog.procyon.org.uk>
In-Reply-To: <162687506932.276387.14456718890524355509.stgit@warthog.procyon.org.uk>
References: <162687506932.276387.14456718890524355509.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add an iov_iter to the read subrequest and set it up to define the
destination buffer to write into.  This will allow future patches to point
to a bounce buffer instead for purposes of handling oversize writes,
decryption (where we want to save the encrypted data to the cache) and
decompression.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/file.c          |    6 +-----
 fs/netfs/read_helper.c |    5 ++++-
 include/linux/netfs.h  |    2 ++
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index c9c21ad0e7c9..ca529f23515a 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -319,11 +319,7 @@ static void afs_req_issue_op(struct netfs_read_subrequest *subreq)
 	fsreq->len	= subreq->len   - subreq->transferred;
 	fsreq->key	= subreq->rreq->netfs_priv;
 	fsreq->vnode	= vnode;
-	fsreq->iter	= &fsreq->def_iter;
-
-	iov_iter_xarray(&fsreq->def_iter, READ,
-			&fsreq->vnode->vfs_inode.i_mapping->i_pages,
-			fsreq->pos, fsreq->len);
+	fsreq->iter	= &subreq->iter;
 
 	afs_fetch_data(fsreq->vnode, fsreq);
 }
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 0b6cd3b8734c..715f3e9c380d 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -150,7 +150,7 @@ static void netfs_clear_unread(struct netfs_read_subrequest *subreq)
 {
 	struct iov_iter iter;
 
-	iov_iter_xarray(&iter, WRITE, &subreq->rreq->mapping->i_pages,
+	iov_iter_xarray(&iter, READ, &subreq->rreq->mapping->i_pages,
 			subreq->start + subreq->transferred,
 			subreq->len   - subreq->transferred);
 	iov_iter_zero(iov_iter_count(&iter), &iter);
@@ -745,6 +745,9 @@ netfs_rreq_prepare_read(struct netfs_read_request *rreq,
 	if (WARN_ON(subreq->len == 0))
 		source = NETFS_INVALID_READ;
 
+	iov_iter_xarray(&subreq->iter, READ, &rreq->mapping->i_pages,
+			subreq->start, subreq->len);
+
 out:
 	subreq->source = source;
 	trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index fe9887768292..5e4fafcc9480 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -17,6 +17,7 @@
 #include <linux/workqueue.h>
 #include <linux/fs.h>
 #include <linux/pagemap.h>
+#include <linux/uio.h>
 
 /*
  * Overload PG_private_2 to give us PG_fscache - this is used to indicate that
@@ -112,6 +113,7 @@ struct netfs_cache_resources {
 struct netfs_read_subrequest {
 	struct netfs_read_request *rreq;	/* Supervising read request */
 	struct list_head	rreq_link;	/* Link in rreq->subrequests */
+	struct iov_iter		iter;		/* Iterator for this subrequest */
 	loff_t			start;		/* Where to start the I/O */
 	size_t			len;		/* Size of the I/O */
 	size_t			transferred;	/* Amount of data transferred */


