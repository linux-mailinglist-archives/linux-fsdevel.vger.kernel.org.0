Return-Path: <linux-fsdevel+bounces-41830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B0CA37D2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 09:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C91E3ACB05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 08:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6879F1A0BF3;
	Mon, 17 Feb 2025 08:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kI37DV1k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C94192B63;
	Mon, 17 Feb 2025 08:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739780915; cv=none; b=Y9RzSdxE6j8VDv1NwqZQ5OZs0Zxc0Uq318t+5v2tDAuLUe/Va6VBrTPVf9rDul5nImANV3nJ4g3keiDhziC1GojRDIupxGTVF50T0+EhTd5fTtQ/cdRbdV2fFh+v4fOHmsy0u1uKZYs9VlmrHI+CRdMXyWg5+l4CIzrTS+q1vrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739780915; c=relaxed/simple;
	bh=soPhO3N7MHBcOo/fyThjUq/a3H8+8UMv+M5v6EkhmQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dwl2u6AfEtD+JHDaVywOw+V80lUhoNFfcf8PhvDAys+/h0hok7rYPzzeKC4w9if/0bDH1MnlOZaStg38DT1eGBjsgr8eb2hN672WWZop0wrAt/4xzDNeLFRvEx++ms3xYfFCYnxwz+9Mk9QXR5bBhqC4bLPcSzFmpKV+NRFFngg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kI37DV1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F627C4CED1;
	Mon, 17 Feb 2025 08:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739780915;
	bh=soPhO3N7MHBcOo/fyThjUq/a3H8+8UMv+M5v6EkhmQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kI37DV1kM+lShISKzbO7jg97ZU4prmocK8dLBCpgPUHBfMuyuQQg2KiYNASnjaJTl
	 J9c1whtA/R1nq7PgF/LRQf0ipHqZXVwHx3wuQ/GaYUapUwVbF4XfCRzb6mwYEjz9Lm
	 rCbn9Gx6xOIjRL1iik2xqOu9puL6XlPgliKWa6JCshpe8xy6FdzW4czqUeqZrqeW68
	 6RaBTLE8XYoliygxVx29hkLBQlK6xdKhRjhVVK9aXjnm9iZQBaOt/5qp30BAuRmKam
	 Tdjb9aSA7qAJgBDn0RCcRQkWH/sJ1Azy5RD7jt3fRqxgEwZAooO0bOEWRdD0woWPj2
	 k2VM3+dWlzzdw==
Date: Mon, 17 Feb 2025 09:28:30 +0100
From: Christian Brauner <brauner@kernel.org>
To: Ruiwu Chen <rwchen404@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, kees@kernel.org, joel.granados@kernel.org, 
	zachwade.k@gmail.com
Subject: Re: [PATCH] drop_caches: re-enable message after disabling
Message-ID: <20250217-diskette-obskur-a3529a2f6a7f@brauner>
References: <20250216101729.2332-1-rwchen404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250216101729.2332-1-rwchen404@gmail.com>

On Sun, Feb 16, 2025 at 06:17:29PM +0800, Ruiwu Chen wrote:
> When 'echo 4 > /proc/sys/vm/drop_caches' the message is disabled,
> but there is no interface to enable the message, only by restarting
> the way, so I want to add the 'echo 0 > /proc/sys/vm/drop_caches'
> way to enabled the message again.
> 
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

Please the change and change that to something explicitly like "silent".

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

