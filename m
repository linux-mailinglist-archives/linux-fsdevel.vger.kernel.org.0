Return-Path: <linux-fsdevel+bounces-7364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBA88241BD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 13:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237981C21B0D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 12:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C8A21A10;
	Thu,  4 Jan 2024 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PKPEOYus";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y9TsAerx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PKPEOYus";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y9TsAerx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573B221A0F
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jan 2024 12:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3E6571F806;
	Thu,  4 Jan 2024 12:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704371208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BhcAIZzPlA8XCKvI+fDxPB+UqIZlAd3/kQvPqOW4WzI=;
	b=PKPEOYus+Utyb86JmwbjR8IKcuVHyWDJyuN4mcW4lYAL2VxN98KJLH+ktdnyLE3dKmcG1E
	xJP03W0cOxGc2BdWMJrEdsfSMmblWhHQIQzHZqpyKacrpjmziZO+7tQDOuCSskojUYaYWO
	fwudJppYJEz6NaCNTkGCBY17H1edpyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704371208;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BhcAIZzPlA8XCKvI+fDxPB+UqIZlAd3/kQvPqOW4WzI=;
	b=Y9TsAerxQuCLQyTLRvRn2h2qr2FbORj5kEEYh/arM9CxnHJWL8A5GiaI9LdV0z2RWTSBGZ
	1Ov6Z4gAvQavV6CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704371208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BhcAIZzPlA8XCKvI+fDxPB+UqIZlAd3/kQvPqOW4WzI=;
	b=PKPEOYus+Utyb86JmwbjR8IKcuVHyWDJyuN4mcW4lYAL2VxN98KJLH+ktdnyLE3dKmcG1E
	xJP03W0cOxGc2BdWMJrEdsfSMmblWhHQIQzHZqpyKacrpjmziZO+7tQDOuCSskojUYaYWO
	fwudJppYJEz6NaCNTkGCBY17H1edpyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704371208;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BhcAIZzPlA8XCKvI+fDxPB+UqIZlAd3/kQvPqOW4WzI=;
	b=Y9TsAerxQuCLQyTLRvRn2h2qr2FbORj5kEEYh/arM9CxnHJWL8A5GiaI9LdV0z2RWTSBGZ
	1Ov6Z4gAvQavV6CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2903E137E8;
	Thu,  4 Jan 2024 12:26:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mO++CQiklmW7FwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Jan 2024 12:26:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 90B4AA07EF; Thu,  4 Jan 2024 13:26:47 +0100 (CET)
Date: Thu, 4 Jan 2024 13:26:47 +0100
From: Jan Kara <jack@suse.cz>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc: linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
	dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz
Subject: Re: [PATCH] fsdax: cleanup tracepoints
Message-ID: <20240104122647.ynowpqfmhrvftfss@quack3>
References: <20240104104925.3496797-1-ruansy.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104104925.3496797-1-ruansy.fnst@fujitsu.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Thu 04-01-24 18:49:25, Shiyang Ruan wrote:
> Restore the tracepoint that was accidentally deleted before, and rename
> to dax_insert_entry().  Also, since we are using XArray, rename
> 'radix_entry' to 'xa_entry'.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/dax.c                      |  2 ++
>  include/trace/events/fs_dax.h | 47 +++++++++++++++++------------------
>  2 files changed, 25 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 3380b43cb6bb..7e7aabec91d8 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1684,6 +1684,8 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
>  	if (dax_fault_is_synchronous(iter, vmf->vma))
>  		return dax_fault_synchronous_pfnp(pfnp, pfn);
>  
> +	trace_dax_insert_entry(iter->inode, vmf, *entry);
> +
>  	/* insert PMD pfn */
>  	if (pmd)
>  		return vmf_insert_pfn_pmd(vmf, pfn, write);
> diff --git a/include/trace/events/fs_dax.h b/include/trace/events/fs_dax.h
> index 97b09fcf7e52..2ec2dcc8f66a 100644
> --- a/include/trace/events/fs_dax.h
> +++ b/include/trace/events/fs_dax.h
> @@ -62,15 +62,14 @@ DEFINE_PMD_FAULT_EVENT(dax_pmd_fault_done);
>  
>  DECLARE_EVENT_CLASS(dax_pmd_load_hole_class,
>  	TP_PROTO(struct inode *inode, struct vm_fault *vmf,
> -		struct page *zero_page,
> -		void *radix_entry),
> -	TP_ARGS(inode, vmf, zero_page, radix_entry),
> +		struct page *zero_page, void *xa_entry),
> +	TP_ARGS(inode, vmf, zero_page, xa_entry),
>  	TP_STRUCT__entry(
>  		__field(unsigned long, ino)
>  		__field(unsigned long, vm_flags)
>  		__field(unsigned long, address)
>  		__field(struct page *, zero_page)
> -		__field(void *, radix_entry)
> +		__field(void *, xa_entry)
>  		__field(dev_t, dev)
>  	),
>  	TP_fast_assign(
> @@ -79,40 +78,40 @@ DECLARE_EVENT_CLASS(dax_pmd_load_hole_class,
>  		__entry->vm_flags = vmf->vma->vm_flags;
>  		__entry->address = vmf->address;
>  		__entry->zero_page = zero_page;
> -		__entry->radix_entry = radix_entry;
> +		__entry->xa_entry = xa_entry;
>  	),
>  	TP_printk("dev %d:%d ino %#lx %s address %#lx zero_page %p "
> -			"radix_entry %#lx",
> +			"xa_entry %#lx",
>  		MAJOR(__entry->dev),
>  		MINOR(__entry->dev),
>  		__entry->ino,
>  		__entry->vm_flags & VM_SHARED ? "shared" : "private",
>  		__entry->address,
>  		__entry->zero_page,
> -		(unsigned long)__entry->radix_entry
> +		(unsigned long)__entry->xa_entry
>  	)
>  )
>  
>  #define DEFINE_PMD_LOAD_HOLE_EVENT(name) \
>  DEFINE_EVENT(dax_pmd_load_hole_class, name, \
>  	TP_PROTO(struct inode *inode, struct vm_fault *vmf, \
> -		struct page *zero_page, void *radix_entry), \
> -	TP_ARGS(inode, vmf, zero_page, radix_entry))
> +		struct page *zero_page, void *xa_entry), \
> +	TP_ARGS(inode, vmf, zero_page, xa_entry))
>  
>  DEFINE_PMD_LOAD_HOLE_EVENT(dax_pmd_load_hole);
>  DEFINE_PMD_LOAD_HOLE_EVENT(dax_pmd_load_hole_fallback);
>  
>  DECLARE_EVENT_CLASS(dax_pmd_insert_mapping_class,
>  	TP_PROTO(struct inode *inode, struct vm_fault *vmf,
> -		long length, pfn_t pfn, void *radix_entry),
> -	TP_ARGS(inode, vmf, length, pfn, radix_entry),
> +		long length, pfn_t pfn, void *xa_entry),
> +	TP_ARGS(inode, vmf, length, pfn, xa_entry),
>  	TP_STRUCT__entry(
>  		__field(unsigned long, ino)
>  		__field(unsigned long, vm_flags)
>  		__field(unsigned long, address)
>  		__field(long, length)
>  		__field(u64, pfn_val)
> -		__field(void *, radix_entry)
> +		__field(void *, xa_entry)
>  		__field(dev_t, dev)
>  		__field(int, write)
>  	),
> @@ -124,10 +123,10 @@ DECLARE_EVENT_CLASS(dax_pmd_insert_mapping_class,
>  		__entry->write = vmf->flags & FAULT_FLAG_WRITE;
>  		__entry->length = length;
>  		__entry->pfn_val = pfn.val;
> -		__entry->radix_entry = radix_entry;
> +		__entry->xa_entry = xa_entry;
>  	),
>  	TP_printk("dev %d:%d ino %#lx %s %s address %#lx length %#lx "
> -			"pfn %#llx %s radix_entry %#lx",
> +			"pfn %#llx %s xa_entry %#lx",
>  		MAJOR(__entry->dev),
>  		MINOR(__entry->dev),
>  		__entry->ino,
> @@ -138,15 +137,15 @@ DECLARE_EVENT_CLASS(dax_pmd_insert_mapping_class,
>  		__entry->pfn_val & ~PFN_FLAGS_MASK,
>  		__print_flags_u64(__entry->pfn_val & PFN_FLAGS_MASK, "|",
>  			PFN_FLAGS_TRACE),
> -		(unsigned long)__entry->radix_entry
> +		(unsigned long)__entry->xa_entry
>  	)
>  )
>  
>  #define DEFINE_PMD_INSERT_MAPPING_EVENT(name) \
>  DEFINE_EVENT(dax_pmd_insert_mapping_class, name, \
>  	TP_PROTO(struct inode *inode, struct vm_fault *vmf, \
> -		long length, pfn_t pfn, void *radix_entry), \
> -	TP_ARGS(inode, vmf, length, pfn, radix_entry))
> +		long length, pfn_t pfn, void *xa_entry), \
> +	TP_ARGS(inode, vmf, length, pfn, xa_entry))
>  
>  DEFINE_PMD_INSERT_MAPPING_EVENT(dax_pmd_insert_mapping);
>  
> @@ -194,14 +193,14 @@ DEFINE_PTE_FAULT_EVENT(dax_load_hole);
>  DEFINE_PTE_FAULT_EVENT(dax_insert_pfn_mkwrite_no_entry);
>  DEFINE_PTE_FAULT_EVENT(dax_insert_pfn_mkwrite);
>  
> -TRACE_EVENT(dax_insert_mapping,
> -	TP_PROTO(struct inode *inode, struct vm_fault *vmf, void *radix_entry),
> -	TP_ARGS(inode, vmf, radix_entry),
> +TRACE_EVENT(dax_insert_entry,
> +	TP_PROTO(struct inode *inode, struct vm_fault *vmf, void *xa_entry),
> +	TP_ARGS(inode, vmf, xa_entry),
>  	TP_STRUCT__entry(
>  		__field(unsigned long, ino)
>  		__field(unsigned long, vm_flags)
>  		__field(unsigned long, address)
> -		__field(void *, radix_entry)
> +		__field(void *, xa_entry)
>  		__field(dev_t, dev)
>  		__field(int, write)
>  	),
> @@ -211,16 +210,16 @@ TRACE_EVENT(dax_insert_mapping,
>  		__entry->vm_flags = vmf->vma->vm_flags;
>  		__entry->address = vmf->address;
>  		__entry->write = vmf->flags & FAULT_FLAG_WRITE;
> -		__entry->radix_entry = radix_entry;
> +		__entry->xa_entry = xa_entry;
>  	),
> -	TP_printk("dev %d:%d ino %#lx %s %s address %#lx radix_entry %#lx",
> +	TP_printk("dev %d:%d ino %#lx %s %s address %#lx xa_entry %#lx",
>  		MAJOR(__entry->dev),
>  		MINOR(__entry->dev),
>  		__entry->ino,
>  		__entry->vm_flags & VM_SHARED ? "shared" : "private",
>  		__entry->write ? "write" : "read",
>  		__entry->address,
> -		(unsigned long)__entry->radix_entry
> +		(unsigned long)__entry->xa_entry
>  	)
>  )
>  
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

