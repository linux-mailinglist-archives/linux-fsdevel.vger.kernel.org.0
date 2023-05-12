Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4CA70030F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 May 2023 10:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240057AbjELI44 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 May 2023 04:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240113AbjELI4z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 May 2023 04:56:55 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79972128;
        Fri, 12 May 2023 01:56:49 -0700 (PDT)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 5F562FF811;
        Fri, 12 May 2023 08:56:24 +0000 (UTC)
Message-ID: <1e30aaca-b4a8-4269-c368-d1f6e0ffff54@ghiti.fr>
Date:   Fri, 12 May 2023 10:56:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 04/12] riscv: mm: init: Pass a pointer to virt_to_page()
To:     Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-snps-arc@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
References: <20230503-virt-to-pfn-v6-4-rc1-v1-0-6c4698dcf9c8@linaro.org>
 <20230503-virt-to-pfn-v6-4-rc1-v1-4-6c4698dcf9c8@linaro.org>
Content-Language: en-US
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230503-virt-to-pfn-v6-4-rc1-v1-4-6c4698dcf9c8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+cc linux-riscv

On 5/11/23 13:59, Linus Walleij wrote:
> Functions that work on a pointer to virtual memory such as
> virt_to_pfn() and users of that function such as
> virt_to_page() are supposed to pass a pointer to virtual
> memory, ideally a (void *) or other pointer. However since
> many architectures implement virt_to_pfn() as a macro,
> this function becomes polymorphic and accepts both a
> (unsigned long) and a (void *).
>
> Fix this in the RISCV mm init code, so we can implement
> a strongly typed virt_to_pfn().
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>   arch/riscv/mm/init.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 747e5b1ef02d..2f7a7c345a6a 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -356,7 +356,7 @@ static phys_addr_t __init alloc_pte_late(uintptr_t va)
>   	unsigned long vaddr;
>   
>   	vaddr = __get_free_page(GFP_KERNEL);
> -	BUG_ON(!vaddr || !pgtable_pte_page_ctor(virt_to_page(vaddr)));
> +	BUG_ON(!vaddr || !pgtable_pte_page_ctor(virt_to_page((void *)vaddr)));
>   
>   	return __pa(vaddr);
>   }
> @@ -439,7 +439,7 @@ static phys_addr_t __init alloc_pmd_late(uintptr_t va)
>   	unsigned long vaddr;
>   
>   	vaddr = __get_free_page(GFP_KERNEL);
> -	BUG_ON(!vaddr || !pgtable_pmd_page_ctor(virt_to_page(vaddr)));
> +	BUG_ON(!vaddr || !pgtable_pmd_page_ctor(virt_to_page((void *)vaddr)));
>   
>   	return __pa(vaddr);
>   }
>

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

