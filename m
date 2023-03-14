Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8896C6BA1F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 23:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjCNWKC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 18:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjCNWJh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:09:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE0425E24
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 15:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678831721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w0CyxxuCfKyDxUhqZI8uZNDs4yTA+LT97JFfaSxmf5E=;
        b=jGO+JF8t5z7V5YiIZPAp/yx8bj7HjaS0bCOJPrIQiwA2Q2FwsY2Ds9rlNGRlmNbO6otXG/
        5jnitxinVWM0dKqhs4duXcBuO3Lb5G1RiuUPyPZROhJWE9C0nCciT530DbZV/c9FdQ3TRO
        3xir+95PugJTVLWj8NniZoLop79vIYQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-WXoXZ4YbN7yQ7YG_W8vEZA-1; Tue, 14 Mar 2023 18:08:38 -0400
X-MC-Unique: WXoXZ4YbN7yQ7YG_W8vEZA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34E3B85D062;
        Tue, 14 Mar 2023 22:08:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 042542166B26;
        Tue, 14 Mar 2023 22:08:34 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        John Hubbard <jhubbard@nvidia.com>,
        Dave Chinner <dchinner@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v18 10/15] iomap: Don't get an reference on ZERO_PAGE for direct I/O block zeroing
Date:   Tue, 14 Mar 2023 22:07:52 +0000
Message-Id: <20230314220757.3827941-11-dhowells@redhat.com>
In-Reply-To: <20230314220757.3827941-1-dhowells@redhat.com>
References: <20230314220757.3827941-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ZERO_PAGE can't go away, no need to hold an extra reference.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: linux-fsdevel@vger.kernel.org
---
 fs/iomap/direct-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index f771001574d0..850fb9870c2f 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -202,7 +202,7 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 	bio->bi_private = dio;
 	bio->bi_end_io = iomap_dio_bio_end_io;
 
-	get_page(page);
+	bio_set_flag(bio, BIO_NO_PAGE_REF);
 	__bio_add_page(bio, page, len, 0);
 	iomap_dio_submit_bio(iter, dio, bio, pos);
 }

