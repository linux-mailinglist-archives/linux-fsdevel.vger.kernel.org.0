Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A98302E7B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 22:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732800AbhAYViJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 16:38:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49352 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733003AbhAYVhy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:37:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611610587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9AGQ+mfuWZPgf1o7G9jfH2wEhkq5VbnMNcHJv95un4U=;
        b=Om50DTCzizUvw71Prf2Pv/ks/IEzoP+EqfbcOMfgscnlhYLlwpDzsC5zR5IUtRNTCCcTTu
        8SWyV0MXHnzJU56Hga3IxB5cMnwtlDAsdeJe++071LUp6J3Ia48DEPnzxeidIqxJVlZjsK
        GaepwbDW+/W8oDmxucJkAGFsoWJJZME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-_iuHzRAyM8qI7fQRD3qbTw-1; Mon, 25 Jan 2021 16:36:23 -0500
X-MC-Unique: _iuHzRAyM8qI7fQRD3qbTw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7081CCE64E;
        Mon, 25 Jan 2021 21:36:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6510A5C1C5;
        Mon, 25 Jan 2021 21:36:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 27/32] NFS: Refactor nfs_readpage() and nfs_readpage_async()
 to use nfs_readdesc
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
Date:   Mon, 25 Jan 2021 21:36:13 +0000
Message-ID: <161161057357.2537118.6542184374596533032.stgit@warthog.procyon.org.uk>
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

Both nfs_readpage() and nfs_readpages() use similar code.
This patch should be no functional change, and refactors
nfs_readpage_async() to use nfs_readdesc to enable future
merging of nfs_readpage_async() and nfs_readpage_async_filler().

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---

 fs/nfs/read.c          |   62 +++++++++++++++++++++++-------------------------
 include/linux/nfs_fs.h |    3 +-
 2 files changed, 31 insertions(+), 34 deletions(-)

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 1153c4e0a155..5fda30742a32 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -114,18 +114,23 @@ static void nfs_readpage_release(struct nfs_page *req, int error)
 	nfs_release_request(req);
 }
 
-int nfs_readpage_async(struct nfs_open_context *ctx, struct inode *inode,
+struct nfs_readdesc {
+	struct nfs_pageio_descriptor pgio;
+	struct nfs_open_context *ctx;
+};
+
+int nfs_readpage_async(void *data, struct inode *inode,
 		       struct page *page)
 {
+	struct nfs_readdesc *desc = (struct nfs_readdesc *)data;
 	struct nfs_page	*new;
 	unsigned int len;
-	struct nfs_pageio_descriptor pgio;
 	struct nfs_pgio_mirror *pgm;
 
 	len = nfs_page_length(page);
 	if (len == 0)
 		return nfs_return_empty_page(page);
-	new = nfs_create_request(ctx, page, 0, len);
+	new = nfs_create_request(desc->ctx, page, 0, len);
 	if (IS_ERR(new)) {
 		unlock_page(page);
 		return PTR_ERR(new);
@@ -133,21 +138,21 @@ int nfs_readpage_async(struct nfs_open_context *ctx, struct inode *inode,
 	if (len < PAGE_SIZE)
 		zero_user_segment(page, len, PAGE_SIZE);
 
-	nfs_pageio_init_read(&pgio, inode, false,
+	nfs_pageio_init_read(&desc->pgio, inode, false,
 			     &nfs_async_read_completion_ops);
-	if (!nfs_pageio_add_request(&pgio, new)) {
+	if (!nfs_pageio_add_request(&desc->pgio, new)) {
 		nfs_list_remove_request(new);
-		nfs_readpage_release(new, pgio.pg_error);
+		nfs_readpage_release(new, desc->pgio.pg_error);
 	}
-	nfs_pageio_complete(&pgio);
+	nfs_pageio_complete(&desc->pgio);
 
 	/* It doesn't make sense to do mirrored reads! */
-	WARN_ON_ONCE(pgio.pg_mirror_count != 1);
+	WARN_ON_ONCE(desc->pgio.pg_mirror_count != 1);
 
-	pgm = &pgio.pg_mirrors[0];
+	pgm = &desc->pgio.pg_mirrors[0];
 	NFS_I(inode)->read_io += pgm->pg_bytes_written;
 
-	return pgio.pg_error < 0 ? pgio.pg_error : 0;
+	return desc->pgio.pg_error < 0 ? desc->pgio.pg_error : 0;
 }
 
 static void nfs_page_group_set_uptodate(struct nfs_page *req)
@@ -312,7 +317,7 @@ static void nfs_readpage_result(struct rpc_task *task,
  */
 int nfs_readpage(struct file *filp, struct page *page)
 {
-	struct nfs_open_context *ctx;
+	struct nfs_readdesc desc;
 	struct inode *inode = page_file_mapping(page)->host;
 	int ret;
 
@@ -339,39 +344,34 @@ int nfs_readpage(struct file *filp, struct page *page)
 
 	if (filp == NULL) {
 		ret = -EBADF;
-		ctx = nfs_find_open_context(inode, NULL, FMODE_READ);
-		if (ctx == NULL)
+		desc.ctx = nfs_find_open_context(inode, NULL, FMODE_READ);
+		if (desc.ctx == NULL)
 			goto out_unlock;
 	} else
-		ctx = get_nfs_open_context(nfs_file_open_context(filp));
+		desc.ctx = get_nfs_open_context(nfs_file_open_context(filp));
 
 	if (!IS_SYNC(inode)) {
-		ret = nfs_readpage_from_fscache(ctx, inode, page);
+		ret = nfs_readpage_from_fscache(desc.ctx, inode, page);
 		if (ret == 0)
 			goto out;
 	}
 
-	xchg(&ctx->error, 0);
-	ret = nfs_readpage_async(ctx, inode, page);
+	xchg(&desc.ctx->error, 0);
+	ret = nfs_readpage_async(&desc, inode, page);
 	if (!ret) {
 		ret = wait_on_page_locked_killable(page);
 		if (!PageUptodate(page) && !ret)
-			ret = xchg(&ctx->error, 0);
+			ret = xchg(&desc.ctx->error, 0);
 	}
 	nfs_add_stats(inode, NFSIOS_READPAGES, 1);
 out:
-	put_nfs_open_context(ctx);
+	put_nfs_open_context(desc.ctx);
 	return ret;
 out_unlock:
 	unlock_page(page);
 	return ret;
 }
 
-struct nfs_readdesc {
-	struct nfs_pageio_descriptor *pgio;
-	struct nfs_open_context *ctx;
-};
-
 static int
 readpage_async_filler(void *data, struct page *page)
 {
@@ -390,9 +390,9 @@ readpage_async_filler(void *data, struct page *page)
 
 	if (len < PAGE_SIZE)
 		zero_user_segment(page, len, PAGE_SIZE);
-	if (!nfs_pageio_add_request(desc->pgio, new)) {
+	if (!nfs_pageio_add_request(&desc->pgio, new)) {
 		nfs_list_remove_request(new);
-		error = desc->pgio->pg_error;
+		error = desc->pgio.pg_error;
 		nfs_readpage_release(new, error);
 		goto out;
 	}
@@ -407,7 +407,6 @@ readpage_async_filler(void *data, struct page *page)
 int nfs_readpages(struct file *filp, struct address_space *mapping,
 		struct list_head *pages, unsigned nr_pages)
 {
-	struct nfs_pageio_descriptor pgio;
 	struct nfs_pgio_mirror *pgm;
 	struct nfs_readdesc desc;
 	struct inode *inode = mapping->host;
@@ -440,17 +439,16 @@ int nfs_readpages(struct file *filp, struct address_space *mapping,
 	if (ret == 0)
 		goto read_complete; /* all pages were read */
 
-	desc.pgio = &pgio;
-	nfs_pageio_init_read(&pgio, inode, false,
+	nfs_pageio_init_read(&desc.pgio, inode, false,
 			     &nfs_async_read_completion_ops);
 
 	ret = read_cache_pages(mapping, pages, readpage_async_filler, &desc);
-	nfs_pageio_complete(&pgio);
+	nfs_pageio_complete(&desc.pgio);
 
 	/* It doesn't make sense to do mirrored reads! */
-	WARN_ON_ONCE(pgio.pg_mirror_count != 1);
+	WARN_ON_ONCE(desc.pgio.pg_mirror_count != 1);
 
-	pgm = &pgio.pg_mirrors[0];
+	pgm = &desc.pgio.pg_mirrors[0];
 	NFS_I(inode)->read_io += pgm->pg_bytes_written;
 	npages = (pgm->pg_bytes_written + PAGE_SIZE - 1) >>
 		 PAGE_SHIFT;
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 681ed98e4ba8..cb0248a34518 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -570,8 +570,7 @@ nfs_have_writebacks(struct inode *inode)
 extern int  nfs_readpage(struct file *, struct page *);
 extern int  nfs_readpages(struct file *, struct address_space *,
 		struct list_head *, unsigned);
-extern int  nfs_readpage_async(struct nfs_open_context *, struct inode *,
-			       struct page *);
+extern int  nfs_readpage_async(void *, struct inode *, struct page *);
 
 /*
  * inline functions


