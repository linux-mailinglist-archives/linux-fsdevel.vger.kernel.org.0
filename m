Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199D56BB9C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 17:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjCOQfz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 12:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjCOQfy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:35:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BF76A062
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 09:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678898103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vyhvQ4/cXVFZMOdQgHYRpusDcLwKmKJK6i+/wez8Nzo=;
        b=MfgR+Pi2/K+ym+Wret8WrG4beLihMZpN40tKYH8vcUl/O3EyaYcHHUFtZEv5gNv5/eFlrQ
        STfNe65qq8Y/yGseMc4tQv4ZSQCfDqa2BRGIDoN2qbcfO8eSAIh27jklGV7pIaNnlJJXIC
        58mNqc1paJAHDwEa48fj+a8Rzn6iH6I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-aMj5vLCAMqS0RzN5FzICew-1; Wed, 15 Mar 2023 12:35:00 -0400
X-MC-Unique: aMj5vLCAMqS0RzN5FzICew-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 30ADE804197;
        Wed, 15 Mar 2023 16:34:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5A282A68;
        Wed, 15 Mar 2023 16:34:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZBCvdKQskS46qyV3@infradead.org>
References: <ZBCvdKQskS46qyV3@infradead.org> <20230308165251.2078898-1-dhowells@redhat.com> <20230308165251.2078898-3-dhowells@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-unionfs@vger.kernel.org
Subject: [RFC PATCH] splice: Convert longs and some ints into ssize_t
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <295323.1678898094.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 15 Mar 2023 16:34:54 +0000
Message-ID: <295324.1678898094@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> The (pre-existing) long here is odd given that ->splice_read
> returns a ssize_t.  This might be a good time to fix that up.

Here's a patch to do that.  I'm not sure yet that I've got all the places =
that
need changing as there are a couple of function pointer-taking functions w=
here
the pointed-to function return value should be changed.

There are a couple of potential bugs fixed here too, where something takes=
 a
size_t length, but counts the data spliced in an int.  iter_to_pipe() for
example.

David
---
splice: Convert longs and some ints into ssize_t

Convert 'long' and some 'int' into ssize_t in the code involved in splice.

Suggested-by: Christoph Hellwig <hch@lst.de>
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
Link: https://lore.kernel.org/r/ZBCvdKQskS46qyV3@infradead.org/
---
 drivers/char/mem.c            |    4 -
 drivers/char/virtio_console.c |    7 +-
 fs/splice.c                   |  119 +++++++++++++++++++++---------------=
------
 include/linux/splice.h        |   24 ++++----
 4 files changed, 78 insertions(+), 76 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index ffb101d349f0..230b72e12c54 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -468,8 +468,8 @@ static ssize_t write_iter_null(struct kiocb *iocb, str=
uct iov_iter *from)
 	return count;
 }
 =

-static int pipe_to_null(struct pipe_inode_info *info, struct pipe_buffer =
*buf,
-			struct splice_desc *sd)
+static ssize_t pipe_to_null(struct pipe_inode_info *info, struct pipe_buf=
fer *buf,
+			    struct splice_desc *sd)
 {
 	return sd->len;
 }
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index d5ac4d955bc8..d38bee859d5c 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -854,11 +854,12 @@ struct sg_list {
 	struct scatterlist *sg;
 };
 =

-static int pipe_to_sg(struct pipe_inode_info *pipe, struct pipe_buffer *b=
uf,
-			struct splice_desc *sd)
+static ssize_t pipe_to_sg(struct pipe_inode_info *pipe, struct pipe_buffe=
r *buf,
+			  struct splice_desc *sd)
 {
 	struct sg_list *sgl =3D sd->u.data;
-	unsigned int offset, len;
+	ssize_t len;
+	size_t offset;
 =

 	if (sgl->n =3D=3D sgl->size)
 		return 0;
diff --git a/fs/splice.c b/fs/splice.c
index f46dd1fb367b..2bfa94d21346 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -186,7 +186,8 @@ ssize_t splice_to_pipe(struct pipe_inode_info *pipe,
 	unsigned int tail =3D pipe->tail;
 	unsigned int head =3D pipe->head;
 	unsigned int mask =3D pipe->ring_size - 1;
-	int ret =3D 0, page_nr =3D 0;
+	ssize_t ret =3D 0;
+	int page_nr =3D 0;
 =

 	if (!spd_pages)
 		return 0;
@@ -232,7 +233,7 @@ ssize_t add_to_pipe(struct pipe_inode_info *pipe, stru=
ct pipe_buffer *buf)
 	unsigned int head =3D pipe->head;
 	unsigned int tail =3D pipe->tail;
 	unsigned int mask =3D pipe->ring_size - 1;
-	int ret;
+	ssize_t ret;
 =

 	if (unlikely(!pipe->readers)) {
 		send_sig(SIGPIPE, current, 0);
@@ -414,8 +415,8 @@ EXPORT_SYMBOL(nosteal_pipe_buf_ops);
  * Send 'sd->len' bytes to socket from 'sd->file' at position 'sd->pos'
  * using sendpage(). Return the number of bytes sent.
  */
-static int pipe_to_sendpage(struct pipe_inode_info *pipe,
-			    struct pipe_buffer *buf, struct splice_desc *sd)
+static ssize_t pipe_to_sendpage(struct pipe_inode_info *pipe,
+				struct pipe_buffer *buf, struct splice_desc *sd)
 {
 	struct file *file =3D sd->u.file;
 	loff_t pos =3D sd->pos;
@@ -468,7 +469,7 @@ static int splice_from_pipe_feed(struct pipe_inode_inf=
o *pipe, struct splice_des
 	unsigned int head =3D pipe->head;
 	unsigned int tail =3D pipe->tail;
 	unsigned int mask =3D pipe->ring_size - 1;
-	int ret;
+	ssize_t ret;
 =

 	while (!pipe_empty(head, tail)) {
 		struct pipe_buffer *buf =3D &pipe->bufs[tail & mask];
@@ -621,7 +622,7 @@ static void splice_from_pipe_end(struct pipe_inode_inf=
o *pipe, struct splice_des
 ssize_t __splice_from_pipe(struct pipe_inode_info *pipe, struct splice_de=
sc *sd,
 			   splice_actor *actor)
 {
-	int ret;
+	ssize_t ret;
 =

 	splice_from_pipe_begin(sd);
 	do {
@@ -827,8 +828,8 @@ static int warn_unsupported(struct file *file, const c=
har *op)
 /*
  * Attempt to initiate a splice from pipe to file.
  */
-static long do_splice_from(struct pipe_inode_info *pipe, struct file *out=
,
-			   loff_t *ppos, size_t len, unsigned int flags)
+static ssize_t do_splice_from(struct pipe_inode_info *pipe, struct file *=
out,
+			      loff_t *ppos, size_t len, unsigned int flags)
 {
 	if (unlikely(!out->f_op->splice_write))
 		return warn_unsupported(out, "write");
@@ -850,12 +851,12 @@ static long do_splice_from(struct pipe_inode_info *p=
ipe, struct file *out,
  * If successful, it returns the amount of data spliced, 0 if it hit the =
EOF or
  * a hole and a negative error code otherwise.
  */
-long vfs_splice_read(struct file *in, loff_t *ppos,
-		     struct pipe_inode_info *pipe, size_t len,
-		     unsigned int flags)
+ssize_t vfs_splice_read(struct file *in, loff_t *ppos,
+			struct pipe_inode_info *pipe, size_t len,
+			unsigned int flags)
 {
 	unsigned int p_space;
-	int ret;
+	ssize_t ret;
 =

 	if (unlikely(!(in->f_mode & FMODE_READ)))
 		return -EBADF;
@@ -894,7 +895,7 @@ ssize_t splice_direct_to_actor(struct file *in, struct=
 splice_desc *sd,
 			       splice_direct_actor *actor)
 {
 	struct pipe_inode_info *pipe;
-	long ret, bytes;
+	ssize_t ret, bytes;
 	size_t len;
 	int i, flags, more;
 =

@@ -1007,7 +1008,7 @@ ssize_t splice_direct_to_actor(struct file *in, stru=
ct splice_desc *sd,
 }
 EXPORT_SYMBOL(splice_direct_to_actor);
 =

-static int direct_splice_actor(struct pipe_inode_info *pipe,
+static ssize_t direct_splice_actor(struct pipe_inode_info *pipe,
 			       struct splice_desc *sd)
 {
 	struct file *file =3D sd->u.file;
@@ -1032,8 +1033,8 @@ static int direct_splice_actor(struct pipe_inode_inf=
o *pipe,
  *    can splice directly through a process-private pipe.
  *
  */
-long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
-		      loff_t *opos, size_t len, unsigned int flags)
+ssize_t do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
+			 loff_t *opos, size_t len, unsigned int flags)
 {
 	struct splice_desc sd =3D {
 		.len		=3D len,
@@ -1043,7 +1044,7 @@ long do_splice_direct(struct file *in, loff_t *ppos,=
 struct file *out,
 		.u.file		=3D out,
 		.opos		=3D opos,
 	};
-	long ret;
+	ssize_t ret;
 =

 	if (unlikely(!(out->f_mode & FMODE_WRITE)))
 		return -EBADF;
@@ -1080,16 +1081,16 @@ static int wait_for_space(struct pipe_inode_info *=
pipe, unsigned flags)
 	}
 }
 =

-static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
-			       struct pipe_inode_info *opipe,
-			       size_t len, unsigned int flags);
+static ssize_t splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
+				   struct pipe_inode_info *opipe,
+				   size_t len, unsigned int flags);
 =

-long splice_file_to_pipe(struct file *in,
-			 struct pipe_inode_info *opipe,
-			 loff_t *offset,
-			 size_t len, unsigned int flags)
+ssize_t splice_file_to_pipe(struct file *in,
+			    struct pipe_inode_info *opipe,
+			    loff_t *offset,
+			    size_t len, unsigned int flags)
 {
-	long ret;
+	ssize_t ret;
 =

 	pipe_lock(opipe);
 	ret =3D wait_for_space(opipe, flags);
@@ -1104,13 +1105,13 @@ long splice_file_to_pipe(struct file *in,
 /*
  * Determine where to splice to/from.
  */
-long do_splice(struct file *in, loff_t *off_in, struct file *out,
-	       loff_t *off_out, size_t len, unsigned int flags)
+ssize_t do_splice(struct file *in, loff_t *off_in, struct file *out,
+		  loff_t *off_out, size_t len, unsigned int flags)
 {
 	struct pipe_inode_info *ipipe;
 	struct pipe_inode_info *opipe;
 	loff_t offset;
-	long ret;
+	ssize_t ret;
 =

 	if (unlikely(!(in->f_mode & FMODE_READ) ||
 		     !(out->f_mode & FMODE_WRITE)))
@@ -1192,14 +1193,14 @@ long do_splice(struct file *in, loff_t *off_in, st=
ruct file *out,
 	return -EINVAL;
 }
 =

-static long __do_splice(struct file *in, loff_t __user *off_in,
-			struct file *out, loff_t __user *off_out,
-			size_t len, unsigned int flags)
+static ssize_t __do_splice(struct file *in, loff_t __user *off_in,
+			   struct file *out, loff_t __user *off_out,
+			   size_t len, unsigned int flags)
 {
 	struct pipe_inode_info *ipipe;
 	struct pipe_inode_info *opipe;
 	loff_t offset, *__off_in =3D NULL, *__off_out =3D NULL;
-	long ret;
+	ssize_t ret;
 =

 	ipipe =3D get_pipe_info(in, true);
 	opipe =3D get_pipe_info(out, true);
@@ -1232,16 +1233,16 @@ static long __do_splice(struct file *in, loff_t __=
user *off_in,
 	return ret;
 }
 =

-static int iter_to_pipe(struct iov_iter *from,
-			struct pipe_inode_info *pipe,
-			unsigned flags)
+static ssize_t iter_to_pipe(struct iov_iter *from,
+			    struct pipe_inode_info *pipe,
+			    unsigned flags)
 {
 	struct pipe_buffer buf =3D {
 		.ops =3D &user_page_pipe_buf_ops,
 		.flags =3D flags
 	};
 	size_t total =3D 0;
-	int ret =3D 0;
+	ssize_t ret =3D 0;
 =

 	while (iov_iter_count(from)) {
 		struct page *pages[16];
@@ -1257,7 +1258,7 @@ static int iter_to_pipe(struct iov_iter *from,
 =

 		n =3D DIV_ROUND_UP(left + start, PAGE_SIZE);
 		for (i =3D 0; i < n; i++) {
-			int size =3D min_t(int, left, PAGE_SIZE - start);
+			size_t size =3D min_t(int, left, PAGE_SIZE - start);
 =

 			buf.page =3D pages[i];
 			buf.offset =3D start;
@@ -1279,10 +1280,10 @@ static int iter_to_pipe(struct iov_iter *from,
 	return total ? total : ret;
 }
 =

-static int pipe_to_user(struct pipe_inode_info *pipe, struct pipe_buffer =
*buf,
-			struct splice_desc *sd)
+static ssize_t pipe_to_user(struct pipe_inode_info *pipe, struct pipe_buf=
fer *buf,
+			    struct splice_desc *sd)
 {
-	int n =3D copy_page_to_iter(buf->page, buf->offset, sd->len, sd->u.data)=
;
+	size_t n =3D copy_page_to_iter(buf->page, buf->offset, sd->len, sd->u.da=
ta);
 	return n =3D=3D sd->len ? n : -EFAULT;
 }
 =

@@ -1290,8 +1291,8 @@ static int pipe_to_user(struct pipe_inode_info *pipe=
, struct pipe_buffer *buf,
  * For lack of a better implementation, implement vmsplice() to userspace
  * as a simple copy of the pipes pages to the user iov.
  */
-static long vmsplice_to_user(struct file *file, struct iov_iter *iter,
-			     unsigned int flags)
+static ssize_t vmsplice_to_user(struct file *file, struct iov_iter *iter,
+				unsigned int flags)
 {
 	struct pipe_inode_info *pipe =3D get_pipe_info(file, true);
 	struct splice_desc sd =3D {
@@ -1299,7 +1300,7 @@ static long vmsplice_to_user(struct file *file, stru=
ct iov_iter *iter,
 		.flags =3D flags,
 		.u.data =3D iter
 	};
-	long ret =3D 0;
+	ssize_t ret =3D 0;
 =

 	if (!pipe)
 		return -EBADF;
@@ -1318,12 +1319,12 @@ static long vmsplice_to_user(struct file *file, st=
ruct iov_iter *iter,
  * as splice-from-memory, where the regular splice is splice-from-file (o=
r
  * to file). In both cases the output is a pipe, naturally.
  */
-static long vmsplice_to_pipe(struct file *file, struct iov_iter *iter,
-			     unsigned int flags)
+static ssize_t vmsplice_to_pipe(struct file *file, struct iov_iter *iter,
+				unsigned int flags)
 {
 	struct pipe_inode_info *pipe;
-	long ret =3D 0;
-	unsigned buf_flag =3D 0;
+	ssize_t ret =3D 0;
+	unsigned int buf_flag =3D 0;
 =

 	if (flags & SPLICE_F_GIFT)
 		buf_flag =3D PIPE_BUF_FLAG_GIFT;
@@ -1414,7 +1415,7 @@ SYSCALL_DEFINE6(splice, int, fd_in, loff_t __user *,=
 off_in,
 		size_t, len, unsigned int, flags)
 {
 	struct fd in, out;
-	long error;
+	ssize_t error;
 =

 	if (unlikely(!len))
 		return 0;
@@ -1514,15 +1515,15 @@ static int opipe_prep(struct pipe_inode_info *pipe=
, unsigned int flags)
 /*
  * Splice contents of ipipe to opipe.
  */
-static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
-			       struct pipe_inode_info *opipe,
-			       size_t len, unsigned int flags)
+static ssize_t splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
+				   struct pipe_inode_info *opipe,
+				   size_t len, unsigned int flags)
 {
 	struct pipe_buffer *ibuf, *obuf;
 	unsigned int i_head, o_head;
 	unsigned int i_tail, o_tail;
 	unsigned int i_mask, o_mask;
-	int ret =3D 0;
+	ssize_t ret =3D 0;
 	bool input_wakeup =3D false;
 =

 =

@@ -1651,15 +1652,15 @@ static int splice_pipe_to_pipe(struct pipe_inode_i=
nfo *ipipe,
 /*
  * Link contents of ipipe to opipe.
  */
-static int link_pipe(struct pipe_inode_info *ipipe,
-		     struct pipe_inode_info *opipe,
-		     size_t len, unsigned int flags)
+static ssize_t link_pipe(struct pipe_inode_info *ipipe,
+			 struct pipe_inode_info *opipe,
+			 size_t len, unsigned int flags)
 {
 	struct pipe_buffer *ibuf, *obuf;
 	unsigned int i_head, o_head;
 	unsigned int i_tail, o_tail;
 	unsigned int i_mask, o_mask;
-	int ret =3D 0;
+	ssize_t ret =3D 0;
 =

 	/*
 	 * Potential ABBA deadlock, work around it by ordering lock
@@ -1742,11 +1743,11 @@ static int link_pipe(struct pipe_inode_info *ipipe=
,
  * The 'flags' used are the SPLICE_F_* variants, currently the only
  * applicable one is SPLICE_F_NONBLOCK.
  */
-long do_tee(struct file *in, struct file *out, size_t len, unsigned int f=
lags)
+ssize_t do_tee(struct file *in, struct file *out, size_t len, unsigned in=
t flags)
 {
 	struct pipe_inode_info *ipipe =3D get_pipe_info(in, true);
 	struct pipe_inode_info *opipe =3D get_pipe_info(out, true);
-	int ret =3D -EINVAL;
+	ssize_t ret =3D -EINVAL;
 =

 	if (unlikely(!(in->f_mode & FMODE_READ) ||
 		     !(out->f_mode & FMODE_WRITE)))
@@ -1778,7 +1779,7 @@ long do_tee(struct file *in, struct file *out, size_=
t len, unsigned int flags)
 SYSCALL_DEFINE4(tee, int, fdin, int, fdout, size_t, len, unsigned int, fl=
ags)
 {
 	struct fd in, out;
-	int error;
+	ssize_t error;
 =

 	if (unlikely(flags & ~SPLICE_F_ALL))
 		return -EINVAL;
diff --git a/include/linux/splice.h b/include/linux/splice.h
index 8f052c3dae95..6af5e197ccd0 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -62,10 +62,10 @@ struct splice_pipe_desc {
 	void (*spd_release)(struct splice_pipe_desc *, unsigned int);
 };
 =

-typedef int (splice_actor)(struct pipe_inode_info *, struct pipe_buffer *=
,
-			   struct splice_desc *);
-typedef int (splice_direct_actor)(struct pipe_inode_info *,
-				  struct splice_desc *);
+typedef ssize_t (splice_actor)(struct pipe_inode_info *, struct pipe_buff=
er *,
+			       struct splice_desc *);
+typedef ssize_t (splice_direct_actor)(struct pipe_inode_info *,
+				      struct splice_desc *);
 =

 extern ssize_t splice_from_pipe(struct pipe_inode_info *, struct file *,
 				loff_t *, size_t, unsigned int,
@@ -76,17 +76,17 @@ extern ssize_t splice_to_pipe(struct pipe_inode_info *=
,
 			      struct splice_pipe_desc *);
 extern ssize_t add_to_pipe(struct pipe_inode_info *,
 			      struct pipe_buffer *);
-long vfs_splice_read(struct file *in, loff_t *ppos,
-		     struct pipe_inode_info *pipe, size_t len,
-		     unsigned int flags);
+ssize_t vfs_splice_read(struct file *in, loff_t *ppos,
+			struct pipe_inode_info *pipe, size_t len,
+			unsigned int flags);
 extern ssize_t splice_direct_to_actor(struct file *, struct splice_desc *=
,
 				      splice_direct_actor *);
-extern long do_splice(struct file *in, loff_t *off_in,
-		      struct file *out, loff_t *off_out,
-		      size_t len, unsigned int flags);
+extern ssize_t do_splice(struct file *in, loff_t *off_in,
+			 struct file *out, loff_t *off_out,
+			 size_t len, unsigned int flags);
 =

-extern long do_tee(struct file *in, struct file *out, size_t len,
-		   unsigned int flags);
+extern ssize_t do_tee(struct file *in, struct file *out, size_t len,
+		      unsigned int flags);
 =

 /*
  * for dynamic pipe sizing

