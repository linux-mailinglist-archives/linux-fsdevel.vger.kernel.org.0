Return-Path: <linux-fsdevel+bounces-33457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF9C9B9016
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 12:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12CF281BAA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 11:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D9C199E94;
	Fri,  1 Nov 2024 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LnFijO1b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lQMMI2OC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TV+HZOKX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TxwhBeBU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7FA17C222;
	Fri,  1 Nov 2024 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730459733; cv=none; b=BaOCVf1rHbkCaY8Hy3/hP9jEtU/IACDBZ1ghtBuoCysleX5bnfgRLs3pxVOLHnPJu+Knm31IRUhziha83ags2FBRjJFwKtnLTBvOo6aS1qa1bMYtfk73tQq+U5MCrVyDJH+d4Nr6T70P3z29tSOD/YvuRs7tAVQNa334JlOMrkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730459733; c=relaxed/simple;
	bh=ZbZwh1+HLBmTjLP+BQFP6RV11wj+XsX8iNQkRu4nkyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogpl7wDL6ax8OVrKYpj3I40F5A/tBDSd6X0FZ3O1n7V73CpwCU5WVTQdZTr2H9rvLfmZqXOAthUiY6e5b/iMeTUvZTe5LUx2vxivqlvUhYQEauJ2sc7Rq+KRzMJQyywkULNpvklBLlPa9yBX/RwVfVmK/oZEfduX+HXRES4KsxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LnFijO1b; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lQMMI2OC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TV+HZOKX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TxwhBeBU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D2C721F8D9;
	Fri,  1 Nov 2024 11:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730459729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Tw51sNbhuAW1iukB4HQhzSomYPBPu24ktYXjZZdHxc=;
	b=LnFijO1bD5w3yCzKjQgpA7ZOwnCAr8lPINA0A/7r9WUC153WzMVOgDlLuH74cfuuQiC+IW
	428pGvX9bIa6MmUxOVcUxlN4TMIua1KqvzNlEfsKzoJ8ySaSm8BAQFJLckdWeMCPsFqWHe
	1iZL2wnGULWVhXPkXQGZffbQBZOh/3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730459729;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Tw51sNbhuAW1iukB4HQhzSomYPBPu24ktYXjZZdHxc=;
	b=lQMMI2OCIMFyGo6osQjXPb8oK7llBg+9fh4GXWgnpXOZxk8eCFx//UYV+/UiQyh9edpdFV
	paqwlbjbNo0UJJCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TV+HZOKX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=TxwhBeBU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730459728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Tw51sNbhuAW1iukB4HQhzSomYPBPu24ktYXjZZdHxc=;
	b=TV+HZOKXI+PNC1AshP76oKF9bfag6NQ3dBWrE4xJCqSuikaGuUKrhGDIcP31zLj3aTYsuu
	0Sp2aOUD/iyV0/t37NIixB5Cf3KnfeOVqkQgxD8YcfyaZF4ZnfETRlzxCvw0C4RSBofU4H
	bFSvuzGa+JLkPf7AcVViFnmLj3oadWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730459728;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Tw51sNbhuAW1iukB4HQhzSomYPBPu24ktYXjZZdHxc=;
	b=TxwhBeBUxqkA3jdAEZvDwG2vcRrc64zTBigDp113Q0JD5sOWcpyK/d1Fo2GLd+DxjrVq7L
	yUdX6wQpq4bB6jCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8EDC136D9;
	Fri,  1 Nov 2024 11:15:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fyYMMVC4JGfTVwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 01 Nov 2024 11:15:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8B377A0AF4; Fri,  1 Nov 2024 12:15:13 +0100 (CET)
Date: Fri, 1 Nov 2024 12:15:13 +0100
From: Jan Kara <jack@suse.cz>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] ext4: Check for atomic writes support in write
 iter
Message-ID: <20241101111513.mjbkvsl5tk3vyz2d@quack3>
References: <cover.1730437365.git.ritesh.list@gmail.com>
 <ad2255a2fb9a4f5a30e4265ca94b6361db8ee76a.1730437365.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad2255a2fb9a4f5a30e4265ca94b6361db8ee76a.1730437365.git.ritesh.list@gmail.com>
X-Rspamd-Queue-Id: D2C721F8D9
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Fri 01-11-24 12:20:52, Ritesh Harjani (IBM) wrote:
> Let's validate the given constraints for atomic write request.
> Otherwise it will fail with -EINVAL. Currently atomic write is only
> supported on DIO, so for buffered-io it will return -EOPNOTSUPP.
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/file.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index f14aed14b9cf..a7b9b9751a3f 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -692,6 +692,20 @@ ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	if (IS_DAX(inode))
>  		return ext4_dax_write_iter(iocb, from);
>  #endif
> +
> +	if (iocb->ki_flags & IOCB_ATOMIC) {
> +		size_t len = iov_iter_count(from);
> +		int ret;
> +
> +		if (len < EXT4_SB(inode->i_sb)->s_awu_min ||
> +		    len > EXT4_SB(inode->i_sb)->s_awu_max)
> +			return -EINVAL;
> +
> +		ret = generic_atomic_write_valid(iocb, from);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	if (iocb->ki_flags & IOCB_DIRECT)
>  		return ext4_dio_write_iter(iocb, from);
>  	else
> --
> 2.46.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

