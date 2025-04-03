Return-Path: <linux-fsdevel+bounces-45655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A957A7A5DD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 17:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C622D188FF5F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 15:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483D9250BFF;
	Thu,  3 Apr 2025 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3H9WMjzx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="voOTGShM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3H9WMjzx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="voOTGShM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A332505D2
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743692432; cv=none; b=hWDhv92vsdlpYrF6XfN1S92IQ4s3SWOIfD42dsQCYGF12iv76tstjPsELwcbhlio7SVQYoXAJDIvqnooD4c+hANeyhw+OfkW1Skyq77Zp1UOivNp27x7ydlVojduR/lpbVmX+ARzDkU5QTBU9KQhDKhyI8DJ20/PsWqLTIPbxuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743692432; c=relaxed/simple;
	bh=bfFZPY45P2gKmQYpGSYCaiXbidvKjiPdDyAgBnKwk9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsScvRiQa2OzJSJVtGIVEce5eQyPc6OilRr12pf9UHK4iqf67/tRvLKTu0AgaLvFdANpNVLSN7r9SQGrFIqpNtCEGmWxohVMg6CBQGqR10F5tVYI5QaeJDbbBJtr+SjbEtnLhVkB3RlcBudDNqHl7pMN5MbLBsN/MmWlwrxLeIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3H9WMjzx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=voOTGShM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3H9WMjzx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=voOTGShM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 594F21F390;
	Thu,  3 Apr 2025 15:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743692429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BunkOkyNC5tt3KvD+BFe7B526GiiXTQ9MnCliQp4MbI=;
	b=3H9WMjzx3gLyAIh8mvahtAgFDZtTMr+mht6vazHjrQyJWKmYrgw0V7wt24pqQnNsD4qQIf
	U5v6Ac0ndL0b6R8d/CRVbJ/CPPUViNgXZo3XSvU5v99IZG79NcQpBOqBP9qXu+jiKMLS6p
	XcdmDkhq5IziICvHUOIqpQC/FTcfO9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743692429;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BunkOkyNC5tt3KvD+BFe7B526GiiXTQ9MnCliQp4MbI=;
	b=voOTGShMusTiqpQJcxGUhzNZnFkmMJPeF1XrXUmYVbFqdk/VPMva8QyFJRIh2onCYotlFN
	C/IB4w5ibcfk08Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3H9WMjzx;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=voOTGShM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743692429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BunkOkyNC5tt3KvD+BFe7B526GiiXTQ9MnCliQp4MbI=;
	b=3H9WMjzx3gLyAIh8mvahtAgFDZtTMr+mht6vazHjrQyJWKmYrgw0V7wt24pqQnNsD4qQIf
	U5v6Ac0ndL0b6R8d/CRVbJ/CPPUViNgXZo3XSvU5v99IZG79NcQpBOqBP9qXu+jiKMLS6p
	XcdmDkhq5IziICvHUOIqpQC/FTcfO9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743692429;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BunkOkyNC5tt3KvD+BFe7B526GiiXTQ9MnCliQp4MbI=;
	b=voOTGShMusTiqpQJcxGUhzNZnFkmMJPeF1XrXUmYVbFqdk/VPMva8QyFJRIh2onCYotlFN
	C/IB4w5ibcfk08Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B6E21392A;
	Thu,  3 Apr 2025 15:00:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WSxqEo2i7mekYAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 03 Apr 2025 15:00:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 00E4AA07E6; Thu,  3 Apr 2025 17:00:28 +0200 (CEST)
Date: Thu, 3 Apr 2025 17:00:28 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, 
	rafael@kernel.org, djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH v2 4/4] kernfs: add warning about implementing freeze/thaw
Message-ID: <arftvbus4knelyjz5htjdm77fqjalv2haeozfkuxdvyipuge52@wbnzvhdulu25>
References: <20250402-work-freeze-v2-0-6719a97b52ac@kernel.org>
 <20250402-work-freeze-v2-4-6719a97b52ac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402-work-freeze-v2-4-6719a97b52ac@kernel.org>
X-Rspamd-Queue-Id: 594F21F390
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.cz,kernel.org,hansenpartnership.com,infradead.org,fromorbit.com,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 02-04-25 16:07:34, Christian Brauner wrote:
> Sysfs is built on top of kernfs and sysfs provides the power management
> infrastructure to support suspend/hibernate by writing to various files
> in /sys/power/. As filesystems may be automatically frozen during
> suspend/hibernate implementing freeze/thaw support for kernfs
> generically will cause deadlocks as the suspending/hibernation
> initiating task will hold a VFS lock that it will then wait upon to be
> released. If freeze/thaw for kernfs is needed talk to the VFS.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Yeah, good idea. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/kernfs/mount.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
> index 1358c21837f1..d2073bb2b633 100644
> --- a/fs/kernfs/mount.c
> +++ b/fs/kernfs/mount.c
> @@ -62,6 +62,21 @@ const struct super_operations kernfs_sops = {
>  
>  	.show_options	= kernfs_sop_show_options,
>  	.show_path	= kernfs_sop_show_path,
> +
> +	/*
> +	 * sysfs is built on top of kernfs and sysfs provides the power
> +	 * management infrastructure to support suspend/hibernate by
> +	 * writing to various files in /sys/power/. As filesystems may
> +	 * be automatically frozen during suspend/hibernate implementing
> +	 * freeze/thaw support for kernfs generically will cause
> +	 * deadlocks as the suspending/hibernation initiating task will
> +	 * hold a VFS lock that it will then wait upon to be released.
> +	 * If freeze/thaw for kernfs is needed talk to the VFS.
> +	 */
> +	.freeze_fs	= NULL,
> +	.unfreeze_fs	= NULL,
> +	.freeze_super	= NULL,
> +	.thaw_super	= NULL,
>  };
>  
>  static int kernfs_encode_fh(struct inode *inode, __u32 *fh, int *max_len,
> 
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

