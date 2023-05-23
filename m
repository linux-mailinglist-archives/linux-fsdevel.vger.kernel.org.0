Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3A770DE79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 16:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237088AbjEWOGu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 10:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjEWOGs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 10:06:48 -0400
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207B1CA
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 07:06:46 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4f3b337e842so4538405e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 07:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684850744; x=1687442744;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZA0L4oxWScvvKHY0CMHXKugVzeIuVnng/I4z1g+Nsk8=;
        b=QcIqArszLp7JwYRjPCdJbW4Bf6QTBpjDv99yZ+wNEDAg5FCcbIEAU2vLnwSaZ/wDVc
         KwCFWAFEPL2FXe8F7dzkZS39C/9+tfHfWsZ6h4kCUkH0T4FZUHi+4baOTYShJP9qBz+S
         0zjb94DnGlZPj4QEcziXBw/p5V4FBO0dsz1i7YFtbW2BpPqLf4qhrXegdsbJiSZoCoJq
         PPqQJc53apzisyqSwpKyFLq+MpFCI/6JPyma763Gv6sO/crLkzzEIKiEGWqTfWY5My0X
         9GH+O+hNHDS3oiNkLhoexOClmfRnXjRH+FWCn9J4XNymU+Ak2ca6i1K60irxAhndOgKh
         GLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684850744; x=1687442744;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZA0L4oxWScvvKHY0CMHXKugVzeIuVnng/I4z1g+Nsk8=;
        b=ZdNdRs63NNFMx5IFgk7CG3nEIZT7GzBnBC2lMgJxOZxEiYeTivHKvi5WX4pAKrdhzs
         423jT4ZI4adye0/zn6qQUON5BX8gELI0nKmAVsfzNpQ3zR1IW2Yfax2xCe5/F1tj+bhK
         +VLHCDMgurcricKNZFcajQ58N0eEffkIxiplzGiMZFGi47jiVAFv6zbWWf8NArw1wPD3
         xtYZeUBU/pafj/tdqM0Ca+c/gWXjZASQWcF3XYFXIWQCHdiYjmfHO5UV7bDFCsjrESvG
         rppwBoihc07O3mDzSSCtqhroDtw+At5aa6E7aDSK6lDs3SkQysS8F3xJlv4NZETYl8az
         fypg==
X-Gm-Message-State: AC+VfDy7ZPnKbeEcD6VsKnc4IOa7DemZKYt+mkZgnoGR3Uo6ZY/b9pnX
        0ieWUrY8xwR4CFEU4VpdRxafqg==
X-Google-Smtp-Source: ACHHUZ7mRj4O82+6ydclzEYDj7XkOaJhpXZnXkQxMsOibkvX5DVva3Ls4f4MLwSjFXvKqDFwmr1s6A==
X-Received: by 2002:ac2:52a3:0:b0:4f3:baf9:8f8e with SMTP id r3-20020ac252a3000000b004f3baf98f8emr2856213lfm.4.1684850744384;
        Tue, 23 May 2023 07:05:44 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id h28-20020ac2597c000000b004e9bf853c27sm1346562lfp.70.2023.05.23.07.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 07:05:44 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3 00/12] arch: Make virt_to_pfn into a static inline
Date:   Tue, 23 May 2023 16:05:24 +0200
Message-Id: <20230503-virt-to-pfn-v6-4-rc1-v3-0-a16c19c03583@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACTIbGQC/42Oyw6CMBBFf8V07ZBCCxZX/odx0RfQxLRkig2G8
 O8WXLHS5b2Zc+YuJFp0NpLraSFok4su+BzY+UT0IH1vwZmcSUUrRmvKIDmcYAowdh5SAxxQl8C
 7+sJaK0xDDcmoktGCQun1sMFHpvgyaM1r3o5HtJ2b9w33R86Di1PA9z4plVv743sqgUKjedMKo
 7tWi9vTeYmhCNiTzZiqfyxVttCWC8OEMkaqg2Vd1w/gwrkLLAEAAA==
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
        linux-cifs@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Tom Talpey <tom@talpey.com>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Changes in v3:
- Fix up the Coldfire changes in accordance with Geert's feedback.
- Link to v2: https://lore.kernel.org/r/20230503-virt-to-pfn-v6-4-rc1-v2-0-0948d38bddab@linaro.org

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
 arch/m68k/include/asm/mcf_pgtable.h  |  3 +--
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
 64 files changed, 108 insertions(+), 80 deletions(-)
---
base-commit: ac9a78681b921877518763ba0e89202254349d1b
change-id: 20230503-virt-to-pfn-v6-4-rc1-4f5739e8d60d

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

