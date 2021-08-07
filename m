Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A603E32A5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Aug 2021 04:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhHGCCT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Aug 2021 22:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhHGCCS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Aug 2021 22:02:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E95C061798;
        Fri,  6 Aug 2021 19:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=N2L9zgxhslmE4lxK1f+s/dL0EtHvvhBzVdO8xeW26qM=; b=NDaDydaDf4F7NvgrJtfOF6LRo4
        diDN9RJq65WnzQzOTOMGMydYt+oYkdYIc7IRqPXouOTQiJJf+cWIZYhXT4Q+C4rGN55R9KA/Dll3z
        Ui1Zao7OyutpMRMMVjXhYwRcXV5yPS3tBLhQQnuWo8VlFDXHHIuBjhO1ebmZvsiC8k0gZdTNtjoMi
        swqEdCa1sHRDb+IVCUBTRAtKUwUBb67V8YL9NJvNEhQ87+EgAeK9HioRRgMYeB4hioHjG6/jMJZyZ
        32XJ5SoJUqlxXp5LOOIejd8C/Eh2c7k/eZpCgqeQd0J6OWPNEiDs8kf/nKVkAXmUZdJAZ9GBM/p0m
        5BK/LB7Q==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCBel-006VPe-Lz; Sat, 07 Aug 2021 02:01:48 +0000
Subject: Re: [PATCH 2/2] mm/damon/Kconfig: Remove unnecessary PAGE_EXTENSION
 setup
To:     SeongJae Park <sj38.park@gmail.com>, akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        willy@infradead.org, linux-damon@amazon.com
References: <20210806092246.30301-1-sjpark@amazon.de>
 <20210806095153.6444-1-sj38.park@gmail.com>
 <20210806095153.6444-2-sj38.park@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8e33d30e-76ff-9f45-8318-9dcd7a2145fd@infradead.org>
Date:   Fri, 6 Aug 2021 19:01:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210806095153.6444-2-sj38.park@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/6/21 2:51 AM, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> Commit 13d49dbd0123 ("mm/damon: implement primitives for the virtual
> memory address spaces") of linux-mm[1] makes DAMON_VADDR to set
> PAGE_IDLE_FLAG.  PAGE_IDLE_FLAG sets PAGE_EXTENSION if !64BIT.  However,
> DAMON_VADDR do the same work again.  This commit removes the unnecessary
> duplicate.
> 
> [1] https://github.com/hnaz/linux-mm/commit/13d49dbd0123
> 
> Fixes: 13d49dbd0123 ("mm/damon: implement primitives for the virtual memory address spaces")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>   mm/damon/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
> index 455995152697..37024798a97c 100644
> --- a/mm/damon/Kconfig
> +++ b/mm/damon/Kconfig
> @@ -27,7 +27,6 @@ config DAMON_KUNIT_TEST
>   config DAMON_VADDR
>   	bool "Data access monitoring primitives for virtual address spaces"
>   	depends on DAMON && MMU
> -	select PAGE_EXTENSION if !64BIT
>   	select PAGE_IDLE_FLAG
>   	help
>   	  This builds the default data access monitoring primitives for DAMON
> 


-- 
~Randy

