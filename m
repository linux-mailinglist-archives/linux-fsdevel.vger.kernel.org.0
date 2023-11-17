Return-Path: <linux-fsdevel+bounces-3062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DED7EF9CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 22:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA8341F275BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 21:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB82647775;
	Fri, 17 Nov 2023 21:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGHcEf8h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC241BE2
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 13:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700255787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mTplFuJpJrC57Jye0A7Rs4hbbfJuamUNfWOMgqHa0J4=;
	b=AGHcEf8hWHaqHJF7sOrK9+FxUJxlqAPV1DOS6hZGMQyVZABUMizko6JU5SkX+pYn0SriwK
	Zn9Qfb8gpalXgmX2aplWrkDruNvXsRO0mBBtc4lsz0A/FGIPhAV0VqpK3VGwwlylLBY8qX
	aIUuv6rBKfWLMLQ3mLEJ9Deq1QCoZhw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416--GTGqoDDPru6VxvXd71HSQ-1; Fri,
 17 Nov 2023 16:16:24 -0500
X-MC-Unique: -GTGqoDDPru6VxvXd71HSQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04CDD28040B4;
	Fri, 17 Nov 2023 21:16:23 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 64D1040C6EB9;
	Fri, 17 Nov 2023 21:16:20 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/51] netfs: Provide tools to create a buffer in an xarray
Date: Fri, 17 Nov 2023 21:15:02 +0000
Message-ID: <20231117211544.1740466-11-dhowells@redhat.com>
In-Reply-To: <20231117211544.1740466-1-dhowells@redhat.com>
References: <20231117211544.1740466-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Provide tools to create a buffer in an xarray, with a function to add new
folios with a mark.  This will be used to create bounce buffer and can be
used more easily to create a list of folios the span of which would require
more than a page's worth of bio_vec structs.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/internal.h   | 13 +++++++
 fs/netfs/misc.c       | 81 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h |  4 +++
 3 files changed, 98 insertions(+)

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 1f067aa96c50..21a47f118009 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -52,6 +52,19 @@ static inline void netfs_proc_add_rreq(struct netfs_io_request *rreq) {}
 static inline void netfs_proc_del_rreq(struct netfs_io_request *rreq) {}
 #endif
 
+/*
+ * misc.c
+ */
+#define NETFS_FLAG_PUT_MARK		BIT(0)
+#define NETFS_FLAG_PAGECACHE_MARK	BIT(1)
+int netfs_xa_store_and_mark(struct xarray *xa, unsigned long index,
+			    struct folio *folio, unsigned int flags,
+			    gfp_t gfp_mask);
+int netfs_add_folios_to_buffer(struct xarray *buffer,
+			       struct address_space *mapping,
+			       pgoff_t index, pgoff_t to, gfp_t gfp_mask);
+void netfs_clear_buffer(struct xarray *buffer);
+
 /*
  * objects.c
  */
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index c3baf2b247d9..106f2fbdccd8 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -8,6 +8,87 @@
 #include <linux/swap.h>
 #include "internal.h"
 
+/*
+ * Attach a folio to the buffer and maybe set marks on it to say that we need
+ * to put the folio later and twiddle the pagecache flags.
+ */
+int netfs_xa_store_and_mark(struct xarray *xa, unsigned long index,
+			    struct folio *folio, unsigned int flags,
+			    gfp_t gfp_mask)
+{
+	XA_STATE_ORDER(xas, xa, index, folio_order(folio));
+
+retry:
+	xas_lock(&xas);
+	for (;;) {
+		xas_store(&xas, folio);
+		if (!xas_error(&xas))
+			break;
+		xas_unlock(&xas);
+		if (!xas_nomem(&xas, gfp_mask))
+			return xas_error(&xas);
+		goto retry;
+	}
+
+	if (flags & NETFS_FLAG_PUT_MARK)
+		xas_set_mark(&xas, NETFS_BUF_PUT_MARK);
+	if (flags & NETFS_FLAG_PAGECACHE_MARK)
+		xas_set_mark(&xas, NETFS_BUF_PAGECACHE_MARK);
+	xas_unlock(&xas);
+	return xas_error(&xas);
+}
+
+/*
+ * Create the specified range of folios in the buffer attached to the read
+ * request.  The folios are marked with NETFS_BUF_PUT_MARK so that we know that
+ * these need freeing later.
+ */
+int netfs_add_folios_to_buffer(struct xarray *buffer,
+			       struct address_space *mapping,
+			       pgoff_t index, pgoff_t to, gfp_t gfp_mask)
+{
+	struct folio *folio;
+	int ret;
+
+	if (to + 1 == index) /* Page range is inclusive */
+		return 0;
+
+	do {
+		/* TODO: Figure out what order folio can be allocated here */
+		folio = filemap_alloc_folio(readahead_gfp_mask(mapping), 0);
+		if (!folio)
+			return -ENOMEM;
+		folio->index = index;
+		ret = netfs_xa_store_and_mark(buffer, index, folio,
+					      NETFS_FLAG_PUT_MARK, gfp_mask);
+		if (ret < 0) {
+			folio_put(folio);
+			return ret;
+		}
+
+		index += folio_nr_pages(folio);
+	} while (index <= to && index != 0);
+
+	return 0;
+}
+
+/*
+ * Clear an xarray buffer, putting a ref on the folios that have
+ * NETFS_BUF_PUT_MARK set.
+ */
+void netfs_clear_buffer(struct xarray *buffer)
+{
+	struct folio *folio;
+	XA_STATE(xas, buffer, 0);
+
+	rcu_read_lock();
+	xas_for_each_marked(&xas, folio, ULONG_MAX, NETFS_BUF_PUT_MARK) {
+		folio_put(folio);
+	}
+	rcu_read_unlock();
+	xa_destroy(buffer);
+}
+
 /**
  * netfs_invalidate_folio - Invalidate or partially invalidate a folio
  * @folio: Folio proposed for release
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 6d820a860052..47270f5d9e89 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -109,6 +109,10 @@ static inline int wait_on_page_fscache_killable(struct page *page)
 	return folio_wait_private_2_killable(page_folio(page));
 }
 
+/* Marks used on xarray-based buffers */
+#define NETFS_BUF_PUT_MARK	XA_MARK_0	/* - Page needs putting  */
+#define NETFS_BUF_PAGECACHE_MARK XA_MARK_1	/* - Page needs wb/dirty flag wrangling */
+
 enum netfs_io_source {
 	NETFS_FILL_WITH_ZEROES,
 	NETFS_DOWNLOAD_FROM_SERVER,


