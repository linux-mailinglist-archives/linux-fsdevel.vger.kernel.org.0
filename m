Return-Path: <linux-fsdevel+bounces-26414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C30959124
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 01:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A671C225F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 23:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69E51C9EC5;
	Tue, 20 Aug 2024 23:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXa3BFU2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9868A1C8FDD
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 23:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724196105; cv=none; b=Wu+lhOFexjB4HRQg7qWyJ683cSy1J2Nci1La5cODoid1KIT+cU5jGZY+h6MQJ2moH8ipzDpc0yRltpwr+gLf+vAvfIt3FRx4AgBNpS4xNa/aCAKcJjbH0cu8ywJhKRJ8z9Twzt03uYmpsf8FhsMTxFcajiICA4nfPNU84ipylBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724196105; c=relaxed/simple;
	bh=tpadh5ijkCCOsa7M3OJjST6sL5scalK1OFyRewofsGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIe6NgEzouv+hPMPz9KIGmEPFfCH31mw68ANEmISPOkZCRDDClPxJZleUEnV0a5dLOjjdlZo0MoilqE0K1gL7QD8ZcF0nP4K/mLc9SofJnhk5FbKqmnHlwL/+5ispsBgVVcDY3qi4v0WSxPIySWzjrhFQ3gHLEBurxmqPNPMx0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LXa3BFU2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724196102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pcRiiH/lYTDVoni9WSyylXIzj+0iyqYBGBDYoCG5zI=;
	b=LXa3BFU2t9Z4ZRDbgBCo6H0N1BGfDPLVvW2on3nNTfYF0OTulVMHWsX+Vm3yTTHi9KzUhQ
	Z5p7eDVCRpUvLhjxbVZBqnybNkDzt9V0L5kVMuy8AEslb+FycTfC90LVg8/zbS8Q/ZEusD
	xeS9UTsrn8jX9OrhBEn2BCnRLw4iXP8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-JolRJguvP_SguD5LijFaFg-1; Tue,
 20 Aug 2024 19:21:39 -0400
X-MC-Unique: JolRJguvP_SguD5LijFaFg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA9DE19560AD;
	Tue, 20 Aug 2024 23:21:36 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A9E6F1955F54;
	Tue, 20 Aug 2024 23:21:32 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Marc Dionne <marc.dionne@auristor.com>
Subject: [PATCH 4/4] netfs: Fix trimming of streaming-write folios in netfs_inval_folio()
Date: Wed, 21 Aug 2024 00:20:58 +0100
Message-ID: <20240820232105.3792638-5-dhowells@redhat.com>
In-Reply-To: <20240820232105.3792638-1-dhowells@redhat.com>
References: <20240820232105.3792638-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

When netfslib writes to a folio that it doesn't have data for, but that
data exists on the server, it will make a 'streaming write' whereby it
stores data in a folio that is marked dirty, but not uptodate.  When it
does this, it attaches a record to folio->private to track the dirty
region.

When truncate() or fallocate() wants to invalidate part of such a folio, it
will call into ->invalidate_folio(), specifying the part of the folio that
is to be invalidated.  netfs_invalidate_folio(), on behalf of the
filesystem, must then determine how to trim the streaming write record.  In
a couple of cases, however, it does this incorrectly (the reduce-length and
move-start cases are switched over and don't, in any case, calculate the
value correctly).

Fix this by making the logic tree more obvious and fixing the cases.

Fixes: 9ebff83e6481 ("netfs: Prep to use folio->private for write grouping and streaming write")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox (Oracle) <willy@infradead.org>
cc: Pankaj Raghav <p.raghav@samsung.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/misc.c | 50 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 69324761fcf7..c1f321cf5999 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -97,10 +97,20 @@ EXPORT_SYMBOL(netfs_clear_inode_writeback);
 void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 {
 	struct netfs_folio *finfo;
+	struct netfs_inode *ctx = netfs_inode(folio_inode(folio));
 	size_t flen = folio_size(folio);
 
 	_enter("{%lx},%zx,%zx", folio->index, offset, length);
 
+	if (offset == 0 && length == flen) {
+		unsigned long long i_size = i_size_read(&ctx->inode);
+		unsigned long long fpos = folio_pos(folio), end;
+
+		end = umin(fpos + flen, i_size);
+		if (fpos < i_size && end > ctx->zero_point)
+			ctx->zero_point = end;
+	}
+
 	folio_wait_private_2(folio); /* [DEPRECATED] */
 
 	if (!folio_test_private(folio))
@@ -115,18 +125,34 @@ void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 		/* We have a partially uptodate page from a streaming write. */
 		unsigned int fstart = finfo->dirty_offset;
 		unsigned int fend = fstart + finfo->dirty_len;
-		unsigned int end = offset + length;
+		unsigned int iend = offset + length;
 
 		if (offset >= fend)
 			return;
-		if (end <= fstart)
+		if (iend <= fstart)
+			return;
+
+		/* The invalidation region overlaps the data.  If the region
+		 * covers the start of the data, we either move along the start
+		 * or just erase the data entirely.
+		 */
+		if (offset <= fstart) {
+			if (iend >= fend)
+				goto erase_completely;
+			/* Move the start of the data. */
+			finfo->dirty_len = fend - iend;
+			finfo->dirty_offset = offset;
+			return;
+		}
+
+		/* Reduce the length of the data if the invalidation region
+		 * covers the tail part.
+		 */
+		if (iend >= fend) {
+			finfo->dirty_len = offset - fstart;
 			return;
-		if (offset <= fstart && end >= fend)
-			goto erase_completely;
-		if (offset <= fstart && end > fstart)
-			goto reduce_len;
-		if (offset > fstart && end >= fend)
-			goto move_start;
+		}
+
 		/* A partial write was split.  The caller has already zeroed
 		 * it, so just absorb the hole.
 		 */
@@ -139,12 +165,6 @@ void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 	folio_clear_uptodate(folio);
 	kfree(finfo);
 	return;
-reduce_len:
-	finfo->dirty_len = offset + length - finfo->dirty_offset;
-	return;
-move_start:
-	finfo->dirty_len -= offset - finfo->dirty_offset;
-	finfo->dirty_offset = offset;
 }
 EXPORT_SYMBOL(netfs_invalidate_folio);
 
@@ -164,7 +184,7 @@ bool netfs_release_folio(struct folio *folio, gfp_t gfp)
 	if (folio_test_dirty(folio))
 		return false;
 
-	end = folio_pos(folio) + folio_size(folio);
+	end = umin(folio_pos(folio) + folio_size(folio), i_size_read(&ctx->inode));
 	if (end > ctx->zero_point)
 		ctx->zero_point = end;
 


