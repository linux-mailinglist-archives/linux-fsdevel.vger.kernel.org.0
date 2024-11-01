Return-Path: <linux-fsdevel+bounces-33443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E47D9B8BF7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 08:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432182821C8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 07:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DDE1531EF;
	Fri,  1 Nov 2024 07:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PP3xJYs1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2903E4E1CA;
	Fri,  1 Nov 2024 07:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730445585; cv=none; b=r5UMBJixgKMakztCERc97DI5MrYgsBUufTBNHJWonkPMnYNi1Qxh6zmp4KzwoG9XNBdXfQSRcIqM5ZIzu4tRWMZWt831qY6zRVTaEdpe1fxaOynMsOir+61dAU1yES8S7Iu9ZvkmFO86A0dZlU3tmsBGD62DaBQToTTJHt6Rk2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730445585; c=relaxed/simple;
	bh=RnTQ1elkFuyR+PQ466DkLTDfOSe69lYJq3xND9eki5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klfn2bJb2eh/JbtjuflEp9cYjmGlRx2CRBa7wfo5BXnUl4eqz5iYSzbphPowTKrQI5NWeENM49bUGEcsv5B1bR0FWD/xXGrKOnpm+csFhwRx9I0CoMGMogf1/+UI8gaIgiSV3iU2BtIK8GDhe61dwDg59UTRO/Jw3uvKacBiGU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PP3xJYs1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B053C4CECD;
	Fri,  1 Nov 2024 07:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730445584;
	bh=RnTQ1elkFuyR+PQ466DkLTDfOSe69lYJq3xND9eki5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PP3xJYs1PWrZBmr3rjwFI0lOjOUunRpxf10OfsTKeiOxbHF3xjuzzGJ+sbpFecEKm
	 ho9Uqluncg+YllXZZzYnQCHMkKFFSC/ufv0lA3BcjV+YUAm8nCiJFLbmcp1W5Lx7jk
	 RqVfxMZSqPrpw95u+KOSDInRX0mweOhXBflPAQr5zX6ZDl28Xwhlo3Yb0iZyacSgBw
	 K9GoTIKlw4VyVkYtPoyxyQyvTVsqryssACDtD/rEJ6ZKWdmJb1AuGEj/VDaHjGOvo1
	 YqwBp/ggQCMYrDJjg96S7b7oKKlDdIqfiwL6M4XP6Gd4SJ/W9FWimAddUsJGv+V94k
	 SkJ7aJV6FX0FQ==
Date: Fri, 1 Nov 2024 00:19:42 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	krisman@kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 3/3] tmpfs: Initialize sysfs during tmpfs init
Message-ID: <20241101071942.GB2962282@thelio-3990X>
References: <20241101013741.295792-1-andrealmeid@igalia.com>
 <20241101013741.295792-4-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241101013741.295792-4-andrealmeid@igalia.com>

Hi André,

On Thu, Oct 31, 2024 at 10:37:41PM -0300, André Almeida wrote:
> Instead of using fs_initcall(), initialize sysfs with the rest of the
> filesystem. This is the right way to do it because otherwise any error
> during tmpfs_sysfs_init() would get silently ignored. It's also useful
> if tmpfs' sysfs ever need to display runtime information.
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
>  mm/shmem.c | 130 ++++++++++++++++++++++++++++-------------------------
>  1 file changed, 68 insertions(+), 62 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 6038e1d11987..8ff2f619f531 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -5126,6 +5126,66 @@ static struct file_system_type shmem_fs_type = {
>  	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP | FS_MGTIME,
>  };
>  
> +#if defined(CONFIG_SYSFS) && defined(CONFIG_TMPFS)

This condition...

> +static int __init tmpfs_sysfs_init(void)
> +{
> +	int ret;
> +
> +	tmpfs_kobj = kobject_create_and_add("tmpfs", fs_kobj);
> +	if (!tmpfs_kobj)
> +		return -ENOMEM;
> +
> +	ret = sysfs_create_group(tmpfs_kobj, &tmpfs_attribute_group);
> +	if (ret)
> +		kobject_put(tmpfs_kobj);
> +
> +	return ret;
> +}
> +#endif /* CONFIG_SYSFS && CONFIG_TMPFS */
> +
>  void __init shmem_init(void)
>  {
>  	int error;
> @@ -5149,6 +5209,14 @@ void __init shmem_init(void)
>  		goto out1;
>  	}
>  
> +#ifdef CONFIG_SYSFS

and this condition are not the same, so there will be a compile error if
CONFIG_SHMEM and CONFIG_SYSFS are enabled but CONFIG_TMPFS is not, such
as with ARCH=x86_64 allnoconfig for me:

  mm/shmem.c: In function 'shmem_init':
  mm/shmem.c:5243:17: error: implicit declaration of function 'tmpfs_sysfs_init'; did you mean 'uids_sysfs_init'? [-Wimplicit-function-declaration]
   5243 |         error = tmpfs_sysfs_init();
        |                 ^~~~~~~~~~~~~~~~
        |                 uids_sysfs_init

> +	error = tmpfs_sysfs_init();
> +	if (error) {
> +		pr_err("Could not init tmpfs sysfs\n");
> +		goto out1;
> +	}
> +#endif

Cheers,
Nathan

