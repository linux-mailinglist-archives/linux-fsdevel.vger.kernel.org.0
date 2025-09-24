Return-Path: <linux-fsdevel+bounces-62560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2759B998E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 13:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6291916F7D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 11:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F9A2E6CA7;
	Wed, 24 Sep 2025 11:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mlF5EbSt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gAGzrb+j";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mlF5EbSt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gAGzrb+j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCD02E6CCF
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 11:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758712386; cv=none; b=om3ZHykQ6hl3+CzFlSdG+zCUkyMGVBx4D3Ahy3WSuaDKevgpCxiNGU/bFLHBzAuNBfoTQGgW8da9l4AyaYT0MQ69x96z0p4ub+k+eoZnmuBlkGxmbQrJQ+MkLvcHk3YOLGAFnRm1bzBrtTVf5/7UTxXy+SRzeelt8ywiyPaRkuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758712386; c=relaxed/simple;
	bh=AFAe+VmdyDCcmv0aoRbIhZs5xUtexs1CNMTnJxQiHF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8h+3hIisysMhPnxaIJYsNEPVfP1eD+ANzx7TWTnOksY/Oe80gXHzRZqzNjiMDkrp+rcved5EvqV1gKZ8XJqTyR+FQnOFsH2ObWqV9CGFeZUs400LtrFtVkB12K2VYzyxeda97jLtOiMpnYJswN5i7hmKy3R0nsc2I1aLZGGeTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mlF5EbSt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gAGzrb+j; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mlF5EbSt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gAGzrb+j; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 66A0C33D33;
	Wed, 24 Sep 2025 11:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758712383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/55ltNxb+GNx2t7BibA+u0KJI5XQTXg/74gfBe8uGk4=;
	b=mlF5EbStewDVxqCoY8qE6dQCuI5EGBrvLa+YTZ24JeBg/S3GtLCZwX6OU8+EnEV+n+poId
	gL6tg6ZuWfzy9CNLWwF/7WAgQpb3/DhKfzbCuK1cZFfLWtPnBpeYCj4KwSnPY4jDvxeibM
	QFnzqDmFckskafTVMFfDuRXhZT37ucI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758712383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/55ltNxb+GNx2t7BibA+u0KJI5XQTXg/74gfBe8uGk4=;
	b=gAGzrb+j50dNNHKWttXvERIBEWwS8L6/29wKHXHY0tsbIkdVI907mNcczDWywdHNuQ3V31
	EaGeS5vEaeVGHgAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758712383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/55ltNxb+GNx2t7BibA+u0KJI5XQTXg/74gfBe8uGk4=;
	b=mlF5EbStewDVxqCoY8qE6dQCuI5EGBrvLa+YTZ24JeBg/S3GtLCZwX6OU8+EnEV+n+poId
	gL6tg6ZuWfzy9CNLWwF/7WAgQpb3/DhKfzbCuK1cZFfLWtPnBpeYCj4KwSnPY4jDvxeibM
	QFnzqDmFckskafTVMFfDuRXhZT37ucI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758712383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/55ltNxb+GNx2t7BibA+u0KJI5XQTXg/74gfBe8uGk4=;
	b=gAGzrb+j50dNNHKWttXvERIBEWwS8L6/29wKHXHY0tsbIkdVI907mNcczDWywdHNuQ3V31
	EaGeS5vEaeVGHgAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58E6813A78;
	Wed, 24 Sep 2025 11:13:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w9BsFT/S02gVOAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Sep 2025 11:13:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0A8C7A0A9A; Wed, 24 Sep 2025 13:12:59 +0200 (CEST)
Date: Wed, 24 Sep 2025 13:12:58 +0200
From: Jan Kara <jack@suse.cz>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Subject: Re: [PATCH] nsfs: reject file handles with invalid inode number
Message-ID: <6xveadhfw4mznkxo653oa5xnfl2jdwvhiah4if6mcjeqlmzelo@tov4lqlczoas>
References: <20250924012815.1096559-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924012815.1096559-1-kartikey406@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[9eefe09bedd093f156c2];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,appspotmail.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Wed 24-09-25 06:58:15, Deepanshu Kartikey wrote:
> Reject nsfs file handles that claim to have inode number 0, as no
> legitimate namespace can have inode 0. This prevents a warning in
> nsfs_fh_to_dentry() when open_by_handle_at() is called with malformed
> file handles.
> 
> The issue occurs when userspace provides a file handle with valid
> namespace type and ID but claims the namespace has inode number 0.
> The namespace lookup succeeds but triggers VFS_WARN_ON_ONCE() when
> comparing the real inode number against the impossible claim of 0.
> 
> Since inode 0 is reserved in all filesystems and no namespace can
> legitimately have inode 0, we can safely reject such handles early
> to prevent reaching the consistency check that triggers the warning.
> 
> Testing confirmed that other invalid inode numbers (1, 255) do not
> trigger the same issue, indicating this is specific to inode 0 rather
> than a general problem with incorrect inode numbers.

Thanks for report and the analysis but looking at the code I'm confused.
How come that if the filehandle has correct 'id' but incorrect 'inum', it
doesn't trigger the warning? I think the check:

VFS_WARN_ON_ONCE(ns->inum != fid->ns_inum);

should just be turned into:

	/* Someone is playing games and passing invalid file handles? */
	if (ns->inum != fid->ns_inum)
		return NULL;

								Honza
> 
> 
> Reported-by: syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
> Tested-by: syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> 
> ---
>  fs/nsfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nsfs.c b/fs/nsfs.c
> index 32cb8c835a2b..42672cec293c 100644
> --- a/fs/nsfs.c
> +++ b/fs/nsfs.c
> @@ -469,7 +469,8 @@ static struct dentry *nsfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
>  
>  	if (fh_len < NSFS_FID_SIZE_U32_VER0)
>  		return NULL;
> -
> +	if (fid->ns_inum == 0)
> +		return NULL;
>  	/* Check that any trailing bytes are zero. */
>  	if ((fh_len > NSFS_FID_SIZE_U32_LATEST) &&
>  	    memchr_inv((void *)fid + NSFS_FID_SIZE_U32_LATEST, 0,
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

