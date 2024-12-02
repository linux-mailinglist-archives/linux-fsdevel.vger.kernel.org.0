Return-Path: <linux-fsdevel+bounces-36269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B679E0808
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 17:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0403B1646C4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 15:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C751B20966D;
	Mon,  2 Dec 2024 15:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AuXG4NRf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="q5Wo+lmw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AuXG4NRf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="q5Wo+lmw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794A720898B;
	Mon,  2 Dec 2024 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153752; cv=none; b=O5wAx7U3gxvzf6M7crAPtj+6v2XnrhKamhOWNxUvFDF0/EeCUEHMYh3HME+5ITo9yFCK97jhkYV0gI1T8EWHIxlW3AIhkqQxrNi+ZzQhAyXHBRHwTH9to14nFTKJFvO8XTu8ZZGmv+ehC/NbGAn3XnBh/nt1+AA4QlZwb4hqb90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153752; c=relaxed/simple;
	bh=IHIj36jT4NU5IRb+TVx1R+FsizOLUkZ+cr7wf6YT3/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GptZHlthmXjKDpYHC4iCjkSzgTkkyvDNNhbXb6x9SZtatTdUVWQytI6Yk/7BIA7O4xMtZtncmCA+3Hp5C5zZx8y9RmJe9hgKao1DSDdvCRL2Wj9FIow1nXucNzY7cVr5I39m88mZ4cLt9hFclKnnnIBWGpSDOryZy/kzrLEzKzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AuXG4NRf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=q5Wo+lmw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AuXG4NRf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=q5Wo+lmw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9CC711F445;
	Mon,  2 Dec 2024 15:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733153748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HaJaHXKsGibczoyFubr1EIKGjfc7iCvy55W14i5dZNw=;
	b=AuXG4NRf4mVgN0jg3VpqOt9+DZSALuMOhoIDaA/xQogkUIV2KeUyP6sb/uAa+Wa/OcEy++
	NvYwwOx/tDRiPzdcv9v281pi4+AHJ2OhBysb7BJa3uXcbAFel+Y1AuEeGoLNZTcwsDmzgM
	3wN64M7Y1mVaOD8buOKG7C073uAqAZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733153748;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HaJaHXKsGibczoyFubr1EIKGjfc7iCvy55W14i5dZNw=;
	b=q5Wo+lmw0SO4/adIGueiEKKy4oaO1pnsLCJ6rLeriyuchEpbLvpOf/W2I1xIc1GkjZx7sT
	jD5kfRXXdSL52jAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733153748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HaJaHXKsGibczoyFubr1EIKGjfc7iCvy55W14i5dZNw=;
	b=AuXG4NRf4mVgN0jg3VpqOt9+DZSALuMOhoIDaA/xQogkUIV2KeUyP6sb/uAa+Wa/OcEy++
	NvYwwOx/tDRiPzdcv9v281pi4+AHJ2OhBysb7BJa3uXcbAFel+Y1AuEeGoLNZTcwsDmzgM
	3wN64M7Y1mVaOD8buOKG7C073uAqAZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733153748;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HaJaHXKsGibczoyFubr1EIKGjfc7iCvy55W14i5dZNw=;
	b=q5Wo+lmw0SO4/adIGueiEKKy4oaO1pnsLCJ6rLeriyuchEpbLvpOf/W2I1xIc1GkjZx7sT
	jD5kfRXXdSL52jAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 859A5139C2;
	Mon,  2 Dec 2024 15:35:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6dCWINTTTWcdNAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Dec 2024 15:35:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 08CD3A07B4; Mon,  2 Dec 2024 16:35:44 +0100 (CET)
Date: Mon, 2 Dec 2024 16:35:43 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Erin Shepherd <erin.shepherd@e43.eu>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC v2 3/3] pidfs: support FS_IOC_GETVERSION
Message-ID: <20241202153543.2y6nt5hada47pf2r@quack3>
References: <20241129-work-pidfs-v2-0-61043d66fbce@kernel.org>
 <20241129-work-pidfs-v2-3-61043d66fbce@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129-work-pidfs-v2-3-61043d66fbce@kernel.org>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.978];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[e43.eu,gmail.com,kernel.org,zeniv.linux.org.uk,suse.cz,oracle.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 29-11-24 14:02:25, Christian Brauner wrote:
> This will allow 32 bit userspace to detect when a given inode number has
> been recycled and also to construct a unique 64 bit identifier.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/pidfs.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index ff4f25078f3d983bce630e597adbb12262e5d727..f73a47e1d8379df886a90a044fb887f8d06f7c0b 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -262,6 +262,15 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  	if (arg)
>  		return -EINVAL;
>  
> +	switch (cmd) {
> +	case FS_IOC32_GETVERSION:
> +		fallthrough;
> +	case FS_IOC_GETVERSION: {
> +		__u32 __user *argp = (__u32 __user *)arg;
> +		return put_user(file_inode(file)->i_generation, argp);
> +	}
> +	}
> +
>  	scoped_guard(task_lock, task) {
>  		nsp = task->nsproxy;
>  		if (nsp)
> 
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

