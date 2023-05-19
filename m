Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581A9709095
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 09:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjESHmL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 03:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjESHmF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 03:42:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE0E19A
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 00:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684482077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HJSls9joKnzamhDgZoRi/AKfts16br7tyBuA30GIBac=;
        b=QFYDajIts4baAcveTWbNX5MjBC+5bl+sLftufvPkOoCN3vvQJvhGzuJ8SFC43xwUrwSAUP
        Ii83EIhRLxBuwbFoqRRBUtBZA4SFt8MG/r22T+3F9xoBlevmm0zeodyticrH0U8X2n6A4X
        x3peDFK955G7cdwz6rqh5wfWUslFxHY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-unilBiGRMYCJnhOgY90jPw-1; Fri, 19 May 2023 03:41:13 -0400
X-MC-Unique: unilBiGRMYCJnhOgY90jPw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0BCD29AB3E8;
        Fri, 19 May 2023 07:41:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 894042166B28;
        Fri, 19 May 2023 07:41:10 +0000 (UTC)
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
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v20 03/32] splice: Make direct_read_splice() limit to eof where appropriate
Date:   Fri, 19 May 2023 08:40:18 +0100
Message-Id: <20230519074047.1739879-4-dhowells@redhat.com>
In-Reply-To: <20230519074047.1739879-1-dhowells@redhat.com>
References: <20230519074047.1739879-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make direct_read_splice() limit the read to the end of the file for regular
files and block devices, thereby reducing the amount of allocation it will
do in such a case.

This means that the blockdev code doesn't require any special handling as
filemap_read_splice() also limits to i_size.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/splice.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index 4db3eee49423..89c8516554d1 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -315,6 +315,19 @@ ssize_t direct_splice_read(struct file *in, loff_t *ppos,
 	size_t used, npages, chunk, remain, keep = 0;
 	int i;
 
+	if (!len)
+		return 0;
+
+	if (S_ISREG(file_inode(in)->i_mode) ||
+	    S_ISBLK(file_inode(in)->i_mode)) {
+		loff_t i_size = i_size_read(in->f_mapping->host);
+
+		if (*ppos >= i_size)
+			return 0;
+		if (len > i_size - *ppos)
+			len = i_size - *ppos;
+	}
+
 	/* Work out how much data we can actually add into the pipe */
 	used = pipe_occupancy(pipe->head, pipe->tail);
 	npages = max_t(ssize_t, pipe->max_usage - used, 0);

