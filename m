Return-Path: <linux-fsdevel+bounces-38852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6990A08CFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 10:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7748218844ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 09:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FA020A5F7;
	Fri, 10 Jan 2025 09:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VsO9gsY7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I7nNPC6r";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VsO9gsY7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I7nNPC6r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD66209F44;
	Fri, 10 Jan 2025 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502844; cv=none; b=KFrKrFCtf/LbVJ1nZvbw2sgUNsmRV+YTWppeApxkSX9lToWvnWDF8Fq6iouzy82VVTOdye5WSDSVQGJdDQlm0LxEu8Lj07bhBnFKM5FwDjNq+ZiIJVggb9D0FDK0RL7m0g7Jgm4ExIm41T9OPYZgoepDEFn2Op7UbxVYkB5J5Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502844; c=relaxed/simple;
	bh=8/2e/mWos9wuKE0t99GBlAnYf5FdSlBLCcGc3g2a46Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmf/IWjeSbKkXXBS2kjHmhkVFXWJsqpUANgEbhD3HrXDYIg9g/HFIHWPtgVW89xwuD/A0m8Zf7dmkAyTvEmpc95x/AbCxuAun5NgySO/429lHnbg1xEGLO+QvF38r7qtbODv/YPXHWJ/IWtDZ88zhFP+fnfXBabDfGyDhVEbVWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VsO9gsY7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I7nNPC6r; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VsO9gsY7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I7nNPC6r; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CA83B1F394;
	Fri, 10 Jan 2025 09:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736502840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xsvN9OIFYxP3/GaFFOm/Gy5OVg27/U7FgUISQD7sGsI=;
	b=VsO9gsY7FSoiORu9UOtTUHEkZxBWpDOl7mZL4F0w8LDwgAsKaEbZ81ZgIzGC7oNYNoWXYl
	5oAbxGSvoOE5UYkdts6JYBB4ATYY2L47Q3qwyvOxRSBRVphj/Zu6EAqTv12UmuOvHTh/sS
	Ra3RWHNKsieiK9s7zMTAz0WpFJNZ0xc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736502840;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xsvN9OIFYxP3/GaFFOm/Gy5OVg27/U7FgUISQD7sGsI=;
	b=I7nNPC6rgqoNGx+4/T56qwZ6wF4QxHoQeWhiI8tJhGvvN4AM5z1rGAZrMRHpNdxbbkE+0i
	2ewNtGNDiqL3A3DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736502840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xsvN9OIFYxP3/GaFFOm/Gy5OVg27/U7FgUISQD7sGsI=;
	b=VsO9gsY7FSoiORu9UOtTUHEkZxBWpDOl7mZL4F0w8LDwgAsKaEbZ81ZgIzGC7oNYNoWXYl
	5oAbxGSvoOE5UYkdts6JYBB4ATYY2L47Q3qwyvOxRSBRVphj/Zu6EAqTv12UmuOvHTh/sS
	Ra3RWHNKsieiK9s7zMTAz0WpFJNZ0xc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736502840;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xsvN9OIFYxP3/GaFFOm/Gy5OVg27/U7FgUISQD7sGsI=;
	b=I7nNPC6rgqoNGx+4/T56qwZ6wF4QxHoQeWhiI8tJhGvvN4AM5z1rGAZrMRHpNdxbbkE+0i
	2ewNtGNDiqL3A3DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B945913A86;
	Fri, 10 Jan 2025 09:54:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jhnvLDjugGf5GgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 10 Jan 2025 09:54:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 63781A0889; Fri, 10 Jan 2025 10:54:00 +0100 (CET)
Date: Fri, 10 Jan 2025 10:54:00 +0100
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, agruenba@redhat.com, amir73il@gmail.com, 
	brauner@kernel.org, ceph-devel@vger.kernel.org, dhowells@redhat.com, 
	hubcap@omnibond.com, jack@suse.cz, krisman@kernel.org, linux-nfs@vger.kernel.org, 
	miklos@szeredi.hu, torvalds@linux-foundation.org
Subject: Re: [PATCH 18/20] ocfs2_dentry_revalidate(): use stable parent inode
 and name passed by caller
Message-ID: <gqakhrasapfiocyilg5zbehb7m24n6sgtyoxe5pluih256v5ht@n7vp2zm5xsti>
References: <20250110023854.GS1977892@ZenIV>
 <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
 <20250110024303.4157645-18-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110024303.4157645-18-viro@zeniv.linux.org.uk>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,gmail.com,kernel.org,omnibond.com,suse.cz,szeredi.hu,linux-foundation.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,linux.org.uk:email,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 10-01-25 02:43:01, Al Viro wrote:
> theoretically, ->d_name use in there is a UAF, but only if you are messing with
> tracepoints...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ocfs2/dcache.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ocfs2/dcache.c b/fs/ocfs2/dcache.c
> index ecb1ce6301c4..1873bbbb7e5b 100644
> --- a/fs/ocfs2/dcache.c
> +++ b/fs/ocfs2/dcache.c
> @@ -45,8 +45,7 @@ static int ocfs2_dentry_revalidate(struct inode *dir, const struct qstr *name,
>  	inode = d_inode(dentry);
>  	osb = OCFS2_SB(dentry->d_sb);
>  
> -	trace_ocfs2_dentry_revalidate(dentry, dentry->d_name.len,
> -				      dentry->d_name.name);
> +	trace_ocfs2_dentry_revalidate(dentry, name->len, name->name);
>  
>  	/* For a negative dentry -
>  	 * check the generation number of the parent and compare with the
> @@ -54,12 +53,8 @@ static int ocfs2_dentry_revalidate(struct inode *dir, const struct qstr *name,
>  	 */
>  	if (inode == NULL) {
>  		unsigned long gen = (unsigned long) dentry->d_fsdata;
> -		unsigned long pgen;
> -		spin_lock(&dentry->d_lock);
> -		pgen = OCFS2_I(d_inode(dentry->d_parent))->ip_dir_lock_gen;
> -		spin_unlock(&dentry->d_lock);
> -		trace_ocfs2_dentry_revalidate_negative(dentry->d_name.len,
> -						       dentry->d_name.name,
> +		unsigned long pgen = OCFS2_I(dir)->ip_dir_lock_gen;
> +		trace_ocfs2_dentry_revalidate_negative(name->len, name->name,
>  						       pgen, gen);
>  		if (gen != pgen)
>  			goto bail;
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

