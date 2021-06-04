Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE41E39B42F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 09:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhFDHpU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Jun 2021 03:45:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229917AbhFDHpU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Jun 2021 03:45:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DA2F613AE;
        Fri,  4 Jun 2021 07:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622792614;
        bh=WrDpt4hAcOHkwVevesF63swf+VlR+oxSw38ZXyr++TM=;
        h=From:To:Cc:Subject:Date:From;
        b=FOM0bCh2FbV/zHyahOdf1uYgAIDe3d9D1Gg/1CDo0bklPT3ktjNiHyXcmTQe/+sVB
         3ATjIyEJ4xuCdDig+H/DSdnN024YaTne/0ITy/Ytiyj0Q2LQ10lYGqt6FdAJ0wbKaT
         yJukzlWtlJvQ0WmK5Fx3DMC9oHAT3nk7i8OEvSRRgWQQEmB07OqyjG+zzYCg5zwTA/
         qi1TpLLvvgwMc/zhgDU+ZsRPq2y2BdwHMVbcTjE3dPm/YvDZsomRktHAk8gWcvPAoV
         4lYVhvUcs8HwNjCbwcinB8ERqZvkY9Fc45u00HsgoXNqddPq+fz8LbyYMStn3LhU0s
         yqOb5UgVgZ+Pw==
From:   Ming Lin <mlin@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Simon Ser <contact@emersion.fr>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v2 0/2] mm: support NOSIGBUS on fault of mmap
Date:   Fri,  4 Jun 2021 00:43:20 -0700
Message-Id: <1622792602-40459-1-git-send-email-mlin@kernel.org>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These 2 patches are based on the discussion of "Sealed memfd & no-fault mmap"
at https://bit.ly/3pdwOGR

v2:
- make MAP_NOSIGBUS generic instead of being restricted to shmem
- use do_anonymous_page() to insert zero page
- fix build warnings/errors reported by LKP test robot

v1:
https://lkml.org/lkml/2021/6/1/1076

Ming Lin (2):
  mm: make "vm_flags" be an u64
  mm: adds NOSIGBUS extension to mmap()

 arch/arm64/Kconfig                           |   1 -
 arch/parisc/include/uapi/asm/mman.h          |   1 +
 arch/powerpc/Kconfig                         |   1 -
 arch/x86/Kconfig                             |   1 -
 drivers/android/binder.c                     |   6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c     |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c    |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c      |   2 +-
 drivers/infiniband/hw/hfi1/file_ops.c        |   2 +-
 drivers/infiniband/hw/qib/qib_file_ops.c     |   4 +-
 fs/exec.c                                    |   2 +-
 fs/userfaultfd.c                             |   6 +-
 include/linux/huge_mm.h                      |   4 +-
 include/linux/ksm.h                          |   4 +-
 include/linux/mm.h                           | 108 +++++++++++++--------------
 include/linux/mm_types.h                     |   6 +-
 include/linux/mman.h                         |   5 +-
 include/uapi/asm-generic/mman-common.h       |   1 +
 mm/Kconfig                                   |   2 -
 mm/debug.c                                   |   4 +-
 mm/khugepaged.c                              |   2 +-
 mm/ksm.c                                     |   2 +-
 mm/madvise.c                                 |   2 +-
 mm/memory.c                                  |  15 +++-
 mm/mmap.c                                    |  14 ++--
 mm/mprotect.c                                |   4 +-
 mm/mremap.c                                  |   2 +-
 tools/include/uapi/asm-generic/mman-common.h |   1 +
 28 files changed, 108 insertions(+), 98 deletions(-)

-- 
1.8.3.1

