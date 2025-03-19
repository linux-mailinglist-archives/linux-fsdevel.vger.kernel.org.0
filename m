Return-Path: <linux-fsdevel+bounces-44459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1440A694C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 17:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5676463586
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 16:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4571DF72F;
	Wed, 19 Mar 2025 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M/RWn2nT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Cy2K5V8A";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L6dQW+WE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XWsEXVVg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F9C1DEFC5
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401393; cv=none; b=gvBFVXOZyQeJHJ/TWYFfNNGdA6isCzlhkZHPpCC0gzf8U6rLetNm3QeFtopFKcz5NNx1g/97D9yVKPwhGLAqvoiqgGPtzmieBA4Q398xvmVGxdCe4/tIos7Uld0jWVGTC5nqu7pvhe92RaU4Ag/7VADnDML37gde9qmZtBQDFNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401393; c=relaxed/simple;
	bh=SFwRnGrXO5KGgMQycikweYX/ll3TkCBZ9K24iTTaav4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTxmVZbyh7inUA6x6yDnp0i3R7dbQEuxcmKzdDRbPTHFBxiEX5EHY3+L1lp/ep6Q+NEbrd/LwHXgUjGYuB12HyRWbtw3ybeIlJsbe6n7q1quLTh16M9BcXeKyVomhC93OT7ma26+sQP6DD8Xi98I95FFHUU0eX3HJxy+50Stgpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M/RWn2nT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Cy2K5V8A; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L6dQW+WE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XWsEXVVg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3FFE721C8A;
	Wed, 19 Mar 2025 16:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742401390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ddRoTd0WptMGQ/Wz0t+xfTEL05P9OdBsDkf/zmdxcnA=;
	b=M/RWn2nTT3NUwwjDt7NsEdewu7k2XXz+IkEa60bFFpjq0gDwYW9PmtoSRh22Fn+pY5G7/7
	tWYrtDAjuit3vGYPxZz4TUeyL6zwzTRyRMGmBwB7CW3qA5qoG9vOL+7NAZQXE9gcG10YQN
	Bf2no+RiVgjxYsE2pVFuABn+QM5GJhs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742401390;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ddRoTd0WptMGQ/Wz0t+xfTEL05P9OdBsDkf/zmdxcnA=;
	b=Cy2K5V8Adi6q4EIc7S8AWir3R+uEzU/roFqxkH76WBcn47ydmpjoSew+oW9W42jK8w3l3R
	LF00Ei+0B/yu3hDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742401389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ddRoTd0WptMGQ/Wz0t+xfTEL05P9OdBsDkf/zmdxcnA=;
	b=L6dQW+WEaDkDbxs9I54eXReQ1/mtJskkRKHOpxvUosqhFiTqUl/SZb7JWCt4vRbjQEbBIr
	3xpOPgpXjv2xNm4Ib5mJ+FFGOf4BfKq3MiCQ6rVEbDOxcXYI2Invv2pJD3BGJf2XnJ4pAp
	n0yHeWfk29UQsr8FyF92PTlVjczrT9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742401389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ddRoTd0WptMGQ/Wz0t+xfTEL05P9OdBsDkf/zmdxcnA=;
	b=XWsEXVVgHQml7A4UbbuYpyhMJkgdVjBaNEsffH8T8jk9TAywyErjyzL2IaqlUzvT8kE/X7
	yuKto5sLxOyLG7Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30DB413A2C;
	Wed, 19 Mar 2025 16:23:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AxOgC23v2mdAWwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 19 Mar 2025 16:23:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D2C2BA08D2; Wed, 19 Mar 2025 17:23:08 +0100 (CET)
Date: Wed, 19 Mar 2025 17:23:08 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: predict not reaching the limit in alloc_empty_file()
Message-ID: <5d6wy7gdbsk5tvusuwx3kkoc3474gjxpwq4hoc2c25jihuvlup@zb5mwj2rhnjd>
References: <20250319124923.1838719-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319124923.1838719-1-mjguzik@gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 19-03-25 13:49:23, Mateusz Guzik wrote:
> Eliminates a jump over a call to capable() in the common case.
> 
> By default the limit is not even set, in which case the check can't even
> fail to begin with. It remains unset at least on Debian and Ubuntu.
> For this cases this can probably become a static branch instead.
> 
> In the meantime tidy it up.
> 
> I note the check separate from the bump makes the entire thing racy.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/file_table.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 5b4cc9da1344..c04ed94cdc4b 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -221,7 +221,8 @@ struct file *alloc_empty_file(int flags, const struct cred *cred)
>  	/*
>  	 * Privileged users can go above max_files
>  	 */
> -	if (get_nr_files() >= files_stat.max_files && !capable(CAP_SYS_ADMIN)) {
> +	if (unlikely(get_nr_files() >= files_stat.max_files) &&
> +	    !capable(CAP_SYS_ADMIN)) {
>  		/*
>  		 * percpu_counters are inaccurate.  Do an expensive check before
>  		 * we go and fail.
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

