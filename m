Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3886A1D317A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 15:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgENNjr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 09:39:47 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53388 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgENNjq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 09:39:46 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200514133945euoutp02e1adeb5d7ffa34df45e1efc4f31e6025~O6LWbtGpN1620016200euoutp02Z
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2020 13:39:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200514133945euoutp02e1adeb5d7ffa34df45e1efc4f31e6025~O6LWbtGpN1620016200euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1589463585;
        bh=fWx0YMUp/JMtvmNqrUDqO8Zb5vgF1GKtXhH/LVX0fYY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=HLWCLjI/770gPJMadpcWM3NeSxssOPuLiZmRwF7UbRcpTNMrihfvWd0ocx8x59R/r
         qMLquXMgzuJyLKRnlDUbjeqF7b05d4mhOLebLtoQqdXomOfRfbwR0m5BGA7V3W5BnA
         M1ut1ZcehuoaV/FnDSrkyaoZr6zvO7uo+uOrLZ9E=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200514133944eucas1p1c83134058526c09d938d5a3035abae7d~O6LWPESKz1865318653eucas1p1Q;
        Thu, 14 May 2020 13:39:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 97.38.61286.02A4DBE5; Thu, 14
        May 2020 14:39:44 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200514133944eucas1p2fb43685052347ab281924ef91a9538aa~O6LVtPLQ12683826838eucas1p2H;
        Thu, 14 May 2020 13:39:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200514133944eusmtrp1c94ae43e151473eaf211964d0f36f374~O6LVstZuV0296802968eusmtrp1L;
        Thu, 14 May 2020 13:39:44 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-5a-5ebd4a206a68
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C6.B2.07950.02A4DBE5; Thu, 14
        May 2020 14:39:44 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200514133944eusmtip1ad25d7e2251d2ea96e578cbfc820a524~O6LVepM9E1597315973eusmtip1N;
        Thu, 14 May 2020 13:39:44 +0000 (GMT)
Subject: Re: [PATCH 12/20] omapfb: get rid of pointless access_ok() calls
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <8e349e00-817f-6c3e-82db-ce4c1f72bada@samsung.com>
Date:   Thu, 14 May 2020 15:39:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200509234557.1124086-12-viro@ZenIV.linux.org.uk>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7djP87oKXnvjDNZ/t7TYs/cki8XlXXPY
        LB71vWW3OP/3OKsDi8eJGb9ZPD5vkvPY9OQtUwBzFJdNSmpOZllqkb5dAlfGx1P3GAtaOSpO
        3vvA0sB4na2LkZNDQsBEYtGjo8xdjFwcQgIrGCV6bp5jAUkICXxhlHjVbg2R+Mwosb1rFTNM
        x8JF69khEssZJf5uvM8I4bxllPjRvYgRpEpYwFPi59Z/YB0iAqoSd06dYQKxmQUKJTbe+QpW
        wyZgJTGxfRWYzStgJ3Ho9Tawehag+lm39oPZogIREp8eHGaFqBGUODnzCdh5nAIOEr2fW9kg
        ZopL3HoyH2q+vMT2t3PA/pEQ6GaXON/1ggXibBeJvk+HoGxhiVfHt7BD2DISpyf3sEA0rAN6
        p+MFVPd2Ronlk/9Bg8la4s65X0A2B9AKTYn1u/Qhwo4SXaufMYKEJQT4JG68FYQ4gk9i0rbp
        zBBhXomONiGIajWJDcs2sMGs7dq5knkCo9IsJK/NQvLOLCTvzELYu4CRZRWjeGppcW56arFh
        Xmq5XnFibnFpXrpecn7uJkZgSjn97/inHYxfLyUdYhTgYFTi4bW4tTtOiDWxrLgy9xCjBAez
        kgiv33qgEG9KYmVValF+fFFpTmrxIUZpDhYlcV7jRS9jhQTSE0tSs1NTC1KLYLJMHJxSDYy2
        f65MWWhVPfd2sGDy5p3q8z89Et3au/iWm+iHb9O7/vJllopGfF+2rnNNsdBni/+Ln52dqHVs
        ZfrxXXbCAj94r/OG+7l941EO+s4fIlGQ3f1sjYfj5nMrmKZE79kfs9mrW9Du+RoFTZssx+Jp
        OvwlAW3JuYfutJo7nAvzdpFfN8vI84G/no4SS3FGoqEWc1FxIgAPxDKuJQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xu7oKXnvjDGY2S1js2XuSxeLyrjls
        Fo/63rJbnP97nNWBxePEjN8sHp83yXlsevKWKYA5Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLP
        yMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j46l7jAWtHBUn731gaWC8ztbFyMkhIWAisXDR
        evYuRi4OIYGljBLzui6wdDFyACVkJI6vL4OoEZb4c62LDaLmNaPEzPk32UESwgKeEj+3/mMG
        sUUEVCXunDrDBGIzCxRKtE/9zgLR8I1R4mnPMbAiNgEriYntqxhBbF4BO4lDr7eBxVmAmmfd
        2g9miwpESBzeMQuqRlDi5MwnLCA2p4CDRO/nVjaIBeoSf+ZdYoawxSVuPZkPtVheYvvbOcwT
        GIVmIWmfhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiMoW3Hfm7Zwdj1
        LvgQowAHoxIPr8Wt3XFCrIllxZW5hxglOJiVRHj91gOFeFMSK6tSi/Lji0pzUosPMZoCPTeR
        WUo0OR8Y33kl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhiX8nuE
        lJx49rehIpFNtFAxYt9K4+qARzzfpr3h1FsnIKq5lk9fedpuf8v/2ktnnTjTbSXx9+cJz88W
        CkLtgjyH/P2b7EoyLmyLy2h9/oal5oOUQPiqSdIPn9ZIdz366Ts1fLU3t9uRb7l9y9Rufewv
        WDHzLWNg3q8FOwuy58T5TUw6veGmEosSS3FGoqEWc1FxIgC/UVHgtwIAAA==
X-CMS-MailID: 20200514133944eucas1p2fb43685052347ab281924ef91a9538aa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200509234608eucas1p13a673239d8145e2dfd12d0ecc98a4cca
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200509234608eucas1p13a673239d8145e2dfd12d0ecc98a4cca
References: <20200509234124.GM23230@ZenIV.linux.org.uk>
        <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
        <CGME20200509234608eucas1p13a673239d8145e2dfd12d0ecc98a4cca@eucas1p1.samsung.com>
        <20200509234557.1124086-12-viro@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/10/20 1:45 AM, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> address is passed only to copy_to_user()
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c b/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
> index 56995f44e76d..f40be68d5aac 100644
> --- a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
> +++ b/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
> @@ -482,9 +482,6 @@ static int omapfb_memory_read(struct fb_info *fbi,
>  	if (!display || !display->driver->memory_read)
>  		return -ENOENT;
>  
> -	if (!access_ok(mr->buffer, mr->buffer_size))
> -		return -EFAULT;
> -
>  	if (mr->w > 4096 || mr->h > 4096)
>  		return -EINVAL;
>  
> 

