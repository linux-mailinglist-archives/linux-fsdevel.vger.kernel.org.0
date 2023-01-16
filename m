Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C6266D2B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 00:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbjAPXLl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 18:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbjAPXKo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 18:10:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A675E2C658
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 15:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673910560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Girl2YBNSmk/RhHD3I8qnvIF9Ng617btd8CJd+5Emo0=;
        b=PoyXEQKfnReg4u9fINve9KW3EUhfZZvf+kH4cfcFUpr+Pe9ODlKzNPU9Qs5nZ3DFKGKg9/
        /n2pCvt2w0gMa/wx+IIEZOUwxir5jD6Yp0QEWqLstbvTZk7lSEk2qZgTB266kJdEvc6MGy
        5QJ1L/M8IPJzL96aSzTdszKVSfwCqFU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-355-QG4fZcgpOoC_YVw6MQevGA-1; Mon, 16 Jan 2023 18:09:16 -0500
X-MC-Unique: QG4fZcgpOoC_YVw6MQevGA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 533ED1C0518D;
        Mon, 16 Jan 2023 23:09:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E91BE492B11;
        Mon, 16 Jan 2023 23:09:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v6 10/34] mm,
 block: Make BIO_PAGE_REFFED/PINNED the same as FOLL_GET/PIN numerically
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, dhowells@redhat.com,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 16 Jan 2023 23:09:13 +0000
Message-ID: <167391055339.2311931.11902422289425837725.stgit@warthog.procyon.org.uk>
In-Reply-To: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

Make BIO_PAGE_REFFED the same as FOLL_GET and BIO_PAGE_PINNED the same as
FOLL_PIN numerically so that the BIO_* flags can be passed directly to
page_put_unpin().

Provide a build-time assertion to check this.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Jan Kara <jack@suse.cz>
cc: Christoph Hellwig <hch@lst.de>
cc: Matthew Wilcox <willy@infradead.org>
cc: Logan Gunthorpe <logang@deltatee.com>
cc: linux-block@vger.kernel.org
---

 block/bio.c               |    3 +++
 include/linux/blk_types.h |    1 +
 include/linux/mm.h        |   17 ++++++++++-------
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 5b6a76c3e620..d8c636cefcdd 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1798,6 +1798,9 @@ static int __init init_bio(void)
 {
 	int i;
 
+	BUILD_BUG_ON((1 << BIO_PAGE_REFFED) != FOLL_GET);
+	BUILD_BUG_ON((1 << BIO_PAGE_PINNED) != FOLL_PIN);
+
 	bio_integrity_init();
 
 	for (i = 0; i < ARRAY_SIZE(bvec_slabs); i++) {
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 86711fb0534a..42b40156c517 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -319,6 +319,7 @@ struct bio {
  */
 enum {
 	BIO_PAGE_REFFED,	/* Pages need refs putting (equivalent to FOLL_GET) */
+	BIO_PAGE_PINNED,	/* Pages need unpinning (equivalent to FOLL_PIN) */
 	BIO_CLONED,		/* doesn't own data */
 	BIO_BOUNCED,		/* bio is a bounce bio */
 	BIO_QUIET,		/* Make BIO Quiet */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8e746a930945..f14edb192394 100644
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
@@ -3098,6 +3098,9 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 #define FOLL_BUF_MASK	FOLL_WRITE
 
 /*
+ * FOLL_GET must be the same bit as BIO_FOLL_GET and FOLL_PIN must be the same
+ * bit as BIO_FOLL_PIN.
+ *
  * FOLL_PIN and FOLL_LONGTERM may be used in various combinations with each
  * other. Here is what they mean, and how to use them:
  *


