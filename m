Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79AFCBB1F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 12:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405701AbfIWKK3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 06:10:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:47368 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405672AbfIWKK3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 06:10:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0A9FAF65;
        Mon, 23 Sep 2019 10:10:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 516001E4669; Mon, 23 Sep 2019 12:10:42 +0200 (CEST)
Date:   Mon, 23 Sep 2019 12:10:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, hch@infradead.org, andres@anarazel.de,
        david@fromorbit.com, riteshh@linux.ibm.com,
        linux-f2fs-devel@lists.sourceforge.net, Ted Tso <tytso@mit.edu>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 2/3] ext4: fix inode rwsem regression
Message-ID: <20190923101042.GA25332@quack2.suse.cz>
References: <20190911093926.pfkkx25mffzeuo32@alap3.anarazel.de>
 <20190911164517.16130-1-rgoldwyn@suse.de>
 <20190911164517.16130-3-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911164517.16130-3-rgoldwyn@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 11-09-19 11:45:16, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> This is similar to 942491c9e6d6 ("xfs: fix AIM7 regression")
> Apparently our current rwsem code doesn't like doing the trylock, then
> lock for real scheme.  So change our read/write methods to just do the
> trylock for the RWF_NOWAIT case.
> 
> Fixes: 728fbc0e10b7 ("ext4: nowait aio support")
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Thanks for fixing this! The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

BTW, I've also added Ted as ext4 maintainer to CC.

								Honza

> ---
>  fs/ext4/file.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 70b0438dbc94..d5b2d0cc325d 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -40,11 +40,13 @@ static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	struct inode *inode = file_inode(iocb->ki_filp);
>  	ssize_t ret;
>  
> -	if (!inode_trylock_shared(inode)) {
> -		if (iocb->ki_flags & IOCB_NOWAIT)
> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> +		if (!inode_trylock_shared(inode))
>  			return -EAGAIN;
> +	} else {
>  		inode_lock_shared(inode);
>  	}
> +
>  	/*
>  	 * Recheck under inode lock - at this point we are sure it cannot
>  	 * change anymore
> @@ -190,11 +192,13 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	struct inode *inode = file_inode(iocb->ki_filp);
>  	ssize_t ret;
>  
> -	if (!inode_trylock(inode)) {
> -		if (iocb->ki_flags & IOCB_NOWAIT)
> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> +		if (!inode_trylock(inode))
>  			return -EAGAIN;
> +	} else {
>  		inode_lock(inode);
>  	}
> +
>  	ret = ext4_write_checks(iocb, from);
>  	if (ret <= 0)
>  		goto out;
> @@ -233,9 +237,10 @@ ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	if (!o_direct && (iocb->ki_flags & IOCB_NOWAIT))
>  		return -EOPNOTSUPP;
>  
> -	if (!inode_trylock(inode)) {
> -		if (iocb->ki_flags & IOCB_NOWAIT)
> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> +		if (!inode_trylock(inode))
>  			return -EAGAIN;
> +	} else {
>  		inode_lock(inode);
>  	}
>  
> -- 
> 2.16.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
