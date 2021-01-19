Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DFD2FBB22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 16:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390135AbhASP0u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 10:26:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42212 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390869AbhASPZY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 10:25:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611069836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a+cxKsMKCCjDUZToTcmQ9jZuDcH5xKSPCL0jMRb9jEE=;
        b=dxX+iSaL7BvmQm1ursKYWZRIHR7ZU7SfeSBgUV4cBAEG0XD7uMD+/o4Lo6HUCqQUIkxiNM
        5XI8TUL/qjAjhMR0Wf8RPQxr/icnq6KOZgLindbtAqHazpVwsITJtRLNkYDU6+ru6CQute
        sWveUSGeF4QPP8zcCT70zm68WNhYjFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-600-IAbgqDAXMxSsABLmqtGZlg-1; Tue, 19 Jan 2021 10:23:52 -0500
X-MC-Unique: IAbgqDAXMxSsABLmqtGZlg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A45471081B38;
        Tue, 19 Jan 2021 15:23:51 +0000 (UTC)
Received: from bfoster (ovpn-114-23.rdu2.redhat.com [10.10.114.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FAAE5D9FC;
        Tue, 19 Jan 2021 15:23:51 +0000 (UTC)
Date:   Tue, 19 Jan 2021 10:23:49 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        avi@scylladb.com
Subject: Re: [PATCH 08/11] iomap: rename the flags variable in __iomap_dio_rw
Message-ID: <20210119152349.GH1646807@bfoster>
References: <20210118193516.2915706-1-hch@lst.de>
 <20210118193516.2915706-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118193516.2915706-9-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 18, 2021 at 08:35:13PM +0100, Christoph Hellwig wrote:
> Rename flags to iomap_flags to make the usage a little more clear.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  fs/iomap/direct-io.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 933f234d5becd0..604103ab76f9c5 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -427,7 +427,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	size_t count = iov_iter_count(iter);
>  	loff_t pos = iocb->ki_pos;
>  	loff_t end = iocb->ki_pos + count - 1, ret = 0;
> -	unsigned int flags = IOMAP_DIRECT;
> +	unsigned int iomap_flags = IOMAP_DIRECT;
>  	struct blk_plug plug;
>  	struct iomap_dio *dio;
>  
> @@ -461,7 +461,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		if (iter_is_iovec(iter))
>  			dio->flags |= IOMAP_DIO_DIRTY;
>  	} else {
> -		flags |= IOMAP_WRITE;
> +		iomap_flags |= IOMAP_WRITE;
>  		dio->flags |= IOMAP_DIO_WRITE;
>  
>  		/* for data sync or sync, we need sync completion processing */
> @@ -483,7 +483,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  			ret = -EAGAIN;
>  			goto out_free_dio;
>  		}
> -		flags |= IOMAP_NOWAIT;
> +		iomap_flags |= IOMAP_NOWAIT;
>  	}
>  
>  	ret = filemap_write_and_wait_range(mapping, pos, end);
> @@ -514,7 +514,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  
>  	blk_start_plug(&plug);
>  	do {
> -		ret = iomap_apply(inode, pos, count, flags, ops, dio,
> +		ret = iomap_apply(inode, pos, count, iomap_flags, ops, dio,
>  				iomap_dio_actor);
>  		if (ret <= 0) {
>  			/* magic error code to fall back to buffered I/O */
> -- 
> 2.29.2
> 

