Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5277B3DB0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 04:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjI3Cpw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 22:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjI3Cpw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 22:45:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1701B6;
        Fri, 29 Sep 2023 19:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=sutjUDhTdDiAZXC/zVaX0ZtYjfFd9yMSNdgYvXTeOug=; b=v0RAgpBm5ZT2ZxQnZfMcFEHZ/d
        BiXDSjXPSB1g39XP6qRT1ye7gQL37dsA4SBC8Dc6b1rTtzCkKsBHVkD1JiitYqxRZexcSyrSe8rNi
        OfxiYfx6siWmgpv0frJEbLtj7OTgheaPCzObybCqPJQAqMuSsy6eJIt01w2wyhDg8kaDgIT+MqmI/
        +MmbYg+Bavpl1ZirM+m8I/jz1HPXm+xziggYgPOPZM4fmuhGkZMwZ8krSppXo9GaSRLQmvpdIkglf
        DoWWxyZUgQJ3YkEli1ePUDj0XxEyvOYMtoTLPvyGMiIyq3nyZqfycFnayCd1o3bdOBOazjrEEPnYy
        leSEulCw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qmPz8-008ppw-1G;
        Sat, 30 Sep 2023 02:45:38 +0000
Message-ID: <ca559807-8456-4ff7-9edd-003480437a93@infradead.org>
Date:   Fri, 29 Sep 2023 19:45:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fixed Kunit test warning message for 'fs' module
Content-Language: en-US
To:     Abhinav <singhabhinav9051571833@gmail.com>,
        akpm@linux-foundation.org, david@redhat.com, rppt@kernel.org,
        hughd@google.com, Liam.Howlett@Oracle.com, surenb@google.com,
        usama.anjum@collabora.com, wangkefeng.wang@huawei.com,
        ryan.roberts@arm.com, yuanchu@google.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        skhan@linuxfoundation.org
References: <20230928085311.938163-1-singhabhinav9051571833@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230928085311.938163-1-singhabhinav9051571833@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 9/28/23 01:53, Abhinav wrote:
> fs/proc/task_mmu : fix warning
> 
> All the caller of the function pagemap_scan_backout_range(...) are inside
> ifdef preprocessor which is checking for the macro
> 'CONFIG_TRANSPARENT_HUGEPAGE' is set or not. When it is not set the
> function doesn't have a caller and it generates a warning unused
> function.
> 
> Putting the whole function inside the preprocessor fixes this warning.
> 
> Signed-off-by: Abhinav <singhabhinav9051571833@gmail.com>

We have this patch:
  https://lore.kernel.org/all/20230927060257.2975412-1-arnd@kernel.org/

which is already merged.

Thanks.

> ---
>  fs/proc/task_mmu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 27da6337d675..88b6b8847cf3 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -2019,6 +2019,7 @@ static bool pagemap_scan_push_range(unsigned long categories,
>  	return true;
>  }
>  
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  static void pagemap_scan_backout_range(struct pagemap_scan_private *p,
>  				       unsigned long addr, unsigned long end)
>  {
> @@ -2031,6 +2032,7 @@ static void pagemap_scan_backout_range(struct pagemap_scan_private *p,
>  
>  	p->found_pages -= (end - addr) / PAGE_SIZE;
>  }
> +#endif
>  
>  static int pagemap_scan_output(unsigned long categories,
>  			       struct pagemap_scan_private *p,

-- 
~Randy
