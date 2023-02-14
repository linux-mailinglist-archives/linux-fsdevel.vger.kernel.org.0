Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062B3695D16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 09:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjBNIiy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 03:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjBNIiv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:38:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37C2E07E
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 00:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676363852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xJXt4KNNFIdMvSSPmBpCRCAi8g0JFMLHorMyvAgfics=;
        b=gIAH3LiNKLVWbWoHrDW/yTd2ncPan6UF/YqqXlD6xnh+d+Z4sCZ3ZUHOgr+dCwRdi6dRKI
        clXPvg+2orcE9vI9x11UiC2mWfMkZvlEjJQkht7QRpi1/HfWuDOV/uSIaZJXEGRRotlIBZ
        DBHV0U1xqjr8PvoyjZwGm3AA59g/dW4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-4m-qRrFTP7OlNbKg3ZIAJA-1; Tue, 14 Feb 2023 03:37:28 -0500
X-MC-Unique: 4m-qRrFTP7OlNbKg3ZIAJA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14FC72999B22;
        Tue, 14 Feb 2023 08:37:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2717F140EBF6;
        Tue, 14 Feb 2023 08:37:26 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 3/5] splice: Use init_sync_kiocb() in filemap_splice_read()
Date:   Tue, 14 Feb 2023 08:37:08 +0000
Message-Id: <20230214083710.2547248-4-dhowells@redhat.com>
In-Reply-To: <20230214083710.2547248-1-dhowells@redhat.com>
References: <20230214083710.2547248-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use init_sync_kiocb() in filemap_splice_read() rather than open coding it.

Requested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: John Hubbard <jhubbard@nvidia.com>
cc: David Hildenbrand <david@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---

Notes:
    ver #2)
     - Don't attempt to filter IOCB_* flags.

 fs/splice.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 7c0ff187f87a..4ea63d6a9040 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -419,15 +419,14 @@ static ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
 				   size_t len, unsigned int flags)
 {
 	struct folio_batch fbatch;
+	struct kiocb iocb;
 	size_t total_spliced = 0, used, npages;
 	loff_t isize, end_offset;
 	bool writably_mapped;
 	int i, error = 0;
 
-	struct kiocb iocb = {
-		.ki_filp	= in,
-		.ki_pos		= *ppos,
-	};
+	init_sync_kiocb(&iocb, in);
+	iocb.ki_pos = *ppos;
 
 	/* Work out how much data we can actually add into the pipe */
 	used = pipe_occupancy(pipe->head, pipe->tail);

