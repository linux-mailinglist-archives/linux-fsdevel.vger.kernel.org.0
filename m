Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF51547522
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jun 2022 16:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbiFKOA5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Jun 2022 10:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbiFKOA4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Jun 2022 10:00:56 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012EF225;
        Sat, 11 Jun 2022 07:00:54 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r71so1716115pgr.0;
        Sat, 11 Jun 2022 07:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c9HBwLp0Uv5MjgxnDuQRISysx2V5J/58czPWYFl7Y+c=;
        b=J5ILuXUYWMfQjDH4S2msyhgkPRceCZoVKL6RHwfqAlOBIL3InHqK7wcsqLhDuwhGTZ
         GsjxoYTI3nxq09rAthVavpFmZpRa+WedvYuXMvFelYFG3anGgzlvOOBCY+ZykdsLpO47
         h1m8c9Tcc7+0Lauceew5EJJAFiqE3YeTfZNkBsc29H0tpyHmPqrWyRoJ32cuqoshLtVO
         zgGt03epVWoeR0d70Oj2+9baQg1u7RWDjy9RJ4Y+9prhr5JI7fEHU/Z0P83Aevjfpsvr
         GduSckWxvPbVquHtRFul5qZ4pcxW88Gt5KPQHgjN1kPTnzQ1hujOcnEWnAZ9NFOac9S3
         EWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=c9HBwLp0Uv5MjgxnDuQRISysx2V5J/58czPWYFl7Y+c=;
        b=2HMfCdnpZEHbdIsN0lQdqQf0431GtzLwpapNpYsxdg4hwHn09G40qSo/SEha1i+r07
         XV9dx87s7n1G8b5sJtr6GWEn7cHOL4oAcuCHkudjmUQk1VY+kfnvrgU2Rh4I1M/Af9hN
         lM/GBVZLzm9+MkcGDcvld4MmuzoWAbK1fEbnsraLrQb9Uj7SwG4rQwyLYmXu0GczcfJ1
         +YmX244gu+Ei+ntAe578jjKVfoJ9LR3T7rZxyy6bQ49d2dR7RGWxSIKbRxNu0nIKoXh3
         Xfq0PYMaIQrDoLwADQ4bgkIAVESXlNs/fi67hltBr6I/AXGKfJDlThQ5v9aCe7brH1/k
         lvzQ==
X-Gm-Message-State: AOAM532qz+EYjB4vOg+rhtFNIvmT96DdcG0twRexDo4WR00NtLzSGa+1
        SjXlcFK251Z4J7OniAEPFxc=
X-Google-Smtp-Source: ABdhPJx8aXzG7lARTjf0DGMNWJ7cU2i9+ckERmOuVpIwDU+ICn1bZ2jiI0zO6THloqk9kmx74bkHfg==
X-Received: by 2002:a63:2a0c:0:b0:3fc:9b04:541d with SMTP id q12-20020a632a0c000000b003fc9b04541dmr44653939pgq.546.1654956054512;
        Sat, 11 Jun 2022 07:00:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g10-20020a170902d5ca00b00163d4dc6e95sm1528126plh.307.2022.06.11.07.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 07:00:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 11 Jun 2022 07:00:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Gao Xiang <xiang@kernel.org>, linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net, devel@lists.orangefs.org,
        linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mainline build failure due to 6c77676645ad ("iov_iter: Fix
 iter_xarray_get_pages{,_alloc}()")
Message-ID: <20220611140052.GA288528@roeck-us.net>
References: <YqRyL2sIqQNDfky2@debian>
 <YqSGv6uaZzLxKfmG@zeniv-ca.linux.org.uk>
 <YqSMmC/UuQpXdxtR@zeniv-ca.linux.org.uk>
 <YqSQ++8UnEW0AJ2y@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqSQ++8UnEW0AJ2y@zeniv-ca.linux.org.uk>
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

On Sat, Jun 11, 2022 at 12:56:27PM +0000, Al Viro wrote:
> On Sat, Jun 11, 2022 at 12:37:44PM +0000, Al Viro wrote:
> > On Sat, Jun 11, 2022 at 12:12:47PM +0000, Al Viro wrote:
> > 
> > 
> > > At a guess, should be
> > > 	return min((size_t)nr * PAGE_SIZE - offset, maxsize);
> > > 
> > > in both places.  I'm more than half-asleep right now; could you verify that it
> > > (as the last lines of both iter_xarray_get_pages() and iter_xarray_get_pages_alloc())
> > > builds correctly?
> > 
> > No, I'm misreading it - it's unsigned * unsigned long - unsigned vs. size_t.
> > On arm it ends up with unsigned long vs. unsigned int; functionally it *is*
> > OK (both have the same range there), but it triggers the tests.  Try 
> > 
> > 	return min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
> > 
> > there (both places).
> 
> The reason we can't overflow on multiplication there, BTW, is that we have
> nr <= count, and count has come from weirdly open-coded
> 	DIV_ROUND_UP(size + offset, PAGE_SIZE)

That is often done to avoid possible overflows. Is size + offset
guaranteed to be smaller than ULONG_MAX ?

Guenter

> IMO we'd better make it explicit, so how about the following:
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index dda6d5f481c1..150dbd314d25 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1445,15 +1445,7 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
>  	offset = pos & ~PAGE_MASK;
>  	*_start_offset = offset;
>  
> -	count = 1;
> -	if (size > PAGE_SIZE - offset) {
> -		size -= PAGE_SIZE - offset;
> -		count += size >> PAGE_SHIFT;
> -		size &= ~PAGE_MASK;
> -		if (size)
> -			count++;
> -	}
> -
> +	count = DIV_ROUND_UP(size + offset, PAGE_SIZE);
>  	if (count > maxpages)
>  		count = maxpages;
>  
> @@ -1461,7 +1453,7 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
>  	if (nr == 0)
>  		return 0;
>  
> -	return min(nr * PAGE_SIZE - offset, maxsize);
> +	return min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
>  }
>  
>  /* must be done on non-empty ITER_IOVEC one */
> @@ -1607,15 +1599,7 @@ static ssize_t iter_xarray_get_pages_alloc(struct iov_iter *i,
>  	offset = pos & ~PAGE_MASK;
>  	*_start_offset = offset;
>  
> -	count = 1;
> -	if (size > PAGE_SIZE - offset) {
> -		size -= PAGE_SIZE - offset;
> -		count += size >> PAGE_SHIFT;
> -		size &= ~PAGE_MASK;
> -		if (size)
> -			count++;
> -	}
> -
> +	count = DIV_ROUND_UP(size + offset, PAGE_SIZE);
>  	p = get_pages_array(count);
>  	if (!p)
>  		return -ENOMEM;
> @@ -1625,7 +1609,7 @@ static ssize_t iter_xarray_get_pages_alloc(struct iov_iter *i,
>  	if (nr == 0)
>  		return 0;
>  
> -	return min(nr * PAGE_SIZE - offset, maxsize);
> +	return min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
>  }
>  
>  ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
