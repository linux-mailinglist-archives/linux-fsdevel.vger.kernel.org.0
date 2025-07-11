Return-Path: <linux-fsdevel+bounces-54646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BDDB01DB0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 15:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E039A45C51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 13:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516452D949C;
	Fri, 11 Jul 2025 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1/Vgmf2t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eVdTB4kA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1/Vgmf2t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eVdTB4kA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC8C2E0403
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240867; cv=none; b=C/SKP8hohdmW33bLgZpHXM89JUpBFs6d/JI9uyR+WAZ6qUchhtc2GcYiyQcPBuY15btBPncitkFBR+fUlqU5g2mXWHYDutIJe51JyEYwe0RXDWo4dp4nicTpVVgjN0ZlHDEoVy9Vd1CmDOQEZUnMNtM190XhXoirT8MwjZUB9ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240867; c=relaxed/simple;
	bh=UNXw9c1c2o2uWn6RTYqLoQ98x0aWsTO1iB2+nShMBTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CxCOGywK4UaM9rg9hGONQmb+HIi8Z5U9uwQF9j41UNURcl2Wk9xW+TzUM4Pw6wQoi5leoVghoXiMa/LpRoU7sWMC9RkgjLhtyUrrSgyokt5FoOpxAljFtAak8RhpEHvOAACPYQfrBVnJAnfBz9vFjEefJ4XrT/R1Eiq8hX59d2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1/Vgmf2t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eVdTB4kA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1/Vgmf2t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eVdTB4kA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8414F21199;
	Fri, 11 Jul 2025 13:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752240863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WBQLyd6g8XwFngSex5GoZ1oSlKSSXFd4IEqvid/+iMc=;
	b=1/Vgmf2tDaoPkmKmnAn7OmkN8nsXDBRdE4GajYhCo7brg2M07nL1iF4s192rzWMtKDZiZQ
	CpFDa6SJGt34QI9u1vG6fJLbgC6GigMT7ONXd6kC19UMlavGE2lrFFRmXERdAVsPjuKcTZ
	d9/ynESSDnd0uhJGpaLe9tMHI+SR3a8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752240863;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WBQLyd6g8XwFngSex5GoZ1oSlKSSXFd4IEqvid/+iMc=;
	b=eVdTB4kAeATZlga6D42p12di/kJgwlZswsjPckvEcXntrJgi9iNmZ9Bzc3eJKcx/6/JKjY
	oZRYT9uxstu/2FBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="1/Vgmf2t";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=eVdTB4kA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752240863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WBQLyd6g8XwFngSex5GoZ1oSlKSSXFd4IEqvid/+iMc=;
	b=1/Vgmf2tDaoPkmKmnAn7OmkN8nsXDBRdE4GajYhCo7brg2M07nL1iF4s192rzWMtKDZiZQ
	CpFDa6SJGt34QI9u1vG6fJLbgC6GigMT7ONXd6kC19UMlavGE2lrFFRmXERdAVsPjuKcTZ
	d9/ynESSDnd0uhJGpaLe9tMHI+SR3a8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752240863;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WBQLyd6g8XwFngSex5GoZ1oSlKSSXFd4IEqvid/+iMc=;
	b=eVdTB4kAeATZlga6D42p12di/kJgwlZswsjPckvEcXntrJgi9iNmZ9Bzc3eJKcx/6/JKjY
	oZRYT9uxstu/2FBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 652851388B;
	Fri, 11 Jul 2025 13:34:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CHVdGN8ScWikQgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 11 Jul 2025 13:34:23 +0000
Message-ID: <dcdb3478-68ea-4d9f-af4f-2f5438de45d2@suse.cz>
Date: Fri, 11 Jul 2025 15:34:23 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/10] mm/mremap: permit mremap() move of multiple VMAs
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Linux API <linux-api@vger.kernel.org>
References: <cover.1752232673.git.lorenzo.stoakes@oracle.com>
 <8f41e72b0543953d277e96d5e67a52f287cdbac3.1752232673.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <8f41e72b0543953d277e96d5e67a52f287cdbac3.1752232673.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email,oracle.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 8414F21199
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

+cc linux-api - see the description of the new behavior below

On 7/11/25 13:38, Lorenzo Stoakes wrote:
> Historically we've made it a uAPI requirement that mremap() may only
> operate on a single VMA at a time.
> 
> For instances where VMAs need to be resized, this makes sense, as it
> becomes very difficult to determine what a user actually wants should they
> indicate a desire to expand or shrink the size of multiple VMAs (truncate?
> Adjust sizes individually? Some other strategy?).
> 
> However, in instances where a user is moving VMAs, it is restrictive to
> disallow this.
> 
> This is especially the case when anonymous mapping remap may or may not be
> mergeable depending on whether VMAs have or have not been faulted due to
> anon_vma assignment and folio index alignment with vma->vm_pgoff.
> 
> Often this can result in surprising impact where a moved region is faulted,
> then moved back and a user fails to observe a merge from otherwise
> compatible, adjacent VMAs.
> 
> This change allows such cases to work without the user having to be
> cognizant of whether a prior mremap() move or other VMA operations has
> resulted in VMA fragmentation.
> 
> We only permit this for mremap() operations that do NOT change the size of
> the VMA and DO specify MREMAP_MAYMOVE | MREMAP_FIXED.
> 
> Should no VMA exist in the range, -EFAULT is returned as usual.
> 
> If a VMA move spans a single VMA - then there is no functional change.
> 
> Otherwise, we place additional requirements upon VMAs:
> 
> * They must not have a userfaultfd context associated with them - this
>   requires dropping the lock to notify users, and we want to perform the
>   operation with the mmap write lock held throughout.
> 
> * If file-backed, they cannot have a custom get_unmapped_area handler -
>   this might result in MREMAP_FIXED not being honoured, which could result
>   in unexpected positioning of VMAs in the moved region.
> 
> There may be gaps in the range of VMAs that are moved:
> 
>                    X        Y                       X        Y
>                  <--->     <->                    <--->     <->
>          |-------|   |-----| |-----|      |-------|   |-----| |-----|
>          |   A   |   |  B  | |  C  | ---> |   A'  |   |  B' | |  C' |
>          |-------|   |-----| |-----|      |-------|   |-----| |-----|
>         addr                           new_addr
> 
> The move will preserve the gaps between each VMA.

AFAIU "moving a gap" doesn't mean we unmap anything pre-existing where the
moved gap's range falls to, right? Worth pointing out explicitly.

> Note that any failures encountered will result in a partial move. Since an
> mremap() can fail at any time, this might result in only some of the VMAs
> being moved.
> 
> Note that failures are very rare and typically require an out of a memory
> condition or a mapping limit condition to be hit, assuming the VMAs being
> moved are valid.
> 
> We don't try to assess ahead of time whether VMAs are valid according to
> the multi VMA rules, as it would be rather unusual for a user to mix
> uffd-enabled VMAs and/or VMAs which map unusual driver mappings that
> specify custom get_unmapped_area() handlers in an aggregate operation.
> 
> So we optimise for the far, far more likely case of the operation being
> entirely permissible.

Guess it's the sanest thing to do given all the cirumstances.

> In the case of the move of a single VMA, the above conditions are
> permitted. This makes the behaviour identical for a single VMA as before.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Some nits:

> ---
>  mm/mremap.c | 157 +++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 150 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 8cb08ccea6ad..59f49de0f84e 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -69,6 +69,8 @@ struct vma_remap_struct {
>  	enum mremap_type remap_type;	/* expand, shrink, etc. */
>  	bool mmap_locked;		/* Is mm currently write-locked? */
>  	unsigned long charged;		/* If VM_ACCOUNT, # pages to account. */
> +	bool seen_vma;			/* Is >1 VMA being moved? */

Seems this could be local variable of remap_move().

> +	bool vmi_needs_reset;		/* Was the VMA iterator invalidated? */
>  };
>  
>  static pud_t *get_old_pud(struct mm_struct *mm, unsigned long addr)
> @@ -1188,6 +1190,9 @@ static int copy_vma_and_data(struct vma_remap_struct *vrm,
>  		*new_vma_ptr = NULL;
>  		return -ENOMEM;
>  	}

A newline here?

> +	if (vma != vrm->vma)
> +		vrm->vmi_needs_reset = true;

A comment on what this condition means wouldn't hurt? Is it when "Source vma
may have been merged into new_vma" in copy_vma(), or when not?

(no comments bellow, remaining quoted part left for linux-api reference)

> +
>  	vrm->vma = vma;
>  	pmc.old = vma;
>  	pmc.new = new_vma;
> @@ -1583,6 +1588,18 @@ static bool vrm_will_map_new(struct vma_remap_struct *vrm)
>  	return false;
>  }
>  
> +/* Does this remap ONLY move mappings? */
> +static bool vrm_move_only(struct vma_remap_struct *vrm)
> +{
> +	if (!(vrm->flags & MREMAP_FIXED))
> +		return false;
> +
> +	if (vrm->old_len != vrm->new_len)
> +		return false;
> +
> +	return true;
> +}
> +
>  static void notify_uffd(struct vma_remap_struct *vrm, bool failed)
>  {
>  	struct mm_struct *mm = current->mm;
> @@ -1597,6 +1614,32 @@ static void notify_uffd(struct vma_remap_struct *vrm, bool failed)
>  	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
>  }
>  
> +static bool vma_multi_allowed(struct vm_area_struct *vma)
> +{
> +	struct file *file;
> +
> +	/*
> +	 * We can't support moving multiple uffd VMAs as notify requires
> +	 * mmap lock to be dropped.
> +	 */
> +	if (userfaultfd_armed(vma))
> +		return false;
> +
> +	/*
> +	 * Custom get unmapped area might result in MREMAP_FIXED not
> +	 * being obeyed.
> +	 */
> +	file = vma->vm_file;
> +	if (file && !vma_is_shmem(vma) && !is_vm_hugetlb_page(vma)) {
> +		const struct file_operations *fop = file->f_op;
> +
> +		if (fop->get_unmapped_area)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>  static int check_prep_vma(struct vma_remap_struct *vrm)
>  {
>  	struct vm_area_struct *vma = vrm->vma;
> @@ -1646,7 +1689,19 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
>  			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
>  		return -EINVAL;
>  
> -	/* We can't remap across vm area boundaries */
> +	/*
> +	 * We can't remap across the end of VMAs, as another VMA may be
> +	 * adjacent:
> +	 *
> +	 *       addr   vma->vm_end
> +	 *  |-----.----------|
> +	 *  |     .          |
> +	 *  |-----.----------|
> +	 *        .<--------->xxx>
> +	 *            old_len
> +	 *
> +	 * We also require that vma->vm_start <= addr < vma->vm_end.
> +	 */
>  	if (old_len > vma->vm_end - addr)
>  		return -EFAULT;
>  
> @@ -1746,6 +1801,90 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
>  	return 0;
>  }
>  
> +static unsigned long remap_move(struct vma_remap_struct *vrm)
> +{
> +	struct vm_area_struct *vma;
> +	unsigned long start = vrm->addr;
> +	unsigned long end = vrm->addr + vrm->old_len;
> +	unsigned long new_addr = vrm->new_addr;
> +	unsigned long target_addr = new_addr;
> +	unsigned long res = -EFAULT;
> +	unsigned long last_end;
> +	bool allowed = true;
> +	VMA_ITERATOR(vmi, current->mm, start);
> +
> +	/*
> +	 * When moving VMAs we allow for batched moves across multiple VMAs,
> +	 * with all VMAs in the input range [addr, addr + old_len) being moved
> +	 * (and split as necessary).
> +	 */
> +	for_each_vma_range(vmi, vma, end) {
> +		/* Account for start, end not aligned with VMA start, end. */
> +		unsigned long addr = max(vma->vm_start, start);
> +		unsigned long len = min(end, vma->vm_end) - addr;
> +		unsigned long offset, res_vma;
> +
> +		if (!allowed)
> +			return -EFAULT;
> +
> +		/* No gap permitted at the start of the range. */
> +		if (!vrm->seen_vma && start < vma->vm_start)
> +			return -EFAULT;
> +
> +		/*
> +		 * To sensibly move multiple VMAs, accounting for the fact that
> +		 * get_unmapped_area() may align even MAP_FIXED moves, we simply
> +		 * attempt to move such that the gaps between source VMAs remain
> +		 * consistent in destination VMAs, e.g.:
> +		 *
> +		 *           X        Y                       X        Y
> +		 *         <--->     <->                    <--->     <->
> +		 * |-------|   |-----| |-----|      |-------|   |-----| |-----|
> +		 * |   A   |   |  B  | |  C  | ---> |   A'  |   |  B' | |  C' |
> +		 * |-------|   |-----| |-----|      |-------|   |-----| |-----|
> +		 *                               new_addr
> +		 *
> +		 * So we map B' at A'->vm_end + X, and C' at B'->vm_end + Y.
> +		 */
> +		offset = vrm->seen_vma ? vma->vm_start - last_end : 0;
> +		last_end = vma->vm_end;
> +
> +		vrm->vma = vma;
> +		vrm->addr = addr;
> +		vrm->new_addr = target_addr + offset;
> +		vrm->old_len = vrm->new_len = len;
> +
> +		allowed = vma_multi_allowed(vma);
> +		if (vrm->seen_vma && !allowed)
> +			return -EFAULT;
> +
> +		res_vma = check_prep_vma(vrm);
> +		if (!res_vma)
> +			res_vma = mremap_to(vrm);
> +		if (IS_ERR_VALUE(res_vma))
> +			return res_vma;
> +
> +		if (!vrm->seen_vma) {
> +			VM_WARN_ON_ONCE(allowed && res_vma != new_addr);
> +			res = res_vma;
> +		}
> +
> +		/* mmap lock is only dropped on shrink. */
> +		VM_WARN_ON_ONCE(!vrm->mmap_locked);
> +		/* This is a move, no expand should occur. */
> +		VM_WARN_ON_ONCE(vrm->populate_expand);
> +
> +		if (vrm->vmi_needs_reset) {
> +			vma_iter_reset(&vmi);
> +			vrm->vmi_needs_reset = false;
> +		}
> +		vrm->seen_vma = true;
> +		target_addr = res_vma + vrm->new_len;
> +	}
> +
> +	return res;
> +}
> +
>  static unsigned long do_mremap(struct vma_remap_struct *vrm)
>  {
>  	struct mm_struct *mm = current->mm;
> @@ -1763,13 +1902,17 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
>  		return -EINTR;
>  	vrm->mmap_locked = true;
>  
> -	vrm->vma = vma_lookup(current->mm, vrm->addr);
> -	res = check_prep_vma(vrm);
> -	if (res)
> -		goto out;
> +	if (vrm_move_only(vrm)) {
> +		res = remap_move(vrm);
> +	} else {
> +		vrm->vma = vma_lookup(current->mm, vrm->addr);
> +		res = check_prep_vma(vrm);
> +		if (res)
> +			goto out;
>  
> -	/* Actually execute mremap. */
> -	res = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
> +		/* Actually execute mremap. */
> +		res = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
> +	}
>  
>  out:
>  	failed = IS_ERR_VALUE(res);


