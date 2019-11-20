Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2D8103A54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 13:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbfKTMvS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 07:51:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:38560 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729820AbfKTMvS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:51:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A57F9B3B6;
        Wed, 20 Nov 2019 12:51:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4E5B81E484C; Wed, 20 Nov 2019 13:51:16 +0100 (CET)
Date:   Wed, 20 Nov 2019 13:51:16 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mbobrowski@mbobrowski.org
Subject: Re: [RFCv3 1/4] ext4: fix ext4_dax_read/write inode locking sequence
 for IOCB_NOWAIT
Message-ID: <20191120125116.GB9509@quack2.suse.cz>
References: <20191120050024.11161-1-riteshh@linux.ibm.com>
 <20191120050024.11161-2-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120050024.11161-2-riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 20-11-19 10:30:21, Ritesh Harjani wrote:
> Apparently our current rwsem code doesn't like doing the trylock, then
> lock for real scheme.  So change our dax read/write methods to just do the
> trylock for the RWF_NOWAIT case.
> This seems to fix AIM7 regression in some scalable filesystems upto ~25%
> in some cases. Claimed in commit 942491c9e6d6 ("xfs: fix AIM7 regression")
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/file.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 6a7293a5cda2..977ac58dc718 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -88,9 +88,10 @@ static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
>  	/*
> @@ -487,9 +488,10 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	bool extend = false;
>  	struct inode *inode = file_inode(iocb->ki_filp);
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
> 2.21.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
