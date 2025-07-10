Return-Path: <linux-fsdevel+bounces-54514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AD9B00447
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 15:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3041C8339D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 13:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D90273D74;
	Thu, 10 Jul 2025 13:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M2eFFee6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7DmfLJuE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ez2TuBkQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mQTgYkI4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81DC270571
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752155353; cv=none; b=LS47fUfxJU0L2IMAzx4rSlo9Q0pP1ko81ctxt/mJkYHVPsZnnSxholAxiKCEeUBzhWj98wBrH+IZ+JdIkwAG1yYGAJFYwGICqlhdvnFSvCGkVY3v3HRpcs5RC8Cr4nqswY3KkXi98qz3cVtHO/hQyCkHGbSWdRZydjRSZhPWMRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752155353; c=relaxed/simple;
	bh=tR8PN/J5l9qFBmrP/SR33R7z0CEzTUo5W/W/kAVPGAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eP3fLaan8oQWB+IrXTrPIRDypVYM6JLVWHmfPJ8YR5qKgvnEqrcRJhYwP0De98uFhLOyQMCW3HzlYA62W1zqGgkkoIRa/L6FRu3v73t0pYUjWuZ7RQ5SnDVb/NphFiVUcBY0jiqCOURPoBu8cwANtMg3ChfxxbM+FJ/wtroMn0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M2eFFee6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7DmfLJuE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ez2TuBkQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mQTgYkI4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D6D73211EA;
	Thu, 10 Jul 2025 13:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752155350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1xNZvFrIzwNQM70BQvlAJOjHYghGvU+dClg4vcHUBic=;
	b=M2eFFee6np8LoV25m+nrItnopF+n85mcC/0wt7fOi91lualJL6L29W8Pk+bS22lhvoZ/zJ
	2L/XBf5MhIyCSb0NgDSjoyTpMr6LXRg206hb73px3ByzRCC4GHFVL5nd1Wh9MAhQiWHHkC
	FnkkfVvv6DtxXr252I2G0EDF/dzGLS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752155350;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1xNZvFrIzwNQM70BQvlAJOjHYghGvU+dClg4vcHUBic=;
	b=7DmfLJuEynaECHVZnb3uL5p6uer81Hdm13VnUq8RJDdiDoud6L5VWUkH0kPJUCBinlklGZ
	A0Ew4b5ROw4ym6Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752155349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1xNZvFrIzwNQM70BQvlAJOjHYghGvU+dClg4vcHUBic=;
	b=ez2TuBkQHKXNLPqCDkyVJjjuZcACTm3moBS1S4uhREacoph2jOSXjXuHJgeMZhU9ukYNha
	BxWxdND6HLncrYrBKcom4FpY+3uI3w1HE0/B2DHnwZl8vdrL1/ItMzb0xgxOHlhZoXpIRu
	Pku/Tx7/E0tiEOZU1Yxe+MbKxxsPHAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752155349;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1xNZvFrIzwNQM70BQvlAJOjHYghGvU+dClg4vcHUBic=;
	b=mQTgYkI41XT7EniDepekQgZgib+Pzw1HqxGBlh5YCqN/4uVvhZzneLtuzuwj+IVTlR+3nD
	DDTZ//CoVLDWTxBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEED8136CB;
	Thu, 10 Jul 2025 13:49:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mM1xLdXEb2hLJwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 10 Jul 2025 13:49:09 +0000
Message-ID: <277aa9f4-ddb7-4f34-ad15-a98888108cb5@suse.cz>
Date: Thu, 10 Jul 2025 15:49:09 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] mm/mremap: cleanup post-processing stage of mremap
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
 <d21f091bb617d0ac31b6e541d6c6ce28afe880c1.1751865330.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <d21f091bb617d0ac31b6e541d6c6ce28afe880c1.1751865330.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 7/7/25 07:27, Lorenzo Stoakes wrote:
> Separate out the uffd bits so it clear's what's happening.
> 
> Don't bother setting vrm->mmap_locked after unlocking, because after this
> we are done anyway.
> 
> The only time we drop the mmap lock is on VMA shrink, at which point
> vrm->new_len will be < vrm->old_len and the operation will not be performed
> anyway, so move this code out of the if (vrm->mmap_locked) block.
> 
> All addresses returned by mremap() are page-aligned, so the
> offset_in_page() check on ret seems only to be incorrectly trying to detect

"incorrectly" to me implies there's a bug. But AFAIU there's not, so maybe
e.g. "inappropriately"?

> whether an error occurred - explicitly check for this.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Just a nit:

> ---
>  mm/mremap.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 60eb0ac8634b..660bdb75e2f9 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -1729,6 +1729,15 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
>  	return 0;
>  }
>  
> +static void notify_uffd(struct vma_remap_struct *vrm, unsigned long ret)

"ret" not "res"? :) Or actually why not name it for what it is,
mremap_userfaultfd_complete() names the parameter "to". Maybe to_addr or
new_addr?

> +{
> +	struct mm_struct *mm = current->mm;
> +
> +	userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
> +	mremap_userfaultfd_complete(vrm->uf, vrm->addr, ret, vrm->old_len);
> +	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
> +}
> +
>  static unsigned long do_mremap(struct vma_remap_struct *vrm)
>  {
>  	struct mm_struct *mm = current->mm;
> @@ -1754,18 +1763,13 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
>  	res = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
>  
>  out:
> -	if (vrm->mmap_locked) {
> +	if (vrm->mmap_locked)
>  		mmap_write_unlock(mm);
> -		vrm->mmap_locked = false;
> -
> -		if (!offset_in_page(res) && vrm->mlocked && vrm->new_len > vrm->old_len)
> -			mm_populate(vrm->new_addr + vrm->old_len, vrm->delta);
> -	}
>  
> -	userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
> -	mremap_userfaultfd_complete(vrm->uf, vrm->addr, res, vrm->old_len);
> -	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
> +	if (!IS_ERR_VALUE(res) && vrm->mlocked && vrm->new_len > vrm->old_len)
> +		mm_populate(vrm->new_addr + vrm->old_len, vrm->delta);
>  
> +	notify_uffd(vrm, res);
>  	return res;
>  }
>  


