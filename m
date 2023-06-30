Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00BB743EC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 17:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjF3P1a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 11:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbjF3P1G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:27:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3103C26
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 08:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688138750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A03JyOO/f7iAqHJBZB+sdm2rxbR0PVujtNmj3kIoBeA=;
        b=a4IMUGcQDaTPJ9zOPGoHuHcmSl+zGP35moMmgkD3Ghd5F9eroZHIWJdnYNcAuREU57dlat
        Mseci6OZ1CPEx1PYF9misU/GB+OIb4gUN6AJooXN640nJGjiBT2MFzA/TyISn3UAiwp/cg
        YKQDZ2kDxaV1/hCVmcsd/n3MXLfcrfE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-601-N6FLg4pXOKyVIzUdiDErog-1; Fri, 30 Jun 2023 11:25:47 -0400
X-MC-Unique: N6FLg4pXOKyVIzUdiDErog-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2467A185A793;
        Fri, 30 Jun 2023 15:25:45 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 187E348FB01;
        Fri, 30 Jun 2023 15:25:43 +0000 (UTC)
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
Subject: [RFC PATCH 06/11] iov_iter: Use op_is_write() rather than iterator direction
Date:   Fri, 30 Jun 2023 16:25:19 +0100
Message-ID: <20230630152524.661208-7-dhowells@redhat.com>
In-Reply-To: <20230630152524.661208-1-dhowells@redhat.com>
References: <20230630152524.661208-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a request struct is available, use op_is_write() instead of the iterator
direction.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christian Brauner <christian@brauner.io>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 block/blk-map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 44d74a30ddac..f8fe114ae433 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -205,7 +205,7 @@ static int bio_copy_user_iov(struct request *rq, struct rq_map_data *map_data,
 	/*
 	 * success
 	 */
-	if ((iov_iter_rw(iter) == WRITE &&
+	if ((op_is_write(rq->cmd_flags) &&
 	     (!map_data || !map_data->null_mapped)) ||
 	    (map_data && map_data->from_user)) {
 		ret = bio_copy_from_iter(bio, iter);

