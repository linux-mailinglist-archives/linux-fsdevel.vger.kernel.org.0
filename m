Return-Path: <linux-fsdevel+bounces-27796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C3796423C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 12:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EACF7B252F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 10:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EB418E740;
	Thu, 29 Aug 2024 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2VVaeWGG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TtlYOp1I";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2VVaeWGG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TtlYOp1I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6F218DF77;
	Thu, 29 Aug 2024 10:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724928692; cv=none; b=T1p4z6+Jk4Crl2j7lOyVf0oiRw3EbNyHbSjXEC3syF5I43dtIFNq4CQ1jKQL8l3Gasri2tFALaD6l60F4Lh7/ur5b3sSdhfjXPR5DBCXof4iT+Aq+kFwzbbrbXg7bx6f+Z71U8IdRFyjObWyBn1zqGupNcXuTdmeGZzN2VrjrWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724928692; c=relaxed/simple;
	bh=ywL4NsSBHNoy9rpspEUEj4YUvvhpY4qUJMoYHy66nZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKEEpKLzE3qekKlFE+2r6QYyVGHOMHjE9xltQsRhbeuwv/kQi9eJuXxek2Xqq7PkPOAcAe7bWWZNHYyZEa0YXsrLyIyp3tDxfCXAh69fsYCrex/5C+wcZnGioAVzlc+T5c1Iq7kT9pSq8NoDN8YiR459VDNxxMMw0zbTXqjJuWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2VVaeWGG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TtlYOp1I; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2VVaeWGG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TtlYOp1I; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ACA3C2199E;
	Thu, 29 Aug 2024 10:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724928688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dBaair/wHrQp3Y/P6HPYN/L5d+w2KmoifNX/toWOhss=;
	b=2VVaeWGG5IEPKcNTi63cTUadBQfPsnAjfSueCdNZc9KWgwv7+yFf9z7eiPMkVq1FEPy5ia
	y8dGEa7Y42OXfWj0aNhVCf+hwYHZX6gSXWlZUWweAjpQR8cq09WrMIOABhqUZ2fCinK5N2
	L/hP0WATN4SBuL44notwfM5fa6/Dbro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724928688;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dBaair/wHrQp3Y/P6HPYN/L5d+w2KmoifNX/toWOhss=;
	b=TtlYOp1IPjbdYKJG6suOMFuXGnHG0+rbW5n+ojie67qk7vhkMLOE4y9bYP8Hn3MPUDX92l
	KnmNwUGcnVepE5CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724928688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dBaair/wHrQp3Y/P6HPYN/L5d+w2KmoifNX/toWOhss=;
	b=2VVaeWGG5IEPKcNTi63cTUadBQfPsnAjfSueCdNZc9KWgwv7+yFf9z7eiPMkVq1FEPy5ia
	y8dGEa7Y42OXfWj0aNhVCf+hwYHZX6gSXWlZUWweAjpQR8cq09WrMIOABhqUZ2fCinK5N2
	L/hP0WATN4SBuL44notwfM5fa6/Dbro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724928688;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dBaair/wHrQp3Y/P6HPYN/L5d+w2KmoifNX/toWOhss=;
	b=TtlYOp1IPjbdYKJG6suOMFuXGnHG0+rbW5n+ojie67qk7vhkMLOE4y9bYP8Hn3MPUDX92l
	KnmNwUGcnVepE5CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CA5F139B0;
	Thu, 29 Aug 2024 10:51:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kpD3JbBS0GZ7DQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 29 Aug 2024 10:51:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5639FA0965; Thu, 29 Aug 2024 12:51:28 +0200 (CEST)
Date: Thu, 29 Aug 2024 12:51:28 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-bcachefs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 12/16] mm: don't allow huge faults for files with pre
 content watches
Message-ID: <20240829105128.zvczpadmdoaarau2@quack3>
References: <cover.1723670362.git.josef@toxicpanda.com>
 <d6d0c9d4ccaeb559f4f51fdb1fb96880f890a665.1723670362.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6d0c9d4ccaeb559f4f51fdb1fb96880f890a665.1723670362.git.josef@toxicpanda.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,suse.cz,gmail.com,kernel.org,lists.linux.dev,kvack.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,toxicpanda.com:email,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Wed 14-08-24 17:25:30, Josef Bacik wrote:
> There's nothing stopping us from supporting this, we could simply pass
> the order into the helper and emit the proper length.  However currently
> there's no tests to validate this works properly, so disable it until
> there's a desire to support this along with the appropriate tests.
> 
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks good to me. I don't expect this to be controversial but let's CC MM
guys for awareness...

								Honza

> ---
>  mm/memory.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index d10e616d7389..3010bcc5e4f9 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -78,6 +78,7 @@
>  #include <linux/ptrace.h>
>  #include <linux/vmalloc.h>
>  #include <linux/sched/sysctl.h>
> +#include <linux/fsnotify.h>
>  
>  #include <trace/events/kmem.h>
>  
> @@ -5252,8 +5253,17 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
> +	struct file *file = vma->vm_file;
>  	if (vma_is_anonymous(vma))
>  		return do_huge_pmd_anonymous_page(vmf);
> +	/*
> +	 * Currently we just emit PAGE_SIZE for our fault events, so don't allow
> +	 * a huge fault if we have a pre content watch on this file.  This would
> +	 * be trivial to support, but there would need to be tests to ensure
> +	 * this works properly and those don't exist currently.
> +	 */
> +	if (file && fsnotify_file_has_pre_content_watches(file))
> +		return VM_FAULT_FALLBACK;
>  	if (vma->vm_ops->huge_fault)
>  		return vma->vm_ops->huge_fault(vmf, PMD_ORDER);
>  	return VM_FAULT_FALLBACK;
> @@ -5263,6 +5273,7 @@ static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
>  static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
> +	struct file *file = vma->vm_file;
>  	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
>  	vm_fault_t ret;
>  
> @@ -5277,6 +5288,9 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
>  	}
>  
>  	if (vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
> +		/* See comment in create_huge_pmd. */
> +		if (file && fsnotify_file_has_pre_content_watches(file))
> +			goto split;
>  		if (vma->vm_ops->huge_fault) {
>  			ret = vma->vm_ops->huge_fault(vmf, PMD_ORDER);
>  			if (!(ret & VM_FAULT_FALLBACK))
> @@ -5296,9 +5310,13 @@ static vm_fault_t create_huge_pud(struct vm_fault *vmf)
>  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) &&			\
>  	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
>  	struct vm_area_struct *vma = vmf->vma;
> +	struct file *file = vma->vm_file;
>  	/* No support for anonymous transparent PUD pages yet */
>  	if (vma_is_anonymous(vma))
>  		return VM_FAULT_FALLBACK;
> +	/* See comment in create_huge_pmd. */
> +	if (file && fsnotify_file_has_pre_content_watches(file))
> +		return VM_FAULT_FALLBACK;
>  	if (vma->vm_ops->huge_fault)
>  		return vma->vm_ops->huge_fault(vmf, PUD_ORDER);
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> @@ -5310,12 +5328,16 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
>  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) &&			\
>  	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
>  	struct vm_area_struct *vma = vmf->vma;
> +	struct file *file = vma->vm_file;
>  	vm_fault_t ret;
>  
>  	/* No support for anonymous transparent PUD pages yet */
>  	if (vma_is_anonymous(vma))
>  		goto split;
>  	if (vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
> +		/* See comment in create_huge_pmd. */
> +		if (file && fsnotify_file_has_pre_content_watches(file))
> +			goto split;
>  		if (vma->vm_ops->huge_fault) {
>  			ret = vma->vm_ops->huge_fault(vmf, PUD_ORDER);
>  			if (!(ret & VM_FAULT_FALLBACK))
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

