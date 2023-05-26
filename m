Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACA971257B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 13:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242986AbjEZLar (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 07:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235332AbjEZLaq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 07:30:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFDD19C
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 May 2023 04:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685100563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/oa1BFyOPAnXCxzKNg+OmyZ2j7EgUWqexyoMi96HVck=;
        b=alBGmeMCpi7w2XAV13WXRT+5iI64s0XhcT4R/LinvQFNIeF5Ii0MLtD24BeQMsReDjtrd0
        smojueliXHj4jmkcc3J7CdIgQHC1vZRQIuuzwEG5p0MLZYvAD6HBmW/azR6s0sGpS/U+Q6
        k/oxyuHbP1A69m4SInvSK/vYIm4Xn6w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-5Dx9Zud5NgaNs8x-s-9Znw-1; Fri, 26 May 2023 07:29:19 -0400
X-MC-Unique: 5Dx9Zud5NgaNs8x-s-9Znw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B8933185A78F;
        Fri, 26 May 2023 11:29:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 470B0200AD47;
        Fri, 26 May 2023 11:29:15 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 2/3] mm: Provide a function to get an additional pin on a page
Date:   Fri, 26 May 2023 12:28:58 +0100
Message-Id: <20230526112859.654506-3-dhowells@redhat.com>
In-Reply-To: <20230526112859.654506-1-dhowells@redhat.com>
References: <20230526112859.654506-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a function to get an additional pin on a page that we already have
a pin on.  This will be used in fs/direct-io.c when dispatching multiple
bios to a page we've extracted from a user-backed iter rather than redoing
the extraction.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@infradead.org>
cc: David Hildenbrand <david@redhat.com>
cc: Lorenzo Stoakes <lstoakes@gmail.com>
cc: Andrew Morton <akpm@linux-foundation.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Matthew Wilcox <willy@infradead.org>
cc: Jan Kara <jack@suse.cz>
cc: Jeff Layton <jlayton@kernel.org>
cc: Jason Gunthorpe <jgg@nvidia.com>
cc: Logan Gunthorpe <logang@deltatee.com>
cc: Hillf Danton <hdanton@sina.com>
cc: Christian Brauner <brauner@kernel.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-fsdevel@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-kernel@vger.kernel.org
cc: linux-mm@kvack.org
---

Notes:
    ver #3)
     - Rename to folio_add_pin().
     - Change to using is_zero_folio()

 include/linux/mm.h |  1 +
 mm/gup.c           | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3c2f6b452586..200068d98686 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2405,6 +2405,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
 			unsigned int gup_flags, struct page **pages);
 int pin_user_pages_fast(unsigned long start, int nr_pages,
 			unsigned int gup_flags, struct page **pages);
+void folio_add_pin(struct folio *folio);
 
 int account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc);
 int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
diff --git a/mm/gup.c b/mm/gup.c
index ad28261dcafd..08fdd84088d1 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -275,6 +275,33 @@ void unpin_user_page(struct page *page)
 }
 EXPORT_SYMBOL(unpin_user_page);
 
+/**
+ * folio_add_pin - Try to get an additional pin on a pinned folio
+ * @folio: The folio to be pinned
+ *
+ * Get an additional pin on a folio we already have a pin on.  Makes no change
+ * if the folio is a zero_page.
+ */
+void folio_add_pin(struct folio *folio)
+{
+	if (is_zero_folio(folio))
+		return;
+
+	/*
+	 * Similar to try_grab_folio(): be sure to *also* increment the normal
+	 * page refcount field at least once, so that the page really is
+	 * pinned.
+	 */
+	if (folio_test_large(folio)) {
+		WARN_ON_ONCE(atomic_read(&folio->_pincount) < 1);
+		folio_ref_add(folio, 1);
+		atomic_add(1, &folio->_pincount);
+	} else {
+		WARN_ON_ONCE(folio_ref_count(folio) < GUP_PIN_COUNTING_BIAS);
+		folio_ref_add(folio, GUP_PIN_COUNTING_BIAS);
+	}
+}
+
 static inline struct folio *gup_folio_range_next(struct page *start,
 		unsigned long npages, unsigned long i, unsigned int *ntails)
 {

