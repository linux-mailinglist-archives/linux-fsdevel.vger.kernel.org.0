Return-Path: <linux-fsdevel+bounces-32950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF509B101F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 22:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03C18B216C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 20:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D155121766B;
	Fri, 25 Oct 2024 20:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NhBQQ+kq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D716D21766A
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729888853; cv=none; b=ToKcuFyOwTox+U/ID3B+RJOieEmfRejhjmZ2vCRTI2lapR8hu0an9Ty9s4i+Cevfv/0m8orsjVdP5ve+4QEy27i2G7DVREmmNf66jYuYQPXEbVbdmQk5/QUalDca+UlOYmN4AT+onzK5kvV5aFBd5E98yz5ea/3iWB9OOaZtvGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729888853; c=relaxed/simple;
	bh=2vC/IfGilItl9YoYzSLfac5oxJJtNnQtCMzGrNI6xUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BT15YiUGiGQ4At6IQdSt5fkOgLVGyWcBfr94tkyvmCCoG7b7gelgM4k/83CZwSbt2AdOyGUQ3fHZJrB1SKiEPJFSKNScKutlj4qbCze8IcAqyj1u2tX64eWT3+s3NtETyZkuHfskPNSRP3VdPoPztSQK5cGojLmgUZ1jx4Q43GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NhBQQ+kq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729888850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2WJ3IwRH8RLBNIi0Kxo/o1E5+hUSf0Z9V2WPyhSRrlg=;
	b=NhBQQ+kq1R6Wdh9UL2DvjIa4pCv7f/pKHh2EHZXvYqhtCYKsbdlsdiLALwP/I/AQylbjXe
	a8WJhqAIIzuc5QFJ0XQ5kbgD1S34M+8lCRLg6er7jbaSCXkgp/VgOzgjiVN6feZbggoI0j
	+2Bwh/HDGZrNiD6uihxw/tq+aFGmErg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-YQ6BU2XqOJqtAGJuR0Eauw-1; Fri,
 25 Oct 2024 16:40:46 -0400
X-MC-Unique: YQ6BU2XqOJqtAGJuR0Eauw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E085D19560BF;
	Fri, 25 Oct 2024 20:40:42 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 278B21956088;
	Fri, 25 Oct 2024 20:40:36 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 03/31] netfs: Remove unnecessary references to pages
Date: Fri, 25 Oct 2024 21:39:30 +0100
Message-ID: <20241025204008.4076565-4-dhowells@redhat.com>
In-Reply-To: <20241025204008.4076565-1-dhowells@redhat.com>
References: <20241025204008.4076565-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

These places should all use folios instead of pages.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Link: https://lore.kernel.org/r/20241005182307.3190401-4-willy@infradead.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/netfs/buffered_read.c  |  8 ++++----
 fs/netfs/buffered_write.c | 14 +++++++-------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index af46a598f4d7..7ac34550c403 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -627,7 +627,7 @@ static bool netfs_skip_folio_read(struct folio *folio, loff_t pos, size_t len,
 	if (unlikely(always_fill)) {
 		if (pos - offset + len <= i_size)
 			return false; /* Page entirely before EOF */
-		zero_user_segment(&folio->page, 0, plen);
+		folio_zero_segment(folio, 0, plen);
 		folio_mark_uptodate(folio);
 		return true;
 	}
@@ -646,7 +646,7 @@ static bool netfs_skip_folio_read(struct folio *folio, loff_t pos, size_t len,
 
 	return false;
 zero_out:
-	zero_user_segments(&folio->page, 0, offset, offset + len, plen);
+	folio_zero_segments(folio, 0, offset, offset + len, plen);
 	return true;
 }
 
@@ -713,7 +713,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	if (folio_test_uptodate(folio))
 		goto have_folio;
 
-	/* If the page is beyond the EOF, we want to clear it - unless it's
+	/* If the folio is beyond the EOF, we want to clear it - unless it's
 	 * within the cache granule containing the EOF, in which case we need
 	 * to preload the granule.
 	 */
@@ -773,7 +773,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 EXPORT_SYMBOL(netfs_write_begin);
 
 /*
- * Preload the data into a page we're proposing to write into.
+ * Preload the data into a folio we're proposing to write into.
  */
 int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 			     size_t offset, size_t len)
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index ff2814da88b1..b4826360a411 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -83,13 +83,13 @@ static void netfs_update_i_size(struct netfs_inode *ctx, struct inode *inode,
  * netfs_perform_write - Copy data into the pagecache.
  * @iocb: The operation parameters
  * @iter: The source buffer
- * @netfs_group: Grouping for dirty pages (eg. ceph snaps).
+ * @netfs_group: Grouping for dirty folios (eg. ceph snaps).
  *
- * Copy data into pagecache pages attached to the inode specified by @iocb.
+ * Copy data into pagecache folios attached to the inode specified by @iocb.
  * The caller must hold appropriate inode locks.
  *
- * Dirty pages are tagged with a netfs_folio struct if they're not up to date
- * to indicate the range modified.  Dirty pages may also be tagged with a
+ * Dirty folios are tagged with a netfs_folio struct if they're not up to date
+ * to indicate the range modified.  Dirty folios may also be tagged with a
  * netfs-specific grouping such that data from an old group gets flushed before
  * a new one is started.
  */
@@ -223,11 +223,11 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		 * we try to read it.
 		 */
 		if (fpos >= ctx->zero_point) {
-			zero_user_segment(&folio->page, 0, offset);
+			folio_zero_segment(folio, 0, offset);
 			copied = copy_folio_from_iter_atomic(folio, offset, part, iter);
 			if (unlikely(copied == 0))
 				goto copy_failed;
-			zero_user_segment(&folio->page, offset + copied, flen);
+			folio_zero_segment(folio, offset + copied, flen);
 			__netfs_set_group(folio, netfs_group);
 			folio_mark_uptodate(folio);
 			trace_netfs_folio(folio, netfs_modify_and_clear);
@@ -407,7 +407,7 @@ EXPORT_SYMBOL(netfs_perform_write);
  * netfs_buffered_write_iter_locked - write data to a file
  * @iocb:	IO state structure (file, offset, etc.)
  * @from:	iov_iter with data to write
- * @netfs_group: Grouping for dirty pages (eg. ceph snaps).
+ * @netfs_group: Grouping for dirty folios (eg. ceph snaps).
  *
  * This function does all the work needed for actually writing data to a
  * file. It does all basic checks, removes SUID from the file, updates


