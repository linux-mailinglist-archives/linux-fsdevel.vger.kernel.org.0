Return-Path: <linux-fsdevel+bounces-69774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CF8C84B8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 12:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541293A4264
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 11:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43432313534;
	Tue, 25 Nov 2025 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HyUzDWUT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sZpxxnIh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HyUzDWUT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sZpxxnIh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AFD26CE3B
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 11:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764069994; cv=none; b=VpnwGsLjtDhWbzlnMfHb9Y/UNqW3127lo+v6GB8qc8v70nrSUDsMwHn00YdJpaWxAd9m0tUl6e17FdctSSFIWW32ALeWLDouiGrBwG67o6+V+jGhgpCQuYF7HM6Fu1zD8xA2rdYkhtiWjhboAno4+vK5jQe9+knzYBADhDkPiuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764069994; c=relaxed/simple;
	bh=Hjf7dpl2fLEPzLbGf3YTxzz1LgTsvgXqp3/HOJRMCg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYy9rkSGKTzM76AuJKAlsqocHx7nEFcC7Hw2MAq0iSizRdhrtXB2/dJ7UWU+A1akXvLUVzxeSZ5KiU4X/n8c6XiYS/ytlKrvVn32iC+Kw2lepM6zlzqyR2bBMB04flSmFZxR6TxvUrPyeovyaDx0SPHCoh5MHkltDzh13HMOPwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HyUzDWUT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sZpxxnIh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HyUzDWUT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sZpxxnIh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 330395BD0D;
	Tue, 25 Nov 2025 11:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764069991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CG8DKX3gnZzcWpVOjXs/kPaj//t0XCnIgkKhCKrkBtk=;
	b=HyUzDWUTCrV6tFWh6JA8NYU3nhsDr/J4BbkinRxD744PkZYbtHAIIwsEORMP7i72B8D9OB
	b+dJ0AZBCuxc0G5+eFVIgtE7f3QI768Zm0gkHfJyRrd6PDKynVI87WyERc6yTVTbKxAFMo
	lNF/yo4BXyPd7NUQjmP4ZgHJouckl+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764069991;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CG8DKX3gnZzcWpVOjXs/kPaj//t0XCnIgkKhCKrkBtk=;
	b=sZpxxnIhETnOnUoUrZR/k2vGWi1iYqcJyTKhB3eEAnwDXrA2+IpOoeuHqEMAlHPg9VyDLm
	a58Zw28eyHzydzBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764069991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CG8DKX3gnZzcWpVOjXs/kPaj//t0XCnIgkKhCKrkBtk=;
	b=HyUzDWUTCrV6tFWh6JA8NYU3nhsDr/J4BbkinRxD744PkZYbtHAIIwsEORMP7i72B8D9OB
	b+dJ0AZBCuxc0G5+eFVIgtE7f3QI768Zm0gkHfJyRrd6PDKynVI87WyERc6yTVTbKxAFMo
	lNF/yo4BXyPd7NUQjmP4ZgHJouckl+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764069991;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CG8DKX3gnZzcWpVOjXs/kPaj//t0XCnIgkKhCKrkBtk=;
	b=sZpxxnIhETnOnUoUrZR/k2vGWi1iYqcJyTKhB3eEAnwDXrA2+IpOoeuHqEMAlHPg9VyDLm
	a58Zw28eyHzydzBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 294F93EA63;
	Tue, 25 Nov 2025 11:26:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MsUPCmeSJWn9MgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Nov 2025 11:26:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D7F20A0C7D; Tue, 25 Nov 2025 12:26:30 +0100 (CET)
Date: Tue, 25 Nov 2025 12:26:30 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs: scale opening of character devices
Message-ID: <d2xotmpncid4rlsahjm7lsszqjrgn6kgtta4w5flvsawcp6guu@neqoz2ayoccm>
References: <20251121072818.3230541-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121072818.3230541-1-mjguzik@gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Fri 21-11-25 08:28:18, Mateusz Guzik wrote:
> chrdev_open() always takes cdev_lock, which is only needed to synchronize
> against cd_forget(). But the latter is only ever called by inode evict(),
> meaning these two can never legally race. Solidify this with asserts.

Are you sure? Because from a quick glance it doesn't seem that inodes hold
a refcount of the cdev. Thus inode->i_cdev can freed if you don't hold
cdev_lock - it is only the cdev_lock that makes cdev_get() safe against UAF
issues in chrdev_open() AFAICS because that blocks cdev_purge() from
completing when last ref of the kobject is dropped...

								Honza

> 
> More cleanups are needed here but this is enough to get the thing out of
> the way.
> 
> Rationale is funny-sounding at first: opening of /dev/zero happens to be
> a contention point in large-scale package building (think 100+ packages
> at the same with a thread count to support it). Such a workload is not
> only very fork+exec heavy, but frequently involves scripts which use the
> idiom of silencing output by redirecting it to /dev/null.
> 
> A non-large-scale microbenchmark of opening /dev/null in a loop in 16
> processes:
> before:	2865472
> after:	4011960 (+40%)
> 
> Code goes from being bottlenecked on the spinlock to being bottlenecked
> on lockref.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
> 
> v2:
> - add back new = NULL lost in refactoring
> 
> I'll note for interested my experience with the workload at hand comes
> from FreeBSD and was surprised to find /dev/null on the profile. Given
> that Linux is globally serializing on it, it has to be a factor as well
> in this case.
> 
>  fs/char_dev.c        | 20 +++++++++++---------
>  fs/inode.c           |  2 +-
>  include/linux/cdev.h |  2 +-
>  3 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/char_dev.c b/fs/char_dev.c
> index c2ddb998f3c9..9a6dfab084d1 100644
> --- a/fs/char_dev.c
> +++ b/fs/char_dev.c
> @@ -374,15 +374,15 @@ static int chrdev_open(struct inode *inode, struct file *filp)
>  {
>  	const struct file_operations *fops;
>  	struct cdev *p;
> -	struct cdev *new = NULL;
>  	int ret = 0;
>  
> -	spin_lock(&cdev_lock);
> -	p = inode->i_cdev;
> +	VFS_BUG_ON_INODE(icount_read(inode) < 1, inode);
> +
> +	p = READ_ONCE(inode->i_cdev);
>  	if (!p) {
>  		struct kobject *kobj;
> +		struct cdev *new = NULL;
>  		int idx;
> -		spin_unlock(&cdev_lock);
>  		kobj = kobj_lookup(cdev_map, inode->i_rdev, &idx);
>  		if (!kobj)
>  			return -ENXIO;
> @@ -392,19 +392,19 @@ static int chrdev_open(struct inode *inode, struct file *filp)
>  		   we dropped the lock. */
>  		p = inode->i_cdev;
>  		if (!p) {
> -			inode->i_cdev = p = new;
> +			p = new;
> +			WRITE_ONCE(inode->i_cdev, p);
>  			list_add(&inode->i_devices, &p->list);
>  			new = NULL;
>  		} else if (!cdev_get(p))
>  			ret = -ENXIO;
> +		spin_unlock(&cdev_lock);
> +		cdev_put(new);
>  	} else if (!cdev_get(p))
>  		ret = -ENXIO;
> -	spin_unlock(&cdev_lock);
> -	cdev_put(new);
>  	if (ret)
>  		return ret;
>  
> -	ret = -ENXIO;
>  	fops = fops_get(p->ops);
>  	if (!fops)
>  		goto out_cdev_put;
> @@ -423,8 +423,10 @@ static int chrdev_open(struct inode *inode, struct file *filp)
>  	return ret;
>  }
>  
> -void cd_forget(struct inode *inode)
> +void inode_cdev_forget(struct inode *inode)
>  {
> +	VFS_BUG_ON_INODE(!(inode_state_read_once(inode) & I_FREEING), inode);
> +
>  	spin_lock(&cdev_lock);
>  	list_del_init(&inode->i_devices);
>  	inode->i_cdev = NULL;
> diff --git a/fs/inode.c b/fs/inode.c
> index a62032864ddf..88be1f20782d 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -840,7 +840,7 @@ static void evict(struct inode *inode)
>  		clear_inode(inode);
>  	}
>  	if (S_ISCHR(inode->i_mode) && inode->i_cdev)
> -		cd_forget(inode);
> +		inode_cdev_forget(inode);
>  
>  	remove_inode_hash(inode);
>  
> diff --git a/include/linux/cdev.h b/include/linux/cdev.h
> index 0e8cd6293deb..bed99967ad90 100644
> --- a/include/linux/cdev.h
> +++ b/include/linux/cdev.h
> @@ -34,6 +34,6 @@ void cdev_device_del(struct cdev *cdev, struct device *dev);
>  
>  void cdev_del(struct cdev *);
>  
> -void cd_forget(struct inode *);
> +void inode_cdev_forget(struct inode *);
>  
>  #endif
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

