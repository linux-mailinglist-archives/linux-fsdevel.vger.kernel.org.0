Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE10B64BD8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 20:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236025AbiLMTtf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 14:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236512AbiLMTt2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 14:49:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1DE18B21
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 11:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670960920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+8pZurhuZVgsVplxwZPRPpmvoNKXXd5kuVycITJEXSU=;
        b=RYjPGsSmja6DSRnEFhL2CnuFFKyzPg+eB1QrfTWl0UQnRPeBLWk8m/7gJVgQG4uQVvqwTo
        HdIY7P7EbXjToULMlPa1V0/qXcpheU2NtX3+EdMfJbMCS/KHn0qWUSjdIWq5WCqzYgMdHE
        Sk25JCGwctUHZHWnl/b4Xf2lIvhgIdg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-1F0AJb-PMwi4_TGn2VvH0A-1; Tue, 13 Dec 2022 14:48:35 -0500
X-MC-Unique: 1F0AJb-PMwi4_TGn2VvH0A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 72475185A794;
        Tue, 13 Dec 2022 19:48:35 +0000 (UTC)
Received: from pasta.redhat.com (ovpn-192-138.brq.redhat.com [10.40.192.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1193D1121315;
        Tue, 13 Dec 2022 19:48:33 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     "Darrick J . Wong" <djwong@kernel.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] iomap: Move page_done callback under the folio lock
Date:   Tue, 13 Dec 2022 20:48:33 +0100
Message-Id: <20221213194833.1636649-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Darrick,

I'd like to get the following iomap change into this merge window.  This
only affects gfs2, so I can push it as part of the gfs2 updates if you
don't mind, provided that I'll get your Reviewed-by confirmation.
Otherwise, if you'd prefer to pass this through the xfs tree, could you
please take it?

Thanks,
Andreas

--

Move the ->page_done() call in iomap_write_end() under the folio lock.
This closes a race between journaled data writes and the shrinker in
gfs2.  What's happening is that gfs2_iomap_page_done() is called after
the page has been unlocked, so try_to_free_buffers() can come in and
free the buffers while gfs2_iomap_page_done() is trying to add them to
the current transaction.  The folio lock prevents that from happening.

The only user of ->page_done() is gfs2, so other filesystems are not
affected.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/iomap/buffered-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 91ee0b308e13..476c9ed1b333 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -714,12 +714,12 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
 		i_size_write(iter->inode, pos + ret);
 		iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
 	}
+	if (page_ops && page_ops->page_done)
+		page_ops->page_done(iter->inode, pos, ret, &folio->page);
 	folio_unlock(folio);
 
 	if (old_size < pos)
 		pagecache_isize_extended(iter->inode, old_size, pos);
-	if (page_ops && page_ops->page_done)
-		page_ops->page_done(iter->inode, pos, ret, &folio->page);
 	folio_put(folio);
 
 	if (ret < len)
-- 
2.38.1

