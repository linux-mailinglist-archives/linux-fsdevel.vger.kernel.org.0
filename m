Return-Path: <linux-fsdevel+bounces-18345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE53F8B78B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 16:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B4451C22621
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 14:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3731C8FB8;
	Tue, 30 Apr 2024 14:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Az1zstw3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B740D1C68B4
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485798; cv=none; b=T5wNeUQfiseHLUlClm+pGPYKgkNtY3DPIoLWSZLr0czcMntANh8W9kM68gZvHdEbRsotstD17Mgq98Ia1GYvJKE/oyTQACUH+4sZ//CiGfaBwfqe6IUOkFoXfED2UeHfFJYsPpJlg9bGwZBVjRzTUZPLXu3tmC5pdRF+8BszKnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485798; c=relaxed/simple;
	bh=01uPlYp+gvlCfzslwRki94T9N2SRBI4xvdjRNvc/FwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwQAHGzlJCUkmV3XIA7Cg19OzH2OJMiQiR77yJXK/ozqshldYwU7QljFmuX+vF9cOmJttRTMDcU9Y0DCB7H3cYzMUVBOe5J95l0aE5y9lDuoulFxq35siTv+zO7ErGETCQ3snuJPAE/TcFpbGBwGZ3Zw80clSNSGl6P9tCs/gEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Az1zstw3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714485792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vGCt48jeC555R9pX52pBDvHMiG4CZMcxlPULZd6gPmg=;
	b=Az1zstw3xOf8zW4a9D9mEw0Z+XAH/JMFJSvZLJWtG+cdwGJ86GOw53wycHf2uXckoKkres
	QYCTsTlh9UcFmWxtmB6LhzNtNIvp6oDpryLZwIYDV0BG5C/8P0nlSPqpdnFVI9m2dMT9BD
	H/B1ImXlgapJixsxpL9xokNtLUa5RFs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-SoCcPPCCPq6LefypiSX-qA-1; Tue, 30 Apr 2024 10:02:56 -0400
X-MC-Unique: SoCcPPCCPq6LefypiSX-qA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0ADA788294A;
	Tue, 30 Apr 2024 14:02:16 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D1AD6EC680;
	Tue, 30 Apr 2024 14:02:12 +0000 (UTC)
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
	linux-kernel@vger.kernel.org,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: [PATCH v2 17/22] netfs, 9p: Implement helpers for new write code
Date: Tue, 30 Apr 2024 15:00:48 +0100
Message-ID: <20240430140056.261997-18-dhowells@redhat.com>
In-Reply-To: <20240430140056.261997-1-dhowells@redhat.com>
References: <20240430140056.261997-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Implement the helpers for the new write code in 9p.  There's now an
optional ->prepare_write() that allows the filesystem to set the parameters
for the next write, such as maximum size and maximum segment count, and an
->issue_write() that is called to initiate an (asynchronous) write
operation.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: v9fs@lists.linux.dev
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---

Notes:
    Changes
    =======
    ver #2)
     - Use 'int len' rather than 'size_t len' because of the varargs packet
       formatter.

 fs/9p/vfs_addr.c        | 48 ++++++++++++++++++++++++++++++++++++++++
 include/net/9p/client.h |  2 ++
 net/9p/Kconfig          |  1 +
 net/9p/client.c         | 49 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 100 insertions(+)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 5a943c122d83..07d03efdd594 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -26,6 +26,40 @@
 #include "cache.h"
 #include "fid.h"
 
+/*
+ * Writeback calls this when it finds a folio that needs uploading.  This isn't
+ * called if writeback only has copy-to-cache to deal with.
+ */
+static void v9fs_begin_writeback(struct netfs_io_request *wreq)
+{
+	struct p9_fid *fid;
+
+	fid = v9fs_fid_find_inode(wreq->inode, true, INVALID_UID, true);
+	if (!fid) {
+		WARN_ONCE(1, "folio expected an open fid inode->i_ino=%lx\n",
+			  wreq->inode->i_ino);
+		return;
+	}
+
+	wreq->wsize = fid->clnt->msize - P9_IOHDRSZ;
+	if (fid->iounit)
+		wreq->wsize = min(wreq->wsize, fid->iounit);
+	wreq->netfs_priv = fid;
+	wreq->io_streams[0].avail = true;
+}
+
+/*
+ * Issue a subrequest to write to the server.
+ */
+static void v9fs_issue_write(struct netfs_io_subrequest *subreq)
+{
+	struct p9_fid *fid = subreq->rreq->netfs_priv;
+	int err, len;
+
+	len = p9_client_write(fid, subreq->start, &subreq->io_iter, &err);
+	netfs_write_subrequest_terminated(subreq, len ?: err, false);
+}
+
 static void v9fs_upload_to_server(struct netfs_io_subrequest *subreq)
 {
 	struct p9_fid *fid = subreq->rreq->netfs_priv;
@@ -92,6 +126,14 @@ static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 			rreq->origin == NETFS_UNBUFFERED_WRITE ||
 			rreq->origin == NETFS_DIO_WRITE);
 
+#if 0 // TODO: Cut over
+	if (rreq->origin == NETFS_WRITEBACK)
+		return 0; /* We don't get the write handle until we find we
+			   * have actually dirty data and not just
+			   * copy-to-cache data.
+			   */
+#endif
+
 	if (file) {
 		fid = file->private_data;
 		if (!fid)
@@ -103,6 +145,10 @@ static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 			goto no_fid;
 	}
 
+	rreq->wsize = fid->clnt->msize - P9_IOHDRSZ;
+	if (fid->iounit)
+		rreq->wsize = min(rreq->wsize, fid->iounit);
+
 	/* we might need to read from a fid that was opened write-only
 	 * for read-modify-write of page cache, use the writeback fid
 	 * for that */
@@ -131,6 +177,8 @@ const struct netfs_request_ops v9fs_req_ops = {
 	.init_request		= v9fs_init_request,
 	.free_request		= v9fs_free_request,
 	.issue_read		= v9fs_issue_read,
+	.begin_writeback	= v9fs_begin_writeback,
+	.issue_write		= v9fs_issue_write,
 	.create_write_requests	= v9fs_create_write_requests,
 };
 
diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index 78ebcf782ce5..4f785098c67a 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -207,6 +207,8 @@ int p9_client_read(struct p9_fid *fid, u64 offset, struct iov_iter *to, int *err
 int p9_client_read_once(struct p9_fid *fid, u64 offset, struct iov_iter *to,
 		int *err);
 int p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err);
+struct netfs_io_subrequest;
+void p9_client_write_subreq(struct netfs_io_subrequest *subreq);
 int p9_client_readdir(struct p9_fid *fid, char *data, u32 count, u64 offset);
 int p9dirent_read(struct p9_client *clnt, char *buf, int len,
 		  struct p9_dirent *dirent);
diff --git a/net/9p/Kconfig b/net/9p/Kconfig
index 00ebce9e5a65..bcdab9c23b40 100644
--- a/net/9p/Kconfig
+++ b/net/9p/Kconfig
@@ -5,6 +5,7 @@
 
 menuconfig NET_9P
 	tristate "Plan 9 Resource Sharing Support (9P2000)"
+	select NETFS_SUPPORT
 	help
 	  If you say Y here, you will get experimental support for
 	  Plan 9 resource sharing via the 9P2000 protocol.
diff --git a/net/9p/client.c b/net/9p/client.c
index f7e90b4769bb..00774656eeac 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -18,6 +18,7 @@
 #include <linux/sched/signal.h>
 #include <linux/uaccess.h>
 #include <linux/uio.h>
+#include <linux/netfs.h>
 #include <net/9p/9p.h>
 #include <linux/parser.h>
 #include <linux/seq_file.h>
@@ -1661,6 +1662,54 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
 }
 EXPORT_SYMBOL(p9_client_write);
 
+void
+p9_client_write_subreq(struct netfs_io_subrequest *subreq)
+{
+	struct netfs_io_request *wreq = subreq->rreq;
+	struct p9_fid *fid = wreq->netfs_priv;
+	struct p9_client *clnt = fid->clnt;
+	struct p9_req_t *req;
+	unsigned long long start = subreq->start + subreq->transferred;
+	int written, len = subreq->len - subreq->transferred;
+	int err;
+
+	p9_debug(P9_DEBUG_9P, ">>> TWRITE fid %d offset %llu len %d\n",
+		 fid->fid, start, len);
+
+	/* Don't bother zerocopy for small IO (< 1024) */
+	if (clnt->trans_mod->zc_request && len > 1024) {
+		req = p9_client_zc_rpc(clnt, P9_TWRITE, NULL, &subreq->io_iter,
+				       0, wreq->len, P9_ZC_HDR_SZ, "dqd",
+				       fid->fid, start, len);
+	} else {
+		req = p9_client_rpc(clnt, P9_TWRITE, "dqV", fid->fid,
+				    start, len, &subreq->io_iter);
+	}
+	if (IS_ERR(req)) {
+		netfs_write_subrequest_terminated(subreq, PTR_ERR(req), false);
+		return;
+	}
+
+	err = p9pdu_readf(&req->rc, clnt->proto_version, "d", &written);
+	if (err) {
+		trace_9p_protocol_dump(clnt, &req->rc);
+		p9_req_put(clnt, req);
+		netfs_write_subrequest_terminated(subreq, err, false);
+		return;
+	}
+
+	if (written > len) {
+		pr_err("bogus RWRITE count (%d > %u)\n", written, len);
+		written = len;
+	}
+
+	p9_debug(P9_DEBUG_9P, "<<< RWRITE count %d\n", len);
+
+	p9_req_put(clnt, req);
+	netfs_write_subrequest_terminated(subreq, written, false);
+}
+EXPORT_SYMBOL(p9_client_write_subreq);
+
 struct p9_wstat *p9_client_stat(struct p9_fid *fid)
 {
 	int err;


