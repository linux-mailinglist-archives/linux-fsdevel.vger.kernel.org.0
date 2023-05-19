Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD66709090
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 09:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjESHmX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 03:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjESHmM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 03:42:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D82A10F3
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 00:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684482081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sXlwBEApq0PjRnmqqIdGIYb9yjH9GX5fVKdD8XUANt8=;
        b=D1FExhMVD+Rv7j1guKI4G2RIyie9b5ZuDqUkg8muKxqrnorzACqpj50phjFsvZ4vcvMZar
        2ePpLz+zKay7pEvts0iRj2KrXG9iRdYXhwrBAWI8ltYYkCos9urZPk8YUVUEt2UcieuEUL
        i/DU5ttHuNToYK5AC6S4X9A1+jfk2WA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-IyiQq-xAM9m13EaOaEApEQ-1; Fri, 19 May 2023 03:41:10 -0400
X-MC-Unique: IyiQq-xAM9m13EaOaEApEQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E69E5380450F;
        Fri, 19 May 2023 07:41:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1B6F2166B25;
        Fri, 19 May 2023 07:41:07 +0000 (UTC)
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
Subject: [PATCH v20 02/32] splice: Clean up direct_splice_read() a bit
Date:   Fri, 19 May 2023 08:40:17 +0100
Message-Id: <20230519074047.1739879-3-dhowells@redhat.com>
In-Reply-To: <20230519074047.1739879-1-dhowells@redhat.com>
References: <20230519074047.1739879-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Do a couple of cleanups to direct_splice_read():

 (1) Cast to struct page **, not void *.

 (2) Simplify the calculation of the number of pages to keep/reclaim in
     direct_splice_read().

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: David Hildenbrand <david@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: linux-mm@kvack.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/splice.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 3e06611d19ae..4db3eee49423 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -312,7 +312,7 @@ ssize_t direct_splice_read(struct file *in, loff_t *ppos,
 	struct kiocb kiocb;
 	struct page **pages;
 	ssize_t ret;
-	size_t used, npages, chunk, remain, reclaim;
+	size_t used, npages, chunk, remain, keep = 0;
 	int i;
 
 	/* Work out how much data we can actually add into the pipe */
@@ -326,7 +326,7 @@ ssize_t direct_splice_read(struct file *in, loff_t *ppos,
 	if (!bv)
 		return -ENOMEM;
 
-	pages = (void *)(bv + npages);
+	pages = (struct page **)(bv + npages);
 	npages = alloc_pages_bulk_array(GFP_USER, npages, pages);
 	if (!npages) {
 		kfree(bv);
@@ -349,11 +349,8 @@ ssize_t direct_splice_read(struct file *in, loff_t *ppos,
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
@@ -366,14 +363,12 @@ ssize_t direct_splice_read(struct file *in, loff_t *ppos,
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

