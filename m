Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8DA5474E1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jun 2022 15:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbiFKNoE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Jun 2022 09:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiFKNoB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Jun 2022 09:44:01 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E002B4A4;
        Sat, 11 Jun 2022 06:44:00 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id f9so1522106plg.0;
        Sat, 11 Jun 2022 06:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ixh/tGjYEGtd9B0U4un+L2Dg2/GvxVifxx8JOO5/xxs=;
        b=dWFageSqD+a/p7/dg6peuXBetNvvozPq1OrZOQ/jnLrmOlYGPzNGQ4RjNm2jbazw9i
         u781rrcK5N+1rObNiGXHrWMqVQY7pZTTAMDXq7DNXEPeF453QBw6/bxOS0JTWBW4mEFL
         oUM/P6Tc2N9Ofg4sbBfsItn4mThyJNPYPK0dfcLnQTh5rjJPmndWQJuSTs7DAwaCi/Vx
         rL+jaeKda3xCTVgeOwll+wUPQ1XB4/3T0OO18jS1/nlZwt9iAYKwdDwzN6eMueoG9fyg
         LLwuRDA7jXNLhI6Pff6Xji5gCQ5vnnxkZEApvX0oXAyGKRCiRXSTKan8B5OV8LXdXJGh
         CGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Ixh/tGjYEGtd9B0U4un+L2Dg2/GvxVifxx8JOO5/xxs=;
        b=wXfDFrpYDnGpiJnabp8sN75w74M9E0Y8PzOb3H9hcO0MwIMY1UoXYS9gZgecAlipg/
         P4t2ad522G9Jmha+shE3ydjXSt585sVGVllOVzPEuRPMPcWiAI5fkFyuRblI/PFi09cE
         PCVEXLTQMaFfb6n8Z4hqM5dbAcpUVcfqyKEIZxhDo/1H/iUN+TDRAGQElxYbq3zMan52
         Bi0cyjOME63xd3YUimrMXVnN0pbh7M2iCTCqZJkAnIcHfU+8qrOqBsQo+rj6y0gyQvtB
         3yLKcTZM8EqDnmhq3sssAN9Hro4vN54l1WzEIzYuQVhS19tY8sUc1pNWNSjkl6PmU6Xw
         bPMA==
X-Gm-Message-State: AOAM530t+ot3f2XxpbZgzfbXzC/hnDSy1T3Q24Fw1FOOEtAXFy3QcckV
        1ioMKzn1A6Kfl1Ovmi5/H6j+Y3DvhqU=
X-Google-Smtp-Source: ABdhPJyVm1Qx3rpbnexbaPz3LjRNh5xdY5jWDRPJD5O1BPtSHpLAWd+II5ejGzWE9luF6mWKd4zRSA==
X-Received: by 2002:a17:902:9f96:b0:163:dc33:6b72 with SMTP id g22-20020a1709029f9600b00163dc336b72mr50033692plq.34.1654955039652;
        Sat, 11 Jun 2022 06:43:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a12-20020a1709027e4c00b00164097a779fsm1523377pln.147.2022.06.11.06.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 06:43:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 11 Jun 2022 06:43:57 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     David Howells <dhowells@redhat.com>
Cc:     jlayton@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Gao Xiang <xiang@kernel.org>, linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net, devel@lists.orangefs.org,
        linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iov_iter: Fix iter_xarray_get_pages{,_alloc}()
Message-ID: <20220611134357.GA278954@roeck-us.net>
References: <165476202136.3999992.433442175457370240.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165476202136.3999992.433442175457370240.stgit@warthog.procyon.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 09, 2022 at 09:07:01AM +0100, David Howells wrote:
> The maths at the end of iter_xarray_get_pages() to calculate the actual
> size doesn't work under some circumstances, such as when it's been asked to
> extract a partial single page.  Various terms of the equation cancel out
> and you end up with actual == offset.  The same issue exists in
> iter_xarray_get_pages_alloc().
> 
> Fix these to just use min() to select the lesser amount from between the
> amount of page content transcribed into the buffer, minus the offset, and
> the size limit specified.
> 
> This doesn't appear to have caused a problem yet upstream because network
> filesystems aren't getting the pages from an xarray iterator, but rather
> passing it directly to the socket, which just iterates over it.  Cachefiles
> *does* do DIO from one to/from ext4/xfs/btrfs/etc. but it always asks for
> whole pages to be written or read.
> 
> Fixes: 7ff5062079ef ("iov_iter: Add ITER_XARRAY")
> Reported-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Alexander Viro <viro@zeniv.linux.org.uk>
> cc: Dominique Martinet <asmadeus@codewreck.org>
> cc: Mike Marshall <hubcap@omnibond.com>
> cc: Gao Xiang <xiang@kernel.org>
> cc: linux-afs@lists.infradead.org
> cc: v9fs-developer@lists.sourceforge.net
> cc: devel@lists.orangefs.org
> cc: linux-erofs@lists.ozlabs.org
> cc: linux-cachefs@redhat.com
> cc: linux-fsdevel@vger.kernel.org
> ---
> 
>  lib/iov_iter.c |   20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 834e1e268eb6..814f65fd0c42 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1434,7 +1434,7 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
>  {
>  	unsigned nr, offset;
>  	pgoff_t index, count;
> -	size_t size = maxsize, actual;
> +	size_t size = maxsize;
>  	loff_t pos;
>  
>  	if (!size || !maxpages)
> @@ -1461,13 +1461,7 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
>  	if (nr == 0)
>  		return 0;
>  
> -	actual = PAGE_SIZE * nr;
> -	actual -= offset;
> -	if (nr == count && size > 0) {
> -		unsigned last_offset = (nr > 1) ? 0 : offset;
> -		actual -= PAGE_SIZE - (last_offset + size);
> -	}
> -	return actual;
> +	return min(nr * PAGE_SIZE - offset, maxsize);

This needs min_t to avoid a build error on 32-bit builds.

In file included from include/linux/kernel.h:26,
                 from include/linux/crypto.h:16,
                 from include/crypto/hash.h:11,
                 from lib/iov_iter.c:2:
lib/iov_iter.c: In function 'iter_xarray_get_pages':
include/linux/minmax.h:20:35: error: comparison of distinct pointer types lacks a cast [-Werror]
...
lib/iov_iter.c:1628:16: note: in expansion of macro 'min'
 1628 |         return min(nr * PAGE_SIZE - offset, maxsize);
      |                ^~~

Guenter
