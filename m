Return-Path: <linux-fsdevel+bounces-66973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04485C32481
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 18:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C83318C4335
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 17:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F8033B958;
	Tue,  4 Nov 2025 17:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Idih7x2W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E48299A94;
	Tue,  4 Nov 2025 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762276126; cv=none; b=vDqJW4pMCs9tmDp1iEi7YtlT4/jMxrwKWdgiT5L+euuntfcOxIwmlmdy8J8hKUVBQsPl/NmdGuB+WD174D0SP/K6r8Lqu9opA4hpP0v4hQv+JxmgHtzbYF9k26QO4Fx8JRI9WHby62HUX0GCZYaee+VGoelciDXNmDzCwW2pNRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762276126; c=relaxed/simple;
	bh=C2E9h8PCXnsVBUe7O2T0vkR1AVsYACov1HR3DrGwEa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0srovq2iLDGZVKJIrICrvdE4/1BAgLPQT7kXvibNuoRzu9CLvk7C4H4rYxl34fFx9o8hOFrYkJE2DsvgqM4yGRzbvgUcucSCd5SMfZzyG1WPZ6Mv+OUXXg76u0SJQoVkE0hskpKl8HXp1V7DC5V8RAkXPk0hyhozkYNC+qKCgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Idih7x2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B49CC4CEF7;
	Tue,  4 Nov 2025 17:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762276126;
	bh=C2E9h8PCXnsVBUe7O2T0vkR1AVsYACov1HR3DrGwEa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Idih7x2W/vSrlx0/3FpHsI3N1OPjhFD1a6097d68Q+eW5TNt/WhV33yrfwXaNXpKP
	 qA0P96vXqi+eOQJvOM5kdjpfiyJfx2eVSoEmjrb6pQY8ijgSjnziGULxWALKRh+oKj
	 nI+cUcMQihoAOPrLQXF1JWd3YomyKl0S+UF0vmns2EUPpdlu9KViVQT8t2fzv49Dzo
	 HPgzy4TnLUysDJ4EKC71L47OFDE62TMNVqb2WxR6kAXTt73cakObX5o23OBRXGjYr4
	 ItZ/Nze1RtiEW9w0zMecTb2uhfSQZYeG+pRV6mjVgiWiqyvc78uRY9x5jVW/GYDakL
	 kv/ZxYUT7DieA==
Date: Tue, 4 Nov 2025 09:08:45 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH RFC 8/8] xfs: use super write guard in xfs_file_ioctl()
Message-ID: <20251104170845.GK196370@frogsfrogsfrogs>
References: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
 <20251104-work-guards-v1-8-5108ac78a171@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104-work-guards-v1-8-5108ac78a171@kernel.org>

On Tue, Nov 04, 2025 at 01:12:37PM +0100, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/xfs/xfs_ioctl.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index a6bb7ee7a27a..f72e96f54cb5 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -1408,10 +1408,8 @@ xfs_file_ioctl(
>  
>  		trace_xfs_ioc_free_eofblocks(mp, &icw, _RET_IP_);
>  
> -		sb_start_write(mp->m_super);
> -		error = xfs_blockgc_free_space(mp, &icw);
> -		sb_end_write(mp->m_super);
> -		return error;
> +		scoped_guard(super_write, mp->m_super)
> +			return xfs_blockgc_free_space(mp, &icw);

Can we go full on Java?

#define with_sb_write(sb) scoped_guard(super_write, (sb))

	with_sb_write(mp->m_super)
		return xfs_blockgc_free_space(mp, &icw);

I still keep seeing scoped_guard() as a function call, not the sort of
thing that starts a new block.

[If I missed the bikeshedding war over this, I'll let this go]

--D

>  	}
>  
>  	case XFS_IOC_EXCHANGE_RANGE:
> 
> -- 
> 2.47.3
> 
> 

