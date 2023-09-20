Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50D77A82AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 15:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbjITNFQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 09:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236433AbjITNFP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:05:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD91D6
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 06:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695215061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=71Btu3XYwWZK+FmqHCgDmjFCfU/69a0+IvtQoWaiN/g=;
        b=T8J+9QjDGHwY1GtZP0ZU/C7n9Hs/E1fJyUz94omoXzNtB3H9zmpqhHQc/eEMO60fqqddRj
        s40SzDUmNElsM771N+cEifH42hyDNKC4R7jsfu70PFH+TB46UcaBMyPw0fyeW7VfgGGWzj
        XJ6wHSGkWyxcy97h94LqBqFJA4jSqOA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-499-gqjx5typNpO8hKhRJZWB-g-1; Wed, 20 Sep 2023 09:04:15 -0400
X-MC-Unique: gqjx5typNpO8hKhRJZWB-g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 540B189C6A3;
        Wed, 20 Sep 2023 13:04:14 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09F2E492B05;
        Wed, 20 Sep 2023 13:04:08 +0000 (UTC)
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
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [RFC PATCH v2 1/9] iov_iter: Fix some checkpatch complaints in kunit tests
Date:   Wed, 20 Sep 2023 14:03:52 +0100
Message-ID: <20230920130400.203330-2-dhowells@redhat.com>
In-Reply-To: <20230920130400.203330-1-dhowells@redhat.com>
References: <20230920130400.203330-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix some checkpatch complaints in the new iov_iter kunit tests:

 (1) Some lines had eight spaces instead of a tab at the start.

 (2) Checkpatch doesn't like (void*)(unsigned long)0xnnnnnULL, so switch to
     using POISON_POINTER_DELTA plus an offset instead.

Reported-by: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
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
 lib/kunit_iov_iter.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/kunit_iov_iter.c b/lib/kunit_iov_iter.c
index 859b67c4d697..4a6c0efd33f5 100644
--- a/lib/kunit_iov_iter.c
+++ b/lib/kunit_iov_iter.c
@@ -53,7 +53,7 @@ static void *__init iov_kunit_create_buffer(struct kunit *test,
 	void *buffer;
 
 	pages = kunit_kcalloc(test, npages, sizeof(struct page *), GFP_KERNEL);
-        KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pages);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pages);
 	*ppages = pages;
 
 	got = alloc_pages_bulk_array(GFP_KERNEL, npages, pages);
@@ -63,7 +63,7 @@ static void *__init iov_kunit_create_buffer(struct kunit *test,
 	}
 
 	buffer = vmap(pages, npages, VM_MAP | VM_MAP_PUT_PAGES, PAGE_KERNEL);
-        KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buffer);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buffer);
 
 	kunit_add_action_or_reset(test, iov_kunit_unmap, buffer);
 	return buffer;
@@ -548,7 +548,7 @@ static void __init iov_kunit_extract_pages_kvec(struct kunit *test)
 		size_t offset0 = LONG_MAX;
 
 		for (i = 0; i < ARRAY_SIZE(pagelist); i++)
-			pagelist[i] = (void *)(unsigned long)0xaa55aa55aa55aa55ULL;
+			pagelist[i] = (void *)POISON_POINTER_DELTA + 0x5a;
 
 		len = iov_iter_extract_pages(&iter, &pages, 100 * 1024,
 					     ARRAY_SIZE(pagelist), 0, &offset0);
@@ -626,7 +626,7 @@ static void __init iov_kunit_extract_pages_bvec(struct kunit *test)
 		size_t offset0 = LONG_MAX;
 
 		for (i = 0; i < ARRAY_SIZE(pagelist); i++)
-			pagelist[i] = (void *)(unsigned long)0xaa55aa55aa55aa55ULL;
+			pagelist[i] = (void *)POISON_POINTER_DELTA + 0x5a;
 
 		len = iov_iter_extract_pages(&iter, &pages, 100 * 1024,
 					     ARRAY_SIZE(pagelist), 0, &offset0);
@@ -709,7 +709,7 @@ static void __init iov_kunit_extract_pages_xarray(struct kunit *test)
 			size_t offset0 = LONG_MAX;
 
 			for (i = 0; i < ARRAY_SIZE(pagelist); i++)
-				pagelist[i] = (void *)(unsigned long)0xaa55aa55aa55aa55ULL;
+				pagelist[i] = (void *)POISON_POINTER_DELTA + 0x5a;
 
 			len = iov_iter_extract_pages(&iter, &pages, 100 * 1024,
 						     ARRAY_SIZE(pagelist), 0, &offset0);

