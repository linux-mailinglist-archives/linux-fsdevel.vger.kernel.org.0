Return-Path: <linux-fsdevel+bounces-52153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 480FDADFD2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 07:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CFE01890F09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 05:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2451244662;
	Thu, 19 Jun 2025 05:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjXP7rVJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3271D555;
	Thu, 19 Jun 2025 05:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750312089; cv=none; b=oq0JgNzCGIZ/fMUtE8amNhkEGH3zcm3D+SyVDr9ghaNBRCNH5OjIqCnSH1VprF/v/HNLZlx/Kc6PLafUeJFsoF/IvjhHGuMbmJ2NFTspv1k+cfgEw3HE5jfR2ua/ahkYK/juegqkzXiHzun9j4KOIgRf5Iqmf0W2/sQcI6xYyxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750312089; c=relaxed/simple;
	bh=naO5r0xMIhdjbn0oOa+SVmj9KjDZ5worxHK7bSVntUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxtyFKOdauKgdqpLWbLmvxuGG6gOxa+SqNfWe2mTDxq9zpJBL4YO8FiO4obmJYPPiUVp135wH5/xxar2Mrh92sZ0byZn9WDG86+D8SwpudeQOGYSEuZHTCxIuU4SSuTORp3sP9qlMhQM9eXAeAGmjJfChkN7b+4I7fxmpK8Nxsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjXP7rVJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCB9C4CEEA;
	Thu, 19 Jun 2025 05:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750312088;
	bh=naO5r0xMIhdjbn0oOa+SVmj9KjDZ5worxHK7bSVntUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IjXP7rVJ7AZnRuppJyLrpp5E8Fh+t+2oljLVnWBBBSn/d1vR0eGIWRYGA9tuTPZxk
	 1WjJMU7H0LqXwDq8R0BlorxkYnEHHHlDMoVIzC4TN0b7sC1cULh3G+MWJHwVH7xkz9
	 tCPMfdyKM5V0i4bvNc7Nmlusq60gK1you1vNrbR0OMNiLtHUI3nfQN0juBAxkHM6/o
	 ts+aKMfmoW7KUXQXeNQG3kObJpnfs/6SAEy+ZvEIdSUbOESxfPgslyESbzwTawbWW0
	 0p+BbIlpITQh6XRqByB/6dGMmYRgJ3In9Qc8ufkd7ZoKCLwjJIVuYBHy37Sjo6Og4z
	 FW+uh64HrHsSA==
Date: Thu, 19 Jun 2025 08:47:46 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>, Peter Xu <peterx@redhat.com>,
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-sgx@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	nvdimm@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] use vm_flags_t consistently
Message-ID: <aFOkguMF3QJpr4VA@kernel.org>
References: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1750274467.git.lorenzo.stoakes@oracle.com>

On Wed, Jun 18, 2025 at 08:42:51PM +0100, Lorenzo Stoakes wrote:
> The VMA flags field vma->vm_flags is of type vm_flags_t. Right now this is
> exactly equivalent to unsigned long, but it should not be assumed to be.
> 
> Much code that references vma->vm_flags already correctly uses vm_flags_t,
> but a fairly large chunk of code simply uses unsigned long and assumes that
> the two are equivalent.
> 
> This series corrects that and has us use vm_flags_t consistently.
> 
> This series is motivated by the desire to, in a future series, adjust
> vm_flags_t to be a u64 regardless of whether the kernel is 32-bit or 64-bit
> in order to deal with the VMA flag exhaustion issue and avoid all the
> various problems that arise from it (being unable to use certain features
> in 32-bit, being unable to add new flags except for 64-bit, etc.)
> 
> This is therefore a critical first step towards that goal. At any rate,
> using the correct type is of value regardless.
> 
> We additionally take the opportunity to refer to VMA flags as vm_flags
> where possible to make clear what we're referring to.
> 
> Overall, this series does not introduce any functional change.
> 
> Lorenzo Stoakes (3):
>   mm: change vm_get_page_prot() to accept vm_flags_t argument
>   mm: update core kernel code to use vm_flags_t consistently
>   mm: update architecture and driver code to use vm_flags_t

For the series

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
 
>  arch/arm/mm/fault.c                        |   2 +-
>  arch/arm64/include/asm/mman.h              |  10 +-
>  arch/arm64/mm/fault.c                      |   2 +-
>  arch/arm64/mm/mmap.c                       |   2 +-
>  arch/arm64/mm/mmu.c                        |   2 +-
>  arch/powerpc/include/asm/book3s/64/pkeys.h |   3 +-
>  arch/powerpc/include/asm/mman.h            |   2 +-
>  arch/powerpc/include/asm/pkeys.h           |   4 +-
>  arch/powerpc/kvm/book3s_hv_uvmem.c         |   2 +-
>  arch/sparc/include/asm/mman.h              |   4 +-
>  arch/sparc/mm/init_64.c                    |   2 +-
>  arch/x86/kernel/cpu/sgx/encl.c             |   8 +-
>  arch/x86/kernel/cpu/sgx/encl.h             |   2 +-
>  arch/x86/mm/pgprot.c                       |   2 +-
>  fs/exec.c                                  |   2 +-
>  fs/userfaultfd.c                           |   2 +-
>  include/linux/coredump.h                   |   2 +-
>  include/linux/huge_mm.h                    |  12 +-
>  include/linux/khugepaged.h                 |   4 +-
>  include/linux/ksm.h                        |   4 +-
>  include/linux/memfd.h                      |   4 +-
>  include/linux/mm.h                         |  10 +-
>  include/linux/mm_types.h                   |   2 +-
>  include/linux/mman.h                       |   4 +-
>  include/linux/pgtable.h                    |   2 +-
>  include/linux/rmap.h                       |   4 +-
>  include/linux/userfaultfd_k.h              |   4 +-
>  include/trace/events/fs_dax.h              |   6 +-
>  mm/debug.c                                 |   2 +-
>  mm/execmem.c                               |   8 +-
>  mm/filemap.c                               |   2 +-
>  mm/gup.c                                   |   2 +-
>  mm/huge_memory.c                           |   2 +-
>  mm/hugetlb.c                               |   4 +-
>  mm/internal.h                              |   4 +-
>  mm/khugepaged.c                            |   4 +-
>  mm/ksm.c                                   |   2 +-
>  mm/madvise.c                               |   4 +-
>  mm/mapping_dirty_helpers.c                 |   2 +-
>  mm/memfd.c                                 |   8 +-
>  mm/memory.c                                |   4 +-
>  mm/mmap.c                                  |  16 +-
>  mm/mprotect.c                              |   8 +-
>  mm/mremap.c                                |   2 +-
>  mm/nommu.c                                 |  12 +-
>  mm/rmap.c                                  |   4 +-
>  mm/shmem.c                                 |   6 +-
>  mm/userfaultfd.c                           |  14 +-
>  mm/vma.c                                   |  78 +++---
>  mm/vma.h                                   |  16 +-
>  mm/vmscan.c                                |   4 +-
>  tools/testing/vma/vma.c                    | 266 ++++++++++-----------
>  tools/testing/vma/vma_internal.h           |  12 +-
>  53 files changed, 298 insertions(+), 297 deletions(-)
> 
> --
> 2.49.0

-- 
Sincerely yours,
Mike.

