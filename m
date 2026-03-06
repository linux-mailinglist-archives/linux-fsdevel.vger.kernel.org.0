Return-Path: <linux-fsdevel+bounces-79601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OScDWfIqmlWXAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 13:28:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D20602209FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 13:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82C3C3069D49
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 12:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958C038E5C9;
	Fri,  6 Mar 2026 12:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpY6K6f3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147B41B4257;
	Fri,  6 Mar 2026 12:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772799995; cv=none; b=u/N3s5P/7qRg6mdAvp/8A6nkDZfJc1MyhhgPYRCoQpru61uXXcd1tqRG+fgmergN8n1D8xRKJLq4JKbsGiF3qg6pmuW+YM47+WaWhNFwTZ//8T2P2SBOr6f3WnTQCJCswZjmj3QTPyPmtSSFoMIjSAmT8MY+L7PRR243+q1M+Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772799995; c=relaxed/simple;
	bh=2P0FvPHpjsAhaxOTJ42bBLcCaRl4aaXZ5kIUOMNVWG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTreZUeKxD9IxpjwSJ8UI8Hf5deY1rEG5jWqewQ8vgyrIzpfk7Q6BmqzODcmVFKhAOIb0ZyetyScle9FKJHbzreHbRrSnnk8Tn/3l1gXA2xXUPIo/oDC3OyDY4afzqw024UV5VxiyxJRRbq5XI1OLsTg1EilO7yl/MNYWkZeMWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpY6K6f3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3469DC4CEF7;
	Fri,  6 Mar 2026 12:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772799994;
	bh=2P0FvPHpjsAhaxOTJ42bBLcCaRl4aaXZ5kIUOMNVWG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TpY6K6f3dvGsTTghQkD02tTChA2EwqMp/TpQHYfK66zjyTbZ8MiJAmvnb4buPO2Ol
	 ASVRmYPmWBmFSlqURChzwTNJTonaTuZGs5/EHFxAeEK+JJM37rDxeHbP+7uPAPbDNB
	 ZJH6y/sj2SwJrkrFUmj4U4BCckhgnUnVgGUpwh2dSE34XG3Ns9Rv8SqsanNsG90lqE
	 qDOiPmqQr5aqOlEJ3hzzDS0y2SX/ydi84zZQWgo/w3iX/S4bMLqQGcMFP6NoojCwMK
	 m9eF4QgqmVkNoXqv/RAre6ur7cbDQLHMeE6WwwrH+FV41xx9ytsuDVQOKxlgtAVRGn
	 vdR8q0SNanDlA==
Date: Fri, 6 Mar 2026 12:26:31 +0000
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
Subject: Re: [PATCH v1 10/16] mm/memory: use __zap_vma_range() in
 zap_vma_for_reaping()
Message-ID: <c03e1ced-6fa5-4d66-9c91-66693193383f@lucifer.local>
References: <20260227200848.114019-1-david@kernel.org>
 <20260227200848.114019-11-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227200848.114019-11-david@kernel.org>
X-Rspamd-Queue-Id: D20602209FE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,linux-foundation.org,oracle.com,kernel.org,google.com,suse.com,suse.de,linux.dev,infradead.org,linux.ibm.com,ellerman.id.au,redhat.com,alien8.de,linuxfoundation.org,android.com,mev.co.uk,visionengravers.com,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,ziepe.ca,hpe.com,arndb.de,iogearbox.net,arm.com,davemloft.net,lists.ozlabs.org,lists.freedesktop.org];
	TAGGED_FROM(0.00)[bounces-79601-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[74];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lucifer.local:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 09:08:41PM +0100, David Hildenbrand (Arm) wrote:
> Let's call __zap_vma_range() instead of unmap_page_range() to prepare
> for further cleanups.
>
> To keep the existing behavior, whereby we do not call uprobe_munmap()
> which could block, add a new "reaping" member to zap_details and use it.

I am always in favour of making further use of helper structs :)

>
> Likely we should handle the possible blocking in uprobe_munmap()
> differently, but for now keep it unchanged.
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

OK this looks like it's doing the equivalent of what was there before, so:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  include/linux/mm.h |  1 +
>  mm/memory.c        | 13 +++++++++----
>  2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 21b67c203e62..4710f7c7495a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2800,6 +2800,7 @@ struct zap_details {
>  	struct folio *single_folio;	/* Locked folio to be unmapped */
>  	bool skip_cows;			/* Do not zap COWed private pages */
>  	bool reclaim_pt;		/* Need reclaim page tables? */
> +	bool reaping;			/* Reaping, do not block. */
>  	zap_flags_t zap_flags;		/* Extra flags for zapping */
>  };
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 7d7c24c6917c..394b2e931974 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2079,14 +2079,18 @@ static void __zap_vma_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  		unsigned long start, unsigned long end,
>  		struct zap_details *details)
>  {
> +	const bool reaping = details && details->reaping;
> +
>  	VM_WARN_ON_ONCE(start >= end || !range_in_vma(vma, start, end));
>
> -	if (vma->vm_file)
> +	/* uprobe_munmap() might sleep, so skip it when reaping. */
> +	if (vma->vm_file && !reaping)
>  		uprobe_munmap(vma, start, end);
>
>  	if (unlikely(is_vm_hugetlb_page(vma))) {
>  		zap_flags_t zap_flags = details ? details->zap_flags : 0;
>
> +		VM_WARN_ON_ONCE(reaping);
>  		/*
>  		 * vm_file will be NULL when we fail early while instantiating
>  		 * a new mapping. In this case, no pages were mapped yet and
> @@ -2111,11 +2115,12 @@ static void __zap_vma_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>   */
>  int zap_vma_for_reaping(struct vm_area_struct *vma)
>  {
> +	struct zap_details details = {
> +		.reaping = true,
> +	};
>  	struct mmu_notifier_range range;
>  	struct mmu_gather tlb;
>
> -	VM_WARN_ON_ONCE(is_vm_hugetlb_page(vma));
> -

I guess because you've moved this safety check into __zap_vma_range()?

>  	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm,
>  				vma->vm_start, vma->vm_end);
>  	tlb_gather_mmu(&tlb, vma->vm_mm);
> @@ -2123,7 +2128,7 @@ int zap_vma_for_reaping(struct vm_area_struct *vma)
>  		tlb_finish_mmu(&tlb);
>  		return -EBUSY;
>  	}
> -	unmap_page_range(&tlb, vma, range.start, range.end, NULL);
> +	__zap_vma_range(&tlb, vma, range.start, range.end, &details);
>  	mmu_notifier_invalidate_range_end(&range);
>  	tlb_finish_mmu(&tlb);
>  	return 0;
> --
> 2.43.0
>

