Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280A72AA939
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Nov 2020 06:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgKHFRe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 00:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgKHFRe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 00:17:34 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD58C0613D2
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 Nov 2020 21:17:33 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h2so5098012wmm.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Nov 2020 21:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r9aT3RV5iTBLi6xVKvy9ESdq01vAtIRf9u+RQFLMlk8=;
        b=ic6PU7pbuoktFwoy5T07opHN2Jhn3G4P+CLIrkN5Iot7hSjoBM4MbhzKWBtuEw0l8J
         tOGbKQrRQpjrr1WB/I5DSPP844qlDzNTeEFmrps1rOVMS/7qM+s1ufALAo/IyPNjZISR
         f3dDMTZxdlB2e1a74qz66cT8JvsZi4s6ow7emxlPuEPruAV3/pWTOOiFeuGr78tKOp5D
         tdL8doiIiYVeM3UeiL6McDVHcYHRq/yvxPeWkP5AY2A5VoV7bubq9cBcyuk0wicvK7Ko
         6oacU0dqbRoEFt3o/6G5eo+c54ghGy/F7/n0WLFMbXMoFzXjJOIE7WzAyFnaEBYMaXCi
         nuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r9aT3RV5iTBLi6xVKvy9ESdq01vAtIRf9u+RQFLMlk8=;
        b=jd14FZ1ErfgFTZYWEpppPYo6TvWs8zh3DfOrSjdJyB59kYRc5eTbCdQlq49//IRNHo
         gnwgWXMNot2tnp+dJp3WSjGSphtQBJdkNeU5TgJJ/vh/IUf6Gstixk8mutJEreQH4LW1
         WnLNvncL0l8b4dxikjTXG7tjPRe4em7xglbx1ELhs4u3eNQqjZ6zXLLO8l9iDPbIkuyG
         2WhnTVcbKiyCP+n3xVZ4VFasPQNv9Jh2G/+w+LX8r6nQggfCX8olRjZq8knf92358Mr6
         /+k5OzNO1AHOrQAO0nCtz/yO6HPX0ILqdmr6A+he+Y0+OSMkYVKBq3UJvLVYWYO6o2mz
         w5Dw==
X-Gm-Message-State: AOAM530rIwFvRRLo0OAATjmb7cN8A6VnPp/bPpiTKarXAKWuzhhQZJuu
        v69YMNQrK0k6dxmhurZMvup0cQ==
X-Google-Smtp-Source: ABdhPJx8kgDcsXzU1GSdZh7iKVRn9ukLbAjTByACEbWQF3Xw3UdIdVxLmbR7qMp+g037hB0U7FwKjQ==
X-Received: by 2002:a1c:81c9:: with SMTP id c192mr7530377wmd.1.1604812652574;
        Sat, 07 Nov 2020 21:17:32 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id r10sm8378462wmg.16.2020.11.07.21.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 21:17:31 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH 00/19] Add generic user_landing tracking
Date:   Sun,  8 Nov 2020 05:17:10 +0000
Message-Id: <20201108051730.2042693-1-dima@arista.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Started from discussion [1], where was noted that currently a couple of
architectures support mremap() for vdso/sigpage, but not munmap().
If an application maps something on the ex-place of vdso/sigpage,
later after processing signal it will land there (good luck!)

Patches set is based on linux-next (next-20201106) and it depends on
changes in x86/cleanups (those reclaim TIF_IA32/TIF_X32) and also
on my changes in akpm (fixing several mremap() issues).

Logically, the patches set divides on:
- patch       1: cleanup for patches in x86/cleanups
- patches  2-11: cleanups for arch_setup_additional_pages()
- patches 12-13: x86 signal changes for unmapped vdso
- patches 14-19: provide generic user_landing in mm_struct

In the end, besides cleanups, it's now more predictable what happens for
applications with unmapped vdso on architectures those support .mremap()
for vdso/sigpage.

I'm aware of only one user that unmaps vdso - Valgrind [2].
(there possibly are more, but this one is "special", it unmaps vdso, but
 not vvar, which confuses CRIU [Checkpoint Restore In Userspace], that's
 why I'm aware of it)

Patches as a .git branch:
https://github.com/0x7f454c46/linux/tree/setup_additional_pages

[1]: https://lore.kernel.org/linux-arch/CAJwJo6ZANqYkSHbQ+3b+Fi_VT80MtrzEV5yreQAWx-L8j8x2zA@mail.gmail.com/
[2]: https://github.com/checkpoint-restore/criu/issues/488

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Guo Ren <guoren@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: x86@kernel.org

Dmitry Safonov (19):
  x86/elf: Check in_x32_syscall() in compat_arch_setup_additional_pages()
  elf: Move arch_setup_additional_pages() to generic elf.h
  arm64: Use in_compat_task() in arch_setup_additional_pages()
  x86: Remove compat_arch_setup_additional_pages()
  elf: Remove compat_arch_setup_additional_pages()
  elf/vdso: Reuse arch_setup_additional_pages() parameters
  elf: Use sysinfo_ehdr in ARCH_DLINFO()
  arm/vdso: Remove vdso pointer from mm->context
  s390/vdso: Remove vdso_base pointer from mm->context
  sparc/vdso: Remove vdso pointer from mm->context
  mm/mmap: Make vm_special_mapping::mremap return void
  x86/signal: Land on &frame->retcode when vdso isn't mapped
  x86/signal: Check if vdso_image_32 is mapped before trying to land on it
  mm: Add user_landing in mm_struct
  x86/vdso: Migrate to user_landing
  arm/vdso: Migrate to user_landing
  arm64/vdso: Migrate compat signals to user_landing
  arm64/vdso: Migrate native signals to user_landing
  mips/vdso: Migrate to user_landing

 arch/alpha/include/asm/elf.h              |  2 +-
 arch/arm/Kconfig                          |  2 +
 arch/arm/include/asm/elf.h                | 10 +---
 arch/arm/include/asm/mmu.h                |  3 -
 arch/arm/include/asm/vdso.h               |  6 +-
 arch/arm/kernel/process.c                 | 14 +----
 arch/arm/kernel/signal.c                  |  6 +-
 arch/arm/kernel/vdso.c                    | 20 ++-----
 arch/arm64/Kconfig                        |  2 +
 arch/arm64/include/asm/elf.h              | 27 ++-------
 arch/arm64/kernel/signal.c                | 10 +++-
 arch/arm64/kernel/signal32.c              | 17 ++++--
 arch/arm64/kernel/vdso.c                  | 47 ++++++---------
 arch/csky/Kconfig                         |  1 +
 arch/csky/include/asm/elf.h               |  4 --
 arch/csky/kernel/vdso.c                   |  3 +-
 arch/hexagon/Kconfig                      |  1 +
 arch/hexagon/include/asm/elf.h            |  6 --
 arch/hexagon/kernel/vdso.c                |  3 +-
 arch/ia64/include/asm/elf.h               |  2 +-
 arch/mips/Kconfig                         |  2 +
 arch/mips/include/asm/elf.h               | 10 +---
 arch/mips/kernel/signal.c                 | 11 ++--
 arch/mips/kernel/vdso.c                   |  5 +-
 arch/mips/vdso/genvdso.c                  |  9 ---
 arch/nds32/Kconfig                        |  1 +
 arch/nds32/include/asm/elf.h              |  8 +--
 arch/nds32/kernel/vdso.c                  |  3 +-
 arch/nios2/Kconfig                        |  1 +
 arch/nios2/include/asm/elf.h              |  4 --
 arch/nios2/mm/init.c                      |  2 +-
 arch/powerpc/Kconfig                      |  1 +
 arch/powerpc/include/asm/elf.h            |  9 +--
 arch/powerpc/kernel/vdso.c                |  3 +-
 arch/riscv/Kconfig                        |  1 +
 arch/riscv/include/asm/elf.h              | 10 +---
 arch/riscv/kernel/vdso.c                  |  9 +--
 arch/s390/Kconfig                         |  1 +
 arch/s390/include/asm/elf.h               | 10 +---
 arch/s390/include/asm/mmu.h               |  1 -
 arch/s390/kernel/vdso.c                   | 13 +---
 arch/sh/Kconfig                           |  1 +
 arch/sh/include/asm/elf.h                 | 16 ++---
 arch/sh/kernel/vsyscall/vsyscall.c        |  3 +-
 arch/sparc/Kconfig                        |  1 +
 arch/sparc/include/asm/elf_64.h           | 11 +---
 arch/sparc/include/asm/mmu_64.h           |  1 -
 arch/sparc/vdso/vma.c                     | 18 +++---
 arch/x86/Kconfig                          |  2 +
 arch/x86/entry/common.c                   |  8 ++-
 arch/x86/entry/vdso/vma.c                 | 72 ++++++++++++-----------
 arch/x86/ia32/ia32_signal.c               | 18 +++---
 arch/x86/include/asm/compat.h             |  6 ++
 arch/x86/include/asm/elf.h                | 44 +++++---------
 arch/x86/include/asm/mmu.h                |  1 -
 arch/x86/include/asm/vdso.h               |  4 ++
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  3 +-
 arch/x86/kernel/signal.c                  | 25 ++++----
 arch/x86/um/asm/elf.h                     |  9 +--
 arch/x86/um/vdso/vma.c                    |  2 +-
 fs/Kconfig.binfmt                         |  3 +
 fs/aio.c                                  |  3 +-
 fs/binfmt_elf.c                           | 19 +++---
 fs/binfmt_elf_fdpic.c                     | 17 +++---
 fs/compat_binfmt_elf.c                    | 12 ----
 include/linux/elf.h                       | 24 ++++++--
 include/linux/mm.h                        |  3 +-
 include/linux/mm_types.h                  | 12 +++-
 mm/Kconfig                                |  3 +
 mm/mmap.c                                 | 21 ++++++-
 mm/mremap.c                               |  2 +-
 71 files changed, 308 insertions(+), 356 deletions(-)


base-commit: c34f157421f6905e6b4a79a312e9175dce2bc607
-- 
2.28.0

