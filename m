Return-Path: <linux-fsdevel+bounces-2902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 589077EC7AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 16:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13066281443
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 15:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C7641A84;
	Wed, 15 Nov 2023 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhb5NmnD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBE73BB46
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 15:50:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697BF1B1
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 07:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700063409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0wrDnIJNvyLeCaZ76kAPm12sjpZAz+xrWcuHtRTLq38=;
	b=dhb5NmnDcONvjd+lk4B0yPMXqAoREMF2HGTaCBVTBJpOnwBYiOvILXjCmGpTrr/O8vBAbs
	F8aLkLuS+jsuq2gJ6giRZzilur4+EGJbNE3+xivt1unDrTOvayUA7MsGiEng/gR/xsToD3
	Cbyj7+9DwCyy68NABFztXpsgQWpvrf0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-gyuK2To_O1O0ylvqZp2Mmg-1; Wed,
 15 Nov 2023 10:50:07 -0500
X-MC-Unique: gyuK2To_O1O0ylvqZp2Mmg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 780DE280FEC2;
	Wed, 15 Nov 2023 15:50:06 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EE6DB492BFD;
	Wed, 15 Nov 2023 15:50:03 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>,
	David Laight <David.Laight@ACULAB.COM>,
	Matthew Wilcox <willy@infradead.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 04/10] iov_iter: Consolidate bvec pattern checking
Date: Wed, 15 Nov 2023 15:49:40 +0000
Message-ID: <20231115154946.3933808-5-dhowells@redhat.com>
In-Reply-To: <20231115154946.3933808-1-dhowells@redhat.com>
References: <20231115154946.3933808-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

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


