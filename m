Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06AF126CDE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 23:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgIPVF7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 17:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgIPQOy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:14:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A26C02C295;
        Wed, 16 Sep 2020 08:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=2L8WeVvRo1osqjjhclSBTpn136Oyr6chq2WMPl65EcM=; b=sha7upVR0ozVlTJFDWdFS4KUrg
        Dlh504xPkCjJ6bcnR0tgQmZYiIutQK/G0ONBD+iomCp+zVQ82oPYqYPfOa29q6UCwl36D+BB9FNFs
        pSeTBdPEiVQz6llxOwpNLZRraxMD45Yt9agHPf8ceWEhufE5EkURg5LtEm+1DjoRnfjJ/WOFs5+4j
        BadKgeBe/qwlbda6A6xYg/rSWFAOIGOJ/+qKGuMxZNBtCJ1ZUglDN7/DVuOWKZv/bNRIhqme65n0j
        CV7jlQDHwCcs1yfZz07j2hPdh6zbICLmsA3R4X5f+JNoZnWPrhrt60ytieQyxK1LeEjJ519udtgbv
        hAy+S0yQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIZqU-0000qm-87; Wed, 16 Sep 2020 15:59:46 +0000
Subject: Re: [PATCH v5 3/5] mm: introduce memfd_secret system call to create
 "secret" memory areas
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-riscv@lists.infradead.org, x86@kernel.org
References: <20200916073539.3552-1-rppt@kernel.org>
 <20200916073539.3552-4-rppt@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6319035d-73db-4b4d-3fa7-aaa11d3843a0@infradead.org>
Date:   Wed, 16 Sep 2020 08:59:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200916073539.3552-4-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Mike,


On 9/16/20 12:35 AM, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/Kconfig                   |   7 +
>  arch/x86/Kconfig               |   1 +
>  include/uapi/linux/magic.h     |   1 +
>  include/uapi/linux/secretmem.h |   8 +
>  kernel/sys_ni.c                |   2 +
>  mm/Kconfig                     |   4 +
>  mm/Makefile                    |   1 +
>  mm/secretmem.c                 | 264 +++++++++++++++++++++++++++++++++
>  8 files changed, 288 insertions(+)
>  create mode 100644 include/uapi/linux/secretmem.h
>  create mode 100644 mm/secretmem.c
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index af14a567b493..8d161bd4142d 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -975,6 +975,13 @@ config HAVE_SPARSE_SYSCALL_NR
>  config ARCH_HAS_VDSO_DATA
>  	bool
>  
> +config HAVE_SECRETMEM_UNCACHED
> +       bool
> +       help
> +          An architecture can select this if its semantics of non-cached
> +          mappings can be used to prevent speculative loads and it is
> +          useful for secret protection.

Please use tabs instead of spaces for indentation.

> +
>  source "kernel/gcov/Kconfig"
>  
>  source "scripts/gcc-plugins/Kconfig"

> diff --git a/mm/Kconfig b/mm/Kconfig
> index 6c974888f86f..70cfc20d7caa 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -868,4 +868,8 @@ config ARCH_HAS_HUGEPD
>  config MAPPING_DIRTY_HELPERS
>          bool
>  
> +config SECRETMEM
> +        def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED

Use tab above for indentation.

> +	select GENERIC_ALLOCATOR
> +
>  endmenu


thanks.
-- 
~Randy

