Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F034302F37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 23:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732887AbhAYVff (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 16:35:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46748 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732837AbhAYVeQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:34:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611610367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hX62zxZiL5wAvS6FKZw3P4+KXmTSpb/ti3ySPUoRqzI=;
        b=CrVtPiOCLsfIixv9zZ61/nmCiF/5D/OHEQa4pYM87xyaQVJSMHGbVPRldy/p43YT82ZMWg
        IG6XaWjkNGc5jKC9r01bekR+nNXf6/moz3U6mSFNnr0P6ETBSRm5pP++B3z7swG990JVz9
        VEr5xpYbdublLWG2oeE/LIE3WLR8QxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-i9y9N7isP7W83uOUb9bN0w-1; Mon, 25 Jan 2021 16:32:43 -0500
X-MC-Unique: i9y9N7isP7W83uOUb9bN0w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6A0A802B40;
        Mon, 25 Jan 2021 21:32:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2348460938;
        Mon, 25 Jan 2021 21:32:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 09/32] netfs: Add write_begin helper
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 25 Jan 2021 21:32:35 +0000
Message-ID: <161161035539.2537118.15674887534950908530.stgit@warthog.procyon.org.uk>
In-Reply-To: <161161025063.2537118.2009249444682241405.stgit@warthog.procyon.org.uk>
References: <161161025063.2537118.2009249444682241405.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a helper to do the pre-reading work for the netfs write_begin address
space op.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/netfs/internal.h          |    2 +
 fs/netfs/read_helper.c       |  165 ++++++++++++++++++++++++++++++++++++++++++
 fs/netfs/stats.c             |   10 ++-
 include/linux/netfs.h        |    8 ++
 include/trace/events/netfs.h |    4 +
 5 files changed, 185 insertions(+), 4 deletions(-)

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 98b6f4516da1..b7f2c4459f33 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -34,8 +34,10 @@ extern atomic_t netfs_n_rh_read_failed;
 extern atomic_t netfs_n_rh_zero;
 extern atomic_t netfs_n_rh_short_read;
 extern atomic_t netfs_n_rh_write;
+extern atomic_t netfs_n_rh_write_begin;
 extern atomic_t netfs_n_rh_write_done;
 extern atomic_t netfs_n_rh_write_failed;
+extern atomic_t netfs_n_rh_write_zskip;
 
 
 static inline void netfs_stat(atomic_t *stat)
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 275ac37e2834..eb34c368617d 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -760,3 +760,168 @@ int netfs_readpage(struct file *file,
 	return ret;
 }
 EXPORT_SYMBOL(netfs_readpage);
+
+static void netfs_clear_thp(struct page *page)
+{
+	unsigned int i;
+
+	for (i = 0; i < thp_nr_pages(page); i++)
+		clear_highpage(page + i);
+}
+
+/**
+ * netfs_write_begin - Helper to prepare for writing
+ * @file: The file to read from
+ * @mapping: The mapping to read from
+ * @pos: File position at which the write will begin
+ * @len: The length of the write in this page
+ * @flags: AOP_* flags
+ * @_page: Where to put the resultant page
+ * @_fsdata: Place for the netfs to store a cookie
+ * @ops: The network filesystem's operations for the helper to use
+ * @netfs_priv: Private netfs data to be retained in the request
+ *
+ * Pre-read data for a write-begin request by drawing data from the cache if
+ * possible, or the netfs if not.  Space beyond the EOF is zero-filled.
+ * Multiple I/O requests from different sources will get munged together.  If
+ * necessary, the readahead window can be expanded in either direction to a
+ * more convenient alighment for RPC efficiency or to make storage in the cache
+ * feasible.
+ *
+ * The calling netfs must provide a table of operations, only one of which,
+ * issue_op, is mandatory.
+ *
+ * The check_write_begin() operation can be provided to check for and flush
+ * conflicting writes once the page is grabbed and locked.  It is passed a
+ * pointer to the fsdata cookie that gets returned to the VM to be passed to
+ * write_end.  It is permitted to sleep.  It should return 0 if the request
+ * should go ahead; unlock the page and return -EAGAIN to cause the page to be
+ * regot; or return an error.
+ *
+ * This is usable whether or not caching is enabled.
+ */
+int netfs_write_begin(struct file *file, struct address_space *mapping,
+		      loff_t pos, unsigned int len, unsigned int flags,
+		      struct page **_page, void **_fsdata,
+		      const struct netfs_read_request_ops *ops,
+		      void *netfs_priv)
+{
+	struct netfs_read_request *rreq;
+	struct page *page, *xpage;
+	struct inode *inode = file_inode(file);
+	unsigned int debug_index = 0;
+	pgoff_t index = pos >> PAGE_SHIFT;
+	int pos_in_page = pos & ~PAGE_MASK;
+	loff_t size;
+	int ret;
+
+	struct readahead_control ractl = {
+		.file		= file,
+		.mapping	= mapping,
+		._index		= index,
+		._nr_pages	= 0,
+	};
+
+retry:
+	page = grab_cache_page_write_begin(mapping, index, 0);
+	if (!page)
+		return -ENOMEM;
+
+	if (ops->check_write_begin) {
+		/* Allow the netfs (eg. ceph) to flush conflicts. */
+		ret = ops->check_write_begin(file, pos, len, page, _fsdata);
+		if (ret < 0) {
+			if (ret == -EAGAIN)
+				goto retry;
+			goto error;
+		}
+	}
+
+	if (PageUptodate(page))
+		goto have_page;
+
+	/* If the page is beyond the EOF, we want to clear it - unless it's
+	 * within the cache granule containing the EOF, in which case we need
+	 * to preload the granule.
+	 */
+	size = i_size_read(inode);
+	if (!ops->is_cache_enabled(inode) &&
+	    ((pos_in_page == 0 && len == thp_size(page)) ||
+	     (pos >= size) ||
+	     (pos_in_page == 0 && (pos + len) >= size))) {
+		netfs_clear_thp(page);
+		SetPageUptodate(page);
+		netfs_stat(&netfs_n_rh_write_zskip);
+		goto have_page_no_wait;
+	}
+
+	ret = -ENOMEM;
+	rreq = netfs_alloc_read_request(ops, netfs_priv, file);
+	if (!rreq)
+		goto error;
+	rreq->mapping		= page->mapping;
+	rreq->start		= page->index * PAGE_SIZE;
+	rreq->len		= thp_size(page);
+	rreq->no_unlock_page	= page->index;
+	__set_bit(NETFS_RREQ_NO_UNLOCK_PAGE, &rreq->flags);
+	netfs_priv = NULL;
+
+	netfs_stat(&netfs_n_rh_write_begin);
+	trace_netfs_read(rreq, pos, len, netfs_read_trace_write_begin);
+
+	/* Expand the request to meet caching requirements and download
+	 * preferences.
+	 */
+	ractl._nr_pages = thp_nr_pages(page);
+	netfs_rreq_expand(rreq, &ractl);
+	netfs_get_read_request(rreq);
+
+	/* We hold the page locks, so we can drop the references */
+	while ((xpage = readahead_page(&ractl)))
+		if (xpage != page)
+			put_page(xpage);
+
+	atomic_set(&rreq->nr_rd_ops, 1);
+	do {
+		if (!netfs_rreq_submit_slice(rreq, &debug_index))
+			break;
+
+	} while (rreq->submitted < rreq->len);
+
+	// TODO: If we didn't submit enough readage, we need to clean up
+
+	/* Keep nr_rd_ops incremented so that the ref always belongs to us, and
+	 * the service code isn't punted off to a random thread pool to
+	 * process.
+	 */
+	for (;;) {
+		wait_var_event(&rreq->nr_rd_ops, atomic_read(&rreq->nr_rd_ops) == 1);
+		netfs_rreq_assess(rreq);
+		if (!test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags))
+			break;
+		cond_resched();
+	}
+
+	ret = rreq->error;
+	netfs_put_read_request(rreq);
+	if (ret < 0)
+		goto error;
+
+have_page:
+	wait_on_page_fscache(page);
+have_page_no_wait:
+	if (netfs_priv)
+		ops->cleanup(netfs_priv, mapping);
+	*_page = page;
+	_leave(" = 0");
+	return 0;
+
+error:
+	unlock_page(page);
+	put_page(page);
+	if (netfs_priv)
+		ops->cleanup(netfs_priv, mapping);
+	_leave(" = %d", ret);
+	return ret;
+}
+EXPORT_SYMBOL(netfs_write_begin);
diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
index df6ff5718f25..dd7ad66ed07e 100644
--- a/fs/netfs/stats.c
+++ b/fs/netfs/stats.c
@@ -24,19 +24,23 @@ atomic_t netfs_n_rh_read_failed;
 atomic_t netfs_n_rh_zero;
 atomic_t netfs_n_rh_short_read;
 atomic_t netfs_n_rh_write;
+atomic_t netfs_n_rh_write_begin;
 atomic_t netfs_n_rh_write_done;
 atomic_t netfs_n_rh_write_failed;
+atomic_t netfs_n_rh_write_zskip;
 
 void netfs_stats_show(struct seq_file *m)
 {
-	seq_printf(m, "RdHelp : RA=%u RP=%u rr=%u sr=%u\n",
+	seq_printf(m, "RdHelp : RA=%u RP=%u WB=%u rr=%u sr=%u\n",
 		   atomic_read(&netfs_n_rh_readahead),
 		   atomic_read(&netfs_n_rh_readpage),
+		   atomic_read(&netfs_n_rh_write_begin),
 		   atomic_read(&netfs_n_rh_rreq),
 		   atomic_read(&netfs_n_rh_sreq));
-	seq_printf(m, "RdHelp : ZR=%u sh=%u\n",
+	seq_printf(m, "RdHelp : ZR=%u sh=%u sk=%u\n",
 		   atomic_read(&netfs_n_rh_zero),
-		   atomic_read(&netfs_n_rh_short_read));
+		   atomic_read(&netfs_n_rh_short_read),
+		   atomic_read(&netfs_n_rh_write_zskip));
 	seq_printf(m, "RdHelp : DL=%u ds=%u df=%u di=%u\n",
 		   atomic_read(&netfs_n_rh_download),
 		   atomic_read(&netfs_n_rh_download_done),
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 92a08d8b8e61..5b54f6637c22 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -87,11 +87,14 @@ struct netfs_read_request {
  * Operations the network filesystem can/must provide to the helpers.
  */
 struct netfs_read_request_ops {
+	bool (*is_cache_enabled)(struct inode *inode);
 	void (*init_rreq)(struct netfs_read_request *rreq, struct file *file);
 	void (*expand_readahead)(struct netfs_read_request *rreq);
 	bool (*clamp_length)(struct netfs_read_subrequest *subreq);
 	void (*issue_op)(struct netfs_read_subrequest *subreq);
 	bool (*is_still_valid)(struct netfs_read_request *rreq);
+	int (*check_write_begin)(struct file *file, loff_t pos, unsigned len,
+				 struct page *page, void **_fsdata);
 	void (*done)(struct netfs_read_request *rreq);
 	void (*cleanup)(struct address_space *mapping, void *netfs_priv);
 };
@@ -104,6 +107,11 @@ extern int netfs_readpage(struct file *,
 			  struct page *,
 			  const struct netfs_read_request_ops *,
 			  void *);
+extern int netfs_write_begin(struct file *, struct address_space *,
+			     loff_t, unsigned int, unsigned int, struct page **,
+			     void **,
+			     const struct netfs_read_request_ops *,
+			     void *);
 
 extern void netfs_subreq_terminated(struct netfs_read_subrequest *, ssize_t);
 extern void netfs_stats_show(struct seq_file *);
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 12ad382764c5..a2bf6cd84bd4 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -22,6 +22,7 @@ enum netfs_read_trace {
 	netfs_read_trace_expanded,
 	netfs_read_trace_readahead,
 	netfs_read_trace_readpage,
+	netfs_read_trace_write_begin,
 };
 
 enum netfs_rreq_trace {
@@ -50,7 +51,8 @@ enum netfs_sreq_trace {
 #define netfs_read_traces					\
 	EM(netfs_read_trace_expanded,		"EXPANDED ")	\
 	EM(netfs_read_trace_readahead,		"READAHEAD")	\
-	E_(netfs_read_trace_readpage,		"READPAGE ")
+	EM(netfs_read_trace_readpage,		"READPAGE ")	\
+	E_(netfs_read_trace_write_begin,	"WRITEBEGN")
 
 #define netfs_rreq_traces					\
 	EM(netfs_rreq_trace_assess,		"ASSESS")	\


