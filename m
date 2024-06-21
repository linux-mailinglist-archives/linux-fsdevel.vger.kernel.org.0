Return-Path: <linux-fsdevel+bounces-22108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFF1912388
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 13:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7911F27380
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 11:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6A8176ABC;
	Fri, 21 Jun 2024 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WyipYmHz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k6Hgy0By";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="duZ7Mh3d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="psEfHHaC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD8E176254;
	Fri, 21 Jun 2024 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969124; cv=none; b=cqXmDZocdt5aXIwPdlp8quU2o/YfQvamAaT17GwZTg+i3zJuciAAMiIyFAW7cQDBF7SDzy5S/cWq+Q2mc5Pw9kWC/SBWdcW6ZQG8QDgQ+YtZ+knshgeQhl+GUU0oGwmTudzcPMqbIMZqjQYFnMygo1t62Cms6FOJzXWly9JUt2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969124; c=relaxed/simple;
	bh=7Wg8YiT2kEFpC+UB7M62V8+RiaolnmozV8kRePzaDdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRQ1xz/YP89WrVrsyzPSdqDD5oLYRmDRwDFc/LJHetyAhnkCkVlUwpL7yUSsdXmNcJUPZuoH7tq9g+5fc2upKAOdpyUVcNOvb89vt5n8XoVciIa2bLQPsNo3XhcqBlQPCIpWdWgfu9lqwykOEoH/DtKLKxv8aDWTH3ALmjLqqhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WyipYmHz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k6Hgy0By; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=duZ7Mh3d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=psEfHHaC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF16821AED;
	Fri, 21 Jun 2024 11:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718969121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gtibqh13Q5Q7EF+VQJmr7nL2jQiH8PMdmBYn5dAvs+0=;
	b=WyipYmHzsG1UAensuD//zh5tTO0fzOPs90KBZq0WUzubYGpdqbcbFRYZv2TeTotlZ6QFMx
	p7zMk0h2BQ3WPIPSbj4lm9worX4DD9q7Oa/DRzBWrOguXx8KJRbVShidJgQEXg0Czy0k2O
	coGFlAD9ukNAUcmlYvyR9/e4MPb8q3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718969121;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gtibqh13Q5Q7EF+VQJmr7nL2jQiH8PMdmBYn5dAvs+0=;
	b=k6Hgy0BykMdAbsgfLELPDkuW6C8/vvVBNZkUwBjFkOEByT9IduZld8v4ZMRae6eWu2OI/e
	rxNtVd3cGCHwvoCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718969119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gtibqh13Q5Q7EF+VQJmr7nL2jQiH8PMdmBYn5dAvs+0=;
	b=duZ7Mh3dWNJOGRI1wVpiqdQDtFTsVWVoFmpvtpJdAxFxL5JsZqpJSv0NumVzFG2RRKNPjN
	MUPoH7TMVnllyAvu2vEIwtjkXGDC66yVXqJozbFyZVvm/BUcwUmFqY+FYxx6fCiO+E2URs
	kh/WUNfKhRVUf0rRR9R9rvXL3Wrgo5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718969119;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gtibqh13Q5Q7EF+VQJmr7nL2jQiH8PMdmBYn5dAvs+0=;
	b=psEfHHaCiNdyW2oUvRKBMaH3zkWtCYLj+uWmsjhmO+9mJNQ8I+ZzbC3vWLbHNupKxyEAZ8
	/8aRzplsLixJ83Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D461A13AAA;
	Fri, 21 Jun 2024 11:25:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dMzRMx9jdWbWZwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 21 Jun 2024 11:25:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 81A10A087E; Fri, 21 Jun 2024 13:25:19 +0200 (CEST)
Date: Fri, 21 Jun 2024 13:25:19 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, viro@zeniv.linux.org.uk,
	jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: reorder checks in may_create_in_sticky
Message-ID: <20240621112519.vp26sqmehxbihqgc@quack3>
References: <20240620120359.151258-1-mjguzik@gmail.com>
 <20240621-affekt-denkzettel-3c115f68355a@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621-affekt-denkzettel-3c115f68355a@brauner>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,zeniv.linux.org.uk,suse.cz,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Fri 21-06-24 09:45:03, Christian Brauner wrote:
> On Thu, Jun 20, 2024 at 02:03:59PM GMT, Mateusz Guzik wrote:
> > The routine is called for all directories on file creation and weirdly
> > postpones the check if the dir is sticky to begin with. Instead it first
> > checks fifos and regular files (in that order), while avoidably pulling
> > globals.
> > 
> > No functional changes.
> > 
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > ---
> >  fs/namei.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 63d1fb06da6b..b1600060ecfb 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -1246,9 +1246,9 @@ static int may_create_in_sticky(struct mnt_idmap *idmap,
> >  	umode_t dir_mode = nd->dir_mode;
> >  	vfsuid_t dir_vfsuid = nd->dir_vfsuid;
> >  
> > -	if ((!sysctl_protected_fifos && S_ISFIFO(inode->i_mode)) ||
> > -	    (!sysctl_protected_regular && S_ISREG(inode->i_mode)) ||
> > -	    likely(!(dir_mode & S_ISVTX)) ||
> > +	if (likely(!(dir_mode & S_ISVTX)) ||
> > +	    (S_ISREG(inode->i_mode) && !sysctl_protected_regular) ||
> > +	    (S_ISFIFO(inode->i_mode) && !sysctl_protected_fifos) ||
> >  	    vfsuid_eq(i_uid_into_vfsuid(idmap, inode), dir_vfsuid) ||
> >  	    vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, inode), current_fsuid()))
> >  		return 0;
> 
> I think we really need to unroll this unoly mess to make it more readable?

I guess my neural network has adapted to these kind of things in the kernel :)

> diff --git a/fs/namei.c b/fs/namei.c
> index 3e23fbb8b029..1dd2d328bae3 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1244,25 +1244,43 @@ static int may_create_in_sticky(struct mnt_idmap *idmap,
>                                 struct nameidata *nd, struct inode *const inode)
>  {
>         umode_t dir_mode = nd->dir_mode;
> -       vfsuid_t dir_vfsuid = nd->dir_vfsuid;
> +       vfsuid_t dir_vfsuid = nd->dir_vfsuid, i_vfsuid;
> +       int ret;
> +
> +       if (likely(!(dir_mode & S_ISVTX)))
> +               return 0;
> +
> +       if (S_ISREG(inode->i_mode) && !sysctl_protected_regular)
> +               return 0;
> +
> +       if (S_ISFIFO(inode->i_mode) && !sysctl_protected_fifos)
> +               return 0;
> +
> +       i_vfsuid = i_uid_into_vfsuid(idmap, inode);
> +
> +       if (vfsuid_eq(i_vfsuid, dir_vfsuid))
> +               return 0;
> 
> -       if (likely(!(dir_mode & S_ISVTX)) ||
> -           (S_ISREG(inode->i_mode) && !sysctl_protected_regular) ||
> -           (S_ISFIFO(inode->i_mode) && !sysctl_protected_fifos) ||
> -           vfsuid_eq(i_uid_into_vfsuid(idmap, inode), dir_vfsuid) ||
> -           vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, inode), current_fsuid()))
> +       if (vfsuid_eq_kuid(i_vfsuid, current_fsuid()))
>                 return 0;
> 
> -       if (likely(dir_mode & 0002) ||
> -           (dir_mode & 0020 &&
> -            ((sysctl_protected_fifos >= 2 && S_ISFIFO(inode->i_mode)) ||
> -             (sysctl_protected_regular >= 2 && S_ISREG(inode->i_mode))))) {
> -               const char *operation = S_ISFIFO(inode->i_mode) ?
> -                                       "sticky_create_fifo" :
> -                                       "sticky_create_regular";
> -               audit_log_path_denied(AUDIT_ANOM_CREAT, operation);
> +       if (likely(dir_mode & 0002)) {
> +               audit_log_path_denied(AUDIT_ANOM_CREAT, "sticky_create");
>                 return -EACCES;
>         }
> +
> +       if (dir_mode & 0020) {
> +               if (sysctl_protected_fifos >= 2 && S_ISFIFO(inode->i_mode)) {
> +                       audit_log_path_denied(AUDIT_ANOM_CREAT, "sticky_create_fifo");
> +                       return -EACCES;
> +               }
> +
> +               if (sysctl_protected_regular >= 2 && S_ISREG(inode->i_mode)) {
> +                       audit_log_path_denied(AUDIT_ANOM_CREAT, "sticky_create_regular");
> +                       return -EACCES;
> +               }
> +       }
> +
>         return 0;
>  }

But this definitely looks nicer to read... Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

