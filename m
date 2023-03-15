Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104856BB9E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 17:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjCOQh4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 12:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjCOQhZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:37:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A832B7C3F1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 09:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678898179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tPHDzTeiqkehQq1hzvPvPGknkMXTxgyXWdFbtANbawg=;
        b=Nb0sQdrtf2dD1zktfWNU3RbDJbtdQ+tUVZoLJCNifPR0WNex4bOo30pzFSjnyT053t6ZMx
        uPA65/gqaPAflu4Msjmg4e9fIzcsT3+5kUoGRxF3sUrH2hy75l+cUJ6fXwN1nO75byY/+/
        7+6PTOG/FTj0CTUU/mTGim+2Go4efgQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-84-WUgqb5XdM1OrTaCbnHUsDQ-1; Wed, 15 Mar 2023 12:36:15 -0400
X-MC-Unique: WUgqb5XdM1OrTaCbnHUsDQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3540185A78F;
        Wed, 15 Mar 2023 16:36:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 639B01121314;
        Wed, 15 Mar 2023 16:36:12 +0000 (UTC)
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
        Steve French <smfrench@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>, linux-cifs@vger.kernel.org
Subject: [PATCH v19 07/15] splice: Do splice read from a file without using ITER_PIPE
Date:   Wed, 15 Mar 2023 16:35:41 +0000
Message-Id: <20230315163549.295454-8-dhowells@redhat.com>
In-Reply-To: <20230315163549.295454-1-dhowells@redhat.com>
References: <20230315163549.295454-1-dhowells@redhat.com>
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

Make generic_file_splice_read() use filemap_splice_read() and
direct_splice_read() rather than using an ITER_PIPE and call_read_iter().

With this, ITER_PIPE is no longer used.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Steve French <smfrench@gmail.com>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: David Hildenbrand <david@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: linux-mm@kvack.org
cc: linux-block@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---

Notes:
    ver #18)
     - Split out the change to cifs to make it use generic_file_splice_read().
     - Split out the unexport of filemap_splice_read() (still needed by cifs).

 fs/splice.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 90ccd3666dca..f46dd1fb367b 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -387,29 +387,13 @@ ssize_t generic_file_splice_read(struct file *in, loff_t *ppos,
 				 struct pipe_inode_info *pipe, size_t len,
 				 unsigned int flags)
 {
-	struct iov_iter to;
-	struct kiocb kiocb;
-	int ret;
-
-	iov_iter_pipe(&to, ITER_DEST, pipe, len);
-	init_sync_kiocb(&kiocb, in);
-	kiocb.ki_pos = *ppos;
-	ret = call_read_iter(in, &kiocb, &to);
-	if (ret > 0) {
-		*ppos = kiocb.ki_pos;
-		file_accessed(in);
-	} else if (ret < 0) {
-		/* free what was emitted */
-		pipe_discard_from(pipe, to.start_head);
-		/*
-		 * callers of ->splice_read() expect -EAGAIN on
-		 * "can't put anything in there", rather than -EFAULT.
-		 */
-		if (ret == -EFAULT)
-			ret = -EAGAIN;
-	}
-
-	return ret;
+	if (unlikely(*ppos >= file_inode(in)->i_sb->s_maxbytes))
+		return 0;
+	if (unlikely(!len))
+		return 0;
+	if (in->f_flags & O_DIRECT)
+		return direct_splice_read(in, ppos, pipe, len, flags);
+	return filemap_splice_read(in, ppos, pipe, len, flags);
 }
 EXPORT_SYMBOL(generic_file_splice_read);
 

