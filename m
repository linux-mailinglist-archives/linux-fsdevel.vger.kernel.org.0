Return-Path: <linux-fsdevel+bounces-31885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF9599C9E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 14:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38DF81C22A60
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 12:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2051A0BDB;
	Mon, 14 Oct 2024 12:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uvsaXnRt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hvFDJ9eT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uvsaXnRt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hvFDJ9eT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6EA7E574;
	Mon, 14 Oct 2024 12:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908153; cv=none; b=UicYAtYiPDptdfWB78MSx09PoQ8uNYEZgQi0W/0UJmtJbklcdHRLihZBzbyXG52jxQ+wSCgcvjCfgqtqDPK37xRisvg23bTi7TGeHOf3pEEppm2AXtd3hIPvLBWL7cq/N2fSkAgJkdAjJ9Ta5n6kBHAPzTVtzXRlwzjgHiag3L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908153; c=relaxed/simple;
	bh=5d2c7ZAEnzATLLjfWg9H82Rdb9FEcueex7OdpeKxgpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDkm2roH1Y6lfZiAS4nfS4SPlN+wduOdU7F3X2UqmjehL7L2pR2A8JHC+rYtl2piMFKcWt6NMCSY/GIqj8z3wjExojXTmyNc1zAx6q77n5m8irC47gPAMePdFBtzelLR+xD53JJhg/Gdec97ditD8He3XwDa+5M/7COAVOO+Hv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uvsaXnRt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hvFDJ9eT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uvsaXnRt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hvFDJ9eT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 412C221D9B;
	Mon, 14 Oct 2024 12:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728908150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6L9TArDqU/9AyY6LyABBa12emgFStrRqvC34y1X/bLg=;
	b=uvsaXnRtmvBy5j9IlTnxcI+HUt6yoCF8TGK2pJufwUH7wQO8F5HdsfV32pU0iQtWpwONh6
	HZHc91sSYVVjVArI3tsA8wrBHX3ryPRteLMeuh4Tts3GgE1K+BXbGM9tDCHOHg7Xg0yCNk
	dSSzNgSiNfMntIGi3OeLALa/2jWAAio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728908150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6L9TArDqU/9AyY6LyABBa12emgFStrRqvC34y1X/bLg=;
	b=hvFDJ9eT2lywgt5kxuJQn4/mpkgtOZicv0yV3DEbky4wq9eppRT3cxFXECJ7G9zeNGxOuL
	4USkNmr0JZ/IdlCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728908150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6L9TArDqU/9AyY6LyABBa12emgFStrRqvC34y1X/bLg=;
	b=uvsaXnRtmvBy5j9IlTnxcI+HUt6yoCF8TGK2pJufwUH7wQO8F5HdsfV32pU0iQtWpwONh6
	HZHc91sSYVVjVArI3tsA8wrBHX3ryPRteLMeuh4Tts3GgE1K+BXbGM9tDCHOHg7Xg0yCNk
	dSSzNgSiNfMntIGi3OeLALa/2jWAAio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728908150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6L9TArDqU/9AyY6LyABBa12emgFStrRqvC34y1X/bLg=;
	b=hvFDJ9eT2lywgt5kxuJQn4/mpkgtOZicv0yV3DEbky4wq9eppRT3cxFXECJ7G9zeNGxOuL
	4USkNmr0JZ/IdlCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3277B13A51;
	Mon, 14 Oct 2024 12:15:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 89RPDHYLDWdDPgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Oct 2024 12:15:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C9447A0896; Mon, 14 Oct 2024 14:15:45 +0200 (CEST)
Date: Mon, 14 Oct 2024 14:15:45 +0200
From: Jan Kara <jack@suse.cz>
To: Kaixiong Yu <yukaixiong@huawei.com>
Cc: akpm@linux-foundation.org, mcgrof@kernel.org,
	ysato@users.sourceforge.jp, dalias@libc.org,
	glaubitz@physik.fu-berlin.de, luto@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, kees@kernel.org, j.granados@samsung.com,
	willy@infradead.org, Liam.Howlett@oracle.com, vbabka@suse.cz,
	lorenzo.stoakes@oracle.com, trondmy@kernel.org, anna@kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, paul@paul-moore.com, jmorris@namei.org,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org, dhowells@redhat.com,
	haifeng.xu@shopee.com, baolin.wang@linux.alibaba.com,
	shikemeng@huaweicloud.com, dchinner@redhat.com, bfoster@redhat.com,
	souravpanda@google.com, hannes@cmpxchg.org, rientjes@google.com,
	pasha.tatashin@soleen.com, david@redhat.com, ryan.roberts@arm.com,
	ying.huang@intel.com, yang@os.amperecomputing.com,
	zev@bewilderbeest.net, serge@hallyn.com, vegard.nossum@oracle.com,
	wangkefeng.wang@huawei.com, sunnanyong@huawei.com
Subject: Re: [PATCH v3 -next 10/15] fs: drop_caches: move sysctl to
 fs/drop_caches.c
Message-ID: <20241014121545.bdgwsw66i2yborjo@quack3>
References: <20241010152215.3025842-1-yukaixiong@huawei.com>
 <20241010152215.3025842-11-yukaixiong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010152215.3025842-11-yukaixiong@huawei.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_GT_50(0.00)[61];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 10-10-24 23:22:10, Kaixiong Yu wrote:
> The sysctl_drop_caches to fs/drop_caches.c, move it to
> fs/drop_caches.c from /kernel/sysctl.c. And remove the
> useless extern variable declaration from include/linux/mm.h
> 
> Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
> Reviewed-by: Kees Cook <kees@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v3:
>  - change the title
> ---
>  fs/drop_caches.c   | 23 +++++++++++++++++++++--
>  include/linux/mm.h |  6 ------
>  kernel/sysctl.c    |  9 ---------
>  3 files changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/drop_caches.c b/fs/drop_caches.c
> index d45ef541d848..f2551ace800f 100644
> --- a/fs/drop_caches.c
> +++ b/fs/drop_caches.c
> @@ -14,7 +14,7 @@
>  #include "internal.h"
>  
>  /* A global variable is a bit ugly, but it keeps the code simple */
> -int sysctl_drop_caches;
> +static int sysctl_drop_caches;
>  
>  static void drop_pagecache_sb(struct super_block *sb, void *unused)
>  {
> @@ -48,7 +48,7 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
>  	iput(toput_inode);
>  }
>  
> -int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
> +static int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
>  		void *buffer, size_t *length, loff_t *ppos)
>  {
>  	int ret;
> @@ -77,3 +77,22 @@ int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
>  	}
>  	return 0;
>  }
> +
> +static struct ctl_table drop_caches_table[] = {
> +	{
> +		.procname	= "drop_caches",
> +		.data		= &sysctl_drop_caches,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0200,
> +		.proc_handler	= drop_caches_sysctl_handler,
> +		.extra1		= SYSCTL_ONE,
> +		.extra2		= SYSCTL_FOUR,
> +	},
> +};
> +
> +static int __init init_vm_drop_caches_sysctls(void)
> +{
> +	register_sysctl_init("vm", drop_caches_table);
> +	return 0;
> +}
> +fs_initcall(init_vm_drop_caches_sysctls);
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c7f73bf32024..ed2e7425c838 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3791,12 +3791,6 @@ static inline int in_gate_area(struct mm_struct *mm, unsigned long addr)
>  
>  extern bool process_shares_mm(struct task_struct *p, struct mm_struct *mm);
>  
> -#ifdef CONFIG_SYSCTL
> -extern int sysctl_drop_caches;
> -int drop_caches_sysctl_handler(const struct ctl_table *, int, void *, size_t *,
> -		loff_t *);
> -#endif
> -
>  void drop_slab(void);
>  
>  #ifndef CONFIG_MMU
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 373e018b950c..d638a1bac9af 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2024,15 +2024,6 @@ static struct ctl_table kern_table[] = {
>  };
>  
>  static struct ctl_table vm_table[] = {
> -	{
> -		.procname	= "drop_caches",
> -		.data		= &sysctl_drop_caches,
> -		.maxlen		= sizeof(int),
> -		.mode		= 0200,
> -		.proc_handler	= drop_caches_sysctl_handler,
> -		.extra1		= SYSCTL_ONE,
> -		.extra2		= SYSCTL_FOUR,
> -	},
>  	{
>  		.procname	= "vfs_cache_pressure",
>  		.data		= &sysctl_vfs_cache_pressure,
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

