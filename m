Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1623FDEE47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 15:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfJUNsT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 09:48:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:60466 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728083AbfJUNsT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:48:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7FDDB469;
        Mon, 21 Oct 2019 13:48:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6CC681E4AA2; Mon, 21 Oct 2019 15:48:17 +0200 (CEST)
Date:   Mon, 21 Oct 2019 15:48:17 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v5 08/12] ext4: update direct I/O read to do trylock in
 IOCB_NOWAIT cases
Message-ID: <20191021134817.GG25184@quack2.suse.cz>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <5ee370a435eb08fb14579c7c197b16e9fa0886f0.1571647179.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ee370a435eb08fb14579c7c197b16e9fa0886f0.1571647179.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 21-10-19 20:18:46, Matthew Bobrowski wrote:
> This patch updates the lock pattern in ext4_dio_read_iter() to only
> perform the trylock in IOCB_NOWAIT cases.

The changelog is actually misleading. It should say something like "This
patch updates the lock pattern in ext4_dio_read_iter() to not block on
inode lock in case of IOCB_NOWAIT direct IO reads."

Also to ease backporting of easy fixes, we try to put patches like this
early in the series (fixing code in ext4_direct_IO_read(), and then the
fixed code would just carry over to ext4_dio_read_iter()).

The change itself looks good to me.

								Honza

> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> ---
>  fs/ext4/file.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 6ea7e00e0204..8420686b90f5 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -52,7 +52,13 @@ static int ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	ssize_t ret;
>  	struct inode *inode = file_inode(iocb->ki_filp);
>  
> -	inode_lock_shared(inode);
> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> +		if (!inode_trylock_shared(inode))
> +			return -EAGAIN;
> +	} else {
> +		inode_lock_shared(inode);
> +	}
> +
>  	if (!ext4_dio_supported(inode)) {
>  		inode_unlock_shared(inode);
>  		/*
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
