Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933A6302E38
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 22:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732534AbhAYVpW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 16:45:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27931 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733011AbhAYViq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611610639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DJBzsieLz3F34jgWNbDfs2G62KaotvEgYmhgd9nKqH8=;
        b=fWke9wl2ubCThpQ6TYKljk/uDdUaY/aZfPRJgE2cZmkS8bBzJTUcL13fKT6n/fjf6N61hR
        EO3qWoYtzfmUe2vrrp6bwVSx/fDEr+NSevI8P8HUQ/9g8L8V6zBt/91jvccM8JaiA+sftg
        h5VIn34PF6Zicgbb/wW5VcqxsX3QXRs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-Zz0Nd77RMqGTYIwAN4aTyA-1; Mon, 25 Jan 2021 16:37:17 -0500
X-MC-Unique: Zz0Nd77RMqGTYIwAN4aTyA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11D2680669E;
        Mon, 25 Jan 2021 21:37:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 755C510023AD;
        Mon, 25 Jan 2021 21:37:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 30/32] NFS: Allow internal use of read structs and functions
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Dave Wysochanski <dwysocha@redhat.com>, dhowells@redhat.com,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 25 Jan 2021 21:37:11 +0000
Message-ID: <161161063169.2537118.13133700308967412779.stgit@warthog.procyon.org.uk>
In-Reply-To: <161161025063.2537118.2009249444682241405.stgit@warthog.procyon.org.uk>
References: <161161025063.2537118.2009249444682241405.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Wysochanski <dwysocha@redhat.com>

The conversion of the NFS read paths to the new fscache API
will require use of a few read structs and functions,
so move these declarations as required.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---

 fs/nfs/internal.h |    8 ++++++++
 fs/nfs/read.c     |   13 ++++---------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 62d3189745cd..8514d002c922 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -457,9 +457,17 @@ extern int nfs4_get_rootfh(struct nfs_server *server, struct nfs_fh *mntfh, bool
 
 struct nfs_pgio_completion_ops;
 /* read.c */
+extern const struct nfs_pgio_completion_ops nfs_async_read_completion_ops;
 extern void nfs_pageio_init_read(struct nfs_pageio_descriptor *pgio,
 			struct inode *inode, bool force_mds,
 			const struct nfs_pgio_completion_ops *compl_ops);
+struct nfs_readdesc {
+	struct nfs_pageio_descriptor pgio;
+	struct nfs_open_context *ctx;
+};
+extern int readpage_async_filler(void *data, struct page *page);
+extern void nfs_pageio_complete_read(struct nfs_pageio_descriptor *pgio,
+				     struct inode *inode);
 extern void nfs_read_prepare(struct rpc_task *task, void *calldata);
 extern void nfs_pageio_reset_read_mds(struct nfs_pageio_descriptor *pgio);
 
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index c2df4040f26c..13266eda8f60 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -30,7 +30,7 @@
 
 #define NFSDBG_FACILITY		NFSDBG_PAGECACHE
 
-static const struct nfs_pgio_completion_ops nfs_async_read_completion_ops;
+const struct nfs_pgio_completion_ops nfs_async_read_completion_ops;
 static const struct nfs_rw_ops nfs_rw_read_ops;
 
 static struct kmem_cache *nfs_rdata_cachep;
@@ -74,7 +74,7 @@ void nfs_pageio_init_read(struct nfs_pageio_descriptor *pgio,
 }
 EXPORT_SYMBOL_GPL(nfs_pageio_init_read);
 
-static void nfs_pageio_complete_read(struct nfs_pageio_descriptor *pgio,
+void nfs_pageio_complete_read(struct nfs_pageio_descriptor *pgio,
 				     struct inode *inode)
 {
 	struct nfs_pgio_mirror *pgm;
@@ -132,11 +132,6 @@ static void nfs_readpage_release(struct nfs_page *req, int error)
 	nfs_release_request(req);
 }
 
-struct nfs_readdesc {
-	struct nfs_pageio_descriptor pgio;
-	struct nfs_open_context *ctx;
-};
-
 static void nfs_page_group_set_uptodate(struct nfs_page *req)
 {
 	if (nfs_page_group_sync_on_bit(req, PG_UPTODATE))
@@ -215,7 +210,7 @@ nfs_async_read_error(struct list_head *head, int error)
 	}
 }
 
-static const struct nfs_pgio_completion_ops nfs_async_read_completion_ops = {
+const struct nfs_pgio_completion_ops nfs_async_read_completion_ops = {
 	.error_cleanup = nfs_async_read_error,
 	.completion = nfs_read_completion,
 };
@@ -290,7 +285,7 @@ static void nfs_readpage_result(struct rpc_task *task,
 		nfs_readpage_retry(task, hdr);
 }
 
-static int
+int
 readpage_async_filler(void *data, struct page *page)
 {
 	struct nfs_readdesc *desc = (struct nfs_readdesc *)data;


