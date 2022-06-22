Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E1855417E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356925AbiFVERK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356863AbiFVEQK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:16:10 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B86B85E
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=BNnRC2cBRpd7fh9UVBlc5dtw8QKktwDKtprwB9veQ4M=; b=ZWIP+OTwKfATJ1kr96g3RRsE/i
        x/rJcPwWgA/EwDmW/OL500owX+ZqauBE0dLn71/pgRT33mfPt4ECro/neT7qKk8lY/942x4qNmm4X
        SQM0Svs9VFrTj3y5J98qBF+xo3o2iVc7YtsZ7DUVH2vEecjOJqxF4XqSiHh3wSQ53gIzIfnXdMDXj
        3WgnCL8GGZXfZahNaFm87hTW3fmZxs7CAtIHXkuG4ED9Cuk/qp9r6wKV/bWDRaTosPFO5/+ZrDVlZ
        j3kRGwBQmlrcCOQVO6j9yVHw49NRYKf3HSyOeLNinOVL3xdLaRSHprpZVFQrJOohXvd/oAMLBOyu+
        eGySC7mw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rmZ-0035zs-Nn;
        Wed, 22 Jun 2022 04:15:59 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 39/44] af_alg_make_sg(): switch to advancing variant of iov_iter_get_pages()
Date:   Wed, 22 Jun 2022 05:15:47 +0100
Message-Id: <20220622041552.737754-39-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622041552.737754-1-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
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

... and adjust the callers

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 crypto/af_alg.c     | 3 +--
 crypto/algif_hash.c | 5 +++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index c8289b7a85ba..e893c0f6c879 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -404,7 +404,7 @@ int af_alg_make_sg(struct af_alg_sgl *sgl, struct iov_iter *iter, int len)
 	ssize_t n;
 	int npages, i;
 
-	n = iov_iter_get_pages(iter, sgl->pages, len, ALG_MAX_PAGES, &off);
+	n = iov_iter_get_pages2(iter, sgl->pages, len, ALG_MAX_PAGES, &off);
 	if (n < 0)
 		return n;
 
@@ -1191,7 +1191,6 @@ int af_alg_get_rsgl(struct sock *sk, struct msghdr *msg, int flags,
 		len += err;
 		atomic_add(err, &ctx->rcvused);
 		rsgl->sg_num_bytes = err;
-		iov_iter_advance(&msg->msg_iter, err);
 	}
 
 	*outlen = len;
diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
index 50f7b22f1b48..1d017ec5c63c 100644
--- a/crypto/algif_hash.c
+++ b/crypto/algif_hash.c
@@ -102,11 +102,12 @@ static int hash_sendmsg(struct socket *sock, struct msghdr *msg,
 		err = crypto_wait_req(crypto_ahash_update(&ctx->req),
 				      &ctx->wait);
 		af_alg_free_sg(&ctx->sgl);
-		if (err)
+		if (err) {
+			iov_iter_revert(&msg->msg_iter, len);
 			goto unlock;
+		}
 
 		copied += len;
-		iov_iter_advance(&msg->msg_iter, len);
 	}
 
 	err = 0;
-- 
2.30.2

