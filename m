Return-Path: <linux-fsdevel+bounces-57915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53582B26B36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 17:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5169FA01CF2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 15:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003DD2561D9;
	Thu, 14 Aug 2025 15:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DJNPGlis"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5ED23815C;
	Thu, 14 Aug 2025 15:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755185736; cv=none; b=EAXvtYtPQsX1iLm+u0/cxxnU0LRC2rF5QME/4MYZcqUGxRiilSxmUoS4+YObqHWqDnk+CSsoJa66X/j/haNqJbfrVWBbDFzyKVMXzfW60vw6JGBhVUL2SC8uzan8Cz1N9vUHRICqhh8ah5hdzvE5btftRP4HLDI3BWotfnAGIbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755185736; c=relaxed/simple;
	bh=gDxvjWIgXlyBLWgV2QQr23LJcSGf4vc5YOroiJL6BHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5NHdUvoZB8y+WseKQCF9GzQ12L08R3VHewug8rMhQ0E9KeBmB2i9t7yhulllCAa6V4q4zJaH1itjWNHM5KNW2f7bC0M0OzmLbsbDXJUWyCG4n6OJZ+iN57e9yCqZ48YMRqNilJMgYDfiwDuCmYwSF2kKAa64tjuPoJKip4CzJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DJNPGlis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2644BC4CEED;
	Thu, 14 Aug 2025 15:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755185735;
	bh=gDxvjWIgXlyBLWgV2QQr23LJcSGf4vc5YOroiJL6BHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DJNPGlisvjw88EiXwDk2RuS15vYBkAcU5305MBsWPMCbM6/W7E4E6L+9JlKljpuRX
	 zwzpCawOznOaYHkMchEhfqmMwpvf3R8wIoHWBbG1N63zmB6JfoOL8GnfoT0t/6j8PQ
	 QQbPrxKsabXo4dWZwuKLd92OEcSIPH/lHm05gpHI=
Date: Thu, 14 Aug 2025 17:35:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, achill@achill.org,
	qemu-devel@nongnu.org,
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
	linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 6.16 000/627] 6.16.1-rc1 review
Message-ID: <2025081416-wing-bakery-3205@gregkh>
References: <20250812173419.303046420@linuxfoundation.org>
 <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
 <bf9ccc7d-036d-46eb-85a1-b46317e2d556@sirena.org.uk>
 <CA+G9fYtjAWpeFfb3DesEY8y6aOefkLOVBE=zxsROWLzP_V_iDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtjAWpeFfb3DesEY8y6aOefkLOVBE=zxsROWLzP_V_iDg@mail.gmail.com>

On Wed, Aug 13, 2025 at 07:11:05PM +0530, Naresh Kamboju wrote:
> On Wed, 13 Aug 2025 at 18:21, Mark Brown <broonie@kernel.org> wrote:
> >
> > On Wed, Aug 13, 2025 at 05:46:26PM +0530, Naresh Kamboju wrote:
> > > On Tue, 12 Aug 2025 at 23:57, Greg Kroah-Hartman
> >
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
> 
> These test failures are not seen on Linus tree v6.16 or v6.15.
> 
> >
> > I'm also seeing epoll_ctl04 failing on Raspberry Pi 4, there's a bisect
> > still running but I suspect given the error message:
> 
> Right !
> LTP syscalls epoll_ctl04 test is failing on Linux mainline as well
> with this error on LKFT CI system on several platforms.
> 
> >
> > epoll_ctl04.c:59: TFAIL: epoll_ctl(..., EPOLL_CTL_ADD, ...) with number of nesting is 5 expected EINVAL: ELOOP (40)
> >
> > that it might be:
> >
> > # bad: [b47ce23d38c737a2f84af2b18c5e6b6e09e4932d] eventpoll: Fix semi-unbounded recursion
> >
> > which already got tested, or something adjacent.
> 
> A patch has been proposed to update the LTP test case to align with
> recent changes in the Linux kernel code.
> 
> [LTP] [PATCH] syscalls/epoll_ctl04: add ELOOP to expected errnos
> 
> -https://lore.kernel.org/ltp/39ee7abdee12e22074b40d46775d69d37725b932.1754386027.git.jstancek@redhat.com/

Great, thanks for letting us know that this is just a test-case issue.

greg k-h

