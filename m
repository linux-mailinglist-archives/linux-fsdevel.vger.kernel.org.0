Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF2F21DCC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 18:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbgGMQeg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 12:34:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33817 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730146AbgGMQef (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594658072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CqhXJF7UXSuUzj+MJy08E9oZvFPZN+DukB4VERBi1NU=;
        b=I/uwfnfDK0zC42HJTU5xOr10e6npa6UgFd925aXLCFExzAUNcP3LY024CTmOVPSYgPOF3z
        TvzOlU+iWoIs8L+qdbkTRjZuf02UU24RRchiPSWQlPpKS+XWCLRsNUW/zeEdvljjfREVRV
        PM1mM3Hcu91NdxITcK2PLEFgUw2Unxk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-ZvnomP70ND2ZcJdmiSycNw-1; Mon, 13 Jul 2020 12:34:31 -0400
X-MC-Unique: ZvnomP70ND2ZcJdmiSycNw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1E001009441;
        Mon, 13 Jul 2020 16:34:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-113.rdu2.redhat.com [10.10.112.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E5205D9D7;
        Mon, 13 Jul 2020 16:34:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 20/32] cachefiles: Implement extent shaper
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Dave Wysochanski <dwysocha@redhat.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 13 Jul 2020 17:34:22 +0100
Message-ID: <159465806243.1376674.18132863053001232748.stgit@warthog.procyon.org.uk>
In-Reply-To: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
References: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement the function that shapes extents to map onto the granules in a
cache file.

When setting to fetch data from the server to be cached, the extent will be
expanded to align with granule size and cut down so that it doesn't cross
the boundary between a non-present extent and a present extent.

When setting to read data from the cache, the extent will be cut down so
that it doesn't cross the boundary between a present extent and a
non-present extent.

If no caching is taking place, whatever was requested goes.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/content-map.c |  217 ++++++++++++++++++++++++++++++++++++-------
 fs/cachefiles/internal.h    |    4 -
 fs/cachefiles/io.c          |   10 --
 3 files changed, 184 insertions(+), 47 deletions(-)

diff --git a/fs/cachefiles/content-map.c b/fs/cachefiles/content-map.c
index 594624cb1cb9..91c44bb39a93 100644
--- a/fs/cachefiles/content-map.c
+++ b/fs/cachefiles/content-map.c
@@ -15,6 +15,31 @@
 static const char cachefiles_xattr_content_map[] =
 	XATTR_USER_PREFIX "CacheFiles.content";
 
+/*
+ * Determine the map size for a granulated object.
+ *
+ * There's one bit per granule.  We size it in terms of 8-byte chunks, where a
+ * 64-bit span * 256KiB bytes granules covers 16MiB of file space.  At that,
+ * 512B will cover 1GiB.
+ */
+static size_t cachefiles_map_size(loff_t i_size)
+{
+	loff_t size;
+	size_t granules, bits, bytes, map_size;
+
+	if (i_size <= CACHEFILES_GRAN_SIZE * 64)
+		return 8;
+
+	size = i_size + CACHEFILES_GRAN_SIZE - 1;
+	granules = size / CACHEFILES_GRAN_SIZE;
+	bits = granules + (64 - 1);
+	bits &= ~(64 - 1);
+	bytes = bits / 8;
+	map_size = roundup_pow_of_two(bytes);
+	_leave(" = %zx [i=%llx g=%zu b=%zu]", map_size, i_size, granules, bits);
+	return map_size;
+}
+
 static bool cachefiles_granule_is_present(struct cachefiles_object *object,
 					  size_t granule)
 {
@@ -28,6 +53,145 @@ static bool cachefiles_granule_is_present(struct cachefiles_object *object,
 	return res;
 }
 
+/*
+ * Shape the extent of a single-chunk data object.
+ */
+static void cachefiles_shape_single(struct fscache_object *obj,
+				    struct fscache_request_shape *shape)
+{
+	struct cachefiles_object *object =
+		container_of(obj, struct cachefiles_object, fscache);
+	pgoff_t eof;
+
+	_enter("{%lx,%x,%x},%llx,%d",
+	       shape->proposed_start, shape->proposed_nr_pages,
+	       shape->max_io_pages, shape->i_size, shape->for_write);
+
+	shape->dio_block_size = CACHEFILES_DIO_BLOCK_SIZE;
+
+	if (object->content_info == CACHEFILES_CONTENT_SINGLE) {
+		shape->to_be_done = FSCACHE_READ_FROM_CACHE;
+	} else {
+		eof = (shape->i_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+		shape->actual_start = 0;
+		shape->actual_nr_pages = eof;
+		shape->granularity = 0;
+		shape->to_be_done = FSCACHE_WRITE_TO_CACHE;
+	}
+}
+
+/*
+ * Determine the size of a data extent in a cache object.
+ *
+ * In cachefiles, a data cache object is divided into granules of 256KiB, each
+ * of which must be written as a whole unit when the cache is being loaded.
+ * Data may be read out piecemeal.
+ *
+ * The extent is resized, but the result will always contain the starting page
+ * from the extent.
+ *
+ * If the granule does not exist in the cachefile, the start may be brought
+ * forward to align with the beginning of a granule boundary, and the end may be
+ * moved either way to align also.  The extent will be cut off it it would cross
+ * over the boundary between what's cached and what's not.
+ *
+ * If the starting granule does exist in the cachefile, the extent will be
+ * shortened, if necessary, so that it doesn't cross over into a region that is
+ * not present.
+ *
+ * If the granule does not exist and we cannot cache it for lack of space, the
+ * requested extent is left unaltered.
+ */
+void cachefiles_shape_request(struct fscache_object *obj,
+			      struct fscache_request_shape *shape)
+{
+	struct cachefiles_object *object =
+		container_of(obj, struct cachefiles_object, fscache);
+	unsigned int max_pages;
+	pgoff_t start, end, eof, bend;
+	size_t granule;
+
+	if (object->fscache.cookie->advice & FSCACHE_ADV_SINGLE_CHUNK) {
+		cachefiles_shape_single(obj, shape);
+		goto out;
+	}
+
+	start	= shape->proposed_start;
+	end	= shape->proposed_start + shape->proposed_nr_pages;
+	max_pages = shape->max_io_pages;
+	_enter("{%lx,%lx,%x},%llx,%d",
+	       start, end, max_pages, shape->i_size, shape->for_write);
+
+	max_pages = round_down(max_pages, CACHEFILES_GRAN_PAGES);
+	if (end - start > max_pages)
+		end = start + max_pages;
+
+	/* If the content map didn't get expanded for some reason - simply
+	 * ignore this granule.
+	 */
+	granule = start / CACHEFILES_GRAN_PAGES;
+	if (granule / 8 >= object->content_map_size)
+		return;
+
+	if (cachefiles_granule_is_present(object, granule)) {
+		/* The start of the requested extent is present in the cache -
+		 * restrict the returned extent to the maximum length of what's
+		 * available.
+		 */
+		bend = round_up(start + 1, CACHEFILES_GRAN_PAGES);
+		while (bend < end) {
+			pgoff_t i = round_up(bend + 1, CACHEFILES_GRAN_PAGES);
+			granule = i / CACHEFILES_GRAN_PAGES;
+			if (!cachefiles_granule_is_present(object, granule))
+				break;
+			bend = i;
+		}
+
+		if (end > bend)
+			end = bend;
+		shape->to_be_done = FSCACHE_READ_FROM_CACHE;
+	} else {
+		/* Otherwise expand the extent in both directions to cover what
+		 * we want for caching purposes.
+		 */
+		start = round_down(start, CACHEFILES_GRAN_PAGES);
+		end   = round_up(end, CACHEFILES_GRAN_PAGES);
+
+		/* But trim to the end of the file and the starting page */
+		eof = (shape->i_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+		if (eof <= shape->proposed_start)
+			eof = shape->proposed_start + 1;
+		if (end > eof)
+			end = eof;
+
+		if ((start << PAGE_SHIFT) >= object->fscache.cookie->zero_point) {
+			/* The start of the requested extent is beyond the
+			 * original EOF of the file on the server - therefore
+			 * it's not going to be found on the server.
+			 */
+			end = round_up(start + 1, CACHEFILES_GRAN_PAGES);
+			shape->to_be_done = FSCACHE_FILL_WITH_ZERO;
+		} else {
+			end = start + CACHEFILES_GRAN_PAGES;
+			if (end > eof)
+				end = eof;
+			shape->to_be_done = FSCACHE_WRITE_TO_CACHE;
+		}
+
+		/* TODO: Check we have space in the cache */
+	}
+
+	shape->actual_start	= start;
+	shape->actual_nr_pages	= end - start;
+	shape->granularity	= CACHEFILES_GRAN_PAGES;
+	shape->dio_block_size	= CACHEFILES_DIO_BLOCK_SIZE;
+
+out:
+	_leave(" [%x,%lx,%x]",
+	       shape->to_be_done, shape->actual_start, shape->actual_nr_pages);
+}
+
 /*
  * Mark the content map to indicate stored granule.
  */
@@ -74,23 +238,14 @@ void cachefiles_mark_content_map(struct fscache_io_request *req)
 /*
  * Expand the content map to a larger file size.
  */
-void cachefiles_expand_content_map(struct cachefiles_object *object, loff_t size)
+void cachefiles_expand_content_map(struct cachefiles_object *object, loff_t i_size)
 {
+	size_t size;
 	u8 *map, *zap;
 
-	/* Determine the size.  There's one bit per granule.  We size it in
-	 * terms of 8-byte chunks, where a 64-bit span * 256KiB bytes granules
-	 * covers 16MiB of file space.  At that, 512B will cover 1GiB.
-	 */
-	if (size > 0) {
-		size += CACHEFILES_GRAN_SIZE - 1;
-		size /= CACHEFILES_GRAN_SIZE;
-		size += 8 - 1;
-		size /= 8;
-		size = roundup_pow_of_two(size);
-	} else {
-		size = 8;
-	}
+	size = cachefiles_map_size(i_size);
+
+	_enter("%llx,%zx,%x", i_size, size, object->content_map_size);
 
 	if (size <= object->content_map_size)
 		return;
@@ -122,7 +277,7 @@ void cachefiles_shorten_content_map(struct cachefiles_object *object,
 				    loff_t new_size)
 {
 	struct fscache_cookie *cookie = object->fscache.cookie;
-	loff_t granule, o_granule;
+	size_t granule, tmp, bytes;
 
 	if (object->fscache.cookie->advice & FSCACHE_ADV_SINGLE_CHUNK)
 		return;
@@ -137,12 +292,16 @@ void cachefiles_shorten_content_map(struct cachefiles_object *object,
 		granule += CACHEFILES_GRAN_SIZE - 1;
 		granule /= CACHEFILES_GRAN_SIZE;
 
-		o_granule = cookie->object_size;
-		o_granule += CACHEFILES_GRAN_SIZE - 1;
-		o_granule /= CACHEFILES_GRAN_SIZE;
+		tmp = granule;
+		tmp = round_up(granule, 64);
+		bytes = tmp / 8;
+		if (bytes < object->content_map_size)
+			memset(object->content_map + bytes, 0,
+			       object->content_map_size - bytes);
 
-		for (; o_granule > granule; o_granule--)
-			clear_bit_le(o_granule, object->content_map);
+		if (tmp > granule)
+			for (tmp--; tmp > granule; tmp--)
+				clear_bit_le(tmp, object->content_map);
 	}
 
 	write_unlock_bh(&object->content_map_lock);
@@ -157,7 +316,7 @@ bool cachefiles_load_content_map(struct cachefiles_object *object)
 						      struct cachefiles_cache, cache);
 	const struct cred *saved_cred;
 	ssize_t got;
-	loff_t size;
+	size_t size;
 	u8 *map = NULL;
 
 	_enter("c=%08x,%llx",
@@ -176,19 +335,7 @@ bool cachefiles_load_content_map(struct cachefiles_object *object)
 		 * bytes granules covers 16MiB of file space.  At that, 512B
 		 * will cover 1GiB.
 		 */
-		size = object->fscache.cookie->object_size;
-		if (size > 0) {
-			size += CACHEFILES_GRAN_SIZE - 1;
-			size /= CACHEFILES_GRAN_SIZE;
-			size += 8 - 1;
-			size /= 8;
-			if (size < 8)
-				size = 8;
-			size = roundup_pow_of_two(size);
-		} else {
-			size = 8;
-		}
-
+		size = cachefiles_map_size(object->fscache.cookie->object_size);
 		map = kzalloc(size, GFP_KERNEL);
 		if (!map)
 			return false;
@@ -212,7 +359,7 @@ bool cachefiles_load_content_map(struct cachefiles_object *object)
 		object->content_map = map;
 		object->content_map_size = size;
 		object->content_info = CACHEFILES_CONTENT_MAP;
-		_leave(" = t [%zd/%llu %*phN]", got, size, (int)size, map);
+		_leave(" = t [%zd/%zu %*phN]", got, size, (int)size, map);
 	}
 
 	return true;
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 4085c1185693..2ea469b77712 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -125,6 +125,8 @@ extern void cachefiles_daemon_unbind(struct cachefiles_cache *cache);
 /*
  * content-map.c
  */
+extern void cachefiles_shape_request(struct fscache_object *object,
+				     struct fscache_request_shape *shape);
 extern void cachefiles_mark_content_map(struct fscache_io_request *req);
 extern void cachefiles_expand_content_map(struct cachefiles_object *object, loff_t size);
 extern void cachefiles_shorten_content_map(struct cachefiles_object *object, loff_t new_size);
@@ -149,8 +151,6 @@ extern struct fscache_object *cachefiles_grab_object(struct fscache_object *_obj
 /*
  * io.c
  */
-extern void cachefiles_shape_request(struct fscache_object *object,
-				     struct fscache_request_shape *shape);
 extern int cachefiles_read(struct fscache_object *object,
 			   struct fscache_io_request *req,
 			   struct iov_iter *iter);
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index e324b835b1a0..ddb44ec5a199 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -12,16 +12,6 @@
 #include <linux/xattr.h>
 #include "internal.h"
 
-/*
- * Determine the size of a data extent in a cache object.  This must be written
- * as a whole unit, but can be read piecemeal.
- */
-void cachefiles_shape_request(struct fscache_object *object,
-			      struct fscache_request_shape *shape)
-{
-	return 0;
-}
-
 /*
  * Initiate a read from the cache.
  */


