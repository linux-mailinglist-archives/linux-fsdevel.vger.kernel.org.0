Return-Path: <linux-fsdevel+bounces-60347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AABB45540
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 12:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7320AA64E25
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 10:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C78314A64;
	Fri,  5 Sep 2025 10:47:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615DF313E2D;
	Fri,  5 Sep 2025 10:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757069231; cv=none; b=VQSyAhr7KT92aI472VwYloyg/fKK8jdT5KxBGGAZEQLCXPhoA0u8LCmwC3MnqvGip6iOuTHqb/87GzQH1C4xEb/UZULeoPJpGQGWX0SRgQuIk7nknIgSqiTr0s4LxhlP+yYskKe8GaUv8BVU9kByag9fB0XSDUWfcGOBUIgJ+bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757069231; c=relaxed/simple;
	bh=lcz6zqp2kq+0fky1oTilOhrS9MwUZf+khKH55vKwiDg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JyjWt4nPPX0DgpaIKahN8zd/GI57S1O/HhgJfcXBTYxPCzPQS+16HoFambQq9BMah+gLwy8cHWBxYCXUuN9G1cXp1DhmBYzjYflMKzve2rtjIkTcEiN8/sNIRnIk5w+Dc9OY5HXMRZvFYsYDFCU4vCw6F4CsUydcrRDhxw8PFpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ubt.. (unknown [210.73.43.101])
	by APP-01 (Coremail) with SMTP id qwCowABnwaNMvbpoocLNAA--.50311S2;
	Fri, 05 Sep 2025 18:37:01 +0800 (CST)
From: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
To: linux-riscv@lists.infradead.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Morton <akpm@linux-foundation.org>,
	Deepak Gupta <debug@rivosinc.com>,
	Ved Shanbhogue <ved@rivosinc.com>,
	Peter Xu <peterx@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jan Kara <jack@suse.cz>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Wei Xu <weixugc@google.com>,
	David Hildenbrand <david@redhat.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH v9 0/5] riscv: mm: Add soft-dirty and uffd-wp support
Date: Fri,  5 Sep 2025 18:36:46 +0800
Message-Id: <20250905103651.489197-1-zhangchunyan@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnwaNMvbpoocLNAA--.50311S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw47ZF48Kr17Jr1rJryxKrg_yoW5Wr18pF
	s8K343KryrJFyIyrs3C34jkF1Fqa1kW34rGa43J3s5J3yagF1jvrn5C3W8KF18JF48uFWS
	9ry5uryru3yqy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvlb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xK
	xwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07j9gAwUUUUU=
X-CM-SenderInfo: x2kd0wxfkx051dq6x2xfdvhtffof0/1tbiCRAQB2i6ooVpxgAAsU

This patchset adds support for Svrsw60t59b [1] extension which is ratified now,
also soft dirty and userfaultfd write protect tracking for RISC-V.

This patchset has been tested with kselftest mm suite in which soft-dirty, 
madv_populate, test_unmerge_uffd_wp, and uffd-unit-tests run and pass,
and no regressions are observed in any of the other tests.

This patchset applies on top of v6.17-rc4.

V9:
- Add pte_soft_dirty/uffd_wp_available() API to allow dynamically checking
  if the PTE bit is available for the platform on which the kernel is running.

V8: (https://lore.kernel.org/all/20250619065232.1786470-1-zhangchunyan@iscas.ac.cn/)
- Rebase on v6.16-rc1;
- Add dependencies to MMU && 64BIT for RISCV_ISA_SVRSW60T59B;
- Use 'Svrsw60t59b' instead of 'SVRSW60T59B' in Kconfig help paragraph;
- Add Alex's Reviewed-by tag in patch 1.

V7: (https://lore.kernel.org/all/20250409095320.224100-1-zhangchunyan@iscas.ac.cn/)
- Add Svrsw60t59b [1] extension support;
- Have soft-dirty and uffd-wp depending on the Svrsw60t59b extension to
  avoid crashes for the hardware which don't have this extension.

V6:
- Changes to use bits 59-60 which are supported by extension Svrsw60t59b
  for soft dirty and userfaultfd write protect tracking.

V5:
- Fixed typos and corrected some words in Kconfig and commit message;
- Removed pte_wrprotect() from pte_swp_mkuffd_wp(), this is a copy-paste
  error;
- Added Alex's Reviewed-by tag in patch 2.

V4:
- Added bit(4) descriptions into "Format of swap PTE".

V3:
- Fixed the issue reported by kernel test irobot <lkp@intel.com>.

V1 -> V2:
- Add uffd-wp supported;
- Make soft-dirty uffd-wp and devmap mutually exclusive which all use
  the same PTE bit;
- Add test results of CRIU in the cover-letter.

[1] https://github.com/riscv-non-isa/riscv-iommu/pull/543

Chunyan Zhang (5):
  mm: softdirty: Add pte_soft_dirty_available()
  mm: uffd_wp: Add pte_uffd_wp_available()
  riscv: Add RISC-V Svrsw60t59b extension support
  riscv: mm: Add soft-dirty page tracking support
  riscv: mm: Add uffd write-protect support

 arch/riscv/Kconfig                    |  16 +++
 arch/riscv/include/asm/hwcap.h        |   1 +
 arch/riscv/include/asm/pgtable-bits.h |  37 +++++++
 arch/riscv/include/asm/pgtable.h      | 140 +++++++++++++++++++++++++-
 arch/riscv/kernel/cpufeature.c        |   1 +
 fs/proc/task_mmu.c                    |  12 ++-
 fs/userfaultfd.c                      |  25 +++--
 include/asm-generic/pgtable_uffd.h    |  12 +++
 include/linux/mm_inline.h             |   6 +-
 include/linux/pgtable.h               |  10 ++
 include/linux/userfaultfd_k.h         |  44 +++++---
 mm/debug_vm_pgtable.c                 |   9 +-
 mm/huge_memory.c                      |  13 +--
 mm/internal.h                         |   2 +-
 mm/memory.c                           |   6 +-
 mm/mremap.c                           |  13 +--
 mm/userfaultfd.c                      |  12 +--
 17 files changed, 302 insertions(+), 57 deletions(-)

-- 
2.34.1


