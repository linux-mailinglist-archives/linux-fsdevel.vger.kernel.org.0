Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8D42CE2C7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 00:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgLCXgy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 18:36:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:43522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgLCXgy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 18:36:54 -0500
Date:   Thu, 3 Dec 2020 15:36:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1607038573;
        bh=Pa4oRfRRHtvNG6DkXhfCABnpMt5dHNY/S5ZIo3xu0I8=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=kuOijURD2S/LKZN7m2xU1Yqs8aTgSaE+8PAXCjOUF+k6SmWXgnBX1a127MGk9xsxD
         Zehgx/bS+bttrniAwVRGaqKRk/HeHmkpC5g5mw+66gde6sKC1WxOhrIrOWZsRz9QI2
         m7IWOOo+Ox/qds8Kx515xXzlhgz0bQmTT4jC/P9M=
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: Re: [PATCH v14 04/10] set_memory: allow querying whether
 set_direct_map_*() is actually enabled
Message-Id: <20201203153610.724f40f26ca1620247bc6b09@linux-foundation.org>
In-Reply-To: <20201203062949.5484-5-rppt@kernel.org>
References: <20201203062949.5484-1-rppt@kernel.org>
        <20201203062949.5484-5-rppt@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu,  3 Dec 2020 08:29:43 +0200 Mike Rapoport <rppt@kernel.org> wrote:

> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> On arm64, set_direct_map_*() functions may return 0 without actually
> changing the linear map. This behaviour can be controlled using kernel
> parameters, so we need a way to determine at runtime whether calls to
> set_direct_map_invalid_noflush() and set_direct_map_default_noflush() have
> any effect.
> 
> Extend set_memory API with can_set_direct_map() function that allows
> checking if calling set_direct_map_*() will actually change the page table,
> replace several occurrences of open coded checks in arm64 with the new
> function and provide a generic stub for architectures that always modify
> page tables upon calls to set_direct_map APIs.
> 
> ...
>
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -22,6 +22,7 @@
>  #include <linux/io.h>
>  #include <linux/mm.h>
>  #include <linux/vmalloc.h>
> +#include <linux/set_memory.h>
>  
>  #include <asm/barrier.h>
>  #include <asm/cputype.h>
> @@ -477,7 +478,7 @@ static void __init map_mem(pgd_t *pgdp)
>  	int flags = 0;
>  	u64 i;
>  
> -	if (rodata_full || debug_pagealloc_enabled())
> +	if (can_set_direct_map())
>  		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;

Changes in -next turned this into

	if (can_set_direct_map() || crash_mem_map)


