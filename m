Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB0A743EC8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 17:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjF3P12 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 11:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjF3P1G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:27:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556973C21
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 08:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688138747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BxhEpe1dWPNZ3l1c5/r0hZMnotB6Lyrh5knFFcDG1mA=;
        b=P2P1Y6092RoqbhLpuutfMCFXirkSUqYx+gRo4PM2eHTtWwfc4fyTF4GKMqoTHCRQrk2qDb
        zZqk7rXPnd/9+Jb9l0d2Szi2i5sB+0xnqlgjj30DOmGDUtVPEQYidbiaty0LvCsTPxLTCw
        yRD3zD9OH/g2gYzWNTI+Tbzf0nr5Zpw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-225-mxE03HUqMrK2T8QUGz-gSw-1; Fri, 30 Jun 2023 11:25:43 -0400
X-MC-Unique: mxE03HUqMrK2T8QUGz-gSw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 65555858290;
        Fri, 30 Jun 2023 15:25:42 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 703104087C6A;
        Fri, 30 Jun 2023 15:25:40 +0000 (UTC)
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
Subject: [RFC PATCH 05/11] iov_iter: Use IOMAP_WRITE rather than iterator direction
Date:   Fri, 30 Jun 2023 16:25:18 +0100
Message-ID: <20230630152524.661208-6-dhowells@redhat.com>
In-Reply-To: <20230630152524.661208-1-dhowells@redhat.com>
References: <20230630152524.661208-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If an iomap_iter is available, use the IOMAP_WRITE flag instead of the
iterator direction.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christian Brauner <christian@brauner.io>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/dax.c             | 4 ++--
 fs/iomap/direct-io.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 5c6ebe64a3fd..d49480675fc0 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1438,7 +1438,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 	loff_t pos = iomi->pos;
 	struct dax_device *dax_dev = iomap->dax_dev;
 	loff_t end = pos + length, done = 0;
-	bool write = iov_iter_rw(iter) == WRITE;
+	bool write = iomi->flags & IOMAP_WRITE;
 	bool cow = write && iomap->flags & IOMAP_F_SHARED;
 	ssize_t ret = 0;
 	size_t xfer;
@@ -1498,7 +1498,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 
 		map_len = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size),
 				DAX_ACCESS, &kaddr, NULL);
-		if (map_len == -EIO && iov_iter_rw(iter) == WRITE) {
+		if (map_len == -EIO && write) {
 			map_len = dax_direct_access(dax_dev, pgoff,
 					PHYS_PFN(size), DAX_RECOVERY_WRITE,
 					&kaddr, NULL);
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index a56099470185..3095091af680 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -587,7 +587,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	 * Revert iter to a state corresponding to that as some callers (such
 	 * as the splice code) rely on it.
 	 */
-	if (iov_iter_rw(iter) == READ && iomi.pos >= dio->i_size)
+	if (!(iomi.flags & IOMAP_WRITE) && iomi.pos >= dio->i_size)
 		iov_iter_revert(iter, iomi.pos - dio->i_size);
 
 	if (ret == -EFAULT && dio->size && (dio_flags & IOMAP_DIO_PARTIAL)) {

