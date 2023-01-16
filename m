Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7E566D2CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 00:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbjAPXNR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 18:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbjAPXMT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 18:12:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF732DE5A
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 15:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673910595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kKmnjesqbVcK16NFYaezZHmG2fXFwkY2y+msB04GC+4=;
        b=Z/8SVx1qAcsdObodU2fqL0sCPCcY/w0Lb6UICxRC7SMdMUlqUPustAwmFdGS43APt/7CQo
        k71V9nbS0G1Gyc6pLUgDToRfeoCRXNTIQDjEd+zS3lO89HDZWjno7q8yADJ5BcUoN5Wr18
        pArK+OGo6rtGQtu/K2vxK4vQYRrN/mA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-523-Dg-7CkFxNXKEqeYPM6L_Fg-1; Mon, 16 Jan 2023 18:09:52 -0500
X-MC-Unique: Dg-7CkFxNXKEqeYPM6L_Fg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7ADA62A59560;
        Mon, 16 Jan 2023 23:09:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 181692026D4B;
        Mon, 16 Jan 2023 23:09:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v6 15/34] af_alg: Pin pages rather than ref'ing if appropriate
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
Date:   Mon, 16 Jan 2023 23:09:49 +0000
Message-ID: <167391058954.2311931.2012230616335750882.stgit@warthog.procyon.org.uk>
In-Reply-To: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert AF_ALG to use iov_iter_extract_pages() instead of
iov_iter_get_pages().  This will pin pages or leave them unaltered rather
than getting a ref on them as appropriate to the iterator.

The pages need to be pinned for DIO-read rather than having refs taken on
them to prevent VM copy-on-write from malfunctioning during a concurrent
fork() (the result of the I/O would otherwise end up only visible to the
child process and not the parent).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Herbert Xu <herbert@gondor.apana.org.au>
cc: linux-crypto@vger.kernel.org
---

 crypto/af_alg.c         |    9 ++++++---
 include/crypto/if_alg.h |    1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 7a68db157fae..c99e09fce71f 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -534,15 +534,18 @@ static const struct net_proto_family alg_family = {
 int af_alg_make_sg(struct af_alg_sgl *sgl, struct iov_iter *iter, int len,
 		   unsigned int gup_flags)
 {
+	struct page **pages = sgl->pages;
 	size_t off;
 	ssize_t n;
 	int npages, i;
 
-	n = iov_iter_get_pages(iter, sgl->pages, len, ALG_MAX_PAGES, &off,
-			       gup_flags);
+	n = iov_iter_extract_pages(iter, &pages, len, ALG_MAX_PAGES,
+				   gup_flags, &off);
 	if (n < 0)
 		return n;
 
+	sgl->cleanup_mode = iov_iter_extract_mode(iter, gup_flags);
+
 	npages = DIV_ROUND_UP(off + n, PAGE_SIZE);
 	if (WARN_ON(npages == 0))
 		return -EINVAL;
@@ -576,7 +579,7 @@ void af_alg_free_sg(struct af_alg_sgl *sgl)
 	int i;
 
 	for (i = 0; i < sgl->npages; i++)
-		put_page(sgl->pages[i]);
+		page_put_unpin(sgl->pages[i], sgl->cleanup_mode);
 }
 EXPORT_SYMBOL_GPL(af_alg_free_sg);
 
diff --git a/include/crypto/if_alg.h b/include/crypto/if_alg.h
index 12058ab6cad9..95b3b7517d3f 100644
--- a/include/crypto/if_alg.h
+++ b/include/crypto/if_alg.h
@@ -61,6 +61,7 @@ struct af_alg_sgl {
 	struct scatterlist sg[ALG_MAX_PAGES + 1];
 	struct page *pages[ALG_MAX_PAGES];
 	unsigned int npages;
+	unsigned int cleanup_mode;
 };
 
 /* TX SGL entry */


