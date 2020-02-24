Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9169C169D50
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 06:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgBXFDh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 00:03:37 -0500
Received: from foss.arm.com ([217.140.110.172]:57634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgBXFDh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 00:03:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66CBD1FB;
        Sun, 23 Feb 2020 21:03:36 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.16.95])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6C51A3F534;
        Sun, 23 Feb 2020 21:03:33 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH V2 0/4] mm/vma: Use all available wrappers when possible
Date:   Mon, 24 Feb 2020 10:33:09 +0530
Message-Id: <1582520593-30704-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Apart from adding a VMA flag readable name for trace purpose, this series
does some open encoding replacements with availabe VMA specific wrappers.
This skips VM_HUGETLB check in vma_migratable() as its already being done
with another patch (https://patchwork.kernel.org/patch/11347831/) which
is yet to be merged.

This series applies on 5.6-rc3. This has been build tested on multiple
platforms, though boot and runtime testing was limited to arm64 and x86.

Cc: linux-kernel@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-mips@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-sh@vger.kernel.org
Cc: kvm-ppc@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org

Changes in V2:

- Dropped patch [PATCH 4/5] mm/vma: Replace....vma_set_anonymous() per Kirril
- Dropped braces around is_vm_hugetlb_page() in kvmppc_e500_shadow_map()
- Replaced two open encodings in mm/mmap.c with vma_is_accessible()
- Added hugetlb headers to prevent build failures wrt is_vm_hugetlb_page()

Changes in V1: (https://patchwork.kernel.org/cover/11385219/)

Anshuman Khandual (4):
  mm/vma: Add missing VMA flag readable name for VM_SYNC
  mm/vma: Make vma_is_accessible() available for general use
  mm/vma: Replace all remaining open encodings with is_vm_hugetlb_page()
  mm/vma: Replace all remaining open encodings with vma_is_anonymous()

 arch/csky/mm/fault.c             | 2 +-
 arch/m68k/mm/fault.c             | 2 +-
 arch/mips/mm/fault.c             | 2 +-
 arch/powerpc/kvm/e500_mmu_host.c | 2 +-
 arch/powerpc/mm/fault.c          | 2 +-
 arch/sh/mm/fault.c               | 2 +-
 arch/x86/mm/fault.c              | 2 +-
 fs/binfmt_elf.c                  | 3 ++-
 include/asm-generic/tlb.h        | 3 ++-
 include/linux/mm.h               | 5 +++++
 include/trace/events/mmflags.h   | 1 +
 kernel/events/core.c             | 3 ++-
 kernel/sched/fair.c              | 2 +-
 mm/gup.c                         | 5 +++--
 mm/memory.c                      | 5 -----
 mm/mempolicy.c                   | 3 +--
 mm/mmap.c                        | 5 ++---
 17 files changed, 26 insertions(+), 23 deletions(-)

-- 
2.20.1

