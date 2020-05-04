Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8331C4206
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 19:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbgEDRPf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 13:15:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21006 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730297AbgEDRP1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 13:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588612524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hrlT0PjbzBoswBZqkQ2vPZ5am0m8THRQms72LcX3AAU=;
        b=d0GgSkhhit/o6iN4NuxTMU/o1rzQmW/gtZ83dSsdPyi5Xi6RQbrnknwmSqfpJBakiU5Xwi
        SzVf9B5aNsoFTHlUPCR6yGZ+H63YbmWVyIhcGVy6bjwHeV9munF1WJH1gxB4veiZ4XmxWO
        /plsmdfPtyAp1X89nXs8prEyRRIrqJw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-q0L074ouM4KOudisPyweOw-1; Mon, 04 May 2020 13:15:18 -0400
X-MC-Unique: q0L074ouM4KOudisPyweOw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7EDC1800D4A;
        Mon,  4 May 2020 17:15:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 105D910013D9;
        Mon,  4 May 2020 17:15:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 51/61] afs: Use ITER_MAPPING for writing
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Jeff Layton <jlayton@redhat.com>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 04 May 2020 18:15:13 +0100
Message-ID: <158861251312.340223.17924900795425422532.stgit@warthog.procyon.org.uk>
In-Reply-To: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
References: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use a single ITER_MAPPING iterator to describe the portion of a file to be
transmitted to the server rather than generating a series of small
ITER_BVEC iterators on the fly.  This will make it easier to implement AIO
in afs.

In theory we could maybe use one giant ITER_BVEC, but that means
potentially allocating a huge array of bio_vec structs (max 256 per page)
when in fact the pagecache already has a structure listing all the relevant
pages (radix_tree/xarray) that can be walked over.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/fsclient.c          |   38 ++++-------------
 fs/afs/internal.h          |   18 +++-----
 fs/afs/rxrpc.c             |   99 +++++++-------------------------------------
 fs/afs/write.c             |   80 +++++++++++++++++++-----------------
 fs/afs/yfsclient.c         |   19 ++------
 include/trace/events/afs.h |   51 ++++++++---------------
 6 files changed, 96 insertions(+), 209 deletions(-)

diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 8222ccf01280..db80c2618778 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -1108,10 +1108,7 @@ static const struct afs_call_type afs_RXFSStoreData64 = {
 /*
  * store a set of pages to a very large file
  */
-static int afs_fs_store_data64(struct afs_fs_cursor *fc,
-			       struct address_space *mapping,
-			       pgoff_t first, pgoff_t last,
-			       unsigned offset, unsigned to,
+static int afs_fs_store_data64(struct afs_fs_cursor *fc, struct iov_iter *iter,
 			       loff_t size, loff_t pos, loff_t i_size,
 			       struct afs_status_cb *scb)
 {
@@ -1130,12 +1127,7 @@ static int afs_fs_store_data64(struct afs_fs_cursor *fc,
 		return -ENOMEM;
 
 	call->key = fc->key;
-	call->mapping = mapping;
-	call->first = first;
-	call->last = last;
-	call->first_offset = offset;
-	call->last_to = to;
-	call->send_pages = true;
+	call->write_iter = iter;
 	call->out_scb = scb;
 
 	/* marshall the parameters */
@@ -1166,30 +1158,24 @@ static int afs_fs_store_data64(struct afs_fs_cursor *fc,
 }
 
 /*
- * store a set of pages
+ * Write data to a file on the server.
  */
-int afs_fs_store_data(struct afs_fs_cursor *fc, struct address_space *mapping,
-		      pgoff_t first, pgoff_t last,
-		      unsigned offset, unsigned to,
+int afs_fs_store_data(struct afs_fs_cursor *fc, struct iov_iter *iter, loff_t pos,
 		      struct afs_status_cb *scb)
 {
 	struct afs_vnode *vnode = fc->vnode;
 	struct afs_call *call;
 	struct afs_net *net = afs_v2net(vnode);
-	loff_t size, pos, i_size;
+	loff_t size, i_size;
 	__be32 *bp;
 
 	if (test_bit(AFS_SERVER_FL_IS_YFS, &fc->cbi->server->flags))
-		return yfs_fs_store_data(fc, mapping, first, last, offset, to, scb);
+		return yfs_fs_store_data(fc, iter, pos, scb);
 
 	_enter(",%x,{%llx:%llu},,",
 	       key_serial(fc->key), vnode->fid.vid, vnode->fid.vnode);
 
-	size = (loff_t)to - (loff_t)offset;
-	if (first != last)
-		size += (loff_t)(last - first) << PAGE_SHIFT;
-	pos = (loff_t)first << PAGE_SHIFT;
-	pos += offset;
+	size = iov_iter_count(iter);
 
 	i_size = i_size_read(&vnode->vfs_inode);
 	if (pos + size > i_size)
@@ -1200,8 +1186,7 @@ int afs_fs_store_data(struct afs_fs_cursor *fc, struct address_space *mapping,
 	       (unsigned long long) i_size);
 
 	if (pos >> 32 || i_size >> 32 || size >> 32 || (pos + size) >> 32)
-		return afs_fs_store_data64(fc, mapping, first, last, offset, to,
-					   size, pos, i_size, scb);
+		return afs_fs_store_data64(fc, iter, size, pos, i_size, scb);
 
 	call = afs_alloc_flat_call(net, &afs_RXFSStoreData,
 				   (4 + 6 + 3) * 4,
@@ -1210,12 +1195,7 @@ int afs_fs_store_data(struct afs_fs_cursor *fc, struct address_space *mapping,
 		return -ENOMEM;
 
 	call->key = fc->key;
-	call->mapping = mapping;
-	call->first = first;
-	call->last = last;
-	call->first_offset = offset;
-	call->last_to = to;
-	call->send_pages = true;
+	call->write_iter = iter;
 	call->out_scb = scb;
 
 	/* marshall the parameters */
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index e676ad145272..0cd9e998d52c 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -118,6 +118,7 @@ struct afs_call {
 	struct address_space	*mapping;	/* Pages being written from */
 	size_t			iov_len;	/* Size of *iter to be used */
 	struct iov_iter		def_iter;	/* Default buffer/data iterator */
+	struct iov_iter		*write_iter;	/* Iterator defining write to be made */
 	struct iov_iter		*iter;		/* Iterator currently in use */
 	union {	/* Convenience for ->def_iter */
 		struct kvec	kvec[1];
@@ -138,8 +139,6 @@ struct afs_call {
 	struct afs_volume_status *out_volstatus;
 	struct afs_read		*read_request;
 	unsigned int		server_index;
-	pgoff_t			first;		/* first page in mapping to deal with */
-	pgoff_t			last;		/* last page in mapping to deal with */
 	atomic_t		usage;
 	enum afs_call_state	state;
 	spinlock_t		state_lock;
@@ -149,15 +148,10 @@ struct afs_call {
 	unsigned int		max_lifespan;	/* Maximum lifespan to set if not 0 */
 	unsigned		request_size;	/* size of request data */
 	unsigned		reply_max;	/* maximum size of reply */
-	unsigned		first_offset;	/* offset into mapping[first] */
-	union {
-		unsigned	last_to;	/* amount of mapping[last] */
-		unsigned	count2;		/* count used in unmarshalling */
-	};
+	unsigned		count2;		/* count used in unmarshalling */
 	unsigned char		unmarshall;	/* unmarshalling phase */
 	unsigned char		addr_ix;	/* Address in ->alist */
 	bool			drop_ref;	/* T if need to drop ref for incoming call */
-	bool			send_pages;	/* T if data from mapping should be sent */
 	bool			need_attention;	/* T if RxRPC poked us */
 	bool			async;		/* T if asynchronous */
 	bool			upgrade;	/* T to request service upgrade */
@@ -962,8 +956,8 @@ extern int afs_fs_symlink(struct afs_fs_cursor *, const char *, const char *,
 extern int afs_fs_rename(struct afs_fs_cursor *, const char *,
 			 struct afs_vnode *, const char *,
 			 struct afs_status_cb *, struct afs_status_cb *);
-extern int afs_fs_store_data(struct afs_fs_cursor *, struct address_space *,
-			     pgoff_t, pgoff_t, unsigned, unsigned, struct afs_status_cb *);
+extern int afs_fs_store_data(struct afs_fs_cursor *, struct iov_iter *, loff_t,
+			     struct afs_status_cb *);
 extern int afs_fs_setattr(struct afs_fs_cursor *, struct iattr *, struct afs_status_cb *);
 extern int afs_fs_get_volume_status(struct afs_fs_cursor *, struct afs_volume_status *);
 extern int afs_fs_set_lock(struct afs_fs_cursor *, afs_lock_type_t, struct afs_status_cb *);
@@ -1378,8 +1372,8 @@ extern int yfs_fs_symlink(struct afs_fs_cursor *, const char *, const char *,
 			  struct afs_status_cb *, struct afs_fid *, struct afs_status_cb *);
 extern int yfs_fs_rename(struct afs_fs_cursor *, const char *, struct afs_vnode *, const char *,
 			 struct afs_status_cb *, struct afs_status_cb *);
-extern int yfs_fs_store_data(struct afs_fs_cursor *, struct address_space *,
-			     pgoff_t, pgoff_t, unsigned, unsigned, struct afs_status_cb *);
+extern int yfs_fs_store_data(struct afs_fs_cursor *, struct iov_iter *, loff_t,
+			     struct afs_status_cb *);
 extern int yfs_fs_setattr(struct afs_fs_cursor *, struct iattr *, struct afs_status_cb *);
 extern int yfs_fs_get_volume_status(struct afs_fs_cursor *, struct afs_volume_status *);
 extern int yfs_fs_set_lock(struct afs_fs_cursor *, afs_lock_type_t, struct afs_status_cb *);
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index b2296feaaff3..98da499232a3 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -274,39 +274,6 @@ void afs_flat_call_destructor(struct afs_call *call)
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
-	struct page *pages[AFS_BVEC_MAX];
-	unsigned int nr, n, i, to, bytes = 0;
-
-	nr = min_t(pgoff_t, last - first + 1, AFS_BVEC_MAX);
-	n = find_get_pages_contig(call->mapping, first, nr, pages);
-	ASSERTCMP(n, ==, nr);
-
-	msg->msg_flags |= MSG_MORE;
-	for (i = 0; i < nr; i++) {
-		to = PAGE_SIZE;
-		if (first + i >= last) {
-			to = call->last_to;
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
@@ -319,41 +286,6 @@ static void afs_notify_end_request_tx(struct sock *sock,
 	afs_set_call_state(call, AFS_CALL_CL_REQUESTING, AFS_CALL_CL_AWAIT_REPLY);
 }
 
-/*
- * attach the data from a bunch of pages on an inode to a call
- */
-static int afs_send_pages(struct afs_call *call, struct msghdr *msg)
-{
-	struct bio_vec bv[AFS_BVEC_MAX];
-	unsigned int bytes, nr, loop, offset;
-	pgoff_t first = call->first, last = call->last;
-	int ret;
-
-	offset = call->first_offset;
-	call->first_offset = 0;
-
-	do {
-		afs_load_bvec(call, msg, bv, first, last, offset);
-		trace_afs_send_pages(call, msg, first, last, offset);
-
-		offset = 0;
-		bytes = msg->msg_iter.count;
-		nr = msg->msg_iter.nr_segs;
-
-		ret = rxrpc_kernel_send_data(call->net->socket, call->rxcall, msg,
-					     bytes, afs_notify_end_request_tx);
-		for (loop = 0; loop < nr; loop++)
-			put_page(bv[loop].bv_page);
-		if (ret < 0)
-			break;
-
-		first += nr;
-	} while (first <= last);
-
-	trace_afs_sent_pages(call, call->first, last, first, ret);
-	return ret;
-}
-
 /*
  * Initiate a call and synchronously queue up the parameters for dispatch.  Any
  * error is stored into the call struct, which the caller must check for.
@@ -385,19 +317,8 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 	 * after the initial fixed part.
 	 */
 	tx_total_len = call->request_size;
-	if (call->send_pages) {
-		if (call->last == call->first) {
-			tx_total_len += call->last_to - call->first_offset;
-		} else {
-			/* It looks mathematically like you should be able to
-			 * combine the following lines with the ones above, but
-			 * unsigned arithmetic is fun when it wraps...
-			 */
-			tx_total_len += PAGE_SIZE - call->first_offset;
-			tx_total_len += call->last_to;
-			tx_total_len += (call->last - call->first - 1) * PAGE_SIZE;
-		}
-	}
+	if (call->write_iter)
+		tx_total_len += iov_iter_count(call->write_iter);
 
 	/* If the call is going to be asynchronous, we need an extra ref for
 	 * the call to hold itself so the caller need not hang on to its ref.
@@ -439,7 +360,7 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 	iov_iter_kvec(&msg.msg_iter, WRITE, iov, 1, call->request_size);
 	msg.msg_control		= NULL;
 	msg.msg_controllen	= 0;
-	msg.msg_flags		= MSG_WAITALL | (call->send_pages ? MSG_MORE : 0);
+	msg.msg_flags		= MSG_WAITALL | (call->write_iter ? MSG_MORE : 0);
 
 	ret = rxrpc_kernel_send_data(call->net->socket, rxcall,
 				     &msg, call->request_size,
@@ -447,8 +368,18 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
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
index 174e355aee6d..44dd4d0bad70 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -311,38 +311,30 @@ static void afs_redirty_pages(struct writeback_control *wbc,
 /*
  * completion of write to server
  */
-static void afs_pages_written_back(struct afs_vnode *vnode,
-				   pgoff_t first, pgoff_t last)
+static void afs_pages_written_back(struct afs_vnode *vnode, pgoff_t start, pgoff_t last)
 {
-	struct pagevec pv;
+	struct address_space *mapping = vnode->vfs_inode.i_mapping;
+	struct page *page;
 	unsigned long priv;
-	unsigned count, loop;
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
+		priv = page_private(page);
+		trace_afs_page_dirty(vnode, tracepoint_string("clear"),
+				     page->index, priv);
+		set_page_private(page, 0);
+		page_endio(page, true, 0);
+	}
 
-		for (loop = 0; loop < count; loop++) {
-			priv = page_private(pv.pages[loop]);
-			trace_afs_page_dirty(vnode, tracepoint_string("clear"),
-					     pv.pages[loop]->index, priv);
-			set_page_private(pv.pages[loop], 0);
-			end_page_writeback(pv.pages[loop]);
-		}
-		first += count;
-		__pagevec_release(&pv);
-	} while (first <= last);
+	rcu_read_unlock();
 
 	afs_prune_wb_keys(vnode);
 	_leave("");
@@ -351,23 +343,22 @@ static void afs_pages_written_back(struct afs_vnode *vnode,
 /*
  * write to a file
  */
-static int afs_store_data(struct address_space *mapping,
-			  pgoff_t first, pgoff_t last,
-			  unsigned offset, unsigned to)
+static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter,
+			  loff_t pos, pgoff_t first, pgoff_t last)
 {
-	struct afs_vnode *vnode = AFS_FS_I(mapping->host);
 	struct afs_fs_cursor fc;
 	struct afs_status_cb *scb;
 	struct afs_wb_key *wbk = NULL;
 	struct list_head *p;
+	loff_t count = iov_iter_count(iter);
 	int ret = -ENOKEY, ret2;
 
-	_enter("%s{%llx:%llu.%u},%lx,%lx,%x,%x",
+	_enter("%s{%llx:%llu.%u},%llx,%llx",
 	       vnode->volume->name,
 	       vnode->fid.vid,
 	       vnode->fid.vnode,
 	       vnode->fid.unique,
-	       first, last, offset, to);
+	       count, pos);
 
 	scb = kzalloc(sizeof(struct afs_status_cb), GFP_NOFS);
 	if (!scb)
@@ -407,7 +398,7 @@ static int afs_store_data(struct address_space *mapping,
 
 		while (afs_select_fileserver(&fc)) {
 			fc.cb_break = afs_calc_vnode_cb_break(vnode);
-			afs_fs_store_data(&fc, mapping, first, last, offset, to, scb);
+			afs_fs_store_data(&fc, iter, pos, scb);
 		}
 
 		afs_check_for_remote_deletion(&fc, vnode);
@@ -421,9 +412,7 @@ static int afs_store_data(struct address_space *mapping,
 	switch (ret) {
 	case 0:
 		afs_stat_v(vnode, n_stores);
-		atomic_long_add((last * PAGE_SIZE + to) -
-				(first * PAGE_SIZE + offset),
-				&afs_v2net(vnode)->n_store_bytes);
+		atomic_long_add(count, &afs_v2net(vnode)->n_store_bytes);
 		break;
 	case -EACCES:
 	case -EPERM:
@@ -454,10 +443,12 @@ static int afs_write_back_from_locked_page(struct address_space *mapping,
 					   pgoff_t final_page)
 {
 	struct afs_vnode *vnode = AFS_FS_I(mapping->host);
+	struct iov_iter iter;
 	struct page *pages[8], *page;
 	unsigned long count, priv;
 	unsigned n, offset, to, f, t;
 	pgoff_t start, first, last;
+	loff_t a, b;
 	int loop, ret;
 
 	_enter(",%lx", primary_page->index);
@@ -557,10 +548,17 @@ static int afs_write_back_from_locked_page(struct address_space *mapping,
 
 	first = primary_page->index;
 	last = first + count - 1;
-
 	_debug("write back %lx[%u..] to %lx[..%u]", first, offset, last, to);
 
-	ret = afs_store_data(mapping, first, last, offset, to);
+	a = first;
+	a <<= PAGE_SHIFT;
+	a += offset;
+	b = last;
+	b <<= PAGE_SHIFT;
+	b += to;
+	iov_iter_mapping(&iter, WRITE, mapping, a, b - a);
+
+	ret = afs_store_data(vnode, &iter, a, first, last);
 	switch (ret) {
 	case 0:
 		ret = count;
@@ -848,6 +846,8 @@ int afs_launder_page(struct page *page)
 {
 	struct address_space *mapping = page->mapping;
 	struct afs_vnode *vnode = AFS_FS_I(mapping->host);
+	struct iov_iter iter;
+	struct bio_vec bv[1];
 	unsigned long priv;
 	unsigned int f, t;
 	int ret = 0;
@@ -863,9 +863,15 @@ int afs_launder_page(struct page *page)
 			t = priv >> AFS_PRIV_SHIFT;
 		}
 
+		bv[0].bv_page = page;
+		bv[0].bv_offset = f;
+		bv[0].bv_len = t - f;
+		iov_iter_bvec(&iter, WRITE, bv, 1, bv[0].bv_len);
+
 		trace_afs_page_dirty(vnode, tracepoint_string("launder"),
 				     page->index, priv);
-		ret = afs_store_data(mapping, page->index, page->index, t, f);
+		ret = afs_store_data(vnode, &iter, (loff_t)page->index << PAGE_SHIFT,
+				     page->index, page->index);
 	}
 
 	trace_afs_page_dirty(vnode, tracepoint_string("laundered"),
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 518b9489ff9e..0b744a117dde 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -1216,25 +1216,19 @@ static const struct afs_call_type yfs_RXYFSStoreData64 = {
 /*
  * Store a set of pages to a large file.
  */
-int yfs_fs_store_data(struct afs_fs_cursor *fc, struct address_space *mapping,
-		      pgoff_t first, pgoff_t last,
-		      unsigned offset, unsigned to,
+int yfs_fs_store_data(struct afs_fs_cursor *fc, struct iov_iter *iter, loff_t pos,
 		      struct afs_status_cb *scb)
 {
 	struct afs_vnode *vnode = fc->vnode;
 	struct afs_call *call;
 	struct afs_net *net = afs_v2net(vnode);
-	loff_t size, pos, i_size;
+	loff_t size, i_size;
 	__be32 *bp;
 
 	_enter(",%x,{%llx:%llu},,",
 	       key_serial(fc->key), vnode->fid.vid, vnode->fid.vnode);
 
-	size = (loff_t)to - (loff_t)offset;
-	if (first != last)
-		size += (loff_t)(last - first) << PAGE_SHIFT;
-	pos = (loff_t)first << PAGE_SHIFT;
-	pos += offset;
+	size = iov_iter_count(iter);
 
 	i_size = i_size_read(&vnode->vfs_inode);
 	if (pos + size > i_size)
@@ -1256,12 +1250,7 @@ int yfs_fs_store_data(struct afs_fs_cursor *fc, struct address_space *mapping,
 		return -ENOMEM;
 
 	call->key = fc->key;
-	call->mapping = mapping;
-	call->first = first;
-	call->last = last;
-	call->first_offset = offset;
-	call->last_to = to;
-	call->send_pages = true;
+	call->write_iter = iter;
 	call->out_scb = scb;
 
 	/* marshall the parameters */
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index c612cabbc378..f663cd482abb 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -762,65 +762,52 @@ TRACE_EVENT(afs_call_done,
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
+		    __entry->offset = msg->msg_iter.iov_offset;
+		    __entry->count = iov_iter_count(&msg->msg_iter);
 			   ),
 
-	    TP_printk(" c=%08x %lx-%lx-%lx b=%x o=%x f=%x",
-		      __entry->call,
-		      __entry->first, __entry->first + __entry->nr - 1, __entry->last,
-		      __entry->bytes, __entry->offset,
+	    TP_printk(" c=%08x o=%llx c=%llx f=%x",
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
+		    __entry->offset = msg->msg_iter.iov_offset;
+		    __entry->count = iov_iter_count(&msg->msg_iter);
 			   ),
 
-	    TP_printk(" c=%08x %lx-%lx c=%lx r=%d",
-		      __entry->call,
-		      __entry->first, __entry->last,
-		      __entry->cursor, __entry->ret)
+	    TP_printk(" c=%08x o=%llx c=%llx r=%d",
+		      __entry->call, __entry->offset, __entry->count,
+		      __entry->ret)
 	    );
 
 TRACE_EVENT(afs_dir_check_failed,


