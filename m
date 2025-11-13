Return-Path: <linux-fsdevel+bounces-68186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5980CC560E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 08:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1478534D8F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 07:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D379C325702;
	Thu, 13 Nov 2025 07:28:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23072F693E;
	Thu, 13 Nov 2025 07:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763018938; cv=none; b=YthWRFn5FRhQCDqs9mNlgDiHcgoR99kICJm6LUBogLu9sOm42aq4Kc++3tpOEXZNbeBnp+dCIx056sJz0uRnDYskIFrHgAeoM/7fBId+OCYZIutl86+7C5CAP4QwaLj4Oav2T121sI3RZVCfv3PnxxGJ9asHyj0qHhWZgx5z6Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763018938; c=relaxed/simple;
	bh=+tWDQR/vm/v7tmTJUbQfSwGLeRfkVxgTd7ghh3TZwKc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S7JOriXfRTXyc9ClDAOrjzgIPV1txiRCL1A9nZvDFSNGjXRIVBMefTsHy9fJYdGR0el3fgmWocNw5eSOA5pr7gB5Byh465T6mj0SayTiJJdp3F/hGeA2sCwwjjIEVrLEnlmtMuJsLfO+FrWu+T1Ao6cob+7O1cE1ns4Kd+WZMOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ubt.. (unknown [210.73.43.101])
	by APP-05 (Coremail) with SMTP id zQCowABnbG2RiBVpVTOWAA--.33691S2;
	Thu, 13 Nov 2025 15:28:19 +0800 (CST)
From: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
To: Andrew Morton <akpm@linux-foundation.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-mm@kvack.org,
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
	linux-riscv@lists.infradead.org,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	devicetree@vger.kernel.org,
	Conor Dooley <conor@kernel.org>,
	Deepak Gupta <debug@rivosinc.com>,
	Ved Shanbhogue <ved@rivosinc.com>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V15 0/6] mm: Add soft-dirty and uffd-wp support for RISC-V
Date: Thu, 13 Nov 2025 15:28:00 +0800
Message-Id: <20251113072806.795029-1-zhangchunyan@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABnbG2RiBVpVTOWAA--.33691S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr18CrWDAF15CF43Zr4DXFb_yoW7tryUpF
	4UGry3tr4rtr1Iga93Xw109an0qan8tw15Gw1rX34rA3y2k3Wjvrna9a1rWF1DJr4UWryI
	qrWakr90934qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9mb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY
	04v7MxkF7I0En4kS14v26r4a6rW5MxkIecxEwVAFwVW8CwCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07ba4SwUUUUU=
X-CM-SenderInfo: x2kd0wxfkx051dq6x2xfdvhtffof0/1tbiDAYFB2kVaThzyQAAsf

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

This patchset applies on the mm/mm-new branch commit ea53cb52f919
("mm/vmalloc: cleanup gfp flag use in new_vmap_block()")

[1] https://github.com/riscv-non-isa/riscv-iommu/pull/543

V15:
- Rebased on to the latest mm-new branch;
- Removed a redundant space;
- Added Conor's Acked-by.

V14: https://lore.kernel.org/all/20250918083731.1820327-1-zhangchunyan@iscas.ac.cn/
- Fix indent inssues in userfaultfd_k.h;
- Some descriptions and comments minor changes.

V13: https://lore.kernel.org/all/20250917033703.1695933-1-zhangchunyan@iscas.ac.cn/
- Rebase on mm-new branch;
- Fixed build errors;
- Add more exactly descriptions in commit message in patch 1-2;
- Replace '__always_inline' with 'inline' for uffd_supports_wp_marker();
- Add Svrsw60t59b description to the extensions dt-binding in patch 6.

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
 include/linux/mm_inline.h                     |   8 +-
 include/linux/pgtable.h                       |  12 ++
 include/linux/userfaultfd_k.h                 |  69 +++++----
 mm/debug_vm_pgtable.c                         |  10 +-
 mm/huge_memory.c                              |  13 +-
 mm/internal.h                                 |   2 +-
 mm/memory.c                                   |   6 +-
 mm/mmap.c                                     |   6 +-
 mm/mremap.c                                   |  13 +-
 mm/userfaultfd.c                              |  10 +-
 mm/vma.c                                      |   6 +-
 mm/vma_exec.c                                 |   5 +-
 22 files changed, 337 insertions(+), 84 deletions(-)

-- 
2.34.1


