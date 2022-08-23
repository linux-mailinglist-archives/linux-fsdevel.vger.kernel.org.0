Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A659559E851
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 19:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245717AbiHWRBq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 13:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343827AbiHWRA0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:00:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0F32E6B2
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Aug 2022 07:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661263968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SSidJ/gIoljhIMpC39sg89E2hTrzuRBHjJOoTCp1BmE=;
        b=bJjN1OmkHg7TcnxPzcTc3rBtqj6mxrpAZqpbwycSgk9vx45NdYewC8qQeEm32rutH9hMmA
        52PpAb6qasecT+tqc8myapg/PJnqKh0uU8wOAEpn+SaIQcob5YZlWbfrQRm2GKgUmVRiYx
        CWraY1BUCVefybWAvE01+0pWHecevBI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-tGi4BJvfOpmIoVCGG8h1dQ-1; Tue, 23 Aug 2022 10:12:44 -0400
X-MC-Unique: tGi4BJvfOpmIoVCGG8h1dQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01EF885A58E;
        Tue, 23 Aug 2022 14:12:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64E032166B26;
        Tue, 23 Aug 2022 14:12:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 5/7] cifs: Change the I/O paths to use an iterator rather than
 a page list
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        linux-cifs@vger.kernel.org, dhowells@redhat.com,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 23 Aug 2022 15:12:41 +0100
Message-ID: <166126396180.708021.271013668175370826.stgit@warthog.procyon.org.uk>
In-Reply-To: <166126392703.708021.14465850073772688008.stgit@warthog.procyon.org.uk>
References: <166126392703.708021.14465850073772688008.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, the cifs I/O paths hand lists of pages from the VM interface
routines at the top all the way through the intervening layers to the
socket interface at the bottom.

This is a problem, however, for interfacing with netfslib which passes an
iterator through to the ->issue_read() method (and will pass an iterator
through to the ->issue_write() method in future).  Netfslib takes over
bounce buffering for direct I/O, async I/O and encrypted content, so cifs
doesn't need to do that.  Netfslib also converts iovec-class iterators into
bvec-class iterators if necessary.

Further, cifs needs foliating - and folios may come in a variety of sizes,
so a page list pointing to an array of heterogeneous pages may cause
problems in places such as where crypto is done.

Change the cifs I/O paths to hand iov_iter iterators all the way through
instead.

Notes:

 (1) Some old routines are #if'd out to be removed in a follow up patch so
     as to avoid confusing diff, thereby making the diff output easier to
     follow.  I've removed functions that don't overlap with anything
     added.

 (2) struct smb_rqst loses rq_pages, rq_offset, rq_npages, rq_pagesz and
     rq_tailsz which describe the pages forming the buffer; instead there's
     an rq_iter describing the source buffer and an rq_buffer which is used
     to hold the buffer for encryption.

 (3) struct cifs_readdata and cifs_writedata are similarly modified to
     smb_rqst.  The ->read_into_pages() and ->copy_into_pages() are then
     replaced with passing the iterator directly to the socket.

     The iterators are stored in these structs so that they are persistent
     and don't get deallocated when the function returns (unlike if they
     were stack variables).

 (4) Buffered writeback is overhauled, borrowing the code from the afs
     filesystem to gather up contiguous runs of folios.  The xarray-class
     iterator is then used to refer directly to the pagecache and can be
     passed to the socket to transmit data directly from there.

     This includes:

	cifs_extend_writeback()
	cifs_write_back_from_locked_folio()
	cifs_writepages_region()
	cifs_writepages()

 (5) Pages are converted to folios.

 (6) Direct I/O uses extract_iter_to_iter() to create a bvec-class iterator
     from the source iterator.

 (7) init_sg() uses iov_iter_scan() to iterate over the iterator and fill
     out the scatterlists that the crypto layer prefers.

 (8) smb2_init_transform_rq() attached pages to smb_rqst::rq_buffer, an
     xarray, to use as a bounce buffer for encryption.  An xarray-class
     iterator can then be used to pass the bounce buffer to lower layers.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: linux-cifs@vger.kernel.org

fixes

fixes
---

 fs/cifs/cifsencrypt.c |   40 +-
 fs/cifs/cifsglob.h    |   28 -
 fs/cifs/cifsproto.h   |    8 
 fs/cifs/cifssmb.c     |   13 -
 fs/cifs/file.c        | 1138 ++++++++++++++++++++++++++++++-------------------
 fs/cifs/fscache.c     |   22 -
 fs/cifs/fscache.h     |   10 
 fs/cifs/misc.c        |  108 -----
 fs/cifs/smb2ops.c     |  369 ++++++++--------
 fs/cifs/smb2pdu.c     |   44 +-
 fs/cifs/smbdirect.c   |  326 ++++++--------
 fs/cifs/smbdirect.h   |    4 
 fs/cifs/transport.c   |   54 +-
 13 files changed, 1091 insertions(+), 1073 deletions(-)

diff --git a/fs/cifs/cifsencrypt.c b/fs/cifs/cifsencrypt.c
index 8f7835ccbca1..fc204f7a8057 100644
--- a/fs/cifs/cifsencrypt.c
+++ b/fs/cifs/cifsencrypt.c
@@ -24,12 +24,27 @@
 #include "../smbfs_common/arc4.h"
 #include <crypto/aead.h>
 
+static ssize_t cifs_signature_scan(struct iov_iter *i, const void *p,
+				   size_t len, size_t off, void *priv)
+{
+	struct shash_desc *shash = priv;
+	int rc;
+
+	rc = crypto_shash_update(shash, p, len);
+	if (rc) {
+		cifs_dbg(VFS, "%s: Could not update with payload\n", __func__);
+		return rc;
+	}
+
+	return len;
+}
+
 int __cifs_calc_signature(struct smb_rqst *rqst,
 			struct TCP_Server_Info *server, char *signature,
 			struct shash_desc *shash)
 {
 	int i;
-	int rc;
+	ssize_t rc;
 	struct kvec *iov = rqst->rq_iov;
 	int n_vec = rqst->rq_nvec;
 	int is_smb2 = server->vals->header_preamble_size == 0;
@@ -62,25 +77,10 @@ int __cifs_calc_signature(struct smb_rqst *rqst,
 		}
 	}
 
-	/* now hash over the rq_pages array */
-	for (i = 0; i < rqst->rq_npages; i++) {
-		void *kaddr;
-		unsigned int len, offset;
-
-		rqst_page_get_length(rqst, i, &len, &offset);
-
-		kaddr = (char *) kmap(rqst->rq_pages[i]) + offset;
-
-		rc = crypto_shash_update(shash, kaddr, len);
-		if (rc) {
-			cifs_dbg(VFS, "%s: Could not update with payload\n",
-				 __func__);
-			kunmap(rqst->rq_pages[i]);
-			return rc;
-		}
-
-		kunmap(rqst->rq_pages[i]);
-	}
+	rc = iov_iter_scan(&rqst->rq_iter, iov_iter_count(&rqst->rq_iter),
+			   cifs_signature_scan, shash);
+	if (rc < 0)
+		return rc;
 
 	rc = crypto_shash_final(shash, signature);
 	if (rc)
diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index f15d7b0c123d..41d2355a3360 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -210,11 +210,8 @@ struct cifs_cred {
 struct smb_rqst {
 	struct kvec	*rq_iov;	/* array of kvecs */
 	unsigned int	rq_nvec;	/* number of kvecs in array */
-	struct page	**rq_pages;	/* pointer to array of page ptrs */
-	unsigned int	rq_offset;	/* the offset to the 1st page */
-	unsigned int	rq_npages;	/* number pages in array */
-	unsigned int	rq_pagesz;	/* page size to use */
-	unsigned int	rq_tailsz;	/* length of last page */
+	struct iov_iter	rq_iter;	/* Data iterator */
+	struct xarray	rq_buffer;	/* Page buffer for encryption */
 };
 
 struct mid_q_entry;
@@ -1432,28 +1429,18 @@ struct cifs_readdata {
 	struct address_space		*mapping;
 	struct cifs_aio_ctx		*ctx;
 	__u64				offset;
+	ssize_t				got_bytes;
 	unsigned int			bytes;
-	unsigned int			got_bytes;
 	pid_t				pid;
 	int				result;
 	struct work_struct		work;
-	int (*read_into_pages)(struct TCP_Server_Info *server,
-				struct cifs_readdata *rdata,
-				unsigned int len);
-	int (*copy_into_pages)(struct TCP_Server_Info *server,
-				struct cifs_readdata *rdata,
-				struct iov_iter *iter);
+	struct iov_iter			iter;
 	struct kvec			iov[2];
 	struct TCP_Server_Info		*server;
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	struct smbd_mr			*mr;
 #endif
-	unsigned int			pagesz;
-	unsigned int			page_offset;
-	unsigned int			tailsz;
 	struct cifs_credits		credits;
-	unsigned int			nr_pages;
-	struct page			**pages;
 };
 
 /* asynchronous write support */
@@ -1465,6 +1452,8 @@ struct cifs_writedata {
 	struct work_struct		work;
 	struct cifsFileInfo		*cfile;
 	struct cifs_aio_ctx		*ctx;
+	struct iov_iter			iter;
+	struct bio_vec			*bv;
 	__u64				offset;
 	pid_t				pid;
 	unsigned int			bytes;
@@ -1473,12 +1462,7 @@ struct cifs_writedata {
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	struct smbd_mr			*mr;
 #endif
-	unsigned int			pagesz;
-	unsigned int			page_offset;
-	unsigned int			tailsz;
 	struct cifs_credits		credits;
-	unsigned int			nr_pages;
-	struct page			**pages;
 };
 
 /*
diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index ba19f9b03fc6..1c721655dc93 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -579,10 +579,7 @@ int cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid);
 int cifs_async_writev(struct cifs_writedata *wdata,
 		      void (*release)(struct kref *kref));
 void cifs_writev_complete(struct work_struct *work);
-struct cifs_writedata *cifs_writedata_alloc(unsigned int nr_pages,
-						work_func_t complete);
-struct cifs_writedata *cifs_writedata_direct_alloc(struct page **pages,
-						work_func_t complete);
+struct cifs_writedata *cifs_writedata_alloc(work_func_t complete);
 void cifs_writedata_release(struct kref *refcount);
 int cifs_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 			  struct cifs_sb_info *cifs_sb,
@@ -599,14 +596,11 @@ enum securityEnum cifs_select_sectype(struct TCP_Server_Info *,
 					enum securityEnum);
 struct cifs_aio_ctx *cifs_aio_ctx_alloc(void);
 void cifs_aio_ctx_release(struct kref *refcount);
-int setup_aio_ctx_iter(struct cifs_aio_ctx *ctx, struct iov_iter *iter, int rw);
 
 int cifs_alloc_hash(const char *name, struct crypto_shash **shash,
 		    struct sdesc **sdesc);
 void cifs_free_hash(struct crypto_shash **shash, struct sdesc **sdesc);
 
-extern void rqst_page_get_length(struct smb_rqst *rqst, unsigned int page,
-				unsigned int *len, unsigned int *offset);
 struct cifs_chan *
 cifs_ses_find_chan(struct cifs_ses *ses, struct TCP_Server_Info *server);
 int cifs_try_adding_channels(struct cifs_sb_info *cifs_sb, struct cifs_ses *ses);
diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 7aa91e272027..5aed4bd825f0 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -24,6 +24,7 @@
 #include <linux/task_io_accounting_ops.h>
 #include <linux/uaccess.h>
 #include "cifspdu.h"
+#include "cifsfs.h"
 #include "cifsglob.h"
 #include "cifsacl.h"
 #include "cifsproto.h"
@@ -1294,11 +1295,7 @@ cifs_readv_callback(struct mid_q_entry *mid)
 	struct TCP_Server_Info *server = tcon->ses->server;
 	struct smb_rqst rqst = { .rq_iov = rdata->iov,
 				 .rq_nvec = 2,
-				 .rq_pages = rdata->pages,
-				 .rq_offset = rdata->page_offset,
-				 .rq_npages = rdata->nr_pages,
-				 .rq_pagesz = rdata->pagesz,
-				 .rq_tailsz = rdata->tailsz };
+				 .rq_iter = rdata->iter };
 	struct cifs_credits credits = { .value = 1, .instance = 0 };
 
 	cifs_dbg(FYI, "%s: mid=%llu state=%d result=%d bytes=%u\n",
@@ -1737,11 +1734,7 @@ cifs_async_writev(struct cifs_writedata *wdata,
 
 	rqst.rq_iov = iov;
 	rqst.rq_nvec = 2;
-	rqst.rq_pages = wdata->pages;
-	rqst.rq_offset = wdata->page_offset;
-	rqst.rq_npages = wdata->nr_pages;
-	rqst.rq_pagesz = wdata->pagesz;
-	rqst.rq_tailsz = wdata->tailsz;
+	rqst.rq_iter = wdata->iter;
 
 	cifs_dbg(FYI, "async write at %llu %u bytes\n",
 		 wdata->offset, wdata->bytes);
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 6dfd96715274..6503a556e42c 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -36,6 +36,32 @@
 #include "cifs_ioctl.h"
 #include "cached_dir.h"
 
+/*
+ * Remove the dirty flags from a span of pages.
+ */
+static void cifs_undirty_folios(struct inode *inode, loff_t start, unsigned int len)
+{
+	struct address_space *mapping = inode->i_mapping;
+	struct folio *folio;
+	pgoff_t end;
+
+	XA_STATE(xas, &mapping->i_pages, start / PAGE_SIZE);
+
+	rcu_read_lock();
+
+	end = (start + len - 1) / PAGE_SIZE;
+	xas_for_each_marked(&xas, folio, end, PAGECACHE_TAG_DIRTY) {
+		xas_pause(&xas);
+		rcu_read_unlock();
+		folio_lock(folio);
+		folio_clear_dirty_for_io(folio);
+		folio_unlock(folio);
+		rcu_read_lock();
+	}
+
+	rcu_read_unlock();
+}
+
 /*
  * Completion of write to server.
  */
@@ -2382,7 +2408,6 @@ cifs_writedata_release(struct kref *refcount)
 	if (wdata->cfile)
 		cifsFileInfo_put(wdata->cfile);
 
-	kvfree(wdata->pages);
 	kfree(wdata);
 }
 
@@ -2393,51 +2418,49 @@ cifs_writedata_release(struct kref *refcount)
 static void
 cifs_writev_requeue(struct cifs_writedata *wdata)
 {
-	int i, rc = 0;
+	int rc = 0;
 	struct inode *inode = d_inode(wdata->cfile->dentry);
 	struct TCP_Server_Info *server;
-	unsigned int rest_len;
+	unsigned int rest_len = wdata->bytes;
+	loff_t fpos = wdata->offset;
 
 	server = tlink_tcon(wdata->cfile->tlink)->ses->server;
-	i = 0;
-	rest_len = wdata->bytes;
 	do {
 		struct cifs_writedata *wdata2;
-		unsigned int j, nr_pages, wsize, tailsz, cur_len;
+		unsigned int wsize, cur_len;
 
 		wsize = server->ops->wp_retry_size(inode);
 		if (wsize < rest_len) {
-			nr_pages = wsize / PAGE_SIZE;
-			if (!nr_pages) {
-				rc = -EOPNOTSUPP;
+			if (wsize < PAGE_SIZE) {
+				rc = -ENOTSUPP;
 				break;
 			}
-			cur_len = nr_pages * PAGE_SIZE;
-			tailsz = PAGE_SIZE;
+			cur_len = min(round_down(wsize, PAGE_SIZE), rest_len);
 		} else {
-			nr_pages = DIV_ROUND_UP(rest_len, PAGE_SIZE);
 			cur_len = rest_len;
-			tailsz = rest_len - (nr_pages - 1) * PAGE_SIZE;
 		}
 
-		wdata2 = cifs_writedata_alloc(nr_pages, cifs_writev_complete);
+		wdata2 = cifs_writedata_alloc(cifs_writev_complete);
 		if (!wdata2) {
 			rc = -ENOMEM;
 			break;
 		}
 
-		for (j = 0; j < nr_pages; j++) {
-			wdata2->pages[j] = wdata->pages[i + j];
-			lock_page(wdata2->pages[j]);
-			clear_page_dirty_for_io(wdata2->pages[j]);
-		}
-
 		wdata2->sync_mode = wdata->sync_mode;
-		wdata2->nr_pages = nr_pages;
-		wdata2->offset = page_offset(wdata2->pages[0]);
-		wdata2->pagesz = PAGE_SIZE;
-		wdata2->tailsz = tailsz;
-		wdata2->bytes = cur_len;
+		wdata2->offset	= fpos;
+		wdata2->bytes	= cur_len;
+		wdata2->iter	= wdata->iter;
+
+		iov_iter_advance(&wdata2->iter, fpos - wdata->offset);
+		iov_iter_truncate(&wdata2->iter, wdata2->bytes);
+
+		if (iov_iter_is_xarray(&wdata2->iter))
+			/* Check for pages having been redirtied and clean
+			 * them.  We can do this by walking the xarray.  If
+			 * it's not an xarray, then it's a DIO and we shouldn't
+			 * be mucking around with the page bits.
+			 */
+			cifs_undirty_folios(inode, fpos, cur_len);
 
 		rc = cifs_get_writable_file(CIFS_I(inode), FIND_WR_ANY,
 					    &wdata2->cfile);
@@ -2452,33 +2475,22 @@ cifs_writev_requeue(struct cifs_writedata *wdata)
 						       cifs_writedata_release);
 		}
 
-		for (j = 0; j < nr_pages; j++) {
-			unlock_page(wdata2->pages[j]);
-			if (rc != 0 && !is_retryable_error(rc)) {
-				SetPageError(wdata2->pages[j]);
-				end_page_writeback(wdata2->pages[j]);
-				put_page(wdata2->pages[j]);
-			}
-		}
-
 		kref_put(&wdata2->refcount, cifs_writedata_release);
 		if (rc) {
 			if (is_retryable_error(rc))
 				continue;
-			i += nr_pages;
+			fpos += cur_len;
+			rest_len -= cur_len;
 			break;
 		}
 
+		fpos += cur_len;
 		rest_len -= cur_len;
-		i += nr_pages;
-	} while (i < wdata->nr_pages);
+	} while (rest_len > 0);
 
-	/* cleanup remaining pages from the original wdata */
-	for (; i < wdata->nr_pages; i++) {
-		SetPageError(wdata->pages[i]);
-		end_page_writeback(wdata->pages[i]);
-		put_page(wdata->pages[i]);
-	}
+	/* Clean up remaining pages from the original wdata */
+	if (iov_iter_is_xarray(&wdata->iter))
+		cifs_pages_write_failed(inode, fpos, rest_len);
 
 	if (rc != 0 && !is_retryable_error(rc))
 		mapping_set_error(inode->i_mapping, rc);
@@ -2491,7 +2503,6 @@ cifs_writev_complete(struct work_struct *work)
 	struct cifs_writedata *wdata = container_of(work,
 						struct cifs_writedata, work);
 	struct inode *inode = d_inode(wdata->cfile->dentry);
-	int i = 0;
 
 	if (wdata->result == 0) {
 		spin_lock(&inode->i_lock);
@@ -2502,41 +2513,25 @@ cifs_writev_complete(struct work_struct *work)
 	} else if (wdata->sync_mode == WB_SYNC_ALL && wdata->result == -EAGAIN)
 		return cifs_writev_requeue(wdata);
 
-	for (i = 0; i < wdata->nr_pages; i++) {
-		struct page *page = wdata->pages[i];
+	if (wdata->result == -EAGAIN)
+		cifs_pages_write_redirty(inode, wdata->offset, wdata->bytes);
+	else if (wdata->result < 0)
+		cifs_pages_write_failed(inode, wdata->offset, wdata->bytes);
+	else
+		cifs_pages_written_back(inode, wdata->offset, wdata->bytes);
 
-		if (wdata->result == -EAGAIN)
-			__set_page_dirty_nobuffers(page);
-		else if (wdata->result < 0)
-			SetPageError(page);
-		end_page_writeback(page);
-		cifs_readpage_to_fscache(inode, page);
-		put_page(page);
-	}
 	if (wdata->result != -EAGAIN)
 		mapping_set_error(inode->i_mapping, wdata->result);
 	kref_put(&wdata->refcount, cifs_writedata_release);
 }
 
 struct cifs_writedata *
-cifs_writedata_alloc(unsigned int nr_pages, work_func_t complete)
-{
-	struct page **pages =
-		kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
-	if (pages)
-		return cifs_writedata_direct_alloc(pages, complete);
-
-	return NULL;
-}
-
-struct cifs_writedata *
-cifs_writedata_direct_alloc(struct page **pages, work_func_t complete)
+cifs_writedata_alloc(work_func_t complete)
 {
 	struct cifs_writedata *wdata;
 
 	wdata = kzalloc(sizeof(*wdata), GFP_NOFS);
 	if (wdata != NULL) {
-		wdata->pages = pages;
 		kref_init(&wdata->refcount);
 		INIT_LIST_HEAD(&wdata->list);
 		init_completion(&wdata->done);
@@ -2545,7 +2540,6 @@ cifs_writedata_direct_alloc(struct page **pages, work_func_t complete)
 	return wdata;
 }
 
-
 static int cifs_partialpagewrite(struct page *page, unsigned from, unsigned to)
 {
 	struct address_space *mapping = page->mapping;
@@ -2604,6 +2598,7 @@ static int cifs_partialpagewrite(struct page *page, unsigned from, unsigned to)
 	return rc;
 }
 
+#if 0 // TODO: Remove for iov_iter support
 static struct cifs_writedata *
 wdata_alloc_and_fillpages(pgoff_t tofind, struct address_space *mapping,
 			  pgoff_t end, pgoff_t *index,
@@ -2893,6 +2888,374 @@ static int cifs_writepages(struct address_space *mapping,
 	set_bit(CIFS_INO_MODIFIED_ATTR, &CIFS_I(inode)->flags);
 	return rc;
 }
+#endif
+
+/*
+ * Extend the region to be written back to include subsequent contiguously
+ * dirty pages if possible, but don't sleep while doing so.
+ */
+static void cifs_extend_writeback(struct address_space *mapping,
+				  long *_count,
+				  loff_t start,
+				  int max_pages,
+				  size_t max_len,
+				  unsigned int *_len)
+{
+	struct folio_batch batch;
+	struct folio *folio;
+	unsigned int psize, nr_pages;
+	size_t len = *_len;
+	pgoff_t index = (start + len) / PAGE_SIZE;
+	bool stop = true;
+	unsigned int i;
+
+	XA_STATE(xas, &mapping->i_pages, index);
+	folio_batch_init(&batch);
+
+	do {
+		/* Firstly, we gather up a batch of contiguous dirty pages
+		 * under the RCU read lock - but we can't clear the dirty flags
+		 * there if any of those pages are mapped.
+		 */
+		rcu_read_lock();
+
+		xas_for_each(&xas, folio, ULONG_MAX) {
+			stop = true;
+			if (xas_retry(&xas, folio))
+				continue;
+			if (xa_is_value(folio))
+				break;
+			if (folio_index(folio) != index)
+				break;
+			if (!folio_try_get_rcu(folio)) {
+				xas_reset(&xas);
+				continue;
+			}
+			nr_pages = folio_nr_pages(folio);
+			if (nr_pages > max_pages)
+				break;
+
+			/* Has the page moved or been split? */
+			if (unlikely(folio != xas_reload(&xas))) {
+				folio_put(folio);
+				break;
+			}
+
+			if (!folio_trylock(folio)) {
+				folio_put(folio);
+				break;
+			}
+			if (!folio_test_dirty(folio) || folio_test_writeback(folio)) {
+				folio_unlock(folio);
+				folio_put(folio);
+				break;
+			}
+
+			max_pages -= nr_pages;
+			psize = folio_size(folio);
+			len += psize;
+			stop = false;
+			if (max_pages <= 0 || len >= max_len || *_count <= 0)
+				stop = true;
+
+			index += nr_pages;
+			if (!folio_batch_add(&batch, folio))
+				break;
+			if (stop)
+				break;
+		}
+
+		if (!stop)
+			xas_pause(&xas);
+		rcu_read_unlock();
+
+		/* Now, if we obtained any pages, we can shift them to being
+		 * writable and mark them for caching.
+		 */
+		if (!folio_batch_count(&batch))
+			break;
+
+		for (i = 0; i < folio_batch_count(&batch); i++) {
+			folio = batch.folios[i];
+			/* The folio should be locked, dirty and not undergoing
+			 * writeback from the loop above.
+			 */
+			if (!folio_clear_dirty_for_io(folio))
+				WARN_ON(1);
+			if (folio_start_writeback(folio))
+				WARN_ON(1);
+
+			*_count -= folio_nr_pages(folio);
+			folio_unlock(folio);
+		}
+
+		folio_batch_release(&batch);
+		cond_resched();
+	} while (!stop);
+
+	*_len = len;
+}
+
+/*
+ * Write back the locked page and any subsequent non-locked dirty pages.
+ */
+static ssize_t cifs_write_back_from_locked_folio(struct address_space *mapping,
+						 struct writeback_control *wbc,
+						 struct folio *folio,
+						 loff_t start, loff_t end)
+{
+	struct inode *inode = mapping->host;
+	struct TCP_Server_Info *server;
+	struct cifs_writedata *wdata;
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
+	struct cifs_credits credits_on_stack;
+	struct cifs_credits *credits = &credits_on_stack;
+	struct cifsFileInfo *cfile = NULL;
+	unsigned int xid, wsize, len;
+	loff_t i_size = i_size_read(inode);
+	size_t max_len;
+	long count = wbc->nr_to_write;
+	int rc;
+
+	/* The folio should be locked, dirty and not undergoing writeback. */
+	if (folio_start_writeback(folio))
+		WARN_ON(1);
+
+	count -= folio_nr_pages(folio);
+	len = folio_size(folio);
+
+	xid = get_xid();
+	server = cifs_pick_channel(cifs_sb_master_tcon(cifs_sb)->ses);
+
+	rc = cifs_get_writable_file(CIFS_I(inode), FIND_WR_ANY, &cfile);
+	if (rc) {
+		cifs_dbg(VFS, "No writable handle in writepages rc=%d\n", rc);
+		goto err_xid;
+	}
+
+	rc = server->ops->wait_mtu_credits(server, cifs_sb->ctx->wsize,
+					   &wsize, credits);
+	if (rc != 0)
+		goto err_close;
+
+	wdata = cifs_writedata_alloc(cifs_writev_complete);
+	if (!wdata) {
+		rc = -ENOMEM;
+		goto err_uncredit;
+	}
+
+	wdata->sync_mode = wbc->sync_mode;
+	wdata->offset = folio_pos(folio);
+	wdata->pid = cfile->pid;
+	wdata->credits = credits_on_stack;
+	wdata->cfile = cfile;
+	wdata->server = server;
+	cfile = NULL;
+
+	/* Find all consecutive lockable dirty pages, stopping when we find a
+	 * page that is not immediately lockable, is not dirty or is missing,
+	 * or we reach the end of the range.
+	 */
+	if (start < i_size) {
+		/* Trim the write to the EOF; the extra data is ignored.  Also
+		 * put an upper limit on the size of a single storedata op.
+		 */
+		max_len = wsize;
+		max_len = min_t(unsigned long long, max_len, end - start + 1);
+		max_len = min_t(unsigned long long, max_len, i_size - start);
+
+		if (len < max_len) {
+			int max_pages = INT_MAX;
+
+#ifdef CONFIG_CIFS_SMB_DIRECT
+			if (server->smbd_conn)
+				max_pages = server->smbd_conn->max_frmr_depth;
+#endif
+			max_pages -= folio_nr_pages(folio);
+
+			if (max_pages > 0)
+				cifs_extend_writeback(mapping, &count, start,
+						      max_pages, max_len, &len);
+		}
+		len = min_t(loff_t, len, max_len);
+	}
+
+	wdata->bytes = len;
+
+	/* We now have a contiguous set of dirty pages, each with writeback
+	 * set; the first page is still locked at this point, but all the rest
+	 * have been unlocked.
+	 */
+	folio_unlock(folio);
+
+	if (start < i_size) {
+		iov_iter_xarray(&wdata->iter, WRITE, &mapping->i_pages, start, len);
+
+		rc = adjust_credits(wdata->server, &wdata->credits, wdata->bytes);
+		if (rc)
+			goto err_wdata;
+
+		if (wdata->cfile->invalidHandle)
+			rc = -EAGAIN;
+		else
+			rc = wdata->server->ops->async_writev(wdata,
+							      cifs_writedata_release);
+		if (rc >= 0) {
+			kref_put(&wdata->refcount, cifs_writedata_release);
+			goto err_close;
+		}
+	} else {
+		/* The dirty region was entirely beyond the EOF. */
+		cifs_pages_written_back(inode, start, len);
+		rc = 0;
+	}
+
+err_wdata:
+	kref_put(&wdata->refcount, cifs_writedata_release);
+err_uncredit:
+	add_credits_and_wake_if(server, credits, 0);
+err_close:
+	if (cfile)
+		cifsFileInfo_put(cfile);
+err_xid:
+	free_xid(xid);
+	if (rc == 0) {
+		wbc->nr_to_write = count;
+	} else if (is_retryable_error(rc)) {
+		cifs_pages_write_redirty(inode, start, len);
+	} else {
+		cifs_pages_write_failed(inode, start, len);
+		mapping_set_error(mapping, rc);
+	}
+	/* Indication to update ctime and mtime as close is deferred */
+	set_bit(CIFS_INO_MODIFIED_ATTR, &CIFS_I(inode)->flags);
+	return rc;
+}
+
+/*
+ * write a region of pages back to the server
+ */
+static int cifs_writepages_region(struct address_space *mapping,
+				  struct writeback_control *wbc,
+				  loff_t start, loff_t end, loff_t *_next)
+{
+	struct folio *folio;
+	struct page *head_page;
+	ssize_t ret;
+	int n, skips = 0;
+
+	do {
+		pgoff_t index = start / PAGE_SIZE;
+
+		n = find_get_pages_range_tag(mapping, &index, end / PAGE_SIZE,
+					     PAGECACHE_TAG_DIRTY, 1, &head_page);
+		if (!n)
+			break;
+
+		folio = page_folio(head_page);
+		start = folio_pos(folio); /* May regress with THPs */
+
+		/* At this point we hold neither the i_pages lock nor the
+		 * page lock: the page may be truncated or invalidated
+		 * (changing page->mapping to NULL), or even swizzled
+		 * back from swapper_space to tmpfs file mapping
+		 */
+		if (wbc->sync_mode != WB_SYNC_NONE) {
+			ret = folio_lock_killable(folio);
+			if (ret < 0) {
+				folio_put(folio);
+				return ret;
+			}
+		} else {
+			if (!folio_trylock(folio)) {
+				folio_put(folio);
+				return 0;
+			}
+		}
+
+		if (folio_mapping(folio) != mapping ||
+		    !folio_test_dirty(folio)) {
+			start += folio_size(folio);
+			folio_unlock(folio);
+			folio_put(folio);
+			continue;
+		}
+
+		if (folio_test_writeback(folio) ||
+		    folio_test_fscache(folio)) {
+			folio_unlock(folio);
+			if (wbc->sync_mode != WB_SYNC_NONE) {
+				folio_wait_writeback(folio);
+#ifdef CONFIG_CIFS_FSCACHE
+				folio_wait_fscache(folio);
+#endif
+			} else {
+				start += folio_size(folio);
+			}
+			folio_put(folio);
+			if (wbc->sync_mode == WB_SYNC_NONE) {
+				if (skips >= 5 || need_resched())
+					break;
+				skips++;
+			}
+			continue;
+		}
+
+		if (!folio_clear_dirty_for_io(folio))
+			/* We hold the page lock - it should've been dirty. */
+			WARN_ON(1);
+
+		ret = cifs_write_back_from_locked_folio(mapping, wbc, folio, start, end);
+		folio_put(folio);
+		if (ret < 0)
+			return ret;
+
+		start += ret;
+		cond_resched();
+	} while (wbc->nr_to_write > 0);
+
+	*_next = start;
+	return 0;
+}
+
+/*
+ * Write some of the pending data back to the server
+ */
+static int cifs_writepages(struct address_space *mapping,
+			   struct writeback_control *wbc)
+{
+	loff_t start, next;
+	int ret;
+
+	/* We have to be careful as we can end up racing with setattr()
+	 * truncating the pagecache since the caller doesn't take a lock here
+	 * to prevent it.
+	 */
+
+	if (wbc->range_cyclic) {
+		start = mapping->writeback_index * PAGE_SIZE;
+		ret = cifs_writepages_region(mapping, wbc, start, LLONG_MAX, &next);
+		if (ret == 0) {
+			mapping->writeback_index = next / PAGE_SIZE;
+			if (start > 0 && wbc->nr_to_write > 0) {
+				ret = cifs_writepages_region(mapping, wbc, 0,
+							     start, &next);
+				if (ret == 0)
+					mapping->writeback_index =
+						next / PAGE_SIZE;
+			}
+		}
+	} else if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX) {
+		ret = cifs_writepages_region(mapping, wbc, 0, LLONG_MAX, &next);
+		if (wbc->nr_to_write > 0 && ret == 0)
+			mapping->writeback_index = next / PAGE_SIZE;
+	} else {
+		ret = cifs_writepages_region(mapping, wbc,
+					     wbc->range_start, wbc->range_end, &next);
+	}
+
+	return ret;
+}
 
 static int
 cifs_writepage_locked(struct page *page, struct writeback_control *wbc)
@@ -2950,6 +3313,7 @@ static int cifs_write_end(struct file *file, struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	struct cifsFileInfo *cfile = file->private_data;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(cfile->dentry->d_sb);
+	struct folio *folio = page_folio(page);
 	__u32 pid;
 
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RWPIDFORWARD)
@@ -2960,14 +3324,14 @@ static int cifs_write_end(struct file *file, struct address_space *mapping,
 	cifs_dbg(FYI, "write_end for page %p from pos %lld with %d bytes\n",
 		 page, pos, copied);
 
-	if (PageChecked(page)) {
+	if (folio_test_checked(folio)) {
 		if (copied == len)
-			SetPageUptodate(page);
-		ClearPageChecked(page);
-	} else if (!PageUptodate(page) && copied == PAGE_SIZE)
-		SetPageUptodate(page);
+			folio_mark_uptodate(folio);
+		folio_clear_checked(folio);
+	} else if (!folio_test_uptodate(folio) && copied == PAGE_SIZE)
+		folio_mark_uptodate(folio);
 
-	if (!PageUptodate(page)) {
+	if (!folio_test_uptodate(folio)) {
 		char *page_data;
 		unsigned offset = pos & (PAGE_SIZE - 1);
 		unsigned int xid;
@@ -3127,6 +3491,7 @@ int cifs_flush(struct file *file, fl_owner_t id)
 	return rc;
 }
 
+#if 0 // TODO: Remove for iov_iter support
 static int
 cifs_write_allocate_pages(struct page **pages, unsigned long num_pages)
 {
@@ -3167,17 +3532,15 @@ size_t get_numpages(const size_t wsize, const size_t len, size_t *cur_len)
 
 	return num_pages;
 }
+#endif
 
 static void
 cifs_uncached_writedata_release(struct kref *refcount)
 {
-	int i;
 	struct cifs_writedata *wdata = container_of(refcount,
 					struct cifs_writedata, refcount);
 
 	kref_put(&wdata->ctx->refcount, cifs_aio_ctx_release);
-	for (i = 0; i < wdata->nr_pages; i++)
-		put_page(wdata->pages[i]);
 	cifs_writedata_release(refcount);
 }
 
@@ -3203,6 +3566,7 @@ cifs_uncached_writev_complete(struct work_struct *work)
 	kref_put(&wdata->refcount, cifs_uncached_writedata_release);
 }
 
+#if 0 // TODO: Remove for iov_iter support
 static int
 wdata_fill_from_iovec(struct cifs_writedata *wdata, struct iov_iter *from,
 		      size_t *len, unsigned long *num_pages)
@@ -3244,6 +3608,7 @@ wdata_fill_from_iovec(struct cifs_writedata *wdata, struct iov_iter *from,
 	*num_pages = i + 1;
 	return 0;
 }
+#endif
 
 static int
 cifs_resend_wdata(struct cifs_writedata *wdata, struct list_head *wdata_list,
@@ -3315,23 +3680,58 @@ cifs_resend_wdata(struct cifs_writedata *wdata, struct list_head *wdata_list,
 	return rc;
 }
 
+/*
+ * Select span of a bvec iterator we're going to use.  Limit it by both maximum
+ * size and maximum number of segments.
+ */
+static size_t cifs_limit_bvec_subset(const struct iov_iter *iter, size_t offset,
+				     size_t max_size, size_t max_segs, unsigned int *_nsegs)
+{
+	const struct bio_vec *bvecs = iter->bvec;
+	unsigned int nbv = iter->nr_segs, ix = 0, nsegs = 0;
+	size_t len, span = 0, n = iter->count;
+	size_t skip = iter->iov_offset + offset;
+
+	if (WARN_ON(!iov_iter_is_bvec(iter)) || WARN_ON(offset > n) || n == 0)
+		return 0;
+
+	while (n && ix < nbv && skip) {
+		len = bvecs[ix].bv_len;
+		if (skip < len)
+			break;
+		skip -= len;
+		n -= len;
+		ix++;
+	}
+
+	while (n && ix < nbv) {
+		len = min3(n, bvecs[ix].bv_len - skip, max_size);
+		span += len;
+		nsegs++;
+		ix++;
+		if (span >= max_size || nsegs >= max_segs)
+			break;
+		skip = 0;
+		n -= len;
+	}
+
+	*_nsegs = nsegs;
+	return span;
+}
+
 static int
-cifs_write_from_iter(loff_t offset, size_t len, struct iov_iter *from,
+cifs_write_from_iter(loff_t fpos, size_t len, const struct iov_iter *from,
 		     struct cifsFileInfo *open_file,
 		     struct cifs_sb_info *cifs_sb, struct list_head *wdata_list,
 		     struct cifs_aio_ctx *ctx)
 {
 	int rc = 0;
-	size_t cur_len;
-	unsigned long nr_pages, num_pages, i;
+	size_t cur_len, max_len;
 	struct cifs_writedata *wdata;
-	struct iov_iter saved_from = *from;
-	loff_t saved_offset = offset;
+	size_t skip = 0;
 	pid_t pid;
 	struct TCP_Server_Info *server;
-	struct page **pagevec;
-	size_t start;
-	unsigned int xid;
+	unsigned int xid, max_segs = INT_MAX;
 
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RWPIDFORWARD)
 		pid = open_file->pid;
@@ -3341,10 +3741,20 @@ cifs_write_from_iter(loff_t offset, size_t len, struct iov_iter *from,
 	server = cifs_pick_channel(tlink_tcon(open_file->tlink)->ses);
 	xid = get_xid();
 
+#ifdef CONFIG_CIFS_SMB_DIRECT
+	if (server->smbd_conn)
+		max_segs = server->smbd_conn->max_frmr_depth;
+#endif
+
 	do {
-		unsigned int wsize;
 		struct cifs_credits credits_on_stack;
 		struct cifs_credits *credits = &credits_on_stack;
+		unsigned int wsize, nsegs = 0;
+
+		if (signal_pending(current)) {
+			rc = -EINTR;
+			break;
+		}
 
 		if (open_file->invalidHandle) {
 			rc = cifs_reopen_file(open_file, false);
@@ -3359,96 +3769,43 @@ cifs_write_from_iter(loff_t offset, size_t len, struct iov_iter *from,
 		if (rc)
 			break;
 
-		cur_len = min_t(const size_t, len, wsize);
-
-		if (ctx->direct_io) {
-			ssize_t result;
-
-			result = iov_iter_get_pages_alloc2(
-				from, &pagevec, cur_len, &start);
-			if (result < 0) {
-				cifs_dbg(VFS,
-					 "direct_writev couldn't get user pages (rc=%zd) iter type %d iov_offset %zd count %zd\n",
-					 result, iov_iter_type(from),
-					 from->iov_offset, from->count);
-				dump_stack();
-
-				rc = result;
-				add_credits_and_wake_if(server, credits, 0);
-				break;
-			}
-			cur_len = (size_t)result;
-
-			nr_pages =
-				(cur_len + start + PAGE_SIZE - 1) / PAGE_SIZE;
-
-			wdata = cifs_writedata_direct_alloc(pagevec,
-					     cifs_uncached_writev_complete);
-			if (!wdata) {
-				rc = -ENOMEM;
-				add_credits_and_wake_if(server, credits, 0);
-				break;
-			}
-
-
-			wdata->page_offset = start;
-			wdata->tailsz =
-				nr_pages > 1 ?
-					cur_len - (PAGE_SIZE - start) -
-					(nr_pages - 2) * PAGE_SIZE :
-					cur_len;
-		} else {
-			nr_pages = get_numpages(wsize, len, &cur_len);
-			wdata = cifs_writedata_alloc(nr_pages,
-					     cifs_uncached_writev_complete);
-			if (!wdata) {
-				rc = -ENOMEM;
-				add_credits_and_wake_if(server, credits, 0);
-				break;
-			}
-
-			rc = cifs_write_allocate_pages(wdata->pages, nr_pages);
-			if (rc) {
-				kvfree(wdata->pages);
-				kfree(wdata);
-				add_credits_and_wake_if(server, credits, 0);
-				break;
-			}
-
-			num_pages = nr_pages;
-			rc = wdata_fill_from_iovec(
-				wdata, from, &cur_len, &num_pages);
-			if (rc) {
-				for (i = 0; i < nr_pages; i++)
-					put_page(wdata->pages[i]);
-				kvfree(wdata->pages);
-				kfree(wdata);
-				add_credits_and_wake_if(server, credits, 0);
-				break;
-			}
+		max_len = min_t(const size_t, len, wsize);
+		if (!max_len) {
+			rc = -EAGAIN;
+			add_credits_and_wake_if(server, credits, 0);
+			break;
+		}
 
-			/*
-			 * Bring nr_pages down to the number of pages we
-			 * actually used, and free any pages that we didn't use.
-			 */
-			for ( ; nr_pages > num_pages; nr_pages--)
-				put_page(wdata->pages[nr_pages - 1]);
+		cur_len = cifs_limit_bvec_subset(from, skip, max_len, max_segs, &nsegs);
+		cifs_dbg(FYI, "write_from_iter len=%zx/%zx nsegs=%u/%lu/%u\n",
+			 cur_len, max_len, nsegs, from->nr_segs, max_segs);
+		if (cur_len == 0) {
+			rc = -EIO;
+			add_credits_and_wake_if(server, credits, 0);
+			break;
+		}
 
-			wdata->tailsz = cur_len - ((nr_pages - 1) * PAGE_SIZE);
+		wdata = cifs_writedata_alloc(cifs_uncached_writev_complete);
+		if (!wdata) {
+			rc = -ENOMEM;
+			add_credits_and_wake_if(server, credits, 0);
+			break;
 		}
 
 		wdata->sync_mode = WB_SYNC_ALL;
-		wdata->nr_pages = nr_pages;
-		wdata->offset = (__u64)offset;
-		wdata->cfile = cifsFileInfo_get(open_file);
-		wdata->server = server;
-		wdata->pid = pid;
-		wdata->bytes = cur_len;
-		wdata->pagesz = PAGE_SIZE;
-		wdata->credits = credits_on_stack;
-		wdata->ctx = ctx;
+		wdata->offset	= (__u64)fpos;
+		wdata->cfile	= cifsFileInfo_get(open_file);
+		wdata->server	= server;
+		wdata->pid	= pid;
+		wdata->bytes	= cur_len;
+		wdata->credits	= credits_on_stack;
+		wdata->iter	= *from;
+		wdata->ctx	= ctx;
 		kref_get(&ctx->refcount);
 
+		iov_iter_advance(&wdata->iter, skip);
+		iov_iter_truncate(&wdata->iter, cur_len);
+
 		rc = adjust_credits(server, &wdata->credits, wdata->bytes);
 
 		if (!rc) {
@@ -3463,16 +3820,14 @@ cifs_write_from_iter(loff_t offset, size_t len, struct iov_iter *from,
 			add_credits_and_wake_if(server, &wdata->credits, 0);
 			kref_put(&wdata->refcount,
 				 cifs_uncached_writedata_release);
-			if (rc == -EAGAIN) {
-				*from = saved_from;
-				iov_iter_advance(from, offset - saved_offset);
+			if (rc == -EAGAIN)
 				continue;
-			}
 			break;
 		}
 
 		list_add_tail(&wdata->list, wdata_list);
-		offset += cur_len;
+		skip += cur_len;
+		fpos += cur_len;
 		len -= cur_len;
 	} while (len > 0);
 
@@ -3571,8 +3926,6 @@ static ssize_t __cifs_writev(
 	struct cifs_tcon *tcon;
 	struct cifs_sb_info *cifs_sb;
 	struct cifs_aio_ctx *ctx;
-	struct iov_iter saved_from = *from;
-	size_t len = iov_iter_count(from);
 	int rc;
 
 	/*
@@ -3606,23 +3959,26 @@ static ssize_t __cifs_writev(
 		ctx->iocb = iocb;
 
 	ctx->pos = iocb->ki_pos;
+	ctx->direct_io = direct;
 
-	if (direct) {
-		ctx->direct_io = true;
-		ctx->iter = *from;
-		ctx->len = len;
-	} else {
-		rc = setup_aio_ctx_iter(ctx, from, WRITE);
-		if (rc) {
-			kref_put(&ctx->refcount, cifs_aio_ctx_release);
-			return rc;
-		}
+	/*
+	 * Duplicate the iterator as it may contain references to the calling
+	 * process's virtual memory layout which won't be available in an async
+	 * worker thread.  This also takes a ref on every folio involved and
+	 * attaches them to ctx->bv[].
+	 */
+	rc = extract_iter_to_iter(from, iov_iter_count(from), &ctx->iter, &ctx->bv);
+	if (rc < 0) {
+		kref_put(&ctx->refcount, cifs_aio_ctx_release);
+		return rc;
 	}
+	ctx->npages = rc;
+	ctx->len = iov_iter_count(&ctx->iter);
 
 	/* grab a lock here due to read response handlers can access ctx */
 	mutex_lock(&ctx->aio_mutex);
 
-	rc = cifs_write_from_iter(iocb->ki_pos, ctx->len, &saved_from,
+	rc = cifs_write_from_iter(iocb->ki_pos, ctx->len, &ctx->iter,
 				  cfile, cifs_sb, &ctx->list, ctx);
 
 	/*
@@ -3762,14 +4118,12 @@ cifs_strict_writev(struct kiocb *iocb, struct iov_iter *from)
 	return written;
 }
 
-static struct cifs_readdata *
-cifs_readdata_direct_alloc(struct page **pages, work_func_t complete)
+static struct cifs_readdata *cifs_readdata_alloc(work_func_t complete)
 {
 	struct cifs_readdata *rdata;
 
 	rdata = kzalloc(sizeof(*rdata), GFP_KERNEL);
-	if (rdata != NULL) {
-		rdata->pages = pages;
+	if (rdata) {
 		kref_init(&rdata->refcount);
 		INIT_LIST_HEAD(&rdata->list);
 		init_completion(&rdata->done);
@@ -3779,27 +4133,14 @@ cifs_readdata_direct_alloc(struct page **pages, work_func_t complete)
 	return rdata;
 }
 
-static struct cifs_readdata *
-cifs_readdata_alloc(unsigned int nr_pages, work_func_t complete)
-{
-	struct page **pages =
-		kcalloc(nr_pages, sizeof(struct page *), GFP_KERNEL);
-	struct cifs_readdata *ret = NULL;
-
-	if (pages) {
-		ret = cifs_readdata_direct_alloc(pages, complete);
-		if (!ret)
-			kfree(pages);
-	}
-
-	return ret;
-}
-
 void
 cifs_readdata_release(struct kref *refcount)
 {
 	struct cifs_readdata *rdata = container_of(refcount,
 					struct cifs_readdata, refcount);
+
+	if (rdata->ctx)
+		kref_put(&rdata->ctx->refcount, cifs_aio_ctx_release);
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	if (rdata->mr) {
 		smbd_deregister_mr(rdata->mr);
@@ -3809,85 +4150,9 @@ cifs_readdata_release(struct kref *refcount)
 	if (rdata->cfile)
 		cifsFileInfo_put(rdata->cfile);
 
-	kvfree(rdata->pages);
 	kfree(rdata);
 }
 
-static int
-cifs_read_allocate_pages(struct cifs_readdata *rdata, unsigned int nr_pages)
-{
-	int rc = 0;
-	struct page *page;
-	unsigned int i;
-
-	for (i = 0; i < nr_pages; i++) {
-		page = alloc_page(GFP_KERNEL|__GFP_HIGHMEM);
-		if (!page) {
-			rc = -ENOMEM;
-			break;
-		}
-		rdata->pages[i] = page;
-	}
-
-	if (rc) {
-		unsigned int nr_page_failed = i;
-
-		for (i = 0; i < nr_page_failed; i++) {
-			put_page(rdata->pages[i]);
-			rdata->pages[i] = NULL;
-		}
-	}
-	return rc;
-}
-
-static void
-cifs_uncached_readdata_release(struct kref *refcount)
-{
-	struct cifs_readdata *rdata = container_of(refcount,
-					struct cifs_readdata, refcount);
-	unsigned int i;
-
-	kref_put(&rdata->ctx->refcount, cifs_aio_ctx_release);
-	for (i = 0; i < rdata->nr_pages; i++) {
-		put_page(rdata->pages[i]);
-	}
-	cifs_readdata_release(refcount);
-}
-
-/**
- * cifs_readdata_to_iov - copy data from pages in response to an iovec
- * @rdata:	the readdata response with list of pages holding data
- * @iter:	destination for our data
- *
- * This function copies data from a list of pages in a readdata response into
- * an array of iovecs. It will first calculate where the data should go
- * based on the info in the readdata and then copy the data into that spot.
- */
-static int
-cifs_readdata_to_iov(struct cifs_readdata *rdata, struct iov_iter *iter)
-{
-	size_t remaining = rdata->got_bytes;
-	unsigned int i;
-
-	for (i = 0; i < rdata->nr_pages; i++) {
-		struct page *page = rdata->pages[i];
-		size_t copy = min_t(size_t, remaining, PAGE_SIZE);
-		size_t written;
-
-		if (unlikely(iov_iter_is_pipe(iter))) {
-			void *addr = kmap_atomic(page);
-
-			written = copy_to_iter(addr, copy, iter);
-			kunmap_atomic(addr);
-		} else
-			written = copy_page_to_iter(page, 0, copy, iter);
-		remaining -= written;
-		if (written < copy && iov_iter_count(iter) > 0)
-			break;
-	}
-	return remaining ? -EFAULT : 0;
-}
-
 static void collect_uncached_read_data(struct cifs_aio_ctx *ctx);
 
 static void
@@ -3899,9 +4164,11 @@ cifs_uncached_readv_complete(struct work_struct *work)
 	complete(&rdata->done);
 	collect_uncached_read_data(rdata->ctx);
 	/* the below call can possibly free the last ref to aio ctx */
-	kref_put(&rdata->refcount, cifs_uncached_readdata_release);
+	kref_put(&rdata->refcount, cifs_readdata_release);
 }
 
+#if 0 // TODO: Remove for iov_iter support
+
 static int
 uncached_fill_pages(struct TCP_Server_Info *server,
 		    struct cifs_readdata *rdata, struct iov_iter *iter,
@@ -3975,6 +4242,7 @@ cifs_uncached_copy_into_pages(struct TCP_Server_Info *server,
 {
 	return uncached_fill_pages(server, rdata, iter, iter->count);
 }
+#endif
 
 static int cifs_resend_rdata(struct cifs_readdata *rdata,
 			struct list_head *rdata_list,
@@ -4044,37 +4312,36 @@ static int cifs_resend_rdata(struct cifs_readdata *rdata,
 	} while (rc == -EAGAIN);
 
 fail:
-	kref_put(&rdata->refcount, cifs_uncached_readdata_release);
+	kref_put(&rdata->refcount, cifs_readdata_release);
 	return rc;
 }
 
 static int
-cifs_send_async_read(loff_t offset, size_t len, struct cifsFileInfo *open_file,
+cifs_send_async_read(loff_t fpos, size_t len, struct cifsFileInfo *open_file,
 		     struct cifs_sb_info *cifs_sb, struct list_head *rdata_list,
 		     struct cifs_aio_ctx *ctx)
 {
 	struct cifs_readdata *rdata;
-	unsigned int npages, rsize;
+	unsigned int rsize, nsegs, max_segs = INT_MAX;
 	struct cifs_credits credits_on_stack;
 	struct cifs_credits *credits = &credits_on_stack;
-	size_t cur_len;
+	size_t cur_len, max_len, skip = 0;
 	int rc;
 	pid_t pid;
 	struct TCP_Server_Info *server;
-	struct page **pagevec;
-	size_t start;
-	struct iov_iter direct_iov = ctx->iter;
 
 	server = cifs_pick_channel(tlink_tcon(open_file->tlink)->ses);
 
+#ifdef CONFIG_CIFS_SMB_DIRECT
+	if (server->smbd_conn)
+		max_segs = server->smbd_conn->max_frmr_depth;
+#endif
+
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RWPIDFORWARD)
 		pid = open_file->pid;
 	else
 		pid = current->tgid;
 
-	if (ctx->direct_io)
-		iov_iter_advance(&direct_iov, offset - ctx->pos);
-
 	do {
 		if (open_file->invalidHandle) {
 			rc = cifs_reopen_file(open_file, true);
@@ -4094,78 +4361,38 @@ cifs_send_async_read(loff_t offset, size_t len, struct cifsFileInfo *open_file,
 		if (rc)
 			break;
 
-		cur_len = min_t(const size_t, len, rsize);
-
-		if (ctx->direct_io) {
-			ssize_t result;
+		max_len = min_t(size_t, len, rsize);
 
-			result = iov_iter_get_pages_alloc2(
-					&direct_iov, &pagevec,
-					cur_len, &start);
-			if (result < 0) {
-				cifs_dbg(VFS,
-					 "Couldn't get user pages (rc=%zd) iter type %d iov_offset %zd count %zd\n",
-					 result, iov_iter_type(&direct_iov),
-					 direct_iov.iov_offset,
-					 direct_iov.count);
-				dump_stack();
-
-				rc = result;
-				add_credits_and_wake_if(server, credits, 0);
-				break;
-			}
-			cur_len = (size_t)result;
-
-			rdata = cifs_readdata_direct_alloc(
-					pagevec, cifs_uncached_readv_complete);
-			if (!rdata) {
-				add_credits_and_wake_if(server, credits, 0);
-				rc = -ENOMEM;
-				break;
-			}
-
-			npages = (cur_len + start + PAGE_SIZE-1) / PAGE_SIZE;
-			rdata->page_offset = start;
-			rdata->tailsz = npages > 1 ?
-				cur_len-(PAGE_SIZE-start)-(npages-2)*PAGE_SIZE :
-				cur_len;
-
-		} else {
-
-			npages = DIV_ROUND_UP(cur_len, PAGE_SIZE);
-			/* allocate a readdata struct */
-			rdata = cifs_readdata_alloc(npages,
-					    cifs_uncached_readv_complete);
-			if (!rdata) {
-				add_credits_and_wake_if(server, credits, 0);
-				rc = -ENOMEM;
-				break;
-			}
-
-			rc = cifs_read_allocate_pages(rdata, npages);
-			if (rc) {
-				kvfree(rdata->pages);
-				kfree(rdata);
-				add_credits_and_wake_if(server, credits, 0);
-				break;
-			}
+		cur_len = cifs_limit_bvec_subset(&ctx->iter, skip, max_len,
+						 max_segs, &nsegs);
+		cifs_dbg(FYI, "read-to-iter len=%zx/%zx nsegs=%u/%lu/%u\n",
+			 cur_len, max_len, nsegs, ctx->iter.nr_segs, max_segs);
+		if (cur_len == 0) {
+			rc = -EIO;
+			add_credits_and_wake_if(server, credits, 0);
+			break;
+		}
 
-			rdata->tailsz = PAGE_SIZE;
+		rdata = cifs_readdata_alloc(cifs_uncached_readv_complete);
+		if (!rdata) {
+			add_credits_and_wake_if(server, credits, 0);
+			rc = -ENOMEM;
+			break;
 		}
 
-		rdata->server = server;
-		rdata->cfile = cifsFileInfo_get(open_file);
-		rdata->nr_pages = npages;
-		rdata->offset = offset;
-		rdata->bytes = cur_len;
-		rdata->pid = pid;
-		rdata->pagesz = PAGE_SIZE;
-		rdata->read_into_pages = cifs_uncached_read_into_pages;
-		rdata->copy_into_pages = cifs_uncached_copy_into_pages;
-		rdata->credits = credits_on_stack;
-		rdata->ctx = ctx;
+		rdata->server	= server;
+		rdata->cfile	= cifsFileInfo_get(open_file);
+		rdata->offset	= fpos;
+		rdata->bytes	= cur_len;
+		rdata->pid	= pid;
+		rdata->credits	= credits_on_stack;
+		rdata->ctx	= ctx;
 		kref_get(&ctx->refcount);
 
+		rdata->iter	= ctx->iter;
+		iov_iter_advance(&rdata->iter, skip);
+		iov_iter_truncate(&rdata->iter, cur_len);
+
 		rc = adjust_credits(server, &rdata->credits, rdata->bytes);
 
 		if (!rc) {
@@ -4177,17 +4404,15 @@ cifs_send_async_read(loff_t offset, size_t len, struct cifsFileInfo *open_file,
 
 		if (rc) {
 			add_credits_and_wake_if(server, &rdata->credits, 0);
-			kref_put(&rdata->refcount,
-				cifs_uncached_readdata_release);
-			if (rc == -EAGAIN) {
-				iov_iter_revert(&direct_iov, cur_len);
+			kref_put(&rdata->refcount, cifs_readdata_release);
+			if (rc == -EAGAIN)
 				continue;
-			}
 			break;
 		}
 
 		list_add_tail(&rdata->list, rdata_list);
-		offset += cur_len;
+		skip += cur_len;
+		fpos += cur_len;
 		len -= cur_len;
 	} while (len > 0);
 
@@ -4229,22 +4454,6 @@ collect_uncached_read_data(struct cifs_aio_ctx *ctx)
 				list_del_init(&rdata->list);
 				INIT_LIST_HEAD(&tmp_list);
 
-				/*
-				 * Got a part of data and then reconnect has
-				 * happened -- fill the buffer and continue
-				 * reading.
-				 */
-				if (got_bytes && got_bytes < rdata->bytes) {
-					rc = 0;
-					if (!ctx->direct_io)
-						rc = cifs_readdata_to_iov(rdata, to);
-					if (rc) {
-						kref_put(&rdata->refcount,
-							cifs_uncached_readdata_release);
-						continue;
-					}
-				}
-
 				if (ctx->direct_io) {
 					/*
 					 * Re-use rdata as this is a
@@ -4261,7 +4470,7 @@ collect_uncached_read_data(struct cifs_aio_ctx *ctx)
 						&tmp_list, ctx);
 
 					kref_put(&rdata->refcount,
-						cifs_uncached_readdata_release);
+						cifs_readdata_release);
 				}
 
 				list_splice(&tmp_list, &ctx->list);
@@ -4269,8 +4478,6 @@ collect_uncached_read_data(struct cifs_aio_ctx *ctx)
 				goto again;
 			} else if (rdata->result)
 				rc = rdata->result;
-			else if (!ctx->direct_io)
-				rc = cifs_readdata_to_iov(rdata, to);
 
 			/* if there was a short read -- discard anything left */
 			if (rdata->got_bytes && rdata->got_bytes < rdata->bytes)
@@ -4279,7 +4486,7 @@ collect_uncached_read_data(struct cifs_aio_ctx *ctx)
 			ctx->total_len += rdata->got_bytes;
 		}
 		list_del_init(&rdata->list);
-		kref_put(&rdata->refcount, cifs_uncached_readdata_release);
+		kref_put(&rdata->refcount, cifs_readdata_release);
 	}
 
 	if (!ctx->direct_io)
@@ -4339,7 +4546,10 @@ static ssize_t __cifs_readv(
 	if (!ctx)
 		return -ENOMEM;
 
-	ctx->cfile = cifsFileInfo_get(cfile);
+	ctx->pos	= offset;
+	ctx->direct_io	= direct;
+	ctx->len	= len;
+	ctx->cfile	= cifsFileInfo_get(cfile);
 
 	if (!is_sync_kiocb(iocb))
 		ctx->iocb = iocb;
@@ -4347,19 +4557,12 @@ static ssize_t __cifs_readv(
 	if (user_backed_iter(to))
 		ctx->should_dirty = true;
 
-	if (direct) {
-		ctx->pos = offset;
-		ctx->direct_io = true;
-		ctx->iter = *to;
-		ctx->len = len;
-	} else {
-		rc = setup_aio_ctx_iter(ctx, to, READ);
-		if (rc) {
-			kref_put(&ctx->refcount, cifs_aio_ctx_release);
-			return rc;
-		}
-		len = ctx->len;
+	rc = extract_iter_to_iter(to, len, &ctx->iter, &ctx->bv);
+	if (rc < 0) {
+		kref_put(&ctx->refcount, cifs_aio_ctx_release);
+		return rc;
 	}
+	ctx->npages = rc;
 
 	/* grab a lock here due to read response handlers can access ctx */
 	mutex_lock(&ctx->aio_mutex);
@@ -4612,6 +4815,8 @@ int cifs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	return rc;
 }
 
+#if 0 // TODO: Remove for iov_iter support
+
 static void
 cifs_readv_complete(struct work_struct *work)
 {
@@ -4742,19 +4947,74 @@ cifs_readpages_copy_into_pages(struct TCP_Server_Info *server,
 {
 	return readpages_fill_pages(server, rdata, iter, iter->count);
 }
+#endif
+
+/*
+ * Unlock a bunch of folios in the pagecache.
+ */
+static void cifs_unlock_folios(struct address_space *mapping, pgoff_t first, pgoff_t last)
+{
+	struct folio *folio;
+	XA_STATE(xas, &mapping->i_pages, first);
+
+	rcu_read_lock();
+	xas_for_each(&xas, folio, last) {
+		folio_unlock(folio);
+	}
+	rcu_read_unlock();
+}
+
+static void cifs_readahead_complete(struct work_struct *work)
+{
+	struct cifs_readdata *rdata = container_of(work,
+						   struct cifs_readdata, work);
+	struct folio *folio;
+	pgoff_t last;
+	bool good = rdata->result == 0 || (rdata->result == -EAGAIN && rdata->got_bytes);
+
+	XA_STATE(xas, &rdata->mapping->i_pages, rdata->offset / PAGE_SIZE);
+
+	if (good)
+		cifs_readahead_to_fscache(rdata->mapping->host,
+					  rdata->offset, rdata->bytes);
+
+	if (iov_iter_count(&rdata->iter) > 0)
+		iov_iter_zero(iov_iter_count(&rdata->iter), &rdata->iter);
+
+	last = (rdata->offset + rdata->bytes - 1) / PAGE_SIZE;
+
+	rcu_read_lock();
+	xas_for_each(&xas, folio, last) {
+		if (good) {
+			flush_dcache_folio(folio);
+			folio_mark_uptodate(folio);
+		}
+		folio_unlock(folio);
+	}
+	rcu_read_unlock();
+
+	kref_put(&rdata->refcount, cifs_readdata_release);
+}
 
 static void cifs_readahead(struct readahead_control *ractl)
 {
-	int rc;
 	struct cifsFileInfo *open_file = ractl->file->private_data;
 	struct cifs_sb_info *cifs_sb = CIFS_FILE_SB(ractl->file);
 	struct TCP_Server_Info *server;
-	pid_t pid;
-	unsigned int xid, nr_pages, last_batch_size = 0, cache_nr_pages = 0;
-	pgoff_t next_cached = ULONG_MAX;
+	unsigned int xid, nr_pages, cache_nr_pages = 0;
+	unsigned int ra_pages;
+	pgoff_t next_cached = ULONG_MAX, ra_index;
 	bool caching = fscache_cookie_enabled(cifs_inode_cookie(ractl->mapping->host)) &&
 		cifs_inode_cookie(ractl->mapping->host)->cache_priv;
 	bool check_cache = caching;
+	pid_t pid;
+	int rc = 0;
+
+	/* Note that readahead_count() lags behind our dequeuing of pages from
+	 * the ractl, wo we have to keep track for ourselves.
+	 */
+	ra_pages = readahead_count(ractl);
+	ra_index = readahead_index(ractl);
 
 	xid = get_xid();
 
@@ -4763,22 +5023,21 @@ static void cifs_readahead(struct readahead_control *ractl)
 	else
 		pid = current->tgid;
 
-	rc = 0;
 	server = cifs_pick_channel(tlink_tcon(open_file->tlink)->ses);
 
 	cifs_dbg(FYI, "%s: file=%p mapping=%p num_pages=%u\n",
-		 __func__, ractl->file, ractl->mapping, readahead_count(ractl));
+		 __func__, ractl->file, ractl->mapping, ra_pages);
 
 	/*
 	 * Chop the readahead request up into rsize-sized read requests.
 	 */
-	while ((nr_pages = readahead_count(ractl) - last_batch_size)) {
-		unsigned int i, got, rsize;
-		struct page *page;
+	while ((nr_pages = ra_pages)) {
+		unsigned int i, rsize;
 		struct cifs_readdata *rdata;
 		struct cifs_credits credits_on_stack;
 		struct cifs_credits *credits = &credits_on_stack;
-		pgoff_t index = readahead_index(ractl) + last_batch_size;
+		struct folio *folio;
+		pgoff_t fsize;
 
 		/*
 		 * Find out if we have anything cached in the range of
@@ -4787,21 +5046,22 @@ static void cifs_readahead(struct readahead_control *ractl)
 		if (caching) {
 			if (check_cache) {
 				rc = cifs_fscache_query_occupancy(
-					ractl->mapping->host, index, nr_pages,
+					ractl->mapping->host, ra_index, nr_pages,
 					&next_cached, &cache_nr_pages);
 				if (rc < 0)
 					caching = false;
 				check_cache = false;
 			}
 
-			if (index == next_cached) {
+			if (ra_index == next_cached) {
 				/*
 				 * TODO: Send a whole batch of pages to be read
 				 * by the cache.
 				 */
-				struct folio *folio = readahead_folio(ractl);
-
-				last_batch_size = folio_nr_pages(folio);
+				folio = readahead_folio(ractl);
+				fsize = folio_nr_pages(folio);
+				ra_pages -= fsize;
+				ra_index += fsize;
 				if (cifs_readpage_from_fscache(ractl->mapping->host,
 							       &folio->page) < 0) {
 					/*
@@ -4812,8 +5072,8 @@ static void cifs_readahead(struct readahead_control *ractl)
 					caching = false;
 				}
 				folio_unlock(folio);
-				next_cached++;
-				cache_nr_pages--;
+				next_cached += fsize;
+				cache_nr_pages -= fsize;
 				if (cache_nr_pages == 0)
 					check_cache = true;
 				continue;
@@ -4838,8 +5098,9 @@ static void cifs_readahead(struct readahead_control *ractl)
 						   &rsize, credits);
 		if (rc)
 			break;
-		nr_pages = min_t(size_t, rsize / PAGE_SIZE, readahead_count(ractl));
-		nr_pages = min_t(size_t, nr_pages, next_cached - index);
+		nr_pages = min_t(size_t, rsize / PAGE_SIZE, ra_pages);
+		if (next_cached != ULONG_MAX)
+			nr_pages = min_t(size_t, nr_pages, next_cached - ra_index);
 
 		/*
 		 * Give up immediately if rsize is too small to read an entire
@@ -4852,33 +5113,31 @@ static void cifs_readahead(struct readahead_control *ractl)
 			break;
 		}
 
-		rdata = cifs_readdata_alloc(nr_pages, cifs_readv_complete);
+		rdata = cifs_readdata_alloc(cifs_readahead_complete);
 		if (!rdata) {
 			/* best to give up if we're out of mem */
 			add_credits_and_wake_if(server, credits, 0);
 			break;
 		}
 
-		got = __readahead_batch(ractl, rdata->pages, nr_pages);
-		if (got != nr_pages) {
-			pr_warn("__readahead_batch() returned %u/%u\n",
-				got, nr_pages);
-			nr_pages = got;
-		}
-
-		rdata->nr_pages = nr_pages;
-		rdata->bytes	= readahead_batch_length(ractl);
+		rdata->offset	= ra_index * PAGE_SIZE;
+		rdata->bytes	= nr_pages * PAGE_SIZE;
 		rdata->cfile	= cifsFileInfo_get(open_file);
 		rdata->server	= server;
 		rdata->mapping	= ractl->mapping;
-		rdata->offset	= readahead_pos(ractl);
 		rdata->pid	= pid;
-		rdata->pagesz	= PAGE_SIZE;
-		rdata->tailsz	= PAGE_SIZE;
-		rdata->read_into_pages = cifs_readpages_read_into_pages;
-		rdata->copy_into_pages = cifs_readpages_copy_into_pages;
 		rdata->credits	= credits_on_stack;
 
+		for (i = 0; i < nr_pages; i++) {
+			if (!readahead_folio(ractl))
+				WARN_ON(1);
+		}
+		ra_pages -= nr_pages;
+		ra_index += nr_pages;
+
+		iov_iter_xarray(&rdata->iter, READ, &rdata->mapping->i_pages,
+				rdata->offset, rdata->bytes);
+
 		rc = adjust_credits(server, &rdata->credits, rdata->bytes);
 		if (!rc) {
 			if (rdata->cfile->invalidHandle)
@@ -4889,18 +5148,15 @@ static void cifs_readahead(struct readahead_control *ractl)
 
 		if (rc) {
 			add_credits_and_wake_if(server, &rdata->credits, 0);
-			for (i = 0; i < rdata->nr_pages; i++) {
-				page = rdata->pages[i];
-				unlock_page(page);
-				put_page(page);
-			}
+			cifs_unlock_folios(rdata->mapping,
+					   rdata->offset / PAGE_SIZE,
+					   (rdata->offset + rdata->bytes - 1) / PAGE_SIZE);
 			/* Fallback to the readpage in error/reconnect cases */
 			kref_put(&rdata->refcount, cifs_readdata_release);
 			break;
 		}
 
 		kref_put(&rdata->refcount, cifs_readdata_release);
-		last_batch_size = nr_pages;
 	}
 
 	free_xid(xid);
@@ -4942,10 +5198,6 @@ static int cifs_readpage_worker(struct file *file, struct page *page,
 
 	flush_dcache_page(page);
 	SetPageUptodate(page);
-
-	/* send this page to the cache */
-	cifs_readpage_to_fscache(file_inode(file), page);
-
 	rc = 0;
 
 io_error:
diff --git a/fs/cifs/fscache.c b/fs/cifs/fscache.c
index 23ef56f55ce5..e1dd4a909017 100644
--- a/fs/cifs/fscache.c
+++ b/fs/cifs/fscache.c
@@ -165,22 +165,16 @@ static int fscache_fallback_read_page(struct inode *inode, struct page *page)
 /*
  * Fallback page writing interface.
  */
-static int fscache_fallback_write_page(struct inode *inode, struct page *page,
-				       bool no_space_allocated_yet)
+static int fscache_fallback_write_pages(struct inode *inode, loff_t start, size_t len,
+					bool no_space_allocated_yet)
 {
 	struct netfs_cache_resources cres;
 	struct fscache_cookie *cookie = cifs_inode_cookie(inode);
 	struct iov_iter iter;
-	struct bio_vec bvec[1];
-	loff_t start = page_offset(page);
-	size_t len = PAGE_SIZE;
 	int ret;
 
 	memset(&cres, 0, sizeof(cres));
-	bvec[0].bv_page		= page;
-	bvec[0].bv_offset	= 0;
-	bvec[0].bv_len		= PAGE_SIZE;
-	iov_iter_bvec(&iter, WRITE, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
+	iov_iter_xarray(&iter, WRITE, &inode->i_mapping->i_pages, start, len);
 
 	ret = fscache_begin_write_operation(&cres, cookie);
 	if (ret < 0)
@@ -189,7 +183,7 @@ static int fscache_fallback_write_page(struct inode *inode, struct page *page,
 	ret = cres.ops->prepare_write(&cres, &start, &len, i_size_read(inode),
 				      no_space_allocated_yet);
 	if (ret == 0)
-		ret = fscache_write(&cres, page_offset(page), &iter, NULL, NULL);
+		ret = fscache_write(&cres, start, &iter, NULL, NULL);
 	fscache_end_operation(&cres);
 	return ret;
 }
@@ -213,12 +207,12 @@ int __cifs_readpage_from_fscache(struct inode *inode, struct page *page)
 	return 0;
 }
 
-void __cifs_readpage_to_fscache(struct inode *inode, struct page *page)
+void __cifs_readahead_to_fscache(struct inode *inode, loff_t pos, size_t len)
 {
-	cifs_dbg(FYI, "%s: (fsc: %p, p: %p, i: %p)\n",
-		 __func__, cifs_inode_cookie(inode), page, inode);
+	cifs_dbg(FYI, "%s: (fsc: %p, p: %llx, l: %zx, i: %p)\n",
+		 __func__, cifs_inode_cookie(inode), pos, len, inode);
 
-	fscache_fallback_write_page(inode, page, true);
+	fscache_fallback_write_pages(inode, pos, len, true);
 }
 
 /*
diff --git a/fs/cifs/fscache.h b/fs/cifs/fscache.h
index 67b601041f0a..173999610997 100644
--- a/fs/cifs/fscache.h
+++ b/fs/cifs/fscache.h
@@ -90,7 +90,7 @@ static inline int cifs_fscache_query_occupancy(struct inode *inode,
 }
 
 extern int __cifs_readpage_from_fscache(struct inode *pinode, struct page *ppage);
-extern void __cifs_readpage_to_fscache(struct inode *pinode, struct page *ppage);
+extern void __cifs_readahead_to_fscache(struct inode *pinode, loff_t pos, size_t len);
 
 
 static inline int cifs_readpage_from_fscache(struct inode *inode,
@@ -101,11 +101,11 @@ static inline int cifs_readpage_from_fscache(struct inode *inode,
 	return -ENOBUFS;
 }
 
-static inline void cifs_readpage_to_fscache(struct inode *inode,
-					    struct page *page)
+static inline void cifs_readahead_to_fscache(struct inode *inode,
+					     loff_t pos, size_t len)
 {
 	if (cifs_inode_cookie(inode))
-		__cifs_readpage_to_fscache(inode, page);
+		__cifs_readahead_to_fscache(inode, pos, len);
 }
 
 #else /* CONFIG_CIFS_FSCACHE */
@@ -141,7 +141,7 @@ cifs_readpage_from_fscache(struct inode *inode, struct page *page)
 }
 
 static inline
-void cifs_readpage_to_fscache(struct inode *inode, struct page *page) {}
+void cifs_readahead_to_fscache(struct inode *inode, loff_t pos, size_t len) {}
 
 #endif /* CONFIG_CIFS_FSCACHE */
 
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index 87f60f736731..ea3282a32119 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -979,95 +979,6 @@ cifs_aio_ctx_release(struct kref *refcount)
 	kfree(ctx);
 }
 
-#define CIFS_AIO_KMALLOC_LIMIT (1024 * 1024)
-
-int
-setup_aio_ctx_iter(struct cifs_aio_ctx *ctx, struct iov_iter *iter, int rw)
-{
-	ssize_t rc;
-	unsigned int cur_npages;
-	unsigned int npages = 0;
-	unsigned int i;
-	size_t len;
-	size_t count = iov_iter_count(iter);
-	unsigned int saved_len;
-	size_t start;
-	unsigned int max_pages = iov_iter_npages(iter, INT_MAX);
-	struct page **pages = NULL;
-	struct bio_vec *bv = NULL;
-
-	if (iov_iter_is_kvec(iter)) {
-		memcpy(&ctx->iter, iter, sizeof(*iter));
-		ctx->len = count;
-		iov_iter_advance(iter, count);
-		return 0;
-	}
-
-	if (array_size(max_pages, sizeof(*bv)) <= CIFS_AIO_KMALLOC_LIMIT)
-		bv = kmalloc_array(max_pages, sizeof(*bv), GFP_KERNEL);
-
-	if (!bv) {
-		bv = vmalloc(array_size(max_pages, sizeof(*bv)));
-		if (!bv)
-			return -ENOMEM;
-	}
-
-	if (array_size(max_pages, sizeof(*pages)) <= CIFS_AIO_KMALLOC_LIMIT)
-		pages = kmalloc_array(max_pages, sizeof(*pages), GFP_KERNEL);
-
-	if (!pages) {
-		pages = vmalloc(array_size(max_pages, sizeof(*pages)));
-		if (!pages) {
-			kvfree(bv);
-			return -ENOMEM;
-		}
-	}
-
-	saved_len = count;
-
-	while (count && npages < max_pages) {
-		rc = iov_iter_get_pages2(iter, pages, count, max_pages, &start);
-		if (rc < 0) {
-			cifs_dbg(VFS, "Couldn't get user pages (rc=%zd)\n", rc);
-			break;
-		}
-
-		if (rc > count) {
-			cifs_dbg(VFS, "get pages rc=%zd more than %zu\n", rc,
-				 count);
-			break;
-		}
-
-		count -= rc;
-		rc += start;
-		cur_npages = DIV_ROUND_UP(rc, PAGE_SIZE);
-
-		if (npages + cur_npages > max_pages) {
-			cifs_dbg(VFS, "out of vec array capacity (%u vs %u)\n",
-				 npages + cur_npages, max_pages);
-			break;
-		}
-
-		for (i = 0; i < cur_npages; i++) {
-			len = rc > PAGE_SIZE ? PAGE_SIZE : rc;
-			bv[npages + i].bv_page = pages[i];
-			bv[npages + i].bv_offset = start;
-			bv[npages + i].bv_len = len - start;
-			rc -= len;
-			start = 0;
-		}
-
-		npages += cur_npages;
-	}
-
-	kvfree(pages);
-	ctx->bv = bv;
-	ctx->len = saved_len - count;
-	ctx->npages = npages;
-	iov_iter_bvec(&ctx->iter, rw, ctx->bv, npages, ctx->len);
-	return 0;
-}
-
 /**
  * cifs_alloc_hash - allocate hash and hash context together
  * @name: The name of the crypto hash algo
@@ -1126,25 +1037,6 @@ cifs_free_hash(struct crypto_shash **shash, struct sdesc **sdesc)
 	*shash = NULL;
 }
 
-/**
- * rqst_page_get_length - obtain the length and offset for a page in smb_rqst
- * @rqst: The request descriptor
- * @page: The index of the page to query
- * @len: Where to store the length for this page:
- * @offset: Where to store the offset for this page
- */
-void rqst_page_get_length(struct smb_rqst *rqst, unsigned int page,
-				unsigned int *len, unsigned int *offset)
-{
-	*len = rqst->rq_pagesz;
-	*offset = (page == 0) ? rqst->rq_offset : 0;
-
-	if (rqst->rq_npages == 1 || page == rqst->rq_npages-1)
-		*len = rqst->rq_tailsz;
-	else if (page == 0)
-		*len = rqst->rq_pagesz - rqst->rq_offset;
-}
-
 void extract_unc_hostname(const char *unc, const char **h, size_t *len)
 {
 	const char *end;
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 96f3b0573606..a6ab69bc1fe5 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -4203,15 +4203,30 @@ fill_transform_hdr(struct smb2_transform_hdr *tr_hdr, unsigned int orig_len,
 static inline void smb2_sg_set_buf(struct scatterlist *sg, const void *buf,
 				   unsigned int buflen)
 {
-	void *addr;
+	struct page *page;
+
 	/*
 	 * VMAP_STACK (at least) puts stack into the vmalloc address space
 	 */
 	if (is_vmalloc_addr(buf))
-		addr = vmalloc_to_page(buf);
+		page = vmalloc_to_page(buf);
 	else
-		addr = virt_to_page(buf);
-	sg_set_page(sg, addr, buflen, offset_in_page(buf));
+		page = virt_to_page(buf);
+	sg_set_page(sg, page, buflen, offset_in_page(buf));
+}
+
+struct cifs_init_sg_priv {
+		struct scatterlist *sg;
+		unsigned int idx;
+};
+
+static ssize_t cifs_init_sg_scan(struct iov_iter *i, const void *p,
+				 size_t len, size_t off, void *_priv)
+{
+	struct cifs_init_sg_priv *priv = _priv;
+
+	smb2_sg_set_buf(&priv->sg[priv->idx++], p, len);
+	return len;
 }
 
 /* Assumes the first rqst has a transform header as the first iov.
@@ -4223,43 +4238,47 @@ static inline void smb2_sg_set_buf(struct scatterlist *sg, const void *buf,
 static struct scatterlist *
 init_sg(int num_rqst, struct smb_rqst *rqst, u8 *sign)
 {
+	struct cifs_init_sg_priv priv;
 	unsigned int sg_len;
-	struct scatterlist *sg;
 	unsigned int i;
 	unsigned int j;
-	unsigned int idx = 0;
+	ssize_t rc;
 	int skip;
 
 	sg_len = 1;
-	for (i = 0; i < num_rqst; i++)
-		sg_len += rqst[i].rq_nvec + rqst[i].rq_npages;
+	for (i = 0; i < num_rqst; i++) {
+		unsigned int np = iov_iter_npages(&rqst[i].rq_iter, INT_MAX);
+
+		sg_len += rqst[i].rq_nvec + np;
+	}
 
-	sg = kmalloc_array(sg_len, sizeof(struct scatterlist), GFP_KERNEL);
-	if (!sg)
+	priv.idx = 0;
+	priv.sg = kmalloc_array(sg_len, sizeof(struct scatterlist), GFP_KERNEL);
+	if (!priv.sg)
 		return NULL;
 
-	sg_init_table(sg, sg_len);
+	sg_init_table(priv.sg, sg_len);
 	for (i = 0; i < num_rqst; i++) {
+		struct iov_iter *iter = &rqst[i].rq_iter;
+		size_t count = iov_iter_count(iter);
+
 		for (j = 0; j < rqst[i].rq_nvec; j++) {
 			/*
 			 * The first rqst has a transform header where the
 			 * first 20 bytes are not part of the encrypted blob
 			 */
 			skip = (i == 0) && (j == 0) ? 20 : 0;
-			smb2_sg_set_buf(&sg[idx++],
+			smb2_sg_set_buf(&priv.sg[priv.idx++],
 					rqst[i].rq_iov[j].iov_base + skip,
 					rqst[i].rq_iov[j].iov_len - skip);
-			}
-
-		for (j = 0; j < rqst[i].rq_npages; j++) {
-			unsigned int len, offset;
-
-			rqst_page_get_length(&rqst[i], j, &len, &offset);
-			sg_set_page(&sg[idx++], rqst[i].rq_pages[j], len, offset);
 		}
+
+		rc = iov_iter_scan(iter, count, cifs_init_sg_scan, &priv);
+		iov_iter_revert(iter, count);
+		WARN_ON(rc < 0);
 	}
-	smb2_sg_set_buf(&sg[idx], sign, SMB2_SIGNATURE_SIZE);
-	return sg;
+	smb2_sg_set_buf(&priv.sg[priv.idx], sign, SMB2_SIGNATURE_SIZE);
+	return priv.sg;
 }
 
 static int
@@ -4398,18 +4417,31 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 	return rc;
 }
 
+/*
+ * Clear a read buffer, discarding the folios which have XA_MARK_0 set.
+ */
+static void cifs_clear_xarray_buffer(struct xarray *buffer)
+{
+	struct folio *folio;
+
+	XA_STATE(xas, buffer, 0);
+
+	rcu_read_lock();
+	xas_for_each_marked(&xas, folio, ULONG_MAX, XA_MARK_0) {
+		folio_put(folio);
+	}
+	rcu_read_unlock();
+	xa_destroy(buffer);
+}
+
 void
 smb3_free_compound_rqst(int num_rqst, struct smb_rqst *rqst)
 {
-	int i, j;
+	int i;
 
-	for (i = 0; i < num_rqst; i++) {
-		if (rqst[i].rq_pages) {
-			for (j = rqst[i].rq_npages - 1; j >= 0; j--)
-				put_page(rqst[i].rq_pages[j]);
-			kfree(rqst[i].rq_pages);
-		}
-	}
+	for (i = 0; i < num_rqst; i++)
+		if (!xa_empty(&rqst[i].rq_buffer))
+			cifs_clear_xarray_buffer(&rqst[i].rq_buffer);
 }
 
 /*
@@ -4429,50 +4461,51 @@ static int
 smb3_init_transform_rq(struct TCP_Server_Info *server, int num_rqst,
 		       struct smb_rqst *new_rq, struct smb_rqst *old_rq)
 {
-	struct page **pages;
 	struct smb2_transform_hdr *tr_hdr = new_rq[0].rq_iov[0].iov_base;
-	unsigned int npages;
+	struct page *page;
 	unsigned int orig_len = 0;
 	int i, j;
 	int rc = -ENOMEM;
 
 	for (i = 1; i < num_rqst; i++) {
-		npages = old_rq[i - 1].rq_npages;
-		pages = kmalloc_array(npages, sizeof(struct page *),
-				      GFP_KERNEL);
-		if (!pages)
-			goto err_free;
-
-		new_rq[i].rq_pages = pages;
-		new_rq[i].rq_npages = npages;
-		new_rq[i].rq_offset = old_rq[i - 1].rq_offset;
-		new_rq[i].rq_pagesz = old_rq[i - 1].rq_pagesz;
-		new_rq[i].rq_tailsz = old_rq[i - 1].rq_tailsz;
-		new_rq[i].rq_iov = old_rq[i - 1].rq_iov;
-		new_rq[i].rq_nvec = old_rq[i - 1].rq_nvec;
-
-		orig_len += smb_rqst_len(server, &old_rq[i - 1]);
-
-		for (j = 0; j < npages; j++) {
-			pages[j] = alloc_page(GFP_KERNEL|__GFP_HIGHMEM);
-			if (!pages[j])
-				goto err_free;
-		}
-
-		/* copy pages form the old */
-		for (j = 0; j < npages; j++) {
-			char *dst, *src;
-			unsigned int offset, len;
-
-			rqst_page_get_length(&new_rq[i], j, &len, &offset);
-
-			dst = (char *) kmap(new_rq[i].rq_pages[j]) + offset;
-			src = (char *) kmap(old_rq[i - 1].rq_pages[j]) + offset;
+		struct smb_rqst *old = &old_rq[i - 1];
+		struct smb_rqst *new = &new_rq[i];
+		struct xarray *buffer = &new->rq_buffer;
+		unsigned int npages;
+		size_t size = iov_iter_count(&old->rq_iter), seg, copied = 0;
+
+		xa_init(buffer);
+
+		if (size > 0) {
+			npages = DIV_ROUND_UP(size, PAGE_SIZE);
+			for (j = 0; j < npages; j++) {
+				void *o;
+
+				rc = -ENOMEM;
+				page = alloc_page(GFP_KERNEL|__GFP_HIGHMEM);
+				if (!page)
+					goto err_free;
+				page->index = j;
+				o = xa_store(buffer, j, page, GFP_KERNEL);
+				if (xa_is_err(o)) {
+					rc = xa_err(o);
+					put_page(page);
+					goto err_free;
+				}
 
-			memcpy(dst, src, len);
-			kunmap(new_rq[i].rq_pages[j]);
-			kunmap(old_rq[i - 1].rq_pages[j]);
+				seg = min_t(size_t, size - copied, PAGE_SIZE);
+				if (copy_page_from_iter(page, 0, seg, &old->rq_iter) != seg) {
+					rc = -EFAULT;
+					goto err_free;
+				}
+				copied += seg;
+			}
+			iov_iter_xarray(&new->rq_iter, iov_iter_rw(&old->rq_iter),
+					buffer, 0, size);
 		}
+		new->rq_iov = old->rq_iov;
+		new->rq_nvec = old->rq_nvec;
+		orig_len += smb_rqst_len(server, new);
 	}
 
 	/* fill the 1st iov with a transform header */
@@ -4500,12 +4533,12 @@ smb3_is_transform_hdr(void *buf)
 
 static int
 decrypt_raw_data(struct TCP_Server_Info *server, char *buf,
-		 unsigned int buf_data_size, struct page **pages,
-		 unsigned int npages, unsigned int page_data_size,
+		 unsigned int buf_data_size, struct iov_iter *iter,
 		 bool is_offloaded)
 {
 	struct kvec iov[2];
 	struct smb_rqst rqst = {NULL};
+	size_t iter_size = 0;
 	int rc;
 
 	iov[0].iov_base = buf;
@@ -4515,10 +4548,10 @@ decrypt_raw_data(struct TCP_Server_Info *server, char *buf,
 
 	rqst.rq_iov = iov;
 	rqst.rq_nvec = 2;
-	rqst.rq_pages = pages;
-	rqst.rq_npages = npages;
-	rqst.rq_pagesz = PAGE_SIZE;
-	rqst.rq_tailsz = (page_data_size % PAGE_SIZE) ? : PAGE_SIZE;
+	if (iter) {
+		rqst.rq_iter = *iter;
+		iter_size = iov_iter_count(iter);
+	}
 
 	rc = crypt_message(server, 1, &rqst, 0);
 	cifs_dbg(FYI, "Decrypt message returned %d\n", rc);
@@ -4529,73 +4562,37 @@ decrypt_raw_data(struct TCP_Server_Info *server, char *buf,
 	memmove(buf, iov[1].iov_base, buf_data_size);
 
 	if (!is_offloaded)
-		server->total_read = buf_data_size + page_data_size;
+		server->total_read = buf_data_size + iter_size;
 
 	return rc;
 }
 
 static int
-read_data_into_pages(struct TCP_Server_Info *server, struct page **pages,
-		     unsigned int npages, unsigned int len)
+cifs_copy_pages_to_iter(struct xarray *pages, unsigned int data_size,
+			unsigned int skip, struct iov_iter *iter)
 {
-	int i;
-	int length;
+	struct page *page;
+	unsigned long index;
 
-	for (i = 0; i < npages; i++) {
-		struct page *page = pages[i];
-		size_t n;
+	xa_for_each(pages, index, page) {
+		size_t n, len = min_t(unsigned int, PAGE_SIZE - skip, data_size);
 
-		n = len;
-		if (len >= PAGE_SIZE) {
-			/* enough data to fill the page */
-			n = PAGE_SIZE;
-			len -= n;
-		} else {
-			zero_user(page, len, PAGE_SIZE - len);
-			len = 0;
+		n = copy_page_to_iter(page, skip, len, iter);
+		if (n != len) {
+			cifs_dbg(VFS, "%s: something went wrong\n", __func__);
+			return -EIO;
 		}
-		length = cifs_read_page_from_socket(server, page, 0, n);
-		if (length < 0)
-			return length;
-		server->total_read += length;
+		data_size -= n;
+		skip = 0;
 	}
 
 	return 0;
 }
 
-static int
-init_read_bvec(struct page **pages, unsigned int npages, unsigned int data_size,
-	       unsigned int cur_off, struct bio_vec **page_vec)
-{
-	struct bio_vec *bvec;
-	int i;
-
-	bvec = kcalloc(npages, sizeof(struct bio_vec), GFP_KERNEL);
-	if (!bvec)
-		return -ENOMEM;
-
-	for (i = 0; i < npages; i++) {
-		bvec[i].bv_page = pages[i];
-		bvec[i].bv_offset = (i == 0) ? cur_off : 0;
-		bvec[i].bv_len = min_t(unsigned int, PAGE_SIZE, data_size);
-		data_size -= bvec[i].bv_len;
-	}
-
-	if (data_size != 0) {
-		cifs_dbg(VFS, "%s: something went wrong\n", __func__);
-		kfree(bvec);
-		return -EIO;
-	}
-
-	*page_vec = bvec;
-	return 0;
-}
-
 static int
 handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
-		 char *buf, unsigned int buf_len, struct page **pages,
-		 unsigned int npages, unsigned int page_data_size,
-		 bool is_offloaded)
+		 char *buf, unsigned int buf_len, struct xarray *pages,
+		 unsigned int pages_len, bool is_offloaded)
 {
 	unsigned int data_offset;
 	unsigned int data_len;
@@ -4604,9 +4601,6 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 	unsigned int pad_len;
 	struct cifs_readdata *rdata = mid->callback_data;
 	struct smb2_hdr *shdr = (struct smb2_hdr *)buf;
-	struct bio_vec *bvec = NULL;
-	struct iov_iter iter;
-	struct kvec iov;
 	int length;
 	bool use_rdma_mr = false;
 
@@ -4695,7 +4689,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 			return 0;
 		}
 
-		if (data_len > page_data_size - pad_len) {
+		if (data_len > pages_len - pad_len) {
 			/* data_len is corrupt -- discard frame */
 			rdata->result = -EIO;
 			if (is_offloaded)
@@ -4705,8 +4699,9 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 			return 0;
 		}
 
-		rdata->result = init_read_bvec(pages, npages, page_data_size,
-					       cur_off, &bvec);
+		/* Copy the data to the output I/O iterator. */
+		rdata->result = cifs_copy_pages_to_iter(pages, pages_len,
+							cur_off, &rdata->iter);
 		if (rdata->result != 0) {
 			if (is_offloaded)
 				mid->mid_state = MID_RESPONSE_MALFORMED;
@@ -4714,14 +4709,16 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 				dequeue_mid(mid, rdata->result);
 			return 0;
 		}
+		rdata->got_bytes = pages_len;
 
-		iov_iter_bvec(&iter, WRITE, bvec, npages, data_len);
 	} else if (buf_len >= data_offset + data_len) {
 		/* read response payload is in buf */
-		WARN_ONCE(npages > 0, "read data can be either in buf or in pages");
-		iov.iov_base = buf + data_offset;
-		iov.iov_len = data_len;
-		iov_iter_kvec(&iter, WRITE, &iov, 1, data_len);
+		WARN_ONCE(pages && !xa_empty(pages),
+			  "read data can be either in buf or in pages");
+		length = copy_to_iter(buf + data_offset, data_len, &rdata->iter);
+		if (length < 0)
+			return length;
+		rdata->got_bytes = data_len;
 	} else {
 		/* read response payload cannot be in both buf and pages */
 		WARN_ONCE(1, "buf can not contain only a part of read data");
@@ -4733,26 +4730,18 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 		return 0;
 	}
 
-	length = rdata->copy_into_pages(server, rdata, &iter);
-
-	kfree(bvec);
-
-	if (length < 0)
-		return length;
-
 	if (is_offloaded)
 		mid->mid_state = MID_RESPONSE_RECEIVED;
 	else
 		dequeue_mid(mid, false);
-	return length;
+	return 0;
 }
 
 struct smb2_decrypt_work {
 	struct work_struct decrypt;
 	struct TCP_Server_Info *server;
-	struct page **ppages;
+	struct xarray buffer;
 	char *buf;
-	unsigned int npages;
 	unsigned int len;
 };
 
@@ -4761,11 +4750,13 @@ static void smb2_decrypt_offload(struct work_struct *work)
 {
 	struct smb2_decrypt_work *dw = container_of(work,
 				struct smb2_decrypt_work, decrypt);
-	int i, rc;
+	int rc;
 	struct mid_q_entry *mid;
+	struct iov_iter iter;
 
+	iov_iter_xarray(&iter, READ, &dw->buffer, 0, dw->len);
 	rc = decrypt_raw_data(dw->server, dw->buf, dw->server->vals->read_rsp_size,
-			      dw->ppages, dw->npages, dw->len, true);
+			      &iter, true);
 	if (rc) {
 		cifs_dbg(VFS, "error decrypting rc=%d\n", rc);
 		goto free_pages;
@@ -4779,7 +4770,7 @@ static void smb2_decrypt_offload(struct work_struct *work)
 		mid->decrypted = true;
 		rc = handle_read_data(dw->server, mid, dw->buf,
 				      dw->server->vals->read_rsp_size,
-				      dw->ppages, dw->npages, dw->len,
+				      &dw->buffer, dw->len,
 				      true);
 		if (rc >= 0) {
 #ifdef CONFIG_CIFS_STATS2
@@ -4812,10 +4803,7 @@ static void smb2_decrypt_offload(struct work_struct *work)
 	}
 
 free_pages:
-	for (i = dw->npages-1; i >= 0; i--)
-		put_page(dw->ppages[i]);
-
-	kfree(dw->ppages);
+	cifs_clear_xarray_buffer(&dw->buffer);
 	cifs_small_buf_release(dw->buf);
 	kfree(dw);
 }
@@ -4825,47 +4813,65 @@ static int
 receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry **mid,
 		       int *num_mids)
 {
+	struct page *page;
 	char *buf = server->smallbuf;
 	struct smb2_transform_hdr *tr_hdr = (struct smb2_transform_hdr *)buf;
-	unsigned int npages;
-	struct page **pages;
-	unsigned int len;
+	struct iov_iter iter;
+	unsigned int len, npages;
 	unsigned int buflen = server->pdu_size;
 	int rc;
 	int i = 0;
 	struct smb2_decrypt_work *dw;
 
+	dw = kzalloc(sizeof(struct smb2_decrypt_work), GFP_KERNEL);
+	if (!dw)
+		return -ENOMEM;
+	xa_init(&dw->buffer);
+	INIT_WORK(&dw->decrypt, smb2_decrypt_offload);
+	dw->server = server;
+
 	*num_mids = 1;
 	len = min_t(unsigned int, buflen, server->vals->read_rsp_size +
 		sizeof(struct smb2_transform_hdr)) - HEADER_SIZE(server) + 1;
 
 	rc = cifs_read_from_socket(server, buf + HEADER_SIZE(server) - 1, len);
 	if (rc < 0)
-		return rc;
+		goto free_dw;
 	server->total_read += rc;
 
 	len = le32_to_cpu(tr_hdr->OriginalMessageSize) -
 		server->vals->read_rsp_size;
+	dw->len = len;
 	npages = DIV_ROUND_UP(len, PAGE_SIZE);
 
-	pages = kmalloc_array(npages, sizeof(struct page *), GFP_KERNEL);
-	if (!pages) {
-		rc = -ENOMEM;
-		goto discard_data;
-	}
-
+	rc = -ENOMEM;
 	for (; i < npages; i++) {
-		pages[i] = alloc_page(GFP_KERNEL|__GFP_HIGHMEM);
-		if (!pages[i]) {
-			rc = -ENOMEM;
+		void *old;
+
+		page = alloc_page(GFP_KERNEL|__GFP_HIGHMEM);
+		if (!page)
+			goto discard_data;
+		page->index = i;
+		old = xa_store(&dw->buffer, i, page, GFP_KERNEL);
+		if (xa_is_err(old)) {
+			rc = xa_err(old);
+			put_page(page);
 			goto discard_data;
 		}
 	}
 
-	/* read read data into pages */
-	rc = read_data_into_pages(server, pages, npages, len);
-	if (rc)
-		goto free_pages;
+	iov_iter_xarray(&iter, READ, &dw->buffer, 0, npages * PAGE_SIZE);
+
+	/* Read the data into the buffer and clear excess bufferage. */
+	rc = cifs_read_iter_from_socket(server, &iter, dw->len);
+	if (rc < 0)
+		goto discard_data;
+
+	server->total_read += rc;
+	if (rc < npages * PAGE_SIZE)
+		iov_iter_zero(npages * PAGE_SIZE - rc, &iter);
+	iov_iter_revert(&iter, npages * PAGE_SIZE);
+	iov_iter_truncate(&iter, dw->len);
 
 	rc = cifs_discard_remaining_data(server);
 	if (rc)
@@ -4878,39 +4884,28 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry **mid,
 
 	if ((server->min_offload) && (server->in_flight > 1) &&
 	    (server->pdu_size >= server->min_offload)) {
-		dw = kmalloc(sizeof(struct smb2_decrypt_work), GFP_KERNEL);
-		if (dw == NULL)
-			goto non_offloaded_decrypt;
-
 		dw->buf = server->smallbuf;
 		server->smallbuf = (char *)cifs_small_buf_get();
 
-		INIT_WORK(&dw->decrypt, smb2_decrypt_offload);
-
-		dw->npages = npages;
-		dw->server = server;
-		dw->ppages = pages;
-		dw->len = len;
 		queue_work(decrypt_wq, &dw->decrypt);
 		*num_mids = 0; /* worker thread takes care of finding mid */
 		return -1;
 	}
 
-non_offloaded_decrypt:
 	rc = decrypt_raw_data(server, buf, server->vals->read_rsp_size,
-			      pages, npages, len, false);
+			      &iter, false);
 	if (rc)
 		goto free_pages;
 
 	*mid = smb2_find_mid(server, buf);
-	if (*mid == NULL)
+	if (*mid == NULL) {
 		cifs_dbg(FYI, "mid not found\n");
-	else {
+	} else {
 		cifs_dbg(FYI, "mid found\n");
 		(*mid)->decrypted = true;
 		rc = handle_read_data(server, *mid, buf,
 				      server->vals->read_rsp_size,
-				      pages, npages, len, false);
+				      &dw->buffer, dw->len, false);
 		if (rc >= 0) {
 			if (server->ops->is_network_name_deleted) {
 				server->ops->is_network_name_deleted(buf,
@@ -4920,9 +4915,9 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry **mid,
 	}
 
 free_pages:
-	for (i = i - 1; i >= 0; i--)
-		put_page(pages[i]);
-	kfree(pages);
+	cifs_clear_xarray_buffer(&dw->buffer);
+free_dw:
+	kfree(dw);
 	return rc;
 discard_data:
 	cifs_discard_remaining_data(server);
@@ -4960,7 +4955,7 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 	server->total_read += length;
 
 	buf_size = pdu_length - sizeof(struct smb2_transform_hdr);
-	length = decrypt_raw_data(server, buf, buf_size, NULL, 0, 0, false);
+	length = decrypt_raw_data(server, buf, buf_size, NULL, false);
 	if (length)
 		return length;
 
@@ -5059,7 +5054,7 @@ smb3_handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 	char *buf = server->large_buf ? server->bigbuf : server->smallbuf;
 
 	return handle_read_data(server, mid, buf, server->pdu_size,
-				NULL, 0, 0, false);
+				NULL, 0, false);
 }
 
 static int
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 91cfc5b47ac7..4d29b1332280 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -4067,10 +4067,8 @@ smb2_new_read_req(void **buf, unsigned int *total_len,
 		struct smbd_buffer_descriptor_v1 *v1;
 		bool need_invalidate = server->dialect == SMB30_PROT_ID;
 
-		rdata->mr = smbd_register_mr(
-				server->smbd_conn, rdata->pages,
-				rdata->nr_pages, rdata->page_offset,
-				rdata->tailsz, true, need_invalidate);
+		rdata->mr = smbd_register_mr(server->smbd_conn, &rdata->iter,
+					     true, need_invalidate);
 		if (!rdata->mr)
 			return -EAGAIN;
 
@@ -4128,11 +4126,7 @@ smb2_readv_callback(struct mid_q_entry *mid)
 	struct cifs_credits credits = { .value = 0, .instance = 0 };
 	struct smb_rqst rqst = { .rq_iov = &rdata->iov[1],
 				 .rq_nvec = 1,
-				 .rq_pages = rdata->pages,
-				 .rq_offset = rdata->page_offset,
-				 .rq_npages = rdata->nr_pages,
-				 .rq_pagesz = rdata->pagesz,
-				 .rq_tailsz = rdata->tailsz };
+				 .rq_iter = rdata->iter };
 
 	WARN_ONCE(rdata->server != mid->server,
 		  "rdata server %p != mid server %p",
@@ -4475,7 +4469,7 @@ smb2_async_writev(struct cifs_writedata *wdata,
 	req->VolatileFileId = wdata->cfile->fid.volatile_fid;
 	req->WriteChannelInfoOffset = 0;
 	req->WriteChannelInfoLength = 0;
-	req->Channel = 0;
+	req->Channel = SMB2_CHANNEL_NONE;
 	req->Offset = cpu_to_le64(wdata->offset);
 	req->DataOffset = cpu_to_le16(
 				offsetof(struct smb2_write_req, Buffer));
@@ -4492,26 +4486,18 @@ smb2_async_writev(struct cifs_writedata *wdata,
 		server->smbd_conn->rdma_readwrite_threshold) {
 
 		struct smbd_buffer_descriptor_v1 *v1;
+		size_t data_size = iov_iter_count(&wdata->iter);
 		bool need_invalidate = server->dialect == SMB30_PROT_ID;
 
-		wdata->mr = smbd_register_mr(
-				server->smbd_conn, wdata->pages,
-				wdata->nr_pages, wdata->page_offset,
-				wdata->tailsz, false, need_invalidate);
+		wdata->mr = smbd_register_mr(server->smbd_conn, &wdata->iter,
+					     false, need_invalidate);
 		if (!wdata->mr) {
 			rc = -EAGAIN;
 			goto async_writev_out;
 		}
 		req->Length = 0;
 		req->DataOffset = 0;
-		if (wdata->nr_pages > 1)
-			req->RemainingBytes =
-				cpu_to_le32(
-					(wdata->nr_pages - 1) * wdata->pagesz -
-					wdata->page_offset + wdata->tailsz
-				);
-		else
-			req->RemainingBytes = cpu_to_le32(wdata->tailsz);
+		req->RemainingBytes = cpu_to_le32(data_size);
 		req->Channel = SMB2_CHANNEL_RDMA_V1_INVALIDATE;
 		if (need_invalidate)
 			req->Channel = SMB2_CHANNEL_RDMA_V1;
@@ -4530,19 +4516,13 @@ smb2_async_writev(struct cifs_writedata *wdata,
 
 	rqst.rq_iov = iov;
 	rqst.rq_nvec = 1;
-	rqst.rq_pages = wdata->pages;
-	rqst.rq_offset = wdata->page_offset;
-	rqst.rq_npages = wdata->nr_pages;
-	rqst.rq_pagesz = wdata->pagesz;
-	rqst.rq_tailsz = wdata->tailsz;
+	rqst.rq_iter = wdata->iter;
 #ifdef CONFIG_CIFS_SMB_DIRECT
-	if (wdata->mr) {
+	if (wdata->mr)
 		iov[0].iov_len += sizeof(struct smbd_buffer_descriptor_v1);
-		rqst.rq_npages = 0;
-	}
 #endif
-	cifs_dbg(FYI, "async write at %llu %u bytes\n",
-		 wdata->offset, wdata->bytes);
+	cifs_dbg(FYI, "async write at %llu %u bytes iter=%zx\n",
+		 wdata->offset, wdata->bytes, iov_iter_count(&rqst.rq_iter));
 
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	/* For RDMA read, I/O size is in RemainingBytes not in Length */
diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index 5fbbec22bcc8..578c24d5a941 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -34,12 +34,6 @@ static int smbd_post_recv(
 		struct smbd_response *response);
 
 static int smbd_post_send_empty(struct smbd_connection *info);
-static int smbd_post_send_data(
-		struct smbd_connection *info,
-		struct kvec *iov, int n_vec, int remaining_data_length);
-static int smbd_post_send_page(struct smbd_connection *info,
-		struct page *page, unsigned long offset,
-		size_t size, int remaining_data_length);
 
 static void destroy_mr_list(struct smbd_connection *info);
 static int allocate_mr_list(struct smbd_connection *info);
@@ -975,24 +969,6 @@ static int smbd_post_send_sgl(struct smbd_connection *info,
 	return rc;
 }
 
-/*
- * Send a page
- * page: the page to send
- * offset: offset in the page to send
- * size: length in the page to send
- * remaining_data_length: remaining data to send in this payload
- */
-static int smbd_post_send_page(struct smbd_connection *info, struct page *page,
-		unsigned long offset, size_t size, int remaining_data_length)
-{
-	struct scatterlist sgl;
-
-	sg_init_table(&sgl, 1);
-	sg_set_page(&sgl, page, size, offset);
-
-	return smbd_post_send_sgl(info, &sgl, size, remaining_data_length);
-}
-
 /*
  * Send an empty message
  * Empty message is used to extend credits to peer to for keep live
@@ -1004,35 +980,6 @@ static int smbd_post_send_empty(struct smbd_connection *info)
 	return smbd_post_send_sgl(info, NULL, 0, 0);
 }
 
-/*
- * Send a data buffer
- * iov: the iov array describing the data buffers
- * n_vec: number of iov array
- * remaining_data_length: remaining data to send following this packet
- * in segmented SMBD packet
- */
-static int smbd_post_send_data(
-	struct smbd_connection *info, struct kvec *iov, int n_vec,
-	int remaining_data_length)
-{
-	int i;
-	u32 data_length = 0;
-	struct scatterlist sgl[SMBDIRECT_MAX_SGE];
-
-	if (n_vec > SMBDIRECT_MAX_SGE) {
-		cifs_dbg(VFS, "Can't fit data to SGL, n_vec=%d\n", n_vec);
-		return -EINVAL;
-	}
-
-	sg_init_table(sgl, n_vec);
-	for (i = 0; i < n_vec; i++) {
-		data_length += iov[i].iov_len;
-		sg_set_buf(&sgl[i], iov[i].iov_base, iov[i].iov_len);
-	}
-
-	return smbd_post_send_sgl(info, sgl, data_length, remaining_data_length);
-}
-
 /*
  * Post a receive request to the transport
  * The remote peer can only send data when a receive request is posted
@@ -1976,6 +1923,68 @@ int smbd_recv(struct smbd_connection *info, struct msghdr *msg)
 	return rc;
 }
 
+struct smbd_post_send_iter_context {
+	struct scatterlist	sgl[SMBDIRECT_MAX_SGE - 1];
+	unsigned int		nsg;
+	unsigned int		len;
+	int			num_rqst;
+	int			rqst_idx;
+	int			*_remaining_data_length;
+};
+
+static ssize_t smbd_post_send_iter_scanner(struct iov_iter *iter, const void *p,
+					   size_t len, size_t offset, void *priv)
+{
+	struct smbd_post_send_iter_context *ctx = priv;
+	unsigned int ix = ctx->nsg;
+
+	if (ctx->nsg >= ARRAY_SIZE(ctx->sgl))
+		return -1;
+
+	sg_set_buf(&ctx->sgl[ix], p, len);
+	ctx->len += len;
+	log_write(INFO, "sending page i=%d offset=%zu size=%zu remaining_data_length=%d\n",
+		  ix, offset, len, *ctx->_remaining_data_length);
+	*ctx->_remaining_data_length -= len;
+	ctx->nsg++;
+	return len;
+}
+
+/*
+ * Send the contents of an iterator
+ * @iter: The iterator to send
+ * @_remaining_data_length: remaining data to send in this payload
+ */
+static int smbd_post_send_iter(struct smbd_connection *info,
+			       struct iov_iter *iter,
+			       int num_rqst, int rqst_idx,
+			       int *_remaining_data_length)
+{
+	struct smbd_post_send_iter_context ctx;
+	unsigned int max_payload = info->max_send_size - sizeof(struct smbd_data_transfer);
+	int rc;
+
+	ctx.num_rqst = num_rqst;
+	ctx.rqst_idx = rqst_idx;
+	ctx._remaining_data_length = _remaining_data_length;
+
+	do {
+		size_t maxlen = min_t(size_t, *_remaining_data_length, max_payload);
+
+		sg_init_table(ctx.sgl, ARRAY_SIZE(ctx.sgl));
+		ctx.nsg = 0;
+		ctx.len = 0;
+		rc = iov_iter_scan(iter, maxlen, smbd_post_send_iter_scanner, &ctx);
+		if (WARN_ON(!ctx.nsg))
+			return -EIO;
+		sg_mark_end(&ctx.sgl[ctx.nsg - 1]);
+
+		rc = smbd_post_send_sgl(info, ctx.sgl, ctx.len, *_remaining_data_length);
+	} while (rc == 0 && iov_iter_count(iter) > 0);
+
+	return rc;
+}
+
 /*
  * Send data to transport
  * Each rqst is transported as a SMBDirect payload
@@ -1986,17 +1995,10 @@ int smbd_send(struct TCP_Server_Info *server,
 	int num_rqst, struct smb_rqst *rqst_array)
 {
 	struct smbd_connection *info = server->smbd_conn;
-	struct kvec vec;
-	int nvecs;
-	int size;
-	unsigned int buflen, remaining_data_length;
-	int start, i, j;
-	int max_iov_size =
-		info->max_send_size - sizeof(struct smbd_data_transfer);
-	struct kvec *iov;
-	int rc;
 	struct smb_rqst *rqst;
-	int rqst_idx;
+	struct iov_iter iter;
+	unsigned int remaining_data_length, klen;
+	int rc, i, rqst_idx;
 
 	if (info->transport_status != SMBD_CONNECTED) {
 		rc = -EAGAIN;
@@ -2025,107 +2027,33 @@ int smbd_send(struct TCP_Server_Info *server,
 	rqst_idx = 0;
 next_rqst:
 	rqst = &rqst_array[rqst_idx];
-	iov = rqst->rq_iov;
 
 	cifs_dbg(FYI, "Sending smb (RDMA): idx=%d smb_len=%lu\n",
 		rqst_idx, smb_rqst_len(server, rqst));
 	for (i = 0; i < rqst->rq_nvec; i++)
-		dump_smb(iov[i].iov_base, iov[i].iov_len);
-
-
-	log_write(INFO, "rqst_idx=%d nvec=%d rqst->rq_npages=%d rq_pagesz=%d rq_tailsz=%d buflen=%lu\n",
-		  rqst_idx, rqst->rq_nvec, rqst->rq_npages, rqst->rq_pagesz,
-		  rqst->rq_tailsz, smb_rqst_len(server, rqst));
-
-	start = i = 0;
-	buflen = 0;
-	while (true) {
-		buflen += iov[i].iov_len;
-		if (buflen > max_iov_size) {
-			if (i > start) {
-				remaining_data_length -=
-					(buflen-iov[i].iov_len);
-				log_write(INFO, "sending iov[] from start=%d i=%d nvecs=%d remaining_data_length=%d\n",
-					  start, i, i - start,
-					  remaining_data_length);
-				rc = smbd_post_send_data(
-					info, &iov[start], i-start,
-					remaining_data_length);
-				if (rc)
-					goto done;
-			} else {
-				/* iov[start] is too big, break it */
-				nvecs = (buflen+max_iov_size-1)/max_iov_size;
-				log_write(INFO, "iov[%d] iov_base=%p buflen=%d break to %d vectors\n",
-					  start, iov[start].iov_base,
-					  buflen, nvecs);
-				for (j = 0; j < nvecs; j++) {
-					vec.iov_base =
-						(char *)iov[start].iov_base +
-						j*max_iov_size;
-					vec.iov_len = max_iov_size;
-					if (j == nvecs-1)
-						vec.iov_len =
-							buflen -
-							max_iov_size*(nvecs-1);
-					remaining_data_length -= vec.iov_len;
-					log_write(INFO,
-						"sending vec j=%d iov_base=%p iov_len=%zu remaining_data_length=%d\n",
-						  j, vec.iov_base, vec.iov_len,
-						  remaining_data_length);
-					rc = smbd_post_send_data(
-						info, &vec, 1,
-						remaining_data_length);
-					if (rc)
-						goto done;
-				}
-				i++;
-				if (i == rqst->rq_nvec)
-					break;
-			}
-			start = i;
-			buflen = 0;
-		} else {
-			i++;
-			if (i == rqst->rq_nvec) {
-				/* send out all remaining vecs */
-				remaining_data_length -= buflen;
-				log_write(INFO, "sending iov[] from start=%d i=%d nvecs=%d remaining_data_length=%d\n",
-					  start, i, i - start,
-					  remaining_data_length);
-				rc = smbd_post_send_data(info, &iov[start],
-					i-start, remaining_data_length);
-				if (rc)
-					goto done;
-				break;
-			}
-		}
-		log_write(INFO, "looping i=%d buflen=%d\n", i, buflen);
-	}
-
-	/* now sending pages if there are any */
-	for (i = 0; i < rqst->rq_npages; i++) {
-		unsigned int offset;
-
-		rqst_page_get_length(rqst, i, &buflen, &offset);
-		nvecs = (buflen + max_iov_size - 1) / max_iov_size;
-		log_write(INFO, "sending pages buflen=%d nvecs=%d\n",
-			buflen, nvecs);
-		for (j = 0; j < nvecs; j++) {
-			size = max_iov_size;
-			if (j == nvecs-1)
-				size = buflen - j*max_iov_size;
-			remaining_data_length -= size;
-			log_write(INFO, "sending pages i=%d offset=%d size=%d remaining_data_length=%d\n",
-				  i, j * max_iov_size + offset, size,
-				  remaining_data_length);
-			rc = smbd_post_send_page(
-				info, rqst->rq_pages[i],
-				j*max_iov_size + offset,
-				size, remaining_data_length);
-			if (rc)
-				goto done;
-		}
+		dump_smb(rqst->rq_iov[i].iov_base, rqst->rq_iov[i].iov_len);
+
+	log_write(INFO, "RDMA-WR[%u] nvec=%d len=%u iter=%zu rqlen=%lu\n",
+		  rqst_idx, rqst->rq_nvec, remaining_data_length,
+		  iov_iter_count(&rqst->rq_iter), smb_rqst_len(server, rqst));
+
+	/* Send the metadata pages. */
+	klen = 0;
+	for (i = 0; i < rqst->rq_nvec; i++)
+		klen += rqst->rq_iov[i].iov_len;
+	iov_iter_kvec(&iter, WRITE, rqst->rq_iov, rqst->rq_nvec, klen);
+
+	rc = smbd_post_send_iter(info, &iter, num_rqst, rqst_idx,
+				 &remaining_data_length);
+	if (rc < 0)
+		goto done;
+
+	if (iov_iter_count(&rqst->rq_iter) > 0) {
+		/* And then the data pages if there are any */
+		rc = smbd_post_send_iter(info, &rqst->rq_iter, num_rqst, rqst_idx,
+					 &remaining_data_length);
+		if (rc < 0)
+			goto done;
 	}
 
 	rqst_idx++;
@@ -2336,6 +2264,48 @@ static struct smbd_mr *get_mr(struct smbd_connection *info)
 	goto again;
 }
 
+struct smbd_iter_to_mr_context {
+	struct scatterlist *sgl;
+	unsigned int nsg;
+	unsigned int max_sg;
+};
+
+static ssize_t smbd_iter_to_mr_scanner(struct iov_iter *iter, const void *p,
+				       size_t len, size_t offset, void *priv)
+{
+	struct smbd_iter_to_mr_context *ctx = priv;
+	unsigned int ix = ctx->nsg;
+
+	if (WARN_ON(ctx->nsg >= ctx->max_sg))
+		return -EIO;
+
+	sg_set_buf(&ctx->sgl[ix], p, len);
+	log_write(INFO, "sending page i=%d offset=%zu size=%zu\n",
+		  ix, offset, len);
+	ctx->nsg++;
+	return len;
+}
+
+/*
+ * Transcribe the pages from an iterator into an MR scatterlist.
+ * @iter: The iterator to transcribe
+ * @_remaining_data_length: remaining data to send in this payload
+ */
+static int smbd_iter_to_mr(struct smbd_connection *info,
+			   struct iov_iter *iter,
+			   struct scatterlist *sgl,
+			   unsigned int num_pages)
+{
+	struct smbd_iter_to_mr_context ctx;
+
+	ctx.sgl = sgl;
+	ctx.nsg = 0;
+	ctx.max_sg = num_pages;
+	sg_init_table(sgl, num_pages);
+
+	return iov_iter_scan(iter, iov_iter_count(iter), smbd_iter_to_mr_scanner, &ctx);
+}
+
 /*
  * Register memory for RDMA read/write
  * pages[]: the list of pages to register memory with
@@ -2346,17 +2316,19 @@ static struct smbd_mr *get_mr(struct smbd_connection *info)
  * return value: the MR registered, NULL if failed.
  */
 struct smbd_mr *smbd_register_mr(
-	struct smbd_connection *info, struct page *pages[], int num_pages,
-	int offset, int tailsz, bool writing, bool need_invalidate)
+	struct smbd_connection *info, struct iov_iter *iter,
+	bool writing, bool need_invalidate)
 {
 	struct smbd_mr *smbdirect_mr;
-	int rc, i;
+	int rc, num_pages;
 	enum dma_data_direction dir;
 	struct ib_reg_wr *reg_wr;
 
+	num_pages = iov_iter_npages(iter, info->max_frmr_depth + 1);
 	if (num_pages > info->max_frmr_depth) {
 		log_rdma_mr(ERR, "num_pages=%d max_frmr_depth=%d\n",
 			num_pages, info->max_frmr_depth);
+		WARN_ON_ONCE(1);
 		return NULL;
 	}
 
@@ -2365,32 +2337,16 @@ struct smbd_mr *smbd_register_mr(
 		log_rdma_mr(ERR, "get_mr returning NULL\n");
 		return NULL;
 	}
+
+	dir = writing ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
+	smbdirect_mr->dir = dir;
 	smbdirect_mr->need_invalidate = need_invalidate;
 	smbdirect_mr->sgl_count = num_pages;
-	sg_init_table(smbdirect_mr->sgl, num_pages);
 
-	log_rdma_mr(INFO, "num_pages=0x%x offset=0x%x tailsz=0x%x\n",
-			num_pages, offset, tailsz);
-
-	if (num_pages == 1) {
-		sg_set_page(&smbdirect_mr->sgl[0], pages[0], tailsz, offset);
-		goto skip_multiple_pages;
-	}
+	log_rdma_mr(INFO, "num_pages=0x%x count=0x%zx\n",
+		    num_pages, iov_iter_count(iter));
+	smbd_iter_to_mr(info, iter, smbdirect_mr->sgl, num_pages);
 
-	/* We have at least two pages to register */
-	sg_set_page(
-		&smbdirect_mr->sgl[0], pages[0], PAGE_SIZE - offset, offset);
-	i = 1;
-	while (i < num_pages - 1) {
-		sg_set_page(&smbdirect_mr->sgl[i], pages[i], PAGE_SIZE, 0);
-		i++;
-	}
-	sg_set_page(&smbdirect_mr->sgl[i], pages[i],
-		tailsz ? tailsz : PAGE_SIZE, 0);
-
-skip_multiple_pages:
-	dir = writing ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
-	smbdirect_mr->dir = dir;
 	rc = ib_dma_map_sg(info->id->device, smbdirect_mr->sgl, num_pages, dir);
 	if (!rc) {
 		log_rdma_mr(ERR, "ib_dma_map_sg num_pages=%x dir=%x rc=%x\n",
diff --git a/fs/cifs/smbdirect.h b/fs/cifs/smbdirect.h
index a87fca82a796..3a0d39e148e8 100644
--- a/fs/cifs/smbdirect.h
+++ b/fs/cifs/smbdirect.h
@@ -298,8 +298,8 @@ struct smbd_mr {
 
 /* Interfaces to register and deregister MR for RDMA read/write */
 struct smbd_mr *smbd_register_mr(
-	struct smbd_connection *info, struct page *pages[], int num_pages,
-	int offset, int tailsz, bool writing, bool need_invalidate);
+	struct smbd_connection *info, struct iov_iter *iter,
+	bool writing, bool need_invalidate);
 int smbd_deregister_mr(struct smbd_mr *mr);
 
 #else
diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index de7aeced7e16..124494568bbc 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -274,26 +274,7 @@ smb_rqst_len(struct TCP_Server_Info *server, struct smb_rqst *rqst)
 	for (i = 0; i < nvec; i++)
 		buflen += iov[i].iov_len;
 
-	/*
-	 * Add in the page array if there is one. The caller needs to make
-	 * sure rq_offset and rq_tailsz are set correctly. If a buffer of
-	 * multiple pages ends at page boundary, rq_tailsz needs to be set to
-	 * PAGE_SIZE.
-	 */
-	if (rqst->rq_npages) {
-		if (rqst->rq_npages == 1)
-			buflen += rqst->rq_tailsz;
-		else {
-			/*
-			 * If there is more than one page, calculate the
-			 * buffer length based on rq_offset and rq_tailsz
-			 */
-			buflen += rqst->rq_pagesz * (rqst->rq_npages - 1) -
-					rqst->rq_offset;
-			buflen += rqst->rq_tailsz;
-		}
-	}
-
+	buflen += iov_iter_count(&rqst->rq_iter);
 	return buflen;
 }
 
@@ -380,23 +361,15 @@ __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 
 		total_len += sent;
 
-		/* now walk the page array and send each page in it */
-		for (i = 0; i < rqst[j].rq_npages; i++) {
-			struct bio_vec bvec;
-
-			bvec.bv_page = rqst[j].rq_pages[i];
-			rqst_page_get_length(&rqst[j], i, &bvec.bv_len,
-					     &bvec.bv_offset);
-
-			iov_iter_bvec(&smb_msg.msg_iter, WRITE,
-				      &bvec, 1, bvec.bv_len);
+		if (iov_iter_count(&rqst[j].rq_iter) > 0) {
+			smb_msg.msg_iter = rqst[j].rq_iter;
 			rc = smb_send_kvec(server, &smb_msg, &sent);
 			if (rc < 0)
 				break;
-
 			total_len += sent;
 		}
-	}
+
+}
 
 unmask:
 	sigprocmask(SIG_SETMASK, &oldmask, NULL);
@@ -1643,11 +1616,11 @@ int
 cifs_discard_remaining_data(struct TCP_Server_Info *server)
 {
 	unsigned int rfclen = server->pdu_size;
-	int remaining = rfclen + server->vals->header_preamble_size -
+	size_t remaining = rfclen + server->vals->header_preamble_size -
 		server->total_read;
 
 	while (remaining > 0) {
-		int length;
+		ssize_t length;
 
 		length = cifs_discard_from_socket(server,
 				min_t(size_t, remaining,
@@ -1794,10 +1767,15 @@ cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 		return cifs_readv_discard(server, mid);
 	}
 
-	length = rdata->read_into_pages(server, rdata, data_len);
-	if (length < 0)
-		return length;
-
+#ifdef CONFIG_CIFS_SMB_DIRECT
+	if (rdata->mr)
+		length = data_len; /* An RDMA read is already done. */
+	else
+#endif
+		length = cifs_read_iter_from_socket(server, &rdata->iter,
+						    data_len);
+	if (length > 0)
+		rdata->got_bytes += length;
 	server->total_read += length;
 
 	cifs_dbg(FYI, "total_read=%u buflen=%u remaining=%u\n",


