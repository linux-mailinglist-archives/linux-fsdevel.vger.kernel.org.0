Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A06B69475D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Feb 2023 14:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjBMNsA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Feb 2023 08:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjBMNr7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Feb 2023 08:47:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F051ADEE
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Feb 2023 05:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676295994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nvl8+FROX68UViRruMCdGgXgWsaTBkOPXdZwOet0pQY=;
        b=L+o8T/XrdL8Y6AyhD6oWqZac3/e8NJ+E2UwtsEJLwxy7Tj7nz6RAssMBwF/duwTlE71BEv
        N5LfpO6bXinxFKjgEE8K0Wnxh8jLrHPgY6oEj6oc5/rZyVrntOUCeT7DAHqF3rt9aGfOVa
        WId+u320pv18Ts7sbSjGBqi5ev06cEE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-Qzx4kRCYOYyoMJ2DNcD_ow-1; Mon, 13 Feb 2023 08:46:29 -0500
X-MC-Unique: Qzx4kRCYOYyoMJ2DNcD_ow-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0EAF857AA4;
        Mon, 13 Feb 2023 13:46:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A5926C16022;
        Mon, 13 Feb 2023 13:46:26 +0000 (UTC)
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
Subject: [PATCH 2/4] splice: Provide pipe_head_buf() helper
Date:   Mon, 13 Feb 2023 13:46:17 +0000
Message-Id: <20230213134619.2198965-3-dhowells@redhat.com>
In-Reply-To: <20230213134619.2198965-1-dhowells@redhat.com>
References: <20230213134619.2198965-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a helper, pipe_head_buf(), to get the current head buffer from a
pipe.  Implement this as a wrapper around a more general function,
pipe_buf(), that gets a specified buffer.

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
 fs/splice.c               |  9 +++------
 include/linux/pipe_fs_i.h | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 91b9e2cb9e03..7c0ff187f87a 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -295,7 +295,6 @@ static ssize_t direct_splice_read(struct file *in, loff_t *ppos,
 	struct bio_vec *bv;
 	struct kiocb kiocb;
 	struct page **pages;
-	unsigned int head;
 	ssize_t ret;
 	size_t used, npages, chunk, remain, reclaim;
 	int i;
@@ -358,9 +357,8 @@ static ssize_t direct_splice_read(struct file *in, loff_t *ppos,
 	}
 
 	/* Push the remaining pages into the pipe. */
-	head = pipe->head;
 	for (i = 0; i < npages; i++) {
-		struct pipe_buffer *buf = &pipe->bufs[head & (pipe->ring_size - 1)];
+		struct pipe_buffer *buf = pipe_head_buf(pipe);
 
 		chunk = min_t(size_t, remain, PAGE_SIZE);
 		*buf = (struct pipe_buffer) {
@@ -369,10 +367,9 @@ static ssize_t direct_splice_read(struct file *in, loff_t *ppos,
 			.offset	= 0,
 			.len	= chunk,
 		};
-		head++;
+		pipe->head++;
 		remain -= chunk;
 	}
-	pipe->head = head;
 
 	kfree(bv);
 	return ret;
@@ -394,7 +391,7 @@ static size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
 
 	while (spliced < size &&
 	       !pipe_full(pipe->head, pipe->tail, pipe->max_usage)) {
-		struct pipe_buffer *buf = &pipe->bufs[pipe->head & (pipe->ring_size - 1)];
+		struct pipe_buffer *buf = pipe_head_buf(pipe);
 		size_t part = min_t(size_t, PAGE_SIZE - offset, size - spliced);
 
 		*buf = (struct pipe_buffer) {
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 6cb65df3e3ba..d2c3f16cf6b1 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -156,6 +156,26 @@ static inline bool pipe_full(unsigned int head, unsigned int tail,
 	return pipe_occupancy(head, tail) >= limit;
 }
 
+/**
+ * pipe_buf - Return the pipe buffer for the specified slot in the pipe ring
+ * @pipe: The pipe to access
+ * @slot: The slot of interest
+ */
+static inline struct pipe_buffer *pipe_buf(const struct pipe_inode_info *pipe,
+					   unsigned int slot)
+{
+	return &pipe->bufs[slot & (pipe->ring_size - 1)];
+}
+
+/**
+ * pipe_head_buf - Return the pipe buffer at the head of the pipe ring
+ * @pipe: The pipe to access
+ */
+static inline struct pipe_buffer *pipe_head_buf(const struct pipe_inode_info *pipe)
+{
+	return pipe_buf(pipe, pipe->head);
+}
+
 /**
  * pipe_buf_get - get a reference to a pipe_buffer
  * @pipe:	the pipe that the buffer belongs to

