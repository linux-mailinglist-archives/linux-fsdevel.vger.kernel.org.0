Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B5645AFA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 00:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhKWXDd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 18:03:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:58208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229642AbhKWXDc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 18:03:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD5E660FBF;
        Tue, 23 Nov 2021 23:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637708424;
        bh=sKHHXnnbT3vnShXHfDI+XrnWEu6cyJlqv49857pCV5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SNfotjJ8X++j3i9C0PzbRugHo7+tyQ3T4m1T2Z0oDe2BL+CvmLKMHbJ9Aof3VKeNY
         sDwLljj8mRvyOvc3cyUTZKzacZFGEg4uSutp+x+tnV8kkKHJifjLRY9EmRsdBMiUqe
         GxVn3bDkDVq06L3e6PgT9bShcPjCNafhZ8ZNi7Z1YJ5EtI6C7aXLzg2e0EWUycTBUP
         DPwpUyMgB1OAcoCUFI/b0zq3XhAyO+uD+jcL/j4IJjCewi4CbvT963KCjlHIf4yWwc
         jGAJ7NKjJpMVS8SUmH8wZarK5OakxSU7WDkhY0Kuv/p08iQVwJqBPPCGcgLRCX5dpb
         goCWZSExVEQpw==
Date:   Tue, 23 Nov 2021 15:00:23 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 22/29] iomap: add a IOMAP_DAX flag
Message-ID: <20211123230023.GQ266024@magnolia>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-23-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109083309.584081-23-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 09, 2021 at 09:33:02AM +0100, Christoph Hellwig wrote:
> Add a flag so that the file system can easily detect DAX operations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/dax.c              | 7 ++++---
>  include/linux/iomap.h | 1 +
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 5b52b878124ac..0bd6cdcbacfc4 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1180,7 +1180,7 @@ int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>  		.inode		= inode,
>  		.pos		= pos,
>  		.len		= len,
> -		.flags		= IOMAP_ZERO,
> +		.flags		= IOMAP_DAX | IOMAP_ZERO,
>  	};
>  	int ret;
>  
> @@ -1308,6 +1308,7 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		.inode		= iocb->ki_filp->f_mapping->host,
>  		.pos		= iocb->ki_pos,
>  		.len		= iov_iter_count(iter),
> +		.flags		= IOMAP_DAX,
>  	};
>  	loff_t done = 0;
>  	int ret;
> @@ -1461,7 +1462,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  		.inode		= mapping->host,
>  		.pos		= (loff_t)vmf->pgoff << PAGE_SHIFT,
>  		.len		= PAGE_SIZE,
> -		.flags		= IOMAP_FAULT,
> +		.flags		= IOMAP_DAX | IOMAP_FAULT,
>  	};
>  	vm_fault_t ret = 0;
>  	void *entry;
> @@ -1570,7 +1571,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  	struct iomap_iter iter = {
>  		.inode		= mapping->host,
>  		.len		= PMD_SIZE,
> -		.flags		= IOMAP_FAULT,
> +		.flags		= IOMAP_DAX | IOMAP_FAULT,
>  	};
>  	vm_fault_t ret = VM_FAULT_FALLBACK;
>  	pgoff_t max_pgoff;
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 6d1b08d0ae930..146a7e3e3ea11 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -141,6 +141,7 @@ struct iomap_page_ops {
>  #define IOMAP_NOWAIT		(1 << 5) /* do not block */
>  #define IOMAP_OVERWRITE_ONLY	(1 << 6) /* only pure overwrites allowed */
>  #define IOMAP_UNSHARE		(1 << 7) /* unshare_file_range */
> +#define IOMAP_DAX		(1 << 8) /* DAX mapping */

Should this be #define'd to 0 ifndef CONFIG_FS_DAX so that the compiler
will optimize out all the IOMAP_DAX bits if dax isn't enabled in
Kconfig?  Kind of like what we do for S_DAX?

--D

>  
>  struct iomap_ops {
>  	/*
> -- 
> 2.30.2
> 
