Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DAD70B591
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 09:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjEVHAr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 03:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjEVHAp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 03:00:45 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11F3A1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 00:00:39 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2af2696fd1cso34216101fa.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 00:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684738838; x=1687330838;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DNPIoJfZfpcGl/mQazzDBrBG+IwcTg57IBktWiArhPQ=;
        b=pIqcidzjihloELcSapvhUCdnCghhcpBL2z4Vy8JgtA966JDSY312p2dVKBOQ887aSw
         iguakCpNf3PAfmBeVFG328fxAK11pvXM+PvDUbTHylH/hm1FSSCCnD8N/8h6iQFuwJ5y
         H8GY0LcLORdHC5DWSKK8EH9jD0Ig/05kq1+WW7S9ttVR5Fd0Y/jSle8a0wHXD7YRJ+Cs
         sAJaQdm83yOAPswPwxgYXGgvxSwmGSS04/eVSBl9irnWrWsWRK60eOp0aUH7UWXPRdM/
         G0pv8uq3cbgyQoNm1TQZrmZpElktwAayLPsULCSW5WYxFgMFezsJ3clVgheXjkOI2PQd
         ldFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684738838; x=1687330838;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DNPIoJfZfpcGl/mQazzDBrBG+IwcTg57IBktWiArhPQ=;
        b=QjOmT1f4tW0R6eVvFQlhqpJmQxjZCMey/z6Lf01sDpz+BSDQygp7LXPxanflUM/wGi
         4XlgsDym1+DEnlAUQJAymkN3Je+2pnYakUVh8rW5ORC+3yuILH6s4lRuVGIBVeLn8OSI
         fVYVl1g76WhsT2RO356GBmALY4fjzQXs1525eOj3EV0HUEjBFUEd7HJe2W29b0KOh7F1
         NlSZep5525kD8V2ESRDBFsKqioD+VJqjhCeVhoTNIZ6QhuJS6gm5KGP0QnH3JJ2qzpQS
         5/My5i3oAYLDnBg2Fd5icLlDnEYNTkYJo8N8JWr9hD7UZciU/e5M5CGRPHB9M60KvyK7
         zd/w==
X-Gm-Message-State: AC+VfDzIe3hXjNWRjYPp2zxFJ6InyG5c3Qu5tWs1d6nB4K9lGsA3N30m
        UnaDs9A2iF/JL1uA6/OjEynCkg==
X-Google-Smtp-Source: ACHHUZ5F3iLu8/R6cUAYvFbkma+E9E2J9cbDIJbVhGpbBKeakTe5SqM7FDxMbSh7yiPn3ePytuF7GA==
X-Received: by 2002:a2e:b04d:0:b0:29f:58c6:986e with SMTP id d13-20020a2eb04d000000b0029f58c6986emr3023170ljl.52.1684738837975;
        Mon, 22 May 2023 00:00:37 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id q4-20020a2e8744000000b002adb98fdf81sm1010187ljj.7.2023.05.22.00.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 00:00:37 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 00/12] arch: Make virt_to_pfn into a static inline
Date:   Mon, 22 May 2023 09:00:35 +0200
Message-Id: <20230503-virt-to-pfn-v6-4-rc1-v2-0-0948d38bddab@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABMTa2QC/4WOOw6DMBBEr4JcZ5H5OZAq94gojD+wUmSjNbGIE
 HePIVWqlG80TzMbC4bQBHbLNkYmYkDvEpSXjKlJutEA6sSs5GXFG15BRFpg8TBbB1FADaQKqG1
 zrTrTasE1S+ogg4GBpFPTIf86+dcho1/rUZ7JWFzPD48+8YRh8fQ+L8XiSP+sxwI4CFWLrtXKd
 qq9P9FJ8rmnkfX7vn8ACYaVheYAAAA=
To:     Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-mm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org,
        linux-snps-arc@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Tom Talpey <tom@talpey.com>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
Changes in v2:
- Fix some "void * x" into "void *x" in generic page accessors and
  in m68k.
- Collected a few ACKs
- All build tests appear to pass!
- Added Andrew Mortin to To: line to see what he thinks
- Link to v1: https://lore.kernel.org/r/20230503-virt-to-pfn-v6-4-rc1-v1-0-6c4698dcf9c8@linaro.org

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
 arch/m68k/include/asm/mcf_pgtable.h  |  4 ++--
 arch/m68k/include/asm/page_mm.h      | 11 +++++++++--
 arch/m68k/include/asm/page_no.h      | 11 +++++++++--
 arch/m68k/include/asm/sun3_pgtable.h |  4 ++--
 arch/m68k/mm/mcfmmu.c                |  3 ++-
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
 64 files changed, 109 insertions(+), 80 deletions(-)
---
base-commit: ac9a78681b921877518763ba0e89202254349d1b
change-id: 20230503-virt-to-pfn-v6-4-rc1-4f5739e8d60d

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

