Return-Path: <linux-fsdevel+bounces-25978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E00CC9523EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 22:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0691F21E31
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 20:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9F91DE872;
	Wed, 14 Aug 2024 20:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4TL475X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31AC1DE842
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 20:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723668074; cv=none; b=W9xOF43Crk65vo2PYCsWZeOsrl2xjGgKiaGmUye4VZVG1hgMMM7lXxJoh4xLagT4q6k9koKHiYVxo9BLo8wLEhG/GX5SAplk518U8zqChiX26J90tBSDCSwRQUFjbuhxnnVUlRYFUwlyhQ8cGZulGlD7mXjyUCYIHzxglgsCDSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723668074; c=relaxed/simple;
	bh=rA7Q3ScE2LCp3jy3wxNYV6fI8svKOnzxOnvE2IAegRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mOBrXK6dY59iOl3+GUtirZZOQ8yqWnJOuIhfrQ4ZuYNKRrtzfFGLpNkSFJtn6EFipWticPhV8bZhEkLNPi29wRjHzbAB+28dqSm7XCa8CZp6/QPgCfdt6GL2x6U7rzp0vgz+vy2tHVdIegIU61gVrCabB/ItGDAdGm6TEPcZtUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T4TL475X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723668072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/5GudhtF+T887yYtTq2ccnSMC605t1SyQsaR8Y8Wa80=;
	b=T4TL475XtmDQ8nCChyWD9r7QzgFZv+exAVPGMh2cbvCjIsiuTKNoXtwW82fODz/AokGO5I
	dDODEXC44oiHC2GUlwKvbal4/Iu+YoZF8/cu2u89TrfML/fCrcdIikAm0lueWf73KZzuFp
	Z+e8SpCKAd7R2uaWjqm3fcBlmRv0OxQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-cuSPPapgNmmADvVkpaXVwA-1; Wed,
 14 Aug 2024 16:41:05 -0400
X-MC-Unique: cuSPPapgNmmADvVkpaXVwA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 837281954B0E;
	Wed, 14 Aug 2024 20:41:02 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E3421300019A;
	Wed, 14 Aug 2024 20:40:56 +0000 (UTC)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/25] netfs: Provide an iterator-reset function
Date: Wed, 14 Aug 2024 21:38:36 +0100
Message-ID: <20240814203850.2240469-17-dhowells@redhat.com>
In-Reply-To: <20240814203850.2240469-1-dhowells@redhat.com>
References: <20240814203850.2240469-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Provide a function to reset the iterator on a subrequest.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/internal.h      |  4 +---
 fs/netfs/misc.c          | 18 ++++++++++++++++++
 fs/netfs/write_collect.c |  3 +--
 fs/netfs/write_issue.c   |  6 +++---
 4 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index e1149e05a5c8..21a3c7d13585 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -69,6 +69,7 @@ int netfs_buffer_append_folio(struct netfs_io_request *rreq, struct folio *folio
 			      bool needs_put);
 struct folio_queue *netfs_delete_buffer_head(struct netfs_io_request *wreq);
 void netfs_clear_buffer(struct netfs_io_request *rreq);
+void netfs_reset_iter(struct netfs_io_subrequest *subreq);
 
 /*
  * objects.c
@@ -161,9 +162,6 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 void netfs_reissue_write(struct netfs_io_stream *stream,
 			 struct netfs_io_subrequest *subreq,
 			 struct iov_iter *source);
-int netfs_advance_write(struct netfs_io_request *wreq,
-			struct netfs_io_stream *stream,
-			loff_t start, size_t len, bool to_eof);
 struct netfs_io_request *netfs_begin_writethrough(struct kiocb *iocb, size_t len);
 int netfs_advance_writethrough(struct netfs_io_request *wreq, struct writeback_control *wbc,
 			       struct folio *folio, size_t copied, bool to_page_end,
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index e642e5cacb8d..08987765306f 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -84,6 +84,24 @@ void netfs_clear_buffer(struct netfs_io_request *rreq)
 	}
 }
 
+/*
+ * Reset the subrequest iterator to refer just to the region remaining to be
+ * read.  The iterator may or may not have been advanced by socket ops or
+ * extraction ops to an extent that may or may not match the amount actually
+ * read.
+ */
+void netfs_reset_iter(struct netfs_io_subrequest *subreq)
+{
+	struct iov_iter *io_iter = &subreq->io_iter;
+	size_t remain = subreq->len - subreq->transferred;
+
+	if (io_iter->count > remain)
+		iov_iter_advance(io_iter, io_iter->count - remain);
+	else if (io_iter->count < remain)
+		iov_iter_revert(io_iter, remain - io_iter->count);
+	iov_iter_truncate(&subreq->io_iter, remain);
+}
+
 /**
  * netfs_dirty_folio - Mark folio dirty and pin a cache object for writeback
  * @mapping: The mapping the folio belongs to.
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 1521a23077c3..801a130a0ce1 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -219,9 +219,8 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 		/* Determine the set of buffers we're going to use.  Each
 		 * subreq gets a subset of a single overall contiguous buffer.
 		 */
+		netfs_reset_iter(from);
 		source = from->io_iter;
-		iov_iter_revert(&source, subreq->len - source.count);
-		iov_iter_advance(&source, from->transferred);
 		source.count = len;
 
 		/* Work through the sublist. */
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index a75b62b202c5..9ead075962f0 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -261,9 +261,9 @@ static void netfs_issue_write(struct netfs_io_request *wreq,
  * we can avoid overrunning the credits obtained (cifs) and try to parallelise
  * content-crypto preparation with network writes.
  */
-int netfs_advance_write(struct netfs_io_request *wreq,
-			struct netfs_io_stream *stream,
-			loff_t start, size_t len, bool to_eof)
+static int netfs_advance_write(struct netfs_io_request *wreq,
+			       struct netfs_io_stream *stream,
+			       loff_t start, size_t len, bool to_eof)
 {
 	struct netfs_io_subrequest *subreq = stream->construct;
 	size_t part;


