Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F94350B766
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 14:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447577AbiDVMfl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 08:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447572AbiDVMfk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:35:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47FF57151;
        Fri, 22 Apr 2022 05:32:46 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 992DD1F37B;
        Fri, 22 Apr 2022 12:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650630765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v+IobmFBFjT5qqNpP/BKZ8Ms1ddIzrsBOvPdgsM35n4=;
        b=Bs5UUzIHvMG4EGaAaZ/SUd5vBPbp564K/grLuYXO0vTHtByfy1jVHAfyvv26c0phaCuW+z
        A0FA0MJ/PGgo7P5FuofrDqw9gPRjgKIuPKOPE9XDkfm7/ZfJf3HmA/wr2z1SoL5+41ogpK
        Q71YFO/p2o2Pxic6PdWz8o3OW5+dTxM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6616B2C141;
        Fri, 22 Apr 2022 12:32:45 +0000 (UTC)
Date:   Fri, 22 Apr 2022 14:32:44 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, hch@lst.de, hannes@cmpxchg.org,
        akpm@linux-foundation.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-input@vger.kernel.org,
        roman.gushchin@linux.dev
Subject: Re: [PATCH v2 7/8] mm: Move lib/show_mem.c to mm/
Message-ID: <YmKgbOYii+XW1xi8@dhcp22.suse.cz>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
 <20220421234837.3629927-13-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421234837.3629927-13-kent.overstreet@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 21-04-22 19:48:36, Kent Overstreet wrote:
> show_mem.c is really mm specific, and the next patch in the series is
> going to require mm/slab.h, so let's move it before doing more work on
> it.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>

No real objections on this. I do agree that this is an mm specific
thing. It depends on other things in mm/page_alloc.c so I wouldn't mind
those living close together.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  lib/Makefile           | 2 +-
>  mm/Makefile            | 2 +-
>  {lib => mm}/show_mem.c | 0
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  rename {lib => mm}/show_mem.c (100%)
> 
> diff --git a/lib/Makefile b/lib/Makefile
> index 31a3904eda..c5041d33d0 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -30,7 +30,7 @@ endif
>  lib-y := ctype.o string.o vsprintf.o cmdline.o \
>  	 rbtree.o radix-tree.o timerqueue.o xarray.o \
>  	 idr.o extable.o sha1.o irq_regs.o argv_split.o \
> -	 flex_proportions.o ratelimit.o show_mem.o \
> +	 flex_proportions.o ratelimit.o \
>  	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
>  	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
>  	 nmi_backtrace.o nodemask.o win_minmax.o memcat_p.o \
> diff --git a/mm/Makefile b/mm/Makefile
> index 70d4309c9c..97c0be12f3 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -54,7 +54,7 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
>  			   mm_init.o percpu.o slab_common.o \
>  			   compaction.o vmacache.o \
>  			   interval_tree.o list_lru.o workingset.o \
> -			   debug.o gup.o mmap_lock.o $(mmu-y)
> +			   debug.o gup.o mmap_lock.o show_mem.o $(mmu-y)
>  
>  # Give 'page_alloc' its own module-parameter namespace
>  page-alloc-y := page_alloc.o
> diff --git a/lib/show_mem.c b/mm/show_mem.c
> similarity index 100%
> rename from lib/show_mem.c
> rename to mm/show_mem.c
> -- 
> 2.35.2

-- 
Michal Hocko
SUSE Labs
