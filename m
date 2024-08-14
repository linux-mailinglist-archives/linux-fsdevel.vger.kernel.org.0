Return-Path: <linux-fsdevel+bounces-25969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 020429523B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 22:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263B61C21A40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 20:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3332A1C6881;
	Wed, 14 Aug 2024 20:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bmu5eK5K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF9E1D2F6E
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 20:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723668007; cv=none; b=JeT/keoloaAjOVPyHnaa4SOmwNWxMtcgUrOfN7rTrdmLSXspHjr0SHpMx0wS0S8JCVkxhAvk7J3LozFX1KPySUP8FFWSOUONSYag2mYfFRgdJqQtfYGmrPKRElZpNL+lD3GlnMcySYLUKNMy+C8OrRSIaiLLIHmh2ADu2fAFEI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723668007; c=relaxed/simple;
	bh=aKvb8fmunQU1JBf++Dggbb8HM3gLpdiQqWzZeFIwPhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDj8jBkblb6cXiG6jl14QqwfhBX27TB/yDrWlROdy+i9JEKGANH7in5jnVrP78hfyS1Z1FJLun7NuQHEOaWQLm5ZwJgMQUfCDJI9SLCaLKTk2bzJbcELnV0bzkx4nMTD7wwUEBsUJa4Ltcrbp39dAJOSODaMPWc2fcC3w+yItmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bmu5eK5K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723668004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rqLnuh2mATxWHSyGBr0F3/ixnLGv5aheiziVrxxyTWk=;
	b=bmu5eK5KqT8tlH5kLQ7bAbUvFsyOxNFkwaL0QTHlfT646czgy7kbsb3o5Q5N5epqY8KQZo
	/BKkHZg9vI4InMc1eBoS/6mfhkSV2lC8rWn6xCwj/BhKwJyVwL+X8x2daZR7tF9rkVjft+
	KiZt/X/+/x6tolaHNzMdxXyK7TLGSKY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-8DvuAjrjPPu5lpcT3ZETFw-1; Wed,
 14 Aug 2024 16:40:00 -0400
X-MC-Unique: 8DvuAjrjPPu5lpcT3ZETFw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 430C21955F43;
	Wed, 14 Aug 2024 20:39:57 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 67BBB1955E8C;
	Wed, 14 Aug 2024 20:39:51 +0000 (UTC)
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
Subject: [PATCH v2 07/25] netfs: Move max_len/max_nr_segs from netfs_io_subrequest to netfs_io_stream
Date: Wed, 14 Aug 2024 21:38:27 +0100
Message-ID: <20240814203850.2240469-8-dhowells@redhat.com>
In-Reply-To: <20240814203850.2240469-1-dhowells@redhat.com>
References: <20240814203850.2240469-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Move max_len/max_nr_segs from struct netfs_io_subrequest to struct
netfs_io_stream as we only issue one subreq at a time and then don't need
these values again for that subreq unless and until we have to retry it -
in which case we want to renegotiate them.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/write.c           |  4 +++-
 fs/cachefiles/io.c       |  5 +++--
 fs/netfs/io.c            |  4 ++--
 fs/netfs/write_collect.c | 10 +++++-----
 fs/netfs/write_issue.c   | 14 +++++++-------
 fs/smb/client/file.c     | 15 ++++++++-------
 include/linux/netfs.h    |  4 ++--
 7 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index e959640694c2..34107b55f834 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -89,10 +89,12 @@ static const struct afs_operation_ops afs_store_data_operation = {
  */
 void afs_prepare_write(struct netfs_io_subrequest *subreq)
 {
+	struct netfs_io_stream *stream = &subreq->rreq->io_streams[subreq->stream_nr];
+
 	//if (test_bit(NETFS_SREQ_RETRYING, &subreq->flags))
 	//	subreq->max_len = 512 * 1024;
 	//else
-	subreq->max_len = 256 * 1024 * 1024;
+	stream->sreq_max_len = 256 * 1024 * 1024;
 }
 
 /*
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index a91acd03ee12..5b82ba7785cd 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -627,11 +627,12 @@ static void cachefiles_prepare_write_subreq(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *wreq = subreq->rreq;
 	struct netfs_cache_resources *cres = &wreq->cache_resources;
+	struct netfs_io_stream *stream = &wreq->io_streams[subreq->stream_nr];
 
 	_enter("W=%x[%x] %llx", wreq->debug_id, subreq->debug_index, subreq->start);
 
-	subreq->max_len = MAX_RW_COUNT;
-	subreq->max_nr_segs = BIO_MAX_VECS;
+	stream->sreq_max_len = MAX_RW_COUNT;
+	stream->sreq_max_segs = BIO_MAX_VECS;
 
 	if (!cachefiles_cres_file(cres)) {
 		if (!fscache_wait_for_operation(cres, FSCACHE_WANT_WRITE))
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 5367caf3fa28..ce3e821b4e4f 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -619,9 +619,9 @@ netfs_rreq_prepare_read(struct netfs_io_request *rreq,
 			goto out;
 		}
 
-		if (subreq->max_nr_segs) {
+		if (rreq->io_streams[0].sreq_max_segs) {
 			lsize = netfs_limit_iter(io_iter, 0, subreq->len,
-						 subreq->max_nr_segs);
+						 rreq->io_streams[0].sreq_max_segs);
 			if (subreq->len > lsize) {
 				subreq->len = lsize;
 				trace_netfs_sreq(subreq, netfs_sreq_trace_limited);
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 426cf87aaf2e..e105ac270090 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -231,7 +231,7 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 			__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
 			stream->prepare_write(subreq);
 
-			part = min(len, subreq->max_len);
+			part = min(len, stream->sreq_max_len);
 			subreq->len = part;
 			subreq->start = start;
 			subreq->transferred = 0;
@@ -271,8 +271,6 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 			subreq = netfs_alloc_subrequest(wreq);
 			subreq->source		= to->source;
 			subreq->start		= start;
-			subreq->max_len		= len;
-			subreq->max_nr_segs	= INT_MAX;
 			subreq->debug_index	= atomic_inc_return(&wreq->subreq_counter);
 			subreq->stream_nr	= to->stream_nr;
 			__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
@@ -286,10 +284,12 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 			to = list_next_entry(to, rreq_link);
 			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
 
+			stream->sreq_max_len	= len;
+			stream->sreq_max_segs	= INT_MAX;
 			switch (stream->source) {
 			case NETFS_UPLOAD_TO_SERVER:
 				netfs_stat(&netfs_n_wh_upload);
-				subreq->max_len = min(len, wreq->wsize);
+				stream->sreq_max_len = umin(len, wreq->wsize);
 				break;
 			case NETFS_WRITE_TO_CACHE:
 				netfs_stat(&netfs_n_wh_write);
@@ -300,7 +300,7 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 
 			stream->prepare_write(subreq);
 
-			part = min(len, subreq->max_len);
+			part = umin(len, stream->sreq_max_len);
 			subreq->len = subreq->transferred + part;
 			len -= part;
 			start += part;
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 44f35a0faaca..34e541afd79b 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -158,8 +158,6 @@ static void netfs_prepare_write(struct netfs_io_request *wreq,
 	subreq = netfs_alloc_subrequest(wreq);
 	subreq->source		= stream->source;
 	subreq->start		= start;
-	subreq->max_len		= ULONG_MAX;
-	subreq->max_nr_segs	= INT_MAX;
 	subreq->stream_nr	= stream->stream_nr;
 
 	_enter("R=%x[%x]", wreq->debug_id, subreq->debug_index);
@@ -170,10 +168,12 @@ static void netfs_prepare_write(struct netfs_io_request *wreq,
 
 	trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
 
+	stream->sreq_max_len	= UINT_MAX;
+	stream->sreq_max_segs	= INT_MAX;
 	switch (stream->source) {
 	case NETFS_UPLOAD_TO_SERVER:
 		netfs_stat(&netfs_n_wh_upload);
-		subreq->max_len = wreq->wsize;
+		stream->sreq_max_len = wreq->wsize;
 		break;
 	case NETFS_WRITE_TO_CACHE:
 		netfs_stat(&netfs_n_wh_write);
@@ -290,13 +290,13 @@ int netfs_advance_write(struct netfs_io_request *wreq,
 		netfs_prepare_write(wreq, stream, start);
 	subreq = stream->construct;
 
-	part = min(subreq->max_len - subreq->len, len);
-	_debug("part %zx/%zx %zx/%zx", subreq->len, subreq->max_len, part, len);
+	part = umin(stream->sreq_max_len - subreq->len, len);
+	_debug("part %zx/%zx %zx/%zx", subreq->len, stream->sreq_max_len, part, len);
 	subreq->len += part;
 	subreq->nr_segs++;
 
-	if (subreq->len >= subreq->max_len ||
-	    subreq->nr_segs >= subreq->max_nr_segs ||
+	if (subreq->len >= stream->sreq_max_len ||
+	    subreq->nr_segs >= stream->sreq_max_segs ||
 	    to_eof) {
 		netfs_issue_write(wreq, stream);
 		subreq = NULL;
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 419bfd0c0cbb..0ff1a286e9ee 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -49,6 +49,7 @@ static void cifs_prepare_write(struct netfs_io_subrequest *subreq)
 	struct cifs_io_subrequest *wdata =
 		container_of(subreq, struct cifs_io_subrequest, subreq);
 	struct cifs_io_request *req = wdata->req;
+	struct netfs_io_stream *stream = &req->rreq.io_streams[subreq->stream_nr];
 	struct TCP_Server_Info *server;
 	struct cifsFileInfo *open_file = req->cfile;
 	size_t wsize = req->rreq.wsize;
@@ -73,7 +74,7 @@ static void cifs_prepare_write(struct netfs_io_subrequest *subreq)
 		}
 	}
 
-	rc = server->ops->wait_mtu_credits(server, wsize, &wdata->subreq.max_len,
+	rc = server->ops->wait_mtu_credits(server, wsize, &stream->sreq_max_len,
 					   &wdata->credits);
 	if (rc < 0) {
 		subreq->error = rc;
@@ -92,7 +93,7 @@ static void cifs_prepare_write(struct netfs_io_subrequest *subreq)
 
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	if (server->smbd_conn)
-		subreq->max_nr_segs = server->smbd_conn->max_frmr_depth;
+		stream->sreq_max_segs = server->smbd_conn->max_frmr_depth;
 #endif
 }
 
@@ -149,11 +150,11 @@ static void cifs_netfs_invalidate_cache(struct netfs_io_request *wreq)
 static bool cifs_clamp_length(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
+	struct netfs_io_stream *stream = &rreq->io_streams[subreq->stream_nr];
 	struct cifs_io_subrequest *rdata = container_of(subreq, struct cifs_io_subrequest, subreq);
 	struct cifs_io_request *req = container_of(subreq->rreq, struct cifs_io_request, rreq);
 	struct TCP_Server_Info *server = req->server;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(rreq->inode->i_sb);
-	size_t rsize = 0;
 	int rc;
 
 	rdata->xid = get_xid();
@@ -166,8 +167,8 @@ static bool cifs_clamp_length(struct netfs_io_subrequest *subreq)
 						     cifs_sb->ctx);
 
 
-	rc = server->ops->wait_mtu_credits(server, cifs_sb->ctx->rsize, &rsize,
-					   &rdata->credits);
+	rc = server->ops->wait_mtu_credits(server, cifs_sb->ctx->rsize,
+					   &stream->sreq_max_len, &rdata->credits);
 	if (rc) {
 		subreq->error = rc;
 		return false;
@@ -183,11 +184,11 @@ static bool cifs_clamp_length(struct netfs_io_subrequest *subreq)
 			      server->credits, server->in_flight, 0,
 			      cifs_trace_rw_credits_read_submit);
 
-	subreq->len = min_t(size_t, subreq->len, rsize);
+	subreq->len = umin(subreq->len, stream->sreq_max_len);
 
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	if (server->smbd_conn)
-		subreq->max_nr_segs = server->smbd_conn->max_frmr_depth;
+		stream->sreq_max_segs = server->smbd_conn->max_frmr_depth;
 #endif
 	return true;
 }
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 574df0402c44..11fa86640d91 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -134,6 +134,8 @@ static inline struct netfs_group *netfs_folio_group(struct folio *folio)
 struct netfs_io_stream {
 	/* Submission tracking */
 	struct netfs_io_subrequest *construct;	/* Op being constructed */
+	size_t			sreq_max_len;	/* Maximum size of a subrequest */
+	unsigned int		sreq_max_segs;	/* 0 or max number of segments in an iterator */
 	unsigned int		submit_off;	/* Folio offset we're submitting from */
 	unsigned int		submit_len;	/* Amount of data left to submit */
 	unsigned int		submit_max_len;	/* Amount I/O can be rounded up to */
@@ -177,14 +179,12 @@ struct netfs_io_subrequest {
 	struct list_head	rreq_link;	/* Link in rreq->subrequests */
 	struct iov_iter		io_iter;	/* Iterator for this subrequest */
 	unsigned long long	start;		/* Where to start the I/O */
-	size_t			max_len;	/* Maximum size of the I/O */
 	size_t			len;		/* Size of the I/O */
 	size_t			transferred;	/* Amount of data transferred */
 	refcount_t		ref;
 	short			error;		/* 0 or error that occurred */
 	unsigned short		debug_index;	/* Index in list (for debugging output) */
 	unsigned int		nr_segs;	/* Number of segs in io_iter */
-	unsigned int		max_nr_segs;	/* 0 or max number of segments in an iterator */
 	enum netfs_io_source	source;		/* Where to read from/write to */
 	unsigned char		stream_nr;	/* I/O stream this belongs to */
 	unsigned long		flags;


