Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB7E1CD6F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 13:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbgEKLAZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 07:00:25 -0400
Received: from foss.arm.com ([217.140.110.172]:56316 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729086AbgEKLAZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 07:00:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AD751FB;
        Mon, 11 May 2020 04:00:24 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFC143F305;
        Mon, 11 May 2020 04:00:20 -0700 (PDT)
Date:   Mon, 11 May 2020 12:00:14 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, james.morse@arm.com,
        Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20200511110014.GA19176@gaia>
References: <20200510075510.987823-1-hch@lst.de>
 <20200510075510.987823-3-hch@lst.de>
 <20200511075115.GA16134@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511075115.GA16134@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 11, 2020 at 08:51:15AM +0100, Will Deacon wrote:
> On Sun, May 10, 2020 at 09:54:41AM +0200, Christoph Hellwig wrote:
> > The second argument is the end "pointer", not the length.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  arch/arm64/kernel/machine_kexec.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> > index 8e9c924423b4e..a0b144cfaea71 100644
> > --- a/arch/arm64/kernel/machine_kexec.c
> > +++ b/arch/arm64/kernel/machine_kexec.c
> > @@ -177,6 +177,7 @@ void machine_kexec(struct kimage *kimage)
> >  	 * the offline CPUs. Therefore, we must use the __* variant here.
> >  	 */
> >  	__flush_icache_range((uintptr_t)reboot_code_buffer,
> > +			     (uintptr_t)reboot_code_buffer +
> >  			     arm64_relocate_new_kernel_size);
> 
> Urgh, well spotted. It's annoyingly different from __flush_dcache_area().
> 
> But now I'm wondering what this code actually does... the loop condition
> in invalidate_icache_by_line works with 64-bit arithmetic, so we could
> spend a /very/ long time here afaict.

I think it goes through the loop only once. The 'b.lo' saves us here.
OTOH, there is no I-cache maintenance done.

> It's also a bit annoying that we do a bunch of redundant D-cache
> maintenance too. Should we use invalidate_icache_range() here instead?

Since we have the __flush_dcache_area() above it for cleaning to PoC, we
could use invalidate_icache_range() here. We probably didn't have this
function at the time, it was added for KVM (commit 4fee94736603cd6).

> (and why does that thing need to toggle uaccess)?

invalidate_icache_range() doesn't need to, it works on the kernel linear
map.

__flush_icache_range() doesn't need to either, that's a side-effect of
the fall-through implementation.

Anyway, I think Christoph's patch needs to go in with a fixes tag:

Fixes: d28f6df1305a ("arm64/kexec: Add core kexec support")
Cc: <stable@vger.kernel.org> # 4.8.x-

and we'll change these functions/helpers going forward for arm64.

Happy to pick this up via the arm64 for-next/fixes branch.

-- 
Catalin
