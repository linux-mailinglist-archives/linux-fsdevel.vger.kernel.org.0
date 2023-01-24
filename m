Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027D9679CDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 16:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbjAXPE6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 10:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbjAXPEu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:04:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1556591
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 07:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674572641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=olDnusGnpWaMzUG7gjMM8AqNTYakgKlzW4amxlc6h7s=;
        b=bzWsg9iFvaKxEEom7TJToXJRQiYSupQe+dviAnX3hiHgAMyTALk879Kg7QfGbs892SuYbs
        ceU9IQyJth8UI3an9VGaq4+oJzv8hz0Im3FE7wx5l7m17/CAsskQztZAtrrhe5wThyXb5Y
        AMpqDxuT3WH887gIUu8UkivSRrBt8Os=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-NRSYzrXNO4OrjGuor4gWqQ-1; Tue, 24 Jan 2023 10:03:57 -0500
X-MC-Unique: NRSYzrXNO4OrjGuor4gWqQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA9211C189AF;
        Tue, 24 Jan 2023 15:03:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7547140444C3;
        Tue, 24 Jan 2023 15:03:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y8/xApRVtqK7IlYT@infradead.org>
References: <Y8/xApRVtqK7IlYT@infradead.org> <2431ffa0-4a37-56a2-17fa-74a5f681bcb8@redhat.com> <20230123173007.325544-1-dhowells@redhat.com> <20230123173007.325544-8-dhowells@redhat.com> <874829.1674571671@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, David Hildenbrand <david@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v8 07/10] block: Switch to pinning pages.
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <875432.1674572633.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 24 Jan 2023 15:03:53 +0000
Message-ID: <875433.1674572633@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> It can't.  Per your latest branch:

Yes it can.  Patch 6:

--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -282,6 +282,7 @@ static int bio_map_user_iov(struct request *rq, struct=
 iov_iter *iter,
 	if (blk_queue_pci_p2pdma(rq->q))
 		extract_flags |=3D ITER_ALLOW_P2PDMA;
 =

+	bio_set_flag(bio, BIO_PAGE_REFFED);
 	while (iov_iter_count(iter)) {
 		struct page **pages, *stack_pages[UIO_FASTIOV];
 		ssize_t bytes;

Patch 7:

+static inline unsigned int bio_to_gup_flags(struct bio *bio)
+{
+	return (bio_flagged(bio, BIO_PAGE_REFFED) ? FOLL_GET : 0) |
+		(bio_flagged(bio, BIO_PAGE_PINNED) ? FOLL_PIN : 0);
+}
+
+/*
+ * Clean up a page appropriately, where the page may be pinned, may have =
a
+ * ref taken on it or neither.
+ */
+static inline void bio_release_page(struct bio *bio, struct page *page)
+{
+	page_put_unpin(page, bio_to_gup_flags(bio));
+}

At patch 8, you can get either FOLL_GET, FOLL_PIN or 0, depending on the p=
ath
you go through.

David

