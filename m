Return-Path: <linux-fsdevel+bounces-9915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC714845EC8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 18:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758F728A7FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 17:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0727C6E3;
	Thu,  1 Feb 2024 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ks1WZ/qQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GGjKx8kV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ks1WZ/qQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GGjKx8kV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F0184037;
	Thu,  1 Feb 2024 17:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809365; cv=none; b=PxY1VUUmDKqeb0ukt7JdEX71EkZTfizrr0d806YfT/lApboDXrIuVRczhIoeOLWAaWbLeS3oTHY+YuSZ/KU3aIeYUrejNI5V3MudAH2a+sB2ah0EbAXolmzGEQD1Ubv1bQf3wDIhtlUHfNG6OewnM8qnxwokz5jKJnOMEiKEqDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809365; c=relaxed/simple;
	bh=nQkgxeJctXCbqc1q77iqkX0YjrjrPVJxfrXEr7aVGY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1g/A8EStXJZN7AaLB2fzoixQIVJu6XD1Jky66n63+02mTv4l1x9UKZ2kKyQ7OAyOApzf8U92xQ4meM58V72VXj545ke8dN71LjOHxorfXFj3NiqOnZtBuCFKsdWsGeDLAhEHsMkAfb4PcWXn+R7kJ5RykpAAyUO703i/14mtxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ks1WZ/qQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GGjKx8kV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ks1WZ/qQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GGjKx8kV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9BDAB21EB6;
	Thu,  1 Feb 2024 17:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706809355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zAgrRfHWWfIki/a6lq962GwLpDnn3/KZNYXlWkHPUZU=;
	b=Ks1WZ/qQq3SF9V12cftZJJrcABCwlpLObdQoS6Ia7kSNbTQoVfi0snOf487tcOMX3942rl
	9CJK1yPAoxZW8mvPgLjxB8/J45pb2G0yBnRczPVe/Dj9PlFPy6+WiZi05ejkOSfiJtqMzi
	j8b8Ovr/I5KFm7iggj3Fd7xVeOXcBuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706809355;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zAgrRfHWWfIki/a6lq962GwLpDnn3/KZNYXlWkHPUZU=;
	b=GGjKx8kV0GeCyWu2hfYKr2uCExetnSHzkdz25Gf+KPwJcsTioDWhqwOrQV3UF3/wMBq13w
	2RmooqmqXWzM49Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706809355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zAgrRfHWWfIki/a6lq962GwLpDnn3/KZNYXlWkHPUZU=;
	b=Ks1WZ/qQq3SF9V12cftZJJrcABCwlpLObdQoS6Ia7kSNbTQoVfi0snOf487tcOMX3942rl
	9CJK1yPAoxZW8mvPgLjxB8/J45pb2G0yBnRczPVe/Dj9PlFPy6+WiZi05ejkOSfiJtqMzi
	j8b8Ovr/I5KFm7iggj3Fd7xVeOXcBuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706809355;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zAgrRfHWWfIki/a6lq962GwLpDnn3/KZNYXlWkHPUZU=;
	b=GGjKx8kV0GeCyWu2hfYKr2uCExetnSHzkdz25Gf+KPwJcsTioDWhqwOrQV3UF3/wMBq13w
	2RmooqmqXWzM49Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E39813672;
	Thu,  1 Feb 2024 17:42:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hGqxIgvYu2XsKAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 17:42:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 339FEA0809; Thu,  1 Feb 2024 18:42:35 +0100 (CET)
Date: Thu, 1 Feb 2024 18:42:35 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 29/34] bdev: make struct bdev_handle private to the
 block layer
Message-ID: <20240201174235.ngbjole5h3huujou@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-29-adbd023e19cc@kernel.org>
 <20240201105422.3wuw332vh4tusbzp@quack3>
 <20240201-enzianblau-wohlgefallen-ece64eb96719@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201-enzianblau-wohlgefallen-ece64eb96719@brauner>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.02 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-2.42)[97.36%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.02

On Thu 01-02-24 16:07:59, Christian Brauner wrote:
> > > +	if (ret)
> > > +		return ERR_PTR(ret);
> > > +
> > > +	bdev = blkdev_get_no_open(dev);
> > > +	if (!bdev)
> > > +		return ERR_PTR(-ENXIO);
> > >  
> > >  	flags = blk_to_file_flags(mode);
> > > -	bdev_file = alloc_file_pseudo_noaccount(handle->bdev->bd_inode,
> > > +	bdev_file = alloc_file_pseudo_noaccount(bdev->bd_inode,
> > >  			blockdev_mnt, "", flags | O_LARGEFILE, &def_blk_fops);
> > >  	if (IS_ERR(bdev_file)) {
> > > -		bdev_release(handle);
> > > +		blkdev_put_no_open(bdev);
> > >  		return bdev_file;
> > >  	}
> > > -	ihold(handle->bdev->bd_inode);
> > > +	bdev_file->f_mode &= ~FMODE_OPENED;
> > 
> > Hum, why do you need these games with FMODE_OPENED? I suspect you want to
> > influence fput() behavior but then AFAICT we will leak dentry, mnt, etc. on
> > error? If this is indeed needed, it deserves a comment...
> 
> I rewrote this.
> 
> Total diff I applied is:

Looks good now.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

