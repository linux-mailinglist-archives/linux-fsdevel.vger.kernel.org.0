Return-Path: <linux-fsdevel+bounces-27799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7519642B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 13:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4BAE1C22505
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 11:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AF6192B8E;
	Thu, 29 Aug 2024 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HsxGaqxd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JICkBGpj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HsxGaqxd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JICkBGpj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB271922FB;
	Thu, 29 Aug 2024 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724929658; cv=none; b=Dgin/8DX7jRfHYbGcA7R39vUWPD9H3Fgus4I48TZEVyZY6Nb8/AN88Ctf6rKgKZOKJ9mAMtsUDNCm9r0Yhh3MlmypDGCtjenr/76FtoEpivlmSy0u8IbQhkP8DzM7PnpcThvFO1NStvK17gFV/PU5LbLT6xjI2iti8g9reQ17mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724929658; c=relaxed/simple;
	bh=uDHrzrQj80ggYnOXBF07oAszTvjUsuReRiw3VbirHDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JP31BtRHF00JAXWcrGsNN1kam+xCYs5SMbPL4shQvPlpX63n+gl24c+KmbIw7sGzXmwJwDjZGwHlIEKrhp2IO6k9cMNJYfksJxYQUpXDsgIYuUcssg8pYVFN7/EjezpCYBKzO3RY6H8mVpPMBBU1/hE4Q32FElUUdgiijh5ZA20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HsxGaqxd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JICkBGpj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HsxGaqxd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JICkBGpj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0B82E21B3F;
	Thu, 29 Aug 2024 11:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724929654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QGQyecD4Fs4QjNPzlLpf3/Z6m6nnwdjllpvvpDrD1u0=;
	b=HsxGaqxdDcxgyrnkxL6HX06Fir1irthGucVgnz5B9VzDbNR5pdPXUaP9Y/9Y5Z9QjH+FNa
	Hmcum8vUX9w9i6Y9pXI00RVHgrjqd21RtdP/JSyTcEVEFSsBeUVvtaQ/jFYdFX1JCYGkDh
	5X4jzf34QFxfXx8tEW1N7uOeku80JC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724929654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QGQyecD4Fs4QjNPzlLpf3/Z6m6nnwdjllpvvpDrD1u0=;
	b=JICkBGpjNsqvf87Tce++GMEjC7W8trbJ/NunTCHlxpT4alrm+g+O0FMwvBMnN+0dZN0fyQ
	JFpYQi61M0aWh2BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724929654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QGQyecD4Fs4QjNPzlLpf3/Z6m6nnwdjllpvvpDrD1u0=;
	b=HsxGaqxdDcxgyrnkxL6HX06Fir1irthGucVgnz5B9VzDbNR5pdPXUaP9Y/9Y5Z9QjH+FNa
	Hmcum8vUX9w9i6Y9pXI00RVHgrjqd21RtdP/JSyTcEVEFSsBeUVvtaQ/jFYdFX1JCYGkDh
	5X4jzf34QFxfXx8tEW1N7uOeku80JC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724929654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QGQyecD4Fs4QjNPzlLpf3/Z6m6nnwdjllpvvpDrD1u0=;
	b=JICkBGpjNsqvf87Tce++GMEjC7W8trbJ/NunTCHlxpT4alrm+g+O0FMwvBMnN+0dZN0fyQ
	JFpYQi61M0aWh2BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF8E6139B0;
	Thu, 29 Aug 2024 11:07:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id brMkOnVW0GYIEwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 29 Aug 2024 11:07:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8CB35A0965; Thu, 29 Aug 2024 13:07:18 +0200 (CEST)
Date: Thu, 29 Aug 2024 13:07:18 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-bcachefs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 13/16] fsnotify: generate pre-content permission event
 on page fault
Message-ID: <20240829110718.tyhbodz5i6jx7gcr@quack3>
References: <cover.1723670362.git.josef@toxicpanda.com>
 <4be573448ff9f15e6fb55e41fa6453b655d8a467.1723670362.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4be573448ff9f15e6fb55e41fa6453b655d8a467.1723670362.git.josef@toxicpanda.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,suse.cz,gmail.com,kernel.org,lists.linux.dev,kvack.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,toxicpanda.com:email,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Wed 14-08-24 17:25:31, Josef Bacik wrote:
> FS_PRE_ACCESS or FS_PRE_MODIFY will be generated on page fault depending
> on the faulting method.
> 
> This pre-content event is meant to be used by hierarchical storage
> managers that want to fill in the file content on first read access.
> 
> Export a simple helper that file systems that have their own ->fault()
> will use, and have a more complicated helper to be do fancy things with
> in filemap_fault.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks good to me. Just let's CC MM guys for awareness about changes to
filemap_fault().
								Honza

> ---
>  include/linux/mm.h |   1 +
>  mm/filemap.c       | 116 ++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 110 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ab3d78116043..3e190f0a0997 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3503,6 +3503,7 @@ extern vm_fault_t filemap_fault(struct vm_fault *vmf);
>  extern vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>  		pgoff_t start_pgoff, pgoff_t end_pgoff);
>  extern vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf);
> +extern vm_fault_t filemap_maybe_emit_fsnotify_event(struct vm_fault *vmf);
>  
>  extern unsigned long stack_guard_gap;
>  /* Generic expand stack which grows the stack according to GROWS{UP,DOWN} */
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 8b1684b62177..50e88e47dff3 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -46,6 +46,7 @@
>  #include <linux/pipe_fs_i.h>
>  #include <linux/splice.h>
>  #include <linux/rcupdate_wait.h>
> +#include <linux/fsnotify.h>
>  #include <asm/pgalloc.h>
>  #include <asm/tlbflush.h>
>  #include "internal.h"
> @@ -3112,13 +3113,13 @@ static int lock_folio_maybe_drop_mmap(struct vm_fault *vmf, struct folio *folio,
>   * that.  If we didn't pin a file then we return NULL.  The file that is
>   * returned needs to be fput()'ed when we're done with it.
>   */
> -static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
> +static struct file *do_sync_mmap_readahead(struct vm_fault *vmf,
> +					   struct file *fpin)
>  {
>  	struct file *file = vmf->vma->vm_file;
>  	struct file_ra_state *ra = &file->f_ra;
>  	struct address_space *mapping = file->f_mapping;
>  	DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
> -	struct file *fpin = NULL;
>  	unsigned long vm_flags = vmf->vma->vm_flags;
>  	unsigned int mmap_miss;
>  
> @@ -3190,12 +3191,12 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>   * was pinned if we have to drop the mmap_lock in order to do IO.
>   */
>  static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
> -					    struct folio *folio)
> +					    struct folio *folio,
> +					    struct file *fpin)
>  {
>  	struct file *file = vmf->vma->vm_file;
>  	struct file_ra_state *ra = &file->f_ra;
>  	DEFINE_READAHEAD(ractl, file, ra, file->f_mapping, vmf->pgoff);
> -	struct file *fpin = NULL;
>  	unsigned int mmap_miss;
>  
>  	/* See comment in do_sync_mmap_readahead. */
> @@ -3260,6 +3261,93 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
>  	return ret;
>  }
>  
> +/*
> + * If we have pre-content watches on this file we will need to emit an event for
> + * this range.  We will handle dropping the lock and emitting the event.
> + *
> + * If FAULT_FLAG_RETRY_NOWAIT is set then we'll return VM_FAULT_RETRY.
> + *
> + * If no event was emitted then *fpin will be NULL and we will return 0.
> + *
> + * If any error occurred we will return VM_FAULT_SIGBUS, *fpin could still be
> + * set and will need to have fput() called on it.
> + *
> + * If we emitted the event then we will return 0 and *fpin will be set, this
> + * must have fput() called on it, and the caller must call VM_FAULT_RETRY after
> + * any other operations it does in order to re-fault the page and make sure the
> + * appropriate locking is maintained.
> + *
> + * Return: the appropriate vm_fault_t return code, 0 on success.
> + */
> +static vm_fault_t __filemap_maybe_emit_fsnotify_event(struct vm_fault *vmf,
> +						      struct file **fpin)
> +{
> +	struct file *file = vmf->vma->vm_file;
> +	loff_t pos = vmf->pgoff << PAGE_SHIFT;
> +	int mask = (vmf->flags & FAULT_FLAG_WRITE) ? MAY_WRITE : MAY_ACCESS;
> +	int ret;
> +
> +	/*
> +	 * We already did this and now we're retrying with everything locked,
> +	 * don't emit the event and continue.
> +	 */
> +	if (vmf->flags & FAULT_FLAG_TRIED)
> +		return 0;
> +
> +	/* No watches, return NULL. */
> +	if (!fsnotify_file_has_pre_content_watches(file))
> +		return 0;
> +
> +	/* We are NOWAIT, we can't wait, just return EAGAIN. */
> +	if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
> +		return VM_FAULT_RETRY;
> +
> +	/*
> +	 * If this fails then we're not allowed to drop the fault lock, return a
> +	 * SIGBUS so we don't errantly populate pagecache with bogus data for
> +	 * this file.
> +	 */
> +	*fpin = maybe_unlock_mmap_for_io(vmf, *fpin);
> +	if (*fpin == NULL)
> +		return VM_FAULT_SIGBUS;
> +
> +	/*
> +	 * We can't fput(*fpin) at this point because we could have been passed
> +	 * in fpin from a previous call.
> +	 */
> +	ret = fsnotify_file_area_perm(*fpin, mask, &pos, PAGE_SIZE);
> +	if (ret)
> +		return VM_FAULT_SIGBUS;
> +
> +	return 0;
> +}
> +
> +/**
> + * filemap_maybe_emit_fsnotify_event - maybe emit a pre-content event.
> + * @vmf:	struct vm_fault containing details of the fault.
> + *
> + * If we have a pre-content watch on this file we will emit an event for this
> + * range.  If we return anything the fault caller should return immediately, we
> + * will return VM_FAULT_RETRY if we had to emit an event, which will trigger the
> + * fault again and then the fault handler will run the second time through.
> + *
> + * Return: a bitwise-OR of %VM_FAULT_ codes, 0 if nothing happened.
> + */
> +vm_fault_t filemap_maybe_emit_fsnotify_event(struct vm_fault *vmf)
> +{
> +	struct file *fpin = NULL;
> +	vm_fault_t ret;
> +
> +	ret = __filemap_maybe_emit_fsnotify_event(vmf, &fpin);
> +	if (fpin) {
> +		fput(fpin);
> +		if (!ret)
> +			ret = VM_FAULT_RETRY;
> +	}
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(filemap_maybe_emit_fsnotify_event);
> +
>  /**
>   * filemap_fault - read in file data for page fault handling
>   * @vmf:	struct vm_fault containing details of the fault
> @@ -3299,6 +3387,17 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  	if (unlikely(index >= max_idx))
>  		return VM_FAULT_SIGBUS;
>  
> +	/*
> +	 * If we have pre-content watchers then we need to generate events on
> +	 * page fault so that we can populate any data before the fault.
> +	 */
> +	ret = __filemap_maybe_emit_fsnotify_event(vmf, &fpin);
> +	if (unlikely(ret)) {
> +		if (fpin)
> +			fput(fpin);
> +		return ret;
> +	}
> +
>  	/*
>  	 * Do we have something in the page cache already?
>  	 */
> @@ -3309,21 +3408,24 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  		 * the lock.
>  		 */
>  		if (!(vmf->flags & FAULT_FLAG_TRIED))
> -			fpin = do_async_mmap_readahead(vmf, folio);
> +			fpin = do_async_mmap_readahead(vmf, folio, fpin);
>  		if (unlikely(!folio_test_uptodate(folio))) {
>  			filemap_invalidate_lock_shared(mapping);
>  			mapping_locked = true;
>  		}
>  	} else {
>  		ret = filemap_fault_recheck_pte_none(vmf);
> -		if (unlikely(ret))
> +		if (unlikely(ret)) {
> +			if (fpin)
> +				goto out_retry;
>  			return ret;
> +		}
>  
>  		/* No page in the page cache at all */
>  		count_vm_event(PGMAJFAULT);
>  		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
>  		ret = VM_FAULT_MAJOR;
> -		fpin = do_sync_mmap_readahead(vmf);
> +		fpin = do_sync_mmap_readahead(vmf, fpin);
>  retry_find:
>  		/*
>  		 * See comment in filemap_create_folio() why we need
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

