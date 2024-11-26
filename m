Return-Path: <linux-fsdevel+bounces-35894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3621D9D963E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 12:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1D21624B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 11:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A521CEAC7;
	Tue, 26 Nov 2024 11:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IvxGSZso";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CvXjlBoM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IvxGSZso";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CvXjlBoM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CD91CB528;
	Tue, 26 Nov 2024 11:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732620425; cv=none; b=eWKl9ZO6Ojr5Fg9N75MFKhp9CpdxBfRSf3GKvO5ikqlnu4aC70EUlTOzFxTrmJF6B9GT6oUjfZhlijClPhG7tsqwBUnEHPwnS9GQQ9Ojm/EFdOUb/gk4vTKxRhZSSF6W19U3tWt+2eIwtPfhGaQXX5ZWVh8ciGaPLiEQ8yvziS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732620425; c=relaxed/simple;
	bh=6iMzTEfVKw/LtTb4zloBzUXHSCWS/fv4fXDWAD9CSRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IA+aexbo78yNTS4a2nzRXUTpGAceKWh8iDww1O0cB5yNaIQs/pU4DONmtXxWQD0EETbX80rnK0AEbrW8q9Cj7G07dGVgozcxbLo9wcFalFbyTVGjpfWtW6/x5ct4TAy69B7UechhESU8MfnOlnw7wCwx6bDBc89983pwW++lUXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IvxGSZso; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CvXjlBoM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IvxGSZso; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CvXjlBoM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6378B1F745;
	Tue, 26 Nov 2024 11:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732620421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8xbS911qITTk8XabhSeP8+9EBPxIdUoUVxhdaYF6LXc=;
	b=IvxGSZsoRK9fXW+wKzAW4yaQWhn5dXihVzlAO0Vwo94XUT1IY7vcGPCdbdZphZ5fqvjzqs
	8Jscd3V6pXmn2Z2ong8wSd3JRh+rSRN/++DrxhkdDB+LXE8OsDLEq+NPLDAmBnFg4FaIaD
	x/I2hn8IHFktM8aVEZkMO9cmz1xCcz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732620421;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8xbS911qITTk8XabhSeP8+9EBPxIdUoUVxhdaYF6LXc=;
	b=CvXjlBoMaba4YwgVQGvlTU3dhyFYo+0dnJpXQxDmSQQ2jGf+5elksND05MfHp8X5g9/1g2
	gO37qcM09XrMzyBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732620421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8xbS911qITTk8XabhSeP8+9EBPxIdUoUVxhdaYF6LXc=;
	b=IvxGSZsoRK9fXW+wKzAW4yaQWhn5dXihVzlAO0Vwo94XUT1IY7vcGPCdbdZphZ5fqvjzqs
	8Jscd3V6pXmn2Z2ong8wSd3JRh+rSRN/++DrxhkdDB+LXE8OsDLEq+NPLDAmBnFg4FaIaD
	x/I2hn8IHFktM8aVEZkMO9cmz1xCcz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732620421;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8xbS911qITTk8XabhSeP8+9EBPxIdUoUVxhdaYF6LXc=;
	b=CvXjlBoMaba4YwgVQGvlTU3dhyFYo+0dnJpXQxDmSQQ2jGf+5elksND05MfHp8X5g9/1g2
	gO37qcM09XrMzyBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5450A13890;
	Tue, 26 Nov 2024 11:27:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eDyVFIWwRWcTOgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 26 Nov 2024 11:27:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F3575A08CA; Tue, 26 Nov 2024 12:26:56 +0100 (CET)
Date: Tue, 26 Nov 2024 12:26:56 +0100
From: Jan Kara <jack@suse.cz>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Eric Sandeen <sandeen@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] fs_parser: update mount_api doc to match function
 signature
Message-ID: <20241126112656.e77b263dvznqcvbf@quack3>
References: <20241125215021.231758-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125215021.231758-1-rdunlap@infradead.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Mon 25-11-24 13:50:21, Randy Dunlap wrote:
> Add the missing 'name' parameter to the mount_api documentation for
> fs_validate_description().
> 
> Fixes: 96cafb9ccb15 ("fs_parser: remove fs_parameter_description name field")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Eric Sandeen <sandeen@redhat.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  Documentation/filesystems/mount_api.rst |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- linux-next-20241122.orig/Documentation/filesystems/mount_api.rst
> +++ linux-next-20241122/Documentation/filesystems/mount_api.rst
> @@ -770,7 +770,8 @@ process the parameters it is given.
>  
>     * ::
>  
> -       bool fs_validate_description(const struct fs_parameter_description *desc);
> +       bool fs_validate_description(const char *name,
> +                                    const struct fs_parameter_description *desc);
>  
>       This performs some validation checks on a parameter description.  It
>       returns true if the description is good and false if it is not.  It will
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

