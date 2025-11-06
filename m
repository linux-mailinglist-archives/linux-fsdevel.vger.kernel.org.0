Return-Path: <linux-fsdevel+bounces-67322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA4BC3BC0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 15:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 702794FFD45
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 14:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC8233E345;
	Thu,  6 Nov 2025 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xGxtWHQ2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D0OaQQNg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xGxtWHQ2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D0OaQQNg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E8C33B978
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 14:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439283; cv=none; b=t9D6sIEaoAsq0HVdYv3ITOfp16g1Th6gLZGKpjtPpuGqVq+UoXKMRbiL84dcbn+GlKAiWEM9Im0GKACYpMxfdiKmMs/wq8GiOz2Hto4jsmZp9t/z3FOJ1FwWxSXVV2VXk5juChz0/BEyRASuD4RY3T2Idzi/90avp77y7SKkyc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439283; c=relaxed/simple;
	bh=7Ik3D23qX2Te9Og+pHzngPjiFiZuQx+DsxyLl2EIkyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKgTaZrARkfXyJOaAkpHbjwfoWsNs8tkAN2+DeVShFSeKXpV5qDOkkY+sqaI5ZIc/9jNZRWslYVA7Ez+aL/nQqG8mImSOKCBmg24G2pCQft8NOkf1vVTxz4cDfj+LDBvS0RDnOJvJrjhYFxf4xJ9/wBSwcMPUjydKJydXF3Y6uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xGxtWHQ2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=D0OaQQNg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xGxtWHQ2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=D0OaQQNg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7D94D211FA;
	Thu,  6 Nov 2025 14:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762439279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AuuUdnWkxyCHK93yhogM0GpeOIixS0TwW2AXgBsT1zU=;
	b=xGxtWHQ2uld6xSLMvFvEFTNRtGmbFTMDR/KhcZ9qZDr1mc8KvPcrTDk+GRTNohsm7UXX/0
	YaA4GOzFlmslU95Kd+zOAKXA+ih6Hi7LcFx8oaTxoQ0TzbzvlrneHF0JWXbVYttyaU0ozB
	qCeKTANYWIxZ278NEITvmfyADVdY5Uc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762439279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AuuUdnWkxyCHK93yhogM0GpeOIixS0TwW2AXgBsT1zU=;
	b=D0OaQQNgQZcmZpSNShYML4vLRxJdK8LQSYg3Qw52p082UUP7rVVlVjMejAyNWlZrAcblz7
	sKc8jk20pNLiL/CA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xGxtWHQ2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=D0OaQQNg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762439279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AuuUdnWkxyCHK93yhogM0GpeOIixS0TwW2AXgBsT1zU=;
	b=xGxtWHQ2uld6xSLMvFvEFTNRtGmbFTMDR/KhcZ9qZDr1mc8KvPcrTDk+GRTNohsm7UXX/0
	YaA4GOzFlmslU95Kd+zOAKXA+ih6Hi7LcFx8oaTxoQ0TzbzvlrneHF0JWXbVYttyaU0ozB
	qCeKTANYWIxZ278NEITvmfyADVdY5Uc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762439279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AuuUdnWkxyCHK93yhogM0GpeOIixS0TwW2AXgBsT1zU=;
	b=D0OaQQNgQZcmZpSNShYML4vLRxJdK8LQSYg3Qw52p082UUP7rVVlVjMejAyNWlZrAcblz7
	sKc8jk20pNLiL/CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38E6513A31;
	Thu,  6 Nov 2025 14:27:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1yZSCm6wDGlERQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 06 Nov 2025 14:27:58 +0000
Date: Thu, 6 Nov 2025 14:27:56 +0000
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
Subject: Re: [PATCH v2 1/5] mm: introduce VM_MAYBE_GUARD and make visible in
 /proc/$pid/smaps
Message-ID: <yja2mhwa4bzatbthjjq5rolqlkfgcbmppic3caaiwi6jc63rbc@cims6rqnotvj>
References: <cover.1762422915.git.lorenzo.stoakes@oracle.com>
 <fe38b1a43364f72d1ce7a6217e53a33c9c0bb0c5.1762422915.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe38b1a43364f72d1ce7a6217e53a33c9c0bb0c5.1762422915.git.lorenzo.stoakes@oracle.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 7D94D211FA
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUBJECT_HAS_CURRENCY(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,lwn.net,redhat.com,oracle.com,suse.cz,kernel.org,google.com,suse.com,goodmis.org,efficios.com,vger.kernel.org,kvack.org,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01

On Thu, Nov 06, 2025 at 10:46:12AM +0000, Lorenzo Stoakes wrote:
> Currently, if a user needs to determine if guard regions are present in a
> range, they have to scan all VMAs (or have knowledge of which ones might
> have guard regions).
> 
> Since commit 8e2f2aeb8b48 ("fs/proc/task_mmu: add guard region bit to
> pagemap") and the related commit a516403787e0 ("fs/proc: extend the
> PAGEMAP_SCAN ioctl to report guard regions"), users can use either
> /proc/$pid/pagemap or the PAGEMAP_SCAN functionality to perform this
> operation at a virtual address level.
> 
> This is not ideal, and it gives no visibility at a /proc/$pid/smaps level
> that guard regions exist in ranges.
> 
> This patch remedies the situation by establishing a new VMA flag,
> VM_MAYBE_GUARD, to indicate that a VMA may contain guard regions (it is
> uncertain because we cannot reasonably determine whether a
> MADV_GUARD_REMOVE call has removed all of the guard regions in a VMA, and
> additionally VMAs may change across merge/split).
> 
> We utilise 0x800 for this flag which makes it available to 32-bit
> architectures also, a flag that was previously used by VM_DENYWRITE, which
> was removed in commit 8d0920bde5eb ("mm: remove VM_DENYWRITE") and hasn't
> bee reused yet.
> 
> We also update the smaps logic and documentation to identify these VMAs.
> 
> Another major use of this functionality is that we can use it to identify
> that we ought to copy page tables on fork.
> 
> We do not actually implement usage of this flag in mm/madvise.c yet as we
> need to allow some VMA flags to be applied atomically under mmap/VMA read
> lock in order to avoid the need to acquire a write lock for this purpose.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  Documentation/filesystems/proc.rst | 1 +
>  fs/proc/task_mmu.c                 | 1 +
>  include/linux/mm.h                 | 3 +++
>  include/trace/events/mmflags.h     | 1 +
>  mm/memory.c                        | 4 ++++
>  tools/testing/vma/vma_internal.h   | 3 +++
>  6 files changed, 13 insertions(+)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 0b86a8022fa1..b8a423ca590a 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -591,6 +591,7 @@ encoded manner. The codes are the following:
>      sl    sealed
>      lf    lock on fault pages
>      dp    always lazily freeable mapping
> +    gu    maybe contains guard regions (if not set, definitely doesn't)
>      ==    =======================================

The nittiest
of nits:     =============================================================


>  
>  Note that there is no guarantee that every flag and associated mnemonic will
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 8a9894aefbca..a420dcf9ffbb 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1147,6 +1147,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>  		[ilog2(VM_MAYSHARE)]	= "ms",
>  		[ilog2(VM_GROWSDOWN)]	= "gd",
>  		[ilog2(VM_PFNMAP)]	= "pf",
> +		[ilog2(VM_MAYBE_GUARD)]	= "gu",
>  		[ilog2(VM_LOCKED)]	= "lo",
>  		[ilog2(VM_IO)]		= "io",
>  		[ilog2(VM_SEQ_READ)]	= "sr",
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6e5ca5287e21..2a5516bff75a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -271,6 +271,8 @@ extern struct rw_semaphore nommu_region_sem;
>  extern unsigned int kobjsize(const void *objp);
>  #endif
>  
> +#define VM_MAYBE_GUARD_BIT 11
> +
>  /*
>   * vm_flags in vm_area_struct, see mm_types.h.
>   * When changing, update also include/trace/events/mmflags.h
> @@ -296,6 +298,7 @@ extern unsigned int kobjsize(const void *objp);
>  #define VM_UFFD_MISSING	0
>  #endif /* CONFIG_MMU */
>  #define VM_PFNMAP	0x00000400	/* Page-ranges managed without "struct page", just pure PFN */
> +#define VM_MAYBE_GUARD	BIT(VM_MAYBE_GUARD_BIT)	/* The VMA maybe contains guard regions. */

Don't we also need an adjustment on the rust side for this BIT()? Like we
for f04aad36a07c ("mm/ksm: fix flag-dropping behavior in ksm_madvise").

In any case:
Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

