Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2FF690E22
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 17:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjBIQQe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 11:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjBIQQd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:16:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1668D22DFA
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Feb 2023 08:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675959345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bNUizXtmcdnkOYN/PK7pVzEd0gUwRHUo/YtJnnQtf7s=;
        b=at0NNN30Csvjn8Qp+HwHyRccsyoZxVM84RYQzABX3pdf5dt4miJmkhQplzIFP4TOErsfHh
        L5vF13pN3pjxpzgtV1rOLJjRLVeoJFrJXheh4I0PI4VLTr3wRen8vZ4y1pWCVpZSm0uW6n
        4KABdVDnsbOsf2JklNIff+bJZGQnQHs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-yy_9a8k6Mr-6k9U0h0Tuow-1; Thu, 09 Feb 2023 11:15:41 -0500
X-MC-Unique: yy_9a8k6Mr-6k9U0h0Tuow-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC46485C70E;
        Thu,  9 Feb 2023 16:15:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B0041121314;
        Thu,  9 Feb 2023 16:15:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y+UJAdnllBw+uxK+@casper.infradead.org>
References: <Y+UJAdnllBw+uxK+@casper.infradead.org> <20230209102954.528942-1-dhowells@redhat.com> <20230209102954.528942-2-dhowells@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
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
Subject: [PATCH v14 01/12] splice: Fix O_DIRECT file read splice to avoid reversion of ITER_PIPE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <909201.1675959337.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 09 Feb 2023 16:15:37 +0000
Message-ID: <909202.1675959337@warthog.procyon.org.uk>
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

Matthew Wilcox <willy@infradead.org> wrote:

> Please don't use alloc_pages_bulk_list().
...
> If you have that array, you can then use release_pages() ...

Done.  See attached replacement patch.

David
---
splice: Fix O_DIRECT file read splice to avoid reversion of ITER_PIPE

With the upcoming iov_iter_extract_pages() function, pages extracted from =
a
non-user-backed iterator such as ITER_PIPE aren't pinned.
__iomap_dio_rw(), however, calls iov_iter_revert() to shorten the iterator
to just the bufferage it is going to use - which has the side-effect of
freeing the excess pipe buffers, even though they're attached to a bio and
may get written to by DMA (thanks to Hillf Danton for spotting this[1]).

This then causes memory corruption that is particularly noticable when the
syzbot test[2] is run.  The test boils down to:

        out =3D creat(argv[1], 0666);
        ftruncate(out, 0x800);
        lseek(out, 0x200, SEEK_SET);
        in =3D open(argv[1], O_RDONLY | O_DIRECT | O_NOFOLLOW);
        sendfile(out, in, NULL, 0x1dd00);

run repeatedly in parallel.  What I think is happening is that ftruncate()
occasionally shortens the DIO read that's about to be made by sendfile's
splice core by reducing i_size.

Fix this by splitting the handling of a splice from an O_DIRECT file fd of=
f
from that of non-DIO and in this case, replacing the use of an ITER_PIPE
iterator with an ITER_BVEC iterator for which reversion won't free the
buffers.  The DIO-specific code bulk allocates all the buffers it thinks i=
t
is going to use in advance, does the read synchronously and only then trim=
s
the buffer down.  The pages we did use get pushed into the pipe.

This should be more efficient for DIO read by virtue of doing a bulk page
allocation, but slightly less efficient by ignoring any partial page in th=
e
pipe.

Fixes: 920756a3306a ("block: Convert bio_iov_iter_get_pages to use iov_ite=
r_extract_pages")
Reported-by: syzbot+a440341a59e3b7142895@syzkaller.appspotmail.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@lst.de>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: David Hildenbrand <david@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: linux-mm@kvack.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20230207094731.1390-1-hdanton@sina.com/ [1=
]
Link: https://lore.kernel.org/r/000000000000b0b3c005f3a09383@google.com/ [=
2]
---
Notes:
    ver #14)
     - Use alloc_pages_bulk_array() rather than alloc_pages_bulk_list().
     - Use release_pages() rather than a loop calling __free_page().
    =

    ver #13)
     - Don't completely replace generic_file_splice_read(), but rather onl=
y use
       this if we're doing a splicing from an O_DIRECT file fd.

 fs/splice.c |   98 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 98 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index 5969b7a1d353..91244270b36e 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -282,6 +282,101 @@ void splice_shrink_spd(struct splice_pipe_desc *spd)
 	kfree(spd->partial);
 }
 =

+/*
+ * Splice data from an O_DIRECT file into pages and then add them to the =
output
+ * pipe.
+ */
+static ssize_t generic_file_direct_splice_read(struct file *in, loff_t *p=
pos,
+					       struct pipe_inode_info *pipe,
+					       size_t len, unsigned int flags)
+{
+	struct iov_iter to;
+	struct bio_vec *bv;
+	struct kiocb kiocb;
+	struct page **pages;
+	unsigned int head;
+	ssize_t ret;
+	size_t used, npages, chunk, remain, reclaim;
+	int i;
+
+	/* Work out how much data we can actually add into the pipe */
+	used =3D pipe_occupancy(pipe->head, pipe->tail);
+	npages =3D max_t(ssize_t, pipe->max_usage - used, 0);
+	len =3D min_t(size_t, len, npages * PAGE_SIZE);
+	npages =3D DIV_ROUND_UP(len, PAGE_SIZE);
+
+	bv =3D kzalloc(array_size(npages, sizeof(bv[0])) +
+		     array_size(npages, sizeof(struct page *)), GFP_KERNEL);
+	if (!bv)
+		return -ENOMEM;
+
+	pages =3D (void *)(bv + npages);
+	npages =3D alloc_pages_bulk_array(GFP_USER, npages, pages);
+	if (!npages) {
+		kfree(bv);
+		return -ENOMEM;
+	}
+
+	remain =3D len =3D min_t(size_t, len, npages * PAGE_SIZE);
+
+	for (i =3D 0; i < npages; i++) {
+		chunk =3D min_t(size_t, PAGE_SIZE, remain);
+		bv[i].bv_page =3D pages[i];
+		bv[i].bv_offset =3D 0;
+		bv[i].bv_len =3D chunk;
+		remain -=3D chunk;
+	}
+
+	/* Do the I/O */
+	iov_iter_bvec(&to, ITER_DEST, bv, npages, len);
+	init_sync_kiocb(&kiocb, in);
+	kiocb.ki_pos =3D *ppos;
+	ret =3D call_read_iter(in, &kiocb, &to);
+
+	reclaim =3D npages * PAGE_SIZE;
+	remain =3D 0;
+	if (ret > 0) {
+		reclaim -=3D ret;
+		remain =3D ret;
+		*ppos =3D kiocb.ki_pos;
+		file_accessed(in);
+	} else if (ret < 0) {
+		/*
+		 * callers of ->splice_read() expect -EAGAIN on
+		 * "can't put anything in there", rather than -EFAULT.
+		 */
+		if (ret =3D=3D -EFAULT)
+			ret =3D -EAGAIN;
+	}
+
+	/* Free any pages that didn't get touched at all. */
+	reclaim /=3D PAGE_SIZE;
+	if (reclaim) {
+		npages -=3D reclaim;
+		release_pages(pages + npages, reclaim);
+	}
+
+	/* Push the remaining pages into the pipe. */
+	head =3D pipe->head;
+	for (i =3D 0; i < npages; i++) {
+		struct pipe_buffer *buf =3D &pipe->bufs[head & (pipe->ring_size - 1)];
+
+		chunk =3D min_t(size_t, remain, PAGE_SIZE);
+		*buf =3D (struct pipe_buffer) {
+			.ops	=3D &default_pipe_buf_ops,
+			.page	=3D bv[i].bv_page,
+			.offset	=3D 0,
+			.len	=3D chunk,
+		};
+		head++;
+		remain -=3D chunk;
+	}
+	pipe->head =3D head;
+
+	kfree(bv);
+	return ret;
+}
+
 /**
  * generic_file_splice_read - splice data from file to a pipe
  * @in:		file to splice from
@@ -303,6 +398,9 @@ ssize_t generic_file_splice_read(struct file *in, loff=
_t *ppos,
 	struct kiocb kiocb;
 	int ret;
 =

+	if (in->f_flags & O_DIRECT)
+		return generic_file_direct_splice_read(in, ppos, pipe, len, flags);
+
 	iov_iter_pipe(&to, ITER_DEST, pipe, len);
 	init_sync_kiocb(&kiocb, in);
 	kiocb.ki_pos =3D *ppos;

