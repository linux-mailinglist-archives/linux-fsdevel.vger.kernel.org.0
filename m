Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF84302E2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 22:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732185AbhAYVmw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 16:42:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56696 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732848AbhAYVjK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:39:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611610664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4T/NCmOwpTvfjisoFVZVBFBrB6mhRWN9E1pl6sQ/jqc=;
        b=Luqq31Zds39nDiiI/aWhyzxtrXRoZG5Iw2rsSVozMHMVpXbo1NTW98D9/L7k0ac0P1d8+Q
        5p9gJzxA2++zrxO7DQtDUHXJ/iEevsyRVUpIvkedDNF+ATn1WAcO4zJLKao8eK89CExdKb
        2PMyMTE0ppKaQdUdhnXpopTv+x0gUfc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-FTtws04MMQK32BrYsVEVWw-1; Mon, 25 Jan 2021 16:37:42 -0500
X-MC-Unique: FTtws04MMQK32BrYsVEVWw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 453ED8030D8;
        Mon, 25 Jan 2021 21:37:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 59E3F5D6DC;
        Mon, 25 Jan 2021 21:37:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 32/32] NFS: Convert readpage to readahead and use
 netfs_readahead for fscache
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
Date:   Mon, 25 Jan 2021 21:37:29 +0000
Message-ID: <161161064956.2537118.3354798147866150631.stgit@warthog.procyon.org.uk>
In-Reply-To: <161161025063.2537118.2009249444682241405.stgit@warthog.procyon.org.uk>
References: <161161025063.2537118.2009249444682241405.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Wysochanski <dwysocha@redhat.com>

The new FS-Cache API does not have a readpages equivalent function,
and instead of fscache_read_or_alloc_pages() it implements a readahead
function, netfs_readahead().  Call netfs_readahead() if fscache is
enabled, and if not, utilize readahead_page() to run through the
pages needed calling readpage_async_filler().

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---

 fs/nfs/file.c              |    2 +-
 fs/nfs/fscache.c           |   49 +++++++-------------------------------------
 fs/nfs/fscache.h           |   28 +++++++++----------------
 fs/nfs/read.c              |   32 ++++++++++++++---------------
 include/linux/nfs_fs.h     |    3 +--
 include/linux/nfs_iostat.h |    2 +-
 6 files changed, 37 insertions(+), 79 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 63940a7a70be..ebcaa164db5f 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -515,7 +515,7 @@ static void nfs_swap_deactivate(struct file *file)
 
 const struct address_space_operations nfs_file_aops = {
 	.readpage = nfs_readpage,
-	.readpages = nfs_readpages,
+	.readahead = nfs_readahead,
 	.set_page_dirty = __set_page_dirty_nobuffers,
 	.writepage = nfs_writepage,
 	.writepages = nfs_writepages,
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index d3445bb1cc9c..b432bf931470 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -499,51 +499,18 @@ int __nfs_readpage_from_fscache(struct file *filp,
 /*
  * Retrieve a set of pages from fscache
  */
-int __nfs_readpages_from_fscache(struct nfs_open_context *ctx,
-				 struct inode *inode,
-				 struct address_space *mapping,
-				 struct list_head *pages,
-				 unsigned *nr_pages)
+int __nfs_readahead_from_fscache(struct nfs_readdesc *desc,
+				 struct readahead_control *rac)
 {
-	unsigned npages = *nr_pages;
-	int ret;
+	struct inode *inode = rac->mapping->host;
 
-	dfprintk(FSCACHE, "NFS: nfs_getpages_from_fscache (0x%p/%u/0x%p)\n",
-		 nfs_i_fscache(inode), npages, inode);
-
-	ret = fscache_read_or_alloc_pages(nfs_i_fscache(inode),
-					  mapping, pages, nr_pages,
-					  nfs_readpage_from_fscache_complete,
-					  ctx,
-					  mapping_gfp_mask(mapping));
-	if (*nr_pages < npages)
-		nfs_add_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_OK,
-				      npages);
-	if (*nr_pages > 0)
-		nfs_add_fscache_stats(inode, NFSIOS_FSCACHE_PAGES_READ_FAIL,
-				      *nr_pages);
+	dfprintk(FSCACHE, "NFS: nfs_readahead_from_fscache (0x%p/0x%p)\n",
+		 nfs_i_fscache(inode), inode);
 
-	switch (ret) {
-	case 0: /* read submitted to the cache for all pages */
-		BUG_ON(!list_empty(pages));
-		BUG_ON(*nr_pages != 0);
-		dfprintk(FSCACHE,
-			 "NFS: nfs_getpages_from_fscache: submitted\n");
+	netfs_readahead(rac, &nfs_fscache_req_ops, desc);
 
-		return ret;
-
-	case -ENOBUFS: /* some pages aren't cached and can't be */
-	case -ENODATA: /* some pages aren't cached */
-		dfprintk(FSCACHE,
-			 "NFS: nfs_getpages_from_fscache: no page: %d\n", ret);
-		return 1;
-
-	default:
-		dfprintk(FSCACHE,
-			 "NFS: nfs_getpages_from_fscache: ret  %d\n", ret);
-	}
-
-	return ret;
+	/* FIXME: NFSIOS_NFSIOS_FSCACHE_ stats */
+	return 0;
 }
 
 /*
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 4a76a5f31772..d095e513af12 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -98,11 +98,10 @@ extern int nfs_fscache_release_page(struct page *, gfp_t);
 extern int __nfs_readpage_from_fscache(struct file *filp,
 				       struct page *page,
 				       struct nfs_readdesc *desc);
-extern int __nfs_readpages_from_fscache(struct nfs_open_context *,
-					struct inode *, struct address_space *,
-					struct list_head *, unsigned *);
-extern void __nfs_readpage_to_fscache(struct inode *, struct page *, int);
-
+extern int __nfs_readahead_from_fscache(struct nfs_readdesc *desc,
+					struct readahead_control *rac);
+extern void __nfs_read_completion_to_fscache(struct nfs_pgio_header *hdr,
+					     unsigned long bytes);
 /*
  * wait for a page to complete writing to the cache
  */
@@ -139,15 +138,11 @@ static inline int nfs_readpage_from_fscache(struct file *filp,
 /*
  * Retrieve a set of pages from an inode data storage object.
  */
-static inline int nfs_readpages_from_fscache(struct nfs_open_context *ctx,
-					     struct inode *inode,
-					     struct address_space *mapping,
-					     struct list_head *pages,
-					     unsigned *nr_pages)
+static inline int nfs_readahead_from_fscache(struct nfs_readdesc *desc,
+					     struct readahead_control *rac)
 {
-	if (NFS_I(inode)->fscache)
-		return __nfs_readpages_from_fscache(ctx, inode, mapping, pages,
-						    nr_pages);
+	if (NFS_I(rac->mapping->host)->fscache)
+		return __nfs_readahead_from_fscache(desc, rac);
 	return -ENOBUFS;
 }
 
@@ -217,11 +212,8 @@ static inline int nfs_readpage_from_fscache(struct file *filp,
 {
 	return -ENOBUFS;
 }
-static inline int nfs_readpages_from_fscache(struct nfs_open_context *ctx,
-					     struct inode *inode,
-					     struct address_space *mapping,
-					     struct list_head *pages,
-					     unsigned *nr_pages)
+static inline int nfs_readahead_from_fscache(struct nfs_readdesc *desc,
+					     struct readahead_control *rac)
 {
 	return -ENOBUFS;
 }
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 7a76ab474fe0..da44ce68488c 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -390,50 +390,50 @@ int nfs_readpage(struct file *filp, struct page *page)
 	return ret;
 }
 
-int nfs_readpages(struct file *filp, struct address_space *mapping,
-		struct list_head *pages, unsigned nr_pages)
+void nfs_readahead(struct readahead_control *rac)
 {
 	struct nfs_readdesc desc;
-	struct inode *inode = mapping->host;
+	struct inode *inode = rac->mapping->host;
+	struct page *page;
 	int ret;
 
-	dprintk("NFS: nfs_readpages (%s/%Lu %d)\n",
-			inode->i_sb->s_id,
-			(unsigned long long)NFS_FILEID(inode),
-			nr_pages);
+	dprintk("NFS: %s (%s/%llu %lld)\n", __func__,
+		inode->i_sb->s_id,
+		(unsigned long long)NFS_FILEID(inode),
+		readahead_length(rac));
 	nfs_inc_stats(inode, NFSIOS_VFSREADPAGES);
 
 	ret = -ESTALE;
 	if (NFS_STALE(inode))
-		goto out;
+		return;
 
-	if (filp == NULL) {
+	if (rac->file == NULL) {
 		ret = -EBADF;
 		desc.ctx = nfs_find_open_context(inode, NULL, FMODE_READ);
 		if (desc.ctx == NULL)
-			goto out;
+			return;
 	} else
-		desc.ctx = get_nfs_open_context(nfs_file_open_context(filp));
+		desc.ctx = get_nfs_open_context(nfs_file_open_context(rac->file));
 
 	/* attempt to read as many of the pages as possible from the cache
 	 * - this returns -ENOBUFS immediately if the cookie is negative
 	 */
-	ret = nfs_readpages_from_fscache(desc.ctx, inode, mapping,
-					 pages, &nr_pages);
+	ret = nfs_readahead_from_fscache(&desc, rac);
 	if (ret == 0)
 		goto read_complete; /* all pages were read */
 
 	nfs_pageio_init_read(&desc.pgio, inode, false,
 			     &nfs_async_read_completion_ops);
 
-	ret = read_cache_pages(mapping, pages, readpage_async_filler, &desc);
+	while ((page = readahead_page(rac))) {
+		ret = readpage_async_filler(&desc, page);
+		put_page(page);
+	}
 
 	nfs_pageio_complete_read(&desc.pgio, inode);
 
 read_complete:
 	put_nfs_open_context(desc.ctx);
-out:
-	return ret;
 }
 
 int __init nfs_init_readpagecache(void)
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 3cfcf219e96b..968c79b1b09b 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -568,8 +568,7 @@ nfs_have_writebacks(struct inode *inode)
  * linux/fs/nfs/read.c
  */
 extern int  nfs_readpage(struct file *, struct page *);
-extern int  nfs_readpages(struct file *, struct address_space *,
-		struct list_head *, unsigned);
+extern void nfs_readahead(struct readahead_control *rac);
 
 /*
  * inline functions
diff --git a/include/linux/nfs_iostat.h b/include/linux/nfs_iostat.h
index 027874c36c88..8baf8fb7551d 100644
--- a/include/linux/nfs_iostat.h
+++ b/include/linux/nfs_iostat.h
@@ -53,7 +53,7 @@
  * NFS page counters
  *
  * These count the number of pages read or written via nfs_readpage(),
- * nfs_readpages(), or their write equivalents.
+ * nfs_readahead(), or their write equivalents.
  *
  * NB: When adding new byte counters, please include the measured
  * units in the name of each byte counter to help users of this


