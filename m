Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82BA91C423E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 19:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbgEDRRF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 13:17:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58744 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730701AbgEDRRF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 13:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588612622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lkhriDR9F1rTct6MC2yWfGXDgXzrKohoMCG19+XqaXY=;
        b=eyNDGTUQBJxlVTZY6WO6K6mKOBBSfjChrUAErxuzI6IBUuBvKn94xDAmp7ZImZNPYYwHyO
        w3tOzD0aELsBO8lbuWlA5RZCVkolrUs1jiJ/OZoc9r2cYZ9y4d+JeJqDREnzQuGSArDTfQ
        5Yg9wFwyHLGobU1COo2wDk8zD1dTvwc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-2U_mJ75IPvKu-w7RL6yRoQ-1; Mon, 04 May 2020 13:16:54 -0400
X-MC-Unique: 2U_mJ75IPvKu-w7RL6yRoQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E868107B288;
        Mon,  4 May 2020 17:16:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC3DB60E1C;
        Mon,  4 May 2020 17:16:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 61/61] fscache: Document the rewritten cache backend API
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
Date:   Mon, 04 May 2020 18:16:49 +0100
Message-ID: <158861260900.340223.17584394318899057798.stgit@warthog.procyon.org.uk>
In-Reply-To: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
References: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Document the rewritten cache backend API.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/filesystems/caching/backend-api.txt |  172 ++++++++++++++++++---
 1 file changed, 148 insertions(+), 24 deletions(-)

diff --git a/Documentation/filesystems/caching/backend-api.txt b/Documentation/filesystems/caching/backend-api.txt
index 710d10408fcb..9af6f9618576 100644
--- a/Documentation/filesystems/caching/backend-api.txt
+++ b/Documentation/filesystems/caching/backend-api.txt
@@ -42,7 +42,7 @@ previously initialised cache definition to:
 			      struct fscache_object *fsdef,
 			      const char *tagname);
 
-Two extra arguments should also be supplied:
+Two further arguments should also be supplied:
 
  (*) "fsdef" which should point to the object representation for the FS-Cache
      master index in this cache.  Netfs primary index entries will be created
@@ -50,9 +50,7 @@ Two extra arguments should also be supplied:
      successful and will release it upon withdrawal of the cache.
 
  (*) "tagname" which, if given, should be a text string naming this cache.  If
-     this is NULL, the identifier will be used instead.  For CacheFS, the
-     identifier is set to name the underlying block device and the tag can be
-     supplied by mount.
+     this is NULL, the identifier will be used instead.
 
 This function may return -ENOMEM if it ran out of memory or -EEXIST if the tag
 is already in use.  0 will be returned on success.
@@ -156,28 +154,45 @@ performed on the denizens of the cache.  These are held in a structure of type:
  (*) Allocate a new object [mandatory]:
 
 	struct fscache_object *(*alloc_object)(struct fscache_cache *cache,
-					       struct fscache_cookie *cookie)
+					       struct fscache_cookie *cookie,
+					       struct fscache_object *parent)
 
      This method is used to allocate a cache object representation to back a
      cookie in a particular cache.  fscache_object_init() should be called on
      the object to initialise it prior to returning.
 
+ (*) Prepare lookup data [mandatory]:
 
- (*) Look up and create object [mandatory]:
+	void *(*prepare_lookup_data)(struct fscache_object *object);
 
-	void (*lookup_object)(struct fscache_object *object)
+     This method is used to prepare lookup data that can be passed to the
+     lookup_object and create_object methods.
+
+
+ (*) Look up an object [mandatory]:
+
+	void (*lookup_object)(struct fscache_object *object,
+			      void *lookup_data);
 
      This method is used to look up an object, given that the object is already
-     allocated and attached to the cookie.  This should instantiate that object
-     in the cache if it can.
+     allocated and attached to the cookie.
+
+
+ (*) Create an object [mandatory]:
+
+	void (*create_object)(struct fscache_object *object,
+			      void *lookup_data);
+
+     This method is used to create an object that has previously been looked
+     up.
 
 
  (*) Release lookup data [mandatory]:
 
-	void (*lookup_complete)(struct fscache_object *object)
+	void (*free_lookup_data)(struct fscache_object *object,
+				 void *lookup_data);
 
-     This method is called to ask the cache to release any resources it was
-     using to perform a lookup.
+     This method is called to clean up the lookup data.
 
 
  (*) Increment object refcount [mandatory]:
@@ -202,23 +217,27 @@ performed on the denizens of the cache.  These are held in a structure of type:
 
 	int (*update_object)(struct fscache_object *object)
 
-     This is called to update the index entry for the specified object.  The
-     new information should be in object->cookie->aux and ->object_size.
+     This is called to update the coherency for the specified object and to
+     trim the cache object to size.  The cache should use the information
+     stored in object->cookie->aux and ->object_size for this purpose.
 
 
  (*) Invalidate data object [mandatory]:
 
-	int (*invalidate_object)(struct fscache_operation *op)
+	int (*invalidate_object)(struct fscache_operation *op,
+				 unsigned int flags)
 
      This is called to invalidate a data object.
 
 
  (*) Discard object [mandatory]:
 
-	void (*drop_object)(struct fscache_object *object)
+	void (*drop_object)(struct fscache_object *object,
+			    bool invalidate)
 
      This method is called to indicate that an object has been unbound from its
-     cookie.
+     cookie.  If invalidate is true, the object should be removed from the
+     cache.
 
      This method should not attempt to release any references held by the
      caller.  The caller will invoke the put_object() method as appropriate.
@@ -228,8 +247,16 @@ performed on the denizens of the cache.  These are held in a structure of type:
 
 	void (*put_object)(struct fscache_object *object)
 
-     This method is used to discard a reference to an object.  The object may
-     be freed when all the references to it are released.
+     This method is used to discard a reference to an object.  The object
+     should be freeable when all the references to it are released.
+
+
+ (*) Get object reference count [mandatory]:
+
+	unsigned int (*get_object_usage)(const struct fscache_object *object);
+
+     This method is used to read the reference count on an object for display
+     purposes.
 
 
  (*) Synchronise a cache [mandatory]:
@@ -258,12 +285,85 @@ performed on the denizens of the cache.  These are held in a structure of type:
      size if larger than that already.
 
 
+ (*) Shape request extent [mandatory]:
+
+	unsigned int (*shape_extent)(struct fscache_object *object,
+				     struct fscache_extent *extent,
+				     loff_t i_size, bool for_write);
+
+     This method is called to shape a request according to the granularity of
+     the cache's content tracking.  The cache may expand and contract the
+     extent, but it is required to keep the start page within the shaped
+     extent.
+
+ (*) Read data from the cache [mandatory]:
+
+	int (*read)(struct fscache_object *object,
+		    struct fscache_io_request *req,
+		    struct iov_iter *iter);
+
+     This method is called to read data from the cache into the buffer
+     specified by 'iter'.  The location and length of the read are specified in
+     the request descriptor.  The operation must be synchronous if req->io_done
+     is not set.  req->io_done() must be called if provided, though this may be
+     deferred if asynchronous I/O is used and -EIOCBQUEUED returned.
+
+     The netfs is expected to have rounded its request to units of
+     dio_block_size as returned by ->shape_extent().
+
+     req->error, req->transferred and req->data_from_cache should be updated as
+     appropriate and fscache_end_io_operation() and fscache_put_io_request()
+     called.  If the operation didn't read all the data, -ENODATA should be
+     set.
+
+ (*) Write data to the cache [mandatory]:
+
+	int (*write)(struct fscache_object *object,
+		     struct fscache_io_request *req,
+		     struct iov_iter *iter);
+
+     This method is called to write data from the buffer specified by 'iter'
+     into the cache.  The location and length of the write are specified in the
+     request descriptor.  The operation must be synchronous if req->io_done is
+     not set.  req->io_done() must be called if provided, though this may be
+     deferred if asynchronous I/O is used and -EIOCBQUEUED returned.
+
+     The netfs is expected to have rounded its request to units of
+     dio_block_size as returned by ->shape_extent().
+
+     req->error should be updated as appropriate and fscache_end_io_operation()
+     and fscache_put_io_request() called.  If the operation didn't write all
+     the data, -ENOBUFS should be set.
+
+ (*) Prepare to write to a live cache object [mandatory]:
+
+	int (*prepare_to_write)(struct fscache_object *object);
+
+     This method is called when fscache_use_object() is called on an object
+     that already exists and will_modify is true and FSCACHE_OBJECT_LOCAL_WRITE
+     was not yet set on the object.  This allows the cache to mark the object
+     as being dirty prior to writing data to it, or to take a local copy.
+
+ (*) Display object info [mandatory]:
+
+	int (*display_object)(struct seq_file *m, struct fscache_object *object);
+
+     This method is called to summarise an object in /proc/fs/fscache/objects.
+
+
 ==================
 FS-CACHE UTILITIES
 ==================
 
 FS-Cache provides some utilities that a cache backend may make use of:
 
+ (*) The filesystem index cookie:
+
+	struct fscache_cookie fscache_fsdef_index
+
+     This is the cookie to which the object passed to fscache_add_cache() are
+     bound.
+
  (*) Note occurrence of an I/O error in a cache:
 
 	void fscache_io_error(struct fscache_cache *cache)
@@ -283,14 +383,13 @@ FS-Cache provides some utilities that a cache backend may make use of:
      This initialises all the fields in an object representation.
 
 
- (*) Indicate the destruction of an object:
+ (*) Bracket the destruction of an object.
 
+	void fscache_object_destroy(struct fscache_object *object);
 	void fscache_object_destroyed(struct fscache_cache *cache);
 
-     This must be called to inform FS-Cache that an object that belonged to a
-     cache has been destroyed and deallocated.  This will allow continuation
-     of the cache withdrawal process when it is stopped pending destruction of
-     all the objects.
+     These must be called on either side of object destruction to clean up the
+     FS-Cache parts of an object and do the accounting.
 
 
  (*) Indicate that a stale object was found and discarded:
@@ -314,3 +413,28 @@ FS-Cache provides some utilities that a cache backend may make use of:
 	FSCACHE_OBJECT_NO_SPACE - there was insufficient cache space
 	FSCACHE_OBJECT_WAS_RETIRED - the object was retired when relinquished.
 	FSCACHE_OBJECT_WAS_CULLED - the object was culled to make space.
+
+
+ (*) Get pointers to the cookie index key and coherency data buffers:
+
+	void *fscache_get_key(struct fscache_cookie *cookie);
+	void *fscache_get_aux(struct fscache_cookie *cookie);
+
+     These handle the switching between internal buffering for small data and
+     kmalloc'd buffering for larger data.
+
+
+ (*) End an I/O operation:
+
+	void fscache_end_io_operation(struct fscache_cookie *cookie);
+
+     This is call to manage the accounting at the end of an I/O operation.
+
+
+ (*) Get/put references on I/O request descriptors.
+
+	void fscache_get_io_request(struct fscache_io_request *req);
+	void fscache_put_io_request(struct fscache_io_request *req);
+
+     Manage references on I/O request descriptors.  These may be called in
+     softirq context.


