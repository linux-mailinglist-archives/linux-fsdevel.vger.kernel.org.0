Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6208707776
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 03:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjERBfg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 21:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjERBfe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 21:35:34 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D2619BD;
        Wed, 17 May 2023 18:35:32 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QMC8x4VnRzTkgf;
        Thu, 18 May 2023 09:30:41 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 09:35:30 +0800
Message-ID: <f7b5aec9-f9e0-dd51-f9a0-c6af227537fd@huawei.com>
Date:   Thu, 18 May 2023 09:35:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 08/13] mm: page_alloc: split out DEBUG_PAGEALLOC
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <ying.huang@intel.com>
References: <20230516063821.121844-1-wangkefeng.wang@huawei.com>
 <20230516063821.121844-9-wangkefeng.wang@huawei.com>
 <20230516152212.95f4a6ebba475cb994a4429f@linux-foundation.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230516152212.95f4a6ebba475cb994a4429f@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/5/17 6:22, Andrew Morton wrote:
> On Tue, 16 May 2023 14:38:16 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> 
>> DEBUG_PAGEALLOC
>>
>>   mm/debug_page_alloc.c | 59 +++++++++++++++++++++++++++++++++
>>   mm/page_alloc.c       | 69 ---------------------------------------
> 
> and
> 
> FAIL_PAGE_ALLOC
> 
> We're irritatingly inconsistent about whether there's an underscore.
> 
> akpm:/usr/src/25> grep page_alloc mm/*c|wc -l
> 49
> akpm:/usr/src/25> grep pagealloc mm/*c|wc -l
> 28

All the 28 pagealloc naming is from DEBUG_PAGEALLOC feature, they chould
be changed to page_alloc except the cmdline, but it will lead to long
function name and don't gain too much advantage, so keep unchange?

$ grep pagealloc mm/*c
mm/debug_page_alloc.c:bool _debug_pagealloc_enabled_early __read_mostly
mm/debug_page_alloc.c:EXPORT_SYMBOL(_debug_pagealloc_enabled_early);
mm/debug_page_alloc.c:DEFINE_STATIC_KEY_FALSE(_debug_pagealloc_enabled);
mm/debug_page_alloc.c:EXPORT_SYMBOL(_debug_pagealloc_enabled);
mm/debug_page_alloc.c:static int __init early_debug_pagealloc(char *buf)
mm/debug_page_alloc.c:	return kstrtobool(buf, 
&_debug_pagealloc_enabled_early);
mm/debug_page_alloc.c:early_param("debug_pagealloc", early_debug_pagealloc);
mm/memory_hotplug.c:	 * Freeing the page with debug_pagealloc enabled 
will try to unmap it,
mm/memory_hotplug.c:	debug_pagealloc_map_pages(page, 1 << order);
mm/mm_init.c:	      debug_pagealloc_enabled())) {
mm/mm_init.c:	if (debug_pagealloc_enabled()) {
mm/mm_init.c:		static_branch_enable(&_debug_pagealloc_enabled);
mm/page_alloc.c:	 * page becomes unavailable via debug_pagealloc or 
arch_free_page.
mm/page_alloc.c:	debug_pagealloc_unmap_pages(page, 1 << order);
mm/page_alloc.c:	debug_pagealloc_map_pages(page, 1 << order);
mm/page_poison.c:		pr_err("pagealloc: single bit error\n");
mm/page_poison.c:		pr_err("pagealloc: memory corruption\n");
mm/page_poison.c:	dump_page(page, "pagealloc: corrupted page details");
mm/slab.c:static inline bool is_debug_pagealloc_cache(struct kmem_cache 
*cachep)
mm/slab.c:	return debug_pagealloc_enabled_static() && OFF_SLAB(cachep) &&
mm/slab.c:	if (!is_debug_pagealloc_cache(cachep))
mm/slab.c:	if (is_debug_pagealloc_cache(cachep))
mm/slab.c:	 * To activate debug pagealloc, off-slab management is necessary
mm/slab.c:	if (debug_pagealloc_enabled_static() && (flags & SLAB_POISON) &&
mm/slab.c:		is_debug_pagealloc_cache(cachep))
mm/slub.c:	if (!debug_pagealloc_enabled_static())
mm/vmalloc.c:	if (debug_pagealloc_enabled_static())
mm/vmalloc.c:	if (debug_pagealloc_enabled_static())



> 


