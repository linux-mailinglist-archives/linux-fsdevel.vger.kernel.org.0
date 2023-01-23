Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EEA678329
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 18:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbjAWRcD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 12:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbjAWRby (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:31:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C9D2CFD1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 09:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674495023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0jN2ELsFFzyNgM8YEdU+VNSLzU8C5xV57PSPrlYR/T4=;
        b=Qnv+jEyW3cZBEZskzxVnhJS8FF+yMytpw1mpQ/LegsbFWfMF1lQS444nXt4TrkA3tPp+Zi
        jVy1wMmr21Ga3oH8LzBx633hzDSJkRV0sSQ2OsVLl4gTfEoq/kv65KUGqm+wiKv0W1Jheg
        iQh0w9nzEXASYcIdVAW610JJ2A+map4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-PNKYRVDkPJio9uZRskHSUg-1; Mon, 23 Jan 2023 12:30:20 -0500
X-MC-Unique: PNKYRVDkPJio9uZRskHSUg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4A183C14859;
        Mon, 23 Jan 2023 17:30:19 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 49E8D2166B32;
        Mon, 23 Jan 2023 17:30:18 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-mm@kvack.org
Subject: [PATCH v8 03/10] mm: Provide a helper to drop a pin/ref on a page
Date:   Mon, 23 Jan 2023 17:30:00 +0000
Message-Id: <20230123173007.325544-4-dhowells@redhat.com>
In-Reply-To: <20230123173007.325544-1-dhowells@redhat.com>
References: <20230123173007.325544-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a helper in the get_user_pages code to drop a pin or a ref on a
page based on being given FOLL_GET or FOLL_PIN in its flags argument or do
nothing if neither is set.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Christoph Hellwig <hch@lst.de>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-fsdevel@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-mm@kvack.org
---
 include/linux/mm.h |  3 +++
 mm/gup.c           | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8f857163ac89..3de9d88f8524 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1367,6 +1367,9 @@ static inline bool is_cow_mapping(vm_flags_t flags)
 #define SECTION_IN_PAGE_FLAGS
 #endif
 
+void folio_put_unpin(struct folio *folio, unsigned int flags);
+void page_put_unpin(struct page *page, unsigned int flags);
+
 /*
  * The identification function is mainly used by the buddy allocator for
  * determining if two pages could be buddies. We are not really identifying
diff --git a/mm/gup.c b/mm/gup.c
index f45a3a5be53a..3ee4b4c7e0cb 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -191,6 +191,28 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
 		folio_put_refs(folio, refs);
 }
 
+/**
+ * folio_put_unpin - Unpin/put a folio as appropriate
+ * @folio: The folio to release
+ * @flags: gup flags indicating the mode of release (FOLL_*)
+ *
+ * Release a folio according to the flags.  If FOLL_GET is set, the folio has a
+ * ref dropped; if FOLL_PIN is set, it is unpinned; otherwise it is left
+ * unaltered.
+ */
+void folio_put_unpin(struct folio *folio, unsigned int flags)
+{
+	if (flags & (FOLL_GET | FOLL_PIN))
+		gup_put_folio(folio, 1, flags);
+}
+EXPORT_SYMBOL_GPL(folio_put_unpin);
+
+void page_put_unpin(struct page *page, unsigned int flags)
+{
+	folio_put_unpin(page_folio(page), flags);
+}
+EXPORT_SYMBOL_GPL(page_put_unpin);
+
 /**
  * try_grab_page() - elevate a page's refcount by a flag-dependent amount
  * @page:    pointer to page to be grabbed

