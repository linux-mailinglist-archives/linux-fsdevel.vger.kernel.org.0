Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5E27AB0F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 13:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbjIVLcK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 07:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbjIVLbx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:31:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B776DCA
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Sep 2023 04:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695382260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0wrDnIJNvyLeCaZ76kAPm12sjpZAz+xrWcuHtRTLq38=;
        b=ZeThmPSPpdJ/E22HolvVFFnYoGzBuRQKuVWimCFTsFjehmoM2hMfiJ2/Vajd6M9PvEERzD
        wBUEkg04tKi/cmclGAZ5FzkWO5aX0xuuTsiMn/mPnG77kwIHwLMJA9es2nomEbi1rBxTGU
        YtBh8gCWggVcSjM88zkfCfYkctqyDss=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-ABTkBwruOi-eHMhSCrIRAQ-1; Fri, 22 Sep 2023 07:30:56 -0400
X-MC-Unique: ABTkBwruOi-eHMhSCrIRAQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6A04800883;
        Fri, 22 Sep 2023 11:30:55 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A69D72156701;
        Fri, 22 Sep 2023 11:30:53 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@ACULAB.COM>,
        Matthew Wilcox <willy@infradead.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 04/10] iov_iter: Consolidate bvec pattern checking
Date:   Fri, 22 Sep 2023 12:30:32 +0100
Message-ID: <20230922113038.1135236-5-dhowells@redhat.com>
In-Reply-To: <20230922113038.1135236-1-dhowells@redhat.com>
References: <20230922113038.1135236-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make the BVEC-testing functions use the consolidated pattern checking
functions to reduce the amount of duplicated code.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Christian Brauner <brauner@kernel.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: David Hildenbrand <david@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: Brendan Higgins <brendanhiggins@google.com>
cc: David Gow <davidgow@google.com>
cc: linux-kselftest@vger.kernel.org
cc: kunit-dev@googlegroups.com
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
---
 lib/kunit_iov_iter.c | 42 +++++++++++-------------------------------
 1 file changed, 11 insertions(+), 31 deletions(-)

diff --git a/lib/kunit_iov_iter.c b/lib/kunit_iov_iter.c
index 4925ca37cde6..eb86371b67d0 100644
--- a/lib/kunit_iov_iter.c
+++ b/lib/kunit_iov_iter.c
@@ -107,9 +107,11 @@ static void iov_kunit_build_to_reference_pattern(struct kunit *test, u8 *scratch
 	int i, patt = 0;
 
 	memset(scratch, 0, bufsize);
-	for (; pr->page >= 0; pr++)
+	for (; pr->page >= 0; pr++) {
+		u8 *p = scratch + pr->page * PAGE_SIZE;
 		for (i = pr->from; i < pr->to; i++)
-			scratch[i] = pattern(patt++);
+			p[i] = pattern(patt++);
+	}
 }
 
 /*
@@ -124,8 +126,10 @@ static void iov_kunit_build_from_reference_pattern(struct kunit *test, u8 *buffe
 
 	memset(buffer, 0, bufsize);
 	for (; pr->page >= 0; pr++) {
+		size_t patt = pr->page * PAGE_SIZE;
+
 		for (j = pr->from; j < pr->to; j++) {
-			buffer[i++] = pattern(j);
+			buffer[i++] = pattern(patt + j);
 			if (i >= bufsize)
 				return;
 		}
@@ -287,13 +291,12 @@ static void __init iov_kunit_load_bvec(struct kunit *test,
  */
 static void __init iov_kunit_copy_to_bvec(struct kunit *test)
 {
-	const struct iov_kunit_range *pr;
 	struct iov_iter iter;
 	struct bio_vec bvec[8];
 	struct page **spages, **bpages;
 	u8 *scratch, *buffer;
 	size_t bufsize, npages, size, copied;
-	int i, patt;
+	int i;
 
 	bufsize = 0x100000;
 	npages = bufsize / PAGE_SIZE;
@@ -315,16 +318,7 @@ static void __init iov_kunit_copy_to_bvec(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, iter.count, 0);
 	KUNIT_EXPECT_EQ(test, iter.nr_segs, 0);
 
-	/* Build the expected image in the scratch buffer. */
-	patt = 0;
-	memset(scratch, 0, bufsize);
-	for (pr = bvec_test_ranges; pr->page >= 0; pr++) {
-		u8 *p = scratch + pr->page * PAGE_SIZE;
-
-		for (i = pr->from; i < pr->to; i++)
-			p[i] = pattern(patt++);
-	}
-
+	iov_kunit_build_to_reference_pattern(test, scratch, bufsize, bvec_test_ranges);
 	iov_kunit_check_pattern(test, buffer, scratch, bufsize);
 	KUNIT_SUCCEED();
 }
@@ -334,13 +328,12 @@ static void __init iov_kunit_copy_to_bvec(struct kunit *test)
  */
 static void __init iov_kunit_copy_from_bvec(struct kunit *test)
 {
-	const struct iov_kunit_range *pr;
 	struct iov_iter iter;
 	struct bio_vec bvec[8];
 	struct page **spages, **bpages;
 	u8 *scratch, *buffer;
 	size_t bufsize, npages, size, copied;
-	int i, j;
+	int i;
 
 	bufsize = 0x100000;
 	npages = bufsize / PAGE_SIZE;
@@ -362,20 +355,7 @@ static void __init iov_kunit_copy_from_bvec(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, iter.count, 0);
 	KUNIT_EXPECT_EQ(test, iter.nr_segs, 0);
 
-	/* Build the expected image in the main buffer. */
-	i = 0;
-	memset(buffer, 0, bufsize);
-	for (pr = bvec_test_ranges; pr->page >= 0; pr++) {
-		size_t patt = pr->page * PAGE_SIZE;
-
-		for (j = pr->from; j < pr->to; j++) {
-			buffer[i++] = pattern(patt + j);
-			if (i >= bufsize)
-				goto stop;
-		}
-	}
-stop:
-
+	iov_kunit_build_from_reference_pattern(test, buffer, bufsize, bvec_test_ranges);
 	iov_kunit_check_pattern(test, buffer, scratch, bufsize);
 	KUNIT_SUCCEED();
 }

