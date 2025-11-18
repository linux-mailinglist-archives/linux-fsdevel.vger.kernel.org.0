Return-Path: <linux-fsdevel+bounces-68909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 623DFC682DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 09:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E2E7A34EEC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 08:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C4A30EF7B;
	Tue, 18 Nov 2025 08:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2ysF9a/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC41211A09
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 08:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763453830; cv=none; b=uf0xtknkoGlP9fa+enm2y55kenCBMT4FYGELXUwxq60AWaZjrvMpnjUVHlLGGgfB3LEPrIF0LLC5H1s64HZ0RobCD+wiKYGES3wh943EUv1lGnu1ys8gkqN2WRhZKzlsR4Mi06DruvqCuW1bHCO7oqT3vP2UFfMgU3JxODONSiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763453830; c=relaxed/simple;
	bh=nrNETb7FnlD8KOyyIYYnpMxqeeX5j6XkCSs+SnDvF5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CsCdNKAHvNN2XCuPXoTQ4GBNa0t+1l3X4/c7aS4C38Zf+L0JSytkncp3b2eL8+XVUYM+m2QWBLYpAgquRH9VvptpCEeYLGX0ARBLDRxEU6Npxxwj+/tW6xreau5VYwUh0R8Bm39vk63pA+ujRhQI2xMBSBuEo6AM2fSF5g3SOT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2ysF9a/; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3ec5df386acso502852fac.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 00:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763453828; x=1764058628; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VoMiIW3QGWFlhk8MIsWxVubR6fxSt8dbm0U8xNqOKso=;
        b=L2ysF9a/uKgonkOGhYuUNJ5mvR14XpyF8zDtlwjw6gnnwusbRrxjqTa/zF7ZbFz8t2
         wPCvWYpD2sEzAdCssQetTMaadY8Jc3DMcDxGRfy+F2L5GcMH5ty8k04zHEpK3YxSz94I
         1jw0bZ5D/txG+28PczrVn1S7LhVrHjhrel8xVhrn9hFTQI8p82g1pIx69DUGYouOCyx/
         PRSxHhDGMQxN/dVkdJRq8HR0ykHj0Jj7f4aLxhcsMiLBaBp8XDbAHRqURhmuaAagfA//
         pJHkzWXoTs5NKLz3dcRshCoEVXOs/4TH2otLES8EVZ8d8A8pCmIYvvSEMeOD4rKNCxR0
         /fdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763453828; x=1764058628;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoMiIW3QGWFlhk8MIsWxVubR6fxSt8dbm0U8xNqOKso=;
        b=pTb5WaS009xYooLwUc4rCkT3rOiIsv42K/uThqC2HGOtf6mzExaS81uPBqG4q+qvJg
         9dTu5wcumJ61cXE9m11FHiEeoWqMBWuq8S2RtGh/Fsvti173ZxicGmAc2jbqEw8d2IWb
         hNfEkOdh8PcuwEVgxxIjKZKgUDrTMnAJjHhZcAcU9IneFefewK+nRT775BmTad3lDMMS
         yrNyv+Q1qJ160/2OibHF3LY5rip/A3jBIiB4Kf/Kh+ASLtcWHQaJN0ktrwZus3t9IVmB
         hnSkTAFDoJKx5peFDtsUgiLL0sL3a5+HPu94eSGPMzRvNFlNO4A+nl5mGck04UZy236j
         ss6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJOo5UBd+Ny37jrgnBxVCjO+ddrIuuKytGFUhLQWfO4rSifwoINc0QT7jwEj3HWRzeK5GoJWd9KbxYEmD3@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx8P7Uq00IDb2i9Tm5mmCGywrmCqau45hlFPy9J9ZNN3rfWTOp
	qMSsKz2Rxgww/zR8AF50Y5TFP87ivUS+2kr5P6VJfgZvENNY8BTZsL5yYkQobxL4G6o610/z8he
	e58XqXYbkUST6tW8boGB4U8wW587rb/0=
X-Gm-Gg: ASbGncsjM+G7Lcf3KWzlaGNloiOiFEzViglQencW7/j0U9VkIO3VWAd/UbgNQYiEcfj
	PPkIdhps5L7FFKm3zWt14ZPfAbDeL5yU90SRIXnY/iIEeB+51k0j/1XxlwOROuQG3/l/Gk0fuTe
	8TZkDKTfvLplhHChhwHn/K+mPbnGDGpu9H47zWNIf6ZKbVLqUWyFuSG8lA18JzLlykNPTf58cFH
	OBagXJBEX/GsKl1j674a/avvY6S5+rGk2iYHIpi+UFrQ7jQG1bkroabh1kXmM+S8cFO1qqZQ63E
	N0C23ibRHDw6nJTxNZz99E+a
X-Google-Smtp-Source: AGHT+IGJVcqmC4kf999U78KR7Z+Carm82VZu3TBqJ/efc58ObEBqzZW6zVk9sdknUB16hhvBH9dnfceG+BbpGDOEGZw=
X-Received: by 2002:a05:6870:8193:b0:3ec:3949:8a20 with SMTP id
 586e51a60fabf-3ec39498c48mr3471777fac.29.1763453828009; Tue, 18 Nov 2025
 00:17:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113072806.795029-1-zhangchunyan@iscas.ac.cn>
In-Reply-To: <20251113072806.795029-1-zhangchunyan@iscas.ac.cn>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Tue, 18 Nov 2025 16:16:30 +0800
X-Gm-Features: AWmQ_bmir1nIDPRCoXTSJbPR1qsg3o-M-aBGdrWbEh4IhEqrSXiExjOsSzb9Kb8
Message-ID: <CAAfSe-v6+Gc8ujv3m3LdBPk+rGSqmz44RheoNqGJcXjOq3vU9A@mail.gmail.com>
Subject: Re: [PATCH V15 0/6] mm: Add soft-dirty and uffd-wp support for RISC-V
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, Peter Xu <peterx@redhat.com>, 
	Arnd Bergmann <arnd@arndb.de>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, linux-riscv@lists.infradead.org, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, devicetree@vger.kernel.org, 
	Conor Dooley <conor@kernel.org>, Deepak Gupta <debug@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-kernel@vger.kernel.org, Chunyan Zhang <zhangchunyan@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

On Thu, 13 Nov 2025 at 15:28, Chunyan Zhang <zhangchunyan@iscas.ac.cn> wrote:
>
> This patchset adds support for Svrsw60t59b [1] extension which is ratified now,
> also add soft dirty and userfaultfd write protect tracking for RISC-V.
>
> The patches 1 and 2 add macros to allow architectures to define their own checks
> if the soft-dirty / uffd_wp PTE bits are available, in other words for RISC-V,
> the Svrsw60t59b extension is supported on which device the kernel is running.
> Also patch1-2 are removing "ifdef CONFIG_MEM_SOFT_DIRTY"
> "ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP" and
> "ifdef CONFIG_PTE_MARKER_UFFD_WP" in favor of checks which if not overridden by
> the architecture, no change in behavior is expected.
>
> This patchset has been tested with kselftest mm suite in which soft-dirty,
> madv_populate, test_unmerge_uffd_wp, and uffd-unit-tests run and pass,
> and no regressions are observed in any of the other tests.
>
> This patchset applies on the mm/mm-new branch commit ea53cb52f919
> ("mm/vmalloc: cleanup gfp flag use in new_vmap_block()")
>
> [1] https://github.com/riscv-non-isa/riscv-iommu/pull/543
>

Can this patchset go through the mm tree if there's no more comments?

Thanks,
Chunyan

> V15:
> - Rebased on to the latest mm-new branch;
> - Removed a redundant space;
> - Added Conor's Acked-by.
>
> V14: https://lore.kernel.org/all/20250918083731.1820327-1-zhangchunyan@iscas.ac.cn/
> - Fix indent inssues in userfaultfd_k.h;
> - Some descriptions and comments minor changes.
>
> V13: https://lore.kernel.org/all/20250917033703.1695933-1-zhangchunyan@iscas.ac.cn/
> - Rebase on mm-new branch;
> - Fixed build errors;
> - Add more exactly descriptions in commit message in patch 1-2;
> - Replace '__always_inline' with 'inline' for uffd_supports_wp_marker();
> - Add Svrsw60t59b description to the extensions dt-binding in patch 6.
>
> V12: https://lore.kernel.org/all/20250915101343.1449546-1-zhangchunyan@iscas.ac.cn/
> - Rename the macro API to pgtable_supports_soft_dirty/uffd_wp();
> - Add changes for setting VM_SOFTDIRTY flags conditionally;
> - Drop changes to show_smap_vma_flags();
> - Drop CONFIG_MEM_SOFT_DIRTY compile condition of clear_soft_dirty() and clear_soft_dirty_pmd();
> - Fix typos;
> - Add uffd_supports_wp_marker() and drop some ifdef CONFIG_PTE_MARKER_UFFD_WP.
>
> V11: https://lore.kernel.org/all/20250911095602.1130290-1-zhangchunyan@iscas.ac.cn/
> - Rename the macro API to pgtable_*_supported() since we also have PMD support;
> - Change the default implementations of two macros, make CONFIG_MEM_SOFT_DIRTY or
>   CONFIG_HAVE_ARCH_USERFAULTFD_WP part of the macros;
> - Correct the order of insertion of RISCV_ISA_EXT_SVRSW60T59B;
> - Rephrase some comments.
>
> V10: https://lore.kernel.org/all/20250909095611.803898-1-zhangchunyan@iscas.ac.cn/
> - Fixed the issue reported by kernel test irobot <lkp@intel.com>.
>
> V9: https://lore.kernel.org/all/20250905103651.489197-1-zhangchunyan@iscas.ac.cn/
> - Add pte_soft_dirty/uffd_wp_available() API to allow dynamically checking
>   if the PTE bit is available for the platform on which the kernel is running.
>
> V8: https://lore.kernel.org/all/20250619065232.1786470-1-zhangchunyan@iscas.ac.cn/)
> - Rebase on v6.16-rc1;
> - Add dependencies to MMU && 64BIT for RISCV_ISA_SVRSW60T59B;
> - Use 'Svrsw60t59b' instead of 'SVRSW60T59B' in Kconfig help paragraph;
> - Add Alex's Reviewed-by tag in patch 1.
>
> V7: https://lore.kernel.org/all/20250409095320.224100-1-zhangchunyan@iscas.ac.cn/
> - Add Svrsw60t59b [1] extension support;
> - Have soft-dirty and uffd-wp depending on the Svrsw60t59b extension to
>   avoid crashes for the hardware which don't have this extension.
>
> V6: https://lore.kernel.org/all/20250408084301.68186-1-zhangchunyan@iscas.ac.cn/
> - Changes to use bits 59-60 which are supported by extension Svrsw60t59b
>   for soft dirty and userfaultfd write protect tracking.
>
> V5: https://lore.kernel.org/all/20241113095833.1805746-1-zhangchunyan@iscas.ac.cn/
> - Fixed typos and corrected some words in Kconfig and commit message;
> - Removed pte_wrprotect() from pte_swp_mkuffd_wp(), this is a copy-paste
>   error;
> - Added Alex's Reviewed-by tag in patch 2.
>
> V4: https://lore.kernel.org/all/20240830011101.3189522-1-zhangchunyan@iscas.ac.cn/
> - Added bit(4) descriptions into "Format of swap PTE".
>
> V3: https://lore.kernel.org/all/20240805095243.44809-1-zhangchunyan@iscas.ac.cn/
> - Fixed the issue reported by kernel test irobot <lkp@intel.com>.
>
> V2: https://lore.kernel.org/all/20240731040444.3384790-1-zhangchunyan@iscas.ac.cn/
> - Add uffd-wp supported;
> - Make soft-dirty uffd-wp and devmap mutually exclusive which all use
>   the same PTE bit;
> - Add test results of CRIU in the cover-letter.
>
> Chunyan Zhang (6):
>   mm: softdirty: Add pgtable_supports_soft_dirty()
>   mm: userfaultfd: Add pgtable_supports_uffd_wp()
>   riscv: Add RISC-V Svrsw60t59b extension support
>   riscv: mm: Add soft-dirty page tracking support
>   riscv: mm: Add userfaultfd write-protect support
>   dt-bindings: riscv: Add Svrsw60t59b extension description
>
>  .../devicetree/bindings/riscv/extensions.yaml |   6 +
>  arch/riscv/Kconfig                            |  16 ++
>  arch/riscv/include/asm/hwcap.h                |   1 +
>  arch/riscv/include/asm/pgtable-bits.h         |  37 +++++
>  arch/riscv/include/asm/pgtable.h              | 143 +++++++++++++++++-
>  arch/riscv/kernel/cpufeature.c                |   1 +
>  fs/proc/task_mmu.c                            |  15 +-
>  fs/userfaultfd.c                              |  22 +--
>  include/asm-generic/pgtable_uffd.h            |  17 +++
>  include/linux/mm.h                            |   3 +
>  include/linux/mm_inline.h                     |   8 +-
>  include/linux/pgtable.h                       |  12 ++
>  include/linux/userfaultfd_k.h                 |  69 +++++----
>  mm/debug_vm_pgtable.c                         |  10 +-
>  mm/huge_memory.c                              |  13 +-
>  mm/internal.h                                 |   2 +-
>  mm/memory.c                                   |   6 +-
>  mm/mmap.c                                     |   6 +-
>  mm/mremap.c                                   |  13 +-
>  mm/userfaultfd.c                              |  10 +-
>  mm/vma.c                                      |   6 +-
>  mm/vma_exec.c                                 |   5 +-
>  22 files changed, 337 insertions(+), 84 deletions(-)
>
> --
> 2.34.1
>

