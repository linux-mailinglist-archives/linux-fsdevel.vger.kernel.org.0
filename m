Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7865BC448
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 10:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiISI2n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 04:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiISI2h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:28:37 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BCB1E3E2;
        Mon, 19 Sep 2022 01:28:35 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MWHld514nz14QZQ;
        Mon, 19 Sep 2022 16:24:29 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 16:28:33 +0800
CC:     <andriy.shevchenko@intel.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, <linux-fsdevel@vger.kernel.org>,
        <viro@zeniv.linux.org.uk>, <akpm@linux-foundation.org>,
        <yangyicong@hisilicon.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libfs: fix negative value support in simple_attr_write()
To:     Eliav Farber <farbere@amazon.com>
References: <20220918135036.33595-1-farbere@amazon.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <6cb8667a-1b0a-bb24-cf8d-880431acf815@huawei.com>
Date:   Mon, 19 Sep 2022 16:28:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20220918135036.33595-1-farbere@amazon.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/9/18 21:50, Eliav Farber wrote:
> After commit 488dac0c9237 ("libfs: fix error cast of negative value in
> simple_attr_write()"), a user trying set a negative value will get a
> '-EINVAL' error, because simple_attr_write() was modified to use
> kstrtoull() which can handle only unsigned values, instead of
> simple_strtoll().
> 
> This breaks all the places using DEFINE_DEBUGFS_ATTRIBUTE() with format
> of a signed integer.
> 
> The u64 value which attr->set() receives is not an issue for negative
> numbers.
> The %lld and %llu in any case are for 64-bit value. Representing it as
> unsigned simplifies the generic code, but it doesn't mean we can't keep
> their signed value if we know that.
> 
> This change basically reverts the mentioned commit, but uses kstrtoll()
> instead of simple_strtoll() which is obsolete.
> 
> Fixes: 488dac0c9237 ("libfs: fix error cast of negative value in simple_attr_write()")

Thanks for fixing this.

Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>

Sorry for my lack of knowledge for the -1 usage.

Thanks.

> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>  fs/libfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 31b0ddf01c31..3bccd75815db 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1016,7 +1016,7 @@ ssize_t simple_attr_write(struct file *file, const char __user *buf,
>  		goto out;
>  
>  	attr->set_buf[size] = '\0';
> -	ret = kstrtoull(attr->set_buf, 0, &val);
> +	ret = kstrtoll(attr->set_buf, 0, &val);
>  	if (ret)
>  		goto out;
>  	ret = attr->set(attr->data, val);
> 
