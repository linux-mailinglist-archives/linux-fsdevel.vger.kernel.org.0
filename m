Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855302FED93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 15:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731731AbhAUOyc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 09:54:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60352 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731290AbhAUNe0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:34:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611235980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=12iaQxRicJBtk/goRWyLEa0IAVmcZ6kH+1xu6r4dq1Y=;
        b=IIHLDNtHYGJC1klMvjoDSZ9WavQyOmLMLM89cddLEgf3qDozszRIJC0i+iTYKK5TgYgZxA
        4qetZOCoUF9B0Srea4FB3+x2xIfIjzfeDj7k9pB3XXa6NEt/ZDyBAnCg2tYZi+WpQQ2lBs
        Bgbh+apWBgb9Qm4/YjiKkmx8czUlN1I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-3ThOr7cpNguDhInZTGgG0Q-1; Thu, 21 Jan 2021 08:32:58 -0500
X-MC-Unique: 3ThOr7cpNguDhInZTGgG0Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52BF4107ACE4;
        Thu, 21 Jan 2021 13:32:57 +0000 (UTC)
Received: from bfoster (ovpn-114-23.rdu2.redhat.com [10.10.114.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ADD7A5D9D5;
        Thu, 21 Jan 2021 13:32:56 +0000 (UTC)
Date:   Thu, 21 Jan 2021 08:32:54 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        avi@scylladb.com
Subject: Re: [PATCH 10/11] iomap: add a IOMAP_DIO_OVERWRITE_ONLY flag
Message-ID: <20210121133254.GA1793795@bfoster>
References: <20210121085906.322712-1-hch@lst.de>
 <20210121085906.322712-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121085906.322712-11-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 21, 2021 at 09:59:05AM +0100, Christoph Hellwig wrote:
> Add a flag to signal an only pure overwrites are allowed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Agreed that the explicit flag name is much more clear:

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  fs/iomap/direct-io.c  | 7 +++++++
>  include/linux/iomap.h | 8 ++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 947343730e2c93..65d32364345d22 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -485,6 +485,13 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		iomap_flags |= IOMAP_NOWAIT;
>  	}
>  
> +	if (dio_flags & IOMAP_DIO_OVERWRITE_ONLY) {
> +		ret = -EAGAIN;
> +		if (pos >= dio->i_size || pos + count > dio->i_size)
> +			goto out_free_dio;
> +		iomap_flags |= IOMAP_OVERWRITE_ONLY;
> +	}
> +
>  	ret = filemap_write_and_wait_range(mapping, pos, end);
>  	if (ret)
>  		goto out_free_dio;
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index be4e1e1e01e801..cfa20afd7d5b87 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -122,6 +122,7 @@ struct iomap_page_ops {
>  #define IOMAP_FAULT		(1 << 3) /* mapping for page fault */
>  #define IOMAP_DIRECT		(1 << 4) /* direct I/O */
>  #define IOMAP_NOWAIT		(1 << 5) /* do not block */
> +#define IOMAP_OVERWRITE_ONLY	(1 << 6) /* purely overwrites allowed */
>  
>  struct iomap_ops {
>  	/*
> @@ -262,6 +263,13 @@ struct iomap_dio_ops {
>   */
>  #define IOMAP_DIO_FORCE_WAIT	(1 << 0)
>  
> +/*
> + * Do not allocate blocks or zero partial blocks, but instead fall back to
> + * the caller by returning -EAGAIN.  Used to optimize direct I/O writes that
> + * are not aligned to the file system block size.
> +  */
> +#define IOMAP_DIO_OVERWRITE_ONLY	(1 << 1)
> +
>  ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
>  		unsigned int dio_flags);
> -- 
> 2.29.2
> 

