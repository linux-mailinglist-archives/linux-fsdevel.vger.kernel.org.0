Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1F279EF95
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 18:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjIMQ60 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 12:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjIMQ6G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:58:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92D181BF3
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 09:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694624235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rhHz2rkHFFU/pzH+hQA/LimHSXRi7J1g2T3941mk2Gc=;
        b=AjUM9IHV8EyrerwDylNpW8nXDKqeNL7PHx7rAPvhZ6YXLvsa/PJCesiK68L5PcNrQelbF9
        jgyvkkDpbPMZ8Jq7lZdsSJqlvDvmK+0UCQqxMFyD5DpAwthuyuB8Nal+SGF1lwpsVqKIyM
        KBnJ8VcCNYz4BqODqsrPlcA3H61M+64=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-2tcJ0K_0Mga54Zz4FQYBNQ-1; Wed, 13 Sep 2023 12:57:08 -0400
X-MC-Unique: 2tcJ0K_0Mga54Zz4FQYBNQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5F09101A529;
        Wed, 13 Sep 2023 16:57:07 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B4AF1054FC1;
        Wed, 13 Sep 2023 16:57:06 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@ACULAB.COM>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/13] iov_iter: Add a kernel-type iterator-only iteration function
Date:   Wed, 13 Sep 2023 17:56:41 +0100
Message-ID: <20230913165648.2570623-7-dhowells@redhat.com>
In-Reply-To: <20230913165648.2570623-1-dhowells@redhat.com>
References: <20230913165648.2570623-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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
 include/linux/iov_iter.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/include/linux/iov_iter.h b/include/linux/iov_iter.h
index 836854847cdf..46e628640934 100644
--- a/include/linux/iov_iter.h
+++ b/include/linux/iov_iter.h
@@ -258,4 +258,39 @@ size_t iterate_and_advance(struct iov_iter *iter, size_t len, void *priv,
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
+	size_t progress;
+
+	if (unlikely(iter->count < len))
+		len = iter->count;
+	if (unlikely(!len))
+		return 0;
+
+	if (iov_iter_is_bvec(iter))
+		progress = iterate_bvec(iter, len, priv, priv2, step);
+	else if (iov_iter_is_kvec(iter))
+		progress = iterate_kvec(iter, len, priv, priv2, step);
+	else if (iov_iter_is_xarray(iter))
+		progress = iterate_xarray(iter, len, priv, priv2, step);
+	else if (WARN_ON_ONCE(unlikely(iter_is_ubuf(iter) || iter_is_iovec(iter))))
+		progress = 0;
+	else
+		progress = len;
+	iter->count -= progress;
+	return progress;
+}
+
 #endif /* _LINUX_IOV_ITER_H */

