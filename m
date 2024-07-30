Return-Path: <linux-fsdevel+bounces-24604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B869412D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 15:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 220A61C23119
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 13:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E85719EEA7;
	Tue, 30 Jul 2024 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="POAVN58I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vDcInd+d";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="POAVN58I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vDcInd+d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264C119CD0E;
	Tue, 30 Jul 2024 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722345115; cv=none; b=AK4agjIpfOec55HxbX1IwuhabiJpsa98TlorjyDK5kwef/tqjoE9rKv7orzMRWFJaA9+pExuy8pxCIfOVJSilxTny7096l69HnX23oHuwdNdLfVagJEwJ/mzBwihE63dAr5F1hH6wNr2iFhdKP7hhrBY7zUgEoqF5NGNYUsXxuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722345115; c=relaxed/simple;
	bh=r3/Caba9CKvWgkeJ4IYviddZCcZivlyVq5gM4gCcAzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCc6Uoep2QJDjmPHIGbc6CfM9Yu1dia6027cYviuPSQFYvZQv+1+8USDV3hVLNAtSe3ELwICxE8y83yAbmLOVZF5ntSyPcTQCN2scdiOrzIoP2j70MAv3CUDP+ekwkvAL+BVgP/mnhEedaGPtR6j8JLhsX9TH3SOkPT+3UtX+JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=POAVN58I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vDcInd+d; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=POAVN58I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vDcInd+d; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 44C1C21B5D;
	Tue, 30 Jul 2024 13:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722345111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BnDuWgez9Yz4rGXeA+sG+j8R/b0r/8OUau8KAmCL8Q8=;
	b=POAVN58If4wzDIGfqbiwL/CVRqa9ibjDDL55V8yRDmaH6+osRxgr09ic8Fyow4y0+05Avj
	+MQykG4JZI3CdiOVuqxEtsH8kEd+zSUYo6YpuC9RAi5XCCDuFG1pvoExmGo1oihJtMZ6/s
	pMgKYqg53/gN0E+n0geNBYisxqUrUwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722345111;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BnDuWgez9Yz4rGXeA+sG+j8R/b0r/8OUau8KAmCL8Q8=;
	b=vDcInd+dla+53eZ2+0fZ3TqKrQqdemPFS5X9uCWqlHe7IqH/ij+FNtQug6AnLxPPAVPru2
	JtfF6hUPs+2bzrAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722345111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BnDuWgez9Yz4rGXeA+sG+j8R/b0r/8OUau8KAmCL8Q8=;
	b=POAVN58If4wzDIGfqbiwL/CVRqa9ibjDDL55V8yRDmaH6+osRxgr09ic8Fyow4y0+05Avj
	+MQykG4JZI3CdiOVuqxEtsH8kEd+zSUYo6YpuC9RAi5XCCDuFG1pvoExmGo1oihJtMZ6/s
	pMgKYqg53/gN0E+n0geNBYisxqUrUwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722345111;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BnDuWgez9Yz4rGXeA+sG+j8R/b0r/8OUau8KAmCL8Q8=;
	b=vDcInd+dla+53eZ2+0fZ3TqKrQqdemPFS5X9uCWqlHe7IqH/ij+FNtQug6AnLxPPAVPru2
	JtfF6hUPs+2bzrAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAEA113983;
	Tue, 30 Jul 2024 13:11:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DoRsKZbmqGY3VQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 30 Jul 2024 13:11:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EEFCBA099C; Tue, 30 Jul 2024 15:11:45 +0200 (CEST)
Date: Tue, 30 Jul 2024 15:11:45 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Olaf Hering <olaf@aepfle.de>, Deepa Dinamani <deepa.kernel@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v1] mount: handle OOM on mnt_warn_timestamp_expiry
Message-ID: <20240730131145.caamuyu2goloa67n@quack3>
References: <20240730085856.32385-1-olaf@aepfle.de>
 <20240730-humpelt-deklamieren-eeefe1d623a9@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730-humpelt-deklamieren-eeefe1d623a9@brauner>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.10 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[aepfle.de,gmail.com,kernel.org,vger.kernel.org,zeniv.linux.org.uk,suse.cz];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.10

On Tue 30-07-24 11:49:37, Christian Brauner wrote:
> On Tue, Jul 30, 2024 at 10:58:13AM GMT, Olaf Hering wrote:
> > If no page could be allocated, an error pointer was used as format
> > string in pr_warn.
> > 
> > Rearrange the code to return early in case of OOM. Also add a check
> > for the return value of d_path. The API of that function is not
> > documented. It currently returns only ERR_PTR values, but may return
> > also NULL in the future. Use PTR_ERR_OR_ZERO to cover both cases.
> > 
> > Fixes: f8b92ba67c5d ("mount: Add mount warning for impending timestamp expiry")
> > 
> > Signed-off-by: Olaf Hering <olaf@aepfle.de>
> > ---
> >  fs/namespace.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 328087a4df8a..539d4f203a20 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -2922,7 +2922,14 @@ static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *
> >  	   (!(sb->s_iflags & SB_I_TS_EXPIRY_WARNED)) &&
> >  	   (ktime_get_real_seconds() + TIME_UPTIME_SEC_MAX > sb->s_time_max)) {
> >  		char *buf = (char *)__get_free_page(GFP_KERNEL);
> > -		char *mntpath = buf ? d_path(mountpoint, buf, PAGE_SIZE) : ERR_PTR(-ENOMEM);
> > +		char *mntpath;
> > +		
> > +		if (!buf)
> > +			return;
> > +
> > +		mntpath = d_path(mountpoint, buf, PAGE_SIZE);
> > +		if (PTR_ERR_OR_ZERO(mntpath))
> 
> This needs to be IS_ERR_OR_NULL().
> 
> > +			goto err;
> 
> We should still warn when decoding the mountpoint fails. I'll just amend
> your patch to something like:

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 328087a4df8a..0f2f140aaf05 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2921,16 +2921,21 @@ static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *
>         if (!__mnt_is_readonly(mnt) &&
>            (!(sb->s_iflags & SB_I_TS_EXPIRY_WARNED)) &&
>            (ktime_get_real_seconds() + TIME_UPTIME_SEC_MAX > sb->s_time_max)) {
> -               char *buf = (char *)__get_free_page(GFP_KERNEL);
> -               char *mntpath = buf ? d_path(mountpoint, buf, PAGE_SIZE) : ERR_PTR(-ENOMEM);
> +               char *buf, *mntpath = NULL;
> +
> +               buf = (char *)__get_free_page(GFP_KERNEL);
> +               if (buf)
> +                       mntpath = d_path(mountpoint, buf, PAGE_SIZE);
> +               if (IS_ERR_OR_NULL(mntpath))
> +                       mntpath = "(unknown)";
> 
>                 pr_warn("%s filesystem being %s at %s supports timestamps until %ptTd (0x%llx)\n",
>                         sb->s_type->name,
>                         is_mounted(mnt) ? "remounted" : "mounted",
>                         mntpath, &sb->s_time_max,
>                         (unsigned long long)sb->s_time_max);
> -
> -               free_page((unsigned long)buf);
> +               if (buf)
> +                       free_page((unsigned long)buf);
>                 sb->s_iflags |= SB_I_TS_EXPIRY_WARNED;
>         }
>  }
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

