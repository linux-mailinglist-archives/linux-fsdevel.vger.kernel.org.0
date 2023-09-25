Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1937AD793
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 14:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjIYMFr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 08:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjIYMFd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:05:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3C2124
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 05:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695643422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ENB7CtH73xnlPC5Szfr84FelPyw0n3TXhDinmckBTOE=;
        b=BFEkW4ctiMudCUG7eqS9vzak+AUlX6zdsBmIB562G2KuwUA8w2PZwznuV8WyY3rJHYR8gF
        DiPBJPRzEs7abTu8fBL4DhgI39QxCsavzMUVpcEALrT2wCn+IEP1ILVoZZGaMPdYQ+gLs4
        aRL1bwbLHOKPJFBk4WtfVFhkdADp2qY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-Tspro7EYNxWz9xyR8d5l5A-1; Mon, 25 Sep 2023 08:03:38 -0400
X-MC-Unique: Tspro7EYNxWz9xyR8d5l5A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07FBD3C1E9D8;
        Mon, 25 Sep 2023 12:03:38 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 609BB14171B6;
        Mon, 25 Sep 2023 12:03:36 +0000 (UTC)
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
Subject: [PATCH v7 08/12] iov_iter: Don't deal with iter->copy_mc in memcpy_from_iter_mc()
Date:   Mon, 25 Sep 2023 13:03:05 +0100
Message-ID: <20230925120309.1731676-9-dhowells@redhat.com>
In-Reply-To: <20230925120309.1731676-1-dhowells@redhat.com>
References: <20230925120309.1731676-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

iter->copy_mc is only used with a bvec iterator and only by
dump_emit_page() in fs/coredump.c so rather than handle this in
memcpy_from_iter_mc() where it is checked repeatedly by _copy_from_iter()
and copy_page_from_iter_atomic(),

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
 lib/iov_iter.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 65374ee91ecd..943aa3cfd7b3 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -253,14 +253,33 @@ size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 EXPORT_SYMBOL_GPL(_copy_mc_to_iter);
 #endif /* CONFIG_ARCH_HAS_COPY_MC */
 
-static size_t memcpy_from_iter_mc(void *iter_from, size_t progress,
-				  size_t len, void *to, void *priv2)
+static __always_inline
+size_t memcpy_from_iter_mc(void *iter_from, size_t progress,
+			   size_t len, void *to, void *priv2)
+{
+	return copy_mc_to_kernel(to + progress, iter_from, len);
+}
+
+static size_t __copy_from_iter_mc(void *addr, size_t bytes, struct iov_iter *i)
 {
-	struct iov_iter *iter = priv2;
+	size_t progress;
 
-	if (iov_iter_is_copy_mc(iter))
-		return copy_mc_to_kernel(to + progress, iter_from, len);
-	return memcpy_from_iter(iter_from, progress, len, to, priv2);
+	if (unlikely(i->count < bytes))
+		bytes = i->count;
+	if (unlikely(!bytes))
+		return 0;
+	progress = iterate_bvec(i, bytes, addr, NULL, memcpy_from_iter_mc);
+	i->count -= progress;
+	return progress;
+}
+
+static __always_inline
+size_t __copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
+{
+	if (unlikely(iov_iter_is_copy_mc(i)))
+		return __copy_from_iter_mc(addr, bytes, i);
+	return iterate_and_advance(i, bytes, addr,
+				   copy_from_user_iter, memcpy_from_iter);
 }
 
 size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
@@ -270,9 +289,7 @@ size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 
 	if (user_backed_iter(i))
 		might_fault();
-	return iterate_and_advance2(i, bytes, addr, i,
-				    copy_from_user_iter,
-				    memcpy_from_iter_mc);
+	return __copy_from_iter(addr, bytes, i);
 }
 EXPORT_SYMBOL(_copy_from_iter);
 
@@ -493,9 +510,7 @@ size_t copy_page_from_iter_atomic(struct page *page, size_t offset,
 		}
 
 		p = kmap_atomic(page) + offset;
-		n = iterate_and_advance2(i, n, p, i,
-					 copy_from_user_iter,
-					 memcpy_from_iter_mc);
+		__copy_from_iter(p, n, i);
 		kunmap_atomic(p);
 		copied += n;
 		offset += n;

