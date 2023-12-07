Return-Path: <linux-fsdevel+bounces-5261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C97809601
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 23:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D3B51F21222
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C86057311
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="clK+2qaN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05843877
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Dec 2023 13:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701984250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BBeV+gPa6exSN5f9Ij71agEQGyyesbGBrZnLGz9yhJU=;
	b=clK+2qaNQ3SgeJtzbPWADpz26Nu2mVeeTix+c0KvtoCFw2TCdV5pYmD0Hr090B3Qh5h4zD
	KodV2Q/aYM+jV3pFQXPMb+kblZbn7MEiow+6+xfTg5m6yswS987yX+uXciXkkhR3KHJgqZ
	umLPbzmIf/QV4E/rQs+qkMNjNeF7SfE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-xRXaFeGcNgOaRy7C7CAhjw-1; Thu, 07 Dec 2023 16:24:03 -0500
X-MC-Unique: xRXaFeGcNgOaRy7C7CAhjw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17FBE870825;
	Thu,  7 Dec 2023 21:24:02 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6E8473C35;
	Thu,  7 Dec 2023 21:23:59 +0000 (UTC)
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
	Eric Van Hensbergen <ericvh@kernel.org>,
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
Subject: [PATCH v3 32/59] netfs: Provide netfs_file_read_iter()
Date: Thu,  7 Dec 2023 21:21:39 +0000
Message-ID: <20231207212206.1379128-33-dhowells@redhat.com>
In-Reply-To: <20231207212206.1379128-1-dhowells@redhat.com>
References: <20231207212206.1379128-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Provide a top-level-ish function that can be pointed to directly by
->read_iter file op.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/buffered_read.c | 73 ++++++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h    |  2 ++
 2 files changed, 75 insertions(+)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 950f63fc156a..a59e7b2edaac 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -558,3 +558,76 @@ int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 	_leave(" = %d", ret);
 	return ret;
 }
+
+/**
+ * netfs_buffered_read_iter - Filesystem buffered I/O read routine
+ * @iocb: kernel I/O control block
+ * @iter: destination for the data read
+ *
+ * This is the ->read_iter() routine for all filesystems that can use the page
+ * cache directly.
+ *
+ * The IOCB_NOWAIT flag in iocb->ki_flags indicates that -EAGAIN shall be
+ * returned when no data can be read without waiting for I/O requests to
+ * complete; it doesn't prevent readahead.
+ *
+ * The IOCB_NOIO flag in iocb->ki_flags indicates that no new I/O requests
+ * shall be made for the read or for readahead.  When no data can be read,
+ * -EAGAIN shall be returned.  When readahead would be triggered, a partial,
+ * possibly empty read shall be returned.
+ *
+ * Return:
+ * * number of bytes copied, even for partial reads
+ * * negative error code (or 0 if IOCB_NOIO) if nothing was read
+ */
+ssize_t netfs_buffered_read_iter(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct netfs_inode *ictx = netfs_inode(inode);
+	ssize_t ret;
+
+	if (WARN_ON_ONCE((iocb->ki_flags & IOCB_DIRECT) ||
+			 test_bit(NETFS_ICTX_UNBUFFERED, &ictx->flags)))
+		return -EINVAL;
+
+	ret = netfs_start_io_read(inode);
+	if (ret == 0) {
+		ret = filemap_read(iocb, iter, 0);
+		netfs_end_io_read(inode);
+	}
+	return ret;
+}
+EXPORT_SYMBOL(netfs_buffered_read_iter);
+
+/**
+ * netfs_file_read_iter - Generic filesystem read routine
+ * @iocb: kernel I/O control block
+ * @iter: destination for the data read
+ *
+ * This is the ->read_iter() routine for all filesystems that can use the page
+ * cache directly.
+ *
+ * The IOCB_NOWAIT flag in iocb->ki_flags indicates that -EAGAIN shall be
+ * returned when no data can be read without waiting for I/O requests to
+ * complete; it doesn't prevent readahead.
+ *
+ * The IOCB_NOIO flag in iocb->ki_flags indicates that no new I/O requests
+ * shall be made for the read or for readahead.  When no data can be read,
+ * -EAGAIN shall be returned.  When readahead would be triggered, a partial,
+ * possibly empty read shall be returned.
+ *
+ * Return:
+ * * number of bytes copied, even for partial reads
+ * * negative error code (or 0 if IOCB_NOIO) if nothing was read
+ */
+ssize_t netfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct netfs_inode *ictx = netfs_inode(iocb->ki_filp->f_mapping->host);
+
+	if ((iocb->ki_flags & IOCB_DIRECT) ||
+	    test_bit(NETFS_ICTX_UNBUFFERED, &ictx->flags))
+		return netfs_unbuffered_read_iter(iocb, iter);
+
+	return netfs_buffered_read_iter(iocb, iter);
+}
+EXPORT_SYMBOL(netfs_file_read_iter);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 46c0a6b45bb8..638f42fdaef5 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -381,6 +381,8 @@ struct netfs_cache_ops {
 
 /* High-level read API. */
 ssize_t netfs_unbuffered_read_iter(struct kiocb *iocb, struct iov_iter *iter);
+ssize_t netfs_buffered_read_iter(struct kiocb *iocb, struct iov_iter *iter);
+ssize_t netfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter);
 
 /* High-level write API */
 ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,


