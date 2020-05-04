Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6710E1C4238
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 19:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbgEDRQy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 13:16:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21186 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730483AbgEDRQx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 13:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588612609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x7Uywdr6nAcQ2rake66KOqd3r0XzFRioKYfDUknBApw=;
        b=PcTUQeBszqy7he/0RrL69Gdtu1nuctIBtXnIrq0l2PB8mqHM+f2eP0nUXvDIBWe2xohukR
        SOh5FfITZh2H/r+zRnIoPqe4iTQ8NwkQjyHaZhRvgVEXT9yV2CbMVHShvkk6WqLuH5m/m3
        knbGD6CcoUwQzx6WdttmrYicltEq0gM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-BhACQHrAOzyww9-TTu7mHQ-1; Mon, 04 May 2020 13:16:45 -0400
X-MC-Unique: BhACQHrAOzyww9-TTu7mHQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCD088014D7;
        Mon,  4 May 2020 17:16:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD9B86F133;
        Mon,  4 May 2020 17:16:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 60/61] fscache: Document the new netfs API
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Jeff Layton <jlayton@redhat.com>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 04 May 2020 18:16:39 +0100
Message-ID: <158861259989.340223.11154339813692528296.stgit@warthog.procyon.org.uk>
In-Reply-To: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
References: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Document the netfs parts of the rewritten caching API.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/filesystems/caching/netfs-api.txt |  488 ++++++++++++++++++-----
 1 file changed, 372 insertions(+), 116 deletions(-)

diff --git a/Documentation/filesystems/caching/netfs-api.txt b/Documentation/filesystems/caching/netfs-api.txt
index a39de0a4f336..5f8f031b423f 100644
--- a/Documentation/filesystems/caching/netfs-api.txt
+++ b/Documentation/filesystems/caching/netfs-api.txt
@@ -28,11 +28,13 @@ This document contains the following sections:
 	- Index registration
 	- Data file registration
 	- Miscellaneous object registration
-	- Index and data file consistency
 	- Miscellaneous cookie operations
 	- Cookie unregistration
-	- Index invalidation
-	- Data file invalidation
+	- Coherency management
+	- Preparing to access data
+	- I/O request shaping
+	- Submitting I/O requests
+	- Read helpers
 	- FS-Cache specific page flag
 
 
@@ -88,9 +90,9 @@ Indices are used for two purposes:
 
 However, since it's unlikely that any two netfs's are going to want to define
 their index hierarchies in quite the same way, FS-Cache tries to impose as few
-restraints as possible on how an index is structured and where it is placed in
-the tree.  The netfs can even mix indices and data files at the same level, but
-it's not recommended.
+restrictions as possible on how an index is structured and where it is placed
+in the tree.  The netfs can even mix indices and data files at the same level,
+but it's not recommended.
 
 Each index entry consists of a key of indeterminate length plus some auxiliary
 data, also of indeterminate length.
@@ -151,7 +153,7 @@ This takes a text string as the name and returns a representation of a tag.  It
 will never return an error.  It may return a dummy tag, however, if it runs out
 of memory; this will inhibit caching with this tag.
 
-Any representation so obtained must be released by passing it to this function:
+The tag must be released by passing it to this function:
 
 	void fscache_release_cache_tag(struct fscache_cache_tag *tag);
 
@@ -169,114 +171,93 @@ the path to the file:
 
 	struct fscache_cookie *
 	fscache_acquire_cookie(struct fscache_cookie *parent,
-			       const struct fscache_object_def *def,
+			       enum fscache_cookie_type type,
+			       const char *type_name,
+			       u8 advice,
+			       struct fscache_cache_tag *preferred_cache,
 			       const void *index_key,
 			       size_t index_key_len,
 			       const void *aux_data,
 			       size_t aux_data_len,
-			       void *netfs_data,
-			       loff_t object_size,
-			       bool enable);
+			       loff_t object_size);
 
-This function creates an index entry in the index represented by parent,
-filling in the index entry by calling the operations pointed to by def.
+This function creates an index entry in the index represented by parent.  The
+entry is of the given type (FSCACHE_COOKIE_TYPE_*) and should be given a small
+type name for display purposes in /proc (trimmed to 7 chars).
+
+The advice flags inform the cache as to how best to handle the object:
+
+ (*) FSCACHE_ADV_SINGLE_CHUNK - The object is all one piece and will only be
+     written or read as a whole.  Without this, it is assumed that the object
+     can be treated as granular.
+
+ (*) FSCACHE_ADV_WRITE_CACHE - Write local changes to the cache.
+
+ (*) FSCACHE_ADV_WRITE_NOCACHE - Don't write local changes to the cache, but
+     rather invalidate the object and cease caching it.
+
+A tag indicating the preferred cache for this object can be given in
+preferred_cache.  If not given, this will be derived from the parent cookie.
 
 A unique key that represents the object within the parent must be pointed to by
-index_key and is of length index_key_len.
+index_key and is of length index_key_len.  A warning will be logged if a cookie
+with this key already exists and NULL will be returned.
 
 An optional blob of auxiliary data that is to be stored within the cache can be
 pointed to with aux_data and should be of length aux_data_len.  This would
-typically be used for storing coherency data.
+typically be used for storing coherency data and will be checked against
+whatever is in the cache when the cache object is located.
 
-The netfs may pass an arbitrary value in netfs_data and this will be presented
-to it in the event of any calling back.  This may also be used in tracing or
-logging of messages.
+object_size indicates the expected size of the object.  This is used for
+trimming the cache object on release rather than coherency checks.
 
-Note that this function never returns an error - all errors are handled
-internally.  It may, however, return NULL to indicate no cookie.  It is quite
-acceptable to pass this token back to this function as the parent to another
-acquisition (or even to the relinquish cookie, read page and write page
-functions - see below).
+That this function never returns an error - all errors are handled internally.
+It may, however, return NULL to indicate no cookie.  It is quite acceptable to
+pass this token back to this function as the parent to another acquisition (or
+even to the relinquish cookie, read and write functions - see below).
 
-Note also that no indices are actually created in a cache until a non-index
-object needs to be created somewhere down the hierarchy.  Furthermore, an index
-may be created in several different caches independently at different times.
-This is all handled transparently, and the netfs doesn't see any of it.
+Note also that no cache activity will take place until the cache is 'used' to
+access a data object.  This is handled transparently, and the netfs doesn't see
+any of it.
 
 For example, with AFS, a cell would be added to the primary index.  This index
 entry would have a dependent inode containing volume mappings within this cell:
 
 	cell->cache =
 		fscache_acquire_cookie(afs_cache_netfs.primary_index,
-				       &afs_cell_cache_index_def,
+				       FSCACHE_COOKIE_TYPE_INDEX,
+				       "AFS.cell",
+				       0, NULL,
 				       cell->name, strlen(cell->name),
-				       NULL, 0,
-				       cell, 0, true);
+				       NULL, 0, 0);
 
 And then a particular volume could be added to that index by ID, creating
 another index for vnodes (AFS inode equivalents):
 
 	volume->cache =
 		fscache_acquire_cookie(volume->cell->cache,
-				       &afs_volume_cache_index_def,
+				       FSCACHE_COOKIE_TYPE_INDEX,
+				       "AFS.vol",
 				       &volume->vid, sizeof(volume->vid),
-				       NULL, 0,
-				       volume, 0, true);
+				       NULL, 0, 0);
 
 
 ======================
 DATA FILE REGISTRATION
 ======================
 
-The fourth step is to request a data file be created in the cache.  This is
-identical to index cookie acquisition.  The only difference is that the type in
-the object definition should be something other than index type.
+The fourth step is to register a data file with the in the cache.  This is more
+or less identical to index cookie acquisition.
 
 	vnode->cache =
 		fscache_acquire_cookie(volume->cache,
-				       &afs_vnode_cache_object_def,
+				       FSCACHE_COOKIE_TYPE_DATAFILE,
+				       "AFS.vnode",
+				       FSCACHE_ADV_SINGLE_CHUNK,
+				       NULL,
 				       &key, sizeof(key),
 				       &aux, sizeof(aux),
-				       vnode, vnode->status.size, true);
-
-
-=================================
-MISCELLANEOUS OBJECT REGISTRATION
-=================================
-
-An optional step is to request an object of miscellaneous type be created in
-the cache.  This is almost identical to index cookie acquisition.  The only
-difference is that the type in the object definition should be something other
-than index type.  While the parent object could be an index, it's more likely
-it would be some other type of object such as a data file.
-
-	xattr->cache =
-		fscache_acquire_cookie(vnode->cache,
-				       &afs_xattr_cache_object_def,
-				       &xattr->name, strlen(xattr->name),
-				       NULL, 0,
-				       xattr, strlen(xattr->val), true);
-
-Miscellaneous objects might be used to store extended attributes or directory
-entries for example.
-
-
-===============================
-INDEX AND DATA FILE CONSISTENCY
-===============================
-
-To request an update of the index data for an index or other object, the
-following function should be called:
-
-	void fscache_update_cookie(struct fscache_cookie *cookie,
-				   const void *aux_data);
-
-This function will update the cookie's auxiliary data buffer from aux_data if
-that is non-NULL and then schedule this to be stored on disk.  The update
-method in the parent index definition will be called to transfer the data.
-
-Note that partial updates may happen automatically at other times, such as when
-data blocks are added to a data file object.
+				       vnode->status.size);
 
 
 ===============================
@@ -306,65 +287,342 @@ COOKIE UNREGISTRATION
 To get rid of a cookie, this function should be called.
 
 	void fscache_relinquish_cookie(struct fscache_cookie *cookie,
-				       const void *aux_data,
 				       bool retire);
 
-If retire is non-zero, then the object will be marked for recycling, and all
-copies of it will be removed from all active caches in which it is present.
-Not only that but all child objects will also be retired.
+If retire is non-zero, then the object and, if an index, all its children will
+be invalidated, and all copies of will be removed from all active caches in
+which it is present.
 
-If retire is zero, then the object may be available again when next the
+If retire is false, then the object may be available again when next the
 acquisition function is called.  Retirement here will overrule the pinning on a
 cookie.
 
-The cookie's auxiliary data will be updated from aux_data if that is non-NULL
-so that the cache can lazily update it on disk.
-
 One very important note - relinquish must NOT be called for a cookie unless all
-the cookies for "child" indices, objects and pages have been relinquished
-first.
+the cookies for "child" cookies have been relinquished first and the cookie has
+been un-used.
 
 
-==================
-INDEX INVALIDATION
-==================
+====================
+COHERENCY MANAGEMENT
+====================
 
-There is no direct way to invalidate an index subtree.  To do this, the caller
-should relinquish and retire the cookie they have, and then acquire a new one.
+Coherency is managed at a number of points in the lifecycle of a cache object.
+Firstly, as previously mentioned, coherency data is stored in the auxiliary
+data buffer in the cookie.  This is initially filled in at cookie acquisition,
+but can be updated arbitrarily by calling:
 
+	void fscache_update_cookie(struct fscache_cookie *cookie,
+				   const void *aux_data,
+				   const loff_t *object_size);
 
-======================
-DATA FILE INVALIDATION
-======================
+This will update the cookie's auxiliary data buffer from aux_data if that is
+non-NULL and the cached size of the object if object_size is non-NULL.
+
+An opportunity to update the coherency information is also provided in the
+parameters passed to fscache_unuse_cookie().
+
+Beyond that, a data object cookie can also be arbitrarily invalidated at any
+time by calling:
+
+	void fscache_invalidate(struct fscache_cookie *cookie,
+				unsigned int flags);
+
+or by passing true to the 'retire' argument of fscache_relinquish_cookie() when
+the cookie is discarded.  Index cookies may only be retired and not arbitrarily
+invalidated as they refer to an entire subtree.
+
+Invalidation is typically done when a foreign change is detected on the server
+with which a network filesystem is communicating.
+
+With fscache_invalidate(), in-progress I/O operations to the cache object will
+be cancelled as best they can and upcoming I/O operations will be made to wait
+until the invalidation is completed.
+
+The flags parameter can be used to qualify the level of invalidation:
+
+ (*) FSCACHE_INVAL_LIGHT - Invalidation need not do anything if the object has
+     already been invalidated and a temporary object is in use.
+
+
+========================
+PREPARING TO ACCESS DATA
+========================
+
+Before a data object can be accessed, the netfs must tell the cache that it
+wants to actively use an object.  This can be done with:
+
+	void fscache_use_cookie(struct fscache_cookie *cookie,
+				bool will_modify);
+
+This allows the cache to prepare any resources, open files, etc. so that it can
+deal with upcoming requests.  At this time, the objects on disk will be looked
+up and/or created as necessary.
+
+The cookie parameter indicates the object to be accessed and the will_modify
+parameter indicates whether this is for the purpose of caching a local write
+to the netfs (note that *reading* in the netfs may result in writes to the
+cache - this is not what this flag is used for).
+
+When the netfs has finished with an object, it should call the counterpart
+function:
+
+	void fscache_unuse_cookie(struct fscache_cookie *cookie,
+				  const void *aux_data,
+				  const loff_t *object_size);
+
+This drops the activity count on the cookie and provides an opportunity to
+update the cached coherency data and object size.
+
+It is permitted to 'use' a cookie multiple times concurrently - say for every
+open of a netfs file.  The number of users is counted and the object state is
+kept in memory until the users drops off to zero.  The state may be kept around
+for a while after that in case further operations are performed as it may cache
+the result of slow, synchronous filesystem operations.
+
+
+===================
+I/O REQUEST SHAPING
+===================
+
+When making a read or a write on the cache, the request needs to be 'shaped'.
+This requires making the request align to the granularity of the cache (for
+content-tracking purposes) and the I/O block size of the backing filesystem
+(for direct-I/O purposes).
+
+The way to do this is to fill in an instance of the following structure:
+
+	struct fscache_extent {
+		pgoff_t		start;
+		pgoff_t		block_end;
+		pgoff_t		limit;
+		unsigned int	dio_block_size;
+	};
+
+where 'start' and 'block_end' define the pages in a contiguous read that is
+intended to be made.  'limit' indicates the maximum page that can be read and
+should be ULONG_MAX if no limit is set.  Note that both 'block_end' and 'limit'
+should be set to the page index after the last page included in the proposed
+set.  dio_block_size can be ignored at this point.
+
+For instance, to read the first two pages of a file:
+
+	.start		= 0,
+	.block_end	= 2,
+	.limit		= ULONG_MAX,
+
+Then the following function can be called:
+
+	unsigned int fscache_shape_extent(struct fscache_cookie *cookie,
+					  struct fscache_extent *extent,
+					  loff_t i_size, bool for_write);
 
-Sometimes it will be necessary to invalidate an object that contains data.
-Typically this will be necessary when the server tells the netfs of a foreign
-change - at which point the netfs has to throw away all the state it had for an
-inode and reload from the server.
+where 'i_size' indicates the size of the netfs file (proposed size in the case
+of a write that increases it) and 'for_write' indicates if this is for a local
+write to the netfs.
 
-To indicate that a cache object should be invalidated, the following function
-can be called:
+For a granular object (ie. not single-chunk) and if for_write is false, this
+will:
 
-	void fscache_invalidate(struct fscache_cookie *cookie);
+ (1) Round start down and round block_end up or down to the nearest granule
+     boundaries, such that the extent does not cross a data-hole transition in
+     the cache (ie. it's all-read or all-write) and doesn't transgress the
+     stated limit.
 
-All extant storage, retrieval and attribute change ops at this point are
-cancelled and discarded.  Some future operations will be rejected until the
-cache has had a chance to insert a barrier in the operations queue.  After
-that, operations will be queued again behind the invalidation operation.
+ (2) Round limit down to indicate the maximum size of a single read the cache
+     can entertain.
 
-The invalidation operation will perform an attribute change operation and an
-auxiliary data update operation as it is very likely these will have changed.
+In the granular case, if for_write is true, then the writes only need to be
+DIO-aligned as it is assumed that the caller has pre-fetched the block from the
+cache.
+
+Note that the cache granule size may vary between cache objects and may vary
+within a cache object.
+
+For a single-chunk object, start is reduced to 0 and block_end and limit are
+set to the EOF, indicating that the cache wants the whole chunk.
+
+In all cases, on return dio_block_size will be set to the cache's I/O block
+size and the function will return 0, FSCACHE_READ_FROM_CACHE or
+FSCACHE_WRITE_TO_CACHE to indicate whether any I/O can/should be done to/from
+the cache.
+
+
+=======================
+SUBMITTING I/O REQUESTS
+=======================
+
+Data I/O on a cache object is done using a reference-counted request descriptor
+and four functions.  To begin an I/O operation, the descriptor must be
+allocated by the netfs and then initialised by calling:
+
+	void fscache_init_io_request(struct fscache_io_request *req,
+				     struct fscache_cookie *cookie,
+				     const struct fscache_io_request_ops *ops);
+
+This sets fields in the request, allocates any resources it needs and takes a
+reference on the cookie.  Once the references have run out, the cache's
+resources in the I/O request descriptor are cleaned up with:
+
+	void fscache_free_io_request(struct fscache_io_request *req)
+
+I/O is initiated with one of two functions, one to read:
+
+	int fscache_read(struct fscache_io_request *req,
+			 struct iov_iter *iter);
+
+and one to write:
+
+	int fscache_write(struct fscache_io_request *req,
+			  struct iov_iter *iter);
+
+Both of them use an I/O iterator, 'iter', to indicate the data/buffer to be
+written/read into.  Other parameters are defined by the request descriptor,
+including the position and length of the transfer and an optional function to
+be called on completion of the I/O operation:
+
+	struct fscache_io_request {
+		loff_t		pos;
+		loff_t		len;
+		void (*io_done)(struct fscache_io_request *);
+
+A number of fields are then filled in upon completion of the I/O operation:
+
+		loff_t		transferred;
+		short		error;
+		bool		data_from_server;
+		bool		data_from_cache;
+		...
+	};
+
+including the amount of data transferred, any error that occurred and the
+source of the data.
+
+The request descriptor must also be supplied with a table of operations:
+
+	struct fscache_io_request_ops {
+		bool (*is_still_valid)(struct fscache_io_request *);
+		void (*get)(struct fscache_io_request *);
+		void (*put)(struct fscache_io_request *);
+		...
+	};
+
+including methods to find out if a cache operation is still valid after a wait
+to begin an operation and methods to get or put a reference on the operation.
+
+[!] Note that the 'put' method may be called in softirq context and be unable
+    to sleep.  A 'work' member is available in the request struct to allow
+    cleanup to be offloaded to a workqueue.
+
+Note that there are other fields and operations in these structures that
+pertain to the read helpers rather than the above I/O operations and are
+discussed there.
+
+The read and write ops will return 0 on immediate success, -EIOCBQUEUED if the
+operation has been queued for asynchronous I/O, -ESTALE if the cache object
+became invalid, -ENODATA if there's no data to read or -ENOBUFS if caching is
+unavailable.  Apart from -EIOCBQUEUED, the error will also be placed in the
+request descriptor.
+
+
+============
+READ HELPERS
+============
+
+Read helpers are available that do all the work of shaping I/O, reading from
+the cache, falling back to issue a read to the server and writing the result to
+the cache.
+
+The first helper is for reading granulated I/O that is read asynchronously in
+units of pages:
+
+	int fscache_read_helper(struct fscache_io_request *req,
+				struct fscache_extent *extent,
+				struct page **requested_page,
+				struct list_head *pages,
+				enum fscache_read_type type,
+				unsigned int aop_flags);
+
+This must be called with a partially prepared request.  It will fill in the
+pos, len and io_done fields for itself.
+
+This function can be called in one of three modes:
+
+ (1) Multipage read (ie. readpages).
+
+     In this case, 'type' should be set to FSCACHE_READ_PAGE_LIST and 'pages'
+     should be pointed at a list of pages that is in reverse order of index.
+     'extent' should indicate the proposed contiguous run.  requested_page
+     should be NULL.  'aop_flags' is ignored.
+
+ (2) Read to locked page (ie. readpage).
+
+     In this case, 'type' should be set to FSCACHE_READ_LOCKED_PAGE and
+     '*requested_page' should point to the page to be read.  'pages' should be
+     NULL.  'aop_flags' is ignored.
+
+ (3) Prefetch for write (ie. write_begin).
+
+     In this case, 'type' should be set to FSCACHE_READ_FOR_WRITE and
+     '*requested_page' should point to either a pointer to the page to be read
+     or to a NULL pointer that will be filled in.  'pages' should be NULL.
+     'aop_flags' indicates the AOP_FLAG_* to be used when getting the primary
+     page.  On success, '*requested_page' will be filled in with the primary
+     page and the caller will be left needing to unlock it and release the ref
+     on it.
+
+Two additional request operations must also be provided:
+
+	struct fscache_io_request_ops {
+		...
+		void (*issue_op)(struct fscache_io_request *);
+		void (*done)(struct fscache_io_request *);
+	};
+
+'issue_op' will be called to issue a request to the server and 'done' will be
+called upon completion of the read phase of the request (though an asynchronous
+write to the cache may still be outstanding).
+
+fscache_read_helper() will attempt to expand/shape the request to fit the
+cache, filling in holes and padding both sides with extra pages attached to the
+cache, though it will abandon that if it finds an uptodate page in the way.
+
+It will attempt to read from the cache first, and if this is unavailable or
+unsuccessful, it will use 'issue_op' to talk to the server.  In the latter
+case, if successful, it will set the PG_fscache bits on the pages involved and
+begin a write to the cache.
+
+
+The second helper is for single-chunk I/O that is read or written synchronously
+as a complete unit:
+
+	int fscache_read_helper_single(
+		struct fscache_io_request *req,
+		int (*check)(struct fscache_io_request *req));
+
+This also requires a prepared request descriptor, but also requires the caller
+to have done the work in creating and locking those pages.  It waits for
+previous writes to the cache to get out of the way and then issues reads
+against the cache and/or the server and writes the data to the cache much in
+the same way as fscache_read_helper().  Reads will, however, be synchronous.
+Upon a successful return, the data is guaranteed to have finished being read,
+though writing to the cache may still be in progress.
 
 
 ===========================
 FS-CACHE SPECIFIC PAGE FLAG
 ===========================
 
-FS-Cache makes use of a page flag, PG_private_2, for its own purpose.  This is
-given the alternative name PG_fscache.
+FS-Cache makes use of a page flag, PG_private_2, to indicate that a page is
+undergoing write to the cache.  This is given the alternative name PG_fscache.
+
+The netfs should wait on PG_fscache in:
 
-The netfs can use this information in methods such as releasepage() to
-determine whether it needs to uncache a page or update it.
+	releasepage()
+	invalidatepage()
+	write_begin() - after calling fscache_read_helper()
+	writepage()
+	writepages()
+	page_mkwrite()
 
 Furthermore, if this bit is set, releasepage() and invalidatepage() operations
 will be called on a page to get rid of it, even if PG_private is not set.
@@ -372,13 +630,11 @@ will be called on a page to get rid of it, even if PG_private is not set.
 This bit does not overlap with such as PG_private.  This means that FS-Cache
 can be used with a filesystem that uses the block buffering code.
 
-There are a number of operations defined on this flag:
+There are a number of operations defined for this flag:
 
 	int PageFsCache(struct page *page);
 	void SetPageFsCache(struct page *page)
 	void ClearPageFsCache(struct page *page)
 	int TestSetPageFsCache(struct page *page)
 	int TestClearPageFsCache(struct page *page)
-
-These functions are bit test, bit set, bit clear, bit test and set and bit
-test and clear operations on PG_fscache.
+	wait_on_page_fscache(struct page *page);


