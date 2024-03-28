Return-Path: <linux-fsdevel+bounces-15579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 316EF890628
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 17:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD1029BC7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 16:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B771313F452;
	Thu, 28 Mar 2024 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F64IndvV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CCA13F001
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 16:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643957; cv=none; b=DwuGMhMpmz7ryC5A53y82Whu35FpdufqU0GJObThy+SRiyBk437wu90OxkSROwZ8DsZXSweG+NyUdLBHaX+O7smeCEoCaWPJk+ADb2sb8xmXzHZ9Gyr4dnAKsU5Gt/egA++Sgc4ABLyW1nCi7KwjgalOaVBAU/JYYvKBTJ2nKdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643957; c=relaxed/simple;
	bh=/05oRYXuuD62BOWpkiLmjztCrdnWPcumQgd+9QYa1e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocHyh6Twr6DJK33YgHF2ZdagiUTuSe585A/aQ2h4Vc07T1uyquoY6DKPhPzHOu5cbdv8Dvc/FZhnivzouHR7kiRO1mG1EI6OxPl6WcG2WqPWT2T8UGAOXjBwFNuKYo4gPpisggRzuWtbaCVIX94zOBJSTfmgUonBh6X1k7YNq5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F64IndvV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711643954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=clNmVAkUKGd8Z01ZlWkYBIz9mR2bmkgLzFIGVS5d4sY=;
	b=F64IndvVwUX03KMdossG0Fc6XX0jzC66u5Zytf9XsSPhRGDAl2e/WXnnlmm5O6ALNCaaI0
	IwUOjpuKdgW0v0v8Q5m3bc3DF4DT4bAQ4F7C5+k2i9ZuDqu/JOBfVDtqyjivqXDmVM3HcA
	k0/Ivi01LFxwKKmGRvIOJiS45Io8OpM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-ZlAnjQNcP7WbHuSb6f6JGQ-1; Thu, 28 Mar 2024 12:39:09 -0400
X-MC-Unique: ZlAnjQNcP7WbHuSb6f6JGQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A36488007A2;
	Thu, 28 Mar 2024 16:39:07 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 98F80C423E0;
	Thu, 28 Mar 2024 16:39:04 +0000 (UTC)
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
Subject: [PATCH 26/26] netfs, afs: Use writeback retry to deal with alternate keys
Date: Thu, 28 Mar 2024 16:34:18 +0000
Message-ID: <20240328163424.2781320-27-dhowells@redhat.com>
In-Reply-To: <20240328163424.2781320-1-dhowells@redhat.com>
References: <20240328163424.2781320-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Use a hook in the new writeback code's retry algorithm to rotate the keys
once all the outstanding subreqs have failed rather than doing it
separately on each subreq.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/file.c            |   1 +
 fs/afs/internal.h        |   1 +
 fs/afs/write.c           | 175 +++++++++++++++++++--------------------
 fs/netfs/write_collect.c |   9 +-
 include/linux/netfs.h    |   2 +
 5 files changed, 96 insertions(+), 92 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 8f983e3ecae7..c3f0c45ae9a9 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -368,6 +368,7 @@ static int afs_check_write_begin(struct file *file, loff_t pos, unsigned len,
 static void afs_free_request(struct netfs_io_request *rreq)
 {
 	key_put(rreq->netfs_priv);
+	afs_put_wb_key(rreq->netfs_priv2);
 }
 
 static void afs_update_i_size(struct inode *inode, loff_t new_i_size)
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 887245f9336d..6e1d3c4daf72 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1601,6 +1601,7 @@ extern int afs_check_volume_status(struct afs_volume *, struct afs_operation *);
 void afs_prepare_write(struct netfs_io_subrequest *subreq);
 void afs_issue_write(struct netfs_io_subrequest *subreq);
 void afs_begin_writeback(struct netfs_io_request *wreq);
+void afs_retry_request(struct netfs_io_request *wreq, struct netfs_io_stream *stream);
 extern int afs_writepages(struct address_space *, struct writeback_control *);
 extern int afs_fsync(struct file *, loff_t, loff_t, int);
 extern vm_fault_t afs_page_mkwrite(struct vm_fault *vmf);
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 6ef7d4cbc008..838db2e94388 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -29,43 +29,39 @@ static void afs_pages_written_back(struct afs_vnode *vnode, loff_t start, unsign
 
 /*
  * Find a key to use for the writeback.  We cached the keys used to author the
- * writes on the vnode.  *_wbk will contain the last writeback key used or NULL
- * and we need to start from there if it's set.
+ * writes on the vnode.  wreq->netfs_priv2 will contain the last writeback key
+ * record used or NULL and we need to start from there if it's set.
+ * wreq->netfs_priv will be set to the key itself or NULL.
  */
-static int afs_get_writeback_key(struct afs_vnode *vnode,
-				 struct afs_wb_key **_wbk)
+static void afs_get_writeback_key(struct netfs_io_request *wreq)
 {
-	struct afs_wb_key *wbk = NULL;
-	struct list_head *p;
-	int ret = -ENOKEY, ret2;
+	struct afs_wb_key *wbk, *old = wreq->netfs_priv2;
+	struct afs_vnode *vnode = AFS_FS_I(wreq->inode);
+
+	key_put(wreq->netfs_priv);
+	wreq->netfs_priv = NULL;
+	wreq->netfs_priv2 = NULL;
 
 	spin_lock(&vnode->wb_lock);
-	if (*_wbk)
-		p = (*_wbk)->vnode_link.next;
+	if (old)
+		wbk = list_next_entry(old, vnode_link);
 	else
-		p = vnode->wb_keys.next;
+		wbk = list_first_entry(&vnode->wb_keys, struct afs_wb_key, vnode_link);
 
-	while (p != &vnode->wb_keys) {
-		wbk = list_entry(p, struct afs_wb_key, vnode_link);
+	list_for_each_entry_from(wbk, &vnode->wb_keys, vnode_link) {
 		_debug("wbk %u", key_serial(wbk->key));
-		ret2 = key_validate(wbk->key);
-		if (ret2 == 0) {
+		if (key_validate(wbk->key) == 0) {
 			refcount_inc(&wbk->usage);
+			wreq->netfs_priv = key_get(wbk->key);
+			wreq->netfs_priv2 = wbk;
 			_debug("USE WB KEY %u", key_serial(wbk->key));
 			break;
 		}
-
-		wbk = NULL;
-		if (ret == -ENOKEY)
-			ret = ret2;
-		p = p->next;
 	}
 
 	spin_unlock(&vnode->wb_lock);
-	if (*_wbk)
-		afs_put_wb_key(*_wbk);
-	*_wbk = wbk;
-	return 0;
+
+	afs_put_wb_key(old);
 }
 
 static void afs_store_data_success(struct afs_operation *op)
@@ -88,72 +84,83 @@ static const struct afs_operation_ops afs_store_data_operation = {
 };
 
 /*
- * write to a file
+ * Prepare a subrequest to write to the server.  This sets the max_len
+ * parameter.
  */
-static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter, loff_t pos)
+void afs_prepare_write(struct netfs_io_subrequest *subreq)
+{
+	//if (test_bit(NETFS_SREQ_RETRYING, &subreq->flags))
+	//	subreq->max_len = 512 * 1024;
+	//else
+	subreq->max_len = 256 * 1024 * 1024;
+}
+
+/*
+ * Issue a subrequest to write to the server.
+ */
+void afs_issue_write(struct netfs_io_subrequest *subreq)
 {
+	struct netfs_io_request *wreq = subreq->rreq;
 	struct afs_operation *op;
-	struct afs_wb_key *wbk = NULL;
-	loff_t size = iov_iter_count(iter);
+	struct afs_vnode *vnode = AFS_FS_I(wreq->inode);
+	unsigned long long pos = subreq->start + subreq->transferred;
+	size_t len = subreq->len - subreq->transferred;
 	int ret = -ENOKEY;
 
-	_enter("%s{%llx:%llu.%u},%llx,%llx",
+	_enter("R=%x[%x],%s{%llx:%llu.%u},%llx,%zx",
+	       wreq->debug_id, subreq->debug_index,
 	       vnode->volume->name,
 	       vnode->fid.vid,
 	       vnode->fid.vnode,
 	       vnode->fid.unique,
-	       size, pos);
+	       pos, len);
 
-	ret = afs_get_writeback_key(vnode, &wbk);
-	if (ret) {
-		_leave(" = %d [no keys]", ret);
-		return ret;
-	}
+#if 0 // Error injection
+	if (subreq->debug_index == 3)
+		return netfs_write_subrequest_terminated(subreq, -ENOANO, false);
 
-	op = afs_alloc_operation(wbk->key, vnode->volume);
-	if (IS_ERR(op)) {
-		afs_put_wb_key(wbk);
-		return -ENOMEM;
+	if (!test_bit(NETFS_SREQ_RETRYING, &subreq->flags)) {
+		set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
+		return netfs_write_subrequest_terminated(subreq, -EAGAIN, false);
 	}
+#endif
+
+	op = afs_alloc_operation(wreq->netfs_priv, vnode->volume);
+	if (IS_ERR(op))
+		return netfs_write_subrequest_terminated(subreq, -EAGAIN, false);
 
 	afs_op_set_vnode(op, 0, vnode);
-	op->file[0].dv_delta = 1;
+	op->file[0].dv_delta	= 1;
 	op->file[0].modification = true;
-	op->store.pos = pos;
-	op->store.size = size;
-	op->flags |= AFS_OPERATION_UNINTR;
-	op->ops = &afs_store_data_operation;
+	op->store.pos		= pos;
+	op->store.size		= len,
+	op->flags		|= AFS_OPERATION_UNINTR;
+	op->ops			= &afs_store_data_operation;
 
-try_next_key:
 	afs_begin_vnode_operation(op);
 
-	op->store.write_iter = iter;
-	op->store.i_size = max(pos + size, vnode->netfs.remote_i_size);
-	op->mtime = inode_get_mtime(&vnode->netfs.inode);
+	op->store.write_iter	= &subreq->io_iter;
+	op->store.i_size	= umax(pos + len, vnode->netfs.remote_i_size);
+	op->mtime		= inode_get_mtime(&vnode->netfs.inode);
 
 	afs_wait_for_operation(op);
-
-	switch (afs_op_error(op)) {
+	ret = afs_put_operation(op);
+	switch (ret) {
 	case -EACCES:
 	case -EPERM:
 	case -ENOKEY:
 	case -EKEYEXPIRED:
 	case -EKEYREJECTED:
 	case -EKEYREVOKED:
-		_debug("next");
-
-		ret = afs_get_writeback_key(vnode, &wbk);
-		if (ret == 0) {
-			key_put(op->key);
-			op->key = key_get(wbk->key);
-			goto try_next_key;
-		}
+		/* If there are more keys we can try, use the retry algorithm
+		 * to rotate the keys.
+		 */
+		if (wreq->netfs_priv2)
+			set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
 		break;
 	}
 
-	afs_put_wb_key(wbk);
-	_leave(" = %d", afs_op_error(op));
-	return afs_put_operation(op);
+	netfs_write_subrequest_terminated(subreq, ret < 0 ? ret : subreq->len, false);
 }
 
 /*
@@ -162,44 +169,32 @@ static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter, loff_t
  */
 void afs_begin_writeback(struct netfs_io_request *wreq)
 {
+	afs_get_writeback_key(wreq);
 	wreq->io_streams[0].avail = true;
 }
 
 /*
- * Prepare a subrequest to write to the server.  This sets the max_len
- * parameter.
- */
-void afs_prepare_write(struct netfs_io_subrequest *subreq)
-{
-	//if (test_bit(NETFS_SREQ_RETRYING, &subreq->flags))
-	//	subreq->max_len = 512 * 1024;
-	//else
-	subreq->max_len = 256 * 1024 * 1024;
-}
-
-/*
- * Issue a subrequest to write to the server.
+ * Prepare to retry the writes in request.  Use this to try rotating the
+ * available writeback keys.
  */
-void afs_issue_write(struct netfs_io_subrequest *subreq)
+void afs_retry_request(struct netfs_io_request *wreq, struct netfs_io_stream *stream)
 {
-	struct afs_vnode *vnode = AFS_FS_I(subreq->rreq->inode);
-	ssize_t ret;
-
-	_enter("%x[%x],%zx",
-	       subreq->rreq->debug_id, subreq->debug_index, subreq->io_iter.count);
-
-#if 0 // Error injection
-	if (subreq->debug_index == 3)
-		return netfs_write_subrequest_terminated(subreq, -ENOANO, false);
+	struct netfs_io_subrequest *subreq =
+		list_first_entry(&stream->subrequests,
+				 struct netfs_io_subrequest, rreq_link);
 
-	if (!test_bit(NETFS_SREQ_RETRYING, &subreq->flags)) {
-		set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
-		return netfs_write_subrequest_terminated(subreq, -EAGAIN, false);
+	switch (subreq->error) {
+	case -EACCES:
+	case -EPERM:
+	case -ENOKEY:
+	case -EKEYEXPIRED:
+	case -EKEYREJECTED:
+	case -EKEYREVOKED:
+		afs_get_writeback_key(wreq);
+		if (!wreq->netfs_priv)
+			stream->failed = true;
+		break;
 	}
-#endif
-
-	ret = afs_store_data(vnode, &subreq->io_iter, subreq->start);
-	netfs_write_subrequest_terminated(subreq, ret < 0 ? ret : subreq->len, false);
 }
 
 /*
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index bea939ab0830..7ff15e2d7270 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -168,6 +168,13 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 
 	_enter("R=%x[%x:]", wreq->debug_id, stream->stream_nr);
 
+	if (list_empty(&stream->subrequests))
+		return;
+
+	if (stream->source == NETFS_UPLOAD_TO_SERVER &&
+	    wreq->netfs_ops->retry_request)
+		wreq->netfs_ops->retry_request(wreq, stream);
+
 	if (unlikely(stream->failed))
 		return;
 
@@ -187,8 +194,6 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 		return;
 	}
 
-	if (list_empty(&stream->subrequests))
-		return;
 	next = stream->subrequests.next;
 
 	do {
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index c2ba364041b0..298552f5122c 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -235,6 +235,7 @@ struct netfs_io_request {
 	struct iov_iter		iter;		/* Unencrypted-side iterator */
 	struct iov_iter		io_iter;	/* I/O (Encrypted-side) iterator */
 	void			*netfs_priv;	/* Private data for the netfs */
+	void			*netfs_priv2;	/* Private data for the netfs */
 	struct bio_vec		*direct_bv;	/* DIO buffer list (when handling iovec-iter) */
 	unsigned int		direct_bv_count; /* Number of elements in direct_bv[] */
 	unsigned int		debug_id;
@@ -306,6 +307,7 @@ struct netfs_request_ops {
 	void (*begin_writeback)(struct netfs_io_request *wreq);
 	void (*prepare_write)(struct netfs_io_subrequest *subreq);
 	void (*issue_write)(struct netfs_io_subrequest *subreq);
+	void (*retry_request)(struct netfs_io_request *wreq, struct netfs_io_stream *stream);
 	void (*invalidate_cache)(struct netfs_io_request *wreq);
 };
 


