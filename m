Return-Path: <linux-fsdevel+bounces-48116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F19FAA9B21
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 19:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CEF8189E744
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 17:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F1826E176;
	Mon,  5 May 2025 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iaCZcNSJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0GXIZKmn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iaCZcNSJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0GXIZKmn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8452F25D8E0
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746467892; cv=none; b=Pue8F9EKWgEdU3DsfQqtmUUKroOL2tWBltGUk7CuOYP1deKp0maeXhJsrVl1QUbcCvYj3shkq5TlsA0H7hUnd6NsEElPyuMf+TSyB2JEm8w/w3Mx/Y1ul5Z801UB0Wavqq5EEkax3uOdV4iDYoap/mW9lIHdqh9B61003tWpcu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746467892; c=relaxed/simple;
	bh=0e6YhLzsG/OfglvPJikQQMARBv9rNGTKfHPfNR9HTjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgCl96H1yvP2fsnTmZjXf6hN+ncFUdpnXI86OA0yLaB7/ln4apvV7rROcRe/T01P+i5x8JhN3Y8eZvy92hiNEKykUYfCck+N8L/iIwYghmV2cXeSuHPr5Wwmo7vG7j+VRuBPsRh+gsj1Muawoed8hAtu83j00MI9sQL+9erO3m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iaCZcNSJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0GXIZKmn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iaCZcNSJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0GXIZKmn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6D2782116B;
	Mon,  5 May 2025 17:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746467888;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AfZbvSoYQLgkuReZJnUb5jjUb2PCP+pD3VIzLsuKudA=;
	b=iaCZcNSJURrtUF72m9iBwMU1WRBj3hX0la53PMv4GerGNZaiyhUq1wx0c60Gsmq2NajqpH
	ugn9TvjaSf1uAIJEfWW04FecRhJIQu7j9T298D40uTwB8aZbc3s/lcnNgv5JOyxLS3jrIb
	x3e/UXZvEhM1S37QO7Pks0HaCEgb0eY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746467888;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AfZbvSoYQLgkuReZJnUb5jjUb2PCP+pD3VIzLsuKudA=;
	b=0GXIZKmniMBQB60nqeXwqXR1p67YWpSvFifs4BpJB8WMJ/rbI2tlqqfnr0zxfCAkE2wrsV
	YV1BzWOofPODJCCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iaCZcNSJ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0GXIZKmn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746467888;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AfZbvSoYQLgkuReZJnUb5jjUb2PCP+pD3VIzLsuKudA=;
	b=iaCZcNSJURrtUF72m9iBwMU1WRBj3hX0la53PMv4GerGNZaiyhUq1wx0c60Gsmq2NajqpH
	ugn9TvjaSf1uAIJEfWW04FecRhJIQu7j9T298D40uTwB8aZbc3s/lcnNgv5JOyxLS3jrIb
	x3e/UXZvEhM1S37QO7Pks0HaCEgb0eY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746467888;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AfZbvSoYQLgkuReZJnUb5jjUb2PCP+pD3VIzLsuKudA=;
	b=0GXIZKmniMBQB60nqeXwqXR1p67YWpSvFifs4BpJB8WMJ/rbI2tlqqfnr0zxfCAkE2wrsV
	YV1BzWOofPODJCCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47CBB1398F;
	Mon,  5 May 2025 17:58:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /spJETD8GGiSCAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 05 May 2025 17:58:08 +0000
Date: Mon, 5 May 2025 19:58:07 +0200
From: David Sterba <dsterba@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [RFC][PATCH] btrfs_get_tree_subvol(): switch from fc_mount() to
 vfs_create_mount()
Message-ID: <20250505175807.GB9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250505030345.GD2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505030345.GD2023217@ZenIV>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 6D2782116B
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, May 05, 2025 at 04:03:45AM +0100, Al Viro wrote:
> it's simpler to do btrfs_reconfigure_for_mount() right after vfs_get_tree() -
> no need to mess with ->s_umount.
> 
> Objections?
>     
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 7121d8c7a318..a3634e7f2304 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1984,17 +1984,13 @@ static int btrfs_get_tree_super(struct fs_context *fc)
>   * btrfs or not, setting the whole super block RO.  To make per-subvolume mounting
>   * work with different options work we need to keep backward compatibility.
>   */
> -static int btrfs_reconfigure_for_mount(struct fs_context *fc, struct vfsmount *mnt)
> +static int btrfs_reconfigure_for_mount(struct fs_context *fc)
>  {
>  	int ret = 0;
>  
> -	if (fc->sb_flags & SB_RDONLY)
> -		return ret;
> -
> -	down_write(&mnt->mnt_sb->s_umount);
> -	if (!(fc->sb_flags & SB_RDONLY) && (mnt->mnt_sb->s_flags & SB_RDONLY))
> +	if (!(fc->sb_flags & SB_RDONLY) && (fc->root->d_sb->s_flags & SB_RDONLY))
>  		ret = btrfs_reconfigure(fc);
> -	up_write(&mnt->mnt_sb->s_umount);
> +
>  	return ret;
>  }
>  
> @@ -2047,17 +2043,18 @@ static int btrfs_get_tree_subvol(struct fs_context *fc)
>  	security_free_mnt_opts(&fc->security);
>  	fc->security = NULL;
>  
> -	mnt = fc_mount(dup_fc);
> -	if (IS_ERR(mnt)) {
> -		put_fs_context(dup_fc);
> -		return PTR_ERR(mnt);
> +	ret = vfs_get_tree(dup_fc);

So this open codes fc_mount(), which is vfs_get_tree() + vfs_create_mount(),
the only difference I see in the new code is that
btrfs_reconfigure_for_mount() dropped the SB_RDONLY check.

Why the check is there is explained in the lengthy comment above
btrfs_reconfigure_for_mount(), so it should stay. If it can be removed
then it should be a separate patch from the cleanup.

> +	if (!ret) {
> +		ret = btrfs_reconfigure_for_mount(dup_fc);
> +		up_write(&fc->root->d_sb->s_umount);
>  	}
> -	ret = btrfs_reconfigure_for_mount(dup_fc, mnt);
> +	if (!ret)
> +		mnt = vfs_create_mount(fc);
> +	else
> +		mnt = ERR_PTR(ret);
>  	put_fs_context(dup_fc);
> -	if (ret) {
> -		mntput(mnt);
> -		return ret;
> -	}
> +	if (IS_ERR(mnt))
> +		return PTR_ERR(mnt);
>  
>  	/*
>  	 * This free's ->subvol_name, because if it isn't set we have to

