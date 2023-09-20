Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DCA7A8F49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 00:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjITWYV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 18:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjITWYU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 18:24:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7188EEB
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 15:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695248569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j/K7bby96tUMA/iC07lWusXqTlhgR9zlJgJ7++h0ZQI=;
        b=HNrA5sgovKS1kYk9UfNGmHYAz7nChnCdT3FWFbWnqhOo/pxr1GRLqWhh/q1UGwBSm1l+po
        b2e7Y60WaW+CiO2YOV+jBy3KOTOdfguBAr4obWQoXgf1wuex3P8UO3XfikR8+HGv/yOnNJ
        ztpeaMoCxMyUeAOgAanux1iwaxp0aJU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-qSI8WUj0N3Orf3pb4D2D6g-1; Wed, 20 Sep 2023 18:22:45 -0400
X-MC-Unique: qSI8WUj0N3Orf3pb4D2D6g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58FB9185A797;
        Wed, 20 Sep 2023 22:22:44 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB58E492C37;
        Wed, 20 Sep 2023 22:22:40 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@ACULAB.COM>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH v5 02/11] infiniband: Use user_backed_iter() to see if iterator is UBUF/IOVEC
Date:   Wed, 20 Sep 2023 23:22:22 +0100
Message-ID: <20230920222231.686275-3-dhowells@redhat.com>
In-Reply-To: <20230920222231.686275-1-dhowells@redhat.com>
References: <20230920222231.686275-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use user_backed_iter() to see if iterator is UBUF/IOVEC rather than poking
inside the iterator.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
cc: Jason Gunthorpe <jgg@ziepe.ca>
cc: Leon Romanovsky <leon@kernel.org>
cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/hw/hfi1/file_ops.c    | 2 +-
 drivers/infiniband/hw/qib/qib_file_ops.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index a5ab22cedd41..788fc249234f 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -267,7 +267,7 @@ static ssize_t hfi1_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 
 	if (!HFI1_CAP_IS_KSET(SDMA))
 		return -EINVAL;
-	if (!from->user_backed)
+	if (!user_backed_iter(from))
 		return -EINVAL;
 	idx = srcu_read_lock(&fd->pq_srcu);
 	pq = srcu_dereference(fd->pq, &fd->pq_srcu);
diff --git a/drivers/infiniband/hw/qib/qib_file_ops.c b/drivers/infiniband/hw/qib/qib_file_ops.c
index 152952127f13..29e4c59aa23b 100644
--- a/drivers/infiniband/hw/qib/qib_file_ops.c
+++ b/drivers/infiniband/hw/qib/qib_file_ops.c
@@ -2244,7 +2244,7 @@ static ssize_t qib_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct qib_ctxtdata *rcd = ctxt_fp(iocb->ki_filp);
 	struct qib_user_sdma_queue *pq = fp->pq;
 
-	if (!from->user_backed || !from->nr_segs || !pq)
+	if (!user_backed_iter(from) || !from->nr_segs || !pq)
 		return -EINVAL;
 
 	return qib_user_sdma_writev(rcd, pq, iter_iov(from), from->nr_segs);

