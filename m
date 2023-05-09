Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8026FCB76
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 18:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjEIQjA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 12:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbjEIQim (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 12:38:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184B13AAE;
        Tue,  9 May 2023 09:38:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D2EE62906;
        Tue,  9 May 2023 16:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F06C433EF;
        Tue,  9 May 2023 16:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683650319;
        bh=rUhrsUno5UKglRVnTSvs0i9Sqtx8GYNijNMIbG+2KZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tYIPeqQC8eQvgj6sCmgYFlKvVU6IQn7QeOxFA9EZLH8Ca9JeyfzS3jJYSHpl0E2cB
         IGhCIX4JkIE0U4UuqU2X6H4fWUyoTbGywdal+kK8GjhTaTFdjo95GKyqAKvabQ2YQg
         xMA0+dIoolZQO3aV5XT56GGpHKROYtxiBrDM4e8ammq4rLfCHkrnP8yov9HUA+BVEi
         i2Wl6nOfRzjcPXiGqqlF4Eb9jfRwJm4jAaQuvjU1JKkLrdW8z5pHILDQWrmnp5A3I2
         FfNU50o3L6Q6Y397uv/s87GErb4jxeb15+6pqneInPDZNqxrEpfoMLbNUupGtZxWmW
         8kyikRGNNay8g==
Date:   Tue, 9 May 2023 09:38:37 -0700
From:   Mike Rapoport <rppt@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/12] mm: page_alloc: move init_on_alloc/free() into
 mm_init.c
Message-ID: <20230509163837.GA4135@kernel.org>
References: <20230508071200.123962-1-wangkefeng.wang@huawei.com>
 <20230508071200.123962-3-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508071200.123962-3-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 08, 2023 at 03:11:50PM +0800, Kefeng Wang wrote:
> Since commit f2fc4b44ec2b ("mm: move init_mem_debugging_and_hardening()
> to mm/mm_init.c"), the init_on_alloc() and init_on_free() define is
> better to move there too.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  mm/mm_init.c    | 6 ++++++
>  mm/page_alloc.c | 5 -----
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index da162b7a044c..15201887f8e0 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2543,6 +2543,12 @@ void __init memblock_free_pages(struct page *page, unsigned long pfn,
>  	__free_pages_core(page, order);
>  }
>  
> +DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_ALLOC_DEFAULT_ON, init_on_alloc);
> +EXPORT_SYMBOL(init_on_alloc);
> +
> +DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
> +EXPORT_SYMBOL(init_on_free);
> +
>  static bool _init_on_alloc_enabled_early __read_mostly
>  				= IS_ENABLED(CONFIG_INIT_ON_ALLOC_DEFAULT_ON);
>  static int __init early_init_on_alloc(char *buf)
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d1086aeca8f2..4f094ba7c8fb 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -233,11 +233,6 @@ unsigned long totalcma_pages __read_mostly;
>  
>  int percpu_pagelist_high_fraction;
>  gfp_t gfp_allowed_mask __read_mostly = GFP_BOOT_MASK;
> -DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_ALLOC_DEFAULT_ON, init_on_alloc);
> -EXPORT_SYMBOL(init_on_alloc);
> -
> -DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
> -EXPORT_SYMBOL(init_on_free);
>  
>  /*
>   * A cached value of the page's pageblock's migratetype, used when the page is
> -- 
> 2.35.3
> 
