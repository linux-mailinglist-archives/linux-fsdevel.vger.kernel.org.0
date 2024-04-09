Return-Path: <linux-fsdevel+bounces-16471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C09A89E337
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 21:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E678E28361F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 19:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6067115746E;
	Tue,  9 Apr 2024 19:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S0pg5XIR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA51B15746C
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 19:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712690623; cv=none; b=D/6hH5Tb2LcT6pDu4StVl3I8+yxS83YBwY7N91SzS3+oXegZ1IuDEUr9GfiT82lypvy3XVX0xToLGoDIYEvikYBWNs0eEN4evSK0inVIFBBkRlNMa7KcBiiiMAa6QH5nv+gC+q/n0YvzWXAOXUhBRpZGpLnzvVxazHwhwwFeXo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712690623; c=relaxed/simple;
	bh=7q15DdmyUVZxJOE4lhL7AMeazKQwnySJ3OuJZt7ZlpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N650AkLMgLbiihst5hJA4qRhMD5Apx9A9GJTGDs3uBMyAUStJg2tYpzQGUamtzsHODIGNOEKL5PN1TVWyMVD4I8+k/RR/KGINvcPqtO6RThzqYkjMSd7zKhOsdDGLoLnrSm78/eohzLIoEbubZDaGIMtfPkahe/3uM/NTIlmpsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S0pg5XIR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712690616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TMgTsHOMAcz2aHp/mH0puI+1mQGKc2ZZZ7iHFFMIZj4=;
	b=S0pg5XIRCB2kVLgmcaFlK4DcQ4h7WKRdhasQaJKE7vnA3gSZ3qDSjfi/ge1QtVICZ8kNLP
	XLxCc/fqmAseS4bW00kU5HWoXhc6UXW2AqwDxuU4GDoejwkXHHggvxFz9PWvzHvjqwXrd6
	GrKdg/vC8xl73wLBvek8QUNW7so7yxo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-RG_wslZHPLGPeceHYFOmDw-1; Tue,
 09 Apr 2024 15:23:33 -0400
X-MC-Unique: RG_wslZHPLGPeceHYFOmDw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 397963C100CD;
	Tue,  9 Apr 2024 19:23:32 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.106])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 43E8F40AE787;
	Tue,  9 Apr 2024 19:23:22 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Peter Xu <peterx@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Yang Shi <shy828301@gmail.com>,
	Zi Yan <ziy@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Hugh Dickins <hughd@google.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Muchun Song <muchun.song@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Richard Chang <richardycc@google.com>
Subject: [PATCH v1 00/18] mm: mapcount for large folios + page_mapcount() cleanups
Date: Tue,  9 Apr 2024 21:22:43 +0200
Message-ID: <20240409192301.907377-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

This series tracks the mapcount of large folios in a single value, so
it can be read efficiently and atomically, just like the mapcount of
small folios.

folio_mapcount() is then used in a couple more places, most notably to
reduce false negatives in folio_likely_mapped_shared(), and many users of
page_mapcount() are cleaned up (that's maybe why you got CCed on the
full series, sorry sh+xtensa folks! :) ).

The remaining s390x user and one KSM user of page_mapcount() are getting
removed separately on the list right now. I have patches to handle the
other KSM one, the khugepaged one and the kpagecount one; as they are not
as "obvious", I will send them out separately in the future. Once that is
all in place, I'm planning on moving page_mapcount() into
fs/proc/task_mmu.c, the remaining user for the time being (and we can
discuss at LSF/MM details on that :) ).

I proposed the mapcount for large folios (previously called total
mapcount) originally in part of [1] and I later included it in [2] where
it is a requirement. In the meantime, I changed the patch a bit so I
dropped all RB's. During the discussion of [1], Peter Xu correctly raised
that this additional tracking might affect the performance when
PMD->PTE remapping THPs. In the meantime. I addressed that by batching RMAP
operations during fork(), unmap/zap and when PMD->PTE remapping THPs.

Running some of my micro-benchmarks [3] (fork,munmap,cow-byte,remap) on 1
GiB of memory backed by folios with the same order, I observe the following
on an Intel(R) Xeon(R) Silver 4210R CPU @ 2.40GHz tuned for reproducible
results as much as possible:

Standard deviation is mostly < 1%, except for order-9, where it's < 2% for
fork() and munmap().

(1) Small folios are not affected (< 1%) in all 4 microbenchmarks.
(2) Order-4 folios are not affected (< 1%) in all 4 microbenchmarks. A bit
    weird comapred to the other orders ...
(3) PMD->PTE remapping of order-9 THPs is not affected (< 1%)
(4) COW-byte (COWing a single page by writing a single byte) is not
    affected for any order (< 1 %). The page copy_fault overhead dominates
    everything.
(5) fork() is mostly not affected (< 1%), except order-2, where we have
    a slowdown of ~4%. Already for order-3 folios, we're down to a slowdown
    of < 1%.
(6) munmap() sees a slowdown by < 3% for some orders (order-5,
    order-6, order-9), but less for others (< 1% for order-4 and order-8,
    < 2% for order-2, order-3, order-7).

Especially the fork() and munmap() benchmark are sensitive to each added
instruction and other system noise, so I suspect some of the change and
observed weirdness (order-4) is due to code layout changes and other
factors, but not really due to the added atomics.

So in the common case where we can batch, the added atomics don't really
make a big difference, especially in light of the recent improvements for
large folios that we recently gained due to batching. Surprisingly, for
some cases where we cannot batch (e.g., COW), the added atomics don't seem
to matter, because other overhead dominates.

My fork and munmap micro-benchmarks don't cover cases where we cannot
batch-process bigger parts of large folios. As this is not the common case,
I'm not worrying about that right now.

Future work is batching RMAP operations during swapout and folio
migration.

Not CCing everybody (e.g., cgroups folks just because of the doc
updated) recommended by get_maintainers, to reduce noise. Tested on
x86-64, compile-tested on a bunch of other archs. Will do more testing
in the upcoming days.

[1] https://lore.kernel.org/all/20230809083256.699513-1-david@redhat.com/
[2] https://lore.kernel.org/all/20231124132626.235350-1-david@redhat.com/
[3] https://gitlab.com/davidhildenbrand/scratchspace/-/raw/main/pte-mapped-folio-benchmarks.c?ref_type=heads

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yin Fengwei <fengwei.yin@intel.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Hugh Dickins <hughd@google.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Richard Chang <richardycc@google.com>

David Hildenbrand (18):
  mm: allow for detecting underflows with page_mapcount() again
  mm/rmap: always inline anon/file rmap duplication of a single PTE
  mm/rmap: add fast-path for small folios when
    adding/removing/duplicating
  mm: track mapcount of large folios in single value
  mm: improve folio_likely_mapped_shared() using the mapcount of large
    folios
  mm: make folio_mapcount() return 0 for small typed folios
  mm/memory: use folio_mapcount() in zap_present_folio_ptes()
  mm/huge_memory: use folio_mapcount() in zap_huge_pmd() sanity check
  mm/memory-failure: use folio_mapcount() in hwpoison_user_mappings()
  mm/page_alloc: use folio_mapped() in __alloc_contig_migrate_range()
  mm/migrate: use folio_likely_mapped_shared() in
    add_page_for_migration()
  sh/mm/cache: use folio_mapped() in copy_from_user_page()
  mm/filemap: use folio_mapcount() in filemap_unaccount_folio()
  mm/migrate_device: use folio_mapcount() in migrate_vma_check_page()
  trace/events/page_ref: trace the raw page mapcount value
  xtensa/mm: convert check_tlb_entry() to sanity check folios
  mm/debug: print only page mapcount (excluding folio entire mapcount)
    in __dump_folio()
  Documentation/admin-guide/cgroup-v1/memory.rst: don't reference
    page_mapcount()

 .../admin-guide/cgroup-v1/memory.rst          |  4 +-
 Documentation/mm/transhuge.rst                | 12 +--
 arch/sh/mm/cache.c                            |  2 +-
 arch/xtensa/mm/tlb.c                          | 11 +--
 include/linux/mm.h                            | 77 +++++++++++--------
 include/linux/mm_types.h                      |  5 +-
 include/linux/rmap.h                          | 40 +++++++++-
 include/trace/events/page_ref.h               |  4 +-
 mm/debug.c                                    | 12 +--
 mm/filemap.c                                  |  2 +-
 mm/huge_memory.c                              |  2 +-
 mm/hugetlb.c                                  |  4 +-
 mm/internal.h                                 |  3 +
 mm/khugepaged.c                               |  2 +-
 mm/memory-failure.c                           |  4 +-
 mm/memory.c                                   |  3 +-
 mm/migrate.c                                  |  2 +-
 mm/migrate_device.c                           | 12 +--
 mm/page_alloc.c                               | 12 ++-
 mm/rmap.c                                     | 60 +++++++--------
 20 files changed, 163 insertions(+), 110 deletions(-)

-- 
2.44.0


