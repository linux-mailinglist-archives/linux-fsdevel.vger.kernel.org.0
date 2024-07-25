Return-Path: <linux-fsdevel+bounces-24232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A8093BE19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 10:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00F93B22C90
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 08:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB39187349;
	Thu, 25 Jul 2024 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jaQ2Lf+K";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jQTzTKCS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jaQ2Lf+K";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jQTzTKCS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A737185623;
	Thu, 25 Jul 2024 08:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721896972; cv=none; b=OwwI1jUPPoeZN5q2fUN6xxIvNpP2avNFMA2eK6oHn0m0hqiHFN9DPuQSADC1ffSf3laoR09+AxfckZMfEB/fwpADplCll6CEl3szsU9UACw0DH43q/y4V8mfBtMRJkM4BZ5X3ILNSv+pzb0BDmaGY2XTySq4zEgTEb5g0DRmrf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721896972; c=relaxed/simple;
	bh=+xNMIiOutEftQ14fECFJ1Dyu58qcr3nWpFQVY+PuaLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u56AMgph+3+JSSk1mPmluo0PNyMzuD62FUcLERFW/5FiMQQ6zEENcHJqvd0cM59iWhtC4jv/ug1CVVd7fqK2gafZtsFZupYVi0Cu5XTkBKkRCKlk1cmkJbSInXVauK6//TZP8q+n3UkNKDsiUeTccI73LGijhl3PmB2Mo1VkYXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jaQ2Lf+K; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jQTzTKCS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jaQ2Lf+K; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jQTzTKCS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6EDBD1FC81;
	Thu, 25 Jul 2024 08:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721896968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fs6bJDWIeskekddsnMj7aBO6yI65RH0EnnArQ8nuep8=;
	b=jaQ2Lf+KXTsMY8adapYh4nv2Y9m9rEBL0hsX4WFPPmJEJhu80yEvdsdSKMBfREc7RCx41W
	Nphc41Vuyy29Og3GA0PtzKJ5s9a11FJlZY2SZnR8FtvQFlwLfR0AKbcaWfX9Ip2f3Kaq8i
	PjtArjfABpGfKfd9fnQFbj9TyvdpXNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721896968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fs6bJDWIeskekddsnMj7aBO6yI65RH0EnnArQ8nuep8=;
	b=jQTzTKCS4KGcqdItqRdp6AzABDPLTcygUrWr6ggcNEDmZrr+9ltGPAt/1OAQGl1ybrGP5D
	nlzNHnA39GD+wfDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721896968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fs6bJDWIeskekddsnMj7aBO6yI65RH0EnnArQ8nuep8=;
	b=jaQ2Lf+KXTsMY8adapYh4nv2Y9m9rEBL0hsX4WFPPmJEJhu80yEvdsdSKMBfREc7RCx41W
	Nphc41Vuyy29Og3GA0PtzKJ5s9a11FJlZY2SZnR8FtvQFlwLfR0AKbcaWfX9Ip2f3Kaq8i
	PjtArjfABpGfKfd9fnQFbj9TyvdpXNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721896968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fs6bJDWIeskekddsnMj7aBO6yI65RH0EnnArQ8nuep8=;
	b=jQTzTKCS4KGcqdItqRdp6AzABDPLTcygUrWr6ggcNEDmZrr+9ltGPAt/1OAQGl1ybrGP5D
	nlzNHnA39GD+wfDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5525713874;
	Thu, 25 Jul 2024 08:42:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PeN+FAgQomajKgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 25 Jul 2024 08:42:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F18CEA08F2; Thu, 25 Jul 2024 10:42:32 +0200 (CEST)
Date: Thu, 25 Jul 2024 10:42:32 +0200
From: Jan Kara <jack@suse.cz>
To: Haifeng Xu <haifeng.xu@shopee.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	tj@kernel.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: don't flush in-flight wb switches for superblocks
 without cgroup writeback
Message-ID: <20240725084232.bj7apjqqowae575c@quack3>
References: <20240725023958.370787-1-haifeng.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725023958.370787-1-haifeng.xu@shopee.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-0.60 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -0.60

On Thu 25-07-24 10:39:58, Haifeng Xu wrote:
> When deactivating any type of superblock, it had to wait for the in-flight
> wb switches to be completed. wb switches are executed in inode_switch_wbs_work_fn()
> which needs to acquire the wb_switch_rwsem and races against sync_inodes_sb().
> If there are too much dirty data in the superblock, the waiting time may increase
> significantly.
> 
> For superblocks without cgroup writeback such as tmpfs, they have nothing to
> do with the wb swithes, so the flushing can be avoided.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> ---
>  fs/super.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 095ba793e10c..f846f853e957 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -621,7 +621,8 @@ void generic_shutdown_super(struct super_block *sb)
>  		sync_filesystem(sb);
>  		sb->s_flags &= ~SB_ACTIVE;
>  
> -		cgroup_writeback_umount();
> +		if (sb->s_bdi != &noop_backing_dev_info)
> +			cgroup_writeback_umount();

So a more obvious check would be:

		if (sb->s_bdi->capabilities & BDI_CAP_WRITEBACK)

even better would be if we'd pass 'sb' into cgroup_writeback_umount() and
that function would do this check inside so that callers don't have to
bother... I know there is only one caller so this is not a huge deal but
still I'd find it cleaner that way.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

