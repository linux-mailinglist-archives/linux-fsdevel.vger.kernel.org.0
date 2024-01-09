Return-Path: <linux-fsdevel+bounces-7600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B188284CC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 12:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B9472873B6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 11:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EF338F8A;
	Tue,  9 Jan 2024 11:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NAU+CMkJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CE9381D0
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jan 2024 11:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704799252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fR5jKaj4zqBjWF982EotHFYbvpWpLhYokRvcwfgk5DQ=;
	b=NAU+CMkJoz9twwWoUs8WmzWEDaPM+RLGyF1kciSn1Bg8ZZi/k/xK2xlcauvQQh2PiH+7Hx
	fULZ2rGWmJhBSF8VZ8AfDCEW5fFyIGm8FQFbEtReatmWLuvicxmLf8qOYGAN7ii/5f14SI
	c/mCrdIQY/E0ZfKQHifBEGIz0aYHqaM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-Gs55spOOMJaH-_bIsqDWkA-1; Tue,
 09 Jan 2024 06:20:50 -0500
X-MC-Unique: Gs55spOOMJaH-_bIsqDWkA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7AF6629AA3A5;
	Tue,  9 Jan 2024 11:20:49 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 93EA31C060B1;
	Tue,  9 Jan 2024 11:20:46 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: David Howells <dhowells@redhat.com>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] netfs: Fix interaction between write-streaming and cachefiles culling
Date: Tue,  9 Jan 2024 11:20:20 +0000
Message-ID: <20240109112029.1572463-4-dhowells@redhat.com>
In-Reply-To: <20240109112029.1572463-1-dhowells@redhat.com>
References: <20240109112029.1572463-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

An issue can occur between write-streaming (storing dirty data in partial
non-uptodate pages) and a cachefiles object being culled to make space.
The problem occurs because the cache object is only marked in use while
there are files open using it.  Once it has been released, it can be culled
and the cookie marked disabled.

At this point, a streaming write is permitted to occur (if the cache is
active, we require pages to be prefetched and cached), but the cache can
become active again before this gets flushed out - and then two effects can
occur:

 (1) The cache may be asked to write out a region that's less than its DIO
     block size (assumed by cachefiles to be PAGE_SIZE) - and this causes
     one of two debugging statements to be emitted.

 (2) netfs_how_to_modify() gets confused because it sees a page that isn't
     allowed to be non-uptodate being uptodate and tries to prefetch it -
     leading to a warning that PG_fscache is set twice.

Fix this by the following means:

 (1) Add a netfs_inode flag to disallow write-streaming to an inode and set
     it if we ever do local caching of that inode.  It remains set for the
     lifetime of that inode - even if the cookie becomes disabled.

 (2) If the no-write-streaming flag is set, then make netfs_how_to_modify()
     always want to prefetch instead.

 (3) If netfs_how_to_modify() decides it wants to prefetch a folio, but
     that folio has write-streamed data in it, then it requires the folio
     be flushed first.

 (4) Export a counter of the number of times we wanted to prefetch a
     non-uptodate page, but found it had write-streamed data in it.

 (5) Export a counter of the number of times we cancelled a write to the
     cache because it didn't DIO align and remove the debug statements.

Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-erofs@lists.ozlabs.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/cachefiles/io.c            | 12 ++++++------
 fs/netfs/buffered_write.c     | 24 ++++++++++++++++++++----
 fs/netfs/fscache_stats.c      |  9 ++++++---
 fs/netfs/internal.h           |  1 +
 fs/netfs/stats.c              |  6 ++++--
 include/linux/fscache-cache.h |  3 +++
 include/linux/netfs.h         |  1 +
 7 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 7529b40bc95a..3eec26967437 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -528,12 +528,12 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
 
 	/* Round to DIO size */
 	start = round_down(*_start, PAGE_SIZE);
-	if (start != *_start) {
-		kleave(" = -ENOBUFS [down]");
-		return -ENOBUFS;
-	}
-	if (*_len > upper_len) {
-		kleave(" = -ENOBUFS [up]");
+	if (start != *_start || *_len > upper_len) {
+		/* Probably asked to cache a streaming write written into the
+		 * pagecache when the cookie was temporarily out of service to
+		 * culling.
+		 */
+		fscache_count_dio_misfit();
 		return -ENOBUFS;
 	}
 
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 08f28800232c..6cd8f7422e9a 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -80,10 +80,19 @@ static enum netfs_how_to_modify netfs_how_to_modify(struct netfs_inode *ctx,
 		return NETFS_WHOLE_FOLIO_MODIFY;
 
 	if (file->f_mode & FMODE_READ)
-		return NETFS_JUST_PREFETCH;
-
-	if (netfs_is_cache_enabled(ctx))
-		return NETFS_JUST_PREFETCH;
+		goto no_write_streaming;
+	if (test_bit(NETFS_ICTX_NO_WRITE_STREAMING, &ctx->flags))
+		goto no_write_streaming;
+
+	if (netfs_is_cache_enabled(ctx)) {
+		/* We don't want to get a streaming write on a file that loses
+		 * caching service temporarily because the backing store got
+		 * culled.
+		 */
+		if (!test_bit(NETFS_ICTX_NO_WRITE_STREAMING, &ctx->flags))
+			set_bit(NETFS_ICTX_NO_WRITE_STREAMING, &ctx->flags);
+		goto no_write_streaming;
+	}
 
 	if (!finfo)
 		return NETFS_STREAMING_WRITE;
@@ -95,6 +104,13 @@ static enum netfs_how_to_modify netfs_how_to_modify(struct netfs_inode *ctx,
 	if (offset == finfo->dirty_offset + finfo->dirty_len)
 		return NETFS_STREAMING_WRITE_CONT;
 	return NETFS_FLUSH_CONTENT;
+
+no_write_streaming:
+	if (finfo) {
+		netfs_stat(&netfs_n_wh_wstream_conflict);
+		return NETFS_FLUSH_CONTENT;
+	}
+	return NETFS_JUST_PREFETCH;
 }
 
 /*
diff --git a/fs/netfs/fscache_stats.c b/fs/netfs/fscache_stats.c
index aad812ead398..add21abdf713 100644
--- a/fs/netfs/fscache_stats.c
+++ b/fs/netfs/fscache_stats.c
@@ -48,13 +48,15 @@ atomic_t fscache_n_no_create_space;
 EXPORT_SYMBOL(fscache_n_no_create_space);
 atomic_t fscache_n_culled;
 EXPORT_SYMBOL(fscache_n_culled);
+atomic_t fscache_n_dio_misfit;
+EXPORT_SYMBOL(fscache_n_dio_misfit);
 
 /*
  * display the general statistics
  */
 int fscache_stats_show(struct seq_file *m)
 {
-	seq_puts(m, "FS-Cache statistics\n");
+	seq_puts(m, "-- FS-Cache statistics --\n");
 	seq_printf(m, "Cookies: n=%d v=%d vcol=%u voom=%u\n",
 		   atomic_read(&fscache_n_cookies),
 		   atomic_read(&fscache_n_volumes),
@@ -93,8 +95,9 @@ int fscache_stats_show(struct seq_file *m)
 		   atomic_read(&fscache_n_no_create_space),
 		   atomic_read(&fscache_n_culled));
 
-	seq_printf(m, "IO     : rd=%u wr=%u\n",
+	seq_printf(m, "IO     : rd=%u wr=%u mis=%u\n",
 		   atomic_read(&fscache_n_read),
-		   atomic_read(&fscache_n_write));
+		   atomic_read(&fscache_n_write),
+		   atomic_read(&fscache_n_dio_misfit));
 	return 0;
 }
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 3f9620d0fa63..ec7045d24400 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -123,6 +123,7 @@ extern atomic_t netfs_n_rh_write_begin;
 extern atomic_t netfs_n_rh_write_done;
 extern atomic_t netfs_n_rh_write_failed;
 extern atomic_t netfs_n_rh_write_zskip;
+extern atomic_t netfs_n_wh_wstream_conflict;
 extern atomic_t netfs_n_wh_upload;
 extern atomic_t netfs_n_wh_upload_done;
 extern atomic_t netfs_n_wh_upload_failed;
diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
index 42db36528d92..deeba9f9dcf5 100644
--- a/fs/netfs/stats.c
+++ b/fs/netfs/stats.c
@@ -29,6 +29,7 @@ atomic_t netfs_n_rh_write_begin;
 atomic_t netfs_n_rh_write_done;
 atomic_t netfs_n_rh_write_failed;
 atomic_t netfs_n_rh_write_zskip;
+atomic_t netfs_n_wh_wstream_conflict;
 atomic_t netfs_n_wh_upload;
 atomic_t netfs_n_wh_upload_done;
 atomic_t netfs_n_wh_upload_failed;
@@ -66,9 +67,10 @@ int netfs_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&netfs_n_wh_write),
 		   atomic_read(&netfs_n_wh_write_done),
 		   atomic_read(&netfs_n_wh_write_failed));
-	seq_printf(m, "Netfs  : rr=%u sr=%u\n",
+	seq_printf(m, "Netfs  : rr=%u sr=%u wsc=%u\n",
 		   atomic_read(&netfs_n_rh_rreq),
-		   atomic_read(&netfs_n_rh_sreq));
+		   atomic_read(&netfs_n_rh_sreq),
+		   atomic_read(&netfs_n_wh_wstream_conflict));
 	return fscache_stats_show(m);
 }
 EXPORT_SYMBOL(netfs_stats_show);
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index a174cedf4d90..bdf7f3eddf0a 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -189,17 +189,20 @@ extern atomic_t fscache_n_write;
 extern atomic_t fscache_n_no_write_space;
 extern atomic_t fscache_n_no_create_space;
 extern atomic_t fscache_n_culled;
+extern atomic_t fscache_n_dio_misfit;
 #define fscache_count_read() atomic_inc(&fscache_n_read)
 #define fscache_count_write() atomic_inc(&fscache_n_write)
 #define fscache_count_no_write_space() atomic_inc(&fscache_n_no_write_space)
 #define fscache_count_no_create_space() atomic_inc(&fscache_n_no_create_space)
 #define fscache_count_culled() atomic_inc(&fscache_n_culled)
+#define fscache_count_dio_misfit() atomic_inc(&fscache_n_dio_misfit)
 #else
 #define fscache_count_read() do {} while(0)
 #define fscache_count_write() do {} while(0)
 #define fscache_count_no_write_space() do {} while(0)
 #define fscache_count_no_create_space() do {} while(0)
 #define fscache_count_culled() do {} while(0)
+#define fscache_count_dio_misfit() do {} while(0)
 #endif
 
 #endif /* _LINUX_FSCACHE_CACHE_H */
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index d3bac60fcd6f..100cbb261269 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -142,6 +142,7 @@ struct netfs_inode {
 #define NETFS_ICTX_ODIRECT	0		/* The file has DIO in progress */
 #define NETFS_ICTX_UNBUFFERED	1		/* I/O should not use the pagecache */
 #define NETFS_ICTX_WRITETHROUGH	2		/* Write-through caching */
+#define NETFS_ICTX_NO_WRITE_STREAMING	3	/* Don't engage in write-streaming */
 };
 
 /*


