Return-Path: <linux-fsdevel+bounces-148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DCE7C6255
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 03:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86AC1C2097A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 01:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48367EA;
	Thu, 12 Oct 2023 01:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fmcS8tNl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30C7654;
	Thu, 12 Oct 2023 01:38:41 +0000 (UTC)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3022498;
	Wed, 11 Oct 2023 18:38:39 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231012013835epoutp03915948e1618d05894d91ad06cd355a69~NOHZmSy0E1454314543epoutp03Z;
	Thu, 12 Oct 2023 01:38:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231012013835epoutp03915948e1618d05894d91ad06cd355a69~NOHZmSy0E1454314543epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697074715;
	bh=PdUbkC1x+krr8gNAbZB7WKraR1jsmcdTFBgZRJBIYjM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fmcS8tNlscvlogXgAu2qGDHwo1aUtTpVp9pu7sjBtb9khN8ZIt9ic5b3kbfNUC6u/
	 RitdrLGsy4OYNlKaKlCTzBHg302/MTsj6QHKyec3worOp/tuvD9HPlHBjEBtBBAOub
	 j7kcyqf6nP7dv0kWAsGUcwQ05Cip45sEd8BOepdY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20231012013835epcas2p2566e93152f4e31c1f9a073eaa028e631~NOHZOl1PU1130211302epcas2p2X;
	Thu, 12 Oct 2023 01:38:35 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.101]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4S5XNB5hKGz4x9QH; Thu, 12 Oct
	2023 01:38:34 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	21.A7.09660.A1E47256; Thu, 12 Oct 2023 10:38:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20231012013834epcas2p28ff3162673294077caef3b0794b69e72~NOHYN-wir0749107491epcas2p2a;
	Thu, 12 Oct 2023 01:38:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231012013834epsmtrp1a51bc2a9f7cdac3a60e01d7171f0dd9c~NOHYMXvvL1729117291epsmtrp1a;
	Thu, 12 Oct 2023 01:38:34 +0000 (GMT)
X-AuditID: b6c32a47-afdff700000025bc-39-65274e1ade0c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	88.AE.08742.91E47256; Thu, 12 Oct 2023 10:38:34 +0900 (KST)
Received: from tiffany (unknown [10.229.95.142]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20231012013833epsmtip126bb6b78bbd2e22e7580f8a6a9a062fc~NOHXycG7p1747417474epsmtip1E;
	Thu, 12 Oct 2023 01:38:33 +0000 (GMT)
Date: Thu, 12 Oct 2023 10:28:24 +0900
From: Hyesoo Yu <hyesoo.yu@samsung.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
	vschneid@redhat.com, mhiramat@kernel.org, rppt@kernel.org, hughd@google.com,
	pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com, david@redhat.com, eugenis@google.com,
	kcc@google.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 04/37] mm: Add MIGRATE_METADATA allocation policy
Message-ID: <20231012012824.GA2426387@tiffany>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230823131350.114942-5-alexandru.elisei@arm.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02TezBcdxTH+9t79+7SMLdo/aqdVFZFmGAXa39axDRGbzQjZnT6TGftrNul
	1u7au0ReU6aKPD0SLSJGW49EtWo9K1lJWUGinZQgwSYZsqZRj0QiypZ0udLJf5/zPef8zvmd
	M4ePOVznufATVDpaq5IpBYQt3tzpKfZ2ifKghRlntqHSuloCfXt+gEDtPXK0UnCFh/onBq3S
	/QwczVUdB2ihbhlD5rwmDP1WPosj8/xJHN1pr+YgU24hjlomZzhoqrETRzltCzjSTwxx0UVD
	L44G2koJdLv2KRcZ637H0a+lvVx0anYSoB+qt6L+y+UcVLg0TaDcsWECdZ+4zEHtOXc51tgW
	DsowzhGoeHQUoBzjEwwZVpdw1NS1yEOZY2J0q/IXXpg7VVtWCyjLcgGgMttHeFS5PoXKNM5w
	qYZzXpS+5ghB6ecLeNTY0EWC6imy4NR36YUY1VDxJfVXQzGg5toHCarh2kHqkX5zNPlJYnA8
	LYujta60Sq6OS1ApQgTvxUh3SsWBQpG3KAhJBK4qWRIdIgjfHe0dkaC0DlPgmipTplilaBnD
	CHxDg7XqFB3tGq9mdCECWhOn1Eg0PowsiUlRKXxUtO4tkVDoJ7YGxibGn5gYwTWre9Jml428
	dGAJOwps+JAMgMbiG/hRYMt3IFsBrD2yuGHMA/h0SA9Y4wmAD7If8Z6lNJ1vwdbYgTQAWG+y
	Z4PMAP59KZ+75sBJd3ikspFYY4L0gD2NVWCNnUhfON40tf4qRl4loOlMH2fN4UjugoVzGets
	R/rAq6a2DX4J9hbfs/bE59uQO+Bj84dsE1m2cL4wmOVwWDRwF2PZEU51N2406gLv52ZtcCI0
	PcwjWNbBn/vSN3R/WDKZvd4bRsbD5aorYK0UJN2gcQRnZXuY07nCY2U7mJPlwGa6wUtVZTjL
	r8Lxn7K5LFNQf83AYUfSDWDF4mksD2wuee4zJc9VY3k7LL8wT5RYS2Dka7B6lc+iJ6xr8y0H
	3BrwCq1hkhQ046fx/3+/cnWSHqyflte7raBo5oFPB+DwQQeAfEzgZDee8CbtYBcn23+A1qql
	2hQlzXQAsXU1+ZjLy3K19TZVOqkoIEgYEBgokviJhRKBs93tr8/GOZAKmY5OpGkNrX2Wx+Hb
	uKRzgpJ5jjhmORg2WOyk/yjC00kcIUmckd2acSdbkg9RrV6KOOnwaP2wSX0vdpxfHfnPF0VY
	8/uTO7PcmvcOqiXHtEUGe5fFun2SVfwr+y271Aeiwhh/uxcG/uwK76/6uC822eJsfrht+vjZ
	rXe2Kw9V9670yK9LtNoIn2ap5HtlNGZzSqQJDbkBDBNFZWlhkeHTmFlxsudfzvzMWOv4G+1d
	fvnZn3Z4EsKbez8IUOz3wEsscsnnm17PTovBz/lJ5bmfnR6v/CMmuD5HeKGECUmixYc1UTbf
	9P24SbxDsMf5Zir/8OixALGzKdXLsvC2IXL3cOnUPiZ06XHNixXvBPWU+wtwJl4m8sK0jOw/
	XgCYueMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTZxiG956vHhpwZ4WEl5pp1mFRjBQW3N4QwpaZbIdlootbtrAf0tCT
	StbWpgec0x8DAw4MUIM2SG1mdRQEYS1tWW3FKqU6OmVBHeAHCFJLhAl1QCVo1o1Clvnvyn3f
	1/ProXFRIymmSzSlnE4jV0koIfFLn2TDNnFBGpc5P4ghk7WDQo1tdyjk7S9GfzdcF6DbwaGV
	aLqCQOGWWoAi1hc4Ch3vxlGveY5Aofl6Ao17WzE0pjcQyDU1i6EZZx+Bqj0RAtmDwyTquRwg
	0B2PiUIPO/4hkd86QCC3KUCiE3NTAP3UKkW3r5oxZFh+SiH96AiFfq27iiFv9QS2snVhqMIf
	plDTgwcAVfuf4+hydJlA3deWBKhydDu6Z7EJPtjEdvzYAdiXLxoAW+m9L2DN9jK20j9Lso7z
	6ay9vYZi7fMNAnZ0uIdi+0+9JNiz5QacdTR/zz5xNAE27B2iWMeNw+yCfcNuplCYq+BUJQc4
	nSyvSLhvKXhfoPXuPDjeuEiWgz/yjoE4GjLZsLvNhR8DQlrEXAKwPvqzYK1IgcaFALbGiXC8
	0k+ujYIATh8xULGCYDbBGotzlSkmDfY7W0CMkxgZnOyeATEBZ25SsP6CkYwViUw+NIQrVq8m
	MBnwtzHPKosYHv4w24yv5W/AQNNjIsY4kw7vRqdXNvQKr4etUTqGccz7cDH05XHAGF8RjK8I
	xv8FM8DbQQqn5dVKNZ+lzdJw32bwcjVfplFmFO9X28Hq76RvuQhc7c8yfACjgQ9AGpckJUyW
	pHKiBIX8u0Ocbv9eXZmK431gPU1IkhOSn9QpRIxSXsp9w3FaTvdfi9Fx4nKsKumj3sBzjZWQ
	odoUYqEr1yO15n/VcO+c+GMKmvo27hqItwzedL99elGMzcz6nu2JtwVP5D46e6PrpLvl1iCF
	Py6IT7uV+RoZrBrpzB579FboqCqnoDBflho/eVrS1hyq22LzHVYc+ezK05mU3rvmCJJmbhzo
	ccmWAidNqaWdp/ISs4eGPz1UbFnX9MWllncjO5Yv2CxvSpVqai65rkuYultMf3JwM/9e5Gtl
	qd6sDhdF4bo8qX5komD7h1dq2oq2He3cutWjD1S9zjh3nk/M4d1MrTNNMfXX2OZdZ6pUipzJ
	dxhbZqH7c6QdHjrnmNhR8vue3NaH+Mj8XPYB1Z8Sgt8nz0rHdbz8X7EzzWWqAwAA
X-CMS-MailID: 20231012013834epcas2p28ff3162673294077caef3b0794b69e72
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----F-dJ1U9ruD8ZBwmJR9mWSg0R4TMepfR1e3Mf-VHtyRp8nNTb=_d9069_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231012013834epcas2p28ff3162673294077caef3b0794b69e72
References: <20230823131350.114942-1-alexandru.elisei@arm.com>
	<20230823131350.114942-5-alexandru.elisei@arm.com>
	<CGME20231012013834epcas2p28ff3162673294077caef3b0794b69e72@epcas2p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

------F-dJ1U9ruD8ZBwmJR9mWSg0R4TMepfR1e3Mf-VHtyRp8nNTb=_d9069_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Aug 23, 2023 at 02:13:17PM +0100, Alexandru Elisei wrote:
> Some architectures implement hardware memory coloring to catch incorrect
> usage of memory allocation. One such architecture is arm64, which calls its
> hardware implementation Memory Tagging Extension.
> 
> So far, the memory which stores the metadata has been configured by
> firmware and hidden from Linux. For arm64, it is impossible to to have the
> entire system RAM allocated with metadata because executable memory cannot
> be tagged. Furthermore, in practice, only a chunk of all the memory that
> can have tags is actually used as tagged. which leaves a portion of
> metadata memory unused. As such, it would be beneficial to use this memory,
> which so far has been unaccessible to Linux, to service allocation
> requests. To prepare for exposing this metadata memory a new migratetype is
> being added to the page allocator, called MIGRATE_METADATA.
> 
> One important aspect is that for arm64 the memory that stores metadata
> cannot have metadata associated with it, it can only be used to store
> metadata for other pages. This means that the page allocator will *not*
> allocate from this migratetype if at least one of the following is true:
> 
> - The allocation also needs metadata to be allocated.
> - The allocation isn't movable. A metadata page storing data must be
>   able to be migrated at any given time so it can be repurposed to store
>   metadata.
> 
> Both cases are specific to arm64's implementation of memory metadata.
> 
> For now, metadata storage pages management is disabled, and it will be
> enabled once the architecture-specific handling is added.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  arch/arm64/include/asm/memory_metadata.h | 21 ++++++++++++++++++
>  arch/arm64/mm/fault.c                    |  3 +++
>  include/asm-generic/Kbuild               |  1 +
>  include/asm-generic/memory_metadata.h    | 18 +++++++++++++++
>  include/linux/mmzone.h                   | 11 ++++++++++
>  mm/Kconfig                               |  3 +++
>  mm/internal.h                            |  5 +++++
>  mm/page_alloc.c                          | 28 ++++++++++++++++++++++++
>  8 files changed, 90 insertions(+)
>  create mode 100644 arch/arm64/include/asm/memory_metadata.h
>  create mode 100644 include/asm-generic/memory_metadata.h
> 
> diff --git a/arch/arm64/include/asm/memory_metadata.h b/arch/arm64/include/asm/memory_metadata.h
> new file mode 100644
> index 000000000000..5269be7f455f
> --- /dev/null
> +++ b/arch/arm64/include/asm/memory_metadata.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2023 ARM Ltd.
> + */
> +#ifndef __ASM_MEMORY_METADATA_H
> +#define __ASM_MEMORY_METADATA_H
> +
> +#include <asm-generic/memory_metadata.h>
> +
> +#ifdef CONFIG_MEMORY_METADATA
> +static inline bool metadata_storage_enabled(void)
> +{
> +	return false;
> +}
> +static inline bool alloc_can_use_metadata_pages(gfp_t gfp_mask)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_MEMORY_METADATA */
> +
> +#endif /* __ASM_MEMORY_METADATA_H  */
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 0ca89ebcdc63..1ca421c11ebc 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -13,6 +13,7 @@
>  #include <linux/kfence.h>
>  #include <linux/signal.h>
>  #include <linux/mm.h>
> +#include <linux/mmzone.h>
>  #include <linux/hardirq.h>
>  #include <linux/init.h>
>  #include <linux/kasan.h>
> @@ -956,6 +957,8 @@ struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
>  
>  void tag_clear_highpage(struct page *page)
>  {
> +	/* Tag storage pages cannot be tagged. */
> +	WARN_ON_ONCE(is_migrate_metadata_page(page));
>  	/* Newly allocated page, shouldn't have been tagged yet */
>  	WARN_ON_ONCE(!try_page_mte_tagging(page));
>  	mte_zero_clear_page_tags(page_address(page));
> diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
> index 941be574bbe0..048ecffc430c 100644
> --- a/include/asm-generic/Kbuild
> +++ b/include/asm-generic/Kbuild
> @@ -36,6 +36,7 @@ mandatory-y += kprobes.h
>  mandatory-y += linkage.h
>  mandatory-y += local.h
>  mandatory-y += local64.h
> +mandatory-y += memory_metadata.h
>  mandatory-y += mmiowb.h
>  mandatory-y += mmu.h
>  mandatory-y += mmu_context.h
> diff --git a/include/asm-generic/memory_metadata.h b/include/asm-generic/memory_metadata.h
> new file mode 100644
> index 000000000000..dc0c84408a8e
> --- /dev/null
> +++ b/include/asm-generic/memory_metadata.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_GENERIC_MEMORY_METADATA_H
> +#define __ASM_GENERIC_MEMORY_METADATA_H
> +
> +#include <linux/gfp.h>
> +
> +#ifndef CONFIG_MEMORY_METADATA
> +static inline bool metadata_storage_enabled(void)
> +{
> +	return false;
> +}
> +static inline bool alloc_can_use_metadata_pages(gfp_t gfp_mask)
> +{
> +	return false;
> +}
> +#endif /* !CONFIG_MEMORY_METADATA */
> +
> +#endif /* __ASM_GENERIC_MEMORY_METADATA_H */
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 5e50b78d58ea..74925806687e 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -61,6 +61,9 @@ enum migratetype {
>  	 */
>  	MIGRATE_CMA,
>  #endif
> +#ifdef CONFIG_MEMORY_METADATA
> +	MIGRATE_METADATA,
> +#endif
>  #ifdef CONFIG_MEMORY_ISOLATION
>  	MIGRATE_ISOLATE,	/* can't allocate from here */
>  #endif
> @@ -78,6 +81,14 @@ extern const char * const migratetype_names[MIGRATE_TYPES];
>  #  define is_migrate_cma_page(_page) false
>  #endif
>  
> +#ifdef CONFIG_MEMORY_METADATA
> +#  define is_migrate_metadata(migratetype) unlikely((migratetype) == MIGRATE_METADATA)
> +#  define is_migrate_metadata_page(_page) (get_pageblock_migratetype(_page) == MIGRATE_METADATA)
> +#else
> +#  define is_migrate_metadata(migratetype) false
> +#  define is_migrate_metadata_page(_page) false
> +#endif
> +
>  static inline bool is_migrate_movable(int mt)
>  {
>  	return is_migrate_cma(mt) || mt == MIGRATE_MOVABLE;
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 09130434e30d..838193522e20 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1236,6 +1236,9 @@ config LOCK_MM_AND_FIND_VMA
>  	bool
>  	depends on !STACK_GROWSUP
>  
> +config MEMORY_METADATA
> +	bool
> +
>  source "mm/damon/Kconfig"
>  
>  endmenu
> diff --git a/mm/internal.h b/mm/internal.h
> index a7d9e980429a..efd52c9f1578 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -824,6 +824,11 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>  #define ALLOC_NOFRAGMENT	  0x0
>  #endif
>  #define ALLOC_HIGHATOMIC	0x200 /* Allows access to MIGRATE_HIGHATOMIC */
> +#ifdef CONFIG_MEMORY_METADATA
> +#define ALLOC_FROM_METADATA	0x400 /* allow allocations from MIGRATE_METADATA list */
> +#else
> +#define ALLOC_FROM_METADATA	0x0
> +#endif
>  #define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
>  
>  /* Flags that allow allocations below the min watermark. */
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index fdc230440a44..7baa78abf351 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -53,6 +53,7 @@
>  #include <linux/khugepaged.h>
>  #include <linux/delayacct.h>
>  #include <asm/div64.h>
> +#include <asm/memory_metadata.h>
>  #include "internal.h"
>  #include "shuffle.h"
>  #include "page_reporting.h"
> @@ -1645,6 +1646,17 @@ static inline struct page *__rmqueue_cma_fallback(struct zone *zone,
>  					unsigned int order) { return NULL; }
>  #endif
>  
> +#ifdef CONFIG_MEMORY_METADATA
> +static __always_inline struct page *__rmqueue_metadata_fallback(struct zone *zone,
> +					unsigned int order)
> +{
> +	return __rmqueue_smallest(zone, order, MIGRATE_METADATA);
> +}
> +#else
> +static inline struct page *__rmqueue_metadata_fallback(struct zone *zone,
> +					unsigned int order) { return NULL; }
> +#endif
> +
>  /*
>   * Move the free pages in a range to the freelist tail of the requested type.
>   * Note that start_page and end_pages are not aligned on a pageblock
> @@ -2144,6 +2156,15 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
>  		if (alloc_flags & ALLOC_CMA)
>  			page = __rmqueue_cma_fallback(zone, order);
>  
> +		/*
> +		 * Allocate data pages from MIGRATE_METADATA only if the regular
> +		 * allocation path fails to increase the chance that the
> +		 * metadata page is available when the associated data page
> +		 * needs it.
> +		 */
> +		if (!page && (alloc_flags & ALLOC_FROM_METADATA))
> +			page = __rmqueue_metadata_fallback(zone, order);
> +

Hi!

I guess it would cause non-movable page starving issue as CMA.
The metadata pages cannot be used for non-movable allocations.
Metadata pages are utilized poorly, non-movable allocations may end up
getting starved if all regular movable pages are allocated and the only
pages left are metadata. If the system has a lot of CMA pages, then
this problem would become more bad. I think it would be better to make
use of it in places where performance is not critical, including some
GFP_METADATA ?

Thanks,
Hyesoo Yu.

>  		if (!page && __rmqueue_fallback(zone, order, migratetype,
>  								alloc_flags))
>  			goto retry;
> @@ -3088,6 +3109,13 @@ static inline unsigned int gfp_to_alloc_flags_fast(gfp_t gfp_mask,
>  	if (gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
>  		alloc_flags |= ALLOC_CMA;
>  #endif
> +#ifdef CONFIG_MEMORY_METADATA
> +	if (metadata_storage_enabled() &&
> +	    gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE &&
> +	    alloc_can_use_metadata_pages(gfp_mask))
> +		alloc_flags |= ALLOC_FROM_METADATA;
> +#endif
> +
>  	return alloc_flags;
>  }
>  
> -- 
> 2.41.0
> 
> 

------F-dJ1U9ruD8ZBwmJR9mWSg0R4TMepfR1e3Mf-VHtyRp8nNTb=_d9069_
Content-Type: text/plain; charset="utf-8"


------F-dJ1U9ruD8ZBwmJR9mWSg0R4TMepfR1e3Mf-VHtyRp8nNTb=_d9069_--

