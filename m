Return-Path: <linux-fsdevel+bounces-15571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 495938905F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 17:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79BEDB253A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 16:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B68D13BC1D;
	Thu, 28 Mar 2024 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DLeU/tgw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781E4131BB2
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643897; cv=none; b=ocUEL2KKDZeWCLh63sLY66GRH4VSF5U/C0hPPcfRsrNBPQQR/z6phLhGE7glcAh1XScTCSnWC/xgzj2W3KMb1BN9grbP+yM1BjOoOkyohELyAfa8XTsHmPMhaSHul4brZGDnq4rtzr6lJ2Fh3/EQXczRyDk9xzn5cqHBr79w7sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643897; c=relaxed/simple;
	bh=nhc5rvuZJ1+r04+ZDNGXMdd1gVMPrAcfjn/g3l1m4dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYHAeaGA289bwT0IupphsV4wrrGSLHwptnuX1xnlAnnmEBhTWPrCavy7g///BI99dIEAE98JCLa91nxQEk9wceHtgCparvp93i/hthSIZ5La7pJ1xQrPVimWDu/SKczU4WncUTuUdkzZOwlBxX34oJBFFGLugS8N+b2Yij5aMG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DLeU/tgw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711643894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JI9PX3u9k9FTrB5i0WWXWgMwPBin4UAr3u+00DhFGiU=;
	b=DLeU/tgwfPPKZUeys0X99B2ZYf2VuESlAsdNjwocuOUJKsgDYYdmNTU2gFgNreorhdo/Bb
	0gu99DpyiZ5LPw32s7p739tB9YMi3Y4dSEgiDLIGOqh3ADM8toAEblOlCv5nNY9shHigvz
	UpwI0lSAtJNnUhw8+18Ga0idFocdMuM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-2sgLOBL1P_u0EwB7rUYwvg-1; Thu,
 28 Mar 2024 12:38:09 -0400
X-MC-Unique: 2sgLOBL1P_u0EwB7rUYwvg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F7C2383CD7C;
	Thu, 28 Mar 2024 16:38:08 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1B5A11C060D0;
	Thu, 28 Mar 2024 16:38:05 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Steve French <smfrench@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
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
Subject: [PATCH 18/26] netfs: Add some write-side stats and clean up some stat names
Date: Thu, 28 Mar 2024 16:34:10 +0000
Message-ID: <20240328163424.2781320-19-dhowells@redhat.com>
In-Reply-To: <20240328163424.2781320-1-dhowells@redhat.com>
References: <20240328163424.2781320-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Add some write-side stats to count buffered writes, buffered writethrough,
and writepages calls.

Whilst we're at it, clean up the naming on some of the existing stats
counters and organise the output into two sets.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_read.c  |  2 +-
 fs/netfs/buffered_write.c |  3 +++
 fs/netfs/direct_write.c   |  2 +-
 fs/netfs/internal.h       |  7 +++++--
 fs/netfs/stats.c          | 17 ++++++++++++-----
 5 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 47603f08680e..a6bb03bea920 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -282,7 +282,7 @@ int netfs_read_folio(struct file *file, struct folio *folio)
 	if (ret == -ENOMEM || ret == -EINTR || ret == -ERESTARTSYS)
 		goto discard;
 
-	netfs_stat(&netfs_n_rh_readpage);
+	netfs_stat(&netfs_n_rh_read_folio);
 	trace_netfs_read(rreq, rreq->start, rreq->len, netfs_read_trace_readpage);
 
 	/* Set up the output buffer */
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index db4ad158948b..244d67a43972 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -215,6 +215,9 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		if (!is_sync_kiocb(iocb))
 			wreq->iocb = iocb;
 		wreq->cleanup = netfs_cleanup_buffered_write;
+		netfs_stat(&netfs_n_wh_writethrough);
+	} else {
+		netfs_stat(&netfs_n_wh_buffered_write);
 	}
 
 	do {
diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index bee047e20f5d..37c91188107b 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -143,7 +143,7 @@ ssize_t netfs_unbuffered_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		return 0;
 
 	trace_netfs_write_iter(iocb, from);
-	netfs_stat(&netfs_n_rh_dio_write);
+	netfs_stat(&netfs_n_wh_dio_write);
 
 	ret = netfs_start_io_direct(inode);
 	if (ret < 0)
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index c67da478cd2b..58289cc65e25 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -106,9 +106,8 @@ int netfs_end_writethrough(struct netfs_io_request *wreq, struct kiocb *iocb);
  */
 #ifdef CONFIG_NETFS_STATS
 extern atomic_t netfs_n_rh_dio_read;
-extern atomic_t netfs_n_rh_dio_write;
 extern atomic_t netfs_n_rh_readahead;
-extern atomic_t netfs_n_rh_readpage;
+extern atomic_t netfs_n_rh_read_folio;
 extern atomic_t netfs_n_rh_rreq;
 extern atomic_t netfs_n_rh_sreq;
 extern atomic_t netfs_n_rh_download;
@@ -125,6 +124,10 @@ extern atomic_t netfs_n_rh_write_begin;
 extern atomic_t netfs_n_rh_write_done;
 extern atomic_t netfs_n_rh_write_failed;
 extern atomic_t netfs_n_rh_write_zskip;
+extern atomic_t netfs_n_wh_buffered_write;
+extern atomic_t netfs_n_wh_writethrough;
+extern atomic_t netfs_n_wh_dio_write;
+extern atomic_t netfs_n_wh_writepages;
 extern atomic_t netfs_n_wh_wstream_conflict;
 extern atomic_t netfs_n_wh_upload;
 extern atomic_t netfs_n_wh_upload_done;
diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
index deeba9f9dcf5..0892768eea32 100644
--- a/fs/netfs/stats.c
+++ b/fs/netfs/stats.c
@@ -10,9 +10,8 @@
 #include "internal.h"
 
 atomic_t netfs_n_rh_dio_read;
-atomic_t netfs_n_rh_dio_write;
 atomic_t netfs_n_rh_readahead;
-atomic_t netfs_n_rh_readpage;
+atomic_t netfs_n_rh_read_folio;
 atomic_t netfs_n_rh_rreq;
 atomic_t netfs_n_rh_sreq;
 atomic_t netfs_n_rh_download;
@@ -29,6 +28,10 @@ atomic_t netfs_n_rh_write_begin;
 atomic_t netfs_n_rh_write_done;
 atomic_t netfs_n_rh_write_failed;
 atomic_t netfs_n_rh_write_zskip;
+atomic_t netfs_n_wh_buffered_write;
+atomic_t netfs_n_wh_writethrough;
+atomic_t netfs_n_wh_dio_write;
+atomic_t netfs_n_wh_writepages;
 atomic_t netfs_n_wh_wstream_conflict;
 atomic_t netfs_n_wh_upload;
 atomic_t netfs_n_wh_upload_done;
@@ -39,13 +42,17 @@ atomic_t netfs_n_wh_write_failed;
 
 int netfs_stats_show(struct seq_file *m, void *v)
 {
-	seq_printf(m, "Netfs  : DR=%u DW=%u RA=%u RP=%u WB=%u WBZ=%u\n",
+	seq_printf(m, "Netfs  : DR=%u RA=%u RF=%u WB=%u WBZ=%u\n",
 		   atomic_read(&netfs_n_rh_dio_read),
-		   atomic_read(&netfs_n_rh_dio_write),
 		   atomic_read(&netfs_n_rh_readahead),
-		   atomic_read(&netfs_n_rh_readpage),
+		   atomic_read(&netfs_n_rh_read_folio),
 		   atomic_read(&netfs_n_rh_write_begin),
 		   atomic_read(&netfs_n_rh_write_zskip));
+	seq_printf(m, "Netfs  : BW=%u WT=%u DW=%u WP=%u\n",
+		   atomic_read(&netfs_n_wh_buffered_write),
+		   atomic_read(&netfs_n_wh_writethrough),
+		   atomic_read(&netfs_n_wh_dio_write),
+		   atomic_read(&netfs_n_wh_writepages));
 	seq_printf(m, "Netfs  : ZR=%u sh=%u sk=%u\n",
 		   atomic_read(&netfs_n_rh_zero),
 		   atomic_read(&netfs_n_rh_short_read),


