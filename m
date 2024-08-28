Return-Path: <linux-fsdevel+bounces-27600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D005B962BFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 17:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C9BBB25EBD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 15:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858AC1A256A;
	Wed, 28 Aug 2024 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="taF32QZJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="e90qolF2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="taF32QZJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="e90qolF2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1521A3BD6
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 15:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858266; cv=none; b=KM4BKn/YfXZoS+MaCSiH5AT3JW1I6wECgBt1v3qAoGE66MVlesYj/3N7RCivL9T47ETZfaDph6Zx9IAI/Dwr5FgRgaw5G34OxmhyW4zQRdbbe2zqFbqmCubIWt0W+BYWEw8N02jbMihdcCdhzKp361CTmnVZQhbEOpSKBjuq6e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858266; c=relaxed/simple;
	bh=HaBB4xXJ/uz7p4hqGdYgn5UG5cyO78jH3GQ1MG3Te5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJb99Da3MLrpmCzyLbTbeidSGFpEkq2CYJj1wYoKZ2kU+jHGIgtjdEIRWFO6PSMpT9Mqt4EysqZoa5ifFydHlq/2PRz0aP5CgJET1m3O5gI6mvptF5FSV89CBxPWlO1c7WR/0WVUHq5SmO9KwbdU8R/8NVAbDUSbuwYfKtbraNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=taF32QZJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=e90qolF2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=taF32QZJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=e90qolF2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 61E7D1FC31;
	Wed, 28 Aug 2024 15:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724858262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uJECRILoADIqJX7fv/yRkwv2GKSTM5VzaC2WYjJPNvc=;
	b=taF32QZJ2sWasKz4vEbP+x0Xfp/gwPd87P6racxG/ieokiBdrgCOCtEMA3HEzZznZtsmU2
	rJT6xZtGCTrxit7ch96PodN2EKjDs1OlL2mdLA/cG0PyrfqQFdluSXfX8ZBZfYP7S4cmca
	BNG1+YDHlyTV8OxH2q137HPRX+taJn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724858262;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uJECRILoADIqJX7fv/yRkwv2GKSTM5VzaC2WYjJPNvc=;
	b=e90qolF2+jh7Y6TTOAgyXOQ1u7527iVkPZP+wRdvXAkibwlb4atchFg7vBGulrLweOYtqx
	60sDpBy7er8L+gAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724858262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uJECRILoADIqJX7fv/yRkwv2GKSTM5VzaC2WYjJPNvc=;
	b=taF32QZJ2sWasKz4vEbP+x0Xfp/gwPd87P6racxG/ieokiBdrgCOCtEMA3HEzZznZtsmU2
	rJT6xZtGCTrxit7ch96PodN2EKjDs1OlL2mdLA/cG0PyrfqQFdluSXfX8ZBZfYP7S4cmca
	BNG1+YDHlyTV8OxH2q137HPRX+taJn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724858262;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uJECRILoADIqJX7fv/yRkwv2GKSTM5VzaC2WYjJPNvc=;
	b=e90qolF2+jh7Y6TTOAgyXOQ1u7527iVkPZP+wRdvXAkibwlb4atchFg7vBGulrLweOYtqx
	60sDpBy7er8L+gAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C4ED138D2;
	Wed, 28 Aug 2024 15:17:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9P1UEpY/z2YqTQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 28 Aug 2024 15:17:42 +0000
Message-ID: <59a935ee-7507-4b94-aefb-f0e5a740e935@suse.cz>
Date: Wed, 28 Aug 2024 17:17:42 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] fs: use kmem_cache_create_rcu()
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, Jann Horn <jannh@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
References: <20240828-work-kmem_cache-rcu-v3-0-5460bc1f09f6@kernel.org>
 <20240828-work-kmem_cache-rcu-v3-3-5460bc1f09f6@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240828-work-kmem_cache-rcu-v3-3-5460bc1f09f6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 8/28/24 12:56, Christian Brauner wrote:
> Switch to the new kmem_cache_create_rcu() helper which allows us to use
> a custom free pointer offset avoiding the need to have an external free
> pointer which would grow struct file behind our backs.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  fs/file_table.c    | 6 +++---
>  include/linux/fs.h | 2 ++
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 694199a1a966..83d5ac1fadc0 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -514,9 +514,9 @@ EXPORT_SYMBOL(__fput_sync);
>  
>  void __init files_init(void)
>  {
> -	filp_cachep = kmem_cache_create("filp", sizeof(struct file), 0,
> -				SLAB_TYPESAFE_BY_RCU | SLAB_HWCACHE_ALIGN |
> -				SLAB_PANIC | SLAB_ACCOUNT, NULL);
> +	filp_cachep = kmem_cache_create_rcu("filp", sizeof(struct file),
> +				offsetof(struct file, f_freeptr),
> +				SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
>  	percpu_counter_init(&nr_files, 0, GFP_KERNEL);
>  }
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 61097a9cf317..5ca83e87adef 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1026,6 +1026,7 @@ static inline int ra_has_index(struct file_ra_state *ra, pgoff_t index)
>   * @f_task_work: task work entry point
>   * @f_llist: work queue entrypoint
>   * @f_ra: file's readahead state
> + * @f_freeptr: Pointer used by SLAB_TYPESAFE_BY_RCU file cache (don't touch.)
>   */
>  struct file {
>  	atomic_long_t			f_count;
> @@ -1057,6 +1058,7 @@ struct file {
>  		struct callback_head	f_task_work;
>  		struct llist_node	f_llist;
>  		struct file_ra_state	f_ra;
> +		freeptr_t		f_freeptr;
>  	};
>  	/* --- cacheline 3 boundary (192 bytes) --- */
>  } __randomize_layout
> 


