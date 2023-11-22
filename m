Return-Path: <linux-fsdevel+bounces-3436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6A57F4904
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 15:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7533F281632
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 14:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C674E62A;
	Wed, 22 Nov 2023 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2458wqn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCB44E625
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 14:33:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0AE2C433C7;
	Wed, 22 Nov 2023 14:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700663639;
	bh=sbdYdHhSV9JWEtL69pxY+VEqa8B7iLdrDy3u/sbCvgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q2458wqnlh7dBWS/7Tj8O8HV7ziQI6XHaXON0vLTB99RJsYj612fnIDzwW05hbTQq
	 xMG+O5ihAFaVr51u2V2/m/ftWu9VtKTvLYazuHOCHO5UHeCUv4PBu6VPU6Q180Famf
	 xmwR0zzo/VXQWvr9lecYQ+v2rxur2ndGhByrVGiWcqJIZ3XH0qgSjInQTaQ1PsMs5q
	 XNERuwy17P4y9fCB+iW1xiVqeJr1Pb6gptU2LWJQ20k5elLPUKBvMbLO32j2cGC2gh
	 wxAuEKBOuFgue8nQTPDKvk6Mx7CMm9lNW02uzhN4h41JAP7ARl+n0UjXIS1U+6SqC7
	 34dfKKEJA7GTA==
Date: Wed, 22 Nov 2023 15:33:55 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 11/16] fs: move permission hook out of do_iter_write()
Message-ID: <20231122-vorrecht-truhe-701aae42b61f@brauner>
References: <20231122122715.2561213-1-amir73il@gmail.com>
 <20231122122715.2561213-12-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231122122715.2561213-12-amir73il@gmail.com>

> -	ret = import_iovec(ITER_SOURCE, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
> -	if (ret >= 0) {
> -		file_start_write(file);
> -		ret = do_iter_write(file, &iter, pos, flags);
> -		file_end_write(file);
> -		kfree(iov);
> -	}
> +	if (!(file->f_mode & FMODE_WRITE))
> +		return -EBADF;
> +	if (!(file->f_mode & FMODE_CAN_WRITE))
> +		return -EINVAL;
> +
> +	ret = import_iovec(ITER_SOURCE, vec, vlen, ARRAY_SIZE(iovstack), &iov,
> +			   &iter);
> +	if (ret < 0)
> +		return ret;
> +
> +	tot_len = iov_iter_count(&iter);
> +	if (!tot_len)
> +		goto out;

Fwiw, the logic is slightly changed here. This now relies on
import_iovec() >= 0 then iov_iter_count() >= 0.

If that's ever changed and iov_iter_count() can return an error even
though import_iovec() succeeded we'll be returning the number of
imported bytes even though nothing was written and also generate a
fsnotify event because ret still points to the number of imported bytes.

The way it was written before it didn't matter because this was hidden
in a function call that returned 0 and initialized ret again. Anyway, I
can just massage that in-tree if that's worth it. Nothing to do for you.

