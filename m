Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B714307A6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 17:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhA1QNV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 11:13:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:37336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232439AbhA1QML (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 11:12:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15C7D64DE5;
        Thu, 28 Jan 2021 16:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611850291;
        bh=l1fZVj6lNKrtqOWXBXFlHL9KLwU2deosKLGUjGIPhaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ae6xo2EqTNtPiMkPuwUBcZnLyMNEeIUX+7ThLWDfngvLkjuzBSsT7Pp5WbxiOPQho
         O6jLUshdETUx1nN4PLVPFnCLafOw9dc+CXzttS8jN/C7hNRWXbzwJxsWaoyVHO2Zak
         boAYycf/k6EsmAbrDlF+KkgSnuk0aRy1li4Y1jQCu0cqT5tL3yDWnu6TkthAWMZ7Dx
         DC7+JL5QB88HCrDHygJRXveBJosYNKqjW8sNNn4SLZ0p6m6F4YaeXBueIVrn/8gnEY
         BRgUeUzaBoReyjCxZvUdOjJysQUQlUOO/PKLFRuM9Cf/ybkQZOvsk0t6nN8lV4QP9L
         vk5bWmlQu//Pg==
Date:   Thu, 28 Jan 2021 08:11:28 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        Chao Yu <chao@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org, dm-devel@redhat.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 08/17] f2fs: remove FAULT_ALLOC_BIO
Message-ID: <YBLiMN7zm44VWaBI@google.com>
References: <20210126145247.1964410-1-hch@lst.de>
 <20210126145247.1964410-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126145247.1964410-9-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/26, Christoph Hellwig wrote:
> Sleeping bio allocations do not fail, which means that injecting an error
> into sleeping bio allocations is a little silly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Already merged tho.

Acked-by: Jaegeuk Kim <jaegeuk@kernel.org>

> ---
>  Documentation/filesystems/f2fs.rst |  1 -
>  fs/f2fs/data.c                     | 29 ++++-------------------------
>  fs/f2fs/f2fs.h                     |  1 -
>  fs/f2fs/super.c                    |  1 -
>  4 files changed, 4 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index dae15c96e659e2..624f5f3ed93e86 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -179,7 +179,6 @@ fault_type=%d		 Support configuring fault injection type, should be
>  			 FAULT_KVMALLOC		  0x000000002
>  			 FAULT_PAGE_ALLOC	  0x000000004
>  			 FAULT_PAGE_GET		  0x000000008
> -			 FAULT_ALLOC_BIO	  0x000000010
>  			 FAULT_ALLOC_NID	  0x000000020
>  			 FAULT_ORPHAN		  0x000000040
>  			 FAULT_BLOCK		  0x000000080
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 0cf0c605992431..9fb6be65592b1f 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -50,28 +50,6 @@ void f2fs_destroy_bioset(void)
>  	bioset_exit(&f2fs_bioset);
>  }
>  
> -static inline struct bio *__f2fs_bio_alloc(gfp_t gfp_mask,
> -						unsigned int nr_iovecs)
> -{
> -	return bio_alloc_bioset(gfp_mask, nr_iovecs, &f2fs_bioset);
> -}
> -
> -static struct bio *f2fs_bio_alloc(struct f2fs_sb_info *sbi, int npages,
> -		bool noio)
> -{
> -	if (noio) {
> -		/* No failure on bio allocation */
> -		return __f2fs_bio_alloc(GFP_NOIO, npages);
> -	}
> -
> -	if (time_to_inject(sbi, FAULT_ALLOC_BIO)) {
> -		f2fs_show_injection_info(sbi, FAULT_ALLOC_BIO);
> -		return NULL;
> -	}
> -
> -	return __f2fs_bio_alloc(GFP_KERNEL, npages);
> -}
> -
>  static bool __is_cp_guaranteed(struct page *page)
>  {
>  	struct address_space *mapping = page->mapping;
> @@ -433,7 +411,7 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
>  	struct f2fs_sb_info *sbi = fio->sbi;
>  	struct bio *bio;
>  
> -	bio = f2fs_bio_alloc(sbi, npages, true);
> +	bio = bio_alloc_bioset(GFP_NOIO, npages, &f2fs_bioset);
>  
>  	f2fs_target_device(sbi, fio->new_blkaddr, bio);
>  	if (is_read_io(fio->op)) {
> @@ -1029,8 +1007,9 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
>  	struct bio_post_read_ctx *ctx;
>  	unsigned int post_read_steps = 0;
>  
> -	bio = f2fs_bio_alloc(sbi, min_t(int, nr_pages, BIO_MAX_PAGES),
> -								for_write);
> +	bio = bio_alloc_bioset(for_write ? GFP_NOIO : GFP_KERNEL,
> +			       min_t(int, nr_pages, BIO_MAX_PAGES),
> +			       &f2fs_bioset);
>  	if (!bio)
>  		return ERR_PTR(-ENOMEM);
>  
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 902bd3267c03e1..6c78365d80ceb5 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -43,7 +43,6 @@ enum {
>  	FAULT_KVMALLOC,
>  	FAULT_PAGE_ALLOC,
>  	FAULT_PAGE_GET,
> -	FAULT_ALLOC_BIO,
>  	FAULT_ALLOC_NID,
>  	FAULT_ORPHAN,
>  	FAULT_BLOCK,
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index b4a07fe62d1a58..3a312642907e86 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -45,7 +45,6 @@ const char *f2fs_fault_name[FAULT_MAX] = {
>  	[FAULT_KVMALLOC]	= "kvmalloc",
>  	[FAULT_PAGE_ALLOC]	= "page alloc",
>  	[FAULT_PAGE_GET]	= "page get",
> -	[FAULT_ALLOC_BIO]	= "alloc bio",
>  	[FAULT_ALLOC_NID]	= "alloc nid",
>  	[FAULT_ORPHAN]		= "orphan",
>  	[FAULT_BLOCK]		= "no more block",
> -- 
> 2.29.2
