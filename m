Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439AF69A6D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Feb 2023 09:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjBQIXl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 03:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjBQIX3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:23:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF1D5D3C0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Feb 2023 00:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676622155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+rHRyKOcZeIEEhKELSIOc3sAUshwl8ClDrtCaFKbOR0=;
        b=IqlWZG/8/iK2vNs58iSUe6o3wlzV87mTg//MlfBC9YREdbv3J+jF7mTY14SGyHM7klv10n
        hH3nl25X/lVJmlqOYxdUaGFdjcm1Uqw2uzL6aSFziiMDTO8ic7ntp6Qs4cGn27sV+QZ52y
        hHpcz+90c3JNrDt3rnoIa+T+fXCDn0A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-mKHUGlstPr2G68_UGsxnAw-1; Fri, 17 Feb 2023 03:22:30 -0500
X-MC-Unique: mKHUGlstPr2G68_UGsxnAw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 112C885A5A3;
        Fri, 17 Feb 2023 08:22:30 +0000 (UTC)
Received: from T590 (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 180E6492C3E;
        Fri, 17 Feb 2023 08:22:19 +0000 (UTC)
Date:   Fri, 17 Feb 2023 16:22:14 +0800
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
Subject: Re: [PATCH v14 08/17] splice: Do splice read from a file without
 using ITER_PIPE
Message-ID: <Y+85Ni9CH/7ajQga@T590>
References: <20230214171330.2722188-1-dhowells@redhat.com>
 <20230214171330.2722188-9-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214171330.2722188-9-dhowells@redhat.com>
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

On Tue, Feb 14, 2023 at 05:13:21PM +0000, David Howells wrote:
> Make generic_file_splice_read() use filemap_splice_read() and
> direct_splice_read() rather than using an ITER_PIPE and call_read_iter().
> 
> With this, ITER_PIPE is no longer used.
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
>     - Split out filemap_splice_read() into a separate patch.
> 
>  fs/splice.c | 30 +++++++-----------------------
>  1 file changed, 7 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/splice.c b/fs/splice.c
> index 4c6332854b63..a93478338cec 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -391,29 +391,13 @@ ssize_t generic_file_splice_read(struct file *in, loff_t *ppos,
>  				 struct pipe_inode_info *pipe, size_t len,
>  				 unsigned int flags)
>  {
> -	struct iov_iter to;
> -	struct kiocb kiocb;
> -	int ret;
> -
> -	iov_iter_pipe(&to, ITER_DEST, pipe, len);
> -	init_sync_kiocb(&kiocb, in);
> -	kiocb.ki_pos = *ppos;
> -	ret = call_read_iter(in, &kiocb, &to);
> -	if (ret > 0) {
> -		*ppos = kiocb.ki_pos;
> -		file_accessed(in);
> -	} else if (ret < 0) {
> -		/* free what was emitted */
> -		pipe_discard_from(pipe, to.start_head);
> -		/*
> -		 * callers of ->splice_read() expect -EAGAIN on
> -		 * "can't put anything in there", rather than -EFAULT.
> -		 */
> -		if (ret == -EFAULT)
> -			ret = -EAGAIN;
> -	}
> -
> -	return ret;
> +	if (unlikely(*ppos >= file_inode(in)->i_sb->s_maxbytes))
> +		return 0;
> +	if (unlikely(!len))
> +		return 0;
> +	if (in->f_flags & O_DIRECT)
> +		return direct_splice_read(in, ppos, pipe, len, flags);

Hello David,

I have one question, for dio, pages need to map to userspace
memory, but direct_splice_read() just allocates pages and not
see when the user mapping is setup, can you give one hint?


Thanks, 
Ming

