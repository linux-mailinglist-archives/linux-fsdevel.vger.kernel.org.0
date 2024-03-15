Return-Path: <linux-fsdevel+bounces-14479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC4A87CFDE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 16:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4AB1F23974
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 15:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD693D0B4;
	Fri, 15 Mar 2024 15:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M2Qls5tx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yd9R4LiV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="swmNZsyv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0douvlR+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B031BDE0;
	Fri, 15 Mar 2024 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710515542; cv=none; b=B3CvTnCtj+4Rxl0zKa2cuN3zDreQvhmR13tWa7hqMvvZV5RoCyaQT9cQhcE4mU5+Sb3o5s4uYN+9lBzdokNFqa92T8uP9xvPGA95LSUqezFENqVGgVYq2X4vXvSt1z0ybl5jF9mDdxLvqEK62Rdw+5SckKOTw22XF90N1HyTq3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710515542; c=relaxed/simple;
	bh=5VYNAZtPNuWYrHtXNVIZ5hDcRvPN2PB/E/Jjgx69R7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBLeX7W+ob+SpEsmJmTV4p3ReoM2dtMRod09N/OTlsswVwmfj8xT3cJ1Zp3DXQTfwdZvqbsrX2bohIW7nps01uHH/EMtw8rA7mqjM+CsSIvzaBatDpbzBp+TQGYObmaY0l/D8SF8IYDlewKRzhB9Q7dJlN3raq/wjMRkIrbF5ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M2Qls5tx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yd9R4LiV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=swmNZsyv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0douvlR+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 247BF21DA8;
	Fri, 15 Mar 2024 15:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710515539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fHp/FYvltxw1jmF6PPwQhxAl3AJOVCNe0ItSPyIWGdI=;
	b=M2Qls5txthi04yjouK4KWiyJIeD03/TWYdpnIf7Nz2se05kKtf9dCuO7hxQu+F+VEExYCT
	VHechagx1mQY0Z2qBIi4oKV75Wqgx84VEHLKcVAD/RrNaOQUt7o3iUnbZhI6Nksp0x+O46
	0DO/SjPjKfMWzP/0wQvarlNSv7ta20E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710515539;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fHp/FYvltxw1jmF6PPwQhxAl3AJOVCNe0ItSPyIWGdI=;
	b=yd9R4LiVTh+f4bRlo+VDcRsc+t+lrhj4fBpV3r/MskqXfmnTPSPJ7b57qRIcVyzczSDdmc
	qb1XICjnZbBGkHDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710515538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fHp/FYvltxw1jmF6PPwQhxAl3AJOVCNe0ItSPyIWGdI=;
	b=swmNZsyvuJG1f4u6CJW5dKFvBSsr62j3SiK9OCFNvQCX/LyMuyr06Ht/c+uDwMzQwpWIuu
	THJPTZRBgm3EXLaNu1Ip85FWgTO42YeYlC5LRXZ/GkvaoXW3dwm0qNYY2byUnac9KUvX5a
	B5FzC3CkQDSQawdHk1IHVxL6nJwpGzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710515538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fHp/FYvltxw1jmF6PPwQhxAl3AJOVCNe0ItSPyIWGdI=;
	b=0douvlR+2XJfnAbKaRV29pIRHEdBGYplsCx7T3j6kueFryz/VoCQt/h0Lw3n7wcOsSrRYo
	y9lHOdi1CkcfsYDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A0541368C;
	Fri, 15 Mar 2024 15:12:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g+ZXBlJl9GXRTQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 15 Mar 2024 15:12:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C0F30A07D9; Fri, 15 Mar 2024 16:12:13 +0100 (CET)
Date: Fri, 15 Mar 2024 16:12:13 +0100
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC v4 linux-next 16/19] block2mtd: prevent direct access of
 bd_inode
Message-ID: <20240315151213.ytwv3veuwn22iud3@quack3>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <20240222124555.2049140-17-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222124555.2049140-17-yukuai1@huaweicloud.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spamd-Result: default: False [-2.81 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-2.01)[95.10%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,huawei.com:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

On Thu 22-02-24 20:45:52, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Now that block2mtd stash the file of opened bdev, it's ok to get inode
> from the file.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/mtd/devices/block2mtd.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
> index 97a00ec9a4d4..e9ecb3286dcb 100644
> --- a/drivers/mtd/devices/block2mtd.c
> +++ b/drivers/mtd/devices/block2mtd.c
> @@ -265,6 +265,7 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
>  	struct file *bdev_file;
>  	struct block_device *bdev;
>  	struct block2mtd_dev *dev;
> +	loff_t size;
>  	char *name;
>  
>  	if (!devname)
> @@ -291,7 +292,8 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
>  		goto err_free_block2mtd;
>  	}
>  
> -	if ((long)bdev->bd_inode->i_size % erase_size) {
> +	size = i_size_read(file_inode(bdev_file));
> +	if ((long)size % erase_size) {
>  		pr_err("erasesize must be a divisor of device size\n");
>  		goto err_free_block2mtd;
>  	}
> @@ -309,7 +311,7 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
>  
>  	dev->mtd.name = name;
>  
> -	dev->mtd.size = bdev->bd_inode->i_size & PAGE_MASK;
> +	dev->mtd.size = size & PAGE_MASK;
>  	dev->mtd.erasesize = erase_size;
>  	dev->mtd.writesize = 1;
>  	dev->mtd.writebufsize = PAGE_SIZE;
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

