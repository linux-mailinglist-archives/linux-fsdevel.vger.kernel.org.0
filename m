Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F850DEDD0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 15:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbfJUNiW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 09:38:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:54636 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729021AbfJUNiV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:38:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 39153AE2D;
        Mon, 21 Oct 2019 13:38:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EC4F51E4AA0; Mon, 21 Oct 2019 15:38:19 +0200 (CEST)
Date:   Mon, 21 Oct 2019 15:38:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     mbobrowski@mbobrowski.org
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v5 06/12] xfs: Use iomap_dio_rw_wait()
Message-ID: <20191021133819.GE25184@quack2.suse.cz>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <78aac4cedf43825b3535a0d35dbba179ecbdffeb.1571647179.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78aac4cedf43825b3535a0d35dbba179ecbdffeb.1571647179.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 21-10-19 20:18:27, mbobrowski@mbobrowski.org wrote:
> Use iomap_dio_rw() to wait for unaligned direct IO instead of opencoding
> the wait.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
> 
> This patch has already been posted through by Jan, but I've just
> included it within this patch series to mark that it's a clear
> dependency.

This patch actually is not a dependency. But that doesn't really matter...

								Honza

> 
>  fs/xfs/xfs_file.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 0739ba72a82e..c0620135a279 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -547,16 +547,12 @@ xfs_file_dio_aio_write(
>  	}
>  
>  	trace_xfs_file_direct_write(ip, count, iocb->ki_pos);
> -	ret = iomap_dio_rw(iocb, from, &xfs_iomap_ops, &xfs_dio_write_ops,
> -			   is_sync_kiocb(iocb));
> -
>  	/*
> -	 * If unaligned, this is the only IO in-flight. If it has not yet
> -	 * completed, wait on it before we release the iolock to prevent
> -	 * subsequent overlapping IO.
> +	 * If unaligned, this is the only IO in-flight. Wait on it before we
> +	 * release the iolock to prevent subsequent overlapping IO.
>  	 */
> -	if (ret == -EIOCBQUEUED && unaligned_io)
> -		inode_dio_wait(inode);
> +	ret = iomap_dio_rw(iocb, from, &xfs_iomap_ops, &xfs_dio_write_ops,
> +			   is_sync_kiocb(iocb) || unaligned_io);
>  out:
>  	xfs_iunlock(ip, iolock);
>  
> -- 
> 2.20.1
> 
> --<M>--
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
