Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2B370C070
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 15:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbjEVNzJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 09:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjEVNyI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 09:54:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD9C198B
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 06:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684763518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d05WbB8biEgCD4p+OO2LDaxF6v/UDORhO7ObNrAbhyo=;
        b=Rm+uqkndABUsJMSZbwJtTWM+ieBQLrGbLdya4GmwbimO23DAxi+5yNrlmtNur1v8zvqwI5
        DVXFpvkUoYvn9eDCgHkozPQFi2l0gIDnVqeQjKH4QIMrPntUZEHDlqVCxFCS2peCPLJUW9
        +ubpqxO7tP7bbjcrQbI1zblmVTXrfbw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-TCrleTLlPQazmOU7dZvwBg-1; Mon, 22 May 2023 09:51:57 -0400
X-MC-Unique: TCrleTLlPQazmOU7dZvwBg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1AF63185A793;
        Mon, 22 May 2023 13:51:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3119D140E95D;
        Mon, 22 May 2023 13:51:53 +0000 (UTC)
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
Subject: [PATCH v22 23/31] orangefs: Provide a splice-read wrapper
Date:   Mon, 22 May 2023 14:50:10 +0100
Message-Id: <20230522135018.2742245-24-dhowells@redhat.com>
In-Reply-To: <20230522135018.2742245-1-dhowells@redhat.com>
References: <20230522135018.2742245-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a splice_read wrapper for ocfs2.  This increments the read stats
and then locks the inode across the call to filemap_splice_read() and a
revalidation of the mapping.  Splicing from direct I/O is done by the
caller.

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
 fs/orangefs/file.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index 1a4301a38aa7..d68372241b30 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -337,6 +337,26 @@ static ssize_t orangefs_file_read_iter(struct kiocb *iocb,
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
@@ -556,7 +576,7 @@ const struct file_operations orangefs_file_operations = {
 	.lock		= orangefs_lock,
 	.mmap		= orangefs_file_mmap,
 	.open		= generic_file_open,
-	.splice_read    = generic_file_splice_read,
+	.splice_read    = orangefs_file_splice_read,
 	.splice_write   = iter_file_splice_write,
 	.flush		= orangefs_flush,
 	.release	= orangefs_file_release,

