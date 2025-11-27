Return-Path: <linux-fsdevel+bounces-69997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E5FC8DD76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 11:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E03743AF9FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 10:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C3232ABC5;
	Thu, 27 Nov 2025 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ebh8MeRI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CCShTgGL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ebh8MeRI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CCShTgGL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4544B320CC9
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764240778; cv=none; b=pGx3xhSHLRuD15+AfZLFykMZK12WqxkhSXKPe6M+v+z5L5x4LF1A2wY+PlMWzomdau7/8zBjvyxM0En7sKvDnN7Vo8JVmyCKe6JpHQy07HCSYjIBHKzYKdTBZbpPdraT9oP5di5dj0qHQz36VeGpYNBsj+Ip341Qvhs3ZOfXacw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764240778; c=relaxed/simple;
	bh=lmIpG/6wpMPGrn8UHtJLjo9/YEqgWiovYbOwMFrcwDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5iHb4tIgbSxXD2qwdXcl38Rz1MEbCsN08Yhcj8ekFHA+SJO4tsgMPFaHp9L1eG4EhvJVZqIwjW5AKeJpu5yIdL2OMA3CnJlKuVIja/vQT3XlyvGqnoTw+CwU2EDfBD99Hj+jFkrnMEI3jiW0XKHK50mDYi7S+CbonktF/Yw/5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ebh8MeRI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CCShTgGL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ebh8MeRI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CCShTgGL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8060E5BCCE;
	Thu, 27 Nov 2025 10:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764240774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dSkfS1PH0V2GqQ7JwCU589oUysx1YAYg5wc2qE7DJO8=;
	b=ebh8MeRIbzXXS4nlvQHeE6b19GwtbYkg18vQvDryICee/hUE4994i2zgnpMFUBIthYG3nU
	UBJRzc8F+GLXPmMIeEIu6lcKDO+GuS5r4t3R24vLkBwrUcZBDFHcekbZBzLjpj2fMJFncP
	AMexocPLs/1FOCJ4ElPh9GDrDvtUkmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764240774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dSkfS1PH0V2GqQ7JwCU589oUysx1YAYg5wc2qE7DJO8=;
	b=CCShTgGLpH2iP4/uFPeSXXOQ7YG9AKQXx7Q/6PY7ZXom3Et/ho3asQQ/5oScgUFip56eSH
	p9FRhoNDdKZxDyBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764240774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dSkfS1PH0V2GqQ7JwCU589oUysx1YAYg5wc2qE7DJO8=;
	b=ebh8MeRIbzXXS4nlvQHeE6b19GwtbYkg18vQvDryICee/hUE4994i2zgnpMFUBIthYG3nU
	UBJRzc8F+GLXPmMIeEIu6lcKDO+GuS5r4t3R24vLkBwrUcZBDFHcekbZBzLjpj2fMJFncP
	AMexocPLs/1FOCJ4ElPh9GDrDvtUkmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764240774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dSkfS1PH0V2GqQ7JwCU589oUysx1YAYg5wc2qE7DJO8=;
	b=CCShTgGLpH2iP4/uFPeSXXOQ7YG9AKQXx7Q/6PY7ZXom3Et/ho3asQQ/5oScgUFip56eSH
	p9FRhoNDdKZxDyBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0C7F3EA63;
	Thu, 27 Nov 2025 10:52:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xrDGJ4ItKGlFNgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 27 Nov 2025 10:52:50 +0000
Date: Thu, 27 Nov 2025 10:52:49 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	Oven Liyang <liyangouwen1@oppo.com>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Matthew Wilcox <willy@infradead.org>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Oscar Salvador <osalvador@suse.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Mark Rutland <mark.rutland@arm.com>, Ada Couprie Diaz <ada.coupriediaz@arm.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, 
	Kevin Brodsky <kevin.brodsky@arm.com>, Yeoreum Yun <yeoreum.yun@arm.com>, 
	Wentao Guan <guanwentao@uniontech.com>, Thorsten Blum <thorsten.blum@linux.dev>, 
	Steven Rostedt <rostedt@goodmis.org>, Yunhui Cui <cuiyunhui@bytedance.com>, 
	Nam Cao <namcao@linutronix.de>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Barry Song <v-songbaohua@oppo.com>
Subject: Re: [RFC PATCH 1/2] mm/filemap: Retry fault by VMA lock if the lock
 was released for I/O
Message-ID: <5by7tko4v3kqvvpu4fdsgpw42yl5ed5qisbaz3la4an52hq4j2@v75fagey6gva>
References: <20251127011438.6918-1-21cnbao@gmail.com>
 <20251127011438.6918-2-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127011438.6918-2-21cnbao@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -7.80
X-Spam-Level: 
X-Spamd-Result: default: False [-7.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kvack.org,oppo.com,armlinux.org.uk,arm.com,kernel.org,xen0n.name,linux.ibm.com,ellerman.id.au,gmail.com,csgroup.eu,dabbelt.com,eecs.berkeley.edu,ghiti.fr,linux.intel.com,infradead.org,linutronix.de,redhat.com,alien8.de,zytor.com,oracle.com,suse.cz,google.com,suse.com,suse.de,renesas.com,uniontech.com,linux.dev,goodmis.org,bytedance.com,lists.infradead.org,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,tencent.com,huaweicloud.com];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_GT_50(0.00)[66];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oppo.com:email,imap1.dmz-prg2.suse.org:helo]

On Thu, Nov 27, 2025 at 09:14:37AM +0800, Barry Song wrote:
> From: Oven Liyang <liyangouwen1@oppo.com>
> 
> If the current page fault is using the per-VMA lock, and we only released
> the lock to wait for I/O completion (e.g., using folio_lock()), then when
> the fault is retried after the I/O completes, it should still qualify for
> the per-VMA-lock path.
> 
<snip>
> Signed-off-by: Oven Liyang <liyangouwen1@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  arch/arm/mm/fault.c       | 5 +++++
>  arch/arm64/mm/fault.c     | 5 +++++
>  arch/loongarch/mm/fault.c | 4 ++++
>  arch/powerpc/mm/fault.c   | 5 ++++-
>  arch/riscv/mm/fault.c     | 4 ++++
>  arch/s390/mm/fault.c      | 4 ++++
>  arch/x86/mm/fault.c       | 4 ++++

If only we could unify all these paths :(

>  include/linux/mm_types.h  | 9 +++++----
>  mm/filemap.c              | 5 ++++-
>  9 files changed, 39 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index b71625378ce3..12b2d65ef1b9 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1670,10 +1670,11 @@ enum vm_fault_reason {
>  	VM_FAULT_NOPAGE         = (__force vm_fault_t)0x000100,
>  	VM_FAULT_LOCKED         = (__force vm_fault_t)0x000200,
>  	VM_FAULT_RETRY          = (__force vm_fault_t)0x000400,
> -	VM_FAULT_FALLBACK       = (__force vm_fault_t)0x000800,
> -	VM_FAULT_DONE_COW       = (__force vm_fault_t)0x001000,
> -	VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x002000,
> -	VM_FAULT_COMPLETED      = (__force vm_fault_t)0x004000,
> +	VM_FAULT_RETRY_VMA      = (__force vm_fault_t)0x000800,

So, what I am wondering here is why we need one more fault flag versus
just blindly doing this on a plain-old RETRY. Is there any particular
reason why? I can't think of one. 

I would also like to see performance numbers.

The rest of the patch looks OK to me.

-- 
Pedro

