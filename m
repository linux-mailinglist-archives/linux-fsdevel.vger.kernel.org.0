Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6238A7AB1C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 14:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbjIVMEu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 08:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbjIVMEZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 08:04:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA57ACC5
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Sep 2023 05:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695384178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hYOoT+N3+ZXg5kUOP5JOmaiFuOq7EbJgQKHzR3cvg3M=;
        b=QlbdtTKSRMEP5wQpKgMDMNzKzcp/YMPv0ZgWrcBak6v5FpWoyslKZJtgGfLyTZtfqtc6hf
        6ziYPLpqpKcCLlhSCJkorB6U4/S8s5LCPfvojAXf9A2njseq99J/PUn4Vyo/8j4CjJ70He
        r5IL13zYjOGFGhVDy1qns+Qa/bUKmVo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-ZTcYAYuYMcqv6NQGNev8hg-1; Fri, 22 Sep 2023 08:02:55 -0400
X-MC-Unique: ZTcYAYuYMcqv6NQGNev8hg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9DF423816C89;
        Fri, 22 Sep 2023 12:02:54 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EFD0D711282;
        Fri, 22 Sep 2023 12:02:52 +0000 (UTC)
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
Subject: [PATCH v6 09/13] iov_iter: Add a kernel-type iterator-only iteration function
Date:   Fri, 22 Sep 2023 13:02:23 +0100
Message-ID: <20230922120227.1173720-10-dhowells@redhat.com>
In-Reply-To: <20230922120227.1173720-1-dhowells@redhat.com>
References: <20230922120227.1173720-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
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

Notes:
    Changes
    =======
    ver #6)
     - Document the priv2 arg of iterate_and_advance_kernel().

 include/linux/iov_iter.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/iov_iter.h b/include/linux/iov_iter.h
index 270454a6703d..d8733dc22b54 100644
--- a/include/linux/iov_iter.h
+++ b/include/linux/iov_iter.h
@@ -271,4 +271,36 @@ size_t iterate_and_advance(struct iov_iter *iter, size_t len, void *priv,
 	return iterate_and_advance2(iter, len, priv, NULL, ustep, step);
 }
 
+/**
+ * iterate_and_advance_kernel - Iterate over a kernel iterator
+ * @iter: The iterator to iterate over.
+ * @len: The amount to iterate over.
+ * @priv: Data for the step functions.
+ * @priv2: More data for the step functions.
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

