Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73741307C3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 18:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbhA1RYT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 12:24:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:52950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233003AbhA1RWN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 12:22:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C458764DED;
        Thu, 28 Jan 2021 17:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611854492;
        bh=wN/vYbjN9dGjcLcGdnyPwaVCaPorwnyIWndgrJa+c0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h4Jj9WXKrn+6FaWHbaqLTTirarAYDVXXbmjKm43Pwyv9CvWF/FCcMNgRPgrx3ByMo
         28fxrNXlVVTo5g3juSTT+7sNpMpJgqbGb4DuHZ8KF3an7+1BY6+nbU2z1+n7iGhwih
         wkXCxISTeJgnl/ygSyJKGjvjcoECGRGnzVlWu3E9jKtn6wt5VP3JuKjRalNmzU1hCy
         4OORtBiU8sk9BK43/E82eZ6NyUeC5IBPMIffBmVCBQkowGnqLXw2BEreMWAztT9vas
         UyeabZv1xy0SE+hBOV4TAGEolTup4mRCss8y10V/Fh7qEXQ2ropSARSls0wsWRnCVn
         9DTzlrlwSUtJA==
Date:   Thu, 28 Jan 2021 09:21:32 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com,
        xen-devel@lists.xenproject.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, linux-pm@vger.kernel.org,
        linux-mm@kvack.org, axboe@kernel.dk, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, konrad.wilk@oracle.com,
        roger.pau@citrix.com, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, agk@redhat.com,
        snitzer@redhat.com, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, viro@zeniv.linux.org.uk, tytso@mit.edu,
        jaegeuk@kernel.org, ebiggers@kernel.org, shaggy@kernel.org,
        konishi.ryusuke@gmail.com, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, damien.lemoal@wdc.com,
        naohiro.aota@wdc.com, jth@kernel.org, rjw@rjwysocki.net,
        len.brown@intel.com, pavel@ucw.cz, akpm@linux-foundation.org,
        hare@suse.de, gustavoars@kernel.org, tiwai@suse.de,
        alex.shi@linux.alibaba.com, asml.silence@gmail.com,
        ming.lei@redhat.com, tj@kernel.org, osandov@fb.com,
        bvanassche@acm.org, jefflexu@linux.alibaba.com
Subject: Re: [RFC PATCH 26/34] xfs: use bio_new in xfs_rw_bdev
Message-ID: <20210128172132.GM7698@magnolia>
References: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
 <20210128071133.60335-27-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128071133.60335-27-chaitanya.kulkarni@wdc.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 27, 2021 at 11:11:25PM -0800, Chaitanya Kulkarni wrote:
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Seems fine to me...
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_bio_io.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/xfs/xfs_bio_io.c b/fs/xfs/xfs_bio_io.c
> index e2148f2d5d6b..e4644f22ebe6 100644
> --- a/fs/xfs/xfs_bio_io.c
> +++ b/fs/xfs/xfs_bio_io.c
> @@ -26,11 +26,8 @@ xfs_rw_bdev(
>  	if (is_vmalloc && op == REQ_OP_WRITE)
>  		flush_kernel_vmap_range(data, count);
>  
> -	bio = bio_alloc(GFP_KERNEL, bio_max_vecs(left));
> -	bio_set_dev(bio, bdev);
> -	bio->bi_iter.bi_sector = sector;
> -	bio->bi_opf = op | REQ_META | REQ_SYNC;
> -
> +	bio = bio_new(bdev, sector, op, REQ_META | REQ_SYNC, bio_max_vecs(left),
> +		      GFP_KERNEL);
>  	do {
>  		struct page	*page = kmem_to_page(data);
>  		unsigned int	off = offset_in_page(data);
> -- 
> 2.22.1
> 
