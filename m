Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63FB775F68
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 14:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjHIMkt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 08:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjHIMks (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:40:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E68410F3
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Aug 2023 05:40:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEAC161924
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Aug 2023 12:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3645C433C8;
        Wed,  9 Aug 2023 12:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691584846;
        bh=qkN4hCfczhkVGSFHRn3lAEAKDnEVv6B1jgLozsEWEqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a0vBC+6ieEcnyA5uNIRNHO+91hD1X8GUNViLzSjtyRwkAN1arAXA24SpDU40Yhymt
         GN8zNpND43HrjlblgvK/VXtTia1wyhVTSX5uYQemANd8ScmrfcTaWWQ7CvZOQkCcij
         0YZaHS8jxP+AeuGxmBgDD0MQSF1gfMQJzhMyR1HIZG2WlJRbEIB1HPQ2J4R/XDxzlY
         4rSb8KCOk9O3vvMc8jPyqWM4c93LvOknSzBQsL6xFSmqfJt4H9/j/Ao8SrgprJ3W4q
         zdFfrly18GUz/BWNYZZo6PwJtX9DmMHXTYsloIGq7AkaPbLoqkWAKv1N9LKwerXlLZ
         gg/bZ55/SvQaQ==
Date:   Wed, 9 Aug 2023 15:39:51 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tomas Mudrunka <tomas.mudrunka@gmail.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH v2] mm: memtest: convert to memtest_report_meminfo()
Message-ID: <20230809123951.GL2607694@kernel.org>
References: <20230808033359.174986-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808033359.174986-1-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 08, 2023 at 11:33:59AM +0800, Kefeng Wang wrote:
> It is better to not expose too many internal variables of memtest,
> add a helper memtest_report_meminfo() to show memtest results.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
> v2: add CONFIG_PROC_FS check, per Matthew
> 
>  fs/proc/meminfo.c        | 12 +-----------
>  include/linux/memblock.h | 10 ++++------
>  mm/memtest.c             | 22 ++++++++++++++++++++--
>  3 files changed, 25 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index 74e3c3815696..45af9a989d40 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -133,17 +133,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>  	show_val_kb(m, "VmallocChunk:   ", 0ul);
>  	show_val_kb(m, "Percpu:         ", pcpu_nr_pages());
>  
> -#ifdef CONFIG_MEMTEST
> -	if (early_memtest_done) {
> -		unsigned long early_memtest_bad_size_kb;
> -
> -		early_memtest_bad_size_kb = early_memtest_bad_size>>10;
> -		if (early_memtest_bad_size && !early_memtest_bad_size_kb)
> -			early_memtest_bad_size_kb = 1;
> -		/* When 0 is reported, it means there actually was a successful test */
> -		seq_printf(m, "EarlyMemtestBad:   %5lu kB\n", early_memtest_bad_size_kb);
> -	}
> -#endif
> +	memtest_report_meminfo(m);
>  
>  #ifdef CONFIG_MEMORY_FAILURE
>  	seq_printf(m, "HardwareCorrupted: %5lu kB\n",
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 0d031fbfea25..1c1072e3ca06 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -594,13 +594,11 @@ extern int hashdist;		/* Distribute hashes across NUMA nodes? */
>  #endif
>  
>  #ifdef CONFIG_MEMTEST
> -extern phys_addr_t early_memtest_bad_size;	/* Size of faulty ram found by memtest */
> -extern bool early_memtest_done;			/* Was early memtest done? */
> -extern void early_memtest(phys_addr_t start, phys_addr_t end);
> +void early_memtest(phys_addr_t start, phys_addr_t end);
> +void memtest_report_meminfo(struct seq_file *m);
>  #else
> -static inline void early_memtest(phys_addr_t start, phys_addr_t end)
> -{
> -}
> +static inline void early_memtest(phys_addr_t start, phys_addr_t end) { }
> +static inline void memtest_report_meminfo(struct seq_file *m) { }
>  #endif
>  
>  
> diff --git a/mm/memtest.c b/mm/memtest.c
> index 57149dfee438..32f3e9dda837 100644
> --- a/mm/memtest.c
> +++ b/mm/memtest.c
> @@ -3,9 +3,10 @@
>  #include <linux/types.h>
>  #include <linux/init.h>
>  #include <linux/memblock.h>
> +#include <linux/seq_file.h>
>  
> -bool early_memtest_done;
> -phys_addr_t early_memtest_bad_size;
> +static bool early_memtest_done;
> +static phys_addr_t early_memtest_bad_size;
>  
>  static u64 patterns[] __initdata = {
>  	/* The first entry has to be 0 to leave memtest with zeroed memory */
> @@ -117,3 +118,20 @@ void __init early_memtest(phys_addr_t start, phys_addr_t end)
>  		do_one_pass(patterns[idx], start, end);
>  	}
>  }
> +
> +void memtest_report_meminfo(struct seq_file *m)
> +{
> +	unsigned long early_memtest_bad_size_kb;
> +
> +	if (!IS_ENABLED(CONFIG_PROC_FS))
> +		return;
> +
> +	if (!early_memtest_done)
> +		return;
> +
> +	early_memtest_bad_size_kb = early_memtest_bad_size >> 10;
> +	if (early_memtest_bad_size && !early_memtest_bad_size_kb)
> +		early_memtest_bad_size_kb = 1;
> +	/* When 0 is reported, it means there actually was a successful test */
> +	seq_printf(m, "EarlyMemtestBad:   %5lu kB\n", early_memtest_bad_size_kb);
> +}
> -- 
> 2.41.0
> 

-- 
Sincerely yours,
Mike.
