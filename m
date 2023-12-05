Return-Path: <linux-fsdevel+bounces-4838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADC5804A32
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 07:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87810281178
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 06:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4074012E55
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 06:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzY1iKQu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E3C6AD7;
	Tue,  5 Dec 2023 05:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D34C433C7;
	Tue,  5 Dec 2023 05:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701753077;
	bh=08/xrYNx1KD3FQY8UkmUKpN4wf3Eh09m/6bAZwCuidA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CzY1iKQu9t1UOTI7yD0PvR7jRXgLwEBzCGiPxSqFJ3QrSePsDMOn0pPY7L/Rtx4vC
	 ocyduR3PKPlkUWBwHLAriofZmaxb4LMPalSd89NrAv953v9uiYr2u/Wj+R41U268Xs
	 78bx+z6z4NW2dqGdWeJc/OqcXu6l8v7wClNIEzfqlxCYCFiZsWxx9kdYYrKPXasmfC
	 sv28JxjvjFSDnzm8n2woOw2QF7UFGXjy/qef9VgBEB6TjQXvWFpb66JHTgiF9QjIsC
	 dB3attMLVXx94d9F9SzB2pjA7stKBFChbjELUXYxOwd8XGybH8iVhcMdvdubXPnrER
	 BVBUyR0++EVXw==
Date: Mon, 4 Dec 2023 21:11:15 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: Re: [PATCH v4 17/46] btrfs: add encryption to CONFIG_BTRFS_DEBUG
Message-ID: <20231205051115.GJ1168@sol.localdomain>
References: <cover.1701468305.git.josef@toxicpanda.com>
 <162cd559b6a47e1df6e49b15acb24942577280f5.1701468306.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162cd559b6a47e1df6e49b15acb24942577280f5.1701468306.git.josef@toxicpanda.com>

On Fri, Dec 01, 2023 at 05:11:14PM -0500, Josef Bacik wrote:
> From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> 
> Since encryption is currently under BTRFS_DEBUG, this adds its
> dependencies: inline encryption from fscrypt, and the inline encryption
> fallback path from the block layer.
> 
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/ioctl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 9968a36079c4..0e8e2ca48a2e 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -4573,6 +4573,7 @@ long btrfs_ioctl(struct file *file, unsigned int
>  		return btrfs_ioctl_get_fslabel(fs_info, argp);
>  	case FS_IOC_SETFSLABEL:
>  		return btrfs_ioctl_set_fslabel(file, argp);
> +#ifdef CONFIG_BTRFS_DEBUG
>  	case FS_IOC_SET_ENCRYPTION_POLICY: {
>  		if (!IS_ENABLED(CONFIG_FS_ENCRYPTION))
>  			return -EOPNOTSUPP;
> @@ -4601,6 +4602,7 @@ long btrfs_ioctl(struct file *file, unsigned int
>  		return fscrypt_ioctl_get_key_status(file, (void __user *)arg);
>  	case FS_IOC_GET_ENCRYPTION_NONCE:
>  		return fscrypt_ioctl_get_nonce(file, (void __user *)arg);
> +#endif /* CONFIG_BTRFS_DEBUG */

This diff doesn't seem to match the commit message.

BTW, only semi-related, but BTRFS_FS should select FS_ENCRYPTION_ALGS if
FS_ENCRYPTION.

- Eric

