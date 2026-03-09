Return-Path: <linux-fsdevel+bounces-79785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OaHFYPPrmnEIwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 14:47:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B449239F81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 14:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C03C930106BB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 13:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2E33CF67F;
	Mon,  9 Mar 2026 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVr69GD8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CF73B8BA2;
	Mon,  9 Mar 2026 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773064006; cv=none; b=hbOb0e2ZFhyy7OHmfLEhF6WAD/0Vf/BHg2CfDvebegzzntr/g5oidbCYbJj5lpq4cYfse/+5gMFzLKbKwUAEenVJrj0hfrqHDczg7G6y8eGNunclGWZr4lQjANfdWiSrPcJmsMCRGdSsakj3jwiZe09BkanfNWTqJbIJWpFmz/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773064006; c=relaxed/simple;
	bh=w0QUYZum+m+R/ZMJD9ICvWbnwxxvrz4NQJRGvdgYc+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OS94GinChKh1M1pwP5cNfLlXU6oLtX0Jd1ZQ+G2iSmNSnKEjsV6h5A67C8e/vg87ZktdfN8BAGWxArASYOu0bPaTWmID97jvWFXvX9drsXeobc5kkWjUIZDi7xDOZe2lDt0lEFgbKZ8TGnf6sA3B2nW/DkXb5QBpI9ju3zJA93s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVr69GD8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF8FC4CEF7;
	Mon,  9 Mar 2026 13:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773064005;
	bh=w0QUYZum+m+R/ZMJD9ICvWbnwxxvrz4NQJRGvdgYc+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BVr69GD85TMcTAfG+a8utDGbnLRZpnfsgk6oAEieKIf3SbpafBvF3+irOxH5364Mf
	 5pQjiP3OB9FC6sxDF6sRahqD3JxDLeM/LKZhytQKKexcd9nKBgdJPKEyw8sk8hmBqZ
	 6Umeng6LJPjNhP9ijAtZ1GLP3fQirKriMZIBcjz1MV/Ly4Ym8+L+fbakf0sGYzf2HZ
	 3zIBqoZorFxzO8i8L6kszr5AnLvTpWYNSPn5PmXLkOowtVs0WINaH4TFDGQhbj2jWW
	 Xu+fRiMPtxXfm3CsyrGqKEUJHR4HPp+HrebcbqvJ0J7zXXW7tbIaDGtBQ28EmTK0dV
	 febooG99fQKig==
Date: Mon, 9 Mar 2026 13:46:27 +0000
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
Subject: Re: [PATCH v1 11/16] mm/memory: inline unmap_page_range() into
 __zap_vma_range()
Message-ID: <737a88b8-8221-44e6-aa90-3be326bc8612@lucifer.local>
References: <20260227200848.114019-1-david@kernel.org>
 <20260227200848.114019-12-david@kernel.org>
 <a5765cac-69d6-4314-82d5-80ee363906de@lucifer.local>
 <bc5cfcc4-5e51-4da1-9ce9-ea0831bec400@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc5cfcc4-5e51-4da1-9ce9-ea0831bec400@kernel.org>
X-Rspamd-Queue-Id: 4B449239F81
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,linux-foundation.org,oracle.com,kernel.org,google.com,suse.com,suse.de,linux.dev,infradead.org,linux.ibm.com,ellerman.id.au,redhat.com,alien8.de,linuxfoundation.org,android.com,mev.co.uk,visionengravers.com,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,ziepe.ca,hpe.com,arndb.de,iogearbox.net,arm.com,davemloft.net,lists.ozlabs.org,lists.freedesktop.org];
	TAGGED_FROM(0.00)[bounces-79785-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[74];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.963];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lucifer.local:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 02:16:26PM +0100, David Hildenbrand (Arm) wrote:
> On 3/6/26 13:29, Lorenzo Stoakes (Oracle) wrote:
> > On Fri, Feb 27, 2026 at 09:08:42PM +0100, David Hildenbrand (Arm) wrote:
> >> Let's inline it into the single caller to reduce the number of confusing
> >> unmap/zap helpers.
> >>
> >> Get rid of the unnecessary BUG_ON().
> >>
> >> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> >
> > Small nits below, but overall LGTM so:
> >
> > Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> >
> >> ---
> >>  mm/memory.c | 32 ++++++++++++--------------------
> >>  1 file changed, 12 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/mm/memory.c b/mm/memory.c
> >> index 394b2e931974..1c0bcdfc73b7 100644
> >> --- a/mm/memory.c
> >> +++ b/mm/memory.c
> >> @@ -2056,25 +2056,6 @@ static inline unsigned long zap_p4d_range(struct mmu_gather *tlb,
> >>  	return addr;
> >>  }
> >>
> >> -static void unmap_page_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
> >> -		unsigned long addr, unsigned long end,
> >> -		struct zap_details *details)
> >> -{
> >> -	pgd_t *pgd;
> >> -	unsigned long next;
> >> -
> >> -	BUG_ON(addr >= end);
> >> -	tlb_start_vma(tlb, vma);
> >> -	pgd = pgd_offset(vma->vm_mm, addr);
> >> -	do {
> >> -		next = pgd_addr_end(addr, end);
> >> -		if (pgd_none_or_clear_bad(pgd))
> >> -			continue;
> >> -		next = zap_p4d_range(tlb, vma, pgd, addr, next, details);
> >> -	} while (pgd++, addr = next, addr != end);
> >> -	tlb_end_vma(tlb, vma);
> >> -}
> >> -
> >>  static void __zap_vma_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
> >>  		unsigned long start, unsigned long end,
> >>  		struct zap_details *details)
> >> @@ -2100,7 +2081,18 @@ static void __zap_vma_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
> >>  			return;
> >>  		__unmap_hugepage_range(tlb, vma, start, end, NULL, zap_flags);
> >>  	} else {
> >> -		unmap_page_range(tlb, vma, start, end, details);
> >> +		unsigned long next, cur = start;
> >
> > VERY nitty, but generally current is abbreviated to curr not cur.
> >
>
> The following might not be fully expressive (but simple to grep):
>
> $ git grep "cur_" | wc -l
> 24261
> $ git grep "curr_" | wc -l
> 9288

Lol hmm...

>
> Tells me that "cur" is rather common.
>
> > It's not a big deal, but why not addr?
>
> Good question, I can just do that. :)

Thanks!

>
> --
> Cheers,
>
> David

Cheers, Lorenzo

