Return-Path: <linux-fsdevel+bounces-67638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C320C45381
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 08:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DA384E52D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 07:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389C92EB861;
	Mon, 10 Nov 2025 07:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvOfkWFd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9836A23D7C8
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762759942; cv=none; b=mxhSS5WnVOpTZuO/OgUAd3XFwHlwJmD6paYKZh9otPgKJbmfiLRN/spy9QP068+EScjDoExL/xncSrSkB/wg0FpZZIY4p61UuZjNLpea6gkDWU9N5cZI6HBMBB6rYP3161wtOmGWn6R3EaMSGC8n2M96mNhV8XKOnIJWSKK4btQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762759942; c=relaxed/simple;
	bh=cQN4kGT4Z9RnV16R7zCdXa49GPir2ZqJr/78v+Lovzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tXErqsQM5Q8BXHx3QUsV/oh5gUBC9c1LH2xOqOCUbDBgC6wTBy60/4n+K7H5ZpxI5tIqmenrMvM4NBtRYxFXHaaVJsiFpsPEE/PTJlD9jLwMk1iKnzJyqZubWBLvlFBFmYnRpPeDOMC5j1mQYA/dbnlkQ+i8Hl3EdkDlK9oAxbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvOfkWFd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8ABC19421
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 07:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762759942;
	bh=cQN4kGT4Z9RnV16R7zCdXa49GPir2ZqJr/78v+Lovzc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZvOfkWFd+WOdHEZJwK/GUI9fhEU3f9bre5eQr7hGOLvs2QldWfyu9odppogGquQxT
	 MHl/e72XmiEfinNedLDKqI3/4tJ17sCJGJI8n9ZC+AK/M63y0cK2xDOp5QYMQc0vpk
	 s7Lh7F+Svdoa0E2Lz9jwGCY2i1kQpyNIL/gZWCp/UW5PhPX6ZX7DZHYEgsCcT+B7Xj
	 zRR75Vm0grsQIb0LpX/GKhi5FIn/ZpA73hO9QgOLnBc0nDRg4O52vZq1l76SP3KX0z
	 D8BHqouuAco+I1052iiE4RdKyvquYsQtszFbUzZ/sopASz4xcUIPnhLi5NlQTduTPh
	 qP8aP4mFGv/ag==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7868b7b90b8so24521507b3.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Nov 2025 23:32:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXlB0lEREDDcsjX5DBV6z0+00x660vDeQQ4ssdTxhF1YKvuvoCshQZsRIanGSOjgJp2663NRPKQ2AmWZyFm@vger.kernel.org
X-Gm-Message-State: AOJu0YwlbNZFkUaLEsO8CLEuVhW6is+VjUqybGeCKd06dxclXJVqfO88
	048Kcv/xAmvuSCxQ5HoY5C09FNgC7eQPOUqM+jYeBInn6p6MwmgRe2hfcCYSJ7er29bRE/JeL0c
	nRvTu9jqBG+2HkjGAMM2TYdOrCA6wJjHttLR6EgvpKQ==
X-Google-Smtp-Source: AGHT+IFQ9N0QJyzxbx3agttaPppdKNBBAeeuQ6oXFqx9fA4bbGoFwr4rbbdYkUn5xJYMpCIw+moKhVHJZhszc+EwPJo=
X-Received: by 2002:a05:690c:670f:b0:786:61c6:7e57 with SMTP id
 00721157ae682-787d5438549mr67487947b3.42.1762759941154; Sun, 09 Nov 2025
 23:32:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
From: Chris Li <chrisl@kernel.org>
Date: Sun, 9 Nov 2025 23:32:09 -0800
X-Gmail-Original-Message-ID: <CACePvbVq3kFtrue2smXRSZ86+EuNVf6q+awQnU-n7=Q4x7U9Lw@mail.gmail.com>
X-Gm-Features: AWmQ_blwAcP-jPkdX_BL8n-dN0nskCj9MNzjkUZFE3hb8I8DIawlcAt-KR_uwfY
Message-ID: <CACePvbVq3kFtrue2smXRSZ86+EuNVf6q+awQnU-n7=Q4x7U9Lw@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] mm: remove is_swap_[pte, pmd]() + non-swap
 entries, introduce leaf entries
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@redhat.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jann Horn <jannh@google.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Pedro Falcato <pfalcato@suse.de>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 9:09=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> There's an established convention in the kernel that we treat leaf page
> tables (so far at the PTE, PMD level) as containing 'swap entries' should
> they be neither empty (i.e. p**_none() evaluating true) nor present
> (i.e. p**_present() evaluating true).
>
> However, at the same time we also have helper predicates - is_swap_pte(),
> is_swap_pmd() - which are inconsistently used.
>
> This is problematic, as it is logical to assume that should somebody wish
> to operate upon a page table swap entry they should first check to see if
> it is in fact one.
>
> It also implies that perhaps, in future, we might introduce a non-present=
,
> none page table entry that is not a swap entry.
>
> This series resolves this issue by systematically eliminating all use of
> the is_swap_pte() and is swap_pmd() predicates so we retain only the
> convention that should a leaf page table entry be neither none nor presen=
t
> it is a swap entry.
>
> We also have the further issue that 'swap entry' is unfortunately a reall=
y
> rather overloaded term and in fact refers to both entries for swap and fo=
r
> other information such as migration entries, page table markers, and devi=
ce
> private entries.
>
> We therefore have the rather 'unique' concept of a 'non-swap' swap entry.
>
> This series therefore introduces the concept of 'software leaf entries', =
of
> type softleaf_t, to eliminate this confusion.
>
> A software leaf entry in this sense is any page table entry which is
> non-present, and represented by the softleaf_t type. That is - page table
> leaf entries which are software-controlled by the kernel.
>
> This includes 'none' or empty entries, which are simply represented by an
> zero leaf entry value.
>
> In order to maintain compatibility as we transition the kernel to this ne=
w
> type, we simply typedef swp_entry_t to softleaf_t.

Hi Lorenzo,

Sorry I was late to the party. Can you clarify that you intend to
remove swp_entry_t completely to softleaf_t?
I think for the traditional usage of the swp_entry_t, which is made up
of swap device type and swap device offset. Can we please keep the
swp_entry_t for the traditional swap system usage? The mix type can
stay in softleaf_t in the pte level.

I kind of wish the swap system could still use swp_entry_t. At least I
don't see any complete reason to massively rename all the swap system
code if we already know the entry is the limited meaning of swap entry
(device + offset).

Timing is not great either. We have the swap table phase II on review
now. There is also phase III and phase IV on the backlog pipeline. All
this renaming can create unnecessary conflicts. I am pleading please
reduce the renaming in the swap system code for now until we can
figure out what is the impact to the rest of the swap table series,
which is the heavy lifting for swap right now. I want to draw a line
in the sand that, on the PTE entry side, having multiple meanings, we
can call it softleaft_t whatever. If we know it is the traditional
swap entry meaning. Keep it swp_entry_t for now until we figure out
the real impact.

Does this renaming have any behavior change in the produced machine code?

Chris

>
> We introduce a number of predicates and helpers to interact with software
> leaf entries in include/linux/leafops.h which, as it imports swapops.h, c=
an
> be treated as a drop-in replacement for swapops.h wherever leaf entry
> helpers are used.
>
> Since softleaf_from_[pte, pmd]() treats present entries as they were
> empty/none leaf entries, this allows for a great deal of simplification o=
f
> code throughout the code base, which this series utilises a great deal.
>
> We additionally change from swap entry to software leaf entry handling
> where it makes sense to and eliminate functions from swapops.h where
> software leaf entries obviate the need for the functions.
>
>
> v2:
> * Folded all fixpatches into patches they fix.
> * Added Vlasta's tag to patch 1 (thanks!)
> * Renamed leaf_entry_t to softleaf_t and leafent_xxx() to softleaf_xxx() =
as
>   a result of discussion between Matthew, Jason, David, Gregory & myself =
to
>   make clearer that we abstract the concept of a software page table leaf
>   entry.
> * Updated all commit messages to reference softleaves.
> * Updated the kdoc comment describing softleaf_t to provide more detail.
> * Added a description of softleaves to the top of leafops.h.
>
> non-RFC v1:
> * As part of efforts to eliminate swp_entry_t usage, remove
>   pte_none_mostly() and correct UFFD PTE marker handling.
> * Introduce leaf_entry_t - credit to Gregory for naming, and to Jason for
>   the concept of simply using a leafent_*() set of functions to interact
>   with these entities.
> * Replace pte_to_swp_entry_or_zero() with leafent_from_pte() and simply
>   categorise pte_none() cases as an empty leaf entry, as per Jason.
> * Eliminate get_pte_swap_entry() - as we can simply do this with
>   leafent_from_pte() also, as discussed with Jason.
> * Put pmd_trans_huge_lock() acquisition/release in pagemap_pmd_range()
>   rather than pmd_trans_huge_lock_thp() as per Gregory.
> * Eliminate pmd_to_swp_entry() and related and introduce leafent_from_pmd=
()
>   to replace it and further propagate leaf entry usage.
> * Remove the confusing and unnecessary is_hugetlb_entry_[migration,
>   hwpoison]() functions.
> * Replace is_pfn_swap_entry(), pfn_swap_entry_to_page(),
>   is_writable_device_private_entry(), is_device_exclusive_entry(),
>   is_migration_entry(), is_writable_migration_entry(),
>   is_readable_migration_entry(), is_readable_exclusive_migration_entry()
>   and pfn_swap_entry_folio() with leafent equivalents.
> * Wrapped up the 'safe' behaviour discussed with Jason in
>   leafent_from_[pte, pmd]() so these can be used unconditionally which
>   simplifies things a lot.
> * Further changes that are a consequence of the introduction of leaf
>   entries.
> https://lore.kernel.org/all/cover.1762171281.git.lorenzo.stoakes@oracle.c=
om/
>
> RFC:
> https://lore.kernel.org/all/cover.1761288179.git.lorenzo.stoakes@oracle.c=
om/
>
> Lorenzo Stoakes (16):
>   mm: correctly handle UFFD PTE markers
>   mm: introduce leaf entry type and use to simplify leaf entry logic
>   mm: avoid unnecessary uses of is_swap_pte()
>   mm: eliminate is_swap_pte() when softleaf_from_pte() suffices
>   mm: use leaf entries in debug pgtable + remove is_swap_pte()
>   fs/proc/task_mmu: refactor pagemap_pmd_range()
>   mm: avoid unnecessary use of is_swap_pmd()
>   mm/huge_memory: refactor copy_huge_pmd() non-present logic
>   mm/huge_memory: refactor change_huge_pmd() non-present logic
>   mm: replace pmd_to_swp_entry() with softleaf_from_pmd()
>   mm: introduce pmd_is_huge() and use where appropriate
>   mm: remove remaining is_swap_pmd() users and is_swap_pmd()
>   mm: remove non_swap_entry() and use softleaf helpers instead
>   mm: remove is_hugetlb_entry_[migration, hwpoisoned]()
>   mm: eliminate further swapops predicates
>   mm: replace remaining pte_to_swp_entry() with softleaf_from_pte()
>
>  MAINTAINERS                   |   1 +
>  arch/s390/mm/gmap_helpers.c   |  20 +-
>  arch/s390/mm/pgtable.c        |  12 +-
>  fs/proc/task_mmu.c            | 294 +++++++++-------
>  fs/userfaultfd.c              |  85 ++---
>  include/asm-generic/hugetlb.h |   8 -
>  include/linux/huge_mm.h       |  48 ++-
>  include/linux/hugetlb.h       |   2 -
>  include/linux/leafops.h       | 620 ++++++++++++++++++++++++++++++++++
>  include/linux/migrate.h       |   2 +-
>  include/linux/mm_inline.h     |   6 +-
>  include/linux/mm_types.h      |  25 ++
>  include/linux/swapops.h       | 273 +--------------
>  include/linux/userfaultfd_k.h |  33 +-
>  mm/damon/ops-common.c         |   6 +-
>  mm/debug_vm_pgtable.c         |  86 +++--
>  mm/filemap.c                  |   8 +-
>  mm/hmm.c                      |  36 +-
>  mm/huge_memory.c              | 263 +++++++-------
>  mm/hugetlb.c                  | 165 ++++-----
>  mm/internal.h                 |  20 +-
>  mm/khugepaged.c               |  33 +-
>  mm/ksm.c                      |   6 +-
>  mm/madvise.c                  |  28 +-
>  mm/memory-failure.c           |   8 +-
>  mm/memory.c                   | 150 ++++----
>  mm/mempolicy.c                |  25 +-
>  mm/migrate.c                  |  45 +--
>  mm/migrate_device.c           |  24 +-
>  mm/mincore.c                  |  25 +-
>  mm/mprotect.c                 |  59 ++--
>  mm/mremap.c                   |  13 +-
>  mm/page_table_check.c         |  33 +-
>  mm/page_vma_mapped.c          |  65 ++--
>  mm/pagewalk.c                 |  15 +-
>  mm/rmap.c                     |  17 +-
>  mm/shmem.c                    |   7 +-
>  mm/swap_state.c               |  12 +-
>  mm/swapfile.c                 |  14 +-
>  mm/userfaultfd.c              |  53 +--
>  40 files changed, 1560 insertions(+), 1085 deletions(-)
>  create mode 100644 include/linux/leafops.h
>
> --
> 2.51.0

