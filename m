Return-Path: <linux-fsdevel+bounces-48878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96405AB5292
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D90E4A1239
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 10:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC3E253934;
	Tue, 13 May 2025 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zUK+TYTV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nvjl6H4n";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zUK+TYTV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nvjl6H4n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8FD253349
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 10:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747131263; cv=none; b=Vd9Nmm5evE8vybYs/SXpQmMuZud+zu7kyHPgYVo/3Qvvce2hNi1kgKLsXvgsyIY6x6aD0Tf0tVp+mqnaPNohOym02dktVp1P9XCmdYF5Q3e2JcYDLnOXEVaV8IPjs0tLrOrSP6FNBXXbbbGyfRhkQgdMcHGO5SAiMHF9FY29VRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747131263; c=relaxed/simple;
	bh=O/D49dH/3ZU7l2kU9fa4Ogt9BRL5efhXD8t4iEIwnvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJ3pMEWy2+bdj7i/iwFrb+NmO5CBUKjGCOnUXhd3o3HwlnTBvRhu9jU0suH3C1ZBIvW6mNcpauqs6s98HqdpxcCDXgRX6HDO2ECycp3VQzp5qqBEaL+9anJiZlHooOCLSpnb4+Nb4Yz5fGtBWcN2/XjvTUuvrfhHFh8wAKD4Cdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zUK+TYTV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nvjl6H4n; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zUK+TYTV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nvjl6H4n; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 25955211CC;
	Tue, 13 May 2025 10:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747131259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MFH3o/CsNjYUloGL83cxS8Khs/dhzDKPh6Uxcq13wfk=;
	b=zUK+TYTVPJTCuvLkQ7UMoOaEE0j6wSFRWt5mDNPzc5Fsk7009srxVszEtkuo/oQWEBzqa2
	PBTvewqAwTlQqx35i2ianHd91wJTKrLs4B2XmI/vVZWegBA/ogFctavcXhqNBWxWZiUfkg
	USU04AFsVJKdwM8yJGapI+niLKvvM8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747131259;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MFH3o/CsNjYUloGL83cxS8Khs/dhzDKPh6Uxcq13wfk=;
	b=Nvjl6H4nAh+KlFrWm0oWIHHGLzfrHW1zBjbvXgz6P4k66ji/P31qCxKCv4cnNPBXWRbe3o
	L0DAUjBtcjX2O6BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zUK+TYTV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Nvjl6H4n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747131259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MFH3o/CsNjYUloGL83cxS8Khs/dhzDKPh6Uxcq13wfk=;
	b=zUK+TYTVPJTCuvLkQ7UMoOaEE0j6wSFRWt5mDNPzc5Fsk7009srxVszEtkuo/oQWEBzqa2
	PBTvewqAwTlQqx35i2ianHd91wJTKrLs4B2XmI/vVZWegBA/ogFctavcXhqNBWxWZiUfkg
	USU04AFsVJKdwM8yJGapI+niLKvvM8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747131259;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MFH3o/CsNjYUloGL83cxS8Khs/dhzDKPh6Uxcq13wfk=;
	b=Nvjl6H4nAh+KlFrWm0oWIHHGLzfrHW1zBjbvXgz6P4k66ji/P31qCxKCv4cnNPBXWRbe3o
	L0DAUjBtcjX2O6BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 173B5137E8;
	Tue, 13 May 2025 10:14:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R76kBXsbI2iFGAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 13 May 2025 10:14:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A941DA0AFB; Tue, 13 May 2025 12:14:18 +0200 (CEST)
Date: Tue, 13 May 2025 12:14:18 +0200
From: Jan Kara <jack@suse.cz>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: Add sysctl vfs_cache_pressure_denom for bulk file
 operations
Message-ID: <udda3sy3v4fnbm3v4tdksq6qm7xsswxt6ron4kassx55b5pukq@cpwolswb52zj>
References: <20250511083624.9305-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250511083624.9305-1-laoar.shao@gmail.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 25955211CC
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim,suse.com:email]
X-Rspamd-Action: no action

On Sun 11-05-25 16:36:24, Yafang Shao wrote:
> On our HDFS servers with 12 HDDs per server, a HDFS datanode[0] startup
> involves scanning all files and caching their metadata (including dentries
> and inodes) in memory. Each HDD contains approximately 2 million files,
> resulting in a total of ~20 million cached dentries after initialization.
> 
> To minimize dentry reclamation, we set vfs_cache_pressure to 1. Despite
> this configuration, memory pressure conditions can still trigger
> reclamation of up to 50% of cached dentries, reducing the cache from 20
> million to approximately 10 million entries. During the subsequent cache
> rebuild period, any HDFS datanode restart operation incurs substantial
> latency penalties until full cache recovery completes.
> 
> To maintain service stability, we need to preserve more dentries during
> memory reclamation. The current minimum reclaim ratio (1/100 of total
> dentries) remains too aggressive for our workload. This patch introduces
> vfs_cache_pressure_denom for more granular cache pressure control. The
> configuration [vfs_cache_pressure=1, vfs_cache_pressure_denom=10000]
> effectively maintains the full 20 million dentry cache under memory
> pressure, preventing datanode restart performance degradation.
> 
> Link: https://hadoop.apache.org/docs/r1.2.1/hdfs_design.html#NameNode+and+DataNodes [0]
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Makes sense. The patch looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  Documentation/admin-guide/sysctl/vm.rst | 32 ++++++++++++++++---------
>  fs/dcache.c                             | 11 ++++++++-
>  2 files changed, 31 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> index 8290177b4f75..d385985b305f 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -75,6 +75,7 @@ Currently, these files are in /proc/sys/vm:
>  - unprivileged_userfaultfd
>  - user_reserve_kbytes
>  - vfs_cache_pressure
> +- vfs_cache_pressure_denom
>  - watermark_boost_factor
>  - watermark_scale_factor
>  - zone_reclaim_mode
> @@ -1017,19 +1018,28 @@ vfs_cache_pressure
>  This percentage value controls the tendency of the kernel to reclaim
>  the memory which is used for caching of directory and inode objects.
>  
> -At the default value of vfs_cache_pressure=100 the kernel will attempt to
> -reclaim dentries and inodes at a "fair" rate with respect to pagecache and
> -swapcache reclaim.  Decreasing vfs_cache_pressure causes the kernel to prefer
> -to retain dentry and inode caches. When vfs_cache_pressure=0, the kernel will
> -never reclaim dentries and inodes due to memory pressure and this can easily
> -lead to out-of-memory conditions. Increasing vfs_cache_pressure beyond 100
> -causes the kernel to prefer to reclaim dentries and inodes.
> +At the default value of vfs_cache_pressure=vfs_cache_pressure_denom the kernel
> +will attempt to reclaim dentries and inodes at a "fair" rate with respect to
> +pagecache and swapcache reclaim.  Decreasing vfs_cache_pressure causes the
> +kernel to prefer to retain dentry and inode caches. When vfs_cache_pressure=0,
> +the kernel will never reclaim dentries and inodes due to memory pressure and
> +this can easily lead to out-of-memory conditions. Increasing vfs_cache_pressure
> +beyond vfs_cache_pressure_denom causes the kernel to prefer to reclaim dentries
> +and inodes.
>  
> -Increasing vfs_cache_pressure significantly beyond 100 may have negative
> -performance impact. Reclaim code needs to take various locks to find freeable
> -directory and inode objects. With vfs_cache_pressure=1000, it will look for
> -ten times more freeable objects than there are.
> +Increasing vfs_cache_pressure significantly beyond vfs_cache_pressure_denom may
> +have negative performance impact. Reclaim code needs to take various locks to
> +find freeable directory and inode objects. When vfs_cache_pressure equals
> +(10 * vfs_cache_pressure_denom), it will look for ten times more freeable
> +objects than there are.
>  
> +Note: This setting should always be used together with vfs_cache_pressure_denom.
> +
> +vfs_cache_pressure_denom
> +========================
> +
> +Defaults to 100 (minimum allowed value). Requires corresponding
> +vfs_cache_pressure setting to take effect.
>  
>  watermark_boost_factor
>  ======================
> diff --git a/fs/dcache.c b/fs/dcache.c
> index bd5aa136153a..ed46818c151c 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -74,10 +74,11 @@
>   * arbitrary, since it's serialized on rename_lock
>   */
>  static int sysctl_vfs_cache_pressure __read_mostly = 100;
> +static int sysctl_vfs_cache_pressure_denom __read_mostly = 100;
>  
>  unsigned long vfs_pressure_ratio(unsigned long val)
>  {
> -	return mult_frac(val, sysctl_vfs_cache_pressure, 100);
> +	return mult_frac(val, sysctl_vfs_cache_pressure, sysctl_vfs_cache_pressure_denom);
>  }
>  EXPORT_SYMBOL_GPL(vfs_pressure_ratio);
>  
> @@ -225,6 +226,14 @@ static const struct ctl_table vm_dcache_sysctls[] = {
>  		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= SYSCTL_ZERO,
>  	},
> +	{
> +		.procname	= "vfs_cache_pressure_denom",
> +		.data		= &sysctl_vfs_cache_pressure_denom,
> +		.maxlen		= sizeof(sysctl_vfs_cache_pressure_denom),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ONE_HUNDRED,
> +	},
>  };
>  
>  static int __init init_fs_dcache_sysctls(void)
> -- 
> 2.43.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

