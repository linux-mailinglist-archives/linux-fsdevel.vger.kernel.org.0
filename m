Return-Path: <linux-fsdevel+bounces-7599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FBD8284CA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 12:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A10DB23A19
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 11:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC4D38DDB;
	Tue,  9 Jan 2024 11:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DwDpan72"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F38381B3
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jan 2024 11:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704799252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WPQwieeKN1qerHU6y651BO8nE/WRIhipjKm0fUBOfew=;
	b=DwDpan72kyTzqvXC/JDSq8VUgrFtBiZn9kfZLgESw9JNDrs4KISDVAUWyjOcHy5SlaPQsp
	etvybJ09XGASkHntOu1FADvlRI5Bptncj9DZIv3UnmQxtgdpUu4b86BFuU8MpzBVsctr+e
	jc2OEIf/aCiD19UxlGRwXirl64LC9NY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-E31DJX2lMH602RvDfJCjMg-1; Tue, 09 Jan 2024 06:20:46 -0500
X-MC-Unique: E31DJX2lMH602RvDfJCjMg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3D56811E86;
	Tue,  9 Jan 2024 11:20:45 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0C7D83C39;
	Tue,  9 Jan 2024 11:20:42 +0000 (UTC)
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
Subject: [PATCH 2/6] netfs: Count DIO writes
Date: Tue,  9 Jan 2024 11:20:19 +0000
Message-ID: <20240109112029.1572463-3-dhowells@redhat.com>
In-Reply-To: <20240109112029.1572463-1-dhowells@redhat.com>
References: <20240109112029.1572463-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Provide a counter for DIO writes to match that for DIO reads.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/direct_write.c |  1 +
 fs/netfs/internal.h     |  1 +
 fs/netfs/stats.c        | 11 +++++++----
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index b9cbfd6a8a01..60a40d293c87 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -140,6 +140,7 @@ ssize_t netfs_unbuffered_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	_enter("%llx,%zx,%llx", iocb->ki_pos, iov_iter_count(from), i_size_read(inode));
 
 	trace_netfs_write_iter(iocb, from);
+	netfs_stat(&netfs_n_rh_dio_write);
 
 	ret = netfs_start_io_direct(inode);
 	if (ret < 0)
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index a6dfc8888377..3f9620d0fa63 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -104,6 +104,7 @@ int netfs_end_writethrough(struct netfs_io_request *wreq, struct kiocb *iocb);
  */
 #ifdef CONFIG_NETFS_STATS
 extern atomic_t netfs_n_rh_dio_read;
+extern atomic_t netfs_n_rh_dio_write;
 extern atomic_t netfs_n_rh_readahead;
 extern atomic_t netfs_n_rh_readpage;
 extern atomic_t netfs_n_rh_rreq;
diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
index 15fd5c3f0f39..42db36528d92 100644
--- a/fs/netfs/stats.c
+++ b/fs/netfs/stats.c
@@ -10,6 +10,7 @@
 #include "internal.h"
 
 atomic_t netfs_n_rh_dio_read;
+atomic_t netfs_n_rh_dio_write;
 atomic_t netfs_n_rh_readahead;
 atomic_t netfs_n_rh_readpage;
 atomic_t netfs_n_rh_rreq;
@@ -37,14 +38,13 @@ atomic_t netfs_n_wh_write_failed;
 
 int netfs_stats_show(struct seq_file *m, void *v)
 {
-	seq_printf(m, "Netfs  : DR=%u RA=%u RP=%u WB=%u WBZ=%u rr=%u sr=%u\n",
+	seq_printf(m, "Netfs  : DR=%u DW=%u RA=%u RP=%u WB=%u WBZ=%u\n",
 		   atomic_read(&netfs_n_rh_dio_read),
+		   atomic_read(&netfs_n_rh_dio_write),
 		   atomic_read(&netfs_n_rh_readahead),
 		   atomic_read(&netfs_n_rh_readpage),
 		   atomic_read(&netfs_n_rh_write_begin),
-		   atomic_read(&netfs_n_rh_write_zskip),
-		   atomic_read(&netfs_n_rh_rreq),
-		   atomic_read(&netfs_n_rh_sreq));
+		   atomic_read(&netfs_n_rh_write_zskip));
 	seq_printf(m, "Netfs  : ZR=%u sh=%u sk=%u\n",
 		   atomic_read(&netfs_n_rh_zero),
 		   atomic_read(&netfs_n_rh_short_read),
@@ -66,6 +66,9 @@ int netfs_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&netfs_n_wh_write),
 		   atomic_read(&netfs_n_wh_write_done),
 		   atomic_read(&netfs_n_wh_write_failed));
+	seq_printf(m, "Netfs  : rr=%u sr=%u\n",
+		   atomic_read(&netfs_n_rh_rreq),
+		   atomic_read(&netfs_n_rh_sreq));
 	return fscache_stats_show(m);
 }
 EXPORT_SYMBOL(netfs_stats_show);


