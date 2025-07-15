Return-Path: <linux-fsdevel+bounces-55007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD139B06500
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 19:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7A8A4E71AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 17:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39489281513;
	Tue, 15 Jul 2025 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UFJFF/b4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380CF280337;
	Tue, 15 Jul 2025 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752599704; cv=none; b=V9MsPsF20nLPIM4hGkIEdNNRFtd8hcK409RvTHgSE3wfs+zrqHCpWPdMWjBOZLPrQhRH0viVuljHr+FRFWxKAB3M+TdCovFkfGLQZUsMsvbfe270yRd85aV8sqmi+EizZMNFTxSQwobXPA/DpC2QDmQHRKCB07Rs3gZEpuQD05w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752599704; c=relaxed/simple;
	bh=Y0mDctyEg96SBqQ1S/ikEEqPzHgLIZJPo1ElK4vu07g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQusue4GKQRTSNlSA/Z5FzSXZprpIR8NAPGZudQKrqHNKDFYLv8FUGPdKJaCTRDiIYB9aDth+dtYNmjPhC5tw4h1JW4luHFphwPeqLE1AA+kD8nkXriljvTvid/oOhfs2L+MPYq4hdlXICRrh/yHMg4If/VBYac1sJu+tq2xf4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UFJFF/b4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.201.83] (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id A6F3B201659E;
	Tue, 15 Jul 2025 10:15:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A6F3B201659E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752599702;
	bh=BGGZWcB8WpO2BU6l2pabW8RpF0yWuehd7B5PSJhVIzU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UFJFF/b4YqQ+XE7fuTLGjYwemJjrOxCDwaF9ISQMlaXVznLmM3q+zkb7enKLwkfK8
	 mge7sPP2TZzI9Nq+E91IcYi1Nvnt48JuYZ5y6ycX7enPL1/D35CpJr1uCv7zuW+nkP
	 KqmXtcD3caUVXSQ21GIu95wyl/tHMgO0Hzt3Jcxo=
Message-ID: <d3e43b5f-6d2c-4a64-b374-6de98130cb40@linux.microsoft.com>
Date: Tue, 15 Jul 2025 10:15:01 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mshv_eventfd: convert to CLASS(fd)
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
References: <20250712165244.GA1880847@ZenIV>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20250712165244.GA1880847@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/12/2025 9:52 AM, Al Viro wrote:
> [in viro/vfs.git #work.fd; if nobody objects, into #for-next it goes...]
> 
> similar to 66635b077624 ("assorted variants of irqfd setup: convert
> to CLASS(fd)") a year ago...
>     
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
> index 8dd22be2ca0b..48c514da34eb 100644
> --- a/drivers/hv/mshv_eventfd.c
> +++ b/drivers/hv/mshv_eventfd.c
> @@ -377,10 +377,11 @@ static int mshv_irqfd_assign(struct mshv_partition *pt,
>  	struct eventfd_ctx *eventfd = NULL, *resamplefd = NULL;
>  	struct mshv_irqfd *irqfd, *tmp;
>  	unsigned int events;
> -	struct fd f;
>  	int ret;
>  	int idx;
>  
> +	CLASS(fd, f)(args->fd);
> +
>  	irqfd = kzalloc(sizeof(*irqfd), GFP_KERNEL);
>  	if (!irqfd)
>  		return -ENOMEM;
> @@ -390,8 +391,7 @@ static int mshv_irqfd_assign(struct mshv_partition *pt,
>  	INIT_WORK(&irqfd->irqfd_shutdown, mshv_irqfd_shutdown);
>  	seqcount_spinlock_init(&irqfd->irqfd_irqe_sc, &pt->pt_irqfds_lock);
>  
> -	f = fdget(args->fd);
> -	if (!fd_file(f)) {
> +	if (fd_empty(f)) {
>  		ret = -EBADF;
>  		goto out;
>  	}
> @@ -496,12 +496,6 @@ static int mshv_irqfd_assign(struct mshv_partition *pt,
>  		mshv_assert_irq_slow(irqfd);
>  
>  	srcu_read_unlock(&pt->pt_irq_srcu, idx);
> -	/*
> -	 * do not drop the file until the irqfd is fully initialized, otherwise
> -	 * we might race against the POLLHUP
> -	 */
> -	fdput(f);
> -
>  	return 0;
>  
>  fail:
> @@ -514,8 +508,6 @@ static int mshv_irqfd_assign(struct mshv_partition *pt,
>  	if (eventfd && !IS_ERR(eventfd))
>  		eventfd_ctx_put(eventfd);
>  
> -	fdput(f);
> -
>  out:
>  	kfree(irqfd);
>  	return ret;

Looks fine to me, thanks.

Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

