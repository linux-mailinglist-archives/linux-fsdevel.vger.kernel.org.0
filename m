Return-Path: <linux-fsdevel+bounces-10001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EA3846F5B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 12:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CA09B2DEC3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 11:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591F313EFFC;
	Fri,  2 Feb 2024 11:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NU1JurFM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ndxrzkpL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NU1JurFM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ndxrzkpL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EA260270
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 11:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874249; cv=none; b=hxHbkmI5Fqq3LO3AeSDe8QsK7DElENo3ldTYqa9X4B0OeDRghAUjZdtk6/YwxFh4hRXpDQIXiNkTgcXSfGR/+dmtdhoQouQPUwbHR+8QJL6gyO7HBQzqokVrLw8WPxSzlrDpAaA5kFw3Uzgn8TG4TkuZnYNI7Qm/FsMUQOt/zXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874249; c=relaxed/simple;
	bh=Er34jIHCzsIQZUPCLaAUalyv5xVq5PX2koiYdiYMB/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N154QU1LzxUgdSPk8Gp3KL8X3wJkjYbuSq6me8nyapGYZqdcy/sP72Ww9VgBrIx6RCv/tyWte9W9PBL5D0CrLdSMgPVTcJ6trMJevKzI0WOruNQu98u/DIe+f7o+tSPkciSVPdvzlID+4V2UtaUSqeDtvrIA/o62/BV9lC+v4Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NU1JurFM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ndxrzkpL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NU1JurFM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ndxrzkpL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C469D22074;
	Fri,  2 Feb 2024 11:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706874245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=11sMjv2FuQC81N0pfpsNQBIZ/rh3tmrU+ebLXx7eORY=;
	b=NU1JurFMlLfy7zGBV7P+Ht/WJbKCWJZIPdHfdeXdFbCW5g+2keWpHKpXDIQ4MMp3gNW/NC
	pW0vHWe58eCwnBG/sX7R/JHUg+BG+cv+dZoTscZ28UzSOZfzmsOilPNG5V+NhD/OMqzPFh
	oCatjXvgvHXwHPA3q3G39fegs0gIGfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706874245;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=11sMjv2FuQC81N0pfpsNQBIZ/rh3tmrU+ebLXx7eORY=;
	b=ndxrzkpLVjIUIXgD4EYMNEQoyIfVzhxvhzuh+pUlsjAed/jEpnG2E0aeQZPT3tFKloug4r
	RFrjtSX9foTogbBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706874245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=11sMjv2FuQC81N0pfpsNQBIZ/rh3tmrU+ebLXx7eORY=;
	b=NU1JurFMlLfy7zGBV7P+Ht/WJbKCWJZIPdHfdeXdFbCW5g+2keWpHKpXDIQ4MMp3gNW/NC
	pW0vHWe58eCwnBG/sX7R/JHUg+BG+cv+dZoTscZ28UzSOZfzmsOilPNG5V+NhD/OMqzPFh
	oCatjXvgvHXwHPA3q3G39fegs0gIGfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706874245;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=11sMjv2FuQC81N0pfpsNQBIZ/rh3tmrU+ebLXx7eORY=;
	b=ndxrzkpLVjIUIXgD4EYMNEQoyIfVzhxvhzuh+pUlsjAed/jEpnG2E0aeQZPT3tFKloug4r
	RFrjtSX9foTogbBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9848139AB;
	Fri,  2 Feb 2024 11:44:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mE1DLYXVvGWecwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 02 Feb 2024 11:44:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6485BA0809; Fri,  2 Feb 2024 12:44:05 +0100 (CET)
Date: Fri, 2 Feb 2024 12:44:05 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] remap_range: merge do_clone_file_range() into
 vfs_clone_file_range()
Message-ID: <20240202114405.xvgo5zbrhhlskwqk@quack3>
References: <20240202102258.1582671-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202102258.1582671-1-amir73il@gmail.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NU1JurFM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ndxrzkpL
X-Spamd-Result: default: False [-4.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C469D22074
X-Spam-Level: 
X-Spam-Score: -4.31
X-Spam-Flag: NO

On Fri 02-02-24 12:22:58, Amir Goldstein wrote:
> commit dfad37051ade ("remap_range: move permission hooks out of
> do_clone_file_range()") moved the permission hooks from
> do_clone_file_range() out to its caller vfs_clone_file_range(),
> but left all the fast sanity checks in do_clone_file_range().
> 
> This makes the expensive security hooks be called in situations
> that they would not have been called before (e.g. fs does not support
> clone).
> 
> The only reason for the do_clone_file_range() helper was that overlayfs
> did not use to be able to call vfs_clone_file_range() from copy up
> context with sb_writers lock held.  However, since commit c63e56a4a652
> ("ovl: do not open/llseek lower file with upper sb_writers held"),
> overlayfs just uses an open coded version of vfs_clone_file_range().
> 
> Merge_clone_file_range() into vfs_clone_file_range(), restoring the
> original order of checks as it was before the regressing commit and adapt
> the overlayfs code to call vfs_clone_file_range() before the permission
> hooks that were added by commit ca7ab482401c ("ovl: add permission hooks
> outside of do_splice_direct()").
> 
> Note that in the merge of do_clone_file_range(), the file_start_write()
> context was reduced to cover ->remap_file_range() without holding it
> over the permission hooks, which was the reason for doing the regressing
> commit in the first place.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202401312229.eddeb9a6-oliver.sang@intel.com
> Fixes: dfad37051ade ("remap_range: move permission hooks out of do_clone_file_range()")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Nice and looks good to me. One curious question below but feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index b8e25ca51016..8586e2f5d243 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -265,20 +265,18 @@ static int ovl_copy_up_file(struct ovl_fs *ofs, struct dentry *dentry,
>  	if (IS_ERR(old_file))
>  		return PTR_ERR(old_file);
>  
> +	/* Try to use clone_file_range to clone up within the same fs */
> +	cloned = vfs_clone_file_range(old_file, 0, new_file, 0, len, 0);
> +	if (cloned == len)
> +		goto out_fput;
> +
> +	/* Couldn't clone, so now we try to copy the data */
>  	error = rw_verify_area(READ, old_file, &old_pos, len);
>  	if (!error)
>  		error = rw_verify_area(WRITE, new_file, &new_pos, len);
>  	if (error)
>  		goto out_fput;

Do we need to keep these rw_verify_area() checks here when
vfs_clone_file_range() already did remap_verify_area()?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

