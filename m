Return-Path: <linux-fsdevel+bounces-69782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AD1C84EF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 13:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F053AB04A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 12:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5330E1D5151;
	Tue, 25 Nov 2025 12:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="axKoU+eN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5yxu6AZQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="axKoU+eN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5yxu6AZQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DE71DA23
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 12:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764072961; cv=none; b=OrGUQnIcRR7jlH/yLKH7/kk+oNfZd5zxcNko4yqw8/QLK/vPBUYZ5T8YKSV0iYjZTZRI8YlStygVZz82JstfENGGoAo4Y9Y3exBi6SUU5TYwjbTqnWzQSmYWFCqtOiVbipdjTxG50WO+4QdEUJiYd2ZIObbDMMMMuLngdPikd7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764072961; c=relaxed/simple;
	bh=bh26hkF3GQwbVU8ieFzEIfqPU0QMVoD2urIr2PZLM/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxN8643pOS18OrHoCBmmm61WRXWCRtwncsBKAcN3jlvLHyEI+auM1zdiVUPXmdcZiFk9eBWPFnOgLhQFort7/9PV/dqyAhdxfOzZkxnuOtTzKQzbRD6vv/Y12oU/xX97O9HjyCOmT4Wvdwp7w4SotP+VPUHgE9qt4osf6AlsxZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=axKoU+eN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5yxu6AZQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=axKoU+eN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5yxu6AZQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5E9B1227DF;
	Tue, 25 Nov 2025 12:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764072958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+bm8jHBTZl4oIysmpAy9dxdzwt7zdA9MuzhqsKlVlEk=;
	b=axKoU+eNHOIysK1H/ojjPM2PyJiC82FVjP8p+i5i1uj/2VLk9c6AmR7AdHIHHVyA6sPEKt
	QqewfJQCRan8cf3SQnf3dlNK7rhFnEVp/latH0rmwlw0eo510z8TuIPspNN/GqmONlBsRW
	wWUoLqMRqNuExWN2uknWD10uSU04sVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764072958;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+bm8jHBTZl4oIysmpAy9dxdzwt7zdA9MuzhqsKlVlEk=;
	b=5yxu6AZQLXIxha7e8EkPYbC8yLGOENIqKLh0AKFJliP3KrS0ZQMzv10Ayuf4hDRqk071Gv
	vaBZcJPG7QlJp4DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764072958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+bm8jHBTZl4oIysmpAy9dxdzwt7zdA9MuzhqsKlVlEk=;
	b=axKoU+eNHOIysK1H/ojjPM2PyJiC82FVjP8p+i5i1uj/2VLk9c6AmR7AdHIHHVyA6sPEKt
	QqewfJQCRan8cf3SQnf3dlNK7rhFnEVp/latH0rmwlw0eo510z8TuIPspNN/GqmONlBsRW
	wWUoLqMRqNuExWN2uknWD10uSU04sVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764072958;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+bm8jHBTZl4oIysmpAy9dxdzwt7zdA9MuzhqsKlVlEk=;
	b=5yxu6AZQLXIxha7e8EkPYbC8yLGOENIqKLh0AKFJliP3KrS0ZQMzv10Ayuf4hDRqk071Gv
	vaBZcJPG7QlJp4DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 546923EA63;
	Tue, 25 Nov 2025 12:15:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9iqYFP6dJWn/YQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Nov 2025 12:15:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 162B5A0C7D; Tue, 25 Nov 2025 13:15:54 +0100 (CET)
Date: Tue, 25 Nov 2025 13:15:54 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 04/47] fhandle: convert do_handle_open() to
 FD_PREPARE()
Message-ID: <fpewtpqf6d2pugj4sqe2roq5pamyp4zpkmcfetecl6ornikpre@4vlacmi5iaay>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
 <20251123-work-fd-prepare-v4-4-b6efa1706cfd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251123-work-fd-prepare-v4-4-b6efa1706cfd@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,kernel.org,gmail.com,kernel.dk];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Sun 23-11-25 17:33:22, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Subject should have FD_ADD() but otherwise looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fhandle.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 052f9c9368fb..3de1547ec9d4 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -404,32 +404,28 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
>  	return retval;
>  }
>  
> +static struct file *file_open_handle(struct path *path, int open_flag)
> +{
> +	const struct export_operations *eops;
> +
> +	eops = path->mnt->mnt_sb->s_export_op;
> +	if (eops->open)
> +		return eops->open(path, open_flag);
> +
> +	return file_open_root(path, "", open_flag, 0);
> +}
> +
>  static long do_handle_open(int mountdirfd, struct file_handle __user *ufh,
>  			   int open_flag)
>  {
> -	long retval = 0;
> +	long retval;
>  	struct path path __free(path_put) = {};
> -	struct file *file;
> -	const struct export_operations *eops;
>  
>  	retval = handle_to_path(mountdirfd, ufh, &path, open_flag);
>  	if (retval)
>  		return retval;
>  
> -	CLASS(get_unused_fd, fd)(open_flag);
> -	if (fd < 0)
> -		return fd;
> -
> -	eops = path.mnt->mnt_sb->s_export_op;
> -	if (eops->open)
> -		file = eops->open(&path, open_flag);
> -	else
> -		file = file_open_root(&path, "", open_flag, 0);
> -	if (IS_ERR(file))
> -		return PTR_ERR(file);
> -
> -	fd_install(fd, file);
> -	return take_fd(fd);
> +	return FD_ADD(open_flag, file_open_handle(&path, open_flag));
>  }
>  
>  /**
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

