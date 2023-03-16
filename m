Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0E56BD3AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 16:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjCPP3n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 11:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjCPP3D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:29:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9945C974C
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Mar 2023 08:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678980434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3nPvkTYaIi99z8jZpnwnKSywFWTrpbYCfoV76x5ycHw=;
        b=BPcAqtrnDpFDu4qbymI4aYBenc567C8t+GIRAMj268B2v4302uRqd7tJ2FuDsydcuFh642
        1+twuoF+FO0aFmnwhwF6GY5AIV/7rPl5A1HKT68JYJuD7Qj6b7sxfJeDBUsWPZuU9deiUZ
        yVogWqcx4PQ/0wkPSvNxdJUwOpQbNLo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-77-Nfq8OMIzNR-misbqjnyc9g-1; Thu, 16 Mar 2023 11:27:11 -0400
X-MC-Unique: Nfq8OMIzNR-misbqjnyc9g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A73085A5A3;
        Thu, 16 Mar 2023 15:27:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24F3A40C6E68;
        Thu, 16 Mar 2023 15:27:08 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Tom Talpey <tom@talpey.com>, linux-rdma@vger.kernel.org
Subject: [RFC PATCH 18/28] siw: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage to transmit
Date:   Thu, 16 Mar 2023 15:26:08 +0000
Message-Id: <20230316152618.711970-19-dhowells@redhat.com>
In-Reply-To: <20230316152618.711970-1-dhowells@redhat.com>
References: <20230316152618.711970-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When transmitting data, call down into TCP using a single sendmsg with
MSG_SPLICE_PAGES to indicate that content should be spliced rather than
performing several sendmsg and sendpage calls to transmit header, data
pages and trailer.

To make this work, the data is assembled in a bio_vec array and attached to
a BVEC-type iterator.  The header and trailer (if present) are copied into
memory acquired from zcopy_alloc() which just breaks a page up into small
pieces that can be freed with put_page().

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Bernard Metzler <bmt@zurich.ibm.com>
cc: Tom Talpey <tom@talpey.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-rdma@vger.kernel.org
cc: netdev@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_qp_tx.c | 231 +++++---------------------
 1 file changed, 46 insertions(+), 185 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 8fc179321e2b..ec4f0ac324ce 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -8,6 +8,7 @@
 #include <linux/net.h>
 #include <linux/scatterlist.h>
 #include <linux/highmem.h>
+#include <linux/zcopy_alloc.h>
 #include <net/tcp.h>
 
 #include <rdma/iw_cm.h>
@@ -312,114 +313,8 @@ static int siw_tx_ctrl(struct siw_iwarp_tx *c_tx, struct socket *s,
 	return rv;
 }
 
-/*
- * 0copy TCP transmit interface: Use MSG_SPLICE_PAGES.
- *
- * Using sendpage to push page by page appears to be less efficient
- * than using sendmsg, even if data are copied.
- *
- * A general performance limitation might be the extra four bytes
- * trailer checksum segment to be pushed after user data.
- */
-static int siw_tcp_sendpages(struct socket *s, struct page **page, int offset,
-			     size_t size)
-{
-	struct bio_vec bvec;
-	struct msghdr msg = {
-		.msg_flags = (MSG_SPLICE_PAGES | MSG_MORE | MSG_DONTWAIT |
-			      MSG_SENDPAGE_NOTLAST),
-	};
-	struct sock *sk = s->sk;
-	int i = 0, rv = 0, sent = 0;
-
-	while (size) {
-		size_t bytes = min_t(size_t, PAGE_SIZE - offset, size);
-
-		if (size + offset <= PAGE_SIZE)
-			msg.msg_flags = MSG_SPLICE_PAGES | MSG_MORE | MSG_DONTWAIT;
-
-		tcp_rate_check_app_limited(sk);
-		bvec_set_page(&bvec, page[i], bytes, offset);
-		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
-
-try_page_again:
-		lock_sock(sk);
-		rv = tcp_sendmsg_locked(sk, &msg, size);
-		release_sock(sk);
-
-		if (rv > 0) {
-			size -= rv;
-			sent += rv;
-			if (rv != bytes) {
-				offset += rv;
-				bytes -= rv;
-				goto try_page_again;
-			}
-			offset = 0;
-		} else {
-			if (rv == -EAGAIN || rv == 0)
-				break;
-			return rv;
-		}
-		i++;
-	}
-	return sent;
-}
-
-/*
- * siw_0copy_tx()
- *
- * Pushes list of pages to TCP socket. If pages from multiple
- * SGE's, all referenced pages of each SGE are pushed in one
- * shot.
- */
-static int siw_0copy_tx(struct socket *s, struct page **page,
-			struct siw_sge *sge, unsigned int offset,
-			unsigned int size)
-{
-	int i = 0, sent = 0, rv;
-	int sge_bytes = min(sge->length - offset, size);
-
-	offset = (sge->laddr + offset) & ~PAGE_MASK;
-
-	while (sent != size) {
-		rv = siw_tcp_sendpages(s, &page[i], offset, sge_bytes);
-		if (rv >= 0) {
-			sent += rv;
-			if (size == sent || sge_bytes > rv)
-				break;
-
-			i += PAGE_ALIGN(sge_bytes + offset) >> PAGE_SHIFT;
-			sge++;
-			sge_bytes = min(sge->length, size - sent);
-			offset = sge->laddr & ~PAGE_MASK;
-		} else {
-			sent = rv;
-			break;
-		}
-	}
-	return sent;
-}
-
 #define MAX_TRAILER (MPA_CRC_SIZE + 4)
 
-static void siw_unmap_pages(struct kvec *iov, unsigned long kmap_mask, int len)
-{
-	int i;
-
-	/*
-	 * Work backwards through the array to honor the kmap_local_page()
-	 * ordering requirements.
-	 */
-	for (i = (len-1); i >= 0; i--) {
-		if (kmap_mask & BIT(i)) {
-			unsigned long addr = (unsigned long)iov[i].iov_base;
-
-			kunmap_local((void *)(addr & PAGE_MASK));
-		}
-	}
-}
-
 /*
  * siw_tx_hdt() tries to push a complete packet to TCP where all
  * packet fragments are referenced by the elements of one iovec.
@@ -439,15 +334,13 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 {
 	struct siw_wqe *wqe = &c_tx->wqe_active;
 	struct siw_sge *sge = &wqe->sqe.sge[c_tx->sge_idx];
-	struct kvec iov[MAX_ARRAY];
-	struct page *page_array[MAX_ARRAY];
+	struct bio_vec bvec[MAX_ARRAY];
 	struct msghdr msg = { .msg_flags = MSG_DONTWAIT | MSG_EOR };
 
 	int seg = 0, do_crc = c_tx->do_crc, is_kva = 0, rv;
 	unsigned int data_len = c_tx->bytes_unsent, hdr_len = 0, trl_len = 0,
 		     sge_off = c_tx->sge_off, sge_idx = c_tx->sge_idx,
 		     pbl_idx = c_tx->pbl_idx;
-	unsigned long kmap_mask = 0L;
 
 	if (c_tx->state == SIW_SEND_HDR) {
 		if (c_tx->use_sendpage) {
@@ -457,10 +350,12 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 
 			c_tx->state = SIW_SEND_DATA;
 		} else {
-			iov[0].iov_base =
-				(char *)&c_tx->pkt.ctrl + c_tx->ctrl_sent;
-			iov[0].iov_len = hdr_len =
-				c_tx->ctrl_len - c_tx->ctrl_sent;
+			const void *hdr = &c_tx->pkt.ctrl + c_tx->ctrl_sent;
+
+			hdr_len = c_tx->ctrl_len - c_tx->ctrl_sent;
+			rv = zcopy_memdup(hdr_len, hdr, &bvec[0], GFP_NOFS);
+			if (rv < 0)
+				goto done;
 			seg = 1;
 		}
 	}
@@ -478,28 +373,9 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 		} else {
 			is_kva = 1;
 		}
-		if (is_kva && !c_tx->use_sendpage) {
-			/*
-			 * tx from kernel virtual address: either inline data
-			 * or memory region with assigned kernel buffer
-			 */
-			iov[seg].iov_base =
-				(void *)(uintptr_t)(sge->laddr + sge_off);
-			iov[seg].iov_len = sge_len;
-
-			if (do_crc)
-				crypto_shash_update(c_tx->mpa_crc_hd,
-						    iov[seg].iov_base,
-						    sge_len);
-			sge_off += sge_len;
-			data_len -= sge_len;
-			seg++;
-			goto sge_done;
-		}
 
 		while (sge_len) {
 			size_t plen = min((int)PAGE_SIZE - fp_off, sge_len);
-			void *kaddr;
 
 			if (!is_kva) {
 				struct page *p;
@@ -512,33 +388,12 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 					p = siw_get_upage(mem->umem,
 							  sge->laddr + sge_off);
 				if (unlikely(!p)) {
-					siw_unmap_pages(iov, kmap_mask, seg);
 					wqe->processed -= c_tx->bytes_unsent;
 					rv = -EFAULT;
 					goto done_crc;
 				}
-				page_array[seg] = p;
-
-				if (!c_tx->use_sendpage) {
-					void *kaddr = kmap_local_page(p);
-
-					/* Remember for later kunmap() */
-					kmap_mask |= BIT(seg);
-					iov[seg].iov_base = kaddr + fp_off;
-					iov[seg].iov_len = plen;
-
-					if (do_crc)
-						crypto_shash_update(
-							c_tx->mpa_crc_hd,
-							iov[seg].iov_base,
-							plen);
-				} else if (do_crc) {
-					kaddr = kmap_local_page(p);
-					crypto_shash_update(c_tx->mpa_crc_hd,
-							    kaddr + fp_off,
-							    plen);
-					kunmap_local(kaddr);
-				}
+
+				bvec_set_page(&bvec[seg], p, plen, fp_off);
 			} else {
 				/*
 				 * Cast to an uintptr_t to preserve all 64 bits
@@ -552,12 +407,15 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 				 * bits on a 64 bit platform and 32 bits on a
 				 * 32 bit platform.
 				 */
-				page_array[seg] = virt_to_page((void *)(va & PAGE_MASK));
-				if (do_crc)
-					crypto_shash_update(
-						c_tx->mpa_crc_hd,
-						(void *)va,
-						plen);
+				bvec_set_virt(&bvec[seg], (void *)va, plen);
+			}
+
+			if (do_crc) {
+				void *kaddr = kmap_local_page(bvec[seg].bv_page);
+				crypto_shash_update(c_tx->mpa_crc_hd,
+						    kaddr + bvec[seg].bv_offset,
+						    bvec[seg].bv_len);
+				kunmap_local(kaddr);
 			}
 
 			sge_len -= plen;
@@ -567,13 +425,12 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 
 			if (++seg > (int)MAX_ARRAY) {
 				siw_dbg_qp(tx_qp(c_tx), "to many fragments\n");
-				siw_unmap_pages(iov, kmap_mask, seg-1);
 				wqe->processed -= c_tx->bytes_unsent;
 				rv = -EMSGSIZE;
 				goto done_crc;
 			}
 		}
-sge_done:
+
 		/* Update SGE variables at end of SGE */
 		if (sge_off == sge->length &&
 		    (data_len != 0 || wqe->processed < wqe->bytes)) {
@@ -582,15 +439,8 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 			sge_off = 0;
 		}
 	}
-	/* trailer */
-	if (likely(c_tx->state != SIW_SEND_TRAILER)) {
-		iov[seg].iov_base = &c_tx->trailer.pad[4 - c_tx->pad];
-		iov[seg].iov_len = trl_len = MAX_TRAILER - (4 - c_tx->pad);
-	} else {
-		iov[seg].iov_base = &c_tx->trailer.pad[c_tx->ctrl_sent];
-		iov[seg].iov_len = trl_len = MAX_TRAILER - c_tx->ctrl_sent;
-	}
 
+	/* Set the CRC in the trailer */
 	if (c_tx->pad) {
 		*(u32 *)c_tx->trailer.pad = 0;
 		if (do_crc)
@@ -603,23 +453,31 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 	else if (do_crc)
 		crypto_shash_final(c_tx->mpa_crc_hd, (u8 *)&c_tx->trailer.crc);
 
-	data_len = c_tx->bytes_unsent;
+	/* Copy the trailer and add it to the output list */
+	if (likely(c_tx->state != SIW_SEND_TRAILER)) {
+		void *trl = &c_tx->trailer.pad[4 - c_tx->pad];
 
-	if (c_tx->use_sendpage) {
-		rv = siw_0copy_tx(s, page_array, &wqe->sqe.sge[c_tx->sge_idx],
-				  c_tx->sge_off, data_len);
-		if (rv == data_len) {
-			rv = kernel_sendmsg(s, &msg, &iov[seg], 1, trl_len);
-			if (rv > 0)
-				rv += data_len;
-			else
-				rv = data_len;
-		}
+		trl_len = MAX_TRAILER - (4 - c_tx->pad);
+		rv = zcopy_memdup(trl_len, trl, &bvec[seg], GFP_NOFS);
+		if (rv < 0)
+			goto done_crc;
 	} else {
-		rv = kernel_sendmsg(s, &msg, iov, seg + 1,
-				    hdr_len + data_len + trl_len);
-		siw_unmap_pages(iov, kmap_mask, seg);
+		void *trl = &c_tx->trailer.pad[c_tx->ctrl_sent];
+
+		trl_len = MAX_TRAILER - c_tx->ctrl_sent;
+		rv = zcopy_memdup(trl_len, trl, &bvec[seg], GFP_NOFS);
+		if (rv < 0)
+			goto done_crc;
 	}
+
+	data_len = c_tx->bytes_unsent;
+
+	if (c_tx->use_sendpage)
+		msg.msg_flags |= MSG_SPLICE_PAGES;
+	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, bvec, seg + 1,
+		      hdr_len + data_len + trl_len);
+	rv = sock_sendmsg(s, &msg);
+
 	if (rv < (int)hdr_len) {
 		/* Not even complete hdr pushed or negative rv */
 		wqe->processed -= data_len;
@@ -680,6 +538,9 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 	}
 done_crc:
 	c_tx->do_crc = 0;
+	if (c_tx->state == SIW_SEND_HDR)
+		folio_put(page_folio(bvec[0].bv_page));
+	folio_put(page_folio(bvec[seg].bv_page));
 done:
 	return rv;
 }

