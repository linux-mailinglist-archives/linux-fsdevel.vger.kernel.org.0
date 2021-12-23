Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4920647DD7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 02:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242327AbhLWBlH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Dec 2021 20:41:07 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:33898 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239866AbhLWBlG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Dec 2021 20:41:06 -0500
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JKCZK02wHzcc0Q;
        Thu, 23 Dec 2021 09:40:41 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 23 Dec 2021 09:41:04 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 23 Dec 2021 09:41:04 +0800
Subject: Re: [PATCH] chardev: fix error handling in cdev_device_add()
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <logang@deltatee.com>,
        <dan.j.williams@intel.com>, <hans.verkuil@cisco.com>,
        <alexandre.belloni@free-electrons.com>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20211012130915.3426584-1-yangyingliang@huawei.com>
Message-ID: <1959fa74-b06c-b8bc-d14f-b71e5c4290ee@huawei.com>
Date:   Thu, 23 Dec 2021 09:41:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20211012130915.3426584-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ping...

On 2021/10/12 21:09, Yang Yingliang wrote:
> If dev->devt is not set, cdev_device_add() will not add the cdev,
> when device_add failed, cdev_del() is not needed, so delete cdev
> only when dev->devt is set.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 233ed09d7fda ("chardev: add helper function to register...")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>   fs/char_dev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/char_dev.c b/fs/char_dev.c
> index ba0ded7842a7..3f667292608c 100644
> --- a/fs/char_dev.c
> +++ b/fs/char_dev.c
> @@ -547,7 +547,7 @@ int cdev_device_add(struct cdev *cdev, struct device *dev)
>   	}
>   
>   	rc = device_add(dev);
> -	if (rc)
> +	if (rc && dev->devt)
>   		cdev_del(cdev);
>   
>   	return rc;
