Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11B4694754
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Feb 2023 14:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjBMNrN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Feb 2023 08:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjBMNrM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Feb 2023 08:47:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94391ABE0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Feb 2023 05:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676295990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cowZ1cmLrnZZxcephacOQa4mjhuuVERSSt8ZL/UsOKw=;
        b=S6F2RlqwijWmPBRCOlEi5RpxQ5s2wJQbrk0yQIyzo3dds0ELLdtmUqdhQpuaEnIKe+9t3N
        3GdyW180eyKJPZ23Z8LvT6TGXFkvrXv67qVaUGt+JvPFXL/z5BRIcqdWSo1jT90KAs1n+p
        2tr5vU1KmowvmX7CWb23jeP2uf5x+Lw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-167-u6s-Mzk-MTWOuQY7_HuoaQ-1; Mon, 13 Feb 2023 08:46:27 -0500
X-MC-Unique: u6s-Mzk-MTWOuQY7_HuoaQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF5EE971086;
        Mon, 13 Feb 2023 13:46:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0AE40492C3C;
        Mon, 13 Feb 2023 13:46:23 +0000 (UTC)
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
Subject: [PATCH 1/4] splice: Rename new splice functions
Date:   Mon, 13 Feb 2023 13:46:16 +0000
Message-Id: <20230213134619.2198965-2-dhowells@redhat.com>
In-Reply-To: <20230213134619.2198965-1-dhowells@redhat.com>
References: <20230213134619.2198965-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename generic_file_buffered_splice_read() to filemap_splice_read().

Rename generic_file_direct_splice_read() to direct_splice_read().

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
 fs/splice.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 2717078949a2..91b9e2cb9e03 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -287,9 +287,9 @@ void splice_shrink_spd(struct splice_pipe_desc *spd)
  * Splice data from an O_DIRECT file into pages and then add them to the output
  * pipe.
  */
-static ssize_t generic_file_direct_splice_read(struct file *in, loff_t *ppos,
-					       struct pipe_inode_info *pipe,
-					       size_t len, unsigned int flags)
+static ssize_t direct_splice_read(struct file *in, loff_t *ppos,
+				  struct pipe_inode_info *pipe,
+				  size_t len, unsigned int flags)
 {
 	struct iov_iter to;
 	struct bio_vec *bv;
@@ -417,10 +417,9 @@ static size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
  * Splice folios from the pagecache of a buffered (ie. non-O_DIRECT) file into
  * a pipe.
  */
-static ssize_t generic_file_buffered_splice_read(struct file *in, loff_t *ppos,
-						 struct pipe_inode_info *pipe,
-						 size_t len,
-						 unsigned int flags)
+static ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
+				   struct pipe_inode_info *pipe,
+				   size_t len, unsigned int flags)
 {
 	struct folio_batch fbatch;
 	size_t total_spliced = 0, used, npages;
@@ -529,8 +528,8 @@ ssize_t generic_file_splice_read(struct file *in, loff_t *ppos,
 	if (unlikely(!len))
 		return 0;
 	if (in->f_flags & O_DIRECT)
-		return generic_file_direct_splice_read(in, ppos, pipe, len, flags);
-	return generic_file_buffered_splice_read(in, ppos, pipe, len, flags);
+		return direct_splice_read(in, ppos, pipe, len, flags);
+	return filemap_splice_read(in, ppos, pipe, len, flags);
 }
 EXPORT_SYMBOL(generic_file_splice_read);
 

