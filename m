Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0618E675C3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 18:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjATR5j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 12:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjATR5i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:57:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD444345B
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 09:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674237373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CYkyXriQe+db2xB55AZm41G9E0QZGdRv8ItoT4z1ez8=;
        b=NHoz7TD3FkBbD1J6fx3k6cUfOhIcs8DA/GsLEcUBbQAEG4Dofd/qKjOCDPYT5cBEjwsZpy
        B8geUnFeV0kzd/PaEUWppAUn9Q3er/CRnLd1pDCM+CcY28PlBb4y8l44RaPj55MEOYB9KV
        QrUtJ24IcKZdb+z2JllRK6jFH8mGPdI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-rOeDDMKeNQmo4B5_T1HLmg-1; Fri, 20 Jan 2023 12:56:09 -0500
X-MC-Unique: rOeDDMKeNQmo4B5_T1HLmg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04CEB185A794;
        Fri, 20 Jan 2023 17:56:09 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C3A5492C3C;
        Fri, 20 Jan 2023 17:56:07 +0000 (UTC)
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
Subject: [PATCH v7 3/8] mm: Provide a helper to drop a pin/ref on a page
Date:   Fri, 20 Jan 2023 17:55:51 +0000
Message-Id: <20230120175556.3556978-4-dhowells@redhat.com>
In-Reply-To: <20230120175556.3556978-1-dhowells@redhat.com>
References: <20230120175556.3556978-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
index f3f196e4d66d..f1cf8f4eb946 100644
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

