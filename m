Return-Path: <linux-fsdevel+bounces-79604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QH8xCojJqmlWXAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 13:33:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D022D220B14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 13:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B85E306CDD8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 12:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307A721B1BF;
	Fri,  6 Mar 2026 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvR/7HPf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51261BD9C9;
	Fri,  6 Mar 2026 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772800282; cv=none; b=dSNpfbNQtDTVlUqgCHry8qN7Kkr5I0h79C/dkPYlGXF0PLVwdVTB+dAaAR7eHzMjaeSdjlh32d3G5599JmXmbM7NBkWP9f/ymy4jSLjhyACSlxNtOAddRLfSrCoAqDLarT1KocTpou8H11jQ0qccVcoZXRy37PE6GynrSyzppOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772800282; c=relaxed/simple;
	bh=LAJ3eHMG09TcFhgWs2EdIeu79xlpIcUA+/nV0cLjx24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9Yy9HPW1DxD1IHVdxOH+ohiTUP32I0mg2bf55uVM3G6tKi6HF77tDd+mg/RBGvMzhb49ownTp2u9ZWbT7+RvU4XmFS8zP95FBergtjmdm+PwaREj8mtBVSqqFhJUwcr5d+LKJfIohfPHb5+b7HdJfxIXW/uKSmHOggQlsp96pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvR/7HPf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF81C2BC86;
	Fri,  6 Mar 2026 12:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772800282;
	bh=LAJ3eHMG09TcFhgWs2EdIeu79xlpIcUA+/nV0cLjx24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LvR/7HPf6wcbcyYRLsw0NDSdEUL1xaUkAW3JmG67UyRk8nOpjrEr2b2NGZY1Rm0QK
	 rmjZWXs/kgIZrKXYtCLoe2wOfAeqwFjFcPcvt+uoLGfKG/Qo+cZY/KlECky/nu7yfe
	 VWWd7vd2jX7axW3zB4eXySNQkQ60kLA1VNARXlEtx0PgK1qc1mJkOGYLZPeIU1jkWi
	 k2zaxtrQMGavqzpX3B010TqicSFWti+U38spA0MblbRmX/eAooWrBcs3e2lHItMiNa
	 oY8qJI8Dwm7XxpAxiijBNODF9u6hWMWr4FWbAtfufjRBYMdKm2jnZp6E+SB/W5VYzM
	 3FhaTnLG18eEQ==
Date: Fri, 6 Mar 2026 12:31:18 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
	"linux-mm @ kvack . org" <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Alice Ryhl <aliceryhl@google.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Ian Abbott <abbotti@mev.co.uk>, 
	H Hartley Sweeten <hsweeten@visionengravers.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Dimitri Sivanich <dimitri.sivanich@hpe.com>, 
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-sgx@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org, 
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v1 13/16] mm: rename zap_page_range_single_batched() to
 zap_vma_range_batched()
Message-ID: <c63bd1e9-52b0-42a3-a568-bfb0ac0afd5b@lucifer.local>
References: <20260227200848.114019-1-david@kernel.org>
 <20260227200848.114019-14-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227200848.114019-14-david@kernel.org>
X-Rspamd-Queue-Id: D022D220B14
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,linux-foundation.org,oracle.com,kernel.org,google.com,suse.com,suse.de,linux.dev,infradead.org,linux.ibm.com,ellerman.id.au,redhat.com,alien8.de,linuxfoundation.org,android.com,mev.co.uk,visionengravers.com,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,ziepe.ca,hpe.com,arndb.de,iogearbox.net,arm.com,davemloft.net,lists.ozlabs.org,lists.freedesktop.org];
	TAGGED_FROM(0.00)[bounces-79604-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[74];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lucifer.local:mid]
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 09:08:44PM +0100, David Hildenbrand (Arm) wrote:
> Let's make the naming more consistent with our new naming scheme.
>
> While at it, polish the kerneldoc a bit.
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM, so:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  mm/internal.h |  2 +-
>  mm/madvise.c  |  5 ++---
>  mm/memory.c   | 23 +++++++++++++----------
>  3 files changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index df9190f7db0e..15a1b3f0a6d1 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -536,7 +536,7 @@ static inline void sync_with_folio_pmd_zap(struct mm_struct *mm, pmd_t *pmdp)
>  }
>
>  struct zap_details;
> -void zap_page_range_single_batched(struct mmu_gather *tlb,
> +void zap_vma_range_batched(struct mmu_gather *tlb,
>  		struct vm_area_struct *vma, unsigned long addr,
>  		unsigned long size, struct zap_details *details);
>  int zap_vma_for_reaping(struct vm_area_struct *vma);
> diff --git a/mm/madvise.c b/mm/madvise.c
> index b51f216934f3..fb5fcdff2b66 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -855,9 +855,8 @@ static long madvise_dontneed_single_vma(struct madvise_behavior *madv_behavior)
>  		.reclaim_pt = true,
>  	};
>
> -	zap_page_range_single_batched(
> -			madv_behavior->tlb, madv_behavior->vma, range->start,
> -			range->end - range->start, &details);
> +	zap_vma_range_batched(madv_behavior->tlb, madv_behavior->vma,
> +			      range->start, range->end - range->start, &details);
>  	return 0;
>  }
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 1c0bcdfc73b7..e611e9af4e85 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2167,17 +2167,20 @@ void unmap_vmas(struct mmu_gather *tlb, struct unmap_desc *unmap)
>  }
>
>  /**
> - * zap_page_range_single_batched - remove user pages in a given range
> + * zap_vma_range_batched - zap page table entries in a vma range
>   * @tlb: pointer to the caller's struct mmu_gather
> - * @vma: vm_area_struct holding the applicable pages
> - * @address: starting address of pages to remove
> - * @size: number of bytes to remove
> - * @details: details of shared cache invalidation
> + * @vma: the vma covering the range to zap
> + * @address: starting address of the range to zap
> + * @size: number of bytes to zap
> + * @details: details specifying zapping behavior
> + *
> + * @tlb must not be NULL. The provided address range must be fully
> + * contained within @vma. If @vma is for hugetlb, @tlb is flushed and
> + * re-initialized by this function.
>   *
> - * @tlb shouldn't be NULL.  The range must fit into one VMA.  If @vma is for
> - * hugetlb, @tlb is flushed and re-initialized by this function.
> + * If @details is NULL, this function will zap all page table entries.
>   */
> -void zap_page_range_single_batched(struct mmu_gather *tlb,
> +void zap_vma_range_batched(struct mmu_gather *tlb,
>  		struct vm_area_struct *vma, unsigned long address,
>  		unsigned long size, struct zap_details *details)
>  {
> @@ -2225,7 +2228,7 @@ void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
>  	struct mmu_gather tlb;
>
>  	tlb_gather_mmu(&tlb, vma->vm_mm);
> -	zap_page_range_single_batched(&tlb, vma, address, size, NULL);
> +	zap_vma_range_batched(&tlb, vma, address, size, NULL);
>  	tlb_finish_mmu(&tlb);
>  }
>
> @@ -4251,7 +4254,7 @@ static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
>  		size = (end_idx - start_idx) << PAGE_SHIFT;
>
>  		tlb_gather_mmu(&tlb, vma->vm_mm);
> -		zap_page_range_single_batched(&tlb, vma, start, size, details);
> +		zap_vma_range_batched(&tlb, vma, start, size, details);
>  		tlb_finish_mmu(&tlb);
>  	}
>  }
> --
> 2.43.0
>

