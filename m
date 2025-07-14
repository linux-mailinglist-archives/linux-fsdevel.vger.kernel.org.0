Return-Path: <linux-fsdevel+bounces-54793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8723CB03487
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 04:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0266174E2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 02:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7391DE2BD;
	Mon, 14 Jul 2025 02:35:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E669EAE7;
	Mon, 14 Jul 2025 02:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752460546; cv=none; b=kFCDa7FYVnbRZlkLLRU7Kjy9j8ZxOBdz0nRed8p1231H8x0j4/iQgsW3J2WD4OjEVKPRSUit7ysrlpMTonDgqvvzWYDoZxpZ4S574otIo32GvxvUcH8yNhOguMkIjsV5mmAEyCG6FPmbloWV0hqkP86FmiWRN5zMBhl222agYBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752460546; c=relaxed/simple;
	bh=KQAzMGUQ+c04oHNp9H4UZyGi84UC9o6J3V2jj3rwhp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y2HSyR33cUUvDmXnRjQbEW+vBMi6t+QncGbjC9dUMsoRSrImc/hMFiq7iHmdxxujQbkwGjUhdNyLaCpGVL7p+csifvRq6jOVOy1USgGf9iBDE9Mv5M0GJGbqR2yDOE4JZE1jJrNg9fHtcdfbu2lCi7QCyBUh6D3T8XY49WgjI8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 476A912FC;
	Sun, 13 Jul 2025 19:35:28 -0700 (PDT)
Received: from [10.164.146.15] (J09HK2D2RT.blr.arm.com [10.164.146.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A1303F6A8;
	Sun, 13 Jul 2025 19:35:34 -0700 (PDT)
Message-ID: <f86c9ec6-d82d-4d0c-80b2-504f7c6da22e@arm.com>
Date: Mon, 14 Jul 2025 08:05:31 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/Kconfig: Enable HUGETLBFS only if
 ARCH_SUPPORTS_HUGETLBFS
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, "David S. Miller" <davem@davemloft.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 x86@kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250711102934.2399533-1-anshuman.khandual@arm.com>
 <20250712161549.499ec62de664904bd86ffa90@linux-foundation.org>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250712161549.499ec62de664904bd86ffa90@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 13/07/25 4:45 AM, Andrew Morton wrote:
> On Fri, 11 Jul 2025 15:59:34 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> 
>> Enable HUGETLBFS only when platform subscrbes via ARCH_SUPPORTS_HUGETLBFS.
>> Hence select ARCH_SUPPORTS_HUGETLBFS on existing x86 and sparc for their
>> continuing HUGETLBFS support.
> 
> Looks nice.
> 
>> While here also just drop existing 'BROKEN' dependency.
> 
> Why?
> 
> What is BROKEN for, anyway?  I don't recall having dealt with it
> before.  It predates kernel git and we forgot to document it.

The original first commit had added 'BROKEN', although currently there
are no explanations about it in the tree. But looks like this might be
used for feature gating (selectively disabling features) etc. But I am
not much aware about it.

commit 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 (tag: v2.6.12-rc2)
Author: Linus Torvalds <torvalds@ppc970.osdl.org>
Date:   Sat Apr 16 15:20:36 2005 -0700

    Linux-2.6.12-rc2

    Initial git repository build. I'm not bothering with the full history,
    even though we have it. We can create a separate "historical" git
    archive of that later if we want to, and in the meantime it's about
    3.2GB when imported into git - space that would just make the early
    git days unnecessarily complicated, when we don't have a lot of good
    infrastructure for it.

    Let it rip!

BROKEN still gets used for multiple config options.

git grep "depends on BROKEN"

arch/m68k/Kconfig.devices:      depends on BROKEN && (Q40 || SUN3X)
arch/mips/loongson64/Kconfig:   depends on BROKEN
arch/parisc/Kconfig:    depends on BROKEN
arch/powerpc/lib/crypto/Kconfig:        depends on BROKEN # Needs to be fixed to work in softirq context
drivers/edac/Kconfig:   depends on BROKEN
drivers/edac/Kconfig:   depends on BROKEN
drivers/gpu/drm/Kconfig.debug:  depends on BROKEN
drivers/gpu/drm/amd/display/Kconfig:    depends on BROKEN || !CC_IS_CLANG || ARM64 || LOONGARCH || RISCV || SPARC64 || X86_64
drivers/gpu/drm/i915/Kconfig.debug:     depends on BROKEN
drivers/net/wireless/intel/iwlwifi/Kconfig:     depends on BROKEN
drivers/s390/block/Kconfig:     depends on BROKEN
drivers/staging/gpib/TODO:- fix device drivers that are broken ("depends on BROKEN" in Kconfig)
drivers/tty/Kconfig:    depends on BROKEN
drivers/virtio/Kconfig:        depends on BROKEN
init/Kconfig:   depends on BROKEN || !SMP
init/Kconfig:   depends on BROKEN
lib/Kconfig.ubsan:      depends on BROKEN

git grep "&& BROKEN"

arch/parisc/Kconfig:    depends on PA8X00 && BROKEN && !KFENCE
arch/parisc/Kconfig:    depends on PA8X00 && BROKEN && !KFENCE
arch/powerpc/platforms/amigaone/Kconfig:        depends on PPC_BOOK3S_32 && BROKEN_ON_SMP
arch/powerpc/platforms/embedded6xx/Kconfig:     depends on PPC_BOOK3S_32 && BROKEN_ON_SMP
arch/sh/Kconfig.debug:  depends on DEBUG_KERNEL && BROKEN
drivers/gpu/drm/Kconfig.debug:  depends on DRM && EXPERT && BROKEN
drivers/i2c/busses/Kconfig:     depends on ISA && HAS_IOPORT_MAP && BROKEN_ON_SMP
drivers/leds/Kconfig:   depends on LEDS_CLASS && BROKEN
drivers/net/wireless/broadcom/b43/Kconfig:      depends on B43 && BROKEN
drivers/net/wireless/broadcom/b43/Kconfig:      depends on B43 && B43_BCMA && BROKEN
drivers/pps/generators/Kconfig: depends on PARPORT && BROKEN
drivers/staging/greybus/Kconfig:        depends on MEDIA_SUPPORT && LEDS_CLASS_FLASH && BROKEN
drivers/video/fbdev/Kconfig:    depends on FB && ((AMIGA && BROKEN) || PCI)
fs/quota/Kconfig:       depends on QUOTA && BROKEN
fs/smb/client/Kconfig:  depends on CIFS && BROKEN
net/ax25/Kconfig:       depends on AX25_DAMA_SLAVE && BROKEN

git grep "|| BROKEN"

arch/sh/Kconfig.debug:  depends on DEBUG_KERNEL && (MMU || BROKEN) && !PAGE_SIZE_64KB
drivers/misc/Kconfig:   depends on X86_64 || BROKEN
drivers/net/ethernet/faraday/Kconfig:   depends on !64BIT || BROKEN
drivers/net/ethernet/faraday/Kconfig:   depends on !64BIT || BROKEN
drivers/net/ethernet/intel/Kconfig:     depends on PCI && (!SPARC32 || BROKEN)
drivers/usb/gadget/udc/Kconfig: depends on !64BIT || BROKEN
kernel/power/Kconfig:           if ARCH_WANTS_FREEZER_CONTROL || BROKEN

