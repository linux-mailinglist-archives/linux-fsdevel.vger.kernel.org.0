Return-Path: <linux-fsdevel+bounces-37728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAEF9F6550
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 12:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED591883D76
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 11:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C5519F42C;
	Wed, 18 Dec 2024 11:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gqjoDTOm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="c1v+eBde";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gqjoDTOm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="c1v+eBde"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FE7193079;
	Wed, 18 Dec 2024 11:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734522677; cv=none; b=YuARY6+CtMxEKbEO2AYpuZqM4b8YP6VwFCzgrLkDB36tE9xofTQrXoww3ixUtKTkdIKjJBYNV1bOuTYxmVBfRkgGRQ/Pe+MRPDP6A2sOo+4TYQAkYEluSWJl0a54HSjZLpH+p0tCesjEFKWjZda5vD9sdTC7dWPnnWGyJjfGu4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734522677; c=relaxed/simple;
	bh=dOc6ynsGrNXlFjP3UqkLc3zkRio+vMtQxovi1q/sDgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5dsifUMHZjPBGrCOHMCwUWddPhIvY6P5UyjDP7+ZKLyg+QklFGaTBsdqE4XJmhnKp9byYnzEjXOkAvLd+vfpPHgXH7BYZVEiSHnmwIWFWnFUXNFu2/Dw+LQPs8YEqSHQbBrAWUXqby34xzT9XyMofvQGYyOt6uqzQFFWDe4Xdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gqjoDTOm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=c1v+eBde; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gqjoDTOm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=c1v+eBde; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8DB8F2116F;
	Wed, 18 Dec 2024 11:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734522672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VoNEmgPK/5aE75gQC52NkYriqOzJTtQfnYVxCB4es6o=;
	b=gqjoDTOmTAw6yKPi6QiBnx8Xb2mTBdVqazNTsbZIggL/fi38sfisLDscIghBGmTZU5C9Zi
	kLeIVOXzAgZ1X8GeBYDSk/WJ17+5GNJ/5LpSYYcYRBslEeuzGpqHjPx+aHiE09J332VDJc
	Y3QzEhYBwyC/JhzE61iPfxiEI7NYNiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734522672;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VoNEmgPK/5aE75gQC52NkYriqOzJTtQfnYVxCB4es6o=;
	b=c1v+eBdeM/vwL9eLqeVqdhL9bUaxdxQxTK27bsY/tkLIKI7lDgk+fBQYzGln2FdlbRichQ
	1jMOuJ7kHZnd6TDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734522672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VoNEmgPK/5aE75gQC52NkYriqOzJTtQfnYVxCB4es6o=;
	b=gqjoDTOmTAw6yKPi6QiBnx8Xb2mTBdVqazNTsbZIggL/fi38sfisLDscIghBGmTZU5C9Zi
	kLeIVOXzAgZ1X8GeBYDSk/WJ17+5GNJ/5LpSYYcYRBslEeuzGpqHjPx+aHiE09J332VDJc
	Y3QzEhYBwyC/JhzE61iPfxiEI7NYNiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734522672;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VoNEmgPK/5aE75gQC52NkYriqOzJTtQfnYVxCB4es6o=;
	b=c1v+eBdeM/vwL9eLqeVqdhL9bUaxdxQxTK27bsY/tkLIKI7lDgk+fBQYzGln2FdlbRichQ
	1jMOuJ7kHZnd6TDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79A63132EA;
	Wed, 18 Dec 2024 11:51:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UuqpHTC3YmcccwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 18 Dec 2024 11:51:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 27B8CA0935; Wed, 18 Dec 2024 12:51:12 +0100 (CET)
Date: Wed, 18 Dec 2024 12:51:12 +0100
From: Jan Kara <jack@suse.cz>
To: nicolas.bouchinet@clip-os.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
	Joel Granados <j.granados@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Neil Horman <nhorman@tuxdriver.com>, Lin Feng <linf@wangsu.com>,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v3 1/2] coredump: Fixes core_pipe_limit sysctl
 proc_handler
Message-ID: <20241218115112.su4gdcdwcbaoz5y2@quack3>
References: <20241217132908.38096-1-nicolas.bouchinet@clip-os.org>
 <20241217132908.38096-2-nicolas.bouchinet@clip-os.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217132908.38096-2-nicolas.bouchinet@clip-os.org>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 17-12-24 14:29:06, nicolas.bouchinet@clip-os.org wrote:
> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> 
> proc_dointvec converts a string to a vector of signed int, which is
> stored in the unsigned int .data core_pipe_limit.
> It was thus authorized to write a negative value to core_pipe_limit
> sysctl which once stored in core_pipe_limit, leads to the signed int
> dump_count check against core_pipe_limit never be true. The same can be
> achieved with core_pipe_limit set to INT_MAX.
> 
> Any negative write or >= to INT_MAX in core_pipe_limit sysctl would
> hypothetically allow a user to create very high load on the system by
> running processes that produces a coredump in case the core_pattern
> sysctl is configured to pipe core files to user space helper.
> Memory or PID exhaustion should happen before but it anyway breaks the
> core_pipe_limit semantic.
> 
> This commit fixes this by changing core_pipe_limit sysctl's proc_handler
> to proc_dointvec_minmax and bound checking between SYSCTL_ZERO and
> SYSCTL_INT_MAX.
> 
> Fixes: a293980c2e26 ("exec: let do_coredump() limit the number of concurrent dumps to pipes")
> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/coredump.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 7f12ff6ad1d3e..c3a74dd194e69 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -1024,7 +1024,9 @@ static struct ctl_table coredump_sysctls[] = {
>  		.data		= &core_pipe_limit,
>  		.maxlen		= sizeof(unsigned int),
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_INT_MAX,
>  	},
>  	{
>  		.procname       = "core_file_note_size_limit",
> -- 
> 2.47.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

