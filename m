Return-Path: <linux-fsdevel+bounces-61864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE11B7F895
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 15:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6682527100
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 03:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B9D2F548A;
	Wed, 17 Sep 2025 03:38:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1232BE656;
	Wed, 17 Sep 2025 03:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758080285; cv=none; b=CZGkYSaxC54+grsFOoAm0xMXGr010gKbBZLykgXKHik9Qqp9KvZevb1PnfzjCd4WUdNfmxryi9ZTlST8bImsqj6AH4xWYCP8D1r2JYgCrXHgTyHWDwEiYksFmLihB4v7fbcOqEcF1BZm7IFaHOkokuOI6ERylYP5rmLR1fju4uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758080285; c=relaxed/simple;
	bh=MrzlUtN2zfhfoSrvl3R7KvmvpP/OQ/YktUCjI57UoUk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mMO4rEqTBQH5YgJ2zUK+ZB8HSDdHKtnU3sp+WP/DycYV/gzNGDNGeH7ZIqU7ucMvX+6i5PG1AU4Ba683U07RQdUahfMYJg9BQc+gPKO8QPTJ5v4ycXVg4oIPJPb+2CITYrCtNancbW2vejoDwqNgqpnJ5dxsrpS6GE81HV34NxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ubt.. (unknown [210.73.43.101])
	by APP-03 (Coremail) with SMTP id rQCowABnsXvsLMpojtxAAw--.607S2;
	Wed, 17 Sep 2025 11:37:17 +0800 (CST)
From: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
To: linux-riscv@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Conor Dooley <conor@kernel.org>,
	Deepak Gupta <debug@rivosinc.com>,
	Ved Shanbhogue <ved@rivosinc.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V13 0/6] riscv: mm: Add soft-dirty and uffd-wp support
Date: Wed, 17 Sep 2025 11:36:57 +0800
Message-Id: <20250917033703.1695933-1-zhangchunyan@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABnsXvsLMpojtxAAw--.607S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr18CrW3AF1rtw1rZFWDurg_yoW7AFy5pF
	4UGry3tr4rtF1Ig393Jw109a1Yqan5t343Gw1rX34rA3y2k3Wjvrna9a1rGF1DJr48WryS
	qryYkr9I934qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9vb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkI
	wI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK67AK6r48MxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUYS2MUUUUUU==
X-CM-SenderInfo: x2kd0wxfkx051dq6x2xfdvhtffof0/1tbiBwkIB2jJ8O30wgAAsL

This patchset adds support for Svrsw60t59b [1] extension which is ratified now,
also add soft dirty and userfaultfd write protect tracking for RISC-V.

The patches 1 and 2 add macros to allow architectures to define their own checks
if the soft-dirty / uffd_wp PTE bits are available, in other words for RISC-V,
the Svrsw60t59b extension is supported on which device the kernel is running.
Also patch1-2 are removing "ifdef CONFIG_MEM_SOFT_DIRTY"
"ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP" and
"ifdef CONFIG_PTE_MARKER_UFFD_WP" in favor of checks which if not overridden by
the architecture, no change in behavior is expected.

This patchset has been tested with kselftest mm suite in which soft-dirty, 
madv_populate, test_unmerge_uffd_wp, and uffd-unit-tests run and pass,
and no regressions are observed in any of the other tests.

This patchset applies on top of the lastest mm-new branch.

[1] https://github.com/riscv-non-isa/riscv-iommu/pull/543

V13:
- Rebase on mm-new branch;
- Fixed build errors;
- Add more exactly descriptions in commit message in patch 1-2;
- Replace '__always_inline' with 'inline' for uffd_supports_wp_markeruffd_supports_wp_marker();
- Add description to the extensions dt-binding in patch 6.

V12: https://lore.kernel.org/all/20250915101343.1449546-1-zhangchunyan@iscas.ac.cn/
- Rename the macro API to pgtable_supports_soft_dirty/uffd_wp();
- Add changes for setting VM_SOFTDIRTY flags conditionally;
- Drop changes to show_smap_vma_flags();
- Drop CONFIG_MEM_SOFT_DIRTY compile condition of clear_soft_dirty() and clear_soft_dirty_pmd();
- Fix typos;
- Add uffd_supports_wp_marker() and drop some ifdef CONFIG_PTE_MARKER_UFFD_WP.

V11: https://lore.kernel.org/all/20250911095602.1130290-1-zhangchunyan@iscas.ac.cn/
- Rename the macro API to pgtable_*_supported() since we also have PMD support;
- Change the default implementations of two macros, make CONFIG_MEM_SOFT_DIRTY or
  CONFIG_HAVE_ARCH_USERFAULTFD_WP part of the macros;
- Correct the order of insertion of RISCV_ISA_EXT_SVRSW60T59B;
- Rephrase some comments.

V10: https://lore.kernel.org/all/20250909095611.803898-1-zhangchunyan@iscas.ac.cn/
- Fixed the issue reported by kernel test irobot <lkp@intel.com>.

V9: https://lore.kernel.org/all/20250905103651.489197-1-zhangchunyan@iscas.ac.cn/
- Add pte_soft_dirty/uffd_wp_available() API to allow dynamically checking
  if the PTE bit is available for the platform on which the kernel is running.

V8: https://lore.kernel.org/all/20250619065232.1786470-1-zhangchunyan@iscas.ac.cn/)
- Rebase on v6.16-rc1;
- Add dependencies to MMU && 64BIT for RISCV_ISA_SVRSW60T59B;
- Use 'Svrsw60t59b' instead of 'SVRSW60T59B' in Kconfig help paragraph;
- Add Alex's Reviewed-by tag in patch 1.

V7: https://lore.kernel.org/all/20250409095320.224100-1-zhangchunyan@iscas.ac.cn/
- Add Svrsw60t59b [1] extension support;
- Have soft-dirty and uffd-wp depending on the Svrsw60t59b extension to
  avoid crashes for the hardware which don't have this extension.

V6: https://lore.kernel.org/all/20250408084301.68186-1-zhangchunyan@iscas.ac.cn/
- Changes to use bits 59-60 which are supported by extension Svrsw60t59b
  for soft dirty and userfaultfd write protect tracking.

V5: https://lore.kernel.org/all/20241113095833.1805746-1-zhangchunyan@iscas.ac.cn/
- Fixed typos and corrected some words in Kconfig and commit message;
- Removed pte_wrprotect() from pte_swp_mkuffd_wp(), this is a copy-paste
  error;
- Added Alex's Reviewed-by tag in patch 2.

V4: https://lore.kernel.org/all/20240830011101.3189522-1-zhangchunyan@iscas.ac.cn/
- Added bit(4) descriptions into "Format of swap PTE".

V3: https://lore.kernel.org/all/20240805095243.44809-1-zhangchunyan@iscas.ac.cn/
- Fixed the issue reported by kernel test irobot <lkp@intel.com>.

V2: https://lore.kernel.org/all/20240731040444.3384790-1-zhangchunyan@iscas.ac.cn/
- Add uffd-wp supported;
- Make soft-dirty uffd-wp and devmap mutually exclusive which all use
  the same PTE bit;
- Add test results of CRIU in the cover-letter.

Chunyan Zhang (6):
  mm: softdirty: Add pgtable_supports_soft_dirty()
  mm: userfaultfd: Add pgtable_supports_uffd_wp()
  riscv: Add RISC-V Svrsw60t59b extension support
  riscv: mm: Add soft-dirty page tracking support
  riscv: mm: Add userfaultfd write-protect support
  dt-bindings: riscv: Add Svrsw60t59b extension description

 .../devicetree/bindings/riscv/extensions.yaml |   6 +
 arch/riscv/Kconfig                            |  16 ++
 arch/riscv/include/asm/hwcap.h                |   1 +
 arch/riscv/include/asm/pgtable-bits.h         |  37 +++++
 arch/riscv/include/asm/pgtable.h              | 143 +++++++++++++++++-
 arch/riscv/kernel/cpufeature.c                |   1 +
 fs/proc/task_mmu.c                            |  15 +-
 fs/userfaultfd.c                              |  22 +--
 include/asm-generic/pgtable_uffd.h            |  17 +++
 include/linux/mm.h                            |   3 +
 include/linux/mm_inline.h                     |  12 +-
 include/linux/pgtable.h                       |  12 ++
 include/linux/userfaultfd_k.h                 | 114 ++++++++------
 mm/debug_vm_pgtable.c                         |  10 +-
 mm/huge_memory.c                              |  13 +-
 mm/internal.h                                 |   2 +-
 mm/memory.c                                   |   6 +-
 mm/mmap.c                                     |   6 +-
 mm/mremap.c                                   |  13 +-
 mm/userfaultfd.c                              |  10 +-
 mm/vma.c                                      |   6 +-
 mm/vma_exec.c                                 |   5 +-
 22 files changed, 365 insertions(+), 105 deletions(-)

-- 
2.34.1


