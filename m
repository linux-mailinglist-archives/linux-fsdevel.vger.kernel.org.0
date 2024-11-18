Return-Path: <linux-fsdevel+bounces-35081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B479D0F9F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 12:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91EE7282A48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 11:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3345D198E80;
	Mon, 18 Nov 2024 11:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vbZsYtrw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="txBr2wbN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QRFMZIAu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wKJvDDBr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D351B155322;
	Mon, 18 Nov 2024 11:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731929204; cv=none; b=bzBC/mj5qeM0OOPioutc2zIjwd+pxXBp4eok+dDF6U+3fI9KJeg5NlnSrl8ktUSRtpIdmwd1SvxyCl+QyvcHeWGtEt1ELUH0kTB5C4kPxI+5qHRwEIiZwn73lXx+j7EiUgRDFhO6T31+AvK2WypAABMAAaKeulYJdxuaAcjaGhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731929204; c=relaxed/simple;
	bh=H1rRHxOdl7f0e8fLz+26zLMxXH7lqtpn3Bc6ZCxB9xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYOWhTrQvoINZnkLAhwEiqdqEkcixMcWrzPNWuB9HVZmFtsmn/c9dtuSwrAS8x+0mV9li8s+4LzP53GjY6680HuLgsSjzAH9kHk9VwVSLerA+li0nbGbcdH1PUb3QarjcgZ6OcyaOn0i6ehyI/iVe+yMGsYW09BNGQDMHBy4+t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vbZsYtrw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=txBr2wbN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QRFMZIAu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wKJvDDBr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EAD78218BB;
	Mon, 18 Nov 2024 11:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731929201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g15DVHHn8bs6EXS1yY2Zn0UBmTSNa17zQ61VWajhxA8=;
	b=vbZsYtrw+f/pnuMx6N/12FXx+f3msFNSa35+MkaC1OIy6R1AHhhgQCppPjv9aM15nj+GWP
	nLpMPfTAyjfQ3HhN0FzSAdFPAYV7bckjSMf3xq4RdUcwq68FaoYl8eGPAVr93irUMO+Q0p
	dHhmvtczeENfpn1S1n5L0/X1n2gLW8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731929201;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g15DVHHn8bs6EXS1yY2Zn0UBmTSNa17zQ61VWajhxA8=;
	b=txBr2wbNILJH5W0O9x3D6hcXGijJSqZw13bH0kiAMVRpH4VpqZNhAN8fb7vncieN/6hat/
	TF72wcvpnDqrjGCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731929200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g15DVHHn8bs6EXS1yY2Zn0UBmTSNa17zQ61VWajhxA8=;
	b=QRFMZIAup1JpeaBKWskOgIAGCk3zttWecZI12THGmSQUpuEFTWW/m8W3Oni7PDGOJ377SL
	48jcrQrNuWm3L4gSfn8+FkuweuLON6q2G6Z3/MEq/vwhO+v2zEcQOrNGyPYq89HG7Z81M/
	mE4X1XZOtIIGQoOeRmOo8aZFzKZ2G4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731929200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g15DVHHn8bs6EXS1yY2Zn0UBmTSNa17zQ61VWajhxA8=;
	b=wKJvDDBrZTIk599NS3DqpekqNOtRQMZJLR50iSm8FBKo/ryRpm37HvY06vFjmqeLPNzbxM
	IbsW212ZiZRnHWDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB11E1376E;
	Mon, 18 Nov 2024 11:26:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JF0tNXAkO2fpQAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 18 Nov 2024 11:26:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8120AA0984; Mon, 18 Nov 2024 12:26:32 +0100 (CET)
Date: Mon, 18 Nov 2024 12:26:32 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: move getattr in inode_operations to a more commonly
 read area
Message-ID: <20241118112632.gfnhr7ldcjdi6d2z@quack3>
References: <20241118002024.451858-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118002024.451858-1-mjguzik@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.78 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.18)[-0.922];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.78
X-Spam-Flag: NO

On Mon 18-11-24 01:20:24, Mateusz Guzik wrote:
> Notabaly occupied by lookup, get_link and permission.
> 
> This pushes unlink to another cache line, otherwise the layout is the
> same on that front.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
> 
> Probably more can be done to rearrange struct. If someone is down to do
> it, I'm happy with this patch being dropped.

This makes some sense to me although I'd like to establish some higher
level guidelines (and document them in a comment) about what goes where in
the inode_operations struct. A lot of accesses to inode->i_op actually do
get optimized away with inode->i_opflags (e.g. frequent stuff like
.permission or .get_inode_acl) so there are actually high chances there's
only one access to inode->i_op for the operation we are doing and in such
case the ordering inside inode_operations doesn't really matter (it's
likely cache cold anyway). So I'm somewhat uncertain what the right
grouping should be and if it matters at all.

								Honza

> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 7e29433c5ecc..972147da71f9 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2140,6 +2140,8 @@ struct inode_operations {
>  	const char * (*get_link) (struct dentry *, struct inode *, struct delayed_call *);
>  	int (*permission) (struct mnt_idmap *, struct inode *, int);
>  	struct posix_acl * (*get_inode_acl)(struct inode *, int, bool);
> +	int (*getattr) (struct mnt_idmap *, const struct path *,
> +			struct kstat *, u32, unsigned int);
>  
>  	int (*readlink) (struct dentry *, char __user *,int);
>  
> @@ -2157,8 +2159,6 @@ struct inode_operations {
>  	int (*rename) (struct mnt_idmap *, struct inode *, struct dentry *,
>  			struct inode *, struct dentry *, unsigned int);
>  	int (*setattr) (struct mnt_idmap *, struct dentry *, struct iattr *);
> -	int (*getattr) (struct mnt_idmap *, const struct path *,
> -			struct kstat *, u32, unsigned int);
>  	ssize_t (*listxattr) (struct dentry *, char *, size_t);
>  	int (*fiemap)(struct inode *, struct fiemap_extent_info *, u64 start,
>  		      u64 len);
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

