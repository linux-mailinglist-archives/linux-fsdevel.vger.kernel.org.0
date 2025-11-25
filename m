Return-Path: <linux-fsdevel+bounces-69787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8BCC84F77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 13:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D0544E377C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 12:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D7830DD08;
	Tue, 25 Nov 2025 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D6WumaNb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WJ+K9tS/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D6WumaNb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WJ+K9tS/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114FD31B11E
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 12:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764073806; cv=none; b=Q4l2ivYubbjHz1LrwL+1FuzJlOxhrTnbTNUZMjd0Lb4mlJawGJXCEY+Af0Rgia4hGa9imtemcRrQyh2N2nPoWwp6xzkYVJFyNjYT7dNH+sDu3H59h71TP8mud8XrxWADwUFLfigFkohdm0gioGpIZWS3lZVQmjUa0JmSxlMQpF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764073806; c=relaxed/simple;
	bh=g2ANMoQkWz1Ye0O441w5jpjtJxiTdGyMIeyZ4uq2mH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrwYSb2h/JklgmsppU7s9lith+JPUboD8RDAJKuZrWToUalR2XCEo1irmq8X1JJqaysgEfk9dmY81BiZlQpUe3Pt00Dx3nR+zwSkMAIp+8WEn6CVwZ5nFlt/Rz592GUjPaUXGBlU8Tzhj3fhjtfiCHOf0tSXhGeRJ7I7jQjPK/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D6WumaNb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WJ+K9tS/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D6WumaNb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WJ+K9tS/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 893E722850;
	Tue, 25 Nov 2025 12:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764073799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u6NC9tfQuIy+U6NguWkDpQ+4JpoP57tNZr80ShfHx6U=;
	b=D6WumaNbD73iOmS0NKO7ruA5/VbFHeTyk7RCmO++m++dcy2QQ66nZfUAxFqUtBzHfRCngu
	BXFV6sEMEdQa9GCyAHrm0g0EqqHgaZldSx8rPHH/Ks/E6tQhy93/7s/3krla6B4t5FnVHQ
	fqjV+rJhIKsie5H1BzmDA53bmXgTy6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764073799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u6NC9tfQuIy+U6NguWkDpQ+4JpoP57tNZr80ShfHx6U=;
	b=WJ+K9tS/4+UxqRbHHDtsoHM+kZR36tKY52nZKHHjDeeWIQjAIjlR8kzZPx8m/StIDZHjCY
	zxuMkIZEmfnTs6Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764073799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u6NC9tfQuIy+U6NguWkDpQ+4JpoP57tNZr80ShfHx6U=;
	b=D6WumaNbD73iOmS0NKO7ruA5/VbFHeTyk7RCmO++m++dcy2QQ66nZfUAxFqUtBzHfRCngu
	BXFV6sEMEdQa9GCyAHrm0g0EqqHgaZldSx8rPHH/Ks/E6tQhy93/7s/3krla6B4t5FnVHQ
	fqjV+rJhIKsie5H1BzmDA53bmXgTy6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764073799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u6NC9tfQuIy+U6NguWkDpQ+4JpoP57tNZr80ShfHx6U=;
	b=WJ+K9tS/4+UxqRbHHDtsoHM+kZR36tKY52nZKHHjDeeWIQjAIjlR8kzZPx8m/StIDZHjCY
	zxuMkIZEmfnTs6Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CF263EA63;
	Tue, 25 Nov 2025 12:29:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +t54HkehJWmgbwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Nov 2025 12:29:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 30D92A0C7D; Tue, 25 Nov 2025 13:29:59 +0100 (CET)
Date: Tue, 25 Nov 2025 13:29:59 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 44/47] file: convert replace_fd() to FD_PREPARE()
Message-ID: <wqi3kssfadsacbk7rwojhz7saom2lzit6knu6auh3eahrthjfk@mpmzuzqgvrmn>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
 <20251123-work-fd-prepare-v4-44-b6efa1706cfd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251123-work-fd-prepare-v4-44-b6efa1706cfd@kernel.org>
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
X-Spam-Level: 

On Sun 23-11-25 17:34:02, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/file.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 28743b742e3c..7ea33a617896 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -1357,28 +1357,25 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
>   */
>  int receive_fd(struct file *file, int __user *ufd, unsigned int o_flags)
>  {
> -	int new_fd;
>  	int error;
>  
>  	error = security_file_receive(file);
>  	if (error)
>  		return error;
>  
> -	new_fd = get_unused_fd_flags(o_flags);
> -	if (new_fd < 0)
> -		return new_fd;
> +	FD_PREPARE(fdf, o_flags, file);
> +	if (fdf.err)
> +		return fdf.err;
> +	get_file(file);

It would seem more consistent with other call sites (and thus more
futureproof) to have:

	FD_PREPARE(fdf, o_flags, get_file(file));
	if (fdf.err)
		return fdf.err;

Otherwise the patch looks good so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

