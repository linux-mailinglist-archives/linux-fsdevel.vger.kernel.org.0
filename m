Return-Path: <linux-fsdevel+bounces-53551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E072CAF0047
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 18:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED294851FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 16:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4132857CB;
	Tue,  1 Jul 2025 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AOFaWqaW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C7B2853EE
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751388003; cv=none; b=SvVw5qm+EC5d17MZYlnESAXq10MpF5gVdpX1KVzG/YpDWn0WAsIjCFE2XL3Sa7uBUCLgnkiYpj8EZk7YYrImoWbQL8A+737Grs1+DLlW7QT9r8cSgQjeKS8uMn+BJFrrtZeD8esqLFTM8Wpa4HwdAHeAF7WVs7PuYJLJiDJIftY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751388003; c=relaxed/simple;
	bh=swHnkcBpaaEigXYIHbwFaH86jUtHP6geVAdFF+qqABg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6DiZHCrUy10+/KcB+n+cgLlSbRvs4xbm54Mi+lSNKIjtmyik+liEgx8pUyGtTZ+9XKyi0NVYSALCMscxYKBZ5u7GyNX3PyWbwkAQV9G6NMimYxCXcxBDPXD0sOPyIjPTyXF37wXRiggfFSC/fT+vk0pJiHC1aH9ntQu1PBFzxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AOFaWqaW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751388000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hOolOhWWj9ygD012ShcK55OTHYySedeCXeLEsArOQ/E=;
	b=AOFaWqaWD37FoCgZftTSv2cDvBBm76is91s4ohKlEBYNCThwBw0jK7KeXIi8oAojeUTXcy
	FkEvC+dntASfHlPfnEKUCNopCP4kvfA4fyndpHPsoJjUOFowWK6AtaSo5QwZqEAyUWfOmC
	1Ex03YYwb3TrlbK2DquUso5Uv3Xbggc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-r5K2d_LQM7ei4ZiAsfER-Q-1; Tue,
 01 Jul 2025 12:39:57 -0400
X-MC-Unique: r5K2d_LQM7ei4ZiAsfER-Q-1
X-Mimecast-MFC-AGG-ID: r5K2d_LQM7ei4ZiAsfER-Q_1751387995
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F39B11978F63;
	Tue,  1 Jul 2025 16:39:54 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.81])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 902751800288;
	Tue,  1 Jul 2025 16:39:51 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>
Subject: [PATCH 11/13] netfs: Merge i_size update functions
Date: Tue,  1 Jul 2025 17:38:46 +0100
Message-ID: <20250701163852.2171681-12-dhowells@redhat.com>
In-Reply-To: <20250701163852.2171681-1-dhowells@redhat.com>
References: <20250701163852.2171681-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Netfslib has two functions for updating the i_size after a write: one for
buffered writes into the pagecache and one for direct/unbuffered writes.
However, what needs to be done is much the same in both cases, so merge
them together.

This does raise one question, though: should updating the i_size after a
direct write do the same estimated update of i_blocks as is done for
buffered writes.

Also get rid of the cleanup function pointer from netfs_io_request as it's
only used for direct write to update i_size; instead do the i_size setting
directly from write collection.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_write.c | 36 +++++++++++++++++++++---------------
 fs/netfs/direct_write.c   | 19 -------------------
 fs/netfs/internal.h       |  6 ++++++
 fs/netfs/write_collect.c  |  6 ++++--
 include/linux/netfs.h     |  1 -
 5 files changed, 31 insertions(+), 37 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index b87ef3fe4ea4..f27ea5099a68 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -53,30 +53,38 @@ static struct folio *netfs_grab_folio_for_write(struct address_space *mapping,
  * data written into the pagecache until we can find out from the server what
  * the values actually are.
  */
-static void netfs_update_i_size(struct netfs_inode *ctx, struct inode *inode,
-				loff_t i_size, loff_t pos, size_t copied)
+void netfs_update_i_size(struct netfs_inode *ctx, struct inode *inode,
+			 loff_t pos, size_t copied)
 {
+	loff_t i_size, end = pos + copied;
 	blkcnt_t add;
 	size_t gap;
 
+	if (end <= i_size_read(inode))
+		return;
+
 	if (ctx->ops->update_i_size) {
-		ctx->ops->update_i_size(inode, pos);
+		ctx->ops->update_i_size(inode, end);
 		return;
 	}
 
 	spin_lock(&inode->i_lock);
-	i_size_write(inode, pos);
+
+	i_size = i_size_read(inode);
+	if (end > i_size) {
+		i_size_write(inode, end);
 #if IS_ENABLED(CONFIG_FSCACHE)
-	fscache_update_cookie(ctx->cache, NULL, &pos);
+		fscache_update_cookie(ctx->cache, NULL, &end);
 #endif
 
-	gap = SECTOR_SIZE - (i_size & (SECTOR_SIZE - 1));
-	if (copied > gap) {
-		add = DIV_ROUND_UP(copied - gap, SECTOR_SIZE);
+		gap = SECTOR_SIZE - (i_size & (SECTOR_SIZE - 1));
+		if (copied > gap) {
+			add = DIV_ROUND_UP(copied - gap, SECTOR_SIZE);
 
-		inode->i_blocks = min_t(blkcnt_t,
-					DIV_ROUND_UP(pos, SECTOR_SIZE),
-					inode->i_blocks + add);
+			inode->i_blocks = min_t(blkcnt_t,
+						DIV_ROUND_UP(end, SECTOR_SIZE),
+						inode->i_blocks + add);
+		}
 	}
 	spin_unlock(&inode->i_lock);
 }
@@ -113,7 +121,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 	struct folio *folio = NULL, *writethrough = NULL;
 	unsigned int bdp_flags = (iocb->ki_flags & IOCB_NOWAIT) ? BDP_ASYNC : 0;
 	ssize_t written = 0, ret, ret2;
-	loff_t i_size, pos = iocb->ki_pos;
+	loff_t pos = iocb->ki_pos;
 	size_t max_chunk = mapping_max_folio_size(mapping);
 	bool maybe_trouble = false;
 
@@ -346,10 +354,8 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		flush_dcache_folio(folio);
 
 		/* Update the inode size if we moved the EOF marker */
+		netfs_update_i_size(ctx, inode, pos, copied);
 		pos += copied;
-		i_size = i_size_read(inode);
-		if (pos > i_size)
-			netfs_update_i_size(ctx, inode, i_size, pos, copied);
 		written += copied;
 
 		if (likely(!wreq)) {
diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index 3efa5894b2c0..dcf2b096cc4e 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -9,24 +9,6 @@
 #include <linux/uio.h>
 #include "internal.h"
 
-static void netfs_cleanup_dio_write(struct netfs_io_request *wreq)
-{
-	struct inode *inode = wreq->inode;
-	unsigned long long end = wreq->start + wreq->transferred;
-
-	if (wreq->error || end <= i_size_read(inode))
-		return;
-
-	spin_lock(&inode->i_lock);
-	if (end > i_size_read(inode)) {
-		if (wreq->netfs_ops->update_i_size)
-			wreq->netfs_ops->update_i_size(inode, end);
-		else
-			i_size_write(inode, end);
-	}
-	spin_unlock(&inode->i_lock);
-}
-
 /*
  * Perform an unbuffered write where we may have to do an RMW operation on an
  * encrypted file.  This can also be used for direct I/O writes.
@@ -102,7 +84,6 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 	if (async)
 		wreq->iocb = iocb;
 	wreq->len = iov_iter_count(&wreq->buffer.iter);
-	wreq->cleanup = netfs_cleanup_dio_write;
 	ret = netfs_unbuffered_write(wreq, is_sync_kiocb(iocb), wreq->len);
 	if (ret < 0) {
 		_debug("begin = %zd", ret);
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index d6656d2b54ab..f9bb9464a147 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -27,6 +27,12 @@ void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error);
 int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 			     size_t offset, size_t len);
 
+/*
+ * buffered_write.c
+ */
+void netfs_update_i_size(struct netfs_inode *ctx, struct inode *inode,
+			 loff_t pos, size_t copied);
+
 /*
  * main.c
  */
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 2ac85a819b71..33a93258f36e 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -393,8 +393,10 @@ bool netfs_write_collection(struct netfs_io_request *wreq)
 		ictx->ops->invalidate_cache(wreq);
 	}
 
-	if (wreq->cleanup)
-		wreq->cleanup(wreq);
+	if ((wreq->origin == NETFS_UNBUFFERED_WRITE ||
+	     wreq->origin == NETFS_DIO_WRITE) &&
+	    !wreq->error)
+		netfs_update_i_size(ictx, &ictx->inode, wreq->start, wreq->transferred);
 
 	if (wreq->origin == NETFS_DIO_WRITE &&
 	    wreq->mapping->nrpages) {
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 065c17385e53..d8186b90fb38 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -279,7 +279,6 @@ struct netfs_io_request {
 #define NETFS_RREQ_USE_PGPRIV2		31	/* [DEPRECATED] Use PG_private_2 to mark
 						 * write to cache on read */
 	const struct netfs_request_ops *netfs_ops;
-	void (*cleanup)(struct netfs_io_request *req);
 };
 
 /*


