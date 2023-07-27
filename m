Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3042B76585C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 18:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjG0QLR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 12:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbjG0QLQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:11:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3DE2D4F
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 09:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690474229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TLR8tINgbBniZykrMZZb+ehfHyamxexwgaHRKDrxZjA=;
        b=WrgIRkUlhEgIcVfBBnruNTC1Z4mDv7HC5bKYmPbQszKce7sh3MhMrrTuzNb0xwb7bPYUe+
        HG4qDfuKmZ8etQJEaMu3JsJXFnaU642t8HXUk8gXEOXXlEc4CS1YRFfOijjpVgqEcEQOaj
        +ArkA/Y2+8JnNvCllvV31CfSljChDQo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-vm9257bXN52QLdEzJBO93A-1; Thu, 27 Jul 2023 12:10:26 -0400
X-MC-Unique: vm9257bXN52QLdEzJBO93A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9DF87858EED;
        Thu, 27 Jul 2023 16:10:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1000740D2839;
        Thu, 27 Jul 2023 16:10:23 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 2/2] shmem: Apply a couple of filemap_splice_read() fixes to shmem_splice_read()
Date:   Thu, 27 Jul 2023 17:10:16 +0100
Message-ID: <20230727161016.169066-3-dhowells@redhat.com>
In-Reply-To: <20230727161016.169066-1-dhowells@redhat.com>
References: <20230727161016.169066-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix shmem_splice_read() to use the inode from in->f_mapping->host rather
than file_inode(in) and to skip the splice if it starts after s_maxbytes,
analogously with fixes to filemap_splice_read().

Fixes: bd194b187115 ("shmem: Implement splice-read")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Hugh Dickins <hughd@google.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: John Hubbard <jhubbard@nvidia.com>
cc: David Hildenbrand <david@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Chuck Lever <chuck.lever@oracle.com>
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 mm/shmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 0164cccdcd71..8a16d4c7092b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2780,13 +2780,16 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
 				      struct pipe_inode_info *pipe,
 				      size_t len, unsigned int flags)
 {
-	struct inode *inode = file_inode(in);
+	struct inode *inode = in->f_mapping->host;
 	struct address_space *mapping = inode->i_mapping;
 	struct folio *folio = NULL;
 	size_t total_spliced = 0, used, npages, n, part;
 	loff_t isize;
 	int error = 0;
 
+	if (unlikely(*ppos >= inode->i_sb->s_maxbytes))
+		return 0;
+
 	/* Work out how much data we can actually add into the pipe */
 	used = pipe_occupancy(pipe->head, pipe->tail);
 	npages = max_t(ssize_t, pipe->max_usage - used, 0);

