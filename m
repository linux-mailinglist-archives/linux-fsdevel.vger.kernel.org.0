Return-Path: <linux-fsdevel+bounces-54287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF215AFD58F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 19:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE5A3B73A6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 17:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29142E6D0A;
	Tue,  8 Jul 2025 17:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qZA+P/A2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2K1Ev5W/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZnALy4Dj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0Tmsowne"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94AE2E613A
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jul 2025 17:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751996226; cv=none; b=AzEbmlAK+Mk5cIOOGOlXKg78GSSozq9VAwgavWYB6cQXOfM5VkD9ENXcz8vrEYzjnzSQHckr+jA7CIZ+uyXYqL5BhgPRRBVb9C8U+YKaL7lYqmZ8AKlnL2JXkW7eKhcLdd7VNzGaDKE1DjdYkFDo1Jd0fYpWboefWHLlVBHNCds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751996226; c=relaxed/simple;
	bh=3ETbXfuDiIb1rIVsKs72/RN/EWQ8Fs3xt1oJEov4Oos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLXj5GOzeYgFiPM8bBScz5SxddcoU6YTagj/qSgD+55jyoZwJf9/7k3gXBq49ldLeghSKLWNutzMshqetj1w5ycYh3Tl3sTRAXXa3oTiJidkzUgv+1vKjiVyqOM/aE6yLNCSlRy1xaS48IFD8MXVDo9F4XSnIMCRJWI2M9DcJKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qZA+P/A2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2K1Ev5W/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZnALy4Dj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0Tmsowne; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E01E02111F;
	Tue,  8 Jul 2025 17:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751996222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tH+4qrLbFoh951omgyvvpr8ql1pn4Evyfl1gUPKbjaI=;
	b=qZA+P/A2RdecqvTOlciyC6KN7axCUlYSQPG2qhRvxoYtO55RTu9DxXWWmAzw9fKZRqPOs6
	HErbR84LTwKdnzxntSmH5Pe7q1Kl6iYgLWWC3T3m2ATmeHcxFdi7ncr5plYGULqALPX6Zy
	jSLOsDRlas+u7BwUnXDmqSrg2p5UO1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751996222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tH+4qrLbFoh951omgyvvpr8ql1pn4Evyfl1gUPKbjaI=;
	b=2K1Ev5W/Bta06tEANRaOF89d5Za6W09a/yHiWtGFAN3aIva8HQehA8atJ2relPR7ST4N6/
	Dr7d2MgkWV1XMICA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751996221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tH+4qrLbFoh951omgyvvpr8ql1pn4Evyfl1gUPKbjaI=;
	b=ZnALy4DjQVwUJLSIAn0dOy+Hz4ezfzu7bZk/oFKSTPr/rqGkNnN/amIetP5Of1BmRKzFjP
	vYfCsiAzIakSbmmGZfRd24Yt7t6RdFtvGfvygMTDhDWGnMPidb3AHfNIXxlWP/57Z3OLev
	22tzeIAhrswJgEbyVBUm3w04QCqHoCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751996221;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tH+4qrLbFoh951omgyvvpr8ql1pn4Evyfl1gUPKbjaI=;
	b=0TmsowneyCfM2N0mNSL/Ne+cG/n8uIkuBz3s2PBsyjjhOLYiX0eFW70dGJ9MuAUHrNehHk
	JfYokWamikkoMyDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3F6313A54;
	Tue,  8 Jul 2025 17:37:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ko5pJz1XbWjoAwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 08 Jul 2025 17:37:01 +0000
Message-ID: <0e0312c9-9a89-4a1b-a135-4425ea95d6f6@suse.cz>
Date: Tue, 8 Jul 2025 19:37:01 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/8] fs/proc/task_mmu: remove conversion of seq_file
 position to unsigned
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com,
 peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org,
 paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com,
 brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com,
 linux@weissschuh.net, willy@infradead.org, osalvador@suse.de,
 andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu,
 tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250704060727.724817-1-surenb@google.com>
 <20250704060727.724817-7-surenb@google.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20250704060727.724817-7-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[oracle.com,redhat.com,google.com,cmpxchg.org,kernel.org,gmail.com,toxicpanda.com,huawei.com,weissschuh.net,infradead.org,suse.de,arm.com,csgroup.eu,vger.kernel.org,kvack.org];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLqwhhqik4qyk5i1fk54co8f1o)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On 7/4/25 08:07, Suren Baghdasaryan wrote:
> Back in 2.6 era, last_addr used to be stored in seq_file->version
> variable, which was unsigned long. As a result, sentinels to represent
> gate vma and end of all vmas used unsigned values. In more recent
> kernels we don't used seq_file->version anymore and therefore conversion
> from loff_t into unsigned type is not needed. Similarly, sentinel values
> don't need to be unsigned. Remove type conversion for set_file position
> and change sentinel values to signed.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Some stuff in the code gave me a pause but it's out of scope here so just in
case someone wants to do some extra churn...

> ---
>  fs/proc/task_mmu.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 751479eb128f..b8bc06d05a72 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -135,7 +135,7 @@ static struct vm_area_struct *proc_get_vma(struct proc_maps_private *priv,
>  	if (vma) {
>  		*ppos = vma->vm_start;
>  	} else {
> -		*ppos = -2UL;
> +		*ppos = -2;
>  		vma = get_gate_vma(priv->mm);
>  	}
>  
> @@ -145,11 +145,11 @@ static struct vm_area_struct *proc_get_vma(struct proc_maps_private *priv,
>  static void *m_start(struct seq_file *m, loff_t *ppos)
>  {
>  	struct proc_maps_private *priv = m->private;
> -	unsigned long last_addr = *ppos;
> +	loff_t last_addr = *ppos;
>  	struct mm_struct *mm;
>  
>  	/* See m_next(). Zero at the start or after lseek. */
> -	if (last_addr == -1UL)
> +	if (last_addr == -1)
>  		return NULL;
>  
>  	priv->task = get_proc_task(priv->inode);
> @@ -170,9 +170,9 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
>  		return ERR_PTR(-EINTR);
>  	}
>  
> -	vma_iter_init(&priv->iter, mm, last_addr);
> +	vma_iter_init(&priv->iter, mm, (unsigned long)last_addr);

I wonder if this should rather be done only after dealing with the -2 case
below. It seems wrong to init the iterator with a bogus address. What if it
acquires some sanity checks?

>  	hold_task_mempolicy(priv);

It seems suboptimal to do that mempolicy refcount dance for numa_maps sake
even if we're reading a different /proc file... maybe priv could have a flag
to determine?

> -	if (last_addr == -2UL)
> +	if (last_addr == -2)
>  		return get_gate_vma(mm);

I think only after the above it makes sense to init the iterator?

>  	return proc_get_vma(priv, ppos);
> @@ -180,8 +180,8 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
>  
>  static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
>  {
> -	if (*ppos == -2UL) {
> -		*ppos = -1UL;
> +	if (*ppos == -2) {
> +		*ppos = -1;
>  		return NULL;
>  	}
>  	return proc_get_vma(m->private, ppos);


