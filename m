Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76D625D2AA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 09:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbgIDHsk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 03:48:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:46406 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgIDHsj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 03:48:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 90A3CACC8;
        Fri,  4 Sep 2020 07:48:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 741CB1E12D1; Fri,  4 Sep 2020 09:48:37 +0200 (CEST)
Date:   Fri, 4 Sep 2020 09:48:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, khazhy@google.com, kernel@collabora.com
Subject: Re: [PATCH v2 2/3] direct-io: don't force writeback for reads beyond
 EOF
Message-ID: <20200904074837.GB2867@quack2.suse.cz>
References: <20200903200414.673105-1-krisman@collabora.com>
 <20200903200414.673105-3-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903200414.673105-3-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 03-09-20 16:04:13, Gabriel Krisman Bertazi wrote:
> If a DIO read starts past EOF, the kernel won't attempt it, so we don't
> need to flush dirty pages before failing the syscall.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

This patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/direct-io.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index 04aae41323d7..43460c8e0f90 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -1188,19 +1188,9 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>  	memset(dio, 0, offsetof(struct dio, pages));
>  
>  	dio->flags = flags;
> -	if (dio->flags & DIO_LOCKING) {
> -		if (iov_iter_rw(iter) == READ) {
> -			struct address_space *mapping =
> -					iocb->ki_filp->f_mapping;
> -
> -			/* will be released by direct_io_worker */
> -			inode_lock(inode);
> -
> -			retval = filemap_write_and_wait_range(mapping, offset,
> -							      end - 1);
> -			if (retval)
> -				goto fail_dio;
> -		}
> +	if (dio->flags & DIO_LOCKING && iov_iter_rw(iter) == READ) {
> +		/* will be released by direct_io_worker */
> +		inode_lock(inode);
>  	}
>  
>  	/* Once we sampled i_size check for reads beyond EOF */
> @@ -1210,6 +1200,14 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>  		goto fail_dio;
>  	}
>  
> +	if (dio->flags & DIO_LOCKING && iov_iter_rw(iter) == READ) {
> +		struct address_space *mapping = iocb->ki_filp->f_mapping;
> +
> +		retval = filemap_write_and_wait_range(mapping, offset, end - 1);
> +		if (retval)
> +			goto fail_dio;
> +	}
> +
>  	/*
>  	 * For file extending writes updating i_size before data writeouts
>  	 * complete can expose uninitialized blocks in dumb filesystems.
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
