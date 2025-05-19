Return-Path: <linux-fsdevel+bounces-49411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 952DCABBFAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 15:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7BD11899B65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 13:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47111281519;
	Mon, 19 May 2025 13:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NIUZuoO/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E69D15855E
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747662523; cv=none; b=AiLJFle0bxF0QWP5NKKZ5C8QpP20f9OHLtH2JQoYQ36uxqOd+8DkdZI+shZSKJDTs030LUshKXXDAllhHfpBSLf6dQmt133Q82u1ko1aLTIGpWcTZ6ZlG5+V09qrHM98XpnZb2dFV90I6z+VXy4/nMY9uLpgcwuG0UNgeLXGMOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747662523; c=relaxed/simple;
	bh=2zEivgPf4cXTsmSXr3FxSo+IR/1rxm/qeJwlO0vx5XM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWYU/a0ePb6GWhwbIWVZzrwdtpp6wRPM2dIHJcl4cj47aip1u39eTfYOcDjC2DjnARpL9A2STw3Hm79fSSM1JFjpylsAho0Y52MdnRPFdSC0/NtL32xBzDFCYMo9CBf2lNecdm6KV/8xDx303nx+KCgYoeCQWQw8Gas0I5vtnzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NIUZuoO/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747662518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ghYrdi5cnBAh+ZkOIcjG/fQZADbNEwVgR4SYknU9CY=;
	b=NIUZuoO/L19LgVJYGOsYUndX8TEsA2Qh7va53sLnHugS+pkjZDvn2G3DqIGY20Uyq7E4Vk
	XrwpyMIIS3L+ux3Rzrz013X6xwRG0z8guZYSoTRZyE13yAzfj5zWM+PU4P04W7whSsJza6
	eUXWa/dAPrVRVfXS0IXVCw+s40FBTxY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-RTBma_fsNGKKVRatGlZBfA-1; Mon,
 19 May 2025 09:48:35 -0400
X-MC-Unique: RTBma_fsNGKKVRatGlZBfA-1
X-Mimecast-MFC-AGG-ID: RTBma_fsNGKKVRatGlZBfA_1747662513
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00FA8195608D;
	Mon, 19 May 2025 13:48:33 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.188])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C3A091956096;
	Mon, 19 May 2025 13:48:27 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Timothy Day <timday@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH 01/11] netfs: Update main API document
Date: Mon, 19 May 2025 14:47:57 +0100
Message-ID: <20250519134813.2975312-2-dhowells@redhat.com>
In-Reply-To: <20250519134813.2975312-1-dhowells@redhat.com>
References: <20250519134813.2975312-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Bring the netfs documentation up to date.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Timothy Day <timday@amazon.com>
cc: Jonathan Corbet <corbet@lwn.net>
cc: netfs@lists.linux.dev
cc: linux-doc@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 Documentation/filesystems/netfs_library.rst | 1016 ++++++++++++++-----
 1 file changed, 739 insertions(+), 277 deletions(-)

diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
index 3886c14f89f4..939b4b624fad 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -1,33 +1,187 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-=================================
-Network Filesystem Helper Library
-=================================
+===================================
+Network Filesystem Services Library
+===================================
 
 .. Contents:
 
  - Overview.
+   - Requests and streams.
+   - Subrequests.
+   - Result collection and retry.
+   - Local caching.
+   - Content encryption (fscrypt).
  - Per-inode context.
    - Inode context helper functions.
- - Buffered read helpers.
-   - Read helper functions.
-   - Read helper structures.
-   - Read helper operations.
-   - Read helper procedure.
-   - Read helper cache API.
+   - Inode locking.
+   - Inode writeback.
+ - High-level VFS API.
+   - Unlocked read/write iter.
+   - Pre-locked read/write iter.
+   - Monolithic files API.
+   - Memory-mapped I/O API.
+ - High-level VM API.
+   - Deprecated PG_private2 API.
+ - I/O request API.
+   - Request structure.
+   - Stream structure.
+   - Subrequest structure.
+   - Filesystem methods.
+   - Terminating a subrequest.
+   - Local cache API.
+ - API function reference.
 
 
 Overview
 ========
 
-The network filesystem helper library is a set of functions designed to aid a
-network filesystem in implementing VM/VFS operations.  For the moment, that
-just includes turning various VM buffered read operations into requests to read
-from the server.  The helper library, however, can also interpose other
-services, such as local caching or local data encryption.
+The network filesystem services library, netfslib, is a set of functions
+designed to aid a network filesystem in implementing VM/VFS API operations.  It
+takes over the normal buffered read, readahead, write and writeback and also
+handles unbuffered and direct I/O.
 
-Note that the library module doesn't link against local caching directly, so
-access must be provided by the netfs.
+The library provides support for (re-)negotiation of I/O sizes and retrying
+failed I/O as well as local caching and will, in the future, provide content
+encryption.
+
+It insulates the filesystem from VM interface changes as much as possible and
+handles VM features such as large multipage folios.  The filesystem basically
+just has to provide a way to perform read and write RPC calls.
+
+The way I/O is organised inside netfslib consists of a number of objects:
+
+ * A *request*.  A request is used to track the progress of the I/O overall and
+   to hold on to resources.  The collection of results is done at the request
+   level.  The I/O within a request is divided into a number of parallel
+   streams of subrequests.
+
+ * A *stream*.  A non-overlapping series of subrequests.  The subrequests
+   within a stream do not have to be contiguous.
+
+ * A *subrequest*.  This is the basic unit of I/O.  It represents a single RPC
+   call or a single cache I/O operation.  The library passes these to the
+   filesystem and the cache to perform.
+
+Requests and Streams
+--------------------
+
+When actually performing I/O (as opposed to just copying into the pagecache),
+netfslib will create one or more requests to track the progress of the I/O and
+to hold resources.
+
+A read operation will have a single stream and the subrequests within that
+stream may be of mixed origins, for instance mixing RPC subrequests and cache
+subrequests.
+
+On the other hand, a write operation may have multiple streams, where each
+stream targets a different destination.  For instance, there may be one stream
+writing to the local cache and one to the server.  Currently, only two streams
+are allowed, but this could be increased if parallel writes to multiple servers
+is desired.
+
+The subrequests within a write stream do not need to match alignment or size
+with the subrequests in another write stream and netfslib performs the tiling
+of subrequests in each stream over the source buffer independently.  Further,
+each stream may contain holes that don't correspond to holes in the other
+stream.
+
+In addition, the subrequests do not need to correspond to the boundaries of the
+folios or vectors in the source/destination buffer.  The library handles the
+collection of results and the wrangling of folio flags and references.
+
+Subrequests
+-----------
+
+Subrequests are at the heart of the interaction between netfslib and the
+filesystem using it.  Each subrequest is expected to correspond to a single
+read or write RPC or cache operation.  The library will stitch together the
+results from a set of subrequests to provide a higher level operation.
+
+Netfslib has two interactions with the filesystem or the cache when setting up
+a subrequest.  First, there's an optional preparatory step that allows the
+filesystem to negotiate the limits on the subrequest, both in terms of maximum
+number of bytes and maximum number of vectors (e.g. for RDMA).  This may
+involve negotiating with the server (e.g. cifs needing to acquire credits).
+
+And, secondly, there's the issuing step in which the subrequest is handed off
+to the filesystem to perform.
+
+Note that these two steps are done slightly differently between read and write:
+
+ * For reads, the VM/VFS tells us how much is being requested up front, so the
+   library can preset maximum values that the cache and then the filesystem can
+   then reduce.  The cache also gets consulted first on whether it wants to do
+   a read before the filesystem is consulted.
+
+ * For writeback, it is unknown how much there will be to write until the
+   pagecache is walked, so no limit is set by the library.
+
+Once a subrequest is completed, the filesystem or cache informs the library of
+the completion and then collection is invoked.  Depending on whether the
+request is synchronous or asynchronous, the collection of results will be done
+in either the application thread or in a work queue.
+
+Result Collection and Retry
+---------------------------
+
+As subrequests complete, the results are collected and collated by the library
+and folio unlocking is performed progressively (if appropriate).  Once the
+request is complete, async completion will be invoked (again, if appropriate).
+It is possible for the filesystem to provide interim progress reports to the
+library to cause folio unlocking to happen earlier if possible.
+
+If any subrequests fail, netfslib can retry them.  It will wait until all
+subrequests are completed, offer the filesystem the opportunity to fiddle with
+the resources/state held by the request and poke at the subrequests before
+re-preparing and re-issuing the subrequests.
+
+This allows the tiling of contiguous sets of failed subrequest within a stream
+to be changed, adding more subrequests or ditching excess as necessary (for
+instance, if the network sizes change or the server decides it wants smaller
+chunks).
+
+Further, if one or more contiguous cache-read subrequests fail, the library
+will pass them to the filesystem to perform instead, renegotiating and retiling
+them as necessary to fit with the filesystem's parameters rather than those of
+the cache.
+
+Local Caching
+-------------
+
+One of the services netfslib provides, via ``fscache``, is the option to cache
+on local disk a copy of the data obtained from/written to a network filesystem.
+The library will manage the storing, retrieval and some invalidation of data
+automatically on behalf of the filesystem if a cookie is attached to the
+``netfs_inode``.
+
+Note that local caching used to use the PG_private_2 (aliased as PG_fscache) to
+keep track of a page that was being written to the cache, but this is now
+deprecated as PG_private_2 will be removed.
+
+Instead, folios that are read from the server for which there was no data in
+the cache will be marked as dirty and will have ``folio->private`` set to a
+special value (``NETFS_FOLIO_COPY_TO_CACHE``) and left to writeback to write.
+If the folio is modified before that happened, the special value will be
+cleared and the write will become normally dirty.
+
+When writeback occurs, folios that are so marked will only be written to the
+cache and not to the server.  Writeback handles mixed cache-only writes and
+server-and-cache writes by using two streams, sending one to the cache and one
+to the server.  The server stream will have gaps in it corresponding to those
+folios.
+
+Content Encryption (fscrypt)
+----------------------------
+
+Though it does not do so yet, at some point netfslib will acquire the ability
+to do client-side content encryption on behalf of the network filesystem (Ceph,
+for example).  fscrypt can be used for this if appropriate (it may not be -
+cifs, for example).
+
+The data will be stored encrypted in the local cache using the same manner of
+encryption as the data written to the server and the library will impose bounce
+buffering and RMW cycles as necessary.
 
 
 Per-Inode Context
@@ -40,10 +194,13 @@ structure is defined::
 	struct netfs_inode {
 		struct inode inode;
 		const struct netfs_request_ops *ops;
-		struct fscache_cookie *cache;
+		struct fscache_cookie * cache;
+		loff_t remote_i_size;
+		unsigned long flags;
+		...
 	};
 
-A network filesystem that wants to use netfs lib must place one of these in its
+A network filesystem that wants to use netfslib must place one of these in its
 inode wrapper struct instead of the VFS ``struct inode``.  This can be done in
 a way similar to the following::
 
@@ -56,7 +213,8 @@ This allows netfslib to find its state by using ``container_of()`` from the
 inode pointer, thereby allowing the netfslib helper functions to be pointed to
 directly by the VFS/VM operation tables.
 
-The structure contains the following fields:
+The structure contains the following fields that are of interest to the
+filesystem:
 
  * ``inode``
 
@@ -71,6 +229,37 @@ The structure contains the following fields:
    Local caching cookie, or NULL if no caching is enabled.  This field does not
    exist if fscache is disabled.
 
+ * ``remote_i_size``
+
+   The size of the file on the server.  This differs from inode->i_size if
+   local modifications have been made but not yet written back.
+
+ * ``flags``
+
+   A set of flags, some of which the filesystem might be interested in:
+
+   * ``NETFS_ICTX_MODIFIED_ATTR``
+
+     Set if netfslib modifies mtime/ctime.  The filesystem is free to ignore
+     this or clear it.
+
+   * ``NETFS_ICTX_UNBUFFERED``
+
+     Do unbuffered I/O upon the file.  Like direct I/O but without the
+     alignment limitations.  RMW will be performed if necessary.  The pagecache
+     will not be used unless mmap() is also used.
+
+   * ``NETFS_ICTX_WRITETHROUGH``
+
+     Do writethrough caching upon the file.  I/O will be set up and dispatched
+     as buffered writes are made to the page cache.  mmap() does the normal
+     writeback thing.
+
+   * ``NETFS_ICTX_SINGLE_NO_UPLOAD``
+
+     Set if the file has a monolithic content that must be read entirely in a
+     single go and must not be written back to the server, though it can be
+     cached (e.g. AFS directories).
 
 Inode Context Helper Functions
 ------------------------------
@@ -84,117 +273,250 @@ set the operations table pointer::
 
 then a function to cast from the VFS inode structure to the netfs context::
 
-	struct netfs_inode *netfs_node(struct inode *inode);
+	struct netfs_inode *netfs_inode(struct inode *inode);
 
 and finally, a function to get the cache cookie pointer from the context
 attached to an inode (or NULL if fscache is disabled)::
 
 	struct fscache_cookie *netfs_i_cookie(struct netfs_inode *ctx);
 
+Inode Locking
+-------------
+
+A number of functions are provided to manage the locking of i_rwsem for I/O and
+to effectively extend it to provide more separate classes of exclusion::
+
+	int netfs_start_io_read(struct inode *inode);
+	void netfs_end_io_read(struct inode *inode);
+	int netfs_start_io_write(struct inode *inode);
+	void netfs_end_io_write(struct inode *inode);
+	int netfs_start_io_direct(struct inode *inode);
+	void netfs_end_io_direct(struct inode *inode);
+
+The exclusion breaks down into four separate classes:
+
+ 1) Buffered reads and writes.
+
+    Buffered reads can run concurrently each other and with buffered writes,
+    but buffered writes cannot run concurrently with each other.
+
+ 2) Direct reads and writes.
+
+    Direct (and unbuffered) reads and writes can run concurrently since they do
+    not share local buffering (i.e. the pagecache) and, in a network
+    filesystem, are expected to have exclusion managed on the server (though
+    this may not be the case for, say, Ceph).
+
+ 3) Other major inode modifying operations (e.g. truncate, fallocate).
+
+    These should just access i_rwsem directly.
+
+ 4) mmap().
+
+    mmap'd accesses might operate concurrently with any of the other classes.
+    They might form the buffer for an intra-file loopback DIO read/write.  They
+    might be permitted on unbuffered files.
+
+Inode Writeback
+---------------
+
+Netfslib will pin resources on an inode for future writeback (such as pinning
+use of an fscache cookie) when an inode is dirtied.  However, this pinning
+needs careful management.  To manage the pinning, the following sequence
+occurs:
+
+ 1) An inode state flag ``I_PINNING_NETFS_WB`` is set by netfslib when the
+    pinning begins (when a folio is dirtied, for example) if the cache is
+    active to stop the cache structures from being discarded and the cache
+    space from being culled.  This also prevents re-getting of cache resources
+    if the flag is already set.
+
+ 2) This flag then cleared inside the inode lock during inode writeback in the
+    VM - and the fact that it was set is transferred to ``->unpinned_netfs_wb``
+    in ``struct writeback_control``.
+
+ 3) If ``->unpinned_netfs_wb`` is now set, the write_inode procedure is forced.
+
+ 4) The filesystem's ``->write_inode()`` function is invoked to do the cleanup.
+
+ 5) The filesystem invokes netfs to do its cleanup.
+
+To do the cleanup, netfslib provides a function to do the resource unpinning::
+
+	int netfs_unpin_writeback(struct inode *inode, struct writeback_control *wbc);
+
+If the filesystem doesn't need to do anything else, this may be set as a its
+``.write_inode`` method.
+
+Further, if an inode is deleted, the filesystem's write_inode method may not
+get called, so::
+
+	void netfs_clear_inode_writeback(struct inode *inode, const void *aux);
 
-Buffered Read Helpers
-=====================
+must be called from ``->evict_inode()`` *before* ``clear_inode()`` is called.
 
-The library provides a set of read helpers that handle the ->read_folio(),
-->readahead() and much of the ->write_begin() VM operations and translate them
-into a common call framework.
 
-The following services are provided:
+High-Level VFS API
+==================
 
- * Handle folios that span multiple pages.
+Netfslib provides a number of sets of API calls for the filesystem to delegate
+VFS operations to.  Netfslib, in turn, will call out to the filesystem and the
+cache to negotiate I/O sizes, issue RPCs and provide places for it to intervene
+at various times.
 
- * Insulate the netfs from VM interface changes.
+Unlocked Read/Write Iter
+------------------------
 
- * Allow the netfs to arbitrarily split reads up into pieces, even ones that
-   don't match folio sizes or folio alignments and that may cross folios.
+The first API set is for the delegation of operations to netfslib when the
+filesystem is called through the standard VFS read/write_iter methods::
 
- * Allow the netfs to expand a readahead request in both directions to meet its
-   needs.
+	ssize_t netfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter);
+	ssize_t netfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from);
+	ssize_t netfs_buffered_read_iter(struct kiocb *iocb, struct iov_iter *iter);
+	ssize_t netfs_unbuffered_read_iter(struct kiocb *iocb, struct iov_iter *iter);
+	ssize_t netfs_unbuffered_write_iter(struct kiocb *iocb, struct iov_iter *from);
 
- * Allow the netfs to partially fulfil a read, which will then be resubmitted.
+They can be assigned directly to ``.read_iter`` and ``.write_iter``.  They
+perform the inode locking themselves and the first two will switch between
+buffered I/O and DIO as appropriate.
 
- * Handle local caching, allowing cached data and server-read data to be
-   interleaved for a single request.
+Pre-Locked Read/Write Iter
+--------------------------
 
- * Handle clearing of bufferage that isn't on the server.
+The second API set is for the delegation of operations to netfslib when the
+filesystem is called through the standard VFS methods, but needs to do some
+other stuff before or after calling netfslib whilst still inside locked section
+(e.g. Ceph negotiating caps).  The unbuffered read function is::
 
- * Handle retrying of reads that failed, switching reads from the cache to the
-   server as necessary.
+	ssize_t netfs_unbuffered_read_iter_locked(struct kiocb *iocb, struct iov_iter *iter);
 
- * In the future, this is a place that other services can be performed, such as
-   local encryption of data to be stored remotely or in the cache.
+This must not be assigned directly to ``.read_iter`` and the filesystem is
+responsible for performing the inode locking before calling it.  In the case of
+buffered read, the filesystem should use ``filemap_read()``.
 
-From the network filesystem, the helpers require a table of operations.  This
-includes a mandatory method to issue a read operation along with a number of
-optional methods.
+There are three functions for writes::
 
+	ssize_t netfs_buffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *from,
+						 struct netfs_group *netfs_group);
+	ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
+				    struct netfs_group *netfs_group);
+	ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *iter,
+						   struct netfs_group *netfs_group);
 
-Read Helper Functions
+These must not be assigned directly to ``.write_iter`` and the filesystem is
+responsible for performing the inode locking before calling them.
+
+The first two functions are for buffered writes; the first just adds some
+standard write checks and jumps to the second, but if the filesystem wants to
+do the checks itself, it can use the second directly.  The third function is
+for unbuffered or DIO writes.
+
+On all three write functions, there is a writeback group pointer (which should
+be NULL if the filesystem doesn't use this).  Writeback groups are set on
+folios when they're modified.  If a folio to-be-modified is already marked with
+a different group, it is flushed first.  The writeback API allows writing back
+of a specific group.
+
+Memory-Mapped I/O API
 ---------------------
 
-Three read helpers are provided::
+An API for support of mmap()'d I/O is provided::
+
+	vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_group);
+
+This allows the filesystem to delegate ``.page_mkwrite`` to netfslib.  The
+filesystem should not take the inode lock before calling it, but, as with the
+locked write functions above, this does take a writeback group pointer.  If the
+page to be made writable is in a different group, it will be flushed first.
+
+Monolithic Files API
+--------------------
+
+There is also a special API set for files for which the content must be read in
+a single RPC (and not written back) and is maintained as a monolithic blob
+(e.g. an AFS directory), though it can be stored and updated in the local cache::
+
+	ssize_t netfs_read_single(struct inode *inode, struct file *file, struct iov_iter *iter);
+	void netfs_single_mark_inode_dirty(struct inode *inode);
+	int netfs_writeback_single(struct address_space *mapping,
+				   struct writeback_control *wbc,
+				   struct iov_iter *iter);
+
+The first function reads from a file into the given buffer, reading from the
+cache in preference if the data is cached there; the second function allows the
+inode to be marked dirty, causing a later writeback; and the third function can
+be called from the writeback code to write the data to the cache, if there is
+one.
 
-	void netfs_readahead(struct readahead_control *ractl);
-	int netfs_read_folio(struct file *file,
-			     struct folio *folio);
-	int netfs_write_begin(struct netfs_inode *ctx,
-			      struct file *file,
-			      struct address_space *mapping,
-			      loff_t pos,
-			      unsigned int len,
-			      struct folio **_folio,
-			      void **_fsdata);
+The inode should be marked ``NETFS_ICTX_SINGLE_NO_UPLOAD`` if this API is to be
+used.  The writeback function requires the buffer to be of ITER_FOLIOQ type.
 
-Each corresponds to a VM address space operation.  These operations use the
-state in the per-inode context.
+High-Level VM API
+==================
 
-For ->readahead() and ->read_folio(), the network filesystem just point directly
-at the corresponding read helper; whereas for ->write_begin(), it may be a
-little more complicated as the network filesystem might want to flush
-conflicting writes or track dirty data and needs to put the acquired folio if
-an error occurs after calling the helper.
+Netfslib also provides a number of sets of API calls for the filesystem to
+delegate VM operations to.  Again, netfslib, in turn, will call out to the
+filesystem and the cache to negotiate I/O sizes, issue RPCs and provide places
+for it to intervene at various times::
 
-The helpers manage the read request, calling back into the network filesystem
-through the supplied table of operations.  Waits will be performed as
-necessary before returning for helpers that are meant to be synchronous.
+	void netfs_readahead(struct readahead_control *);
+	int netfs_read_folio(struct file *, struct folio *);
+	int netfs_writepages(struct address_space *mapping,
+			     struct writeback_control *wbc);
+	bool netfs_dirty_folio(struct address_space *mapping, struct folio *folio);
+	void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t length);
+	bool netfs_release_folio(struct folio *folio, gfp_t gfp);
 
-If an error occurs, the ->free_request() will be called to clean up the
-netfs_io_request struct allocated.  If some parts of the request are in
-progress when an error occurs, the request will get partially completed if
-sufficient data is read.
+These are ``address_space_operations`` methods and can be set directly in the
+operations table.
 
-Additionally, there is::
+Deprecated PG_private_2 API
+---------------------------
 
-  * void netfs_subreq_terminated(struct netfs_io_subrequest *subreq,
-				 ssize_t transferred_or_error,
-				 bool was_async);
+There is also a deprecated function for filesystems that still use the
+``->write_begin`` method::
 
-which should be called to complete a read subrequest.  This is given the number
-of bytes transferred or a negative error code, plus a flag indicating whether
-the operation was asynchronous (ie. whether the follow-on processing can be
-done in the current context, given this may involve sleeping).
+	int netfs_write_begin(struct netfs_inode *inode, struct file *file,
+			      struct address_space *mapping, loff_t pos, unsigned int len,
+			      struct folio **_folio, void **_fsdata);
 
+It uses the deprecated PG_private_2 flag and so should not be used.
 
-Read Helper Structures
-----------------------
 
-The read helpers make use of a couple of structures to maintain the state of
-the read.  The first is a structure that manages a read request as a whole::
+I/O Request API
+===============
+
+The I/O request API comprises a number of structures and a number of functions
+that the filesystem may need to use.
+
+Request Structure
+-----------------
+
+The request structure manages the request as a whole, holding some resources
+and state on behalf of the filesystem and tracking the collection of results::
 
 	struct netfs_io_request {
+		enum netfs_io_origin	origin;
 		struct inode		*inode;
 		struct address_space	*mapping;
-		struct netfs_cache_resources cache_resources;
+		struct netfs_group	*group;
+		struct netfs_io_stream	io_streams[];
 		void			*netfs_priv;
-		loff_t			start;
-		size_t			len;
-		loff_t			i_size;
-		const struct netfs_request_ops *netfs_ops;
+		void			*netfs_priv2;
+		unsigned long long	start;
+		unsigned long long	len;
+		unsigned long long	i_size;
 		unsigned int		debug_id;
+		unsigned long		flags;
 		...
 	};
 
-The above fields are the ones the netfs can use.  They are:
+Many of the fields are for internal use, but the fields shown here are of
+interest to the filesystem:
+
+ * ``origin``
+
+   The origin of the request (readahead, read_folio, DIO read, writeback, ...).
 
  * ``inode``
  * ``mapping``
@@ -202,11 +524,19 @@ The above fields are the ones the netfs can use.  They are:
    The inode and the address space of the file being read from.  The mapping
    may or may not point to inode->i_data.
 
- * ``cache_resources``
+ * ``group``
+
+   The writeback group this request is dealing with or NULL.  This holds a ref
+   on the group.
+
+ * ``io_streams``
 
-   Resources for the local cache to use, if present.
+   The parallel streams of subrequests available to the request.  Currently two
+   are available, but this may be made extensible in future.  ``NR_IO_STREAMS``
+   indicates the size of the array.
 
  * ``netfs_priv``
+ * ``netfs_priv2``
 
    The network filesystem's private data.  The value for this can be passed in
    to the helper functions or set during the request.
@@ -221,37 +551,121 @@ The above fields are the ones the netfs can use.  They are:
 
    The size of the file at the start of the request.
 
- * ``netfs_ops``
-
-   A pointer to the operation table.  The value for this is passed into the
-   helper functions.
-
  * ``debug_id``
 
    A number allocated to this operation that can be displayed in trace lines
    for reference.
 
+ * ``flags``
+
+   Flags for managing and controlling the operation of the request.  Some of
+   these may be of interest to the filesystem:
+
+   * ``NETFS_RREQ_RETRYING``
+
+     Netfslib sets this when generating retries.
+
+   * ``NETFS_RREQ_PAUSE``
+
+     The filesystem can set this to request to pause the library's subrequest
+     issuing loop - but care needs to be taken as netfslib may also set it.
+
+   * ``NETFS_RREQ_NONBLOCK``
+   * ``NETFS_RREQ_BLOCKED``
+
+     Netfslib sets the first to indicate that non-blocking mode was set by the
+     caller and the filesystem can set the second to indicate that it would
+     have had to block.
+
+   * ``NETFS_RREQ_USE_PGPRIV2``
+
+     The filesystem can set this if it wants to use PG_private_2 to track
+     whether a folio is being written to the cache.  This is deprecated as
+     PG_private_2 is going to go away.
+
+If the filesystem wants more private data than is afforded by this structure,
+then it should wrap it and provide its own allocator.
+
+Stream Structure
+----------------
+
+A request is comprised of one or more parallel streams and each stream may be
+aimed at a different target.
+
+For read requests, only stream 0 is used.  This can contain a mixture of
+subrequests aimed at different sources.  For write requests, stream 0 is used
+for the server and stream 1 is used for the cache.  For buffered writeback,
+stream 0 is not enabled unless a normal dirty folio is encountered, at which
+point ->begin_writeback() will be invoked and the filesystem can mark the
+stream available.
+
+The stream struct looks like::
+
+	struct netfs_io_stream {
+		unsigned char		stream_nr;
+		bool			avail;
+		size_t			sreq_max_len;
+		unsigned int		sreq_max_segs;
+		unsigned int		submit_extendable_to;
+		...
+	};
+
+A number of members are available for access/use by the filesystem:
+
+ * ``stream_nr``
+
+   The number of the stream within the request.
+
+ * ``avail``
+
+   True if the stream is available for use.  The filesystem should set this on
+   stream zero if in ->begin_writeback().
+
+ * ``sreq_max_len``
+ * ``sreq_max_segs``
+
+   These are set by the filesystem or the cache in ->prepare_read() or
+   ->prepare_write() for each subrequest to indicate the maximum number of
+   bytes and, optionally, the maximum number of segments (if not 0) that that
+   subrequest can support.
+
+ * ``submit_extendable_to``
 
-The second structure is used to manage individual slices of the overall read
-request::
+   The size that a subrequest can be rounded up to beyond the EOF, given the
+   available buffer.  This allows the cache to work out if it can do a DIO read
+   or write that straddles the EOF marker.
+
+Subrequest Structure
+--------------------
+
+Individual units of I/O are managed by the subrequest structure.  These
+represent slices of the overall request and run independently::
 
 	struct netfs_io_subrequest {
 		struct netfs_io_request *rreq;
-		loff_t			start;
+		struct iov_iter		io_iter;
+		unsigned long long	start;
 		size_t			len;
 		size_t			transferred;
 		unsigned long		flags;
+		short			error;
 		unsigned short		debug_index;
+		unsigned char		stream_nr;
 		...
 	};
 
-Each subrequest is expected to access a single source, though the helpers will
+Each subrequest is expected to access a single source, though the library will
 handle falling back from one source type to another.  The members are:
 
  * ``rreq``
 
    A pointer to the read request.
 
+ * ``io_iter``
+
+   An I/O iterator representing a slice of the buffer to be read into or
+   written from.
+
  * ``start``
  * ``len``
 
@@ -260,241 +674,300 @@ handle falling back from one source type to another.  The members are:
 
  * ``transferred``
 
-   The amount of data transferred so far of the length of this slice.  The
-   network filesystem or cache should start the operation this far into the
-   slice.  If a short read occurs, the helpers will call again, having updated
-   this to reflect the amount read so far.
+   The amount of data transferred so far for this subrequest.  This should be
+   added to with the length of the transfer made by this issuance of the
+   subrequest.  If this is less than ``len`` then the subrequest may be
+   reissued to continue.
 
  * ``flags``
 
-   Flags pertaining to the read.  There are two of interest to the filesystem
-   or cache:
+   Flags for managing the subrequest.  There are a number of interest to the
+   filesystem or cache:
+
+   * ``NETFS_SREQ_MADE_PROGRESS``
+
+     Set by the filesystem to indicates that at least one byte of data was read
+     or written.
+
+   * ``NETFS_SREQ_HIT_EOF``
+
+     The filesystem should set this if a read hit the EOF on the file (in which
+     case ``transferred`` should stop at the EOF).  Netfslib may expand the
+     subrequest out to the size of the folio containing the EOF on the off
+     chance that a third party change happened or a DIO read may have asked for
+     more than is available.  The library will clear any excess pagecache.
 
    * ``NETFS_SREQ_CLEAR_TAIL``
 
-     This can be set to indicate that the remainder of the slice, from
-     transferred to len, should be cleared.
+     The filesystem can set this to indicate that the remainder of the slice,
+     from transferred to len, should be cleared.  Do not set if HIT_EOF is set.
+
+   * ``NETFS_SREQ_NEED_RETRY``
+
+     The filesystem can set this to tell netfslib to retry the subrequest.
+
+   * ``NETFS_SREQ_BOUNDARY``
+
+     This can be set by the filesystem on a subrequest to indicate that it ends
+     at a boundary with the filesystem structure (e.g. at the end of a Ceph
+     object).  It tells netfslib not to retile subrequests across it.
 
    * ``NETFS_SREQ_SEEK_DATA_READ``
 
-     This is a hint to the cache that it might want to try skipping ahead to
-     the next data (ie. using SEEK_DATA).
+     This is a hint from netfslib to the cache that it might want to try
+     skipping ahead to the next data (ie. using SEEK_DATA).
+
+ * ``error``
+
+   This is for the filesystem to store result of the subrequest.  It should be
+   set to 0 if successful and a negative error code otherwise.
 
  * ``debug_index``
+ * ``stream_nr``
 
    A number allocated to this slice that can be displayed in trace lines for
-   reference.
+   reference and the number of the request stream that it belongs to.
 
+If necessary, the filesystem can get and put extra refs on the subrequest it is
+given::
 
-Read Helper Operations
-----------------------
+	void netfs_get_subrequest(struct netfs_io_subrequest *subreq,
+				  enum netfs_sreq_ref_trace what);
+	void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
+				  enum netfs_sreq_ref_trace what);
 
-The network filesystem must provide the read helpers with a table of operations
-through which it can issue requests and negotiate::
+using netfs trace codes to indicate the reason.  Care must be taken, however,
+as once control of the subrequest is returned to netfslib, the same subrequest
+can be reissued/retried.
+
+Filesystem Methods
+------------------
+
+The filesystem sets a table of operations in ``netfs_inode`` for netfslib to
+use::
 
 	struct netfs_request_ops {
-		void (*init_request)(struct netfs_io_request *rreq, struct file *file);
+		mempool_t *request_pool;
+		mempool_t *subrequest_pool;
+		int (*init_request)(struct netfs_io_request *rreq, struct file *file);
 		void (*free_request)(struct netfs_io_request *rreq);
+		void (*free_subrequest)(struct netfs_io_subrequest *rreq);
 		void (*expand_readahead)(struct netfs_io_request *rreq);
-		bool (*clamp_length)(struct netfs_io_subrequest *subreq);
+		int (*prepare_read)(struct netfs_io_subrequest *subreq);
 		void (*issue_read)(struct netfs_io_subrequest *subreq);
-		bool (*is_still_valid)(struct netfs_io_request *rreq);
-		int (*check_write_begin)(struct file *file, loff_t pos, unsigned len,
-					 struct folio **foliop, void **_fsdata);
 		void (*done)(struct netfs_io_request *rreq);
+		void (*update_i_size)(struct inode *inode, loff_t i_size);
+		void (*post_modify)(struct inode *inode);
+		void (*begin_writeback)(struct netfs_io_request *wreq);
+		void (*prepare_write)(struct netfs_io_subrequest *subreq);
+		void (*issue_write)(struct netfs_io_subrequest *subreq);
+		void (*retry_request)(struct netfs_io_request *wreq,
+				      struct netfs_io_stream *stream);
+		void (*invalidate_cache)(struct netfs_io_request *wreq);
 	};
 
-The operations are as follows:
-
- * ``init_request()``
+The table starts with a pair of optional pointers to memory pools from which
+requests and subrequests can be allocated.  If these are not given, netfslib
+has default pools that it will use instead.  If the filesystem wraps the netfs
+structs in its own larger structs, then it will need to use its own pools.
+Netfslib will allocate directly from the pools.
 
-   [Optional] This is called to initialise the request structure.  It is given
-   the file for reference.
+The methods defined in the table are:
 
+ * ``init_request()``
  * ``free_request()``
+ * ``free_subrequest()``
 
-   [Optional] This is called as the request is being deallocated so that the
-   filesystem can clean up any state it has attached there.
+   [Optional] A filesystem may implement these to initialise or clean up any
+   resources that it attaches to the request or subrequest.
 
  * ``expand_readahead()``
 
    [Optional] This is called to allow the filesystem to expand the size of a
-   readahead read request.  The filesystem gets to expand the request in both
-   directions, though it's not permitted to reduce it as the numbers may
-   represent an allocation already made.  If local caching is enabled, it gets
-   to expand the request first.
+   readahead request.  The filesystem gets to expand the request in both
+   directions, though it must retain the initial region as that may represent
+   an allocation already made.  If local caching is enabled, it gets to expand
+   the request first.
 
    Expansion is communicated by changing ->start and ->len in the request
    structure.  Note that if any change is made, ->len must be increased by at
    least as much as ->start is reduced.
 
- * ``clamp_length()``
-
-   [Optional] This is called to allow the filesystem to reduce the size of a
-   subrequest.  The filesystem can use this, for example, to chop up a request
-   that has to be split across multiple servers or to put multiple reads in
-   flight.
-
-   This should return 0 on success and an error code on error.
-
- * ``issue_read()``
+ * ``prepare_read()``
 
-   [Required] The helpers use this to dispatch a subrequest to the server for
-   reading.  In the subrequest, ->start, ->len and ->transferred indicate what
-   data should be read from the server.
+   [Optional] This is called to allow the filesystem to limit the size of a
+   subrequest.  It may also limit the number of individual regions in iterator,
+   such as required by RDMA.  This information should be set on stream zero in::
 
-   There is no return value; the netfs_subreq_terminated() function should be
-   called to indicate whether or not the operation succeeded and how much data
-   it transferred.  The filesystem also should not deal with setting folios
-   uptodate, unlocking them or dropping their refs - the helpers need to deal
-   with this as they have to coordinate with copying to the local cache.
+	rreq->io_streams[0].sreq_max_len
+	rreq->io_streams[0].sreq_max_segs
 
-   Note that the helpers have the folios locked, but not pinned.  It is
-   possible to use the ITER_XARRAY iov iterator to refer to the range of the
-   inode that is being operated upon without the need to allocate large bvec
-   tables.
+   The filesystem can use this, for example, to chop up a request that has to
+   be split across multiple servers or to put multiple reads in flight.
 
- * ``is_still_valid()``
+   Zero should be returned on success and an error code otherwise.
 
-   [Optional] This is called to find out if the data just read from the local
-   cache is still valid.  It should return true if it is still valid and false
-   if not.  If it's not still valid, it will be reread from the server.
+ * ``issue_read()``
 
- * ``check_write_begin()``
+   [Required] Netfslib calls this to dispatch a subrequest to the server for
+   reading.  In the subrequest, ->start, ->len and ->transferred indicate what
+   data should be read from the server and ->io_iter indicates the buffer to be
+   used.
 
-   [Optional] This is called from the netfs_write_begin() helper once it has
-   allocated/grabbed the folio to be modified to allow the filesystem to flush
-   conflicting state before allowing it to be modified.
+   There is no return value; the ``netfs_read_subreq_terminated()`` function
+   should be called to indicate that the subrequest completed either way.
+   ->error, ->transferred and ->flags should be updated before completing.  The
+   termination can be done asynchronously.
 
-   It may unlock and discard the folio it was given and set the caller's folio
-   pointer to NULL.  It should return 0 if everything is now fine (``*foliop``
-   left set) or the op should be retried (``*foliop`` cleared) and any other
-   error code to abort the operation.
+   Note: the filesystem must not deal with setting folios uptodate, unlocking
+   them or dropping their refs - the library deals with this as it may have to
+   stitch together the results of multiple subrequests that variously overlap
+   the set of folios.
 
- * ``done``
+ * ``done()``
 
-   [Optional] This is called after the folios in the request have all been
+   [Optional] This is called after the folios in a read request have all been
    unlocked (and marked uptodate if applicable).
 
+ * ``update_i_size()``
+
+   [Optional] This is invoked by netfslib at various points during the write
+   paths to ask the filesystem to update its idea of the file size.  If not
+   given, netfslib will set i_size and i_blocks and update the local cache
+   cookie.
+   
+ * ``post_modify()``
+
+   [Optional] This is called after netfslib writes to the pagecache or when it
+   allows an mmap'd page to be marked as writable.
+   
+ * ``begin_writeback()``
+
+   [Optional] Netfslib calls this when processing a writeback request if it
+   finds a dirty page that isn't simply marked NETFS_FOLIO_COPY_TO_CACHE,
+   indicating it must be written to the server.  This allows the filesystem to
+   only set up writeback resources when it knows it's going to have to perform
+   a write.
+   
+ * ``prepare_write()``
 
+   [Optional] This is called to allow the filesystem to limit the size of a
+   subrequest.  It may also limit the number of individual regions in iterator,
+   such as required by RDMA.  This information should be set on stream to which
+   the subrequest belongs::
 
-Read Helper Procedure
----------------------
-
-The read helpers work by the following general procedure:
-
- * Set up the request.
-
- * For readahead, allow the local cache and then the network filesystem to
-   propose expansions to the read request.  This is then proposed to the VM.
-   If the VM cannot fully perform the expansion, a partially expanded read will
-   be performed, though this may not get written to the cache in its entirety.
-
- * Loop around slicing chunks off of the request to form subrequests:
-
-   * If a local cache is present, it gets to do the slicing, otherwise the
-     helpers just try to generate maximal slices.
-
-   * The network filesystem gets to clamp the size of each slice if it is to be
-     the source.  This allows rsize and chunking to be implemented.
+	rreq->io_streams[subreq->stream_nr].sreq_max_len
+	rreq->io_streams[subreq->stream_nr].sreq_max_segs
 
-   * The helpers issue a read from the cache or a read from the server or just
-     clears the slice as appropriate.
+   The filesystem can use this, for example, to chop up a request that has to
+   be split across multiple servers or to put multiple writes in flight.
 
-   * The next slice begins at the end of the last one.
+   This is not permitted to return an error.  Instead, in the event of failure,
+   ``netfs_prepare_write_failed()`` must be called.
 
-   * As slices finish being read, they terminate.
+ * ``issue_write()``
 
- * When all the subrequests have terminated, the subrequests are assessed and
-   any that are short or have failed are reissued:
+   [Required] This is used to dispatch a subrequest to the server for writing.
+   In the subrequest, ->start, ->len and ->transferred indicate what data
+   should be written to the server and ->io_iter indicates the buffer to be
+   used.
 
-   * Failed cache requests are issued against the server instead.
+   There is no return value; the ``netfs_write_subreq_terminated()`` function
+   should be called to indicate that the subrequest completed either way.
+   ->error, ->transferred and ->flags should be updated before completing.  The
+   termination can be done asynchronously.
 
-   * Failed server requests just fail.
+   Note: the filesystem must not deal with removing the dirty or writeback
+   marks on folios involved in the operation and should not take refs or pins
+   on them, but should leave retention to netfslib.
 
-   * Short reads against either source will be reissued against that source
-     provided they have transferred some more data:
+ * ``retry_request()``
 
-     * The cache may need to skip holes that it can't do DIO from.
+   [Optional] Netfslib calls this at the beginning of a retry cycle.  This
+   allows the filesystem to examine the state of the request, the subrequests
+   in the indicated stream and of its own data and make adjustments or
+   renegotiate resources.
+   
+ * ``invalidate_cache()``
 
-     * If NETFS_SREQ_CLEAR_TAIL was set, a short read will be cleared to the
-       end of the slice instead of reissuing.
+   [Optional] This is called by netfslib to invalidate data stored in the local
+   cache in the event that writing to the local cache fails, providing updated
+   coherency data that netfs can't provide.
 
- * Once the data is read, the folios that have been fully read/cleared:
+Terminating a subrequest
+------------------------
 
-   * Will be marked uptodate.
+When a subrequest completes, there are a number of functions that the cache or
+subrequest can call to inform netfslib of the status change.  One function is
+provided to terminate a write subrequest at the preparation stage and acts
+synchronously:
 
-   * If a cache is present, will be marked with PG_fscache.
+ * ``void netfs_prepare_write_failed(struct netfs_io_subrequest *subreq);``
 
-   * Unlocked
+   Indicate that the ->prepare_write() call failed.  The ``error`` field should
+   have been updated.
 
- * Any folios that need writing to the cache will then have DIO writes issued.
+Note that ->prepare_read() can return an error as a read can simply be aborted.
+Dealing with writeback failure is trickier.
 
- * Synchronous operations will wait for reading to be complete.
+The other functions are used for subrequests that got as far as being issued:
 
- * Writes to the cache will proceed asynchronously and the folios will have the
-   PG_fscache mark removed when that completes.
+ * ``void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq);``
 
- * The request structures will be cleaned up when everything has completed.
+   Tell netfslib that a read subrequest has terminated.  The ``error``,
+   ``flags`` and ``transferred`` fields should have been updated.
 
+ * ``void netfs_write_subrequest_terminated(void *_op, ssize_t transferred_or_error);``
 
-Read Helper Cache API
----------------------
+   Tell netfslib that a write subrequest has terminated.  Either the amount of
+   data processed or the negative error code can be passed in.  This is
+   can be used as a kiocb completion function.
 
-When implementing a local cache to be used by the read helpers, two things are
-required: some way for the network filesystem to initialise the caching for a
-read request and a table of operations for the helpers to call.
+ * ``void netfs_read_subreq_progress(struct netfs_io_subrequest *subreq);``
 
-To begin a cache operation on an fscache object, the following function is
-called::
+   This is provided to optionally update netfslib on the incremental progress
+   of a read, allowing some folios to be unlocked early and does not actually
+   terminate the subrequest.  The ``transferred`` field should have been
+   updated.
 
-	int fscache_begin_read_operation(struct netfs_io_request *rreq,
-					 struct fscache_cookie *cookie);
+Local Cache API
+---------------
 
-passing in the request pointer and the cookie corresponding to the file.  This
-fills in the cache resources mentioned below.
+Netfslib provides a separate API for a local cache to implement, though it
+provides some somewhat similar routines to the filesystem request API.
 
-The netfs_io_request object contains a place for the cache to hang its
+Firstly, the netfs_io_request object contains a place for the cache to hang its
 state::
 
 	struct netfs_cache_resources {
 		const struct netfs_cache_ops	*ops;
 		void				*cache_priv;
 		void				*cache_priv2;
+		unsigned int			debug_id;
+		unsigned int			inval_counter;
 	};
 
-This contains an operations table pointer and two private pointers.  The
-operation table looks like the following::
+This contains an operations table pointer and two private pointers plus the
+debug ID of the fscache cookie for tracing purposes and an invalidation counter
+that is cranked by calls to ``fscache_invalidate()`` allowing cache subrequests
+to be invalidated after completion.
+
+The cache operation table looks like the following::
 
 	struct netfs_cache_ops {
 		void (*end_operation)(struct netfs_cache_resources *cres);
-
 		void (*expand_readahead)(struct netfs_cache_resources *cres,
 					 loff_t *_start, size_t *_len, loff_t i_size);
-
 		enum netfs_io_source (*prepare_read)(struct netfs_io_subrequest *subreq,
-						       loff_t i_size);
-
+						     loff_t i_size);
 		int (*read)(struct netfs_cache_resources *cres,
 			    loff_t start_pos,
 			    struct iov_iter *iter,
 			    bool seek_data,
 			    netfs_io_terminated_t term_func,
 			    void *term_func_priv);
-
-		int (*prepare_write)(struct netfs_cache_resources *cres,
-				     loff_t *_start, size_t *_len, loff_t i_size,
-				     bool no_space_allocated_yet);
-
-		int (*write)(struct netfs_cache_resources *cres,
-			     loff_t start_pos,
-			     struct iov_iter *iter,
-			     netfs_io_terminated_t term_func,
-			     void *term_func_priv);
-
-		int (*query_occupancy)(struct netfs_cache_resources *cres,
-				       loff_t start, size_t len, size_t granularity,
-				       loff_t *_data_start, size_t *_data_len);
+		void (*prepare_write_subreq)(struct netfs_io_subrequest *subreq);
+		void (*issue_write)(struct netfs_io_subrequest *subreq);
 	};
 
 With a termination handler function pointer::
@@ -511,10 +984,16 @@ The methods defined in the table are:
 
  * ``expand_readahead()``
 
-   [Optional] Called at the beginning of a netfs_readahead() operation to allow
-   the cache to expand a request in either direction.  This allows the cache to
+   [Optional] Called at the beginning of a readahead operation to allow the
+   cache to expand a request in either direction.  This allows the cache to
    size the request appropriately for the cache granularity.
 
+ * ``prepare_read()``
+
+   [Required] Called to configure the next slice of a request.  ->start and
+   ->len in the subrequest indicate where and how big the next slice can be;
+   the cache gets to reduce the length to match its granularity requirements.
+
    The function is passed pointers to the start and length in its parameters,
    plus the size of the file for reference, and adjusts the start and length
    appropriately.  It should return one of:
@@ -528,12 +1007,6 @@ The methods defined in the table are:
    downloaded from the server or read from the cache - or whether slicing
    should be given up at the current point.
 
- * ``prepare_read()``
-
-   [Required] Called to configure the next slice of a request.  ->start and
-   ->len in the subrequest indicate where and how big the next slice can be;
-   the cache gets to reduce the length to match its granularity requirements.
-
  * ``read()``
 
    [Required] Called to read from the cache.  The start file offset is given
@@ -547,44 +1020,33 @@ The methods defined in the table are:
    indicating whether the termination is definitely happening in the caller's
    context.
 
- * ``prepare_write()``
+ * ``prepare_write_subreq()``
 
-   [Required] Called to prepare a write to the cache to take place.  This
-   involves checking to see whether the cache has sufficient space to honour
-   the write.  ``*_start`` and ``*_len`` indicate the region to be written; the
-   region can be shrunk or it can be expanded to a page boundary either way as
-   necessary to align for direct I/O.  i_size holds the size of the object and
-   is provided for reference.  no_space_allocated_yet is set to true if the
-   caller is certain that no data has been written to that region - for example
-   if it tried to do a read from there already.
+   [Required] This is called to allow the cache to limit the size of a
+   subrequest.  It may also limit the number of individual regions in iterator,
+   such as required by DIO/DMA.  This information should be set on stream to
+   which the subrequest belongs::
 
- * ``write()``
+	rreq->io_streams[subreq->stream_nr].sreq_max_len
+	rreq->io_streams[subreq->stream_nr].sreq_max_segs
 
-   [Required] Called to write to the cache.  The start file offset is given
-   along with an iterator to write from, which gives the length also.
-
-   Also provided is a pointer to a termination handler function and private
-   data to pass to that function.  The termination function should be called
-   with the number of bytes transferred or an error code, plus a flag
-   indicating whether the termination is definitely happening in the caller's
-   context.
+   The filesystem can use this, for example, to chop up a request that has to
+   be split across multiple servers or to put multiple writes in flight.
 
- * ``query_occupancy()``
+   This is not permitted to return an error.  In the event of failure,
+   ``netfs_prepare_write_failed()`` must be called.
 
-   [Required] Called to find out where the next piece of data is within a
-   particular region of the cache.  The start and length of the region to be
-   queried are passed in, along with the granularity to which the answer needs
-   to be aligned.  The function passes back the start and length of the data,
-   if any, available within that region.  Note that there may be a hole at the
-   front.
+ * ``issue_write()``
 
-   It returns 0 if some data was found, -ENODATA if there was no usable data
-   within the region or -ENOBUFS if there is no caching on this file.
+   [Required] This is used to dispatch a subrequest to the cache for writing.
+   In the subrequest, ->start, ->len and ->transferred indicate what data
+   should be written to the cache and ->io_iter indicates the buffer to be
+   used.
 
-Note that these methods are passed a pointer to the cache resource structure,
-not the read request structure as they could be used in other situations where
-there isn't a read request structure as well, such as writing dirty data to the
-cache.
+   There is no return value; the ``netfs_write_subreq_terminated()`` function
+   should be called to indicate that the subrequest completed either way.
+   ->error, ->transferred and ->flags should be updated before completing.  The
+   termination can be done asynchronously.
 
 
 API Function Reference


