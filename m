Return-Path: <linux-fsdevel+bounces-49663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E78AC0821
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 11:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6443E4A3BCE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 09:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8617F286895;
	Thu, 22 May 2025 09:03:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A9025487C;
	Thu, 22 May 2025 09:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904586; cv=none; b=CF6Y/Gqfp0lTZKk/ytCR1ZDels5DjnFGvn//0sEhdBjsfUU0eTz3htogHU94sNs7iPoj0qtfWpPnYOXDErY/vMocg9+APwKeGWfD4QNYwHbA9wvaTT2/wxgERfX2zgC3XgenCgsJJbir282tCLAsMv8su7EszlZsWyeBk48G43Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904586; c=relaxed/simple;
	bh=yT1vovEWxBKzhS4iI2jBKX2WkXj4S3BUZDAob//KnbY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CWd4NhENw9grYkC75XVi6t+x466paBzona/WoTp4R8ca8G9pUp/9chFqmkrGh/itjM0sMXiMC/NrwhpFyFeCFDlp3fmlZIgKBiHK3AzRpjuyKzI/rcGf5M/gGgsgCcs/7OvN9WnvpzyOL4MEeuxDumjJL9G/wOrWswHoKCgeYn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=pankajraghav.com; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4b32PV1rhnz9sc4;
	Thu, 22 May 2025 11:02:54 +0200 (CEST)
From: Pankaj Raghav <p.raghav@samsung.com>
To: Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
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
	Zi Yan <ziy@nvidia.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	gost.dev@samsung.com,
	kernel@pankajraghav.com,
	hch@lst.de,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org,
	x86@kernel.org,
	mcgrof@kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC v2 0/2] add THP_HUGE_ZERO_PAGE_ALWAYS config option
Date: Thu, 22 May 2025 11:02:41 +0200
Message-ID: <20250522090243.758943-1-p.raghav@samsung.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4b32PV1rhnz9sc4

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
matter if the PMD size is reasonable (like x86).

Add a config option THP_HUGE_ZERO_PAGE_ALWAYS that will always allocate
the huge_zero_folio, and it will never be freed. This makes using the
huge_zero_folio without having to pass any mm struct and a call to put_folio
in the destructor.

I have converted blkdev_issue_zero_pages() as an example as a part of
this series.

I will send patches to individual subsystems using the huge_zero_folio
once this gets upstreamed.

Looking forward to some feedback.

[1] https://lore.kernel.org/linux-xfs/20231027051847.GA7885@lst.de/
[2] https://lore.kernel.org/linux-xfs/ZitIK5OnR7ZNY0IG@infradead.org/

Changes since v1:
- Added the config option based on the feedback from David.
- Removed iomap patches so that I don't clutter this series with too
  many subsystems.

Pankaj Raghav (2):
  mm: add THP_HUGE_ZERO_PAGE_ALWAYS config option
  block: use mm_huge_zero_folio in __blkdev_issue_zero_pages()

 arch/x86/Kconfig |  1 +
 block/blk-lib.c  | 15 +++++++++---
 mm/Kconfig       | 12 +++++++++
 mm/huge_memory.c | 63 ++++++++++++++++++++++++++++++++++++++----------
 4 files changed, 74 insertions(+), 17 deletions(-)


base-commit: f1f6aceb82a55f87d04e2896ac3782162e7859bd
-- 
2.47.2


