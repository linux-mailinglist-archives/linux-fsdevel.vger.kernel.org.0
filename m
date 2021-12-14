Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2AFA473DE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Dec 2021 09:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhLNIA4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Dec 2021 03:00:56 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16805 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhLNIAz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Dec 2021 03:00:55 -0500
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JCrQL1vmVz91dX;
        Tue, 14 Dec 2021 16:00:10 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 16:00:53 +0800
Subject: Re: [PATCH -next] sysctl: returns -EINVAL when a negative value is
 passed to proc_doulongvec_minmax
To:     <mcgrof@kernel.org>, <keescook@chromium.org>, <yzaikin@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <yukuai3@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Baokun Li <libaokun1@huawei.com>
References: <20211209085635.1288737-1-libaokun1@huawei.com>
From:   "libaokun (A)" <libaokun1@huawei.com>
Message-ID: <34f34475-2025-ebb5-7f2e-1a069fcc2a44@huawei.com>
Date:   Tue, 14 Dec 2021 16:00:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20211209085635.1288737-1-libaokun1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ÔÚ 2021/12/9 16:56, Baokun Li Ð´µÀ:
> When we pass a negative value to the proc_doulongvec_minmax() function,
> the function returns 0, but the corresponding interface value does not
> change.
>
> we can easily reproduce this problem with the following commands:
>      `cd /proc/sys/fs/epoll`
>      `echo -1 > max_user_watches; echo $?; cat max_user_watches`
>
> This function requires a non-negative number to be passed in, so when
> a negative number is passed in, -EINVAL is returned.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>   kernel/sysctl.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 7f07b058b180..537d2f75faa0 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1149,10 +1149,9 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table,
>   					     sizeof(proc_wspace_sep), NULL);
>   			if (err)
>   				break;
> -			if (neg)
> -				continue;
> +
>   			val = convmul * val / convdiv;
> -			if ((min && val < *min) || (max && val > *max)) {
> +			if (neg || (min && val < *min) || (max && val > *max)) {
>   				err = -EINVAL;
>   				break;
>   			}

ping

