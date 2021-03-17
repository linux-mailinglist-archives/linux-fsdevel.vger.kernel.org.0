Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6334633E7C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 04:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhCQDja (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 23:39:30 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14358 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhCQDjD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 23:39:03 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F0bSP2vYsz909p;
        Wed, 17 Mar 2021 11:37:09 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Wed, 17 Mar 2021
 11:38:58 +0800
Subject: Re: [PATCH] Revert "libfs: fix error cast of negative value in
 simple_attr_write()"
To:     <m.malygin@yadro.com>, <linux-fsdevel@vger.kernel.org>
CC:     <r.bolshakov@yadro.com>, <linux@yadro.com>
References: <20210316204939.39812-1-m.malygin@yadro.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <da484350-8f38-0e8b-70aa-6cd2f240d574@hisilicon.com>
Date:   Wed, 17 Mar 2021 11:38:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210316204939.39812-1-m.malygin@yadro.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Mikhail,

On 2021/3/17 4:49, m.malygin@yadro.com wrote:
> From: Mikhail Malygin <m.malygin@yadro.com>
> 
> This reverts commit 488dac0c9237647e9b8f788b6a342595bfa40bda.
> 
> An established and documented [1] way of of configuring unlimited number of failures in fault-injection framework is to write -1:
> 
> - /sys/kernel/debug/fail*/times:
> 
>  specifies how many times failures may happen at most.
>  A value of -1 means "no limit".
> 
> Commit 488dac0c92 inadverently breaks that.
> 
> 1. https://www.kernel.org/doc/Documentation/fault-injection/fault-injection.txt

a simple revert can address this issue, but i don't think it's reasonable to directly cast the negative value.

considering attr->set() callback receives a value of u64, it's hard for the upper users
to know whether it's casted or not.

> 
> Signed-off-by: Mikhail Malygin <m.malygin@yadro.com>
> Signef-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> ---
>  fs/libfs.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index e2de5401abca..9bea71111299 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -961,7 +961,7 @@ ssize_t simple_attr_write(struct file *file, const char __user *buf,
>  			  size_t len, loff_t *ppos)
>  {
>  	struct simple_attr *attr;
> -	unsigned long long val;
> +	u64 val;
>  	size_t size;
>  	ssize_t ret;
>  
> @@ -979,9 +979,7 @@ ssize_t simple_attr_write(struct file *file, const char __user *buf,
>  		goto out;
>  
>  	attr->set_buf[size] = '\0';
> -	ret = kstrtoull(attr->set_buf, 0, &val);
> -	if (ret)
> -		goto out;
> +	val = simple_strtoll(attr->set_buf, NULL, 0);

simple_strtoll() is deprecated and has unexpected results[1],
use kstrtoll() instead.

[1] https://github.com/torvalds/linux/blob/master/Documentation/process/deprecated.rst#simple_strtol-simple_strtoll-simple_strtoul-simple_strtoull

Thanks,
Yicong

>  	ret = attr->set(attr->data, val);
>  	if (ret == 0)
>  		ret = len; /* on success, claim we got the whole input */
> 

