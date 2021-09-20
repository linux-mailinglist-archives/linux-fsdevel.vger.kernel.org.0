Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697A841265B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Sep 2021 20:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387266AbhITS4z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 14:56:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:38114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1385812AbhITSw2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 14:52:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5BEE60F93;
        Mon, 20 Sep 2021 17:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632160331;
        bh=8X1huYgVmpXrodo8riMbssaE5inWAMYPMR+fBP6GCIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tLPYawOUzuDYLYhgqipKOXb/4NjftR6/YcLIuzUz7D/yc/lcJgJrHT4ORIUV/NTSE
         5uGYo206ndt5mLl97wANwxBSbgfZdMLRs18L3gogfQDBa4QMEcfTR/zl3LNKKGhHL6
         9Vm5ivM21b0SDSdJTk2lbJvR/TGSzsXypY4bpq9fBxk48eAnMTA/nhc+EtRNrir42M
         tk75cs2aCcFO3FhqjS5Bu9KjwevfckS9+vxiLMbBCV2kR6UBseM6hRRiXbyuUBosUO
         FBcjCVYZfRe9vwDn/G+NB3ZGdNYbeBm7dRkeRTagNDAHCl7Ox8XKCNLoN5jawfXhWF
         f/6Tg0/EJxTWg==
Date:   Mon, 20 Sep 2021 10:52:09 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     jane.chu@oracle.com, linux-xfs@vger.kernel.org, hch@infradead.org,
        dan.j.williams@intel.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] vfs: add a zero-initialization mode to fallocate
Message-ID: <YUjKSclPPWFmZHwZ@gmail.com>
References: <163192864476.417973.143014658064006895.stgit@magnolia>
 <163192866125.417973.7293598039998376121.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163192866125.417973.7293598039998376121.stgit@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 06:31:01PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Add a new mode to fallocate to zero-initialize all the storage backing a
> file.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/open.c                   |    5 +++++
>  include/linux/falloc.h      |    1 +
>  include/uapi/linux/falloc.h |    9 +++++++++
>  3 files changed, 15 insertions(+)
> 
> 
> diff --git a/fs/open.c b/fs/open.c
> index daa324606a41..230220b8f67a 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -256,6 +256,11 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  	    (mode & ~FALLOC_FL_INSERT_RANGE))
>  		return -EINVAL;
>  
> +	/* Zeroinit should only be used by itself and keep size must be set. */
> +	if ((mode & FALLOC_FL_ZEROINIT_RANGE) &&
> +	    (mode != (FALLOC_FL_ZEROINIT_RANGE | FALLOC_FL_KEEP_SIZE)))
> +		return -EINVAL;
> +
>  	/* Unshare range should only be used with allocate mode. */
>  	if ((mode & FALLOC_FL_UNSHARE_RANGE) &&
>  	    (mode & ~(FALLOC_FL_UNSHARE_RANGE | FALLOC_FL_KEEP_SIZE)))
> diff --git a/include/linux/falloc.h b/include/linux/falloc.h
> index f3f0b97b1675..4597b416667b 100644
> --- a/include/linux/falloc.h
> +++ b/include/linux/falloc.h
> @@ -29,6 +29,7 @@ struct space_resv {
>  					 FALLOC_FL_PUNCH_HOLE |		\
>  					 FALLOC_FL_COLLAPSE_RANGE |	\
>  					 FALLOC_FL_ZERO_RANGE |		\
> +					 FALLOC_FL_ZEROINIT_RANGE |	\
>  					 FALLOC_FL_INSERT_RANGE |	\
>  					 FALLOC_FL_UNSHARE_RANGE)
>  
> diff --git a/include/uapi/linux/falloc.h b/include/uapi/linux/falloc.h
> index 51398fa57f6c..8144403b6102 100644
> --- a/include/uapi/linux/falloc.h
> +++ b/include/uapi/linux/falloc.h
> @@ -77,4 +77,13 @@
>   */
>  #define FALLOC_FL_UNSHARE_RANGE		0x40
>  
> +/*
> + * FALLOC_FL_ZEROINIT_RANGE is used to reinitialize storage backing a file by
> + * writing zeros to it.  Subsequent read and writes should not fail due to any
> + * previous media errors.  Blocks must be not be shared or require copy on
> + * write.  Holes and unwritten extents are left untouched.  This mode must be
> + * used with FALLOC_FL_KEEP_SIZE.
> + */
> +#define FALLOC_FL_ZEROINIT_RANGE	0x80
> +

How does this differ from ZERO_RANGE?  Especially when the above says that
ZEROINIT_RANGE leaves unwritten extents untouched.  That implies that unwritten
extents are still "allowed".  If that's the case, why not just use ZERO_RANGE?

- Eric
