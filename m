Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C2F7A10AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 00:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjINWQh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 18:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjINWQb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 18:16:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 694162712
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 15:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694729739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=71Btu3XYwWZK+FmqHCgDmjFCfU/69a0+IvtQoWaiN/g=;
        b=bCD8M9kq5MNb3a+QlwWkJbHUpPxF3M9+wJVLZivwQhI47Y8L9Xf43gNC+zXwz5uFz9CQma
        mOOszjIWaRHPZ82wLLSnI0TpQ7hkWpNxz8XX1u6zXW1ROF4UXyWtyVwJshEfyueALI76uU
        wWs8NfCBrXA33qYMnT3zZ+5i63MB/XE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-xSilx-EINMK-s9yGWPKnCA-1; Thu, 14 Sep 2023 18:15:34 -0400
X-MC-Unique: xSilx-EINMK-s9yGWPKnCA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 855E3857A9C;
        Thu, 14 Sep 2023 22:15:33 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2331E2026D4B;
        Thu, 14 Sep 2023 22:15:31 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
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
Subject: [RFC PATCH 1/9] iov_iter: Fix some checkpatch complaints in kunit tests
Date:   Thu, 14 Sep 2023 23:15:18 +0100
Message-ID: <20230914221526.3153402-2-dhowells@redhat.com>
In-Reply-To: <20230914221526.3153402-1-dhowells@redhat.com>
References: <20230914221526.3153402-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

