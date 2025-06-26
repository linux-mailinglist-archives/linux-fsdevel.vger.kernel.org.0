Return-Path: <linux-fsdevel+bounces-53084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F635AE9DBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 14:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03721C4016F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 12:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A322E11CD;
	Thu, 26 Jun 2025 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b1+K1Jd3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33623201017
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 12:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750941888; cv=none; b=f+TmGmeh6Uct9ns7y5hyA1jQ7/tNxelU/BT/G5gyYEhsUlcrccPZPmOuDe+xsmJfgUDwB/d29xg9fFF3e6snBm2ai+PS1HwJm2kR7s2S/pz6ZiOsVpETSBB8xO18DsRkpdmq7FfBw3loJ8DLuekmMLN7pJkU2p1F68Fyji0bL7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750941888; c=relaxed/simple;
	bh=c4XYvSotZZ1FzLtX0U0KD0tABl7m2IlcHYxYvccy0Ww=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Content-Type:
	 Date:Message-ID; b=KX+nMZcsyEjtvZroa6KobGZsKXXjDTKdyC6PDFYISb78jBxu42Ne8SCALDaErBQ0mod3jtDkhQdp+rWdCIEZIKW09ebK/jSv0LBybBanpfWDPMHhd7V2Q6RBNbjvBvgi+1m4DMBjlRcF3g4t6tOeWfjTbt1flm5ITEgfZrqJ6dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b1+K1Jd3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750941885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Am4Qfwr6+rKCR3jYF9USP6nGypEhphTHlkFTYuyX0uw=;
	b=b1+K1Jd3NdrO5+oNPMB0HawTTkuvCQDkf6jY0bqadzpobsJ+WLJR3V+u02oHdAg6rSwrds
	NnUEa3ssgZLjzu3+3V4UKaXk9W7azL1djD+49kiTO26fiAcWguOGxmGLF8IScgWi0e5a8N
	CVHVMk6MZfg6/I7vE8V1x28Yz+Z2e0s=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-vGo7d88LMeSsDJf-JncBxA-1; Thu,
 26 Jun 2025 08:44:42 -0400
X-MC-Unique: vGo7d88LMeSsDJf-JncBxA-1
X-Mimecast-MFC-AGG-ID: vGo7d88LMeSsDJf-JncBxA_1750941880
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 767BD1956086;
	Thu, 26 Jun 2025 12:44:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 526C419560AF;
	Thu, 26 Jun 2025 12:44:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1576470.1750941177@warthog.procyon.org.uk>
References: <1576470.1750941177@warthog.procyon.org.uk>
Cc: dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
    Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>,
    linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Merge i_size update functions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1587238.1750941876.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Jun 2025 13:44:36 +0100
Message-ID: <1587239.1750941876@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Here's a follow up patch to the previous one, though this would be for nex=
t -
and assuming it's okay to do the i_blocks update in the DIO case which it
currently lacks.

David
---
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
 fs/netfs/buffered_write.c |   36 +++++++++++++++++++++---------------
 fs/netfs/direct_write.c   |   19 -------------------
 fs/netfs/internal.h       |    6 ++++++
 fs/netfs/write_collect.c  |    6 ++++--
 include/linux/netfs.h     |    1 -
 5 files changed, 31 insertions(+), 37 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index b87ef3fe4ea4..f27ea5099a68 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -53,30 +53,38 @@ static struct folio *netfs_grab_folio_for_write(struct=
 address_space *mapping,
  * data written into the pagecache until we can find out from the server =
what
  * the values actually are.
  */
-static void netfs_update_i_size(struct netfs_inode *ctx, struct inode *in=
ode,
-				loff_t i_size, loff_t pos, size_t copied)
+void netfs_update_i_size(struct netfs_inode *ctx, struct inode *inode,
+			 loff_t pos, size_t copied)
 {
+	loff_t i_size, end =3D pos + copied;
 	blkcnt_t add;
 	size_t gap;
 =

+	if (end <=3D i_size_read(inode))
+		return;
+
 	if (ctx->ops->update_i_size) {
-		ctx->ops->update_i_size(inode, pos);
+		ctx->ops->update_i_size(inode, end);
 		return;
 	}
 =

 	spin_lock(&inode->i_lock);
-	i_size_write(inode, pos);
+
+	i_size =3D i_size_read(inode);
+	if (end > i_size) {
+		i_size_write(inode, end);
 #if IS_ENABLED(CONFIG_FSCACHE)
-	fscache_update_cookie(ctx->cache, NULL, &pos);
+		fscache_update_cookie(ctx->cache, NULL, &end);
 #endif
 =

-	gap =3D SECTOR_SIZE - (i_size & (SECTOR_SIZE - 1));
-	if (copied > gap) {
-		add =3D DIV_ROUND_UP(copied - gap, SECTOR_SIZE);
+		gap =3D SECTOR_SIZE - (i_size & (SECTOR_SIZE - 1));
+		if (copied > gap) {
+			add =3D DIV_ROUND_UP(copied - gap, SECTOR_SIZE);
 =

-		inode->i_blocks =3D min_t(blkcnt_t,
-					DIV_ROUND_UP(pos, SECTOR_SIZE),
-					inode->i_blocks + add);
+			inode->i_blocks =3D min_t(blkcnt_t,
+						DIV_ROUND_UP(end, SECTOR_SIZE),
+						inode->i_blocks + add);
+		}
 	}
 	spin_unlock(&inode->i_lock);
 }
@@ -113,7 +121,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct=
 iov_iter *iter,
 	struct folio *folio =3D NULL, *writethrough =3D NULL;
 	unsigned int bdp_flags =3D (iocb->ki_flags & IOCB_NOWAIT) ? BDP_ASYNC : =
0;
 	ssize_t written =3D 0, ret, ret2;
-	loff_t i_size, pos =3D iocb->ki_pos;
+	loff_t pos =3D iocb->ki_pos;
 	size_t max_chunk =3D mapping_max_folio_size(mapping);
 	bool maybe_trouble =3D false;
 =

@@ -346,10 +354,8 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struc=
t iov_iter *iter,
 		flush_dcache_folio(folio);
 =

 		/* Update the inode size if we moved the EOF marker */
+		netfs_update_i_size(ctx, inode, pos, copied);
 		pos +=3D copied;
-		i_size =3D i_size_read(inode);
-		if (pos > i_size)
-			netfs_update_i_size(ctx, inode, i_size, pos, copied);
 		written +=3D copied;
 =

 		if (likely(!wreq)) {
diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index 9df297a555f1..a16660ab7f83 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -9,24 +9,6 @@
 #include <linux/uio.h>
 #include "internal.h"
 =

-static void netfs_cleanup_dio_write(struct netfs_io_request *wreq)
-{
-	struct inode *inode =3D wreq->inode;
-	unsigned long long end =3D wreq->start + wreq->transferred;
-
-	if (wreq->error || end <=3D i_size_read(inode))
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
  * Perform an unbuffered write where we may have to do an RMW operation o=
n an
  * encrypted file.  This can also be used for direct I/O writes.
@@ -102,7 +84,6 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb=
 *iocb, struct iov_iter *
 	if (async)
 		wreq->iocb =3D iocb;
 	wreq->len =3D iov_iter_count(&wreq->buffer.iter);
-	wreq->cleanup =3D netfs_cleanup_dio_write;
 	ret =3D netfs_unbuffered_write(wreq, is_sync_kiocb(iocb), wreq->len);
 	if (ret < 0) {
 		_debug("begin =3D %zd", ret);
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index e13ed767aec0..d4f16fefd965 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -27,6 +27,12 @@ void netfs_cache_read_terminated(void *priv, ssize_t tr=
ansferred_or_error);
 int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 			     size_t offset, size_t len);
 =

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
index dedfdf80eccc..0f3a36852a4d 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -393,8 +393,10 @@ bool netfs_write_collection(struct netfs_io_request *=
wreq)
 		ictx->ops->invalidate_cache(wreq);
 	}
 =

-	if (wreq->cleanup)
-		wreq->cleanup(wreq);
+	if ((wreq->origin =3D=3D NETFS_UNBUFFERED_WRITE ||
+	     wreq->origin =3D=3D NETFS_DIO_WRITE) &&
+	    !wreq->error)
+		netfs_update_i_size(ictx, &ictx->inode, wreq->start, wreq->transferred)=
;
 =

 	if (wreq->origin =3D=3D NETFS_DIO_WRITE &&
 	    wreq->mapping->nrpages) {
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 8b5bf6e393f6..f43f075852c0 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -279,7 +279,6 @@ struct netfs_io_request {
 #define NETFS_RREQ_USE_PGPRIV2		31	/* [DEPRECATED] Use PG_private_2 to ma=
rk
 						 * write to cache on read */
 	const struct netfs_request_ops *netfs_ops;
-	void (*cleanup)(struct netfs_io_request *req);
 };
 =

 /*


