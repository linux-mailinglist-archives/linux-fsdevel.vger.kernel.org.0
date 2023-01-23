Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA6867834C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 18:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjAWRdW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 12:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjAWRco (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:32:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF8C2ED57
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 09:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674495051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JKkpA1QDyFR8sFnII4BY3UsDy9lIqmuw1mdMwZBIzUs=;
        b=U71n6Sdih0HLOLwUdKad/ne4Z87oZbljIaHByy87BczCPpZASaLb/+D6qN0cUWpxg4JELN
        cMrGPpzXIsQaJHZU83/vsnQAm2siptJ2yh8Ja/MChhClnqKZ+Sw7qkq63KEx0yVfP4iv2J
        MDWrARRX9ZV6NPRwrLy6thCmZA1KAcU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-Tr5hk-wmOh-yYRPR03ZbOg-1; Mon, 23 Jan 2023 12:30:35 -0500
X-MC-Unique: Tr5hk-wmOh-yYRPR03ZbOg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A0DF858F09;
        Mon, 23 Jan 2023 17:30:34 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E23071121330;
        Mon, 23 Jan 2023 17:30:32 +0000 (UTC)
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
Subject: [PATCH v8 10/10] mm: Renumber FOLL_PIN and FOLL_GET down
Date:   Mon, 23 Jan 2023 17:30:07 +0000
Message-Id: <20230123173007.325544-11-dhowells@redhat.com>
In-Reply-To: <20230123173007.325544-1-dhowells@redhat.com>
References: <20230123173007.325544-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Renumber FOLL_PIN and FOLL_GET down to bit 0 and 1 respectively so that
they are coincidentally the same as BIO_PAGE_PINNED and BIO_PAGE_REFFED and
also so that they can be stored in the bottom two bits of a page pointer
(something I'm looking at for zerocopy socket fragments).

(Note that BIO_PAGE_REFFED should probably be got rid of at some point,
hence why FOLL_PIN is at 0.)

Also renumber down the other FOLL_* flags to close the gaps.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Christoph Hellwig <hch@lst.de>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---

Notes:
    ver #8)
     - Put FOLL_PIN at bit 0 and FOLL_GET at bit 1 to match BIO_PAGE_*.
     - Renumber the remaining flags down to fill in the gap.

 include/linux/mm.h | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3de9d88f8524..c95bc4f77e8f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3074,26 +3074,28 @@ static inline vm_fault_t vmf_error(int err)
 struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 			 unsigned int foll_flags);
 
-#define FOLL_WRITE	0x01	/* check pte is writable */
-#define FOLL_TOUCH	0x02	/* mark page accessed */
-#define FOLL_GET	0x04	/* do get_page on page */
-#define FOLL_DUMP	0x08	/* give error on hole if it would be zero */
-#define FOLL_FORCE	0x10	/* get_user_pages read/write w/o permission */
-#define FOLL_NOWAIT	0x20	/* if a disk transfer is needed, start the IO
+#define FOLL_PIN	0x01	/* pages must be released via unpin_user_page */
+#define FOLL_GET	0x02	/* do get_page on page (equivalent to BIO_FOLL_GET) */
+#define FOLL_WRITE	0x04	/* check pte is writable */
+#define FOLL_TOUCH	0x08	/* mark page accessed */
+#define FOLL_DUMP	0x10	/* give error on hole if it would be zero */
+#define FOLL_FORCE	0x20	/* get_user_pages read/write w/o permission */
+#define FOLL_NOWAIT	0x40	/* if a disk transfer is needed, start the IO
 				 * and return without waiting upon it */
 #define FOLL_NOFAULT	0x80	/* do not fault in pages */
 #define FOLL_HWPOISON	0x100	/* check page is hwpoisoned */
-#define FOLL_TRIED	0x800	/* a retry, previous pass started an IO */
-#define FOLL_REMOTE	0x2000	/* we are working on non-current tsk/mm */
-#define FOLL_ANON	0x8000	/* don't do file mappings */
-#define FOLL_LONGTERM	0x10000	/* mapping lifetime is indefinite: see below */
-#define FOLL_SPLIT_PMD	0x20000	/* split huge pmd before returning */
-#define FOLL_PIN	0x40000	/* pages must be released via unpin_user_page */
-#define FOLL_FAST_ONLY	0x80000	/* gup_fast: prevent fall-back to slow gup */
-#define FOLL_PCI_P2PDMA	0x100000 /* allow returning PCI P2PDMA pages */
-#define FOLL_INTERRUPTIBLE  0x200000 /* allow interrupts from generic signals */
+#define FOLL_TRIED	0x200	/* a retry, previous pass started an IO */
+#define FOLL_REMOTE	0x400	/* we are working on non-current tsk/mm */
+#define FOLL_ANON	0x800	/* don't do file mappings */
+#define FOLL_LONGTERM	0x1000	/* mapping lifetime is indefinite: see below */
+#define FOLL_SPLIT_PMD	0x2000	/* split huge pmd before returning */
+#define FOLL_FAST_ONLY	0x4000	/* gup_fast: prevent fall-back to slow gup */
+#define FOLL_PCI_P2PDMA	0x8000 /* allow returning PCI P2PDMA pages */
+#define FOLL_INTERRUPTIBLE  0x10000 /* allow interrupts from generic signals */
 
 /*
+ * Note that FOLL_PIN is sorted to bit 0 to be coincident with BIO_PAGE_PINNED.
+ *
  * FOLL_PIN and FOLL_LONGTERM may be used in various combinations with each
  * other. Here is what they mean, and how to use them:
  *

