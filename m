Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6857AD797
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 14:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjIYMFw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 08:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjIYMFi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:05:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B537120
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 05:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695643418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4obcSyEH8f0LI+hqbulIObwIk6RPpIYigX0Ml5LHEtM=;
        b=GXRJbgGHZ8xnrpjd2hrIGcXIS6ozcnx87Q7lgZfyyWozQ6df9nUjdkD66sP5erkeS14ldI
        9G1bgwMJx5Ik+bDTKQxby5KOcA5xTopVj05PBpJC0sinqf+dRV4PgWgRe8qWisn1fBQ+I8
        KrpZhNv8/ZkdbXAUH/RHjZAPsTIbMk4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-136-cDj4weHpMsW5nB2aWNtwwg-1; Mon, 25 Sep 2023 08:03:34 -0400
X-MC-Unique: cDj4weHpMsW5nB2aWNtwwg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F33E800B35;
        Mon, 25 Sep 2023 12:03:33 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8F8551E3;
        Mon, 25 Sep 2023 12:03:31 +0000 (UTC)
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
Subject: [PATCH v7 06/12] iov_iter: Derive user-backedness from the iterator type
Date:   Mon, 25 Sep 2023 13:03:03 +0100
Message-ID: <20230925120309.1731676-7-dhowells@redhat.com>
In-Reply-To: <20230925120309.1731676-1-dhowells@redhat.com>
References: <20230925120309.1731676-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the iterator type to determine whether an iterator is user-backed or
not rather than using a special flag for it.  Now that ITER_UBUF and
ITER_IOVEC are 0 and 1, they can be checked with a single comparison.

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
 include/linux/uio.h | 4 +---
 lib/iov_iter.c      | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index bef8e56aa45c..65d9143f83c8 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -43,7 +43,6 @@ struct iov_iter {
 	bool copy_mc;
 	bool nofault;
 	bool data_source;
-	bool user_backed;
 	size_t iov_offset;
 	/*
 	 * Hack alert: overlay ubuf_iovec with iovec + count, so
@@ -140,7 +139,7 @@ static inline unsigned char iov_iter_rw(const struct iov_iter *i)
 
 static inline bool user_backed_iter(const struct iov_iter *i)
 {
-	return i->user_backed;
+	return iter_is_ubuf(i) || iter_is_iovec(i);
 }
 
 /*
@@ -380,7 +379,6 @@ static inline void iov_iter_ubuf(struct iov_iter *i, unsigned int direction,
 	*i = (struct iov_iter) {
 		.iter_type = ITER_UBUF,
 		.copy_mc = false,
-		.user_backed = true,
 		.data_source = direction,
 		.ubuf = buf,
 		.count = count,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 27234a820eeb..227c9f536b94 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -290,7 +290,6 @@ void iov_iter_init(struct iov_iter *i, unsigned int direction,
 		.iter_type = ITER_IOVEC,
 		.copy_mc = false,
 		.nofault = false,
-		.user_backed = true,
 		.data_source = direction,
 		.__iov = iov,
 		.nr_segs = nr_segs,

