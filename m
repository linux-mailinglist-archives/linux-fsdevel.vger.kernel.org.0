Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E112687A82
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2019 14:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406760AbfHIMvr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 08:51:47 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57353 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406735AbfHIMvq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 08:51:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 464lVk02RMz9sP7;
        Fri,  9 Aug 2019 22:51:41 +1000 (AEST)
From:   mpe@ellerman.id.au
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>, x86@kernel.org
Cc:     iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Lianbo Jiang <lijiang@redhat.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v4 0/6] Remove x86-specific code from generic headers
In-Reply-To: <20190806044919.10622-1-bauerman@linux.ibm.com>
References: <20190806044919.10622-1-bauerman@linux.ibm.com>
Date:   Fri, 09 Aug 2019 22:51:41 +1000
Message-ID: <87sgqasdr6.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
> Hello,
>
> This version has only a small change in the last patch as requested by
> Christoph and Halil, and collects Reviewed-by's.
>
> These patches are applied on top of v5.3-rc2.
>
> I don't have a way to test SME, SEV, nor s390's PEF so the patches have only
> been build tested.

I need to take this series via the powerpc tree because there is another
fairly large powerpc specific series dependent on it.

I think this series already has pretty much all the acks it needs, which
almost never happens, amazing work!

I'll put the series in a topic branch, just in case there's any bad
conflicts and other folks want to merge it later on. I'll then merge the
topic branch into my next, and so this series will be tested in
linux-next that way.

cheers


> Changelog
>
> Since v3:
>
> - Patch "s390/mm: Remove sev_active() function"
>   - Preserve comment from sev_active() in force_dma_unencrypted().
>     Suggested by Christoph Hellwig.
>
> Since v2:
>
> - Patch "x86,s390: Move ARCH_HAS_MEM_ENCRYPT definition to arch/Kconfig"
>   - Added "select ARCH_HAS_MEM_ENCRYPT" to config S390. Suggested by Janani.
>
> - Patch "DMA mapping: Move SME handling to x86-specific files"
>   - Split up into 3 new patches. Suggested by Christoph Hellwig.
>
> - Patch "swiotlb: Remove call to sme_active()"
>   - New patch.
>
> - Patch "dma-mapping: Remove dma_check_mask()"
>   - New patch.
>
> - Patch "x86,s390/mm: Move sme_active() and sme_me_mask to x86-specific header"
>   - New patch.
>   - Removed export of sme_active symbol. Suggested by Christoph Hellwig.
>
> - Patch "fs/core/vmcore: Move sev_active() reference to x86 arch code"
>   - Removed export of sev_active symbol. Suggested by Christoph Hellwig.
>
> - Patch "s390/mm: Remove sev_active() function"
>   - New patch.
>
> Since v1:
>
> - Patch "x86,s390: Move ARCH_HAS_MEM_ENCRYPT definition to arch/Kconfig"
>   - Remove definition of ARCH_HAS_MEM_ENCRYPT from s390/Kconfig as well.
>   - Reworded patch title and message a little bit.
>
> - Patch "DMA mapping: Move SME handling to x86-specific files"
>   - Adapt s390's <asm/mem_encrypt.h> as well.
>   - Remove dma_check_mask() from kernel/dma/mapping.c. Suggested by
>     Christoph Hellwig.
>
> Thiago Jung Bauermann (6):
>   x86,s390: Move ARCH_HAS_MEM_ENCRYPT definition to arch/Kconfig
>   swiotlb: Remove call to sme_active()
>   dma-mapping: Remove dma_check_mask()
>   x86,s390/mm: Move sme_active() and sme_me_mask to x86-specific header
>   fs/core/vmcore: Move sev_active() reference to x86 arch code
>   s390/mm: Remove sev_active() function
>
>  arch/Kconfig                        |  3 +++
>  arch/s390/Kconfig                   |  4 +---
>  arch/s390/include/asm/mem_encrypt.h |  5 +----
>  arch/s390/mm/init.c                 |  7 +------
>  arch/x86/Kconfig                    |  4 +---
>  arch/x86/include/asm/mem_encrypt.h  | 10 ++++++++++
>  arch/x86/kernel/crash_dump_64.c     |  5 +++++
>  arch/x86/mm/mem_encrypt.c           |  2 --
>  fs/proc/vmcore.c                    |  8 ++++----
>  include/linux/crash_dump.h          | 14 ++++++++++++++
>  include/linux/mem_encrypt.h         | 15 +--------------
>  kernel/dma/mapping.c                |  8 --------
>  kernel/dma/swiotlb.c                |  3 +--
>  13 files changed, 42 insertions(+), 46 deletions(-)
