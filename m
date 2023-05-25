Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BF3711A42
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 00:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjEYWlo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 18:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241917AbjEYWli (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 18:41:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA82F1A2
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 15:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685054407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FUrVwlJ5El5UIYEfnTZW9jIZIlAoV+8/20tkEUBC5dE=;
        b=Y6Baw+PBjervD2NCg1qevTb5vV8W+7iyHvx7BEiF8TfqUmi6l7oOw+O+6uNWvsgwrRvh/J
        iaO3MNsZhj3rbe370ZbFp6bRmlJGj45AG2swWER0m5NhtSoZBxfy1hW/KbKwvmCLX+Og6y
        OzaBZNyrR+a4m0ZXI2ca/DbvCtRF0lY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-fTcodurYMs6Ocu2Sqmj11g-1; Thu, 25 May 2023 18:40:02 -0400
X-MC-Unique: fTcodurYMs6Ocu2Sqmj11g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC01485A5BD;
        Thu, 25 May 2023 22:40:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5EAFC1121314;
        Thu, 25 May 2023 22:39:59 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>
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
Subject: [RFC PATCH v2 1/3] mm: Don't pin ZERO_PAGE in pin_user_pages()
Date:   Thu, 25 May 2023 23:39:51 +0100
Message-Id: <20230525223953.225496-2-dhowells@redhat.com>
In-Reply-To: <20230525223953.225496-1-dhowells@redhat.com>
References: <20230525223953.225496-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make pin_user_pages*() leave a ZERO_PAGE unpinned if it extracts a pointer
to it from the page tables and make unpin_user_page*() correspondingly
ignore a ZERO_PAGE when unpinning.  We don't want to risk overrunning a
zero page's refcount as we're only allowed ~2 million pins on it -
something that userspace can conceivably trigger.

Add a pair of functions to test whether a page or a folio is a ZERO_PAGE.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@infradead.org>
cc: David Hildenbrand <david@redhat.com>
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
    ver #2)
     - Fix use of ZERO_PAGE().
     - Add is_zero_page() and is_zero_folio() wrappers.
     - Return the zero page obtained, not ZERO_PAGE(0) unconditionally.

 include/linux/pgtable.h | 10 ++++++++++
 mm/gup.c                | 25 ++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index c5a51481bbb9..2b0431a11de2 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1245,6 +1245,16 @@ static inline unsigned long my_zero_pfn(unsigned long addr)
 }
 #endif /* CONFIG_MMU */
 
+static inline bool is_zero_page(const struct page *page)
+{
+	return is_zero_pfn(page_to_pfn(page));
+}
+
+static inline bool is_zero_folio(const struct folio *folio)
+{
+	return is_zero_page(&folio->page);
+}
+
 #ifdef CONFIG_MMU
 
 #ifndef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/mm/gup.c b/mm/gup.c
index bbe416236593..69b002628f5d 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -51,7 +51,8 @@ static inline void sanity_check_pinned_pages(struct page **pages,
 		struct page *page = *pages;
 		struct folio *folio = page_folio(page);
 
-		if (!folio_test_anon(folio))
+		if (is_zero_page(page) ||
+		    !folio_test_anon(folio))
 			continue;
 		if (!folio_test_large(folio) || folio_test_hugetlb(folio))
 			VM_BUG_ON_PAGE(!PageAnonExclusive(&folio->page), page);
@@ -131,6 +132,13 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
 	else if (flags & FOLL_PIN) {
 		struct folio *folio;
 
+		/*
+		 * Don't take a pin on the zero page - it's not going anywhere
+		 * and it is used in a *lot* of places.
+		 */
+		if (is_zero_page(page))
+			return page_folio(page);
+
 		/*
 		 * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
 		 * right zone, so fail and let the caller fall back to the slow
@@ -180,6 +188,8 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
 static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
 {
 	if (flags & FOLL_PIN) {
+		if (is_zero_folio(folio))
+			return;
 		node_stat_mod_folio(folio, NR_FOLL_PIN_RELEASED, refs);
 		if (folio_test_large(folio))
 			atomic_sub(refs, &folio->_pincount);
@@ -224,6 +234,13 @@ int __must_check try_grab_page(struct page *page, unsigned int flags)
 	if (flags & FOLL_GET)
 		folio_ref_inc(folio);
 	else if (flags & FOLL_PIN) {
+		/*
+		 * Don't take a pin on the zero page - it's not going anywhere
+		 * and it is used in a *lot* of places.
+		 */
+		if (is_zero_page(page))
+			return 0;
+
 		/*
 		 * Similar to try_grab_folio(): be sure to *also*
 		 * increment the normal page refcount field at least once,
@@ -3079,6 +3096,9 @@ EXPORT_SYMBOL_GPL(get_user_pages_fast);
  *
  * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
  * see Documentation/core-api/pin_user_pages.rst for further details.
+ *
+ * Note that if the zero_page is amongst the returned pages, it will not have
+ * pins in it and unpin_user_page() will not remove pins from it.
  */
 int pin_user_pages_fast(unsigned long start, int nr_pages,
 			unsigned int gup_flags, struct page **pages)
@@ -3161,6 +3181,9 @@ EXPORT_SYMBOL(pin_user_pages);
  * pin_user_pages_unlocked() is the FOLL_PIN variant of
  * get_user_pages_unlocked(). Behavior is the same, except that this one sets
  * FOLL_PIN and rejects FOLL_GET.
+ *
+ * Note that if the zero_page is amongst the returned pages, it will not have
+ * pins in it and unpin_user_page() will not remove pins from it.
  */
 long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 			     struct page **pages, unsigned int gup_flags)

