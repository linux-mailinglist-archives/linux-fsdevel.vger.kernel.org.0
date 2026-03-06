Return-Path: <linux-fsdevel+bounces-79598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDPQAinGqmnVWwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 13:18:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6432A220694
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 13:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 083D8307DC7A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 12:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35363803C9;
	Fri,  6 Mar 2026 12:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JE9hl+xg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCAA30EF69;
	Fri,  6 Mar 2026 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772799426; cv=none; b=PlGd14rqipZLUap+TQL04rBOhRsunhOtek6zP2dxqVHXpbPA609RCImU9ZPUMHtmwcVvmmxIyeL8xydRNScSQLv1hjZGavNG+49dythof+Ddyt15CovUW86Cc+m5EQa2f5DvHpZvC0WKzn4nmnHMNWysYi8kkXhIY2qWACsJyTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772799426; c=relaxed/simple;
	bh=E50Nei4wvO5acKQ5WAuR9y8yrxBw8Jw9n6m//WAfpNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/zM7BmZen2AAgjV9MHw8zTPQq1CNq5nrl1LFm+YHw28QJI/yCzktzGbmxVG8fYLoco8Xz8jI0ZDdckXesem9YSLxGeOUj9tCVtTMCz16wOMNne6rLwBOAT0oNzFuKnabGF4TDyYHmnO9Rtte/GMN6/IdI1aS5Fv2iqDRgRuuek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JE9hl+xg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9601AC4CEF7;
	Fri,  6 Mar 2026 12:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772799426;
	bh=E50Nei4wvO5acKQ5WAuR9y8yrxBw8Jw9n6m//WAfpNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JE9hl+xgT0bTGi+BM5jUSHSxJhmfXyDYuZyy882H8pwaPVW4rs91GqXsOlDdNYt5q
	 M4CYD21uXiIoE80aCpIXZWa8pvS6BpzRhby5F3zlbgDBohqfN8gLvqI1ZzEKj9Sq8O
	 1GA8U2yXsayzOcXwk/z9rDzRougLhaH2sFQZ/lImuHVanVDszwy6gcpcLHaEn0JF34
	 5MRb84nwU6hkVV8bxr42O43gDIOYuZx7PoAczRQyQjOzRXl+pydnhhFnDCu0OWdTD3
	 GeXNhxm0JknludP4ZgMHI0L5kkBWpm7KDg9wTx0PM6ikXJpjNR7e3ecgYQUbTFzh7m
	 tM4T4pFHUGsng==
Date: Fri, 6 Mar 2026 12:17:03 +0000
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
Subject: Re: [PATCH v1 06/16] mm/oom_kill: factor out zapping of VMA into
 zap_vma_for_reaping()
Message-ID: <d92e21ff-50cd-485b-8f48-621e8ae1b169@lucifer.local>
References: <20260227200848.114019-1-david@kernel.org>
 <20260227200848.114019-7-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227200848.114019-7-david@kernel.org>
X-Rspamd-Queue-Id: 6432A220694
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
	TAGGED_FROM(0.00)[bounces-79598-lists,linux-fsdevel=lfdr.de];
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

On Fri, Feb 27, 2026 at 09:08:37PM +0100, David Hildenbrand (Arm) wrote:
> Let's factor it out so we can turn unmap_page_range() into a static
> function instead, and so oom reaping has a clean interface to call.
>
> Note that hugetlb is not supported, because it would require a bunch of
> hugetlb-specific further actions (see zap_page_range_single_batched()).

Ugh gawd. Hugetlb.

>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Seems reasonable, so:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  mm/internal.h |  5 +----
>  mm/memory.c   | 36 ++++++++++++++++++++++++++++++++----
>  mm/oom_kill.c | 15 +--------------
>  3 files changed, 34 insertions(+), 22 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index 39ab37bb0e1d..df9190f7db0e 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -536,13 +536,10 @@ static inline void sync_with_folio_pmd_zap(struct mm_struct *mm, pmd_t *pmdp)
>  }
>
>  struct zap_details;
> -void unmap_page_range(struct mmu_gather *tlb,
> -			     struct vm_area_struct *vma,
> -			     unsigned long addr, unsigned long end,
> -			     struct zap_details *details);
>  void zap_page_range_single_batched(struct mmu_gather *tlb,
>  		struct vm_area_struct *vma, unsigned long addr,
>  		unsigned long size, struct zap_details *details);
> +int zap_vma_for_reaping(struct vm_area_struct *vma);
>  int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
>  			   gfp_t gfp);
>
> diff --git a/mm/memory.c b/mm/memory.c
> index e4154f03feac..621f38ae1425 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2054,10 +2054,9 @@ static inline unsigned long zap_p4d_range(struct mmu_gather *tlb,
>  	return addr;
>  }
>
> -void unmap_page_range(struct mmu_gather *tlb,
> -			     struct vm_area_struct *vma,
> -			     unsigned long addr, unsigned long end,
> -			     struct zap_details *details)
> +static void unmap_page_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
> +		unsigned long addr, unsigned long end,
> +		struct zap_details *details)
>  {
>  	pgd_t *pgd;
>  	unsigned long next;
> @@ -2115,6 +2114,35 @@ static void unmap_single_vma(struct mmu_gather *tlb,
>  	}
>  }
>
> +/**
> + * zap_vma_for_reaping - zap all page table entries in the vma without blocking
> + * @vma: The vma to zap.
> + *
> + * Zap all page table entries in the vma without blocking for use by the oom
> + * killer. Hugetlb vmas are not supported.
> + *
> + * Returns: 0 on success, -EBUSY if we would have to block.
> + */
> +int zap_vma_for_reaping(struct vm_area_struct *vma)
> +{
> +	struct mmu_notifier_range range;
> +	struct mmu_gather tlb;
> +
> +	VM_WARN_ON_ONCE(is_vm_hugetlb_page(vma));
> +
> +	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm,
> +				vma->vm_start, vma->vm_end);
> +	tlb_gather_mmu(&tlb, vma->vm_mm);
> +	if (mmu_notifier_invalidate_range_start_nonblock(&range)) {
> +		tlb_finish_mmu(&tlb);
> +		return -EBUSY;
> +	}
> +	unmap_page_range(&tlb, vma, range.start, range.end, NULL);
> +	mmu_notifier_invalidate_range_end(&range);
> +	tlb_finish_mmu(&tlb);
> +	return 0;
> +}
> +
>  /**
>   * unmap_vmas - unmap a range of memory covered by a list of vma's
>   * @tlb: address of the caller's struct mmu_gather
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 0ba56fcd10d5..54b7a8fe5136 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -548,21 +548,8 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
>  		 * count elevated without a good reason.
>  		 */
>  		if (vma_is_anonymous(vma) || !(vma->vm_flags & VM_SHARED)) {
> -			struct mmu_notifier_range range;
> -			struct mmu_gather tlb;
> -
> -			mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0,
> -						mm, vma->vm_start,
> -						vma->vm_end);
> -			tlb_gather_mmu(&tlb, mm);
> -			if (mmu_notifier_invalidate_range_start_nonblock(&range)) {
> -				tlb_finish_mmu(&tlb);
> +			if (zap_vma_for_reaping(vma))
>  				ret = false;
> -				continue;
> -			}
> -			unmap_page_range(&tlb, vma, range.start, range.end, NULL);
> -			mmu_notifier_invalidate_range_end(&range);
> -			tlb_finish_mmu(&tlb);
>  		}
>  	}
>
> --
> 2.43.0
>

