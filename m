Return-Path: <linux-fsdevel+bounces-27225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7FC95FA31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 21:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA7C284AE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 19:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B5C199E8B;
	Mon, 26 Aug 2024 19:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qw2/c6PW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD34E1991B8;
	Mon, 26 Aug 2024 19:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724702272; cv=none; b=RvOS4RLZy+mO21mXJHQyw8ozlyPsQDHP/3PyHlko4sHJ6CUn4lpryihEXO5qV2y5bhjZH0L7B4OjQif7gPD4UDPQzgCv7hBHwY4UxutWo4XCNIGmv1x8tdq+ZhTmiN90Vt1r7Ec4bo6mSIo5spV3jTT7q5tKwWDw6UjkxsChmH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724702272; c=relaxed/simple;
	bh=sPVlnRIjMywyzyc6nAw1h/13Pzxm7ZopyfCDSI2DgEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSCezf5xTQrqaUMbni64Uv6AVVtKUxtPgLa0rZgLnSSa/IBlZuPluTOOepToqu8I7KpyrN4ZcsMWK0VH96aiL6w2mMClBTwxyx9kmpg/c/PtjMOjqO+Yz8wYdcNrYcP8+B+zs3Q5dA+1SWhkE/AG8tTY5Ol8WwQ8TJyaCtjQJGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qw2/c6PW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C40DC8B7A3;
	Mon, 26 Aug 2024 19:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724702272;
	bh=sPVlnRIjMywyzyc6nAw1h/13Pzxm7ZopyfCDSI2DgEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qw2/c6PWFMQtdt9h+tSsbv4+Vi56P1zxnVprcFt1WEa3mG9PdBDs/4t8/GmNqyxHz
	 ScPSUGwnB2FqJdAu2Vd/S6Hu8U1rujDxX6R49424wEmFdCGs69w1FnwewxRC21zGAe
	 uw4pJPQifspkEqaSXmVCNVqQAA5sf1wPZ/knl9I6E9wBS2iXJHZ4458KwjOPJa5Dwf
	 9SqOvB1tsldDBHOGPestBQ//HXs6JTQhc3j4+dRxzbl78ub5gHWrd0l7aHBHJcswvf
	 gX9kDhCMXqvPGpUo9WkMJ4iPsPPsa1vnXNFYoZZwXCoPvloXkWKDsHj0pd0QkpjCTS
	 8z1bZVBiLx+8A==
Date: Mon, 26 Aug 2024 12:57:51 -0700
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
Subject: Re: [PATCH -next 00/15] sysctl: move sysctls from vm_table into its
 own files
Message-ID: <202408261256.ACC5E323B2@keescook>
References: <20240826120449.1666461-1-yukaixiong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826120449.1666461-1-yukaixiong@huawei.com>

On Mon, Aug 26, 2024 at 08:04:34PM +0800, Kaixiong Yu wrote:
> This patch series moves sysctls of vm_table in kernel/sysctl.c to
> places where they actually belong, and do some related code clean-ups.
> After this patch series, all sysctls in vm_table have been moved into its
> own files, meanwhile, delete vm_table.

This is really nice! Thanks for doing this migration. I sent a note
about the "fs: dcache: ..." patch that I don't think will be a problem.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

