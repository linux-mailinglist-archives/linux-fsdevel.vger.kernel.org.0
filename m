Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E96B7A8F55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 00:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjITWYi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 18:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjITWYY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 18:24:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35C0119
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 15:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695248580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QdaDFgQ/IdiUz+wPFCKvBKKks+ni1Kcs8Sp2gYxHcOI=;
        b=hpcYlp8KPtSUmbiycQr92FNdQ76P/aQ2nFQq0LVcSYUwGBEdmt33v60xb5dn73J+ZCnZ9t
        CrE1oiLyeVWumAfVEbmJ5KypigvNPP7NDOh5vTnbQa9SgI9oAgPJB5yOyW1tCUo9P+8S2z
        haXCaREQ3Px3+VDxKHvb3/AcAJ3fpT4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-pcHmzeEEOaC540eqzQ0x5A-1; Wed, 20 Sep 2023 18:22:56 -0400
X-MC-Unique: pcHmzeEEOaC540eqzQ0x5A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EEE4328EC113;
        Wed, 20 Sep 2023 22:22:55 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55F5F2156A27;
        Wed, 20 Sep 2023 22:22:54 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@ACULAB.COM>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/11] iov_iter: Add a kernel-type iterator-only iteration function
Date:   Wed, 20 Sep 2023 23:22:27 +0100
Message-ID: <20230920222231.686275-8-dhowells@redhat.com>
In-Reply-To: <20230920222231.686275-1-dhowells@redhat.com>
References: <20230920222231.686275-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add an iteration function that can only iterate over kernel internal-type
iterators (ie. BVEC, KVEC, XARRAY) and not user-backed iterators (ie. UBUF
and IOVEC).  This allows for smaller iterators to be built when it is known
the caller won't have a user-backed iterator.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@lst.de>
cc: Christian Brauner <christian@brauner.io>
cc: Matthew Wilcox <willy@infradead.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: David Laight <David.Laight@ACULAB.COM>
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 include/linux/iov_iter.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/linux/iov_iter.h b/include/linux/iov_iter.h
index 270454a6703d..a94d605d7386 100644
--- a/include/linux/iov_iter.h
+++ b/include/linux/iov_iter.h
@@ -271,4 +271,35 @@ size_t iterate_and_advance(struct iov_iter *iter, size_t len, void *priv,
 	return iterate_and_advance2(iter, len, priv, NULL, ustep, step);
 }
 
+/**
+ * iterate_and_advance_kernel - Iterate over a kernel iterator
+ * @iter: The iterator to iterate over.
+ * @len: The amount to iterate over.
+ * @priv: Data for the step functions.
+ * @step: Processing function; given kernel addresses.
+ *
+ * Like iterate_and_advance2(), but rejected UBUF and IOVEC iterators and does
+ * not take a user-step function.
+ */
+static __always_inline
+size_t iterate_and_advance_kernel(struct iov_iter *iter, size_t len, void *priv,
+				  void *priv2, iov_step_f step)
+{
+	if (unlikely(iter->count < len))
+		len = iter->count;
+	if (unlikely(!len))
+		return 0;
+
+	if (iov_iter_is_bvec(iter))
+		return iterate_bvec(iter, len, priv, priv2, step);
+	if (iov_iter_is_kvec(iter))
+		return iterate_kvec(iter, len, priv, priv2, step);
+	if (iov_iter_is_xarray(iter))
+		return iterate_xarray(iter, len, priv, priv2, step);
+	if (iov_iter_is_discard(iter))
+		return iterate_discard(iter, len, priv, priv2, step);
+	WARN_ON_ONCE(1);
+	return 0;
+}
+
 #endif /* _LINUX_IOV_ITER_H */

