Return-Path: <linux-fsdevel+bounces-4842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42124804A3A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 07:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D899AB20AA1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 06:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A55D276
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 06:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="METwknOs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8292F6FB8;
	Tue,  5 Dec 2023 05:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9C9C433C8;
	Tue,  5 Dec 2023 05:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701754883;
	bh=EGD2m+dW91SvCc9znl5dHUo5p9bt+T4CqT05Ww/Dy64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=METwknOsaOFQLA1cKhDWgucbecujxzchFUbQkTvZsRkbNPTqHpw7jmeaZ/xe7NlSY
	 uDRfXN8KwwHpNutqy/RQSt1kuqtF4V+5g8/OngBE8eZmhC1DCOjEZ16//WdZ0fRopE
	 MwMhbckEymmUJDUAxort0E+Fy96aIRQTl/cyEHF6T2vQkXYPWrkjkDa5Cgd9CHX94e
	 j0BY5zCKjwFG7Emu0DfzyDi2Y3Fz67wMYt1M2VU3cs3riwRPy/RuYRYHboZDD9aPdR
	 daXVUpwI0L9baTNYjjjhZ3/aJXVf/kyC9pO7Ecj/970mb0hBGbt7cSBz9v5PkT3Bgt
	 EI38/YrJtjZug==
Date: Mon, 4 Dec 2023 21:41:21 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: Re: [PATCH v4 19/46] btrfs: turn on inlinecrypt mount option for
 encrypt
Message-ID: <20231205054121.GM1168@sol.localdomain>
References: <cover.1701468305.git.josef@toxicpanda.com>
 <a3f216c6e951b8d1b3cb9b96dcd6d44e1c19bd9b.1701468306.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3f216c6e951b8d1b3cb9b96dcd6d44e1c19bd9b.1701468306.git.josef@toxicpanda.com>

On Fri, Dec 01, 2023 at 05:11:16PM -0500, Josef Bacik wrote:
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 0e8e2ca48a2e..48d751011d07 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -4585,6 +4585,9 @@ long btrfs_ioctl(struct file *file, unsigned int
>  		 * state persists.
>  		 */
>  		btrfs_set_fs_incompat(fs_info, ENCRYPT);
> +		if (!(inode->i_sb->s_flags & SB_INLINECRYPT)) {
> +			inode->i_sb->s_flags |= SB_INLINECRYPT;
> +		}
>  		return fscrypt_ioctl_set_policy(file, (const void __user *)arg);
>  	}

Multiple tasks can execute ioctls at the same time, so isn't the lockless
modification of 's_flags' above a data race?

Maybe you should just set SB_INLINECRYPT at mount time only, regardless of the
ENCRYPT feature, so that it doesn't have to be enabled later.

> +	if (btrfs_fs_incompat(fs_info, ENCRYPT)) {
> +		if (IS_ENABLED(CONFIG_FS_ENCRYPTION_INLINE_CRYPT)) {
> +			sb->s_flags |= SB_INLINECRYPT;
> +		} else {
> +			btrfs_err(fs_info, "encryption not supported");
> +			err = -EINVAL;
> +			goto fail_close;
> +		}
> +	}

Why CONFIG_FS_ENCRYPTION_INLINE_CRYPT instead of CONFIG_FS_ENCRYPTION?  I think
you need to make CONFIG_FS_ENCRYPTION select CONFIG_FS_ENCRYPTION_INLINE_CRYPT
when btrfs is enabled anyway, right?

Also, should the error message be clearer?  Like "filesystem has encrypt feature
but kernel doesn't support encryption", or something like that.  Actually,
should that case even be an error?  ext4, for example, allows a filesystem with
the encrypt feature to be mounted even when the kernel doesn't support
encryption.  (It doesn't allow access to encrypted files, of course.)

- Eric

