Return-Path: <linux-fsdevel+bounces-50073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 962DCAC7FE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 16:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54DCF1C0288E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 14:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAE322B8BF;
	Thu, 29 May 2025 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zj4WrcoO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AqRwRPYv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zj4WrcoO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AqRwRPYv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882E133E4
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748530221; cv=none; b=XD7GjWOE8sf3YP7vp/ENXtbR2z+aEaGj7ddJk/UKqVtV+Wts+x6r1jirdAx8joo2htncqeohtdc99lp8lL21rvlEQKBRgBy1EpvH/SlsoPptMoc9QE8fyo3h9iqA9412C+T9py4O1Mgh+MP86rrT4WTGCZKpjdsqRZJG2Vemq9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748530221; c=relaxed/simple;
	bh=i3SQpCkwdI82q1XtVJ3szfugVH3vAfvo8/MNv4LKUv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Va2z5RC/3MivLFMyL4wd8FArcXclP3QRv0lloHJspAx7+//2Xg86muTkIMK67KyjYEbMTb0LvsjGmlk64htaSsjax5sBVtpCeskJxJabKOWMT20kzzzGINOnjjfKqDLfGbD0+7DL2pNGZDWFoY2MxLWwFmlBuHe/g4/0z85RqSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zj4WrcoO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AqRwRPYv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zj4WrcoO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AqRwRPYv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 483551F7A9;
	Thu, 29 May 2025 14:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748530217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=djn1kbQfcENXYJYX8R1xrSQibb49cq0b2Wy1kAULoDI=;
	b=Zj4WrcoOtvaeE6RQ3uoIo5hd3e8UI6ow01guVFJz0pv0J4HzDVxo3zDUw6uIwyYu3gOYcr
	M+t4jVEcG0SrkhF6TfPzmawHhLO4xuWiXS+4D/AekZTmNYRkhWLv6VaWYEumU3Vo7Py8la
	vVfNhErBnvviXW7uGbWSrDpio/qdKZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748530217;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=djn1kbQfcENXYJYX8R1xrSQibb49cq0b2Wy1kAULoDI=;
	b=AqRwRPYvUy/ScnkDMqwNgul/B1mv+UfSIsbaHJM4isCPUeEG/EVlw7W4asRXVCMq4FNBDM
	ba7jwJpIK97sKJCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Zj4WrcoO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=AqRwRPYv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748530217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=djn1kbQfcENXYJYX8R1xrSQibb49cq0b2Wy1kAULoDI=;
	b=Zj4WrcoOtvaeE6RQ3uoIo5hd3e8UI6ow01guVFJz0pv0J4HzDVxo3zDUw6uIwyYu3gOYcr
	M+t4jVEcG0SrkhF6TfPzmawHhLO4xuWiXS+4D/AekZTmNYRkhWLv6VaWYEumU3Vo7Py8la
	vVfNhErBnvviXW7uGbWSrDpio/qdKZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748530217;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=djn1kbQfcENXYJYX8R1xrSQibb49cq0b2Wy1kAULoDI=;
	b=AqRwRPYvUy/ScnkDMqwNgul/B1mv+UfSIsbaHJM4isCPUeEG/EVlw7W4asRXVCMq4FNBDM
	ba7jwJpIK97sKJCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 244CD136E0;
	Thu, 29 May 2025 14:50:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EidBCCl0OGi1SwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 29 May 2025 14:50:17 +0000
Message-ID: <924e2e84-fe37-4fc3-9c76-11ce008f0ac4@suse.cz>
Date: Thu, 29 May 2025 16:50:16 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] mm: prevent KSM from completely breaking VMA
 merging
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Stefan Roesch <shr@devkernel.io>
References: <cover.1747844463.git.lorenzo.stoakes@oracle.com>
 <6057647abfceb672fa932ad7fb1b5b69bdab0fc7.1747844463.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <6057647abfceb672fa932ad7fb1b5b69bdab0fc7.1747844463.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,oracle.com:email];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 483551F7A9
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51

On 5/21/25 20:20, Lorenzo Stoakes wrote:
> If a user wishes to enable KSM mergeability for an entire process and all
> fork/exec'd processes that come after it, they use the prctl()
> PR_SET_MEMORY_MERGE operation.
> 
> This defaults all newly mapped VMAs to have the VM_MERGEABLE VMA flag set
> (in order to indicate they are KSM mergeable), as well as setting this flag
> for all existing VMAs.
> 
> However it also entirely and completely breaks VMA merging for the process
> and all forked (and fork/exec'd) processes.

I think merging due to e.g. mprotect() should still work, but for new VMAs,
yeah.

> This is because when a new mapping is proposed, the flags specified will
> never have VM_MERGEABLE set. However all adjacent VMAs will already have
> VM_MERGEABLE set, rendering VMAs unmergeable by default.
> 
> To work around this, we try to set the VM_MERGEABLE flag prior to
> attempting a merge. In the case of brk() this can always be done.
> 
> However on mmap() things are more complicated - while KSM is not supported
> for file-backed mappings, it is supported for MAP_PRIVATE file-backed

     ^ insert "shared" to make it obvious?

> mappings.
> 
> And these mappings may have deprecated .mmap() callbacks specified which
> could, in theory, adjust flags and thus KSM eligiblity.

Right, however your can_set_ksm_flags_early() isn't testing exactly that?
More on that there.

> This is unlikely to cause an issue on merge, as any adjacent file-backed
> mappings would already have the same post-.mmap() callback attributes, and
> thus would naturally not be merged.

I'm getting a bit lost as two kinds of merging have to be discussed. If the
vma's around have the same afftributes, they would be VMA-merged, no?

> But for the purposes of establishing a VMA as KSM-eligible (as well as
> initially scanning the VMA), this is potentially very problematic.

This part I understand as we have to check if we can add VM_MERGEABLE after
mmap() has adjusted the flags, as it might have an effect on the result of
ksm_compatible()?

> So we check to determine whether this at all possible. If not, we set
> VM_MERGEABLE prior to the merge attempt on mmap(), otherwise we retain the
> previous behaviour.
> 
> When .mmap_prepare() is more widely used, we can remove this precaution.
> 
> While this doesn't quite cover all cases, it covers a great many (all
> anonymous memory, for instance), meaning we should already see a
> significant improvement in VMA mergeability.
> 
> Since, when it comes to file-backed mappings (other than shmem) we are
> really only interested in MAP_PRIVATE mappings which have an available anon
> page by default. Therefore, the VM_SPECIAL restriction makes less sense for
> KSM.
> 
> In a future series we therefore intend to remove this limitation, which
> ought to simplify this implementation. However it makes sense to defer
> doing so until a later stage so we can first address this mergeability
> issue.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Fixes: d7597f59d1d3 ("mm: add new api to enable ksm per process") # please no backport!
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

<snip>

> +/*
> + * Are we guaranteed no driver can change state such as to preclude KSM merging?
> + * If so, let's set the KSM mergeable flag early so we don't break VMA merging.
> + *
> + * This is applicable when PR_SET_MEMORY_MERGE has been set on the mm_struct via
> + * prctl() causing newly mapped VMAs to have the KSM mergeable VMA flag set.
> + *
> + * If this is not the case, then we set the flag after considering mergeability,

								     ^ "VMA"

> + * which will prevent mergeability as, when PR_SET_MEMORY_MERGE is set, a new

			^ "VMA"

> + * VMA will not have the KSM mergeability VMA flag set, but all other VMAs will,
> + * preventing any merge.

		    ^ "VMA"

tedious I know, but more obvious, IMHO

> + */
> +static bool can_set_ksm_flags_early(struct mmap_state *map)
> +{
> +	struct file *file = map->file;
> +
> +	/* Anonymous mappings have no driver which can change them. */
> +	if (!file)
> +		return true;
> +
> +	/* shmem is safe. */
> +	if (shmem_file(file))
> +		return true;
> +
> +	/*
> +	 * If .mmap_prepare() is specified, then the driver will have already
> +	 * manipulated state prior to updating KSM flags.
> +	 */
> +	if (file->f_op->mmap_prepare)
> +		return true;
> +
> +	return false;

So back to my reply in the commit log, why test for mmap_prepare and
otherwise assume false, and not instead test for f_op->mmap which would
result in false, and otherwise return true? Or am I assuming wrong that
there are f_ops that have neither of those two callbacks?

> +}
> +
>  static unsigned long __mmap_region(struct file *file, unsigned long addr,
>  		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
>  		struct list_head *uf)
> @@ -2595,6 +2633,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
>  	bool have_mmap_prepare = file && file->f_op->mmap_prepare;
>  	VMA_ITERATOR(vmi, mm, addr);
>  	MMAP_STATE(map, mm, &vmi, addr, len, pgoff, vm_flags, file);
> +	bool check_ksm_early = can_set_ksm_flags_early(&map);
> 
>  	error = __mmap_prepare(&map, uf);
>  	if (!error && have_mmap_prepare)
> @@ -2602,6 +2641,9 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
>  	if (error)
>  		goto abort_munmap;
> 
> +	if (check_ksm_early)
> +		update_ksm_flags(&map);
> +
>  	/* Attempt to merge with adjacent VMAs... */
>  	if (map.prev || map.next) {
>  		VMG_MMAP_STATE(vmg, &map, /* vma = */ NULL);
> @@ -2611,6 +2653,9 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
> 
>  	/* ...but if we can't, allocate a new VMA. */
>  	if (!vma) {
> +		if (!check_ksm_early)
> +			update_ksm_flags(&map);
> +
>  		error = __mmap_new_vma(&map, &vma);
>  		if (error)
>  			goto unacct_error;
> @@ -2713,6 +2758,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	 * Note: This happens *after* clearing old mappings in some code paths.
>  	 */
>  	flags |= VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
> +	flags = ksm_vma_flags(mm, NULL, flags);
>  	if (!may_expand_vm(mm, flags, len >> PAGE_SHIFT))
>  		return -ENOMEM;
> 
> @@ -2756,7 +2802,6 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
> 
>  	mm->map_count++;
>  	validate_mm(mm);
> -	ksm_add_vma(vma);
>  out:
>  	perf_event_mmap(vma);
>  	mm->total_vm += len >> PAGE_SHIFT;
> --
> 2.49.0


