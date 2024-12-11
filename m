Return-Path: <linux-fsdevel+bounces-37076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A21639ED294
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 17:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3E316716D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 16:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CE71DE4EB;
	Wed, 11 Dec 2024 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JCzrzn4N";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r0JdujfP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JCzrzn4N";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r0JdujfP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450AC38DE9;
	Wed, 11 Dec 2024 16:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935706; cv=none; b=oiv6XvkI03idEpZYDsJqzvZ5ZTsYXAihJaLnnT+B7ft0CI++P7gbmNhHH7ZhL6Z9/GQ3P8a3jvXXfHtmYI601LJRaCK4wEADrU6RZPLkETaqTI5bdeX+zpPFIkqaZDMUZWHs2Q52c7u406NfwmlqhB9BAdEqK9EW9lvGECH/sx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935706; c=relaxed/simple;
	bh=Z+faUIpdUj0Nqr728cT8TmlvcXaD3eeCwKNDNhgoqOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRSyn4/u2d1fA0UPFBh1J+50FQML1Nn6VLy9U2CW9by4VJBlTHOTL2yaqmuUXiHTAtYS7J9rJFSXC20BDd6pU446b8VfQtDricmKOEXPVg2f5dPsCKPiPwBbHMoifZD6hcp/asPdYif4hT9gdyfHXMGUAMVwoA7iRqPoN4tpwIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JCzrzn4N; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r0JdujfP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JCzrzn4N; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r0JdujfP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4B90D2117B;
	Wed, 11 Dec 2024 16:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733935702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kVgazgq1PikQ/169F+CRX5eNyOAH+ARoQ+7953vu2/A=;
	b=JCzrzn4NkNwitIrDl6BEfFHTA5bXkjvmDw5mJ2PkaupDO2kdFQwyXAXTvnQ8Fy9XcodufA
	83pNCRi6gT7rpnrSPXh6grzSYo0h/2tPFeUK/9RUevGimcxqUo7UhAFphtl+DchViG1ygo
	gIgRBWd7n/LaePieCt4fCv0G31yYgdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733935702;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kVgazgq1PikQ/169F+CRX5eNyOAH+ARoQ+7953vu2/A=;
	b=r0JdujfPg2zXdNiLJAJ9fV8jIJm+zxrFllPeWFblT+UrxAkeKdb3thwqzmmAR7tuoIIK5R
	hwVocnNyOFdJOOBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JCzrzn4N;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=r0JdujfP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733935702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kVgazgq1PikQ/169F+CRX5eNyOAH+ARoQ+7953vu2/A=;
	b=JCzrzn4NkNwitIrDl6BEfFHTA5bXkjvmDw5mJ2PkaupDO2kdFQwyXAXTvnQ8Fy9XcodufA
	83pNCRi6gT7rpnrSPXh6grzSYo0h/2tPFeUK/9RUevGimcxqUo7UhAFphtl+DchViG1ygo
	gIgRBWd7n/LaePieCt4fCv0G31yYgdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733935702;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kVgazgq1PikQ/169F+CRX5eNyOAH+ARoQ+7953vu2/A=;
	b=r0JdujfPg2zXdNiLJAJ9fV8jIJm+zxrFllPeWFblT+UrxAkeKdb3thwqzmmAR7tuoIIK5R
	hwVocnNyOFdJOOBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 322FC1344A;
	Wed, 11 Dec 2024 16:48:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZZQ6DFbCWWcDXgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 11 Dec 2024 16:48:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DFDC5A0894; Wed, 11 Dec 2024 17:48:21 +0100 (CET)
Date: Wed, 11 Dec 2024 17:48:21 +0100
From: Jan Kara <jack@suse.cz>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] binfmt_elf: Fix potential Oops in load_elf_binary()
Message-ID: <20241211164821.ki4wy4ltffgx677t@quack3>
References: <5952b626-ef08-4293-8a73-f1496af4e987@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5952b626-ef08-4293-8a73-f1496af4e987@stanley.mountain>
X-Rspamd-Queue-Id: 4B90D2117B
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[11];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FREEMAIL_CC(0.00)[gmail.com,zeniv.linux.org.uk,kernel.org,suse.cz,xmission.com,vger.kernel.org,kvack.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,linaro.org:email,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Wed 11-12-24 12:21:39, Dan Carpenter wrote:
> This function call was changed from allow_write_access() which has a NULL
> check to exe_file_allow_write_access() which doesn't.  Check for NULL
> before calling it.
> 
> Fixes: 871387b27c20 ("fs: don't block write during exec on pre-content watched files")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks for noticing! I've opted to change exe_file_allow_write_access() to
check for NULL instead to be 1:1 replacement for allow_write_access().
Because bugs like this one are very easy to introduce.

								Honza

> ---
>  fs/binfmt_elf.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 8054f44d39cf..db9cb4c20125 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1354,9 +1354,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  	kfree(interp_elf_ex);
>  	kfree(interp_elf_phdata);
>  out_free_file:
> -	exe_file_allow_write_access(interpreter);
> -	if (interpreter)
> +	if (interpreter) {
> +		exe_file_allow_write_access(interpreter);
>  		fput(interpreter);
> +	}
>  out_free_ph:
>  	kfree(elf_phdata);
>  	goto out;
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

