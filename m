Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B302FBB1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 16:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391503AbhASPZJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 10:25:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23868 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389567AbhASPZF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 10:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611069818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6IOCzEEZmUBeZWP6WWqnV6vKo2Y6IOb3KpA7/jr14dc=;
        b=N+cpATNQ/GSJjJ1VGt+8ElnoK3D/9IqAQkncBwcdHcXp2xNntOO7jsJex6cpdsR/cwBvvZ
        7750Au075wfV4tMZGpo8PFCdfv5ikE3yNqW8hdwmZrl4PTGjCromxjbjJvg95nJGY1GVY3
        01sfFMeGs8Y8TUobpB3L1XmBJmvHP0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-597-npNQoGZ1MTq9SYFFB1BAAg-1; Tue, 19 Jan 2021 10:23:36 -0500
X-MC-Unique: npNQoGZ1MTq9SYFFB1BAAg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61F6D1005D5F;
        Tue, 19 Jan 2021 15:23:35 +0000 (UTC)
Received: from bfoster (ovpn-114-23.rdu2.redhat.com [10.10.114.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A7645D968;
        Tue, 19 Jan 2021 15:23:34 +0000 (UTC)
Date:   Tue, 19 Jan 2021 10:23:32 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        avi@scylladb.com, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 06/11] xfs: improve the reflink_bounce_dio_write
 tracepoint
Message-ID: <20210119152332.GF1646807@bfoster>
References: <20210118193516.2915706-1-hch@lst.de>
 <20210118193516.2915706-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118193516.2915706-7-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 18, 2021 at 08:35:11PM +0100, Christoph Hellwig wrote:
> Use a more suitable event class.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

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

