Return-Path: <linux-fsdevel+bounces-42458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E83F2A42872
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 17:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06C11672AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 16:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13170264607;
	Mon, 24 Feb 2025 16:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Njy4c4rB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A6C2638BE
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416173; cv=none; b=Yy0gE6X/37d4jAX78wTmqNHX6MZLUd4biweksSKwn6m5TUmUqv4ikhQpqkikIfjZNE10jhjEKbMAbkGdARfM6GJL3oeTXVmOoJ9MJoJSb44WEJmAjIqZX33/XlcrTrLr+/3+X0b75UdOmKDDMROVW8l0MWOiEjLZ2bU5bWknlVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416173; c=relaxed/simple;
	bh=Ny8n8bARUVf8JItxY4j22UnzS9WTtRZSxSuYtNP+Jc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZqlPsgFAneGdC9Ndy9XgF0P2sPWd+tR+sx7ViatVvRb47ypLI9IwMSUgc0lAcqN/tFHMYb7FyZzy1jM2Uyv9A3p2BEXvFHu0eeh6qP+0LmzRFVNq949U4Ryn8K82XyXx6PO+w5H/p/pMgyK4y+6tG5Gw+Apc1stksW6g3APgAno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Njy4c4rB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740416168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vIgm4H2uHMHo4+m66r/a3CG1jRNxOBryy+RTgVgshV8=;
	b=Njy4c4rBy3FanG/Eg22Fz9YrEoTTQQpnxgd2dHgb+PyoWOBlAhl7xJufkGGJDZn1X72zh3
	rB9MvbTZK/8MUiKw465WjxpWEQmaUA0P+R3wmYRNCq9oLalQVeVpPtzKjH6oV3PUTEMTSG
	fzWAFxUlFginx1463RG/75FNqxw/4CY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-Sr3ydmpMM6q_djOvqvxfbQ-1; Mon, 24 Feb 2025 11:56:07 -0500
X-MC-Unique: Sr3ydmpMM6q_djOvqvxfbQ-1
X-Mimecast-MFC-AGG-ID: Sr3ydmpMM6q_djOvqvxfbQ_1740416166
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4393e873962so23627695e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 08:56:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416166; x=1741020966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vIgm4H2uHMHo4+m66r/a3CG1jRNxOBryy+RTgVgshV8=;
        b=hd/JQeyi+4JX9JtPyAY88QkPC7OLlD/vfWUqLOgOrMBBORXfXJVa4Csq7fP7ekskM3
         FK0LH2X0G2rfHs6s0nkYkK4ueHB3r2GRKQ+ERAy+GOZcDgFNP2JmccuG+WHSYAlMZ/1M
         LBxbnLpuBpdx8N3fKDsAQSw/YfzNmTIu3fjMBrC1QTRd8PeBuJwJO9qmSjrBItjRZmZz
         G5GTums6s4JTytP3pYMqOkkzBP+zLX6K4kgstWZq7UQZPOQVZt/PLGbBkQfmxEh+mZ0d
         jxD8H29g5MtcRCvyHiyKdioxsroLLldbR3ZFN0KIdgT+1X6zKztyP+uQ6cKo8IOjXsTl
         fA/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCcLyYjyxYKbefCjxZ8J3ZpD6gvG+PloNVNRqpYkeTdEPbuFKXutwOxLhDLtheKMHPNTSxv4qEevr3ucYR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8e6TEHweE++NPgMuIgJnFqsxkSXqNIk5fpoDiOvzN2goxhy8M
	S2O8eeJT+AKEv47gFtDYkW+tATnkaeD96YYN5rMPCERhNkxndDr8tvRTWo4DMQ7OZlnZWXYhPTB
	fZ80H5+poqCEdN/wjJEoE+dlq062euNJ5ouolIjpKLREBtUktPG72SktH0AwsDmU=
X-Gm-Gg: ASbGncvIBGMDUS9wU6wdhZx+GUFL+jt3bIBkc3uY1SmRcmRGKzrXnfhTLh3WTOonrzu
	7vnRDgAMVM0xvmr5ufXRASWLV3yK0u86KFEKHeYFUEfwH5mX8hB8nW9u20olw4ZJkOQuw7SHhb6
	FF/kry0pRsgIPdIHMac8HHWxNJX8POGDfZSFpc/WtOJngVQjQ1gCdRFotWGo8Y4bn3pzJCNw5kR
	z8nLfgEkvp2GO1HzXFjgBA6pU2OiitxmfN4ZfYHJnimZ0XaAtGWrDi4Q3fdbQMcggNmJdXsvhCw
	S2v7d0LTAW3oIAHUxqMoMUgHdVLEsO77QuSoYayO/w==
X-Received: by 2002:a5d:6d84:0:b0:38d:e61a:bc7 with SMTP id ffacd0b85a97d-38f6f097d06mr13544006f8f.40.1740416165595;
        Mon, 24 Feb 2025 08:56:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHN8OH3n9WE23Lc4kXfIlxiOxHRhk72tX7EnWl0S28OyqBX37h81SgW+6HH/Zw+hw7Pg1sjOg==
X-Received: by 2002:a5d:6d84:0:b0:38d:e61a:bc7 with SMTP id ffacd0b85a97d-38f6f097d06mr13543976f8f.40.1740416165076;
        Mon, 24 Feb 2025 08:56:05 -0800 (PST)
Received: from localhost (p4ff234b6.dip0.t-ipconnect.de. [79.242.52.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-439b031b954sm111060545e9.37.2025.02.24.08.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 08:56:04 -0800 (PST)
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
Subject: [PATCH v2 00/20] mm: MM owner tracking for large folios (!hugetlb) + CONFIG_NO_PAGE_MAPCOUNT
Date: Mon, 24 Feb 2025 17:55:42 +0100
Message-ID: <20250224165603.1434404-1-david@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series is about to haunt me in my dreams, and the time spent
on this is ridiculous ... anyhow, here goes a new version that now also
supports 32bit (I wish we would have dynamically allocated "struct folio"
already ...) and always enables the new tracking with
CONFIG_TRANSPARENT_HUGEPAGE.

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
one mapping a folio exclusively, we will *not* detect the folio as
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

Detailed performance numbers were included in v1 [4], and not that much
changed between v1 and v2.

I did plenty of measurements on different systems in the meantime, that
all revealed slightly different results.

The pte-mapped-folio micro-benchmarks are fairly sensitive to code layout
changes on some systems. Especially the fork() benchmark started being
more-shaky-than-before on recent kernels for some reason.

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
easily see how right now. Well, and I am out of puff :)

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

The downside is that we maybe would also have to take the same number of
folio references to make our folio_mapcount() == folio_ref_count() work. I
think it should be possible (user space could trigger many PTE mappings
already), but we be a bit more careful about possible mapcount/refcount
overflows. (e.g., fail mapping a folio if the mapcount exceeds a certain
threshold)

Maybe some day we'll have a 64bit refcount+mapcount.

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
(CCed on all patches, sorry :) ).

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
 Documentation/admin-guide/mm/pagemap.rst      |  16 +-
 Documentation/filesystems/proc.rst            |  28 +-
 Documentation/mm/transhuge.rst                |  39 ++-
 fs/proc/internal.h                            |  39 +++
 fs/proc/page.c                                |  19 +-
 fs/proc/task_mmu.c                            |  39 ++-
 include/linux/bit_spinlock.h                  |   8 +-
 include/linux/mm.h                            |  93 +++---
 include/linux/mm_types.h                      | 110 +++++--
 include/linux/page-flags.h                    |   4 +
 include/linux/rmap.h                          | 270 ++++++++++++++++--
 kernel/fork.c                                 |  36 +++
 mm/Kconfig                                    |  22 ++
 mm/debug.c                                    |  10 +-
 mm/gup.c                                      |   8 +-
 mm/huge_memory.c                              |  20 +-
 mm/hugetlb.c                                  |   1 -
 mm/internal.h                                 |  20 +-
 mm/khugepaged.c                               |   8 +-
 mm/madvise.c                                  |   6 +-
 mm/memory.c                                   |  96 ++++++-
 mm/mempolicy.c                                |   8 +-
 mm/migrate.c                                  |   7 +-
 mm/mprotect.c                                 |   2 +-
 mm/page_alloc.c                               |  50 +++-
 mm/page_owner.c                               |   2 +-
 mm/rmap.c                                     | 118 ++++++--
 29 files changed, 903 insertions(+), 190 deletions(-)


base-commit: f7ed46277aaa8f848f18959ff68469f5186ba87c
-- 
2.48.1


