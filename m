Return-Path: <linux-fsdevel+bounces-27224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA9295FA1C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 21:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5BE1284A85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 19:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C907199940;
	Mon, 26 Aug 2024 19:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXaV5LWE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F47E54648;
	Mon, 26 Aug 2024 19:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724702161; cv=none; b=TpTKgn3BxD5JIFevZLTFfEUrYZWg/hoKOnE7+T0I0nnx43Gt/EZMbwPrf/dMJ8yYvlR8sRu+Hy59KZvHuZ6Rr2qNaYQN20W13dDRWUaOitUB/GTJEP5lyxtUuc71GXl/AJUsvbRAYB1s386x9CK1XBRCH5tROOGJLiL1SVA98Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724702161; c=relaxed/simple;
	bh=wGxjIAFTwaejtggHWXZuDgCwxLBZTkCB+uUES7gFwb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQaDNyKY2/KVdUgNu4RDJIi1QTmzGADTdmymP0kQwU2fcX2EFVQmrlGXrgjgGd4T4ITwow+IZzxTiDADiiwBvfvy1ZQSIpXDTkYE460fTS0QF7sb5NEpr+A3CY6g7ghViZPT/+6wKTH9QTLwxP12iFYKqCQayitDjgkrOjwr3Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXaV5LWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7F3C4FE89;
	Mon, 26 Aug 2024 19:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724702161;
	bh=wGxjIAFTwaejtggHWXZuDgCwxLBZTkCB+uUES7gFwb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HXaV5LWEmT/LQFxPV7jriO64KkTHVHIDB+Kh84aqyOUbOqdBKinLhWxW7v30qsDfi
	 T1XDZPsseN1rThL7/E6jaosenWAA941LR77fR1KqQSBL7C6sy9olEfqnDDVUBND/Xu
	 qbtrUfkB/B0RVU5r96622EogXGyMd6kHDIdGGPCWKXmiK3hz8J83yXiG+m+CLsF0IO
	 fHMMNJUru2Lzj0DGZKkW71Pt0K+Z4XHFz1qG079OoRWkmU2EzpPlbQnUR2g+nB2mnX
	 sYPXL7gCe9ZdWxuDBNve0okHBMc7z9hIGnFaPMOXnULU1tNDg1eMBG5GM4mZ24K9jZ
	 P/ZDbLRuoCqQw==
Date: Mon, 26 Aug 2024 12:56:00 -0700
From: Kees Cook <kees@kernel.org>
To: Kaixiong Yu <yukaixiong@huawei.com>
Cc: akpm@linux-foundation.org, mcgrof@kernel.org,
	ysato@users.sourceforge.jp, dalias@libc.org,
	glaubitz@physik.fu-berlin.de, luto@kernel.org, tglx@linutronix.de,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	j.granados@samsung.com, willy@infradead.org,
	Liam.Howlett@oracle.com, vbabka@suse.cz, lorenzo.stoakes@oracle.com,
	trondmy@kernel.org, anna@kernel.org, chuck.lever@oracle.com,
	jlayton@kernel.org, neilb@suse.de, okorniev@redhat.com,
	Dai.Ngo@oracle.com, tom@talpey.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	paul@paul-moore.com, jmorris@namei.org, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
	wangkefeng.wang@huawei.com
Subject: Re: [PATCH -next 12/15] fs: dcache: move the sysctl into its own file
Message-ID: <202408261253.D155EA0@keescook>
References: <20240826120449.1666461-1-yukaixiong@huawei.com>
 <20240826120449.1666461-13-yukaixiong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826120449.1666461-13-yukaixiong@huawei.com>

On Mon, Aug 26, 2024 at 08:04:46PM +0800, Kaixiong Yu wrote:
> The sysctl_vfs_cache_pressure belongs to fs/dcache.c, move it to
> its own file from kernel/sysctl.c. As a part of fs/dcache.c cleaning,
> sysctl_vfs_cache_pressure is changed to a static variable, and export
> vfs_pressure_ratio with EXPORT_SYMBOL_GPL to be used by other files.
> And move the unneeded include(linux/dcache.h).
> 
> Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
> ---
>  fs/dcache.c            | 21 +++++++++++++++++++--
>  include/linux/dcache.h |  7 +------
>  kernel/sysctl.c        |  9 ---------
>  3 files changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 1af75fa68638..8717d5026cda 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -73,8 +73,13 @@
>   * If no ancestor relationship:
>   * arbitrary, since it's serialized on rename_lock
>   */
> -int sysctl_vfs_cache_pressure __read_mostly = 100;
> -EXPORT_SYMBOL_GPL(sysctl_vfs_cache_pressure);
> +static int sysctl_vfs_cache_pressure __read_mostly = 100;
> +
> +unsigned long vfs_pressure_ratio(unsigned long val)
> +{
> +	return mult_frac(val, sysctl_vfs_cache_pressure, 100);
> +}
> +EXPORT_SYMBOL_GPL(vfs_pressure_ratio);

This was a static inline, but AFAICT it's only called through
alloc_super() which is hardly "fast path". If this series gets another
version it may be worth calling out this inline->out-of-line change in
the commit log.

I don't think it's a blocker, but I'm not a VFS maintainer. :)

-- 
Kees Cook

