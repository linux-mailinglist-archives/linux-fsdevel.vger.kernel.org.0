Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0E31D02B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 01:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731633AbgELXAf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 19:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731618AbgELXAa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 19:00:30 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EFAC05BD09
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 16:00:29 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id u15so2093064plm.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 16:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=TxR+iMR41NNC8Tp0Yh5G0J9anaHo/y+mAo5OJ6FnE3w=;
        b=YV0IEXO5IABYUMUtMWw6Y0a2xNZhYt4iDNMNdBJAdhkLz+DhDJrEb2/tely+kMRfBe
         elzT7mfwntttCi0+nBJzpxqW1RzbdA4k2z5m0sbPhXbgm86NhUGJ6ezv1UWvqUAF6AFb
         GwYEyZnEpPlXtS0AdB1oOMIXhoSzH1oQ3QYdKyFvf7rV9a0F5474HoxquQdEEcVsoVZk
         mkFDvy/LaDlTuj+uY+/sZnyRH+3w/Rut2ArIzwHPIrhPI856FrWtiOC99MOqCPnAlAt1
         y5de0EiQgDBn8VhocdW7T7X+feJnXd114pzMo7qEMcn1qfbF3zf4gbB8O6Pkx7p0q4QB
         ZmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=TxR+iMR41NNC8Tp0Yh5G0J9anaHo/y+mAo5OJ6FnE3w=;
        b=dLiK910igUDzAG6M2Ig4EhGaJDeOPJqy38/HcdMG2DC62Oth2pRfegpcmWed2DyvE3
         28DLL7iQPPaysldMpKVssMKzGfzg5+G9BtwKz8icD6+l4jnPiNhtwVYYrBvvhQZRL3Hg
         u7w8bNZMtdiRIgiyNv2HYXkuZqF2jJMTAgyfVaXM0zrawtVYoZgiKBSFOo0BWrzo0JmT
         Dw+AqfAS+oLXHOlLFPzQKovvVnCLUrvmAq9Ii07DCADe+XVp+nXu0CPlnD62Kfq3Vg2e
         T8Hs8BKAYYp9TNqcsfi3QPqSgu/JzDIDhfy7e51wyfSHcmU1h2Yr3YanW7e++HLKYvLs
         x8pQ==
X-Gm-Message-State: AGi0PuaK76hR1VufpMNDrXMEzUqB6ppZTY1WFHhsSVZAYyBi23TTKE0E
        TpDfA5iVGwqruWDWJqMb6R1FqA==
X-Google-Smtp-Source: APiQypKPbiNIuzOhnfWZK3aSuAimZ6kMvjtjoB3PUVWkLgrXCsrrvonJs2vHPqxiHQA1YoMJYuJ02Q==
X-Received: by 2002:a17:90a:2281:: with SMTP id s1mr31687737pjc.68.1589324428530;
        Tue, 12 May 2020 16:00:28 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id w143sm12602170pfc.165.2020.05.12.16.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 16:00:26 -0700 (PDT)
Date:   Tue, 12 May 2020 16:00:26 -0700 (PDT)
X-Google-Original-Date: Tue, 12 May 2020 15:59:50 PDT (-0700)
Subject:     Re: [PATCH 19/31] riscv: use asm-generic/cacheflush.h
In-Reply-To: <20200510075510.987823-20-hch@lst.de>
CC:     akpm@linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
        zippel@linux-m68k.org, linux-arch@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, monstr@monstr.eu, jeyu@kernel.org,
        linux-ia64@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
        linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org,
        x86@kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-m68k@lists.linux-m68k.org,
        openrisc@lists.librecores.org, linux-alpha@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-8adbedbc-0f91-4291-9471-2df5eb7b802b@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 10 May 2020 00:54:58 PDT (-0700), Christoph Hellwig wrote:
> RISC-V needs almost no cache flushing routines of its own.  Rely on
> asm-generic/cacheflush.h for the defaults.
>
> Also remove the pointless __KERNEL__ ifdef while we're at it.
> ---
>  arch/riscv/include/asm/cacheflush.h | 62 ++---------------------------
>  1 file changed, 3 insertions(+), 59 deletions(-)
>
> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
> index c8677c75f82cb..a167b4fbdf007 100644
> --- a/arch/riscv/include/asm/cacheflush.h
> +++ b/arch/riscv/include/asm/cacheflush.h
> @@ -8,65 +8,6 @@
>
>  #include <linux/mm.h>
>
> -#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
> -
> -/*
> - * The cache doesn't need to be flushed when TLB entries change when
> - * the cache is mapped to physical memory, not virtual memory
> - */
> -static inline void flush_cache_all(void)
> -{
> -}
> -
> -static inline void flush_cache_mm(struct mm_struct *mm)
> -{
> -}
> -
> -static inline void flush_cache_dup_mm(struct mm_struct *mm)
> -{
> -}
> -
> -static inline void flush_cache_range(struct vm_area_struct *vma,
> -				     unsigned long start,
> -				     unsigned long end)
> -{
> -}
> -
> -static inline void flush_cache_page(struct vm_area_struct *vma,
> -				    unsigned long vmaddr,
> -				    unsigned long pfn)
> -{
> -}
> -
> -static inline void flush_dcache_mmap_lock(struct address_space *mapping)
> -{
> -}
> -
> -static inline void flush_dcache_mmap_unlock(struct address_space *mapping)
> -{
> -}
> -
> -static inline void flush_icache_page(struct vm_area_struct *vma,
> -				     struct page *page)
> -{
> -}
> -
> -static inline void flush_cache_vmap(unsigned long start, unsigned long end)
> -{
> -}
> -
> -static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
> -{
> -}
> -
> -#define copy_to_user_page(vma, page, vaddr, dst, src, len) \
> -	do { \
> -		memcpy(dst, src, len); \
> -		flush_icache_user_range(vma, page, vaddr, len); \
> -	} while (0)
> -#define copy_from_user_page(vma, page, vaddr, dst, src, len) \
> -	memcpy(dst, src, len)
> -
>  static inline void local_flush_icache_all(void)
>  {
>  	asm volatile ("fence.i" ::: "memory");
> @@ -79,6 +20,7 @@ static inline void flush_dcache_page(struct page *page)
>  	if (test_bit(PG_dcache_clean, &page->flags))
>  		clear_bit(PG_dcache_clean, &page->flags);
>  }
> +#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
>
>  /*
>   * RISC-V doesn't have an instruction to flush parts of the instruction cache,
> @@ -105,4 +47,6 @@ void flush_icache_mm(struct mm_struct *mm, bool local);
>  #define SYS_RISCV_FLUSH_ICACHE_LOCAL 1UL
>  #define SYS_RISCV_FLUSH_ICACHE_ALL   (SYS_RISCV_FLUSH_ICACHE_LOCAL)
>
> +#include <asm-generic/cacheflush.h>
> +
>  #endif /* _ASM_RISCV_CACHEFLUSH_H */

Thanks!

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

Were you trying to get these all in at once, or do you want me to take it into
my tree?
