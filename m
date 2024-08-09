Return-Path: <linux-fsdevel+bounces-25551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2828094D541
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 19:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D99112824B4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 17:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B1249630;
	Fri,  9 Aug 2024 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gX2ak6pV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RBRnnKXG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gX2ak6pV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RBRnnKXG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9508145957
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723223703; cv=none; b=YbcExFxfSyZg+3AsLY1d4e6OdAys/BH3FoO+DK8e0RUb46TXgfgrocm58tcaNUuIuPKsTWv1sd/f1fc1BL+pxYLeFQAOZHrHQ7HA6KbC1AS47kycNkS6VoOHEbhYaKGv92k2sTAHIaU1Jd6yVSbDUq4sfqJL6mkaTqS4mFuKS6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723223703; c=relaxed/simple;
	bh=uLCRCAv1qd35wMIKk1H+zT5mvQPlnSdRgV6Gq39wGZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aq4g7IVaBBgrN4mEU6zTVQx+82t7h1/dU96GWpq1UTAALJOV/Gwjxm2OaX+4gkZT+kpRaP/ERG7uwm5vfC7d++lGag1/PRVca/KGp8YrQVAlt7Nk68eGRL4vfJL//VjBMuNJ6yN8zrxOW2Ss41dincvuRxE0yuGAa5dr2dboSnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gX2ak6pV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RBRnnKXG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gX2ak6pV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RBRnnKXG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9DBD11FF9E;
	Fri,  9 Aug 2024 17:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723223699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tAQ6MF8EYg3gDYU8FKMbjSAwsxl8g4nhqn1366Xfs2Y=;
	b=gX2ak6pV55jwteeZwfeq4QM9FJcwRQQIaSrN2vDgINayHL6D56frLXi5dq/hXAARMti5Oz
	IFTVAKQpwtPTq7nVD99t5U3/ZoehQKzx9CbjSURrjV679XhOWujT/x/st5mJ+zO1u9+xTU
	G7EhsXEgjwAM1+GQ8bmIaokyGPcyQws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723223699;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tAQ6MF8EYg3gDYU8FKMbjSAwsxl8g4nhqn1366Xfs2Y=;
	b=RBRnnKXGW73dDQTvq0RzyMzO3/BGDQ9ROW/a1mfFoJ7gqiGVTRw6bfb+vqHpGrHL6199C2
	wNcxsLGM3skYWyCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gX2ak6pV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RBRnnKXG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723223699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tAQ6MF8EYg3gDYU8FKMbjSAwsxl8g4nhqn1366Xfs2Y=;
	b=gX2ak6pV55jwteeZwfeq4QM9FJcwRQQIaSrN2vDgINayHL6D56frLXi5dq/hXAARMti5Oz
	IFTVAKQpwtPTq7nVD99t5U3/ZoehQKzx9CbjSURrjV679XhOWujT/x/st5mJ+zO1u9+xTU
	G7EhsXEgjwAM1+GQ8bmIaokyGPcyQws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723223699;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tAQ6MF8EYg3gDYU8FKMbjSAwsxl8g4nhqn1366Xfs2Y=;
	b=RBRnnKXGW73dDQTvq0RzyMzO3/BGDQ9ROW/a1mfFoJ7gqiGVTRw6bfb+vqHpGrHL6199C2
	wNcxsLGM3skYWyCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 837551379A;
	Fri,  9 Aug 2024 17:14:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +d7OH5NOtmbbQQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 09 Aug 2024 17:14:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 34F79A084C; Fri,  9 Aug 2024 19:14:55 +0200 (CEST)
Date: Fri, 9 Aug 2024 19:14:55 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] fs: move FMODE_UNSIGNED_OFFSET to fop_flags
Message-ID: <20240809171455.voevkrfvvrhcptwh@quack3>
References: <20240809-work-fop_unsigned-v1-1-658e054d893e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809-work-fop_unsigned-v1-1-658e054d893e@kernel.org>
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -1.01
X-Rspamd-Queue-Id: 9DBD11FF9E

On Fri 09-08-24 12:38:56, Christian Brauner wrote:
> This is another flag that is statically set and doesn't need to use up
> an FMODE_* bit. Move it to ->fop_flags and free up another FMODE_* bit.
> 
> (1) mem_open() used from proc_mem_operations
> (2) adi_open() used from adi_fops
> (3) drm_open_helper():
>     (3.1) accel_open() used from DRM_ACCEL_FOPS
>     (3.2) drm_open() used from
>     (3.2.1) amdgpu_driver_kms_fops
>     (3.2.2) psb_gem_fops
>     (3.2.3) i915_driver_fops
>     (3.2.4) nouveau_driver_fops
>     (3.2.5) panthor_drm_driver_fops
>     (3.2.6) radeon_driver_kms_fops
>     (3.2.7) tegra_drm_fops
>     (3.2.8) vmwgfx_driver_fops
>     (3.2.9) xe_driver_fops
>     (3.2.10) DRM_GEM_FOPS
>     (3.2.11) DEFINE_DRM_GEM_DMA_FOPS
> (4) struct memdev sets fmode flags based on type of device opened. For
>     devices using struct mem_fops unsigned offset is used.
> 
> Mark all these file operations as FOP_UNSIGNED_OFFSET and add asserts
> into the open helper to ensure that the flag is always set.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> ---
>  drivers/char/adi.c                      |  8 +-------
>  drivers/char/mem.c                      |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  1 +
>  drivers/gpu/drm/drm_file.c              |  3 ++-
>  drivers/gpu/drm/gma500/psb_drv.c        |  1 +
>  drivers/gpu/drm/i915/i915_driver.c      |  1 +
>  drivers/gpu/drm/nouveau/nouveau_drm.c   |  1 +
>  drivers/gpu/drm/radeon/radeon_drv.c     |  1 +
>  drivers/gpu/drm/tegra/drm.c             |  1 +
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c     |  1 +
>  drivers/gpu/drm/xe/xe_device.c          |  1 +
>  fs/proc/base.c                          | 10 ++++------
>  fs/read_write.c                         |  2 +-
>  include/drm/drm_accel.h                 |  3 ++-
>  include/drm/drm_gem.h                   |  3 ++-
>  include/drm/drm_gem_dma_helper.h        |  1 +
>  include/linux/fs.h                      |  5 +++--
>  mm/mmap.c                               |  2 +-
>  18 files changed, 27 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/char/adi.c b/drivers/char/adi.c
> index 751d7cc0da1b..1c76c8758f0f 100644
> --- a/drivers/char/adi.c
> +++ b/drivers/char/adi.c
> @@ -14,12 +14,6 @@
>  
>  #define MAX_BUF_SZ	PAGE_SIZE
>  
> -static int adi_open(struct inode *inode, struct file *file)
> -{
> -	file->f_mode |= FMODE_UNSIGNED_OFFSET;
> -	return 0;
> -}
> -
>  static int read_mcd_tag(unsigned long addr)
>  {
>  	long err;
> @@ -206,9 +200,9 @@ static loff_t adi_llseek(struct file *file, loff_t offset, int whence)
>  static const struct file_operations adi_fops = {
>  	.owner		= THIS_MODULE,
>  	.llseek		= adi_llseek,
> -	.open		= adi_open,
>  	.read		= adi_read,
>  	.write		= adi_write,
> +	.fop_flags	= FOP_UNSIGNED_OFFSET,
>  };
>  
>  static struct miscdevice adi_miscdev = {
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index 7c359cc406d5..169eed162a7f 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -643,6 +643,7 @@ static const struct file_operations __maybe_unused mem_fops = {
>  	.get_unmapped_area = get_unmapped_area_mem,
>  	.mmap_capabilities = memory_mmap_capabilities,
>  #endif
> +	.fop_flags	= FOP_UNSIGNED_OFFSET,
>  };
>  
>  static const struct file_operations null_fops = {
> @@ -693,7 +694,7 @@ static const struct memdev {
>  	umode_t mode;
>  } devlist[] = {
>  #ifdef CONFIG_DEVMEM
> -	[DEVMEM_MINOR] = { "mem", &mem_fops, FMODE_UNSIGNED_OFFSET, 0 },
> +	[DEVMEM_MINOR] = { "mem", &mem_fops, 0, 0 },
>  #endif
>  	[3] = { "null", &null_fops, FMODE_NOWAIT, 0666 },
>  #ifdef CONFIG_DEVPORT
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 094498a0964b..d7ef8cbecf6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2908,6 +2908,7 @@ static const struct file_operations amdgpu_driver_kms_fops = {
>  #ifdef CONFIG_PROC_FS
>  	.show_fdinfo = drm_show_fdinfo,
>  #endif
> +	.fop_flags = FOP_UNSIGNED_OFFSET,
>  };
>  
>  int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv)
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index 714e42b05108..f8de3cba1a08 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -318,6 +318,8 @@ int drm_open_helper(struct file *filp, struct drm_minor *minor)
>  	if (dev->switch_power_state != DRM_SWITCH_POWER_ON &&
>  	    dev->switch_power_state != DRM_SWITCH_POWER_DYNAMIC_OFF)
>  		return -EINVAL;
> +	if (WARN_ON_ONCE(!(filp->f_op->fop_flags & FOP_UNSIGNED_OFFSET)))
> +		return -EINVAL;
>  
>  	drm_dbg_core(dev, "comm=\"%s\", pid=%d, minor=%d\n",
>  		     current->comm, task_pid_nr(current), minor->index);
> @@ -335,7 +337,6 @@ int drm_open_helper(struct file *filp, struct drm_minor *minor)
>  	}
>  
>  	filp->private_data = priv;
> -	filp->f_mode |= FMODE_UNSIGNED_OFFSET;
>  	priv->filp = filp;
>  
>  	mutex_lock(&dev->filelist_mutex);
> diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
> index 8b64f61ffaf9..d67c2b3ad901 100644
> --- a/drivers/gpu/drm/gma500/psb_drv.c
> +++ b/drivers/gpu/drm/gma500/psb_drv.c
> @@ -498,6 +498,7 @@ static const struct file_operations psb_gem_fops = {
>  	.mmap = drm_gem_mmap,
>  	.poll = drm_poll,
>  	.read = drm_read,
> +	.fop_flags = FOP_UNSIGNED_OFFSET,
>  };
>  
>  static const struct drm_driver driver = {
> diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
> index fb8e9c2fcea5..cf276299bccb 100644
> --- a/drivers/gpu/drm/i915/i915_driver.c
> +++ b/drivers/gpu/drm/i915/i915_driver.c
> @@ -1671,6 +1671,7 @@ static const struct file_operations i915_driver_fops = {
>  #ifdef CONFIG_PROC_FS
>  	.show_fdinfo = drm_show_fdinfo,
>  #endif
> +	.fop_flags = FOP_UNSIGNED_OFFSET,
>  };
>  
>  static int
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
> index a58c31089613..e243b42f8582 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -1274,6 +1274,7 @@ nouveau_driver_fops = {
>  	.compat_ioctl = nouveau_compat_ioctl,
>  #endif
>  	.llseek = noop_llseek,
> +	.fop_flags = FOP_UNSIGNED_OFFSET,
>  };
>  
>  static struct drm_driver
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
> index 7bf08164140e..ac49779ed03d 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -520,6 +520,7 @@ static const struct file_operations radeon_driver_kms_fops = {
>  #ifdef CONFIG_COMPAT
>  	.compat_ioctl = radeon_kms_compat_ioctl,
>  #endif
> +	.fop_flags = FOP_UNSIGNED_OFFSET,
>  };
>  
>  static const struct drm_ioctl_desc radeon_ioctls_kms[] = {
> diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
> index 03d1c76aec2d..108c26a33edb 100644
> --- a/drivers/gpu/drm/tegra/drm.c
> +++ b/drivers/gpu/drm/tegra/drm.c
> @@ -801,6 +801,7 @@ static const struct file_operations tegra_drm_fops = {
>  	.read = drm_read,
>  	.compat_ioctl = drm_compat_ioctl,
>  	.llseek = noop_llseek,
> +	.fop_flags = FOP_UNSIGNED_OFFSET,
>  };
>  
>  static int tegra_drm_context_cleanup(int id, void *p, void *data)
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> index 50ad3105c16e..2825dd3149ed 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> @@ -1609,6 +1609,7 @@ static const struct file_operations vmwgfx_driver_fops = {
>  	.compat_ioctl = vmw_compat_ioctl,
>  #endif
>  	.llseek = noop_llseek,
> +	.fop_flags = FOP_UNSIGNED_OFFSET,
>  };
>  
>  static const struct drm_driver driver = {
> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
> index 76109415eba6..ea7e3ff6feba 100644
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
> @@ -197,6 +197,7 @@ static const struct file_operations xe_driver_fops = {
>  #ifdef CONFIG_PROC_FS
>  	.show_fdinfo = drm_show_fdinfo,
>  #endif
> +	.fop_flags = FOP_UNSIGNED_OFFSET,
>  };
>  
>  static struct drm_driver driver = {
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 72a1acd03675..1409d1003101 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -827,12 +827,9 @@ static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
>  
>  static int mem_open(struct inode *inode, struct file *file)
>  {
> -	int ret = __mem_open(inode, file, PTRACE_MODE_ATTACH);
> -
> -	/* OK to pass negative loff_t, we can catch out-of-range */
> -	file->f_mode |= FMODE_UNSIGNED_OFFSET;
> -
> -	return ret;
> +	if (WARN_ON_ONCE(!(file->f_op->fop_flags & FOP_UNSIGNED_OFFSET)))
> +		return -EINVAL;
> +	return __mem_open(inode, file, PTRACE_MODE_ATTACH);
>  }
>  
>  static ssize_t mem_rw(struct file *file, char __user *buf,
> @@ -932,6 +929,7 @@ static const struct file_operations proc_mem_operations = {
>  	.write		= mem_write,
>  	.open		= mem_open,
>  	.release	= mem_release,
> +	.fop_flags	= FOP_UNSIGNED_OFFSET,
>  };
>  
>  static int environ_open(struct inode *inode, struct file *file)
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 90e283b31ca1..89d4af0e3b93 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -36,7 +36,7 @@ EXPORT_SYMBOL(generic_ro_fops);
>  
>  static inline bool unsigned_offsets(struct file *file)
>  {
> -	return file->f_mode & FMODE_UNSIGNED_OFFSET;
> +	return file->f_op->fop_flags & FOP_UNSIGNED_OFFSET;
>  }
>  
>  /**
> diff --git a/include/drm/drm_accel.h b/include/drm/drm_accel.h
> index f4d3784b1dce..41c78b7d712c 100644
> --- a/include/drm/drm_accel.h
> +++ b/include/drm/drm_accel.h
> @@ -28,7 +28,8 @@
>  	.poll		= drm_poll,\
>  	.read		= drm_read,\
>  	.llseek		= noop_llseek, \
> -	.mmap		= drm_gem_mmap
> +	.mmap		= drm_gem_mmap, \
> +	.fop_flags	= FOP_UNSIGNED_OFFSET
>  
>  /**
>   * DEFINE_DRM_ACCEL_FOPS() - macro to generate file operations for accelerators drivers
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index bae4865b2101..d8b86df2ec0d 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -447,7 +447,8 @@ struct drm_gem_object {
>  	.poll		= drm_poll,\
>  	.read		= drm_read,\
>  	.llseek		= noop_llseek,\
> -	.mmap		= drm_gem_mmap
> +	.mmap		= drm_gem_mmap, \
> +	.fop_flags	= FOP_UNSIGNED_OFFSET
>  
>  /**
>   * DEFINE_DRM_GEM_FOPS() - macro to generate file operations for GEM drivers
> diff --git a/include/drm/drm_gem_dma_helper.h b/include/drm/drm_gem_dma_helper.h
> index a827bde494f6..f2678e7ecb98 100644
> --- a/include/drm/drm_gem_dma_helper.h
> +++ b/include/drm/drm_gem_dma_helper.h
> @@ -267,6 +267,7 @@ unsigned long drm_gem_dma_get_unmapped_area(struct file *filp,
>  		.read		= drm_read,\
>  		.llseek		= noop_llseek,\
>  		.mmap		= drm_gem_mmap,\
> +		.fop_flags = FOP_UNSIGNED_OFFSET, \
>  		DRM_GEM_DMA_UNMAPPED_AREA_FOPS \
>  	}
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index fd34b5755c0b..40ebfa09112c 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -146,8 +146,7 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
>  /* Expect random access pattern */
>  #define FMODE_RANDOM		((__force fmode_t)(1 << 12))
>  
> -/* File is huge (eg. /dev/mem): treat loff_t as unsigned */
> -#define FMODE_UNSIGNED_OFFSET	((__force fmode_t)(1 << 13))
> +/* FMODE_* bit 13 */
>  
>  /* File is opened with O_PATH; almost nothing can be done with it */
>  #define FMODE_PATH		((__force fmode_t)(1 << 14))
> @@ -2073,6 +2072,8 @@ struct file_operations {
>  #define FOP_DIO_PARALLEL_WRITE	((__force fop_flags_t)(1 << 3))
>  /* Contains huge pages */
>  #define FOP_HUGE_PAGES		((__force fop_flags_t)(1 << 4))
> +/* Treat loff_t as unsigned (e.g., /dev/mem) */
> +#define FOP_UNSIGNED_OFFSET	((__force fop_flags_t)(1 << 5))
>  
>  /* Wrap a directory iterator that needs exclusive inode access */
>  int wrap_directory_iterator(struct file *, struct dir_context *,
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d0dfc85b209b..6ddb278a5ee8 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1229,7 +1229,7 @@ static inline u64 file_mmap_size_max(struct file *file, struct inode *inode)
>  		return MAX_LFS_FILESIZE;
>  
>  	/* Special "we do even unsigned file positions" case */
> -	if (file->f_mode & FMODE_UNSIGNED_OFFSET)
> +	if (file->f_op->fop_flags & FOP_UNSIGNED_OFFSET)
>  		return 0;
>  
>  	/* Yes, random drivers might want more. But I'm tired of buggy drivers */
> 
> ---
> base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
> change-id: 20240809-work-fop_unsigned-5f6f7734cb7b
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

