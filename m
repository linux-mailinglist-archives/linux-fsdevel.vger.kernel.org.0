Return-Path: <linux-fsdevel+bounces-4003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF747FADB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 23:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8090AB20FBB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 22:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C2848CF2;
	Mon, 27 Nov 2023 22:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCXakQs3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4903E490;
	Mon, 27 Nov 2023 22:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11659C433C8;
	Mon, 27 Nov 2023 22:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701125241;
	bh=Y4oxrecu9ql/C7+/pWvE72XQSeQO0hmoCWBxJdrSTgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RCXakQs3Lvm/NZ4IohSRSzS5ha4CpLf9iXXNE2gzU12WjlKhA6BByL06gdkR2Yl8N
	 qIcbnyv/O/hUAE+YcK+WEBL2opMGlawyFsswlIlOShGrocyxQsiF/ltCEsVRgtzk6f
	 ZS1CgRTABTLrtC+wT2c06detaejWQs7FwoXclVZmVSEdLvZfQHU8tnC4lJtGkItyiC
	 H/JZmfFNJQNuKYaHn7Y57Z5hYpiqPthrcfgNzEzAdOom/D01+Tp+ialYIspQdPEP4P
	 HzC/JlWUWvBbXJFZHsI9Lo164J6yw4L4tpYyy8dFb/sUnoEAFYJl9n4RgmXEv+hAtE
	 Ygv1bcTo7hedw==
Date: Mon, 27 Nov 2023 14:47:19 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Sergei Shtepa <sergei.shtepa@linux.dev>
Cc: axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: Re: [PATCH v6 11/11] blksnap: prevents using devices with data
 integrity or inline encryption
Message-ID: <20231127224719.GD1463@sol.localdomain>
References: <20231124165933.27580-1-sergei.shtepa@linux.dev>
 <20231124165933.27580-12-sergei.shtepa@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124165933.27580-12-sergei.shtepa@linux.dev>

On Fri, Nov 24, 2023 at 05:59:33PM +0100, Sergei Shtepa wrote:
> There is an opinion that the use of the blksnap module may violate the
> security of encrypted data. The difference storage file may be located
> on an unreliable disk or even network storage. 

I think this misses the point slightly.  The main problem is that blksnap writes
data in plaintext that is supposed to be encrypted, as indicated by the bio
having an encryption context.  That's just what it does, at least based on the
last patchset; it's not just "an opinion".  See
https://lore.kernel.org/linux-block/20a5802d-424d-588a-c497-1d1236c52880@veeam.com/

> +#ifdef CONFIG_BLK_INLINE_ENCRYPTION
> +	if (bio->bi_crypt_context) {
> +		pr_err_once("Hardware inline encryption is not supported\n");
> +		diff_area_set_corrupted(tracker->diff_area, -EPERM);
> +		return false;
> +	}
> +#endif

The error message for ->bi_crypt_context being set should say
"Inline encryption", not "Hardware inline encryption".  The submitter of the bio
may have intended to use blk-crypto-fallback.

Anyway, this patch is better than ignoring the problem.  It's worth noting,
though, that this patch does not prevent blksnap from being set up on a block
device on which blk-crypto-fallback is already being used (or will be used).
When that happens, I/O will suddenly start failing.  For usability reasons,
ideally that would be prevented somehow.

- Eric

