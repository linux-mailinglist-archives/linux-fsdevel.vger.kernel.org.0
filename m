Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D196FCB79
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 18:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjEIQjB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 12:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjEIQjA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 12:39:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212E940CE;
        Tue,  9 May 2023 09:38:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EB0E62906;
        Tue,  9 May 2023 16:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E537C433D2;
        Tue,  9 May 2023 16:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683650336;
        bh=CNIoMSTpu9Fo0eEfWNQNIpTO1qX87mPTP8s97bQPs98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OYFk8gZtCaUB0GFVyA5nY2s6X6XAUcoBMqiiEPrWaxX20vmTkcN36Z9hNaCqa8e9F
         KFRlXdWA9a5Fqib0SKZEI8Va0aCzwr25HaZdj3HiFHP+hRK3GuoSRgOffpg1iY7UES
         yQMj/+ro7KyYSw4v0MqnRnKf07fEFz7qsVvVwGavLZqlc2DUMqqFCXzWdKW5SDgbNI
         U0M9PyPEpi3gGZppjIyijComU7HywJ/O52d+zYQbX/NMmeASZFdY13ZodyKNIiF5nK
         vAjsOkIGwDN6wXDgvSlvb4nn6NUp3T9H3teuWJUNV92VCEkQFHYGQGW033Fjxbdm7a
         SkEKmOv/I9HUw==
Date:   Tue, 9 May 2023 09:38:54 -0700
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
Subject: Re: [PATCH 01/12] mm: page_alloc: move mirrored_kernelcore into
 mm_init.c
Message-ID: <20230509163854.GB4135@kernel.org>
References: <20230508071200.123962-1-wangkefeng.wang@huawei.com>
 <20230508071200.123962-2-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508071200.123962-2-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 08, 2023 at 03:11:49PM +0800, Kefeng Wang wrote:
> Since commit 9420f89db2dd ("mm: move most of core MM initialization
> to mm/mm_init.c"), mirrored_kernelcore should be moved into mm_init.c,
> as most related codes are already there.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  mm/mm_init.c    | 2 ++
>  mm/page_alloc.c | 3 ---
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 7f7f9c677854..da162b7a044c 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -259,6 +259,8 @@ static int __init cmdline_parse_core(char *p, unsigned long *core,
>  	return 0;
>  }
>  
> +bool mirrored_kernelcore __initdata_memblock;
> +
>  /*
>   * kernelcore=size sets the amount of memory for use for allocations that
>   * cannot be reclaimed or migrated.
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index af9c995d3c1e..d1086aeca8f2 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -23,7 +23,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/pagemap.h>
>  #include <linux/jiffies.h>
> -#include <linux/memblock.h>
>  #include <linux/compiler.h>
>  #include <linux/kernel.h>
>  #include <linux/kasan.h>
> @@ -374,8 +373,6 @@ int user_min_free_kbytes = -1;
>  int watermark_boost_factor __read_mostly = 15000;
>  int watermark_scale_factor = 10;
>  
> -bool mirrored_kernelcore __initdata_memblock;
> -
>  /* movable_zone is the "real" zone pages in ZONE_MOVABLE are taken from */
>  int movable_zone;
>  EXPORT_SYMBOL(movable_zone);
> -- 
> 2.35.3
> 
