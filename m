Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4BC2D107B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 13:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbgLGMVH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 07:21:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41694 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726748AbgLGMVF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:21:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607343579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Itvlqd0kxvScpcIk5b9oFbJP3emazAwFYL5MTR3etUM=;
        b=LlZiIGlu50Rhg+aqxUj1BLJW+i/QpbpW73vMrMimR4xj0j2VrBINDucg70rCGVFHOk6ecU
        G/qtsogj+sGax3qeiku8828fbpa4sYCEeUWffnUQs5KkFiRZkXDqpv+Ib8ZwB//eDvejTy
        ME94B5tfNSKQcfrGMswucAXxJesMO2I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-rKIvg7AJOtuzNUgkU0omkw-1; Mon, 07 Dec 2020 07:19:35 -0500
X-MC-Unique: rKIvg7AJOtuzNUgkU0omkw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A23B8107ACE4;
        Mon,  7 Dec 2020 12:19:31 +0000 (UTC)
Received: from [10.36.114.33] (ovpn-114-33.ams2.redhat.com [10.36.114.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FFE35D6AB;
        Mon,  7 Dec 2020 12:19:26 +0000 (UTC)
Subject: Re: [PATCH v7 03/15] mm/hugetlb: Introduce a new config
 HUGETLB_PAGE_FREE_VMEMMAP
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        mike.kravetz@oracle.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20201130151838.11208-1-songmuchun@bytedance.com>
 <20201130151838.11208-4-songmuchun@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <2ec1d360-c8c8-eb7b-2afe-b75ee61cfcea@redhat.com>
Date:   Mon, 7 Dec 2020 13:19:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201130151838.11208-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 30.11.20 16:18, Muchun Song wrote:
> The purpose of introducing HUGETLB_PAGE_FREE_VMEMMAP is to configure
> whether to enable the feature of freeing unused vmemmap associated
> with HugeTLB pages. And this is just for dependency check. Now only
> support x86.

x86 - i386 and x86-64? (I assume the latter only ;) )

> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  arch/x86/mm/init_64.c |  2 +-
>  fs/Kconfig            | 14 ++++++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 0a45f062826e..0435bee2e172 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1225,7 +1225,7 @@ static struct kcore_list kcore_vsyscall;
>  
>  static void __init register_page_bootmem_info(void)
>  {
> -#ifdef CONFIG_NUMA
> +#if defined(CONFIG_NUMA) || defined(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP)
>  	int i;
>  

Why does this hunk belong into this patch? Looks like this should go
into another patch.

>  	for_each_online_node(i)
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 976e8b9033c4..4961dd488444 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -245,6 +245,20 @@ config HUGETLBFS
>  config HUGETLB_PAGE
>  	def_bool HUGETLBFS
>  
> +config HUGETLB_PAGE_FREE_VMEMMAP
> +	def_bool HUGETLB_PAGE
> +	depends on X86
> +	depends on SPARSEMEM_VMEMMAP
> +	depends on HAVE_BOOTMEM_INFO_NODE
> +	help
> +	  When using HUGETLB_PAGE_FREE_VMEMMAP, the system can save up some
> +	  memory from pre-allocated HugeTLB pages when they are not used.
> +	  6 pages per 2MB HugeTLB page and 4094 per 1GB HugeTLB page.

Calculations only apply to 4k base pages, no? (maybe generalize this a
bit or mention 4k base pages - I'm pretty sure we'll see the "depends on
X86" part fairly soon if this goes upstream)


-- 
Thanks,

David / dhildenb

