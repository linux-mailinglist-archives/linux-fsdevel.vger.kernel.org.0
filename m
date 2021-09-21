Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112C0412A1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 02:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhIUA6y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 20:58:54 -0400
Received: from gateway20.websitewelcome.com ([192.185.63.14]:14214 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237413AbhIUA4y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 20:56:54 -0400
X-Greylist: delayed 1440 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Sep 2021 20:56:54 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 61AE7400D3741
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Sep 2021 18:48:40 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id STJqm2HjHK61iSTJqmBUOb; Mon, 20 Sep 2021 19:07:30 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OD4JC5dtfAt335bNgwNunS9YrQ3MNpy44kfHABxRQ6o=; b=iH6LhrBzbmbr/EZb1kGa+IQXkD
        0eSrjYHNtkzmpF+dd6X6ZB/hImNDBSTVCvlcfujKW/3VnrE6VFWT4DPr0iqNn3uIqYgf6XE2Ibsgm
        lIE3fQ0sdEKlqWYArxjBEu3y3tbLaseh92xrStdwAg1dwpYFSthYdH9gZK2sa48bueC+8fXx/Ahmh
        BsWfsgu9PKx0Jgv1nFcR2PPfmyuI7xe9BvhI1BDSHr5QJ2FvgUGqawKjLFRrirr+6+5KkHwA80cao
        j3LJSn0dbFNjZdma8pSzxVQheVPsnB6S8iZac2hEpGx3SrvvOz2VF1nTLTNbCYHcdBXQzE1zjHSKE
        bL03eMsQ==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:33914 helo=[192.168.15.9])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1mSTJq-000gZd-6d; Mon, 20 Sep 2021 19:07:30 -0500
Subject: Re: [PATCH] aio: Prefer struct_size over open coded arithmetic
To:     Len Baker <len.baker@gmx.com>, Benjamin LaHaise <bcrl@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210919094539.30589-1-len.baker@gmx.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <6cd35222-cc17-b3f5-dad4-ed540e0df79b@embeddedor.com>
Date:   Mon, 20 Sep 2021 19:11:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210919094539.30589-1-len.baker@gmx.com>
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
X-Exim-ID: 1mSTJq-000gZd-6d
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.9]) [187.162.31.110]:33914
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 25
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/19/21 04:45, Len Baker wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, use the struct_size() helper to do the arithmetic instead of the
> argument "size + size * count" in the kzalloc() function.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> 
> Signed-off-by: Len Baker <len.baker@gmx.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  fs/aio.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 51b08ab01dff..c2978c0b872c 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -659,8 +659,7 @@ static int ioctx_add_table(struct kioctx *ctx, struct mm_struct *mm)
>  		new_nr = (table ? table->nr : 1) * 4;
>  		spin_unlock(&mm->ioctx_lock);
> 
> -		table = kzalloc(sizeof(*table) + sizeof(struct kioctx *) *
> -				new_nr, GFP_KERNEL);
> +		table = kzalloc(struct_size(table, table, new_nr), GFP_KERNEL);
>  		if (!table)
>  			return -ENOMEM;
> 
> --
> 2.25.1
> 
