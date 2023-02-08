Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7705A68F2E4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 17:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjBHQKr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 11:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjBHQKq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:10:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EAB4B190
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Feb 2023 08:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675872602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ttU6PE9iflqeIUm8ZnIkH1iwQtDU9V14fcb7c0ocDXI=;
        b=E+AxIB5OMso8qQmrd9cCZyXPxI4AaGdEEIceTwcQ0ZPQxQhQrftaGWQoKbXiby3Lg7Tqx7
        SHflOHzcZzOpF8Ct37YWvPytush+zeAMcXYEjpbr9UGmvNuhrWtjQhV6EnDYfxzEzAm8m1
        G1zUQ4vv3Tst5k5IsbfVVulUe0+/m2Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-Mme54beJMPytjgZ7reZGRg-1; Wed, 08 Feb 2023 11:09:56 -0500
X-MC-Unique: Mme54beJMPytjgZ7reZGRg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3587A8027FD;
        Wed,  8 Feb 2023 16:09:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 545F6492B00;
        Wed,  8 Feb 2023 16:09:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y+MydH2HZ7ihITli@infradead.org>
References: <Y+MydH2HZ7ihITli@infradead.org> <20230207171305.3716974-1-dhowells@redhat.com> <20230207171305.3716974-2-dhowells@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        syzbot+a440341a59e3b7142895@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v12 01/10] vfs, iomap: Fix generic_file_splice_read() to avoid reversion of ITER_PIPE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <176198.1675872591.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 08 Feb 2023 16:09:51 +0000
Message-ID: <176199.1675872591@warthog.procyon.org.uk>
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

Christoph Hellwig <hch@infradead.org> wrote:

> We'll have to fix reverting of pipe buffers, just as I already pointed
> out in your cifs series that tries to play the same game.

Fixing ITER_PIPE reversion isn't very straightforward, unfortunately.  It'=
s
possible for a partial direct I/O read to use reversion to trim the iterat=
or
(thereby discarding anon pages from a pipe) and then fall back to reading =
the
rest by buffered I/O.  I suppose I could set a flag on the pipe_buffers
indicating whether iov_iter_revert() is allowed to free them (if they were
spliced in from the pagecache, then they must be freed by reverting them).

How about one of two different solutions?

 (1) Repurpose the function I proposed for generic_file_splice_read() but =
only
     for splicing from O_DIRECT files; reading from non-O_DIRECT files wou=
ld
     use an ITER_PIPE as upstream.

 (2) Repurpose the function I proposed for generic_file_splice_read() but =
only
     for splicing from O_DIRECT files, as (1), but also replace the splice
     from a buffered file with something like the patch below.  This uses
     filemap_get_pages() to do the reading and to get a bunch of folios fr=
om
     the pagecache that we can then splice into the pipe directly.

David
---
splice: Do splice read from a buffered file without using ITER_PIPE

Provide a function to do splice read from a buffered file, pulling the
folios out of the pagecache directly by calling filemap_get_pages() to do
any required reading and then pasting the returned folios into the pipe.

A helper function is provided to do the actual folio pasting and will
handle multipage folios by splicing as many of the relevant subpages as
will fit into the pipe.

The ITER_BVEC-based splicing previously added is then only used for
splicing from O_DIRECT files.

The code is loosely based on filemap_read() and might belong in
mm/filemap.c with that as it needs to use filemap_get_pages().

filemap_get_pages() and some of the functions it uses are changed to take
the required byte count rather than an iterator (which was only being used
for iter->count).  This should be split into a separate file.

Signed-off-by: David Howells <dhowells@redhat.com>
---
 fs/splice.c             |  177 ++++++++++++++++++++++++++++++++++++++++++=
+-----
 include/linux/pagemap.h |    2 =

 mm/filemap.c            |   23 +++---
 3 files changed, 176 insertions(+), 26 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index fba93f4a4f9e..3ccecfa50eda 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -22,6 +22,7 @@
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/pagemap.h>
+#include <linux/pagevec.h>
 #include <linux/splice.h>
 #include <linux/memcontrol.h>
 #include <linux/mm_inline.h>
@@ -282,22 +283,13 @@ void splice_shrink_spd(struct splice_pipe_desc *spd)
 	kfree(spd->partial);
 }
 =

-/**
- * generic_file_splice_read - splice data from file to a pipe
- * @in:		file to splice from
- * @ppos:	position in @in
- * @pipe:	pipe to splice to
- * @len:	number of bytes to splice
- * @flags:	splice modifier flags
- *
- * Description:
- *    Will read pages from given file and fill them into a pipe. Can be
- *    used as long as it has more or less sane ->read_iter().
- *
+/*
+ * Splice data from an O_DIRECT file into pages and then add them to the =
output
+ * pipe.
  */
-ssize_t generic_file_splice_read(struct file *in, loff_t *ppos,
-				 struct pipe_inode_info *pipe, size_t len,
-				 unsigned int flags)
+static ssize_t generic_file_direct_splice_read(struct file *in, loff_t *p=
pos,
+					       struct pipe_inode_info *pipe,
+					       size_t len, unsigned int flags)
 {
 	LIST_HEAD(pages);
 	struct iov_iter to;
@@ -383,6 +375,161 @@ ssize_t generic_file_splice_read(struct file *in, lo=
ff_t *ppos,
 	kfree(bv);
 	return ret;
 }
+
+/*
+ * Splice subpages from a folio into a pipe.
+ */
+static size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
+				     struct folio *folio,
+				     loff_t fpos, size_t size)
+{
+	struct page *page;
+	size_t spliced =3D 0, offset =3D offset_in_folio(folio, fpos);
+
+	page =3D folio_page(folio, offset / PAGE_SIZE);
+	size =3D min(size, folio_size(folio) - offset);
+	offset %=3D PAGE_SIZE;
+
+	while (spliced < size &&
+	       !pipe_full(pipe->head, pipe->tail, pipe->max_usage)) {
+		struct pipe_buffer *buf =3D &pipe->bufs[pipe->head & (pipe->ring_size -=
 1)];
+		size_t part =3D min_t(size_t, PAGE_SIZE - offset, size - spliced);
+
+		*buf =3D (struct pipe_buffer) {
+			.ops	=3D &page_cache_pipe_buf_ops,
+			.page	=3D page,
+			.offset	=3D offset,
+			.len	=3D part,
+		};
+		folio_get(folio);
+		pipe->head++;
+		page++;
+		spliced +=3D part;
+		offset =3D 0;
+	}
+
+	return spliced;
+}
+
+/*
+ * Splice folios from the pagecache of a buffered (ie. non-O_DIRECT) file=
 into
+ * a pipe.
+ */
+static ssize_t generic_file_buffered_splice_read(struct file *in, loff_t =
*ppos,
+						 struct pipe_inode_info *pipe,
+						 size_t len,
+						 unsigned int flags)
+{
+	struct folio_batch fbatch;
+	size_t total_spliced =3D 0, used, npages;
+	loff_t isize, end_offset;
+	bool writably_mapped;
+	int i, error =3D 0;
+
+	struct kiocb iocb =3D {
+		.ki_filp	=3D in,
+		.ki_pos		=3D *ppos,
+	};
+
+	/* Work out how much data we can actually add into the pipe */
+	used =3D pipe_occupancy(pipe->head, pipe->tail);
+	npages =3D max_t(ssize_t, pipe->max_usage - used, 0);
+	len =3D min_t(size_t, len, npages * PAGE_SIZE);
+
+	folio_batch_init(&fbatch);
+
+	do {
+		cond_resched();
+
+		if (*ppos >=3D i_size_read(file_inode(in)))
+			break;
+
+		iocb.ki_pos =3D *ppos;
+		error =3D filemap_get_pages(&iocb, len, &fbatch);
+		if (error < 0)
+			break;
+
+		/*
+		 * i_size must be checked after we know the pages are Uptodate.
+		 *
+		 * Checking i_size after the check allows us to calculate
+		 * the correct value for "nr", which means the zero-filled
+		 * part of the page is not copied back to userspace (unless
+		 * another truncate extends the file - this is desired though).
+		 */
+		isize =3D i_size_read(file_inode(in));
+		if (unlikely(*ppos >=3D isize))
+			break;
+		end_offset =3D min_t(loff_t, isize, *ppos + len);
+
+		/*
+		 * Once we start copying data, we don't want to be touching any
+		 * cachelines that might be contended:
+		 */
+		writably_mapped =3D mapping_writably_mapped(in->f_mapping);
+
+		for (i =3D 0; i < folio_batch_count(&fbatch); i++) {
+			struct folio *folio =3D fbatch.folios[i];
+			size_t n;
+
+			if (folio_pos(folio) >=3D end_offset)
+				goto out;
+			folio_mark_accessed(folio);
+
+			/*
+			 * If users can be writing to this folio using arbitrary
+			 * virtual addresses, take care of potential aliasing
+			 * before reading the folio on the kernel side.
+			 */
+			if (writably_mapped)
+				flush_dcache_folio(folio);
+
+			n =3D splice_folio_into_pipe(pipe, folio, *ppos, len);
+			if (!n)
+				goto out;
+			len -=3D n;
+			total_spliced +=3D n;
+			*ppos +=3D n;
+			in->f_ra.prev_pos =3D *ppos;
+			if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
+				goto out;
+		}
+
+		folio_batch_release(&fbatch);
+	} while (len);
+
+out:
+	folio_batch_release(&fbatch);
+	file_accessed(in);
+
+	return total_spliced ? total_spliced : error;
+}
+
+/**
+ * generic_file_splice_read - splice data from file to a pipe
+ * @in:		file to splice from
+ * @ppos:	position in @in
+ * @pipe:	pipe to splice to
+ * @len:	number of bytes to splice
+ * @flags:	splice modifier flags
+ *
+ * Description:
+ *    Will read pages from given file and fill them into a pipe. Can be
+ *    used as long as it has more or less sane ->read_iter().
+ *
+ */
+ssize_t generic_file_splice_read(struct file *in, loff_t *ppos,
+				 struct pipe_inode_info *pipe, size_t len,
+				 unsigned int flags)
+{
+	if (unlikely(*ppos >=3D file_inode(in)->i_sb->s_maxbytes))
+		return 0;
+	if (unlikely(!len))
+		return 0;
+	if (in->f_flags & O_DIRECT)
+		return generic_file_direct_splice_read(in, ppos, pipe, len, flags);
+	return generic_file_buffered_splice_read(in, ppos, pipe, len, flags);
+}
 EXPORT_SYMBOL(generic_file_splice_read);
 =

 const struct pipe_buf_operations default_pipe_buf_ops =3D {
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 29e1f9e76eb6..317fbc34849f 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -748,6 +748,8 @@ struct page *read_cache_page(struct address_space *, p=
goff_t index,
 		filler_t *filler, struct file *file);
 extern struct page * read_cache_page_gfp(struct address_space *mapping,
 				pgoff_t index, gfp_t gfp_mask);
+int filemap_get_pages(struct kiocb *iocb, size_t count,
+		      struct folio_batch *fbatch);
 =

 static inline struct page *read_mapping_page(struct address_space *mappin=
g,
 				pgoff_t index, struct file *file)
diff --git a/mm/filemap.c b/mm/filemap.c
index f72e4875bfcb..f8b28352b038 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2440,10 +2440,8 @@ static int filemap_read_folio(struct file *file, fi=
ller_t filler,
 }
 =

 static bool filemap_range_uptodate(struct address_space *mapping,
-		loff_t pos, struct iov_iter *iter, struct folio *folio)
+		loff_t pos, size_t count, struct folio *folio)
 {
-	int count;
-
 	if (folio_test_uptodate(folio))
 		return true;
 	if (!mapping->a_ops->is_partially_uptodate)
@@ -2451,7 +2449,6 @@ static bool filemap_range_uptodate(struct address_sp=
ace *mapping,
 	if (mapping->host->i_blkbits >=3D folio_shift(folio))
 		return false;
 =

-	count =3D iter->count;
 	if (folio_pos(folio) > pos) {
 		count -=3D folio_pos(folio) - pos;
 		pos =3D 0;
@@ -2463,7 +2460,7 @@ static bool filemap_range_uptodate(struct address_sp=
ace *mapping,
 }
 =

 static int filemap_update_page(struct kiocb *iocb,
-		struct address_space *mapping, struct iov_iter *iter,
+		struct address_space *mapping, size_t count,
 		struct folio *folio)
 {
 	int error;
@@ -2498,7 +2495,7 @@ static int filemap_update_page(struct kiocb *iocb,
 		goto unlock;
 =

 	error =3D 0;
-	if (filemap_range_uptodate(mapping, iocb->ki_pos, iter, folio))
+	if (filemap_range_uptodate(mapping, iocb->ki_pos, count, folio))
 		goto unlock;
 =

 	error =3D -EAGAIN;
@@ -2574,8 +2571,12 @@ static int filemap_readahead(struct kiocb *iocb, st=
ruct file *file,
 	return 0;
 }
 =

-static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
-		struct folio_batch *fbatch)
+/*
+ * Extract some folios from the pagecache of a file, reading those pages =
from
+ * the backing store if necessary and waiting for them.
+ */
+int filemap_get_pages(struct kiocb *iocb, size_t count,
+		      struct folio_batch *fbatch)
 {
 	struct file *filp =3D iocb->ki_filp;
 	struct address_space *mapping =3D filp->f_mapping;
@@ -2585,7 +2586,7 @@ static int filemap_get_pages(struct kiocb *iocb, str=
uct iov_iter *iter,
 	struct folio *folio;
 	int err =3D 0;
 =

-	last_index =3D DIV_ROUND_UP(iocb->ki_pos + iter->count, PAGE_SIZE);
+	last_index =3D DIV_ROUND_UP(iocb->ki_pos + count, PAGE_SIZE);
 retry:
 	if (fatal_signal_pending(current))
 		return -EINTR;
@@ -2618,7 +2619,7 @@ static int filemap_get_pages(struct kiocb *iocb, str=
uct iov_iter *iter,
 		if ((iocb->ki_flags & IOCB_WAITQ) &&
 		    folio_batch_count(fbatch) > 1)
 			iocb->ki_flags |=3D IOCB_NOWAIT;
-		err =3D filemap_update_page(iocb, mapping, iter, folio);
+		err =3D filemap_update_page(iocb, mapping, count, folio);
 		if (err)
 			goto err;
 	}
@@ -2688,7 +2689,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_=
iter *iter,
 		if (unlikely(iocb->ki_pos >=3D i_size_read(inode)))
 			break;
 =

-		error =3D filemap_get_pages(iocb, iter, &fbatch);
+		error =3D filemap_get_pages(iocb, iov_iter_count(iter), &fbatch);
 		if (error < 0)
 			break;
 =

