Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2945302E7F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 22:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733071AbhAYV4s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 16:56:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30319 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732775AbhAYViE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:38:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611610598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PdWJ4bVY9thyqHryVHuwVIJS4CpzrVpasqjIys1aHWc=;
        b=dbL3rbq3lk63pGRn9PAM2BvaD2DBvsKl6lq4d+dOlR7p0o6xk0FmUnud8qlsyXU6uVT8Jy
        blTeVRumHUxRE+bYXLQjRnoZGPUZR5T7jhS0/qQ/9JfsM9PQOlZEs+HkqnPIdaPg3Lcy4j
        44aBtVo7/efNky+Yd+RldYewBn0MyZ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-XhdXvk5IOuuHds0NLC6eMQ-1; Mon, 25 Jan 2021 16:36:35 -0500
X-MC-Unique: XhdXvk5IOuuHds0NLC6eMQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E5521015EC7;
        Mon, 25 Jan 2021 21:36:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 758107445D;
        Mon, 25 Jan 2021 21:36:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 28/32] NFS: Call readpage_async_filler() from
 nfs_readpage_async()
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
Date:   Mon, 25 Jan 2021 21:36:25 +0000
Message-ID: <161161058568.2537118.17174981646903311352.stgit@warthog.procyon.org.uk>
In-Reply-To: <161161025063.2537118.2009249444682241405.stgit@warthog.procyon.org.uk>
References: <161161025063.2537118.2009249444682241405.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Wysochanski <dwysocha@redhat.com>

Refactor slightly so nfs_readpage_async() calls into
readpage_async_filler().

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---

 fs/nfs/read.c |   28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 5fda30742a32..1401f1c734c0 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -119,31 +119,22 @@ struct nfs_readdesc {
 	struct nfs_open_context *ctx;
 };
 
+static int readpage_async_filler(void *data, struct page *page);
+
 int nfs_readpage_async(void *data, struct inode *inode,
 		       struct page *page)
 {
 	struct nfs_readdesc *desc = (struct nfs_readdesc *)data;
-	struct nfs_page	*new;
-	unsigned int len;
 	struct nfs_pgio_mirror *pgm;
-
-	len = nfs_page_length(page);
-	if (len == 0)
-		return nfs_return_empty_page(page);
-	new = nfs_create_request(desc->ctx, page, 0, len);
-	if (IS_ERR(new)) {
-		unlock_page(page);
-		return PTR_ERR(new);
-	}
-	if (len < PAGE_SIZE)
-		zero_user_segment(page, len, PAGE_SIZE);
+	int error;
 
 	nfs_pageio_init_read(&desc->pgio, inode, false,
 			     &nfs_async_read_completion_ops);
-	if (!nfs_pageio_add_request(&desc->pgio, new)) {
-		nfs_list_remove_request(new);
-		nfs_readpage_release(new, desc->pgio.pg_error);
-	}
+
+	error = readpage_async_filler(desc, page);
+	if (error)
+		goto out;
+
 	nfs_pageio_complete(&desc->pgio);
 
 	/* It doesn't make sense to do mirrored reads! */
@@ -153,6 +144,9 @@ int nfs_readpage_async(void *data, struct inode *inode,
 	NFS_I(inode)->read_io += pgm->pg_bytes_written;
 
 	return desc->pgio.pg_error < 0 ? desc->pgio.pg_error : 0;
+
+out:
+	return error;
 }
 
 static void nfs_page_group_set_uptodate(struct nfs_page *req)


