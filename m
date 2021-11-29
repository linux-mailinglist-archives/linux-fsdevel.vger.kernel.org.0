Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2554461AE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 16:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245157AbhK2PcQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 10:32:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21872 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349450AbhK2PaQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 10:30:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638199618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=muscdDC11I9Z6sf+k2MqAac1cA7yGzRS+DsuStEiQFE=;
        b=IjRn7yZsU5ctxk4oaeInWhbjLgSW+DVArM4jqo/WRJfCZ64rSbUGQVfStTNR3vGGQ+7KMI
        veJZomPGvWlRnnKOTloLB8xzvWelp69WnRTtX92sRtPduXuzQXitbYO1YwUcignZmhCDtE
        /rysG13Rrrxxf+UkD5LC480fyMe8DpM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-x7lx4dllPY2R-fyn6yn92Q-1; Mon, 29 Nov 2021 10:26:54 -0500
X-MC-Unique: x7lx4dllPY2R-fyn6yn92Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DB19102C7EC;
        Mon, 29 Nov 2021 15:26:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32ECF60BF4;
        Mon, 29 Nov 2021 15:26:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] netfs: Adjust docs after foliation
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, linux-cachefs@redhat.com,
        linux-mm@kvack.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Nov 2021 15:26:43 +0000
Message-ID: <163819960325.224342.9892463787829639241.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adjust the netfslib docs in light of the foliation changes.

Also un-kdoc-mark netfs_skip_folio_read() since it's internal and isn't
part of the API.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-cachefs@redhat.com
cc: linux-mm@kvack.org
Link: https://lore.kernel.org/r/163706992597.3179783.18360472879717076435.stgit@warthog.procyon.org.uk/
---

 Documentation/filesystems/netfs_library.rst |   95 ++++++++++++++++-----------
 fs/netfs/read_helper.c                      |    4 +
 2 files changed, 58 insertions(+), 41 deletions(-)

diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
index bb68d39f03b7..375baca7edcd 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
 =================================
-NETWORK FILESYSTEM HELPER LIBRARY
+Network Filesystem Helper Library
 =================================
 
 .. Contents:
@@ -37,22 +37,22 @@ into a common call framework.
 
 The following services are provided:
 
- * Handles transparent huge pages (THPs).
+ * Handle folios that span multiple pages.
 
- * Insulates the netfs from VM interface changes.
+ * Insulate the netfs from VM interface changes.
 
- * Allows the netfs to arbitrarily split reads up into pieces, even ones that
-   don't match page sizes or page alignments and that may cross pages.
+ * Allow the netfs to arbitrarily split reads up into pieces, even ones that
+   don't match folio sizes or folio alignments and that may cross folios.
 
- * Allows the netfs to expand a readahead request in both directions to meet
-   its needs.
+ * Allow the netfs to expand a readahead request in both directions to meet its
+   needs.
 
- * Allows the netfs to partially fulfil a read, which will then be resubmitted.
+ * Allow the netfs to partially fulfil a read, which will then be resubmitted.
 
- * Handles local caching, allowing cached data and server-read data to be
+ * Handle local caching, allowing cached data and server-read data to be
    interleaved for a single request.
 
- * Handles clearing of bufferage that aren't on the server.
+ * Handle clearing of bufferage that aren't on the server.
 
  * Handle retrying of reads that failed, switching reads from the cache to the
    server as necessary.
@@ -70,22 +70,22 @@ Read Helper Functions
 
 Three read helpers are provided::
 
- * void netfs_readahead(struct readahead_control *ractl,
-			const struct netfs_read_request_ops *ops,
-			void *netfs_priv);``
- * int netfs_readpage(struct file *file,
-		      struct page *page,
-		      const struct netfs_read_request_ops *ops,
-		      void *netfs_priv);
- * int netfs_write_begin(struct file *file,
-			 struct address_space *mapping,
-			 loff_t pos,
-			 unsigned int len,
-			 unsigned int flags,
-			 struct page **_page,
-			 void **_fsdata,
-			 const struct netfs_read_request_ops *ops,
-			 void *netfs_priv);
+	void netfs_readahead(struct readahead_control *ractl,
+			     const struct netfs_read_request_ops *ops,
+			     void *netfs_priv);
+	int netfs_readpage(struct file *file,
+			   struct folio *folio,
+			   const struct netfs_read_request_ops *ops,
+			   void *netfs_priv);
+	int netfs_write_begin(struct file *file,
+			      struct address_space *mapping,
+			      loff_t pos,
+			      unsigned int len,
+			      unsigned int flags,
+			      struct folio **_folio,
+			      void **_fsdata,
+			      const struct netfs_read_request_ops *ops,
+			      void *netfs_priv);
 
 Each corresponds to a VM operation, with the addition of a couple of parameters
 for the use of the read helpers:
@@ -103,8 +103,8 @@ Both of these values will be stored into the read request structure.
 For ->readahead() and ->readpage(), the network filesystem should just jump
 into the corresponding read helper; whereas for ->write_begin(), it may be a
 little more complicated as the network filesystem might want to flush
-conflicting writes or track dirty data and needs to put the acquired page if an
-error occurs after calling the helper.
+conflicting writes or track dirty data and needs to put the acquired folio if
+an error occurs after calling the helper.
 
 The helpers manage the read request, calling back into the network filesystem
 through the suppplied table of operations.  Waits will be performed as
@@ -253,7 +253,7 @@ through which it can issue requests and negotiate::
 		void (*issue_op)(struct netfs_read_subrequest *subreq);
 		bool (*is_still_valid)(struct netfs_read_request *rreq);
 		int (*check_write_begin)(struct file *file, loff_t pos, unsigned len,
-					 struct page *page, void **_fsdata);
+					 struct folio *folio, void **_fsdata);
 		void (*done)(struct netfs_read_request *rreq);
 		void (*cleanup)(struct address_space *mapping, void *netfs_priv);
 	};
@@ -313,13 +313,14 @@ The operations are as follows:
 
    There is no return value; the netfs_subreq_terminated() function should be
    called to indicate whether or not the operation succeeded and how much data
-   it transferred.  The filesystem also should not deal with setting pages
+   it transferred.  The filesystem also should not deal with setting folios
    uptodate, unlocking them or dropping their refs - the helpers need to deal
    with this as they have to coordinate with copying to the local cache.
 
-   Note that the helpers have the pages locked, but not pinned.  It is possible
-   to use the ITER_XARRAY iov iterator to refer to the range of the inode that
-   is being operated upon without the need to allocate large bvec tables.
+   Note that the helpers have the folios locked, but not pinned.  It is
+   possible to use the ITER_XARRAY iov iterator to refer to the range of the
+   inode that is being operated upon without the need to allocate large bvec
+   tables.
 
  * ``is_still_valid()``
 
@@ -330,15 +331,15 @@ The operations are as follows:
  * ``check_write_begin()``
 
    [Optional] This is called from the netfs_write_begin() helper once it has
-   allocated/grabbed the page to be modified to allow the filesystem to flush
+   allocated/grabbed the folio to be modified to allow the filesystem to flush
    conflicting state before allowing it to be modified.
 
-   It should return 0 if everything is now fine, -EAGAIN if the page should be
+   It should return 0 if everything is now fine, -EAGAIN if the folio should be
    regrabbed and any other error code to abort the operation.
 
  * ``done``
 
-   [Optional] This is called after the pages in the request have all been
+   [Optional] This is called after the folios in the request have all been
    unlocked (and marked uptodate if applicable).
 
  * ``cleanup``
@@ -390,7 +391,7 @@ The read helpers work by the following general procedure:
      * If NETFS_SREQ_CLEAR_TAIL was set, a short read will be cleared to the
        end of the slice instead of reissuing.
 
- * Once the data is read, the pages that have been fully read/cleared:
+ * Once the data is read, the folios that have been fully read/cleared:
 
    * Will be marked uptodate.
 
@@ -398,11 +399,11 @@ The read helpers work by the following general procedure:
 
    * Unlocked
 
- * Any pages that need writing to the cache will then have DIO writes issued.
+ * Any folios that need writing to the cache will then have DIO writes issued.
 
  * Synchronous operations will wait for reading to be complete.
 
- * Writes to the cache will proceed asynchronously and the pages will have the
+ * Writes to the cache will proceed asynchronously and the folios will have the
    PG_fscache mark removed when that completes.
 
  * The request structures will be cleaned up when everything has completed.
@@ -452,6 +453,9 @@ operation table looks like the following::
 			    netfs_io_terminated_t term_func,
 			    void *term_func_priv);
 
+		int (*prepare_write)(struct netfs_cache_resources *cres,
+				     loff_t *_start, size_t *_len, loff_t i_size);
+
 		int (*write)(struct netfs_cache_resources *cres,
 			     loff_t start_pos,
 			     struct iov_iter *iter,
@@ -509,6 +513,14 @@ The methods defined in the table are:
    indicating whether the termination is definitely happening in the caller's
    context.
 
+ * ``prepare_write()``
+
+   [Required] Called to adjust a write to the cache and check that there is
+   sufficient space in the cache.  The start and length values indicate the
+   size of the write that netfslib is proposing, and this can be adjusted by
+   the cache to respect DIO boundaries.  The file size is passed for
+   information.
+
  * ``write()``
 
    [Required] Called to write to the cache.  The start file offset is given
@@ -525,4 +537,9 @@ not the read request structure as they could be used in other situations where
 there isn't a read request structure as well, such as writing dirty data to the
 cache.
 
+
+API Function Reference
+======================
+
 .. kernel-doc:: include/linux/netfs.h
+.. kernel-doc:: fs/netfs/read_helper.c
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 9320a42dfaf9..7046f9bdd8dc 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -1008,8 +1008,8 @@ int netfs_readpage(struct file *file,
 }
 EXPORT_SYMBOL(netfs_readpage);
 
-/**
- * netfs_skip_folio_read - prep a folio for writing without reading first
+/*
+ * Prepare a folio for writing without reading first
  * @folio: The folio being prepared
  * @pos: starting position for the write
  * @len: length of write


