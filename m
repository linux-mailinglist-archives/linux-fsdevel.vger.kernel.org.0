Return-Path: <linux-fsdevel+bounces-42949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CB8A4C76D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BE401626F5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 16:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6598F2417C5;
	Mon,  3 Mar 2025 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O84dTJjO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F213523F26B
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019440; cv=none; b=B2R0CCo65c55ItxuE0XKx8DyBL/BuN00WRWCy0gQ4n3zLRaLX0AX79edcU0yxKM5+CBJE0CKTRnWNRRD94KO6KokVEMyrX6qHVAk+i5i9zYwK77GkxW0o4pQfwjJCy/+BpMCmYwHxXqi8Tamhax9oyoJ2cMXV2zcGnS45FLnj6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019440; c=relaxed/simple;
	bh=9atUndxsomL0089aWeIdVhVD9vSKauDAWk8bvEBxHRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mRw/iSbawkNTPErNLpMq3MonWroL5aLQqNo3C3pGybI/x3L14IcY/tPzEHqXMAeYvQOGeObkOhNyZ9UZhAE+qw8ctq92DZHyEymi+u9KYCGdrua96kpvXedg7oi4bG6Men9RLpmF0m5bg0D8ckcO7qaYV+QPUc4L5Fr9TzfL9J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O84dTJjO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z94iP1hoGdaqxJEP0csSOfM7B5vV14GxndPnByfrfkk=;
	b=O84dTJjOW2fqd0ghRdOTb3tSfKGXFxmHbdG+W5xQBNOYE/hiUlwfhb5O+yBwyDCQe+wN4u
	L8rTyFUz21Z9XYSBalxtUsBZ6JiMf2fbXU+cZuuI7yO9x8nlw3dcFCJxogZ7K4N469xme8
	yWIXH2feypyElQHqkUi0cdWW3DCDetk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-pCEHy6UiMRmz45_Ixd--0Q-1; Mon, 03 Mar 2025 11:30:18 -0500
X-MC-Unique: pCEHy6UiMRmz45_Ixd--0Q-1
X-Mimecast-MFC-AGG-ID: pCEHy6UiMRmz45_Ixd--0Q_1741019418
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ba50406fbso33863545e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Mar 2025 08:30:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019417; x=1741624217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z94iP1hoGdaqxJEP0csSOfM7B5vV14GxndPnByfrfkk=;
        b=LD0adFIODO/XbfWmYgoctdIBWTBDQF/vpmUVqtJS4IsYqO6seX4LNEJ5VaP9Ud/EXX
         o8pOtZJm+ipwLFN+be5KXyBXoUBtVawhT1JDux9hMYbFgu8SBufr8LxsRXua/gm9EF8X
         STCpvctVhXUVUDtUGY8bZiexaPhVFa+iAt1r1MIv7e2IvkO/COsCYrqYxWcaTa4U76mW
         /A7X2ZRothIwmvxHJ3pGhYXCNO+CrmPPvfEVx5AgDsZBNQPc6KBN8rz+GilASjjJW53k
         MKyQd7auXdvO/YZnXLs0RCfi/r6aSgQfbvTb6bfivVAPvir896U/cRo021nTU1gYfr4z
         C70Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZtqic/Dzv6+84PiIrskTWeqampa4HSqtX/8oHZ8a5DcZHybibOUZwjvaCj3GhSkyguQhIt9ErZuYZnwCa@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx/lRKsLImbs5Etj/hfty+vVCAkzCk0pEs5YVxb8sG+yKIq5fA
	+6lX5WclpI7cYu/C/un+jrJhlPaSxzIbzKIydML52duikvXKOyJ20L9fxPZ1ARIB+V09rL4s7Do
	GyqSD8rX72GFbu1oZIWeMhStUbJp3t6RmE1cGaakllhpfTXb2si9ZbS9f2yEpXD4=
X-Gm-Gg: ASbGncs/9TjI4EMNxNsyb8np01zDcIDJ/OsmAFy4llHjzHAtQiw61S36iMpXfjn85i2
	OxdZjLAvsoGKmJJjlHzrp8zfPh17ySBTFEqIQ2XV/R2kTvxGpTDbCsCnene/QYM4gCxoC5hho56
	e9IwJIjyPRBvBvwwA47lIaQeoK1YhqRSz65zLuJZcbnCeaNzMH3Hq2Eac2JHF+H0fBzlG2EjG6F
	C53AqJYHKYOAztmtH9SXlw0Z3+MxXZPwaMd56gJh9iZfhx9lUHBGDm7n0YNtjO31dExXwy/hbqD
	qLiP8E/0WT+2mQpwXLW/EnHt2Ba4lPpwvgfor/WWuBnI8UYTjyijnoE7BCwgr9z5GumVRC0pc1o
	X
X-Received: by 2002:a05:600c:5246:b0:439:9a40:aa0b with SMTP id 5b1f17b1804b1-43bb64f1ce8mr54619455e9.25.1741019417382;
        Mon, 03 Mar 2025 08:30:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9h9cPVLAuewr23pDXEUpxwXa6a0sFQSeyADG1tdUOqtE7HWTucVTNAuNpxGq4bhaC5CPQoQ==
X-Received: by 2002:a05:600c:5246:b0:439:9a40:aa0b with SMTP id 5b1f17b1804b1-43bb64f1ce8mr54618915e9.25.1741019416791;
        Mon, 03 Mar 2025 08:30:16 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e47b7d1dsm15119437f8f.56.2025.03.03.08.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:16 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
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
	Dave Hansen <dave.hansen@linux.intel.com>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>
Subject: [PATCH v3 00/20] mm: MM owner tracking for large folios (!hugetlb) + CONFIG_NO_PAGE_MAPCOUNT
Date: Mon,  3 Mar 2025 17:29:53 +0100
Message-ID: <20250303163014.1128035-1-david@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some smaller change based on Zi Yan's feedback (thanks!).


Let's add an "easy" way to decide -- without false positives, without
page-mapcounts and without page table/rmap scanning -- whether a large
folio is "certainly mapped exclusively" into a single MM, or whether it
"maybe mapped shared" into multiple MMs.

Use that information to implement Copy-on-Write reuse, to convert
folio_likely_mapped_shared() to folio_maybe_mapped_share(), and to
introduce a kernel config option that let's us not use+maintain
per-page mapcounts in large folios anymore.

The bigger picture was presented at LSF/MM [1].

This series is effectively a follow-up on my early work [2], which
implemented a more precise, but also more complicated, way to identify
whether a large folio is "mapped shared" into multiple MMs or
"mapped exclusively" into a single MM.


1 Patch Organization
====================

Patch #1 -> #6: make more room in order-1 folios, so we have two
                "unsigned long" available for our purposes

Patch #7 -> #11: preparations

Patch #12: MM owner tracking for large folios

Patch #13: COW reuse for PTE-mapped anon THP

Patch #14: folio_maybe_mapped_shared()

Patch #15 -> #20: introduce and implement CONFIG_NO_PAGE_MAPCOUNT


2 MM owner tracking
===================

We assign each MM a unique ID ("MM ID"), to be able to squeeze more
information in our folios. On 32bit we use 15-bit IDs, on 64bit we use
31-bit IDs.

For each large folios, we now store two MM-ID+mapcount ("slot")
combinations:
* mm0_id + mm0_mapcount
* mm1_id + mm1_mapcount

On 32bit, we use a 16-bit per-MM mapcount, on 64bit an ordinary 32bit
mapcount. This way, we require 2x "unsigned long" on 32bit and 64bit for
both slots.

Paired with the large mapcount, we can reliably identify whether one
of these MMs is the current owner (-> owns all mappings) or even holds
all folio references (-> owns all mappings, and all references are from
mappings).

As long as only two MMs map folio pages at a time, we can reliably and
precisely identify whether a large folio is "mapped shared" or
"mapped exclusively".

Any additional MM that starts mapping the folio while there are no free
slots becomes an "untracked MM". If one such "untracked MM" is the last
one mapping a folio exclusively, we will not detect the folio as
"mapped exclusively" but instead as "maybe mapped shared". (exception:
only a single mapping remains)

So that's where the approach gets imprecise.

For now, we use a bit-spinlock to sync the large mapcount + slots, and
make sure we do keep the machinery fast, to not degrade (un)map performance
drastically: for example, we make sure to only use a single atomic (when
grabbing the bit-spinlock), like we would already perform when updating
the large mapcount.


3 CONFIG_NO_PAGE_MAPCOUNT
=========================

patch #15 -> #20 spell out and document what exactly is affected when
not maintaining the per-page mapcounts in large folios anymore.

Most importantly, as we cannot maintain folio->_nr_pages_mapped anymore when
(un)mapping pages, we'll account a complete folio as mapped if a
single page is mapped. In addition, we'll not detect partially mapped
anonymous folios as such in all cases yet.

Likely less relevant changes include that we might now under-estimate the
USS (Unique Set Size) of a process, but never over-estimate it.

The goal is to make CONFIG_NO_PAGE_MAPCOUNT the default at some point,
to then slowly make it the only option, as we learn about real-life
impacts and possible ways to mitigate them.


4 Performance
=============

Detailed performance numbers were included in v1 [3], and not that much
changed between v1 and v2.

I did plenty of measurements on different systems in the meantime, that
all revealed slightly different results.

The pte-mapped-folio micro-benchmarks [4] are fairly sensitive to code
layout changes on some systems. Especially the fork() benchmark started
being more-shaky-than-before on recent kernels for some reason.

In summary, with my micro-benchmarks:

* Small folios are not impacted.

* CoW performance seems to be mostly unchanged across all folios sizes.

* CoW reuse performance of large folios now matches CoW reuse performance
  of small folios, because we now actually implement the CoW reuse
  optimization. On an Intel Xeon Silver 4210R I measured a ~65% reduction
  in runtime, on an arm64 system I measured ~54% reduction.

* munmap() performance improves with CONFIG_NO_PAGE_MAPCOUNT. I saw
  double-digit % reduction (up to ~30% on an Intel Xeon Silver 4210R
  and up to ~70% on an AmpereOne A192-32X) with larger folios. The
  larger the folios, the larger the performance improvement.

* munmao() performance very slightly (couple percent) degrades without
  CONFIG_NO_PAGE_MAPCOUNT for smaller folios. For larger folios, there
  seems to be no change at all.

* fork() performance improves with CONFIG_NO_PAGE_MAPCOUNT. I saw
  double-digit % reduction (up to ~20% on an Intel Xeon Silver 4210R
  and up to ~10% on an AmpereOne A192-32X) with larger folios. The larger
  the folios, the larger the performance improvement.

* While fork() performance without CONFIG_NO_PAGE_MAPCOUNT seems to be
  almost unchanged on some systems, I saw some degradation for
  smaller folios on the AmpereOne A192-32X. I did not investigate the
  details yet, but I suspect code layout changes or suboptimal code
  placement / inlining.

I'm not to worried about the fork() micro-benchmarks for smaller folios
given how shaky the results are lately and by how much we improved fork()
performance recently.

I also ran case-anon-cow-rand and case-anon-cow-seq part of vm-scalability,
to assess the scalability and the impact of the bit-spinlock.
My measurements on a two 2-socket 10-core Intel Xeon Silver 4210R CPU
revealed no significant changes.

Similarly, running these benchmarks with 2 MiB THPs enabled on the
AmpereOne A192-32X with 192 cores, I got < 1% difference with < 1% stdev,
which is nice.

So far, I did not get my hands on a similarly large system with multiple
sockets.

I found no other fitting scalability benchmarks that seem to really hammer
on concurrent mapping/unmapping of large folio pages like case-anon-cow-seq
does.


5 Concerns
==========

5.1 Bit spinlock
----------------

I'm not quite happy about the bit-spinlock, but so far it does not seem to
affect scalability in my measurements.

If it ever becomes a problem we could either investigate improving the
locking, or simply stopping the MM tracking once there are "too many
mappings" and simply assume that the folio is "mapped shared" until it
was freed.

This would be similar (but slightly different) to the "0,1,2,stopped"
counting idea Willy had at some point. Adding that logic to "stop tracking"
adds more code to the hot path, so I avoided that for now.


5.2 folio_maybe_mapped_shared()
-------------------------------

I documented the change from folio_likely_mapped_shared() to
folio_maybe_mapped_shared() quite extensively. If we run into surprises,
I have some ideas on how to resolve them. For now, I think we should
be fine.


5.3 Added code to map/unmap hot path
------------------------------------

So far, it looks like the added code on the rmap hot path does not
really seem to matter much in the bigger picture. I'd like to further
reduce it (and possibly improve fork() performance further), but I don't
easily see how right now. Well, and I am out of puff 🙂

Having that said, alternatives I considered (e.g., per-MM per-folio
mapcount) would add a lot more overhead to these hot paths.


6 Future Work
=============

6.1 Large mapcount
------------------

It would be very handy if the large mapcount would count how often folio
pages are actually mapped into page tables: a PMD on x86-64 would count
512 times. Calculating the average per-page mapcount will be easy, and
remapping (PMD->PTE) folios would get even faster.

That would also remove the need for the entire mapcount (except for
PMD-sized folios for memory statistics reasons ...), and allow for mapping
folios larger than PMDs (e.g., 4 MiB) easily.

We likely would also have to take the same number of folio references to
make our folio_mapcount() == folio_ref_count() work, and we'd want to be
able to avoid mapcount+refcount overflows: this could already become an
issue with pte-mapped PUD-sized folios (fsdax).

One approach we discussed in the THP cabal meeting is (1) extending the
mapcount for large folios to 64bit (at least on 64bit systems) and (2)
keeping the refcount at 32bit, but (3) having exactly one reference if the
the mapcount != 0.

It should be doable, but there are some corner cases to consider on the
unmap path; it is something that I will be looking into next.


6.2 hugetlb
-----------

I'd love to make use of the same tracking also for hugetlb.

The real problem is PMD table sharing: getting a page mapped by MM X and
unmapped by MM Y will not work. With mshare, that problem should not exist
(all mapping/unmapping will be routed through the mshare MM).


7 Version Updates
=================

I did a bunch of cross-compiles and quite some testing on i386, x86-64 and
arm64. The build bots were very helpful as well.

To keep the CC list short, adding only relevant subsystem maintainers
(CCed on all patches, sorry 🙂 ).

v2 -> v3:
* "mm: CONFIG_NO_PAGE_MAPCOUNT to prepare for not maintain per-page
    mapcounts in large folios"
 -> Simplify Kconfig documentation
* "fs/proc/page: remove per-page mapcount dependency for /proc/kpagecount
    (CONFIG_NO_PAGE_MAPCOUNT)"
 -> Clarify average calculation, improve documentation, and make the
    average always be at least 1 if a single page is mapped.
 -> Consequently, simplify kpagecount_read()
* "fs/proc/task_mmu: remove per-page mapcount dependency for
   PM_MMAP_EXCLUSIVE (CONFIG_NO_PAGE_MAPCOUNT)"
 -> Improve documentation
* "fs/proc/task_mmu: remove per-page mapcount dependency for "mapmax"
   (CONFIG_NO_PAGE_MAPCOUNT)"
 -> Simplify/fix gather_stats()

v1 -> v2:
* 32bit support. It would all be easier if we would already allocate
  "struct folio" dynamically, but fortunately when we manage to do that,
  it will just clean that part up again. For now, we have to relocate in
  "struct folio" the _pincount and _entire_mapcount on 32bit, and the
  hugetlb data  unconditionally.
* "mm/rmap: basic MM owner tracking for large folios (!hugetlb)"
 -> Now unconditionally enabled with CONFIG_TRANSPARENT_HUGEPAGE
 -> Some changes to slot handling to handle some edge cases in a better
    way.
 -> Reworked the way flags are stored, in light of 32bit support.
* "mm: convert folio_likely_mapped_shared() to folio_maybe_mapped_shared()"
 -> Use the new logic always such that we can rename the function
* A bunch of cleanups/simplifications

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
Cc: Muchun Song <muchun.song@linux.dev>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Jann Horn <jannh@google.com>

[1] https://lwn.net/Articles/974223/
[2] https://lore.kernel.org/linux-mm/a9922f58-8129-4f15-b160-e0ace581bcbe@redhat.com/T/
[3] https://lkml.kernel.org/r/20240829165627.2256514-1-david@redhat.com
[3] https://gitlab.com/davidhildenbrand/scratchspace/-/raw/main/pte-mapped-folio-benchmarks.c

David Hildenbrand (20):
  mm: factor out large folio handling from folio_order() into
    folio_large_order()
  mm: factor out large folio handling from folio_nr_pages() into
    folio_large_nr_pages()
  mm: let _folio_nr_pages overlay memcg_data in first tail page
  mm: move hugetlb specific things in folio to page[3]
  mm: move _pincount in folio to page[2] on 32bit
  mm: move _entire_mapcount in folio to page[2] on 32bit
  mm/rmap: pass dst_vma to folio_dup_file_rmap_pte() and friends
  mm/rmap: pass vma to __folio_add_rmap()
  mm/rmap: abstract large mapcount operations for large folios
    (!hugetlb)
  bit_spinlock: __always_inline (un)lock functions
  mm/rmap: use folio_large_nr_pages() in add/remove functions
  mm/rmap: basic MM owner tracking for large folios (!hugetlb)
  mm: Copy-on-Write (COW) reuse support for PTE-mapped THP
  mm: convert folio_likely_mapped_shared() to
    folio_maybe_mapped_shared()
  mm: CONFIG_NO_PAGE_MAPCOUNT to prepare for not maintain per-page
    mapcounts in large folios
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
 Documentation/admin-guide/mm/pagemap.rst      |  18 +-
 Documentation/filesystems/proc.rst            |  37 ++-
 Documentation/mm/transhuge.rst                |  39 ++-
 fs/proc/internal.h                            |  43 +++
 fs/proc/page.c                                |  11 +-
 fs/proc/task_mmu.c                            |  39 ++-
 include/linux/bit_spinlock.h                  |   8 +-
 include/linux/mm.h                            |  93 +++---
 include/linux/mm_types.h                      | 110 +++++--
 include/linux/page-flags.h                    |   4 +
 include/linux/rmap.h                          | 270 ++++++++++++++++--
 kernel/fork.c                                 |  36 +++
 mm/Kconfig                                    |  21 ++
 mm/debug.c                                    |  10 +-
 mm/gup.c                                      |   8 +-
 mm/huge_memory.c                              |  20 +-
 mm/hugetlb.c                                  |   1 -
 mm/internal.h                                 |  20 +-
 mm/khugepaged.c                               |   8 +-
 mm/madvise.c                                  |   6 +-
 mm/memory.c                                   |  95 +++++-
 mm/mempolicy.c                                |   8 +-
 mm/migrate.c                                  |   7 +-
 mm/mprotect.c                                 |   2 +-
 mm/page_alloc.c                               |  50 +++-
 mm/page_owner.c                               |   2 +-
 mm/rmap.c                                     | 118 ++++++--
 29 files changed, 905 insertions(+), 193 deletions(-)


base-commit: 5f089a9aa987ccf72df0c6955e168e865f280603
-- 
2.48.1


