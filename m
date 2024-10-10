Return-Path: <linux-fsdevel+bounces-31574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D990D99883D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 15:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835291F25454
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 13:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91741CB512;
	Thu, 10 Oct 2024 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="AkfI5ZuF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF60E1CB505;
	Thu, 10 Oct 2024 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568139; cv=none; b=qVjUU1RHb/+IazxtjLfmm4h4iMAok99CGDa8OmJ/n7NoK+JWnsY9tCydSEN2dsSxPrHc9OljDLrk21Qss/bfSjOcVvFVX+k0x8P8arkaeTWqJl7TUZhAQ7e9iaBC1Zx6ObDKoxPPZ7V2AZiZ14K7jbS2XomCM/v9/eec+nTa/Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568139; c=relaxed/simple;
	bh=BDfG6D0k6mhhOha80lUom77pONcFISv/QfpRGpLmDLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTffwwox7H3CmWvrrH5k3Xuc83pI2843KDk91FfXG4me320eo726+HwgALw/JJ98v6iMNjpbYN89DB9xG7fmoEIqL0FxdyMJCdqBzuULzeIfgrBW8rFjWDQwjHyfSNLHwHbSRYIbzvzF1SbpwPFuYHr7ATXWXzM2Tqu0ryvDKgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=AkfI5ZuF; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1728568133; bh=BDfG6D0k6mhhOha80lUom77pONcFISv/QfpRGpLmDLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AkfI5ZuFr1kcOFVXosMGDjM89nA+MiJCWYydEfmoSytStXkam7GJkVpylQgO4dUbT
	 V4nmESJbA5Jp31b0Ks8HwCBFLJDIrPD4l99hVfD/wZCFm4/G2NYH1PzWEfCPNfsxQK
	 1CA0s0tZ/vGTR7MjQmaPFq2DQrli+0atq6x0sJNQ=
Date: Thu, 10 Oct 2024 15:48:52 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Ye Bin <yebin@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, yebin10@huawei.com, 
	zhangxiaoxu5@huawei.com
Subject: Re: [PATCH 2/3] sysctl: add support for drop_caches for individual
 filesystem
Message-ID: <11fb0b59-64e1-4f11-8ffb-03537be5fa36@t-8ch.de>
References: <20241010112543.1609648-1-yebin@huaweicloud.com>
 <20241010112543.1609648-3-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010112543.1609648-3-yebin@huaweicloud.com>

On 2024-10-10 19:25:42+0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> In order to better analyze the issue of file system uninstallation caused
> by kernel module opening files, it is necessary to perform dentry recycling
> on a single file system. But now, apart from global dentry recycling, it is
> not supported to do dentry recycling on a single file system separately.
> This feature has usage scenarios in problem localization scenarios.At the
> same time, it also provides users with a slightly fine-grained
> pagecache/entry recycling mechanism.
> This patch supports the recycling of pagecache/entry for individual file
> systems.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/drop_caches.c   | 43 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mm.h |  2 ++
>  kernel/sysctl.c    |  9 +++++++++
>  3 files changed, 54 insertions(+)
> 
> diff --git a/fs/drop_caches.c b/fs/drop_caches.c
> index d45ef541d848..99d412cf3e52 100644
> --- a/fs/drop_caches.c
> +++ b/fs/drop_caches.c
> @@ -77,3 +77,46 @@ int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
>  	}
>  	return 0;
>  }
> +
> +int drop_fs_caches_sysctl_handler(const struct ctl_table *table, int write,
> +				  void *buffer, size_t *length, loff_t *ppos)
> +{
> +	unsigned int major, minor;
> +	unsigned int ctl;
> +	struct super_block *sb;
> +	static int stfu;
> +
> +	if (!write)
> +		return 0;
> +
> +	if (sscanf(buffer, "%u:%u:%u", &major, &minor, &ctl) != 3)
> +		return -EINVAL;
> +
> +	if (ctl < *((int *)table->extra1) || ctl > *((int *)table->extra2))
> +		return -EINVAL;
> +
> +	sb = user_get_super(MKDEV(major, minor), false);
> +	if (!sb)
> +		return -EINVAL;
> +
> +	if (ctl & 1) {

BIT(0)

> +		lru_add_drain_all();
> +		drop_pagecache_sb(sb, NULL);
> +		count_vm_event(DROP_PAGECACHE);
> +	}
> +
> +	if (ctl & 2) {
> +		shrink_dcache_sb(sb);
> +		shrink_icache_sb(sb);
> +		count_vm_event(DROP_SLAB);
> +	}
> +
> +	drop_super(sb);
> +
> +	if (!stfu)
> +		pr_info("%s (%d): drop_fs_caches: %u:%u:%d\n", current->comm,
> +			task_pid_nr(current), major, minor, ctl);
> +	stfu |= ctl & 4;

This looks very weird. I guess it's already in the original
drop_caches_sysctl_handler().

> +
> +	return 0;
> +}
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 344541f8cba0..43079478296f 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3788,6 +3788,8 @@ extern bool process_shares_mm(struct task_struct *p, struct mm_struct *mm);
>  extern int sysctl_drop_caches;
>  int drop_caches_sysctl_handler(const struct ctl_table *, int, void *, size_t *,
>  		loff_t *);
> +int drop_fs_caches_sysctl_handler(const struct ctl_table *table, int write,
> +				  void *buffer, size_t *length, loff_t *ppos);
>  #endif
>  
>  void drop_slab(void);
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 79e6cb1d5c48..d434cbe10e47 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2101,6 +2101,15 @@ static struct ctl_table vm_table[] = {

Sooner or later this table should move out of kernel/sysctl.c and into a
subsystem-specific file.
This also means the handler doesn't need to be exported.

>  		.extra1		= SYSCTL_ONE,
>  		.extra2		= SYSCTL_FOUR,
>  	},
> +	{
> +		.procname	= "drop_fs_caches",
> +		.data		= NULL,

NULL is already the default.

> +		.maxlen		= 256,

The maxlen field refers to the data field.
As there is no data, there should be no maxlen.

> +		.mode		= 0200,
> +		.proc_handler	= drop_fs_caches_sysctl_handler,
> +		.extra1         = SYSCTL_ONE,
> +		.extra2         = SYSCTL_FOUR,

These extras are meant as parameters for generic handlers.
Inlining the limits into your hander makes it much clearer.

> +	},
>  	{
>  		.procname	= "page_lock_unfairness",
>  		.data		= &sysctl_page_lock_unfairness,
> -- 
> 2.31.1
> 

