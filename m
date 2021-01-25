Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBA1302E48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 22:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732528AbhAYVsJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 16:48:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35520 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733003AbhAYVin (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:38:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611610635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MXc4nZxzaqSxiNr4bz5Y+7eQVFLxJ+/iZUIvYnTahv8=;
        b=QKh9ypPjUa8msb2whO9mSYOStldd/mYqDVOR6IK9Y4foBHMA7zIClbP7agheyrADCjZMle
        XSwKjYyOHmcUWoOUGcg8ovR3mojkz6a5gMO8vTL94JttEVsdNRH4yNlNrEaytQ4J8P+jh1
        7iht3iepYDG/45avhbIVmE+POlRTvTw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-g042gAoRN1W5oniJ3QZJjA-1; Mon, 25 Jan 2021 16:37:11 -0500
X-MC-Unique: g042gAoRN1W5oniJ3QZJjA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4E0B835E18;
        Mon, 25 Jan 2021 21:37:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F456105C722;
        Mon, 25 Jan 2021 21:36:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 29/32] NFS: Add nfs_pageio_complete_read() and remove
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
Date:   Mon, 25 Jan 2021 21:36:38 +0000
Message-ID: <161161059859.2537118.3305621799356778773.stgit@warthog.procyon.org.uk>
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

Add nfs_pageio_complete_read() and call this from both nfs_readpage()
and nfs_readpages(), since the submission and accounting is the same
for both functions.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---

 fs/nfs/read.c          |  137 +++++++++++++++++++++---------------------------
 include/linux/nfs_fs.h |    1 
 2 files changed, 61 insertions(+), 77 deletions(-)

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 1401f1c734c0..c2df4040f26c 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -74,6 +74,24 @@ void nfs_pageio_init_read(struct nfs_pageio_descriptor *pgio,
 }
 EXPORT_SYMBOL_GPL(nfs_pageio_init_read);
 
+static void nfs_pageio_complete_read(struct nfs_pageio_descriptor *pgio,
+				     struct inode *inode)
+{
+	struct nfs_pgio_mirror *pgm;
+	unsigned long npages;
+
+	nfs_pageio_complete(pgio);
+
+	/* It doesn't make sense to do mirrored reads! */
+	WARN_ON_ONCE(pgio->pg_mirror_count != 1);
+
+	pgm = &pgio->pg_mirrors[0];
+	NFS_I(inode)->read_io += pgm->pg_bytes_written;
+	npages = (pgm->pg_bytes_written + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	nfs_add_stats(inode, NFSIOS_READPAGES, npages);
+}
+
+
 void nfs_pageio_reset_read_mds(struct nfs_pageio_descriptor *pgio)
 {
 	struct nfs_pgio_mirror *mirror;
@@ -119,36 +137,6 @@ struct nfs_readdesc {
 	struct nfs_open_context *ctx;
 };
 
-static int readpage_async_filler(void *data, struct page *page);
-
-int nfs_readpage_async(void *data, struct inode *inode,
-		       struct page *page)
-{
-	struct nfs_readdesc *desc = (struct nfs_readdesc *)data;
-	struct nfs_pgio_mirror *pgm;
-	int error;
-
-	nfs_pageio_init_read(&desc->pgio, inode, false,
-			     &nfs_async_read_completion_ops);
-
-	error = readpage_async_filler(desc, page);
-	if (error)
-		goto out;
-
-	nfs_pageio_complete(&desc->pgio);
-
-	/* It doesn't make sense to do mirrored reads! */
-	WARN_ON_ONCE(desc->pgio.pg_mirror_count != 1);
-
-	pgm = &desc->pgio.pg_mirrors[0];
-	NFS_I(inode)->read_io += pgm->pg_bytes_written;
-
-	return desc->pgio.pg_error < 0 ? desc->pgio.pg_error : 0;
-
-out:
-	return error;
-}
-
 static void nfs_page_group_set_uptodate(struct nfs_page *req)
 {
 	if (nfs_page_group_sync_on_bit(req, PG_UPTODATE))
@@ -170,8 +158,7 @@ static void nfs_read_completion(struct nfs_pgio_header *hdr)
 
 		if (test_bit(NFS_IOHDR_EOF, &hdr->flags)) {
 			/* note: regions of the page not covered by a
-			 * request are zeroed in nfs_readpage_async /
-			 * readpage_async_filler */
+			 * request are zeroed in readpage_async_filler */
 			if (bytes > hdr->good_bytes) {
 				/* nothing in this request was good, so zero
 				 * the full extent of the request */
@@ -303,6 +290,38 @@ static void nfs_readpage_result(struct rpc_task *task,
 		nfs_readpage_retry(task, hdr);
 }
 
+static int
+readpage_async_filler(void *data, struct page *page)
+{
+	struct nfs_readdesc *desc = (struct nfs_readdesc *)data;
+	struct nfs_page *new;
+	unsigned int len;
+	int error;
+
+	len = nfs_page_length(page);
+	if (len == 0)
+		return nfs_return_empty_page(page);
+
+	new = nfs_create_request(desc->ctx, page, 0, len);
+	if (IS_ERR(new))
+		goto out_error;
+
+	if (len < PAGE_SIZE)
+		zero_user_segment(page, len, PAGE_SIZE);
+	if (!nfs_pageio_add_request(&desc->pgio, new)) {
+		nfs_list_remove_request(new);
+		error = desc->pgio.pg_error;
+		nfs_readpage_release(new, error);
+		goto out;
+	}
+	return 0;
+out_error:
+	error = PTR_ERR(new);
+	unlock_page(page);
+out:
+	return error;
+}
+
 /*
  * Read a page over NFS.
  * We read the page synchronously in the following case:
@@ -351,13 +370,20 @@ int nfs_readpage(struct file *filp, struct page *page)
 	}
 
 	xchg(&desc.ctx->error, 0);
-	ret = nfs_readpage_async(&desc, inode, page);
+	nfs_pageio_init_read(&desc.pgio, inode, false,
+			     &nfs_async_read_completion_ops);
+
+	ret = readpage_async_filler(&desc, page);
+
+	if (!ret)
+		nfs_pageio_complete_read(&desc.pgio, inode);
+
+	ret = desc.pgio.pg_error < 0 ? desc.pgio.pg_error : 0;
 	if (!ret) {
 		ret = wait_on_page_locked_killable(page);
 		if (!PageUptodate(page) && !ret)
 			ret = xchg(&desc.ctx->error, 0);
 	}
-	nfs_add_stats(inode, NFSIOS_READPAGES, 1);
 out:
 	put_nfs_open_context(desc.ctx);
 	return ret;
@@ -366,45 +392,11 @@ int nfs_readpage(struct file *filp, struct page *page)
 	return ret;
 }
 
-static int
-readpage_async_filler(void *data, struct page *page)
-{
-	struct nfs_readdesc *desc = (struct nfs_readdesc *)data;
-	struct nfs_page *new;
-	unsigned int len;
-	int error;
-
-	len = nfs_page_length(page);
-	if (len == 0)
-		return nfs_return_empty_page(page);
-
-	new = nfs_create_request(desc->ctx, page, 0, len);
-	if (IS_ERR(new))
-		goto out_error;
-
-	if (len < PAGE_SIZE)
-		zero_user_segment(page, len, PAGE_SIZE);
-	if (!nfs_pageio_add_request(&desc->pgio, new)) {
-		nfs_list_remove_request(new);
-		error = desc->pgio.pg_error;
-		nfs_readpage_release(new, error);
-		goto out;
-	}
-	return 0;
-out_error:
-	error = PTR_ERR(new);
-	unlock_page(page);
-out:
-	return error;
-}
-
 int nfs_readpages(struct file *filp, struct address_space *mapping,
 		struct list_head *pages, unsigned nr_pages)
 {
-	struct nfs_pgio_mirror *pgm;
 	struct nfs_readdesc desc;
 	struct inode *inode = mapping->host;
-	unsigned long npages;
 	int ret;
 
 	dprintk("NFS: nfs_readpages (%s/%Lu %d)\n",
@@ -437,16 +429,9 @@ int nfs_readpages(struct file *filp, struct address_space *mapping,
 			     &nfs_async_read_completion_ops);
 
 	ret = read_cache_pages(mapping, pages, readpage_async_filler, &desc);
-	nfs_pageio_complete(&desc.pgio);
 
-	/* It doesn't make sense to do mirrored reads! */
-	WARN_ON_ONCE(desc.pgio.pg_mirror_count != 1);
+	nfs_pageio_complete_read(&desc.pgio, inode);
 
-	pgm = &desc.pgio.pg_mirrors[0];
-	NFS_I(inode)->read_io += pgm->pg_bytes_written;
-	npages = (pgm->pg_bytes_written + PAGE_SIZE - 1) >>
-		 PAGE_SHIFT;
-	nfs_add_stats(inode, NFSIOS_READPAGES, npages);
 read_complete:
 	put_nfs_open_context(desc.ctx);
 out:
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index cb0248a34518..3cfcf219e96b 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -570,7 +570,6 @@ nfs_have_writebacks(struct inode *inode)
 extern int  nfs_readpage(struct file *, struct page *);
 extern int  nfs_readpages(struct file *, struct address_space *,
 		struct list_head *, unsigned);
-extern int  nfs_readpage_async(void *, struct inode *, struct page *);
 
 /*
  * inline functions


