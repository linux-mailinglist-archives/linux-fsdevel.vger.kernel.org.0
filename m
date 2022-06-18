Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED715502FA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 07:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237324AbiFRFgY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 01:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbiFRFfw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 01:35:52 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687BD68315
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 22:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rJnvd3gxx0323F5XV/MaNwH0y9IWGe1FKJo6f70OOso=; b=OYC9h7Z5rvx8X6/vIpitByZa9a
        3Bs5DrTkBAR7SDgeuL6sTVvgsuqfNmbXBTakwH3TjRL4FPFj0NPzK48ccMoUpASOXCpTpamyFaPuH
        0fFkg6SGnvNcdC/VPQqVjsiBBeZ+kzJkAEOvF04SImFXFVie1WPM68R75zUrRfHaWKJmsc1VyxO2J
        /8civcOzOHAIcRFnbOOBc2cJPOTfhL/X0zNGM8balxh4qX/GK/QkNiZYX18xDvlG57tfYVQV8fpb0
        MKtJ4x4qNJSzZGcvVQWQCpCXfIDSvZSBVciiuu5YuywaCmFd6Mz3Ij1S9WoZH97BDbjjMohSCi0TE
        DSLt6hfQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2R7W-001VRM-PU;
        Sat, 18 Jun 2022 05:35:42 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 23/31] iov_iter: advancing variants of iov_iter_get_pages{,_alloc}()
Date:   Sat, 18 Jun 2022 06:35:30 +0100
Message-Id: <20220618053538.359065-24-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220618053538.359065-1-viro@zeniv.linux.org.uk>
References: <Yq1iNHboD+9fz60M@ZenIV>
 <20220618053538.359065-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Most of the users immediately follow successful iov_iter_get_pages()
with advancing by the amount it had returned.

Provide inline wrappers doing that, convert trivial open-coded
uses of those.

BTW, iov_iter_get_pages() never returns more than it had been asked
to; such checks in cifs ought to be removed someday...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/vhost/scsi.c |  4 +---
 fs/ceph/file.c       |  3 +--
 fs/cifs/file.c       |  6 ++----
 fs/cifs/misc.c       |  3 +--
 fs/direct-io.c       |  3 +--
 fs/fuse/dev.c        |  3 +--
 fs/fuse/file.c       |  3 +--
 fs/nfs/direct.c      |  6 ++----
 include/linux/uio.h  | 20 ++++++++++++++++++++
 net/core/datagram.c  |  3 +--
 net/core/skmsg.c     |  3 +--
 net/rds/message.c    |  3 +--
 net/tls/tls_sw.c     |  4 +---
 13 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index ffd9e6c2ffc1..9b65509424dc 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -643,14 +643,12 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
 	size_t offset;
 	unsigned int npages = 0;
 
-	bytes = iov_iter_get_pages(iter, pages, LONG_MAX,
+	bytes = iov_iter_get_pages2(iter, pages, LONG_MAX,
 				VHOST_SCSI_PREALLOC_UPAGES, &offset);
 	/* No pages were pinned */
 	if (bytes <= 0)
 		return bytes < 0 ? bytes : -EFAULT;
 
-	iov_iter_advance(iter, bytes);
-
 	while (bytes) {
 		unsigned n = min_t(unsigned, PAGE_SIZE - offset, bytes);
 		sg_set_page(sg++, pages[npages++], n, offset);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index c535de5852bf..8fab5db16c73 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -95,12 +95,11 @@ static ssize_t __iter_get_bvecs(struct iov_iter *iter, size_t maxsize,
 		size_t start;
 		int idx = 0;
 
-		bytes = iov_iter_get_pages(iter, pages, maxsize - size,
+		bytes = iov_iter_get_pages2(iter, pages, maxsize - size,
 					   ITER_GET_BVECS_PAGES, &start);
 		if (bytes < 0)
 			return size ?: bytes;
 
-		iov_iter_advance(iter, bytes);
 		size += bytes;
 
 		for ( ; bytes; idx++, bvec_idx++) {
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index e1e05b253daa..3ba013e2987f 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3022,7 +3022,7 @@ cifs_write_from_iter(loff_t offset, size_t len, struct iov_iter *from,
 		if (ctx->direct_io) {
 			ssize_t result;
 
-			result = iov_iter_get_pages_alloc(
+			result = iov_iter_get_pages_alloc2(
 				from, &pagevec, cur_len, &start);
 			if (result < 0) {
 				cifs_dbg(VFS,
@@ -3036,7 +3036,6 @@ cifs_write_from_iter(loff_t offset, size_t len, struct iov_iter *from,
 				break;
 			}
 			cur_len = (size_t)result;
-			iov_iter_advance(from, cur_len);
 
 			nr_pages =
 				(cur_len + start + PAGE_SIZE - 1) / PAGE_SIZE;
@@ -3758,7 +3757,7 @@ cifs_send_async_read(loff_t offset, size_t len, struct cifsFileInfo *open_file,
 		if (ctx->direct_io) {
 			ssize_t result;
 
-			result = iov_iter_get_pages_alloc(
+			result = iov_iter_get_pages_alloc2(
 					&direct_iov, &pagevec,
 					cur_len, &start);
 			if (result < 0) {
@@ -3774,7 +3773,6 @@ cifs_send_async_read(loff_t offset, size_t len, struct cifsFileInfo *open_file,
 				break;
 			}
 			cur_len = (size_t)result;
-			iov_iter_advance(&direct_iov, cur_len);
 
 			rdata = cifs_readdata_direct_alloc(
 					pagevec, cifs_uncached_readv_complete);
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index c69e1240d730..37493118fb72 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -1022,7 +1022,7 @@ setup_aio_ctx_iter(struct cifs_aio_ctx *ctx, struct iov_iter *iter, int rw)
 	saved_len = count;
 
 	while (count && npages < max_pages) {
-		rc = iov_iter_get_pages(iter, pages, count, max_pages, &start);
+		rc = iov_iter_get_pages2(iter, pages, count, max_pages, &start);
 		if (rc < 0) {
 			cifs_dbg(VFS, "Couldn't get user pages (rc=%zd)\n", rc);
 			break;
@@ -1034,7 +1034,6 @@ setup_aio_ctx_iter(struct cifs_aio_ctx *ctx, struct iov_iter *iter, int rw)
 			break;
 		}
 
-		iov_iter_advance(iter, rc);
 		count -= rc;
 		rc += start;
 		cur_npages = DIV_ROUND_UP(rc, PAGE_SIZE);
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 72237f49ad94..9724244f12ce 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -169,7 +169,7 @@ static inline int dio_refill_pages(struct dio *dio, struct dio_submit *sdio)
 {
 	ssize_t ret;
 
-	ret = iov_iter_get_pages(sdio->iter, dio->pages, LONG_MAX, DIO_PAGES,
+	ret = iov_iter_get_pages2(sdio->iter, dio->pages, LONG_MAX, DIO_PAGES,
 				&sdio->from);
 
 	if (ret < 0 && sdio->blocks_available && (dio->op == REQ_OP_WRITE)) {
@@ -191,7 +191,6 @@ static inline int dio_refill_pages(struct dio *dio, struct dio_submit *sdio)
 	}
 
 	if (ret >= 0) {
-		iov_iter_advance(sdio->iter, ret);
 		ret += sdio->from;
 		sdio->head = 0;
 		sdio->tail = (ret + PAGE_SIZE - 1) / PAGE_SIZE;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 8d657c2cd6f7..51897427a534 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -730,14 +730,13 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
 		}
 	} else {
 		size_t off;
-		err = iov_iter_get_pages(cs->iter, &page, PAGE_SIZE, 1, &off);
+		err = iov_iter_get_pages2(cs->iter, &page, PAGE_SIZE, 1, &off);
 		if (err < 0)
 			return err;
 		BUG_ON(!err);
 		cs->len = err;
 		cs->offset = off;
 		cs->pg = page;
-		iov_iter_advance(cs->iter, err);
 	}
 
 	return lock_request(cs->req);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index c982e3afe3b4..69e19fc0afc1 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1401,14 +1401,13 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 	while (nbytes < *nbytesp && ap->num_pages < max_pages) {
 		unsigned npages;
 		size_t start;
-		ret = iov_iter_get_pages(ii, &ap->pages[ap->num_pages],
+		ret = iov_iter_get_pages2(ii, &ap->pages[ap->num_pages],
 					*nbytesp - nbytes,
 					max_pages - ap->num_pages,
 					&start);
 		if (ret < 0)
 			break;
 
-		iov_iter_advance(ii, ret);
 		nbytes += ret;
 
 		ret += start;
diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 022e1ce63e62..c275c83f0aef 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -364,13 +364,12 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 		size_t pgbase;
 		unsigned npages, i;
 
-		result = iov_iter_get_pages_alloc(iter, &pagevec, 
+		result = iov_iter_get_pages_alloc2(iter, &pagevec,
 						  rsize, &pgbase);
 		if (result < 0)
 			break;
 	
 		bytes = result;
-		iov_iter_advance(iter, bytes);
 		npages = (result + pgbase + PAGE_SIZE - 1) / PAGE_SIZE;
 		for (i = 0; i < npages; i++) {
 			struct nfs_page *req;
@@ -812,13 +811,12 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 		size_t pgbase;
 		unsigned npages, i;
 
-		result = iov_iter_get_pages_alloc(iter, &pagevec, 
+		result = iov_iter_get_pages_alloc2(iter, &pagevec,
 						  wsize, &pgbase);
 		if (result < 0)
 			break;
 
 		bytes = result;
-		iov_iter_advance(iter, bytes);
 		npages = (result + pgbase + PAGE_SIZE - 1) / PAGE_SIZE;
 		for (i = 0; i < npages; i++) {
 			struct nfs_page *req;
diff --git a/include/linux/uio.h b/include/linux/uio.h
index d3e13b37ea72..ab1cc218b9de 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -349,4 +349,24 @@ static inline void iov_iter_ubuf(struct iov_iter *i, unsigned int direction,
 	};
 }
 
+static inline ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
+			size_t maxsize, unsigned maxpages, size_t *start)
+{
+	ssize_t res = iov_iter_get_pages(i, pages, maxsize, maxpages, start);
+
+	if (res >= 0)
+		iov_iter_advance(i, res);
+	return res;
+}
+
+static inline ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
+			size_t maxsize, size_t *start)
+{
+	ssize_t res = iov_iter_get_pages_alloc(i, pages, maxsize, start);
+
+	if (res >= 0)
+		iov_iter_advance(i, res);
+	return res;
+}
+
 #endif
diff --git a/net/core/datagram.c b/net/core/datagram.c
index 50f4faeea76c..344b4c5791ac 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -629,12 +629,11 @@ int __zerocopy_sg_from_iter(struct sock *sk, struct sk_buff *skb,
 		if (frag == MAX_SKB_FRAGS)
 			return -EMSGSIZE;
 
-		copied = iov_iter_get_pages(from, pages, length,
+		copied = iov_iter_get_pages2(from, pages, length,
 					    MAX_SKB_FRAGS - frag, &start);
 		if (copied < 0)
 			return -EFAULT;
 
-		iov_iter_advance(from, copied);
 		length -= copied;
 
 		truesize = PAGE_ALIGN(copied + start);
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 22b983ade0e7..662151678f20 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -324,14 +324,13 @@ int sk_msg_zerocopy_from_iter(struct sock *sk, struct iov_iter *from,
 			goto out;
 		}
 
-		copied = iov_iter_get_pages(from, pages, bytes, maxpages,
+		copied = iov_iter_get_pages2(from, pages, bytes, maxpages,
 					    &offset);
 		if (copied <= 0) {
 			ret = -EFAULT;
 			goto out;
 		}
 
-		iov_iter_advance(from, copied);
 		bytes -= copied;
 		msg->sg.size += copied;
 
diff --git a/net/rds/message.c b/net/rds/message.c
index 799034e0f513..d74be4e3f3fa 100644
--- a/net/rds/message.c
+++ b/net/rds/message.c
@@ -391,7 +391,7 @@ static int rds_message_zcopy_from_user(struct rds_message *rm, struct iov_iter *
 		size_t start;
 		ssize_t copied;
 
-		copied = iov_iter_get_pages(from, &pages, PAGE_SIZE,
+		copied = iov_iter_get_pages2(from, &pages, PAGE_SIZE,
 					    1, &start);
 		if (copied < 0) {
 			struct mmpin *mmp;
@@ -405,7 +405,6 @@ static int rds_message_zcopy_from_user(struct rds_message *rm, struct iov_iter *
 			goto err;
 		}
 		total_copied += copied;
-		iov_iter_advance(from, copied);
 		length -= copied;
 		sg_set_page(sg, pages, copied, start);
 		rm->data.op_nents++;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 0513f82b8537..b1406c60f8df 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1361,7 +1361,7 @@ static int tls_setup_from_iter(struct iov_iter *from,
 			rc = -EFAULT;
 			goto out;
 		}
-		copied = iov_iter_get_pages(from, pages,
+		copied = iov_iter_get_pages2(from, pages,
 					    length,
 					    maxpages, &offset);
 		if (copied <= 0) {
@@ -1369,8 +1369,6 @@ static int tls_setup_from_iter(struct iov_iter *from,
 			goto out;
 		}
 
-		iov_iter_advance(from, copied);
-
 		length -= copied;
 		size += copied;
 		while (copied) {
-- 
2.30.2

