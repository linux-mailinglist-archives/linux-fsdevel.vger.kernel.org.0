Return-Path: <linux-fsdevel+bounces-79592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IphEN/DqmnPWwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 13:09:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9472F22030B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 13:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 609CB315FD73
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 12:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B858438E5C5;
	Fri,  6 Mar 2026 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1hNNt/g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FD52874FF;
	Fri,  6 Mar 2026 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772798607; cv=none; b=BBWuHlULqxdMkxUF1YalK4PfrYrEkYkiWP+C1fBkUuLBnkX46CbCBOABZy5Pqld06m3IDbfzWgl5tpzEKfX9caTmFvd6z9AazQOjHxlwmL5cC1mTxnIcoUKKuUybkxNkM2plI6CGcV38Xj2mQzD5OYKyxeZTEOQ53DR1sNiyukc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772798607; c=relaxed/simple;
	bh=8tIEjkmwTnv14wqiBx5utAVT1y4BywX848doWLEUMyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/pvDdoh12cyyBQhF3uShKmq3RUUWBseTFvnjqbEWbxVg3TpWX6tPCm2nrll0IDjvmrm2zt0nulCI8hCNWiNNWsJFFvHspMGWh7rA1h4AGkdW0hX7YwRbWWRwSSAmxeyphAIRY5KrJe4Lsu8l5O5L4sJjlrf/G7AypTlNSoKYvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1hNNt/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6488CC4CEF7;
	Fri,  6 Mar 2026 12:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772798607;
	bh=8tIEjkmwTnv14wqiBx5utAVT1y4BywX848doWLEUMyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h1hNNt/ggkmOIg6nOIs6YVKXxpvjxXfuNC1/E243FERUMlrdAP/1JGuS8WftUsd7f
	 sEmFfcrfCzizYh1WflGJxM+Mh8s8/NGzCybtmxDbPIa+RYlLhAC8M2mVomjBVzk4GJ
	 ovvi/YoGsX9AnKFqWBjW+IpIUt/t0ThtH++DKgi9JosbOXhePSuaAgqwo9ysipyiZZ
	 tJR6V8PVm0Q3rJsUQBZpi2/tPfiYYA+aTsakBMmVszHI4rXW/zZE1/jrzMC/3s/CgY
	 3bcJ8hm+9ce3MEINimXRaNGIqZXC4Xd93/yIA5/AX590NC8dE2fbRiLTj205GiFNUz
	 8UXcS4I1Opdeg==
Date: Fri, 6 Mar 2026 12:03:24 +0000
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
Subject: Re: [PATCH v1 01/16] mm/madvise: drop range checks in
 madvise_free_single_vma()
Message-ID: <c5a89c14-0c6b-4c1e-a68c-0680c7d64f4c@lucifer.local>
References: <20260227200848.114019-1-david@kernel.org>
 <20260227200848.114019-2-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227200848.114019-2-david@kernel.org>
X-Rspamd-Queue-Id: 9472F22030B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,linux-foundation.org,oracle.com,kernel.org,google.com,suse.com,suse.de,linux.dev,infradead.org,linux.ibm.com,ellerman.id.au,redhat.com,alien8.de,linuxfoundation.org,android.com,mev.co.uk,visionengravers.com,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,ziepe.ca,hpe.com,arndb.de,iogearbox.net,arm.com,davemloft.net,lists.ozlabs.org,lists.freedesktop.org];
	TAGGED_FROM(0.00)[bounces-79592-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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

On Fri, Feb 27, 2026 at 09:08:32PM +0100, David Hildenbrand (Arm) wrote:
> madvise_vma_behavior()-> madvise_dontneed_free()->madvise_free_single_vma()
> is only called from madvise_walk_vmas()
>
> (a) After try_vma_read_lock() confirmed that the whole range falls into
>     a single VMA (see is_vma_lock_sufficient()).
>
> (b) After adjusting the range to the VMA in the loop afterwards.
>
> madvise_dontneed_free() might drop the MM lock when handling
> userfaultfd, but it properly looks up the VMA again to adjust the range.
>
> So in madvise_free_single_vma(), the given range should always fall into
> a single VMA and should also span at least one page.
>
> Let's drop the error checks.
>
> The code now matches what we do in madvise_dontneed_single_vma(), where
> we call zap_vma_range_batched() that documents: "The range must fit into
> one VMA.". Although that function still adjusts that range, we'll change
> that soon.
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Yeah I did wonder about some of these checks, thanks for going through and
confirming these are useless.

Checked the madvise_dontneed_free() case to be sure and LGTM so overall:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  mm/madvise.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index c0370d9b4e23..efc04334a000 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -799,9 +799,10 @@ static int madvise_free_single_vma(struct madvise_behavior *madv_behavior)
>  {
>  	struct mm_struct *mm = madv_behavior->mm;
>  	struct vm_area_struct *vma = madv_behavior->vma;
> -	unsigned long start_addr = madv_behavior->range.start;
> -	unsigned long end_addr = madv_behavior->range.end;
> -	struct mmu_notifier_range range;
> +	struct mmu_notifier_range range = {
> +		.start = madv_behavior->range.start,
> +		.end = madv_behavior->range.end,
> +	};
>  	struct mmu_gather *tlb = madv_behavior->tlb;
>  	struct mm_walk_ops walk_ops = {
>  		.pmd_entry		= madvise_free_pte_range,
> @@ -811,12 +812,6 @@ static int madvise_free_single_vma(struct madvise_behavior *madv_behavior)
>  	if (!vma_is_anonymous(vma))
>  		return -EINVAL;
>
> -	range.start = max(vma->vm_start, start_addr);
> -	if (range.start >= vma->vm_end)
> -		return -EINVAL;
> -	range.end = min(vma->vm_end, end_addr);
> -	if (range.end <= vma->vm_start)
> -		return -EINVAL;
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
>  				range.start, range.end);
>
> --
> 2.43.0
>

