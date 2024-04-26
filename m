Return-Path: <linux-fsdevel+bounces-17936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3228D8B3F9B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 20:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A0D285474
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 18:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724D48475;
	Fri, 26 Apr 2024 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Gowg+N32"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14936FB6
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 18:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714157346; cv=none; b=pi7BMeVVxYReo7UJGRMOTOsQl/WRsjHoqGPeMffP2F8k70TExS5b5FwkkqHQeoyFd/YZ/6nmaUAmzBF7i8AX7LpbcMOwOo1uHQTQa7HpFb3Ur6Nn3s3o699FYcPpEOxbyK0CjArPWB8I5bbjPoXH926gVJsrNJnnRTSzjUn3p00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714157346; c=relaxed/simple;
	bh=2z6vF8qxPMRT039by+3fR74GjN+7YlbplU/DVWyW3AI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WDph4U6YAWh8wRSJtge2a1qpY157m726BojFJ7/jlL4OvRwmzQ/17fYjv4MxOvT+wAdi0acUucAj333NC0urvdTw3ze3j0BHyfEadCcqvZyduyxyyVeImUZQMwZqdqBVq7rZxU6o+BWLf4QFPPx94yykO5WcmFAFl9vscL+qDRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Gowg+N32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE19C2BD10;
	Fri, 26 Apr 2024 18:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1714157346;
	bh=2z6vF8qxPMRT039by+3fR74GjN+7YlbplU/DVWyW3AI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gowg+N32tsmUNQRdZHszFRGOGH5d7dM4fnZYSZ2VXZhYo2xLqNqA1VY7g7jxuHqqK
	 /tDbOYKPEWPtRZJDKvXVmVjmUgL3CihFtJnbyiOtBsmYog2GBzitdV6X+rl3Rg9aeD
	 LCHPPyFpoNUJdV5IcHKvHumAIW3RirbMmSqITv3A=
Date: Fri, 26 Apr 2024 11:49:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, <linux-mm@kvack.org>,
 <linux-fsdevel@vger.kernel.org>, zhangyi <yi.zhang@huawei.com>
Subject: Re: [PATCH] mm: use memalloc_nofs_save() in page_cache_ra_order()
Message-Id: <20240426114905.216e3d41b97f9a59be26999e@linux-foundation.org>
In-Reply-To: <20240426112938.124740-1-wangkefeng.wang@huawei.com>
References: <20240426112938.124740-1-wangkefeng.wang@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Apr 2024 19:29:38 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> See commit f2c817bed58d ("mm: use memalloc_nofs_save in readahead
> path"), ensure that page_cache_ra_order() do not attempt to reclaim
> file-backed pages too, or it leads to a deadlock, found issue when
> test ext4 large folio.
> 
>  INFO: task DataXceiver for:7494 blocked for more than 120 seconds.
>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>  task:DataXceiver for state:D stack:0     pid:7494  ppid:1      flags:0x00000200
>  Call trace:
>   __switch_to+0x14c/0x240
>   __schedule+0x82c/0xdd0
>   schedule+0x58/0xf0
>   io_schedule+0x24/0xa0
>   __folio_lock+0x130/0x300
>   migrate_pages_batch+0x378/0x918
>   migrate_pages+0x350/0x700
>   compact_zone+0x63c/0xb38
>   compact_zone_order+0xc0/0x118
>   try_to_compact_pages+0xb0/0x280
>   __alloc_pages_direct_compact+0x98/0x248
>   __alloc_pages+0x510/0x1110
>   alloc_pages+0x9c/0x130
>   folio_alloc+0x20/0x78
>   filemap_alloc_folio+0x8c/0x1b0
>   page_cache_ra_order+0x174/0x308
>   ondemand_readahead+0x1c8/0x2b8
>   page_cache_async_ra+0x68/0xb8
>   filemap_readahead.isra.0+0x64/0xa8
>   filemap_get_pages+0x3fc/0x5b0
>   filemap_splice_read+0xf4/0x280
>   ext4_file_splice_read+0x2c/0x48 [ext4]
>   vfs_splice_read.part.0+0xa8/0x118
>   splice_direct_to_actor+0xbc/0x288
>   do_splice_direct+0x9c/0x108
>   do_sendfile+0x328/0x468
>   __arm64_sys_sendfile64+0x8c/0x148
>   invoke_syscall+0x4c/0x118
>   el0_svc_common.constprop.0+0xc8/0xf0
>   do_el0_svc+0x24/0x38
>   el0_svc+0x4c/0x1f8
>   el0t_64_sync_handler+0xc0/0xc8
>   el0t_64_sync+0x188/0x190
> 
> Cc: zhangyi (F) <yi.zhang@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

I'm thinking

Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
Cc: stable

> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -494,6 +494,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
>  	pgoff_t index = readahead_index(ractl);
>  	pgoff_t limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
>  	pgoff_t mark = index + ra->size - ra->async_size;
> +	unsigned int nofs;
>  	int err = 0;
>  	gfp_t gfp = readahead_gfp_mask(mapping);
>  
> @@ -508,6 +509,8 @@ void page_cache_ra_order(struct readahead_control *ractl,
>  		new_order = min_t(unsigned int, new_order, ilog2(ra->size));
>  	}
>  
> +	/* See comment in page_cache_ra_unbounded() */
> +	nofs = memalloc_nofs_save();
>  	filemap_invalidate_lock_shared(mapping);
>  	while (index <= limit) {
>  		unsigned int order = new_order;
> @@ -531,6 +534,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
>  
>  	read_pages(ractl);
>  	filemap_invalidate_unlock_shared(mapping);
> +	memalloc_nofs_restore(nofs);
>  
>  	/*
>  	 * If there were already pages in the page cache, then we may have
> -- 
> 2.41.0

