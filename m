Return-Path: <linux-fsdevel+bounces-41796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F99BA3762B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 18:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A5BA189099D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 17:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BDF19D083;
	Sun, 16 Feb 2025 17:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROq5nN8R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FC6188724;
	Sun, 16 Feb 2025 17:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739725660; cv=none; b=Ul4YhJtnpFGI+qBsPhW2Gxlt3UsUJ06YDwNvh3b/+lwUfYYqYDCekrwreYiKadh93W5CWrNdgg2AhP/ZPRik4EJ9AICbM8Q4fL8edq5FIsfNcErW2UP+SACNKrp9vAAkouMsX4jJNa3KhzvtHrDM2n3GS2eseRZ25bhGkFHraPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739725660; c=relaxed/simple;
	bh=c/9tgpooSevtIXvhv7PfQOLK0UYpRmLA8i6VZpmd/iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+V4zDbDGUYpNRvDPo7Yr96q1aoa9ZZOeGY8dfphTDQTFJ4XC4qtRe+fDVpR7ImK6bjaArWN+xVsQKhG2HDByqfvUVGkYpY2dylWacJFRru9yC6HtNcCvowJ1M6zRb16ylTz6WQ4z/apFV+SjziLEMThKFuY4gQkYGBF9YbaXuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROq5nN8R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A380AC4CEDD;
	Sun, 16 Feb 2025 17:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739725659;
	bh=c/9tgpooSevtIXvhv7PfQOLK0UYpRmLA8i6VZpmd/iY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ROq5nN8RVyJAMn17jXCyBSVuaEax3FPssecRERcsRwBH3AHln2IMI1OzwOYnJT4su
	 /POZOgxKJL+W8w0TIeDJ3N5uMBPfvUIpY3t2ZVLgY5/CUW9kF0k2hrsoIdIMbVrX5H
	 hwOMIOHqcVr2u/DkGxscJtNzZ++N+fdGSd5I045laZYna0p5b6rIev7XGetR5k0U5h
	 WCrYazJLBjKOMjQmJ8L5NJzwkGlVj7g4vlkpwFGinrZGX24RLLsen368EKtPtfesxl
	 DAeCS9f9NLcrGeuPHdSw33HXpd02y5fTcr7YkCo0m3SHmIaInFgISngBZPa2rxWe5u
	 FrXx6uqkC8A1w==
Date: Sun, 16 Feb 2025 09:07:39 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ruiwu Chen <rwchen404@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	kees@kernel.org, joel.granados@kernel.org, zachwade.k@gmail.com
Subject: Re: [PATCH] drop_caches: re-enable message after disabling
Message-ID: <20250216170739.GA1564284@frogsfrogsfrogs>
References: <20250216101729.2332-1-rwchen404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216101729.2332-1-rwchen404@gmail.com>

On Sun, Feb 16, 2025 at 06:17:29PM +0800, Ruiwu Chen wrote:
> When 'echo 4 > /proc/sys/vm/drop_caches' the message is disabled,
> but there is no interface to enable the message, only by restarting
> the way, so I want to add the 'echo 0 > /proc/sys/vm/drop_caches'
> way to enabled the message again.

Please update Documentation/ to note this new API.

--D

> Signed-off-by: Ruiwu Chen <rwchen404@gmail.com>
> ---
>  fs/drop_caches.c | 7 +++++--
>  kernel/sysctl.c  | 2 +-
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/drop_caches.c b/fs/drop_caches.c
> index d45ef541d848..c90cfaf9756d 100644
> --- a/fs/drop_caches.c
> +++ b/fs/drop_caches.c
> @@ -57,7 +57,7 @@ int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
>  	if (ret)
>  		return ret;
>  	if (write) {
> -		static int stfu;
> +		static bool stfu;
>  
>  		if (sysctl_drop_caches & 1) {
>  			lru_add_drain_all();
> @@ -73,7 +73,10 @@ int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
>  				current->comm, task_pid_nr(current),
>  				sysctl_drop_caches);
>  		}
> -		stfu |= sysctl_drop_caches & 4;
> +		if (sysctl_drop_caches == 0)
> +			stfu = false;
> +		else if (sysctl_drop_caches == 4)
> +			stfu = true;
>  	}
>  	return 0;
>  }
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index cb57da499ebb..f2e06e074724 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2088,7 +2088,7 @@ static const struct ctl_table vm_table[] = {
>  		.maxlen		= sizeof(int),
>  		.mode		= 0200,
>  		.proc_handler	= drop_caches_sysctl_handler,
> -		.extra1		= SYSCTL_ONE,
> +		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_FOUR,
>  	},
>  	{
> -- 
> 2.27.0
> 
> 

