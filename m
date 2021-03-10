Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4949A334018
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 15:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbhCJOPC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 09:15:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:46854 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232956AbhCJOO7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 09:14:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615385697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PsgN0DLBzJSs8dxWX8jTU+wIyrjJ0g+0prudfyao9mI=;
        b=Tvrh7P5wQ54v3pcp4SSdZktDbXaGQxnTqh5w1+b5YXcC9xj3PxbzzEaa0nRg8xuUBhUx6F
        mVAAT+wTOiHORW7XCiJ5OKfFDqN7cTZSNUdy5453SIY4RCOmf3mcYh/PO/KDFinvgkn1Xg
        Im/jUaDXWzfu7BnsmFD6m2cFS5qbi9A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 64687AEB6;
        Wed, 10 Mar 2021 14:14:57 +0000 (UTC)
Date:   Wed, 10 Mar 2021 15:14:56 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com, joao.m.martins@oracle.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Subject: Re: [PATCH v18 1/9] mm: memory_hotplug: factor out bootmem core
 functions to bootmem_info.c
Message-ID: <YEjUYOIJb2kYoQIA@dhcp22.suse.cz>
References: <20210308102807.59745-1-songmuchun@bytedance.com>
 <20210308102807.59745-2-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308102807.59745-2-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[I am sorry for a late review]

On Mon 08-03-21 18:27:59, Muchun Song wrote:
> Move bootmem info registration common API to individual bootmem_info.c.
> And we will use {get,put}_page_bootmem() to initialize the page for the
> vmemmap pages or free the vmemmap pages to buddy in the later patch.
> So move them out of CONFIG_MEMORY_HOTPLUG_SPARSE. This is just code
> movement without any functional change.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> Tested-by: Chen Huang <chenhuang5@huawei.com>
> Tested-by: Bodeddula Balasubramaniam <bodeddub@amazon.com>

Separation from memory_hotplug.c is definitely a right step. I am
wondering about the config dependency though
[...]
> diff --git a/mm/Makefile b/mm/Makefile
> index 72227b24a616..daabf86d7da8 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -83,6 +83,7 @@ obj-$(CONFIG_SLUB) += slub.o
>  obj-$(CONFIG_KASAN)	+= kasan/
>  obj-$(CONFIG_KFENCE) += kfence/
>  obj-$(CONFIG_FAILSLAB) += failslab.o
> +obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o

I would have expected this would depend on CONFIG_SPARSE.
BOOTMEM_INFO_NODE is really an odd thing to depend on here. There is
some functionality which requires the node info but that can be gated
specifically. Or what is the thinking behind?

This doesn't matter right now because it seems that the *_page_bootmem
is only used by x86 outside of the memory hotplug.

Other than that looks good to me.
-- 
Michal Hocko
SUSE Labs
