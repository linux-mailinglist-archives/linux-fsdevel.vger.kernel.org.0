Return-Path: <linux-fsdevel+bounces-9837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 542D7845488
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA57F28DA69
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 09:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32C44DA0F;
	Thu,  1 Feb 2024 09:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tZEk2L4Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pz+l2eYM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tZEk2L4Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pz+l2eYM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A1815B964;
	Thu,  1 Feb 2024 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780911; cv=none; b=kFanDJ+sb+ug+pXp75lDierJhPfGsXKx+DOne8zumRyFbyqasE1TPWVSRe+NdOvOexzvVqZLulKhfJ7c6RmjKLk7wYfSm1rnV70+mv/C7o23/xWl/tLY0tNi1dNaVckAjbrc6lk/3U0x/z04DRDW7GfY/eM2d44SCb5zBg/XZog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780911; c=relaxed/simple;
	bh=tDMbD4PMdT6UfagN+yuhScX9TjAkhJ0rsI9jzZvDz7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOcGgIM3wRPJA7DODG23g5RW/BX2jsuauyK82crkXw51hPJ/0n3yY1YTdKwQxFJfFQvU78V0iKiIEz0MLoA7ncUFNaaEgSTkKNJ364Feyu+MtQVAoc+rildA53Awdewr8nwsq6AazjznBqaBEk6qzOw7gzSTaldp+0D7VyqtUJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tZEk2L4Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pz+l2eYM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tZEk2L4Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pz+l2eYM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ADDF8221BF;
	Thu,  1 Feb 2024 09:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706780907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WsOhp/Yk2JKBhL5ykqAu+mt9pPTg6uW9cuDlpV1B14I=;
	b=tZEk2L4YVIh0pB+mUPcPNiX/roDCMlZtuw7N3LpOa3Tn8X2bMo8yBqPlYO5eFmGpNEbXyB
	4kLuV0N9sxnws/BToK4p6xW/YCr/8eTzJoXtZt0OgsKnfUjoTic/QkY8PjPoyBTa8y11PX
	UFjzWF38qu4PbF2z+5aqxEp4g+HXVvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706780907;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WsOhp/Yk2JKBhL5ykqAu+mt9pPTg6uW9cuDlpV1B14I=;
	b=pz+l2eYMi+MPX37VKCmyxDJwvWEfC2+OwPEviZtSuWMpHZWb+H0PdHlVwQjQluL1wQpzuK
	EucJ7GdR8SPAI7Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706780907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WsOhp/Yk2JKBhL5ykqAu+mt9pPTg6uW9cuDlpV1B14I=;
	b=tZEk2L4YVIh0pB+mUPcPNiX/roDCMlZtuw7N3LpOa3Tn8X2bMo8yBqPlYO5eFmGpNEbXyB
	4kLuV0N9sxnws/BToK4p6xW/YCr/8eTzJoXtZt0OgsKnfUjoTic/QkY8PjPoyBTa8y11PX
	UFjzWF38qu4PbF2z+5aqxEp4g+HXVvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706780907;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WsOhp/Yk2JKBhL5ykqAu+mt9pPTg6uW9cuDlpV1B14I=;
	b=pz+l2eYMi+MPX37VKCmyxDJwvWEfC2+OwPEviZtSuWMpHZWb+H0PdHlVwQjQluL1wQpzuK
	EucJ7GdR8SPAI7Dg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A071F13594;
	Thu,  1 Feb 2024 09:48:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Z5spJ+tou2UdVwAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 09:48:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5B1C3A0809; Thu,  1 Feb 2024 10:48:27 +0100 (CET)
Date: Thu, 1 Feb 2024 10:48:27 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 15/34] nvme: port block device access to file
Message-ID: <20240201094827.a5rd7mdpcqfuywc2@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-15-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-15-adbd023e19cc@kernel.org>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tZEk2L4Y;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pz+l2eYM
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: ADDF8221BF
X-Spam-Flag: NO

On Tue 23-01-24 14:26:32, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/nvme/target/io-cmd-bdev.c | 16 ++++++++--------
>  drivers/nvme/target/nvmet.h       |  2 +-
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> index f11400a908f2..6426aac2634a 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -50,10 +50,10 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
>  
>  void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
>  {
> -	if (ns->bdev_handle) {
> -		bdev_release(ns->bdev_handle);
> +	if (ns->bdev_file) {
> +		fput(ns->bdev_file);
>  		ns->bdev = NULL;
> -		ns->bdev_handle = NULL;
> +		ns->bdev_file = NULL;
>  	}
>  }
>  
> @@ -85,18 +85,18 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
>  	if (ns->buffered_io)
>  		return -ENOTBLK;
>  
> -	ns->bdev_handle = bdev_open_by_path(ns->device_path,
> +	ns->bdev_file = bdev_file_open_by_path(ns->device_path,
>  				BLK_OPEN_READ | BLK_OPEN_WRITE, NULL, NULL);
> -	if (IS_ERR(ns->bdev_handle)) {
> -		ret = PTR_ERR(ns->bdev_handle);
> +	if (IS_ERR(ns->bdev_file)) {
> +		ret = PTR_ERR(ns->bdev_file);
>  		if (ret != -ENOTBLK) {
>  			pr_err("failed to open block device %s: (%d)\n",
>  					ns->device_path, ret);
>  		}
> -		ns->bdev_handle = NULL;
> +		ns->bdev_file = NULL;
>  		return ret;
>  	}
> -	ns->bdev = ns->bdev_handle->bdev;
> +	ns->bdev = file_bdev(ns->bdev_file);
>  	ns->size = bdev_nr_bytes(ns->bdev);
>  	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
>  
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 6c8acebe1a1a..33e61b4f478b 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -58,7 +58,7 @@
>  
>  struct nvmet_ns {
>  	struct percpu_ref	ref;
> -	struct bdev_handle	*bdev_handle;
> +	struct file		*bdev_file;
>  	struct block_device	*bdev;
>  	struct file		*file;
>  	bool			readonly;
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

