Return-Path: <linux-fsdevel+bounces-27901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A51C4964C3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 18:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE416B2353B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 16:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A3E1B5ED4;
	Thu, 29 Aug 2024 16:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Grp/mBlY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD5C1B5EAD
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 16:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950618; cv=none; b=QXZcmgMRFrWugO3cldzceOYZDovD4q8jSPCsAYlIomZwHCQ4KwtrmTJHCQ/hLAbdWghmA8D2klv4UpjR+QrnuglA5+mZbBXAzOHbyX5BF9mT5kqJ2El9GphdiKEHq+xcyNubhpmOTvE56OuACDioqgAzG3pwjbVyBoVANhS0HdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950618; c=relaxed/simple;
	bh=/ub3L2kK+K2jf5lLrtmCxIf3zW7bd3LddAqnISUAFxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A+FfpmNmfLSsc5JHa1jv5TxEzELdhnsVI136dVCceXUsZ718kXMD4y1lVi55HVv7u4OONkpPDTXCpZra8p3AtC3JbSSnLwkD8ou+8gXK3hIkQZEZNWksb4tiN2DdRHlfB6ute9vg+HojtDha5nvLkp8YEB1GqNjLGhSenb0Zt8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Grp/mBlY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724950614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WPfeJ9iInySc4M0GDUTsyxt4nEunRxFuq3mNL7lmknw=;
	b=Grp/mBlYcyjhETSghPZaERH0/djSaUtpdEX1pxKdw1gBX+bjWootFrHe+jTgJ4HKt+Xmv2
	JH6ovZtfZHwCVcN35SN2tNC3CI1usHwUvMstLTyOtrfunAqowDlX8SxbDgBr3ZrEjWNyaK
	c99DbIaJivbWuEEwpC5H25E6xsyev5k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-WI0M_D3PMuyydDrWwMCecQ-1; Thu,
 29 Aug 2024 12:56:51 -0400
X-MC-Unique: WI0M_D3PMuyydDrWwMCecQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8ECA1955BE7;
	Thu, 29 Aug 2024 16:56:47 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.245])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2BC2D1955F66;
	Thu, 29 Aug 2024 16:56:28 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	x86@kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v1 00/17] mm: MM owner tracking for large folios (!hugetlb) + CONFIG_NO_PAGE_MAPCOUNT
Date: Thu, 29 Aug 2024 18:56:03 +0200
Message-ID: <20240829165627.2256514-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

RMAP overhaul and optimizations, PTE batching, large mapcount,
folio_likely_mapped_shared() introduction and optimizations, page_mapcount
cleanups and preparations ... it's been quite some work to get to this
point.

Next up is being able to identify -- without false positives, without
page-mapcounts and without page table/rmap scanning -- whether a
large folio is "mapped exclusively" into a single MM, and using that
information to implement Copy-on-Write reuse and to improve
folio_likely_mapped_shared() for large folios.

... and based on that, finally introducing a kernel config option that
let's us not use+maintain per-page mapcounts in large folios, improving
performance of (un)map operations today, taking one step towards
supporting large folios  > PMD_SIZE, and preparing for the bright future
where we might no longer have a mapcount per page at all.

The bigger picture was presented at LSF/MM [1].

This series is effectively a follow-up on my early work from last
year [2], which proposed a precise way to identify whether a large folio is
"mapped shared" into multiple MMs or "mapped exclusively" into a single MM.

While that advanced approach has been simplified and optimized in the
meantime, let's start with something simpler first -- "certainly mapped
exclusive" vs. ""maybe mapped shared" -- so we can start learning about
the effects and TODOs that some of the implied changes of losing
per-page mapcounts has.

I have plans to exchange the simple approach used in this series at some
point by the advanced approach, but one important thing to learn if the
imprecision in the simple approach is relevant in practice.

64BIT only, and unless enabled in kconfig, this series should for now
not have any impact.


1) Patch Organization
=====================

Patch #1 -> #4: make more room on 64BIT in order-1 folios

Patch #5 -> #7: prepare for MM owner tracking of large folios

Patch #8: implement a simple MM owner tracking approach for large folios

patch #9: simple optimization

Patch #10: COW reuse for PTE-mapped anon THP

Patch #11 -> #17: introduce and implement CONFIG_NO_PAGE_MAPCOUNT


2) MM owner tracking
====================

Similar to my advanced approach [2], we assign each MM a unique 20-bit ID
("MM ID"), to be able to squeeze more information in our folios.

Each large folios can store two MM-ID+mapcount combination:
* mm0_id + mm0_mapcount
* mm1_id + mm1_mapcount

Combined with the large mapcount, we can reliably identify whether one
of these MMs is the current owner (-> owns all mappings) or even holds
all folio references (-> owns all mappings, and all references are from
mappings).

Stored MM IDs can only change if the corresponding mapcount is logically
0, and if the folio is currently "mapped exclusively".

As long as only two MMs map folio pages at a time, we can reliably identify
whether a large folio is "mapped shared" or "mapped exclusively". The
approach is precise.

Any MM mapping the folio while two other MMs are already mapping the folio,
will lead to a "mapped shared" detection even after all other MMs stopped
mapping the folio and it is actually "mapped exclusively": we can have
false positives but never false negatives when detecting "mapped shared".

So that's where the approach gets imprecise.

For now, we use a bit-spinlock to sync the large mapcount + MM IDs + MM
mapcounts, and make sure we do keep the machinery fast, to not degrade
(un)map performance too much: for example, we make sure to only use a
single atomic (when grabbing the bit-spinlock), like we would already
perform when updating the large mapcount.

In the future, we might be able to use an arch_spin_lock(), but that's
future work.


3) CONFIG_NO_PAGE_MAPCOUNT
==========================

patch #11 -> #17 spell out and document what exactly is affected when
not maintaining the per-page mapcounts in large folios anymore.

For example, as we cannot maintain folio->_nr_pages_mapped anymore when
(un)mapping pages, we'll account a complete folio as mapped if a
single page is mapped.

As another example, we might now under-estimate the USS (Unique Set Size)
of a process, but never over-estimate it.

With a more elaborate approach for MM-owner tracking like #1, some things
could be improved (e.g., USS to some degree), but somethings just cannot be
handled like we used to without these per-page mapcounts (e.g.,
folio->_nr_pages_mapped).


4) Performance
==============

The following kernel config combinations are possible:

* Base: CONFIG_PAGE_MAPCOUNT
  -> (existing) page-mapcount tracking
* MM-ID: CONFIG_MM_ID && CONFIG_PAGE_MAPCOUNT
  -> page-mapcount + MM-ID tracking
* No-Mapcount: CONFIG_MM_ID && CONFIG_NO_PAGE_MAPCOUNT
  -> MM-ID tracking


I run my PTE-mapped-THP microbenchmarks [3] and vm-scalability on a machine
with two NUMA nodes, with a 10-core Intel(R) Xeon(R) Silver 4210R CPU @
2.40GHz and 16 GiB of memory each.

4.1) PTE-mapped-THP microbenchmarks
-----------------------------------

All benchmarks allocate 1 GiB of THPs of a given size, to then fork()/
munmap/... PMD-sized THPs are mapped by PTEs first.

Numbers are increase (+) / reduction (-) in runtime. Reduction (-) is
good. "Base" is the baseline.

munmap: munmap() the allocated memory.

Folio Size |  MM-ID | No-Mapcount
--------------------------------
    16 KiB |   2 % |        -8 %
    32 KiB |   3 % |        -9 %
    64 KiB |   4 % |       -16 %
   128 KiB |   3 % |       -17 %
   256 KiB |   1 % |       -23 %
   512 KiB |   1 % |       -26 %
  1024 KiB |   0 % |       -29 %
  2048 KiB |   0 % |       -31 %

-> 32-128 with MM-ID are a bit unexpected: we would expect to see the worst
   case with the smallest size (16 KiB). But for these sizes also the STDEV
   is between 1% and 2%, in contrast to the others (< 1 %). Maybe some
   weird interaction with PCP/buddy.

fork: fork()

Folio Size |  MM-ID | No-Mapcount
--------------------------------
    16 KiB |    4 % |       -9 %
    32 KiB |    1 % |      -12 %
    64 KiB |    0 % |      -15 %
   128 KiB |    0 % |      -15 %
   256 KiB |    0 % |      -16 %
   512 KiB |    0 % |      -16 %
  1024 KiB |    0 % |      -17 %
  2048 KiB |   -1 % |      -21 %

-> Slight slowdown with MM-ID for the smallest folio size (more what we
expect in contrast to munmap()).

cow-byte: fork() and keep the child running. write one byte to each
  individual page, measuring the duration of all writes.

Folio Size |  MM-ID | No-Mapcount
--------------------------------
    16 KiB |    0 % |        0 %
    32 KiB |    0 % |        0 %
    64 KiB |    0 % |        0 %
   128 KiB |    0 % |        0 %
   256 KiB |    0 % |        0 %
   512 KiB |    0 % |        0 %
  1024 KiB |    0 % |        0 %
  2048 KiB |    0 % |        0 %

-> All other overhead dominates even when effectively unmapping
   single pages of large folios when replacing them by a copy during write
   faults. No change, which is great!

reuse-byte: fork() and wait until the child quit. write one byte to each
  individual page, measuring the duration of all writes.

Folio Size |  MM-ID | No-Mapcount
--------------------------------
    16 KiB |  -66 % |      -66 %
    32 KiB |  -65 % |      -65 %
    64 KiB |  -64 % |      -64 %
   128 KiB |  -64 % |      -64 %
   256 KiB |  -64 % |      -64 %
   512 KiB |  -64 % |      -64 %
  1024 KiB |  -64 % |      -64 %
  2048 KiB |  -64 % |      -64 %

-> No surprise, we reuse all pages instead of copying them.

child-reuse-bye: fork() and unmap the memory in the parent. write one byte
  to each individual page in the child, measuring the duration of all writes.

Folio Size |  MM-ID | No-Mapcount
--------------------------------
    16 KiB |  -66 % |      -66 %
    32 KiB |  -65 % |      -65 %
    64 KiB |  -64 % |      -64 %
   128 KiB |  -64 % |      -64 %
   256 KiB |  -64 % |      -64 %
   512 KiB |  -64 % |      -64 %
  1024 KiB |  -64 % |      -64 %
  2048 KiB |  -64 % |      -64 %

-> Same thing, we reuse all pages instead of copying them.


For 4 KiB, there is no change in any benchmark, as expected.


4.2) vm-scalability
-------------------

For now I only ran anon COW tests. I use 1 GiB per child process and use
one child per core (-> 20).

case-anon-cow-rand: random writes

There is effectively no change (<0.6% throughput difference).

case-anon-cow-seq: sequential writes

MM-ID has up to 2% *lower* throughout than Base, not really correlating to
folio size. The difference is almost as large as the STDEV (1% - 2%),
though. It looks like there is a very slight effective slowdown.

No-Mapcount has up to 3% *higher* throughput than Base, not really
correlating to the folio size. However, also here the difference is almost
as large as the STDEV (up to 2%). It looks like there is a very slight
effective speedup.

In summary, no earth-shattering slowdown with MM-ID (and we just recently
optimized folio->_nr_pages_mapped to give us some speedup :) ), and
another nice improvement with No-Mapcount.


I did a bunch of cross-compiles and the build bots turned out very helpful
over the last months. I did quite some testing with LTP and selftests,
but x86-64 only.

To keep the CC list short, adding only relevant maintainers (CCed on all
patches, sorry ;) ).

Related things on my long TODO list:
* Replace the "entire mapcount" by a "pmd mapcount" and a "pud mapcount",
  to prepare for handling folios > PMD size. Maybe we'll have to keep it for
  hugetlb, we'll see.
* Make hugetlb play along, and possibly use the same mapcount scheme. PMD
  page table sharing doesn't play along and needs some thought. There might
  be ways, but it's a bit more involved.
* Make AnonExclusive a per-folio flag. It's complicated.

[1] https://lwn.net/Articles/974223/
[2] https://lore.kernel.org/linux-mm/a9922f58-8129-4f15-b160-e0ace581bcbe@redhat.com/T/
[3] https://gitlab.com/davidhildenbrand/scratchspace/-/raw/main/pte-mapped-folio-benchmarks.c

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Michal Koutný" <mkoutny@suse.com>
Cc: Jonathan Corbet <corbet@lwn.net> 
Cc: Andy Lutomirski <luto@kernel.org> 
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>

David Hildenbrand (17):
  mm: factor out large folio handling from folio_order() into
    folio_large_order()
  mm: factor out large folio handling from folio_nr_pages() into
    folio_large_nr_pages()
  mm/rmap: use folio_large_nr_pages() in add/remove functions
  mm: let _folio_nr_pages overlay memcg_data in first tail page
  mm/rmap: pass dst_vma to page_try_dup_anon_rmap() and
    page_dup_file_rmap()
  mm/rmap: pass vma to __folio_add_rmap()
  mm/rmap: abstract large mapcount operations for large folios
    (!hugetlb)
  mm/rmap: initial MM owner tracking for large folios (!hugetlb)
  bit_spinlock: __always_inline (un)lock functions
  mm: COW reuse support for PTE-mapped THP with CONFIG_MM_ID
  mm: CONFIG_NO_PAGE_MAPCOUNT to prepare for not maintain per-page
    mapcounts in large folios
  mm: remove per-page mapcount dependency in
    folio_likely_mapped_shared() (CONFIG_NO_PAGE_MAPCOUNT)
  fs/proc/page: remove per-page mapcount dependency for /proc/kpagecount
    (CONFIG_NO_PAGE_MAPCOUNT)
  fs/proc/task_mmu: remove per-page mapcount dependency for
    PM_MMAP_EXCLUSIVE (CONFIG_NO_PAGE_MAPCOUNT)
  fs/proc/task_mmu: remove per-page mapcount dependency for "mapmax"
    (CONFIG_NO_PAGE_MAPCOUNT)
  fs/proc/task_mmu: remove per-page mapcount dependency for
    smaps/smaps_rollup (CONFIG_NO_PAGE_MAPCOUNT)
  mm: stop maintaining the per-page mapcount of large folios
    (CONFIG_NO_PAGE_MAPCOUNT)

 .../admin-guide/cgroup-v1/memory.rst          |   4 +
 Documentation/admin-guide/cgroup-v2.rst       |  10 +-
 Documentation/admin-guide/mm/pagemap.rst      |  16 +-
 Documentation/filesystems/proc.rst            |  28 ++-
 Documentation/mm/transhuge.rst                |  39 +++-
 arch/x86/entry/vdso/vdso32/fake_32bit_build.h |   1 +
 fs/proc/internal.h                            |  33 +++
 fs/proc/page.c                                |  18 +-
 fs/proc/task_mmu.c                            |  41 +++-
 include/linux/bit_spinlock.h                  |   8 +-
 include/linux/mm.h                            |  60 +++--
 include/linux/mm_types.h                      |  57 ++++-
 include/linux/page-flags.h                    |  41 ++++
 include/linux/rmap.h                          | 213 ++++++++++++++++--
 kernel/fork.c                                 |  36 +++
 mm/Kconfig                                    |  31 +++
 mm/huge_memory.c                              |  16 +-
 mm/internal.h                                 |  33 ++-
 mm/memory.c                                   |  97 ++++++--
 mm/page_alloc.c                               |  18 +-
 mm/page_owner.c                               |   2 +-
 mm/rmap.c                                     |  97 ++++++--
 22 files changed, 781 insertions(+), 118 deletions(-)

-- 
2.46.0


