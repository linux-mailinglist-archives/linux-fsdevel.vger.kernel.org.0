Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6CA72685B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 20:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjFGSUb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 14:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjFGSU2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:20:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13271BE5
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 11:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686161984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OL+TnlQNDjtbdgR92AyZlN3k/q2TbFv+1S0kh3gXGzs=;
        b=izEH8nlj8wOMl1gqQZlQtLJeGyEg8CgqGO6RG59FTRsbUTINJdkKc1DNpO6NwyKT4uFBOY
        aEnnsmYPOmuDLB9OSvH4KUBcLPZreNK9HOWVluLuVfrFy5d6nHJtTohb0KkZRjouVjrMLt
        uqipZLzfygiENb2gLMVIhAVXP71hriQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-BNnBFgYAMHmHweMCL8Mjlg-1; Wed, 07 Jun 2023 14:19:41 -0400
X-MC-Unique: BNnBFgYAMHmHweMCL8Mjlg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 525B5811E7F;
        Wed,  7 Jun 2023 18:19:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4BF82166B25;
        Wed,  7 Jun 2023 18:19:37 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH net-next v6 04/14] splice, net: Add a splice_eof op to file-ops and socket-ops
Date:   Wed,  7 Jun 2023 19:19:10 +0100
Message-ID: <20230607181920.2294972-5-dhowells@redhat.com>
In-Reply-To: <20230607181920.2294972-1-dhowells@redhat.com>
References: <20230607181920.2294972-1-dhowells@redhat.com>
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

Add an optional method, ->splice_eof(), to allow splice to indicate the
premature termination of a splice to struct file_operations and struct
proto_ops.

This is called if sendfile() or splice() encounters all of the following
conditions inside splice_direct_to_actor():

 (1) the user did not set SPLICE_F_MORE (splice only), and

 (2) an EOF condition occurred (->splice_read() returned 0), and

 (3) we haven't read enough to fulfill the request (ie. len > 0 still), and

 (4) we have already spliced at least one byte.

A further patch will modify the behaviour of SPLICE_F_MORE to always be
passed to the actor if either the user set it or we haven't yet read
sufficient data to fulfill the request.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/CAHk-=wh=V579PDYvkpnTobCLGczbgxpMgGmmhqiTyE34Cpi5Gg@mail.gmail.com/
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@lst.de>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Matthew Wilcox <willy@infradead.org>
cc: Jan Kara <jack@suse.cz>
cc: Jeff Layton <jlayton@kernel.org>
cc: David Hildenbrand <david@redhat.com>
cc: Christian Brauner <brauner@kernel.org>
cc: Chuck Lever <chuck.lever@oracle.com>
cc: Boris Pismenny <borisp@nvidia.com>
cc: John Fastabend <john.fastabend@gmail.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-fsdevel@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-mm@kvack.org
cc: netdev@vger.kernel.org
---
 fs/splice.c            | 31 ++++++++++++++++++++++++++++++-
 include/linux/fs.h     |  1 +
 include/linux/net.h    |  1 +
 include/linux/splice.h |  1 +
 include/net/sock.h     |  1 +
 net/socket.c           | 10 ++++++++++
 6 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/fs/splice.c b/fs/splice.c
index e337630aed64..67dbd85db207 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -969,6 +969,17 @@ static long do_splice_from(struct pipe_inode_info *pipe, struct file *out,
 	return out->f_op->splice_write(pipe, out, ppos, len, flags);
 }
 
+/*
+ * Indicate to the caller that there was a premature EOF when reading from the
+ * source and the caller didn't indicate they would be sending more data after
+ * this.
+ */
+static void do_splice_eof(struct splice_desc *sd)
+{
+	if (sd->splice_eof)
+		sd->splice_eof(sd);
+}
+
 /*
  * Attempt to initiate a splice from a file to a pipe.
  */
@@ -1068,7 +1079,7 @@ ssize_t splice_direct_to_actor(struct file *in, struct splice_desc *sd,
 
 		ret = do_splice_to(in, &pos, pipe, len, flags);
 		if (unlikely(ret <= 0))
-			goto out_release;
+			goto read_failure;
 
 		read_len = ret;
 		sd->total_len = read_len;
@@ -1108,6 +1119,15 @@ ssize_t splice_direct_to_actor(struct file *in, struct splice_desc *sd,
 	file_accessed(in);
 	return bytes;
 
+read_failure:
+	/*
+	 * If the user did *not* set SPLICE_F_MORE *and* we didn't hit that
+	 * "use all of len" case that cleared SPLICE_F_MORE, *and* we did a
+	 * "->splice_in()" that returned EOF (ie zero) *and* we have sent at
+	 * least 1 byte *then* we will also do the ->splice_eof() call.
+	 */
+	if (ret == 0 && !more && len > 0 && bytes)
+		do_splice_eof(sd);
 out_release:
 	/*
 	 * If we did an incomplete transfer we must release
@@ -1136,6 +1156,14 @@ static int direct_splice_actor(struct pipe_inode_info *pipe,
 			      sd->flags);
 }
 
+static void direct_file_splice_eof(struct splice_desc *sd)
+{
+	struct file *file = sd->u.file;
+
+	if (file->f_op->splice_eof)
+		file->f_op->splice_eof(file);
+}
+
 /**
  * do_splice_direct - splices data directly between two files
  * @in:		file to splice from
@@ -1161,6 +1189,7 @@ long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
 		.flags		= flags,
 		.pos		= *ppos,
 		.u.file		= out,
+		.splice_eof	= direct_file_splice_eof,
 		.opos		= opos,
 	};
 	long ret;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index df92f4b3d122..de2cb1132f07 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1796,6 +1796,7 @@ struct file_operations {
 	int (*flock) (struct file *, int, struct file_lock *);
 	ssize_t (*splice_write)(struct pipe_inode_info *, struct file *, loff_t *, size_t, unsigned int);
 	ssize_t (*splice_read)(struct file *, loff_t *, struct pipe_inode_info *, size_t, unsigned int);
+	void (*splice_eof)(struct file *file);
 	int (*setlease)(struct file *, long, struct file_lock **, void **);
 	long (*fallocate)(struct file *file, int mode, loff_t offset,
 			  loff_t len);
diff --git a/include/linux/net.h b/include/linux/net.h
index b73ad8e3c212..8defc8f1d82e 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -210,6 +210,7 @@ struct proto_ops {
 				      int offset, size_t size, int flags);
 	ssize_t 	(*splice_read)(struct socket *sock,  loff_t *ppos,
 				       struct pipe_inode_info *pipe, size_t len, unsigned int flags);
+	void		(*splice_eof)(struct socket *sock);
 	int		(*set_peek_off)(struct sock *sk, int val);
 	int		(*peek_len)(struct socket *sock);
 
diff --git a/include/linux/splice.h b/include/linux/splice.h
index 991ae318b6eb..4fab18a6e371 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -38,6 +38,7 @@ struct splice_desc {
 		struct file *file;	/* file to read/write */
 		void *data;		/* cookie */
 	} u;
+	void (*splice_eof)(struct splice_desc *sd); /* Unexpected EOF handler */
 	loff_t pos;			/* file position */
 	loff_t *opos;			/* sendfile: output position */
 	size_t num_spliced;		/* number of bytes already spliced */
diff --git a/include/net/sock.h b/include/net/sock.h
index b418425d7230..ae2d74a0bc4c 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1271,6 +1271,7 @@ struct proto {
 					   size_t len, int flags, int *addr_len);
 	int			(*sendpage)(struct sock *sk, struct page *page,
 					int offset, size_t size, int flags);
+	void			(*splice_eof)(struct socket *sock);
 	int			(*bind)(struct sock *sk,
 					struct sockaddr *addr, int addr_len);
 	int			(*bind_add)(struct sock *sk,
diff --git a/net/socket.c b/net/socket.c
index c4d9104418c8..b778fc03c6e0 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -130,6 +130,7 @@ static int sock_fasync(int fd, struct file *filp, int on);
 static ssize_t sock_splice_read(struct file *file, loff_t *ppos,
 				struct pipe_inode_info *pipe, size_t len,
 				unsigned int flags);
+static void sock_splice_eof(struct file *file);
 
 #ifdef CONFIG_PROC_FS
 static void sock_show_fdinfo(struct seq_file *m, struct file *f)
@@ -163,6 +164,7 @@ static const struct file_operations socket_file_ops = {
 	.fasync =	sock_fasync,
 	.splice_write = splice_to_socket,
 	.splice_read =	sock_splice_read,
+	.splice_eof =	sock_splice_eof,
 	.show_fdinfo =	sock_show_fdinfo,
 };
 
@@ -1076,6 +1078,14 @@ static ssize_t sock_splice_read(struct file *file, loff_t *ppos,
 	return sock->ops->splice_read(sock, ppos, pipe, len, flags);
 }
 
+static void sock_splice_eof(struct file *file)
+{
+	struct socket *sock = file->private_data;
+
+	if (sock->ops->splice_eof)
+		sock->ops->splice_eof(sock);
+}
+
 static ssize_t sock_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct file *file = iocb->ki_filp;

