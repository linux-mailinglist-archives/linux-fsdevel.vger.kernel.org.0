Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5042E1AF5C1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 00:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgDRWzk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 18:55:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbgDRWzk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 18:55:40 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E5842072C
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2020 22:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587250539;
        bh=5m9YaqFXTzw6Js+p8N08wBdua5MaC4xad5htqkThn+o=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=L+ITSg6n+tEEwcJQYZle0SvFbX+7L7vtqvnhH9ya5bHYheiXDB2rYQ6TO6Shs3IfK
         +K4xB/VTZTUXEE86Grjxfwgzl5nrUwQLjNvXDtnL8szvkq57LZNqpFZS6opgI1Jlrr
         s6Pm1kKzNAjzi9B7G6d22ldYx6ik+vSC4qdnL7hM=
Received: by mail-ot1-f45.google.com with SMTP id z17so4759891oto.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2020 15:55:39 -0700 (PDT)
X-Gm-Message-State: AGi0PubYQcWXZjYAhigeNnixR2zxzKUcmEbRum7JFlV8XMhaE+9J+Zmh
        ZE5t0uhfvgzkgWUkBq81pVIlLCkzXngx23GfBa0=
X-Google-Smtp-Source: APiQypL4IP+kPd+ozM3vMWWiSqFGW+eUfgoCYUYvb0Bn7DXG5LHnXJzdz8hskrx23VsGkXGWDoxB3FuqXuLiYF1OM4w=
X-Received: by 2002:a05:6830:1b7a:: with SMTP id d26mr4358158ote.120.1587250538517;
 Sat, 18 Apr 2020 15:55:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5744:0:0:0:0:0 with HTTP; Sat, 18 Apr 2020 15:55:38
 -0700 (PDT)
In-Reply-To: <fd29fb6b-8c92-d4c1-a15e-4e33025175ea@sandeen.net>
References: <ef3cdac4-9967-a225-fb04-4dbb4c7037a9@sandeen.net>
 <abfc2cdf-0ff1-3334-da03-8fbcc6eda328@sandeen.net> <381e5327-618b-13ab-ebe5-175f99abf7db@sandeen.net>
 <CAKYAXd8f_4nodeTf8OHQvXCwzDSfGciw9FSd42dygeYK7A+5qw@mail.gmail.com>
 <9d3c760c-9b1d-b8e7-a24b-2d6f11975cf7@sandeen.net> <380a03f3-b7da-8b54-6350-c0a81bf7a58f@sandeen.net>
 <fd29fb6b-8c92-d4c1-a15e-4e33025175ea@sandeen.net>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sun, 19 Apr 2020 07:55:38 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-A5E4NFjoxuG3Y0uCVUFjZD6DjHo6j43ZYuXbUXcD+8A@mail.gmail.com>
Message-ID: <CAKYAXd-A5E4NFjoxuG3Y0uCVUFjZD6DjHo6j43ZYuXbUXcD+8A@mail.gmail.com>
Subject: Re: [PATCH 2/2 V2] exfat: truncate atimes to 2s granularity
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     fsdevel <linux-fsdevel@vger.kernel.org>,
        Namjae Jeon <namjae.jeon@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2020-04-19 2:06 GMT+09:00, Eric Sandeen <sandeen@sandeen.net>:
>
>
> On 4/18/20 11:40 AM, Eric Sandeen wrote:
>> On 4/18/20 11:04 AM, Eric Sandeen wrote:
>>> since access_time has no corresponding 10msIncrement field, my
>>> understanding was that it could only have a 2s granularity.
>>
>> Maybe your concern is whether the other _time fields should also be
>> truncated to 2s even though they have the _ms field?  I don't think so;
>> the
>> s_time_gran already limits in-core timestamp resolution to 10ms, which
>> will
>> be properly translated when the inode is written to disk.
>>
>> atime has a different granularity though, so s_time_gran doens't help and
>> we
>> must manually change it to 2s whenever we call something like
>> current_time(), which
>> only enforces the 10ms granularity.
>>
>> So for cases like this:
>>
>>  	generic_fillattr(inode, stat);
>> +	exfat_truncate_atime(&stat->atime);
>>
>> or this:
>>
>>  	inode->i_mtime = inode->i_atime = inode->i_ctime =
>>  		EXFAT_I(inode)->i_crtime = current_time(inode);
>> +	exfat_truncate_atime(&inode->i_atime);
>>
>> I think it's clearly the right thing to do; anything finer than 2s will be
>> thrown
>> away when the vfs inode atime is translated to the disk format, so we
>> should never
>> hold finer granularity in the in-memory vfs inode.
>>
>> However, in exfat_get_entry_time() maybe all we need to do is set
>> ts->tv_nsec to 0;
>> that might be clearer.
>
> so maybe this is better -
>
> diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
> index c8b33278d474..2c5629b4e7e6 100644
> --- a/fs/exfat/misc.c
> +++ b/fs/exfat/misc.c
> @@ -89,7 +89,7 @@ void exfat_get_entry_time(struct exfat_sb_info *sbi,
> struct timespec64 *ts,
>  		ts->tv_sec += time_ms / 100;
>  		ts->tv_nsec = (time_ms % 100) * 10 * NSEC_PER_MSEC;
>  	} else
> -		exfat_truncate_atime(ts);
> +		ts->tv_nsec = 0;
>
>  	if (tz & EXFAT_TZ_VALID)
>  		/* Adjust timezone to UTC0. */
>
>
> because the conversion should already limit tv_sec to a 2s granularity.
Right. I will update it and replace it with old one.
Thanks!
>
> -Eric
>
