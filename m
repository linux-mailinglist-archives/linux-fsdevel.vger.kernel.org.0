Return-Path: <linux-fsdevel+bounces-67325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3021BC3BDE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 15:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6AE8502214
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 14:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D56B345CBA;
	Thu,  6 Nov 2025 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iIYqVCVW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cJfUt/5W";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iIYqVCVW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cJfUt/5W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C26343D98
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440313; cv=none; b=Vp1bG2jUX6oM7pKDdepbAy3fn40nrpXk2zw6op4iSqfBv+VcXN1Amb9+d/hBMnAS1KENPp1wATd9oeAMwjtHCbXfww6xiwWJvmJvXyjkiUR9NawQgu2a3a52cm8w9qksbTLNARM2O7BuOGogVNYGJp5E4QkWDphtCWAorZeqbLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440313; c=relaxed/simple;
	bh=rHiQpD6Dguyzhqco5a71e3ZBXppCumTrPP+N3kV916Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1PzpMvexoWqHkDTWrnxv9QQQ3xzzC15TStRaQQTydpaumHvullfY8Bqr5uBZgzw191WMZHT1INSmldd004i9rQRGuAmF7VMqwiscG+qPGYDdN4IONQm71zDi7th0CAkogxxOLt4HB+s/4VXjgYyGbfU9fXUKCtwZUx2hKhUg8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iIYqVCVW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cJfUt/5W; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iIYqVCVW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cJfUt/5W; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9B3741F747;
	Thu,  6 Nov 2025 14:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762440309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nKYZuLb6Nw7zZ6Jj1iayriDsnFotAsi2YnGGy/qZxaE=;
	b=iIYqVCVW8trouxIau1Jb2p19gyPQLsOzO1T9vdE53k93FoKMpvRHjpW790I82MgSqiM7l5
	lV9viSF/+SuKgoSxNvpQGlp+lA/4cEM1bu/0spHHY+6hnOEqgK7M3qH1WUoEoJCwdWdEaY
	GELOWUe6yFpgvaxfGc5iPNviJy8PonQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762440309;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nKYZuLb6Nw7zZ6Jj1iayriDsnFotAsi2YnGGy/qZxaE=;
	b=cJfUt/5WY9dWjKauNGghYkyh6CE1i/Bw1taOd7vAPymyisRI4Wv7MWMPFElfXjs27hvHWq
	FGCwOCOTNY6308CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762440309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nKYZuLb6Nw7zZ6Jj1iayriDsnFotAsi2YnGGy/qZxaE=;
	b=iIYqVCVW8trouxIau1Jb2p19gyPQLsOzO1T9vdE53k93FoKMpvRHjpW790I82MgSqiM7l5
	lV9viSF/+SuKgoSxNvpQGlp+lA/4cEM1bu/0spHHY+6hnOEqgK7M3qH1WUoEoJCwdWdEaY
	GELOWUe6yFpgvaxfGc5iPNviJy8PonQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762440309;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nKYZuLb6Nw7zZ6Jj1iayriDsnFotAsi2YnGGy/qZxaE=;
	b=cJfUt/5WY9dWjKauNGghYkyh6CE1i/Bw1taOd7vAPymyisRI4Wv7MWMPFElfXjs27hvHWq
	FGCwOCOTNY6308CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52D9C13A31;
	Thu,  6 Nov 2025 14:45:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cLPwEHS0DGnJVQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 06 Nov 2025 14:45:08 +0000
Date: Thu, 6 Nov 2025 14:45:06 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v2 2/5] mm: add atomic VMA flags, use VM_MAYBE_GUARD as
 such
Message-ID: <y6a4qchmj7jnaogx6u5a3i6lni7v54lj25ipwb7tdtakcudakr@vm6vt7eumxax>
References: <cover.1762422915.git.lorenzo.stoakes@oracle.com>
 <94935cf140e3279c234b39e0d976c4718c547c73.1762422915.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94935cf140e3279c234b39e0d976c4718c547c73.1762422915.git.lorenzo.stoakes@oracle.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,lwn.net,redhat.com,oracle.com,suse.cz,kernel.org,google.com,suse.com,goodmis.org,efficios.com,vger.kernel.org,kvack.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Thu, Nov 06, 2025 at 10:46:13AM +0000, Lorenzo Stoakes wrote:
> This patch adds the ability to atomically set VMA flags with only the mmap
> read/VMA read lock held.
> 
> As this could be hugely problematic for VMA flags in general given that all
> other accesses are non-atomic and serialised by the mmap/VMA locks, we
> implement this with a strict allow-list - that is, only designated flags
> are allowed to do this.
> 
> We make VM_MAYBE_GUARD one of these flags, and then set it under the mmap
> read flag upon guard region installation.
> 
> The places where this flag is used currently and matter are:
> 
> * VMA merge - performed under mmap/VMA write lock, therefore excluding
>   racing writes.
> 
> * /proc/$pid/smaps - can race the write, however this isn't meaningful as
>   the flag write is performed at the point of the guard region being
>   established, and thus an smaps reader can't reasonably expect to avoid
>   races. Due to atomicity, a reader will observe either the flag being set
>   or not. Therefore consistency will be maintained.
> 
> In all other cases the flag being set is irrelevant and atomicity
> guarantees other flags will be read correctly.

Probably important to write down that the only reason why this doesn't make
KCSAN have a small stroke is that we are only changing one bit. i.e we can
only have one bit of atomic flags before annotating every reader.

(Source: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/kcsan/permissive.h#n51)

> We additionally update madvise_guard_install() to ensure that
> anon_vma_prepare() is set for anonymous VMAs to maintain consistency with
> the assumption that any anonymous VMA with page tables will have an
> anon_vma set, and any with an anon_vma unset will not have page tables
> established.

Isn't that what we already had? Or do you mean "*only* set for anonymous VMAs"?

> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

With the nits below and above addressed:
Reviewed-by: Pedro Falcato <pfalcato@suse.de>

> ---
>  include/linux/mm.h | 23 +++++++++++++++++++++++
>  mm/madvise.c       | 22 ++++++++++++++--------
>  2 files changed, 37 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 2a5516bff75a..2ea65c646212 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -518,6 +518,9 @@ extern unsigned int kobjsize(const void *objp);
>  /* This mask represents all the VMA flag bits used by mlock */
>  #define VM_LOCKED_MASK	(VM_LOCKED | VM_LOCKONFAULT)
>  
> +/* These flags can be updated atomically via VMA/mmap read lock. */
> +#define VM_ATOMIC_SET_ALLOWED VM_MAYBE_GUARD
> +
>  /* Arch-specific flags to clear when updating VM flags on protection change */
>  #ifndef VM_ARCH_CLEAR
>  # define VM_ARCH_CLEAR	VM_NONE
> @@ -860,6 +863,26 @@ static inline void vm_flags_mod(struct vm_area_struct *vma,
>  	__vm_flags_mod(vma, set, clear);
>  }
>  
> +/*
> + * Set VMA flag atomically. Requires only VMA/mmap read lock. Only specific
> + * valid flags are allowed to do this.
> + */
> +static inline void vma_flag_set_atomic(struct vm_area_struct *vma,
> +				       int bit)
> +{
> +	const vm_flags_t mask = BIT(bit);
> +
> +	/* mmap read lock/VMA read lock must be held. */
> +	if (!rwsem_is_locked(&vma->vm_mm->mmap_lock))
> +		vma_assert_locked(vma);
> +
> +	/* Only specific flags are permitted */
> +	if (WARN_ON_ONCE(!(mask & VM_ATOMIC_SET_ALLOWED)))
> +		return;

VM_WARN_ON_ONCE?

-- 
Pedro

