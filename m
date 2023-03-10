Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13906B4486
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 15:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjCJOZF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 09:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjCJOYo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:24:44 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AFADDB2E;
        Fri, 10 Mar 2023 06:23:37 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PY7X85ntKzHvKK;
        Fri, 10 Mar 2023 22:21:28 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 22:23:35 +0800
Message-ID: <a9375f3c-bd8b-8d32-2fd2-32047005f9b5@huawei.com>
Date:   Fri, 10 Mar 2023 22:23:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] mm: hugetlb: move hugeltb sysctls to its own file
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
References: <20230309122011.61969-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230309122011.61969-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/3/9 20:20, Kefeng Wang wrote:
> This moves all hugetlb sysctls to its own file, also kill an
> useless hugetlb_treat_movable_handler() defination.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   include/linux/hugetlb.h |  8 -------
>   kernel/sysctl.c         | 32 --------------------------
>   mm/hugetlb.c            | 51 ++++++++++++++++++++++++++++++++++++++---
>   3 files changed, 48 insertions(+), 43 deletions(-)
> 

> +#ifdef CONFIG_SYSCTL
> +static void hugetlb_sysctl_init(void);

Hi Luis，this should add __init as it is called by hugetlb_init,
could you help to change it, or I could send a new patch.


> +#else
> +static inline void hugetlb_sysctl_init(void) { }
> +#endif
> +
>   static int __init hugetlb_init(void)
>   {
>   	int i;
> @@ -4257,6 +4263,7 @@ static int __init hugetlb_init(void)
>   
>   	hugetlb_sysfs_init();
>   	hugetlb_cgroup_file_init();
> +	hugetlb_sysctl_init();
>   
...
> +
> +static void hugetlb_sysctl_init(void)

ditto, sorry for the mistake.

Thanks.

> +{
> +	register_sysctl_init("vm", hugetlb_table);
> +}
>   #endif /* CONFIG_SYSCTL */
>   
>   void hugetlb_report_meminfo(struct seq_file *m)
