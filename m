Return-Path: <linux-fsdevel+bounces-8193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E206A830C78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 19:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52D0E1F224EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 18:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3349522EFF;
	Wed, 17 Jan 2024 18:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FOwG2ksJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5eV0s4ch";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FOwG2ksJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5eV0s4ch"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CDF22EE0
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 18:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705514918; cv=none; b=d8pt2ggZW/KNLMvU9mZLdcn59YgA14hpcjvFvmmN+XcaVEXnDNdHYmy/rDvIdJjd3wgg/tnRZEXXeaJKWdil+9Z0TaFmLdbhexGPq5JGzkv2JkMc/v9mtssmsycyNfh2aZj+hSyH9txmPbmgGp+rlagZn0LJwZ4TX4N4/fFpts8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705514918; c=relaxed/simple;
	bh=7vBSBiYPXaLyieXcbSQVPZDsoq9+ExmUOrVOq71geiw=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Level:X-Spam-Score:
	 X-Spamd-Result:X-Spam-Flag; b=JeBXz43P9rOam/l99pGyqJo3FOCprcoYhji+ML6E5MAdc2nHHJtAdCgtDKaxfAVsr3YJ5KJYBlp7k13E3pRB1cb3QOMRdgf522mc7t1fhhEJ2/I8nrMhPkM3+1SA0cL9iT8XoO44MKhRQ9S2xGqK2ZIzCSx0Wsbry2bRgKX0MTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FOwG2ksJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5eV0s4ch; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FOwG2ksJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5eV0s4ch; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 196B11FCE4;
	Wed, 17 Jan 2024 18:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705514914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TT+pqpg96pk8TiWrbogxRy9D0lPWLP4PmGb7VfwpuN8=;
	b=FOwG2ksJodyY3bWl6nsKvtjjO6OCoU3ESjyyEfi1IBo3aksj7mgHsAGuH61gVo7OuLstru
	No6oWqbt2OvKFl2zH9P4JjxscpfusJ95A33XuUuJL8z/3+Zbda6e+2EUjBKwpoxf5taQ0D
	bLvSCqA59F/po3uAIUDs6shPOXmPXuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705514914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TT+pqpg96pk8TiWrbogxRy9D0lPWLP4PmGb7VfwpuN8=;
	b=5eV0s4chA+1mp0AmXm9gQa+xkgyxlkuwOKPImtzFonqBoXFq28LkHuXYc1H9EWM3Qb59s2
	gzUY/8UPItUsAiDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705514914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TT+pqpg96pk8TiWrbogxRy9D0lPWLP4PmGb7VfwpuN8=;
	b=FOwG2ksJodyY3bWl6nsKvtjjO6OCoU3ESjyyEfi1IBo3aksj7mgHsAGuH61gVo7OuLstru
	No6oWqbt2OvKFl2zH9P4JjxscpfusJ95A33XuUuJL8z/3+Zbda6e+2EUjBKwpoxf5taQ0D
	bLvSCqA59F/po3uAIUDs6shPOXmPXuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705514914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TT+pqpg96pk8TiWrbogxRy9D0lPWLP4PmGb7VfwpuN8=;
	b=5eV0s4chA+1mp0AmXm9gQa+xkgyxlkuwOKPImtzFonqBoXFq28LkHuXYc1H9EWM3Qb59s2
	gzUY/8UPItUsAiDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF3BA13751;
	Wed, 17 Jan 2024 18:08:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VWVgOqEXqGXVSwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Jan 2024 18:08:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7C685A0803; Wed, 17 Jan 2024 19:08:33 +0100 (CET)
Date: Wed, 17 Jan 2024 19:08:33 +0100
From: Jan Kara <jack@suse.cz>
To: cem@kernel.org
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] Add quotactl_fd() support
Message-ID: <20240117180833.y5ocl526tumw7nkj@quack3>
References: <20240109134651.869887-1-cem@kernel.org>
 <20240109134651.869887-3-cem@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109134651.869887-3-cem@kernel.org>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Tue 09-01-24 14:46:04, cem@kernel.org wrote:
> From: Carlos Maiolino <cem@kernel.org>
> 
> To be able to set quotas on filesystems without a backing device, quota tools
> should be able to use quotactl_fd().
> To achieve that, add a new helper, do_quotactl(), to select between quotactl()
> and quotactl_fd().
> 
> This shouldn't change the semantics of current code. quotactl_fd() will be
> called if and only if the handlers contain an empty device, and a valid
> mountpoint.
> All current calls containing a value device should be still handled by quotactl().
> The same is true for calls passing a NULL device on purpose, aiming to sync
> active quotas.
> 
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>

quota-tools work on mounted filesystems so ideally we could switch all the
places to use quotactl_fd() (if the kernel supports it - we probably have
to keep the fallback for some time yet). But for now what you do is fine
and we can clean that up later.

								Honza

> ---
>  Makefile.am       |  1 +
>  quotacheck.c      | 12 +++++------
>  quotaio.c         |  4 ++--
>  quotaio_generic.c | 12 +++++------
>  quotaio_meta.c    |  4 ++--
>  quotaio_v1.c      | 10 ++++-----
>  quotaio_v2.c      | 12 +++++------
>  quotaio_xfs.c     | 21 ++++++++++--------
>  quotaon.c         |  8 +++----
>  quotaon_xfs.c     |  9 ++++----
>  quotastats.c      |  4 ++--
>  quotasync.c       |  2 +-
>  quotasys.c        | 55 ++++++++++++++++++++++++++++++++++++-----------
>  quotasys.h        |  3 +++
>  14 files changed, 98 insertions(+), 59 deletions(-)
> 
> diff --git a/Makefile.am b/Makefile.am
> index 372eafb..13a0f06 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -207,6 +207,7 @@ quotastats_SOURCES = \
>  	pot.h
>  
>  quotastats_LDADD = \
> +	libquota.a \
>  	$(INTLLIBS)
>  
>  xqmstats_SOURCES = \
> diff --git a/quotacheck.c b/quotacheck.c
> index bd62d9a..e2c3bbd 100644
> --- a/quotacheck.c
> +++ b/quotacheck.c
> @@ -648,8 +648,8 @@ Please turn quotas off or use -f to force checking.\n"),
>  				    type2name(type), mnt->me_dir);
>  		}
>  		/* At least sync quotas so damage will be smaller */
> -		if (quotactl(QCMD((kernel_iface == IFACE_GENERIC)? Q_SYNC : Q_6_5_SYNC, type),
> -			     mnt->me_devname, 0, NULL) < 0)
> +		if (do_quotactl(QCMD((kernel_iface == IFACE_GENERIC)? Q_SYNC : Q_6_5_SYNC, type),
> +			     mnt->me_devname, mnt->me_dir, 0, NULL) < 0)
>  			die(4, _("Error while syncing quotas on %s: %s\n"), mnt->me_devname, strerror(errno));
>  	}
>  
> @@ -848,8 +848,8 @@ static int dump_to_file(struct mount_entry *mnt, int type)
>  		if (get_qf_name(mnt, type, cfmt, NF_FORMAT, &filename) < 0)
>  			errstr(_("Cannot find checked quota file for %ss on %s!\n"), _(type2name(type)), mnt->me_devname);
>  		else {
> -			if (quotactl(QCMD((kernel_iface == IFACE_GENERIC) ? Q_QUOTAOFF : Q_6_5_QUOTAOFF, type),
> -				     mnt->me_devname, 0, NULL) < 0)
> +			if (do_quotactl(QCMD((kernel_iface == IFACE_GENERIC) ? Q_QUOTAOFF : Q_6_5_QUOTAOFF, type),
> +				     mnt->me_devname, mnt->me_dir, 0, NULL) < 0)
>  				errstr(_("Cannot turn %s quotas off on %s: %s\nKernel won't know about changes quotacheck did.\n"),
>  					_(type2name(type)), mnt->me_devname, strerror(errno));
>  			else {
> @@ -859,9 +859,9 @@ static int dump_to_file(struct mount_entry *mnt, int type)
>  				rename_files(mnt, type);
>  
>  				if (kernel_iface == IFACE_GENERIC)
> -					ret = quotactl(QCMD(Q_QUOTAON, type), mnt->me_devname, util2kernfmt(cfmt), filename);
> +					ret = do_quotactl(QCMD(Q_QUOTAON, type), mnt->me_devname, mnt->me_dir, util2kernfmt(cfmt), filename);
>  				else
> -					ret = quotactl(QCMD(Q_6_5_QUOTAON, type), mnt->me_devname, 0, filename);
> +					ret = do_quotactl(QCMD(Q_6_5_QUOTAON, type), mnt->me_devname, mnt->me_dir, 0, filename);
>  				if (ret < 0)
>  					errstr(_("Cannot turn %s quotas on on %s: %s\nKernel won't know about changes quotacheck did.\n"),
>  						_(type2name(type)), mnt->me_devname, strerror(errno));
> diff --git a/quotaio.c b/quotaio.c
> index 94ae458..9bebb5e 100644
> --- a/quotaio.c
> +++ b/quotaio.c
> @@ -140,8 +140,8 @@ struct quota_handle *init_io(struct mount_entry *mnt, int type, int fmt, int fla
>  		if (QIO_ENABLED(h)) {	/* Kernel uses same file? */
>  			unsigned int cmd =
>  				(kernel_iface == IFACE_GENERIC) ? Q_SYNC : Q_6_5_SYNC;
> -			if (quotactl(QCMD(cmd, h->qh_type), h->qh_quotadev,
> -				     0, NULL) < 0) {
> +			if (do_quotactl(QCMD(cmd, h->qh_type), h->qh_quotadev,
> +				     h->qh_dir, 0,  NULL) < 0) {
>  				die(4, _("Cannot sync quotas on device %s: %s\n"),
>  				    h->qh_quotadev, strerror(errno));
>  			}
> diff --git a/quotaio_generic.c b/quotaio_generic.c
> index 5b23955..3c95872 100644
> --- a/quotaio_generic.c
> +++ b/quotaio_generic.c
> @@ -50,7 +50,7 @@ int vfs_get_info(struct quota_handle *h)
>  {
>  	struct if_dqinfo kinfo;
>  
> -	if (quotactl(QCMD(Q_GETINFO, h->qh_type), h->qh_quotadev, 0, (void *)&kinfo) < 0) {
> +	if (do_quotactl(QCMD(Q_GETINFO, h->qh_type), h->qh_quotadev, h->qh_dir, 0, (void *)&kinfo) < 0) {
>  		errstr(_("Cannot get info for %s quota file from kernel on %s: %s\n"), type2name(h->qh_type), h->qh_quotadev, strerror(errno));
>  		return -1;
>  	}
> @@ -68,7 +68,7 @@ int vfs_set_info(struct quota_handle *h, int flags)
>  	kinfo.dqi_igrace = h->qh_info.dqi_igrace;
>  	kinfo.dqi_valid = flags;
>  
> -	if (quotactl(QCMD(Q_SETINFO, h->qh_type), h->qh_quotadev, 0, (void *)&kinfo) < 0) {
> +	if (do_quotactl(QCMD(Q_SETINFO, h->qh_type), h->qh_quotadev, h->qh_dir, 0, (void *)&kinfo) < 0) {
>  		errstr(_("Cannot set info for %s quota file from kernel on %s: %s\n"), type2name(h->qh_type), h->qh_quotadev, strerror(errno));
>  		return -1;
>  	}
> @@ -80,7 +80,7 @@ int vfs_get_dquot(struct dquot *dquot)
>  {
>  	struct if_dqblk kdqblk;
>  
> -	if (quotactl(QCMD(Q_GETQUOTA, dquot->dq_h->qh_type), dquot->dq_h->qh_quotadev, dquot->dq_id, (void *)&kdqblk) < 0) {
> +	if (do_quotactl(QCMD(Q_GETQUOTA, dquot->dq_h->qh_type), dquot->dq_h->qh_quotadev, dquot->dq_h->qh_dir, dquot->dq_id, (void *)&kdqblk) < 0) {
>  		errstr(_("Cannot get quota for %s %d from kernel on %s: %s\n"), type2name(dquot->dq_h->qh_type), dquot->dq_id, dquot->dq_h->qh_quotadev, strerror(errno));
>  		return -1;
>  	}
> @@ -95,7 +95,7 @@ int vfs_set_dquot(struct dquot *dquot, int flags)
>  
>  	generic_util2kerndqblk(&kdqblk, &dquot->dq_dqb);
>  	kdqblk.dqb_valid = flags;
> -	if (quotactl(QCMD(Q_SETQUOTA, dquot->dq_h->qh_type), dquot->dq_h->qh_quotadev, dquot->dq_id, (void *)&kdqblk) < 0) {
> +	if (do_quotactl(QCMD(Q_SETQUOTA, dquot->dq_h->qh_type), dquot->dq_h->qh_quotadev, dquot->dq_h->qh_dir, dquot->dq_id, (void *)&kdqblk) < 0) {
>  		errstr(_("Cannot set quota for %s %d from kernel on %s: %s\n"), type2name(dquot->dq_h->qh_type), dquot->dq_id, dquot->dq_h->qh_quotadev, strerror(errno));
>  		return -1;
>  	}
> @@ -188,8 +188,8 @@ int vfs_scan_dquots(struct quota_handle *h,
>  
>  	dquot->dq_h = h;
>  	while (1) {
> -		ret = quotactl(QCMD(Q_GETNEXTQUOTA, h->qh_type),
> -			       h->qh_quotadev, id, (void *)&kdqblk);
> +		ret = do_quotactl(QCMD(Q_GETNEXTQUOTA, h->qh_type),
> +			       h->qh_quotadev, h->qh_dir, id, (void *)&kdqblk);
>  		if (ret < 0)
>  			break;
>  
> diff --git a/quotaio_meta.c b/quotaio_meta.c
> index ad6ff7a..51ebbcf 100644
> --- a/quotaio_meta.c
> +++ b/quotaio_meta.c
> @@ -59,8 +59,8 @@ static int meta_scan_dquots(struct quota_handle *h, int (*process_dquot)(struct
>  	struct if_nextdqblk kdqblk;
>  	int ret;
>  
> -	ret = quotactl(QCMD(Q_GETNEXTQUOTA, h->qh_type), h->qh_quotadev, 0,
> -		       (void *)&kdqblk);
> +	ret = do_quotactl(QCMD(Q_GETNEXTQUOTA, h->qh_type), h->qh_quotadev,
> +			  h->qh_dir, 0, (void *)&kdqblk);
>  	/*
>  	 * Fall back to scanning using passwd if Q_GETNEXTQUOTA is not
>  	 * supported
> diff --git a/quotaio_v1.c b/quotaio_v1.c
> index 6a6dc78..187a5a5 100644
> --- a/quotaio_v1.c
> +++ b/quotaio_v1.c
> @@ -118,7 +118,7 @@ static int v1_init_io(struct quota_handle *h)
>  		else {
>  			struct v1_kern_dqblk kdqblk;
>  
> -			if (quotactl(QCMD(Q_V1_GETQUOTA, h->qh_type), h->qh_quotadev, 0, (void *)&kdqblk) < 0) {
> +			if (do_quotactl(QCMD(Q_V1_GETQUOTA, h->qh_type), h->qh_quotadev, h->qh_dir, 0, (void *)&kdqblk) < 0) {
>  				if (errno == EPERM) {	/* We have no permission to get this information? */
>  					h->qh_info.dqi_bgrace = h->qh_info.dqi_igrace = 0;	/* It hopefully won't be needed */
>  				}
> @@ -193,11 +193,11 @@ static int v1_write_info(struct quota_handle *h)
>  		else {
>  			struct v1_kern_dqblk kdqblk;
>  
> -			if (quotactl(QCMD(Q_V1_GETQUOTA, h->qh_type), h->qh_quotadev, 0, (void *)&kdqblk) < 0)
> +			if (do_quotactl(QCMD(Q_V1_GETQUOTA, h->qh_type), h->qh_quotadev, h->qh_dir, 0, (void *)&kdqblk) < 0)
>  				return -1;
>  			kdqblk.dqb_btime = h->qh_info.dqi_bgrace;
>  			kdqblk.dqb_itime = h->qh_info.dqi_igrace;
> -			if (quotactl(QCMD(Q_V1_SETQUOTA, h->qh_type), h->qh_quotadev, 0, (void *)&kdqblk) < 0)
> +			if (do_quotactl(QCMD(Q_V1_SETQUOTA, h->qh_type), h->qh_quotadev, h->qh_dir, 0, (void *)&kdqblk) < 0)
>  				return -1;
>  		}
>  	}
> @@ -237,7 +237,7 @@ static struct dquot *v1_read_dquot(struct quota_handle *h, qid_t id)
>  		else {
>  			struct v1_kern_dqblk kdqblk;
>  
> -			if (quotactl(QCMD(Q_V1_GETQUOTA, h->qh_type), h->qh_quotadev, id, (void *)&kdqblk) < 0) {
> +			if (do_quotactl(QCMD(Q_V1_GETQUOTA, h->qh_type), h->qh_quotadev, h->qh_dir, id, (void *)&kdqblk) < 0) {
>  				free(dquot);
>  				return NULL;
>  			}
> @@ -299,7 +299,7 @@ static int v1_commit_dquot(struct dquot *dquot, int flags)
>  			else
>  				cmd = Q_V1_SETQUOTA;
>  			v1_util2kerndqblk(&kdqblk, &dquot->dq_dqb);
> -			if (quotactl(QCMD(cmd, h->qh_type), h->qh_quotadev, dquot->dq_id,
> +			if (do_quotactl(QCMD(cmd, h->qh_type), h->qh_quotadev, h->qh_dir, dquot->dq_id,
>  			     (void *)&kdqblk) < 0)
>  				return -1;
>  		}
> diff --git a/quotaio_v2.c b/quotaio_v2.c
> index 56a549f..b0fe7bf 100644
> --- a/quotaio_v2.c
> +++ b/quotaio_v2.c
> @@ -275,7 +275,7 @@ static int v2_init_io(struct quota_handle *h)
>  		else {
>  			struct v2_kern_dqinfo kdqinfo;
>  
> -			if (quotactl(QCMD(Q_V2_GETINFO, h->qh_type), h->qh_quotadev, 0, (void *)&kdqinfo) < 0) {
> +			if (do_quotactl(QCMD(Q_V2_GETINFO, h->qh_type), h->qh_quotadev, h->qh_dir, 0, (void *)&kdqinfo) < 0) {
>  				/* Temporary check just before fix gets to kernel */
>  				if (errno == EPERM)	/* Don't have permission to get information? */
>  					return 0;
> @@ -403,8 +403,8 @@ static int v2_write_info(struct quota_handle *h)
>  			kdqinfo.dqi_blocks = h->qh_info.u.v2_mdqi.dqi_qtree.dqi_blocks;
>  			kdqinfo.dqi_free_blk = h->qh_info.u.v2_mdqi.dqi_qtree.dqi_free_blk;
>  			kdqinfo.dqi_free_entry = h->qh_info.u.v2_mdqi.dqi_qtree.dqi_free_entry;
> -			if (quotactl(QCMD(Q_V2_SETGRACE, h->qh_type), h->qh_quotadev, 0, (void *)&kdqinfo) < 0 ||
> -			    quotactl(QCMD(Q_V2_SETFLAGS, h->qh_type), h->qh_quotadev, 0, (void *)&kdqinfo) < 0)
> +			if (do_quotactl(QCMD(Q_V2_SETGRACE, h->qh_type), h->qh_quotadev, h->qh_dir, 0, (void *)&kdqinfo) < 0 ||
> +			    do_quotactl(QCMD(Q_V2_SETFLAGS, h->qh_type), h->qh_quotadev, h->qh_dir, 0, (void *)&kdqinfo) < 0)
>  					return -1;
>  		}
>  	}
> @@ -441,7 +441,7 @@ static struct dquot *v2_read_dquot(struct quota_handle *h, qid_t id)
>  		else {
>  			struct v2_kern_dqblk kdqblk;
>  
> -			if (quotactl(QCMD(Q_V2_GETQUOTA, h->qh_type), h->qh_quotadev, id, (void *)&kdqblk) < 0) {
> +			if (do_quotactl(QCMD(Q_V2_GETQUOTA, h->qh_type), h->qh_quotadev, h->qh_dir, id, (void *)&kdqblk) < 0) {
>  				free(dquot);
>  				return NULL;
>  			}
> @@ -485,8 +485,8 @@ static int v2_commit_dquot(struct dquot *dquot, int flags)
>  			else
>  				cmd = Q_V2_SETQUOTA;
>  			v2_util2kerndqblk(&kdqblk, &dquot->dq_dqb);
> -			if (quotactl(QCMD(cmd, dquot->dq_h->qh_type), dquot->dq_h->qh_quotadev,
> -			     dquot->dq_id, (void *)&kdqblk) < 0)
> +			if (do_quotactl(QCMD(cmd, dquot->dq_h->qh_type), dquot->dq_h->qh_quotadev,
> +			     dquot->dq_h->qh_dir, dquot->dq_id, (void *)&kdqblk) < 0)
>  				return -1;
>  		}
>  		return 0;
> diff --git a/quotaio_xfs.c b/quotaio_xfs.c
> index 5abb2c2..0bf6f34 100644
> --- a/quotaio_xfs.c
> +++ b/quotaio_xfs.c
> @@ -128,7 +128,7 @@ static int xfs_init_io(struct quota_handle *h)
>  
>  	qcmd = QCMD(Q_XFS_GETQSTAT, h->qh_type);
>  	memset(&info, 0, sizeof(struct xfs_mem_dqinfo));
> -	if (quotactl(qcmd, h->qh_quotadev, 0, (void *)&info) < 0)
> +	if (do_quotactl(qcmd, h->qh_quotadev, h->qh_dir, 0, (void *)&info) < 0)
>  		return -1;
>  	h->qh_info.dqi_bgrace = info.qs_btimelimit;
>  	h->qh_info.dqi_igrace = info.qs_itimelimit;
> @@ -153,7 +153,7 @@ static int xfs_write_info(struct quota_handle *h)
>  	xdqblk.d_itimer = h->qh_info.dqi_igrace;
>  	xdqblk.d_fieldmask |= FS_DQ_TIMER_MASK;
>  	qcmd = QCMD(Q_XFS_SETQLIM, h->qh_type);
> -	if (quotactl(qcmd, h->qh_quotadev, 0, (void *)&xdqblk) < 0)
> +	if (do_quotactl(qcmd, h->qh_quotadev, h->qh_dir, 0, (void *)&xdqblk) < 0)
>  		return -1;
>  	return 0;
>  }
> @@ -174,7 +174,8 @@ static struct dquot *xfs_read_dquot(struct quota_handle *h, qid_t id)
>  		return dquot;
>  
>  	qcmd = QCMD(Q_XFS_GETQUOTA, h->qh_type);
> -	if (quotactl(qcmd, h->qh_quotadev, id, (void *)&xdqblk) < 0) {
> +	if (do_quotactl(qcmd, h->qh_quotadev, h->qh_dir,
> +			id, (void *)&xdqblk) < 0) {
>  		;
>  	}
>  	else {
> @@ -219,7 +220,7 @@ static int xfs_commit_dquot(struct dquot *dquot, int flags)
>  	}
>  
>  	qcmd = QCMD(Q_XFS_SETQLIM, h->qh_type);
> -	if (quotactl(qcmd, h->qh_quotadev, id, (void *)&xdqblk) < 0)
> +	if (do_quotactl(qcmd, h->qh_quotadev, h->qh_dir, id, (void *)&xdqblk) < 0)
>  		return -1;
>  	return 0;
>  }
> @@ -234,7 +235,9 @@ static int xfs_get_dquot(struct dquot *dq)
>  	int ret;
>  
>  	memset(&d, 0, sizeof(d));
> -	ret = quotactl(qcmd, dq->dq_h->qh_quotadev, dq->dq_id, (void *)&d);
> +	ret = do_quotactl(qcmd, dq->dq_h->qh_quotadev, dq->dq_h->qh_dir,
> +			  dq->dq_id, (void *)&d);
> +
>  	if (ret < 0) {
>  		if (errno == ENOENT)
>  			return 0;
> @@ -254,8 +257,8 @@ static int xfs_kernel_scan_dquots(struct quota_handle *h,
>  
>  	dquot->dq_h = h;
>  	while (1) {
> -		ret = quotactl(QCMD(Q_XGETNEXTQUOTA, h->qh_type),
> -			       h->qh_quotadev, id, (void *)&xdqblk);
> +		ret = do_quotactl(QCMD(Q_XGETNEXTQUOTA, h->qh_type),
> +			       h->qh_quotadev, h->qh_dir, id, (void *)&xdqblk);
>  		if (ret < 0)
>  			break;
>  
> @@ -286,8 +289,8 @@ static int xfs_scan_dquots(struct quota_handle *h, int (*process_dquot) (struct
>  	int ret;
>  	struct xfs_kern_dqblk xdqblk;
>  
> -	ret = quotactl(QCMD(Q_XGETNEXTQUOTA, h->qh_type), h->qh_quotadev, 0,
> -		       (void *)&xdqblk);
> +	ret = do_quotactl(QCMD(Q_XGETNEXTQUOTA, h->qh_type), h->qh_quotadev,
> +			  h->qh_dir, 0, (void *)&xdqblk);
>  	if (ret < 0 && (errno == ENOSYS || errno == EINVAL)) {
>  		if (!XFS_USRQUOTA(h) && !XFS_GRPQUOTA(h) && !XFS_PRJQUOTA(h))
>  			return 0;
> diff --git a/quotaon.c b/quotaon.c
> index 125b934..351c851 100644
> --- a/quotaon.c
> +++ b/quotaon.c
> @@ -152,13 +152,13 @@ static int quotarsquashonoff(const char *quotadev, int type, int flags)
>  
>  		info.dqi_flags = V1_DQF_RSQUASH;
>  		info.dqi_valid = IIF_FLAGS;
> -		ret = quotactl(qcmd, quotadev, 0, (void *)&info);
> +		ret = do_quotactl(qcmd, quotadev, NULL, 0, (void *)&info);
>  	}
>  	else {
>  		int mode = (flags & STATEFLAG_OFF) ? 0 : 1;
>  		int qcmd = QCMD(Q_V1_RSQUASH, type);
>  
> -		ret = quotactl(qcmd, quotadev, 0, (void *)&mode);
> +		ret = do_quotactl(qcmd, quotadev, NULL, 0, (void *)&mode);
>  	}
>  	if (ret < 0) {
>  		errstr(_("set root_squash on %s: %s\n"), quotadev, strerror(errno));
> @@ -184,7 +184,7 @@ static int quotaonoff(const char *quotadev, const char *quotadir, char *quotafil
>  			qcmd = QCMD(Q_QUOTAOFF, type);
>  		else
>  			qcmd = QCMD(Q_6_5_QUOTAOFF, type);
> -		if (quotactl(qcmd, quotadev, 0, NULL) < 0) {
> +		if (do_quotactl(qcmd, quotadev, quotadir, 0, NULL) < 0) {
>  			errstr(_("quotactl on %s [%s]: %s\n"), quotadev, quotadir, strerror(errno));
>  			return 1;
>  		}
> @@ -199,7 +199,7 @@ static int quotaonoff(const char *quotadev, const char *quotadir, char *quotafil
>  		qcmd = QCMD(Q_6_5_QUOTAON, type);
>  		kqf = 0;
>  	}
> -	if (quotactl(qcmd, quotadev, kqf, (void *)quotafile) < 0) {
> +	if (do_quotactl(qcmd, quotadev, quotadir, kqf, (void *)quotafile) < 0) {
>  		if (errno == ENOENT)
>  			errstr(_("cannot find %s on %s [%s]\n"), quotafile, quotadev, quotadir);
>  		else
> diff --git a/quotaon_xfs.c b/quotaon_xfs.c
> index d137240..dda3023 100644
> --- a/quotaon_xfs.c
> +++ b/quotaon_xfs.c
> @@ -32,7 +32,7 @@ static int xfs_state_check(int qcmd, int type, int flags, const char *dev, int r
>  	if (flags & STATEFLAG_ALL)
>  		return 0;	/* noop */
>  
> -	if (quotactl(QCMD(Q_XFS_GETQSTAT, type), dev, 0, (void *)&info) < 0) {
> +	if (do_quotactl(QCMD(Q_XFS_GETQSTAT, type), dev, NULL, 0, (void *)&info) < 0) {
>  		errstr(_("quotactl() on %s: %s\n"), dev, strerror(errno));
>  		return -1;
>  	}
> @@ -156,7 +156,7 @@ static int xfs_onoff(const char *dev, int type, int flags, int roothack, int xop
>  	if (check != 1)
>  		return (check < 0);
>  
> -	if (quotactl(QCMD(qcmd, type), dev, 0, (void *)&xopts) < 0) {
> +	if (do_quotactl(QCMD(qcmd, type), dev, NULL, 0, (void *)&xopts) < 0) {
>  		errstr(_("quotactl on %s: %s\n"), dev, strerror(errno));
>  		return 1;
>  	}
> @@ -176,7 +176,7 @@ static int xfs_delete(const char *dev, int type, int flags, int roothack, int xo
>  	if (check != 1)
>  		return (check < 0);
>  
> -	if (quotactl(QCMD(qcmd, type), dev, 0, (void *)&xopts) < 0) {
> +	if (do_quotactl(QCMD(qcmd, type), dev, NULL, 0, (void *)&xopts) < 0) {
>  		errstr(_("Failed to delete quota: %s\n"),
>  			strerror(errno));
>  		return 1;
> @@ -208,7 +208,8 @@ int xfs_newstate(struct mount_entry *mnt, int type, char *xarg, int flags)
>  		struct xfs_mem_dqinfo info;
>  		u_int16_t sbflags = 0;
>  
> -		if (!quotactl(QCMD(Q_XFS_GETQSTAT, type), mnt->me_devname, 0, (void *)&info))
> +		if (!quotactl(QCMD(Q_XFS_GETQSTAT, type), mnt->me_devname,
> +			      mnt->me_dir, 0, (void *)&info))
>  			sbflags = (info.qs_flags & 0xff00) >> 8;
>  
>  		if ((type == USRQUOTA && (sbflags & XFS_QUOTA_UDQ_ACCT)) &&
> diff --git a/quotastats.c b/quotastats.c
> index a059812..ee23afd 100644
> --- a/quotastats.c
> +++ b/quotastats.c
> @@ -72,7 +72,7 @@ static int get_stats(struct util_dqstats *dqstats)
>  		dqstats->free_dquots = get_proc_num("free_dquots");
>  		dqstats->syncs = get_proc_num("syncs");
>  	}
> -	else if (quotactl(QCMD(Q_V1_GETSTATS, 0), NULL, 0, (caddr_t)&old_dqstats) >= 0) {
> +	else if (do_quotactl(QCMD(Q_V1_GETSTATS, 0), NULL, NULL, 0, (caddr_t)&old_dqstats) >= 0) {
>  		/* Structures are currently the same */
>  		memcpy(dqstats, &old_dqstats, sizeof(old_dqstats));
>  		dqstats->version = 0;
> @@ -83,7 +83,7 @@ static int get_stats(struct util_dqstats *dqstats)
>  			errstr(_("Error while getting quota statistics from kernel: %s\n"), strerror(errno));
>  			goto out;
>  		}
> -		if (quotactl(QCMD(Q_V2_GETSTATS, 0), NULL, 0, (caddr_t)&v0_dqstats) < 0) {
> +		if (do_quotactl(QCMD(Q_V2_GETSTATS, 0), NULL, NULL, 0, (caddr_t)&v0_dqstats) < 0) {
>  			errstr(_("Error while getting old quota statistics from kernel: %s\n"), strerror(errno));
>  			goto out;
>  		}
> diff --git a/quotasync.c b/quotasync.c
> index 80f7e9e..cad2a20 100644
> --- a/quotasync.c
> +++ b/quotasync.c
> @@ -100,7 +100,7 @@ static int sync_one(int type, char *dev)
>  {
>  	int qcmd = QCMD(Q_SYNC, type);
>  
> -	return quotactl(qcmd, dev, 0, NULL);
> +	return do_quotactl(qcmd, dev, NULL, 0, NULL);
>  }
>  
>  static int syncquotas(int type)
> diff --git a/quotasys.c b/quotasys.c
> index 9af9932..903816b 100644
> --- a/quotasys.c
> +++ b/quotasys.c
> @@ -25,6 +25,7 @@
>  #include <sys/vfs.h>
>  #include <stdint.h>
>  #include <sys/utsname.h>
> +#include <sys/syscall.h>
>  
>  #include "pot.h"
>  #include "bylabel.h"
> @@ -670,6 +671,36 @@ const char *str2number(const char *string, qsize_t *inodes)
>  	return NULL;
>  }
>  
> +/*
> + * Wrappers for quotactl syscalls
> + */
> +#ifdef SYS_quotactl_fd
> +int do_quotactl(int cmd, const char *dev, const char *mnt, int id, caddr_t addr)
> +{
> +	int ret = -EINVAL;
> +
> +	if (mnt && !dev) {
> +		int fd = open(mnt, O_DIRECTORY | O_PATH);
> +
> +		if (fd < 0) {
> +			errstr(_("Unable to get a filedescriptor from mountpoint: %s\n"), mnt);
> +			return fd;
> +		}
> +
> +		ret = syscall(SYS_quotactl_fd, fd, cmd, id, addr);
> +		close(fd);
> +		return ret;
> +	}
> +
> +	return quotactl(cmd, dev, id, addr);
> +}
> +#else
> +int do_quotactl(int cmd, const char *dev, const char *mnt, int id, caddr_t addr)
> +{
> +	return quotactl(cmd, dev, id, addr);
> +}
> +#endif
> +
>  /*
>   *	Wrappers for mount options processing functions
>   */
> @@ -685,7 +716,7 @@ static int hasxfsquota(const char *dev, struct mntent *mnt, int type, int flags)
>  		return QF_XFS;
>  
>  	memset(&info, 0, sizeof(struct xfs_mem_dqinfo));
> -	if (!quotactl(QCMD(Q_XFS_GETQSTAT, type), dev, 0, (void *)&info)) {
> +	if (!do_quotactl(QCMD(Q_XFS_GETQSTAT, type), dev, mnt->mnt_dir, 0, (void *)&info)) {
>  #ifdef XFS_ROOTHACK
>  		int sbflags = (info.qs_flags & 0xff00) >> 8;
>  #endif /* XFS_ROOTHACK */
> @@ -719,7 +750,7 @@ static int hasvfsmetaquota(const char *dev, struct mntent *mnt, int type, int fl
>  {
>  	uint32_t fmt;
>  
> -	if (!quotactl(QCMD(Q_GETFMT, type), dev, 0, (void *)&fmt))
> +	if (!do_quotactl(QCMD(Q_GETFMT, type), dev, mnt->mnt_dir, 0, (void *)&fmt))
>  		return QF_META;
>  	return QF_ERROR;
>  }
> @@ -796,7 +827,7 @@ static int hasquota(const char *dev, struct mntent *mnt, int type, int flags)
>  	if (!strcmp(mnt->mnt_type, MNTTYPE_EXT4) || !strcmp(mnt->mnt_type, MNTTYPE_F2FS)) {
>  		struct if_dqinfo kinfo;
>  
> -		if (quotactl(QCMD(Q_GETINFO, type), dev, 0, (void *)&kinfo) == 0) {
> +		if (do_quotactl(QCMD(Q_GETINFO, type), dev, mnt->mnt_dir, 0, (void *)&kinfo) == 0) {
>  			if (kinfo.dqi_flags & DQF_SYS_FILE)
>  				return QF_META;
>  		}
> @@ -1069,11 +1100,11 @@ void init_kernel_interface(void)
>  		else {
>  			fs_quota_stat_t dummy;
>  
> -			if (!quotactl(QCMD(Q_XGETQSTAT, 0), "/dev/root", 0, (void *)&dummy) ||
> +			if (!do_quotactl(QCMD(Q_XGETQSTAT, 0), "/dev/root", NULL, 0, (void *)&dummy) ||
>  			    (errno != EINVAL && errno != ENOSYS))
>  				kernel_qfmt[kernel_qfmt_num++] = QF_XFS;
>  		}
> -		if (quotactl(QCMD(Q_V2_GETSTATS, 0), NULL, 0, (void *)&v2_stats) >= 0) {
> +		if (do_quotactl(QCMD(Q_V2_GETSTATS, 0), NULL, NULL, 0, (void *)&v2_stats) >= 0) {
>  			kernel_qfmt[kernel_qfmt_num++] = QF_VFSV0;
>  			kernel_iface = IFACE_VFSV0;
>  		}
> @@ -1085,9 +1116,9 @@ void init_kernel_interface(void)
>  			int err_quota = 0;
>   			char tmp[1024];         /* Just temporary buffer */
>  
> -			if (quotactl(QCMD(Q_V1_GETSTATS, 0), NULL, 0, tmp))
> +			if (do_quotactl(QCMD(Q_V1_GETSTATS, 0), NULL, NULL, 0, tmp))
>  				err_stat = errno;
> -			if (quotactl(QCMD(Q_V1_GETQUOTA, 0), "/dev/null", 0, tmp))
> +			if (do_quotactl(QCMD(Q_V1_GETQUOTA, 0), "/dev/null", NULL, 0, tmp))
>  				err_quota = errno;
>  
>  			/* On a RedHat 2.4.2-2 	we expect 0, EINVAL
> @@ -1127,7 +1158,7 @@ static int v1_kern_quota_on(const char *dev, int type)
>  	char tmp[1024];		/* Just temporary buffer */
>  	qid_t id = (type == USRQUOTA) ? getuid() : getgid();
>  
> -	if (!quotactl(QCMD(Q_V1_GETQUOTA, type), dev, id, tmp))	/* OK? */
> +	if (!do_quotactl(QCMD(Q_V1_GETQUOTA, type), dev, NULL, id, tmp))	/* OK? */
>  		return 1;
>  	return 0;
>  }
> @@ -1138,7 +1169,7 @@ static int v2_kern_quota_on(const char *dev, int type)
>  	char tmp[1024];		/* Just temporary buffer */
>  	qid_t id = (type == USRQUOTA) ? getuid() : getgid();
>  
> -	if (!quotactl(QCMD(Q_V2_GETQUOTA, type), dev, id, tmp))	/* OK? */
> +	if (!do_quotactl(QCMD(Q_V2_GETQUOTA, type), dev, NULL, id, tmp))	/* OK? */
>  		return 1;
>  	return 0;
>  }
> @@ -1155,7 +1186,7 @@ int kern_quota_state_xfs(const char *dev, int type)
>  {
>  	struct xfs_mem_dqinfo info;
>  
> -	if (!quotactl(QCMD(Q_XFS_GETQSTAT, type), dev, 0, (void *)&info)) {
> +	if (!do_quotactl(QCMD(Q_XFS_GETQSTAT, type), dev, NULL, 0, (void *)&info)) {
>  		if (type == USRQUOTA) {
>  			return !!(info.qs_flags & XFS_QUOTA_UDQ_ACCT) +
>  			       !!(info.qs_flags & XFS_QUOTA_UDQ_ENFD);
> @@ -1199,8 +1230,8 @@ int kern_quota_on(struct mount_entry *mnt, int type, int fmt)
>  	if (kernel_iface == IFACE_GENERIC) {
>  		int actfmt;
>  
> -		if (quotactl(QCMD(Q_GETFMT, type), mnt->me_devname, 0,
> -			     (void *)&actfmt) >= 0) {
> +		if (do_quotactl(QCMD(Q_GETFMT, type), mnt->me_devname,
> +				mnt->me_dir, 0, (void *)&actfmt) >= 0) {
>  			actfmt = kern2utilfmt(actfmt);
>  			if (actfmt >= 0)
>  				return actfmt;
> diff --git a/quotasys.h b/quotasys.h
> index 841251e..b166ad2 100644
> --- a/quotasys.h
> +++ b/quotasys.h
> @@ -206,6 +206,9 @@ void end_mounts_scan(void);
>  /* Parse kernel version and return 1 if ext4 supports quota feature */
>  int ext4_supports_quota_feature(void);
>  
> +/* Wrapper around quota syscalls, either call quotactl or quotactl_fd */
> +int do_quotactl(int cmd, const char *dev, const char *mnt, int id, caddr_t addr);
> +
>  /* Quota output formats */
>  #define QOF_ERROR	-1
>  #define QOF_DEFAULT	0
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

