Return-Path: <linux-fsdevel+bounces-57693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159CBB249CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 14:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32B73B13F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 12:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08012E5B0F;
	Wed, 13 Aug 2025 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G/lvod9q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D700D1547D2;
	Wed, 13 Aug 2025 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755089453; cv=none; b=CknsgSvJgl1Zh59hOpLfYfRAuYQ8Yj5W7+EKf2yXWOrz5e8imxfb6zSuccQ2tQBFvqBeTWmzReWKClmzTMSky6SgpA8IJGIvWbWtVyCTiw6oyekgq/6qiVJvCyugJGYteJ1vkIQXGyjVVRUtG8PqUu6xsIR19d+zD2ab/ou76/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755089453; c=relaxed/simple;
	bh=1sFEp7tfTZsLqsEbQ6yN/DfqybrcqHWTfRSt7pluUnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBMMPo6Dgs6KU48wanigWveFyU0ke3mw2WIRfJXi/Mywb36at153DHjZEIkG+6kzcYj2lurLyu3X1P3PtOxZeqOeqEzjvpyLN71JdgAnnF82zg+d0ECUUsVAapadPWOLvhYbau4YaAlmXXrz5wHh12dolrQbIE4C3mtxv7z6epw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G/lvod9q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B4EC4CEF6;
	Wed, 13 Aug 2025 12:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755089452;
	bh=1sFEp7tfTZsLqsEbQ6yN/DfqybrcqHWTfRSt7pluUnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G/lvod9qaNFe8MgiqMNtSrnZl6ICr4ny7PsTyyOhzVZeCv/MZyhfDLlgNxCv37Z7r
	 GYSIKBF/pteVt/vjuJB94/MdSefsCgRAQaRxWEIW2/awDVXuZZFSfXB+5rMnnQexLI
	 cxOX0SSrpyCPB+x6DMMiVzgiv5VergRxG6Bl2MhE=
Date: Wed, 13 Aug 2025 14:50:49 +0200
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
	linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 6.16 000/627] 6.16.1-rc1 review
Message-ID: <2025081300-frown-sketch-f5bd@gregkh>
References: <20250812173419.303046420@linuxfoundation.org>
 <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>

On Wed, Aug 13, 2025 at 05:46:26PM +0530, Naresh Kamboju wrote:
> Long story:
> 1)
> The perf gcc-13 build failed on x86_64 and i386.
> 
> Build regression: qemu-arm64 ARM64_64K_PAGES ltp syscalls swap fsync
> fallocate failed.
> 
> > Ian Rogers <irogers@google.com>
> >     perf topdown: Use attribute to see an event is a topdown metic or slots
> 
> Build error:
> 
> arch/x86/tests/topdown.c: In function 'event_cb':
> arch/x86/tests/topdown.c:53:25: error: implicit declaration of
> function 'pr_debug' [-Werror=implicit-function-declaration]
>    53 |                         pr_debug("Broken topdown information
> for '%s'\n", evsel__name(evsel));
>       |                         ^~~~~~~~
> cc1: all warnings being treated as errors

Already fixed.

> 2)
> 
> The following list of LTP syscalls failure noticed on qemu-arm64 with
> stable-rc 6.16.1-rc1 with CONFIG_ARM64_64K_PAGES=y build configuration.
> 
> Most failures report ENOSPC (28) or mkswap errors, which may be related
> to disk space handling in the 64K page configuration on qemu-arm64.
> 
> The issue is reproducible on multiple runs.
> 
> * qemu-arm64, ltp-syscalls - 64K page size test failures list,
> 
>   - fallocate04
>   - fallocate05
>   - fdatasync03
>   - fsync01
>   - fsync04
>   - ioctl_fiemap01
>   - swapoff01
>   - swapoff02
>   - swapon01
>   - swapon02
>   - swapon03
>   - sync01
>   - sync_file_range02
>   - syncfs01
> 
> Reproducibility:
>  - 64K config above listed test fails
>  - 4K config above listed test pass.
> 
> Regression Analysis:
> - New regression? yes

Regression from 6.16?  Or just from 6.15.y?

> 3)
> 
> Test regression: stable-rc 6.16.1-rc1 WARNING fs jbd2 transaction.c
> start_this_handle
> 
> Kernel warning noticed on this stable-rc 6.16.1-rc1 this regression was
> reported last month on the Linux next,
> 
> - https://lore.kernel.org/all/CA+G9fYsyYQ3ZL4xaSg1-Tt5Evto7Zd+hgNWZEa9cQLbahA1+xg@mail.gmail.com/

Ok, no real regression here if this was already in 6.16.

Doesn't look like it got fixed in 6.17-rc1 either :(

thanks,

greg k-h

