Return-Path: <linux-fsdevel+bounces-31884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2581599C9D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 14:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 986221F21FA6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 12:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF191A0BC4;
	Mon, 14 Oct 2024 12:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MSkRzHJL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9eOjRoJL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MSkRzHJL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9eOjRoJL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1287156F3F;
	Mon, 14 Oct 2024 12:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908072; cv=none; b=oRqVTsmWbw0t2+vpjVOObNaVfTw2AInsdFZkr3T9sRc83lAvCr+PqfthrG/RftCjzyA8HptC7+20cmfeoyfcElE2NFjL5mth73pmoeCNpUutVDk6+YSaPW9ZU7RRT37EqnrQ+cje4agU5jCmpCjIFiYuo4t5LcfyIQMfoov1C8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908072; c=relaxed/simple;
	bh=hI9GQ3vWz+dBlWIaegULE8LirCEC8ki5cfl4RmMwbPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKX6tUv6Zi3DQaXYELqfOoBxepzHPgihFD+1+DTeTs1qGa7fbX6yY7iwQgLuDdFCsrl7cbt5yN6Hv4PGbZu476LJ5JYlnfDKRy0fQjq/Ip2wov41wOe51LmsJwCI2HTNOpi6UPLcv7cUOLHrqNkuL0YaXVVBwjezxv6TxjucuEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MSkRzHJL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9eOjRoJL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MSkRzHJL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9eOjRoJL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 110F321B5D;
	Mon, 14 Oct 2024 12:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728908068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WDvMMHa5hCU5rljm//6SmMBj9GhVvVjaeKHjUwQCpNw=;
	b=MSkRzHJL2U9tNILZ53M7T+G7hBt5Gu3qsdJDFOEQGfiSTxYSNoTxDzdn7XosPoeklNOD8O
	eZz7rgPHanpLc0QREwoMWLe0gXVWK5oHqMM6l65GTF2/zp2vqDfbQCN1/mMyFxh1iMJjFy
	xuTVOaZ/H7tyyf9Nlxs5WeIboGM/qAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728908068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WDvMMHa5hCU5rljm//6SmMBj9GhVvVjaeKHjUwQCpNw=;
	b=9eOjRoJLlTvz5l4PYWguZW27Xg22LNgu4zu/8XkcB0ssuDH50N40nmDYnhSbcx8qRjKZcM
	DmVFF+M12aAo5wAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728908068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WDvMMHa5hCU5rljm//6SmMBj9GhVvVjaeKHjUwQCpNw=;
	b=MSkRzHJL2U9tNILZ53M7T+G7hBt5Gu3qsdJDFOEQGfiSTxYSNoTxDzdn7XosPoeklNOD8O
	eZz7rgPHanpLc0QREwoMWLe0gXVWK5oHqMM6l65GTF2/zp2vqDfbQCN1/mMyFxh1iMJjFy
	xuTVOaZ/H7tyyf9Nlxs5WeIboGM/qAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728908068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WDvMMHa5hCU5rljm//6SmMBj9GhVvVjaeKHjUwQCpNw=;
	b=9eOjRoJLlTvz5l4PYWguZW27Xg22LNgu4zu/8XkcB0ssuDH50N40nmDYnhSbcx8qRjKZcM
	DmVFF+M12aAo5wAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECE9513A79;
	Mon, 14 Oct 2024 12:14:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BA6EOSMLDWe2PQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Oct 2024 12:14:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8A807A0896; Mon, 14 Oct 2024 14:14:27 +0200 (CEST)
Date: Mon, 14 Oct 2024 14:14:27 +0200
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
Subject: Re: [PATCH v3 -next 09/15] fs: fs-writeback: move sysctl to
 fs/fs-writeback.c
Message-ID: <20241014121427.vuebknsmdlrtbveh@quack3>
References: <20241010152215.3025842-1-yukaixiong@huawei.com>
 <20241010152215.3025842-10-yukaixiong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010152215.3025842-10-yukaixiong@huawei.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
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
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Thu 10-10-24 23:22:09, Kaixiong Yu wrote:
> The dirtytime_expire_interval belongs to fs/fs-writeback.c, move it to
> fs/fs-writeback.c from /kernel/sysctl.c. And remove the useless extern
> variable declaration and the function declaration from
> include/linux/writeback.h
> 
> Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
> Reviewed-by: Kees Cook <kees@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v3:
>  - change dirtytime_expire_interval to static type
>  - change the title
> ---
>  fs/fs-writeback.c         | 30 +++++++++++++++++++++---------
>  include/linux/writeback.h |  4 ----
>  kernel/sysctl.c           |  8 --------
>  3 files changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index d8bec3c1bb1f..4fedefdb8e15 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -65,7 +65,7 @@ struct wb_writeback_work {
>   * timestamps written to disk after 12 hours, but in the worst case a
>   * few inodes might not their timestamps updated for 24 hours.
>   */
> -unsigned int dirtytime_expire_interval = 12 * 60 * 60;
> +static unsigned int dirtytime_expire_interval = 12 * 60 * 60;
>  
>  static inline struct inode *wb_inode(struct list_head *head)
>  {
> @@ -2413,14 +2413,7 @@ static void wakeup_dirtytime_writeback(struct work_struct *w)
>  	schedule_delayed_work(&dirtytime_work, dirtytime_expire_interval * HZ);
>  }
>  
> -static int __init start_dirtytime_writeback(void)
> -{
> -	schedule_delayed_work(&dirtytime_work, dirtytime_expire_interval * HZ);
> -	return 0;
> -}
> -__initcall(start_dirtytime_writeback);
> -
> -int dirtytime_interval_handler(const struct ctl_table *table, int write,
> +static int dirtytime_interval_handler(const struct ctl_table *table, int write,
>  			       void *buffer, size_t *lenp, loff_t *ppos)
>  {
>  	int ret;
> @@ -2431,6 +2424,25 @@ int dirtytime_interval_handler(const struct ctl_table *table, int write,
>  	return ret;
>  }
>  
> +static struct ctl_table vm_fs_writeback_table[] = {
> +	{
> +		.procname	= "dirtytime_expire_seconds",
> +		.data		= &dirtytime_expire_interval,
> +		.maxlen		= sizeof(dirtytime_expire_interval),
> +		.mode		= 0644,
> +		.proc_handler	= dirtytime_interval_handler,
> +		.extra1		= SYSCTL_ZERO,
> +	},
> +};
> +
> +static int __init start_dirtytime_writeback(void)
> +{
> +	schedule_delayed_work(&dirtytime_work, dirtytime_expire_interval * HZ);
> +	register_sysctl_init("vm", vm_fs_writeback_table);
> +	return 0;
> +}
> +__initcall(start_dirtytime_writeback);
> +
>  /**
>   * __mark_inode_dirty -	internal function to mark an inode dirty
>   *
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index d6db822e4bb3..5f35b24aff7b 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -351,12 +351,8 @@ extern struct wb_domain global_wb_domain;
>  /* These are exported to sysctl. */
>  extern unsigned int dirty_writeback_interval;
>  extern unsigned int dirty_expire_interval;
> -extern unsigned int dirtytime_expire_interval;
>  extern int laptop_mode;
>  
> -int dirtytime_interval_handler(const struct ctl_table *table, int write,
> -		void *buffer, size_t *lenp, loff_t *ppos);
> -
>  void global_dirty_limits(unsigned long *pbackground, unsigned long *pdirty);
>  unsigned long wb_calc_thresh(struct bdi_writeback *wb, unsigned long thresh);
>  unsigned long cgwb_calc_thresh(struct bdi_writeback *wb);
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index d3de31ec74bf..373e018b950c 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2024,14 +2024,6 @@ static struct ctl_table kern_table[] = {
>  };
>  
>  static struct ctl_table vm_table[] = {
> -	{
> -		.procname	= "dirtytime_expire_seconds",
> -		.data		= &dirtytime_expire_interval,
> -		.maxlen		= sizeof(dirtytime_expire_interval),
> -		.mode		= 0644,
> -		.proc_handler	= dirtytime_interval_handler,
> -		.extra1		= SYSCTL_ZERO,
> -	},
>  	{
>  		.procname	= "drop_caches",
>  		.data		= &sysctl_drop_caches,
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

