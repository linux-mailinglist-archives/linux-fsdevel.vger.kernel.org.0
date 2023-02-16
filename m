Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D149699F35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Feb 2023 22:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjBPVt1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Feb 2023 16:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjBPVtS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Feb 2023 16:49:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B7648E28
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Feb 2023 13:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676584098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LFENKL+WQlWvhbDc2HxenGINBq9+lQWBR5ko6ef/r4M=;
        b=iWvtzwwVrFEKKaEWWn43rCHY+HGms5MYYZTj6OQ3HMDoUrlqHYxm5BH8faji3DxOpahuZk
        1BrQeItp+gwHpJw+d/Ul9/NCT/MaE16dVAtqd1/t57eCOlEpnYhr5looFTPdmckDTpZ7eH
        QFK8yI+9Ia74DjZi4XOd4wHEzyGSDRk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-_tSm9z9QMGu8nYP2_juG9w-1; Thu, 16 Feb 2023 16:48:17 -0500
X-MC-Unique: _tSm9z9QMGu8nYP2_juG9w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25232802D32;
        Thu, 16 Feb 2023 21:48:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2AC5492B15;
        Thu, 16 Feb 2023 21:48:13 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        syzbot+a440341a59e3b7142895@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 03/17] splice: Add a func to do a splice from an O_DIRECT file without ITER_PIPE
Date:   Thu, 16 Feb 2023 21:47:31 +0000
Message-Id: <20230216214745.3985496-4-dhowells@redhat.com>
In-Reply-To: <20230216214745.3985496-1-dhowells@redhat.com>
References: <20230216214745.3985496-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement a function, direct_file_splice(), that deals with this by using
an ITER_BVEC iterator instead of an ITER_PIPE iterator as the former won't
free its buffers when reverted.  The function bulk allocates all the
buffers it thinks it is going to use in advance, does the read
synchronously and only then trims the buffer down.  The pages we did use
get pushed into the pipe.

This fixes a problem with the upcoming iov_iter_extract_pages() function,
whereby pages extracted from a non-user-backed iterator such as ITER_PIPE
aren't pinned.  __iomap_dio_rw(), however, calls iov_iter_revert() to
shorten the iterator to just the bufferage it is going to use - which has
the side-effect of freeing the excess pipe buffers, even though they're
attached to a bio and may get written to by DMA (thanks to Hillf Danton for
spotting this[1]).

This then causes memory corruption that is particularly noticable when the
syzbot test[2] is run.  The test boils down to:

	out = creat(argv[1], 0666);
	ftruncate(out, 0x800);
	lseek(out, 0x200, SEEK_SET);
	in = open(argv[1], O_RDONLY | O_DIRECT | O_NOFOLLOW);
	sendfile(out, in, NULL, 0x1dd00);

run repeatedly in parallel.  What I think is happening is that ftruncate()
occasionally shortens the DIO read that's about to be made by sendfile's
splice core by reducing i_size.

This should be more efficient for DIO read by virtue of doing a bulk page
allocation, but slightly less efficient by ignoring any partial page in the
pipe.

Reported-by: syzbot+a440341a59e3b7142895@syzkaller.appspotmail.com
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@lst.de>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: David Hildenbrand <david@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: linux-mm@kvack.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20230207094731.1390-1-hdanton@sina.com/ [1]
Link: https://lore.kernel.org/r/000000000000b0b3c005f3a09383@google.com/ [2]
---
 fs/splice.c               | 92 +++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h        |  3 ++
 include/linux/pipe_fs_i.h | 20 +++++++++
 lib/iov_iter.c            |  6 ---
 4 files changed, 115 insertions(+), 6 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 5969b7a1d353..4c6332854b63 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -282,6 +282,98 @@ void splice_shrink_spd(struct splice_pipe_desc *spd)
 	kfree(spd->partial);
 }
 
+/*
+ * Splice data from an O_DIRECT file into pages and then add them to the output
+ * pipe.
+ */
+ssize_t direct_splice_read(struct file *in, loff_t *ppos,
+			   struct pipe_inode_info *pipe,
+			   size_t len, unsigned int flags)
+{
+	struct iov_iter to;
+	struct bio_vec *bv;
+	struct kiocb kiocb;
+	struct page **pages;
+	ssize_t ret;
+	size_t used, npages, chunk, remain, reclaim;
+	int i;
+
+	/* Work out how much data we can actually add into the pipe */
+	used = pipe_occupancy(pipe->head, pipe->tail);
+	npages = max_t(ssize_t, pipe->max_usage - used, 0);
+	len = min_t(size_t, len, npages * PAGE_SIZE);
+	npages = DIV_ROUND_UP(len, PAGE_SIZE);
+
+	bv = kzalloc(array_size(npages, sizeof(bv[0])) +
+		     array_size(npages, sizeof(struct page *)), GFP_KERNEL);
+	if (!bv)
+		return -ENOMEM;
+
+	pages = (void *)(bv + npages);
+	npages = alloc_pages_bulk_array(GFP_USER, npages, pages);
+	if (!npages) {
+		kfree(bv);
+		return -ENOMEM;
+	}
+
+	remain = len = min_t(size_t, len, npages * PAGE_SIZE);
+
+	for (i = 0; i < npages; i++) {
+		chunk = min_t(size_t, PAGE_SIZE, remain);
+		bv[i].bv_page = pages[i];
+		bv[i].bv_offset = 0;
+		bv[i].bv_len = chunk;
+		remain -= chunk;
+	}
+
+	/* Do the I/O */
+	iov_iter_bvec(&to, ITER_DEST, bv, npages, len);
+	init_sync_kiocb(&kiocb, in);
+	kiocb.ki_pos = *ppos;
+	ret = call_read_iter(in, &kiocb, &to);
+
+	reclaim = npages * PAGE_SIZE;
+	remain = 0;
+	if (ret > 0) {
+		reclaim -= ret;
+		remain = ret;
+		*ppos = kiocb.ki_pos;
+		file_accessed(in);
+	} else if (ret < 0) {
+		/*
+		 * callers of ->splice_read() expect -EAGAIN on
+		 * "can't put anything in there", rather than -EFAULT.
+		 */
+		if (ret == -EFAULT)
+			ret = -EAGAIN;
+	}
+
+	/* Free any pages that didn't get touched at all. */
+	reclaim /= PAGE_SIZE;
+	if (reclaim) {
+		npages -= reclaim;
+		release_pages(pages + npages, reclaim);
+	}
+
+	/* Push the remaining pages into the pipe. */
+	for (i = 0; i < npages; i++) {
+		struct pipe_buffer *buf = pipe_head_buf(pipe);
+
+		chunk = min_t(size_t, remain, PAGE_SIZE);
+		*buf = (struct pipe_buffer) {
+			.ops	= &default_pipe_buf_ops,
+			.page	= bv[i].bv_page,
+			.offset	= 0,
+			.len	= chunk,
+		};
+		pipe->head++;
+		remain -= chunk;
+	}
+
+	kfree(bv);
+	return ret;
+}
+
 /**
  * generic_file_splice_read - splice data from file to a pipe
  * @in:		file to splice from
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 28743e38df91..551c9403f9b3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3166,6 +3166,9 @@ ssize_t vfs_iocb_iter_write(struct file *file, struct kiocb *iocb,
 ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
 			    struct pipe_inode_info *pipe,
 			    size_t len, unsigned int flags);
+ssize_t direct_splice_read(struct file *in, loff_t *ppos,
+			   struct pipe_inode_info *pipe,
+			   size_t len, unsigned int flags);
 extern ssize_t generic_file_splice_read(struct file *, loff_t *,
 		struct pipe_inode_info *, size_t, unsigned int);
 extern ssize_t iter_file_splice_write(struct pipe_inode_info *,
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
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index f9a3ff37ecd1..47c484551c59 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -186,12 +186,6 @@ static int copyin(void *to, const void __user *from, size_t n)
 	return res;
 }
 
-static inline struct pipe_buffer *pipe_buf(const struct pipe_inode_info *pipe,
-					   unsigned int slot)
-{
-	return &pipe->bufs[slot & (pipe->ring_size - 1)];
-}
-
 #ifdef PIPE_PARANOIA
 static bool sanity(const struct iov_iter *i)
 {

