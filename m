Return-Path: <linux-fsdevel+bounces-79812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDhLAlD6rmliLAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 17:50:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED9023D141
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 17:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D9543101351
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 16:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E74B3DFC7F;
	Mon,  9 Mar 2026 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N83WeFjH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1347C3BE14A;
	Mon,  9 Mar 2026 16:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074655; cv=none; b=jiIJmXdkHaPa/GL1PHUFkuBqFbwgQRi/1izVxMiemo6u0n68m6HP9l9579zHEXAXvleDUssZNZNHn/aq/Fb00M0IbRuhIc+PmydC3XlarWa/WIjYS+81439Mwa3bCt8CJP27RkL0sfLGUH7pUE/vTeOuz/j/ntpjfEcGUKk9zcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074655; c=relaxed/simple;
	bh=Uk7QgN6xzOCWYu8MBXFyjWy0R+x2ZeLTbcNOpvXhzcE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RNgSKDtNyomlCLk2B1/HCCni4CujI6n/mP1XFJicpkgAJ0qyRroUoOlfR8+xCaoub/bWP7GEgdzp0Nn4nzstp+sH30zI21eEzsE+ljIqthw8kyP7zOjYHp8tF+YjHsvNn+kcCmDaBJOnb2O6RUaQ3u/rHJmrGFFwfY0Lu82qmsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N83WeFjH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F45C2BC86;
	Mon,  9 Mar 2026 16:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773074654;
	bh=Uk7QgN6xzOCWYu8MBXFyjWy0R+x2ZeLTbcNOpvXhzcE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=N83WeFjHOOqWdbT02p7u6F13MMV7RRau8GbcaBSyL47Q6vraRT6zI0/uD7vTeMN+7
	 jEganNn2JAI3p1bhGbQgVTlIj/PYZ25c4VNozic7qKb9tSU1YYc6xWeetAnJuwud7a
	 pSpMO/wkDQeTMONUSdQx3eHU/4lrDnGQQ3MZbE10I4mXfspZDeSov/kUkNe0L78NCB
	 rLiNZBXTOVj0tOlyFahCjpdld9enU7FrrwsPTSrEy+IBzIG7ccingg6ZVLS4fysV0R
	 cvMYjW5kHwTVCmuY0LVXEcsy6DmN2iZknFT4/P+pQzGtvpHCm6qJ5er7m3qAR6IPTW
	 T4Mx+idBPe/FQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>, linux-kernel@vger.kernel.org
Cc: "linux-mm @ kvack . org" <linux-mm@kvack.org>, "David Hildenbrand (Arm)"
 <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, David Rientjes <rientjes@google.com>, Shakeel Butt
 <shakeel.butt@linux.dev>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Alice Ryhl <aliceryhl@google.com>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank
 <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=
 <arve@android.com>, Todd Kjos
 <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, Carlos Llamas
 <cmllamas@google.com>, Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten
 <hsweeten@visionengravers.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Jason
 Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Dimitri
 Sivanich <dimitri.sivanich@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Eric Dumazet
 <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, "David S.
 Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Miguel Ojeda
 <ojeda@kernel.org>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-sgx@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v1 02/16] mm/memory: remove "zap_details" parameter from
 zap_page_range_single()
In-Reply-To: <20260227200848.114019-3-david@kernel.org>
References: <20260227200848.114019-1-david@kernel.org>
 <20260227200848.114019-3-david@kernel.org>
Date: Mon, 09 Mar 2026 16:44:10 +0000
Message-ID: <m21phtx89x.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 8ED9023D141
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79812-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kvack.org,kernel.org,linux-foundation.org,oracle.com,google.com,suse.com,suse.de,linux.dev,infradead.org,linux.ibm.com,ellerman.id.au,redhat.com,alien8.de,linuxfoundation.org,android.com,mev.co.uk,visionengravers.com,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,ziepe.ca,hpe.com,arndb.de,iogearbox.net,arm.com,davemloft.net,lists.ozlabs.org,vger.kernel.org,lists.freedesktop.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[puranjay@kernel.org,linux-fsdevel@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	RCPT_COUNT_GT_50(0.00)[75];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

"David Hildenbrand (Arm)" <david@kernel.org> writes:

> Nobody except memory.c should really set that parameter to non-NULL. So
> let's just drop it and make unmap_mapping_range_vma() use
> zap_page_range_single_batched() instead.
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  arch/s390/mm/gmap_helpers.c    |  2 +-
>  drivers/android/binder_alloc.c |  2 +-
>  include/linux/mm.h             |  5 ++---
>  kernel/bpf/arena.c             |  3 +--
>  kernel/events/core.c           |  2 +-
>  mm/madvise.c                   |  3 +--
>  mm/memory.c                    | 16 ++++++++++------
>  net/ipv4/tcp.c                 |  5 ++---
>  rust/kernel/mm/virt.rs         |  2 +-
>  9 files changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/arch/s390/mm/gmap_helpers.c b/arch/s390/mm/gmap_helpers.c
> index dea83e3103e5..ae2d59a19313 100644
> --- a/arch/s390/mm/gmap_helpers.c
> +++ b/arch/s390/mm/gmap_helpers.c
> @@ -89,7 +89,7 @@ void gmap_helper_discard(struct mm_struct *mm, unsigned long vmaddr, unsigned lo
>  		if (!vma)
>  			return;
>  		if (!is_vm_hugetlb_page(vma))
> -			zap_page_range_single(vma, vmaddr, min(end, vma->vm_end) - vmaddr, NULL);
> +			zap_page_range_single(vma, vmaddr, min(end, vma->vm_end) - vmaddr);
>  		vmaddr = vma->vm_end;
>  	}
>  }
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 241f16a9b63d..dd2046bd5cde 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -1185,7 +1185,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
>  	if (vma) {
>  		trace_binder_unmap_user_start(alloc, index);
>  
> -		zap_page_range_single(vma, page_addr, PAGE_SIZE, NULL);
> +		zap_page_range_single(vma, page_addr, PAGE_SIZE);
>  
>  		trace_binder_unmap_user_end(alloc, index);
>  	}
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ecff8268089b..a8138ff7d1fa 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2835,11 +2835,10 @@ struct page *vm_normal_page_pud(struct vm_area_struct *vma, unsigned long addr,
>  void zap_vma_ptes(struct vm_area_struct *vma, unsigned long address,
>  		  unsigned long size);
>  void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
> -			   unsigned long size, struct zap_details *details);
> +			   unsigned long size);
>  static inline void zap_vma_pages(struct vm_area_struct *vma)
>  {
> -	zap_page_range_single(vma, vma->vm_start,
> -			      vma->vm_end - vma->vm_start, NULL);
> +	zap_page_range_single(vma, vma->vm_start, vma->vm_end - vma->vm_start);
>  }
>  struct mmu_notifier_range;
>  
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 144f30e740e8..c34510d83b1f 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -656,8 +656,7 @@ static void zap_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
>  	guard(mutex)(&arena->lock);
>  	/* iterate link list under lock */
>  	list_for_each_entry(vml, &arena->vma_list, head)
> -		zap_page_range_single(vml->vma, uaddr,
> -				      PAGE_SIZE * page_cnt, NULL);
> +		zap_page_range_single(vml->vma, uaddr, PAGE_SIZE * page_cnt);
>  }

Acked-by: Puranjay Mohan <puranjay@kernel.org>

