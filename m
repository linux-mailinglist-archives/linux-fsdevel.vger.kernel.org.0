Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11407795C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 19:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbjHKRIV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 13:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbjHKRII (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:08:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF69B30DE
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 10:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691773634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ApvezO5YUmVyU1VImv5XlYF6Qd7hCzC3ZUJaOLuslQs=;
        b=KVGBQtar6N7gI3bI+JU7VFAmOgtzm6HyzCNO57y/pgep3hR3cuZ3h+w7ICq/66xiIVfONA
        W37Qz2CDg1fSasAcBTXlIjcFG72LVU+Dq2lcD2YvM3k9jNNKtN/GsHXqpld+i3yz6/in6P
        6+rnPgSfA7yyNQgMqW+yigpY9efx/CM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-rhh60aFROIWDMm8yoRVjbQ-1; Fri, 11 Aug 2023 13:07:09 -0400
X-MC-Unique: rhh60aFROIWDMm8yoRVjbQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 128FA1C07267;
        Fri, 11 Aug 2023 17:07:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A963140C2063;
        Fri, 11 Aug 2023 17:07:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wi1QZ+zdXkjnEY7u1GsVDaBv8yY+m4-9G3R34ihwg9pmQ@mail.gmail.com>
References: <CAHk-=wi1QZ+zdXkjnEY7u1GsVDaBv8yY+m4-9G3R34ihwg9pmQ@mail.gmail.com> <3710261.1691764329@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>, jlayton@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] iov_iter: Convert iterate*() to inline funcs
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3888330.1691773627.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 11 Aug 2023 18:07:07 +0100
Message-ID: <3888331.1691773627@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> I like this generally, the code generation deprovement worries me a
> bit, but from a quick look on a test-branch it didn't really look all
> that bad (but the changes are too big to usefully show up as asm
> diffs)

Hmmm...  It seems that using if-if-if rather than switch() gets optimised
better in terms of .text space.  The attached change makes things a bit
smaller (by 69 bytes).

David
---
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 8943ac25e202..f61474ec1c89 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -190,22 +190,18 @@ size_t iterate_and_advance(struct iov_iter *iter, si=
ze_t len, void *priv,
 	if (unlikely(!len))
 		return 0;
 =

-	switch (iov_iter_type(iter)) {
-	case ITER_UBUF:
+	if (likely(iter_is_ubuf(iter)))
 		return iterate_ubuf(iter, len, priv, NULL, ustep);
-	case ITER_IOVEC:
+	if (likely(iter_is_iovec(iter)))
 		return iterate_iovec(iter, len, priv, NULL, ustep);
-	case ITER_KVEC:
+	if (iov_iter_is_kvec(iter))
 		return iterate_kvec(iter, len, priv, NULL, step);
-	case ITER_BVEC:
+	if (iov_iter_is_bvec(iter))
 		return iterate_bvec(iter, len, priv, NULL, step);
-	case ITER_XARRAY:
+	if (iov_iter_is_xarray(iter))
 		return iterate_xarray(iter, len, priv, NULL, step);
-	case ITER_DISCARD:
-		iter->count -=3D len;
-		return len;
-	}
-	return 0;
+	iter->count -=3D len;
+	return len;
 }
 =

 static __always_inline
@@ -217,22 +213,18 @@ size_t iterate_and_advance_csum(struct iov_iter *ite=
r, size_t len, void *priv,
 	if (unlikely(!len))
 		return 0;
 =

-	switch (iov_iter_type(iter)) {
-	case ITER_UBUF:
+	if (likely(iter_is_ubuf(iter)))
 		return iterate_ubuf(iter, len, priv, csum, ustep);
-	case ITER_IOVEC:
+	if (likely(iter_is_iovec(iter)))
 		return iterate_iovec(iter, len, priv, csum, ustep);
-	case ITER_KVEC:
+	if (iov_iter_is_kvec(iter))
 		return iterate_kvec(iter, len, priv, csum, step);
-	case ITER_BVEC:
+	if (iov_iter_is_bvec(iter))
 		return iterate_bvec(iter, len, priv, csum, step);
-	case ITER_XARRAY:
+	if (iov_iter_is_xarray(iter))
 		return iterate_xarray(iter, len, priv, csum, step);
-	case ITER_DISCARD:
-		iter->count -=3D len;
-		return len;
-	}
-	return 0;
+	iter->count -=3D len;
+	return len;
 }
 =

 static size_t copy_to_user_iter(void __user *iter_to, size_t progress,

