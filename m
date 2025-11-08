Return-Path: <linux-fsdevel+bounces-67551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E2BC4318A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 08 Nov 2025 18:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5D943B0B41
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Nov 2025 17:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7EA24468A;
	Sat,  8 Nov 2025 17:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXLXLja8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541121A5B8B;
	Sat,  8 Nov 2025 17:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762622298; cv=none; b=jADMr2jHKYlfX1SzFxqUktBAzORceheRsu1ppU0o8ZcPIhdTIHM8CtjVlHauiWt92Q1b2qvwoWS6HtKrvzGc0Vdjv0dMBS2wjjf2/72mn6n524lH3Kq91xe56Oulysftarn3WRF0sAdt6XNMTkVqHncgC2ZYCZSOCikRviSmWaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762622298; c=relaxed/simple;
	bh=pESYDLXfcVD/iJn0c7wNfoZTyYhd+yM9sA3cQbI6Gww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1x3vrakdKB0MEahoOIISZmNn+4nlm40nss5RWUC4r3tFC8dA4nq1P8VJTU3niDGb701C9ytdh4NQHv7r38ODtvLP74QJ85MgwNxhJZgmCa4FvZvRX3FMD17iVFe9WLmvG3wLYrBEmj5d/VCIS/gZ7ncUiyeqXW+4bPjVovibbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXLXLja8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D797C4CEF5;
	Sat,  8 Nov 2025 17:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762622297;
	bh=pESYDLXfcVD/iJn0c7wNfoZTyYhd+yM9sA3cQbI6Gww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pXLXLja8D++3i+AfHiCU6NWWnKCTqEseSjb6R01Wd2qFTmLAUkW07+K3qAkLAB/iO
	 58twgr3qbPV7bJw2Xlx8je9ohYkBOStMy56jhmQ9FOSppxGZWilCo/StGKN5tm0P61
	 b1KRhblheTCEPQheRpoPPNKS+0o7Bp0uMRP+JxSsg6XvaByUie79tO9Vq/JnxBAmGN
	 bRE3xmzZzdcNNdy2RVe2gI/se+/RKNc4bbk9TorBN9r5WaJCOkqffGrFhlZRQNVbLe
	 KQYfPymH7R+7yeKssxlH529Od2FBgCcEzgK73afUL4OeUfCq0h8ZUMuFtRudOFqqWU
	 nQWLuajG/ch7w==
From: SeongJae Park <sj@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Peter Xu <peterx@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Chris Li <chrisl@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jann Horn <jannh@google.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Hugh Dickins <hughd@google.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	damon@lists.linux.dev
Subject: Re: [PATCH v2 10/16] mm: replace pmd_to_swp_entry() with softleaf_from_pmd()
Date: Sat,  8 Nov 2025 09:18:08 -0800
Message-ID: <20251108171808.77373-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <093e438c240272d081548222900a5c3b205e9a5d.1762621568.git.lorenzo.stoakes@oracle.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat,  8 Nov 2025 17:08:24 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> Introduce softleaf_from_pmd() to do the equivalent operation for PMDs that
> softleaf_from_pte() fulfils, and cascade changes through code base
> accordingly, introducing helpers as necessary.
> 
> We are then able to eliminate pmd_to_swp_entry(), is_pmd_migration_entry(),
> is_pmd_device_private_entry() and is_pmd_non_present_folio_entry().
> 
> This further establishes the use of leaf operations throughout the code
> base and further establishes the foundations for eliminating is_swap_pmd().
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  fs/proc/task_mmu.c      |  27 +++--
>  include/linux/leafops.h | 220 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/migrate.h |   2 +-
>  include/linux/swapops.h | 100 ------------------
>  mm/damon/ops-common.c   |   6 +-
>  mm/filemap.c            |   6 +-
>  mm/hmm.c                |  16 +--
>  mm/huge_memory.c        |  98 +++++++++---------
>  mm/khugepaged.c         |   4 +-
>  mm/madvise.c            |   2 +-
>  mm/memory.c             |   4 +-
>  mm/mempolicy.c          |   4 +-
>  mm/migrate.c            |  20 ++--
>  mm/migrate_device.c     |  14 +--
>  mm/page_table_check.c   |  16 +--
>  mm/page_vma_mapped.c    |  15 +--
>  mm/pagewalk.c           |   8 +-
>  mm/rmap.c               |   4 +-
>  18 files changed, 343 insertions(+), 223 deletions(-)
[...]

> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index 971df8a16ba4..a218d9922234 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -11,7 +11,7 @@
>  #include <linux/pagemap.h>
>  #include <linux/rmap.h>
>  #include <linux/swap.h>
> -#include <linux/swapops.h>
> +#include <linux/leafops.h>
>  
>  #include "../internal.h"
>  #include "ops-common.h"
> @@ -51,7 +51,7 @@ void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr
>  	if (likely(pte_present(pteval)))
>  		pfn = pte_pfn(pteval);
>  	else
> -		pfn = swp_offset_pfn(pte_to_swp_entry(pteval));
> +		pfn = softleaf_to_pfn(softleaf_from_pte(pteval));
>  
>  	folio = damon_get_folio(pfn);
>  	if (!folio)
> @@ -83,7 +83,7 @@ void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr
>  	if (likely(pmd_present(pmdval)))
>  		pfn = pmd_pfn(pmdval);
>  	else
> -		pfn = swp_offset_pfn(pmd_to_swp_entry(pmdval));
> +		pfn = softleaf_to_pfn(softleaf_from_pmd(pmdval));
>  
>  	folio = damon_get_folio(pfn);
>  	if (!folio)

I'll try to take a time to review the whole series.  But, for now, for this
DAMON part change,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

