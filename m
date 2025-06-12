Return-Path: <linux-fsdevel+bounces-51433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFF2AD6E41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 12:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2901883CFA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 10:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00034239E97;
	Thu, 12 Jun 2025 10:51:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A0F223339;
	Thu, 12 Jun 2025 10:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749725482; cv=none; b=g5eXwWe923h0yIXIeOc+CNHYuG+CuLK4LkfzEHyYJYNjx+cNawKnPy6sUJNGf3bnzrWuNHbDORfSn7HPOC5mMOWUbKxAon1f93FRUhEyDgcF4UJh+XPdogGzibRWCjH77qaUZX0YdzF2lmL2LlLSEpo+e3OOtFfuCi+RTl9oTIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749725482; c=relaxed/simple;
	bh=RTUyZzHc5+IhRr21BI9rWRtv9QEQ6vyWa/gmEwdxm6o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LZvJEVNbXW1NF5u3jryUraTVrZJEcL+kBruqOQaL4/bzs7nM47LqKIGdcjnVpbRAY3sVpuZ3pJpUXhmuqKApVyUSkGKlgq2PZzErMpGe/8SML/ONd2Z5EwGuyA/YcQmO+Vwzt/5OFxq/SKPO04ssBrcCz2WTFMhewhLN7kmmfSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=pankajraghav.com; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bHzpk5YtZz9t13;
	Thu, 12 Jun 2025 12:51:10 +0200 (CEST)
From: Pankaj Raghav <p.raghav@samsung.com>
To: Suren Baghdasaryan <surenb@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nico Pache <npache@redhat.com>,
	Dev Jain <dev.jain@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org,
	x86@kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	kernel@pankajraghav.com,
	hch@lst.de,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 0/5] add STATIC_PMD_ZERO_PAGE config option
Date: Thu, 12 Jun 2025 12:50:55 +0200
Message-ID: <20250612105100.59144-1-p.raghav@samsung.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are many places in the kernel where we need to zeroout larger
chunks but the maximum segment we can zeroout at a time by ZERO_PAGE
is limited by PAGE_SIZE.

This concern was raised during the review of adding Large Block Size support
to XFS[1][2].

This is especially annoying in block devices and filesystems where we
attach multiple ZERO_PAGEs to the bio in different bvecs. With multipage
bvec support in block layer, it is much more efficient to send out
larger zero pages as a part of a single bvec.

Some examples of places in the kernel where this could be useful:
- blkdev_issue_zero_pages()
- iomap_dio_zero()
- vmalloc.c:zero_iter()
- rxperf_process_call()
- fscrypt_zeroout_range_inline_crypt()
- bch2_checksum_update()
...

We already have huge_zero_folio that is allocated on demand, and it will be
deallocated by the shrinker if there are no users of it left.

But to use huge_zero_folio, we need to pass a mm struct and the
put_folio needs to be called in the destructor. This makes sense for
systems that have memory constraints but for bigger servers, it does not
matter if the PMD size is reasonable (like in x86).

Add a config option STATIC_PMD_ZERO_PAGE that will always allocate
the huge_zero_folio in .bss, and it will never be freed.

The static PMD page is reused by huge_zero_folio when this config
option is enabled.

I have converted blkdev_issue_zero_pages() as an example as a part of
this series.

I will send patches to individual subsystems using the huge_zero_folio
once this gets upstreamed.

Looking forward to some feedback.

[1] https://lore.kernel.org/linux-xfs/20231027051847.GA7885@lst.de/
[2] https://lore.kernel.org/linux-xfs/ZitIK5OnR7ZNY0IG@infradead.org/

Changes since RFC:
- Added the config option based on the feedback from David.
- Encode more info in the header to avoid dead code (Dave hansen
  feedback)
- The static part of huge_zero_folio in memory.c and the dynamic part
  stays in huge_memory.c
- Split the patches to make it easy for review.

Pankaj Raghav (5):
  mm: move huge_zero_page declaration from huge_mm.h to mm.h
  huge_memory: add huge_zero_page_shrinker_(init|exit) function
  mm: add static PMD zero page
  mm: add mm_get_static_huge_zero_folio() routine
  block: use mm_huge_zero_folio in __blkdev_issue_zero_pages()

 arch/x86/Kconfig               |  1 +
 arch/x86/include/asm/pgtable.h |  8 +++++
 arch/x86/kernel/head_64.S      |  8 +++++
 block/blk-lib.c                | 17 +++++----
 include/linux/huge_mm.h        | 31 ----------------
 include/linux/mm.h             | 64 ++++++++++++++++++++++++++++++++++
 mm/Kconfig                     | 13 +++++++
 mm/huge_memory.c               | 62 ++++++++++++++++++++++++--------
 mm/memory.c                    | 19 ++++++++++
 9 files changed, 170 insertions(+), 53 deletions(-)


base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.49.0


