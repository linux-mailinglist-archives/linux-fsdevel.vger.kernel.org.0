Return-Path: <linux-fsdevel+bounces-38430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BD4A02529
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 13:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E56C4161931
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 12:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BC21DE885;
	Mon,  6 Jan 2025 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTYyJPQl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167A61D6182;
	Mon,  6 Jan 2025 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736165708; cv=none; b=hDUPrYAsFvr5FMjskErJpDZQFVpkRQSdHwEo8/rVc0gKJLY0BW2SnSzyZVRHITRFY26KTjjIZ2/P3EAp9dYSjd7AplD4Xn686K1BLmXcXfReKZwSfNrF82ZQYBLbA+kGDo51FxKM5wgEstSfASvpDuNHVwaZq7Zd5sh/2mSQ6wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736165708; c=relaxed/simple;
	bh=7if+6chVPBtkpuf0yafjGMeeJGQXiQ4tJJvW4EBQSj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOWA4oP5AmZCeP6z/gWrtJKZaKypqyD6ZfYij8srAKtd+0GFh+AVIQ5fIOekU9Msu3dOAFSf9xHk2Cs2QLnNjl45mZ9rAxCLPvQum2Cv04RlrzqzWUCRwU4EXybKOqM+meDCTgQSE/f36VBtB/aLOMgEhX5xN3QajaQrgRvUBKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTYyJPQl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CAC4C4CED2;
	Mon,  6 Jan 2025 12:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736165707;
	bh=7if+6chVPBtkpuf0yafjGMeeJGQXiQ4tJJvW4EBQSj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZTYyJPQl1Vgp01XncM2/C03xclL3/1SGxnK2cq14/L9OmRiMabXiA+/Lp0q23fHx0
	 J8G4zMDxMMS6OUJnbZWughB+f8ziHMmnaONQejF0W5oeLCWalp/Nb2zJ9Ry62DuG72
	 31ZCToXTEF/PyCK8SIRTSfQFk2SG5csUOKvzWXmisDAMi72cJtHgrTMxQrnXptZSJa
	 Cb5ghiFY1AQgctd2WGwImTjRWPVLnQma4ED+2buC4R1tmXE/cHcJxUXmxtW90CoOhx
	 lvD8zXcE0o0vstqE/6NQux/tpKRhqsXfAA40dN915REMxyyOczzKIDJ6lgHSBIJP+5
	 CwR/PJaIc4sjw==
Date: Mon, 6 Jan 2025 13:15:02 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Kaixiong Yu <yukaixiong@huawei.com>
Cc: akpm@linux-foundation.org, mcgrof@kernel.org, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, luto@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	hpa@zytor.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	kees@kernel.org, j.granados@samsung.com, willy@infradead.org, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, lorenzo.stoakes@oracle.com, trondmy@kernel.org, 
	anna@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, 
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, paul@paul-moore.com, 
	jmorris@namei.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, dhowells@redhat.com, 
	haifeng.xu@shopee.com, baolin.wang@linux.alibaba.com, shikemeng@huaweicloud.com, 
	dchinner@redhat.com, bfoster@redhat.com, souravpanda@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, pasha.tatashin@soleen.com, david@redhat.com, 
	ryan.roberts@arm.com, ying.huang@intel.com, yang@os.amperecomputing.com, 
	zev@bewilderbeest.net, serge@hallyn.com, vegard.nossum@oracle.com, 
	wangkefeng.wang@huawei.com
Subject: Re: [PATCH v4 -next 00/15] sysctl: move sysctls from vm_table into
 its own files
Message-ID: <tgp2b7kbbdx4obapr4fgtmgjjo6zjbxbligucs32eewiasacko@f4h6uoamznry>
References: <20241228145746.2783627-1-yukaixiong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241228145746.2783627-1-yukaixiong@huawei.com>

On Sat, Dec 28, 2024 at 10:57:31PM +0800, Kaixiong Yu wrote:
> This patch series moves sysctls of vm_table in kernel/sysctl.c to
> places where they actually belong, and do some related code clean-ups.
> After this patch series, all sysctls in vm_table have been moved into its
> own files, meanwhile, delete vm_table.
> 
> All the modifications of this patch series base on
> linux-next(tags/next-20241219). To test this patch series, the code was
> compiled with both the CONFIG_SYSCTL enabled and disabled on arm64 and
> x86_64 architectures. After this patch series is applied, all files
> under /proc/sys/vm can be read or written normally.
> 
> Changes in v4:
>  - due to my mistake, the previous version sent 15 patches twice.
>    Please ignore that, as this version is the correct one.
I would not ignore the reviewed-by tags that you got from Lorenzo.
Please include those moving forward.

>  - change all "static struct ctl_table" type into
>    "static const struct ctl_table" type in patch1~10,12,13,14
>  - simplify result of rpcauth_cache_shrink_count() in patch11
...
>  mm/vmscan.c                        |  23 +++
>  mm/vmstat.c                        |  44 +++++-
>  net/sunrpc/auth.c                  |   2 +-
>  security/min_addr.c                |  11 ++
>  23 files changed, 330 insertions(+), 312 deletions(-)
> 
> -- 
> 2.34.1
> 

best

-- 

Joel Granados

