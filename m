Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5124A675C4A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 18:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjATR6i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 12:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjATR6Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:58:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FFD58967
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 09:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674237387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MdinPY6vQ8fVw027uUZU584MsmM5YD/+rGjhklLF+d8=;
        b=cFO/QjjTbCLg0xDh6iXEiLW4oUTkbM58OgkI2fVY9QDq9K1Zjcm+L5Ds+99sNPnQI9Wjvq
        7DvKgvfHnnRE9Y7SA5UPvTmAxtzNPyelmxEQqo/O7I3HbUL0aDDuI7wQSj1fr+9WwxYHZE
        sGW+Bc6mu1NASZ/5NL8XLtM9hF2YPFE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-442-XWXguqUFNAG-6TTKujd0rA-1; Fri, 20 Jan 2023 12:56:20 -0500
X-MC-Unique: XWXguqUFNAG-6TTKujd0rA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D11A101A521;
        Fri, 20 Jan 2023 17:56:19 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E593A492C3C;
        Fri, 20 Jan 2023 17:56:17 +0000 (UTC)
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
Subject: [PATCH v7 8/8] mm: Renumber FOLL_GET and FOLL_PIN down
Date:   Fri, 20 Jan 2023 17:55:56 +0000
Message-Id: <20230120175556.3556978-9-dhowells@redhat.com>
In-Reply-To: <20230120175556.3556978-1-dhowells@redhat.com>
References: <20230120175556.3556978-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Renumber FOLL_GET and FOLL_PIN down to bit 0 and 1 respectively so that
they are coincidentally the same as BIO_PAGE_REFFED and BIO_PAGE_PINNED and
also so that they can be stored in the bottom two bits of a page pointer
(something I'm looking at for zerocopy socket fragments).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Christoph Hellwig <hch@lst.de>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 include/linux/mm.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f1cf8f4eb946..33c9eacd9548 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3074,12 +3074,13 @@ static inline vm_fault_t vmf_error(int err)
 struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 			 unsigned int foll_flags);
 
-#define FOLL_WRITE	0x01	/* check pte is writable */
-#define FOLL_TOUCH	0x02	/* mark page accessed */
-#define FOLL_GET	0x04	/* do get_page on page */
-#define FOLL_DUMP	0x08	/* give error on hole if it would be zero */
-#define FOLL_FORCE	0x10	/* get_user_pages read/write w/o permission */
-#define FOLL_NOWAIT	0x20	/* if a disk transfer is needed, start the IO
+#define FOLL_GET	0x01	/* do get_page on page (equivalent to BIO_FOLL_GET) */
+#define FOLL_PIN	0x02	/* pages must be released via unpin_user_page */
+#define FOLL_WRITE	0x04	/* check pte is writable */
+#define FOLL_TOUCH	0x08	/* mark page accessed */
+#define FOLL_DUMP	0x10	/* give error on hole if it would be zero */
+#define FOLL_FORCE	0x20	/* get_user_pages read/write w/o permission */
+#define FOLL_NOWAIT	0x40	/* if a disk transfer is needed, start the IO
 				 * and return without waiting upon it */
 #define FOLL_NOFAULT	0x80	/* do not fault in pages */
 #define FOLL_HWPOISON	0x100	/* check page is hwpoisoned */
@@ -3088,7 +3089,6 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 #define FOLL_ANON	0x8000	/* don't do file mappings */
 #define FOLL_LONGTERM	0x10000	/* mapping lifetime is indefinite: see below */
 #define FOLL_SPLIT_PMD	0x20000	/* split huge pmd before returning */
-#define FOLL_PIN	0x40000	/* pages must be released via unpin_user_page */
 #define FOLL_FAST_ONLY	0x80000	/* gup_fast: prevent fall-back to slow gup */
 #define FOLL_PCI_P2PDMA	0x100000 /* allow returning PCI P2PDMA pages */
 #define FOLL_INTERRUPTIBLE  0x200000 /* allow interrupts from generic signals */

