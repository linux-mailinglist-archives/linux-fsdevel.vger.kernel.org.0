Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15E2743EDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 17:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjF3P2j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 11:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjF3P1O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:27:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184343C3F
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 08:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688138757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Jdd9WWzw52HFg7DtTsZeyIq/lnUM49zKvJ/hNK831U=;
        b=GTNl1IbsROO7WHFvSOAEVrmR1vd2K33WiV9TNpZ9KC8VDHDzjFkTpw2ckGfGBMQkmblPPt
        HpzpIFdAdkVo5+lJlzym7KOnuWBxAoQLnF/7JtnhuEyFHL3aZl2PxXrM28YPcgq6kVbsPF
        CqiQCO+gkLMh2EGxAYA0Firn94xAkUQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-JWUOtE-7PZaOWCY4vn-G4w-1; Fri, 30 Jun 2023 11:25:52 -0400
X-MC-Unique: JWUOtE-7PZaOWCY4vn-G4w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06884800B35;
        Fri, 30 Jun 2023 15:25:52 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4B2F2166B2D;
        Fri, 30 Jun 2023 15:25:49 +0000 (UTC)
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
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>
Subject: [RFC PATCH 08/11] iov_iter: Drop iov_iter_rw() and fold in last user
Date:   Fri, 30 Jun 2023 16:25:21 +0100
Message-ID: <20230630152524.661208-9-dhowells@redhat.com>
In-Reply-To: <20230630152524.661208-1-dhowells@redhat.com>
References: <20230630152524.661208-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Drop the last usage of iov_iter_rw() into __iov_iter_get_pages_alloc().

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christian Brauner <christian@brauner.io>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 include/linux/uio.h | 5 -----
 lib/iov_iter.c      | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index ff81e5ccaef2..70e12f536f8f 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -136,11 +136,6 @@ static inline bool iov_iter_is_xarray(const struct iov_iter *i)
 	return iov_iter_type(i) == ITER_XARRAY;
 }
 
-static inline unsigned char iov_iter_rw(const struct iov_iter *i)
-{
-	return i->data_source ? WRITE : READ;
-}
-
 static inline bool user_backed_iter(const struct iov_iter *i)
 {
 	return i->user_backed;
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index b667b1e2f688..b8c52231a6ff 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1097,7 +1097,7 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		unsigned long addr;
 		int res;
 
-		if (iov_iter_rw(i) != WRITE)
+		if (i->data_source == ITER_SOURCE)
 			gup_flags |= FOLL_WRITE;
 		if (i->nofault)
 			gup_flags |= FOLL_NOFAULT;

