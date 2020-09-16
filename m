Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2FB26B9B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 04:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgIPCN4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 22:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgIPCNz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 22:13:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4A7C06174A;
        Tue, 15 Sep 2020 19:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=StAcmq2hytUsdqjmMPZzvMl7oTgVOsqygfC3l3eMGYg=; b=ne/A1+vxjw6SisnO/IxVlBsGAR
        UvwaOJHNiWIAZ2Ja9SbQ7ug5Xh+umaia+1FZ+GYrjDBDa2eYTECk9/eYxOvNXOj2/krbCPggplFyH
        6zoI8YJODm/4DsvHiCcXtWsj2zqJoUQzZ5iOU1jz752hjBVm2GCa6aw5tWO6axxiaWNMz6Y9q4vM5
        DcukDeNO7ZiDn5m1XWCkxo0ESj9sLHm0Umoj5FYhAJAU5cQBu4uAQSCK772OcFh94b+1BlfM5+Oeo
        nHngKVHRDvkOG2SLmlTIFN3XdDLn4l7s+8ixWITt+9R8LpqrEeaUOq0QqOH7+pphICn+j2jcMfZ+/
        kbwG6/EA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIMxE-00027v-HD; Wed, 16 Sep 2020 02:13:52 +0000
Subject: Re: [RFC PATCH 03/24] mm/hugetlb: Introduce a new config
 HUGETLB_PAGE_FREE_VMEMMAP
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        mike.kravetz@oracle.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de, almasrymina@google.com,
        rientjes@google.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20200915125947.26204-1-songmuchun@bytedance.com>
 <20200915125947.26204-4-songmuchun@bytedance.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b61afed1-c710-182c-bd80-1ad00f83a36e@infradead.org>
Date:   Tue, 15 Sep 2020 19:13:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200915125947.26204-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/15/20 5:59 AM, Muchun Song wrote:
> The purpose of introducing HUGETLB_PAGE_FREE_VMEMMAP is to configure
> whether to enable the feature of freeing unused vmemmap associated
> with HugeTLB pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  fs/Kconfig | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 976e8b9033c4..61e9c08096ca 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -245,6 +245,21 @@ config HUGETLBFS
>  config HUGETLB_PAGE
>  	def_bool HUGETLBFS
>  
> +config HUGETLB_PAGE_FREE_VMEMMAP
> +	bool "Free unused vmemmap associated with HugeTLB pages"
> +	default n
> +	depends on HUGETLB_PAGE
> +	depends on SPARSEMEM_VMEMMAP
> +	depends on HAVE_BOOTMEM_INFO_NODE
> +	help
> +	  There are many struct page structure associated with each HugeTLB

	                             structures

> +	  page. But we only use a few struct page structure. In this case,

	                                          structures.

> +	  it waste some memory. It is better to free the unused struct page

	  it wastes

> +	  structures to buddy system which can save some memory. For
> +	  architectures that support it, say Y here.
> +
> +	  If unsure, say N.
> +
>  config MEMFD_CREATE
>  	def_bool TMPFS || HUGETLBFS
>  
> 


-- 
~Randy

