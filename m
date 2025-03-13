Return-Path: <linux-fsdevel+bounces-43978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EB4A605E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 00:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 555F4422592
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 23:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1685F20E708;
	Thu, 13 Mar 2025 23:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SjpypCXx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EC520DD54
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 23:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908943; cv=none; b=pbXBk9HhXoWEDcLwzSaBCAHvmgKNsq/lEHpP+dCqJmGaomuRhUBAtydh971HlJmk92pJ1DBzLLc80nQpD2m9B4Egmlkeh3U2H0ngjkYbojXIhLaDRO/oTxgfWRo6L7wry2B05nUF+4WQo8Y7AxbvfcpoklTQBfTaVIwROFqtkzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908943; c=relaxed/simple;
	bh=7t4syejk2Ap8A2Bv+ZlpSBwz2DzYMksQcfs7WWVUA5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oISjkj/YgOUSOsOLt89XF4C9nS7FE9YUZJpt/R++7T0SGgc3J6Pajx+6q/9jGjSvavtLZPX5LRPtN02QBvGbtWF34e76UsTyhZeNCw956G7CUp7zNKDZI9H3DFE/IwDnuHXXvvwjdwAjiMG2nQFfd83Hp+zc9ONiYqyF0Sggspw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SjpypCXx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YLiTeAvB3TgtihHrmX2Xj+lq/9LyEs5c10u6Qa3bzY4=;
	b=SjpypCXxo8XAt28/977YNvgSwXR/o4/N3TEXV2rec+rBfbQ5HZhMBcPfNMUTI6PiKujCy0
	eiDvjDeuBE26RAq9wxAJ1MDCHGScFbEALm4YNFRjJm4GVE82fU+1zeczPyj4biIHdqeQLm
	6O0e48lrBFHC10VkLEOTog2cs9xzTBE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-5kZeNjvvMFeDQV-68Zevtg-1; Thu,
 13 Mar 2025 19:35:37 -0400
X-MC-Unique: 5kZeNjvvMFeDQV-68Zevtg-1
X-Mimecast-MFC-AGG-ID: 5kZeNjvvMFeDQV-68Zevtg_1741908934
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2ECFD180049D;
	Thu, 13 Mar 2025 23:35:34 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CD6021954B32;
	Thu, 13 Mar 2025 23:35:31 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	Alex Markuze <amarkuze@redhat.com>
Cc: David Howells <dhowells@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 28/35] netfs: Adjust group handling
Date: Thu, 13 Mar 2025 23:33:20 +0000
Message-ID: <20250313233341.1675324-29-dhowells@redhat.com>
In-Reply-To: <20250313233341.1675324-1-dhowells@redhat.com>
References: <20250313233341.1675324-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Make some adjustments to the handling of netfs groups so that ceph can use
them for snap contexts:

 - Move netfs_get_group(), netfs_put_group() and netfs_put_group_many() to
   linux/netfs.h so that ceph can build its snap context on netfs groups.

 - Move netfs_set_group() and __netfs_set_group() to linux/netfs.h so that
   ceph_dirty_folio() can call them from inside of the locked section in
   which it finds the snap context to attach.

 - Provide a netfs_writepages_group() that takes a group as a parameter and
   attaches it to the request and make netfs_free_request() drop the ref on
   it.  netfs_writepages() then becomes a wrapper that passes in a NULL
   group.

 - In netfs_perform_write(), only consider a folio to have a conflicting
   group if the folio's group pointer isn't NULL and if the folio is dirty.

 - In netfs_perform_write(), interject a small 10ms sleep after every 16
   attempts to flush a folio within a single call.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_write.c | 25 ++++-------------
 fs/netfs/internal.h       | 32 ---------------------
 fs/netfs/objects.c        |  1 +
 fs/netfs/write_issue.c    | 38 +++++++++++++++++++++----
 include/linux/netfs.h     | 59 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 98 insertions(+), 57 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 0245449b93e3..12ddbe9bc78b 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -11,26 +11,9 @@
 #include <linux/pagemap.h>
 #include <linux/slab.h>
 #include <linux/pagevec.h>
+#include <linux/delay.h>
 #include "internal.h"
 
-static void __netfs_set_group(struct folio *folio, struct netfs_group *netfs_group)
-{
-	if (netfs_group)
-		folio_attach_private(folio, netfs_get_group(netfs_group));
-}
-
-static void netfs_set_group(struct folio *folio, struct netfs_group *netfs_group)
-{
-	void *priv = folio_get_private(folio);
-
-	if (unlikely(priv != netfs_group)) {
-		if (netfs_group && (!priv || priv == NETFS_FOLIO_COPY_TO_CACHE))
-			folio_attach_private(folio, netfs_get_group(netfs_group));
-		else if (!netfs_group && priv == NETFS_FOLIO_COPY_TO_CACHE)
-			folio_detach_private(folio);
-	}
-}
-
 /*
  * Grab a folio for writing and lock it.  Attempt to allocate as large a folio
  * as possible to hold as much of the remaining length as possible in one go.
@@ -113,6 +96,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 	};
 	struct netfs_io_request *wreq = NULL;
 	struct folio *folio = NULL, *writethrough = NULL;
+	unsigned int flush_counter = 0;
 	unsigned int bdp_flags = (iocb->ki_flags & IOCB_NOWAIT) ? BDP_ASYNC : 0;
 	ssize_t written = 0, ret, ret2;
 	loff_t i_size, pos = iocb->ki_pos;
@@ -208,7 +192,8 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		group = netfs_folio_group(folio);
 
 		if (unlikely(group != netfs_group) &&
-		    group != NETFS_FOLIO_COPY_TO_CACHE)
+		    group != NETFS_FOLIO_COPY_TO_CACHE &&
+		    (group || folio_test_dirty(folio)))
 			goto flush_content;
 
 		if (folio_test_uptodate(folio)) {
@@ -341,6 +326,8 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		trace_netfs_folio(folio, netfs_flush_content);
 		folio_unlock(folio);
 		folio_put(folio);
+		if ((++flush_counter & 0xf) == 0xf)
+			msleep(10);
 		ret = filemap_write_and_wait_range(mapping, fpos, fpos + flen - 1);
 		if (ret < 0)
 			goto error_folio_unlock;
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index eebb4f0f660e..2a6123c4da35 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -261,38 +261,6 @@ static inline bool netfs_is_cache_enabled(struct netfs_inode *ctx)
 #endif
 }
 
-/*
- * Get a ref on a netfs group attached to a dirty page (e.g. a ceph snap).
- */
-static inline struct netfs_group *netfs_get_group(struct netfs_group *netfs_group)
-{
-	if (netfs_group && netfs_group != NETFS_FOLIO_COPY_TO_CACHE)
-		refcount_inc(&netfs_group->ref);
-	return netfs_group;
-}
-
-/*
- * Dispose of a netfs group attached to a dirty page (e.g. a ceph snap).
- */
-static inline void netfs_put_group(struct netfs_group *netfs_group)
-{
-	if (netfs_group &&
-	    netfs_group != NETFS_FOLIO_COPY_TO_CACHE &&
-	    refcount_dec_and_test(&netfs_group->ref))
-		netfs_group->free(netfs_group);
-}
-
-/*
- * Dispose of a netfs group attached to a dirty page (e.g. a ceph snap).
- */
-static inline void netfs_put_group_many(struct netfs_group *netfs_group, int nr)
-{
-	if (netfs_group &&
-	    netfs_group != NETFS_FOLIO_COPY_TO_CACHE &&
-	    refcount_sub_and_test(nr, &netfs_group->ref))
-		netfs_group->free(netfs_group);
-}
-
 /*
  * Check to see if a buffer aligns with the crypto block size.  If it doesn't
  * the crypto layer is going to copy all the data - in which case relying on
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index 52d6fce70837..7fdbaa5c5cab 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -153,6 +153,7 @@ static void netfs_free_request(struct work_struct *work)
 		kvfree(rreq->direct_bv);
 	}
 
+	netfs_put_group(rreq->group);
 	rolling_buffer_clear(&rreq->buffer);
 	rolling_buffer_clear(&rreq->bounce);
 	if (test_bit(NETFS_RREQ_PUT_RMW_TAIL, &rreq->flags))
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 93601033ba08..3921fcf4f859 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -418,7 +418,7 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 		netfs_issue_write(wreq, upload);
 	} else if (fgroup != wreq->group) {
 		/* We can't write this page to the server yet. */
-		kdebug("wrong group");
+		kdebug("wrong group %px != %px", fgroup, wreq->group);
 		folio_redirty_for_writepage(wbc, folio);
 		folio_unlock(folio);
 		netfs_issue_write(wreq, upload);
@@ -593,11 +593,19 @@ static void netfs_end_issue_write(struct netfs_io_request *wreq)
 		netfs_wake_write_collector(wreq, false);
 }
 
-/*
- * Write some of the pending data back to the server
+/**
+ * netfs_writepages_group - Flush data from the pagecache for a file
+ * @mapping: The file to flush from
+ * @wbc: Details of what should be flushed
+ * @group: The write grouping to flush (or NULL)
+ *
+ * Start asynchronous write back operations to flush dirty data belonging to a
+ * particular group in a file's pagecache back to the server and to the local
+ * cache.
  */
-int netfs_writepages(struct address_space *mapping,
-		     struct writeback_control *wbc)
+int netfs_writepages_group(struct address_space *mapping,
+			   struct writeback_control *wbc,
+			   struct netfs_group *group)
 {
 	struct netfs_inode *ictx = netfs_inode(mapping->host);
 	struct netfs_io_request *wreq = NULL;
@@ -618,12 +626,15 @@ int netfs_writepages(struct address_space *mapping,
 	if (!folio)
 		goto out;
 
-	wreq = netfs_create_write_req(mapping, NULL, folio_pos(folio), NETFS_WRITEBACK);
+	wreq = netfs_create_write_req(mapping, NULL, folio_pos(folio),
+				      NETFS_WRITEBACK);
 	if (IS_ERR(wreq)) {
 		error = PTR_ERR(wreq);
 		goto couldnt_start;
 	}
 
+	wreq->group = netfs_get_group(group);
+
 	trace_netfs_write(wreq, netfs_write_trace_writeback);
 	netfs_stat(&netfs_n_wh_writepages);
 
@@ -659,6 +670,21 @@ int netfs_writepages(struct address_space *mapping,
 	_leave(" = %d", error);
 	return error;
 }
+EXPORT_SYMBOL(netfs_writepages_group);
+
+/**
+ * netfs_writepages - Flush data from the pagecache for a file
+ * @mapping: The file to flush from
+ * @wbc: Details of what should be flushed
+ *
+ * Start asynchronous write back operations to flush dirty data in a file's
+ * pagecache back to the server and to the local cache.
+ */
+int netfs_writepages(struct address_space *mapping,
+		     struct writeback_control *wbc)
+{
+	return netfs_writepages_group(mapping, wbc, NULL);
+}
 EXPORT_SYMBOL(netfs_writepages);
 
 /*
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index a67297de8a20..69052ac47ab1 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -457,6 +457,9 @@ int netfs_read_folio(struct file *, struct folio *);
 int netfs_write_begin(struct netfs_inode *, struct file *,
 		      struct address_space *, loff_t pos, unsigned int len,
 		      struct folio **, void **fsdata);
+int netfs_writepages_group(struct address_space *mapping,
+			   struct writeback_control *wbc,
+			   struct netfs_group *group);
 int netfs_writepages(struct address_space *mapping,
 		     struct writeback_control *wbc);
 bool netfs_dirty_folio(struct address_space *mapping, struct folio *folio);
@@ -597,4 +600,60 @@ static inline void netfs_wait_for_outstanding_io(struct inode *inode)
 	wait_var_event(&ictx->io_count, atomic_read(&ictx->io_count) == 0);
 }
 
+/*
+ * Get a ref on a netfs group attached to a dirty page (e.g. a ceph snap).
+ */
+static inline struct netfs_group *netfs_get_group(struct netfs_group *netfs_group)
+{
+	if (netfs_group && netfs_group != NETFS_FOLIO_COPY_TO_CACHE)
+		refcount_inc(&netfs_group->ref);
+	return netfs_group;
+}
+
+/*
+ * Dispose of a netfs group attached to a dirty page (e.g. a ceph snap).
+ */
+static inline void netfs_put_group(struct netfs_group *netfs_group)
+{
+	if (netfs_group &&
+	    netfs_group != NETFS_FOLIO_COPY_TO_CACHE &&
+	    refcount_dec_and_test(&netfs_group->ref))
+		netfs_group->free(netfs_group);
+}
+
+/*
+ * Dispose of a netfs group attached to a dirty page (e.g. a ceph snap).
+ */
+static inline void netfs_put_group_many(struct netfs_group *netfs_group, int nr)
+{
+	if (netfs_group &&
+	    netfs_group != NETFS_FOLIO_COPY_TO_CACHE &&
+	    refcount_sub_and_test(nr, &netfs_group->ref))
+		netfs_group->free(netfs_group);
+}
+
+/*
+ * Set the group pointer directly on a folio.
+ */
+static inline void __netfs_set_group(struct folio *folio, struct netfs_group *netfs_group)
+{
+	if (netfs_group)
+		folio_attach_private(folio, netfs_get_group(netfs_group));
+}
+
+/*
+ * Set the group pointer on a folio or the folio info record.
+ */
+static inline void netfs_set_group(struct folio *folio, struct netfs_group *netfs_group)
+{
+	void *priv = folio_get_private(folio);
+
+	if (unlikely(priv != netfs_group)) {
+		if (netfs_group && (!priv || priv == NETFS_FOLIO_COPY_TO_CACHE))
+			folio_attach_private(folio, netfs_get_group(netfs_group));
+		else if (!netfs_group && priv == NETFS_FOLIO_COPY_TO_CACHE)
+			folio_detach_private(folio);
+	}
+}
+
 #endif /* _LINUX_NETFS_H */


