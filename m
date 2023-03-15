Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8139F6BB9CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 17:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjCOQhC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 12:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbjCOQgy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:36:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E4D73889
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 09:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678898165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UYOaJrv+k3qRHTtCyS3jh/xO0Z1XCGBD7xHPEpqnnTw=;
        b=cEK5pW022AOcCiQKllptHPVJ3OootTfHwL+p21Pp6/StFvfKR9PbsOixkRjJGZt2dwo1BG
        hRLsVkLZu0siQEo0XBHKYddT1m1X0bii3+vykhMQYJFrSxYrRFpVi1+NZJLQh1UrLFB2Me
        /ZwvK+Szj8qg73cvDzxLVewaXB6xokA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-HjThJPlUMZe-gype1NTd7Q-1; Wed, 15 Mar 2023 12:36:04 -0400
X-MC-Unique: HjThJPlUMZe-gype1NTd7Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0D933C6675C;
        Wed, 15 Mar 2023 16:35:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95B66C164E7;
        Wed, 15 Mar 2023 16:35:56 +0000 (UTC)
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
        Miklos Szeredi <miklos@szeredi.hu>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-unionfs@vger.kernel.org
Subject: [PATCH v19 02/15] splice: Make do_splice_to() generic and export it
Date:   Wed, 15 Mar 2023 16:35:36 +0000
Message-Id: <20230315163549.295454-3-dhowells@redhat.com>
In-Reply-To: <20230315163549.295454-1-dhowells@redhat.com>
References: <20230315163549.295454-1-dhowells@redhat.com>
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

Rename do_splice_to() to vfs_splice_read() and export it so that it can be
used as a helper when calling down to a lower layer filesystem as it
performs all the necessary checks[1].

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: John Hubbard <jhubbard@nvidia.com>
cc: David Hildenbrand <david@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-unionfs@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
Link: https://lore.kernel.org/r/CAJfpeguGksS3sCigmRi9hJdUec8qtM9f+_9jC1rJhsXT+dV01w@mail.gmail.com/ [1]
---
 fs/splice.c            | 27 ++++++++++++++++++++-------
 include/linux/splice.h |  3 +++
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index abd21a455a2b..90ccd3666dca 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -851,12 +851,24 @@ static long do_splice_from(struct pipe_inode_info *pipe, struct file *out,
 	return out->f_op->splice_write(pipe, out, ppos, len, flags);
 }
 
-/*
- * Attempt to initiate a splice from a file to a pipe.
+/**
+ * vfs_splice_read - Read data from a file and splice it into a pipe
+ * @in:		File to splice from
+ * @ppos:	Input file offset
+ * @pipe:	Pipe to splice to
+ * @len:	Number of bytes to splice
+ * @flags:	Splice modifier flags (SPLICE_F_*)
+ *
+ * Splice the requested amount of data from the input file to the pipe.  This
+ * is synchronous as the caller must hold the pipe lock across the entire
+ * operation.
+ *
+ * If successful, it returns the amount of data spliced, 0 if it hit the EOF or
+ * a hole and a negative error code otherwise.
  */
-static long do_splice_to(struct file *in, loff_t *ppos,
-			 struct pipe_inode_info *pipe, size_t len,
-			 unsigned int flags)
+long vfs_splice_read(struct file *in, loff_t *ppos,
+		     struct pipe_inode_info *pipe, size_t len,
+		     unsigned int flags)
 {
 	unsigned int p_space;
 	int ret;
@@ -879,6 +891,7 @@ static long do_splice_to(struct file *in, loff_t *ppos,
 		return warn_unsupported(in, "read");
 	return in->f_op->splice_read(in, ppos, pipe, len, flags);
 }
+EXPORT_SYMBOL_GPL(vfs_splice_read);
 
 /**
  * splice_direct_to_actor - splices data directly between two non-pipes
@@ -949,7 +962,7 @@ ssize_t splice_direct_to_actor(struct file *in, struct splice_desc *sd,
 		size_t read_len;
 		loff_t pos = sd->pos, prev_pos = pos;
 
-		ret = do_splice_to(in, &pos, pipe, len, flags);
+		ret = vfs_splice_read(in, &pos, pipe, len, flags);
 		if (unlikely(ret <= 0))
 			goto out_release;
 
@@ -1097,7 +1110,7 @@ long splice_file_to_pipe(struct file *in,
 	pipe_lock(opipe);
 	ret = wait_for_space(opipe, flags);
 	if (!ret)
-		ret = do_splice_to(in, offset, opipe, len, flags);
+		ret = vfs_splice_read(in, offset, opipe, len, flags);
 	pipe_unlock(opipe);
 	if (ret > 0)
 		wakeup_pipe_readers(opipe);
diff --git a/include/linux/splice.h b/include/linux/splice.h
index a55179fd60fc..8f052c3dae95 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -76,6 +76,9 @@ extern ssize_t splice_to_pipe(struct pipe_inode_info *,
 			      struct splice_pipe_desc *);
 extern ssize_t add_to_pipe(struct pipe_inode_info *,
 			      struct pipe_buffer *);
+long vfs_splice_read(struct file *in, loff_t *ppos,
+		     struct pipe_inode_info *pipe, size_t len,
+		     unsigned int flags);
 extern ssize_t splice_direct_to_actor(struct file *, struct splice_desc *,
 				      splice_direct_actor *);
 extern long do_splice(struct file *in, loff_t *off_in,

