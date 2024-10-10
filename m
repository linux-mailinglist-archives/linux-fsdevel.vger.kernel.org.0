Return-Path: <linux-fsdevel+bounces-31553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFC49985B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 14:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343E2283249
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 12:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923091C3F2E;
	Thu, 10 Oct 2024 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pnq7C+U2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O7Vw1tAU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pnq7C+U2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O7Vw1tAU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2951B1C4600;
	Thu, 10 Oct 2024 12:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728562572; cv=none; b=KQskP+eon0AISrmjwgkby3LKNGnP0VrLgIL/uM8cGAAmWZFT80NkcuosyaX92MI3XRCICSFsfiv+6OcNuLQ/iVTDVV6SWBZy3iJlnAJDMZBuxyd9qJEM72yjDegfmWV55mkpJKBi1RQ7Duo4zZqRJk/tRTGGk0wP8G2pLQ2l2fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728562572; c=relaxed/simple;
	bh=Qp3ydjRT2gvkNjcDCDypVnDazx5BwM1k0YwpB3CzQHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qkl/UmIoMEft7yToLgvJXasjXjRCaMSkVSaqOGRyeCJZpn5Y4OHTRvf8U+YpuONJlS5/GqB4mpVha/5304lKl735trAL0SAYOJMBvlEO0M7RrdLY4Erxsz1gt4wFifVJHLNKCzqLukknMnso3lx0ckSoBXmVv9ZiPWA4osb90os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pnq7C+U2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O7Vw1tAU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pnq7C+U2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O7Vw1tAU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0FE451FE42;
	Thu, 10 Oct 2024 12:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728562568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k6/G+GkLzVV2ezkSkr3FOfmnvzYVldBdtiqpf5dgbuQ=;
	b=pnq7C+U2DMGFd7HlS3GWLkHiLGuyGUeMIkO/yZdTnp6sSneVxgLDopQppGtifpFLp2TOF/
	LYVkkBZlOubEw8JuHTprSBkEd6yEaba8kqPLGpv7DebgJywO5mStlY+O07PIc5LA/w/IpD
	GgiZvYnG7Sc4ZxeVV4/HjfSDMIV9gr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728562568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k6/G+GkLzVV2ezkSkr3FOfmnvzYVldBdtiqpf5dgbuQ=;
	b=O7Vw1tAURpy6GW1fany/SqHfMprP8dpJ4/yMbk/3+wupqlFip5BJXkhdaAiroNZBeoWWxQ
	TEoLp5+C5JW+g0DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pnq7C+U2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=O7Vw1tAU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728562568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k6/G+GkLzVV2ezkSkr3FOfmnvzYVldBdtiqpf5dgbuQ=;
	b=pnq7C+U2DMGFd7HlS3GWLkHiLGuyGUeMIkO/yZdTnp6sSneVxgLDopQppGtifpFLp2TOF/
	LYVkkBZlOubEw8JuHTprSBkEd6yEaba8kqPLGpv7DebgJywO5mStlY+O07PIc5LA/w/IpD
	GgiZvYnG7Sc4ZxeVV4/HjfSDMIV9gr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728562568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k6/G+GkLzVV2ezkSkr3FOfmnvzYVldBdtiqpf5dgbuQ=;
	b=O7Vw1tAURpy6GW1fany/SqHfMprP8dpJ4/yMbk/3+wupqlFip5BJXkhdaAiroNZBeoWWxQ
	TEoLp5+C5JW+g0DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00DD61370C;
	Thu, 10 Oct 2024 12:16:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IRE0AIjFB2cLPQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 10 Oct 2024 12:16:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6731EA08A2; Thu, 10 Oct 2024 14:16:07 +0200 (CEST)
Date: Thu, 10 Oct 2024 14:16:07 +0200
From: Jan Kara <jack@suse.cz>
To: Ye Bin <yebin@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	yebin10@huawei.com, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH 2/3] sysctl: add support for drop_caches for individual
 filesystem
Message-ID: <20241010121607.54ttcmdfmh7ywho7@quack3>
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
X-Rspamd-Queue-Id: 0FE451FE42
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Thu 10-10-24 19:25:42, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> In order to better analyze the issue of file system uninstallation caused
> by kernel module opening files, it is necessary to perform dentry recycling

I don't quite understand the use case you mention here. Can you explain it
a bit more (that being said I've needed dropping caches for a particular sb
myself a few times for debugging purposes so I generally agree it is a
useful feature).

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

I think specifying bdev major & minor number is not a great interface these
days. In particular for filesystems which are not bdev based such as NFS. I
think specifying path to some file/dir in the filesystem is nicer and you
can easily resolve that to sb here as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

