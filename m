Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31933FA0EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 22:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhH0U5i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 16:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbhH0U5i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 16:57:38 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E812AC0613D9;
        Fri, 27 Aug 2021 13:56:48 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id c12so13664144ljr.5;
        Fri, 27 Aug 2021 13:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D1T7WfWNcvzH9Rk51aqcudHNYK1tsZ5bySC0AdDjdzY=;
        b=RbdxFrq3AZk2AVn7yl3pt8+lQpJUp5KPzkbvVqgAcYtQu90n7SyTG8Oy8DR3QNnAkG
         c7ESdl02RlG/v/ZjzR+95EJjo1ZDbNPdZ8Ml9YriJl3BUlD5XyJDQwiidxtKql/KYNIu
         pWMZiZE4W1RDKrI1H+t91Vkkjt6YWtPdEExu8UwFo0jBsw8MCRwUnWxBQdBAAvQiMToe
         GwyJUR343O0Uso4JUHCe1XBYpnNP1lk6SbCRxuD9adRqeRQvY67WTAAwtFa84D2XtBjZ
         YBZRaBG6osK6MrBVHoRSB5G0k0fLyLTYwEHSrNoPDGuDh5HI8zkx6BCJyhAqtZ3EzLac
         yhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D1T7WfWNcvzH9Rk51aqcudHNYK1tsZ5bySC0AdDjdzY=;
        b=hYi9o2gaD/Xo4x0I1zyXQ9+bjxgsph5obhCDA+wy2gfII/H+X6OGhRtyzeTudzpeJY
         WZSzbZ4NDBpt6loUwSRkb3V7xsSgSwQnn60+xDf01efJjJF4e8T7P6GWmNaH2ArOrfA1
         qXNIB0oQobwOf0Gko4s3Efm1Pq3w8k6rXB2AA15zIVRG52fwrQJbhedyNJg1Ch8FqMFb
         Rpcoo1OTwOu1kBH6qyciS5Jqv9yzNCOy5Ae/txYhgr6SywqYPXu2rARAcAOBQWf0ql17
         Ncu0CZpfsZUr6FemxTUKjO2iK8MQT0eZE/21s5kHDgLm/755oiMXLFwkevlW3jvVw8MS
         eDNA==
X-Gm-Message-State: AOAM532JMw4JXTmUyD9ft3T/7KpJwTEmoaDvmEdNlCg+GnAzksi5jXOJ
        JQtemgWtXjouLsFbvqeEF9E=
X-Google-Smtp-Source: ABdhPJwCJ2OaAUF4gAyq/jrqfb/W8br/EFdiBn99hCJwKvuif4qcT7IwmOBkVG9J+AGjgGor/tS0Ow==
X-Received: by 2002:a2e:bc1a:: with SMTP id b26mr9289762ljf.218.1630097807229;
        Fri, 27 Aug 2021 13:56:47 -0700 (PDT)
Received: from kari-VirtualBox (87-95-21-3.bb.dnainternet.fi. [87.95.21.3])
        by smtp.gmail.com with ESMTPSA id f9sm687906lfg.143.2021.08.27.13.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 13:56:46 -0700 (PDT)
Date:   Fri, 27 Aug 2021 23:56:44 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, ntfs3@lists.linux.dev
Subject: Re: [PATCH v7 04/19] iov_iter: Turn iov_iter_fault_in_readable into
 fault_in_iov_iter_readable
Message-ID: <20210827205644.lkihrypv27er5km3@kari-VirtualBox>
References: <20210827164926.1726765-1-agruenba@redhat.com>
 <20210827164926.1726765-5-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827164926.1726765-5-agruenba@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 06:49:11PM +0200, Andreas Gruenbacher wrote:
> Turn iov_iter_fault_in_readable into a function that returns the number
> of bytes not faulted in (similar to copy_to_user) instead of returning a
> non-zero value when any of the requested pages couldn't be faulted in.
> This supports the existing users that require all pages to be faulted in
> as well as new users that are happy if any pages can be faulted in at
> all.
> 
> Rename iov_iter_fault_in_readable to fault_in_iov_iter_readable to make
> sure that this change doesn't silently break things.

At least this patch will break ntfs3 which is in next. It has been there
just couple weeks so I understand. I added Konstantin and ntfs3 list so
that we know what is going on. Can you please info if and when do we
need rebase.

We are in situation that ntfs3 might get in 5.15, but it is uncertain so
it would be best that we solve this. Just info is enough.

Argillander

> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  fs/btrfs/file.c        |  2 +-
>  fs/f2fs/file.c         |  2 +-
>  fs/fuse/file.c         |  2 +-
>  fs/iomap/buffered-io.c |  2 +-
>  fs/ntfs/file.c         |  2 +-
>  include/linux/uio.h    |  2 +-
>  lib/iov_iter.c         | 33 +++++++++++++++++++++------------
>  mm/filemap.c           |  2 +-
>  8 files changed, 28 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index ee34497500e1..281c77cfe91a 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1698,7 +1698,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
>  		 * Fault pages before locking them in prepare_pages
>  		 * to avoid recursive lock
>  		 */
> -		if (unlikely(iov_iter_fault_in_readable(i, write_bytes))) {
> +		if (unlikely(fault_in_iov_iter_readable(i, write_bytes))) {
>  			ret = -EFAULT;
>  			break;
>  		}
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 6afd4562335f..b04b6c909a8b 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4259,7 +4259,7 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		size_t target_size = 0;
>  		int err;
>  
> -		if (iov_iter_fault_in_readable(from, iov_iter_count(from)))
> +		if (fault_in_iov_iter_readable(from, iov_iter_count(from)))
>  			set_inode_flag(inode, FI_NO_PREALLOC);
>  
>  		if ((iocb->ki_flags & IOCB_NOWAIT)) {
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 97f860cfc195..da49ef71dab5 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1160,7 +1160,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
>  
>   again:
>  		err = -EFAULT;
> -		if (iov_iter_fault_in_readable(ii, bytes))
> +		if (fault_in_iov_iter_readable(ii, bytes))
>  			break;
>  
>  		err = -ENOMEM;
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 87ccb3438bec..7dc42dd3a724 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -749,7 +749,7 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  		 * same page as we're writing to, without it being marked
>  		 * up-to-date.
>  		 */
> -		if (unlikely(iov_iter_fault_in_readable(i, bytes))) {
> +		if (unlikely(fault_in_iov_iter_readable(i, bytes))) {
>  			status = -EFAULT;
>  			break;
>  		}
> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> index ab4f3362466d..a43adeacd930 100644
> --- a/fs/ntfs/file.c
> +++ b/fs/ntfs/file.c
> @@ -1829,7 +1829,7 @@ static ssize_t ntfs_perform_write(struct file *file, struct iov_iter *i,
>  		 * pages being swapped out between us bringing them into memory
>  		 * and doing the actual copying.
>  		 */
> -		if (unlikely(iov_iter_fault_in_readable(i, bytes))) {
> +		if (unlikely(fault_in_iov_iter_readable(i, bytes))) {
>  			status = -EFAULT;
>  			break;
>  		}
> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index 82c3c3e819e0..12d30246c2e9 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -119,7 +119,7 @@ size_t copy_page_from_iter_atomic(struct page *page, unsigned offset,
>  				  size_t bytes, struct iov_iter *i);
>  void iov_iter_advance(struct iov_iter *i, size_t bytes);
>  void iov_iter_revert(struct iov_iter *i, size_t bytes);
> -int iov_iter_fault_in_readable(const struct iov_iter *i, size_t bytes);
> +size_t fault_in_iov_iter_readable(const struct iov_iter *i, size_t bytes);
>  size_t iov_iter_single_seg_count(const struct iov_iter *i);
>  size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
>  			 struct iov_iter *i);
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 069cedd9d7b4..082ab155496d 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -430,33 +430,42 @@ static size_t copy_page_to_iter_pipe(struct page *page, size_t offset, size_t by
>  }
>  
>  /*
> + * fault_in_iov_iter_readable - fault in iov iterator for reading
> + * @i: iterator
> + * @size: maximum length
> + *
>   * Fault in one or more iovecs of the given iov_iter, to a maximum length of
> - * bytes.  For each iovec, fault in each page that constitutes the iovec.
> + * @size.  For each iovec, fault in each page that constitutes the iovec.
> + *
> + * Returns the number of bytes not faulted in (like copy_to_user() and
> + * copy_from_user()).
>   *
> - * Return 0 on success, or non-zero if the memory could not be accessed (i.e.
> - * because it is an invalid address).
> + * Always returns 0 for non-userspace iterators.
>   */
> -int iov_iter_fault_in_readable(const struct iov_iter *i, size_t bytes)
> +size_t fault_in_iov_iter_readable(const struct iov_iter *i, size_t size)
>  {
>  	if (iter_is_iovec(i)) {
> +		size_t count = min(size, iov_iter_count(i));
>  		const struct iovec *p;
>  		size_t skip;
>  
> -		if (bytes > i->count)
> -			bytes = i->count;
> -		for (p = i->iov, skip = i->iov_offset; bytes; p++, skip = 0) {
> -			size_t len = min(bytes, p->iov_len - skip);
> +		size -= count;
> +		for (p = i->iov, skip = i->iov_offset; count; p++, skip = 0) {
> +			size_t len = min(count, p->iov_len - skip);
> +			size_t ret;
>  
>  			if (unlikely(!len))
>  				continue;
> -			if (fault_in_readable(p->iov_base + skip, len))
> -				return -EFAULT;
> -			bytes -= len;
> +			ret = fault_in_readable(p->iov_base + skip, len);
> +			count -= len - ret;
> +			if (ret)
> +				break;
>  		}
> +		return count + size;
>  	}
>  	return 0;
>  }
> -EXPORT_SYMBOL(iov_iter_fault_in_readable);
> +EXPORT_SYMBOL(fault_in_iov_iter_readable);
>  
>  void iov_iter_init(struct iov_iter *i, unsigned int direction,
>  			const struct iovec *iov, unsigned long nr_segs,
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 4dec3bc7752e..83af8a534339 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3643,7 +3643,7 @@ ssize_t generic_perform_write(struct file *file,
>  		 * same page as we're writing to, without it being marked
>  		 * up-to-date.
>  		 */
> -		if (unlikely(iov_iter_fault_in_readable(i, bytes))) {
> +		if (unlikely(fault_in_iov_iter_readable(i, bytes))) {
>  			status = -EFAULT;
>  			break;
>  		}
> -- 
> 2.26.3
> 
