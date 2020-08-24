Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751C324FBFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 12:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgHXKxm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 06:53:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgHXKxi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 06:53:38 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCF082071E;
        Mon, 24 Aug 2020 10:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598266416;
        bh=qH9tu8/66AnvcmnbDrUOe52jE1Smh8r+3XYyB4XlwpE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HqjPVk4t1jp1MayrpuV57WmBoGVegaoD8GrQl82u/Vio8K/GP/BCgrbESv+PT51ur
         wu4x1lBLs17gp9cWFVnCtWfwZvtiJCI6bokKbwMD2upcCCNi9Sw7eEBKS8BFbYRQCx
         BOo0ClFbxA7dS2oWLRAo1OC7wqhkSTeCI39L6tmg=
Message-ID: <048e78f2b440820d936eb67358495cc45ba579c3.camel@kernel.org>
Subject: Re: [PATCH 5/5] fs/ceph: use pipe_get_pages_alloc() for pipe
From:   Jeff Layton <jlayton@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 24 Aug 2020 06:53:34 -0400
In-Reply-To: <20200822042059.1805541-6-jhubbard@nvidia.com>
References: <20200822042059.1805541-1-jhubbard@nvidia.com>
         <20200822042059.1805541-6-jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-08-21 at 21:20 -0700, John Hubbard wrote:
> This reduces, by one, the number of callers of iov_iter_get_pages().
> That's helpful because these calls are being audited and converted over
> to use iov_iter_pin_user_pages(), where applicable. And this one here is
> already known by the caller to be only for ITER_PIPE, so let's just
> simplify it now.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  fs/ceph/file.c      | 3 +--
>  include/linux/uio.h | 3 ++-
>  lib/iov_iter.c      | 6 +++---
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index d51c3f2fdca0..d3d7dd957390 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -879,8 +879,7 @@ static ssize_t ceph_sync_read(struct kiocb *iocb, struct iov_iter *to,
>  		more = len < iov_iter_count(to);
>  
>  		if (unlikely(iov_iter_is_pipe(to))) {
> -			ret = iov_iter_get_pages_alloc(to, &pages, len,
> -						       &page_off);
> +			ret = pipe_get_pages_alloc(to, &pages, len, &page_off);
>  			if (ret <= 0) {
>  				ceph_osdc_put_request(req);
>  				ret = -ENOMEM;
> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index 62bcf5e45f2b..76cd47ab3dfd 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -227,7 +227,8 @@ ssize_t iov_iter_get_pages(struct iov_iter *i, struct page **pages,
>  ssize_t iov_iter_get_pages_alloc(struct iov_iter *i, struct page ***pages,
>  			size_t maxsize, size_t *start);
>  int iov_iter_npages(const struct iov_iter *i, int maxpages);
> -
> +ssize_t pipe_get_pages_alloc(struct iov_iter *i, struct page ***pages,
> +			     size_t maxsize, size_t *start);
>  const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags);
>  
>  ssize_t iov_iter_pin_user_pages(struct bio *bio, struct iov_iter *i, struct page **pages,
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index a4bc1b3a3fda..f571fe3ddbe8 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1396,9 +1396,8 @@ static struct page **get_pages_array(size_t n)
>  	return kvmalloc_array(n, sizeof(struct page *), GFP_KERNEL);
>  }
>  
> -static ssize_t pipe_get_pages_alloc(struct iov_iter *i,
> -		   struct page ***pages, size_t maxsize,
> -		   size_t *start)
> +ssize_t pipe_get_pages_alloc(struct iov_iter *i, struct page ***pages,
> +			     size_t maxsize, size_t *start)
>  {
>  	struct page **p;
>  	unsigned int iter_head, npages;
> @@ -1428,6 +1427,7 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter *i,
>  		kvfree(p);
>  	return n;
>  }
> +EXPORT_SYMBOL(pipe_get_pages_alloc);
>  
>  ssize_t iov_iter_pin_user_pages_alloc(struct bio *bio, struct iov_iter *i,
>  		   struct page ***pages, size_t maxsize,


This looks fine to me. Let me know if you need this merged via the ceph
tree. Thanks!

Acked-by: Jeff Layton <jlayton@kernel.org>

