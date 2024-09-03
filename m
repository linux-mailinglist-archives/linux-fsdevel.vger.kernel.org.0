Return-Path: <linux-fsdevel+bounces-28373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06461969F19
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 15:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B4271C23B46
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 13:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAEE4A06;
	Tue,  3 Sep 2024 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="efcwX+Q9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jsAMfU9f";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="efcwX+Q9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jsAMfU9f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C84817
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370396; cv=none; b=nkyrwU/D+tMG/uVZItjpEGUn8hbQ6NcYoE+4dDUh/TgzlsP5TypAIp7Ajcyr/6H+5QSAPGNplT4szq/nbRJbYF9V0Am4nz6EUwgk2vCbJCAFuXlS7qfAg7AQZFP4VU0F77DjcjmGAxj75sGbLXljx1IvqJDNlogZjk/PQFTiek0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370396; c=relaxed/simple;
	bh=I7ZP1txfUcubCHz6YNY5t5U/wwekcqhXAqVON25BSbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Koj6Fhsb4D1qMxoVcLOu36sZVH8YwzF1WlvPGe9W3N1OZSvNmWsU39Xx2l3hiSxuM8DfPdb67Pn7YG6E2yvB5VEtPWKxMcGQbQKJ90NzBfIC/ipN+9PSQ8pHjDYJzCJwes5JrZ3gZ90Y7QU4F298JAWUfg1kC1EowQO7GU+2su4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=efcwX+Q9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jsAMfU9f; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=efcwX+Q9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jsAMfU9f; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B467D21A43;
	Tue,  3 Sep 2024 13:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725370392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+DBoLctgWVn2XaptFoQSAeagwZ/ze7vN4XQdt8GoSCE=;
	b=efcwX+Q91f5varAwsn9Dp2cKCnrn1UDHup4A1lljpfKG0LyByzvxeBoVuys/Cf0PAFPU/O
	8vQ8VHTnnvEkqpKvsBv1q+LUm4N1UhLmaMJCPmo827o6XwOnCyI9k48YXlYT2SkGnDeDGS
	V4ZjAu0dS5+WA5n88Xgq5DsSRdPe2lM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725370392;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+DBoLctgWVn2XaptFoQSAeagwZ/ze7vN4XQdt8GoSCE=;
	b=jsAMfU9fON2YkBzyTgBysftaotf32ztiDqfcj7BBAkbKVHKtHTwPAJ0QCsj1CUNisFUc7z
	q6SJEFWjgF62BZCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=efcwX+Q9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jsAMfU9f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725370392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+DBoLctgWVn2XaptFoQSAeagwZ/ze7vN4XQdt8GoSCE=;
	b=efcwX+Q91f5varAwsn9Dp2cKCnrn1UDHup4A1lljpfKG0LyByzvxeBoVuys/Cf0PAFPU/O
	8vQ8VHTnnvEkqpKvsBv1q+LUm4N1UhLmaMJCPmo827o6XwOnCyI9k48YXlYT2SkGnDeDGS
	V4ZjAu0dS5+WA5n88Xgq5DsSRdPe2lM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725370392;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+DBoLctgWVn2XaptFoQSAeagwZ/ze7vN4XQdt8GoSCE=;
	b=jsAMfU9fON2YkBzyTgBysftaotf32ztiDqfcj7BBAkbKVHKtHTwPAJ0QCsj1CUNisFUc7z
	q6SJEFWjgF62BZCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0C2413A52;
	Tue,  3 Sep 2024 13:33:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p+Q6JxgQ12YuSQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Sep 2024 13:33:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0F06AA096C; Tue,  3 Sep 2024 15:33:04 +0200 (CEST)
Date: Tue, 3 Sep 2024 15:33:04 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 14/20] proc: store cookie in private data
Message-ID: <20240903133304.c4g2bel5kckyv23w@quack3>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
 <20240830-vfs-file-f_version-v1-14-6d3e4816aa7b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830-vfs-file-f_version-v1-14-6d3e4816aa7b@kernel.org>
X-Rspamd-Queue-Id: B467D21A43
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 30-08-24 15:04:55, Christian Brauner wrote:
> Store the cookie to detect concurrent seeks on directories in
> file->private_data.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

...

>  	ns = proc_pid_ns(inode->i_sb);
> -	tid = (int)file->f_version;
> -	file->f_version = 0;
> +	tid = (int)(intptr_t)file->private_data;

What's the point of first casting to intptr_t?

> @@ -3890,7 +3890,7 @@ static int proc_task_readdir(struct file *file, struct dir_context *ctx)
>  				proc_task_instantiate, task, NULL)) {
>  			/* returning this tgid failed, save it as the first
>  			 * pid for the next readir call */
> -			file->f_version = (u64)tid;
> +			file->private_data = (void *)(intptr_t)tid;

The same here...

>  			put_task_struct(task);
>  			break;
>  		}
> @@ -3915,6 +3915,12 @@ static int proc_task_getattr(struct mnt_idmap *idmap,
>  	return 0;
>  }
>  
> +static loff_t proc_dir_llseek(struct file *file, loff_t offset, int whence)
> +{
> +	return generic_llseek_cookie(file, offset, whence,
> +				     (u64 *)(uintptr_t)&file->private_data);

So this I think is wrong for 32-bit archs because generic_llseek_cookie()
will store 8 bytes there while file->private_data has only 4 bytes...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

