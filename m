Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F01433446B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 18:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbhCJQ7p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 11:59:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56741 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233555AbhCJQ72 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:59:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615395567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=23/uau4IKv0ZIDU3TV8ZbfKGSR3Dzt3o5ODM+F77Hxs=;
        b=C7vCFRaTqlqw4WNVPmHekXvsvcKjwzl7HoWSukYWU2IBwQgs17sKZFOx9YLWJ2wtcWfmWh
        xrqdcO6cOHWCeJHKqsfruO817q6noNzSRBJ+mghF/SvPVbJFDbFG0zU/D04TYPE5SZjw6f
        9BQpaBCPE+2bH2IuY0Jf8YJ3K4pT43w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-CgcrjcsTN3KP4V5ZM2sWXg-1; Wed, 10 Mar 2021 11:59:25 -0500
X-MC-Unique: CgcrjcsTN3KP4V5ZM2sWXg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A53A0802B62;
        Wed, 10 Mar 2021 16:59:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-152.rdu2.redhat.com [10.10.118.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5BA745B6A8;
        Wed, 10 Mar 2021 16:59:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v4 22/28] afs: Use ITER_XARRAY for writing
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     linux-afs@lists.infradead.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 10 Mar 2021 16:59:16 +0000
Message-ID: <161539555629.286939.5241869986617154517.stgit@warthog.procyon.org.uk>
In-Reply-To: <161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk>
References: <161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use a single ITER_XARRAY iterator to describe the portion of a file to be
transmitted to the server rather than generating a series of small
ITER_BVEC iterators on the fly.  This will make it easier to implement AIO
in afs.

In theory we could maybe use one giant ITER_BVEC, but that means
potentially allocating a huge array of bio_vec structs (max 256 per page)
when in fact the pagecache already has a structure listing all the relevant
pages (radix_tree/xarray) that can be walked over.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/153685395197.14766.16289516750731233933.stgit@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/158861251312.340223.17924900795425422532.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/159465828607.1377938.6903132788463419368.stgit@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/160588535018.3465195.14509994354240338307.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/161118152415.1232039.6452879415814850025.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/161161048194.2537118.13763612220937637316.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/161340411602.1303470.4661108879482218408.stgit@warthog.procyon.org.uk/ # v3
---

 fs/afs/fsclient.c          |   50 +++++++++------------
 fs/afs/internal.h          |   15 +++---
 fs/afs/rxrpc.c             |  103 ++++++--------------------------------------
 fs/afs/write.c             |  100 ++++++++++++++++++++++++-------------------
 fs/afs/yfsclient.c         |   25 +++--------
 include/trace/events/afs.h |   51 ++++++++--------------
 6 files changed, 126 insertions(+), 218 deletions(-)

diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 897b37301851..31e6b3635541 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -1055,8 +1055,7 @@ static const struct afs_call_type afs_RXFSStoreData64 = {
 /*
  * store a set of pages to a very large file
  */
-static void afs_fs_store_data64(struct afs_operation *op,
-				loff_t pos, loff_t size, loff_t i_size)
+static void afs_fs_store_data64(struct afs_operation *op)
 {
 	struct afs_vnode_param *vp = &op->file[0];
 	struct afs_call *call;
@@ -1071,7 +1070,7 @@ static void afs_fs_store_data64(struct afs_operation *op,
 	if (!call)
 		return afs_op_nomem(op);
 
-	call->send_pages = true;
+	call->write_iter = op->store.write_iter;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -1087,47 +1086,38 @@ static void afs_fs_store_data64(struct afs_operation *op,
 	*bp++ = 0; /* unix mode */
 	*bp++ = 0; /* segment size */
 
-	*bp++ = htonl(upper_32_bits(pos));
-	*bp++ = htonl(lower_32_bits(pos));
-	*bp++ = htonl(upper_32_bits(size));
-	*bp++ = htonl(lower_32_bits(size));
-	*bp++ = htonl(upper_32_bits(i_size));
-	*bp++ = htonl(lower_32_bits(i_size));
+	*bp++ = htonl(upper_32_bits(op->store.pos));
+	*bp++ = htonl(lower_32_bits(op->store.pos));
+	*bp++ = htonl(upper_32_bits(op->store.size));
+	*bp++ = htonl(lower_32_bits(op->store.size));
+	*bp++ = htonl(upper_32_bits(op->store.i_size));
+	*bp++ = htonl(lower_32_bits(op->store.i_size));
 
 	trace_afs_make_fs_call(call, &vp->fid);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
 
 /*
- * store a set of pages
+ * Write data to a file on the server.
  */
 void afs_fs_store_data(struct afs_operation *op)
 {
 	struct afs_vnode_param *vp = &op->file[0];
 	struct afs_call *call;
-	loff_t size, pos, i_size;
 	__be32 *bp;
 
 	_enter(",%x,{%llx:%llu},,",
 	       key_serial(op->key), vp->fid.vid, vp->fid.vnode);
 
-	size = (loff_t)op->store.last_to - (loff_t)op->store.first_offset;
-	if (op->store.first != op->store.last)
-		size += (loff_t)(op->store.last - op->store.first) << PAGE_SHIFT;
-	pos = (loff_t)op->store.first << PAGE_SHIFT;
-	pos += op->store.first_offset;
-
-	i_size = i_size_read(&vp->vnode->vfs_inode);
-	if (pos + size > i_size)
-		i_size = size + pos;
-
 	_debug("size %llx, at %llx, i_size %llx",
-	       (unsigned long long) size, (unsigned long long) pos,
-	       (unsigned long long) i_size);
+	       (unsigned long long)op->store.size,
+	       (unsigned long long)op->store.pos,
+	       (unsigned long long)op->store.i_size);
 
-	if (upper_32_bits(pos) || upper_32_bits(i_size) || upper_32_bits(size) ||
-	    upper_32_bits(pos + size))
-		return afs_fs_store_data64(op, pos, size, i_size);
+	if (upper_32_bits(op->store.pos) ||
+	    upper_32_bits(op->store.size) ||
+	    upper_32_bits(op->store.i_size))
+		return afs_fs_store_data64(op);
 
 	call = afs_alloc_flat_call(op->net, &afs_RXFSStoreData,
 				   (4 + 6 + 3) * 4,
@@ -1135,7 +1125,7 @@ void afs_fs_store_data(struct afs_operation *op)
 	if (!call)
 		return afs_op_nomem(op);
 
-	call->send_pages = true;
+	call->write_iter = op->store.write_iter;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -1151,9 +1141,9 @@ void afs_fs_store_data(struct afs_operation *op)
 	*bp++ = 0; /* unix mode */
 	*bp++ = 0; /* segment size */
 
-	*bp++ = htonl(lower_32_bits(pos));
-	*bp++ = htonl(lower_32_bits(size));
-	*bp++ = htonl(lower_32_bits(i_size));
+	*bp++ = htonl(lower_32_bits(op->store.pos));
+	*bp++ = htonl(lower_32_bits(op->store.size));
+	*bp++ = htonl(lower_32_bits(op->store.i_size));
 
 	trace_afs_make_fs_call(call, &vp->fid);
 	afs_make_op_call(op, call, GFP_NOFS);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 0ed1793949dd..4076c6ba43eb 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -107,6 +107,7 @@ struct afs_call {
 	void			*request;	/* request data (first part) */
 	size_t			iov_len;	/* Size of *iter to be used */
 	struct iov_iter		def_iter;	/* Default buffer/data iterator */
+	struct iov_iter		*write_iter;	/* Iterator defining write to be made */
 	struct iov_iter		*iter;		/* Iterator currently in use */
 	union {	/* Convenience for ->def_iter */
 		struct kvec	kvec[1];
@@ -133,7 +134,6 @@ struct afs_call {
 	unsigned char		unmarshall;	/* unmarshalling phase */
 	unsigned char		addr_ix;	/* Address in ->alist */
 	bool			drop_ref;	/* T if need to drop ref for incoming call */
-	bool			send_pages;	/* T if data from mapping should be sent */
 	bool			need_attention;	/* T if RxRPC poked us */
 	bool			async;		/* T if asynchronous */
 	bool			upgrade;	/* T to request service upgrade */
@@ -811,12 +811,13 @@ struct afs_operation {
 			afs_lock_type_t type;
 		} lock;
 		struct {
-			struct address_space *mapping;	/* Pages being written from */
-			pgoff_t		first;		/* first page in mapping to deal with */
-			pgoff_t		last;		/* last page in mapping to deal with */
-			unsigned	first_offset;	/* offset into mapping[first] */
-			unsigned	last_to;	/* amount of mapping[last] */
-			bool		laundering;	/* Laundering page, PG_writeback not set */
+			struct iov_iter	*write_iter;
+			loff_t	pos;
+			loff_t	size;
+			loff_t	i_size;
+			pgoff_t	first;		/* first page in mapping to deal with */
+			pgoff_t	last;		/* last page in mapping to deal with */
+			bool	laundering;	/* Laundering page, PG_writeback not set */
 		} store;
 		struct {
 			struct iattr	*attr;
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index ae68576f822f..23a1a92d64bb 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -271,40 +271,6 @@ void afs_flat_call_destructor(struct afs_call *call)
 	call->buffer = NULL;
 }
 
-#define AFS_BVEC_MAX 8
-
-/*
- * Load the given bvec with the next few pages.
- */
-static void afs_load_bvec(struct afs_call *call, struct msghdr *msg,
-			  struct bio_vec *bv, pgoff_t first, pgoff_t last,
-			  unsigned offset)
-{
-	struct afs_operation *op = call->op;
-	struct page *pages[AFS_BVEC_MAX];
-	unsigned int nr, n, i, to, bytes = 0;
-
-	nr = min_t(pgoff_t, last - first + 1, AFS_BVEC_MAX);
-	n = find_get_pages_contig(op->store.mapping, first, nr, pages);
-	ASSERTCMP(n, ==, nr);
-
-	msg->msg_flags |= MSG_MORE;
-	for (i = 0; i < nr; i++) {
-		to = PAGE_SIZE;
-		if (first + i >= last) {
-			to = op->store.last_to;
-			msg->msg_flags &= ~MSG_MORE;
-		}
-		bv[i].bv_page = pages[i];
-		bv[i].bv_len = to - offset;
-		bv[i].bv_offset = offset;
-		bytes += to - offset;
-		offset = 0;
-	}
-
-	iov_iter_bvec(&msg->msg_iter, WRITE, bv, nr, bytes);
-}
-
 /*
  * Advance the AFS call state when the RxRPC call ends the transmit phase.
  */
@@ -317,42 +283,6 @@ static void afs_notify_end_request_tx(struct sock *sock,
 	afs_set_call_state(call, AFS_CALL_CL_REQUESTING, AFS_CALL_CL_AWAIT_REPLY);
 }
 
-/*
- * attach the data from a bunch of pages on an inode to a call
- */
-static int afs_send_pages(struct afs_call *call, struct msghdr *msg)
-{
-	struct afs_operation *op = call->op;
-	struct bio_vec bv[AFS_BVEC_MAX];
-	unsigned int bytes, nr, loop, offset;
-	pgoff_t first = op->store.first, last = op->store.last;
-	int ret;
-
-	offset = op->store.first_offset;
-	op->store.first_offset = 0;
-
-	do {
-		afs_load_bvec(call, msg, bv, first, last, offset);
-		trace_afs_send_pages(call, msg, first, last, offset);
-
-		offset = 0;
-		bytes = msg->msg_iter.count;
-		nr = msg->msg_iter.nr_segs;
-
-		ret = rxrpc_kernel_send_data(op->net->socket, call->rxcall, msg,
-					     bytes, afs_notify_end_request_tx);
-		for (loop = 0; loop < nr; loop++)
-			put_page(bv[loop].bv_page);
-		if (ret < 0)
-			break;
-
-		first += nr;
-	} while (first <= last);
-
-	trace_afs_sent_pages(call, op->store.first, last, first, ret);
-	return ret;
-}
-
 /*
  * Initiate a call and synchronously queue up the parameters for dispatch.  Any
  * error is stored into the call struct, which the caller must check for.
@@ -384,21 +314,8 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 	 * after the initial fixed part.
 	 */
 	tx_total_len = call->request_size;
-	if (call->send_pages) {
-		struct afs_operation *op = call->op;
-
-		if (op->store.last == op->store.first) {
-			tx_total_len += op->store.last_to - op->store.first_offset;
-		} else {
-			/* It looks mathematically like you should be able to
-			 * combine the following lines with the ones above, but
-			 * unsigned arithmetic is fun when it wraps...
-			 */
-			tx_total_len += PAGE_SIZE - op->store.first_offset;
-			tx_total_len += op->store.last_to;
-			tx_total_len += (op->store.last - op->store.first - 1) * PAGE_SIZE;
-		}
-	}
+	if (call->write_iter)
+		tx_total_len += iov_iter_count(call->write_iter);
 
 	/* If the call is going to be asynchronous, we need an extra ref for
 	 * the call to hold itself so the caller need not hang on to its ref.
@@ -440,7 +357,7 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 	iov_iter_kvec(&msg.msg_iter, WRITE, iov, 1, call->request_size);
 	msg.msg_control		= NULL;
 	msg.msg_controllen	= 0;
-	msg.msg_flags		= MSG_WAITALL | (call->send_pages ? MSG_MORE : 0);
+	msg.msg_flags		= MSG_WAITALL | (call->write_iter ? MSG_MORE : 0);
 
 	ret = rxrpc_kernel_send_data(call->net->socket, rxcall,
 				     &msg, call->request_size,
@@ -448,8 +365,18 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 	if (ret < 0)
 		goto error_do_abort;
 
-	if (call->send_pages) {
-		ret = afs_send_pages(call, &msg);
+	if (call->write_iter) {
+		msg.msg_iter = *call->write_iter;
+		msg.msg_flags &= ~MSG_MORE;
+		trace_afs_send_data(call, &msg);
+
+		ret = rxrpc_kernel_send_data(call->net->socket,
+					     call->rxcall, &msg,
+					     iov_iter_count(&msg.msg_iter),
+					     afs_notify_end_request_tx);
+		*call->write_iter = msg.msg_iter;
+
+		trace_afs_sent_data(call, &msg, ret);
 		if (ret < 0)
 			goto error_do_abort;
 	}
diff --git a/fs/afs/write.c b/fs/afs/write.c
index e78a9bc3b02d..dd4dc1c868b5 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -325,36 +325,27 @@ static void afs_redirty_pages(struct writeback_control *wbc,
 /*
  * completion of write to server
  */
-static void afs_pages_written_back(struct afs_vnode *vnode,
-				   pgoff_t first, pgoff_t last)
+static void afs_pages_written_back(struct afs_vnode *vnode, pgoff_t start, pgoff_t last)
 {
-	struct pagevec pv;
-	unsigned count, loop;
+	struct address_space *mapping = vnode->vfs_inode.i_mapping;
+	struct page *page;
+
+	XA_STATE(xas, &mapping->i_pages, start);
 
 	_enter("{%llx:%llu},{%lx-%lx}",
-	       vnode->fid.vid, vnode->fid.vnode, first, last);
+	       vnode->fid.vid, vnode->fid.vnode, start, last);
 
-	pagevec_init(&pv);
+	rcu_read_lock();
 
-	do {
-		_debug("done %lx-%lx", first, last);
+	xas_for_each(&xas, page, last) {
+		ASSERT(PageWriteback(page));
 
-		count = last - first + 1;
-		if (count > PAGEVEC_SIZE)
-			count = PAGEVEC_SIZE;
-		pv.nr = find_get_pages_contig(vnode->vfs_inode.i_mapping,
-					      first, count, pv.pages);
-		ASSERTCMP(pv.nr, ==, count);
+		detach_page_private(page);
+		trace_afs_page_dirty(vnode, tracepoint_string("clear"), page);
+		page_endio(page, true, 0);
+	}
 
-		for (loop = 0; loop < count; loop++) {
-			detach_page_private(pv.pages[loop]);
-			trace_afs_page_dirty(vnode, tracepoint_string("clear"),
-					     pv.pages[loop]);
-			end_page_writeback(pv.pages[loop]);
-		}
-		first += count;
-		__pagevec_release(&pv);
-	} while (first <= last);
+	rcu_read_unlock();
 
 	afs_prune_wb_keys(vnode);
 	_leave("");
@@ -411,9 +402,7 @@ static void afs_store_data_success(struct afs_operation *op)
 		if (!op->store.laundering)
 			afs_pages_written_back(vnode, op->store.first, op->store.last);
 		afs_stat_v(vnode, n_stores);
-		atomic_long_add((op->store.last * PAGE_SIZE + op->store.last_to) -
-				(op->store.first * PAGE_SIZE + op->store.first_offset),
-				&afs_v2net(vnode)->n_store_bytes);
+		atomic_long_add(op->store.size, &afs_v2net(vnode)->n_store_bytes);
 	}
 }
 
@@ -426,21 +415,21 @@ static const struct afs_operation_ops afs_store_data_operation = {
 /*
  * write to a file
  */
-static int afs_store_data(struct address_space *mapping,
-			  pgoff_t first, pgoff_t last,
-			  unsigned offset, unsigned to, bool laundering)
+static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter,
+			  loff_t pos, pgoff_t first, pgoff_t last,
+			  bool laundering)
 {
-	struct afs_vnode *vnode = AFS_FS_I(mapping->host);
 	struct afs_operation *op;
 	struct afs_wb_key *wbk = NULL;
-	int ret;
+	loff_t size = iov_iter_count(iter), i_size;
+	int ret = -ENOKEY;
 
-	_enter("%s{%llx:%llu.%u},%lx,%lx,%x,%x",
+	_enter("%s{%llx:%llu.%u},%llx,%llx",
 	       vnode->volume->name,
 	       vnode->fid.vid,
 	       vnode->fid.vnode,
 	       vnode->fid.unique,
-	       first, last, offset, to);
+	       size, pos);
 
 	ret = afs_get_writeback_key(vnode, &wbk);
 	if (ret) {
@@ -454,13 +443,16 @@ static int afs_store_data(struct address_space *mapping,
 		return -ENOMEM;
 	}
 
+	i_size = i_size_read(&vnode->vfs_inode);
+
 	afs_op_set_vnode(op, 0, vnode);
 	op->file[0].dv_delta = 1;
-	op->store.mapping = mapping;
+	op->store.write_iter = iter;
+	op->store.pos = pos;
 	op->store.first = first;
 	op->store.last = last;
-	op->store.first_offset = offset;
-	op->store.last_to = to;
+	op->store.size = size;
+	op->store.i_size = max(pos + size, i_size);
 	op->store.laundering = laundering;
 	op->mtime = vnode->vfs_inode.i_mtime;
 	op->flags |= AFS_OPERATION_UNINTR;
@@ -503,11 +495,12 @@ static int afs_write_back_from_locked_page(struct address_space *mapping,
 					   pgoff_t final_page)
 {
 	struct afs_vnode *vnode = AFS_FS_I(mapping->host);
+	struct iov_iter iter;
 	struct page *pages[8], *page;
 	unsigned long count, priv;
 	unsigned n, offset, to, f, t;
 	pgoff_t start, first, last;
-	loff_t i_size, end;
+	loff_t i_size, pos, end;
 	int loop, ret;
 
 	_enter(",%lx", primary_page->index);
@@ -604,15 +597,28 @@ static int afs_write_back_from_locked_page(struct address_space *mapping,
 
 	first = primary_page->index;
 	last = first + count - 1;
+	_debug("write back %lx[%u..] to %lx[..%u]", first, offset, last, to);
 
-	end = (loff_t)last * PAGE_SIZE + to;
-	i_size = i_size_read(&vnode->vfs_inode);
+	pos = first;
+	pos <<= PAGE_SHIFT;
+	pos += offset;
+	end = last;
+	end <<= PAGE_SHIFT;
+	end += to;
 
-	_debug("write back %lx[%u..] to %lx[..%u]", first, offset, last, to);
+	/* Trim the actual write down to the EOF */
+	i_size = i_size_read(&vnode->vfs_inode);
 	if (end > i_size)
-		to = i_size & ~PAGE_MASK;
+		end = i_size;
+
+	if (pos < i_size) {
+		iov_iter_xarray(&iter, WRITE, &mapping->i_pages, pos, end - pos);
+		ret = afs_store_data(vnode, &iter, pos, first, last, false);
+	} else {
+		/* The dirty region was entirely beyond the EOF. */
+		ret = 0;
+	}
 
-	ret = afs_store_data(mapping, first, last, offset, to, false);
 	switch (ret) {
 	case 0:
 		ret = count;
@@ -913,6 +919,8 @@ int afs_launder_page(struct page *page)
 {
 	struct address_space *mapping = page->mapping;
 	struct afs_vnode *vnode = AFS_FS_I(mapping->host);
+	struct iov_iter iter;
+	struct bio_vec bv[1];
 	unsigned long priv;
 	unsigned int f, t;
 	int ret = 0;
@@ -928,8 +936,14 @@ int afs_launder_page(struct page *page)
 			t = afs_page_dirty_to(page, priv);
 		}
 
+		bv[0].bv_page = page;
+		bv[0].bv_offset = f;
+		bv[0].bv_len = t - f;
+		iov_iter_bvec(&iter, WRITE, bv, 1, bv[0].bv_len);
+
 		trace_afs_page_dirty(vnode, tracepoint_string("launder"), page);
-		ret = afs_store_data(mapping, page->index, page->index, t, f, true);
+		ret = afs_store_data(vnode, &iter, (loff_t)page->index << PAGE_SHIFT,
+				     page->index, page->index, true);
 	}
 
 	detach_page_private(page);
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index abcec145db4b..363d6dd276c0 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -1078,25 +1078,15 @@ void yfs_fs_store_data(struct afs_operation *op)
 {
 	struct afs_vnode_param *vp = &op->file[0];
 	struct afs_call *call;
-	loff_t size, pos, i_size;
 	__be32 *bp;
 
 	_enter(",%x,{%llx:%llu},,",
 	       key_serial(op->key), vp->fid.vid, vp->fid.vnode);
 
-	size = (loff_t)op->store.last_to - (loff_t)op->store.first_offset;
-	if (op->store.first != op->store.last)
-		size += (loff_t)(op->store.last - op->store.first) << PAGE_SHIFT;
-	pos = (loff_t)op->store.first << PAGE_SHIFT;
-	pos += op->store.first_offset;
-
-	i_size = i_size_read(&vp->vnode->vfs_inode);
-	if (pos + size > i_size)
-		i_size = size + pos;
-
 	_debug("size %llx, at %llx, i_size %llx",
-	       (unsigned long long)size, (unsigned long long)pos,
-	       (unsigned long long)i_size);
+	       (unsigned long long)op->store.size,
+	       (unsigned long long)op->store.pos,
+	       (unsigned long long)op->store.i_size);
 
 	call = afs_alloc_flat_call(op->net, &yfs_RXYFSStoreData64,
 				   sizeof(__be32) +
@@ -1109,8 +1099,7 @@ void yfs_fs_store_data(struct afs_operation *op)
 	if (!call)
 		return afs_op_nomem(op);
 
-	call->key = op->key;
-	call->send_pages = true;
+	call->write_iter = op->store.write_iter;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -1118,9 +1107,9 @@ void yfs_fs_store_data(struct afs_operation *op)
 	bp = xdr_encode_u32(bp, 0); /* RPC flags */
 	bp = xdr_encode_YFSFid(bp, &vp->fid);
 	bp = xdr_encode_YFSStoreStatus_mtime(bp, &op->mtime);
-	bp = xdr_encode_u64(bp, pos);
-	bp = xdr_encode_u64(bp, size);
-	bp = xdr_encode_u64(bp, i_size);
+	bp = xdr_encode_u64(bp, op->store.pos);
+	bp = xdr_encode_u64(bp, op->store.size);
+	bp = xdr_encode_u64(bp, op->store.i_size);
 	yfs_check_req(call, bp);
 
 	trace_afs_make_fs_call(call, &vp->fid);
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 9203cf6a8c53..3ccf591b2374 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -886,65 +886,52 @@ TRACE_EVENT(afs_call_done,
 		      __entry->rx_call)
 	    );
 
-TRACE_EVENT(afs_send_pages,
-	    TP_PROTO(struct afs_call *call, struct msghdr *msg,
-		     pgoff_t first, pgoff_t last, unsigned int offset),
+TRACE_EVENT(afs_send_data,
+	    TP_PROTO(struct afs_call *call, struct msghdr *msg),
 
-	    TP_ARGS(call, msg, first, last, offset),
+	    TP_ARGS(call, msg),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		call		)
-		    __field(pgoff_t,			first		)
-		    __field(pgoff_t,			last		)
-		    __field(unsigned int,		nr		)
-		    __field(unsigned int,		bytes		)
-		    __field(unsigned int,		offset		)
 		    __field(unsigned int,		flags		)
+		    __field(loff_t,			offset		)
+		    __field(loff_t,			count		)
 			     ),
 
 	    TP_fast_assign(
 		    __entry->call = call->debug_id;
-		    __entry->first = first;
-		    __entry->last = last;
-		    __entry->nr = msg->msg_iter.nr_segs;
-		    __entry->bytes = msg->msg_iter.count;
-		    __entry->offset = offset;
 		    __entry->flags = msg->msg_flags;
+		    __entry->offset = msg->msg_iter.xarray_start + msg->msg_iter.iov_offset;
+		    __entry->count = iov_iter_count(&msg->msg_iter);
 			   ),
 
-	    TP_printk(" c=%08x %lx-%lx-%lx b=%x o=%x f=%x",
-		      __entry->call,
-		      __entry->first, __entry->first + __entry->nr - 1, __entry->last,
-		      __entry->bytes, __entry->offset,
+	    TP_printk(" c=%08x o=%llx n=%llx f=%x",
+		      __entry->call, __entry->offset, __entry->count,
 		      __entry->flags)
 	    );
 
-TRACE_EVENT(afs_sent_pages,
-	    TP_PROTO(struct afs_call *call, pgoff_t first, pgoff_t last,
-		     pgoff_t cursor, int ret),
+TRACE_EVENT(afs_sent_data,
+	    TP_PROTO(struct afs_call *call, struct msghdr *msg, int ret),
 
-	    TP_ARGS(call, first, last, cursor, ret),
+	    TP_ARGS(call, msg, ret),
 
 	    TP_STRUCT__entry(
 		    __field(unsigned int,		call		)
-		    __field(pgoff_t,			first		)
-		    __field(pgoff_t,			last		)
-		    __field(pgoff_t,			cursor		)
 		    __field(int,			ret		)
+		    __field(loff_t,			offset		)
+		    __field(loff_t,			count		)
 			     ),
 
 	    TP_fast_assign(
 		    __entry->call = call->debug_id;
-		    __entry->first = first;
-		    __entry->last = last;
-		    __entry->cursor = cursor;
 		    __entry->ret = ret;
+		    __entry->offset = msg->msg_iter.xarray_start + msg->msg_iter.iov_offset;
+		    __entry->count = iov_iter_count(&msg->msg_iter);
 			   ),
 
-	    TP_printk(" c=%08x %lx-%lx c=%lx r=%d",
-		      __entry->call,
-		      __entry->first, __entry->last,
-		      __entry->cursor, __entry->ret)
+	    TP_printk(" c=%08x o=%llx n=%llx r=%x",
+		      __entry->call, __entry->offset, __entry->count,
+		      __entry->ret)
 	    );
 
 TRACE_EVENT(afs_dir_check_failed,


