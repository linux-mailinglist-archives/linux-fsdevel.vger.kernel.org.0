Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161AE66D2CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 00:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbjAPXNq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 18:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235331AbjAPXM7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 18:12:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3307C2DE6A
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 15:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673910602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PjIAiip7N5L8hcYwP5P+y/gD9B8I5Bbt/wX0DBUObE8=;
        b=N59+z+xY7qP/C/MArMLAu2H7p7qhw7/tyegWONMOh+OJEI3uFWk6Un6YqPqeLp5rAjc41F
        Tv3IaMppPYFKcZ160Q41neShDjOPp2CfVsulexY2H+M7a/ValD+nHXjr6UdMqDboML31Kx
        zNw3747Hj/iYMFCRcwWzatuvr+ITM94=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-464-BpfiqjMTNrS7NCWxGctuPg-1; Mon, 16 Jan 2023 18:09:59 -0500
X-MC-Unique: BpfiqjMTNrS7NCWxGctuPg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A3942101AA78;
        Mon, 16 Jan 2023 23:09:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E19E2166B26;
        Mon, 16 Jan 2023 23:09:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v6 16/34] af_alg: [RFC] Use netfs_extract_iter_to_sg() to
 create scatterlists
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, dhowells@redhat.com,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 16 Jan 2023 23:09:56 +0000
Message-ID: <167391059663.2311931.12037449511418464282.stgit@warthog.procyon.org.uk>
In-Reply-To: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use netfs_extract_iter_to_sg() to decant the destination iterator into a
scatterlist in af_alg_get_rsgl().  af_alg_make_sg() can then be removed.

Note that if this fits, netfs_extract_iter_to_sg() should move to core
code.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Herbert Xu <herbert@gondor.apana.org.au>
cc: linux-crypto@vger.kernel.org
---

 crypto/af_alg.c         |   63 +++++++++++++----------------------------------
 crypto/algif_hash.c     |   21 +++++++++++-----
 include/crypto/if_alg.h |    7 +----
 3 files changed, 35 insertions(+), 56 deletions(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index c99e09fce71f..c5fbe39366ff 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -22,6 +22,7 @@
 #include <linux/sched/signal.h>
 #include <linux/security.h>
 #include <linux/string.h>
+#include <linux/netfs.h>
 #include <keys/user-type.h>
 #include <keys/trusted-type.h>
 #include <keys/encrypted-type.h>
@@ -531,55 +532,22 @@ static const struct net_proto_family alg_family = {
 	.owner	=	THIS_MODULE,
 };
 
-int af_alg_make_sg(struct af_alg_sgl *sgl, struct iov_iter *iter, int len,
-		   unsigned int gup_flags)
-{
-	struct page **pages = sgl->pages;
-	size_t off;
-	ssize_t n;
-	int npages, i;
-
-	n = iov_iter_extract_pages(iter, &pages, len, ALG_MAX_PAGES,
-				   gup_flags, &off);
-	if (n < 0)
-		return n;
-
-	sgl->cleanup_mode = iov_iter_extract_mode(iter, gup_flags);
-
-	npages = DIV_ROUND_UP(off + n, PAGE_SIZE);
-	if (WARN_ON(npages == 0))
-		return -EINVAL;
-	/* Add one extra for linking */
-	sg_init_table(sgl->sg, npages + 1);
-
-	for (i = 0, len = n; i < npages; i++) {
-		int plen = min_t(int, len, PAGE_SIZE - off);
-
-		sg_set_page(sgl->sg + i, sgl->pages[i], plen, off);
-
-		off = 0;
-		len -= plen;
-	}
-	sg_mark_end(sgl->sg + npages - 1);
-	sgl->npages = npages;
-
-	return n;
-}
-EXPORT_SYMBOL_GPL(af_alg_make_sg);
-
 static void af_alg_link_sg(struct af_alg_sgl *sgl_prev,
 			   struct af_alg_sgl *sgl_new)
 {
-	sg_unmark_end(sgl_prev->sg + sgl_prev->npages - 1);
-	sg_chain(sgl_prev->sg, sgl_prev->npages + 1, sgl_new->sg);
+	sg_unmark_end(sgl_prev->sgt.sgl + sgl_prev->sgt.nents - 1);
+	sg_chain(sgl_prev->sgt.sgl, sgl_prev->sgt.nents + 1, sgl_new->sgt.sgl);
 }
 
 void af_alg_free_sg(struct af_alg_sgl *sgl)
 {
 	int i;
 
-	for (i = 0; i < sgl->npages; i++)
-		page_put_unpin(sgl->pages[i], sgl->cleanup_mode);
+	if (!(sgl->cleanup_mode & (FOLL_PIN | FOLL_GET)))
+		return;
+
+	for (i = 0; i < sgl->sgt.nents; i++)
+		page_put_unpin(sg_page(&sgl->sgt.sgl[i]), sgl->cleanup_mode);
 }
 EXPORT_SYMBOL_GPL(af_alg_free_sg);
 
@@ -1293,8 +1261,8 @@ int af_alg_get_rsgl(struct sock *sk, struct msghdr *msg, int flags,
 
 	while (maxsize > len && msg_data_left(msg)) {
 		struct af_alg_rsgl *rsgl;
+		ssize_t err;
 		size_t seglen;
-		int err;
 
 		/* limit the amount of readable buffers */
 		if (!af_alg_readable(sk))
@@ -1311,17 +1279,22 @@ int af_alg_get_rsgl(struct sock *sk, struct msghdr *msg, int flags,
 				return -ENOMEM;
 		}
 
-		rsgl->sgl.npages = 0;
+		rsgl->sgl.sgt.sgl = rsgl->sgl.sgl;
+		rsgl->sgl.sgt.nents = 0;
+		rsgl->sgl.sgt.orig_nents = 0;
 		list_add_tail(&rsgl->list, &areq->rsgl_list);
 
-		/* make one iovec available as scatterlist */
-		err = af_alg_make_sg(&rsgl->sgl, &msg->msg_iter, seglen,
-				     FOLL_DEST_BUF);
+		err = netfs_extract_iter_to_sg(&msg->msg_iter, seglen,
+					       &rsgl->sgl.sgt, ALG_MAX_PAGES,
+					       FOLL_DEST_BUF);
 		if (err < 0) {
 			rsgl->sg_num_bytes = 0;
 			return err;
 		}
 
+		rsgl->sgl.cleanup_mode = iov_iter_extract_mode(&msg->msg_iter,
+							       FOLL_DEST_BUF);
+
 		/* chain the new scatterlist with previous one */
 		if (areq->last_rsgl)
 			af_alg_link_sg(&areq->last_rsgl->sgl, &rsgl->sgl);
diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
index fe3d2258145f..5aef6818a9ff 100644
--- a/crypto/algif_hash.c
+++ b/crypto/algif_hash.c
@@ -14,6 +14,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/net.h>
+#include <linux/netfs.h>
 #include <net/sock.h>
 
 struct hash_ctx {
@@ -91,14 +92,22 @@ static int hash_sendmsg(struct socket *sock, struct msghdr *msg,
 		if (len > limit)
 			len = limit;
 
-		len = af_alg_make_sg(&ctx->sgl, &msg->msg_iter, len,
-				     FOLL_SOURCE_BUF);
+		ctx->sgl.sgt.sgl = ctx->sgl.sgl;
+		ctx->sgl.sgt.nents = 0;
+		ctx->sgl.sgt.orig_nents = 0;
+
+		len = netfs_extract_iter_to_sg(&msg->msg_iter, len,
+					       &ctx->sgl.sgt, ALG_MAX_PAGES,
+					       FOLL_SOURCE_BUF);
 		if (len < 0) {
 			err = copied ? 0 : len;
 			goto unlock;
 		}
 
-		ahash_request_set_crypt(&ctx->req, ctx->sgl.sg, NULL, len);
+		ctx->sgl.cleanup_mode = iov_iter_extract_mode(&msg->msg_iter,
+							      FOLL_SOURCE_BUF);
+
+		ahash_request_set_crypt(&ctx->req, ctx->sgl.sgt.sgl, NULL, len);
 
 		err = crypto_wait_req(crypto_ahash_update(&ctx->req),
 				      &ctx->wait);
@@ -142,8 +151,8 @@ static ssize_t hash_sendpage(struct socket *sock, struct page *page,
 		flags |= MSG_MORE;
 
 	lock_sock(sk);
-	sg_init_table(ctx->sgl.sg, 1);
-	sg_set_page(ctx->sgl.sg, page, size, offset);
+	sg_init_table(ctx->sgl.sgl, 1);
+	sg_set_page(ctx->sgl.sgl, page, size, offset);
 
 	if (!(flags & MSG_MORE)) {
 		err = hash_alloc_result(sk, ctx);
@@ -152,7 +161,7 @@ static ssize_t hash_sendpage(struct socket *sock, struct page *page,
 	} else if (!ctx->more)
 		hash_free_result(sk, ctx);
 
-	ahash_request_set_crypt(&ctx->req, ctx->sgl.sg, ctx->result, size);
+	ahash_request_set_crypt(&ctx->req, ctx->sgl.sgl, ctx->result, size);
 
 	if (!(flags & MSG_MORE)) {
 		if (ctx->more)
diff --git a/include/crypto/if_alg.h b/include/crypto/if_alg.h
index 95b3b7517d3f..424a2071705d 100644
--- a/include/crypto/if_alg.h
+++ b/include/crypto/if_alg.h
@@ -58,9 +58,8 @@ struct af_alg_type {
 };
 
 struct af_alg_sgl {
-	struct scatterlist sg[ALG_MAX_PAGES + 1];
-	struct page *pages[ALG_MAX_PAGES];
-	unsigned int npages;
+	struct sg_table sgt;
+	struct scatterlist sgl[ALG_MAX_PAGES + 1];
 	unsigned int cleanup_mode;
 };
 
@@ -166,8 +165,6 @@ int af_alg_release(struct socket *sock);
 void af_alg_release_parent(struct sock *sk);
 int af_alg_accept(struct sock *sk, struct socket *newsock, bool kern);
 
-int af_alg_make_sg(struct af_alg_sgl *sgl, struct iov_iter *iter, int len,
-		   unsigned int gup_flags);
 void af_alg_free_sg(struct af_alg_sgl *sgl);
 
 static inline struct alg_sock *alg_sk(struct sock *sk)


