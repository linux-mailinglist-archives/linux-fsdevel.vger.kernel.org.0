Return-Path: <linux-fsdevel+bounces-39681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A17A16F27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 16:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 732C6166DD4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 15:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D771E3784;
	Mon, 20 Jan 2025 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mu7Mrw/H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iKcc69fW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KLXSh5l8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q9MYdye3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4992B18FDC8
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737386317; cv=none; b=bjf6+7sdaATSfTytX9pGROwd6OQgvCoew+O0/tFheQ3D6oZz2NkagZ0SyfLxmMCUjH9LAQAB8LhTnmbA8QGCm2OriHUHbY7yveK8qRrSosfc54NLyMbYtfwv/ty4rgr8UP711TwrTCmQfSkBEYauJ+HoYUZLeyciPX0R9jfI4UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737386317; c=relaxed/simple;
	bh=iRtt5NhhlTWK7dNjLzs3vqnUiGiCx4b/s4TaaF8+fQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikiqk5OMk0BxewDzd9wqr9aBpUn5bltveWlOF3r9qS8zdjDf/7WH3sZU3/QGVU6ZZ26w49T39nNYmWw/z0ycVJd1jvLLOl8q0N009uQnkn7zYtTGyRvxzoy+d2kjEdYWLu43bK71k7/2nbQGiSkNwLlu0/NrWp39Sgisqc3lmbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mu7Mrw/H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iKcc69fW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KLXSh5l8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q9MYdye3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EE0591F7B9;
	Mon, 20 Jan 2025 15:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737386311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rAFRQ7HpGGo3ZK3U0uOG8Dc7jlqIqipWdR6nfshgDBY=;
	b=mu7Mrw/H3dD55WnkbOCGtcNOdPbwythCEQPfy6oEHrJioydYKSqGH2uIqxfUQjf/TsaBCO
	3eqdddmExu75Rr539G8QW8wtw09W0C+mNGthKMaxXPIt15c67nCYVw0ADztHTIg7U+HhxQ
	qUdHjOaBQEEn+WdNrDIbmtd0Rwf0Nak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737386311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rAFRQ7HpGGo3ZK3U0uOG8Dc7jlqIqipWdR6nfshgDBY=;
	b=iKcc69fWoighhee3sqK92AsL//ELzH1EAZY70dinD/MxbHi83M2sCyav4O+qtp3LdzpJhx
	H7q+obrZeBdwoJAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737386310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rAFRQ7HpGGo3ZK3U0uOG8Dc7jlqIqipWdR6nfshgDBY=;
	b=KLXSh5l8g3GR/CVjsy/oe2gvQcroGRy5aOJnQ7kR/cO3p00tzVaj0Y643Ny5B8xmHre3wo
	nBTiUDN8MPhvZ7iLyr1cdJOEjbfTEFWnooGA0cIhndiQYUkVxz6syxam2uGKG5iLmez853
	jnFKd3fwR6H9pAJ4il0sFEePZG2AzyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737386310;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rAFRQ7HpGGo3ZK3U0uOG8Dc7jlqIqipWdR6nfshgDBY=;
	b=Q9MYdye3QxpghZvrKPTwAAjKYQuab/NxRraYnmRn7u6W7nASbYt43aoEHiwuGlqDTFOZPx
	BnqM5IEv8wNVzvBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3D211393E;
	Mon, 20 Jan 2025 15:18:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1fCWN0ZpjmeLcQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Jan 2025 15:18:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 80E79A081E; Mon, 20 Jan 2025 16:18:26 +0100 (CET)
Date: Mon, 20 Jan 2025 16:18:26 +0100
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH][RFC] make use of anon_inode_getfile_fmode()
Message-ID: <s2nxhfndcxp5fmuajwxnivbixghlyxhyngpldhhu4vmqcr3uta@vfmimwsfjcmx>
References: <20250118014434.GT1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250118014434.GT1977892@ZenIV>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat 18-01-25 01:44:34, Al Viro wrote:
> ["fallen through the cracks" misc stuff]
> 
> A bunch of anon_inode_getfile() callers follow it with adjusting
> ->f_mode; we have a helper doing that now, so let's make use
> of it.
>     
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> diff --git a/arch/powerpc/platforms/pseries/papr-vpd.c b/arch/powerpc/platforms/pseries/papr-vpd.c
> index 1574176e3ffc..c86950d7105a 100644
> --- a/arch/powerpc/platforms/pseries/papr-vpd.c
> +++ b/arch/powerpc/platforms/pseries/papr-vpd.c
> @@ -482,14 +482,13 @@ static long papr_vpd_create_handle(struct papr_location_code __user *ulc)
>  		goto free_blob;
>  	}
>  
> -	file = anon_inode_getfile("[papr-vpd]", &papr_vpd_handle_ops,
> -				  (void *)blob, O_RDONLY);
> +	file = anon_inode_getfile_fmode("[papr-vpd]", &papr_vpd_handle_ops,
> +				  (void *)blob, O_RDONLY,
> +				  FMODE_LSEEK | FMODE_PREAD);
>  	if (IS_ERR(file)) {
>  		err = PTR_ERR(file);
>  		goto put_fd;
>  	}
> -
> -	file->f_mode |= FMODE_LSEEK | FMODE_PREAD;
>  	fd_install(fd, file);
>  	return fd;
>  put_fd:
> diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> index 49559605177e..c321d442f0da 100644
> --- a/drivers/vfio/group.c
> +++ b/drivers/vfio/group.c
> @@ -266,24 +266,12 @@ static struct file *vfio_device_open_file(struct vfio_device *device)
>  	if (ret)
>  		goto err_free;
>  
> -	/*
> -	 * We can't use anon_inode_getfd() because we need to modify
> -	 * the f_mode flags directly to allow more than just ioctls
> -	 */
> -	filep = anon_inode_getfile("[vfio-device]", &vfio_device_fops,
> -				   df, O_RDWR);
> +	filep = anon_inode_getfile_fmode("[vfio-device]", &vfio_device_fops,
> +				   df, O_RDWR, FMODE_PREAD | FMODE_PWRITE);
>  	if (IS_ERR(filep)) {
>  		ret = PTR_ERR(filep);
>  		goto err_close_device;
>  	}
> -
> -	/*
> -	 * TODO: add an anon_inode interface to do this.
> -	 * Appears to be missing by lack of need rather than
> -	 * explicitly prevented.  Now there's need.
> -	 */
> -	filep->f_mode |= (FMODE_PREAD | FMODE_PWRITE);
> -
>  	/*
>  	 * Use the pseudo fs inode on the device to link all mmaps
>  	 * to the same address space, allowing us to unmap all vmas
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index fe3de9ad57bf..d9bc67176128 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -317,8 +317,9 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req,
>  		goto err_free_id;
>  	}
>  
> -	anon_file->file = anon_inode_getfile("[cachefiles]",
> -				&cachefiles_ondemand_fd_fops, object, O_WRONLY);
> +	anon_file->file = anon_inode_getfile_fmode("[cachefiles]",
> +				&cachefiles_ondemand_fd_fops, object,
> +				O_WRONLY, FMODE_PWRITE | FMODE_LSEEK);
>  	if (IS_ERR(anon_file->file)) {
>  		ret = PTR_ERR(anon_file->file);
>  		goto err_put_fd;
> @@ -333,8 +334,6 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req,
>  		goto err_put_file;
>  	}
>  
> -	anon_file->file->f_mode |= FMODE_PWRITE | FMODE_LSEEK;
> -
>  	load = (void *)req->msg.data;
>  	load->fd = anon_file->fd;
>  	object->ondemand->ondemand_id = object_id;
> diff --git a/fs/eventfd.c b/fs/eventfd.c
> index 76129bfcd663..af42b2c7d235 100644
> --- a/fs/eventfd.c
> +++ b/fs/eventfd.c
> @@ -406,14 +406,13 @@ static int do_eventfd(unsigned int count, int flags)
>  	if (fd < 0)
>  		goto err;
>  
> -	file = anon_inode_getfile("[eventfd]", &eventfd_fops, ctx, flags);
> +	file = anon_inode_getfile_fmode("[eventfd]", &eventfd_fops,
> +					ctx, flags, FMODE_NOWAIT);
>  	if (IS_ERR(file)) {
>  		put_unused_fd(fd);
>  		fd = PTR_ERR(file);
>  		goto err;
>  	}
> -
> -	file->f_mode |= FMODE_NOWAIT;
>  	fd_install(fd, file);
>  	return fd;
>  err:
> diff --git a/fs/signalfd.c b/fs/signalfd.c
> index d1a5f43ce466..d469782f97f4 100644
> --- a/fs/signalfd.c
> +++ b/fs/signalfd.c
> @@ -277,15 +277,14 @@ static int do_signalfd4(int ufd, sigset_t *mask, int flags)
>  			return ufd;
>  		}
>  
> -		file = anon_inode_getfile("[signalfd]", &signalfd_fops, ctx,
> -				       O_RDWR | (flags & O_NONBLOCK));
> +		file = anon_inode_getfile_fmode("[signalfd]", &signalfd_fops,
> +					ctx, O_RDWR | (flags & O_NONBLOCK),
> +					FMODE_NOWAIT);
>  		if (IS_ERR(file)) {
>  			put_unused_fd(ufd);
>  			kfree(ctx);
>  			return PTR_ERR(file);
>  		}
> -		file->f_mode |= FMODE_NOWAIT;
> -
>  		fd_install(ufd, file);
>  	} else {
>  		CLASS(fd, f)(ufd);
> diff --git a/fs/timerfd.c b/fs/timerfd.c
> index 9f7eb451a60f..753e22e83e0f 100644
> --- a/fs/timerfd.c
> +++ b/fs/timerfd.c
> @@ -439,15 +439,15 @@ SYSCALL_DEFINE2(timerfd_create, int, clockid, int, flags)
>  		return ufd;
>  	}
>  
> -	file = anon_inode_getfile("[timerfd]", &timerfd_fops, ctx,
> -				    O_RDWR | (flags & TFD_SHARED_FCNTL_FLAGS));
> +	file = anon_inode_getfile_fmode("[timerfd]", &timerfd_fops, ctx,
> +			    O_RDWR | (flags & TFD_SHARED_FCNTL_FLAGS),
> +			    FMODE_NOWAIT);
>  	if (IS_ERR(file)) {
>  		put_unused_fd(ufd);
>  		kfree(ctx);
>  		return PTR_ERR(file);
>  	}
>  
> -	file->f_mode |= FMODE_NOWAIT;
>  	fd_install(ufd, file);
>  	return ufd;
>  }
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index de2c11dae231..0ba0ffc4abc9 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -4222,15 +4222,14 @@ static int kvm_vcpu_ioctl_get_stats_fd(struct kvm_vcpu *vcpu)
>  	if (fd < 0)
>  		return fd;
>  
> -	file = anon_inode_getfile(name, &kvm_vcpu_stats_fops, vcpu, O_RDONLY);
> +	file = anon_inode_getfile_fmode(name, &kvm_vcpu_stats_fops, vcpu,
> +					O_RDONLY, FMODE_PREAD);
>  	if (IS_ERR(file)) {
>  		put_unused_fd(fd);
>  		return PTR_ERR(file);
>  	}
>  
>  	kvm_get_kvm(vcpu->kvm);
> -
> -	file->f_mode |= FMODE_PREAD;
>  	fd_install(fd, file);
>  
>  	return fd;
> @@ -4982,16 +4981,14 @@ static int kvm_vm_ioctl_get_stats_fd(struct kvm *kvm)
>  	if (fd < 0)
>  		return fd;
>  
> -	file = anon_inode_getfile("kvm-vm-stats",
> -			&kvm_vm_stats_fops, kvm, O_RDONLY);
> +	file = anon_inode_getfile_fmode("kvm-vm-stats",
> +			&kvm_vm_stats_fops, kvm, O_RDONLY, FMODE_PREAD);
>  	if (IS_ERR(file)) {
>  		put_unused_fd(fd);
>  		return PTR_ERR(file);
>  	}
>  
>  	kvm_get_kvm(kvm);
> -
> -	file->f_mode |= FMODE_PREAD;
>  	fd_install(fd, file);
>  
>  	return fd;
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

