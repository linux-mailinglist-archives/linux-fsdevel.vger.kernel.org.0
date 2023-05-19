Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B700D7090B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 09:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjESHo0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 03:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjESHnf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 03:43:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90B119B3
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 00:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684482135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uuCSAVZVpWhK4klEEqx7Ct2l0SGs5ZJdbhyX0+gkImI=;
        b=fFJp2AgtD/x/Xe3ZDzDn75u/INN2zK7+io3gd3b6jSfes/aYqEkcyzV+PVnkhGtRPFtyd6
        0tGu5bncFqckAgTvoVWwSXF8rSwRfeIoPF04t+uKoZ+GWCE2sXsZA5ZG+mb1lu2IA8Y3xd
        rfTRagyDhC4uwQQfPZ/JWu+is8uRdY4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-570-9WYmFVhKPfigCOXLKK6NJQ-1; Fri, 19 May 2023 03:42:10 -0400
X-MC-Unique: 9WYmFVhKPfigCOXLKK6NJQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43746101A53B;
        Fri, 19 May 2023 07:42:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A998E40D1B60;
        Fri, 19 May 2023 07:42:06 +0000 (UTC)
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
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org
Subject: [PATCH v20 20/32] orangefs: Provide a splice-read stub
Date:   Fri, 19 May 2023 08:40:35 +0100
Message-Id: <20230519074047.1739879-21-dhowells@redhat.com>
In-Reply-To: <20230519074047.1739879-1-dhowells@redhat.com>
References: <20230519074047.1739879-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a splice_read stub for ocfs2.  This increments the read stats and
then locks the inode across the call to filemap_splice_read() and a
revalidation of the mapping.

The lock must not be held across the call to direct_splice_read() as this
calls ->read_iter(); this might also mean that the stat increment doesn't
need to be done in DIO mode.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Mike Marshall <hubcap@omnibond.com>
cc: Martin Brandenburg <martin@omnibond.com>
cc: devel@lists.orangefs.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/orangefs/file.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index 1a4301a38aa7..c1eae145e4a8 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -337,6 +337,29 @@ static ssize_t orangefs_file_read_iter(struct kiocb *iocb,
 	return ret;
 }
 
+static ssize_t orangefs_file_splice_read(struct file *in, loff_t *ppos,
+					 struct pipe_inode_info *pipe,
+					 size_t len, unsigned int flags)
+{
+	struct inode *inode = file_inode(in);
+	ssize_t ret;
+
+	orangefs_stats.reads++;
+
+	if (in->f_flags & O_DIRECT)
+		return direct_splice_read(in, ppos, pipe, len, flags);
+
+	down_read(&inode->i_rwsem);
+	ret = orangefs_revalidate_mapping(inode);
+	if (ret)
+		goto out;
+
+	ret = filemap_splice_read(in, ppos, pipe, len, flags);
+out:
+	up_read(&inode->i_rwsem);
+	return ret;
+}
+
 static ssize_t orangefs_file_write_iter(struct kiocb *iocb,
     struct iov_iter *iter)
 {
@@ -556,7 +579,7 @@ const struct file_operations orangefs_file_operations = {
 	.lock		= orangefs_lock,
 	.mmap		= orangefs_file_mmap,
 	.open		= generic_file_open,
-	.splice_read    = generic_file_splice_read,
+	.splice_read    = orangefs_file_splice_read,
 	.splice_write   = iter_file_splice_write,
 	.flush		= orangefs_flush,
 	.release	= orangefs_file_release,

