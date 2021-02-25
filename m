Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968933252B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 16:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbhBYPrf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 10:47:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36857 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229890AbhBYPrH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 10:47:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614267940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YpCvlQYx6vhAoMX/ljEDh4+GeB6i/L4OzgR+3DRvI5g=;
        b=iZdsGnXmb6FzPOtkzIKCSA9/s+tuKmGgcv1IaGRx0joemCMyUq+fhU/aX0+e37TUlb1M8T
        lBn2EmDRT+2IT+yo1zGVjOwZFhhHfpOvLVOXyyt4GHO7ehSLcre6MEqI9QDkDbtFqLd79S
        94Qda9UWIDg0btsWg7J08dhPMfoxXIo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-aGYeJXbQO06hHWuoYqFm9Q-1; Thu, 25 Feb 2021 10:45:38 -0500
X-MC-Unique: aGYeJXbQO06hHWuoYqFm9Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8929100CCCB;
        Thu, 25 Feb 2021 15:45:36 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DADA5C224;
        Thu, 25 Feb 2021 15:45:34 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] direct-io: Using kmem_cache_zalloc() instead of kmem_cache_alloc() and memset()
References: <1614243581-50870-1-git-send-email-yang.lee@linux.alibaba.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 25 Feb 2021 10:46:15 -0500
In-Reply-To: <1614243581-50870-1-git-send-email-yang.lee@linux.alibaba.com>
        (Yang Li's message of "Thu, 25 Feb 2021 16:59:41 +0800")
Message-ID: <x4935xknoag.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Y, Yang,

Yang Li <yang.lee@linux.alibaba.com> writes:

> Fix the following coccicheck warning:
> ./fs/direct-io.c:1155:7-23: WARNING: kmem_cache_zalloc should be used
> for dio, instead of kmem_cache_alloc/memset
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  fs/direct-io.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index 0957e1b..6ec2935 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -1152,7 +1152,7 @@ static inline int drop_refcount(struct dio *dio)
>  	if (iov_iter_rw(iter) == READ && !count)
>  		return 0;
>  
> -	dio = kmem_cache_alloc(dio_cache, GFP_KERNEL);
> +	dio = kmem_cache_zalloc(dio_cache, GFP_KERNEL);
>  	if (!dio)
>  		return -ENOMEM;
>  	/*
> @@ -1160,8 +1160,6 @@ static inline int drop_refcount(struct dio *dio)
>  	 * performance regression in a database benchmark.  So, we take
>  	 * care to only zero out what's needed.
>  	 */
> -	memset(dio, 0, offsetof(struct dio, pages));
> -

You must have missed the comment just above this memset:

        /*
         * Believe it or not, zeroing out the page array caused a .5%
         * performance regression in a database benchmark.  So, we take
         * care to only zero out what's needed.
         */

That's referring to this part of the dio struct:

        /*
         * pages[] (and any fields placed after it) are not zeroed out at
         * allocation time.  Don't add new fields after pages[] unless you
         * wish that they not be zeroed.
         */
        union {
                struct page *pages[DIO_PAGES];  /* page buffer */
                struct work_struct complete_work;/* deferred AIO completion */
        };
} ____cacheline_aligned_in_smp;

Nacked-by: Jeff Moyer <jmoyer@redhat.com>

