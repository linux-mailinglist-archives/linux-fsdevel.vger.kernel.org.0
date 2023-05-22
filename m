Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1DC70C024
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 15:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbjEVNwM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 09:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbjEVNwE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 09:52:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB77185
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 06:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684763444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+QycUCk1EhV64OEFYi0Ywr/xSgjmAM7Sud1UY4yTKxE=;
        b=imOvbhZWXZrn071ozagm2BrQJTTDT6Zqr/slp800YmZB9SOw7b+zYkK0qVFrDP7sMJkaoX
        vDFvSd2mMQLTN3xERc7Kj18UxvDtYsIFGlwZmOXIYktSroHqkf/Hr3peYqNzODNqmCEYik
        I/Fz3HUmuzG906tQ2NIxZb5tlXOhcMI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-5SDxrfwzNriOr4rM0S6JVg-1; Mon, 22 May 2023 09:50:41 -0400
X-MC-Unique: 5SDxrfwzNriOr4rM0S6JVg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8CC9185A78E;
        Mon, 22 May 2023 13:50:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A3B22166B25;
        Mon, 22 May 2023 13:50:38 +0000 (UTC)
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
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v22 04/31] splice: Clean up copy_splice_read() a bit
Date:   Mon, 22 May 2023 14:49:51 +0100
Message-Id: <20230522135018.2742245-5-dhowells@redhat.com>
In-Reply-To: <20230522135018.2742245-1-dhowells@redhat.com>
References: <20230522135018.2742245-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Do a couple of cleanups to copy_splice_read():

 (1) Cast to struct page **, not void *.

 (2) Simplify the calculation of the number of pages to keep/reclaim in
     copy_splice_read().

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: David Hildenbrand <david@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: linux-mm@kvack.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---

Notes:
    ver #21)
     - direct_splice_read() got renamed to copy_splice_read().

 fs/splice.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 2478e065bc53..f9a9be797b0c 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -311,7 +311,7 @@ ssize_t copy_splice_read(struct file *in, loff_t *ppos,
 	struct kiocb kiocb;
 	struct page **pages;
 	ssize_t ret;
-	size_t used, npages, chunk, remain, reclaim;
+	size_t used, npages, chunk, remain, keep = 0;
 	int i;
 
 	/* Work out how much data we can actually add into the pipe */
@@ -325,7 +325,7 @@ ssize_t copy_splice_read(struct file *in, loff_t *ppos,
 	if (!bv)
 		return -ENOMEM;
 
-	pages = (void *)(bv + npages);
+	pages = (struct page **)(bv + npages);
 	npages = alloc_pages_bulk_array(GFP_USER, npages, pages);
 	if (!npages) {
 		kfree(bv);
@@ -348,11 +348,8 @@ ssize_t copy_splice_read(struct file *in, loff_t *ppos,
 	kiocb.ki_pos = *ppos;
 	ret = call_read_iter(in, &kiocb, &to);
 
-	reclaim = npages * PAGE_SIZE;
-	remain = 0;
 	if (ret > 0) {
-		reclaim -= ret;
-		remain = ret;
+		keep = DIV_ROUND_UP(ret, PAGE_SIZE);
 		*ppos = kiocb.ki_pos;
 		file_accessed(in);
 	} else if (ret < 0) {
@@ -365,14 +362,12 @@ ssize_t copy_splice_read(struct file *in, loff_t *ppos,
 	}
 
 	/* Free any pages that didn't get touched at all. */
-	reclaim /= PAGE_SIZE;
-	if (reclaim) {
-		npages -= reclaim;
-		release_pages(pages + npages, reclaim);
-	}
+	if (keep < npages)
+		release_pages(pages + keep, npages - keep);
 
 	/* Push the remaining pages into the pipe. */
-	for (i = 0; i < npages; i++) {
+	remain = ret;
+	for (i = 0; i < keep; i++) {
 		struct pipe_buffer *buf = pipe_head_buf(pipe);
 
 		chunk = min_t(size_t, remain, PAGE_SIZE);

