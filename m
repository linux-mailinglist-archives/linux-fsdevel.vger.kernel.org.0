Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7482269B7C3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 03:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjBRCnB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 21:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBRCnA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 21:43:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D001B53EF4
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Feb 2023 18:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676688131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PWOvznM2L9QyDWoJX6erFzsz89hT+rHvd14btB9G+Ac=;
        b=UJ1lp4m9UOU31wAWh/6IGrM8h1y/OobbBTCAwGB51yxtu63875Nrgutv7jhUMf7sPoZ8OU
        xj1LKM+ez424HO8ZFVsCh/FDtzY5Qu3S/z2w9ZzkK9xtSgo5h11QuVLNmajUTfJhAxkMsr
        0kQ2D8jcu+mTnRT7gW8qqoB2nfun+xA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-9bYswzT2PVWZCNa2oCU2DA-1; Fri, 17 Feb 2023 21:42:06 -0500
X-MC-Unique: 9bYswzT2PVWZCNa2oCU2DA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61C4129AA38E;
        Sat, 18 Feb 2023 02:42:05 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 618CD2026D4B;
        Sat, 18 Feb 2023 02:41:54 +0000 (UTC)
Date:   Sat, 18 Feb 2023 10:41:49 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, ming.lei@redhat.com
Subject: Re: [PATCH v14 02/17] splice: Add a func to do a splice from a
 buffered file without ITER_PIPE
Message-ID: <Y/A67a6LovSYHhHz@T590>
References: <20230214171330.2722188-1-dhowells@redhat.com>
 <20230214171330.2722188-3-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214171330.2722188-3-dhowells@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 14, 2023 at 05:13:15PM +0000, David Howells wrote:
> Provide a function to do splice read from a buffered file, pulling the
> folios out of the pagecache directly by calling filemap_get_pages() to do
> any required reading and then pasting the returned folios into the pipe.
> 
> A helper function is provided to do the actual folio pasting and will
> handle multipage folios by splicing as many of the relevant subpages as
> will fit into the pipe.
> 
> The code is loosely based on filemap_read() and might belong in
> mm/filemap.c with that as it needs to use filemap_get_pages().
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: David Hildenbrand <david@redhat.com>
> cc: John Hubbard <jhubbard@nvidia.com>
> cc: linux-mm@kvack.org
> cc: linux-block@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> ---
> 
> Notes:
>     ver #14)
>      - Rename to filemap_splice_read().
>      - Create a helper, pipe_head_buf(), to get the head buffer.
>      - Use init_sync_kiocb().
>      - Move to mm/filemap.c.
>      - Split the implementation of filemap_splice_read() from the patch to
>        make generic_file_splice_read() use it and direct_splice_read().
> 
>  include/linux/fs.h |   3 ++
>  mm/filemap.c       | 128 +++++++++++++++++++++++++++++++++++++++++++++
>  mm/internal.h      |   6 +++
>  3 files changed, 137 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c1769a2c5d70..28743e38df91 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3163,6 +3163,9 @@ ssize_t vfs_iocb_iter_write(struct file *file, struct kiocb *iocb,
>  			    struct iov_iter *iter);
>  
>  /* fs/splice.c */
> +ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
> +			    struct pipe_inode_info *pipe,
> +			    size_t len, unsigned int flags);
>  extern ssize_t generic_file_splice_read(struct file *, loff_t *,
>  		struct pipe_inode_info *, size_t, unsigned int);
>  extern ssize_t iter_file_splice_write(struct pipe_inode_info *,
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 876e77278d2a..8c7b135c8e23 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -42,6 +42,8 @@
>  #include <linux/ramfs.h>
>  #include <linux/page_idle.h>
>  #include <linux/migrate.h>
> +#include <linux/pipe_fs_i.h>
> +#include <linux/splice.h>
>  #include <asm/pgalloc.h>
>  #include <asm/tlbflush.h>
>  #include "internal.h"
> @@ -2842,6 +2844,132 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  }
>  EXPORT_SYMBOL(generic_file_read_iter);
>  
> +/*
> + * Splice subpages from a folio into a pipe.
> + */
> +size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
> +			      struct folio *folio, loff_t fpos, size_t size)
> +{
> +	struct page *page;
> +	size_t spliced = 0, offset = offset_in_folio(folio, fpos);
> +
> +	page = folio_page(folio, offset / PAGE_SIZE);
> +	size = min(size, folio_size(folio) - offset);
> +	offset %= PAGE_SIZE;
> +
> +	while (spliced < size &&
> +	       !pipe_full(pipe->head, pipe->tail, pipe->max_usage)) {
> +		struct pipe_buffer *buf = pipe_head_buf(pipe);
> +		size_t part = min_t(size_t, PAGE_SIZE - offset, size - spliced);
> +
> +		*buf = (struct pipe_buffer) {
> +			.ops	= &page_cache_pipe_buf_ops,
> +			.page	= page,
> +			.offset	= offset,
> +			.len	= part,
> +		};
> +		folio_get(folio);
> +		pipe->head++;
> +		page++;
> +		spliced += part;
> +		offset = 0;

It should be better to replace above with add_to_pipe().

> +	}
> +
> +	return spliced;
> +}
> +
> +/*
> + * Splice folios from the pagecache of a buffered (ie. non-O_DIRECT) file into
> + * a pipe.
> + */
> +ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
> +			    struct pipe_inode_info *pipe,
> +			    size_t len, unsigned int flags)
> +{
> +	struct folio_batch fbatch;
> +	struct kiocb iocb;
> +	size_t total_spliced = 0, used, npages;
> +	loff_t isize, end_offset;
> +	bool writably_mapped;
> +	int i, error = 0;
> +
> +	init_sync_kiocb(&iocb, in);
> +	iocb.ki_pos = *ppos;
> +
> +	/* Work out how much data we can actually add into the pipe */
> +	used = pipe_occupancy(pipe->head, pipe->tail);
> +	npages = max_t(ssize_t, pipe->max_usage - used, 0);
> +	len = min_t(size_t, len, npages * PAGE_SIZE);

Do we need to consider offset in 1st page here?


thanks, 
Ming

