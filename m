Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024FC334413
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 17:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbhCJQ47 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 11:56:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44468 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233634AbhCJQ41 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:56:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615395386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FPJX7b9dndGN393JTy0OyOUFEb/PbK+waIrfRf/dU0U=;
        b=I3BHJtpcy4yrI9qF/0MMZ/CxeYLQMq/TEDvfz6/XI5efEyAISkBJz0Ep9WFSebPLZ8KdlF
        wHAuIuKwO4g+tGrAdsaog4F6k9kPn1P7KFMp+ME34m1YUg7Uqk79A9iohFVklzKfFkgGRy
        6hqCCehO/jhFemcBFbqo4W3DJKynf6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-GGcgcgwdMEacjZs1atKNYw-1; Wed, 10 Mar 2021 11:56:23 -0500
X-MC-Unique: GGcgcgwdMEacjZs1atKNYw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEF3210866A6;
        Wed, 10 Mar 2021 16:56:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-152.rdu2.redhat.com [10.10.118.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E91446;
        Wed, 10 Mar 2021 16:56:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v4 08/28] netfs: Provide readahead and readpage netfs helpers
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 10 Mar 2021 16:56:13 +0000
Message-ID: <161539537375.286939.16642940088716990995.stgit@warthog.procyon.org.uk>
In-Reply-To: <161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk>
References: <161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a pair of helper functions:

 (*) netfs_readahead()
 (*) netfs_readpage()

to do the work of handling a readahead or a readpage, where the page(s)
that form part of the request may be split between the local cache, the
server or just require clearing, and may be single pages and transparent
huge pages.  This is all handled within the helper.

Note that while both will read from the cache if there is data present,
only netfs_readahead() will expand the request beyond what it was asked to
do, and only netfs_readahead() will write back to the cache.

netfs_readpage(), on the other hand, is synchronous and only fetches the
page (which might be a THP) it is asked for.

The netfs gives the helper parameters from the VM, the cache cookie it
wants to use (or NULL) and a table of operations (only one of which is
mandatory):

 (*) expand_readahead() [optional]

     Called to allow the netfs to request an expansion of a readahead
     request to meet its own alignment requirements.  This is done by
     changing rreq->start and rreq->len.

 (*) clamp_length() [optional]

     Called to allow the netfs to cut down a subrequest to meet its own
     boundary requirements.  If it does this, the helper will generate
     additional subrequests until the full request is satisfied.

 (*) is_still_valid() [optional]

     Called to find out if the data just read from the cache has been
     invalidated and must be reread from the server.

 (*) issue_op() [required]

     Called to ask the netfs to issue a read to the server.  The subrequest
     describes the read.  The read request holds information about the file
     being accessed.

     The netfs can cache information in rreq->netfs_priv.

     Upon completion, the netfs should set the error, transferred and can
     also set FSCACHE_SREQ_CLEAR_TAIL and then call
     fscache_subreq_terminated().

 (*) done() [optional]

     Called after the pages have been unlocked.  The read request is still
     pinning the file and mapping and may still be pinning pages with
     PG_fscache.  rreq->error indicates any error that has been
     accumulated.

 (*) cleanup() [optional]

     Called when the helper is disposing of a finished read request.  This
     allows the netfs to clear rreq->netfs_priv.

Netfs support is enabled with CONFIG_NETFS_SUPPORT=y.  It will be built
even if CONFIG_FSCACHE=n and in this case much of it should be optimised
away, allowing the filesystem to use it even when caching is disabled.

Changes:
 - Folded in a kerneldoc comment fix.
 - Folded in a fix for the error handling in the case that ENOMEM occurs.
 - Added flag to netfs_subreq_terminated() to indicate that the caller may
   have been running async and stuff that might sleep needs punting to a
   workqueue (can't use in_softirq()[1]).

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-mm@kvack.org
cc: linux-cachefs@redhat.com
cc: linux-afs@lists.infradead.org
cc: linux-nfs@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: ceph-devel@vger.kernel.org
cc: v9fs-developer@lists.sourceforge.net
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/160588497406.3465195.18003475695899726222.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/161118136849.1232039.8923686136144228724.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/161161032290.2537118.13400578415247339173.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/161340394873.1303470.6237319335883242536.stgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/20210216084230.GA23669@lst.de/ [1]
---

 fs/Kconfig             |    1 
 fs/Makefile            |    1 
 fs/netfs/Makefile      |    6 
 fs/netfs/internal.h    |   61 ++++
 fs/netfs/read_helper.c |  717 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h  |   82 +++++
 6 files changed, 868 insertions(+)
 create mode 100644 fs/netfs/Makefile
 create mode 100644 fs/netfs/internal.h
 create mode 100644 fs/netfs/read_helper.c

diff --git a/fs/Kconfig b/fs/Kconfig
index 462253ae483a..eccbcf1e3f2e 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -125,6 +125,7 @@ source "fs/overlayfs/Kconfig"
 
 menu "Caches"
 
+source "fs/netfs/Kconfig"
 source "fs/fscache/Kconfig"
 source "fs/cachefiles/Kconfig"
 
diff --git a/fs/Makefile b/fs/Makefile
index 3215fe205256..9c708e1fbe8f 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -67,6 +67,7 @@ obj-y				+= devpts/
 obj-$(CONFIG_DLM)		+= dlm/
  
 # Do not add any filesystems before this line
+obj-$(CONFIG_NETFS_SUPPORT)	+= netfs/
 obj-$(CONFIG_FSCACHE)		+= fscache/
 obj-$(CONFIG_REISERFS_FS)	+= reiserfs/
 obj-$(CONFIG_EXT4_FS)		+= ext4/
diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
new file mode 100644
index 000000000000..4b4eff2ba369
--- /dev/null
+++ b/fs/netfs/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+netfs-y := \
+	read_helper.o
+
+obj-$(CONFIG_NETFS_SUPPORT) := netfs.o
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
new file mode 100644
index 000000000000..ee665c0e7dc8
--- /dev/null
+++ b/fs/netfs/internal.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Internal definitions for network filesystem support
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+
+#define pr_fmt(fmt) "netfs: " fmt
+
+/*
+ * read_helper.c
+ */
+extern unsigned int netfs_debug;
+
+#define netfs_stat(x) do {} while(0)
+#define netfs_stat_d(x) do {} while(0)
+
+/*****************************************************************************/
+/*
+ * debug tracing
+ */
+#define dbgprintk(FMT, ...) \
+	printk("[%-6.6s] "FMT"\n", current->comm, ##__VA_ARGS__)
+
+#define kenter(FMT, ...) dbgprintk("==> %s("FMT")", __func__, ##__VA_ARGS__)
+#define kleave(FMT, ...) dbgprintk("<== %s()"FMT"", __func__, ##__VA_ARGS__)
+#define kdebug(FMT, ...) dbgprintk(FMT, ##__VA_ARGS__)
+
+#ifdef __KDEBUG
+#define _enter(FMT, ...) kenter(FMT, ##__VA_ARGS__)
+#define _leave(FMT, ...) kleave(FMT, ##__VA_ARGS__)
+#define _debug(FMT, ...) kdebug(FMT, ##__VA_ARGS__)
+
+#elif defined(CONFIG_NETFS_DEBUG)
+#define _enter(FMT, ...)			\
+do {						\
+	if (netfs_debug)			\
+		kenter(FMT, ##__VA_ARGS__);	\
+} while (0)
+
+#define _leave(FMT, ...)			\
+do {						\
+	if (netfs_debug)			\
+		kleave(FMT, ##__VA_ARGS__);	\
+} while (0)
+
+#define _debug(FMT, ...)			\
+do {						\
+	if (netfs_debug)			\
+		kdebug(FMT, ##__VA_ARGS__);	\
+} while (0)
+
+#else
+#define _enter(FMT, ...) no_printk("==> %s("FMT")", __func__, ##__VA_ARGS__)
+#define _leave(FMT, ...) no_printk("<== %s()"FMT"", __func__, ##__VA_ARGS__)
+#define _debug(FMT, ...) no_printk(FMT, ##__VA_ARGS__)
+#endif
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
new file mode 100644
index 000000000000..c5ed0dcc9571
--- /dev/null
+++ b/fs/netfs/read_helper.c
@@ -0,0 +1,717 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Network filesystem high-level read support.
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/module.h>
+#include <linux/export.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include <linux/uio.h>
+#include <linux/sched/mm.h>
+#include <linux/task_io_accounting_ops.h>
+#include <linux/netfs.h>
+#include "internal.h"
+
+MODULE_DESCRIPTION("Network fs support");
+MODULE_AUTHOR("Red Hat, Inc.");
+MODULE_LICENSE("GPL");
+
+unsigned netfs_debug;
+module_param_named(debug, netfs_debug, uint, S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(netfs_debug, "Netfs support debugging mask");
+
+static void netfs_rreq_work(struct work_struct *);
+static void __netfs_put_subrequest(struct netfs_read_subrequest *, bool);
+
+static void netfs_put_subrequest(struct netfs_read_subrequest *subreq,
+				 bool was_async)
+{
+	if (refcount_dec_and_test(&subreq->usage))
+		__netfs_put_subrequest(subreq, was_async);
+}
+
+static struct netfs_read_request *netfs_alloc_read_request(
+	const struct netfs_read_request_ops *ops, void *netfs_priv,
+	struct file *file)
+{
+	struct netfs_read_request *rreq;
+
+	rreq = kzalloc(sizeof(struct netfs_read_request), GFP_KERNEL);
+	if (rreq) {
+		rreq->netfs_ops	= ops;
+		rreq->netfs_priv = netfs_priv;
+		rreq->inode	= file_inode(file);
+		rreq->i_size	= i_size_read(rreq->inode);
+		INIT_LIST_HEAD(&rreq->subrequests);
+		INIT_WORK(&rreq->work, netfs_rreq_work);
+		refcount_set(&rreq->usage, 1);
+		__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
+		ops->init_rreq(rreq, file);
+	}
+
+	return rreq;
+}
+
+static void netfs_get_read_request(struct netfs_read_request *rreq)
+{
+	refcount_inc(&rreq->usage);
+}
+
+static void netfs_rreq_clear_subreqs(struct netfs_read_request *rreq,
+				     bool was_async)
+{
+	struct netfs_read_subrequest *subreq;
+
+	while (!list_empty(&rreq->subrequests)) {
+		subreq = list_first_entry(&rreq->subrequests,
+					  struct netfs_read_subrequest, rreq_link);
+		list_del(&subreq->rreq_link);
+		netfs_put_subrequest(subreq, was_async);
+	}
+}
+
+static void netfs_free_read_request(struct work_struct *work)
+{
+	struct netfs_read_request *rreq =
+		container_of(work, struct netfs_read_request, work);
+	netfs_rreq_clear_subreqs(rreq, false);
+	if (rreq->netfs_priv)
+		rreq->netfs_ops->cleanup(rreq->mapping, rreq->netfs_priv);
+	kfree(rreq);
+}
+
+static void netfs_put_read_request(struct netfs_read_request *rreq, bool was_async)
+{
+	if (refcount_dec_and_test(&rreq->usage)) {
+		if (was_async) {
+			rreq->work.func = netfs_free_read_request;
+			if (!queue_work(system_unbound_wq, &rreq->work))
+				BUG();
+		} else {
+			netfs_free_read_request(&rreq->work);
+		}
+	}
+}
+
+/*
+ * Allocate and partially initialise an I/O request structure.
+ */
+static struct netfs_read_subrequest *netfs_alloc_subrequest(
+	struct netfs_read_request *rreq)
+{
+	struct netfs_read_subrequest *subreq;
+
+	subreq = kzalloc(sizeof(struct netfs_read_subrequest), GFP_KERNEL);
+	if (subreq) {
+		INIT_LIST_HEAD(&subreq->rreq_link);
+		refcount_set(&subreq->usage, 2);
+		subreq->rreq = rreq;
+		netfs_get_read_request(rreq);
+	}
+
+	return subreq;
+}
+
+static void netfs_get_read_subrequest(struct netfs_read_subrequest *subreq)
+{
+	refcount_inc(&subreq->usage);
+}
+
+static void __netfs_put_subrequest(struct netfs_read_subrequest *subreq,
+				   bool was_async)
+{
+	struct netfs_read_request *rreq = subreq->rreq;
+
+	kfree(subreq);
+	netfs_put_read_request(rreq, was_async);
+}
+
+/*
+ * Clear the unread part of an I/O request.
+ */
+static void netfs_clear_unread(struct netfs_read_subrequest *subreq)
+{
+	struct iov_iter iter;
+
+	iov_iter_xarray(&iter, WRITE, &subreq->rreq->mapping->i_pages,
+			subreq->start + subreq->transferred,
+			subreq->len   - subreq->transferred);
+	iov_iter_zero(iov_iter_count(&iter), &iter);
+}
+
+/*
+ * Fill a subrequest region with zeroes.
+ */
+static void netfs_fill_with_zeroes(struct netfs_read_request *rreq,
+				   struct netfs_read_subrequest *subreq)
+{
+	__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
+	netfs_subreq_terminated(subreq, 0, false);
+}
+
+/*
+ * Ask the netfs to issue a read request to the server for us.
+ *
+ * The netfs is expected to read from subreq->pos + subreq->transferred to
+ * subreq->pos + subreq->len - 1.  It may not backtrack and write data into the
+ * buffer prior to the transferred point as it might clobber dirty data
+ * obtained from the cache.
+ *
+ * Alternatively, the netfs is allowed to indicate one of two things:
+ *
+ * - NETFS_SREQ_SHORT_READ: A short read - it will get called again to try and
+ *   make progress.
+ *
+ * - NETFS_SREQ_CLEAR_TAIL: A short read - the rest of the buffer will be
+ *   cleared.
+ */
+static void netfs_read_from_server(struct netfs_read_request *rreq,
+				   struct netfs_read_subrequest *subreq)
+{
+	rreq->netfs_ops->issue_op(subreq);
+}
+
+/*
+ * Release those waiting.
+ */
+static void netfs_rreq_completed(struct netfs_read_request *rreq, bool was_async)
+{
+	netfs_rreq_clear_subreqs(rreq, was_async);
+	netfs_put_read_request(rreq, was_async);
+}
+
+/*
+ * Unlock the pages in a read operation.  We need to set PG_fscache on any
+ * pages we're going to write back before we unlock them.
+ */
+static void netfs_rreq_unlock(struct netfs_read_request *rreq)
+{
+	struct netfs_read_subrequest *subreq;
+	struct page *page;
+	unsigned int iopos, account = 0;
+	pgoff_t start_page = rreq->start / PAGE_SIZE;
+	pgoff_t last_page = ((rreq->start + rreq->len) / PAGE_SIZE) - 1;
+	bool subreq_failed = false;
+	int i;
+
+	XA_STATE(xas, &rreq->mapping->i_pages, start_page);
+
+	if (test_bit(NETFS_RREQ_FAILED, &rreq->flags)) {
+		__clear_bit(NETFS_RREQ_WRITE_TO_CACHE, &rreq->flags);
+		list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
+			__clear_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags);
+		}
+	}
+
+	/* Walk through the pagecache and the I/O request lists simultaneously.
+	 * We may have a mixture of cached and uncached sections and we only
+	 * really want to write out the uncached sections.  This is slightly
+	 * complicated by the possibility that we might have huge pages with a
+	 * mixture inside.
+	 */
+	subreq = list_first_entry(&rreq->subrequests,
+				  struct netfs_read_subrequest, rreq_link);
+	iopos = 0;
+	subreq_failed = (subreq->error < 0);
+
+	rcu_read_lock();
+	xas_for_each(&xas, page, last_page) {
+		unsigned int pgpos = (page->index - start_page) * PAGE_SIZE;
+		unsigned int pgend = pgpos + thp_size(page);
+		bool pg_failed = false;
+
+		for (;;) {
+			if (!subreq) {
+				pg_failed = true;
+				break;
+			}
+			if (test_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags))
+				SetPageFsCache(page);
+			pg_failed |= subreq_failed;
+			if (pgend < iopos + subreq->len)
+				break;
+
+			account += subreq->transferred;
+			iopos += subreq->len;
+			if (!list_is_last(&subreq->rreq_link, &rreq->subrequests)) {
+				subreq = list_next_entry(subreq, rreq_link);
+				subreq_failed = (subreq->error < 0);
+			} else {
+				subreq = NULL;
+				subreq_failed = false;
+			}
+			if (pgend == iopos)
+				break;
+		}
+
+		if (!pg_failed) {
+			for (i = 0; i < thp_nr_pages(page); i++)
+				flush_dcache_page(page);
+			SetPageUptodate(page);
+		}
+
+		if (!test_bit(NETFS_RREQ_DONT_UNLOCK_PAGES, &rreq->flags)) {
+			if (page->index == rreq->no_unlock_page &&
+			    test_bit(NETFS_RREQ_NO_UNLOCK_PAGE, &rreq->flags))
+				_debug("no unlock");
+			else
+				unlock_page(page);
+		}
+	}
+	rcu_read_unlock();
+
+	task_io_account_read(account);
+	if (rreq->netfs_ops->done)
+		rreq->netfs_ops->done(rreq);
+}
+
+/*
+ * Handle a short read.
+ */
+static void netfs_rreq_short_read(struct netfs_read_request *rreq,
+				  struct netfs_read_subrequest *subreq)
+{
+	__clear_bit(NETFS_SREQ_SHORT_READ, &subreq->flags);
+	__set_bit(NETFS_SREQ_SEEK_DATA_READ, &subreq->flags);
+
+	netfs_get_read_subrequest(subreq);
+	atomic_inc(&rreq->nr_rd_ops);
+	netfs_read_from_server(rreq, subreq);
+}
+
+/*
+ * Resubmit any short or failed operations.  Returns true if we got the rreq
+ * ref back.
+ */
+static bool netfs_rreq_perform_resubmissions(struct netfs_read_request *rreq)
+{
+	struct netfs_read_subrequest *subreq;
+
+	WARN_ON(in_interrupt());
+
+	/* We don't want terminating submissions trying to wake us up whilst
+	 * we're still going through the list.
+	 */
+	atomic_inc(&rreq->nr_rd_ops);
+
+	__clear_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags);
+	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
+		if (subreq->error) {
+			if (subreq->source != NETFS_READ_FROM_CACHE)
+				break;
+			subreq->source = NETFS_DOWNLOAD_FROM_SERVER;
+			subreq->error = 0;
+			netfs_get_read_subrequest(subreq);
+			atomic_inc(&rreq->nr_rd_ops);
+			netfs_read_from_server(rreq, subreq);
+		} else if (test_bit(NETFS_SREQ_SHORT_READ, &subreq->flags)) {
+			netfs_rreq_short_read(rreq, subreq);
+		}
+	}
+
+	/* If we decrement nr_rd_ops to 0, the usage ref belongs to us. */
+	if (atomic_dec_and_test(&rreq->nr_rd_ops))
+		return true;
+
+	wake_up_var(&rreq->nr_rd_ops);
+	return false;
+}
+
+/*
+ * Assess the state of a read request and decide what to do next.
+ *
+ * Note that we could be in an ordinary kernel thread, on a workqueue or in
+ * softirq context at this point.  We inherit a ref from the caller.
+ */
+static void netfs_rreq_assess(struct netfs_read_request *rreq, bool was_async)
+{
+again:
+	if (!test_bit(NETFS_RREQ_FAILED, &rreq->flags) &&
+	    test_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags)) {
+		if (netfs_rreq_perform_resubmissions(rreq))
+			goto again;
+		return;
+	}
+
+	netfs_rreq_unlock(rreq);
+
+	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
+	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);
+
+	netfs_rreq_completed(rreq, was_async);
+}
+
+static void netfs_rreq_work(struct work_struct *work)
+{
+	struct netfs_read_request *rreq =
+		container_of(work, struct netfs_read_request, work);
+	netfs_rreq_assess(rreq, false);
+}
+
+/*
+ * Handle the completion of all outstanding I/O operations on a read request.
+ * We inherit a ref from the caller.
+ */
+static void netfs_rreq_terminated(struct netfs_read_request *rreq,
+				  bool was_async)
+{
+	if (test_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags) &&
+	    was_async) {
+		if (!queue_work(system_unbound_wq, &rreq->work))
+			BUG();
+	} else {
+		netfs_rreq_assess(rreq, was_async);
+	}
+}
+
+/**
+ * netfs_subreq_terminated - Note the termination of an I/O operation.
+ * @subreq: The I/O request that has terminated.
+ * @transferred_or_error: The amount of data transferred or an error code.
+ * @was_async: The termination was asynchronous
+ *
+ * This tells the read helper that a contributory I/O operation has terminated,
+ * one way or another, and that it should integrate the results.
+ *
+ * The caller indicates in @transferred_or_error the outcome of the operation,
+ * supplying a positive value to indicate the number of bytes transferred, 0 to
+ * indicate a failure to transfer anything that should be retried or a negative
+ * error code.  The helper will look after reissuing I/O operations as
+ * appropriate and writing downloaded data to the cache.
+ *
+ * If @was_async is true, the caller might be running in softirq or interrupt
+ * context and we can't sleep.
+ */
+void netfs_subreq_terminated(struct netfs_read_subrequest *subreq,
+			     ssize_t transferred_or_error,
+			     bool was_async)
+{
+	struct netfs_read_request *rreq = subreq->rreq;
+	int u;
+
+	_enter("[%u]{%llx,%lx},%zd",
+	       subreq->debug_index, subreq->start, subreq->flags,
+	       transferred_or_error);
+
+	if (IS_ERR_VALUE(transferred_or_error)) {
+		subreq->error = transferred_or_error;
+		goto failed;
+	}
+
+	if (WARN_ON(transferred_or_error > subreq->len - subreq->transferred))
+		transferred_or_error = subreq->len - subreq->transferred;
+
+	subreq->error = 0;
+	subreq->transferred += transferred_or_error;
+	if (subreq->transferred < subreq->len)
+		goto incomplete;
+
+complete:
+	__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
+	if (test_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags))
+		set_bit(NETFS_RREQ_WRITE_TO_CACHE, &rreq->flags);
+
+out:
+	/* If we decrement nr_rd_ops to 0, the ref belongs to us. */
+	u = atomic_dec_return(&rreq->nr_rd_ops);
+	if (u == 0)
+		netfs_rreq_terminated(rreq, was_async);
+	else if (u == 1)
+		wake_up_var(&rreq->nr_rd_ops);
+
+	netfs_put_subrequest(subreq, was_async);
+	return;
+
+incomplete:
+	if (test_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags)) {
+		netfs_clear_unread(subreq);
+		subreq->transferred = subreq->len;
+		goto complete;
+	}
+
+	if (transferred_or_error == 0) {
+		if (__test_and_set_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags)) {
+			subreq->error = -ENODATA;
+			goto failed;
+		}
+	} else {
+		__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
+	}
+
+	__set_bit(NETFS_SREQ_SHORT_READ, &subreq->flags);
+	set_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags);
+	goto out;
+
+failed:
+	if (subreq->source == NETFS_READ_FROM_CACHE) {
+		set_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags);
+	} else {
+		set_bit(NETFS_RREQ_FAILED, &rreq->flags);
+		rreq->error = subreq->error;
+	}
+	goto out;
+}
+EXPORT_SYMBOL(netfs_subreq_terminated);
+
+static enum netfs_read_source netfs_cache_prepare_read(struct netfs_read_subrequest *subreq,
+						       loff_t i_size)
+{
+	struct netfs_read_request *rreq = subreq->rreq;
+
+	if (subreq->start >= rreq->i_size)
+		return NETFS_FILL_WITH_ZEROES;
+	return NETFS_DOWNLOAD_FROM_SERVER;
+}
+
+/*
+ * Work out what sort of subrequest the next one will be.
+ */
+static enum netfs_read_source
+netfs_rreq_prepare_read(struct netfs_read_request *rreq,
+			struct netfs_read_subrequest *subreq)
+{
+	enum netfs_read_source source;
+
+	_enter("%llx-%llx,%llx", subreq->start, subreq->start + subreq->len, rreq->i_size);
+
+	source = netfs_cache_prepare_read(subreq, rreq->i_size);
+	if (source == NETFS_INVALID_READ)
+		goto out;
+
+	if (source == NETFS_DOWNLOAD_FROM_SERVER) {
+		/* Call out to the netfs to let it shrink the request to fit
+		 * its own I/O sizes and boundaries.  If it shinks it here, it
+		 * will be called again to make simultaneous calls; if it wants
+		 * to make serial calls, it can indicate a short read and then
+		 * we will call it again.
+		 */
+		if (subreq->len > rreq->i_size - subreq->start)
+			subreq->len = rreq->i_size - subreq->start;
+
+		if (rreq->netfs_ops->clamp_length &&
+		    !rreq->netfs_ops->clamp_length(subreq)) {
+			source = NETFS_INVALID_READ;
+			goto out;
+		}
+	}
+
+	if (WARN_ON(subreq->len == 0))
+		source = NETFS_INVALID_READ;
+
+out:
+	subreq->source = source;
+	return source;
+}
+
+/*
+ * Slice off a piece of a read request and submit an I/O request for it.
+ */
+static bool netfs_rreq_submit_slice(struct netfs_read_request *rreq,
+				    unsigned int *_debug_index)
+{
+	struct netfs_read_subrequest *subreq;
+	enum netfs_read_source source;
+
+	subreq = netfs_alloc_subrequest(rreq);
+	if (!subreq)
+		return false;
+
+	subreq->debug_index	= (*_debug_index)++;
+	subreq->start		= rreq->start + rreq->submitted;
+	subreq->len		= rreq->len   - rreq->submitted;
+
+	_debug("slice %llx,%zx,%zx", subreq->start, subreq->len, rreq->submitted);
+	list_add_tail(&subreq->rreq_link, &rreq->subrequests);
+
+	/* Call out to the cache to find out what it can do with the remaining
+	 * subset.  It tells us in subreq->flags what it decided should be done
+	 * and adjusts subreq->len down if the subset crosses a cache boundary.
+	 *
+	 * Then when we hand the subset, it can choose to take a subset of that
+	 * (the starts must coincide), in which case, we go around the loop
+	 * again and ask it to download the next piece.
+	 */
+	source = netfs_rreq_prepare_read(rreq, subreq);
+	if (source == NETFS_INVALID_READ)
+		goto subreq_failed;
+
+	atomic_inc(&rreq->nr_rd_ops);
+
+	rreq->submitted += subreq->len;
+
+	switch (source) {
+	case NETFS_FILL_WITH_ZEROES:
+		netfs_fill_with_zeroes(rreq, subreq);
+		break;
+	case NETFS_DOWNLOAD_FROM_SERVER:
+		netfs_read_from_server(rreq, subreq);
+		break;
+	default:
+		BUG();
+	}
+
+	return true;
+
+subreq_failed:
+	rreq->error = subreq->error;
+	netfs_put_subrequest(subreq, false);
+	return false;
+}
+
+static void netfs_rreq_expand(struct netfs_read_request *rreq,
+			      struct readahead_control *ractl)
+{
+	/* Give the netfs a chance to change the request parameters.  The
+	 * resultant request must contain the original region.
+	 */
+	if (rreq->netfs_ops->expand_readahead)
+		rreq->netfs_ops->expand_readahead(rreq);
+
+	/* Expand the request if the cache wants it to start earlier.  Note
+	 * that the expansion may get further extended if the VM wishes to
+	 * insert THPs and the preferred start and/or end wind up in the middle
+	 * of THPs.
+	 *
+	 * If this is the case, however, the THP size should be an integer
+	 * multiple of the cache granule size, so we get a whole number of
+	 * granules to deal with.
+	 */
+	if (rreq->start  != readahead_pos(ractl) ||
+	    rreq->len != readahead_length(ractl)) {
+		readahead_expand(ractl, rreq->start, rreq->len);
+		rreq->start  = readahead_pos(ractl);
+		rreq->len = readahead_length(ractl);
+	}
+}
+
+/**
+ * netfs_readahead - Helper to manage a read request
+ * @ractl: The description of the readahead request
+ * @ops: The network filesystem's operations for the helper to use
+ * @netfs_priv: Private netfs data to be retained in the request
+ *
+ * Fulfil a readahead request by drawing data from the cache if possible, or
+ * the netfs if not.  Space beyond the EOF is zero-filled.  Multiple I/O
+ * requests from different sources will get munged together.  If necessary, the
+ * readahead window can be expanded in either direction to a more convenient
+ * alighment for RPC efficiency or to make storage in the cache feasible.
+ *
+ * The calling netfs must provide a table of operations, only one of which,
+ * issue_op, is mandatory.  It may also be passed a private token, which will
+ * be retained in rreq->netfs_priv and will be cleaned up by ops->cleanup().
+ *
+ * This is usable whether or not caching is enabled.
+ */
+void netfs_readahead(struct readahead_control *ractl,
+		     const struct netfs_read_request_ops *ops,
+		     void *netfs_priv)
+{
+	struct netfs_read_request *rreq;
+	struct page *page;
+	unsigned int debug_index = 0;
+
+	_enter("%lx,%x", readahead_index(ractl), readahead_count(ractl));
+
+	if (readahead_count(ractl) == 0)
+		goto cleanup;
+
+	rreq = netfs_alloc_read_request(ops, netfs_priv, ractl->file);
+	if (!rreq)
+		goto cleanup;
+	rreq->mapping	= ractl->mapping;
+	rreq->start	= readahead_pos(ractl);
+	rreq->len	= readahead_length(ractl);
+
+	netfs_rreq_expand(rreq, ractl);
+
+	atomic_set(&rreq->nr_rd_ops, 1);
+	do {
+		if (!netfs_rreq_submit_slice(rreq, &debug_index))
+			break;
+
+	} while (rreq->submitted < rreq->len);
+
+	while ((page = readahead_page(ractl)))
+		put_page(page);
+
+	/* If we decrement nr_rd_ops to 0, the ref belongs to us. */
+	if (atomic_dec_and_test(&rreq->nr_rd_ops))
+		netfs_rreq_assess(rreq, false);
+	return;
+
+cleanup:
+	if (netfs_priv)
+		ops->cleanup(ractl->mapping, netfs_priv);
+	return;
+}
+EXPORT_SYMBOL(netfs_readahead);
+
+/**
+ * netfs_page - Helper to manage a readpage request
+ * @file: The file to read from
+ * @page: The page to read
+ * @ops: The network filesystem's operations for the helper to use
+ * @netfs_priv: Private netfs data to be retained in the request
+ *
+ * Fulfil a readpage request by drawing data from the cache if possible, or the
+ * netfs if not.  Space beyond the EOF is zero-filled.  Multiple I/O requests
+ * from different sources will get munged together.
+ *
+ * The calling netfs must provide a table of operations, only one of which,
+ * issue_op, is mandatory.  It may also be passed a private token, which will
+ * be retained in rreq->netfs_priv and will be cleaned up by ops->cleanup().
+ *
+ * This is usable whether or not caching is enabled.
+ */
+int netfs_readpage(struct file *file,
+		   struct page *page,
+		   const struct netfs_read_request_ops *ops,
+		   void *netfs_priv)
+{
+	struct netfs_read_request *rreq;
+	unsigned int debug_index = 0;
+	int ret;
+
+	_enter("%lx", page->index);
+
+	rreq = netfs_alloc_read_request(ops, netfs_priv, file);
+	if (!rreq) {
+		if (netfs_priv)
+			ops->cleanup(netfs_priv, page->mapping);
+		unlock_page(page);
+		return -ENOMEM;
+	}
+	rreq->mapping	= page->mapping;
+	rreq->start	= page->index * PAGE_SIZE;
+	rreq->len	= thp_size(page);
+
+	netfs_get_read_request(rreq);
+
+	atomic_set(&rreq->nr_rd_ops, 1);
+	do {
+		if (!netfs_rreq_submit_slice(rreq, &debug_index))
+			break;
+
+	} while (rreq->submitted < rreq->len);
+
+	/* Keep nr_rd_ops incremented so that the ref always belongs to us, and
+	 * the service code isn't punted off to a random thread pool to
+	 * process.
+	 */
+	do {
+		wait_var_event(&rreq->nr_rd_ops, atomic_read(&rreq->nr_rd_ops) == 1);
+		netfs_rreq_assess(rreq, false);
+	} while (test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags));
+
+	ret = rreq->error;
+	if (ret == 0 && rreq->submitted < rreq->len)
+		ret = -EIO;
+	netfs_put_read_request(rreq, false);
+	return ret;
+}
+EXPORT_SYMBOL(netfs_readpage);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 5ed8c6dc7453..d5453f625610 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -14,6 +14,8 @@
 #ifndef _LINUX_NETFS_H
 #define _LINUX_NETFS_H
 
+#include <linux/workqueue.h>
+#include <linux/fs.h>
 #include <linux/pagemap.h>
 
 /*
@@ -55,4 +57,84 @@ static inline void wait_on_page_fscache(struct page *page)
 		wait_on_page_bit(compound_head(page), PG_fscache);
 }
 
+enum netfs_read_source {
+	NETFS_FILL_WITH_ZEROES,
+	NETFS_DOWNLOAD_FROM_SERVER,
+	NETFS_READ_FROM_CACHE,
+	NETFS_INVALID_READ,
+} __mode(byte);
+
+/*
+ * Descriptor for a single component subrequest.
+ */
+struct netfs_read_subrequest {
+	struct netfs_read_request *rreq;	/* Supervising read request */
+	struct list_head	rreq_link;	/* Link in rreq->subrequests */
+	loff_t			start;		/* Where to start the I/O */
+	size_t			len;		/* Size of the I/O */
+	size_t			transferred;	/* Amount of data transferred */
+	refcount_t		usage;
+	short			error;		/* 0 or error that occurred */
+	unsigned short		debug_index;	/* Index in list (for debugging output) */
+	enum netfs_read_source	source;		/* Where to read from */
+	unsigned long		flags;
+#define NETFS_SREQ_WRITE_TO_CACHE	0	/* Set if should write to cache */
+#define NETFS_SREQ_CLEAR_TAIL		1	/* Set if the rest of the read should be cleared */
+#define NETFS_SREQ_SHORT_READ		2	/* Set if there was a short read from the cache */
+#define NETFS_SREQ_SEEK_DATA_READ	3	/* Set if ->read() should SEEK_DATA first */
+#define NETFS_SREQ_NO_PROGRESS		4	/* Set if we didn't manage to read any data */
+};
+
+/*
+ * Descriptor for a read helper request.  This is used to make multiple I/O
+ * requests on a variety of sources and then stitch the result together.
+ */
+struct netfs_read_request {
+	struct work_struct	work;
+	struct inode		*inode;		/* The file being accessed */
+	struct address_space	*mapping;	/* The mapping being accessed */
+	struct list_head	subrequests;	/* Requests to fetch I/O from disk or net */
+	void			*netfs_priv;	/* Private data for the netfs */
+	atomic_t		nr_rd_ops;	/* Number of read ops in progress */
+	size_t			submitted;	/* Amount submitted for I/O so far */
+	size_t			len;		/* Length of the request */
+	short			error;		/* 0 or error that occurred */
+	loff_t			i_size;		/* Size of the file */
+	loff_t			start;		/* Start position */
+	pgoff_t			no_unlock_page;	/* Don't unlock this page after read */
+	refcount_t		usage;
+	unsigned long		flags;
+#define NETFS_RREQ_INCOMPLETE_IO	0	/* Some ioreqs terminated short or with error */
+#define NETFS_RREQ_WRITE_TO_CACHE	1	/* Need to write to the cache */
+#define NETFS_RREQ_NO_UNLOCK_PAGE	2	/* Don't unlock no_unlock_page on completion */
+#define NETFS_RREQ_DONT_UNLOCK_PAGES	3	/* Don't unlock the pages on completion */
+#define NETFS_RREQ_FAILED		4	/* The request failed */
+#define NETFS_RREQ_IN_PROGRESS		5	/* Unlocked when the request completes */
+	const struct netfs_read_request_ops *netfs_ops;
+};
+
+/*
+ * Operations the network filesystem can/must provide to the helpers.
+ */
+struct netfs_read_request_ops {
+	void (*init_rreq)(struct netfs_read_request *rreq, struct file *file);
+	void (*expand_readahead)(struct netfs_read_request *rreq);
+	bool (*clamp_length)(struct netfs_read_subrequest *subreq);
+	void (*issue_op)(struct netfs_read_subrequest *subreq);
+	bool (*is_still_valid)(struct netfs_read_request *rreq);
+	void (*done)(struct netfs_read_request *rreq);
+	void (*cleanup)(struct address_space *mapping, void *netfs_priv);
+};
+
+struct readahead_control;
+extern void netfs_readahead(struct readahead_control *,
+			    const struct netfs_read_request_ops *,
+			    void *);
+extern int netfs_readpage(struct file *,
+			  struct page *,
+			  const struct netfs_read_request_ops *,
+			  void *);
+
+extern void netfs_subreq_terminated(struct netfs_read_subrequest *, ssize_t, bool);
+
 #endif /* _LINUX_NETFS_H */


