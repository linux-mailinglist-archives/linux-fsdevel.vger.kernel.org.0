Return-Path: <linux-fsdevel+bounces-28347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAA8969A3C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 12:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBF5EB23FBA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 10:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A661B984F;
	Tue,  3 Sep 2024 10:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HoBNECNb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oB2JvQ8i";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HoBNECNb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oB2JvQ8i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE0D45003
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 10:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359515; cv=none; b=Y5HyIrbdVHN3Ri49kwUFidEMjwMBPiHL1WfWeZXiUQvFw7SdS1yG6QfWL4ptskD+4bo8v0FT/7nvJ8PUndBpYpevoJy5DBfscXxQ4RuiVTEiewpKE5YDFbhbBFtUOEME46Nhi12i+pPlCcMBZx6tyb/pQuc4ymBfFDm7ZkDMkvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359515; c=relaxed/simple;
	bh=ue4lHlQbu6NPGIN+OUHYcbpiHD2nv3vQYTYa3E0EqzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5K9G9cdfgGGg6PYpW6Jb5gZWfR1faV+WcUG2zcYHAsyYI3OfJRgG71AZW2oZDXes+0YN5yZVjX10fEF+ppoxEGZnc5fLPLxaPDZ3cNvGTmjUDCALQeifrktwMEMRgX3Kh/dUBHgALidGBMmSAnchewoDNnRVM3kg21IXhJ7IeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HoBNECNb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oB2JvQ8i; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HoBNECNb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oB2JvQ8i; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 116F81FD66;
	Tue,  3 Sep 2024 10:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725359512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VJKwVJGIH1mhp83Qaz6K58stiBO3QUnfWfrX2YI77Lg=;
	b=HoBNECNbwL0qldaEjrtRzvDNkOPIAl+IaU3NfDJz70ulrKT9lZYa2lYBYdHehlN974FIpv
	bFjLDiwyiYQ1hJKI+R3mgIPMXOfl4H3MPx2HxxViR/oO8qYloY47qFaZ89CmU3ovdlKzD/
	22LqeH7GJ7qdsJM7+wfRKaervVuMMI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725359512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VJKwVJGIH1mhp83Qaz6K58stiBO3QUnfWfrX2YI77Lg=;
	b=oB2JvQ8iJ5W9zrN1dXAKZwH7qw3O8Bpu+EGbQfJjs4rFEdlFVoDQ2FMJFrHDRmbfKwrChs
	U3p6nU1ImfhuKbDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HoBNECNb;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=oB2JvQ8i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725359512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VJKwVJGIH1mhp83Qaz6K58stiBO3QUnfWfrX2YI77Lg=;
	b=HoBNECNbwL0qldaEjrtRzvDNkOPIAl+IaU3NfDJz70ulrKT9lZYa2lYBYdHehlN974FIpv
	bFjLDiwyiYQ1hJKI+R3mgIPMXOfl4H3MPx2HxxViR/oO8qYloY47qFaZ89CmU3ovdlKzD/
	22LqeH7GJ7qdsJM7+wfRKaervVuMMI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725359512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VJKwVJGIH1mhp83Qaz6K58stiBO3QUnfWfrX2YI77Lg=;
	b=oB2JvQ8iJ5W9zrN1dXAKZwH7qw3O8Bpu+EGbQfJjs4rFEdlFVoDQ2FMJFrHDRmbfKwrChs
	U3p6nU1ImfhuKbDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F388D13A80;
	Tue,  3 Sep 2024 10:31:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1rtwO5fl1mYODwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Sep 2024 10:31:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8D7AFA096C; Tue,  3 Sep 2024 12:31:51 +0200 (CEST)
Date: Tue, 3 Sep 2024 12:31:51 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 04/20] s390: remove unused f_version
Message-ID: <20240903103151.ztdnlkbkd5pvfcxe@quack3>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
 <20240830-vfs-file-f_version-v1-4-6d3e4816aa7b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830-vfs-file-f_version-v1-4-6d3e4816aa7b@kernel.org>
X-Rspamd-Queue-Id: 116F81FD66
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,suse.com:email];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Fri 30-08-24 15:04:45, Christian Brauner wrote:
> It's not used so don't bother with it at all.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/s390/char/hmcdrv_dev.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/s390/char/hmcdrv_dev.c b/drivers/s390/char/hmcdrv_dev.c
> index 8d50c894711f..e069dd685899 100644
> --- a/drivers/s390/char/hmcdrv_dev.c
> +++ b/drivers/s390/char/hmcdrv_dev.c
> @@ -186,9 +186,6 @@ static loff_t hmcdrv_dev_seek(struct file *fp, loff_t pos, int whence)
>  	if (pos < 0)
>  		return -EINVAL;
>  
> -	if (fp->f_pos != pos)
> -		++fp->f_version;
> -
>  	fp->f_pos = pos;
>  	return pos;
>  }
> 
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

