Return-Path: <linux-fsdevel+bounces-25518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 723B194D015
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 14:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2E3DB216CC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 12:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B4F194082;
	Fri,  9 Aug 2024 12:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ID6t4lNP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E954A3398E
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723206188; cv=none; b=UmgmfIxAGPGJgQ5Sben1BI3MY2nZnK7HiwuNY+BioGorA8yB/jZAQ+HNzDO2boR6RiUqdlzy3a2pVu7pwZw5rPV4G6A49eP4vv5KObYkiCudmsXLpP1UXMrwU9/yxCwyWjCAFHl0Expi2xitEFgZ7QjE9NUQeyFaChwXmPS18Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723206188; c=relaxed/simple;
	bh=g9EMRdBGSAchBLs7haAE/cjma5cC7NP5KKUlcJ3FoV8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t7UypfIDUamVMVDrCtGsPe7ihT3hdOJQ3VxzW6McvEcrmrlJSsvaJXV5GnCyXnBkZnVXhCq8qf0chVLZvaXvpzkPjYDGkv+tEZXkNLiOt0bYCLGDBTNOqHni9JUT73iXR66BKMlyz0B704M3xWnsxihuwWgMWN7JX4Sqq3C02fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ID6t4lNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0520C32782;
	Fri,  9 Aug 2024 12:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723206187;
	bh=g9EMRdBGSAchBLs7haAE/cjma5cC7NP5KKUlcJ3FoV8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ID6t4lNPxdKUTPIsuDTFEI5fFbrMQKoLC/3lPI0C7pl0BSenbT5Fz/zVRp1ndnEOX
	 CqVm8DYj2UOUWBOWIhiA94g2vTvEKJThHWvwnHS4ZwGjHAvn3iKwvJXuDXA6TVAg2L
	 wqBzBfj67Uqup1ySUn6G7LNThsA6VEZNM8u7OuOcl3/ljP3Q9NdH+rhiLxk3UBuXtd
	 N8QmxqIgBe0d+j/DKRbdS+ef4F2gTJ6RCpHE7uBNfyBaUmnTBd7WtZwLvzCNOq3yNS
	 sSkIYzfN1oDp7eD1nFwTNIQFSigaGzIxeIfYQgNSoinA4lQ2k3hhIA+L+/m2Rurmtw
	 ANd9qlEeT9hRg==
Message-ID: <6aec7ebc2c88c61d0b978538f23660eb8fa32efd.camel@kernel.org>
Subject: Re: [PATCH] fs: move FMODE_UNSIGNED_OFFSET to fop_flags
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, Josef Bacik
	 <josef@toxicpanda.com>
Date: Fri, 09 Aug 2024 08:23:05 -0400
In-Reply-To: <20240809-work-fop_unsigned-v1-1-658e054d893e@kernel.org>
References: <20240809-work-fop_unsigned-v1-1-658e054d893e@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-09 at 12:38 +0200, Christian Brauner wrote:
> This is another flag that is statically set and doesn't need to use up
> an FMODE_* bit. Move it to ->fop_flags and free up another FMODE_* bit.
>=20
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
>=20
> Mark all these file operations as FOP_UNSIGNED_OFFSET and add asserts
> into the open helper to ensure that the flag is always set.
>=20
> Signed-off-by: Christian Brauner <brauner@kernel.org>
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
>=20
> diff --git a/drivers/char/adi.c b/drivers/char/adi.c
> index 751d7cc0da1b..1c76c8758f0f 100644
> --- a/drivers/char/adi.c
> +++ b/drivers/char/adi.c
> @@ -14,12 +14,6 @@
> =20
>  #define MAX_BUF_SZ	PAGE_SIZE
> =20
> -static int adi_open(struct inode *inode, struct file *file)
> -{
> -	file->f_mode |=3D FMODE_UNSIGNED_OFFSET;
> -	return 0;
> -}
> -
>  static int read_mcd_tag(unsigned long addr)
>  {
>  	long err;
> @@ -206,9 +200,9 @@ static loff_t adi_llseek(struct file *file, loff_t of=
fset, int whence)
>  static const struct file_operations adi_fops =3D {
>  	.owner		=3D THIS_MODULE,
>  	.llseek		=3D adi_llseek,
> -	.open		=3D adi_open,
>  	.read		=3D adi_read,
>  	.write		=3D adi_write,
> +	.fop_flags	=3D FOP_UNSIGNED_OFFSET,
>  };
> =20
>  static struct miscdevice adi_miscdev =3D {
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index 7c359cc406d5..169eed162a7f 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -643,6 +643,7 @@ static const struct file_operations __maybe_unused me=
m_fops =3D {
>  	.get_unmapped_area =3D get_unmapped_area_mem,
>  	.mmap_capabilities =3D memory_mmap_capabilities,
>  #endif
> +	.fop_flags	=3D FOP_UNSIGNED_OFFSET,
>  };
> =20
>  static const struct file_operations null_fops =3D {
> @@ -693,7 +694,7 @@ static const struct memdev {
>  	umode_t mode;
>  } devlist[] =3D {
>  #ifdef CONFIG_DEVMEM
> -	[DEVMEM_MINOR] =3D { "mem", &mem_fops, FMODE_UNSIGNED_OFFSET, 0 },
> +	[DEVMEM_MINOR] =3D { "mem", &mem_fops, 0, 0 },
>  #endif
>  	[3] =3D { "null", &null_fops, FMODE_NOWAIT, 0666 },
>  #ifdef CONFIG_DEVPORT
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 094498a0964b..d7ef8cbecf6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2908,6 +2908,7 @@ static const struct file_operations amdgpu_driver_k=
ms_fops =3D {
>  #ifdef CONFIG_PROC_FS
>  	.show_fdinfo =3D drm_show_fdinfo,
>  #endif
> +	.fop_flags =3D FOP_UNSIGNED_OFFSET,
>  };
> =20
>  int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv)
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index 714e42b05108..f8de3cba1a08 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -318,6 +318,8 @@ int drm_open_helper(struct file *filp, struct drm_min=
or *minor)
>  	if (dev->switch_power_state !=3D DRM_SWITCH_POWER_ON &&
>  	    dev->switch_power_state !=3D DRM_SWITCH_POWER_DYNAMIC_OFF)
>  		return -EINVAL;
> +	if (WARN_ON_ONCE(!(filp->f_op->fop_flags & FOP_UNSIGNED_OFFSET)))
> +		return -EINVAL;
> =20
>  	drm_dbg_core(dev, "comm=3D\"%s\", pid=3D%d, minor=3D%d\n",
>  		     current->comm, task_pid_nr(current), minor->index);
> @@ -335,7 +337,6 @@ int drm_open_helper(struct file *filp, struct drm_min=
or *minor)
>  	}
> =20
>  	filp->private_data =3D priv;
> -	filp->f_mode |=3D FMODE_UNSIGNED_OFFSET;
>  	priv->filp =3D filp;
> =20
>  	mutex_lock(&dev->filelist_mutex);
> diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/ps=
b_drv.c
> index 8b64f61ffaf9..d67c2b3ad901 100644
> --- a/drivers/gpu/drm/gma500/psb_drv.c
> +++ b/drivers/gpu/drm/gma500/psb_drv.c
> @@ -498,6 +498,7 @@ static const struct file_operations psb_gem_fops =3D =
{
>  	.mmap =3D drm_gem_mmap,
>  	.poll =3D drm_poll,
>  	.read =3D drm_read,
> +	.fop_flags =3D FOP_UNSIGNED_OFFSET,
>  };
> =20
>  static const struct drm_driver driver =3D {
> diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i9=
15_driver.c
> index fb8e9c2fcea5..cf276299bccb 100644
> --- a/drivers/gpu/drm/i915/i915_driver.c
> +++ b/drivers/gpu/drm/i915/i915_driver.c
> @@ -1671,6 +1671,7 @@ static const struct file_operations i915_driver_fop=
s =3D {
>  #ifdef CONFIG_PROC_FS
>  	.show_fdinfo =3D drm_show_fdinfo,
>  #endif
> +	.fop_flags =3D FOP_UNSIGNED_OFFSET,
>  };
> =20
>  static int
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouv=
eau/nouveau_drm.c
> index a58c31089613..e243b42f8582 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -1274,6 +1274,7 @@ nouveau_driver_fops =3D {
>  	.compat_ioctl =3D nouveau_compat_ioctl,
>  #endif
>  	.llseek =3D noop_llseek,
> +	.fop_flags =3D FOP_UNSIGNED_OFFSET,
>  };
> =20
>  static struct drm_driver
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon=
/radeon_drv.c
> index 7bf08164140e..ac49779ed03d 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -520,6 +520,7 @@ static const struct file_operations radeon_driver_kms=
_fops =3D {
>  #ifdef CONFIG_COMPAT
>  	.compat_ioctl =3D radeon_kms_compat_ioctl,
>  #endif
> +	.fop_flags =3D FOP_UNSIGNED_OFFSET,
>  };
> =20
>  static const struct drm_ioctl_desc radeon_ioctls_kms[] =3D {
> diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
> index 03d1c76aec2d..108c26a33edb 100644
> --- a/drivers/gpu/drm/tegra/drm.c
> +++ b/drivers/gpu/drm/tegra/drm.c
> @@ -801,6 +801,7 @@ static const struct file_operations tegra_drm_fops =
=3D {
>  	.read =3D drm_read,
>  	.compat_ioctl =3D drm_compat_ioctl,
>  	.llseek =3D noop_llseek,
> +	.fop_flags =3D FOP_UNSIGNED_OFFSET,
>  };
> =20
>  static int tegra_drm_context_cleanup(int id, void *p, void *data)
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_drv.c
> index 50ad3105c16e..2825dd3149ed 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> @@ -1609,6 +1609,7 @@ static const struct file_operations vmwgfx_driver_f=
ops =3D {
>  	.compat_ioctl =3D vmw_compat_ioctl,
>  #endif
>  	.llseek =3D noop_llseek,
> +	.fop_flags =3D FOP_UNSIGNED_OFFSET,
>  };
> =20
>  static const struct drm_driver driver =3D {
> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_devic=
e.c
> index 76109415eba6..ea7e3ff6feba 100644
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
> @@ -197,6 +197,7 @@ static const struct file_operations xe_driver_fops =
=3D {
>  #ifdef CONFIG_PROC_FS
>  	.show_fdinfo =3D drm_show_fdinfo,
>  #endif
> +	.fop_flags =3D FOP_UNSIGNED_OFFSET,
>  };
> =20
>  static struct drm_driver driver =3D {
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 72a1acd03675..1409d1003101 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -827,12 +827,9 @@ static int __mem_open(struct inode *inode, struct fi=
le *file, unsigned int mode)
> =20
>  static int mem_open(struct inode *inode, struct file *file)
>  {
> -	int ret =3D __mem_open(inode, file, PTRACE_MODE_ATTACH);
> -
> -	/* OK to pass negative loff_t, we can catch out-of-range */
> -	file->f_mode |=3D FMODE_UNSIGNED_OFFSET;
> -
> -	return ret;
> +	if (WARN_ON_ONCE(!(file->f_op->fop_flags & FOP_UNSIGNED_OFFSET)))
> +		return -EINVAL;
> +	return __mem_open(inode, file, PTRACE_MODE_ATTACH);
>  }
> =20
>  static ssize_t mem_rw(struct file *file, char __user *buf,
> @@ -932,6 +929,7 @@ static const struct file_operations proc_mem_operatio=
ns =3D {
>  	.write		=3D mem_write,
>  	.open		=3D mem_open,
>  	.release	=3D mem_release,
> +	.fop_flags	=3D FOP_UNSIGNED_OFFSET,
>  };
> =20
>  static int environ_open(struct inode *inode, struct file *file)
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 90e283b31ca1..89d4af0e3b93 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -36,7 +36,7 @@ EXPORT_SYMBOL(generic_ro_fops);
> =20
>  static inline bool unsigned_offsets(struct file *file)
>  {
> -	return file->f_mode & FMODE_UNSIGNED_OFFSET;
> +	return file->f_op->fop_flags & FOP_UNSIGNED_OFFSET;
>  }
> =20
>  /**
> diff --git a/include/drm/drm_accel.h b/include/drm/drm_accel.h
> index f4d3784b1dce..41c78b7d712c 100644
> --- a/include/drm/drm_accel.h
> +++ b/include/drm/drm_accel.h
> @@ -28,7 +28,8 @@
>  	.poll		=3D drm_poll,\
>  	.read		=3D drm_read,\
>  	.llseek		=3D noop_llseek, \
> -	.mmap		=3D drm_gem_mmap
> +	.mmap		=3D drm_gem_mmap, \
> +	.fop_flags	=3D FOP_UNSIGNED_OFFSET
> =20
>  /**
>   * DEFINE_DRM_ACCEL_FOPS() - macro to generate file operations for accel=
erators drivers
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index bae4865b2101..d8b86df2ec0d 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -447,7 +447,8 @@ struct drm_gem_object {
>  	.poll		=3D drm_poll,\
>  	.read		=3D drm_read,\
>  	.llseek		=3D noop_llseek,\
> -	.mmap		=3D drm_gem_mmap
> +	.mmap		=3D drm_gem_mmap, \
> +	.fop_flags	=3D FOP_UNSIGNED_OFFSET
> =20
>  /**
>   * DEFINE_DRM_GEM_FOPS() - macro to generate file operations for GEM dri=
vers
> diff --git a/include/drm/drm_gem_dma_helper.h b/include/drm/drm_gem_dma_h=
elper.h
> index a827bde494f6..f2678e7ecb98 100644
> --- a/include/drm/drm_gem_dma_helper.h
> +++ b/include/drm/drm_gem_dma_helper.h
> @@ -267,6 +267,7 @@ unsigned long drm_gem_dma_get_unmapped_area(struct fi=
le *filp,
>  		.read		=3D drm_read,\
>  		.llseek		=3D noop_llseek,\
>  		.mmap		=3D drm_gem_mmap,\
> +		.fop_flags =3D FOP_UNSIGNED_OFFSET, \
>  		DRM_GEM_DMA_UNMAPPED_AREA_FOPS \
>  	}
> =20
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index fd34b5755c0b..40ebfa09112c 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -146,8 +146,7 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t=
 offset,
>  /* Expect random access pattern */
>  #define FMODE_RANDOM		((__force fmode_t)(1 << 12))
> =20
> -/* File is huge (eg. /dev/mem): treat loff_t as unsigned */
> -#define FMODE_UNSIGNED_OFFSET	((__force fmode_t)(1 << 13))
> +/* FMODE_* bit 13 */
> =20
>  /* File is opened with O_PATH; almost nothing can be done with it */
>  #define FMODE_PATH		((__force fmode_t)(1 << 14))
> @@ -2073,6 +2072,8 @@ struct file_operations {
>  #define FOP_DIO_PARALLEL_WRITE	((__force fop_flags_t)(1 << 3))
>  /* Contains huge pages */
>  #define FOP_HUGE_PAGES		((__force fop_flags_t)(1 << 4))
> +/* Treat loff_t as unsigned (e.g., /dev/mem) */
> +#define FOP_UNSIGNED_OFFSET	((__force fop_flags_t)(1 << 5))
> =20
>  /* Wrap a directory iterator that needs exclusive inode access */
>  int wrap_directory_iterator(struct file *, struct dir_context *,
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d0dfc85b209b..6ddb278a5ee8 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1229,7 +1229,7 @@ static inline u64 file_mmap_size_max(struct file *f=
ile, struct inode *inode)
>  		return MAX_LFS_FILESIZE;
> =20
>  	/* Special "we do even unsigned file positions" case */
> -	if (file->f_mode & FMODE_UNSIGNED_OFFSET)
> +	if (file->f_op->fop_flags & FOP_UNSIGNED_OFFSET)
>  		return 0;
> =20
>  	/* Yes, random drivers might want more. But I'm tired of buggy drivers =
*/
>=20
> ---
> base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
> change-id: 20240809-work-fop_unsigned-5f6f7734cb7b
>=20

Nice.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

