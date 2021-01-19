Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5C62FBB20
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 16:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390198AbhASPZm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 10:25:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38728 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391468AbhASPYs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 10:24:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611069802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cMfoMfj22BY1KKl54jQ/V7G1fwpSus/XU7Im4QVgTno=;
        b=hOwycsWenH4rNax6mVmouOssI9rHGSkzET2eAv32diAYikD0ZiEYryJ9W96k38kyO1uHD+
        ZG9A1mGwNgZoVlAbt7pczGIbG4ij33J3uuobKKIaSweZlapbg5RCG04wO7YaK5LCMvbV27
        mF04a+LSydRi+I8Dx3lrw+6CjrvnOT4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-RIXTcbs-MVm5fnHrFtQVRg-1; Tue, 19 Jan 2021 10:23:20 -0500
X-MC-Unique: RIXTcbs-MVm5fnHrFtQVRg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73C87107ACE6;
        Tue, 19 Jan 2021 15:23:19 +0000 (UTC)
Received: from bfoster (ovpn-114-23.rdu2.redhat.com [10.10.114.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C656B6A914;
        Tue, 19 Jan 2021 15:23:18 +0000 (UTC)
Date:   Tue, 19 Jan 2021 10:23:17 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        avi@scylladb.com, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 04/11] xfs: remove the buffered I/O fallback assert
Message-ID: <20210119152317.GD1646807@bfoster>
References: <20210118193516.2915706-1-hch@lst.de>
 <20210118193516.2915706-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118193516.2915706-5-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 18, 2021 at 08:35:09PM +0100, Christoph Hellwig wrote:
> The iomap code has been designed from the start not to do magic fallback,
> so remove the assert in preparation for further code cleanups.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  fs/xfs/xfs_file.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index ae7313ccaa11ed..97836ec53397d4 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -610,12 +610,6 @@ xfs_file_dio_write(
>  out:
>  	if (iolock)
>  		xfs_iunlock(ip, iolock);
> -
> -	/*
> -	 * No fallback to buffered IO after short writes for XFS, direct I/O
> -	 * will either complete fully or return an error.
> -	 */
> -	ASSERT(ret < 0 || ret == count);
>  	return ret;
>  }
>  
> -- 
> 2.29.2
> 

