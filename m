Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172F02FD980
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 20:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388743AbhATTYA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 14:24:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:53634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390115AbhATSpz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:45:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 042CF20575;
        Wed, 20 Jan 2021 18:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611168313;
        bh=JKvcTEUiv+o996+6a4zTDTrmgEmspy8AEufWQhq5cDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VU4tNtLaWnTbihymDmvWQ4cwIVUZE4AQKULkXCNhr2gwWr7TEl4l9awOj/H9LvrrW
         gb/3SGkRG4Rxzh1UAbIFCSBggmKDJKPRahF7yvMgO1TtOKN5G8iSY8U+fHWt6E/zYq
         eEmg50UpRm2MJW7M9yLfwLVvfudpCoMvB3wHhvQsN/hM0pWWmygLsPBKlJbeVP5qCF
         2aKdyWaG3idxPqbAnIzMT5f4ENwd5AWgwQ4vmTJKmr5rVFR5W5kmCAN4WdV68rjziM
         l4ZSrhZXiyXRH2UlFhGYgrpMoPygZSFfllWUUUuh/q4WD/ttYnN49Zp456vhBGuFNQ
         sjbe9MfhF5/dQ==
Date:   Wed, 20 Jan 2021 10:45:12 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        avi@scylladb.com, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 06/11] xfs: improve the reflink_bounce_dio_write
 tracepoint
Message-ID: <20210120184512.GH3134581@magnolia>
References: <20210118193516.2915706-1-hch@lst.de>
 <20210118193516.2915706-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118193516.2915706-7-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 18, 2021 at 08:35:11PM +0100, Christoph Hellwig wrote:
> Use a more suitable event class.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>

Woot!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_file.c  | 2 +-
>  fs/xfs/xfs_trace.h | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index aa64e78fc3c467..a696bd34f71d21 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -560,7 +560,7 @@ xfs_file_dio_write(
>  		 * files yet, as we can't unshare a partial block.
>  		 */
>  		if (xfs_is_cow_inode(ip)) {
> -			trace_xfs_reflink_bounce_dio_write(ip, iocb->ki_pos, count);
> +			trace_xfs_reflink_bounce_dio_write(iocb, from);
>  			return -ENOTBLK;
>  		}
>  		iolock = XFS_IOLOCK_EXCL;
> diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
> index a6d04d860a565e..0cfd65cd67c190 100644
> --- a/fs/xfs/xfs_trace.h
> +++ b/fs/xfs/xfs_trace.h
> @@ -1321,6 +1321,8 @@ DEFINE_RW_EVENT(xfs_file_dax_read);
>  DEFINE_RW_EVENT(xfs_file_buffered_write);
>  DEFINE_RW_EVENT(xfs_file_direct_write);
>  DEFINE_RW_EVENT(xfs_file_dax_write);
> +DEFINE_RW_EVENT(xfs_reflink_bounce_dio_write);
> +
>  
>  DECLARE_EVENT_CLASS(xfs_imap_class,
>  	TP_PROTO(struct xfs_inode *ip, xfs_off_t offset, ssize_t count,
> @@ -3294,8 +3296,6 @@ DEFINE_INODE_IREC_EVENT(xfs_reflink_cow_found);
>  DEFINE_INODE_IREC_EVENT(xfs_reflink_cow_enospc);
>  DEFINE_INODE_IREC_EVENT(xfs_reflink_convert_cow);
>  
> -DEFINE_SIMPLE_IO_EVENT(xfs_reflink_bounce_dio_write);
> -
>  DEFINE_SIMPLE_IO_EVENT(xfs_reflink_cancel_cow_range);
>  DEFINE_SIMPLE_IO_EVENT(xfs_reflink_end_cow);
>  DEFINE_INODE_IREC_EVENT(xfs_reflink_cow_remap);
> -- 
> 2.29.2
> 
