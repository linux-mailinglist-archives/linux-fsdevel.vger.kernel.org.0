Return-Path: <linux-fsdevel+bounces-79606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMPuGfPLqmnUXAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 13:43:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F7F220DBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 13:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02793309AD60
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 12:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2248628134F;
	Fri,  6 Mar 2026 12:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teU+WZvc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8939C286D53;
	Fri,  6 Mar 2026 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772800810; cv=none; b=FIERidZlnzKuqOQMylcQlpd5eVAKVMY+FdzbvCGSwIe2X0fMt7JuK/ECDnvjVvhke/+vqDRlRlaZ90mNat/J/8H6GnKB2oqp45AXTujKaXYInhhk8FB6qMF6ogYyExJLxe9IHOKcmNVun/k66HawNSAIfYRO6ECLTQcBN7lluLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772800810; c=relaxed/simple;
	bh=momqQiCPeBiESmsNjbCQuXjIElnPD5t8ixlqkLdaUNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oi9peaPdNngUeQ35HPbdsfC2NO+/sAWbk+FWiUqlnGdW9GdcY81vYWPAiH02Yg0G840kKycA+/HZn4S7yDQFMQEYU6o+NTQlqnxSqvKBEKMdIGXyZ5SEEmdrpqUkjoXTYWR8xpvZUnFpg7vGd0ezofZmehB9T8yLo1jg0wGK1UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teU+WZvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E997C4CEF7;
	Fri,  6 Mar 2026 12:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772800810;
	bh=momqQiCPeBiESmsNjbCQuXjIElnPD5t8ixlqkLdaUNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=teU+WZvcr3Vfjfj4PS79KVLwqpyqTY1ONa1PtwIvjXtMon6hdWoFyi7tYSgQVQlA7
	 7WqNZXjH072FsKlQxHwMb1xYD4ogJ/HhRqFMhvz7mUpomd6qDRF1LsEb2Nx0xCA20F
	 Q306mWNpenrHSDponyi32Ye/+ALDPg+T87ZCaJf9rHbmPLs7TEcXwfiNFZJ08Qk58i
	 YudRyMnPxWInwwAAt3CqHvwKRQrMAo7VQbC5DvtngGuMvZuxZUii1u78G4eRDQ1D/r
	 cgHhuLioq6MaNE+pd+1wCN6iTybUQcrEBmRwhDJWiYLDD7kyNQioEEvs3ECG9KmNxt
	 q/+pMMPgggcHw==
Date: Fri, 6 Mar 2026 12:40:07 +0000
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
Subject: Re: [PATCH v1 08/16] mm/memory: move adjusting of address range to
 unmap_vmas()
Message-ID: <6858ccdd-5065-4396-81c9-489bf2d43c9e@lucifer.local>
References: <20260227200848.114019-1-david@kernel.org>
 <20260227200848.114019-9-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227200848.114019-9-david@kernel.org>
X-Rspamd-Queue-Id: D3F7F220DBB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,linux-foundation.org,oracle.com,kernel.org,google.com,suse.com,suse.de,linux.dev,infradead.org,linux.ibm.com,ellerman.id.au,redhat.com,alien8.de,linuxfoundation.org,android.com,mev.co.uk,visionengravers.com,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,ziepe.ca,hpe.com,arndb.de,iogearbox.net,arm.com,davemloft.net,lists.ozlabs.org,lists.freedesktop.org];
	TAGGED_FROM(0.00)[bounces-79606-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[74];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lucifer.local:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 09:08:39PM +0100, David Hildenbrand (Arm) wrote:
> __zap_vma_range() has two callers, whereby
> zap_page_range_single_batched() documents that the range must fit into
> the VMA range.
>
> So move adjusting the range to unmap_vmas() where it is actually
> required and add a safety check in __zap_vma_range() instead. In
> unmap_vmas(), we'd never expect to have empty ranges (otherwise, why
> have the vma in there in the first place).
>
> __zap_vma_range() will no longer be called with start == end, so
> cleanup the function a bit. While at it, simplify the overly long
> comment to its core message.
>
> We will no longer call uprobe_munmap() for start == end, which actually
> seems to be the right thing to do.
>
> Note that hugetlb_zap_begin()->...->adjust_range_if_pmd_sharing_possible()
> cannot result in the range exceeding the vma range.
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM, So:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  mm/memory.c | 58 +++++++++++++++++++++--------------------------------
>  1 file changed, 23 insertions(+), 35 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index f0aaec57a66b..fdcd2abf29c2 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2073,44 +2073,28 @@ static void unmap_page_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  	tlb_end_vma(tlb, vma);
>  }
>
> -
> -static void __zap_vma_range(struct mmu_gather *tlb,
> -		struct vm_area_struct *vma, unsigned long start_addr,
> -		unsigned long end_addr, struct zap_details *details)
> +static void __zap_vma_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
> +		unsigned long start, unsigned long end,
> +		struct zap_details *details)
>  {
> -	unsigned long start = max(vma->vm_start, start_addr);
> -	unsigned long end;
> -
> -	if (start >= vma->vm_end)
> -		return;
> -	end = min(vma->vm_end, end_addr);
> -	if (end <= vma->vm_start)
> -		return;
> +	VM_WARN_ON_ONCE(start >= end || !range_in_vma(vma, start, end));
>
>  	if (vma->vm_file)
>  		uprobe_munmap(vma, start, end);
>
> -	if (start != end) {
> -		if (unlikely(is_vm_hugetlb_page(vma))) {
> -			/*
> -			 * It is undesirable to test vma->vm_file as it
> -			 * should be non-null for valid hugetlb area.
> -			 * However, vm_file will be NULL in the error
> -			 * cleanup path of mmap_region. When
> -			 * hugetlbfs ->mmap method fails,
> -			 * mmap_region() nullifies vma->vm_file
> -			 * before calling this function to clean up.
> -			 * Since no pte has actually been setup, it is
> -			 * safe to do nothing in this case.
> -			 */
> -			if (vma->vm_file) {
> -				zap_flags_t zap_flags = details ?
> -				    details->zap_flags : 0;
> -				__unmap_hugepage_range(tlb, vma, start, end,
> -							     NULL, zap_flags);
> -			}
> -		} else
> -			unmap_page_range(tlb, vma, start, end, details);
> +	if (unlikely(is_vm_hugetlb_page(vma))) {
> +		zap_flags_t zap_flags = details ? details->zap_flags : 0;
> +
> +		/*
> +		 * vm_file will be NULL when we fail early while instantiating
> +		 * a new mapping. In this case, no pages were mapped yet and
> +		 * there is nothing to do.
> +		 */
> +		if (!vma->vm_file)
> +			return;
> +		__unmap_hugepage_range(tlb, vma, start, end, NULL, zap_flags);
> +	} else {
> +		unmap_page_range(tlb, vma, start, end, details);
>  	}
>  }
>
> @@ -2174,8 +2158,9 @@ void unmap_vmas(struct mmu_gather *tlb, struct unmap_desc *unmap)
>  				unmap->vma_start, unmap->vma_end);
>  	mmu_notifier_invalidate_range_start(&range);
>  	do {
> -		unsigned long start = unmap->vma_start;
> -		unsigned long end = unmap->vma_end;
> +		unsigned long start = max(vma->vm_start, unmap->vma_start);
> +		unsigned long end = min(vma->vm_end, unmap->vma_end);
> +
>  		hugetlb_zap_begin(vma, &start, &end);
>  		__zap_vma_range(tlb, vma, start, end, &details);
>  		hugetlb_zap_end(vma, &details);
> @@ -2204,6 +2189,9 @@ void zap_page_range_single_batched(struct mmu_gather *tlb,
>
>  	VM_WARN_ON_ONCE(!tlb || tlb->mm != vma->vm_mm);
>
> +	if (unlikely(!size))
> +		return;
> +
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm,
>  				address, end);
>  	hugetlb_zap_begin(vma, &range.start, &range.end);
> --
> 2.43.0
>

