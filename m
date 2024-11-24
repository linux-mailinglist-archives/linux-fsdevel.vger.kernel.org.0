Return-Path: <linux-fsdevel+bounces-35715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1419D77C9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 20:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CE31B25582
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 18:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783BC13C3CD;
	Sun, 24 Nov 2024 18:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uOf4dNQf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2DB8472;
	Sun, 24 Nov 2024 18:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732472776; cv=none; b=hm/L6Cdpt2/zEmXNrI/ej19ZplmiM4EGh6Yf52y3pBFoyuk8WsjI5lK8qLN166lSuefCMNRi75dJBEChiS9RP7tO3wpb0Y3DOPpL7wGaDonkqJu4ln/RCuX8HclXrDZjVauqoZr1f1xr9oV0xyYY/zw3LaE+XU1Nn0s27JKxW9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732472776; c=relaxed/simple;
	bh=DH18F10m5G/gZ2tTVGnVgwuxuuLGOnK88bK7HsnZM4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qy6XDZchiEilGMGze3eUATHiKlwKryscz9cGdN74GDzyPCVOKyxRSpBXz/obOFSsECM26sCzcuRvi/PX2yJ11XehzjYFLgzmPcDsQAjHgq7DNc/xiVPtsjenxvOxNa581MJaFp/57grujN6VX+WETC36pARCTHZA06CV6HYxs+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uOf4dNQf; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=60ZM+jjLFMPY8vkmsUoFxwVXHX4iGEuWdH+B2g2Nw6U=; b=uOf4dNQf39N/i74HpLJP4vmQ/P
	Ak8ksilXZfBdlQihBfvGD1xRMdSyVHsykubvjqLHawx25a0hLf0auxNFCAUi3ZuKDz46wl8SWCujR
	SVtuUMWkkB757xw9hJ2JEPY7LSDwz32Fy8AKLK1V11/v22Yl9AC3Cq9GioFeCzeVcjS/xCofH8YoN
	sMX8x293B+SyltVCYmNSWOE2E0zVgmZKnUZq/ntqcxR0Wd/AdeTJ9hyaeEkfhV4E2k+kfTD9fQkTe
	1kCEV6SyEJZOuk07E+s+otpylKmwBKS1ocYMWaCFprdIYFQH5NvQpD3uaNwo3FU24vCqt22eUvPM/
	GDCe7HMw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFHJE-00000001HeX-0L2w;
	Sun, 24 Nov 2024 18:26:12 +0000
Date: Sun, 24 Nov 2024 18:26:12 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/26] target_core_configfs: avoid pointless cred
 reference count bump
Message-ID: <20241124182612.GW3387508@ZenIV>
References: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
 <20241124-work-cred-v1-9-f352241c3970@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241124-work-cred-v1-9-f352241c3970@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Nov 24, 2024 at 02:43:55PM +0100, Christian Brauner wrote:
> The creds are allocated via prepare_kernel_cred() which has already
> taken a reference.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  drivers/target/target_core_configfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
> index ec7a5598719397da5cadfed12a05ca8eb81e46a9..d102ab79c56dd7977465f7455749e6e7a2c9fba1 100644
> --- a/drivers/target/target_core_configfs.c
> +++ b/drivers/target/target_core_configfs.c
> @@ -3756,10 +3756,9 @@ static int __init target_core_init_configfs(void)
>  		ret = -ENOMEM;
>  		goto out;
>  	}
> -	old_cred = override_creds(get_new_cred(kern_cred));
> +	old_cred = override_creds(kern_cred);
>  	target_init_dbroot();
>  	put_cred(revert_creds(old_cred));
> -	put_cred(kern_cred);

FWIW, I agree with Amir - 
 	revert_creds(old_cred);
	put_cred(kern_cred);
might be easier to follow.  In effect, you have two scopes here -
from prepare_kernel_cred() to put_cred() and, nested in it,
from override_creds() to revert_creds().

I'm not saying that __cleanup() is the right tool in those cases,
but the closing brackets of those scopes would be better off
separated.

