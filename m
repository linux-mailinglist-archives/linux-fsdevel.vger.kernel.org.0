Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0817E70A6D5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 11:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjETJrc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 05:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjETJrb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 05:47:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4F01BD;
        Sat, 20 May 2023 02:47:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9333260B6C;
        Sat, 20 May 2023 09:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251B0C433EF;
        Sat, 20 May 2023 09:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684576048;
        bh=tpbo4BqtQNV64ZRx85M71kPc027/14n1Atl6YMev6Nw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pZFm8NQY+xZm8guWK+z/3dddQXvn4pHCJ9Yl/pAvhhPb/EOs9yGAznOr1NN3KcI9n
         kroj0W5v9/EVnsYLKAeHtnt4zR2V3URnHJjks5ik5JzTLT6IwNd/2zXSybyjZPp/6F
         gh7yL0T4hRTcx3p/ulTt1p4F9dEwLi5hRS6qqsgRnaR0gQvcIfqNGOT9iLkaBCqd+v
         94t+vqHVE64VLRbG98KcN4+B/6xeVB09BQ77glqqasMKN3neUwrTcMiIs8ZlFWQuzC
         1nckliMlCLM6KNkTmGG3sn3xggbthm2/sZZBMairxZT0KER7Q49aTk0m+oHrTdxzC2
         W+IbQC53gqZmg==
Date:   Sat, 20 May 2023 11:47:20 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v21 10/30] overlayfs: Implement splice-read
Message-ID: <20230520-zeitplan-erdig-b97a98a72261@brauner>
References: <20230520000049.2226926-1-dhowells@redhat.com>
 <20230520000049.2226926-11-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230520000049.2226926-11-dhowells@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Cc Amir as well]

On Sat, May 20, 2023 at 01:00:29AM +0100, David Howells wrote:
> Implement splice-read for overlayfs by passing the request down a layer
> rather than going through generic_file_splice_read() which is going to be
> changed to assume that ->read_folio() is present on buffered files.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: John Hubbard <jhubbard@nvidia.com>
> cc: David Hildenbrand <david@redhat.com>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Miklos Szeredi <miklos@szeredi.hu>
> cc: linux-unionfs@vger.kernel.org
> cc: linux-block@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---

Acked-by: Christian Brauner <brauner@kernel.org>

> 
> Notes:
>     ver #17)
>      - Use vfs_splice_read() helper rather than open-coding checks.
>     
>     ver #15)
>      - Remove redundant FMODE_CAN_ODIRECT check on real file.
>      - Do rw_verify_area() on the real file, not the overlay file.
>      - Fix a file leak.
> 
>  fs/overlayfs/file.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 7c04f033aadd..86197882ff35 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -419,6 +419,27 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
>  	return ret;
>  }
>  
> +static ssize_t ovl_splice_read(struct file *in, loff_t *ppos,
> +			       struct pipe_inode_info *pipe, size_t len,
> +			       unsigned int flags)
> +{
> +	const struct cred *old_cred;
> +	struct fd real;
> +	ssize_t ret;
> +
> +	ret = ovl_real_fdget(in, &real);
> +	if (ret)
> +		return ret;
> +
> +	old_cred = ovl_override_creds(file_inode(in)->i_sb);
> +	ret = vfs_splice_read(real.file, ppos, pipe, len, flags);
> +	revert_creds(old_cred);
> +	ovl_file_accessed(in);
> +
> +	fdput(real);
> +	return ret;
> +}
> +
>  /*
>   * Calling iter_file_splice_write() directly from overlay's f_op may deadlock
>   * due to lock order inversion between pipe->mutex in iter_file_splice_write()
> @@ -695,7 +716,7 @@ const struct file_operations ovl_file_operations = {
>  	.fallocate	= ovl_fallocate,
>  	.fadvise	= ovl_fadvise,
>  	.flush		= ovl_flush,
> -	.splice_read    = generic_file_splice_read,
> +	.splice_read    = ovl_splice_read,
>  	.splice_write   = ovl_splice_write,
>  
>  	.copy_file_range	= ovl_copy_file_range,
> 
