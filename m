Return-Path: <linux-fsdevel+bounces-39265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6D4A11F58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 11:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C731162DF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3C023F281;
	Wed, 15 Jan 2025 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxmuo0vj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850FC1F9F41;
	Wed, 15 Jan 2025 10:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736936838; cv=none; b=t1SvXPDLcKr3VN+7j426mANrKwmpfI7NVi8Vltu2qs1oOsEuZvzHWCUXE6v1qZAXQx8W15Uw3yB2yeIVU51uHVGI2VbI5WuJQJLKFacVc64FZtVirmpAVHfSaKof1YWAA4lYdvmQ2Cbya/pwpGiSLGiKdH0mPsw2dijbemG/4E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736936838; c=relaxed/simple;
	bh=KYZIMr/3k14SL2mbscG9aRFAH8pOXfUIWzMsgwXTxAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3F9EpyfoaKexe9ru+jwAS6Dxq7GcFERFGpEgEEh8WkZfm/2rIDI0r8+GDdOlBdqN+SdnV6CF9dSIb/on7kBlzTDiGVD1s5unoXHcj2ChUjTN7YjchnYAAq5ejXpPeR5h/hkNUJUKOfqJznd09vNd2pSLRHmv3ZfMRaqyMoomZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxmuo0vj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D41DC4CEE1;
	Wed, 15 Jan 2025 10:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736936838;
	bh=KYZIMr/3k14SL2mbscG9aRFAH8pOXfUIWzMsgwXTxAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fxmuo0vjrLbxYbEFhbKD2Bp1P9mSq+LibAaAitW8nspU+4KhRiWQJBo5SNctJa5mN
	 tFlFEzI/Cemzletnyoxbm8VaYEz4f8RZih+g8Uxdp+bWPPQ22WSes5WZ0iyUTBD8tq
	 GQ8is3lcoWisw2PxDjcLi4nj0mF5OaUB7xHApjgxevIsai1GWngnnUk2I1RL+TY7Y8
	 oBOMWqzco3jeYxDyr8kX7daf26Im1co+1HLd5xua4KH/3q3/wO9TJq8eSnoteKMAbC
	 okcCfEmf6d6fKSkH+X/681szb9hIoR3P+PHh4FToFwmbdcEVLRnUgazaBETsKagJLn
	 7whkYdWKDh2eA==
Date: Wed, 15 Jan 2025 11:27:12 +0100
From: Joel Granados <joel.granados@kernel.org>
To: nicolas.bouchinet@clip-os.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Luis Chamberlain <mcgrof@kernel.org>, 
	Kees Cook <kees@kernel.org>, Joel Granados <j.granados@samsung.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Neil Horman <nhorman@tuxdriver.com>, Lin Feng <linf@wangsu.com>, 
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v3 2/2] sysctl: Fix underflow value setting risk in
 vm_table
Message-ID: <mdyg6vjy5hybv47ovw2uywlqzz4nq67bdntnpmtbaxj64pz5sz@5vx4rlsvu22a>
References: <20241217132908.38096-1-nicolas.bouchinet@clip-os.org>
 <20241217132908.38096-3-nicolas.bouchinet@clip-os.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217132908.38096-3-nicolas.bouchinet@clip-os.org>

On Tue, Dec 17, 2024 at 02:29:07PM +0100, nicolas.bouchinet@clip-os.org wrote:
> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> 
> Commit 3b3376f222e3 ("sysctl.c: fix underflow value setting risk in vm_table")
> fixes underflow value setting risk in vm_table but misses vdso_enabled
> sysctl.
> 
> vdso_enabled sysctl is initialized with .extra1 value as SYSCTL_ZERO to
> avoid negative value writes but the proc_handler is proc_dointvec and
> not proc_dointvec_minmax and thus do not uses .extra1 and .extra2.
> 
> The following command thus works :
> 
> `# echo -1 > /proc/sys/vm/vdso_enabled`
> 
> This patch properly sets the proc_handler to proc_dointvec_minmax.
Please also mention that you added a extra* arg.

> 
> Fixes: 3b3376f222e3 ("sysctl.c: fix underflow value setting risk in vm_table")
> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> ---
>  kernel/sysctl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 79e6cb1d5c48f..6d8a4fceb79aa 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2194,8 +2194,9 @@ static struct ctl_table vm_table[] = {
>  		.maxlen		= sizeof(vdso_enabled),
>  #endif
>  		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> +		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= SYSCTL_ZERO,
> +		.extra1		= SYSCTL_ONE,
* What did you mean here?
  1. To replace extra1 with SYSCTL_ONE?
  2. To add extra2 as SYSCTL_ONE and you mistyped it as "extra1"?

* This patch conflicts with the vm_table moving out of the kernel
  directory [1] from Kaixiong Yu <yukaixiong@huawei.com> (which is also
  in sysctl-testing). I have fixed this conflict with [2], please scream
  if you see that messed up.

* Please send an updated version addressing these comments and taking
  into account that your patches will go after [1]. You can use [3] as
  your base if you prefer.

Best


[1] https://lore.kernel.org/20250111070751.2588654-14-yukaixiong@huawei.com
[2] https://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/commit/?h=sysctl-testing&id=81b34e7966e84983a31c0150cbf2171605c023a3
[3] https://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/commit/?h=sysctl-testing&id=2fc99f285719e0cce8df1fe21479cb9e6626c2fe

-- 

Joel Granados

