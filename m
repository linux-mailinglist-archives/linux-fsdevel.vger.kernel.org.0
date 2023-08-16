Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DE577E124
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 14:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244960AbjHPMJD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 08:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244957AbjHPMIl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:08:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C18626A9
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 05:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692187682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wO3T+Kgn8IqvgBuNhCcF+dgBv+VoPvzdg3BdkPf9/3I=;
        b=S+6bCzf0g5DmHq4V6IkpR/MQoVOzs1RhjEqNZ+6FMTZnhGUbB/q78D0ofezlR5YmoCBZ89
        PukHRsSVwtzzj39pAfTSugfJS05+pEJkAUpC/suX0wejSIRrGOuZvMvxCp2Lb6v+JQfNjk
        y5Y8MJfGyBDyfvCwKzzbq+emsmIZZ1w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-ow2g6_iFP9a7UhFz3Anncw-1; Wed, 16 Aug 2023 08:07:59 -0400
X-MC-Unique: ow2g6_iFP9a7UhFz3Anncw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF1CC101A53C;
        Wed, 16 Aug 2023 12:07:58 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D03D91121314;
        Wed, 16 Aug 2023 12:07:56 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@list.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@ACULAB.COM>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] iov_iter: Don't deal with iter->copy_mc in memcpy_from_iter_mc()
Date:   Wed, 16 Aug 2023 13:07:41 +0100
Message-ID: <20230816120741.534415-3-dhowells@redhat.com>
In-Reply-To: <20230816120741.534415-1-dhowells@redhat.com>
References: <20230816120741.534415-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

iter->copy_mc is only used with a bvec iterator and only by
dump_emit_page() in fs/coredump.c so rather than handle this in
memcpy_from_iter_mc() where it is checked repeatedly by _copy_from_iter() and
copy_page_from_iter_atomic(),
---
 lib/iov_iter.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 378da0cb3069..33febccadd9d 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -450,14 +450,33 @@ size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 EXPORT_SYMBOL_GPL(_copy_mc_to_iter);
 #endif /* CONFIG_ARCH_HAS_COPY_MC */
 
-static size_t memcpy_from_iter_mc(void *iter_from, size_t progress,
-				  size_t len, void *to, void *priv2)
+static __always_inline
+size_t memcpy_from_iter_mc(void *iter_from, size_t progress,
+			   size_t len, void *to, void *priv2)
 {
-	struct iov_iter *iter = priv2;
+	return copy_mc_to_kernel(to + progress, iter_from, len);
+}
 
-	if (iov_iter_is_copy_mc(iter))
-		return copy_mc_to_kernel(to + progress, iter_from, len);
-	return memcpy_from_iter(iter_from, progress, len, to, priv2);
+static size_t __copy_from_iter_mc(void *addr, size_t bytes, struct iov_iter *i)
+{
+	size_t progress;
+
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
@@ -467,9 +486,7 @@ size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 
 	if (user_backed_iter(i))
 		might_fault();
-	return iterate_and_advance2(i, bytes, addr, i,
-				    copy_from_user_iter,
-				    memcpy_from_iter_mc);
+	return __copy_from_iter(addr, bytes, i);
 }
 EXPORT_SYMBOL(_copy_from_iter);
 
@@ -690,9 +707,7 @@ size_t copy_page_from_iter_atomic(struct page *page, size_t offset,
 		}
 
 		p = kmap_atomic(page) + offset;
-		n = iterate_and_advance2(i, n, p, i,
-					 copy_from_user_iter,
-					 memcpy_from_iter_mc);
+		__copy_from_iter(p, n, i);
 		kunmap_atomic(p);
 		copied += n;
 		offset += n;

