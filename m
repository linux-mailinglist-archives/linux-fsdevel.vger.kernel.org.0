Return-Path: <linux-fsdevel+bounces-16142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC3489933A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 04:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91119284DA5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 02:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4753E171CC;
	Fri,  5 Apr 2024 02:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzDJIGCM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B95F134A8;
	Fri,  5 Apr 2024 02:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712284801; cv=none; b=Mj9h/db5nkqtWVWE403sJv3ByjfcMijeeODI6tGSrqz/3w3f8XDZlXJkiuTi3oMTa4bDDDxRGB3WZIJnQtkHGm7ysLPYc5lFqVjhNpqSNUQo918HkBddnYhNw2LDzHIL0uArulVL8laGBFAbTzj6owB1FicB2wynLhi5wvKc5Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712284801; c=relaxed/simple;
	bh=hRvAGiyQHBoq2Urifv2i6cvSMPQR7k4Y8JcWPFe4SL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fP6pxsnPy5EAojRBxduen1ELsE5OTgLXFQHFAD0aC+qSCj2/mYZX2mALGcoArDQb8uYziLm7FrsT5HwjbT/CCzJAA230eYYJ0vC2V3XywGIJFwkZW3FonF1iDa9Z0ncW07P+kURP4ExaNR9vvciue/XP1kdEC03iBa/ul4MxHu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzDJIGCM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B15C433C7;
	Fri,  5 Apr 2024 02:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712284801;
	bh=hRvAGiyQHBoq2Urifv2i6cvSMPQR7k4Y8JcWPFe4SL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pzDJIGCMq8RmYI1sJQMAD7mlGfgH5LKwyOE2tw/QUJUU5PXBnKu/oX+888fBVKMk7
	 Gxok/uzGJppcWD6e3V2zZqTDlk0L4X69KCRkIrlx5vkEQqdrLtKCxVbzol3yLRoPkN
	 64Hxjv8U2TNCK1/xDLPzvBRqRWuqcftP17HYZ880sjDxG/+lqaxNn5MJgJqgA/jv0d
	 KcyfLmBHoROXiMrNrl/Gd13/tiMfvKsMyBuJEnq+UarGlRqklrZhRmMWv3WSOXfMKN
	 vNACQyZQIsSZG26DP3XlSCpTUr7/tjw+dx+HZNe6iqzbIgHloac+MWOdTsZkloT2FA
	 AzjXxsWY+uCIw==
Date: Thu, 4 Apr 2024 22:39:53 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 04/13] fsverity: add per-sb workqueue for post read
 processing
Message-ID: <20240405023953.GC1958@quark.localdomain>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
 <171175867930.1987804.1200988399612926993.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171175867930.1987804.1200988399612926993.stgit@frogsfrogsfrogs>

On Fri, Mar 29, 2024 at 05:33:43PM -0700, Darrick J. Wong wrote:
> diff --git a/fs/super.c b/fs/super.c
> index 71d9779c42b10..aaa75131f6795 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -637,6 +637,13 @@ void generic_shutdown_super(struct super_block *sb)
>  			sb->s_dio_done_wq = NULL;
>  		}
>  
> +#ifdef CONFIG_FS_VERITY
> +		if (sb->s_verify_wq) {
> +			destroy_workqueue(sb->s_verify_wq);
> +			sb->s_verify_wq = NULL;
> +		}
> +#endif

Should it maybe be s_verity_wq with a t?

I guess it could be argued that the actual data verification is just part of
fsverity, and there could be other workqueues related to fsverity, e.g. one for
enabling fsverity.  But in practice this is the only one.

Also, the runtime name of the workqueue is "fsverity/$s_id", which is more
consistent with s_verity_wq than s_verify_wq.

> +int __fsverity_init_verify_wq(struct super_block *sb)
> +{
> +	struct workqueue_struct *wq, *old;
> +
> +	wq = alloc_workqueue("fsverity/%s", WQ_MEM_RECLAIM | WQ_FREEZABLE, 0,
> +			sb->s_id);
> +	if (!wq)
> +		return -ENOMEM;
> +
> +	/*
> +	 * This has to be atomic as readaheads can race to create the
> +	 * workqueue.  If someone created workqueue before us, we drop ours.
> +	 */
> +	old = cmpxchg(&sb->s_verify_wq, NULL, wq);
> +	if (old)
> +		destroy_workqueue(wq);
> +	return 0;
> +}

The cmpxchg thing makes no sense because this is only called at mount time, when
there is no chance of a race condition.

- Eric

