Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025E737FB49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 18:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbhEMQOV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 12:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbhEMQOJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 12:14:09 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD6CC061756
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 May 2021 09:12:59 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id c10so10310343qtx.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 May 2021 09:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c3FwvvgxpK8Jgr/cfoaMZxB/tNnCRMPVSiFd4uKGvlQ=;
        b=MADfEPYf8G6gf9l1Gqm6w23OgPrQuI2bxxipGlcCPSPd44+7+DzuPS1pzH2iWgT+zn
         g0l0Kujhrg6t/Ex9b5j3Bj2W31aY5m/cGA22wYeq4g4Fs+5tr51eUzo8GE32RKHy3tqs
         ZUR2lUlGtt2nb1daWEbmScvkyl8W0QLZHqCf+7VI4FqhJ8ysakKTz3uwUKW84pK2Es+Y
         PhjNqocQaILOqO3NUastr7Mjdg9lJyWJ0bTmmM5DB+fua4qZxA7yuFnJblH6b56j19YG
         C0B7Jg1jnHZHxF6pjL3qHU3Qlum0+j2AIhktMMsVfmuDFDeZLU2YGUNbGiSN/Uozgvsz
         l+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c3FwvvgxpK8Jgr/cfoaMZxB/tNnCRMPVSiFd4uKGvlQ=;
        b=ggpS730wnjfnflvXgOVsbmZMz9/r2++N+Nh7DSHfBzM3hhcEMadU32Fq9wmJm7xn2X
         ys1cbfJ6q8lJFfKXdUQ7xs8uB0D1SaaER9MJlSuFguymlV9vKLGqrTR+u3nwCZyKvlOA
         CKtoFTliEbBMnHKYXfl0Wi37f+9Ne6wsTJHlDdOa5T+tqrwC7acbd0RkbmYnCF6z74Co
         YKsIeMt8yQqRP3szYwk9DZkXGyRvHRJ3PYMW8seGUJ0Hi4wUtsE47ugYQjc5QTFk3vQg
         okzRhpHAF2FGqhKzvDhE6nrmxHyyn/Kf9d0v2URppYeLO4KbEeKnVJ+LAXzCZVX7JRwv
         xpJw==
X-Gm-Message-State: AOAM533Mdfgm0TLoiJGgdZkQdi44kJCTYtBGfNKLJtgK00pBTilJnGgx
        sjDSBFFXT3v9qFwvS60+YCjo6Q==
X-Google-Smtp-Source: ABdhPJwx+wWD/0jLrnlCyRW0mf+sBX8loZEaAwXC0cHHBnwlQepFTMFpYKnQX1V8z6efSko/OuvKbQ==
X-Received: by 2002:ac8:5691:: with SMTP id h17mr39092410qta.185.1620922377413;
        Thu, 13 May 2021 09:12:57 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d1::1214? ([2620:10d:c091:480::1:7c1f])
        by smtp.gmail.com with ESMTPSA id h7sm2557702qtj.35.2021.05.13.09.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 09:12:56 -0700 (PDT)
Subject: Re: [PATCH] sysctl: Limit the size of I/Os to PAGE_SIZE
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-abi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
References: <20210513160649.2280429-1-willy@infradead.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <47a34aa5-ad1a-6259-d9cb-f85f314f9ffb@toxicpanda.com>
Date:   Thu, 13 May 2021 12:12:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210513160649.2280429-1-willy@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/13/21 12:06 PM, Matthew Wilcox (Oracle) wrote:
> We currently allow a read or a write that is up to KMALLOC_MAX_SIZE.
> This has caused problems when cat decides to do a 64kB read and
> so we allocate a 64kB buffer for the sysctl handler to store into.
> The immediate problem was fixed by switching to kvmalloc(), but it's
> ridiculous to allocate so much memory to read what is likely to be a
> few bytes.
> 
> sysfs limits reads and writes to PAGE_SIZE, and I feel we should do the
> same for sysctl.  The largest sysctl anyone's been able to come up with
> is 433 bytes for /proc/sys/dev/cdrom/info
> 
> This will allow simplifying the BPF sysctl code later, but I'll leave
> that for someone who understands it better.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   fs/proc/proc_sysctl.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index dea0f5ee540c..a97a8a4ff270 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -562,11 +562,14 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
>   	if (!table->proc_handler)
>   		goto out;
>   
> -	/* don't even try if the size is too large */
> +	/* reads may return short values; large writes must fail now */
> +	if (count >= PAGE_SIZE) {
> +		if (write)
> +			goto out;
> +		count = PAGE_SIZE;
> +	}
>   	error = -ENOMEM;
> -	if (count >= KMALLOC_MAX_SIZE)
> -		goto out;
> -	kbuf = kvzalloc(count + 1, GFP_KERNEL);
> +	kbuf = kmalloc(PAGE_SIZE, GFP_KERNEL);
>   	if (!kbuf)
>   		goto out;
>   

Below here we have

kbuf[count] = '\0';

with will overflow with this patch.  So maybe instead we do

if (count >= PAGE_SIZE)
	count = PAGE_SIZE - 1;
kbuf = kmalloc(count);

and that solves your problem and keeps us from overflowing.  Thanks,

Josef
