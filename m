Return-Path: <linux-fsdevel+bounces-57914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D3FB26B15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 17:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58636A23D7A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 15:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851A2225A4F;
	Thu, 14 Aug 2025 15:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jTOR52cE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34A321B9D6;
	Thu, 14 Aug 2025 15:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755185450; cv=none; b=PhpxBbjIVakEsl81t/Pj6FJr7g4QZBrlfRMizaLeJOXEQnNQ0nguYXUJWEkur83fzvwbDpyHnM+grtG+tWAgpsmM3cVwwxTBP4G94fRbE/AKH11b0nEJ3tKIyU2u60XX7vrvo0I0DFMPbwT5A2WlCYaX7bXhHfc1RIVfCFZ2avc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755185450; c=relaxed/simple;
	bh=cvTYcOO2SFOCDjwerP1KEOTUieXi4c8bDV0Z2qhr2s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCNVFuF9QEbSi1LuTJ12N7FashyRRv7NMAZgqIijJATbUTtgVnwfpXju9RKroLX001/15shT4g1HFz1/vXrqXzq4OxjXts6Br2ozB5rzgdxUgPK8Ux3GZob1A+lGtTub49ZYzQSY0rv2qBnV5OAWeOs5WBN1lbqPMp6MMNjQVVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jTOR52cE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51789C4CEED;
	Thu, 14 Aug 2025 15:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755185450;
	bh=cvTYcOO2SFOCDjwerP1KEOTUieXi4c8bDV0Z2qhr2s4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jTOR52cELhkyDE+NrphwZYdLWf4cfJAMhSsdNkjjGXFVbnh3vqBpW91wVEGUkEYtJ
	 JRwUwCFEaf4x+OyYrdf0R9Ua1H5/GNFbwLX4h6vwnDEiIka6iFvJzrjB6meClf4B8X
	 WkXh/Yp7lXXwYtX1kgmHJ7Jz6UEKqS9UWLtHT8Mc=
Date: Thu, 14 Aug 2025 17:30:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	qemu-devel@nongnu.org,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>,
	LTP List <ltp@lists.linux.it>, chrubis <chrubis@suse.cz>,
	Petr Vorel <pvorel@suse.cz>, Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org, Joseph Qi <jiangqi903@gmail.com>,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	Zhang Yi <yi.zhang@huawei.com>, Theodore Ts'o <tytso@mit.edu>,
	Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 6.16 000/627] 6.16.1-rc1 review
Message-ID: <2025081436-upchuck-shush-adba@gregkh>
References: <20250812173419.303046420@linuxfoundation.org>
 <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
 <2025081300-frown-sketch-f5bd@gregkh>
 <CA+G9fYuEb7Y__CVHxZ8VkWGqfA4imWzXsBhPdn05GhOandg0Yw@mail.gmail.com>
 <2025081311-purifier-reviver-aeb2@gregkh>
 <42aace87-1b89-4b17-96f1-3efbabc4acf3@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42aace87-1b89-4b17-96f1-3efbabc4acf3@huaweicloud.com>

On Thu, Aug 14, 2025 at 09:27:49AM +0800, Zhang Yi wrote:
> On 2025/8/13 22:53, Greg Kroah-Hartman wrote:
> > On Wed, Aug 13, 2025 at 08:01:51PM +0530, Naresh Kamboju wrote:
> >> Hi Greg,
> >>
> >>>> 2)
> >>>>
> >>>> The following list of LTP syscalls failure noticed on qemu-arm64 with
> >>>> stable-rc 6.16.1-rc1 with CONFIG_ARM64_64K_PAGES=y build configuration.
> >>>>
> >>>> Most failures report ENOSPC (28) or mkswap errors, which may be related
> >>>> to disk space handling in the 64K page configuration on qemu-arm64.
> >>>>
> >>>> The issue is reproducible on multiple runs.
> >>>>
> >>>> * qemu-arm64, ltp-syscalls - 64K page size test failures list,
> >>>>
> >>>>   - fallocate04
> >>>>   - fallocate05
> >>>>   - fdatasync03
> >>>>   - fsync01
> >>>>   - fsync04
> >>>>   - ioctl_fiemap01
> >>>>   - swapoff01
> >>>>   - swapoff02
> >>>>   - swapon01
> >>>>   - swapon02
> >>>>   - swapon03
> >>>>   - sync01
> >>>>   - sync_file_range02
> >>>>   - syncfs01
> >>>>
> >>>> Reproducibility:
> >>>>  - 64K config above listed test fails
> >>>>  - 4K config above listed test pass.
> >>>>
> >>>> Regression Analysis:
> >>>> - New regression? yes
> >>>
> >>> Regression from 6.16?  Or just from 6.15.y?
> >>
> >> Based on available data, the issue is not present in v6.16 or v6.15.
> >>
> >> Anders, bisected this regression and found,
> >>
> >>   ext4: correct the reserved credits for extent conversion
> >>     [ Upstream commit 95ad8ee45cdbc321c135a2db895d48b374ef0f87 ]
> >>
> >> Report lore link,
> >>
> >> https://lore.kernel.org/stable/CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com/
> > 
> > Great, and that's also affecting 6.17-rc1 so we are "bug compatible"?
> > :)
> > 
> 
> Hi,
> 
> This issue has already fixed in 6.17-rc1 through this series:
> 
> https://lore.kernel.org/linux-ext4/20250707140814.542883-1-yi.zhang@huaweicloud.com/
> 
> 
> To fix this issue in 6.16, it's necessary to backport the whole series
> instead of just pick 5137d6c8906b ("ext4: fix insufficient credits
> calculation in ext4_meta_trans_blocks()") and 95ad8ee45cdb {"ext4: correct
> the reserved credits for extent conversion").  Otherwise, this will make
> the problem more likely to occur.

Thanks, I'll just postpone this one for now.

greg k-h

