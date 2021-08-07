Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914E73E32A3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Aug 2021 04:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhHGCCS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Aug 2021 22:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhHGCCS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Aug 2021 22:02:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A758C0613CF;
        Fri,  6 Aug 2021 19:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=/J4tKVW+an4YqzZpky0ZZI9/CoT+k+T+4SM/TLT14Ks=; b=djzqCUGdiuQ7yW/bbum4/iEbAT
        Bh0d4iDEKBYoSS8UM04tMXI4KVuc/fiCHnCF0WmugjOb2yB9cGbWf5MIgNisdsYYmA2QfrzSi6Ega
        otKvCQffVBhuaJUTbYiAHMQWiV4jSizZwPtO3rq6wLgvkRihEaCoxPX/wdcGrYIReArbmNI2ndSHL
        NoZ8CF+pI2IC8NXLzcK1pSONNmvrNGAisiJWpR9EQqWdFt3mvaQld/Mp4Ty6WrNH4b7AQ3ovfwhCp
        jgw/4P43b3/E9gBerehP8JMdVNW0+YChXbbFPXxRa0mms0XIiNnKquVr8OkV4qVCOXxe+82vZ6ua3
        Epe4zUvg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCBeo-006VPk-B9; Sat, 07 Aug 2021 02:01:50 +0000
Subject: Re: [PATCH 1/2] mm/PAGE_IDLE_FLAG: Set PAGE_EXTENSION for none-64BIT
To:     SeongJae Park <sj38.park@gmail.com>, akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        willy@infradead.org, linux-damon@amazon.com
References: <20210806092246.30301-1-sjpark@amazon.de>
 <20210806095153.6444-1-sj38.park@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <829fd5ac-4761-9861-0517-4293bf9344cf@infradead.org>
Date:   Fri, 6 Aug 2021 19:01:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210806095153.6444-1-sj38.park@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/6/21 2:51 AM, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> Commit 128fd80c4c07 ("mm/idle_page_tracking: Make PG_idle reusable") of
> linux-mm[1] allows PAGE_IDLE_FLAG to be set without PAGE_EXTENSION
> while 64BIT is not set.  This makes 'enum page_ext_flags' undefined, so
> build fails as below for the config (!64BIT, !PAGE_EXTENSION, and
> IDLE_PAGE_FLAG).
> 
>      $ make ARCH=i386 allnoconfig
>      $ echo 'CONFIG_PAGE_IDLE_FLAG=y' >> .config
>      $ make olddefconfig
>      $ make ARCH=i386
>      [...]
>      ../include/linux/page_idle.h: In function ‘folio_test_young’:
>      ../include/linux/page_idle.h:25:18: error: ‘PAGE_EXT_YOUNG’ undeclared (first use in this function); did you mean ‘PAGEOUTRUN’?
>         return test_bit(PAGE_EXT_YOUNG, &page_ext->flags);
>      [...]
> 
> This commit fixes this issue by making PAGE_EXTENSION to be set when
> 64BIT is not set and PAGE_IDLE_FLAG is set.
> 
> [1] https://github.com/hnaz/linux-mm/commit/128fd80c4c07
> 
> Fixes: 128fd80c4c07 ("mm/idle_page_tracking: Make PG_idle reusable")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>   mm/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index d0b85dc12429..50ca602edeb6 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -741,6 +741,7 @@ config DEFERRED_STRUCT_PAGE_INIT
>   
>   config PAGE_IDLE_FLAG
>   	bool "Add PG_idle and PG_young flags"
> +	select PAGE_EXTENSION if !64BIT
>   	help
>   	  This feature adds PG_idle and PG_young flags in 'struct page'.  PTE
>   	  Accessed bit writers can set the state of the bit in the flags to let
> @@ -749,7 +750,6 @@ config PAGE_IDLE_FLAG
>   config IDLE_PAGE_TRACKING
>   	bool "Enable idle page tracking"
>   	depends on SYSFS && MMU && BROKEN
> -	select PAGE_EXTENSION if !64BIT
>   	select PAGE_IDLE_FLAG
>   	help
>   	  This feature allows to estimate the amount of user pages that have
> 


-- 
~Randy

