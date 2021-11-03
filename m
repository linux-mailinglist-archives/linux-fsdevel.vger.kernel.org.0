Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F656444560
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Nov 2021 17:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhKCQKC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Nov 2021 12:10:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232495AbhKCQKC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Nov 2021 12:10:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3ACF60187;
        Wed,  3 Nov 2021 16:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635955645;
        bh=HI1d8Ki7XHeU436KYocWDREMb6YuJHmjxGeSPjBNdn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gROgrH2o7fIf/Z8BC3P3I7jIaV+Ed06V8JUvCtn3ra7zgcQpk+ktH/AJ5JTPHTnUI
         yX7MmaxdR6SS/thfSYpjLJ0oK8nUEPKaC5pN+HNr9LeRAQ4sNnJXNxTT76fNBg9fpZ
         bJDbosWJTgMD6uPR+jEVwhjZmxtHn52LrG4tyAEL4/rsYr27l8vA3prclkgl8q8Xge
         gyDDM1mAPifTl+/585DqfrIdYmzh4nRfAOZV6fV+O84fWEtNtqNx8DaA7D35ces7eq
         PDPmiNd3OwRAz/DPEUXkgwlZAbvR7LbwWrDhaR8E5gZGhxKI2Y8S2RY07UJ19lH4vl
         n6Yo+34QE2ngA==
Date:   Wed, 3 Nov 2021 09:07:25 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 21/21] xfs: Support multi-page folios
Message-ID: <20211103160725.GN24307@magnolia>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-22-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101203929.954622-22-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 01, 2021 at 08:39:29PM +0000, Matthew Wilcox (Oracle) wrote:
> Now that iomap has been converted, XFS is multi-page folio safe.
> Indicate to the VFS that it can now create multi-page folios for XFS.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Provisional
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

...assuming you've run generic/521 and generic/522 (fsx) and generic/476
(fsstress) through the grinder for several days?

And just for laughs, could you run those three (for an hour or two) with

MKFS_OPTIONS='-m reflink=0,rmapbt=0 -d rtinherit=1 -r extsize=28k,rtdev=/dev/XXX'

just to see how well multipage folios deal with 4k blocks allocated in
chunks of 28k on the realtime device?  Pretty please? :D

--D

> ---
>  fs/xfs/xfs_icache.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index f2210d927481..804507c82455 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -87,6 +87,7 @@ xfs_inode_alloc(
>  	/* VFS doesn't initialise i_mode or i_state! */
>  	VFS_I(ip)->i_mode = 0;
>  	VFS_I(ip)->i_state = 0;
> +	mapping_set_large_folios(VFS_I(ip)->i_mapping);
>  
>  	XFS_STATS_INC(mp, vn_active);
>  	ASSERT(atomic_read(&ip->i_pincount) == 0);
> @@ -336,6 +337,7 @@ xfs_reinit_inode(
>  	inode->i_rdev = dev;
>  	inode->i_uid = uid;
>  	inode->i_gid = gid;
> +	mapping_set_large_folios(inode->i_mapping);
>  	return error;
>  }
>  
> -- 
> 2.33.0
> 
