Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F061D319C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 15:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgENNpN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 09:45:13 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55278 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgENNpM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 09:45:12 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200514134510euoutp02b5d71372ffe28c6c8324688d249a60fe~O6QFQFS9X1957919579euoutp02D
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2020 13:45:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200514134510euoutp02b5d71372ffe28c6c8324688d249a60fe~O6QFQFS9X1957919579euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1589463910;
        bh=tk4F7XF4ZBxaM4OI15DVjYGiRANSFX5WWJmygI83Bi4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ohvYJh8wUMFuO9xBCZaHA3tbvl3MIuQLEGCIiuGo7fq8YLjxQ0s2W5TeMvt5JZnZK
         mvnruQpogBstCw0hFFH7CAunyRkqOtb3x2R4NUhawFog2fT7FsOU5umfTcTcGYWTRr
         BHPmXuPQsUdM3RLjSwfxE93EBOONqc/2PxKiTymE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200514134510eucas1p2cd7b8879584bac4797ed16bb0a2c065b~O6QFHKcBw1585815858eucas1p2S;
        Thu, 14 May 2020 13:45:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 32.9C.60698.66B4DBE5; Thu, 14
        May 2020 14:45:10 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200514134509eucas1p28834b8da955386c10df913d82582aadd~O6QEyNknz1584915849eucas1p2P;
        Thu, 14 May 2020 13:45:09 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200514134509eusmtrp25d9fc8e02f977e7cdf49b775b5380019~O6QExkvfx2085120851eusmtrp2o;
        Thu, 14 May 2020 13:45:09 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-9a-5ebd4b66ccf1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 70.57.08375.56B4DBE5; Thu, 14
        May 2020 14:45:09 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200514134509eusmtip2ece107089ea8b07d9cf9156d6178f88d~O6QEiT5Se0446204462eusmtip2u;
        Thu, 14 May 2020 13:45:09 +0000 (GMT)
Subject: Re: [PATCH 11/20] amifb: get rid of pointless access_ok() calls
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <6f89732b-fba9-a947-6c61-5d1680747f3b@samsung.com>
Date:   Thu, 14 May 2020 15:45:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200509234557.1124086-11-viro@ZenIV.linux.org.uk>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7djP87pp3nvjDK5+ZLHYs/cki8XlXXPY
        LB71vWW3OP/3OKsDi8eJGb9ZPD5vkvPY9OQtUwBzFJdNSmpOZllqkb5dAlfG0p9bGAtWcVdc
        6PjO1sA4kbOLkZNDQsBE4sibZqYuRi4OIYEVjBLd3XPYIJwvjBKT3lxlh3A+M0pMfDmJCaZl
        3sFlUC3LGSU6P7xlhnDeMkosbO1n7GLk4BAW8JD4vbcepEFEQFXizqkzYM3MAoUSG+98ZQSx
        2QSsJCa2rwKzeQXsJHbceMQCYrMA1f/73gZWLyoQIfHpwWFWiBpBiZMzn4DVcAo4SCw494IR
        Yqa4xK0n86Hmy0tsfzsH7B4JgX52iV9vVjNDXO0icfn1BKgPhCVeHd/CDmHLSPzfOZ8JomEd
        o8TfjhdQ3dsZJZZP/scGUWUtcefcLzaQz5gFNCXW79KHCDtKLH+6FuxhCQE+iRtvBSGO4JOY
        tG06M0SYV6KjTQiiWk1iw7INbDBru3auZJ7AqDQLyWuzkLwzC8k7sxD2LmBkWcUonlpanJue
        Wmycl1quV5yYW1yal66XnJ+7iRGYUk7/O/51B+O+P0mHGAU4GJV4eB9c3x0nxJpYVlyZe4hR
        goNZSYTXbz1QiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/xopexQgLpiSWp2ampBalFMFkmDk6p
        BsZ41et10p0yrfV+5k2WZx/9q7Zd8NS+uT88rb5506L/HgzbmitVfvbrvLderBmTanzxTcm0
        Yw6elk8b9APtPkmv/HNgyaNb1VcOfw09WNC1LXbjDO9/rLa33wpnnnJ11P3xY5FwPXfjp+Jw
        Qf7U6d/ieuZpNmnwcakdnD1t5kcB8ZxURfX3j5VYijMSDbWYi4oTAWfwInAlAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xe7qp3nvjDD5vNLLYs/cki8XlXXPY
        LB71vWW3OP/3OKsDi8eJGb9ZPD5vkvPY9OQtUwBzlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWe
        kYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G0p9bGAtWcVdc6PjO1sA4kbOLkZNDQsBEYt7B
        ZUxdjFwcQgJLGSW6jr1i72LkAErISBxfXwZRIyzx51oXG4gtJPCaUeLCYWmQEmEBD4nfe+tB
        wiICqhJ3Tp1hArGZBQol2qd+Z4EY+Y1RYsH1LmaQBJuAlcTE9lWMIDavgJ3EjhuPWEBsFqDm
        f9/bwJpFBSIkDu+YBVUjKHFy5hOwGk4BB4kF514wQixQl/gz7xIzhC0ucevJfKjF8hLb385h
        nsAoNAtJ+ywkLbOQtMxC0rKAkWUVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYPxsO/Zz8w7G
        SxuDDzEKcDAq8fBa3NodJ8SaWFZcmXuIUYKDWUmE1289UIg3JbGyKrUoP76oNCe1+BCjKdBz
        E5mlRJPzgbGdVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7NbUgtQimj4mDU6qBMf7H
        9Ltz6v0bp5e/38m+1jNWZ5dTUPBStUsGx53eFx5grT3GJux6WtGl6omYsqufzMstb38+eM1z
        e3HzHKmpX10sJsXdP7bDxZj9QoGKR+uq9Z9nsi+w6Dz+z4B7kUJT0fbXspw8m/Y4TNpx8eIJ
        IQaXT/+6+YVubphx7sR9LsUd4cb3mo4/OKvEUpyRaKjFXFScCADNsvlytQIAAA==
X-CMS-MailID: 20200514134509eucas1p28834b8da955386c10df913d82582aadd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200509234610eucas1p258be307cde10392b26c322354db78a9b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200509234610eucas1p258be307cde10392b26c322354db78a9b
References: <20200509234124.GM23230@ZenIV.linux.org.uk>
        <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
        <CGME20200509234610eucas1p258be307cde10392b26c322354db78a9b@eucas1p2.samsung.com>
        <20200509234557.1124086-11-viro@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Al,

On 5/10/20 1:45 AM, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> addresses passed only to get_user() and put_user()

This driver lacks checks for {get,put}_user() return values so it will
now return 0 ("success") even if {get,put}_user() fails.

Am I missing something?

> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  drivers/video/fbdev/amifb.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/video/fbdev/amifb.c b/drivers/video/fbdev/amifb.c
> index 20e03e00b66d..6062104f3afb 100644
> --- a/drivers/video/fbdev/amifb.c
> +++ b/drivers/video/fbdev/amifb.c
> @@ -1855,8 +1855,6 @@ static int ami_get_var_cursorinfo(struct fb_var_cursorinfo *var,
>  	var->yspot = par->crsr.spot_y;
>  	if (size > var->height * var->width)
>  		return -ENAMETOOLONG;
> -	if (!access_ok(data, size))
> -		return -EFAULT;
>  	delta = 1 << par->crsr.fmode;
>  	lspr = lofsprite + (delta << 1);
>  	if (par->bplcon0 & BPC0_LACE)
> @@ -1935,8 +1933,6 @@ static int ami_set_var_cursorinfo(struct fb_var_cursorinfo *var,
>  		return -EINVAL;
>  	if (!var->height)
>  		return -EINVAL;
> -	if (!access_ok(data, var->width * var->height))
> -		return -EFAULT;
>  	delta = 1 << fmode;
>  	lofsprite = shfsprite = (u_short *)spritememory;
>  	lspr = lofsprite + (delta << 1);
> 
 
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
