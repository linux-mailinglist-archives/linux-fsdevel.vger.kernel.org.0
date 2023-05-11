Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7356FF0C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 13:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237917AbjEKL7x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 07:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237821AbjEKL7v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 07:59:51 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4799C7D82
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 04:59:48 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f14ec8d72aso7552578e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 04:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683806386; x=1686398386;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fRNm+KFUDDN1oQKMlpBJgWHFsPEB2sb8N1qDdTLzrRA=;
        b=q/t+iF7gcJlLwSFwyWdRVnaOH6DnZ15Hh00D8KDQCVj3czLiXT5DcNm1lg1D63XkNa
         Pj7xZBHkxALHXET/ZaOVwqFb6EwCwf3dRnmhxU6pcwd8SWBYpQMrJhlGMfdKuUwNFgWP
         adfl9m0RH4IrxjXpe4B1I+Wh+kNFUTEkijwmETCXnS28KGFkhTO4BdrOSzMloCUJEtSa
         f2Bgg9QCu7u/mZ8HVRLDEVI1QgOPsZwCF8T3osYHfET+aMPl2+RtI/u7llqrOun4YjTd
         uoN9KVeCneLQVGqjqCZOUwLprHCLtQbeB4KKpHA7KQtZK0gWwU/3dYookH8iYrMjdaU/
         0hRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683806386; x=1686398386;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fRNm+KFUDDN1oQKMlpBJgWHFsPEB2sb8N1qDdTLzrRA=;
        b=KieW/uxvRfGLNnk7vgNOIYz5ZHzpucsOyh25TYZ1wYemwnl3Df1kRvMA3JrmjveID4
         sqyhJ5rjH0AoBqE3q6UPfuRyQxOvtaIsgjCDZZjadbHlR5uMGjyOGhz0TIp+f2k5LLvo
         l3/0iwv73V/HvxgU8JTtOrtPwJyjjhKjoQexLO4cqza+6IsJw68SCmKZhGrXBTxt0wJc
         3HE5ZlC+61nanq9yvujsQuVwKlFkzFervcdo5oKmirwboVfC5koXZIPSx6ZWtPC69K6b
         t1xvJCVOZMiOY3FAbrXiu2ZlFyA89op1WzrZwTq2CbOONOZYk0b//SvDodg89yHqmCDh
         R0Nw==
X-Gm-Message-State: AC+VfDzENUKXBp9dzXxOYiac5L6PSrVHClWn0v309Wi6QU/RgRuQJEc4
        jF/osbIlpfnVTrih0cA7vP1gvg==
X-Google-Smtp-Source: ACHHUZ5buhASnVjeRPaHmKvQyrqmIv8tehj5S8Nqt/PTjDb7bZMSILKyBVZvDPpNIQ1tGpyJ5D9CUw==
X-Received: by 2002:a05:6512:932:b0:4ef:ef67:65c9 with SMTP id f18-20020a056512093200b004efef6765c9mr2958124lft.23.1683806386456;
        Thu, 11 May 2023 04:59:46 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id f16-20020ac25090000000b004cb23904bd9sm1100841lfm.144.2023.05.11.04.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 04:59:46 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 00/12] arch: Make virt_to_pfn into a static inline
Date:   Thu, 11 May 2023 13:59:17 +0200
Message-Id: <20230503-virt-to-pfn-v6-4-rc1-v1-0-6c4698dcf9c8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJXYXGQC/1XOQQqDMBCF4avIrB2JRm3tVUoXMZnobKJMbBDEu
 ze2qy5/eB+8AyIJU4RHcYBQ4shLyFGXBdjZhImQXW5oVKNVpzQmlg23BVcfMPXYotgaW9/d9EB
 31ysHmY4mEo5igp0v/G+qnxFy7/0ar0Ke9++H5+s8P+BE9BOTAAAA
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-snps-arc@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an attempt to harden the typing on virt_to_pfn()
and pfn_to_virt().

Making virt_to_pfn() a static inline taking a strongly typed
(const void *) makes the contract of a passing a pointer of that
type to the function explicit and exposes any misuse of the
macro virt_to_pfn() acting polymorphic and accepting many types
such as (void *), (unitptr_t) or (unsigned long) as arguments
without warnings.

For symmetry, we do the same with pfn_to_virt().

The problem with this inconsistent typing was pointed out by
Russell King:
https://lore.kernel.org/linux-arm-kernel/YoJDKJXc0MJ2QZTb@shell.armlinux.org.uk/

And confirmed by Andrew Morton:
https://lore.kernel.org/linux-mm/20220701160004.2ffff4e5ab59a55499f4c736@linux-foundation.org/

So the recognition of the problem is widespread.

These platforms have been chosen as initial conversion targets:

- ARC
- ARM
- ARM64/Aarch64
- asm-generic (including for example x86)
- m68k

The idea is that if this goes in, it will block further misuse
of the function signatures due to the large compile coverage,
and then I can go in and fix the remaining platforms on a
one-by-one basis.

Some of the patches have been circulated before but were not
picked up by subsystem maintainers, so now the arch tree is
target for this series.

It has passed zeroday builds after a lot of iterations in my
personal tree, but there could be some randconfig outliers.

The To/Cc list would be too long if I include all the minor
patches maintainers, so I have trimmed it down to the mailing
lists since these people certainly have received the patches
before.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (12):
      fs/proc/kcore.c: Pass a pointer to virt_addr_valid()
      m68k: Pass a pointer to virt_to_pfn() virt_to_page()
      ARC: init: Pass a pointer to virt_to_pfn() in init
      riscv: mm: init: Pass a pointer to virt_to_page()
      cifs: Pass a pointer to virt_to_page()
      cifs: Pass a pointer to virt_to_page() in cifsglob
      netfs: Pass a pointer to virt_to_page()
      arm64: vdso: Pass (void *) to virt_to_page()
      asm-generic/page.h: Make pfn accessors static inlines
      ARM: mm: Make virt_to_pfn() a static inline
      arm64: memory: Make virt_to_pfn() a static inline
      m68k/mm: Make pfn accessors static inlines

 arch/arc/mm/init.c                   |  2 +-
 arch/arm/common/sharpsl_param.c      |  2 +-
 arch/arm/include/asm/delay.h         |  2 +-
 arch/arm/include/asm/io.h            |  2 +-
 arch/arm/include/asm/memory.h        | 17 ++++++++++++-----
 arch/arm/include/asm/page.h          |  4 ++--
 arch/arm/include/asm/pgtable.h       |  2 +-
 arch/arm/include/asm/proc-fns.h      |  2 --
 arch/arm/include/asm/sparsemem.h     |  2 +-
 arch/arm/include/asm/uaccess-asm.h   |  2 +-
 arch/arm/include/asm/uaccess.h       |  2 +-
 arch/arm/kernel/asm-offsets.c        |  2 +-
 arch/arm/kernel/entry-armv.S         |  2 +-
 arch/arm/kernel/entry-common.S       |  2 +-
 arch/arm/kernel/entry-v7m.S          |  2 +-
 arch/arm/kernel/head-nommu.S         |  3 +--
 arch/arm/kernel/head.S               |  2 +-
 arch/arm/kernel/hibernate.c          |  2 +-
 arch/arm/kernel/suspend.c            |  2 +-
 arch/arm/kernel/tcm.c                |  2 +-
 arch/arm/kernel/vmlinux-xip.lds.S    |  3 +--
 arch/arm/kernel/vmlinux.lds.S        |  3 +--
 arch/arm/mach-berlin/platsmp.c       |  2 +-
 arch/arm/mach-keystone/keystone.c    |  2 +-
 arch/arm/mach-omap2/sleep33xx.S      |  2 +-
 arch/arm/mach-omap2/sleep43xx.S      |  2 +-
 arch/arm/mach-omap2/sleep44xx.S      |  2 +-
 arch/arm/mach-pxa/gumstix.c          |  2 +-
 arch/arm/mach-rockchip/sleep.S       |  2 +-
 arch/arm/mach-sa1100/pm.c            |  2 +-
 arch/arm/mach-shmobile/headsmp-scu.S |  2 +-
 arch/arm/mach-shmobile/headsmp.S     |  2 +-
 arch/arm/mach-socfpga/headsmp.S      |  2 +-
 arch/arm/mach-spear/spear.h          |  2 +-
 arch/arm/mm/cache-fa.S               |  1 -
 arch/arm/mm/cache-v4wb.S             |  1 -
 arch/arm/mm/dma-mapping.c            |  2 +-
 arch/arm/mm/dump.c                   |  2 +-
 arch/arm/mm/init.c                   |  2 +-
 arch/arm/mm/kasan_init.c             |  1 -
 arch/arm/mm/mmu.c                    |  2 +-
 arch/arm/mm/physaddr.c               |  2 +-
 arch/arm/mm/pmsa-v8.c                |  2 +-
 arch/arm/mm/proc-v7.S                |  2 +-
 arch/arm/mm/proc-v7m.S               |  2 +-
 arch/arm/mm/pv-fixup-asm.S           |  2 +-
 arch/arm64/include/asm/memory.h      |  9 ++++++++-
 arch/arm64/kernel/vdso.c             |  2 +-
 arch/m68k/include/asm/page_mm.h      | 11 +++++++++--
 arch/m68k/include/asm/page_no.h      | 11 +++++++++--
 arch/m68k/mm/motorola.c              |  4 ++--
 arch/m68k/mm/sun3mmu.c               |  2 +-
 arch/m68k/sun3/dvma.c                |  2 +-
 arch/m68k/sun3x/dvma.c               |  2 +-
 arch/riscv/mm/init.c                 |  4 ++--
 drivers/memory/ti-emif-sram-pm.S     |  2 +-
 fs/cifs/cifsglob.h                   |  2 +-
 fs/cifs/smbdirect.c                  |  2 +-
 fs/netfs/iterator.c                  |  2 +-
 fs/proc/kcore.c                      |  2 +-
 include/asm-generic/page.h           | 12 ++++++++++--
 61 files changed, 103 insertions(+), 75 deletions(-)
---
base-commit: ac9a78681b921877518763ba0e89202254349d1b
change-id: 20230503-virt-to-pfn-v6-4-rc1-4f5739e8d60d

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

