Return-Path: <linux-fsdevel+bounces-42367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C0CA41065
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 18:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8061893681
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 17:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4D31474A0;
	Sun, 23 Feb 2025 17:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJB5tKNH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D430622071;
	Sun, 23 Feb 2025 17:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740331343; cv=none; b=aTbj0PXl4C5OuQxDNVS6LFd1VbT7AK7uCerXy3zLk+bIKak4TE5t7SP5B5PacwSfMY5unh8zSTfjiF4oj6LqKN9GMD6N/z6GCT8d8RoZu9FvFuKcav3DoYOJud0+CObkwpnKsu4ndgqTDafVGP60JDtwMd4JaX855/nLp1Xu0yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740331343; c=relaxed/simple;
	bh=ikthoz7q6na/BgPcgPu7Oys3XOFB7HVKetzGLYnw3Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iI+MvaIq8RCGm2CabFFtlaqnHRN+PsBJ2AXJBUOe5Mi2OUw3HaFJRXq6lD43xsqMjPFt9Ed2q7u01+fz4l6p20jC+qm9jKRK63CxDPD9xnHkPnVKqXnj5AnfSvc1rdV1/naaMispG5pA+m6BdWMRrqZgwx7Lp7b1sbdzxqfeS3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJB5tKNH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3A6C4CEDD;
	Sun, 23 Feb 2025 17:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740331342;
	bh=ikthoz7q6na/BgPcgPu7Oys3XOFB7HVKetzGLYnw3Gg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LJB5tKNH71oIJPN+zlqlFAeA/eHt/H7sM0lPHD5hxOzMwMBILHKf5Qwux9yg8T17U
	 lHhfMEJjbDmABJqxPojrfKylUBDbugpOvVdrgulnFdb72r+3H8LQIAk3CtbhZByKle
	 0NWjFUa4N/GZnHC+GP/YKyk4XaXXsG6UR9gaGKZpxQxrzncg5u4T9pF6yY7ZfVkq8D
	 b0GVnfRGXbPshcVKJzhDLNoMqv4D++EtPhNw40755C1lkqYEkQKO2OjIJta7i2tNKw
	 57UC63+6sX9qTXWy3bVVklOlgQ02jUJFbIKdoR2AwcyP4DIIMEiexPXZ/5kuXhiVsV
	 tBJF7pnEU3mLQ==
Date: Sun, 23 Feb 2025 09:22:20 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Ruiwu Chen <rwchen404@gmail.com>,
	Joel Granados <joel.granados@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, viro@zeniv.linux.org.uk,
	keescook@chromium.org, zachwade.k@gmail.com
Subject: Re: [PATCH v2] drop_caches: re-enable message after disabling
Message-ID: <Z7tZTCsQop1Oxk_O@bombadil.infradead.org>
References: <virvi6vh663p5ypdjr2v2fr3o77w5st3cagr4fe6z7nhhqehc6@xb7nqlop6nct>
 <20250222084513.15832-1-rwchen404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222084513.15832-1-rwchen404@gmail.com>

On Sat, Feb 22, 2025 at 04:45:13PM +0800, Ruiwu Chen wrote:
> When 'echo 4 > /proc/sys/vm/drop_caches' the message is disabled,
> but there is no interface to enable the message, only by restarting
> the way, so add the 'echo 0 > /proc/sys/vm/drop_caches' way to
> enabled the message again.
> 
> Signed-off-by: Ruiwu Chen <rwchen404@gmail.com>

You are overcomplicating things, if you just want to re-enable messages
you can just use:

-		stfu |= sysctl_drop_caches & 4;
+		stfu = sysctl_drop_caches & 4;

The bool is there as 4 is intended as a bit flag, you can can figure
out what values you want and just append 4 to it to get the expected
result.

  Luis

> ---
> v2: - updated Documentation/ to note this new API.
>     - renamed the variable.
>     - rebase this on top of sysctl-next [1].
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/log/?h=sysctl-next
> 
>  Documentation/admin-guide/sysctl/vm.rst | 11 ++++++++++-
>  fs/drop_caches.c                        | 11 +++++++----
>  2 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> index f48eaa98d22d..ef73d36e8b84 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -266,7 +266,16 @@ used::
>  	cat (1234): drop_caches: 3
>  
>  These are informational only.  They do not mean that anything is wrong
> -with your system.  To disable them, echo 4 (bit 2) into drop_caches.
> +with your system.
> +
> +To disable informational::
> +
> +	echo 4 > /proc/sys/vm/drop_caches
> +
> +To enable informational::
> +
> +	echo 0 > /proc/sys/vm/drop_caches
> +
>  
>  enable_soft_offline
>  ===================
> diff --git a/fs/drop_caches.c b/fs/drop_caches.c
> index 019a8b4eaaf9..a49af7023886 100644
> --- a/fs/drop_caches.c
> +++ b/fs/drop_caches.c
> @@ -57,7 +57,7 @@ static int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
>  	if (ret)
>  		return ret;
>  	if (write) {
> -		static int stfu;
> +		static bool silent;
>  
>  		if (sysctl_drop_caches & 1) {
>  			lru_add_drain_all();
> @@ -68,12 +68,15 @@ static int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
>  			drop_slab();
>  			count_vm_event(DROP_SLAB);
>  		}
> -		if (!stfu) {
> +		if (!silent) {
>  			pr_info("%s (%d): drop_caches: %d\n",
>  				current->comm, task_pid_nr(current),
>  				sysctl_drop_caches);
>  		}
> -		stfu |= sysctl_drop_caches & 4;
> +		if (sysctl_drop_caches == 0)
> +			silent = true;
> +		else if (sysctl_drop_caches == 4)
> +			silent = false;
>  	}
>  	return 0;
>  }
> @@ -85,7 +88,7 @@ static const struct ctl_table drop_caches_table[] = {
>  		.maxlen		= sizeof(int),
>  		.mode		= 0200,
>  		.proc_handler	= drop_caches_sysctl_handler,
> -		.extra1		= SYSCTL_ONE,
> +		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_FOUR,
>  	},
>  };
> -- 
> 2.27.0
> 

