Return-Path: <linux-fsdevel+bounces-52724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5DBAE6092
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 11:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416FA4C1AB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 09:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84D027AC3D;
	Tue, 24 Jun 2025 09:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LOEosNRd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y0Sis9oZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LOEosNRd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y0Sis9oZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8125827AC48
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 09:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750756603; cv=none; b=WzROhmXlsjleGjBy2AGlm9K40crwqsNVOQdwWW1Bgk0AtqQOGdUthUrGNfMd1PugcGVsfSmtyftgvLiYGRi4zUuWBCw+8CQMeg+UCyr/LqG3jcs3LoPafdFNngfSunK4u6So0W5fgtwHo01khD3g2KnpuHnFxRDz5HnTOQ7RhPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750756603; c=relaxed/simple;
	bh=R6gPBnrT6O1esi5/dK6KL++mrnAUOPOO4ishMYIuf2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2v+RnvraDSrWPd3/yhk2IygmdZdWWO3Cxe7+Vg01glqCdeVASHgLlWxenXeAvxQVuMs6wr9sbJljzVzuu3890gjM84DSLoSLKOwlPZ4ig7+rtQm6S6tANQcTXowN0bQp2LIc6sSLXPcVHwXMf6P9pLlR4GqOf6CbNsiDUPiTP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LOEosNRd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=y0Sis9oZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LOEosNRd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=y0Sis9oZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 71AD221186;
	Tue, 24 Jun 2025 09:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750756599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hqWUfOYwvsQAqwgNGHBNdeocJt3PGL/+fVpAZVjl2so=;
	b=LOEosNRdYuogkpm3C7m5U/+tf20pNdUyxKr8gbBWHfnyou3nk5VbalPMitHnIMONiPV+l9
	ck8KKS8pTsiGQ+xBKgHGhKqOn/HhY+l/hqPUAe2+V3yOohvobIlSSrgi6a1KoFeXPYHYFB
	glTd2EE7BHqkfg/OpbIdPFyvRBbJf/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750756599;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hqWUfOYwvsQAqwgNGHBNdeocJt3PGL/+fVpAZVjl2so=;
	b=y0Sis9oZ+KOW/SY0D1TR6dzV2bP1MNsLPA2w+rh7wsr/gtosp+oDXpUY7YpSVke1SYiSQh
	fTOEQN7oP3bO9ACQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LOEosNRd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=y0Sis9oZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750756599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hqWUfOYwvsQAqwgNGHBNdeocJt3PGL/+fVpAZVjl2so=;
	b=LOEosNRdYuogkpm3C7m5U/+tf20pNdUyxKr8gbBWHfnyou3nk5VbalPMitHnIMONiPV+l9
	ck8KKS8pTsiGQ+xBKgHGhKqOn/HhY+l/hqPUAe2+V3yOohvobIlSSrgi6a1KoFeXPYHYFB
	glTd2EE7BHqkfg/OpbIdPFyvRBbJf/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750756599;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hqWUfOYwvsQAqwgNGHBNdeocJt3PGL/+fVpAZVjl2so=;
	b=y0Sis9oZ+KOW/SY0D1TR6dzV2bP1MNsLPA2w+rh7wsr/gtosp+oDXpUY7YpSVke1SYiSQh
	fTOEQN7oP3bO9ACQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6435A13A96;
	Tue, 24 Jun 2025 09:16:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ItRwGPdsWmjQGQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Jun 2025 09:16:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1D794A0A03; Tue, 24 Jun 2025 11:16:39 +0200 (CEST)
Date: Tue, 24 Jun 2025 11:16:39 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 05/11] fhandle: reflow get_path_anchor()
Message-ID: <nem4nldmws4e6cgbnbc4nbbvq53jtadewspcimztbdeikppeda@ss33vygtetxd>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
 <20250624-work-pidfs-fhandle-v2-5-d02a04858fe3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-work-pidfs-fhandle-v2-5-d02a04858fe3@kernel.org>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 71AD221186
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,suse.cz,gmail.com,ffwll.ch,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01
X-Spam-Level: 

On Tue 24-06-25 10:29:08, Christian Brauner wrote:
> Switch to a more common coding style.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/fhandle.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index d8d32208c621..22edced83e4c 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -170,18 +170,22 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
>  
>  static int get_path_anchor(int fd, struct path *root)
>  {
> +	if (fd >= 0) {
> +		CLASS(fd, f)(fd);
> +		if (fd_empty(f))
> +			return -EBADF;
> +		*root = fd_file(f)->f_path;
> +		path_get(root);
> +		return 0;
> +	}
> +
>  	if (fd == AT_FDCWD) {
>  		struct fs_struct *fs = current->fs;
>  		spin_lock(&fs->lock);
>  		*root = fs->pwd;
>  		path_get(root);
>  		spin_unlock(&fs->lock);
> -	} else {
> -		CLASS(fd, f)(fd);
> -		if (fd_empty(f))
> -			return -EBADF;
> -		*root = fd_file(f)->f_path;
> -		path_get(root);
> +		return 0;
>  	}

This actually introduces a regression that when userspace passes invalid fd
< 0, we'd be returning 0 whereas previously we were returning -EBADF. I
think the return below should be switched to -EBADF to fix that.

>  	return 0;
> 

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

