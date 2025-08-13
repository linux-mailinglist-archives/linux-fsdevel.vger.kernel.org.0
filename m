Return-Path: <linux-fsdevel+bounces-57726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C4BB24C9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 16:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C751706D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 14:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787952F0C5D;
	Wed, 13 Aug 2025 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h9Z1b9Dh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDA32ED172;
	Wed, 13 Aug 2025 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096820; cv=none; b=DSN/vdtUu7wr8hDOBVP0PC3iFQjyd86cAyyEwJjGO12U/+g1HtsHUU0SGkvKUQdnNtxtcfCBI3eEzpisRK7WhY/acXos0kCv+WdgkJ2jec5inn/HPY1ivczgdxy9phEDjkYcVb8pnxCF4SjK4sHiTjBU70V9UaxD3oy3wmLUScA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096820; c=relaxed/simple;
	bh=qsIzK3FQVmuwp376IvkIc7QaQl0+eKfxluiwZGuycJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZ3tVzIvFop5D3B/m+I6cSiU8NNj7+PkYbg3EU/Shx+VPFS4AlyWroREbvOK3Y1ZbOphZjZarRuSb3OT4ZzTOi/1ooYWK3YCAPjDJWkFuebfzR/z9BEiKU7zUE4P4k52bymd7cytIQucchg7Zx3AeqEQ4nkQjtt0c+J1CDVmMx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h9Z1b9Dh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933ADC4CEEB;
	Wed, 13 Aug 2025 14:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755096820;
	bh=qsIzK3FQVmuwp376IvkIc7QaQl0+eKfxluiwZGuycJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h9Z1b9DhPWIV6cS+bkMlZk/eNbU+HdGphYtWJcvDnCd4mHNW6LGz0PAzq4S3sz/bQ
	 Qu6Q/zr1uSLN9QG07lhIO8zKvSK3b5B2d7wMCY+FxzL+PtVIheklfnv+CxHDBiqwKK
	 HH28jaOUNKO4S5N8tA/MsLvV3/5lSRVuQ5L0TQBQ=
Date: Wed, 13 Aug 2025 16:53:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	achill@achill.org, qemu-devel@nongnu.org,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>,
	LTP List <ltp@lists.linux.it>, chrubis <chrubis@suse.cz>,
	Petr Vorel <pvorel@suse.cz>, Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Joseph Qi <jiangqi903@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	Zhang Yi <yi.zhang@huawei.com>, Theodore Ts'o <tytso@mit.edu>,
	Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 6.16 000/627] 6.16.1-rc1 review
Message-ID: <2025081311-purifier-reviver-aeb2@gregkh>
References: <20250812173419.303046420@linuxfoundation.org>
 <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
 <2025081300-frown-sketch-f5bd@gregkh>
 <CA+G9fYuEb7Y__CVHxZ8VkWGqfA4imWzXsBhPdn05GhOandg0Yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuEb7Y__CVHxZ8VkWGqfA4imWzXsBhPdn05GhOandg0Yw@mail.gmail.com>

On Wed, Aug 13, 2025 at 08:01:51PM +0530, Naresh Kamboju wrote:
> Hi Greg,
> 
> > > 2)
> > >
> > > The following list of LTP syscalls failure noticed on qemu-arm64 with
> > > stable-rc 6.16.1-rc1 with CONFIG_ARM64_64K_PAGES=y build configuration.
> > >
> > > Most failures report ENOSPC (28) or mkswap errors, which may be related
> > > to disk space handling in the 64K page configuration on qemu-arm64.
> > >
> > > The issue is reproducible on multiple runs.
> > >
> > > * qemu-arm64, ltp-syscalls - 64K page size test failures list,
> > >
> > >   - fallocate04
> > >   - fallocate05
> > >   - fdatasync03
> > >   - fsync01
> > >   - fsync04
> > >   - ioctl_fiemap01
> > >   - swapoff01
> > >   - swapoff02
> > >   - swapon01
> > >   - swapon02
> > >   - swapon03
> > >   - sync01
> > >   - sync_file_range02
> > >   - syncfs01
> > >
> > > Reproducibility:
> > >  - 64K config above listed test fails
> > >  - 4K config above listed test pass.
> > >
> > > Regression Analysis:
> > > - New regression? yes
> >
> > Regression from 6.16?  Or just from 6.15.y?
> 
> Based on available data, the issue is not present in v6.16 or v6.15.
> 
> Anders, bisected this regression and found,
> 
>   ext4: correct the reserved credits for extent conversion
>     [ Upstream commit 95ad8ee45cdbc321c135a2db895d48b374ef0f87 ]
> 
> Report lore link,
> 
> https://lore.kernel.org/stable/CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com/

Great, and that's also affecting 6.17-rc1 so we are "bug compatible"?
:)

thanks

greg k-h

