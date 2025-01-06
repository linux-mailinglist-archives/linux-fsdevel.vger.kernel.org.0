Return-Path: <linux-fsdevel+bounces-38412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7A9A02189
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 10:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1385F163753
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 09:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE921D89F0;
	Mon,  6 Jan 2025 09:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KRmrPign";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vxyQPM/F";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KRmrPign";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vxyQPM/F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F5873451;
	Mon,  6 Jan 2025 09:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736154827; cv=none; b=TpjqrGRCCTGJvfJV4xsaUwzES7IPk9K5lCEjz59vi3cukuEPIxVbGpgwbUcMnA+fNZfe+TyYpIsKOR/vWxhHXoXCnUQkRPK+eJ+Nfz7vgj/ZUM62Cos7usmtj5U3AKyViqP/Zx1jb+YWQbmMFfWGeGiGqJiFiY7mhhAO43fW5aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736154827; c=relaxed/simple;
	bh=0hXHb7qPEKdhm0/RK6SqPhjdZrX9KRn+qrYDsUjOhSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrBO+BAhYMYyCwLSP9R1nupCeOm1iuPc+8Kfg1b28uOw8sFM/hoi/KW1aVUj4DokGAQrTyLMV+45apnaUj9bGcO6m/HJEK0qimmDOSIGrABrp9yfTZLh6sv0KNZrRe/QGYLG76Uvs07AogsoKfL7TWWfes1+RyRG+wPP+DqGbwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KRmrPign; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vxyQPM/F; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KRmrPign; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vxyQPM/F; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0417221157;
	Mon,  6 Jan 2025 09:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736154824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dDkRF+Vf55DYF2+Zua2WtZLKZjL1FB0xYlA/o8pczd8=;
	b=KRmrPign7EHmD19HO4vsyczHnQ8URTrayWVqOGlCQ1QT8a+xr/aYJU38lveFv703p+tylI
	04dr38yadqoaFgejSxFAbdKL4OI9iO3tDJcb1qA9DL6JqsQeyUL18JaCv6zwLh1uFADWxU
	a1sW9aOHW8fETKv4K5y7PuxoxBqNLNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736154824;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dDkRF+Vf55DYF2+Zua2WtZLKZjL1FB0xYlA/o8pczd8=;
	b=vxyQPM/FaV4IqQFLjVAINS5ugChoY04ZQ8+n6dBpnBGl3763BAa/znQYeTY6V3+uzzkEmv
	guZQf6j8oyh9WXBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736154824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dDkRF+Vf55DYF2+Zua2WtZLKZjL1FB0xYlA/o8pczd8=;
	b=KRmrPign7EHmD19HO4vsyczHnQ8URTrayWVqOGlCQ1QT8a+xr/aYJU38lveFv703p+tylI
	04dr38yadqoaFgejSxFAbdKL4OI9iO3tDJcb1qA9DL6JqsQeyUL18JaCv6zwLh1uFADWxU
	a1sW9aOHW8fETKv4K5y7PuxoxBqNLNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736154824;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dDkRF+Vf55DYF2+Zua2WtZLKZjL1FB0xYlA/o8pczd8=;
	b=vxyQPM/FaV4IqQFLjVAINS5ugChoY04ZQ8+n6dBpnBGl3763BAa/znQYeTY6V3+uzzkEmv
	guZQf6j8oyh9WXBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6CB3139AB;
	Mon,  6 Jan 2025 09:13:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qZVXOMeee2coagAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 06 Jan 2025 09:13:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 875C1A0887; Mon,  6 Jan 2025 10:13:43 +0100 (CET)
Date: Mon, 6 Jan 2025 10:13:43 +0100
From: Jan Kara <jack@suse.cz>
To: Maninder Singh <maninder1.s@samsung.com>
Cc: viro@zeniv.linux.org.uk, elver@google.com, brauner@kernel.org, 
	jack@suse.cz, akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, r.thapliyal@samsung.com
Subject: Re: [PATCH 1/1] lib/list_debug.c: add object information in case of
 invalid object
Message-ID: <4vvrz4fqhtxb4l6yfapxaj37cxmcgywqwzg2c3rhswjsleq54a@glu62exwujrh>
References: <CGME20241230101102epcas5p1c879ea11518951971c8f1bf3dbc3fe39@epcas5p1.samsung.com>
 <20241230101043.53773-1-maninder1.s@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241230101043.53773-1-maninder1.s@samsung.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 30-12-24 15:40:43, Maninder Singh wrote:
> As of now during link list corruption it prints about cluprit address
> and its wrong value, but sometime it is not enough to catch the actual
> issue point.
> 
> If it prints allocation and free path of that corrupted node,
> it will be a lot easier to find and fix the issues.
> 
> Adding the same information when data mismatch is found in link list
> debug data:
> 
> [   14.243055]  slab kmalloc-32 start ffff0000cda19320 data offset 32 pointer offset 8 size 32 allocated at add_to_list+0x28/0xb0
> [   14.245259]     __kmalloc_cache_noprof+0x1c4/0x358
> [   14.245572]     add_to_list+0x28/0xb0
> ...
> [   14.248632]     do_el0_svc_compat+0x1c/0x34
> [   14.249018]     el0_svc_compat+0x2c/0x80
> [   14.249244]  Free path:
> [   14.249410]     kfree+0x24c/0x2f0
> [   14.249724]     do_force_corruption+0xbc/0x100
> ...
> [   14.252266]     el0_svc_common.constprop.0+0x40/0xe0
> [   14.252540]     do_el0_svc_compat+0x1c/0x34
> [   14.252763]     el0_svc_compat+0x2c/0x80
> [   14.253071] ------------[ cut here ]------------
> [   14.253303] list_del corruption. next->prev should be ffff0000cda192a8, but was 6b6b6b6b6b6b6b6b. (next=ffff0000cda19348)
> [   14.254255] WARNING: CPU: 3 PID: 84 at lib/list_debug.c:65 __list_del_entry_valid_or_report+0x158/0x164
> 
> moved prototype of mem_dump_obj() to bug.h, as mm.h can not be included
> in bug.h.
> 
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>

Looks like this could be useful. The changes look good to me. Feel free to
add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Comment: I am not sure about moving of prototype, we can make a new wrapper also,
> so please suggest what is best option. because name mem_dump_obj does
> not go with bug.h
> 
>  fs/open.c           |  2 +-
>  fs/super.c          |  2 +-
>  include/linux/bug.h | 10 +++++++++-
>  include/linux/mm.h  |  6 ------
>  lib/list_debug.c    | 22 +++++++++++-----------
>  5 files changed, 22 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index 0a5d2f6061c6..932e5a6de63b 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1529,7 +1529,7 @@ static int filp_flush(struct file *filp, fl_owner_t id)
>  {
>  	int retval = 0;
>  
> -	if (CHECK_DATA_CORRUPTION(file_count(filp) == 0,
> +	if (CHECK_DATA_CORRUPTION(file_count(filp) == 0, filp,
>  			"VFS: Close: file count is 0 (f_op=%ps)",
>  			filp->f_op)) {
>  		return 0;
> diff --git a/fs/super.c b/fs/super.c
> index c9c7223bc2a2..5a7db4a556e3 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -647,7 +647,7 @@ void generic_shutdown_super(struct super_block *sb)
>  		 */
>  		fscrypt_destroy_keyring(sb);
>  
> -		if (CHECK_DATA_CORRUPTION(!list_empty(&sb->s_inodes),
> +		if (CHECK_DATA_CORRUPTION(!list_empty(&sb->s_inodes), NULL,
>  				"VFS: Busy inodes after unmount of %s (%s)",
>  				sb->s_id, sb->s_type->name)) {
>  			/*
> diff --git a/include/linux/bug.h b/include/linux/bug.h
> index 348acf2558f3..a9948a9f1093 100644
> --- a/include/linux/bug.h
> +++ b/include/linux/bug.h
> @@ -73,15 +73,23 @@ static inline void generic_bug_clear_once(void) {}
>  
>  #endif	/* CONFIG_GENERIC_BUG */
>  
> +#ifdef CONFIG_PRINTK
> +void mem_dump_obj(void *object);
> +#else
> +static inline void mem_dump_obj(void *object) {}
> +#endif
> +
>  /*
>   * Since detected data corruption should stop operation on the affected
>   * structures. Return value must be checked and sanely acted on by caller.
>   */
>  static inline __must_check bool check_data_corruption(bool v) { return v; }
> -#define CHECK_DATA_CORRUPTION(condition, fmt, ...)			 \
> +#define CHECK_DATA_CORRUPTION(condition, addr, fmt, ...)		 \
>  	check_data_corruption(({					 \
>  		bool corruption = unlikely(condition);			 \
>  		if (corruption) {					 \
> +			if (addr)					 \
> +				mem_dump_obj(addr);			 \
>  			if (IS_ENABLED(CONFIG_BUG_ON_DATA_CORRUPTION)) { \
>  				pr_err(fmt, ##__VA_ARGS__);		 \
>  				BUG();					 \
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index d61b9c7a3a7b..9cabab47a23e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4097,12 +4097,6 @@ unsigned long wp_shared_mapping_range(struct address_space *mapping,
>  
>  extern int sysctl_nr_trim_pages;
>  
> -#ifdef CONFIG_PRINTK
> -void mem_dump_obj(void *object);
> -#else
> -static inline void mem_dump_obj(void *object) {}
> -#endif
> -
>  #ifdef CONFIG_ANON_VMA_NAME
>  int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
>  			  unsigned long len_in,
> diff --git a/lib/list_debug.c b/lib/list_debug.c
> index db602417febf..ee7eeeb8f92c 100644
> --- a/lib/list_debug.c
> +++ b/lib/list_debug.c
> @@ -22,17 +22,17 @@ __list_valid_slowpath
>  bool __list_add_valid_or_report(struct list_head *new, struct list_head *prev,
>  				struct list_head *next)
>  {
> -	if (CHECK_DATA_CORRUPTION(prev == NULL,
> +	if (CHECK_DATA_CORRUPTION(prev == NULL, NULL,
>  			"list_add corruption. prev is NULL.\n") ||
> -	    CHECK_DATA_CORRUPTION(next == NULL,
> +	    CHECK_DATA_CORRUPTION(next == NULL, NULL,
>  			"list_add corruption. next is NULL.\n") ||
> -	    CHECK_DATA_CORRUPTION(next->prev != prev,
> +	    CHECK_DATA_CORRUPTION(next->prev != prev, next,
>  			"list_add corruption. next->prev should be prev (%px), but was %px. (next=%px).\n",
>  			prev, next->prev, next) ||
> -	    CHECK_DATA_CORRUPTION(prev->next != next,
> +	    CHECK_DATA_CORRUPTION(prev->next != next, prev,
>  			"list_add corruption. prev->next should be next (%px), but was %px. (prev=%px).\n",
>  			next, prev->next, prev) ||
> -	    CHECK_DATA_CORRUPTION(new == prev || new == next,
> +	    CHECK_DATA_CORRUPTION(new == prev || new == next, NULL,
>  			"list_add double add: new=%px, prev=%px, next=%px.\n",
>  			new, prev, next))
>  		return false;
> @@ -49,20 +49,20 @@ bool __list_del_entry_valid_or_report(struct list_head *entry)
>  	prev = entry->prev;
>  	next = entry->next;
>  
> -	if (CHECK_DATA_CORRUPTION(next == NULL,
> +	if (CHECK_DATA_CORRUPTION(next == NULL, NULL,
>  			"list_del corruption, %px->next is NULL\n", entry) ||
> -	    CHECK_DATA_CORRUPTION(prev == NULL,
> +	    CHECK_DATA_CORRUPTION(prev == NULL, NULL,
>  			"list_del corruption, %px->prev is NULL\n", entry) ||
> -	    CHECK_DATA_CORRUPTION(next == LIST_POISON1,
> +	    CHECK_DATA_CORRUPTION(next == LIST_POISON1, next,
>  			"list_del corruption, %px->next is LIST_POISON1 (%px)\n",
>  			entry, LIST_POISON1) ||
> -	    CHECK_DATA_CORRUPTION(prev == LIST_POISON2,
> +	    CHECK_DATA_CORRUPTION(prev == LIST_POISON2, prev,
>  			"list_del corruption, %px->prev is LIST_POISON2 (%px)\n",
>  			entry, LIST_POISON2) ||
> -	    CHECK_DATA_CORRUPTION(prev->next != entry,
> +	    CHECK_DATA_CORRUPTION(prev->next != entry, prev,
>  			"list_del corruption. prev->next should be %px, but was %px. (prev=%px)\n",
>  			entry, prev->next, prev) ||
> -	    CHECK_DATA_CORRUPTION(next->prev != entry,
> +	    CHECK_DATA_CORRUPTION(next->prev != entry, next,
>  			"list_del corruption. next->prev should be %px, but was %px. (next=%px)\n",
>  			entry, next->prev, next))
>  		return false;
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

