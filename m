Return-Path: <linux-fsdevel+bounces-71757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2FDCD112B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 18:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C416302BBBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 17:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB47838F241;
	Fri, 19 Dec 2025 16:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJ64F8Y9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A0538F23A
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766160998; cv=none; b=LCHMGqk4DPTloRegwiLv9ye6S1hQwNEc/YYRY6adpzXhTtNvXTsdl/xbGZ842OVSwhryTnVXmkoHzvZw65NlnQ/1KC2CP0iTsu2THpqW49HohRB9HJP/PSH3BBixtCg4Ytit6zhkGybRE8s1JaKvrVTMIe0hHQ8Pv7WLdjkDkyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766160998; c=relaxed/simple;
	bh=JUANTRw13L53ZJeWRkytCQq3wemKN/QVSV7VD+meYXA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gkBIYn6ATpPQtnNddpegEDSV4WgyLylQn+Ysn5RP0rlFnNZMnKqLepDJfirKS4dW8djNjj/M2AzaRjtQNk7RfbauSsEGLA8U7aEx/Q7XtCbRyutPAiCAo8Yxvidk4jNSdCCqr84jfxbqN2trIEdPyGa2/5fv/25lCp2Ed0Uim7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJ64F8Y9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B064FC4CEF1;
	Fri, 19 Dec 2025 16:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766160997;
	bh=JUANTRw13L53ZJeWRkytCQq3wemKN/QVSV7VD+meYXA=;
	h=From:To:Cc:Subject:Date:From;
	b=AJ64F8Y9Olu9SXqmaxmT9KT0vAWaGBKrVOSF5D/0Oz74R9S7OUB4519d3Z2Lp1bl+
	 O8u/lVF5zadcmz+Jg7ZazmZGrJW4d4Va1PnH2siAZQ+9ghPxuy5UAsm7DU/mLVfq5r
	 hnksEovGij6hUHhTTaexE7/wA0zSddCm3xkBo5gXW6F07o6HD0gY/tadQ3Mrz7EbXB
	 S1D4hNCpD473VLN7fQzyjsiHa49R2e0xMzWwQkDuiqzMQmmO9guk6Kqz94jCpgzdfP
	 hn3U6Jmry9eImWjt1gJ5CsTA5x9BkByml4oyXj5zLBrNtTGtQjGdonwP5jZ7tWWVGG
	 gJZ0MXw+MyIAw==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-mm@kvack.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Matthew Wilcox <willy@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org
Subject: [PATCH 0/4] mm: increase lowmem size in linux-7.0
Date: Fri, 19 Dec 2025 17:15:55 +0100
Message-Id: <20251219161559.556737-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

At the kernel summit in Tokyo last week, I hosted a session on dealing
with highmem in the long run, see the link below.

My feeling was that we got sufficient consensus on the plan to keep the
funcationality present for the time being but instead reduce the scope
of highmem in the kernel as much as we can without hurting users.

The short summary is a three stage process:

 1. Nudge users towards using a larger lowmem zone with the
    CONFIG_VMSPLIT_* options if at all possible.

 2. Drop most __GFP_HIGHMEM allocations and corresponding kmap()
    calls from the kernel, leaving only the subset that is likely
    to contain the majority of the actual allocations.
    Specifically we will keep anonymous and regular file backed
    user mappings, zsmalloc, and huge pages.

 3. In a few years, also drop the page cache allocations and leave
    perhaps only zsmalloc using a much simpler interface.  I suggested
    five years as the time until we do this, but the timing depends a
    lot on how the first two stages work out in practice, and how long
    the remaining highmem users plan to keep updating their kernels.

This series implements stage 1, mostly using Kconfig changes to the
default settings but leaving the traditional behavior as a CONFIG_EXPERT
choice in Kconfig. With the new defaults, most installations that use
highmem today with 1 GiB or 2 GiB of system RAM will see all of their
RAM in the lowmem zone after upgrading their kernels. My estimate is
that instead of 80% to 90% of maintained embedded 32-bit systems, this
should cover over 98%.

As I don't actually have hardware in the category that still needs
highmem, I tested this using a qemu-system for Armv7 and PPC6xx running a
Debian userland with all combinations of VMSPLIT and HIGHMEM options. I
ran some kernel builds on the Arm guest to ensure that the new options
don't cause functional or performance regressions for regular workloads
that don't exceed the virtual address space. I also ran some tests
with Firefox and was positively surprised to see that this still works
on the VMSPLIT_2G_OPT configuration without highmem, though it gets
close to both the address space and lowmem size limits.

The change to use VMSPLIT_3G_OPT by default on Armv5 means that I could
include a patch to no longer support highmem at all on VIVT caches,
as suggested by Jason Gunthorpe.

     Arnd

Link: https://lpc.events/event/19/contributions/2261/

Arnd Bergmann (4):
  arch/*: increase lowmem size to avoid highmem use
  ARM: add CONFIG_VMSPLIT_2G_OPT option
  ARM: remove support for highmem on VIVT
  mm: remove ARCH_NEEDS_KMAP_HIGH_GET

 arch/arm/Kconfig                            |  12 ++-
 arch/arm/configs/aspeed_g5_defconfig        |   1 -
 arch/arm/configs/dove_defconfig             |   2 -
 arch/arm/configs/gemini_defconfig           |   1 -
 arch/arm/configs/multi_v5_defconfig         |   1 -
 arch/arm/configs/mv78xx0_defconfig          |   2 -
 arch/arm/configs/mvebu_v5_defconfig         |   1 -
 arch/arm/configs/u8500_defconfig            |   1 -
 arch/arm/configs/vt8500_v6_v7_defconfig     |   3 -
 arch/arm/include/asm/highmem.h              |  56 +----------
 arch/arm/mach-omap2/Kconfig                 |   1 -
 arch/arm/mm/cache-feroceon-l2.c             |  31 +-----
 arch/arm/mm/cache-xsc3l2.c                  |  47 +--------
 arch/arm/mm/dma-mapping.c                   |  12 +--
 arch/arm/mm/flush.c                         |  19 +---
 arch/microblaze/Kconfig                     |   9 +-
 arch/microblaze/configs/mmu_defconfig       |   1 -
 arch/powerpc/Kconfig                        |  17 ++--
 arch/powerpc/configs/44x/akebono_defconfig  |   1 -
 arch/powerpc/configs/85xx/ksi8560_defconfig |   1 -
 arch/powerpc/configs/85xx/stx_gp3_defconfig |   1 -
 arch/x86/Kconfig                            |   4 +-
 mm/highmem.c                                | 100 ++------------------
 23 files changed, 56 insertions(+), 268 deletions(-)

-- 
2.39.5

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>


