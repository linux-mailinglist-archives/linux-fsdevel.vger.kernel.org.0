Return-Path: <linux-fsdevel+bounces-51013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 710A0AD1C82
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 13:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B140188DB14
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 11:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EC2253346;
	Mon,  9 Jun 2025 11:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fWecfaQF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p8ai50Dv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fWecfaQF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p8ai50Dv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7084A3C
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749468946; cv=none; b=C476gHPNuTUlbOiQlxmIKf686QGuXME7oDO0DYeQfMoIDaVYvBC757+LiwBdahIXzbKMUg1thca4fni+dZxZLVHT14LGXmKsZrkyGNKuKdRuX0KyMFU9juNU7a0XED4pi2y3tLUjEtQgTFJ45+4JJZs9Bvg3kno6R9a+ti1iGwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749468946; c=relaxed/simple;
	bh=1VAjJAYh1LVaQgA/g/otMLDmvQ+m1/2lSxQ0AYYCq0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPg+odFgUVVPxFEbP8Up54K1drTHLdBsgiCyo42taDtsYPEPDUIs53DH/CuqSeS+FppI2Kgu1oI2wwNAo4x4JExTUoEFH2pgjLCTiMtw0G8Tbfi/Uv/+yae99tv+wLtdAe07KfSC5efFHkLV+ul5el4Ne0DEjwzk/QSN4LujOsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fWecfaQF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p8ai50Dv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fWecfaQF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p8ai50Dv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BD5612118A;
	Mon,  9 Jun 2025 11:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749468942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0aX4K0ZmJrkWwew/LvkVL8sEQCpqlT0saO3jfYDTfg8=;
	b=fWecfaQF8O4I+bO0Z2K29v2Q3dmludqUkhUXQbdertpNCuNyrN7F6en1xXm2e72cvBNEfb
	woQPYSUD3aydiLcKKEOW6QCjrWqnIlJQeB6b+C9+mnPxJ9J/qSQNYpcfEhWJ8mXQMYdC51
	ZtwX4h2ZdCQjlYOq3+4vmbZQi4fwApA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749468942;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0aX4K0ZmJrkWwew/LvkVL8sEQCpqlT0saO3jfYDTfg8=;
	b=p8ai50Dv4WmcZF1f/x9s+Y0iZV3ABINLUBWPRhIiKrzHHVQFo/DZxVn9CADDCrMBft2NmK
	XZHXUxDWM3HQjeAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749468942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0aX4K0ZmJrkWwew/LvkVL8sEQCpqlT0saO3jfYDTfg8=;
	b=fWecfaQF8O4I+bO0Z2K29v2Q3dmludqUkhUXQbdertpNCuNyrN7F6en1xXm2e72cvBNEfb
	woQPYSUD3aydiLcKKEOW6QCjrWqnIlJQeB6b+C9+mnPxJ9J/qSQNYpcfEhWJ8mXQMYdC51
	ZtwX4h2ZdCQjlYOq3+4vmbZQi4fwApA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749468942;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0aX4K0ZmJrkWwew/LvkVL8sEQCpqlT0saO3jfYDTfg8=;
	b=p8ai50Dv4WmcZF1f/x9s+Y0iZV3ABINLUBWPRhIiKrzHHVQFo/DZxVn9CADDCrMBft2NmK
	XZHXUxDWM3HQjeAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 090A2137FE;
	Mon,  9 Jun 2025 11:35:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IyGQOg3HRmgFPgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 09 Jun 2025 11:35:41 +0000
Date: Mon, 9 Jun 2025 12:35:40 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: add mmap_prepare() compatibility layer for nested
 file systems
Message-ID: <lus7wfr2fcycylium7ljykdbywinsfmaow45xhiduiitajzclj@s5pzxkvyd6fd>
References: <20250609092413.45435-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609092413.45435-1-lorenzo.stoakes@oracle.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Mon, Jun 09, 2025 at 10:24:13AM +0100, Lorenzo Stoakes wrote:
> Nested file systems, that is those which invoke call_mmap() within their
> own f_op->mmap() handlers, may encounter underlying file systems which
> provide the f_op->mmap_prepare() hook introduced by commit
> c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback").
> 
> We have a chicken-and-egg scenario here - until all file systems are
> converted to using .mmap_prepare(), we cannot convert these nested
> handlers, as we can't call f_op->mmap from an .mmap_prepare() hook.
> 
> So we have to do it the other way round - invoke the .mmap_prepare() hook
> from an .mmap() one.
> 
> in order to do so, we need to convert VMA state into a struct vm_area_desc
> descriptor, invoking the underlying file system's f_op->mmap_prepare()
> callback passing a pointer to this, and then setting VMA state accordingly
> and safely.
> 
> This patch achieves this via the compat_vma_mmap_prepare() function, which
> we invoke from call_mmap() if f_op->mmap_prepare() is specified in the
> passed in file pointer.
> 
> We place the fundamental logic into mm/vma.c where VMA manipulation
> belongs. We also update the VMA userland tests to accommodate the changes.
> 
> The compat_vma_mmap_prepare() function and its associated machinery is
> temporary, and will be removed once the conversion of file systems is
> complete.
>

Thanks, this is annoying but looks mostly cromulent!

> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reported-by: Jann Horn <jannh@google.com>
> Closes: https://lore.kernel.org/linux-mm/CAG48ez04yOEVx1ekzOChARDDBZzAKwet8PEoPM4Ln3_rk91AzQ@mail.gmail.com/
> Fixes: c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback").
> ---
>  include/linux/fs.h               |  6 +++--
>  mm/mmap.c                        | 39 +++++++++++++++++++++++++++
>  mm/vma.c                         | 46 +++++++++++++++++++++++++++++++-
>  mm/vma.h                         |  4 +++
>  tools/testing/vma/vma_internal.h | 16 +++++++++++
>  5 files changed, 108 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 05abdabe9db7..8fe41a2b7527 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2274,10 +2274,12 @@ static inline bool file_has_valid_mmap_hooks(struct file *file)
>  	return true;
>  }
>  
> +int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma);
> +
>  static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
>  {
> -	if (WARN_ON_ONCE(file->f_op->mmap_prepare))
> -		return -EINVAL;
> +	if (file->f_op->mmap_prepare)
> +		return compat_vma_mmap_prepare(file, vma);
>  
>  	return file->f_op->mmap(file, vma);
>  }
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 09c563c95112..0755cb5d89d1 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1891,3 +1891,42 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
>  	vm_unacct_memory(charge);
>  	goto loop_out;
>  }
> +
> +/**
> + * compat_vma_mmap_prepare() - Apply the file's .mmap_prepare() hook to an
> + * existing VMA
> + * @file: The file which possesss an f_op->mmap_prepare() hook
> + * @vma; The VMA to apply the .mmap_prepare() hook to.
> + *
> + * Ordinarily, .mmap_prepare() is invoked directly upon mmap(). However, certain
> + * 'wrapper' file systems invoke a nested mmap hook of an underlying file.
> + *
> + * Until all filesystems are converted to use .mmap_prepare(), we must be
> + * conservative and continue to invoke these 'wrapper' filesystems using the
> + * deprecated .mmap() hook.
> + *
> + * However we have a problem if the underlying file system possesses an
> + * .mmap_prepare() hook, as we are in a different context when we invoke the
> + * .mmap() hook, already having a VMA to deal with.
> + *
> + * compat_vma_mmap_prepare() is a compatibility function that takes VMA state,
> + * establishes a struct vm_area_desc descriptor, passes to the underlying
> + * .mmap_prepare() hook and applies any changes performed by it.
> + *
> + * Once the conversion of filesystems is complete this function will no longer
> + * be required and will be removed.
> + *
> + * Returns: 0 on success or error.
> + */
> +int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma)
> +{
> +	struct vm_area_desc desc;
> +	int err;
> +
> +	err = file->f_op->mmap_prepare(vma_to_desc(vma, &desc));
> +	if (err)
> +		return err;
> +	set_vma_from_desc(vma, &desc);
> +
> +	return 0;
> +}
> diff --git a/mm/vma.c b/mm/vma.c
> index 01b1d26d87b4..d771750f8f76 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -3153,7 +3153,6 @@ int __vm_munmap(unsigned long start, size_t len, bool unlock)
>  	return ret;
>  }
>  
> -
>  /* Insert vm structure into process list sorted by address
>   * and into the inode's i_mmap tree.  If vm_file is non-NULL
>   * then i_mmap_rwsem is taken here.
> @@ -3195,3 +3194,48 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
>  
>  	return 0;
>  }
> +
> +/*
> + * Temporary helper functions for file systems which wrap an invocation of
> + * f_op->mmap() but which might have an underlying file system which implements
> + * f_op->mmap_prepare().
> + */
> +
> +struct vm_area_desc *vma_to_desc(struct vm_area_struct *vma,
> +		struct vm_area_desc *desc)
> +{
> +	desc->mm = vma->vm_mm;
> +	desc->start = vma->vm_start;
> +	desc->end = vma->vm_end;
> +
> +	desc->pgoff = vma->vm_pgoff;
> +	desc->file = vma->vm_file;
> +	desc->vm_flags = vma->vm_flags;
> +	desc->page_prot = vma->vm_page_prot;
> +
> +	desc->vm_ops = NULL;
> +	desc->private_data = NULL;
> +
> +	return desc;
> +}
> +
> +void set_vma_from_desc(struct vm_area_struct *vma, struct vm_area_desc *desc)
> +{
> +	/*
> +	 * Since we're invoking .mmap_prepare() despite having a partially
> +	 * established VMA, we must take care to handle setting fields
> +	 * correctly.
> +	 */
> +
> +	/* Mutable fields. Populated with initial state. */
> +	vma->vm_pgoff = desc->pgoff;
> +	if (vma->vm_file != desc->file)
> +		vma_set_file(vma, desc->file);
> +	if (vma->vm_flags != desc->vm_flags)
> +		vm_flags_set(vma, desc->vm_flags);

I think we don't need vm_flags_set in this case, since the VMA isn't exposed yet.
__vm_flags_mod should work just fine. Of course this isn't a big deal, but I would
like it if we reduced vm_flags_set to core mm and conceptually attached things.

In any case, with or without that addressed:

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

