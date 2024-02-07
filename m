Return-Path: <linux-fsdevel+bounces-10585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A48F384C7DC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 10:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14CBC1F2A8B5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 09:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6414C224CC;
	Wed,  7 Feb 2024 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v30ZZdlU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Or/maB2h";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v30ZZdlU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Or/maB2h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBE6241E2;
	Wed,  7 Feb 2024 09:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299291; cv=none; b=s9Zb+4b8SQnYZdspDztXJNdNUk+jrpZHLp4aEMPSEGpDuiVGCs7oNTdql8EPYpd8JOiZ6noi99Pfc/SYjLHrT/UM6TOYzYqRT7ify+UzT5BOgq97dY+LhQWYmwtUbdeq/gBsahacx806OmOXcRYlOd913zFRFRHngHNE3GhIAXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299291; c=relaxed/simple;
	bh=vot/1hIXiWBJvw/eZSy6IAEsY+QaIu2gBumlPcUGuBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuH+pU47PiNObAjD7OtWf9X/Ei9AXt5gnXZvz/2QA5gH8tWbWkV/3CkfBojkZG1dFHmrpb1PwPnfsVDYQsiM2VTKStftZs9tvTS6Mhnrf5GYNFYibFtdxMxMYx/HpmFN39Q//D92No/HT6IOQPD07sXBzsVIIUuJ6BRSVm0F+Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v30ZZdlU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Or/maB2h; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v30ZZdlU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Or/maB2h; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 390E91FBB7;
	Wed,  7 Feb 2024 09:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707299288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YTb9O/Fa/X2zuuCVuYrQNHC/06gYLBQwZ4dl1nKzGH0=;
	b=v30ZZdlU2Lu6VlhRFu09os0Mbf1OPtNeIQ2KuLSMVTDAY3XPoGgl4t1JlAp2y9v2UT1a33
	7Q81Tt4IvLJ5yQr2vLKLyGGXd/6On2R5H92HgzM64BCHcNoCT1V/MgZni/yyHifVIbmbBl
	DqXt2UuDW7dMHZQ1xVIdcCU/K0CzkZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707299288;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YTb9O/Fa/X2zuuCVuYrQNHC/06gYLBQwZ4dl1nKzGH0=;
	b=Or/maB2hsQkhta6KyHHi6XBMxbapxixp6KA4tccVfSvpDl8ZD+dT3r5PVyGjc2XWs5W8zj
	v8rA0uX7BYsPiaCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707299288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YTb9O/Fa/X2zuuCVuYrQNHC/06gYLBQwZ4dl1nKzGH0=;
	b=v30ZZdlU2Lu6VlhRFu09os0Mbf1OPtNeIQ2KuLSMVTDAY3XPoGgl4t1JlAp2y9v2UT1a33
	7Q81Tt4IvLJ5yQr2vLKLyGGXd/6On2R5H92HgzM64BCHcNoCT1V/MgZni/yyHifVIbmbBl
	DqXt2UuDW7dMHZQ1xVIdcCU/K0CzkZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707299288;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YTb9O/Fa/X2zuuCVuYrQNHC/06gYLBQwZ4dl1nKzGH0=;
	b=Or/maB2hsQkhta6KyHHi6XBMxbapxixp6KA4tccVfSvpDl8ZD+dT3r5PVyGjc2XWs5W8zj
	v8rA0uX7BYsPiaCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E11F13931;
	Wed,  7 Feb 2024 09:48:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wmM6C9hRw2VLVQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Feb 2024 09:48:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CB02AA0809; Wed,  7 Feb 2024 10:48:07 +0100 (CET)
Date: Wed, 7 Feb 2024 10:48:07 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>, Karel Zak <kzak@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] fs: relax mount_setattr() permission checks
Message-ID: <20240207094807.aqduah7dfxkrq5o2@quack3>
References: <20240206-vfs-mount-rootfs-v1-1-19b335eee133@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206-vfs-mount-rootfs-v1-1-19b335eee133@kernel.org>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

On Tue 06-02-24 11:22:09, Christian Brauner wrote:
> When we added mount_setattr() I added additional checks compared to the
> legacy do_reconfigure_mnt() and do_change_type() helpers used by regular
> mount(2). If that mount had a parent then verify that the caller and the
> mount namespace the mount is attached to match and if not make sure that
> it's an anonymous mount.
> 
> The real rootfs falls into neither category. It is neither an anoymous
> mount because it is obviously attached to the initial mount namespace
> but it also obviously doesn't have a parent mount. So that means legacy
> mount(2) allows changing mount properties on the real rootfs but
> mount_setattr(2) blocks this. I never thought much about this but of
> course someone on this planet of earth changes properties on the real
> rootfs as can be seen in [1].
> 
> Since util-linux finally switched to the new mount api in 2.39 not so
> long ago it also relies on mount_setattr() and that surfaced this issue
> when Fedora 39 finally switched to it. Fix this.
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2256843
> Reported-by: Karel Zak <kzak@redhat.com>
> Cc: stable@vger.kernel.org # v5.12+
> Signed-off-by: Christian Brauner <brauner@kernel.org>

I'm not too confident with subtleties of this code but it looks good to me.
So feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namespace.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 437f60e96d40..fb0286920bce 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4472,10 +4472,15 @@ static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
>  	/*
>  	 * If this is an attached mount make sure it's located in the callers
>  	 * mount namespace. If it's not don't let the caller interact with it.
> -	 * If this is a detached mount make sure it has an anonymous mount
> -	 * namespace attached to it, i.e. we've created it via OPEN_TREE_CLONE.
> +	 *
> +	 * If this mount doesn't have a parent it's most often simply a
> +	 * detached mount with an anonymous mount namespace. IOW, something
> +	 * that's simply not attached yet. But there are apparently also users
> +	 * that do change mount properties on the rootfs itself. That obviously
> +	 * neither has a parent nor is it a detached mount so we cannot
> +	 * unconditionally check for detached mounts.
>  	 */
> -	if (!(mnt_has_parent(mnt) ? check_mnt(mnt) : is_anon_ns(mnt->mnt_ns)))
> +	if (mnt_has_parent(mnt) && !check_mnt(mnt))
>  		goto out;
>  
>  	/*
> 
> ---
> base-commit: 2a42e144dd0b62eaf79148394ab057145afbc3c5
> change-id: 20240206-vfs-mount-rootfs-70aff2e3956d
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

