Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E07279EF8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 18:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjIMQ6Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 12:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjIMQ6A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:58:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4D741BEC
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 09:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694624236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p+t8ChtS3C0mCAtd18JzNSIJcCnKtYlpMvVgh9PlkwE=;
        b=UQPF4PWsnCasFEdyyysVTcjyKbiJexdcwJzzX/ZEtw8yAi2J7HyAlLEsyS0w3Bj21DDxBO
        usWo7iqC4U+uS6GwPByAIIRnq6Of9xCdJOhCrKo1rEsgVIVrBFnCtk2YANkkgGk1VxNQ3f
        gfbHE/BvFvLR6nsntTyYuAIJD3R+hwY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-542-5xC_0HubPGGLzilTHkSTMQ-1; Wed, 13 Sep 2023 12:57:13 -0400
X-MC-Unique: 5xC_0HubPGGLzilTHkSTMQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 783FB85531D;
        Wed, 13 Sep 2023 16:57:12 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D43F240C6EA8;
        Wed, 13 Sep 2023 16:57:10 +0000 (UTC)
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
Subject: [PATCH v4 08/13] iov_iter: Remove the copy_mc flag and associated functions
Date:   Wed, 13 Sep 2023 17:56:43 +0100
Message-ID: <20230913165648.2570623-9-dhowells@redhat.com>
In-Reply-To: <20230913165648.2570623-1-dhowells@redhat.com>
References: <20230913165648.2570623-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

copy_to/from_iter() now always return a short copy on MCE, so we don't need
to have special handling.

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
 include/linux/uio.h | 16 ----------------
 lib/iov_iter.c      |  5 -----
 2 files changed, 21 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index e2a248dad80b..cc250892872e 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -40,7 +40,6 @@ struct iov_iter_state {
 
 struct iov_iter {
 	u8 iter_type;
-	bool copy_mc;
 	bool nofault;
 	bool data_source;
 	union {
@@ -251,22 +250,8 @@ size_t _copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i);
 
 #ifdef CONFIG_ARCH_HAS_COPY_MC
 size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
-static inline void iov_iter_set_copy_mc(struct iov_iter *i)
-{
-	i->copy_mc = true;
-}
-
-static inline bool iov_iter_is_copy_mc(const struct iov_iter *i)
-{
-	return i->copy_mc;
-}
 #else
 #define _copy_mc_to_iter _copy_to_iter
-static inline void iov_iter_set_copy_mc(struct iov_iter *i) { }
-static inline bool iov_iter_is_copy_mc(const struct iov_iter *i)
-{
-	return false;
-}
 #endif
 
 size_t iov_iter_zero(size_t bytes, struct iov_iter *);
@@ -381,7 +366,6 @@ static inline void iov_iter_ubuf(struct iov_iter *i, unsigned int direction,
 	WARN_ON(direction & ~(READ | WRITE));
 	*i = (struct iov_iter) {
 		.iter_type = ITER_UBUF,
-		.copy_mc = false,
 		.data_source = direction,
 		.ubuf = buf,
 		.count = count,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index b574601783bc..66d2a16774fe 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -169,7 +169,6 @@ void iov_iter_init(struct iov_iter *i, unsigned int direction,
 	WARN_ON(direction & ~(READ | WRITE));
 	*i = (struct iov_iter) {
 		.iter_type = ITER_IOVEC,
-		.copy_mc = false,
 		.nofault = false,
 		.data_source = direction,
 		.__iov = iov,
@@ -629,7 +628,6 @@ void iov_iter_kvec(struct iov_iter *i, unsigned int direction,
 	WARN_ON(direction & ~(READ | WRITE));
 	*i = (struct iov_iter){
 		.iter_type = ITER_KVEC,
-		.copy_mc = false,
 		.data_source = direction,
 		.kvec = kvec,
 		.nr_segs = nr_segs,
@@ -646,7 +644,6 @@ void iov_iter_bvec(struct iov_iter *i, unsigned int direction,
 	WARN_ON(direction & ~(READ | WRITE));
 	*i = (struct iov_iter){
 		.iter_type = ITER_BVEC,
-		.copy_mc = false,
 		.data_source = direction,
 		.bvec = bvec,
 		.nr_segs = nr_segs,
@@ -675,7 +672,6 @@ void iov_iter_xarray(struct iov_iter *i, unsigned int direction,
 	BUG_ON(direction & ~1);
 	*i = (struct iov_iter) {
 		.iter_type = ITER_XARRAY,
-		.copy_mc = false,
 		.data_source = direction,
 		.xarray = xarray,
 		.xarray_start = start,
@@ -699,7 +695,6 @@ void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count)
 	BUG_ON(direction != READ);
 	*i = (struct iov_iter){
 		.iter_type = ITER_DISCARD,
-		.copy_mc = false,
 		.data_source = false,
 		.count = count,
 		.iov_offset = 0

