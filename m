Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1FE1109FB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 14:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfKZN71 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 08:59:27 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2520 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727379AbfKZN71 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:59:27 -0500
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 100ED841153C19D8EF22;
        Tue, 26 Nov 2019 21:59:22 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 26 Nov 2019 21:59:21 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 26 Nov 2019 21:59:21 +0800
Date:   Tue, 26 Nov 2019 22:01:38 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
CC:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2] posix_acl: fix memleak when set posix acl.
Message-ID: <20191126140138.GA228491@architecture4>
References: <20191126133809.2082-1-zhangxiaoxu5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191126133809.2082-1-zhangxiaoxu5@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme715-chm.china.huawei.com (10.1.199.111) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Xiaoxu,

On Tue, Nov 26, 2019 at 09:38:09PM +0800, Zhang Xiaoxu wrote:
> When set posix acl, it maybe call posix_acl_update_mode in some
> filesystem, eg. ext4. It may set acl to NULL, so, we can't free
> the acl which allocated in posix_acl_xattr_set.
> 
> Use an temp value to store the acl address for posix_acl_release.
> 
> Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
> ---
>  fs/posix_acl.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index 84ad1c90d535..0a359d06274c 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -882,7 +882,7 @@ posix_acl_xattr_set(const struct xattr_handler *handler,
>  		    const char *name, const void *value,
>  		    size_t size, int flags)
>  {
> -	struct posix_acl *acl = NULL;
> +	struct posix_acl *acl = NULL, *p = NULL;
>  	int ret;
>  
>  	if (value) {
> @@ -890,8 +890,15 @@ posix_acl_xattr_set(const struct xattr_handler *handler,
>  		if (IS_ERR(acl))
>  			return PTR_ERR(acl);
>  	}
> +
> +	/*
> +	 * when call set_posix_acl, posix_acl_update_mode may set acl
> +	 * to NULL,use temporary variables p for posix_acl_release.
> +	 */
> +	p = acl;
>  	ret = set_posix_acl(inode, handler->flags, acl);

IMO, variable acl in this function won't be affected, yes?
Am I missing something?

Thanks,
Gao Xiang

> -	posix_acl_release(acl);
> +
> +	posix_acl_release(p);
>  	return ret;
>  }
>  
> -- 
> 2.17.2
> 
