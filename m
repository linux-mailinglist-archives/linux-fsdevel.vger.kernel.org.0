Return-Path: <linux-fsdevel+bounces-42744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB707A47757
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 09:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A473AD9B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 08:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D62224893;
	Thu, 27 Feb 2025 08:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaKzYk7J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153CF219A68;
	Thu, 27 Feb 2025 08:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740643803; cv=none; b=CnPr2jeNv0aZU/QQ8a2EKCcA6FGZNrNfropAE2vfZTEghCPhOKNfvS2PdV8laIm0lQZq1FffUPf/pD3PQkrXqTwOTjJaM5oDbteYPIKSCGjgKD5/NXVQMpKPlADhsfdd112IYpZjDhJHvzX6wLUAnZnyWjsK3gDhWV7gKT+921g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740643803; c=relaxed/simple;
	bh=sT9FoMjjZ+j9C9C1Tm3d5T9KzPPeaRXmtqMNkoYoUj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkVpSOutrmpOSbXNeuUJc3h7XOhq49mXxOWj294sK+w4+xPDI+V36UZ6sm8R9q2FtICwkBhgJgOhTAie1pClaSzl3j/ODRd67ceNbC+N9j02pnF5rGpiuYglXWwQSbl+A4SAHneLguIPYF/yzgEQp2orYG6ZwJ1u7MI2SOfJDTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaKzYk7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17308C4CEDD;
	Thu, 27 Feb 2025 08:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740643802;
	bh=sT9FoMjjZ+j9C9C1Tm3d5T9KzPPeaRXmtqMNkoYoUj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VaKzYk7JrOG0sraUOyAup/ViOy/o8eEZ32GYqu3gr5iu8ZGfEsIHa2JHLB11P1S9+
	 /lnCU021TKUxBz0vqrFJE1gkin5JXTB0a6QmEVGT/Rhg2Atq2K5zjLfk9YxwUfR65N
	 zwUJd3Kxxxy3ssBkp5uL1P1mSZCSvydJqGn74osNhQeR9lE/fNPcsRrILhs6fk40ds
	 8JPbHg9niTHwetppsWcXEyl1J19T48xlqPenNYLl+1BrdJP714R9WFZ2rt5zIKvVaT
	 euk0varEjqsfJzb2tCtznKeR2nUhjf2ursYTWD7c8h2b2M+RUyJJgfqxrkOpMOKF2W
	 Xi4kAP39Jen4A==
Date: Thu, 27 Feb 2025 09:09:58 +0100
From: Christian Brauner <brauner@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] fs: Fix uninitialized variable uflags
Message-ID: <20250227-boxhandschuhe-gesichert-908c190a9634@brauner>
References: <20250226223913.591371-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226223913.591371-1-colin.i.king@gmail.com>

On Wed, Feb 26, 2025 at 10:39:12PM +0000, Colin Ian King wrote:
> The variable uflags is only being initialized in the if statement that
> checks if flags & MOVE_MOUNT_F_EMPTY_PATH is non-zero.  Fix this by
> initializing uflags at the start of the system call move_mount.
> 
> Fixes: b1e9423d65e3 ("fs: support getname_maybe_null() in move_mount()")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Thanks, Colin. I've already taken in a patch from Arnd Bergmann
yesterday. So this should already be fixed.

>  fs/namespace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 663bacefddfa..c19e919a9108 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4599,7 +4599,7 @@ SYSCALL_DEFINE5(move_mount,
>  	struct path from_path __free(path_put) = {};
>  	struct filename *to_name __free(putname) = NULL;
>  	struct filename *from_name __free(putname) = NULL;
> -	unsigned int lflags, uflags;
> +	unsigned int lflags, uflags = 0;
>  	enum mnt_tree_flags_t mflags = 0;
>  	int ret = 0;
>  
> -- 
> 2.47.2
> 

