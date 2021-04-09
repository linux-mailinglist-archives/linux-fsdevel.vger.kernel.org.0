Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E725835A390
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 18:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhDIQkt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 12:40:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229665AbhDIQks (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:40:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7DE56108B;
        Fri,  9 Apr 2021 16:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617986434;
        bh=y65vKsllT+CRdGvjaM6gGanMbXZ5lBOPW7WiN0Nru98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pr9cFr6Q6uyl+ZnlJjKYiHsUSll87Zg6VmVLVWRj/CSkXxmrHgJounA7W+8D0xhKF
         1DG9F2E+noYowQhLwwK7VlUkowgZ5oFFn2FWksa1KK4rw9KV62s36vj5jbUJX2g1HH
         fGRZwpuS02Sm852NbRox1Mu2f1Nk0F+QCGMA8PXAFzQhvkYaNTthzt6p9f/kuQqv4R
         9H1yc8mXuX+T7efGzrfu5zRl/1m0SrrI5qJrHnqXlmnzoUDjuCjK2BnXSeZja/goWj
         LrLk14sV55Ggx90OtpwLJ+dXN+pvpQkWdyqaIhOqbh9LrgclpgP3PJQzuA/E0NH4vG
         rlqGTQgMR94/A==
Date:   Fri, 9 Apr 2021 09:40:34 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iomap: remove unused private field from ioend
Message-ID: <20210409164034.GG3957620@magnolia>
References: <20210409141210.1000155-1-bfoster@redhat.com>
 <20210409141210.1000155-6-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409141210.1000155-6-bfoster@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 09, 2021 at 10:12:10AM -0400, Brian Foster wrote:
> The only remaining user of ->io_private is the generic ioend merging
> infrastructure. The only user of that is XFS, which no longer sets
> ->io_private or passes an associated merge callback. Remove the
> unused parameter and the ->io_private field.
> 
> CC: linux-fsdevel@vger.kernel.org
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Looks good to me.  If anyone actually wants to start using io_private,
the time to holler is _right now_.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 7 +------
>  fs/xfs/xfs_aops.c      | 2 +-
>  include/linux/iomap.h  | 5 +----
>  3 files changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 414769a6ad11..b7753a7907e2 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1134,9 +1134,7 @@ iomap_ioend_can_merge(struct iomap_ioend *ioend, struct iomap_ioend *next)
>  }
>  
>  void
> -iomap_ioend_try_merge(struct iomap_ioend *ioend, struct list_head *more_ioends,
> -		void (*merge_private)(struct iomap_ioend *ioend,
> -				struct iomap_ioend *next))
> +iomap_ioend_try_merge(struct iomap_ioend *ioend, struct list_head *more_ioends)
>  {
>  	struct iomap_ioend *next;
>  
> @@ -1148,8 +1146,6 @@ iomap_ioend_try_merge(struct iomap_ioend *ioend, struct list_head *more_ioends,
>  			break;
>  		list_move_tail(&next->io_list, &ioend->io_list);
>  		ioend->io_size += next->io_size;
> -		if (next->io_private && merge_private)
> -			merge_private(ioend, next);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(iomap_ioend_try_merge);
> @@ -1235,7 +1231,6 @@ iomap_alloc_ioend(struct inode *inode, struct iomap_writepage_ctx *wpc,
>  	ioend->io_inode = inode;
>  	ioend->io_size = 0;
>  	ioend->io_offset = offset;
> -	ioend->io_private = NULL;
>  	ioend->io_bio = bio;
>  	return ioend;
>  }
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 8540180bd106..8275ee09733d 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -146,7 +146,7 @@ xfs_end_io(
>  	while ((ioend = list_first_entry_or_null(&tmp, struct iomap_ioend,
>  			io_list))) {
>  		list_del_init(&ioend->io_list);
> -		iomap_ioend_try_merge(ioend, &tmp, NULL);
> +		iomap_ioend_try_merge(ioend, &tmp);
>  		xfs_end_ioend(ioend);
>  	}
>  }
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index d202fd2d0f91..c87d0cb0de6d 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -198,7 +198,6 @@ struct iomap_ioend {
>  	struct inode		*io_inode;	/* file being written to */
>  	size_t			io_size;	/* size of the extent */
>  	loff_t			io_offset;	/* offset in the file */
> -	void			*io_private;	/* file system private data */
>  	struct bio		*io_bio;	/* bio being built */
>  	struct bio		io_inline_bio;	/* MUST BE LAST! */
>  };
> @@ -234,9 +233,7 @@ struct iomap_writepage_ctx {
>  
>  void iomap_finish_ioends(struct iomap_ioend *ioend, int error);
>  void iomap_ioend_try_merge(struct iomap_ioend *ioend,
> -		struct list_head *more_ioends,
> -		void (*merge_private)(struct iomap_ioend *ioend,
> -				struct iomap_ioend *next));
> +		struct list_head *more_ioends);
>  void iomap_sort_ioends(struct list_head *ioend_list);
>  int iomap_writepage(struct page *page, struct writeback_control *wbc,
>  		struct iomap_writepage_ctx *wpc,
> -- 
> 2.26.3
> 
