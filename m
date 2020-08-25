Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D86251D1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 18:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgHYQWX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 12:22:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgHYQWV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 12:22:21 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 204672076C;
        Tue, 25 Aug 2020 16:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598372540;
        bh=Ob6Ya4sG/9TFYtRrP6g9VXPseZ2X38wAlcrlrPayfhY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=yj+xSLQWrJYsteoxUDzI4203SRM4N7vwTUF/ZLxu3kZZTD61PsVNefCJ2heTYdXez
         ZjUPhgm7YB7fwVIZoz++Avg+NgquXhY3ARdasGto7IuSRSJT7cNRqt1af9BdF/Zw0o
         sQQn//fM6Q7RI/4QY5VStkEfy1CYo69EUGd8g2to=
Message-ID: <578fb1e557d1990f768b7fdf5c6e4505db4c24e6.camel@kernel.org>
Subject: Re: [PATCH v2] fs/ceph: use pipe_get_pages_alloc() for pipe
From:   Jeff Layton <jlayton@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>, willy@infradead.org
Cc:     akpm@linux-foundation.org, axboe@kernel.dk,
        ceph-devel@vger.kernel.org, hch@infradead.org, idryomov@gmail.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk,
        "Yan, Zheng" <ukernel@gmail.com>
Date:   Tue, 25 Aug 2020 12:22:17 -0400
In-Reply-To: <20200825012034.1962362-1-jhubbard@nvidia.com>
References: <20200824185400.GE17456@casper.infradead.org>
         <20200825012034.1962362-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-08-24 at 18:20 -0700, John Hubbard wrote:
> This reduces, by one, the number of callers of iov_iter_get_pages().
> That's helpful because these calls are being audited and converted over
> to use iov_iter_pin_user_pages(), where applicable. And this one here is
> already known by the caller to be only for ITER_PIPE, so let's just
> simplify it now.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
> 
> OK, here's a v2 that does EXPORT_SYMBOL_GPL, instead of EXPORT_SYMBOL,
> that's the only change from v1. That should help give this patch a
> clear bill of passage. :)
> 
> thanks,
> John Hubbard
> NVIDIA
> 
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
> index 3835a8a8e9ea..270a4dcf5453 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -226,7 +226,8 @@ ssize_t iov_iter_get_pages(struct iov_iter *i, struct page **pages,
>  ssize_t iov_iter_get_pages_alloc(struct iov_iter *i, struct page ***pages,
>  			size_t maxsize, size_t *start);
>  int iov_iter_npages(const struct iov_iter *i, int maxpages);
> -
> +ssize_t pipe_get_pages_alloc(struct iov_iter *i, struct page ***pages,
> +			     size_t maxsize, size_t *start);
>  const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags);
>  
>  static inline size_t iov_iter_count(const struct iov_iter *i)
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 5e40786c8f12..6290998df480 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1355,9 +1355,8 @@ static struct page **get_pages_array(size_t n)
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
> @@ -1387,6 +1386,7 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter *i,
>  		kvfree(p);
>  	return n;
>  }
> +EXPORT_SYMBOL_GPL(pipe_get_pages_alloc);
>  
>  ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
>  		   struct page ***pages, size_t maxsize,

Thanks. I've got a v1 of this in the ceph-client/testing branch and it
seems fine so far.

I'd prefer an ack from Al on one or the other though, since I'm not sure
he wants to expose this primitive, and in the past he hasn't been
enamored with EXPORT_SYMBOL_GPL, because its meaning wasn't well
defined. Maybe that's changed since.

As a side note, Al also asked privately why ceph special cases
ITER_PIPE. I wasn't sure either, so I did a bit of git-archaeology. The
change was added here:

---------------------------8<---------------------------
commit
7ce469a53e7106acdaca2e25027941d0f7c12a8e
Author: Yan, Zheng <zyan@redhat.com>
Date:   Tue Nov 8 21:54:34 2016 +0800

    ceph: fix splice read for no Fc capability case
    
    When iov_iter type is ITER_PIPE, copy_page_to_iter() increases
    the page's reference and add the page to a pipe_buffer. It also
    set the pipe_buffer's ops to page_cache_pipe_buf_ops. The comfirm
    callback in page_cache_pipe_buf_ops expects the page is from page
    cache and uptodate, otherwise it return error.
    
    For ceph_sync_read() case, pages are not from page cache. So we
    can't call copy_page_to_iter() when iov_iter type is ITER_PIPE.
    The fix is using iov_iter_get_pages_alloc() to allocate pages
    for the pipe. (the code is similar to default_file_splice_read)
    
    Signed-off-by: Yan, Zheng <zyan@redhat.com>
---------------------------8<---------------------------

If we don't have Fc (FILE_CACHE) caps then the client's not allowed to
cache data and so we can't use the pagecache. I'm not certain special
casing pipes in ceph, is the best approach to handle that, but the
confirm callback still seems to work the same way today.

Cheers,
-- 
Jeff Layton <jlayton@kernel.org>

