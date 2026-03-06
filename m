Return-Path: <linux-fsdevel+bounces-79600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AFCL/XGqmkyXAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 13:22:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67749220785
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 13:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B42CF30330CF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 12:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F44838E5F0;
	Fri,  6 Mar 2026 12:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5AYGafZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D326F36605E;
	Fri,  6 Mar 2026 12:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772799708; cv=none; b=YyORlxNyitG5lX+aUBui5M+gNyd87+DBRILsGBZqyL1XsFxAwlv5yhhnWmg885RL7G9DqLkVak34szXf8kGWFWJX15qF+eVjWyV5912cBQOrRu34cKIu8mvTEpw69v9Y5/X2us87chzrjsE3sWVJhQONvw3u4Gx86PTWBxVg8zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772799708; c=relaxed/simple;
	bh=theG/LCt2/q2eE4jZPVvO5dWH6DfzprovWLt+cDnxxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSm4UuHaaKXjqR9/2AffRtgrn22rUTjAMjZSgiC+XSC3EPWzQfdhcrirNcwXa4weneTlgBcCWB2/8clSX9wFMnOKEI3qN/+9RGECT5A3FJFvCbOZjRJO4JG4OY7wwHtpNyKP/XjjiNtk+ZhloZazDuUg2f0nNOikVsGR53ELNn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5AYGafZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2EEC4CEF7;
	Fri,  6 Mar 2026 12:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772799708;
	bh=theG/LCt2/q2eE4jZPVvO5dWH6DfzprovWLt+cDnxxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h5AYGafZBAupVubVI+ZD7t499uAUfoIBiWhpl8owqkPKw6XrDaEVq2gk6V3VMTbJG
	 I4jRzHR0ZgmZkpNFwz4WPgqzlj/ZTXG8Mkg6mu7rnyphpzPSp0u7fh1+VK9oWLl6gi
	 IDaaFcFprJbRbe9bTzXRL2TSF66F78vemrV5U33fTWh+G/lmL2lf9YKdm5HPHC4unn
	 ZD1xuMdPWyTYHNQLOcZ7Z+EV+KFd74oVVcNcMiIFZxDCm23EI+oRIIIQqgBzscf/du
	 1PqvIt+BJZaIL/QfENv95huWxRehRctl1ISCOa4xhZ4a1heXH/LVdrvC2Qdmxny09h
	 GIoNXwDaiAUHQ==
Date: Fri, 6 Mar 2026 12:21:45 +0000
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
Subject: Re: [PATCH v1 09/16] mm/memory: convert details->even_cows into
 details->skip_cows
Message-ID: <091ce280-9204-4b85-bf39-5e2a61e3d0ba@lucifer.local>
References: <20260227200848.114019-1-david@kernel.org>
 <20260227200848.114019-10-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227200848.114019-10-david@kernel.org>
X-Rspamd-Queue-Id: 67749220785
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,linux-foundation.org,oracle.com,kernel.org,google.com,suse.com,suse.de,linux.dev,infradead.org,linux.ibm.com,ellerman.id.au,redhat.com,alien8.de,linuxfoundation.org,android.com,mev.co.uk,visionengravers.com,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,ziepe.ca,hpe.com,arndb.de,iogearbox.net,arm.com,davemloft.net,lists.ozlabs.org,lists.freedesktop.org];
	TAGGED_FROM(0.00)[bounces-79600-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[74];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lucifer.local:mid]
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 09:08:40PM +0100, David Hildenbrand (Arm) wrote:
> The current semantics are confusing: simply because someone specifies an
> empty zap_detail struct suddenly makes should_zap_cows() behave
> differently. The default should be to also zap CoW'ed anonymous pages.
>
> Really only unmap_mapping_pages() and friends want to skip zapping of
> these anon folios.
>
> So let's invert the meaning; turn the confusing "reclaim_pt" check that
> overrides other properties in should_zap_cows() into a safety check.
>
> Note that the only caller that sets reclaim_pt=true is
> madvise_dontneed_single_vma(), which wants to zap any pages.
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

This is another nice change. I have some tweak suggestions below, but past
experience suggests to me it's quite possible you do what I ask in subsequent
patches, will see :)

Anyway overall LGTM, so:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  include/linux/mm.h |  2 +-
>  mm/madvise.c       |  1 -
>  mm/memory.c        | 12 ++++++------
>  3 files changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index d3ef586ee1c0..21b67c203e62 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2798,7 +2798,7 @@ extern void pagefault_out_of_memory(void);
>   */
>  struct zap_details {
>  	struct folio *single_folio;	/* Locked folio to be unmapped */
> -	bool even_cows;			/* Zap COWed private pages too? */
> +	bool skip_cows;			/* Do not zap COWed private pages */
>  	bool reclaim_pt;		/* Need reclaim page tables? */
>  	zap_flags_t zap_flags;		/* Extra flags for zapping */
>  };
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 557a360f7919..b51f216934f3 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -853,7 +853,6 @@ static long madvise_dontneed_single_vma(struct madvise_behavior *madv_behavior)
>  	struct madvise_behavior_range *range = &madv_behavior->range;
>  	struct zap_details details = {
>  		.reclaim_pt = true,
> -		.even_cows = true,
>  	};
>
>  	zap_page_range_single_batched(
> diff --git a/mm/memory.c b/mm/memory.c
> index fdcd2abf29c2..7d7c24c6917c 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1554,11 +1554,13 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
>  static inline bool should_zap_cows(struct zap_details *details)

Not sure if you fix up later, but we should probably change this function to
should_skip_cows() to keep everything consistent, otherwise this is a bit weird
and confusing.

>  {
>  	/* By default, zap all pages */
> -	if (!details || details->reclaim_pt)
> +	if (!details)
>  		return true;
>
> +	VM_WARN_ON_ONCE(details->skip_cows && details->reclaim_pt);
> +
>  	/* Or, we zap COWed pages only if the caller wants to */
> -	return details->even_cows;
> +	return !details->skip_cows;
>  }
>
>  /* Decides whether we should zap this folio with the folio pointer specified */
> @@ -2149,8 +2151,6 @@ void unmap_vmas(struct mmu_gather *tlb, struct unmap_desc *unmap)
>  	struct mmu_notifier_range range;
>  	struct zap_details details = {
>  		.zap_flags = ZAP_FLAG_DROP_MARKER | ZAP_FLAG_UNMAP,
> -		/* Careful - we need to zap private pages too! */
> -		.even_cows = true,
>  	};
>
>  	vma = unmap->first;
> @@ -4282,7 +4282,7 @@ void unmap_mapping_folio(struct folio *folio)
>  	first_index = folio->index;
>  	last_index = folio_next_index(folio) - 1;
>
> -	details.even_cows = false;
> +	details.skip_cows = true;
>  	details.single_folio = folio;
>  	details.zap_flags = ZAP_FLAG_DROP_MARKER;
>
> @@ -4312,7 +4312,7 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
>  	pgoff_t	first_index = start;
>  	pgoff_t	last_index = start + nr - 1;
>
> -	details.even_cows = even_cows;
> +	details.skip_cows = !even_cows;

Not sure if you clean up later, but seems sensible to cascade the change into
the local boolean here.

>  	if (last_index < first_index)
>  		last_index = ULONG_MAX;
>
> --
> 2.43.0
>

