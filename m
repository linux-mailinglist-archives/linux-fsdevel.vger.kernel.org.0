Return-Path: <linux-fsdevel+bounces-79596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDKOAAjGqmnVWwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 13:18:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C5D220676
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 13:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE8D430F8502
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 12:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E4438F234;
	Fri,  6 Mar 2026 12:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edn61naH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F7935F160;
	Fri,  6 Mar 2026 12:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772799165; cv=none; b=XF6Tgok6Lt+JKKGC204l6fvJCy+pqNzVL13DbEOpfPQi/iE8zritAPWROhtTMmz5eKxvdTzGATI2vHikNuhIksM3lE3PuCrpzJqVNZ4Uz3D9LhmZ3o+aq7CIr1W2RGgUCauBQV3BjjKtF6qv1DHuBZyT6YaeMu7/0oKJLfRFKjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772799165; c=relaxed/simple;
	bh=0pXAFOIFGu2oV25L8o52sQR97OfC/9uMSwkci4VWiEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hh1u47Povq6Mb4+FIKXYvDNcftGM3z+0sa8C+AlWOm95DlCnTN4Yykx/lJMzVeHJhMAw6WJmFQLlq8A+AvCB2IjWYBxKZwcGi8+M5x8hXpnYg8RbDMIAWbas81KhKT/ediUTYqOU5v2cf9bln99hjjkKipEaERIRMozVQLCja60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edn61naH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62C0C2BCAF;
	Fri,  6 Mar 2026 12:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772799165;
	bh=0pXAFOIFGu2oV25L8o52sQR97OfC/9uMSwkci4VWiEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=edn61naHlNfCj6ZsP5AwEUGw9CwfdJ2+qp4E3P9NrRqaex7Mzs8I9+4N3Nb8iPzP+
	 MDPjuNK9A6Qetf2KX0tPdvyQxuXEHgWgnJamhiPEMXHArV5hNb6HubqUE67/ScusgV
	 91Op1mHTejDA5unrODiPadH1XnhaGXoJamDx/1ZP/XFup2VlHpsi86fd3iVR7t4ble
	 +R8KS6ktipoGCS0QCYK2SAjgpa//+C9kqsjUElB2UcpnwNnT+t6UY96TQdEfREXxm8
	 O4hbjLTlhFJ/5gK3fCzWdjUFddgW6o4Vk83yvQglRcCnELrZY+0WRVW3GmusGUbG5S
	 PqwmeKjYrR3zQ==
Date: Fri, 6 Mar 2026 12:12:42 +0000
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
Subject: Re: [PATCH v1 04/16] mm/memory: simplify calculation in
 unmap_mapping_range_tree()
Message-ID: <6c6bf2d6-bc0f-4721-a57d-6b9c5f2a5c66@lucifer.local>
References: <20260227200848.114019-1-david@kernel.org>
 <20260227200848.114019-5-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227200848.114019-5-david@kernel.org>
X-Rspamd-Queue-Id: 78C5D220676
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
	TAGGED_FROM(0.00)[bounces-79596-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lucifer.local:mid]
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 09:08:35PM +0100, David Hildenbrand (Arm) wrote:
> Let's simplify the calculation a bit further to make it easier to get,
> reusing vma_last_pgoff() which we move from interval_tree.c to mm.h.
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks, some crusty old code here much improved. LGTM, so:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  include/linux/mm.h |  5 +++++
>  mm/interval_tree.c |  5 -----
>  mm/memory.c        | 12 +++++-------
>  3 files changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a8138ff7d1fa..d3ef586ee1c0 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4000,6 +4000,11 @@ static inline unsigned long vma_pages(const struct vm_area_struct *vma)
>  	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
>  }
>
> +static inline unsigned long vma_last_pgoff(struct vm_area_struct *vma)
> +{
> +	return vma->vm_pgoff + vma_pages(vma) - 1;
> +}
> +
>  static inline unsigned long vma_desc_size(const struct vm_area_desc *desc)
>  {
>  	return desc->end - desc->start;
> diff --git a/mm/interval_tree.c b/mm/interval_tree.c
> index 32e390c42c53..32bcfbfcf15f 100644
> --- a/mm/interval_tree.c
> +++ b/mm/interval_tree.c
> @@ -15,11 +15,6 @@ static inline unsigned long vma_start_pgoff(struct vm_area_struct *v)
>  	return v->vm_pgoff;
>  }
>
> -static inline unsigned long vma_last_pgoff(struct vm_area_struct *v)
> -{
> -	return v->vm_pgoff + vma_pages(v) - 1;
> -}
> -
>  INTERVAL_TREE_DEFINE(struct vm_area_struct, shared.rb,
>  		     unsigned long, shared.rb_subtree_last,
>  		     vma_start_pgoff, vma_last_pgoff, /* empty */, vma_interval_tree)
> diff --git a/mm/memory.c b/mm/memory.c
> index 5c47309331f5..e4154f03feac 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4227,17 +4227,15 @@ static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
>  					    struct zap_details *details)
>  {
>  	struct vm_area_struct *vma;
> -	pgoff_t vba, vea, zba, zea;
>  	unsigned long start, size;
>  	struct mmu_gather tlb;
>
>  	vma_interval_tree_foreach(vma, root, first_index, last_index) {
> -		vba = vma->vm_pgoff;
> -		vea = vba + vma_pages(vma) - 1;
> -		zba = max(first_index, vba);
> -		zea = min(last_index, vea);

These variable names... Lord.

> -		start = ((zba - vba) << PAGE_SHIFT) + vma->vm_start;
> -		size = (zea - zba + 1) << PAGE_SHIFT;
> +		const pgoff_t start_idx = max(first_index, vma->vm_pgoff);
> +		const pgoff_t end_idx = min(last_index, vma_last_pgoff(vma)) + 1;

I guess since 'end' is by-convention the +1 of last this is fine

> +
> +		start = vma->vm_start + ((start_idx - vma->vm_pgoff) << PAGE_SHIFT);
> +		size = (end_idx - start_idx) << PAGE_SHIFT;
>
>  		tlb_gather_mmu(&tlb, vma->vm_mm);
>  		zap_page_range_single_batched(&tlb, vma, start, size, details);
> --
> 2.43.0
>

