Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534AF412A02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 02:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbhIUAhv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 20:37:51 -0400
Received: from gateway23.websitewelcome.com ([192.185.49.218]:42158 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233096AbhIUAfv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 20:35:51 -0400
X-Greylist: delayed 1233 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Sep 2021 20:35:50 EDT
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id B82B65AB0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Sep 2021 19:13:48 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id STPwmFNriBvjySTPwmwV6N; Mon, 20 Sep 2021 19:13:48 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rC43D1q/Fpqld09/wg6gq0zwktyAt7L1OzENn3Bvg8g=; b=Rbx+WldhwvBXH/Es+i84gO7nK4
        xhaunjLemgYxJF41YiEYkZr5b0L2FbetCIHtYE2BoWoEkd1SpLXQerryMdzvCBKd5gR1Fk23806gt
        SG/UWujtSucxy/Jro+J6BYpM28UjAra1tMQI3oYevYp0uY/xt1r7X/F9jh2zJXCc5L6Sb0iT4VOzq
        zeciwVEm181eJlLV//Opy8hORo42OYOEuO9bX8ZqdTMHPqi5jDXYS+inQETnwkg1dapIobiP++PKQ
        cGF/OGlvt5ZeBLwo7CKfy5nGbEHOxCZnVPS0m6Fr1HvSyPqbckZMPf0uHFKkHu/XrrSgiIBYsAkGN
        q+0B8dUg==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:34200 helo=[192.168.15.9])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1mSTPw-000oJG-Bi; Mon, 20 Sep 2021 19:13:48 -0500
Subject: Re: [PATCH] writeback: prefer struct_size over open coded arithmetic
To:     Len Baker <len.baker@gmx.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210919094630.30668-1-len.baker@gmx.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <6bc45138-c3a5-9465-40cb-3db714e7706d@embeddedor.com>
Date:   Mon, 20 Sep 2021 19:17:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210919094630.30668-1-len.baker@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1mSTPw-000oJG-Bi
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.9]) [187.162.31.110]:34200
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 32
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/19/21 04:46, Len Baker wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> In this case this is not actually dynamic size: all the operands
> involved in the calculation are constant values. However it is best to
> refactor this anyway, just to keep the open-coded math idiom out of
> code.
> 
> So, use the struct_size() helper to do the arithmetic instead of the
> argument "size + count * size" in the kzalloc() function.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> 
> Signed-off-by: Len Baker <len.baker@gmx.com>
> ---
>  fs/fs-writeback.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 81ec192ce067..f7abff31e026 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -624,8 +624,8 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
>  	int nr;
>  	bool restart = false;
> 
> -	isw = kzalloc(sizeof(*isw) + WB_MAX_INODES_PER_ISW *
> -		      sizeof(struct inode *), GFP_KERNEL);
> +	isw = kzalloc(struct_size(isw, inodes, WB_MAX_INODES_PER_ISW),
> +		      GFP_KERNEL);


There is another instance at:

 569         isw = kzalloc(sizeof(*isw) + 2 * sizeof(struct inode *), GFP_ATOMIC);
 570         if (!isw)
 571                 return;

If you are finding these with the help of Coccinelle, please mention it
in the changelog text. :)

Thanks
--
Gustavo

>  	if (!isw)
>  		return restart;
> 
> --
> 2.25.1
> 
