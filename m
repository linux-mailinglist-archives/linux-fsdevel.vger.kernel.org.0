Return-Path: <linux-fsdevel+bounces-56765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D16DB1B63A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 16:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6BA1893505
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 14:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAFB275B0D;
	Tue,  5 Aug 2025 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JLEiwTWg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="15OpfyJo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zDiNZGJ5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZnbvifoH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00C0274FEB
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754403535; cv=none; b=j3woGhX17TKY6eV+xqVre64zaImOjAFsH7QIBMbNvLZZTuvI3goYoARUtchBMwmwjiSUgjm+L/Bed/InXkGx+jCgk7+K/E5YKCMwM14kUKWkSUOAje5QMQlDszPv6LvMKDG4EwenDzYYHGmWjlJEe9267F+ApOIW35lnlIIfj/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754403535; c=relaxed/simple;
	bh=8aRcbWkNJ7XJB7HhT/RC3DT8xiYVHSKOLO2NPWxyEFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pN67p7bV99DsZ2bQo6fGNXiAt4bMAEECtYN6m/BxJfI7zqGwgSAskncHnIJyu2W+HaOyQZvxHaaM5uPDvNXEP7YpeiGgEw4UCV2MJuZ2H6V+PxPu43em/aZJnFAhbOrrPUD1zPnsg2q0MyNmMx1pzDbtrUgw17PeMxtdRDHw68E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JLEiwTWg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=15OpfyJo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zDiNZGJ5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZnbvifoH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DB6CE1F38A;
	Tue,  5 Aug 2025 14:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754403531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+NfTJO6QExB/AjtZCsMzDvrCWnZLiopnMrmlLDf3JbE=;
	b=JLEiwTWgrN3FMXG6fIc7sMoJCxq1EVPmn0gw60A48lFseG+7pgp16TK0QsWp2cyVPSlB/d
	Ax+Gw0JlK4Ic1I5p9wroVK7OffPuUuzWkwRIAtIjjJCgaMcdqyBW6T9hWmecarQgR9mpQE
	OcoOcLoqzQ/JdIiyuaVHAe7bXMGe0cY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754403531;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+NfTJO6QExB/AjtZCsMzDvrCWnZLiopnMrmlLDf3JbE=;
	b=15OpfyJoyk2taAkgIC4Xv+OOtyhWW4yD2jIA+HdaA0B9fKtQ5TD5UCTC0igqFmqQ3E8Gz+
	59OI7CE+fPo/VRDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754403530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+NfTJO6QExB/AjtZCsMzDvrCWnZLiopnMrmlLDf3JbE=;
	b=zDiNZGJ5si2mcehmfw2uKJsVv/5QwnJ6f3tNpjsLAoeQmqBlltQNalA9bop2V2mU6urcLB
	1rnepXmjAR41zGBOEEQSGv/ckndF0/HNZADa6bItMJME+ydlyKB7WT+CUIj3PF6Hk3a+3d
	hydmdVEkZp/7sEij6hxG7BWqmmO6fDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754403530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+NfTJO6QExB/AjtZCsMzDvrCWnZLiopnMrmlLDf3JbE=;
	b=ZnbvifoHF0Ve/E4VFWtrLfAQSaYUTFoeM8xoPnpU01Q7Mo4yP0G3GwG2rcPBIw0ZSkljNF
	2gAHxNsZHZZYPrDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0D8513A50;
	Tue,  5 Aug 2025 14:18:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ysP5MMkSkmh2LwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 05 Aug 2025 14:18:49 +0000
Message-ID: <a2fca13d-87bd-4eb3-b673-46c538f46e66@suse.cz>
Date: Tue, 5 Aug 2025 16:20:47 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] fs/proc/task_mmu: execute PROCMAP_QUERY ioctl
 under per-vma locks
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
References: <20250804231552.1217132-1-surenb@google.com>
 <20250804231552.1217132-4-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <20250804231552.1217132-4-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,redhat.com,google.com,cmpxchg.org,kernel.org,gmail.com,toxicpanda.com,huawei.com,weissschuh.net,infradead.org,suse.de,arm.com,csgroup.eu,vger.kernel.org,kvack.org];
	R_RATELIMIT(0.00)[to_ip_from(RLqwhhqik4qyk5i1fk54co8f1o)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On 8/5/25 1:15 AM, Suren Baghdasaryan wrote:
> Utilize per-vma locks to stabilize vma after lookup without taking
> mmap_lock during PROCMAP_QUERY ioctl execution. If vma lock is
> contended, we fall back to mmap_lock but take it only momentarily
> to lock the vma and release the mmap_lock. In a very unlikely case
> of vm_refcnt overflow, this fall back path will fail and ioctl is
> done under mmap_lock protection.
> 
> This change is designed to reduce mmap_lock contention and prevent
> PROCMAP_QUERY ioctl calls from blocking address space updates.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  fs/proc/task_mmu.c | 81 +++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 65 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 843577aa7a32..1d06ecdbef6f 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -517,28 +517,78 @@ static int pid_maps_open(struct inode *inode, struct file *file)
>  		PROCMAP_QUERY_VMA_FLAGS				\
>  )
>  
> -static int query_vma_setup(struct mm_struct *mm)
> +#ifdef CONFIG_PER_VMA_LOCK
> +
> +static int query_vma_setup(struct proc_maps_locking_ctx *lock_ctx)
>  {
> -	return mmap_read_lock_killable(mm);
> +	lock_ctx->locked_vma = NULL;
> +	lock_ctx->mmap_locked = false;
> +
> +	return 0;
>  }
>  
> -static void query_vma_teardown(struct mm_struct *mm, struct vm_area_struct *vma)
> +static void query_vma_teardown(struct proc_maps_locking_ctx *lock_ctx)
>  {
> -	mmap_read_unlock(mm);
> +	if (lock_ctx->mmap_locked)
> +		mmap_read_unlock(lock_ctx->mm);
> +	else
> +		unlock_vma(lock_ctx);
>  }
>  
> -static struct vm_area_struct *query_vma_find_by_addr(struct mm_struct *mm, unsigned long addr)
> +static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_locking_ctx *lock_ctx,
> +						     unsigned long addr)
>  {
> -	return find_vma(mm, addr);
> +	struct vm_area_struct *vma;
> +	struct vma_iterator vmi;
> 

Hm I think we can reach here with lock_ctx->mmap_locked being true via
"goto next_vma" in query_matching_vma(). In that case we should just
"return find_vma()" and doing the below is wrong, no?

> +	unlock_vma(lock_ctx);
> +	rcu_read_lock();
> +	vma_iter_init(&vmi, lock_ctx->mm, addr);
> +	vma = lock_next_vma(lock_ctx->mm, &vmi, addr);
> +	rcu_read_unlock();
> +
> +	if (!IS_ERR_OR_NULL(vma)) {
> +		lock_ctx->locked_vma = vma;
> +	} else if (PTR_ERR(vma) == -EAGAIN) {
> +		/* Fallback to mmap_lock on vma->vm_refcnt overflow */
> +		mmap_read_lock(lock_ctx->mm);
> +		vma = find_vma(lock_ctx->mm, addr);
> +		lock_ctx->mmap_locked = true;
> +	}
> +
> +	return vma;
>  }
>  

