Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F041CD343
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 09:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgEKHvY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 03:51:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgEKHvY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 03:51:24 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15B2F20735;
        Mon, 11 May 2020 07:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589183483;
        bh=ujV3u+dsl5PKS0aIWtuPo2XlUIWTrnZfhH9932lJ3Ck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0mQ7t5as8jZps7eSFkQLnwLtzVeQdo1iP3qe/Hftt/g3zJxfzwQVDrNcWnrxBfusE
         WGRRbC87hk6tU7Y02J552JkiWyPKHGmHG8/2xNIIubv0rRSCeTtP6ug62nSc345L3i
         YbZ4edSRI7cSRvmZAntksnLnC8c2Z4vBB1WMY+EY=
Date:   Mon, 11 May 2020 08:51:15 +0100
From:   Will Deacon <will@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, james.morse@arm.com,
        catalin.marinas@arm.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Roman Zippel <zippel@linux-m68k.org>,
        Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/31] arm64: fix the flush_icache_range arguments in
 machine_kexec
Message-ID: <20200511075115.GA16134@willie-the-truck>
References: <20200510075510.987823-1-hch@lst.de>
 <20200510075510.987823-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510075510.987823-3-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[+James and Catalin]

On Sun, May 10, 2020 at 09:54:41AM +0200, Christoph Hellwig wrote:
> The second argument is the end "pointer", not the length.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm64/kernel/machine_kexec.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index 8e9c924423b4e..a0b144cfaea71 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -177,6 +177,7 @@ void machine_kexec(struct kimage *kimage)
>  	 * the offline CPUs. Therefore, we must use the __* variant here.
>  	 */
>  	__flush_icache_range((uintptr_t)reboot_code_buffer,
> +			     (uintptr_t)reboot_code_buffer +
>  			     arm64_relocate_new_kernel_size);

Urgh, well spotted. It's annoyingly different from __flush_dcache_area().

But now I'm wondering what this code actually does... the loop condition
in invalidate_icache_by_line works with 64-bit arithmetic, so we could
spend a /very/ long time here afaict. It's also a bit annoying that we
do a bunch of redundant D-cache maintenance too.

Should we use invalidate_icache_range() here instead? (and why does that
thing need to toggle uaccess)? Argh, too many questions!

Will
