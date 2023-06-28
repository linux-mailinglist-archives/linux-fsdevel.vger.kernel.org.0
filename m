Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4147416B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 18:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjF1Qqd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 12:46:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58706 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231835AbjF1Qqb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687970741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9vOBIaytrYiPkaqMIJvuxkcnZSEVMg/kCzHHy7/59jY=;
        b=bmzj/2/UZZ2c8nvyrz7S4VuoBdHaYtTfy33LdXXc+3gSzSLEAtsHGhiQKvtrwI08P9GKnq
        ix6ugD3SFkdnj7FblnqucdPmeg8/0KxsUVtT+0XqK+WhJNwwyxH0WXLz+BY9algC8I/8SS
        55KLGdFeenThVh00l71cIfwPMAeQM+Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-NikTkMo9Ncix8VYrrcJkow-1; Wed, 28 Jun 2023 12:45:37 -0400
X-MC-Unique: NikTkMo9Ncix8VYrrcJkow-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1A20185A7A5;
        Wed, 28 Jun 2023 16:45:36 +0000 (UTC)
Received: from redhat.com (unknown [10.22.8.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 126A4F5CD4;
        Wed, 28 Jun 2023 16:45:36 +0000 (UTC)
Date:   Wed, 28 Jun 2023 11:45:34 -0500
From:   Bill O'Donnell <billodo@redhat.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     axboe@kernel.dk, song@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com, hch@infradead.org,
        djwong@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/7] block: add queue_logical_block_mask() and
 bdev_logical_block_mask()
Message-ID: <ZJxjrpbaKyX14yPq@redhat.com>
References: <20230628093500.68779-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628093500.68779-1-frank.li@vivo.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 05:34:54PM +0800, Yangtao Li wrote:
> Introduce queue_logical_block_mask() and bdev_logical_block_mask()
> to simplify code, which replace (queue_logical_block_size(q) - 1)
> and (bdev_logical_block_size(bdev) - 1).
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Looks fine.
Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>

> ---
>  include/linux/blkdev.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index ed44a997f629..0cc0d1694ef6 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1150,11 +1150,21 @@ static inline unsigned queue_logical_block_size(const struct request_queue *q)
>  	return retval;
>  }
>  
> +static inline unsigned int queue_logical_block_mask(const struct request_queue *q)
> +{
> +	return queue_logical_block_size(q) - 1;
> +}
> +
>  static inline unsigned int bdev_logical_block_size(struct block_device *bdev)
>  {
>  	return queue_logical_block_size(bdev_get_queue(bdev));
>  }
>  
> +static inline unsigned int bdev_logical_block_mask(struct block_device *bdev)
> +{
> +	return bdev_logical_block_size(bdev) - 1;
> +}
> +
>  static inline unsigned int queue_physical_block_size(const struct request_queue *q)
>  {
>  	return q->limits.physical_block_size;
> -- 
> 2.39.0
> 

