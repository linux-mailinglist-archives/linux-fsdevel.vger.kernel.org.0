Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662AB66D2AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 00:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbjAPXKx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 18:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbjAPXJt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 18:09:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E212A160
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 15:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673910542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TCpipUj3nCrwQxMm0ou1SVJZpUKEvQM3FUN+vn5vbFE=;
        b=B2o8sY9WvEcBmbObtyQyh84SjmYqEn9QdEJ6g2gCv40h3cnxSo0a/lau/hMUtTSIVSFzJE
        g3Rgiy2nqEWVTUHCNjYv35wd3tli5arIp/NpPQgDYAvHF3lYUnVNmnOUFTMe95DuTIOiVN
        w8gTOEd0kF2V3yuXvN+Vo4a5cdHqwWE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-i5YEOVHvMj-EMbjcVQNT2w-1; Mon, 16 Jan 2023 18:08:55 -0500
X-MC-Unique: i5YEOVHvMj-EMbjcVQNT2w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 338A4811E6E;
        Mon, 16 Jan 2023 23:08:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 987AA40C6EC4;
        Mon, 16 Jan 2023 23:08:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v6 07/34] iov_iter: Add a function to extract a page list from
 an iterator
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dhowells@redhat.com, Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 16 Jan 2023 23:08:52 +0000
Message-ID: <167391053207.2311931.16398133457201442907.stgit@warthog.procyon.org.uk>
In-Reply-To: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a function, iov_iter_extract_pages(), to extract a list of pages from
an iterator.  The pages may be returned with a reference added or a pin
added or neither, depending on the type of iterator and the direction of
transfer.  The caller should pass FOLL_SOURCE_BUF or FOLL_DEST_BUF as part
of gup_flags to indicate how the iterator contents are to be used.

Add a second function, iov_iter_extract_mode(), to determine how the
cleanup should be done.

There are three cases:

 (1) Transfer *into* an ITER_IOVEC or ITER_UBUF iterator.

     Extracted pages will have pins obtained on them (but not references)
     so that fork() doesn't CoW the pages incorrectly whilst the I/O is in
     progress.

     iov_iter_extract_mode() will return FOLL_PIN for this case.  The
     caller should use something like unpin_user_page() to dispose of the
     page.

 (2) Transfer is *out of* an ITER_IOVEC or ITER_UBUF iterator.

     Extracted pages will have references obtained on them, but not pins.

     iov_iter_extract_mode() will return FOLL_GET.  The caller should use
     something like put_page() for page disposal.

 (3) Any other sort of iterator.

     No refs or pins are obtained on the page, the assumption is made that
     the caller will manage page retention.

     iov_iter_extract_mode() will return 0.  The pages don't need
     additional disposal.

Changes:
========
ver #6)
 - Add back the function to indicate the cleanup mode.
 - Drop the cleanup_mode return arg to iov_iter_extract_pages().
 - Pass FOLL_SOURCE/DEST_BUF in gup_flags.  Check this against the iter
   data_source.

ver #4)
 - Use ITER_SOURCE/DEST instead of WRITE/READ.
 - Allow additional FOLL_* flags, such as FOLL_PCI_P2PDMA to be passed in.

ver #3)
 - Switch to using EXPORT_SYMBOL_GPL to prevent indirect 3rd-party access
   to get/pin_user_pages_fast()[1].

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Christoph Hellwig <hch@lst.de>
cc: John Hubbard <jhubbard@nvidia.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org

Link: https://lore.kernel.org/r/Y3zFzdWnWlEJ8X8/@infradead.org/ [1]
Link: https://lore.kernel.org/r/166722777971.2555743.12953624861046741424.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/166732025748.3186319.8314014902727092626.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/166869689451.3723671.18242195992447653092.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/166920903885.1461876.692029808682876184.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/166997421646.9475.14837976344157464997.stgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/167305163883.1521586.10777155475378874823.stgit@warthog.procyon.org.uk/ # v4
Link: https://lore.kernel.org/r/167344728530.2425628.9613910866466387722.stgit@warthog.procyon.org.uk/ # v5
---

 include/linux/uio.h |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 18b64068cc6d..38607c82e0cc 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -373,4 +373,32 @@ static inline void iov_iter_ubuf(struct iov_iter *i, enum iter_dir direction,
 	};
 }
 
+ssize_t iov_iter_extract_pages(struct iov_iter *i, struct page ***pages,
+			       size_t maxsize, unsigned int maxpages,
+			       unsigned int gup_flags, size_t *offset0);
+
+/**
+ * iov_iter_extract_mode - Indicate how pages from the iterator will be retained
+ * @iter: The iterator
+ * @gup_flags: How the iterator is to be used (FOLL_SOURCE/DEST_BUF)
+ *
+ * Examine the iterator and the gup_flags and indicate by returning FOLL_PIN,
+ * FOLL_GET or 0 as to how, if at all, pages extracted from the iterator will
+ * be retained by the extraction function.
+ *
+ * FOLL_GET indicates that the pages will have a reference taken on them that
+ * the caller must put.  This can be done for DMA/async DIO write from a page.
+ *
+ * FOLL_PIN indicates that the pages will have a pin placed in them that the
+ * caller must unpin.  This is must be done for DMA/async DIO read to a page to
+ * avoid CoW problems in fork.
+ *
+ * 0 indicates that no measures are taken and that it's up to the caller to
+ * retain the pages.
+ */
+#define iov_iter_extract_mode(iter, gup_flags) \
+	(user_backed_iter(iter) ?				\
+	 (gup_flags & FOLL_BUF_MASK) == FOLL_SOURCE_BUF ?	\
+	 FOLL_GET : FOLL_PIN : 0)
+
 #endif


