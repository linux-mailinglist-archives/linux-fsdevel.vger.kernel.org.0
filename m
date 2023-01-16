Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D706B66D2B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 00:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbjAPXLW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 18:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbjAPXJ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 18:09:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD6C2B0A2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 15:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673910544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QrTYZnqppnIRJJtPh9wzilaUaNto9L5Dg5kn8SyEIfI=;
        b=BobNA1rlgDJUPNXsvgh+9Hc7/XliArhNdjMDl27X3jV5/vEx6NX7KhQrqRIGIZ+9cCeaoP
        nrZxqH+LVFqn3mz+vvlxfdP4Jp0qKnciRXODA4ipYWfT+M/ULugL6ek/OtAK4ZgwW2mjpb
        ojdTfc5Q6R45pCjNyWw0cWNNPhvFaHw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-rgMGV2BLNVaszWNZA-oF3g-1; Mon, 16 Jan 2023 18:09:01 -0500
X-MC-Unique: rgMGV2BLNVaszWNZA-oF3g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2CA8385CCE3;
        Mon, 16 Jan 2023 23:09:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EFE7540C6EC4;
        Mon, 16 Jan 2023 23:08:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v6 08/34] mm: Provide a helper to drop a pin/ref on a page
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 16 Jan 2023 23:08:59 +0000
Message-ID: <167391053934.2311931.17229969100836070492.stgit@warthog.procyon.org.uk>
In-Reply-To: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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
---

 include/linux/mm.h |    3 +++
 mm/gup.c           |   22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3af4ca8b1fe7..8e746a930945 100644
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


