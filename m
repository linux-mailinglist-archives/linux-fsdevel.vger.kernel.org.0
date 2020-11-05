Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04FD2A74F3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Nov 2020 02:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732782AbgKEBdq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 20:33:46 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7591 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731131AbgKEBdq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 20:33:46 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CRQyp4Cb7zLpG5;
        Thu,  5 Nov 2020 09:33:38 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.238) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Thu, 5 Nov 2020
 09:33:34 +0800
Subject: Re: [PATCH] fuse: check whether fuse_request_alloc returns NULL in
 fuse_simple_request
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
To:     <miklos@szeredi.hu>, <mszeredi@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        linfeilong <linfeilong@huawei.com>,
        lihaotian <lihaotian9@huawei.com>
References: <ffefa3f4-4090-f7dd-97d4-27b8a8cb262f@huawei.com>
Message-ID: <b99b141d-acb8-954e-c932-7d7f402db9b3@huawei.com>
Date:   Thu, 5 Nov 2020 09:33:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <ffefa3f4-4090-f7dd-97d4-27b8a8cb262f@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.238]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ping ...

On 2020/10/22 21:13, Zhiqiang Liu wrote:
> 
> In fuse_simple_request func, we will call fuse_request_alloc func to alloc
> one request from fuse_req_cachep when args->force is true. However, the
> return value of fuse_request_alloc func is not checked whether it is NULL.
> If allocating request fails, access-NULL-pointer problem will occur.
> 
> Here, we check the return value of fuse_request_alloc func.
> 
> Fixes: 7213394c4e18 ("fuse: simplify request allocation")
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> Signed-off-by: Haotian Li <lihaotian9@huawei.com>
> ---
>  fs/fuse/dev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 02b3c36b3676..f7dd33ae8e31 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -481,6 +481,8 @@ ssize_t fuse_simple_request(struct fuse_conn *fc, struct fuse_args *args)
>  	if (args->force) {
>  		atomic_inc(&fc->num_waiting);
>  		req = fuse_request_alloc(GFP_KERNEL | __GFP_NOFAIL);
> +		if (!req)
> +			return -ENOMEM;
> 
>  		if (!args->nocreds)
>  			fuse_force_creds(fc, req);
> 

