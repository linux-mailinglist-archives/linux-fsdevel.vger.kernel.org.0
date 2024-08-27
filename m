Return-Path: <linux-fsdevel+bounces-27268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 547A995FEE1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 04:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F150F1F2284D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 02:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4688C8C7;
	Tue, 27 Aug 2024 02:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIQ5ks6D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECC210A1F;
	Tue, 27 Aug 2024 02:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724724781; cv=none; b=XhUT6792Uru3BaqGyjhd9OLaVsq6mzQdXMA0m9L9MyYtxh9DAL2a+4wo5xbksFLDskaMF9kp6dBEbN9pmA8uJLnfaU/GyyP2focMQrAa4O4VPVmCvrI11c9OkkuKnnXv/twyNPd8CEifr4S4ddCisXMWTq/BudpFm1QygHho8iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724724781; c=relaxed/simple;
	bh=52eAx3gO8uEk6S8PQUMzNViD8dCJuPh/+GLrhAbSKlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoC0yLQxBU3wA9bFa2sHigsvSMDiZFzArOxuLKB/jNDk2rJAQpCl4OuDDeBs05rDcB6No4fzy7Ju1B7dodqDxcLOizlqtm/jahJsnfrXesZZd/GNyoW2/YBKgvVrwrcn4Vbb7cYEStFZLp/hR4gEjWb2FAAGPu8SoOx+lF5HXE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIQ5ks6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DEF4C4AF63;
	Tue, 27 Aug 2024 02:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724724780;
	bh=52eAx3gO8uEk6S8PQUMzNViD8dCJuPh/+GLrhAbSKlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pIQ5ks6DlsyEiHTDCZQFffom2YyAGESNmjUUIUVG37c7UepB53U7rIn1xiDcw1YZl
	 xud3feF1RKVcUReq7xNezXE1Tu1HUKMqtqClf7JZjxYOhBxaKtRUFBJ6TYduF6Pcah
	 +ltC5fyTX8ACflI4ri2yAD9uXsa/lqA+7y5q2s1PkWbko39haG2BojvVO/GvUM44dK
	 Rg9NDbAB8wSCiZbkF16A9sN/CmG6DErv/y5OqsXzPT2MclfAErsLS3vYq0il50URHw
	 AvfwXYGkLuLX0wvuvbjIbCvDU2X5FkFUuDhBnewAI+4vQiQ+jyX70B1Dl6vZpeNmqX
	 OdKo4vIKnOAfQ==
Date: Mon, 26 Aug 2024 19:13:00 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk,
	gnoack@google.com, mic@digikod.net, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] fs: obtain the inode generation number from vfs
 directly
Message-ID: <20240827021300.GK6043@frogsfrogsfrogs>
References: <20240827014108.222719-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827014108.222719-1-lihongbo22@huawei.com>

On Tue, Aug 27, 2024 at 01:41:08AM +0000, Hongbo Li wrote:
> Many mainstream file systems already support the GETVERSION ioctl,
> and their implementations are completely the same, essentially
> just obtain the value of i_generation. We think this ioctl can be
> implemented at the VFS layer, so the file systems do not need to
> implement it individually.

What if a filesystem never touches i_generation?  Is it ok to advertise
a generation number of zero when that's really meaningless?  Or should
we gate the generic ioctl on (say) whether or not the fs implements file
handles and/or supports nfs?

--D

> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  fs/ioctl.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 64776891120c..dff887ec52c4 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -878,6 +878,9 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
>  	case FS_IOC_GETFSUUID:
>  		return ioctl_getfsuuid(filp, argp);
>  
> +	case FS_IOC_GETVERSION:
> +		return put_user(inode->i_generation, (int __user *)argp);
> +
>  	case FS_IOC_GETFSSYSFSPATH:
>  		return ioctl_get_fs_sysfs_path(filp, argp);
>  
> @@ -992,6 +995,9 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
>  		cmd = (cmd == FS_IOC32_GETFLAGS) ?
>  			FS_IOC_GETFLAGS : FS_IOC_SETFLAGS;
>  		fallthrough;
> +	case FS_IOC32_GETVERSION:
> +		cmd = FS_IOC_GETVERSION;
> +		fallthrough;
>  	/*
>  	 * everything else in do_vfs_ioctl() takes either a compatible
>  	 * pointer argument or no argument -- call it with a modified
> -- 
> 2.34.1
> 
> 

